Return-Path: <linux-fsdevel+bounces-72582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B356CFC3DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 07:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FD4A3019899
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 06:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1314928C849;
	Wed,  7 Jan 2026 06:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZsRk2j1D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6175421D3F2;
	Wed,  7 Jan 2026 06:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768649; cv=none; b=FbgVZR+w4VL1X1+AsFOZv2sFuBNRU7gsYecPCwk58nBURiUVzBEzfejyyPDak9IYilpmBohuxgvMxSibuLs2k++KLOquZ1okTEW+b7KK1TX6meP5UWQ4Mw6bF5e3ci/DHmPzczeZJmgtDD0h9htl6U3n1N97DtgWKP3diwlOZXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768649; c=relaxed/simple;
	bh=uMRq+SjlEkKard7y3BRFWoW49bviGBHOxgRqnxR6wVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NqiJYjJ6pGmJchUxV/OOIB6+KtKTaOI6DmqTRAhmOUPwKKZawQHnMdlz9seJob9Fnc11K4I6lN+rs990LjbF9kRr1TuU8TUtMrPHgdy8oxgC+moDrhB5y+hLC6nwgNIMnDBpvr/ePgdC7GWCFtn3jo9g4FTRR8AiVTOxBCJ/fME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZsRk2j1D; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zcA78h/25ZcOE+V2h5pq/ndroGIocBHBYMTcRCRbx5Q=;
	b=ZsRk2j1DfZzYuOUGL3eiFpxqKeKbwNFYdcEoE7y/u+lCDVk0kPJ+6rK1KDG7tf9NWOneR3fVN
	+Caa0PoKqh/0MJqeEO0hawqo4aeRNp+3WLkHniQat1xtRxI36EcD4FQTknFru9NvKKFQL8F6uud
	vMy7FAqu1+QhM7zDBvfowVg=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dmJWH2s4jznTY4;
	Wed,  7 Jan 2026 14:47:39 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id B7C434055B;
	Wed,  7 Jan 2026 14:50:43 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 Jan 2026 14:50:43 +0800
Message-ID: <06419d60-1fe9-4fcc-9d14-2751e12b6f7a@huawei.com>
Date: Wed, 7 Jan 2026 14:50:42 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 08/10] erofs: support unencoded inodes for page cache
 share
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>, Christian Brauner
	<brauner@kernel.org>
References: <20251231090118.541061-1-lihongbo22@huawei.com>
 <20251231090118.541061-9-lihongbo22@huawei.com>
 <d31cd92b-56ba-4798-bc88-5bf4999a2437@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <d31cd92b-56ba-4798-bc88-5bf4999a2437@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)



