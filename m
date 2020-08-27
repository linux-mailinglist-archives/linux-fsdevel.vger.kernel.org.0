Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA467254459
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 13:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgH0LdK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 07:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728700AbgH0LcR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:32:17 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2729AC061232;
        Thu, 27 Aug 2020 04:01:18 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id m22so7018697eje.10;
        Thu, 27 Aug 2020 04:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=edStvBe16F0DYe/Tb0S52V60X6Qfj/1Yjsd3cDbffB0=;
        b=Mo7bwIXOuWz4IVnwnNBFImsBmAtzEfPNf9csfDXHRs3BannEZyzHNkl40GYOcpjZuN
         kWougdSqVmjN0MMoVvwGXxoGZ2zpFAkjMq7qyGjyBDvVwjF6f/Rp3JNdr1Hm2l0Fecs/
         Hu8GnrIsG16Z5YQbSGOJSxnMNGO7RX0teGbiQtV7SxXhEZU8PidP8+6YfEgeRQaBx0SX
         DXRkeTllDgvBP5tBNpoH/AAqueJ/KDSMz2rHIxSrOKnDrztt3mPYADkcm5Ji2D7f4FfU
         45wRQewIk5tb9Ply6xfBWnqFh17xs23VU/Rj2Qmg9RQOSQ6FTJfH3d7iO/HM6AC6n/zL
         98pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=edStvBe16F0DYe/Tb0S52V60X6Qfj/1Yjsd3cDbffB0=;
        b=Z2Mzw46ctyCwYvUTI9IifXIKzacAZQzYAAcvh0tuniLQVWM7C9SKyBaf4AmssfruEe
         ykJZfSrhLdLXJ08SqU7IaAn8/QVqMzSZUMwsEZo73vmjw1v36lbP5yarXSdu8ONNCKJb
         yeb/JWFjEO76eHuNRWfR4jc53L82+5G96pTgorGTam6ChXwdlFnTdH6bwA86MNf6Madv
         SgzryH9y4zAWhPeOEjC4vyihqATcGrpWITVhgCm5wwdj5URm1h2upjw28jPJrhN8seZs
         AVWzrK270fjjJLhklpK8iSgMgcQtkKrgwAW6GEN7iWd40WEJj8Ha5fhAOWI/4DTt+qo6
         SciQ==
X-Gm-Message-State: AOAM531AaG+upNfRfvv3XtkItmQAQkGnKni+Kob4fEKrWa2fjBEe7R/p
        1jBKvRwrygtrcAH2g2VjVIWTSF0tGdg=
X-Google-Smtp-Source: ABdhPJzvLj8h3de0+iIa7UgFE76P78v3iCDf3ADkSIcXBdpvWS6EsYsqBs2M9GhNlo8KQ+NeWy5xKw==
X-Received: by 2002:a17:906:d050:: with SMTP id bo16mr21613988ejb.367.1598526076845;
        Thu, 27 Aug 2020 04:01:16 -0700 (PDT)
Received: from ?IPv6:2001:a61:253c:4c01:2cf1:7133:9da2:66a9? ([2001:a61:253c:4c01:2cf1:7133:9da2:66a9])
        by smtp.gmail.com with ESMTPSA id j92sm1250562edc.82.2020.08.27.04.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 04:01:15 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Add manpage for open_tree(2)
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
References: <159827188271.306468.16962617119460123110.stgit@warthog.procyon.org.uk>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <402ceb27-0f63-e7f0-c58d-de0fe4c86f56@gmail.com>
Date:   Thu, 27 Aug 2020 13:01:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159827188271.306468.16962617119460123110.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello David,

Can I ask that you please reply to each of my mails, rather than 
just sending out a new patch series (which of course I would also
like  you to do). Some things that I mentioned in the last mails
got lost, and I end up having to repeat them.

So, even where I say "please change this", could you please reply with
"done", or a reason why you declined the suggested change, is useful.
But in any case, a few words in reply to explain the other changes
that you make would be helpful.

Also, some of my questions now will get a little more complex, and as
well as you updating the pages, I think a little discussion may be
required in some cases.

