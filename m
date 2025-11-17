Return-Path: <linux-fsdevel+bounces-68623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A7CC62069
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 02:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A7AF4E50F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 01:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F291C8611;
	Mon, 17 Nov 2025 01:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="dyzgxSYS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E161FB1;
	Mon, 17 Nov 2025 01:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763343933; cv=none; b=WqkRWLomxdoqWwKAGsK2Nxigr0NzLjbCvqEHdRXg5gEeIL16Umk6oDFHuhJikY0+v44ObSUKLQzaumamS+0mMPQfuUrZbLTjDrGB65vZl9/A85ldrIj2R4hxbWbjjrmrN1O3OaSSdy5uvxR7Xg64frqklevmO+SfOV3Xcmx6QBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763343933; c=relaxed/simple;
	bh=sp8hLbpfq58tymC5gtjzY8kJz5QFWJB40KMerk+aKOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hq+gDSjdC5fgq7wcGfL94CHo+2FiamVo1qoQzwUG0MDQ5GCqYMNPrqk/WRFG1MWfvMBMpFQ4anRTRjtl5xXF87EWqKOxTopAldo63sR/aiHiegmEA7kNcmLNQlhshCvPgop8gjFyI30YGrVEkLT9msYl3wW+1OXlrOL1dn8bJTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=dyzgxSYS; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FuG5ZFIMPnpMFGvhLCDkKKPsJcNw/LoD6bJD83gzIZQ=;
	b=dyzgxSYSzURMtGG4Wt8H4XVmPTKbEK0U2aqQ2QKnIFFKXOGo6MXJc93yo7ump0IblB75kMmsw
	pFydBAovYfDWQtYuLYuXyIi3u0T/eBA11x63/HkykHWbpfzh9CE45Bf3+lOK5s320fZoo4dqLDI
	Jy9qZb7IGHrT5ASW69CEHfU=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4d8rBN3T9Nz1T4Fq;
	Mon, 17 Nov 2025 09:43:56 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E1CA140132;
	Mon, 17 Nov 2025 09:45:26 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Nov 2025 09:45:25 +0800
Message-ID: <d2f9f55d-1112-4252-b662-a36398f88aaa@huawei.com>
Date: Mon, 17 Nov 2025 09:45:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/9] erofs: hold read context in iomap_iter if needed
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <chao@kernel.org>,
	<brauner@kernel.org>, <djwong@kernel.org>, <amir73il@gmail.com>,
	<joannelkoong@gmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
References: <20251114095516.207555-1-lihongbo22@huawei.com>
 <20251114095516.207555-3-lihongbo22@huawei.com>
 <f714479d-703c-4fc6-ad5a-b18d92f0a9b7@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <f714479d-703c-4fc6-ad5a-b18d92f0a9b7@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500015.china.huawei.com (7.202.195.162)

Hi Xiang,

