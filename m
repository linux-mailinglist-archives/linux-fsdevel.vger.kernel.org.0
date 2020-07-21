Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF811227C51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 11:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgGUJ7a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 05:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgGUJ73 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:59:29 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFC1C061794;
        Tue, 21 Jul 2020 02:59:28 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z2so20618870wrp.2;
        Tue, 21 Jul 2020 02:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=auzhEAh6hyvNX7w9Z/V0K/XEQ9JPAAZZtsNVziQZRYg=;
        b=U1LNenS4lyuBWpNzmqCzKPn/+KhiqyvpnfaWVW6CifpqL8ZJ1LeQ0DGPRWAPSsOC5m
         iLqxzMBPA5hjxUrWa0EP52fVisGz2vJ7rO2pdWaRg+6MMcKa2wC4Guq1tI33tn7yI7he
         QvJbC+8uDbu1jeUYvwXkCDMw+toazCxIFb+b0w0Ywsi17DAOd7UXrv6OiU7677IURpw/
         tvheqNNmpvPiZ1eJt637wvrN/sdyVqixu7CZxF0E/e/YD/KpR7LsmwByN0YpWkL/nGAC
         BcJh6YTSoK+MLUBBkWec8/+1DDM+Td8SHuqGYV/hXadJuD5MRwuM2DjkGuNkVcPeGbhF
         RKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=auzhEAh6hyvNX7w9Z/V0K/XEQ9JPAAZZtsNVziQZRYg=;
        b=k6EzuPyTExEhjKSMLlPfio6xUI/ckFOpIFOwDeo4cQqd5lH5x6bgWgETon1bNHpMqt
         xsJTdaHsNvaXjvupM3FKe26m3iiZj10rQSWlq5UKpzvV7BGNIXiDtQCOkjsAPoPVFJhe
         Cv/T44cyA2TR+5mlfuWom1Sw/kNnA2GdKih420Be6L1uxX4Ic7dA+pLZpvY7a/oMlweH
         hM7uG6aic89DGkX2LGQbVYt7ttX+dZX2jUym8Aowjl344Ijpha36T1mUeDAJ7Jkkzn/p
         KOF9VMVUlbM8xGvmFc9LV8Z334bR7hpdDpmrrgEQOR9PpvGJ0ZEJCP1gUZ3OV5EY5VqQ
         aAMQ==
X-Gm-Message-State: AOAM533X2b0wxMMdPLpOX1A4pVnJMTs0PSGJi2PztVqIdGxbVnuoeDjv
        KEwh0skoBX4ewES16DYuYnvzRdVa
X-Google-Smtp-Source: ABdhPJyzorw1N/0QePArm0/det6rXCQC8UW72UdPZIxvQHoTZyAVxwL5NPw71JdJBoVtpMWtUr8/yA==
X-Received: by 2002:adf:f74f:: with SMTP id z15mr24424282wrp.233.1595325567165;
        Tue, 21 Jul 2020 02:59:27 -0700 (PDT)
Received: from ?IPv6:2001:a61:3adb:8201:9649:88f:51f8:6a21? ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id n14sm36272362wro.81.2020.07.21.02.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 02:59:26 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] mount_setattr.2: New manual page documenting the
 mount_setattr() system call
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
References: <20200714161415.3886463-1-christian.brauner@ubuntu.com>
 <20200714161415.3886463-2-christian.brauner@ubuntu.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <450635a6-3bf4-4f5a-2eb2-9e477490483d@gmail.com>
Date:   Tue, 21 Jul 2020 11:59:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200714161415.3886463-2-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Christian,

Thanks for writing this manual page. A few comments below.

On 7/14/20 6:14 PM, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  man2/mount_setattr.2 | 296 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 296 insertions(+)
>  create mode 100644 man2/mount_setattr.2
> 
> diff --git a/man2/mount_setattr.2 b/man2/mount_setattr.2
> new file mode 100644
> index 000000000..aae10525e
> --- /dev/null
> +++ b/man2/mount_setattr.2
> @@ -0,0 +1,296 @@
> +.\" Copyright (c) 2020 by Christian Brauner <christian.brauner@ubuntu.com>
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
> +.TH MOUNT_SETATTR 2 2020-07-14 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +mount_setattr \- change mount options of a mount or mount tree
> +.SH SYNOPSIS
> +.nf
> +.BI "int mount_setattr(int " dfd ", const char *" path ", unsigned int " flags ,
> +.BI "                  struct mount_attr *" attr ", size_t " size );
> +.fi
> +.PP
> +.IR Note :
> +There is no glibc wrapper for this system call; see NOTES.
> +.SH DESCRIPTION
> +The
> +.BR mount_setattr ()
> +system call changes the mount properties of a mount or whole mount tree.

You jump over a point between this sentence and the next. I suggest:

s/of a mount or whole mount tree
 /a mount or a whole mount tree whose location is specified
  by the dirfd and path arguments/

Seem okay?

> +If
> +.I path
> +is a relative pathname, then it is interpreted relative to the directory
> +referred to by the file descriptor
> +.I dirfd
> +(or the current working directory of the calling process, if
> +.I dirfd
> +is the special value
> +.BR AT_FDCWD ).
> +If
> +.BR AT_EMPTY_PATH
> +is specified in
> +.I flags

s/$/,/

> +then the mount properties of the mount identified by
> +.I dirfd
> +are changed.
> +.PP
> +The
> +.I flags
> +argument can be used to alter the path resolution behavior. The supported
> +values are:
> +.TP
> +.in +4n
> +.B AT_EMPTY_PATH
> +.in +4n
> +The mount properties of the mount identified by
> +.I dfd
> +are changed.
> +.TP
> +.in +4n
> +.B AT_RECURSIVE
> +.in +4n
> +Change the mount properties of the whole mount tree.
> +.TP
> +.in +4n
> +.B AT_SYMLINK_NOFOLLOW
> +.in +4n
> +Don't follow trailing symlinks.
> +.TP
> +.in +4n
> +.B AT_NO_AUTOMOUNT
> +.in +4n
> +Don't trigger automounts.
> +.PP
> +The
> +.I attr
> +argument of
> +.BR mount_setattr ()
> +is a structure of the following form:
> +.PP
> +.in +4n
> +.EX
> +struct mount_attr {
> +    u64 attr_set;    /* Mount properties to set. */
> +    u64 attr_clr;    /* Mount properties to clear. */
> +    u32 propagation; /* Mount propagation type. */
> +    u32 atime;       /* Access time settings. */
> +};
> +.EE
> +.in
> +.PP
> +The
> +.I attr_set
> +and
> +.I attr_clr
> +members are used to specify the mount options that are supposed to be set or
> +cleared for a given mount or mount tree. The following mount attributes can be
> +specified in the
> +.I attr_set
> +and
> +.I attr_clear
> +fields:
> +.TP
> +.in +4n
> +.B MOUNT_ATTR_RDONLY
> +.in +4n
> +If set in
> +.I attr_set

s/$/,/

> +makes the mount read only and if set in

s/makes/make/
(and similar below)

> +.I attr_clr
> +removes the read only setting if set on the mount.

s/removes/remove/
(and similar below)

> +.TP
> +.in +4n
> +.B MOUNT_ATTR_NOSUID
> +.in +4n
> +If set in
> +.I attr_set

s/$/,/

> +makes the mount not honor set-user-ID and set-group-ID bits or file capabilities
> +when executing programs
> +and if set in
> +.I attr_clr
> +clears the set-user-ID, set-group-ID bits, file capability restriction if set on
> +this mount.
> +.TP
> +.in +4n
> +.B MOUNT_ATTR_NODEV
> +.in +4n
> +If set in
> +.I attr_set

s/$/,/

> +prevents access to devices on this mount

s/prevents/prevent/
(and similar below)

> +and if set in
> +.I attr_clr
> +removes the device access restriction if set on this mount.
> +.TP
> +.in +4n
> +.B MOUNT_ATTR_NOEXEC
> +.in +4n
> +If set in
> +.I attr_set
> +prevents executing programs on this mount
> +and if set in
> +.I attr_clr
> +removes the restriction to execute programs on this mount.
> +.TP
> +.in +4n
> +.B MOUNT_ATTR_NODIRATIME
> +.in +4n
> +If set in
> +.I attr_set
> +prevents updating access time for directories on this mount
> +and if set in
> +.I attr_clr
> +removes access time restriction for directories. Note that
> +.I MOUNT_ATTR_NODIRATIME

s/.I/.B/

> +can be combined with other access time settings and is implied
> +by the noatime setting. All other access time settins are mutually

s/settins/settings/

> +exclusive.
> +.PP
> +The
> +.I propagation
> +member is used to specify the propagation type of the mount or mount tree.
> +The supported mount propagation settings are:
> +.TP
> +.in +4n
> +.B MAKE_PROPAGATION_PRIVATE
> +.in +4n
> +Turn all mounts into private mounts. Mount and umount events do not propagate

Since it may be one or many mounts, I suggest:

s/Turn all mounts into private mounts
 /Make the mount(s) private/

And similar changes below.

And: s/umount/unmount/

> +into or out of this mount point.
> +.TP
> +.in +4n
> +.B MAKE_PROPAGATION_SHARED

These names seem rather verbose. Does the "MAKE_" prefix really add value?
What about using just "PROPAGATION_SHARED" and so on?