On 8/24/20 2:24 PM, David Howells wrote:
> Add a manual page to document the open_tree() system call.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  man2/open_tree.2 |  249 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 249 insertions(+)
>  create mode 100644 man2/open_tree.2
> 
> diff --git a/man2/open_tree.2 b/man2/open_tree.2
> new file mode 100644
> index 000000000..d480bd82f
> --- /dev/null
> +++ b/man2/open_tree.2
> @@ -0,0 +1,249 @@
> +'\" t
> +.\" Copyright (c) 2020 David Howells <dhowells@redhat.com>
> +.\"
> +.\" %%%LICENSE_START(VERBATIM)
> +.\" Permission is granted to make and distribute verbatim copies of this
> +.\" manual provided the copyright notice and this permission notice are
> +.\" preserved on all copies.
> +.\"
> +.\" Permission is granted to copy and distribute modified versions of this
> +.\" manual under the conditions for verbatim copying, provided that the
> +.\" entire resulting derived work is distributed under the terms of a
> +.\" permission notice identical to this one.
> +.\"
> +.\" Since the Linux kernel and libraries are constantly changing, this
> +.\" manual page may be incorrect or out-of-date.  The author(s) assume no
> +.\" responsibility for errors or omissions, or for damages resulting from
> +.\" the use of the information contained herein.  The author(s) may not
> +.\" have taken the same level of care in the production of this manual,
> +.\" which is licensed free of charge, as they might when working
> +.\" professionally.
> +.\"
> +.\" Formatted or processed versions of this manual, if unaccompanied by
> +.\" the source, must acknowledge the copyright and authors of this work.
> +.\" %%%LICENSE_END
> +.\"
> +.TH OPEN_TREE 2 2020-08-24 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +open_tree \- Pick or clone mount object and attach to fd
> +.SH SYNOPSIS
> +.nf
> +.B #include <sys/types.h>
> +.B #include <sys/mount.h>
> +.B #include <unistd.h>
> +.BR "#include <fcntl.h>           " "/* Definition of AT_* constants */"
> +.PP
> +.BI "int open_tree(int " dirfd ", const char *" pathname ", unsigned int " flags );
> +.fi
> +.PP
> +.IR Note :
> +There are no glibc wrappers for these system calls.
> +.SH DESCRIPTION
> +.BR open_tree ()
> +picks the mount object specified by the pathname and attaches it to a new file

