Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3472426D54C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 09:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgIQHxe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 03:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgIQHwt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:52:49 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541ACC06174A;
        Thu, 17 Sep 2020 00:52:49 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id u25so1077228otq.6;
        Thu, 17 Sep 2020 00:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=0UlSbYsUidVoXTUQAkak7JZEzdY6B0MPenGz0FDLL1U=;
        b=qeJ5ysKlzW9h+KRm1d5MbiITjK2hIwj8ex2iSUtElJlWzifmaqtUF6q6mmY2G4PLWs
         8651a0HIet1dzA9HLYYBe2KKIukmy0X0q5k2uZkzrrYsLCFSvj6mKNBbRSo7VmmbYl/W
         eI8IreP2DGKBwAYw4M6CBfA0LoKFjYe6fXFbzlmyoWPa+PGnA0hdQ3c9mePpY9S4fFeE
         pNF7Tcv+5N2Xj/nDf1KkRfNMQC7kxOOFLMY6fadUtUjcHtXOw6vrAYpoRf0u1BYwxap8
         uY4JIaUU14wPkxvClAv5r9hKndjC+ZAjY+9QWHkRzjg8lUO/ao+ni+LaPu3Vs8C3CO9v
         JzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=0UlSbYsUidVoXTUQAkak7JZEzdY6B0MPenGz0FDLL1U=;
        b=NufeiDx92yC/UZs2iVpY95S07fVyBtzvCzT3Xl7HU3blugkBNt1q+YAYxbKvkBqbXt
         lXrMJm6EiMRKZ1X43CBkTSusf9fB6unJLS0DQqf0b9DxqoK2KMZlmzHheTygEGLWbWSy
         D/wrjj83fVuMD0EJ3dQBhq6H2fPkVHZi403kfMOis9qxvU5qVFHV50ekwyhjQBAxEvRy
         oA+nMVLzHcjrFfd6CH//RrIu5EZVMMsyaFNjQZ3fIoCmW0wKsy38tOWv5s2qGqLh733i
         5vu8ydBfwHpl8cZUsfWUXkaIiHakNz8BnDjiNOIe141Rn3zbWJDprMbEHJTvVurvVRWt
         DYqQ==
X-Gm-Message-State: AOAM531ZrtMTTttx24iPeUK/GotajSucr5L2gmrKVxxulNP7XuqWEtH6
        wEX+8OTQ1ZCKMX/nV1IZrqCQzjlK1XFhVl+NPss=
X-Google-Smtp-Source: ABdhPJxZrRhAVMSfdToNzvs1EUzqJy9F8kC6LvGGb6+LhaVMLDNTsDkWUatVnILbdC/qT5UYI4Uu2X9pSTwqQkSalQo=
X-Received: by 2002:a9d:68d3:: with SMTP id i19mr16754967oto.308.1600329168527;
 Thu, 17 Sep 2020 00:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200602204219.186620-1-christian.brauner@ubuntu.com>
 <20200602204219.186620-2-christian.brauner@ubuntu.com> <CAKgNAkiHYer_d+AvRUDPgS3WfCQXKrrCuXFV1g9t2zim7QBpXw@mail.gmail.com>
In-Reply-To: <CAKgNAkiHYer_d+AvRUDPgS3WfCQXKrrCuXFV1g9t2zim7QBpXw@mail.gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Thu, 17 Sep 2020 09:52:37 +0200
Message-ID: <CAKgNAkgrBsy1H4E1a-8z9CWan6C3e7mai42ufG_GHqB2y7n+Xw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] open: add close_range()
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Kyle Evans <self@kyle-evans.net>,
        Victor Stinner <victor.stinner@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Christian,

Could we please have a manual page for the close_range(2) syscall
that's about to land in 5.9?

Thanks,

Michael

