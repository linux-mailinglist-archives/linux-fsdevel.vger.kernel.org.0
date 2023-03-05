Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBE06AAEA4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Mar 2023 09:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCEIxg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Mar 2023 03:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEIxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Mar 2023 03:53:34 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3158BBBC;
        Sun,  5 Mar 2023 00:53:33 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id y2so6859297pjg.3;
        Sun, 05 Mar 2023 00:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Iv+GuZ1uASGnLzqpdUE7BOfQ48/mQJ2SDTfiMkwx1fU=;
        b=KWsZOgtA5eH49SdP6icthsD9GYeCiRbMJ5yK9bFryYg+hXs3C1s/g/D8tgFWGq7Sdv
         HGYKs46HFI8+S+LfWbNBV9IfT6YWC9XjEdWtDRT2IDBF9EjcjxW5LFnMxkVR5J0wi5Vw
         Wq7JotHjttVQclsXp2SJ47N+Wzzo5jUEFNntCNwnOyvLQTYv/dYt9XdhJFS9f3Yq2rMH
         hB4XhbPgjLEUlgkkQcTEBNsrV1sMjBH/iqDbWM1y/z/DAFuCnpzaxaCuCClPheQ6FxOG
         LUt4RvhVpEhR4+b37nXeH6xsWIMTB53OY7xja2TL1kwXCtaiO8/OyYGbsiX+7PRhpr5B
         LPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iv+GuZ1uASGnLzqpdUE7BOfQ48/mQJ2SDTfiMkwx1fU=;
        b=3LdhqIr/NQkvJHNmq8dL48IMtSLFmMk4cPS/qYW4NpyfXmxmJJGKSIiSVWqtLgfrlq
         uWQ58TX8yn8/X5J7SKbXIk2Kfe1a6MhrJIZnzeyvJuOgJHNQURTwYtKfINDacAHigPua
         /bW/a2jY7XYyBQ4zfXPgbmULvQBQcoKqPY2mzM4/u+ZZxjreaf7tQjZLNyZPUQ00ujOR
         CZC76kUPk65rqVMkLNRyYklWnkXmSU7qfd+7c8XTxxJFdgdihEoeK0nY/hVsZzjag2YL
         i402tLHybujhSR8B5Y9bvnHOiLKK33yLqzozWMgStoW1bgiepVejSbFF42u0DZNN+AGG
         Uchg==
X-Gm-Message-State: AO0yUKWyeIBIgKt0yksIoG4FDPZkUYM1sR4jfYoaHH93lPZRc3SYLJYX
        GWT3KVu+NkUBF8zdbvdQjotXg3slTeapOQ==
X-Google-Smtp-Source: AK7set+N7K8jaRUG0luofeYUmt+lldIvZ8Xk74I1NliydEzceGIpXSTXZuRDgBd71cnPoUNUYHLQ5A==
X-Received: by 2002:a17:90b:3505:b0:234:dc4:2006 with SMTP id ls5-20020a17090b350500b002340dc42006mr8091203pjb.4.1678006412621;
        Sun, 05 Mar 2023 00:53:32 -0800 (PST)
Received: from rh-tp ([2406:7400:63:469f:eb50:3ffb:dc1b:2d55])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090a890200b0023a71a06c86sm3670373pjn.29.2023.03.05.00.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 00:53:32 -0800 (PST)
Date:   Sun, 05 Mar 2023 14:23:19 +0530
Message-Id: <87mt4rmveo.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/31] fs: Add FGP_WRITEBEGIN
In-Reply-To: <20230126202415.1682629-2-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Matthew Wilcox (Oracle)" <willy@infradead.org> writes:

> This particular combination of flags is used by most filesystems
> in their ->write_begin method, although it does find use in a
> few other places.  Before folios, it warranted its own function
> (grab_cache_page_write_begin()), but I think that just having specialised
> flags is enough.  It certainly helps the few places that have been
> converted from grab_cache_page_write_begin() to __filemap_get_folio().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good to me. With small comment below.

Please feel free to add -
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

> ---
>  fs/ext4/move_extent.c    | 5 ++---
>  fs/iomap/buffered-io.c   | 2 +-
>  fs/netfs/buffered_read.c | 3 +--
>  include/linux/pagemap.h  | 2 ++
>  mm/folio-compat.c        | 4 +---
>  5 files changed, 7 insertions(+), 9 deletions(-)