The terminology "pick" is unusual, and you never really explain what
it means.  Is there better terminology? In any case, can you add a few
words to explain what the term (('pick" or whatever alternative you
come up with) means.

> +descriptor or clones it and attaches the clone to the file descriptor.  The

Please replace "it" by a noun (phrase) -- maybe: "the mount object"?

> +resultant file descriptor is indistinguishable from one produced by
> +.BR open "(2) with " O_PATH .

What is the significance of that last piece? Can you add some words
about why the fact that the resulting FD is indistinguishable from one
produced by open() O_PATH matters or is useful?

> +.PP
> +In the case that the mount object is cloned, the clone will be "unmounted" and

You place "unmounted" in quotes. Why? Is this to signify that the the 
unmount is somehow different from other unmounts? If so, please
explain how it is different.  If not, then I think we can lose the double
quotes.

> +destroyed when the file descriptor is closed if it is not otherwise mounted
> +somewhere by calling
> +.BR move_mount (2).
> +.PP
> +To select a mount object, no permissions are required on the object referred

Here you use the word "select". Is this the same as "pick"? If yes, please
use the same term.

> +to by the path, but execute (search) permission is required on all of the

s/the path/.I pathname/ ?

(Where pathname == "the pathname argument)

> +directories in
> +.I pathname
> +that lead to the object.
> +.PP
> +Appropriate privilege (Linux: the

s/Linux: //
(This is a Linux specific system call...)

> +.B CAP_SYS_ADMIN
> +capability) is required to clone mount objects.
> +.PP
> +.BR open_tree ()
> +uses
> +.IR pathname ", " dirfd " and " flags
> +to locate the target object in one of a variety of ways:
> +.TP
> +[*] By absolute path.
> +.I pathname
> +points to an absolute path and
> +.I dirfd
> +is ignored.  The object is looked up by name, starting from the root of the
> +filesystem as seen by the calling process.
> +.TP
> +[*] By cwd-relative path.
> +.I pathname
> +points to a relative path and
> +.IR dirfd " is " AT_FDCWD .
> +The object is looked up by name, starting from the current working directory.
> +.TP
> +[*] By dir-relative path.
> +.I pathname
> +points to relative path and
> +.I dirfd
> +indicates a file descriptor pointing to a directory.  The object is looked up
> +by name, starting from the directory specified by
> +.IR dirfd .
> +.TP
> +[*] By file descriptor.
> +.I pathname
> +is "",
> +.I dirfd
> +indicates a file descriptor and
> +.B AT_EMPTY_PATH
> +is set in
> +.IR flags .
> +The mount attached to the file descriptor is queried directly.  The file
> +descriptor may point to any type of file, not just a directory.

I want to check here. Is it really *any* type of file? Can it be a UNIX 
domain socket or a char/block device or a FIFO?

> +.PP
> +.I flags
> +can be used to control the operation of the function and to influence a
> +path-based lookup.  A value for
> +.I flags
> +is constructed by OR'ing together zero or more of the following constants:
> +.TP
> +.BR AT_EMPTY_PATH
> +.\" commit 65cfc6722361570bfe255698d9cd4dccaf47570d
> +If
> +.I pathname
> +is an empty string, operate on the file referred to by
> +.IR dirfd
> +(which may have been obtained from
> +.BR open "(2) with"
> +.BR O_PATH ", from " fsmount (2)
> +or from another

s/another/a previous call to/

> +.BR open_tree ()).
> +If
> +.I dirfd
> +is
> +.BR AT_FDCWD ,
> +the call operates on the current working directory.
> +In this case,
> +.I dirfd
> +can refer to any type of file, not just a directory.
> +This flag is Linux-specific; define
> +.B _GNU_SOURCE
> +.\" Before glibc 2.16, defining _ATFILE_SOURCE sufficed
> +to obtain its definition.
> +.TP
> +.BR AT_NO_AUTOMOUNT
> +Don't automount the final ("basename") component of
> +.I pathname
> +if it is a directory that is an automount point.  This flag allows the
> +automount point itself to be picked up or a mount cloned that is rooted on the
> +automount point.  The
> +.B AT_NO_AUTOMOUNT
> +flag has no effect if the mount point has already been mounted over.
> +This flag is Linux-specific; define
> +.B _GNU_SOURCE
> +.\" Before glibc 2.16, defining _ATFILE_SOURCE sufficed
> +to obtain its definition.
> +.TP
> +.B AT_SYMLINK_NOFOLLOW
> +If
> +.I pathname
> +is a symbolic link, do not dereference it: instead pick up or clone a mount
> +rooted on the link itself.
> +.TP
> +.B OPEN_TREE_CLOEXEC
> +Set the close-on-exec flag for the new file descriptor.  This will cause the
> +file descriptor to be closed automatically when a process exec's.
> +.TP
> +.B OPEN_TREE_CLONE
> +Rather than directly attaching the selected object to the file descriptor,
> +clone the object, set the root of the new mount object to that point and

Could you expand on "that point" a little. It's not quite clear to me what
you mean there.

> +attach the clone to the file descriptor.
> +.TP
> +.B AT_RECURSIVE
> +This is only permitted in conjunction with OPEN_TREE_CLONE.  It causes the
> +entire mount subtree rooted at the selected spot to be cloned rather than just

Is there a better word than "spot"?

> +that one mount object.
> +.SH RETURN VALUE
> +On success, the new file descriptor is returned.  On error, \-1 is returned,
> +and
> +.I errno
> +is set appropriately.
> +.SH ERRORS
> +.TP
> +.B EACCES
> +Search permission is denied for one of the directories
> +in the path prefix of
> +.IR pathname .
> +(See also
> +.BR path_resolution (7).)
> +.TP
> +.B EBADF
> +.I dirfd
> +is not a valid open file descriptor.
> +.TP
> +.B EFAULT
> +.I pathname
> +is NULL or
> +.IR pathname
> +point to a location outside the process's accessible address space.
> +.TP
> +.B EINVAL
> +Reserved flag specified in
> +.IR flags .
> +.TP
> +.B ELOOP
> +Too many symbolic links encountered while traversing the pathname.
> +.TP
> +.B ENAMETOOLONG
> +.I pathname
> +is too long.
> +.TP
> +.B ENOENT
> +A component of
> +.I pathname
> +does not exist, or
> +.I pathname
> +is an empty string and
> +.B AT_EMPTY_PATH
> +was not specified in
> +.IR flags .
> +.TP
> +.B ENOMEM
> +Out of memory (i.e., kernel memory).
> +.TP
> +.B ENOTDIR
> +A component of the path prefix of
> +.I pathname
> +is not a directory or
> +.I pathname
> +is relative and
> +.I dirfd
> +is a file descriptor referring to a file other than a directory.
> +.SH VERSIONS
> +.BR open_tree ()
> +was added to Linux in kernel 5.2.
> +.SH CONFORMING TO
> +.BR open_tree ()
> +is Linux-specific.
> +.SH NOTES
> +Glibc does not (yet) provide a wrapper for the
> +.BR open_tree ()
> +system call; call it using
> +.BR syscall (2).

What's the current status with respect to glibc support? Is it coming/is
someone working on this?

> +.SH EXAMPLE

s/EXAMPLE/EXAMPLES/
(That's the standard section header name these days.)

> +The
> +.BR open_tree ()
> +function can be used like the following:

The following example does a recursive bind mount, right?
Can you please add some words to say that explicitly.

> +.PP
> +.RS
> +.nf
> +fd1 = open_tree(AT_FDCWD, "/mnt", 0);
> +fd2 = open_tree(fd1, "",
> +                AT_EMPTY_PATH | OPEN_TREE_CLONE | AT_RECURSIVE);
> +move_mount(fd2, "", AT_FDCWD, "/mnt2", MOVE_MOUNT_F_EMPTY_PATH);
> +.fi
> +.RE
> +.PP
> +This would attach the path point for "/mnt" to fd1, then it would copy the

What is a "path point"? This is not standard terminology. Can you
replace this with something better?

> +entire subtree at the point referred to by fd1 and attach that to fd2; lastly,
> +it would attach the clone to "/mnt2".
> +.SH SEE ALSO
> +.BR fsmount (2),
> +.BR move_mount (2),
> +.BR open (2)

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
