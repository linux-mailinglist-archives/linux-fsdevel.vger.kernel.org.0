Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22FEE2CC91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 18:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfE1QtU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 12:49:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59336 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfE1QtT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 12:49:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SGYHcM171535;
        Tue, 28 May 2019 16:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=g4VMDHaVzIXfUD9TtJzd+T5I/JvgEaOHGIOgnX9Fmu0=;
 b=GAFTOwcWopfNekUkc0Bw4cTBT9M1rV+KgJ/fPx2JxTmuz/zEIRnfMR6oZP7JOfdQjjYv
 PR0KNCiNF6dSZ0im2y6M1Qly8ETuyrIz3WGL0MdGwaVeZvBomsWqow6m3/EgTq5NtOgi
 GRMr0M/a3YuCDiLCEq93JqrouXgHF71Wd8sSvbC9h7QIo9D9rgg69AcPPhUs+LhtJqmg
 Azb5QVKYVANdY/hNSMuJCGSW68QrTjFKcOUUfBXGb/DvqWsxqRKbkmxd1B/w7DPJSRxU
 nKli/lSOb1+Vs1Bh7gUu8c0pFJ4m+LnMj0FO1le/4+MIIYLCRBUCq41Mp2+PYFH7GAyv Iw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2spw4tcj5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 16:48:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SGlnT3182373;
        Tue, 28 May 2019 16:48:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2srbdwwcuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 16:48:47 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4SGmkG3021980;
        Tue, 28 May 2019 16:48:46 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 May 2019 09:48:46 -0700
Date:   Tue, 28 May 2019 09:48:44 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-api@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v2 9/8] man-pages: copy_file_range updates
Message-ID: <20190528164844.GJ5221@magnolia>
References: <20190526061100.21761-1-amir73il@gmail.com>
 <20190526061100.21761-10-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526061100.21761-10-amir73il@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905280106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280106
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 26, 2019 at 09:11:00AM +0300, Amir Goldstein wrote:
> Update with all the missing errors the syscall can return, the
> behaviour the syscall should have w.r.t. to copies within single
> files, etc.
> 
> [Amir] Copying beyond EOF returns zero.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  man2/copy_file_range.2 | 93 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 77 insertions(+), 16 deletions(-)
> 
> diff --git a/man2/copy_file_range.2 b/man2/copy_file_range.2
> index 2438b63c8..fab11f977 100644
> --- a/man2/copy_file_range.2
> +++ b/man2/copy_file_range.2
> @@ -42,9 +42,9 @@ without the additional cost of transferring data from the kernel to user space
>  and then back into the kernel.
>  It copies up to
>  .I len
> -bytes of data from file descriptor
> +bytes of data from the source file descriptor
>  .I fd_in
> -to file descriptor
> +to target file descriptor

"to the target file descriptor"

>  .IR fd_out ,
>  overwriting any data that exists within the requested range of the target file.
>  .PP
> @@ -74,6 +74,11 @@ is not changed, but
>  .I off_in
>  is adjusted appropriately.
>  .PP
> +.I fd_in
> +and
> +.I fd_out
> +can refer to the same file. If they refer to the same file, then the source and
> +target ranges are not allowed to overlap.

Please start each sentence on a new line, per mkerrisk rules.

>  .PP
>  The
>  .I flags
> @@ -84,6 +89,11 @@ Upon successful completion,
>  .BR copy_file_range ()
>  will return the number of bytes copied between files.
>  This could be less than the length originally requested.
> +If the file offset of
> +.I fd_in
> +is at or past the end of file, no bytes are copied, and
> +.BR copy_file_range ()
> +returns zero.
>  .PP
>  On error,
>  .BR copy_file_range ()
> @@ -93,12 +103,16 @@ is set to indicate the error.
>  .SH ERRORS
>  .TP
>  .B EBADF
> -One or more file descriptors are not valid; or
> +One or more file descriptors are not valid.
> +.TP
> +.B EBADF
>  .I fd_in
>  is not open for reading; or
>  .I fd_out
> -is not open for writing; or
> -the
> +is not open for writing.
> +.TP
> +.B EBADF
> +The
>  .B O_APPEND
>  flag is set for the open file description (see
>  .BR open (2))
> @@ -106,17 +120,36 @@ referred to by the file descriptor
>  .IR fd_out .
>  .TP
>  .B EFBIG
> -An attempt was made to write a file that exceeds the implementation-defined
> -maximum file size or the process's file size limit,
> -or to write at a position past the maximum allowed offset.
> +An attempt was made to write at a position past the maximum file offset the
> +kernel supports.
> +.TP
> +.B EFBIG
> +An attempt was made to write a range that exceeds the allowed maximum file size.
> +The maximum file size differs between filesystem implemenations and can be

