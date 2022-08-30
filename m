Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1C25A6BDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 20:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiH3SM5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 14:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiH3SM4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:12:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC8398D22;
        Tue, 30 Aug 2022 11:12:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72B27B81D82;
        Tue, 30 Aug 2022 18:12:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D73C433C1;
        Tue, 30 Aug 2022 18:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661883172;
        bh=ixGvOAZh9pbWjDHPBaoYqgLLERvv5DHPj+SuBYJSABI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FADst2ftxXUddrz1Yh0jNy7qBJyiTuNUnq0e6Zk8s3pYauTgyExV5Wd/XpGMU/Bxj
         opKz+AQxYqv6Lrf4Njau7LLZjBlTAcLqXZX+vYEmtgJOaJ7VrDRoCcnZ0mEVMnqVpQ
         ODHRmPfaQEn8P5UznCx5ddt+BIhCEMdUo92L76MBj/nHwGOCwpQ0ggqqxRa4y59ghi
         rWZNdsEGNlRfchp2OIQVH60Y4wUFAZnEoG7hxtf0uQOEsKWsCGZpi8j5s3ZHlW4a4K
         x4qECwL1sI/Es9ODSK999Gp94BP1IMTyMKZFCzYVjaTy1kEdeHS3PToyLkzRhZU7Zj
         o6ZadaV7wTNTg==
Date:   Tue, 30 Aug 2022 11:12:50 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH] Documentation: filesystems: correct possessive "its"
Message-ID: <Yw5TIkHQ6lr+UlfD@google.com>
References: <20220829235429.17902-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829235429.17902-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/29, Randy Dunlap wrote:
> Change occurrences of "it's" that are possessive to "its"
> so that they don't read as "it is".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Cc: linux-xfs@vger.kernel.org
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Seth Forshee <sforshee@kernel.org>

For f2fs,

Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>

Thanks,

> ---
>  Documentation/filesystems/f2fs.rst                       |    2 +-
>  Documentation/filesystems/idmappings.rst                 |    2 +-
>  Documentation/filesystems/qnx6.rst                       |    2 +-
>  Documentation/filesystems/xfs-delayed-logging-design.rst |    6 +++---
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -287,7 +287,7 @@ compress_algorithm=%s:%d Control compres
>  			 lz4		3 - 16
>  			 zstd		1 - 22
>  compress_log_size=%u	 Support configuring compress cluster size, the size will
> -			 be 4KB * (1 << %u), 16KB is minimum size, also it's
> +			 be 4KB * (1 << %u), 16KB is minimum size, also its
>  			 default size.
>  compress_extension=%s	 Support adding specified extension, so that f2fs can enable
>  			 compression on those corresponding files, e.g. if all files
> --- a/Documentation/filesystems/idmappings.rst
> +++ b/Documentation/filesystems/idmappings.rst
> @@ -661,7 +661,7 @@ idmappings::
>   mount idmapping:      u0:k10000:r10000
>  
>  Assume a file owned by ``u1000`` is read from disk. The filesystem maps this id
> -to ``k21000`` according to it's idmapping. This is what is stored in the
> +to ``k21000`` according to its idmapping. This is what is stored in the
>  inode's ``i_uid`` and ``i_gid`` fields.
>  
>  When the caller queries the ownership of this file via ``stat()`` the kernel
> --- a/Documentation/filesystems/qnx6.rst
> +++ b/Documentation/filesystems/qnx6.rst
> @@ -176,7 +176,7 @@ Then userspace.
>  The requirement for a static, fixed preallocated system area comes from how
>  qnx6fs deals with writes.
>  
> -Each superblock got it's own half of the system area. So superblock #1
> +Each superblock got its own half of the system area. So superblock #1
>  always uses blocks from the lower half while superblock #2 just writes to
>  blocks represented by the upper half bitmap system area bits.
>  
> --- a/Documentation/filesystems/xfs-delayed-logging-design.rst
> +++ b/Documentation/filesystems/xfs-delayed-logging-design.rst
> @@ -551,14 +551,14 @@ Essentially, this shows that an item tha
>  and relogged, so any tracking must be separate to the AIL infrastructure. As
>  such, we cannot reuse the AIL list pointers for tracking committed items, nor
>  can we store state in any field that is protected by the AIL lock. Hence the
> -committed item tracking needs it's own locks, lists and state fields in the log
> +committed item tracking needs its own locks, lists and state fields in the log
>  item.
>  
>  Similar to the AIL, tracking of committed items is done through a new list
>  called the Committed Item List (CIL).  The list tracks log items that have been
>  committed and have formatted memory buffers attached to them. It tracks objects
>  in transaction commit order, so when an object is relogged it is removed from
> -it's place in the list and re-inserted at the tail. This is entirely arbitrary
> +its place in the list and re-inserted at the tail. This is entirely arbitrary
>  and done to make it easy for debugging - the last items in the list are the
>  ones that are most recently modified. Ordering of the CIL is not necessary for
>  transactional integrity (as discussed in the next section) so the ordering is
> @@ -884,7 +884,7 @@ pin the object the first time it is inse
>  the CIL during a transaction commit, then we do not pin it again. Because there
>  can be multiple outstanding checkpoint contexts, we can still see elevated pin
>  counts, but as each checkpoint completes the pin count will retain the correct
> -value according to it's context.
> +value according to its context.
>  
>  Just to make matters more slightly more complex, this checkpoint level context
>  for the pin count means that the pinning of an item must take place under the
