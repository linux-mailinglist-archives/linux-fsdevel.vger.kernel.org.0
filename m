Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC202215D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2019 05:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfERDWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 23:22:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43445 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfERDWJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 23:22:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id c6so4564473pfa.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2019 20:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=olC6NXAKGq2s3YUhJiea/QvzzqsDIDwL88dOGBbti9M=;
        b=uBu4z9nG9JFHiIwBRhPtdyaQ3itoskDkeHDyZxhth+dWAE62UtbjzCeg2IW+y+JCXu
         JX6Rh0Shq5TYsdnpjnutB38k26Nx6Q33jql7KLT/ix1rZHWUI0DWKdS/AFqSXfDelioT
         CCbcyTfRhWGcDk2LrRA5pz+r5Hi98b/jS07KtrggINPf4sXeSD8NtOca+uhhbfYefrd1
         YjgIs40RDcRzwM1OwsMj0cB5mtTFG6rsdnlnty+75CZVXTrsyKLAWjjpoldXL2yoRU9G
         juphrfuZ3oC1myim5xJ9/5f5SkOe5oQItpMDePJJT3xin53UXuFiWdchjE7rVoRFXW35
         8myQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=olC6NXAKGq2s3YUhJiea/QvzzqsDIDwL88dOGBbti9M=;
        b=szU2i9rBMdCGmfEfvDcl9REWEOtxPruSjsIuKzp7i7kcImY8P3Q9LsYYlE0BnHHWu0
         pAGEmlafPEi6NgADaIMrtrJzSm9nkbBF0K46vv3u/Jp2fvIgA+BXFtGWgfNvLAwJI38G
         kP70yIJuw01zPQ+rdMFZGomCAIUNNAxqZF071GIXeHotHe8CsOintK2pbBXFngO5MeiR
         bsYrvckvQ0iHPWzdqJXLYmn9/Atfdg/bSxE7U7v4yf3lBdpkKnp7+SgpLDWNyLTyIImw
         ybXBoQq3pNkH6p+mt1NHTQbp6Pa68IlVXCUmUr81Hwo5gdBAKT//xghTXEbLEhTn0J/e
         E4XQ==
X-Gm-Message-State: APjAAAXT38wUyX2kKRMvSLaJVfx/RpWTyDvL+6efk1rfs1XCUFPcoPiE
        fikYEITNEBm+4chJTP9TiPYw
X-Google-Smtp-Source: APXvYqzKE+iLabyB9TynxfpcKqw+210khnFdArHx2Mw8mkhz2tmmZ6tsSMZpgZmt4IhbIfz5E1sX2w==
X-Received: by 2002:a62:ee04:: with SMTP id e4mr1856858pfi.232.1558149728050;
        Fri, 17 May 2019 20:22:08 -0700 (PDT)
Received: from poseidon.Home (n114-74-156-190.sbr2.nsw.optusnet.com.au. [114.74.156.190])
        by smtp.gmail.com with ESMTPSA id s80sm28652956pfs.117.2019.05.17.20.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 20:22:07 -0700 (PDT)
Date:   Sat, 18 May 2019 13:22:00 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, amir73il@gmail.com, jack@suse.cz
Subject: Re: [PATCH v2] fanotify.7, fanotify_init.2, fanotify_mark.2:
 Document FAN_REPORT_FID and directory modification events
Message-ID: <20190518032158.GA7273@poseidon.Home>
References: <20190330115554.GA28328@lithium.mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330115554.GA28328@lithium.mbobrowski.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Michael,

I noticed that this patch series was not part of the recent 5.01
man-pages release. Is there any particular reason why it wasn't
included?

