Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 022184F869
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2019 00:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfFVWLV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Jun 2019 18:11:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbfFVWLV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Jun 2019 18:11:21 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7079920862;
        Sat, 22 Jun 2019 22:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561241480;
        bh=RhKMeMVHiPEptXFqpCXa+Yxdifzh7xBgyuqv4J4b2G8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZNHle0+nFQ+YABTJ0EewWqhzFIEDrQQKGgPyTa437VxsZ+ev7Dt2lfyeOnTevuxOF
         cLcxNoYSUcYErop9bvz47E/Fw8+RQ4ofp/zxefRR0BIaOLQBgl9ojhF4kG4BVbq3sJ
         xL5b3zqMTXnSziOcuWCjE8m71PvNr+31Y/aVGvzc=
Date:   Sat, 22 Jun 2019 15:11:19 -0700
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
Subject: Re: [PATCH v5 02/16] fs-verity: add MAINTAINERS file entry
Message-ID: <20190622221119.GB19686@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190620205043.64350-1-ebiggers@kernel.org>
 <20190620205043.64350-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620205043.64350-3-ebiggers@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/20, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> fs-verity will be jointly maintained by Eric Biggers and Theodore Ts'o.
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>

Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>

> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6954776a37e70..655065116f9228 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6505,6 +6505,18 @@ S:	Maintained
>  F:	fs/notify/
>  F:	include/linux/fsnotify*.h
>  
> +FSVERITY: READ-ONLY FILE-BASED AUTHENTICITY PROTECTION
> +M:	Eric Biggers <ebiggers@kernel.org>
> +M:	Theodore Y. Ts'o <tytso@mit.edu>
> +L:	linux-fscrypt@vger.kernel.org
> +Q:	https://patchwork.kernel.org/project/linux-fscrypt/list/
> +T:	git git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git fsverity
> +S:	Supported
> +F:	fs/verity/
> +F:	include/linux/fsverity.h
> +F:	include/uapi/linux/fsverity.h
> +F:	Documentation/filesystems/fsverity.rst
> +
>  FUJITSU LAPTOP EXTRAS
>  M:	Jonathan Woithe <jwoithe@just42.net>
>  L:	platform-driver-x86@vger.kernel.org
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
