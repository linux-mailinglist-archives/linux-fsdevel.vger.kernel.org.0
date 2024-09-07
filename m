Return-Path: <linux-fsdevel+bounces-28893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6E396FFC8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 05:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CCC11C21812
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 03:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526E8381C2;
	Sat,  7 Sep 2024 03:22:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE041B7E9
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Sep 2024 03:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725679336; cv=none; b=RSF7SUXFNigIU0qCqU851jOW088UPson0vR9zVobFqPm9v+m2jmBYlgZD3yiTaZ61Kj8VpBKn5rPRsh0OX2PwBghwdE0NCyKOiGm/R2KKFYD641apRq/ObO+ay17kZgM/sWRHYA9HJAiPp0yu5vXG+lo837cDiR6ZxvltZ3Si+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725679336; c=relaxed/simple;
	bh=IxTWgfTdDr8etFmWE41tYl7m1owEaJqpVXOHuAepSz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/ucI+jkLVMn3q/lc2stySTD+HyZv6LsDMRBTdZ1UtNGq35mupwteuWhwMDGCSknz4Oc96gH7XtHHjqRkAh2O2U+TP3I6XYy5smAGh4eStdxiTquHdYaQkx35DRPI61vZSxH5lNH46cfCX2EPNCZ4ioe280WHW76XJb/rUvR0vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4X0z0X3wk3z4f3jY5
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Sep 2024 11:21:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B3A441A13E4
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Sep 2024 11:22:03 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgDH+8faxttmh814Ag--.19981S3;
	Sat, 07 Sep 2024 11:22:03 +0800 (CST)
Message-ID: <cc8fc5b3-4cfc-f65a-af46-59cb6cb0c9fb@huaweicloud.com>
Date: Sat, 7 Sep 2024 11:22:02 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH] fuse: enable writeback cgroup to limit dirty page
 cache
To: Yang Erkun <yangerkun@huaweicloud.com>, miklos@szeredi.hu,
 brauner@kernel.org, jack@suse.cz, amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org
References: <20240830120540.2446680-1-yangerkun@huaweicloud.com>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <20240830120540.2446680-1-yangerkun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+8faxttmh814Ag--.19981S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar1xCF13Gw1UWry3KFWUtwb_yoW7Ar1fpF
	13Ka98Ar4fXrWUWrySva1Dur1aqa4xA3y09ryfGa1SvFnrtFyYkasY93WUGr1FyrykJr42
	qF4jkr9xWr1DtwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
	73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

Hi,

Gently ping for this.

Only btrfs/ext2/ext4/f2fs/xfs/blkdev support SB_I_CGROUPWB which can
limit dirty pagecache with memcg's max bytes, and for fs like nfs/cifs
/fuse(and so on) still can not do that. Does this seems a big issue we 
should try to fix...