On 2026/1/7 14:12, Gao Xiang wrote:
> 
> 
> On 2025/12/31 17:01, Hongbo Li wrote:
>> This patch adds inode page cache sharing functionality for unencoded
>> files.
>>
>> I conducted experiments in the container environment. Below is the
>> memory usage for reading all files in two different minor versions
>> of container images:
>>
>> +-------------------+------------------+-------------+---------------+
>> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
>> |                   |                  |             | Reduction (%) |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     241     |       -       |
>> |       redis       +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |     163     |      33%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     872     |       -       |
>> |      postgres     +------------------+-------------+---------------+
>> |    16.1 & 16.2    |        Yes       |     630     |      28%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     2771    |       -       |
>> |     tensorflow    +------------------+-------------+---------------+
>> |  2.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     926     |       -       |
>> |       mysql       +------------------+-------------+---------------+
>> |  8.0.11 & 8.0.12  |        Yes       |     735     |      21%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     390     |       -       |
>> |       nginx       +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |     219     |      44%      |
>> +-------------------+------------------+-------------+---------------+
>> |       tomcat      |        No        |     924     |       -       |
>> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
>> |                   |        Yes       |     474     |      49%      |
>> +-------------------+------------------+-------------+---------------+
>>
>> Additionally, the table below shows the runtime memory usage of the
>> container:
>>
>> +-------------------+------------------+-------------+---------------+
>> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
>> |                   |                  |             | Reduction (%) |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |      35     |       -       |
>> |       redis       +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |      28     |      20%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     149     |       -       |
>> |      postgres     +------------------+-------------+---------------+
>> |    16.1 & 16.2    |        Yes       |      95     |      37%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     1028    |       -       |
>> |     tensorflow    +------------------+-------------+---------------+
>> |  2.11.0 & 2.11.1  |        Yes       |     930     |      10%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     155     |       -       |
>> |       mysql       +------------------+-------------+---------------+
>> |  8.0.11 & 8.0.12  |        Yes       |     132     |      15%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |      25     |       -       |
>> |       nginx       +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |      20     |      20%      |
>> +-------------------+------------------+-------------+---------------+
>> |       tomcat      |        No        |     186     |       -       |
>> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
>> |                   |        Yes       |      98     |      48%      |
>> +-------------------+------------------+-------------+---------------+
>>
>> Co-developed-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   fs/erofs/data.c     | 30 +++++++++++++++++++++++-------
>>   fs/erofs/inode.c    |  4 ++++
>>   fs/erofs/internal.h |  6 ++++++
>>   fs/erofs/ishare.c   | 32 ++++++++++++++++++++++++++++++++
>>   4 files changed, 65 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index 71e23d91123d..5fc8e3ce0d9e 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -269,6 +269,7 @@ void erofs_onlinefolio_end(struct folio *folio, 
>> int err, bool dirty)
>>   struct erofs_iomap_iter_ctx {
>>       struct page *page;
>>       void *base;
>> +    struct inode *realinode;
>>   };
>>   static int erofs_iomap_begin(struct inode *inode, loff_t offset, 
>> loff_t length,
>> @@ -276,14 +277,15 @@ static int erofs_iomap_begin(struct inode 
>> *inode, loff_t offset, loff_t length,
>>   {
>>       struct iomap_iter *iter = container_of(iomap, struct iomap_iter, 
>> iomap);
>>       struct erofs_iomap_iter_ctx *ctx = iter->private;
>> -    struct super_block *sb = inode->i_sb;
>> +    struct inode *realinode = ctx ? ctx->realinode : inode;
>> +    struct super_block *sb = realinode->i_sb;
>>       struct erofs_map_blocks map;
>>       struct erofs_map_dev mdev;
>>       int ret;
>>       map.m_la = offset;
>>       map.m_llen = length;
>> -    ret = erofs_map_blocks(inode, &map);
>> +    ret = erofs_map_blocks(realinode, &map);
>>       if (ret < 0)
>>           return ret;
>> @@ -296,7 +298,7 @@ static int erofs_iomap_begin(struct inode *inode, 
>> loff_t offset, loff_t length,
>>           return 0;
>>       }
>> -    if (!(map.m_flags & EROFS_MAP_META) || 
>> !erofs_inode_in_metabox(inode)) {
>> +    if (!(map.m_flags & EROFS_MAP_META) || 
>> !erofs_inode_in_metabox(realinode)) {
>>           mdev = (struct erofs_map_dev) {
>>               .m_deviceid = map.m_deviceid,
>>               .m_pa = map.m_pa,
>> @@ -322,7 +324,7 @@ static int erofs_iomap_begin(struct inode *inode, 
>> loff_t offset, loff_t length,
>>               void *ptr;
>>               ptr = erofs_read_metabuf(&buf, sb, map.m_pa,
>> -                         erofs_inode_in_metabox(inode));
>> +                         erofs_inode_in_metabox(realinode));
>>               if (IS_ERR(ptr))
>>                   return PTR_ERR(ptr);
>>               iomap->inline_data = ptr;
>> @@ -379,30 +381,42 @@ int erofs_fiemap(struct inode *inode, struct 
>> fiemap_extent_info *fieinfo,
>>    */
>>   static int erofs_read_folio(struct file *file, struct folio *folio)
>>   {
>> +    struct inode *inode = folio_inode(folio);
>>       struct iomap_read_folio_ctx read_ctx = {
>>           .ops        = &iomap_bio_read_ops,
>>           .cur_folio    = folio,
>>       };
>> -    struct erofs_iomap_iter_ctx iter_ctx = {};
>> +    bool need_iput;
>> +    struct erofs_iomap_iter_ctx iter_ctx = {
>> +        .realinode    = erofs_real_inode(inode, &need_iput),
>> +    };
>>       trace_erofs_read_folio(folio, true);
>>       iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
>> +    if (need_iput)
>> +        iput(iter_ctx.realinode);
>>       return 0;
>>   }
>>   static void erofs_readahead(struct readahead_control *rac)
>>   {
>> +    struct inode *inode = rac->mapping->host;
>>       struct iomap_read_folio_ctx read_ctx = {
>>           .ops        = &iomap_bio_read_ops,
>>           .rac        = rac,
>>       };
>> -    struct erofs_iomap_iter_ctx iter_ctx = {};
>> +    bool need_iput;
>> +    struct erofs_iomap_iter_ctx iter_ctx = {
>> +        .realinode    = erofs_real_inode(inode, &need_iput),
>> +    };
>>       trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
>>                       readahead_count(rac), true);
>>       iomap_readahead(&erofs_iomap_ops, &read_ctx, &iter_ctx);
>> +    if (need_iput)
>> +        iput(iter_ctx.realinode);
>>   }
>>   static sector_t erofs_bmap(struct address_space *mapping, sector_t 
>> block)
>> @@ -423,7 +437,9 @@ static ssize_t erofs_file_read_iter(struct kiocb 
>> *iocb, struct iov_iter *to)
>>           return dax_iomap_rw(iocb, to, &erofs_iomap_ops);
>>   #endif
>>       if ((iocb->ki_flags & IOCB_DIRECT) && inode->i_sb->s_bdev) {
>> -        struct erofs_iomap_iter_ctx iter_ctx = {};
>> +        struct erofs_iomap_iter_ctx iter_ctx = {
>> +            .realinode = inode,
>> +        };
>>           return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
>>                       NULL, 0, &iter_ctx, 0);
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index bce98c845a18..8116738fe432 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -215,6 +215,10 @@ static int erofs_fill_inode(struct inode *inode)
>>       case S_IFREG:
>>           inode->i_op = &erofs_generic_iops;
>>           inode->i_fop = &erofs_file_fops;
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> 
> Is that unnecessary?
> 

Yeah, I will remove it in next version.

Thanks,
Hongbo

> It seems erofs_ishare_fill_inode() will return false if
> CONFIG_EROFS_FS_PAGE_CACHE_SHARE is undefined.
> 
> Otherwise it looks good to me,
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Thanks,
> Gao Xiang

