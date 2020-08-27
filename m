Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C9525447E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 13:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgH0LrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 07:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbgH0Lqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:46:36 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50863C06123B;
        Thu, 27 Aug 2020 04:07:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id e23so6314675ejb.4;
        Thu, 27 Aug 2020 04:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zU4FrI+Vt0q4ZIfI3neU7juoeszoQlRoZHrRORmmAiY=;
        b=bcFGAOIY0PA9yEz5optZo1DSd/8VixxnGGte+kgKoaQ7M5kTYw1we/PXCzUSTfhNzD
         GLT7ALEjw0uyiHXWOaYkBBJU49xaCtWvzYkpC+XXFmSoS+7VPka3z5YHfGQjTvPe9bf8
         kkBxfCtqngr7N3SZnbT62fG5e1/4T2Xe2z4ceEwKc86EgAxw65+vVSjseEaxEFnYPbLZ
         VMm894viweqrPSZPrCGqCdDHWpqa8A0wBbvmQomiTI4hdwBX5WdL7zOlD0WkLgyGqrKu
         e53EnhA+83GyV8QV9nRKZWtG+LEEBUA/M8WhigMv43kG+w9LjT/tn9cSIpY2ATKJLwv0
         A34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zU4FrI+Vt0q4ZIfI3neU7juoeszoQlRoZHrRORmmAiY=;
        b=DLeudYSvY9fBMw9Q4nF6/FW21tBPTPnOJUb2BH1UffLcWIXJdEmtk0e5qSpIq54Ls4
         jC/3cy6+P8RQbBl+XfH1xwRz2rGxZKawv07AdT+ghjRrUqGNLzcGrU23ff6qASVf1301
         2hf2FCAw0yHM9CREXWZ2lg2md26vhG37IWWULtcSusOYwoBUfnPfKvgyDbOPbzG8sNMu
         DhrrTCT6s7YNjCMIPSK2ZQh2PwjL0OA3FLevg8xvqEKprg6XUnEcduGjLqFZsxwnzGfN
         HSPqCXQt8WuW6sVdEUiajzv8/MV2eEzAT/NAdWTgzYpFP52iela0wyGDZt04L9P+hgNb
         KS0w==
X-Gm-Message-State: AOAM531gUso2ZOoNie6pIpvHxYkxPY9UpWqhyDo1AnR/EKxCbCt6Timb
        CstF8KRCrewuWGbAOqv7fT1naDceOkU=
X-Google-Smtp-Source: ABdhPJwT6p4KhAQ5MJW8SB7wFk8kzQQcWNVaGdSoGx1XHA1zFrepRsElrQsCU9H28chCMDFhHNxrwg==
X-Received: by 2002:a17:906:6415:: with SMTP id d21mr7967668ejm.550.1598526455654;
        Thu, 27 Aug 2020 04:07:35 -0700 (PDT)
Received: from ?IPv6:2001:a61:253c:4c01:2cf1:7133:9da2:66a9? ([2001:a61:253c:4c01:2cf1:7133:9da2:66a9])
        by smtp.gmail.com with ESMTPSA id x21sm1596064ejy.97.2020.08.27.04.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 04:07:35 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] Add manpage for fsopen(2) and fsmount(2)
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
References: <159827188271.306468.16962617119460123110.stgit@warthog.procyon.org.uk>
 <159827190508.306468.12755090833140558156.stgit@warthog.procyon.org.uk>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <335e623c-9676-4af9-4a0a-082bb7fc750f@gmail.com>
Date:   Thu, 27 Aug 2020 13:07:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159827190508.306468.12755090833140558156.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello David,

On 8/24/20 2:25 PM, David Howells wrote:
> Add a manual page to document the fsopen() and fsmount() system calls.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  man2/fsmount.2 |    1 
>  man2/fsopen.2  |  245 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 246 insertions(+)
>  create mode 100644 man2/fsmount.2
>  create mode 100644 man2/fsopen.2
> 
> diff --git a/man2/fsmount.2 b/man2/fsmount.2
> new file mode 100644
> index 000000000..2bf59fc3e
> --- /dev/null
> +++ b/man2/fsmount.2
> @@ -0,0 +1 @@
> +.so man2/fsopen.2
> diff --git a/man2/fsopen.2 b/man2/fsopen.2
> new file mode 100644
> index 000000000..1d1bba238
> --- /dev/null
> +++ b/man2/fsopen.2
> @@ -0,0 +1,245 @@
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
> +.TH FSOPEN 2 2020-08-07 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +fsopen, fsmount \- Filesystem parameterisation and mount creation
> +.SH SYNOPSIS
> +.nf
> +.B #include <sys/types.h>
> +.B #include <sys/mount.h>
> +.B #include <unistd.h>
> +.BR "#include <fcntl.h>           " "/* Definition of AT_* constants */"
> +.PP
> +.BI "int fsopen(const char *" fsname ", unsigned int " flags );
> +.PP
> +.BI "int fsmount(int " fd ", unsigned int " flags ", unsigned int " mount_attrs );
> +.fi
> +.PP
> +.IR Note :
> +There are no glibc wrappers for these system calls.
> +.SH DESCRIPTION
> +.PP
> +.BR fsopen ()
> +creates a blank filesystem configuration context within the kernel for the
> +filesystem named in the
> +.I fsname
> +parameter, puts it into creation mode and attaches it to a file descriptor,
> +which it then returns.  

