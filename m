Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E12763825
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjGZN4O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 09:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjGZN4N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:56:13 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5782716;
        Wed, 26 Jul 2023 06:54:00 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id A3786320039A;
        Wed, 26 Jul 2023 09:53:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 26 Jul 2023 09:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1690379630; x=1690466030; bh=vcPDkrsGIwFtmpzt098KRroBQefPuWMGKTH
        AmPms6QE=; b=P9KZyJhTKlj1NQ3Cm0gWoHj/6QLltZp81f74zItfjr7/T+/4wCI
        GpG3hrgRU83LMTNr5kPTnEg6nZIMMUS3urPY6GEHGXyoONrrJRAmydu6FfHotmy4
        R8r6phEDHtM6kOzMNcqJnFWNAaFPED+U6oDNzK7cDe1pkYx35+5vOrAn+OQ3ueLK
        Lm9raHomDna6+R8lwOiYNOYs4j+LlC6RyCQNYEvwMY0vm+ns0ZT86zxmwlp5K6dK
        wxKDE1mt0kZrW/FHw3/It2LsaTZ472Lzj8GY1izdg8whoSKMEdl91OmrEInWsgS8
        XyiHz0q7aQkO1Eejmic1SWpqetBYp4+CgTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1690379630; x=
        1690466030; bh=vcPDkrsGIwFtmpzt098KRroBQefPuWMGKTHAmPms6QE=; b=p
        bTF2jKsQtHQUJDmARouwsuP/ygVU7gS2EEWiwdrrU4O3P4FX256CNIcr4/KTyTQo
        6q+FVidaD9Rcu5xi4sRhzgCN1Cl5Vwj7F89MXfmTepxhhKPqmzPdQ+rAmeOh+2mW
        xwWeznjLoytEbRjIl0OF80+ybdlelftp2ENQwP54SeS1xGd8OMqiTVwelY4lJX8q
        Ajcf7QDdFQybC+y0rToOo3dvsvBjCsc6i/IlIJPyd3AFlT3Qv4stAzuFx8+Dxrh9
        bvN7FDWzNoihaHglB6mK/ZfWfRPAZ2CXDRtbQzLvylas0fsiplWIM0WGXNCrIvV3
        D+pO25u43PxQ61oiOuWUQ==
X-ME-Sender: <xms:biXBZFE8UPVASSR7VKgNpn0yUlZ3ZM_AvTn7wRZOSRU5LYJe9Er6HQ>
    <xme:biXBZKWQ_Kl8_5FPvGptHLktM4kwUoSNpztAiAHzHgpz_v6Z8iyFSJZZzsiWsYP9Z
    zu8lPPceBnBSB6S>
X-ME-Received: <xmr:biXBZHIs-q-eMqoVmplb3eAYBmuqJ3Dh9WG7fz3lqQpzrvD5SwZHlRyU6SZBtxlP1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculddutddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdef
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeegffdutdegiefg
    teelleeggeeuueduteefieduvedvueefieejledvjeeuhfefgeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:biXBZLHEbsuxV6zW_kktPeE4sC7uAGLyoh-CUXfZqOLry5M0omV9EQ>
    <xmx:biXBZLWJUDA21Z95rdC45mrxKdGZ6jCaPdmb_MFCBM1y8-ma60MiVA>
    <xmx:biXBZGPcxVclx20XeyFe3z8At6m8uMP7yyXKvbJfOQJsVAkdsy6h_w>
    <xmx:biXBZIg43U4BXLIlWFIDcU-_FI9kSWrZOA9aX5gqgdDSXhlJ2lJPrA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 09:53:49 -0400 (EDT)