After below patch got added to mainline, we should use FGP_WRITEBEGIN
flag in fs/nfs/file.c as well.

54d99381b7371d2999566d1fb4ea88d46cf9d865
Author:     Trond Myklebust <trond.myklebust@hammerspace.com>
CommitDate: Tue Feb 14 14:22:32 2023 -0500

NFS: Convert nfs_write_begin/end to use folios


In fact we don't even need the helper
(nfs_folio_grab_cache_write_begin()) anymore, since we can directly pass
FGP_WRITEBEGIN flag in __filemap_get_folio() in the caller itself.

static struct folio *
nfs_folio_grab_cache_write_begin(struct address_space *mapping, pgoff_t index)
{
	unsigned fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE;

	return __filemap_get_folio(mapping, index, fgp_flags,
				   mapping_gfp_mask(mapping));
}


-ritesh

>
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 2de9829aed63..0cb361f0a4fe 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -126,7 +126,6 @@ mext_folio_double_lock(struct inode *inode1, struct inode *inode2,
>  {
>  	struct address_space *mapping[2];
>  	unsigned int flags;
> -	unsigned fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE;
>
>  	BUG_ON(!inode1 || !inode2);
>  	if (inode1 < inode2) {
> @@ -139,14 +138,14 @@ mext_folio_double_lock(struct inode *inode1, struct inode *inode2,
>  	}
>
>  	flags = memalloc_nofs_save();
> -	folio[0] = __filemap_get_folio(mapping[0], index1, fgp_flags,
> +	folio[0] = __filemap_get_folio(mapping[0], index1, FGP_WRITEBEGIN,
>  			mapping_gfp_mask(mapping[0]));
>  	if (!folio[0]) {
>  		memalloc_nofs_restore(flags);
>  		return -ENOMEM;
>  	}
>
> -	folio[1] = __filemap_get_folio(mapping[1], index2, fgp_flags,
> +	folio[1] = __filemap_get_folio(mapping[1], index2, FGP_WRITEBEGIN,
>  			mapping_gfp_mask(mapping[1]));
>  	memalloc_nofs_restore(flags);
>  	if (!folio[1]) {
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 6f4c97a6d7e9..10a203515583 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -467,7 +467,7 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
>   */
>  struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos)
>  {
> -	unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
> +	unsigned fgp = FGP_WRITEBEGIN | FGP_NOFS;
>  	struct folio *folio;
>
>  	if (iter->flags & IOMAP_NOWAIT)
> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> index 7679a68e8193..e3d754a9e1b0 100644
> --- a/fs/netfs/buffered_read.c
> +++ b/fs/netfs/buffered_read.c
> @@ -341,14 +341,13 @@ int netfs_write_begin(struct netfs_inode *ctx,
>  {
>  	struct netfs_io_request *rreq;
>  	struct folio *folio;
> -	unsigned int fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE;
>  	pgoff_t index = pos >> PAGE_SHIFT;
>  	int ret;
>
>  	DEFINE_READAHEAD(ractl, file, NULL, mapping, index);
>
>  retry:
> -	folio = __filemap_get_folio(mapping, index, fgp_flags,
> +	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
>  				    mapping_gfp_mask(mapping));
>  	if (!folio)
>  		return -ENOMEM;
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 9f1081683771..47069662f4b8 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -507,6 +507,8 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
>  #define FGP_ENTRY		0x00000080
>  #define FGP_STABLE		0x00000100
>
> +#define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
> +
>  struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  		int fgp_flags, gfp_t gfp);
>  struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
> diff --git a/mm/folio-compat.c b/mm/folio-compat.c
> index 18c48b557926..668350748828 100644
> --- a/mm/folio-compat.c
> +++ b/mm/folio-compat.c
> @@ -106,9 +106,7 @@ EXPORT_SYMBOL(pagecache_get_page);
>  struct page *grab_cache_page_write_begin(struct address_space *mapping,
>  					pgoff_t index)
>  {
> -	unsigned fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE;
> -
> -	return pagecache_get_page(mapping, index, fgp_flags,
> +	return pagecache_get_page(mapping, index, FGP_WRITEBEGIN,
>  			mapping_gfp_mask(mapping));
>  }
>  EXPORT_SYMBOL(grab_cache_page_write_begin);
> --
> 2.35.1
