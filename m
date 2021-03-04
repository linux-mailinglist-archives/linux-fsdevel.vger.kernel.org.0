Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BF232D870
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 18:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239171AbhCDRPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 12:15:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:36886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239072AbhCDROb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:14:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 960E464F1E;
        Thu,  4 Mar 2021 17:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614878030;
        bh=lqO7UkOMXWWQHikCfDTDyGiTWusKSlro4VEZN21pRgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c7RhJ2hkF22/QR6Ws+Ygt5m539P7TU2r4XRQOb1j2WGhUQwtrop0RLw0uZ+MemZzU
         hqmLenKN93+rdtIUoh0Fexx5dW7WA9hjA149SdKqlDG714eINwMfIAacaBtKIPNrCO
         oPQcTLzT77A4g8h4dFkceukCFmK6HQt644bGSVLv6v1SEsYKakk60fXnpjHJJcWsOD
         67oPOglMCgjQbzitpIhyT0NGM9vzd9Fd2IdZvQbZHSiTcYiaexbIBXyfSvFoObOm1Z
         I2afWFBzXpFOqxhrtSiwJ5I4YY8CDrJTGEMxNUL+2Sy61o7bLMURkAx1jpnQg4oAkY
         LmWjhrD0TModA==
Date:   Thu, 4 Mar 2021 09:13:50 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Luis Henriques <lhenriques@suse.de>,
        Steve French <sfrench@samba.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Olga Kornievskaia <aglo@umich.edu>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Walter Harms <wharms@bfs.de>
Subject: Re: [RFC v4] copy_file_range.2: Update cross-filesystem support for
 5.12
Message-ID: <20210304171350.GC7267@magnolia>
References: <20210224142307.7284-1-lhenriques@suse.de>
 <20210304093806.10589-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304093806.10589-1-alx.manpages@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 04, 2021 at 10:38:07AM +0100, Alejandro Colomar wrote:
> Linux 5.12 fixes a regression.
> 
> Cross-filesystem (introduced in 5.3) copies were buggy.
> 
> Move the statements documenting cross-fs to BUGS.
> Kernels 5.3..5.11 should be patched soon.
> 
> State version information for some errors related to this.
> 
> Reported-by: Luis Henriques <lhenriques@suse.de>
> Reported-by: Amir Goldstein <amir73il@gmail.com>
> Related: <https://lwn.net/Articles/846403/>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: Anna Schumaker <anna.schumaker@netapp.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Steve French <sfrench@samba.org>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> Cc: Dave Chinner <dchinner@redhat.com>
> Cc: Nicolas Boichat <drinkcat@chromium.org>
> Cc: Ian Lance Taylor <iant@google.com>
> Cc: Luis Lozano <llozano@chromium.org>
> Cc: Andreas Dilger <adilger@dilger.ca>
> Cc: Olga Kornievskaia <aglo@umich.edu>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: ceph-devel <ceph-devel@vger.kernel.org>
> Cc: linux-kernel <linux-kernel@vger.kernel.org>
> Cc: CIFS <linux-cifs@vger.kernel.org>
> Cc: samba-technical <samba-technical@lists.samba.org>
> Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
> Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
> Cc: Walter Harms <wharms@bfs.de>
> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
> ---
> 
> v3:
>         - Don't remove some important text.
>         - Reword BUGS.
> v4:
> 	- Reword.
> 	- Link to BUGS.
> 
> Thanks, Amir, for all the help and better wordings.
> 
> Cheers,
> 
> Alex
> 
> ---
>  man2/copy_file_range.2 | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/man2/copy_file_range.2 b/man2/copy_file_range.2
> index 611a39b80..f58bfea8f 100644
> --- a/man2/copy_file_range.2
> +++ b/man2/copy_file_range.2
> @@ -169,6 +169,9 @@ Out of memory.
>  .B ENOSPC
>  There is not enough space on the target filesystem to complete the copy.
>  .TP
> +.BR EOPNOTSUPP " (since Linux 5.12)"
> +The filesystem does not support this operation.
> +.TP
>  .B EOVERFLOW
>  The requested source or destination range is too large to represent in the
>  specified data types.
> @@ -184,10 +187,17 @@ or
>  .I fd_out
>  refers to an active swap file.
>  .TP
> -.B EXDEV
> +.BR EXDEV " (before Linux 5.3)"
> +The files referred to by
> +.IR fd_in " and " fd_out
> +are not on the same filesystem.
> +.TP
> +.BR EXDEV " (since Linux 5.12)"
>  The files referred to by
>  .IR fd_in " and " fd_out
> -are not on the same mounted filesystem (pre Linux 5.3).
> +are not on the same filesystem,
> +and the source and target filesystems are not of the same type,
> +or do not support cross-filesystem copy.
>  .SH VERSIONS
>  The
>  .BR copy_file_range ()
> @@ -200,8 +210,11 @@ Areas of the API that weren't clearly defined were clarified and the API bounds
>  are much more strictly checked than on earlier kernels.
>  Applications should target the behaviour and requirements of 5.3 kernels.
>  .PP
> -First support for cross-filesystem copies was introduced in Linux 5.3.
> -Older kernels will return -EXDEV when cross-filesystem copies are attempted.
> +Since Linux 5.12,
> +cross-filesystem copies can be achieved
> +when both filesystems are of the same type,
> +and that filesystem implements support for it.
> +See BUGS for behavior prior to 5.12.
>  .SH CONFORMING TO
>  The
>  .BR copy_file_range ()
> @@ -226,6 +239,12 @@ gives filesystems an opportunity to implement "copy acceleration" techniques,
>  such as the use of reflinks (i.e., two or more inodes that share
>  pointers to the same copy-on-write disk blocks)
>  or server-side-copy (in the case of NFS).
> +.SH BUGS
> +In Linux kernels 5.3 to 5.11,
> +cross-filesystem copies were implemented by the kernel,
> +if the operation was not supported by individual filesystems.
> +However, on some virtual filesystems,
> +the call failed to copy, while still reporting success.

...success, or merely a short copy?

(The rest looks reasonable (at least by c_f_r standards) to me.)

--D

>  .SH EXAMPLES
>  .EX
>  #define _GNU_SOURCE
> -- 
> 2.30.1.721.g45526154a5
> 
