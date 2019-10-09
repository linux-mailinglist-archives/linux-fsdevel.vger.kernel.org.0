Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1692CD0BE0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 11:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbfJIJwV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 05:52:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36591 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfJIJwV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:52:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id m18so1820066wmc.1;
        Wed, 09 Oct 2019 02:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PMuN07xEQU7ENKm6Bs8hnIyOIUncdbKKMapdrTY/3VY=;
        b=SfoiUwQcPOa2kP88V47YgKKh40ILt9LX6xUFIceCiYlovB/Q8qYk+rYJ9oiPYRNNEx
         LcOP5ktaYOta04k+IRfZh0DniNdVeqkrIsCG114MKxwiMg3HbACptBpFhqRIDLzJcGYY
         dRzvqjeNpI3K3pumUYp6BOMtYBQYGKTwjdvxxvK77yx9PosaWSfXm4wUiKjRySK6QjWr
         tzuKxnUGYWJXD1N1WecGXu/FlRLrlQZX+LJe3mmg9COPGSLSqER+GAmNJwCHb2+JrTac
         zaWHTWkvdx5moF0HcT4Wf5Uz3/EzxhK0nHQNJpw6yYQw1/mZcee6M5aIwcX7yApgWyKf
         xrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PMuN07xEQU7ENKm6Bs8hnIyOIUncdbKKMapdrTY/3VY=;
        b=GB8b0KEmfko6rdJPuaxU2XDqPfmqvD7E2pyQ9+yMyUdlnfX4a6ntooVvZ5c2JzlG+l
         FWT0b6VghFFxWgE9vi8W1stWCw/xPkPLlPKOSWVdib7ZUTGaYq5/0HvwmfL1yKQzG8M6
         i+vMyAP3C8o7kohMbbCpL81xgHuD0NUBQygMZZZE6I2YzCe7mTmL8/DMCQDvrW/+pyRw
         VvvNI2uheTfq41tSjBm0sGTWcZ5+D2iyYzRFK0Fob6ITjaLZjIJeCqfYiESN/U7rwUM8
         0qUx3I3U9HNwiuucM+T+49EyJRoNqHF/Ccq3f3Q7O2lOL0e1ZJPf9DN2yWW9T2xCGCgX
         gDtw==
X-Gm-Message-State: APjAAAUvhbaXMqawKLDaRLTMOuJ+rsGqvcJKg9wPY+LunwO1NzWU0ZGG
        M+Ge+iUA93zqlygkNhShMkQ=
X-Google-Smtp-Source: APXvYqy61Qq6/NORj4hNcekVyN6ZPJgVOxvMIurwYx8BtgcLbIHbhFeZq6WyiwWxCDOkpkdzAT1hqQ==
X-Received: by 2002:a7b:caea:: with SMTP id t10mr2034667wml.38.1570614735996;
        Wed, 09 Oct 2019 02:52:15 -0700 (PDT)
Received: from [10.0.20.253] ([95.157.63.22])
        by smtp.gmail.com with ESMTPSA id 90sm2335440wrr.1.2019.10.09.02.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 02:52:15 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, viro@zeniv.linux.org.uk,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-man@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [MANPAGE PATCH] Add manpage for fsinfo(2)
To:     David Howells <dhowells@redhat.com>
References: <153126269451.14533.13592791373864325188.stgit@warthog.procyon.org.uk>
 <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <15519.1531263314@warthog.procyon.org.uk>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <515a67cd-f847-8885-da30-1eab3931f1fb@gmail.com>
Date:   Wed, 9 Oct 2019 11:52:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <15519.1531263314@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello David,

See my previous mails.

There is no fsinfo(2) in the system call in the kernel currently.
Will that call still be added, or was it replaced by fsconfig(2),
which--as far as I can tell--dnot have a man-pages patch?

Thanks,

Michael