And then: is there a reason not to use the MS_ constants already used by
mount(2): MS_SHARED, MS_PRIVATE, etc. I appreciate that those constants
have "odd" values, dictated by the fact that the 'mountflags' argument
of mount(2) is used for many other bits. But, is there harm in simply
reusing the same values and names? (But see my note below before
answering.)

> +.in +4n
> +Turn all mounts into shared mounts. Mount points share events with members of a
> +peer group. Mount and unmount events immediately under this mount point
> +will propagate to the other mount points that are members of the peer group.
> +Propagation here means that the same mount or unmount will automatically occur
> +under all of the other mount points in the peer group. Conversely, mount and
> +unmount events that take place under peer mount points will propagate to this
> +mount point.
> +.TP
> +.in +4n
> +.B MAKE_PROPAGATION_DEPENDENT

Okay -- maybe this is the answer to my question above.

I applaud the move to change the problematic language. Is this name
("DEPENDENT") your invention and/or is there an intent to to propagate this
this language change into any existing parts of the API (e.g., MS_DEPENDENT
as a synonym for MS_SLAVE)? I think it might be useful to add a sentence 
along the lines of:

"This flag is the equivalent of the (unfortunately named) mount(2) 
MS_SLAVE flag."

Just so that the reader can see the equivalence.

> +.in +4n
> +Turn all mounts into dependent mounts. Mount and unmount events propagate into
> +this mount point from a shared  peer group. Mount and unmount events under this
> +mount point do not propagate to any peer.
> +.TP
> +.in +4n
> +.B MAKE_PROPAGATION_UNBINDABLE
> +.in +4n

Add: "Make the mount(s) unbindable."

> +This is like a private mount, and in addition this mount can't be bind mounted.
> +Attempts to bind mount this mount will fail.
> +When a recursive bind mount is performed on a directory subtree, any bind
> +mounts within the subtree are automatically pruned (i.e., not replicated) when
> +replicating that subtree to produce the target subtree.
> +.PP
> +The
> +.I atime
> +member is used to specify the access time behavior on a mount or mount tree.

Somewhere around here, I think it would be good to add a sentence or two to 
explain why the 'atime' field exists in addition to the 'attr_set' and
'attr_clr' fields.

That said, looking at another mail in this discussion, is 'atime'
going away?

> +The supported access times settings are:
> +.TP
> +.in +4n
> +.B MAKE_ATIME_RELATIVE
> +.in +4n
> +When a file on is accessed via this mount, update the file's last access time
> +(atime) only if the current value of atime is less than or equal to the file's
> +last modification time (mtime) or last status change time (ctime).
> +.TP
> +.in +4n
> +.B MAKE_ATIME_NONE
> +.in +4n
> +Do not update access times for (all types of) files on this mount.
> +.TP
> +.in +4n
> +.B MAKE_ATIME_STRICT
> +.in +4n
> +Always update the last access time (atime) when files are
> +accessed on this mount.
> +.PP
> +The
> +.I size
> +argument that is supplied to
> +.BR mount_setattr ()
> +should be initialized to the size of this structure.
> +(The existence of the
> +.I size
> +argument permits future extensions to the
> +.IR mount_attr
> +structure.)
> +.SH RETURN VALUE
> +On success,
> +.BR mount_setattr ()
> +zero is returned. On error, \-1 is returned and

Wording problem...

s/zero is returned/returns 0/

> +.I errno
> +is set to indicate the cause of the error.
> +.SH ERRORS
> +.TP
> +.B EBADF
> +.I dfd
> +is not a valid file descriptor.
> +.TP
> +.B ENOENT
> +A pathname was empty or had a nonexistent component.
> +.TP
> +.B EINVAL
> +Unsupported value in
> +.I flags
> +.TP
> +.B EINVAL
> +Unsupported value was specified in the
> +.I attr_set
> +field of
> +.IR mount_attr.

s/.IR mount_attr./
  .IR mount_attr ./

(and the same at various places below)

> +.TP
> +.B EINVAL
> +Unsupported value was specified in the
> +.I attr_clr
> +field of
> +.IR mount_attr.
> +.TP
> +.B EINVAL
> +Unsupported value was specified in the
> +.I propagation
> +field of
> +.IR mount_attr.
> +.TP
> +.B EINVAL
> +Unsupported value was specified in the
> +.I atime
> +field of
> +.IR mount_attr.
> +.TP
> +.B EINVAL
> +Caller tried to change the mount properties of a mount or mount tree
> +in another mount namespace.
> +.SH VERSIONS
> +.BR mount_setattr ()
> +first appeared in Linux ?.?.
> +.\" commit ?
> +.SH CONFORMING TO
> +.BR mount_setattr ()
> +is Linux specific.
> +.SH NOTES
> +Currently, there is no glibc wrapper for this system call; call it using
> +.BR syscall (2).
> +.SH SEE ALSO
> +.BR mount (2),

Add: mount_namespaces (7).

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
