Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6FE4F874
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2019 00:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfFVWLx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Jun 2019 18:11:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbfFVWLx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Jun 2019 18:11:53 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9FA320862;
        Sat, 22 Jun 2019 22:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561241511;
        bh=pWoXCpB1qxcWe85YQz2OZPYh2L7dHQZAU4vlFFwBHyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M/P6vgSdRCBAMVbjQGvKFCW1dEY9AZV09wQ53yTq0DU408NCkXFSAICQV6jn1+MTG
         fX0UFSeVoTMJO67DFqUgnyjLkmU2YZuH1bOoOyIBdiE+WDzG4OALjrPOL8YO/JCnct
         gcGg+0Aua0/NdNr7VBu6WeJliataKEavETqinIn0=
Date:   Sat, 22 Jun 2019 15:11:51 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 04/16] fs: uapi: define verity bit for FS_IOC_GETFLAGS
Message-ID: <20190622221151.GD19686@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190620205043.64350-1-ebiggers@kernel.org>
 <20190620205043.64350-5-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620205043.64350-5-ebiggers@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/20, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add FS_VERITY_FL to the flags for FS_IOC_GETFLAGS, so that applications
> can easily determine whether a file is a verity file at the same time as
> they're checking other file flags.  This flag will be gettable only;
> FS_IOC_SETFLAGS won't allow setting it, since an ioctl must be used
> instead to provide more parameters.
> 
> This flag matches the on-disk bit that was already allocated for ext4.
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>

Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>

> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  include/uapi/linux/fs.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 59c71fa8c553a3..df261b7e0587ed 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -306,6 +306,7 @@ struct fscrypt_key {
>  #define FS_TOPDIR_FL			0x00020000 /* Top of directory hierarchies*/
>  #define FS_HUGE_FILE_FL			0x00040000 /* Reserved for ext4 */
>  #define FS_EXTENT_FL			0x00080000 /* Extents */
> +#define FS_VERITY_FL			0x00100000 /* Verity protected inode */
>  #define FS_EA_INODE_FL			0x00200000 /* Inode used for large EA */
>  #define FS_EOFBLOCKS_FL			0x00400000 /* Reserved for ext4 */
>  #define FS_NOCOW_FL			0x00800000 /* Do not cow file */
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