On 7/11/18 12:55 AM, David Howells wrote:
> Add a manual page to document the fsinfo() system call.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  man2/fsinfo.2       | 1017 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  man2/ioctl_iflags.2 |    6 
>  man2/stat.2         |    7 
>  man2/statx.2        |   13 +
>  man2/utime.2        |    7 
>  man2/utimensat.2    |    7 
>  6 files changed, 1057 insertions(+)
>  create mode 100644 man2/fsinfo.2
> 
> diff --git a/man2/fsinfo.2 b/man2/fsinfo.2
> new file mode 100644
> index 000000000..5710232df
> --- /dev/null
> +++ b/man2/fsinfo.2
> @@ -0,0 +1,1017 @@
> +'\" t
> +.\" Copyright (c) 2018 David Howells <dhowells@redhat.com>
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
> +.TH FSINFO 2 2018-06-06 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +fsinfo \- Get filesystem information
> +.SH SYNOPSIS
> +.nf
> +.B #include <sys/types.h>
> +.br
> +.B #include <sys/fsinfo.h>
> +.br
> +.B #include <unistd.h>
> +.br
> +.BR "#include <fcntl.h>           " "/* Definition of AT_* constants */"
> +.PP
> +.BI "int fsinfo(int " dirfd ", const char *" pathname ","
> +.BI "           struct fsinfo_params *" params ","
> +.BI "           void *" buffer ", size_t " buf_size );
> +.fi
> +.PP
> +.IR Note :
> +There is no glibc wrapper for
> +.BR fsinfo ();
> +see NOTES.
> +.SH DESCRIPTION
> +.PP
> +fsinfo() retrieves the desired filesystem attribute, as selected by the
> +parameters pointed to by
> +.IR params ,
> +and stores its value in the buffer pointed to by
> +.IR buffer .
> +.PP
> +The parameter structure is optional, defaulting to all the parameters being 0
> +if the pointer is NULL.  The structure looks like the following:
> +.PP
> +.in +4n
> +.nf
> +struct fsinfo_params {
> +    __u32 at_flags;     /* AT_SYMLINK_NOFOLLOW and similar flags */
> +    __u32 request;      /* Requested attribute */
> +    __u32 Nth;          /* Instance of attribute */
> +    __u32 Mth;          /* Subinstance of Nth instance */
> +    __u32 __reserved[6]; /* Reserved params; all must be 0 */
> +};
> +.fi
> +.in
> +.PP
> +The filesystem to be queried is looked up using a combination of
> +.IR dfd ", " pathname " and " params->at_flags.
> +This is discussed in more detail below.
> +.PP
> +The desired attribute is indicated by
> +.IR params->request .
> +If
> +.I params
> +is NULL, this will default to
> +.BR fsinfo_attr_statfs ,
> +which retrieves some of the information returned by
> +.BR statfs ().
> +The available attributes are described below in the "THE ATTRIBUTES" section.
> +.PP
> +Some attributes can have multiple values and some can even have multiple
> +instances with multiple values.  For example, a network filesystem might use
> +multiple servers.  The names of each of these servers can be retrieved by
> +using
> +.I params->Nth
> +to iterate through all the instances until error
> +.B ENODATA
> +occurs, indicating the end of the list.  Further, each server might have
> +multiple addresses available; these can be enumerated using
> +.I params->Nth
> +to iterate the servers and
> +.I params->Mth
> +to iterate the addresses of the Nth server.
> +.PP
> +The amount of data written into the buffer depends on the attribute selected.
> +Some attributes return variable-length strings and some return fixed-size
> +structures.  If either
> +.IR buffer " is  NULL  or " buf_size " is 0"
> +then the size of the attribute value will be returned and nothing will be
> +written into the buffer.
> +.PP
> +The
> +.I params->__reserved
> +parameters must all be 0.
> +.\"_______________________________________________________
> +.SS
> +Allowance for Future Attribute Expansion
> +.PP
> +To allow for the future expansion and addition of fields to any fixed-size
> +structure attribute,
> +.BR fsinfo ()
> +makes the following guarantees:
> +.RS 4m
> +.IP (1) 4m
> +It will always clear any excess space in the buffer.
> +.IP (2) 4m
> +It will always return the actual size of the data.
> +.IP (3) 4m
> +It will truncate the data to fit it into the buffer rather than giving an
> +error.
> +.IP (4) 4m
> +Any new version of a structure will incorporate all the fields from the old
> +version at same offsets.
> +.RE
> +.PP
> +So, for example, if the caller is running on an older version of the kernel
> +with an older, smaller version of the structure than was asked for, the kernel
> +will write the smaller version into the buffer and will clear the remainder of
> +the buffer to make sure any additional fields are set to 0.  The function will
> +return the actual size of the data.
> +.PP
> +On the other hand, if the caller is running on a newer version of the kernel
> +with a newer version of the structure that is larger than the buffer, the write
> +to the buffer will be truncated to fit as necessary and the actual size of the
> +data will be returned.
> +.PP
> +Note that this doesn't apply to variable-length string attributes.
> +
> +.\"_______________________________________________________
> +.SS
> +Invoking \fBfsinfo\fR():
> +.PP
> +To access a file's status, no permissions are required on the file itself, but
> +in the case of
> +.BR fsinfo ()
> +with a path, execute (search) permission is required on all of the directories
> +in
> +.I pathname
> +that lead to the file.
> +.PP
> +.BR fsinfo ()
> +uses
> +.IR pathname ", " dirfd " and " params->at_flags
> +to locate the target file in one of a variety of ways:
> +.TP
> +[*] By absolute path.
> +.I pathname
> +points to an absolute path and
> +.I dirfd
> +is ignored.  The file is looked up by name, starting from the root of the
> +filesystem as seen by the calling process.
> +.TP
> +[*] By cwd-relative path.
> +.I pathname
> +points to a relative path and
> +.IR dirfd " is " AT_FDCWD .
> +The file is looked up by name, starting from the current working directory.
> +.TP
> +[*] By dir-relative path.
> +.I pathname
> +points to relative path and
> +.I dirfd
> +indicates a file descriptor pointing to a directory.  The file is looked up by
> +name, starting from the directory specified by
> +.IR dirfd .
> +.TP
> +[*] By file descriptor.
> +.IR pathname " is " NULL " and " dirfd
> +indicates a file descriptor.  The file attached to the file descriptor is
> +queried directly.  The file descriptor may point to any type of file, not just
> +a directory.
> +.PP
> +.I flags
> +can be used to influence a path-based lookup.  A value for
> +.I flags
> +is constructed by OR'ing together zero or more of the following constants:
> +.TP
> +.BR AT_EMPTY_PATH
> +.\" commit 65cfc6722361570bfe255698d9cd4dccaf47570d
> +If
> +.I pathname
> +is an empty string, operate on the file referred to by
> +.IR dirfd
> +(which may have been obtained using the
> +.BR open (2)
> +.B O_PATH
> +flag).
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
> +Don't automount the terminal ("basename") component of
> +.I pathname
> +if it is a directory that is an automount point.  This allows the caller to
> +gather attributes of the filesystem holding an automount point (rather than
> +the filesystem it would mount).  This flag can be used in tools that scan
> +directories to prevent mass-automounting of a directory of automount points.
> +The
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
> +is a symbolic link, do not dereference it:
> +instead return information about the link itself, like
> +.BR lstat ().
> +.SH THE ATTRIBUTES
> +.PP
> +There is a range of attributes that can be selected from.  These are:
> +
> +.\" __________________ fsinfo_attr_statfs __________________
> +.TP
> +.B fsinfo_attr_statfs
> +This retrieves the "dynamic"
> +.B statfs
> +information, such as block and file counts, that are expected to change whilst
> +a filesystem is being used.  This fills in the following structure:
> +.PP
> +.RS
> +.in +4n
> +.nf
> +struct fsinfo_statfs {
> +    __u64 f_blocks;	/* Total number of blocks in fs */
> +    __u64 f_bfree;	/* Total number of free blocks */
> +    __u64 f_bavail;	/* Number of free blocks available to ordinary user */
> +    __u64 f_files;	/* Total number of file nodes in fs */
> +    __u64 f_ffree;	/* Number of free file nodes */
> +    __u64 f_favail;	/* Number of free file nodes available to ordinary user */
> +    __u32 f_bsize;	/* Optimal block size */
> +    __u32 f_frsize;	/* Fragment size */
> +};
> +.fi
> +.in
> +.RE
> +.IP
> +The fields correspond to those of the same name returned by
> +.BR statfs ().
> +
> +.\" __________________ fsinfo_attr_fsinfo __________________
> +.TP
> +.B fsinfo_attr_fsinfo
> +This retrieves information about the
> +.BR fsinfo ()
> +system call itself.  This fills in the following structure:
> +.PP
> +.RS
> +.in +4n
> +.nf
> +struct fsinfo_fsinfo {
> +    __u32 max_attr;
> +    __u32 max_cap;
> +};
> +.fi
> +.in
> +.RE
> +.IP
> +The
> +.I max_attr
> +value indicates the number of attributes supported by the
> +.BR fsinfo ()
> +system call, and
> +.I max_cap
> +indicates the number of capability bits supported by the
> +.B fsinfo_attr_capabilities
> +attribute.  The first corresponds to
> +.I fsinfo_attr__nr
> +and the second to
> +.I fsinfo_cap__nr
> +in the header file.
> +
> +.\" __________________ fsinfo_attr_ids __________________
> +.TP
> +.B fsinfo_attr_ids
> +This retrieves a number of fixed IDs and other static information otherwise
> +available through
> +.BR statfs ().
> +The following structure is filled in:
> +.PP
> +.RS
> +.in +4n
> +.nf
> +struct fsinfo_ids {
> +    char  f_fs_name[15 + 1]; /* Filesystem name */
> +    __u64 f_flags;	/* Filesystem mount flags (MS_*) */
> +    __u64 f_fsid;	/* Short 64-bit Filesystem ID */
> +    __u64 f_sb_id;	/* Internal superblock ID */
> +    __u32 f_fstype;	/* Filesystem type from linux/magic.h */
> +    __u32 f_dev_major;	/* As st_dev_* from struct statx */
> +    __u32 f_dev_minor;
> +};
> +.fi
> +.in
> +.RE
> +.IP
> +Most of these are filled in as for
> +.BR statfs (),
> +with the addition of the filesystem's symbolic name in
> +.I f_fs_name
> +and an identifier for use in notifications in
> +.IR f_sb_id .
> +
> +.\" __________________ fsinfo_attr_limits __________________
> +.TP
> +.B fsinfo_attr_limits
> +This retrieves information about the limits of what a filesystem can support.
> +The following structure is filled in:
> +.PP
> +.RS
> +.in +4n
> +.nf
> +struct fsinfo_limits {
> +    __u64 max_file_size;
> +    __u64 max_uid;
> +    __u64 max_gid;
> +    __u64 max_projid;
> +    __u32 max_dev_major;
> +    __u32 max_dev_minor;
> +    __u32 max_hard_links;
> +    __u32 max_xattr_body_len;
> +    __u16 max_xattr_name_len;
> +    __u16 max_filename_len;
> +    __u16 max_symlink_len;
> +    __u16 __reserved[1];
> +};
> +.fi
> +.in
> +.RE
> +.IP
> +These indicate the maximum supported sizes for a variety of filesystem objects,
> +including the file size, the extended attribute name length and body length,
> +the filename length and the symlink body length.
> +.IP
> +It also indicates the maximum representable values for a User ID, a Group ID,
> +a Project ID, a device major number and a device minor number.
> +.IP
> +And finally, it indicates the maximum number of hard links that can be made to
> +a file.
> +.IP
> +Note that some of these values may be zero if the underlying object or concept
> +is not supported by the filesystem or the medium.
> +
> +.\" __________________ fsinfo_attr_supports __________________
> +.TP
> +.B fsinfo_attr_supports
> +This retrieves information about what bits a filesystem supports in various
> +masks.  The following structure is filled in:
> +.PP
> +.RS
> +.in +4n
> +.nf
> +struct fsinfo_supports {
> +    __u64 stx_attributes;
> +    __u32 stx_mask;
> +    __u32 ioc_flags;
> +    __u32 win_file_attrs;
> +    __u32 __reserved[1];
> +};
> +.fi
> +.in
> +.RE
> +.IP
> +The
> +.IR stx_attributes " and " stx_mask
> +fields indicate what bits in the struct statx fields of the matching names
> +are supported by the filesystem.
> +.IP
> +The
> +.I ioc_flags
> +field indicates what FS_*_FL flag bits as used through the FS_IOC_GET/SETFLAGS
> +ioctls are supported by the filesystem.
> +.IP
> +The
> +.I win_file_attrs
> +indicates what DOS/Windows file attributes a filesystem supports, if any.
> +
> +.\" __________________ fsinfo_attr_capabilities __________________
> +.TP
> +.B fsinfo_attr_capabilities
> +This retrieves information about what features a filesystem supports as a
> +series of single bit indicators.  The following structure is filled in:
> +.PP
> +.RS
> +.in +4n
> +.nf
> +struct fsinfo_capabilities {
> +    __u8 capabilities[(fsinfo_cap__nr + 7) / 8];
> +};
> +.fi
> +.in
> +.RE
> +.IP
> +where the bit of interest can be found by:
> +.PP
> +.RS
> +.in +4n
> +.nf
> +	p->capabilities[bit / 8] & (1 << (bit % 8)))
> +.fi
> +.in
> +.RE
> +.IP
> +The bits are listed by
> +.I enum fsinfo_capability
> +and
> +.B fsinfo_cap__nr
> +is one more than the last capability bit listed in the header file.
> +.IP
> +Note that the number of capability bits actually supported by the kernel can be
> +found using the
> +.B fsinfo_attr_fsinfo
> +attribute.
> +.IP
> +The capability bits and their meanings are listed below in the "THE
> +CAPABILITIES" section.
> +
> +.\" __________________ fsinfo_attr_timestamp_info __________________
> +.TP
> +.B fsinfo_attr_timestamp_info
> +This retrieves information about what timestamp resolution and scope is
> +supported by a filesystem for each of the file timestamps.  The following
> +structure is filled in:
> +.PP
> +.RS
> +.in +4n
> +.nf
> +struct fsinfo_timestamp_info {
> +	__s64 minimum_timestamp;
> +	__s64 maximum_timestamp;
> +	__u16 atime_gran_mantissa;
> +	__u16 btime_gran_mantissa;
> +	__u16 ctime_gran_mantissa;
> +	__u16 mtime_gran_mantissa;
> +	__s8  atime_gran_exponent;
> +	__s8  btime_gran_exponent;
> +	__s8  ctime_gran_exponent;
> +	__s8  mtime_gran_exponent;
> +	__u32 __reserved[1];
> +};
> +.fi
> +.in
> +.RE
> +.IP
> +where
> +.IR minimum_timestamp " and " maximum_timestamp
> +are the limits on the timestamps that the filesystem supports and
> +.IR *time_gran_mantissa " and " *time_gran_exponent
> +indicate the granularity of each timestamp in terms of seconds, using the
> +formula:
> +.PP
> +.RS
> +.in +4n
> +.nf
> +mantissa * pow(10, exponent) Seconds
> +.fi
> +.in
> +.RE
> +.IP
> +where exponent may be negative and the result may be a fraction of a second.
> +.IP
> +Four timestamps are detailed: \fBA\fPccess time, \fBB\fPirth/creation time,
> +\fBC\fPhange time and \fBM\fPodification time.  Capability bits are defined
> +that specify whether each of these exist in the filesystem or not.
> +.IP
> +Note that the timestamp description may be approximated or inaccurate if the
> +file is actually remote or is the union of multiple objects.
> +
> +.\" __________________ fsinfo_attr_volume_id __________________
> +.TP
> +.B fsinfo_attr_volume_id
> +This retrieves the system's superblock volume identifier as a variable-length
> +string.  This does not necessarily represent a value stored in the medium but
> +might be constructed on the fly.
> +.IP
> +For instance, for a block device this is the block device identifier
> +(eg. "sdb2"); for AFS this would be the numeric volume identifier.
> +
> +.\" __________________ fsinfo_attr_volume_uuid __________________
> +.TP
> +.B fsinfo_attr_volume_uuid
> +This retrieves the volume UUID, if there is one, as a little-endian binary
> +UUID.  This fills in the following structure:
> +.PP
> +.RS
> +.in +4n
> +.nf
> +struct fsinfo_volume_uuid {
> +    __u8 uuid[16];
> +};
> +.fi
> +.in
> +.RE
> +.IP
> +
> +.\" __________________ fsinfo_attr_volume_name __________________
> +.TP
> +.B fsinfo_attr_volume_name
> +This retrieves the filesystem's volume name as a variable-length string.  This
> +is expected to represent a name stored in the medium.
> +.IP
> +For a block device, this might be a label stored in the superblock.  For a
> +network filesystem, this might be a logical volume name of some sort.
> +
> +.\" __________________ fsinfo_attr_cell/domain __________________
> +.PP
> +.B fsinfo_attr_cell_name
> +.br
> +.B fsinfo_attr_domain_name
> +.br
> +.IP
> +These two attributes are variable-length string attributes that may be used to
> +obtain information about network filesystems.  An AFS volume, for instance,
> +belongs to a named cell.  CIFS shares may belong to a domain.
> +
> +.\" __________________ fsinfo_attr_realm_name __________________
> +.TP
> +.B fsinfo_attr_realm_name
> +This attribute is variable-length string that indicates the Kerberos realm that
> +a filesystem's authentication tokens should come from.
> +
> +.\" __________________ fsinfo_attr_server_name __________________
> +.TP
> +.B fsinfo_attr_server_name
> +This attribute is a multiple-value attribute that lists the names of the
> +servers that are backing a network filesystem.  Each value is a variable-length
> +string.  The values are enumerated by calling
> +.BR fsinfo ()
> +multiple times, incrementing
> +.I params->Nth
> +each time until an ENODATA error occurs, thereby indicating the end of the
> +list.
> +
> +.\" __________________ fsinfo_attr_server_address __________________
> +.TP
> +.B fsinfo_attr_server_address
> +This attribute is a multiple-instance, multiple-value attribute that lists the
> +addresses of the servers that are backing a network filesystem.  Each value is
> +a structure of the following type:
> +.PP
> +.RS
> +.in +4n
> +.nf
> +struct fsinfo_server_address {
> +    struct __kernel_sockaddr_storage address;
> +};
> +.fi
> +.in
> +.RE
> +.IP
> +Where the address may be AF_INET, AF_INET6, AF_RXRPC or any other type as
> +appropriate to the filesystem.
> +.IP
> +The values are enumerated by calling
> +.IR fsinfo ()
> +multiple times, incrementing
> +.I params->Nth
> +to step through the servers and
> +.I params->Mth
> +to step through the addresses of the Nth server each time until ENODATA errors
> +occur, thereby indicating either the end of a server's address list or the end
> +of the server list.
> +.IP
> +Barring the server list changing whilst being accessed, it is expected that the
> +.I params->Nth
> +will correspond to
> +.I params->Nth
> +for
> +.BR fsinfo_attr_server_name .
> +
> +.\" __________________ fsinfo_attr_parameter __________________
> +.TP
> +.B fsinfo_attr_parameter
> +This attribute is a multiple-value attribute that lists the values of the mount
> +parameters for a filesystem as variable-length strings.
> +.IP
> +The parameters are enumerated by calling
> +.BR fsinfo ()
> +multiple times, incrementing
> +.I params->Nth
> +to step through them until error ENODATA is given.
> +.IP
> +Parameter strings are presented in a form akin to the way they're passed to the
> +context created by the
> +.BR fsopen ()
> +system call.  For example, straight text parameters will be rendered as
> +something like:
> +.PP
> +.RS
> +.in +4n
> +.nf
> +"o data=journal"
> +"o noquota"
> +.fi
> +.in
> +.RE
> +.IP
> +Where the initial "word" indicates the option form.
> +
> +.\" __________________ fsinfo_attr_source __________________
> +.TP
> +.B fsinfo_attr_source
> +This attribute is a multiple-value attribute that lists the mount sources for a
> +filesystem as variable-length strings.  Normally only one source will be
> +available, but the possibility of having more than one is allowed for.
> +.IP
> +The sources are enumerated by calling
> +.BR fsinfo ()
> +multiple times, incrementing
> +.I params->Nth
> +to step through them until error ENODATA is given.
> +.IP
> +Source strings are presented in a form akin to the way they're passed to the
> +context created by the
> +.BR fsopen ()
> +system call.  For example, they will be rendered as something like:
> +.PP
> +.RS
> +.in +4n
> +.nf
> +"s /dev/sda1"
> +"s example.com/pub/linux/"
> +.fi
> +.in
> +.RE
> +.IP
> +Where the initial "word" indicates the option form.
> +
> +.\" __________________ fsinfo_attr_name_encoding __________________
> +.TP
> +.B fsinfo_attr_name_encoding
> +This attribute is variable-length string that indicates the filename encoding
> +used by the filesystem.  The default is "utf8".  Note that this may indicate a
> +non-8-bit encoding if that's what the underlying filesystem actually supports.
> +
> +.\" __________________ fsinfo_attr_name_codepage __________________
> +.TP
> +.B fsinfo_attr_name_codepage
> +This attribute is variable-length string that indicates the codepage used to
> +translate filenames from the filesystem to the system if this is applicable to
> +the filesystem.
> +
> +.\" __________________ fsinfo_attr_io_size __________________
> +.TP
> +.B fsinfo_attr_io_size
> +This retrieves information about the I/O sizes supported by the filesystem.
> +The following structure is filled in:
> +.PP
> +.RS
> +.in +4n
> +.nf
> +struct fsinfo_io_size {
> +    __u32 block_size;
> +    __u32 max_single_read_size;
> +    __u32 max_single_write_size;
> +    __u32 best_read_size;
> +    __u32 best_write_size;
> +};
> +.fi
> +.in
> +.RE
> +.IP
> +Where
> +.I block_size
> +indicates the fundamental I/O block size of the filesystem as something
> +O_DIRECT read/write sizes must be a multiple of;
> +.IR max_single_write_size " and " max_single_write_size
> +indicate the maximum sizes for individual unbuffered data transfer operations;
> +and
> +.IR best_read_size " and " best_write_size
> +indicate the recommended I/O sizes.
> +.IP
> +Note that any of these may be zero if inapplicable or indeterminable.
> +
> +
> +
> +.SH THE CAPABILITIES
> +.PP
> +There are number of capability bits in a bit array that can be retrieved using
> +.BR fsinfo_attr_capabilities .
> +These give information about features of the filesystem driver and the specific
> +filesystem.
> +
> +.\" __________________ fsinfo_cap_is_*_fs __________________
> +.PP
> +.B fsinfo_cap_is_kernel_fs
> +.br
> +.B fsinfo_cap_is_block_fs
> +.br
> +.B fsinfo_cap_is_flash_fs
> +.br
> +.B fsinfo_cap_is_network_fs
> +.br
> +.B fsinfo_cap_is_automounter_fs
> +.IP
> +These indicate the primary type of the filesystem.
> +.B kernel
> +filesystems are special communication interfaces that substitute files for
> +system calls; examples include procfs and sysfs.
> +.B block
> +filesystems require a block device on which to operate; examples include ext4
> +and XFS.
> +.B flash
> +filesystems require an MTD device on which to operate; examples include JFFS2.
> +.B network
> +filesystems require access to the network and contact one or more servers;
> +examples include NFS and AFS.
> +.B automounter
> +filesystems are kernel special filesystems that host automount points and
> +triggers to dynamically create automount points.  Examples include autofs and
> +AFS's dynamic root.
> +
> +.\" __________________ fsinfo_cap_automounts __________________
> +.TP
> +.B fsinfo_cap_automounts
> +The filesystem may have automount points that can be triggered by pathwalk.
> +
> +.\" __________________ fsinfo_cap_adv_locks __________________
> +.TP
> +.B fsinfo_cap_adv_locks
> +The filesystem supports advisory file locks.  For a network filesystem, this
> +indicates that the advisory file locks are cross-client (and also between
> +server and its local filesystem on something like NFS).
> +
> +.\" __________________ fsinfo_cap_mand_locks __________________
> +.TP
> +.B fsinfo_cap_mand_locks
> +The filesystem supports mandatory file locks.  For a network filesystem, this
> +indicates that the mandatory file locks are cross-client (and also between
> +server and its local filesystem on something like NFS).
> +
> +.\" __________________ fsinfo_cap_leases __________________
> +.TP
> +.B fsinfo_cap_leases
> +The filesystem supports leases.  For a network filesystem, this means that the
> +server will tell the client to clean up its state on a file before passing the
> +lease to another client.
> +
> +.\" __________________ fsinfo_cap_*ids __________________
> +.PP
> +.B fsinfo_cap_uids
> +.br
> +.B fsinfo_cap_gids
> +.br
> +.B fsinfo_cap_projids
> +.IP
> +These indicate that the filesystem supports numeric user IDs, group IDs and
> +project IDs respectively.
> +
> +.\" __________________ fsinfo_cap_id_* __________________
> +.PP
> +.B fsinfo_cap_id_names
> +.br
> +.B fsinfo_cap_id_guids
> +.IP
> +These indicate that the filesystem employs textual names and/or GUIDs as
> +identifiers.
> +
> +.\" __________________ fsinfo_cap_windows_attrs __________________
> +.TP
> +.B fsinfo_cap_windows_attrs
> +Indicates that the filesystem supports some Windows FILE_* attributes.
> +
> +.\" __________________ fsinfo_cap_*_quotas __________________
> +.PP
> +.B fsinfo_cap_user_quotas
> +.br
> +.B fsinfo_cap_group_quotas
> +.br
> +.B fsinfo_cap_project_quotas
> +.IP
> +These indicate that the filesystem supports quotas for users, groups and
> +projects respectively.
> +
> +.\" __________________ fsinfo_cap_xattrs/filetypes __________________
> +.PP
> +.B fsinfo_cap_xattrs
> +.br
> +.B fsinfo_cap_symlinks
> +.br
> +.B fsinfo_cap_hard_links
> +.br
> +.B fsinfo_cap_hard_links_1dir
> +.br
> +.B fsinfo_cap_device_files
> +.br
> +.B fsinfo_cap_unix_specials
> +.IP
> +These indicate that the filesystem supports respectively extended attributes;
> +symbolic links; hard links spanning direcories; hard links, but only within a
> +directory; block and character device files; and UNIX special files, such as
> +FIFO and socket.
> +
> +.\" __________________ fsinfo_cap_*journal* __________________
> +.PP
> +.B fsinfo_cap_journal
> +.br
> +.B fsinfo_cap_data_is_journalled
> +.IP
> +The first of these indicates that the filesystem has a journal and the second
> +that the file data changes are being journalled.
> +
> +.\" __________________ fsinfo_cap_o_* __________________
> +.PP
> +.B fsinfo_cap_o_sync
> +.br
> +.B fsinfo_cap_o_direct
> +.IP
> +These indicate that O_SYNC and O_DIRECT are supported respectively.
> +
> +.\" __________________ fsinfo_cap_o_* __________________
> +.PP
> +.B fsinfo_cap_volume_id
> +.br
> +.B fsinfo_cap_volume_uuid
> +.br
> +.B fsinfo_cap_volume_name
> +.br
> +.B fsinfo_cap_volume_fsid
> +.br
> +.B fsinfo_cap_cell_name
> +.br
> +.B fsinfo_cap_domain_name
> +.br
> +.B fsinfo_cap_realm_name
> +.IP
> +These indicate if various attributes are supported by the filesystem, where
> +.B fsinfo_cap_X
> +here corresponds to
> +.BR fsinfo_attr_X .
> +
> +.\" __________________ fsinfo_cap_iver_* __________________
> +.PP
> +.B fsinfo_cap_iver_all_change
> +.br
> +.B fsinfo_cap_iver_data_change
> +.br
> +.B fsinfo_cap_iver_mono_incr
> +.IP
> +These indicate if
> +.I i_version
> +on an inode in the filesystem is supported and
> +how it behaves.
> +.B all_change
> +indicates that i_version is incremented on metadata changes as well as data
> +changes.
> +.B data_change
> +indicates that i_version is only incremented on data changes, including
> +truncation.
> +.B mono_incr
> +indicates that i_version is incremented by exactly 1 for each change made.
> +
> +.\" __________________ fsinfo_cap_resource_forks __________________
> +.TP
> +.B fsinfo_cap_resource_forks
> +This indicates that the filesystem supports some sort of resource fork or
> +alternate data stream on a file.  This isn't the same as an extended attribute.
> +
> +.\" __________________ fsinfo_cap_name_* __________________
> +.PP
> +.B fsinfo_cap_name_case_indep
> +.br
> +.B fsinfo_cap_name_non_utf8
> +.br
> +.B fsinfo_cap_name_has_codepage
> +.IP
> +These indicate certain facts about the filenames in a filesystem: whether
> +they're case-independent; if they're not UTF-8; and if there's a codepage
> +employed to map the names.
> +
> +.\" __________________ fsinfo_cap_sparse __________________
> +.TP
> +.B fsinfo_cap_sparse
> +This indicates that the filesystem supports sparse files.
> +
> +.\" __________________ fsinfo_cap_not_persistent __________________
> +.TP
> +.B fsinfo_cap_not_persistent
> +This indicates that the filesystem is not persistent, and that any data stored
> +here will not be saved in the event that the filesystem is unmounted, the
> +machine is rebooted or the machine loses power.
> +
> +.\" __________________ fsinfo_cap_no_unix_mode __________________
> +.TP
> +.B fsinfo_cap_no_unix_mode
> +This indicates that the filesystem doesn't support the UNIX mode permissions
> +bits.
> +
> +.\" __________________ fsinfo_cap_has_*time __________________
> +.PP
> +.B fsinfo_cap_has_atime
> +.br
> +.B fsinfo_cap_has_btime
> +.br
> +.B fsinfo_cap_has_ctime
> +.br
> +.B fsinfo_cap_has_mtime
> +.IP
> +These indicate as to what timestamps a filesystem supports, including: Access
> +time, Birth/creation time, Change time (metadata and data) and Modification
> +time (data only).
> +
> +
> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +.SH RETURN VALUE
> +On success, the size of the value that the kernel has available is returned,
> +irrespective of whether the buffer is large enough to hold that.  The data
> +written to the buffer will be truncated if it is not.  On error, \-1 is
> +returned, and
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
> +.IR pathname ", " params " or " buffer
> +point to a location outside the process's accessible address space.
> +.TP
> +.B EINVAL
> +Reserved flag specified in
> +.IR params->at_flags " or one of " params->__reserved[]
> +is not 0.
> +.TP
> +.B EOPNOTSUPP
> +Unsupported attribute requested in
> +.IR params->request .
> +This may be beyond the limit of the supported attribute set or may just not be
> +one that's supported by the filesystem.
> +.TP
> +.B ENODATA
> +Unavailable attribute value requested by
> +.IR params->Nth " and/or " params->Mth .
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
> +.IR params->at_flags .
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
> +.BR fsinfo ()
> +was added to Linux in kernel 4.18.
> +.SH CONFORMING TO
> +.BR fsinfo ()
> +is Linux-specific.
> +.SH NOTES
> +Glibc does not (yet) provide a wrapper for the
> +.BR fsinfo ()
> +system call; call it using
> +.BR syscall (2).
> +.SH SEE ALSO
> +.BR ioctl_iflags (2),
> +.BR statx (2),
> +.BR statfs (2)
> diff --git a/man2/ioctl_iflags.2 b/man2/ioctl_iflags.2
> index 9c77b08b9..49ba4444e 100644
> --- a/man2/ioctl_iflags.2
> +++ b/man2/ioctl_iflags.2
> @@ -200,9 +200,15 @@ the effective user ID of the caller must match the owner of the file,
>  or the caller must have the
>  .BR CAP_FOWNER
>  capability.
> +.PP
> +The set of flags supported by a filesystem can be determined by calling
> +.IR fsinfo (2)
> +with attribute
> +.IR fsinfo_attr_supports .
>  .SH SEE ALSO
>  .BR chattr (1),
>  .BR lsattr (1),
> +.BR fsinfo (2),
>  .BR mount (2),
>  .BR btrfs (5),
>  .BR ext4 (5),
> diff --git a/man2/stat.2 b/man2/stat.2
> index dad9a01ac..ee4001f85 100644
> --- a/man2/stat.2
> +++ b/man2/stat.2
> @@ -532,6 +532,12 @@ If none of the aforementioned macros are defined,
>  then the nanosecond values are exposed with names of the form
>  .IR st_atimensec .
>  .\"
> +.PP
> +Which timestamps are supported by a filesystem and their the ranges and
> +granularities can be determined by calling
> +.IR fsinfo (2)
> +with attribute
> +.IR fsinfo_attr_timestamp_info .
>  .SS C library/kernel differences
>  Over time, increases in the size of the
>  .I stat
> @@ -707,6 +713,7 @@ main(int argc, char *argv[])
>  .BR access (2),
>  .BR chmod (2),
>  .BR chown (2),
> +.BR fsinfo (2),
>  .BR readlink (2),
>  .BR utime (2),
>  .BR capabilities (7),
> diff --git a/man2/statx.2 b/man2/statx.2
> index edac9f6f4..9a57c1b90 100644
> --- a/man2/statx.2
> +++ b/man2/statx.2
> @@ -534,12 +534,25 @@ Glibc does not (yet) provide a wrapper for the
>  .BR statx ()
>  system call; call it using
>  .BR syscall (2).
> +.PP
> +The sets of mask/stx_mask and stx_attributes bits supported by a filesystem
> +can be determined by calling
> +.IR fsinfo (2)
> +with attribute
> +.IR fsinfo_attr_supports .
> +.PP
> +Which timestamps are supported by a filesystem and their the ranges and
> +granularities can also be determined by calling
> +.IR fsinfo (2)
> +with attribute
> +.IR fsinfo_attr_timestamp_info .
>  .SH SEE ALSO
>  .BR ls (1),
>  .BR stat (1),
>  .BR access (2),
>  .BR chmod (2),
>  .BR chown (2),
> +.BR fsinfo (2),
>  .BR readlink (2),
>  .BR stat (2),
>  .BR utime (2),
> diff --git a/man2/utime.2 b/man2/utime.2
> index 03a43a416..c6acdbac2 100644
> --- a/man2/utime.2
> +++ b/man2/utime.2
> @@ -181,9 +181,16 @@ on an append-only file.
>  .\" is just a wrapper for
>  .\" .BR utime ()
>  .\" and hence does not allow a subsecond resolution.
> +.PP
> +Which timestamps are supported by a filesystem and their the ranges and
> +granularities can be determined by calling
> +.IR fsinfo (2)
> +with attribute
> +.IR fsinfo_attr_timestamp_info .
>  .SH SEE ALSO
>  .BR chattr (1),
>  .BR touch (1),
> +.BR fsinfo (2),
>  .BR futimesat (2),
>  .BR stat (2),
>  .BR utimensat (2),
> diff --git a/man2/utimensat.2 b/man2/utimensat.2
> index d61b43e96..be8925548 100644
> --- a/man2/utimensat.2
> +++ b/man2/utimensat.2
> @@ -633,9 +633,16 @@ instead checks whether the
>  .\" conversely, a process with a read-only file descriptor won't
>  .\" be able to update the timestamps of a file,
>  .\" even if it has write permission on the file.
> +.PP
> +Which timestamps are supported by a filesystem and their the ranges and
> +granularities can be determined by calling
> +.IR fsinfo (2)
> +with attribute
> +.IR fsinfo_attr_timestamp_info .
>  .SH SEE ALSO
>  .BR chattr (1),
>  .BR touch (1),
> +.BR fsinfo (2),
>  .BR futimesat (2),
>  .BR openat (2),
>  .BR stat (2),
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