In the preceding sentence, "it" is used three times, with two *different* 
referents. That's quite hard on the reader.

How about:

[[
.BR fsopen ()
creates a blank filesystem configuration context within the kernel for the
filesystem named in the
.I fsname
parameter, puts the context into creation mode and 
attaches it to a file descriptor;
.BR fsopen ()
returns the file descriptor as the function result.  
]]

> The file descriptor can be marked close-on-exec by
> +setting
> +.B FSOPEN_CLOEXEC
> +in
> +.IR flags .
> +.PP
> +After calling fsopen(), the file descriptor should be passed to the
> +.BR fsconfig (2)
> +system call, using that to specify the desired filesystem and security
> +parameters.
> +.PP
> +When the parameters are all set, the
> +.BR fsconfig ()
> +system call should then be called again with
> +.B FSCONFIG_CMD_CREATE
> +as the command argument to effect the creation.
> +.RS
> +.PP
> +.BR "[!]\ NOTE" :
> +Depending on the filesystem type and parameters, this may rather share an

Please replace "this" with a noun (phrase), since it is a little
unclear what "this" refers to.

> +existing in-kernel filesystem representation instead of creating a new one.
> +In such a case, the parameters specified may be discarded or may overwrite the
> +parameters set by a previous mount - at the filesystem's discretion.
> +.RE
> +.PP
> +The file descriptor also serves as a channel by which more comprehensive error,
> +warning and information messages may be retrieved from the kernel using
> +.BR read (2).
> +.PP
> +Once the creation command has been successfully run on a context, the context
> +will not accept further configuration.  At
> +this point,
> +.BR fsmount ()
> +should be called to create a mount object.
> +.PP
> +.BR fsmount ()
> +takes the file descriptor returned by
> +.BR fsopen ()
> +and creates a mount object for the filesystem root specified there.  The
> +attributes of the mount object are set from the
> +.I mount_attrs
> +parameter.  The attributes specify the propagation and mount restrictions to
> +be applied to accesses through this mount.

Can we please have a list of the available attributes here, with a 
description of each attribute.

> +.PP
> +The mount object is then attached to a new file descriptor that looks like one
> +created by
> +.BR open "(2) with " O_PATH " or " open_tree (2).
> +This can be passed to
> +.BR move_mount (2)
> +to attach the mount object to a mountpoint, thereby completing the process.

s/mountpoint/mount point/