Message-ID: <b5255112-922f-b965-398e-38b9f5fb4892@fastmail.fm>
Date:   Wed, 26 Jul 2023 15:53:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] fuse: enable larger read buffers for readdir.
Content-Language: en-US
To:     Jaco Kroon <jaco@uls.co.za>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230726105953.843-1-jaco@uls.co.za>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230726105953.843-1-jaco@uls.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/26/23 12:59, Jaco Kroon wrote:
> Signed-off-by: Jaco Kroon <jaco@uls.co.za>
> ---
>   fs/fuse/Kconfig   | 16 ++++++++++++++++
>   fs/fuse/readdir.c | 42 ++++++++++++++++++++++++------------------
>   2 files changed, 40 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index 038ed0b9aaa5..0783f9ee5cd3 100644
> --- a/fs/fuse/Kconfig
> +++ b/fs/fuse/Kconfig
> @@ -18,6 +18,22 @@ config FUSE_FS
>   	  If you want to develop a userspace FS, or if you want to use
>   	  a filesystem based on FUSE, answer Y or M.
>   
> +config FUSE_READDIR_ORDER
> +	int
> +	range 0 5
> +	default 5
> +	help
> +		readdir performance varies greatly depending on the size of the read.
> +		Larger buffers results in larger reads, thus fewer reads and higher
> +		performance in return.
> +
> +		You may want to reduce this value on seriously constrained memory
> +		systems where 128KiB (assuming 4KiB pages) cache pages is not ideal.
> +
> +		This value reprents the order of the number of pages to allocate (ie,
> +		the shift value).  A value of 0 is thus 1 page (4KiB) where 5 is 32
> +		pages (128KiB).
> +

I like the idea of a larger readdir size, but shouldn't that be a 
server/daemon/library decision which size to use, instead of kernel 
compile time? So should be part of FUSE_INIT negotiation?