On Sat, Mar 30, 2019 at 10:56:00PM +1100, Matthew Bobrowski wrote:
> Details relating to the new initialization flag FAN_REPORT_FID has been
> added. As part of the FAN_REPORT_FID feature, a new set of event masks are
> available and have been documented accordingly.
> 
> A simple example program has been added to also support the understanding
> and use of FAN_REPORT_FID and directory modification events.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
> 
> This patch contains the supporting documentation for the newly introduced
> FAN_REPORT_FID flag and directory entry modification events. These changes have
> been merged with master and are available as of Linux 5.1. This version of the
> patch contains minor grammatical corrections that have been applied to
> man7/fanotify.7.
> 
>  man2/fanotify_init.2 |  30 +++++
>  man2/fanotify_mark.2 |  94 ++++++++++++++-
>  man7/fanotify.7      | 331 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 442 insertions(+), 13 deletions(-)
> 
> diff --git a/man2/fanotify_init.2 b/man2/fanotify_init.2
> index 9be15be..c808c2b 100644
> --- a/man2/fanotify_init.2
> +++ b/man2/fanotify_init.2
> @@ -94,6 +94,34 @@ already contain their final content.
>  This notification class might be used by malware detection programs, for
>  example.
>  .TP
> +.BR FAN_REPORT_FID " (since Linux 5.1)"
> +.\" commit a8b13aa20afb69161b5123b4f1acc7ea0a03d360
> +This value allows the receipt of events which contain additional information
> +about the underlying object correlated to an event.
> +An additional structure encapsulates the information about the object and is
> +included alongside the generic event metadata structure.
> +The file descriptor that is used to represent the object correlated to an
> +event is instead substituted with a file handle.
> +It is intended for applications that may find the use of a file handle to
> +identify an object more suitable than a file descriptor.
> +Additionally, it may be used for applications that are interested in
> +directory entry events, such as
> +.BR FAN_CREATE ,
> +.BR FAN_ATTRIB ,
> +.BR FAN_MOVE
> +and
> +.BR FAN_DELETE
> +for example.
> +The use of
> +.BR FAN_CLASS_CONTENT
> +or
> +.BR FAN_CLASS_PRE_CONTENT
> +is not permitted with this flag and will result in the error
> +.BR EINVAL .
> +See
> +.BR fanotify (7)
> +for additional information.
> +.TP
>  .B FAN_CLASS_NOTIF
>  This is the default value.
>  It does not need to be specified.
> @@ -224,6 +252,8 @@ An invalid value was passed in
>  or
>  .IR event_f_flags .
>  .B FAN_ALL_INIT_FLAGS
> +(deprecated since Linux kernel version 4.20)
> +.\" commit 23c9deeb3285d34fd243abb3d6b9f07db60c3cf4
>  defines all allowable bits for
>  .IR flags .
>  .TP
> diff --git a/man2/fanotify_mark.2 b/man2/fanotify_mark.2
> index 3c6e956..cffaae9 100644
> --- a/man2/fanotify_mark.2
> +++ b/man2/fanotify_mark.2
> @@ -126,6 +126,13 @@ is not itself a mount point, the mount point containing
>  will be marked.
>  All directories, subdirectories, and the contained files of the mount point
>  will be monitored.
> +This value cannot be used if the
> +.I fanotify_fd
> +file descriptor has been initialized with the flag
> +.BR FAN_REPORT_FID .
> +Attempting to do so will result in the error
> +.B EINVAL
> +being returned.
>  .TP
>  .BR FAN_MARK_FILESYSTEM " (since Linux 4.20)"
>  .\" commit d54f4fba889b205e9cd8239182ca5d27d0ac3bc2
> @@ -171,6 +178,28 @@ Create an event when a file or directory is opened.
>  Create an event when a file is opened with the intent to be executed.
>  See NOTES for additional details.
>  .TP
> +.B FAN_ATTRIB
> +Create an event when the metadata for a file or directory has changed.
> +.TP
> +.B FAN_CREATE
> +Create an event when a file or directory has been created in a marked
> +parent directory.
> +.TP
> +.B FAN_DELETE
> +Create an event when a file or directory has been deleted in a marked
> +parent directory.
> +.TP
> +.B FAN_DELETE_SELF
> +Create an event when a marked file or directory itself is deleted.
> +.TP
> +.B FAN_MOVED_FROM
> +Create an event when a file or directory has been moved from a marked
> +parent directory.
> +.TP
> +.B FAN_MOVED_TO
> +Create an event when a file or directory has been moved to a marked parent
> +directory.
> +.TP
>  .B FAN_Q_OVERFLOW
>  Create an event when an overflow of the event queue occurs.
>  The size of the event queue is limited to 16384 entries if
> @@ -205,13 +234,33 @@ or
>  is required.
>  .TP
>  .B FAN_ONDIR
> -Create events for directories\(emfor example, when
> +Create events for directories \(em for example, when
>  .BR opendir (3),
>  .BR readdir (3)
>  (but see BUGS), and
>  .BR closedir (3)
>  are called.
>  Without this flag, only events for files are created.
> +The
> +.BR FAN_ONDIR
> +flag is reported in an event mask only if the
> +.I fanotify_fd
> +file descriptor has been initialized with the flag
> +.BR FAN_REPORT_FID .
> +In the context of directory entry events, such as
> +.BR FAN_CREATE ,
> +.BR FAN_DELETE ,
> +.BR FAN_MOVED_FROM
> +and
> +.BR FAN_MOVED_TO
> +for example, specifying the flag
> +.BR FAN_ONDIR
> +is required in order to create events when subdirectory entries are
> +modified (i.e. mkdir/rmdir).
> +Subdirectory entry modification events will never be merged with non
> +subdirectory entry modification events.
> +This flag is never reported individually within an event and is always
> +supplied in conjunction with another event type.
>  .TP
>  .B FAN_EVENT_ON_CHILD
>  Events for the immediate children of marked directories shall be created.
> @@ -221,11 +270,15 @@ of marked directories.
>  To monitor complete directory trees it is necessary to mark the relevant
>  mount.
>  .PP
> -The following composed value is defined:
> +The following composed values are defined:
>  .TP
>  .B FAN_CLOSE
>  A file is closed
>  .RB ( FAN_CLOSE_WRITE | FAN_CLOSE_NOWRITE ).
> +.TP
> +.B FAN_MOVE
> +A file or directory has been moved
> +.RB ( FAN_MOVED_FROM | FAN_MOVED_TO ).
>  .PP
>  The filesystem object to be marked is determined by the file descriptor
>  .I dirfd
> @@ -297,6 +350,8 @@ was not an fanotify file descriptor.
>  .B EINVAL
>  The fanotify file descriptor was opened with
>  .B FAN_CLASS_NOTIF
> +or
> +.B FAN_REPORT_FID
>  and mask contains a flag for permission events
>  .RB ( FAN_OPEN_PERM
>  or
> @@ -335,6 +390,41 @@ and
>  and
>  .I pathname
>  do not specify a directory.
> +.TP
> +.B EXDEV
> +The object indicated by
> +.I pathname
> +resides within a filesystem subvolume (e.g. btrfs) which uses a different
> +.I fsid
> +than its root superblock.
> +This error can only be returned when an fanotify file descriptor returned
> +by
> +.BR fanotify_init (2)
> +has been created with
> +.BR FAN_REPORT_FID .
> +.TP
> +.B ENODEV
> +The object indicated by
> +.I pathname
> +is not associated with a filesystem that supports
> +.I fsid
> +(e.g. tmpfs).
> +This error can only be returned when an fanotify file descriptor returned
> +by
> +.BR fanotify_init (2)
> +has been created with
> +.BR FAN_REPORT_FID .
> +.TP
> +.B EOPNOTSUPP
> +The object indicated by
> +.I pathname
> +is associated with a filesystem that does not support the encoding of file
> +handles.
> +This error can only be returned when an fanotify file descriptor returned
> +by
> +.BR fanotify_init (2)
> +has been created with
> +.BR FAN_REPORT_FID .
>  .SH VERSIONS
>  .BR fanotify_mark ()
>  was introduced in version 2.6.36 of the Linux kernel and enabled in version
> diff --git a/man7/fanotify.7 b/man7/fanotify.7
> index 7424606..788f23f 100644
> --- a/man7/fanotify.7
> +++ b/man7/fanotify.7
> @@ -112,8 +112,12 @@ events and
>  events.
>  Notification events are merely informative
>  and require no action to be taken by
> -the receiving application except for closing the file descriptor passed
> -in the event (see below).
> +the receiving application with the exception being that the file
> +descriptor provided within a generic event must be closed.
> +The closing of file descriptors for each event only applies to
> +applications that have initialized fanotify without using
> +.BR FAN_REPORT_FID
> +(see below).
>  Permission events are requests to the receiving application to decide
>  whether permission for a file access shall be granted.
>  For these events, the recipient must write a response which decides whether
> @@ -138,6 +142,12 @@ until either a file event occurs or the call is interrupted by a signal
>  (see
>  .BR signal (7)).
>  .PP
> +Depending on whether
> +.BR FAN_REPORT_FID
> +is supplied as one of the flags when calling
> +.BR fanotify_init (2)
> +determines what structure(s) are returned for an event within the read
> +buffer.
>  After a successful
>  .BR read (2),
>  the read buffer contains one or more of the following structures:
> @@ -156,6 +166,25 @@ struct fanotify_event_metadata {
>  .EE
>  .in
>  .PP
> +In the instance that
> +.BR FAN_REPORT_FID
> +is supplied as one of the flags to
> +.BR fanotify_init (2),
> +you should also expect to receive the structure detailed below following
> +the generic
> +.I fanotify_event_metadata
> +structure within the read buffer:
> +.PP
> +.in +4n
> +.EX
> +struct fanotify_event_info_fid {
> +    struct fanotify_event_info_header hdr;
> +    __kernel_fsid_t fsid;
> +    unsigned char file_handle[0];
> +};
> +.EE
> +.in
> +.PP
>  For performance reasons, it is recommended to use a large
>  buffer size (for example, 4096 bytes),
>  so that multiple events can be retrieved by a single
> @@ -173,12 +202,16 @@ structure are as follows:
>  .I event_len
>  This is the length of the data for the current event and the offset
>  to the next event in the buffer.
> -In the current implementation, the value of
> +Without
> +.BR FAN_REPORT_FID ,
> +the value of
>  .I event_len
>  is always
>  .BR FAN_EVENT_METADATA_LEN .
> -However, the API is designed to allow
> -variable-length structures to be returned in the future.
> +With
> +.BR FAN_REPORT_FID ,
> +.I event_len
> +also includes the variable length file identifier.
>  .TP
>  .I vers
>  This field holds a version number for the structure.
> @@ -205,6 +238,11 @@ This is a bit mask describing the event (see below).
>  This is an open file descriptor for the object being accessed, or
>  .B FAN_NOFD
>  if a queue overflow occurred.
> +If the fanotify file descriptor has been initialized using
> +.BR FAN_REPORT_FID ,
> +applications should expect this value to be set to
> +.B FAN_NOFD
> +for each event that is received.
>  The file descriptor can be used to access the contents
>  of the monitored file or directory.
>  The reading application is responsible for closing this file descriptor.
> @@ -262,6 +300,27 @@ See NOTES in
>  .BR fanotify_mark (2)
>  for additional details.
>  .TP
> +.B FAN_ATTRIB
> +A file or directory metadata was changed.
> +.TP
> +.B FAN_CREATE
> +A child file or directory was created in a watched parent.
> +.TP
> +.B FAN_DELETE
> +A child file or directory was deleted in a watched parent.
> +.TP
> +.B FAN_DELETE_SELF
> +A watched file or directory was deleted.
> +.TP
> +.B FAN_MOVED_FROM
> +A file or directory has been moved from a watched parent directory.
> +.TP
> +.B FAN_MOVED_TO
> +A file or directory has been moved to a watched parent directory.
> +.TP
> +.B FAN_MOVE_SELF
> +A watched file or directory was moved.
> +.TP
>  .B FAN_MODIFY
>  A file was modified.
>  .TP
> @@ -314,6 +373,76 @@ This is a synonym for:
>  .IP
>      FAN_CLOSE_WRITE | FAN_CLOSE_NOWRITE
>  .PP
> +To check for any move event, the following bit mask may be used:
> +.TP
> +.B FAN_MOVE
> +A file or directory was moved.
> +This is a synonym for:
> +.IP
> +    FAN_MOVED_FROM | FAN_MOVED_TO
> +.PP
> +The fields of the
> +.I fanotify_event_info_fid
> +structure are as follows:
> +.TP
> +.I hdr
> +This is a structure of type
> +.IR fanotify_event_info_header .
> +It is a generic header that contains information used to describe
> +additional information attached to the event.
> +For example, when an fanotify file descriptor is created using
> +.B FAN_REPORT_FID
> +the
> +.I info_type
> +field of this header is set to
> +.BR FAN_EVENT_INFO_TYPE_FID .
> +Event listeners can use this field to check that the additional
> +information received for an event is of the correct type.
> +Additionally, the
> +.I fanotify_event_info_header
> +also contains a
> +.I len
> +field.
> +In the current implementation, the value of
> +.I len
> +is always (event_len - FAN_EVENT_METADATA_LEN).
> +.TP
> +.I fsid
> +This is a unique identifier of the filesystem containing the object
> +associated with the event.
> +It is a structure of type
> +.I __kernel_fsid_t
> +and contains the same value as
> +.I f_fsid
> +when calling
> +.BR statfs (2).
> +.TP
> +.I file_handle
> +This is a variable length structure of type
> +.IR file_handle .
> +It is an opaque handle that corresponds to a specified object on a
> +filesystem as returned by
> +.BR name_to_handle_at (2) .
> +It can be used to uniquely identify a file on a filesystem and can be
> +passed as an argument to
> +.BR open_by_handle_at (2) .
> +Note that for directory entry events, such as
> +.BR FAN_CREATE ,
> +.BR FAN_DELETE ,
> +.BR FAN_MOVE
> +the
> +.IR file_handle
> +describes the modified directory and not the created/deleted/moved child
> +object.
> +The events
> +.BR FAN_ATTRIB ,
> +.BR FAN_DELETE_SELF
> +and
> +.BR FAN_MOVE_SELF
> +will carry the
> +.IR file_handle
> +information for the child object if the child object is being watched.
> +.PP
>  The following macros are provided to iterate over a buffer containing
>  fanotify event metadata returned by a
>  .BR read (2)
> @@ -549,9 +678,12 @@ The return value will not be \-1, and
>  will not be set.
>  Thus, the reading application has no way to detect the error.
>  .SH EXAMPLE
> -The following program demonstrates the usage of the fanotify API.
> -It marks the mount point passed as a command-line argument
> -and waits for events of type
> +The two example programs below demonstrate the usage of the fanotify API.
> +The first program (fanotify_example.c) is an example of fanotify being
> +used with its event object information passed in the form of a file
> +descriptor.
> +It marks the mount point passed as a command-line argument and waits for
> +events of type
>  .B FAN_OPEN_PERM
>  and
>  .BR FAN_CLOSE_WRITE .
> @@ -559,7 +691,21 @@ When a permission event occurs, a
>  .B FAN_ALLOW
>  response is given.
>  .PP
> -The following output was recorded while editing the file
> +The second program (fanotify_fid.c) is an example of fanotify being used
> +with
> +.B FAN_REPORT_FID
> +enabled.
> +It attempts to mark the object that is passed as a command-line argument
> +and waits until an event of type
> +.B FAN_CREATE
> +has occurred.
> +Depending on whether a file or directory is created depends on what mask
> +is returned in the event mask.
> +Once all events have been read from the buffer and processed accordingly,
> +the program simply terminates.
> +.PP
> +The first example program output was captured from fanotify_example.
> +This session involved editing the file
>  .IR /home/user/temp/notes .
>  Before the file was opened, a
>  .B FAN_OPEN_PERM
> @@ -568,7 +714,34 @@ After the file was closed, a
>  .B FAN_CLOSE_WRITE
>  event occurred.
>  Execution of the program ends when the user presses the ENTER key.
> -.SS Example output
> +.PP
> +The second example program output was captured from fanotify_fid.
> +There are two discrete invocations to this program with each invocation
> +accommodating a different action performed on a watched object.
> +This first session shows a mark being placed on
> +.IR /home/user .
> +This is followed by a subsequent regular file
> +.IR /home/user/testfile.txt
> +being created.
> +This results in a
> +.B FAN_CREATE
> +event being created and reported against the file's parent watched
> +directory object.
> +Program execution ends once all events captured within the buffer have
> +been processed.
> +The second session shows a mark being placed on
> +.IR /home/user .
> +This is followed by a directory
> +.IR /home/user/testdir
> +being created.
> +This specific action results in the program producing a
> +.B FAN_CREATE
> +and
> +.B FAN_ONDIR
> +event.
> +Program execution ends once all events captured within the buffer are
> +processed.
> +.SS Example output (fanotify_example.c)
>  .in +4n
>  .EX
>  # ./fanotify_example /home
> @@ -579,8 +752,27 @@ FAN_CLOSE_WRITE: File /home/user/temp/notes
>  
>  Listening for events stopped.
>  .EE
> +.SS Example output (fanotify_fid.c)
> +.in +4n
> +.EX
> +# ./fanotify_fid /home/user
> +Listening for events.
> +FAN_CREATE (file created): Directory /home/user has been modified.
> +All events processed successfully. Program exiting.
> +
> +$ touch /home/user/testing
> +
> +---
> +
> +# ./fanotify_fid /home/user
> +Listening for events.
> +FAN_CREATE | FAN_ONDIR (subdirectory created): Directory /home/user has been modified.
> +All events processed successfully. Program exiting.
> +
> +$ mkdir -p /home/user/testing
> +.EE
>  .in
> -.SS Program source
> +.SS Program source: fanotify_example.c
>  \&
>  .EX
>  #define _GNU_SOURCE     /* Needed to get O_LARGEFILE definition */
> @@ -778,6 +970,123 @@ main(int argc, char *argv[])
>      exit(EXIT_SUCCESS);
>  }
>  .EE
> +.in
> +.SS Program source: fanotify_fid.c
> +\&
> +.EX
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/fanotify.h>
> +#include <unistd.h>
> +
> +#define BUF_SIZE 256
> +
> +int main(int argc, char **argv)
> +{
> +    int fd, ret, event_fd;
> +    ssize_t len, path_len;
> +    char path[PATH_MAX];
> +    char procfd_path[PATH_MAX];
> +    char events_buf[BUF_SIZE];
> +
> +    struct file_handle *file_handle;
> +    struct fanotify_event_metadata *metadata;
> +    struct fanotify_event_info_fid *fid;
> +
> +    if (argc != 2) {
> +        fprintf(stderr, "Invalid number of command line arguments.\\n");
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    /* Create an fanotify file descriptor with FAN_REPORT_FID as a flag
> +     * so that program can receive fid events.
> +     */
> +    fd = fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_FID, 0);
> +    if (fd == -1) {
> +        perror("fanotify_init");
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    /* Place a mark on the filesystem object supplied in argv[1]. */
> +    ret = fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_ONLYDIR,
> +                        FAN_CREATE | FAN_ONDIR,
> +                        AT_FDCWD, argv[1]);
> +    if (ret == -1) {
> +        perror("fanotify_mark");
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    printf("Listening for events.\\n");
> +
> +    /* Read events from the event queue into a buffer */
> +    len = read(fd, (void *) &events_buf, sizeof(events_buf));
> +    if (len == -1 && errno != EAGAIN) {
> +        perror("read");
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    /* Process all events within the buffer */
> +    for (metadata = (struct fanotify_event_metadata *) events_buf;
> +            FAN_EVENT_OK(metadata, len);
> +            metadata = FAN_EVENT_NEXT(metadata, len)) {
> +        fid = (struct fanotify_event_info_fid *) (metadata + 1);
> +        file_handle = (struct file_handle *) fid->handle;
> +
> +        /* Ensure that the event info is of the correct type */
> +        if (fid->hdr.info_type != FAN_EVENT_INFO_TYPE_FID) {
> +            fprintf(stderr, "Received unexpected event info type.\\n");
> +            exit(EXIT_FAILURE);
> +        }
> +
> +        if (metadata->mask == FAN_CREATE)
> +            printf("FAN_CREATE (file created): ");
> +
> +        if (metadata->mask == FAN_CREATE | FAN_ONDIR)
> +            printf("FAN_CREATE | FAN_ONDIR (subdirectory created): ");
> +
> +        /* metadata->fd is set to FAN_NOFD when FAN_REPORT_FID is enabled.
> +         * To obtain a file descriptor for the file object corresponding to
> +         * an event you can use the struct file_handle that's provided
> +         * within the fanotify_event_info_fid in conjunction with the
> +         * open_by_handle_at(2) system call. A check for -ESTALE is done
> +         * to accommodate for the situation where the file handle was
> +         * deleted for the object prior to this system call.
> +         */
> +        event_fd = open_by_handle_at(AT_FDCWD, file_handle, O_RDONLY);
> +        if (ret == -1 && errno == ESTALE) {
> +            printf("File handle is no longer valid. File has been deleted\\n");
> +            continue;
> +        } else if (ret == -1) {
> +            perror("open_by_handle_at");
> +            exit(EXIT_FAILURE);
> +        }
> +
> +        snprintf(procfd_path, sizeof(procfd_path), "/proc/self/fd/%d", event_fd);
> +
> +        /* Retreive and print the path of the modified dentry */
> +        path_len = readlink(procfd_path, path, sizeof(path) - 1);
> +        if (path_len == -1) {
> +            perror("readlink");
> +            exit(EXIT_FAILURE);
> +        }
> +
> +        path[path_len] = '\\0';
> +        printf("Directory '%s' has been modified.\\n", path);
> +
> +        /* Close associated file descriptor for this event */
> +        close(event_fd);
> +    }
> +
> +    printf("All events processed successfully. Program exiting.\\n");
> +    exit(EXIT_SUCCESS);
> +}
> +.EE
>  .SH SEE ALSO
>  .ad l
>  .BR fanotify_init (2),
> -- 
> 1.8.3.1

-- 
Matthew Bobrowski