In the preceding paragraph, the description is a bit unclear. (Again, 
overuse of pronouns ("this) does not help. I think it
would be better to say something like:

[[
.BR fsmount()
attaches the mount object to a new file descriptor that looks like one
created by
.BR open "(2) with " O_PATH " or " open_tree (2).
This file descriptor can be passed to
.BR move_mount (2)
to attach the mount object to a mount point, thereby completing the process.
]]

But, please also replace "the process" with a more meaningful phrase.

> +.PP
> +The file descriptor returned by fsmount() is marked close-on-exec if
> +FSMOUNT_CLOEXEC is specified in
> +.IR flags .
> +.PP
> +After fsmount() has completed, the context created by fsopen() is reset and
> +moved to reconfiguration state, allowing the new superblock to be
> +reconfigured.  See
> +.BR fspick (2)
> +for details.
> +.PP
> +To use either of these calls, the caller requires the appropriate privilege
> +(Linux: the

s/Linux: //
(this is after all a Linux-specific system call)

> +.B CAP_SYS_ADMIN
> +capability).
> +.PP
> +.SS Message Retrieval Interface
> +The context file descriptor may be queried for message strings at any time by

s/The context file descriptor/
  The context file descriptor returned by fsopen()/

> +calling
> +.BR read (2)
> +on the file descriptor.  This will return formatted messages that are prefixed
> +to indicate their class:
> +.TP
> +\fB"e <message>"\fP
> +An error message string was logged.
> +.TP
> +\fB"i <message>"\fP
> +An informational message string was logged.
> +.TP
> +\fB"w <message>"\fP
> +An warning message string was logged.
> +.PP
> +Messages are removed from the queue as they're read.

What if there are no pending error messages to retrieve? What does
read() do in that case? Please add an explanation here.

> +.SH RETURN VALUE
> +On success, both functions return a file descriptor.  On error, \-1 is
> +returned, and
> +.I errno
> +is set appropriately> +.SH ERRORS
> +The error values given below result from filesystem type independent
> +errors.
> +Each filesystem type may have its own special errors and its
> +own special behavior.
> +See the Linux kernel source code for details.
> +.TP
> +.B EBUSY
> +The context referred to by
> +.I fd
> +is not in the right state to be used by
> +.BR fsmount ().
> +.TP
> +.B EFAULT
> +One of the pointer arguments points outside the user address space.
> +.TP
> +.B EINVAL
> +.I flags
> +had an invalid flag set.
> +.TP
> +.B EINVAL
> +.I mount_attrs,
> +includes invalid
> +.BR MOUNT_ATTR_*
> +flags.
> +.TP
> +.B EMFILE
> +The system has too many open files to create more.
> +.TP
> +.B ENFILE
> +The process has too many open files to create more.
> +.TP
> +.B ENODEV
> +The filesystem
> +.I fsname
> +is not available in the kernel.
> +.TP
> +.B ENOMEM
> +The kernel could not allocate sufficient memory to complete the call.
> +.TP
> +.B EPERM
> +The caller does not have the required privileges.

Please name the required capability.

> +.SH CONFORMING TO
> +These functions are Linux-specific and should not be used in programs intended
> +to be portable.
> +.SH VERSIONS
> +.BR fsopen "(), and " fsmount ()
> +were added to Linux in kernel 5.2.
> +.SH NOTES
> +Glibc does not (yet) provide a wrapper for the
> +.BR fsopen "() or " fsmount "()"
> +system calls; call them using
> +.BR syscall (2).
> +.SH EXAMPLES
> +To illustrate the process, here's an example whereby this can be used to mount

Please replace "this" by a noun (phrase).

> +an ext4 filesystem on /dev/sdb1 onto /mnt.
> +.PP
> +.in +4n
> +.nf
> +sfd = fsopen("ext4", FSOPEN_CLOEXEC);
> +fsconfig(sfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
> +fsconfig(sfd, FSCONFIG_SET_STRING, "source", "/dev/sdb1", 0);
> +fsconfig(sfd, FSCONFIG_SET_FLAG, "noatime", NULL, 0);
> +fsconfig(sfd, FSCONFIG_SET_FLAG, "acl", NULL, 0);
> +fsconfig(sfd, FSCONFIG_SET_FLAG, "user_attr", NULL, 0);
> +fsconfig(sfd, FSCONFIG_SET_FLAG, "iversion", NULL, 0);
> +fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> +mfd = fsmount(sfd, FSMOUNT_CLOEXEC, MS_RELATIME);
> +move_mount(mfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
> +.fi
> +.in
> +.PP
> +Here, an ext4 context is created first and attached to sfd.  The context is
> +then told where its source will be, given a bunch of options and a superblock
> +record object is then created.  Then fsmount() is called to create a mount
> +object and
> +.BR move_mount (2)
> +is called to attach it to its intended mountpoint.

s/mountpoint/mount point/

> +.PP
> +And here's an example of mounting from an NFS server and setting a Smack
> +security module label on it too:

Please replace "it" with a noun (phrase).

> +.PP
> +.in +4n
> +.nf
> +sfd = fsopen("nfs", 0);
> +fsconfig(sfd, FSCONFIG_SET_STRING, "source", "example.com:/pub", 0);
> +fsconfig(sfd, FSCONFIG_SET_STRING, "nfsvers", "3", 0);
> +fsconfig(sfd, FSCONFIG_SET_STRING, "rsize", "65536", 0);
> +fsconfig(sfd, FSCONFIG_SET_STRING, "wsize", "65536", 0);
> +fsconfig(sfd, FSCONFIG_SET_STRING, "smackfsdef", "foolabel", 0);
> +fsconfig(sfd, FSCONFIG_SET_FLAG, "rdma", NULL, 0);
> +fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> +mfd = fsmount(sfd, 0, MS_NODEV);
> +move_mount(mfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
> +.fi
> +.in
> +.PP
> +.SH SEE ALSO
> +.BR mountpoint (1),
> +.BR fsconfig (2),
> +.BR fspick (2),
> +.BR move_mount (2),
> +.BR open_tree (2),
> +.BR umount (2),
> +.BR mount_namespaces (7),
> +.BR path_resolution (7),
> +.BR mount (8),
> +.BR umount (8)

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