在 2024/8/30 20:05, Yang Erkun 写道:
> From: Yang Erkun <yangerkun@huawei.com>
> 
> Commit 3be5a52b30aa("fuse: support writable mmap") give a strict limit
> for about 1% max dirty ratio for fuse to protect that fuse won't slow
> down the hole system by hogging lots of dirty memory. It works well for
> system without memcg. But now for system with memcg, since fuse does
> not support writeback cgroup, this max dirty ratio won't work for the
> memcg's max bytes.
> 
> So it seems reasonable to enable writeback cgroup for fuse. Same commit
> as above shows why we manage wb's count within fuse itself. In order to
> support writeback cgroup, we need inode_to_wb to find the right wb,
> and this needs some locks to pretect it. We now choose
> inode->i_mapping->i_pages.xa_lock to do this.
> 
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>   fs/fuse/file.c  | 33 ++++++++++++++++++++++++---------
>   fs/fuse/inode.c |  3 ++-
>   2 files changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index f39456c65ed7..4248eaf46c39 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1774,15 +1774,20 @@ static void fuse_writepage_finish(struct fuse_mount *fm,
>   {
>   	struct fuse_args_pages *ap = &wpa->ia.ap;
>   	struct inode *inode = wpa->inode;
> +	struct address_space *mapping = inode->i_mapping;
>   	struct fuse_inode *fi = get_fuse_inode(inode);
> -	struct backing_dev_info *bdi = inode_to_bdi(inode);
> +	struct bdi_writeback *wb;
> +	unsigned long flags;
>   	int i;
>   
> +	xa_lock_irqsave(&mapping->i_pages, flags);
> +	wb = inode_to_wb(inode);
>   	for (i = 0; i < ap->num_pages; i++) {
> -		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
> +		dec_wb_stat(wb, WB_WRITEBACK);
>   		dec_node_page_state(ap->pages[i], NR_WRITEBACK_TEMP);
> -		wb_writeout_inc(&bdi->wb);
> +		wb_writeout_inc(wb);
>   	}
> +	xa_unlock_irqrestore(&mapping->i_pages, flags);
>   	wake_up(&fi->page_waitq);
>   }
>   
> @@ -2084,8 +2089,10 @@ static int fuse_writepage_locked(struct folio *folio)
>   	ap->args.end = fuse_writepage_end;
>   	wpa->inode = inode;
>   
> -	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
> +	xa_lock(&mapping->i_pages);
> +	inc_wb_stat(inode_to_wb(inode), WB_WRITEBACK);
>   	node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);
> +	xa_unlock(&mapping->i_pages);
>   
>   	spin_lock(&fi->lock);
>   	tree_insert(&fi->writepages, wpa);
> @@ -2169,7 +2176,8 @@ static void fuse_writepages_send(struct fuse_fill_wb_data *data)
>   static bool fuse_writepage_add(struct fuse_writepage_args *new_wpa,
>   			       struct page *page)
>   {
> -	struct fuse_inode *fi = get_fuse_inode(new_wpa->inode);
> +	struct inode *inode = new_wpa->inode;
> +	struct fuse_inode *fi = get_fuse_inode(inode);
>   	struct fuse_writepage_args *tmp;
>   	struct fuse_writepage_args *old_wpa;
>   	struct fuse_args_pages *new_ap = &new_wpa->ia.ap;
> @@ -2204,11 +2212,15 @@ static bool fuse_writepage_add(struct fuse_writepage_args *new_wpa,
>   	spin_unlock(&fi->lock);
>   
>   	if (tmp) {
> -		struct backing_dev_info *bdi = inode_to_bdi(new_wpa->inode);
> +		struct address_space *mapping = inode->i_mapping;
> +		struct bdi_writeback *wb;
>   
> -		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
> +		xa_lock(&mapping->i_pages);
> +		wb = inode_to_wb(new_wpa->inode);
> +		dec_wb_stat(wb, WB_WRITEBACK);
>   		dec_node_page_state(new_ap->pages[0], NR_WRITEBACK_TEMP);
> -		wb_writeout_inc(&bdi->wb);
> +		wb_writeout_inc(wb);
> +		xa_unlock(&mapping->i_pages);
>   		fuse_writepage_free(new_wpa);
>   	}
>   
> @@ -2256,6 +2268,7 @@ static int fuse_writepages_fill(struct folio *folio,
>   	struct fuse_writepage_args *wpa = data->wpa;
>   	struct fuse_args_pages *ap = &wpa->ia.ap;
>   	struct inode *inode = data->inode;
> +	struct address_space *mapping = inode->i_mapping;
>   	struct fuse_inode *fi = get_fuse_inode(inode);
>   	struct fuse_conn *fc = get_fuse_conn(inode);
>   	struct page *tmp_page;
> @@ -2319,8 +2332,10 @@ static int fuse_writepages_fill(struct folio *folio,
>   	ap->descs[ap->num_pages].length = PAGE_SIZE;
>   	data->orig_pages[ap->num_pages] = &folio->page;
>   
> -	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
> +	xa_lock(&mapping->i_pages);
> +	inc_wb_stat(inode_to_wb(inode), WB_WRITEBACK);
>   	inc_node_page_state(tmp_page, NR_WRITEBACK_TEMP);
> +	xa_unlock(&mapping->i_pages);
>   
>   	err = 0;
>   	if (data->wpa) {
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index d8ab4e93916f..71d08f0a8514 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1566,7 +1566,8 @@ static void fuse_sb_defaults(struct super_block *sb)
>   	sb->s_maxbytes = MAX_LFS_FILESIZE;
>   	sb->s_time_gran = 1;
>   	sb->s_export_op = &fuse_export_operations;
> -	sb->s_iflags |= SB_I_IMA_UNVERIFIABLE_SIGNATURE;
> +	sb->s_iflags |= SB_I_IMA_UNVERIFIABLE_SIGNATURE |
> +			SB_I_CGROUPWB;
>   	if (sb->s_user_ns != &init_user_ns)
>   		sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
>   	sb->s_flags &= ~(SB_NOSEC | SB_I_VERSION);