On 2025/11/16 20:01, Gao Xiang wrote:
> 
> 
> On 2025/11/14 17:55, Hongbo Li wrote:
>> Uncoming page cache sharing needs pass read context to iomap_iter,
>> here we unify the way of passing the read context in EROFS. Moreover,
>> bmap and fiemap don't need to map the inline data.
>>
>> Note that we keep `struct page *` in `struct erofs_iomap_iter_ctx` as
>> well to avoid bogus kmap_to_page usage.
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   fs/erofs/data.c | 79 ++++++++++++++++++++++++++++++++++++-------------
>>   1 file changed, 59 insertions(+), 20 deletions(-)
>>
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index bb13c4cb8455..bd3d85c61341 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -266,14 +266,23 @@ void erofs_onlinefolio_end(struct folio *folio, 
>> int err, bool dirty)
>>       folio_end_read(folio, !(v & BIT(EROFS_ONLINEFOLIO_EIO)));
>>   }
>> +struct erofs_iomap_iter_ctx {
>> +    struct page *page;
>> +    void *base;
>> +};
>> +
>>   static int erofs_iomap_begin(struct inode *inode, loff_t offset, 
>> loff_t length,
>>           unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
>>   {
>>       int ret;
>> +    struct erofs_iomap_iter_ctx *ctx;
>>       struct super_block *sb = inode->i_sb;
>>       struct erofs_map_blocks map;
>>       struct erofs_map_dev mdev;
>> +    struct iomap_iter *iter;
>> +    iter = container_of(iomap, struct iomap_iter, iomap);
>> +    ctx = iter->private;
> 
> Can you just rearrange it as:
> 
>      struct iomap_iter *iter = container_of(iomap, struct iomap_iter, 
> iomap);
>      struct erofs_iomap_iter_ctx *ctx = iter->private;
> 
> ?
> 

Thanks for your through review. The points you raised are quite 
reasonable, and I will address them in later version.

Thanks,
Hongbo

>>       map.m_la = offset;
>>       map.m_llen = length;
>>       ret = erofs_map_blocks(inode, &map);
>> @@ -283,7 +292,8 @@ static int erofs_iomap_begin(struct inode *inode, 
>> loff_t offset, loff_t length,
>>       iomap->offset = map.m_la;
>>       iomap->length = map.m_llen;
>>       iomap->flags = 0;
>> -    iomap->private = NULL;
>> +    if (ctx)
>> +        ctx->base = NULL;
> 
> I think this line is unnecessary if iter->private == ctx;
> 
>>       iomap->addr = IOMAP_NULL_ADDR;
>>       if (!(map.m_flags & EROFS_MAP_MAPPED)) {
>>           iomap->type = IOMAP_HOLE;
>> @@ -309,16 +319,20 @@ static int erofs_iomap_begin(struct inode 
>> *inode, loff_t offset, loff_t length,
>>       }
>>       if (map.m_flags & EROFS_MAP_META) {
>> -        void *ptr;
>> -        struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>> -
>>           iomap->type = IOMAP_INLINE;
>> -        ptr = erofs_read_metabuf(&buf, sb, map.m_pa,
>> -                     erofs_inode_in_metabox(inode));
>> -        if (IS_ERR(ptr))
>> -            return PTR_ERR(ptr);
>> -        iomap->inline_data = ptr;
>> -        iomap->private = buf.base;
>> +        /* read context should read the inlined data */
>> +        if (ctx) {
>> +            void *ptr;
>> +            struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> 
> better to resort them as:
>              struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>              void *ptr;
> 
>> +
>> +            ptr = erofs_read_metabuf(&buf, sb, map.m_pa,
>> +                         erofs_inode_in_metabox(inode));
>> +            if (IS_ERR(ptr))
>> +                return PTR_ERR(ptr);
>> +            iomap->inline_data = ptr;
>> +            ctx->page = buf.page;
>> +            ctx->base = buf.base;
>> +        }
>>       } else {
>>           iomap->type = IOMAP_MAPPED;
>>       }
>> @@ -328,18 +342,19 @@ static int erofs_iomap_begin(struct inode 
>> *inode, loff_t offset, loff_t length,
>>   static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t 
>> length,
>>           ssize_t written, unsigned int flags, struct iomap *iomap)
>>   {
>> -    void *ptr = iomap->private;
>> +    struct erofs_iomap_iter_ctx *ctx;
>> +    struct iomap_iter *iter;
>> -    if (ptr) {
>> +    iter = container_of(iomap, struct iomap_iter, iomap);
>> +    ctx = iter->private;
>> +    if (ctx && ctx->base) {
>>           struct erofs_buf buf = {
>> -            .page = kmap_to_page(ptr),
>> -            .base = ptr,
>> +            .page = ctx->page,
>> +            .base = ctx->base,
>>           };
>>           DBG_BUGON(iomap->type != IOMAP_INLINE);
>>           erofs_put_metabuf(&buf);
> 
> so need to nullify ctx->base here:
> 
>          ctx->base = NULL;
> 
>> -    } else {
>> -        DBG_BUGON(iomap->type == IOMAP_INLINE);
>>       }
>>       return written;
>>   }
>> @@ -369,18 +384,36 @@ int erofs_fiemap(struct inode *inode, struct 
>> fiemap_extent_info *fieinfo,
>>    */
>>   static int erofs_read_folio(struct file *file, struct folio *folio)
>>   {
>> +    struct iomap_read_folio_ctx read_ctx = {
>> +        .ops        = &iomap_bio_read_ops,
>> +        .cur_folio    = folio,
>> +    };
>> +    struct erofs_iomap_iter_ctx iter_ctx = {
>> +        .page        = NULL,
>> +        .base        = NULL,
>> +    };
> 
> it can be initialized just by:
>      struct erofs_iomap_iter_ctx iter_ctx = {};
> 
>> +
>>       trace_erofs_read_folio(folio, true);
>> -    iomap_bio_read_folio(folio, &erofs_iomap_ops);
>> +    iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
>>       return 0;
>>   }
>>   static void erofs_readahead(struct readahead_control *rac)
>>   {
>> +    struct iomap_read_folio_ctx read_ctx = {
>> +        .ops        = &iomap_bio_read_ops,
>> +        .rac        = rac,
>> +    };
>> +    struct erofs_iomap_iter_ctx iter_ctx = {
>> +        .page        = NULL,
>> +        .base        = NULL,
>> +    };
> 
> Same here.
> 
>> +
>>       trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
>>                       readahead_count(rac), true);
>> -    iomap_bio_readahead(rac, &erofs_iomap_ops);
>> +    iomap_readahead(&erofs_iomap_ops, &read_ctx, &iter_ctx);
>>   }
>>   static sector_t erofs_bmap(struct address_space *mapping, sector_t 
>> block)
>> @@ -400,9 +433,15 @@ static ssize_t erofs_file_read_iter(struct kiocb 
>> *iocb, struct iov_iter *to)
>>       if (IS_DAX(inode))
>>           return dax_iomap_rw(iocb, to, &erofs_iomap_ops);
>>   #endif
>> -    if ((iocb->ki_flags & IOCB_DIRECT) && inode->i_sb->s_bdev)
>> +    if ((iocb->ki_flags & IOCB_DIRECT) && inode->i_sb->s_bdev) {
>> +        struct erofs_iomap_iter_ctx iter_ctx = {
>> +            .page = NULL,
>> +            .base = NULL,
>> +        };
> 
> Same here again.
> 
> Thanks,
> Gao Xiang