"implementations"

> +different to the maximum allowed file offset.

"...different from the maximum..."

> +.TP
> +.B EFBIG
> +An attempt was made to write beyond the process's file size resource
> +limit. This may also result in the process receiving a
> +.I SIGXFSZ
> +signal.

Start new sentences on a new line, please.

>  .TP
>  .B EINVAL
> -Requested range extends beyond the end of the source file; or the
> +The
>  .I flags
>  argument is not 0.
>  .TP
> -.B EIO
> -A low-level I/O error occurred while copying.
> +.B EINVAL
> +.I fd_in
> +and
> +.I fd_out
> +refer to the same file and the source and target ranges overlap.
> +.TP
> +.B EINVAL
> +.I fd_in
> +or
> +.I fd_out
> +is not a regular file.

Adding the word "either" at the beginning of the sentence (e.g.  "Either
fd_in or fd_out is not a regular file.") would help this flow better.

>  .TP
>  .B EISDIR
>  .I fd_in
> @@ -124,22 +157,50 @@ or
>  .I fd_out
>  refers to a directory.
>  .TP
> +.B EOVERFLOW
> +The requested source or destination range is too large to represent in the
> +specified data types.
> +.TP
> +.B EIO
> +A low-level I/O error occurred while copying.
> +.TP
>  .B ENOMEM
>  Out of memory.
>  .TP
> -.B ENOSPC
> -There is not enough space on the target filesystem to complete the copy.
> -.TP
>  .B EXDEV
>  The files referred to by
>  .IR file_in " and " file_out
> -are not on the same mounted filesystem.
> +are not on the same mounted filesystem (pre Linux 5.3).
> +.TP
> +.B ENOSPC
> +There is not enough space on the target filesystem to complete the copy.

Why move this?

> +.TP
> +.B TXTBSY
> +.I fd_in
> +or
> +.I fd_out
> +refers to an active swap file.

"Either fd_in or fd_out refers to..."

> +.TP
> +.B EPERM
> +.I fd_out
> +refers to an immutable file.
> +.TP
> +.B EACCES
> +The user does not have write permissions for the destination file.
>  .SH VERSIONS
>  The
>  .BR copy_file_range ()
>  system call first appeared in Linux 4.5, but glibc 2.27 provides a user-space
>  emulation when it is not available.
>  .\" https://sourceware.org/git/?p=glibc.git;a=commit;f=posix/unistd.h;h=bad7a0c81f501fbbcc79af9eaa4b8254441c4a1f
> +.PP
> +A major rework of the kernel implementation occurred in 5.3. Areas of the API
> +that weren't clearly defined were clarified and the API bounds are much more
> +strictly checked than on earlier kernels. Applications should target the
> +behaviour and requirements of 5.3 kernels.

Are there any weird cases where a program targetting 5.3 behavior would
fail or get stuck in an infinite loop on a 5.2 kernel?

Particularly since glibc spat out a copy_file_range fallback for 2.29
that tries to emulate the kernel behavior 100%.  It even refuses
cross-filesystem copies (because hey, we documented that :() even though
that's perfectly fine for a userspace implementation.

TBH I suspect that we ought to get the glibc developers to remove the
"no cross device copies" code from their implementation and then update
the manpage to say that cross device copies are supposed to be
supported all the time, at least as of glibc 2.(futureversion).

Anyways, thanks for taking on the c_f_r cleanup! :)

--D

> +.PP
> +First support for cross-filesystem copies was introduced in Linux 5.3. Older
> +kernels will return -EXDEV when cross-filesystem copies are attempted.
>  .SH CONFORMING TO
>  The
>  .BR copy_file_range ()
> @@ -224,7 +285,7 @@ main(int argc, char **argv)
>          }
>  
>          len \-= ret;
> -    } while (len > 0);
> +    } while (len > 0 && ret > 0);
>  
>      close(fd_in);
>      close(fd_out);
> -- 
> 2.17.1
> 