>   config CUSE
>   	tristate "Character device in Userspace support"
>   	depends on FUSE_FS
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index dc603479b30e..98c62b623240 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -13,6 +13,12 @@
>   #include <linux/pagemap.h>
>   #include <linux/highmem.h>
>   
> +#define READDIR_PAGES_ORDER		CONFIG_FUSE_READDIR_ORDER
> +#define READDIR_PAGES			(1 << READDIR_PAGES_ORDER)
> +#define READDIR_PAGES_SIZE		(PAGE_SIZE << READDIR_PAGES_ORDER)
> +#define READDIR_PAGES_MASK		(READDIR_PAGES_SIZE - 1)
> +#define READDIR_PAGES_SHIFT		(PAGE_SHIFT + READDIR_PAGES_ORDER)
> +
>   static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
>   {
>   	struct fuse_conn *fc = get_fuse_conn(dir);
> @@ -52,10 +58,10 @@ static void fuse_add_dirent_to_cache(struct file *file,
>   	}
>   	version = fi->rdc.version;
>   	size = fi->rdc.size;
> -	offset = size & ~PAGE_MASK;
> -	index = size >> PAGE_SHIFT;
> +	offset = size & ~READDIR_PAGES_MASK;
> +	index = size >> READDIR_PAGES_SHIFT;
>   	/* Dirent doesn't fit in current page?  Jump to next page. */
> -	if (offset + reclen > PAGE_SIZE) {
> +	if (offset + reclen > READDIR_PAGES_SIZE) {
>   		index++;
>   		offset = 0;
>   	}
> @@ -83,7 +89,7 @@ static void fuse_add_dirent_to_cache(struct file *file,
>   	}
>   	memcpy(addr + offset, dirent, reclen);
>   	kunmap_local(addr);
> -	fi->rdc.size = (index << PAGE_SHIFT) + offset + reclen;
> +	fi->rdc.size = (index << READDIR_PAGES_SHIFT) + offset + reclen;
>   	fi->rdc.pos = dirent->off;
>   unlock:
>   	spin_unlock(&fi->rdc.lock);
> @@ -104,7 +110,7 @@ static void fuse_readdir_cache_end(struct file *file, loff_t pos)
>   	}
>   
>   	fi->rdc.cached = true;
> -	end = ALIGN(fi->rdc.size, PAGE_SIZE);
> +	end = ALIGN(fi->rdc.size, READDIR_PAGES_SIZE);
>   	spin_unlock(&fi->rdc.lock);
>   
>   	/* truncate unused tail of cache */
> @@ -328,25 +334,25 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
>   	struct fuse_mount *fm = get_fuse_mount(inode);
>   	struct fuse_io_args ia = {};
>   	struct fuse_args_pages *ap = &ia.ap;
> -	struct fuse_page_desc desc = { .length = PAGE_SIZE };
> +	struct fuse_page_desc desc = { .length = READDIR_PAGES_SIZE };
>   	u64 attr_version = 0;
>   	bool locked;
>   
> -	page = alloc_page(GFP_KERNEL);
> +	page = alloc_pages(GFP_KERNEL, READDIR_PAGES_ORDER);

I guess that should become folio alloc(), one way or the other. Now I 
think order 0 was chosen before to avoid risk of allocation failure. I 
guess it might work to try a large size and to fall back to 0 when that 
failed. Or fail back to the slower vmalloc.

>   	if (!page)
>   		return -ENOMEM;
>   
>   	plus = fuse_use_readdirplus(inode, ctx);
>   	ap->args.out_pages = true;
> -	ap->num_pages = 1;
> +	ap->num_pages = READDIR_PAGES;
>   	ap->pages = &page;
>   	ap->descs = &desc;
>   	if (plus) {
>   		attr_version = fuse_get_attr_version(fm->fc);
> -		fuse_read_args_fill(&ia, file, ctx->pos, PAGE_SIZE,
> +		fuse_read_args_fill(&ia, file, ctx->pos, READDIR_PAGES_SIZE,
>   				    FUSE_READDIRPLUS);
>   	} else {
> -		fuse_read_args_fill(&ia, file, ctx->pos, PAGE_SIZE,
> +		fuse_read_args_fill(&ia, file, ctx->pos, READDIR_PAGES_SIZE,
>   				    FUSE_READDIR);
>   	}
>   	locked = fuse_lock_inode(inode);
> @@ -383,7 +389,7 @@ static enum fuse_parse_result fuse_parse_cache(struct fuse_file *ff,
>   					       void *addr, unsigned int size,
>   					       struct dir_context *ctx)
>   {
> -	unsigned int offset = ff->readdir.cache_off & ~PAGE_MASK;
> +	unsigned int offset = ff->readdir.cache_off & ~READDIR_PAGES_MASK;
>   	enum fuse_parse_result res = FOUND_NONE;
>   
>   	WARN_ON(offset >= size);
> @@ -504,16 +510,16 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
>   
>   	WARN_ON(fi->rdc.size < ff->readdir.cache_off);
>   
> -	index = ff->readdir.cache_off >> PAGE_SHIFT;
> +	index = ff->readdir.cache_off >> READDIR_PAGES_SHIFT;
>   
> -	if (index == (fi->rdc.size >> PAGE_SHIFT))
> -		size = fi->rdc.size & ~PAGE_MASK;
> +	if (index == (fi->rdc.size >> READDIR_PAGES_SHIFT))
> +		size = fi->rdc.size & ~READDIR_PAGES_MASK;
>   	else
> -		size = PAGE_SIZE;
> +		size = READDIR_PAGES_SIZE;
>   	spin_unlock(&fi->rdc.lock);
>   
>   	/* EOF? */
> -	if ((ff->readdir.cache_off & ~PAGE_MASK) == size)
> +	if ((ff->readdir.cache_off & ~READDIR_PAGES_MASK) == size)
>   		return 0;
>   
>   	page = find_get_page_flags(file->f_mapping, index,
> @@ -559,9 +565,9 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
>   	if (res == FOUND_ALL)
>   		return 0;
>   
> -	if (size == PAGE_SIZE) {
> +	if (size == READDIR_PAGES_SIZE) {
>   		/* We hit end of page: skip to next page. */
> -		ff->readdir.cache_off = ALIGN(ff->readdir.cache_off, PAGE_SIZE);
> +		ff->readdir.cache_off = ALIGN(ff->readdir.cache_off, READDIR_PAGES_SIZE);
>   		goto retry;
>   	}
>   

Thanks,
Bernd
