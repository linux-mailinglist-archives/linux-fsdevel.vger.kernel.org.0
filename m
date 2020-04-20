Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B241B0D52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 15:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgDTNsp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 09:48:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47188 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbgDTNsl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587390519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g7y4WU1T9l13UE4AeSAMeV0dvLVDo/1wJoF790VrkXE=;
        b=CBx2eny9VN87eTE86q/KkLEySJcKM5lP+rZ2o08ouGUxbwEsZOYQPgxyu3rAY7ZNAFaQeN
        p72BaerRDD3q8naklJaki9bR3wXMbhTp8c5PMT2IsUIGKfz705DgAxUwmeHjkMaOChgYmj
        bHxgAgvh6GN7R0Tl58nIJCsFqQ8Gu2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-N9UYrC5qPM-27Q4o2iNAMA-1; Mon, 20 Apr 2020 09:48:34 -0400
X-MC-Unique: N9UYrC5qPM-27Q4o2iNAMA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D87F190D343;
        Mon, 20 Apr 2020 13:48:33 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6011312656B;
        Mon, 20 Apr 2020 13:48:32 +0000 (UTC)
Subject: Re: [PATCH 2/2 V2] man2: New page documenting filesystem get/set
 label ioctls
To:     mtk.manpages@gmail.com, Eric Sandeen <sandeen@sandeen.net>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
References: <d2979d75-5e45-b145-9ca5-2c315d8ead9c@redhat.com>
 <708b8e2a-2bc2-df38-ec9c-c605203052b5@sandeen.net>
 <7d74cc3b-52cc-be60-0a69-1a5ee1499f47@sandeen.net>
 <CAKgNAkgLekaA6jBtUYTD2F=7u_GgBbXDvq-jc8RCBswYvvZmtg@mail.gmail.com>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <5ac17186-4463-4f61-4733-125f2af9b73d@redhat.com>
Date:   Mon, 20 Apr 2020 08:48:31 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgNAkgLekaA6jBtUYTD2F=7u_GgBbXDvq-jc8RCBswYvvZmtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/20/20 7:04 AM, Michael Kerrisk (man-pages) wrote:
> Hello Eric,
> 
> So it seems like this feature eventually got merged in Linux 4.18. Is
> this page up to date with what went into the kernel?

Yes, I believe that it's all still accurate.

Thanks,
-Eric

> Thanks,
> 
> Michael
> 
> On Thu, 10 May 2018 at 19:29, Eric Sandeen <sandeen@sandeen.net> wrote:
>>
>> This documents the proposed new vfs-level ioctls which can
>> get or set a mounted filesytem's label.
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>
>> V2: make primary file ioctl_getfslabel, link ioctl_setfslabel to it
>>     note that getfslabel requires CAP_SYS_ADMIN
>>
>> diff --git a/man2/ioctl_getfslabel.2 b/man2/ioctl_getfslabel.2
>> new file mode 100644
>> index 0000000..2c3375c
>> --- /dev/null
>> +++ b/man2/ioctl_getfslabel.2
>> @@ -0,0 +1,87 @@
>> +.\" Copyright (c) 2018, Red Hat, Inc.  All rights reserved.
>> +.\"
>> +.\" %%%LICENSE_START(GPLv2+_DOC_FULL)
>> +.\" This is free documentation; you can redistribute it and/or
>> +.\" modify it under the terms of the GNU General Public License as
>> +.\" published by the Free Software Foundation; either version 2 of
>> +.\" the License, or (at your option) any later version.
>> +.\"
>> +.\" The GNU General Public License's references to "object code"
>> +.\" and "executables" are to be interpreted as the output of any
>> +.\" document formatting or typesetting system, including
>> +.\" intermediate and printed output.
>> +.\"
>> +.\" This manual is distributed in the hope that it will be useful,
>> +.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +.\" GNU General Public License for more details.
>> +.\"
>> +.\" You should have received a copy of the GNU General Public
>> +.\" License along with this manual; if not, see
>> +.\" <http://www.gnu.org/licenses/>.
>> +.\" %%%LICENSE_END
>> +.TH IOCTL-FSLABEL 2 2018-05-02 "Linux" "Linux Programmer's Manual"
>> +.SH NAME
>> +ioctl_fslabel \- get or set a filesystem label
>> +.SH SYNOPSIS
>> +.br
>> +.B #include <sys/ioctl.h>
>> +.br
>> +.B #include <linux/fs.h>
>> +.sp
>> +.BI "int ioctl(int " fd ", FS_IOC_GETFSLABEL, char " label [FSLABEL_MAX]);
>> +.br
>> +.BI "int ioctl(int " fd ", FS_IOC_SETFSLABEL, char " label [FSLABEL_MAX]);
>> +.SH DESCRIPTION
>> +If a filesystem supports online label manipulation, these
>> +.BR ioctl (2)
>> +operations can be used to get or set the filesystem label for the filesystem
>> +on which
>> +.B fd
>> +resides.
>> +The
>> +.B FS_IOC_SETFSLABEL
>> +operation requires privilege
>> +.RB ( CAP_SYS_ADMIN ).
>> +.SH RETURN VALUE
>> +On success zero is returned.  On error, \-1 is returned, and
>> +.I errno
>> +is set to indicate the error.
>> +.PP
>> +.SH ERRORS
>> +Error codes can be one of, but are not limited to, the following:
>> +.TP
>> +.B EINVAL
>> +The specified label exceeds the maximum label length for the filesystem.
>> +.TP
>> +.B ENOTTY
>> +This can appear if the filesystem does not support online label manipulation.
>> +.TP
>> +.B EPERM
>> +The calling process does not have sufficient permissions to set the label.
>> +.TP
>> +.B EFAULT
>> +.I label
>> +references an inaccessible memory area.
>> +.SH VERSIONS
>> +These ioctl operations first appeared in Linux 4.18.
>> +They were previously known as
>> +.B BTRFS_IOC_GET_FSLABEL
>> +and
>> +.B BTRFS_IOC_SET_FSLABEL
>> +and were private to Btrfs.
>> +.SH CONFORMING TO
>> +This API is Linux-specific.
>> +.SH NOTES
>> +The maximum string length for this interface is
>> +.BR FSLABEL_MAX ,
>> +including the terminating null byte (\(aq\\0\(aq).
>> +Filesystems have differing maximum label lengths, which may or
>> +may not include the terminating null.  The string provided to
>> +.B FS_IOC_SETFSLABEL
>> +must always be null-terminated, and the string returned by
>> +.B FS_IOC_GETFSLABEL
>> +will always be null-terminated.
>> +.SH SEE ALSO
>> +.BR ioctl (2),
>> +.BR blkid (8)
>> diff --git a/man2/ioctl_setfslabel.2 b/man2/ioctl_setfslabel.2
>> new file mode 100644
>> index 0000000..2119835
>> --- /dev/null
>> +++ b/man2/ioctl_setfslabel.2
>> @@ -0,0 +1 @@
>> +.so man2/ioctl_getfslabel.2
>>
> 
> 

