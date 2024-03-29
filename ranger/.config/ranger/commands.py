import os
import subprocess
import sys

from ranger.api.commands import Command
from ranger.core.loader import CommandLoader


class empty(Command):
    """:empty

    Empties the trash directory ~/.local/share/Trash
    """

    def execute(self):
        self.fm.run("gio trash --empty")


class fzf_select(Command):
    """:fzf_select

    Find a file using fzf.

    See: https://github.com/ranger/ranger/wiki/Custom-Commands
    """

    def execute(self):
        command = (
            os.getenv("FZF_DEFAULT_COMMAND")
            + f" | fzf +m --preview='{sys.path[-1]}/ranger/data/scope.sh"
            + " {} 100 100 /tmp False 2> /dev/null'"
        )
        fzf = self.fm.execute_command(
            command, universal_newlines=True, stdout=subprocess.PIPE
        )
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip("\n"))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)


class extract(Command):
    """:extract

    Extract copied files to current directory or directory
    specified in a command line.

    See: https://github.com/maximtrp/ranger-archives
    """

    def execute(self):
        cwd = self.fm.thisdir
        copied_files = cwd.get_selection()

        if not copied_files:
            return

        def refresh(_):
            cwd = self.fm.get_directory(original_path)
            cwd.load_content()

        one_file = copied_files[0]
        cwd = self.fm.thisdir
        original_path = cwd.path

        line_args = self.line.split()[1:]
        if line_args:
            extraction_dir = os.path.join(cwd.path, "".join(line_args))
            os.makedirs(extraction_dir, exist_ok=True)
            flags = ["-X", extraction_dir]
            flags += ["-e"]
        else:
            flags = ["-X", cwd.path]
            flags += ["-e"]

        self.fm.copy_buffer.clear()
        self.fm.cut_buffer = False

        if len(copied_files) == 1:
            descr = "Extracting: " + os.path.basename(one_file.path)
        else:
            descr = "Extracting files from: " + os.path.basename(one_file.dirname)
        obj = CommandLoader(
            args=["aunpack"] + flags + [f.path for f in copied_files],
            descr=descr,
            read=True,
        )

        obj.signal_bind("after", refresh)
        self.fm.loader.add(obj)


class extract_to_dirs(Command):
    """:extract_to_dirs

    Extract copied files to a subdirectories

    See: https://github.com/maximtrp/ranger-archives
    """

    def execute(self):
        cwd = self.fm.thisdir
        original_path = cwd.path
        copied_files = cwd.get_selection()

        if not copied_files:
            return

        def refresh(_):
            cwd = self.fm.get_directory(original_path)
            cwd.load_content()

        def make_flags(fn):
            fn_wo_ext = os.path.basename(os.path.splitext(fn)[0])
            flags = ["-X", fn_wo_ext]
            return flags

        one_file = copied_files[0]
        self.fm.copy_buffer.clear()
        self.fm.cut_buffer = False

        # Making description line
        if len(copied_files) == 1:
            descr = "Extracting: " + os.path.basename(one_file.path)
        else:
            descr = "Extracting files from: " + os.path.basename(one_file.dirname)

        # Extracting files
        for f in copied_files:
            obj = CommandLoader(
                args=["aunpack"] + make_flags(f.path) + [f.path], descr=descr, read=True
            )
            obj.signal_bind("after", refresh)
            self.fm.loader.add(obj)


class compress(Command):
    """:compress

    Compress marked files to current directory.

    See: https://github.com/maximtrp/ranger-archives
    """

    def execute(self):
        cwd = self.fm.thisdir
        marked_files = cwd.get_selection()

        if not marked_files:
            return

        def refresh(_):
            cwd = self.fm.get_directory(original_path)
            cwd.load_content()

        original_path = cwd.path

        # Parsing arguments line
        parts = self.line.strip().split()
        if len(parts) > 1:
            au_flags = [" ".join(parts[1:])]
        else:
            au_flags = [os.path.basename(self.fm.thisdir.path) + ".zip"]

        # Making description line
        files_num = len(marked_files)
        files_num_str = str(files_num) + " objects" if files_num > 1 else "1 object"
        descr = "Compressing " + files_num_str + " -> " + os.path.basename(au_flags[0])

        # Creating archive
        obj = CommandLoader(
            args=["apack"]
            + au_flags
            + [os.path.relpath(f.path, cwd.path) for f in marked_files],
            descr=descr,
            read=True,
        )

        obj.signal_bind("after", refresh)
        self.fm.loader.add(obj)

    def tab(self, tabnum):
        """Complete with current folder name"""
        extension = [".zip", ".tar.gz", ".rar", ".7z"]
        return [
            "compress " + os.path.basename(self.fm.thisdir.path) + ext
            for ext in extension
        ]