On Wed, 3 Jun 2020 at 12:24, Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hi Christian,
>
> Could we have a manual page for this API (best before it's merged)?
>
> Thanks,
>
> Michael
>
> On Tue, 2 Jun 2020 at 22:44, Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > This adds the close_range() syscall. It allows to efficiently close a range
> > of file descriptors up to all file descriptors of a calling task.
> >
> > I've also coordinated with some FreeBSD developers who got in touch with
> > me (Cced below). FreeBSD intends to add the same syscall once we merged it.
> > Quite a bunch of projects in userspace are waiting on this syscall
> > including Python and systemd.
> >
> > The syscall came up in a recent discussion around the new mount API and
> > making new file descriptor types cloexec by default. During this
> > discussion, Al suggested the close_range() syscall (cf. [1]). Note, a
> > syscall in this manner has been requested by various people over time.
> >
> > First, it helps to close all file descriptors of an exec()ing task. This
> > can be done safely via (quoting Al's example from [1] verbatim):
> >
> >         /* that exec is sensitive */
> >         unshare(CLONE_FILES);
> >         /* we don't want anything past stderr here */
> >         close_range(3, ~0U);
> >         execve(....);
> >
> > The code snippet above is one way of working around the problem that file
> > descriptors are not cloexec by default. This is aggravated by the fact that
> > we can't just switch them over without massively regressing userspace. For
> > a whole class of programs having an in-kernel method of closing all file
> > descriptors is very helpful (e.g. demons, service managers, programming
> > language standard libraries, container managers etc.).
> > (Please note, unshare(CLONE_FILES) should only be needed if the calling
> > task is multi-threaded and shares the file descriptor table with another
> > thread in which case two threads could race with one thread allocating file
> > descriptors and the other one closing them via close_range(). For the
> > general case close_range() before the execve() is sufficient.)
> >
> > Second, it allows userspace to avoid implementing closing all file
> > descriptors by parsing through /proc/<pid>/fd/* and calling close() on each
> > file descriptor. From looking at various large(ish) userspace code bases
> > this or similar patterns are very common in:
> > - service managers (cf. [4])
> > - libcs (cf. [6])
> > - container runtimes (cf. [5])
> > - programming language runtimes/standard libraries
> >   - Python (cf. [2])
> >   - Rust (cf. [7], [8])
> > As Dmitry pointed out there's even a long-standing glibc bug about missing
> > kernel support for this task (cf. [3]).
> > In addition, the syscall will also work for tasks that do not have procfs
> > mounted and on kernels that do not have procfs support compiled in. In such
> > situations the only way to make sure that all file descriptors are closed
> > is to call close() on each file descriptor up to UINT_MAX or RLIMIT_NOFILE,
> > OPEN_MAX trickery (cf. comment [8] on Rust).
> >
> > The performance is striking. For good measure, comparing the following
> > simple close_all_fds() userspace implementation that is essentially just
> > glibc's version in [6]:
> >
> > static int close_all_fds(void)
> > {
> >         int dir_fd;
> >         DIR *dir;
> >         struct dirent *direntp;
> >
> >         dir = opendir("/proc/self/fd");
> >         if (!dir)
> >                 return -1;
> >         dir_fd = dirfd(dir);
> >         while ((direntp = readdir(dir))) {
> >                 int fd;
> >                 if (strcmp(direntp->d_name, ".") == 0)
> >                         continue;
> >                 if (strcmp(direntp->d_name, "..") == 0)
> >                         continue;
> >                 fd = atoi(direntp->d_name);
> >                 if (fd == dir_fd || fd == 0 || fd == 1 || fd == 2)
> >                         continue;
> >                 close(fd);
> >         }
> >         closedir(dir);
> >         return 0;
> > }
> >
> > to close_range() yields:
> > 1. closing 4 open files:
> >    - close_all_fds(): ~280 us
> >    - close_range():    ~24 us
> >
> > 2. closing 1000 open files:
> >    - close_all_fds(): ~5000 us
> >    - close_range():   ~800 us
> >
> > close_range() is designed to allow for some flexibility. Specifically, it
> > does not simply always close all open file descriptors of a task. Instead,
> > callers can specify an upper bound.
> > This is e.g. useful for scenarios where specific file descriptors are
> > created with well-known numbers that are supposed to be excluded from
> > getting closed.
> > For extra paranoia close_range() comes with a flags argument. This can e.g.
> > be used to implement extension. Once can imagine userspace wanting to stop
> > at the first error instead of ignoring errors under certain circumstances.
> > There might be other valid ideas in the future. In any case, a flag
> > argument doesn't hurt and keeps us on the safe side.
> >
> > From an implementation side this is kept rather dumb. It saw some input
> > from David and Jann but all nonsense is obviously my own!
> > - Errors to close file descriptors are currently ignored. (Could be changed
> >   by setting a flag in the future if needed.)
> > - __close_range() is a rather simplistic wrapper around __close_fd().
> >   My reasoning behind this is based on the nature of how __close_fd() needs
> >   to release an fd. But maybe I misunderstood specifics:
> >   We take the files_lock and rcu-dereference the fdtable of the calling
> >   task, we find the entry in the fdtable, get the file and need to release
> >   files_lock before calling filp_close().
> >   In the meantime the fdtable might have been altered so we can't just
> >   retake the spinlock and keep the old rcu-reference of the fdtable
> >   around. Instead we need to grab a fresh reference to the fdtable.
> >   If my reasoning is correct then there's really no point in fancyfying
> >   __close_range(): We just need to rcu-dereference the fdtable of the
> >   calling task once to cap the max_fd value correctly and then go on
> >   calling __close_fd() in a loop.
> >
> > /* References */
> > [1]: https://lore.kernel.org/lkml/20190516165021.GD17978@ZenIV.linux.org.uk/
> > [2]: https://github.com/python/cpython/blob/9e4f2f3a6b8ee995c365e86d976937c141d867f8/Modules/_posixsubprocess.c#L220
> > [3]: https://sourceware.org/bugzilla/show_bug.cgi?id=10353#c7
> > [4]: https://github.com/systemd/systemd/blob/5238e9575906297608ff802a27e2ff9effa3b338/src/basic/fd-util.c#L217
> > [5]: https://github.com/lxc/lxc/blob/ddf4b77e11a4d08f09b7b9cd13e593f8c047edc5/src/lxc/start.c#L236
> > [6]: https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/grantpt.c;h=2030e07fa6e652aac32c775b8c6e005844c3c4eb;hb=HEAD#l17
> >      Note that this is an internal implementation that is not exported.
> >      Currently, libc seems to not provide an exported version of this
> >      because of missing kernel support to do this.
> > [7]: https://github.com/rust-lang/rust/issues/12148
> > [8]: https://github.com/rust-lang/rust/blob/5f47c0613ed4eb46fca3633c1297364c09e5e451/src/libstd/sys/unix/process2.rs#L303-L308
> >      Rust's solution is slightly different but is equally unperformant.
> >      Rust calls getdtablesize() which is a glibc library function that
> >      simply returns the current RLIMIT_NOFILE or OPEN_MAX values. Rust then
> >      goes on to call close() on each fd. That's obviously overkill for most
> >      tasks. Rarely, tasks - especially non-demons - hit RLIMIT_NOFILE or
> >      OPEN_MAX.
> >      Let's be nice and assume an unprivileged user with RLIMIT_NOFILE set
> >      to 1024. Even in this case, there's a very high chance that in the
> >      common case Rust is calling the close() syscall 1021 times pointlessly
> >      if the task just has 0, 1, and 2 open.
> >
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Kyle Evans <self@kyle-evans.net>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Dmitry V. Levin <ldv@altlinux.org>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Florian Weimer <fweimer@redhat.com>
> > Cc: linux-api@vger.kernel.org
> > ---
> > /* v2 */
> > - Linus Torvalds <torvalds@linux-foundation.org>:
> >   - add cond_resched() to yield cpu when closing a lot of file descriptors
> > - Al Viro <viro@zeniv.linux.org.uk>:
> >   - add cond_resched() to yield cpu when closing a lot of file descriptors
> >
> > /* v3 */
> > unchanged
> >
> > /* v4 */
> > - Oleg Nesterov <oleg@redhat.com>:
> >   - fix braino: s/max()/min()/
> >
> > /* v5 */
> > unchanged
> > ---
> >  fs/file.c                | 62 ++++++++++++++++++++++++++++++++++------
> >  fs/open.c                | 20 +++++++++++++
> >  include/linux/fdtable.h  |  2 ++
> >  include/linux/syscalls.h |  2 ++
> >  4 files changed, 78 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/file.c b/fs/file.c
> > index abb8b7081d7a..e260bfe687d1 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/syscalls.h>
> >  #include <linux/export.h>
> >  #include <linux/fs.h>
> > +#include <linux/kernel.h>
> >  #include <linux/mm.h>
> >  #include <linux/sched/signal.h>
> >  #include <linux/slab.h>
> > @@ -620,12 +621,9 @@ void fd_install(unsigned int fd, struct file *file)
> >
> >  EXPORT_SYMBOL(fd_install);
> >
> > -/*
> > - * The same warnings as for __alloc_fd()/__fd_install() apply here...
> > - */
> > -int __close_fd(struct files_struct *files, unsigned fd)
> > +static struct file *pick_file(struct files_struct *files, unsigned fd)
> >  {
> > -       struct file *file;
> > +       struct file *file = NULL;
> >         struct fdtable *fdt;
> >
> >         spin_lock(&files->file_lock);
> > @@ -637,15 +635,63 @@ int __close_fd(struct files_struct *files, unsigned fd)
> >                 goto out_unlock;
> >         rcu_assign_pointer(fdt->fd[fd], NULL);
> >         __put_unused_fd(files, fd);
> > -       spin_unlock(&files->file_lock);
> > -       return filp_close(file, files);
> >
> >  out_unlock:
> >         spin_unlock(&files->file_lock);
> > -       return -EBADF;
> > +       return file;
> > +}
> > +
> > +/*
> > + * The same warnings as for __alloc_fd()/__fd_install() apply here...
> > + */
> > +int __close_fd(struct files_struct *files, unsigned fd)
> > +{
> > +       struct file *file;
> > +
> > +       file = pick_file(files, fd);
> > +       if (!file)
> > +               return -EBADF;
> > +
> > +       return filp_close(file, files);
> >  }
> >  EXPORT_SYMBOL(__close_fd); /* for ksys_close() */
> >
> > +/**
> > + * __close_range() - Close all file descriptors in a given range.
> > + *
> > + * @fd:     starting file descriptor to close
> > + * @max_fd: last file descriptor to close
> > + *
> > + * This closes a range of file descriptors. All file descriptors
> > + * from @fd up to and including @max_fd are closed.
> > + */
> > +int __close_range(struct files_struct *files, unsigned fd, unsigned max_fd)
> > +{
> > +       unsigned int cur_max;
> > +
> > +       if (fd > max_fd)
> > +               return -EINVAL;
> > +
> > +       rcu_read_lock();
> > +       cur_max = files_fdtable(files)->max_fds;
> > +       rcu_read_unlock();
> > +
> > +       /* cap to last valid index into fdtable */
> > +       max_fd = min(max_fd, (cur_max - 1));
> > +       while (fd <= max_fd) {
> > +               struct file *file;
> > +
> > +               file = pick_file(files, fd++);
> > +               if (!file)
> > +                       continue;
> > +
> > +               filp_close(file, files);
> > +               cond_resched();
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  /*
> >   * variant of __close_fd that gets a ref on the file for later fput.
> >   * The caller must ensure that filp_close() called on the file, and then
> > diff --git a/fs/open.c b/fs/open.c
> > index 719b320ede52..87e076e9e127 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -1279,6 +1279,26 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
> >         return retval;
> >  }
> >
> > +/**
> > + * close_range() - Close all file descriptors in a given range.
> > + *
> > + * @fd:     starting file descriptor to close
> > + * @max_fd: last file descriptor to close
> > + * @flags:  reserved for future extensions
> > + *
> > + * This closes a range of file descriptors. All file descriptors
> > + * from @fd up to and including @max_fd are closed.
> > + * Currently, errors to close a given file descriptor are ignored.
> > + */
> > +SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
> > +               unsigned int, flags)
> > +{
> > +       if (flags)
> > +               return -EINVAL;
> > +
> > +       return __close_range(current->files, fd, max_fd);
> > +}
> > +
> >  /*
> >   * This routine simulates a hangup on the tty, to arrange that users
> >   * are given clean terminals at login time.
> > diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
> > index f07c55ea0c22..fcd07181a365 100644
> > --- a/include/linux/fdtable.h
> > +++ b/include/linux/fdtable.h
> > @@ -121,6 +121,8 @@ extern void __fd_install(struct files_struct *files,
> >                       unsigned int fd, struct file *file);
> >  extern int __close_fd(struct files_struct *files,
> >                       unsigned int fd);
> > +extern int __close_range(struct files_struct *files, unsigned int fd,
> > +                        unsigned int max_fd);
> >  extern int __close_fd_get_file(unsigned int fd, struct file **res);
> >
> >  extern struct kmem_cache *files_cachep;
> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index 1815065d52f3..18fea399329b 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -442,6 +442,8 @@ asmlinkage long sys_openat(int dfd, const char __user *filename, int flags,
> >  asmlinkage long sys_openat2(int dfd, const char __user *filename,
> >                             struct open_how *how, size_t size);
> >  asmlinkage long sys_close(unsigned int fd);
> > +asmlinkage long sys_close_range(unsigned int fd, unsigned int max_fd,
> > +                               unsigned int flags);
> >  asmlinkage long sys_vhangup(void);
> >
> >  /* fs/pipe.c */
> > --
> > 2.26.2
> >
>
>
> --
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
