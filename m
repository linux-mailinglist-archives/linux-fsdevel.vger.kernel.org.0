Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D365103679
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 10:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfKTJTH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 04:19:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:38504 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726689AbfKTJTH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 04:19:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5DDFFB4AD;
        Wed, 20 Nov 2019 09:19:03 +0000 (UTC)
Subject: Re: [PATCH v2 06/13] exfat: add exfat entry operations
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de, sj1557.seo@samsung.com
References: <20191119071107.1947-1-namjae.jeon@samsung.com>
 <CGME20191119071405epcas1p29e1af8242cce221c45eb529921028e48@epcas1p2.samsung.com>
 <20191119071107.1947-7-namjae.jeon@samsung.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <93d33e8b-b75b-61ee-ee74-2257a4ec5acf@suse.com>
Date:   Wed, 20 Nov 2019 11:19:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191119071107.1947-7-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 19.11.19 г. 9:11 ч., Namjae Jeon wrote:
> This adds the implementation of exfat entry operations for exfat.
> 
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> ---
>  fs/exfat/fatent.c | 475 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 475 insertions(+)
>  create mode 100644 fs/exfat/fatent.c
> 
> diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
> new file mode 100644
> index 000000000000..006c513ae5c0
> --- /dev/null
> +++ b/fs/exfat/fatent.c
> @@ -0,0 +1,475 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
> + */
> +
> +#include <linux/slab.h>
> +#include <asm/unaligned.h>
> +#include <linux/buffer_head.h>
> +
> +#include "exfat_raw.h"
> +#include "exfat_fs.h"
> +
> +static int __exfat_ent_get(struct super_block *sb, unsigned int loc,
> +		unsigned int *content)
> +{
> +	unsigned int off, _content;
> +	sector_t sec;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	struct buffer_head *bh;
> +
> +	sec = sbi->FAT1_start_sector + (loc >> (sb->s_blocksize_bits-2));
> +	off = (loc << 2) & (sb->s_blocksize - 1);
> +
> +	bh = sb_bread(sb, sec);
> +	if (!bh)
> +		return -EIO;
> +
> +	_content = le32_to_cpu(*(__le32 *)(&bh->b_data[off]));
> +
> +	/* remap reserved clusters to simplify code */
> +	if (_content >= CLUSTER_32(0xFFFFFFF8))
> +		_content = EOF_CLUSTER;
> +
> +	*content = CLUSTER_32(_content);
> +	brelse(bh);
> +	return 0;
> +}
> +
> +int exfat_ent_set(struct super_block *sb, unsigned int loc,
> +		unsigned int content)
> +{
> +	unsigned int off;
> +	sector_t sec;
> +	__le32 *fat_entry;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	struct buffer_head *bh;
> +
> +	sec = sbi->FAT1_start_sector + (loc >> (sb->s_blocksize_bits-2));
> +	off = (loc << 2) & (sb->s_blocksize - 1);
> +
> +	bh = sb_bread(sb, sec);
> +	if (!bh)
> +		return -EIO;
> +
> +	fat_entry = (__le32 *)&(bh->b_data[off]);
> +	*fat_entry = cpu_to_le32(content);
> +	exfat_update_bh(sb, bh, sb->s_flags & SB_SYNCHRONOUS);
> +	exfat_mirror_bh(sb, sec, bh);
> +	brelse(bh);
> +	return 0;
> +}
> +
> +static inline bool is_reserved_cluster(unsigned int clus)
> +{
> +	if (clus == FREE_CLUSTER || clus == EOF_CLUSTER || clus == BAD_CLUSTER)
> +		return true;
> +	return false;
> +}
> +
> +static inline bool is_valid_cluster(struct exfat_sb_info *sbi,
> +		unsigned int clus)
> +{
> +	if (clus < BASE_CLUSTER || sbi->num_clusters <= clus)
> +		return false;
> +	return true;
> +}
> +
> +int exfat_ent_get(struct super_block *sb, unsigned int loc,
> +		unsigned int *content)
> +{
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	int err;
> +
> +	if (!is_valid_cluster(sbi, loc)) {
> +		exfat_fs_error(sb, "invalid access to FAT (entry 0x%08x)",
> +			loc);
> +		return -EIO;
> +	}
> +
> +	err = __exfat_ent_get(sb, loc, content);
> +	if (err) {
> +		exfat_fs_error(sb,
> +			"failed to access to FAT (entry 0x%08x, err:%d)",
> +			loc, err);
> +		return err;
> +	}
> +
> +	if (!is_reserved_cluster(*content) &&
> +			!is_valid_cluster(sbi, *content)) {
> +		exfat_fs_error(sb,
> +			"invalid access to FAT (entry 0x%08x) bogus content (0x%08x)",
> +			loc, *content);
> +		return -EIO;
> +	}
> +
> +	if (*content == FREE_CLUSTER) {
> +		exfat_fs_error(sb,
> +			"invalid access to FAT free cluster (entry 0x%08x)",
> +			loc);
> +		return -EIO;
> +	}
> +
> +	if (*content == BAD_CLUSTER) {
> +		exfat_fs_error(sb,
> +			"invalid access to FAT bad cluster (entry 0x%08x)",
> +			loc);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +int exfat_chain_cont_cluster(struct super_block *sb, unsigned int chain,
> +		unsigned int len)
> +{
> +	if (!len)
> +		return 0;
> +
> +	while (len > 1) {
> +		if (exfat_ent_set(sb, chain, chain + 1))
> +			return -EIO;
> +		chain++;
> +		len--;
> +	}
> +
> +	if (exfat_ent_set(sb, chain, EOF_CLUSTER))
> +		return -EIO;
> +	return 0;
> +}
> +
> +int exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain)
> +{
> +	unsigned int num_clusters = 0;
> +	unsigned int clu;
> +	struct super_block *sb = inode->i_sb;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +
> +	/* invalid cluster number */
> +	if (p_chain->dir == FREE_CLUSTER || p_chain->dir == EOF_CLUSTER)
> +		return 0;
> +
> +	/* no cluster to truncate */
> +	if (p_chain->size == 0)
> +		return 0;
> +
> +	/* check cluster validation */
> +	if (p_chain->dir < 2 && p_chain->dir >= sbi->num_clusters) {
> +		exfat_msg(sb, KERN_ERR, "invalid start cluster (%u)",
> +				p_chain->dir);
> +		return -EIO;
> +	}
> +
> +	WRITE_ONCE(sbi->s_dirt, true);
> +	clu = p_chain->dir;
> +
> +	if (p_chain->flags == 0x03) {

magic constant

> +		do {
> +			exfat_clear_bitmap(inode, clu-2);
> +			clu++;
> +
> +			num_clusters++;
> +		} while (num_clusters < p_chain->size);
> +	} else {
> +		do {
> +			exfat_clear_bitmap(inode, (clu - BASE_CLUSTER));
> +
> +			if (exfat_get_next_cluster(sb, &clu))
> +				goto out;
> +
> +			num_clusters++;
> +		} while (clu != EOF_CLUSTER);
> +	}
> +
> +out:
> +	sbi->used_clusters -= num_clusters;
> +	return 0;
> +}
> +
> +int exfat_find_last_cluster(struct super_block *sb, struct exfat_chain *p_chain,
> +		unsigned int *ret_clu)
> +{
> +	unsigned int clu, next;
> +	unsigned int count = 0;
> +
> +	next = p_chain->dir;
> +	if (p_chain->flags == 0x03) {

ditto

> +		*ret_clu = next + p_chain->size - 1;
> +		return 0;
> +	}
> +
> +	do {
> +		count++;
> +		clu = next;
> +		if (exfat_ent_get(sb, clu, &next))
> +			return -EIO;
> +	} while (next != EOF_CLUSTER);
> +
> +	if (p_chain->size != count) {
> +		exfat_fs_error(sb,
> +			"bogus directory size (clus : ondisk(%d) != counted(%d))",
> +			p_chain->size, count);
> +		return -EIO;
> +	}
> +
> +	*ret_clu = clu;
> +	return 0;
> +}
> +
> +static inline int exfat_sync_bhs(struct buffer_head **bhs, int nr_bhs)
> +{
> +	int i, err = 0;
> +
> +	for (i = 0; i < nr_bhs; i++)
> +		write_dirty_buffer(bhs[i], 0);
> +
> +	for (i = 0; i < nr_bhs; i++) {
> +		wait_on_buffer(bhs[i]);
> +		if (!err && !buffer_uptodate(bhs[i]))
> +			err = -EIO;
> +	}
> +	return err;
> +}
> +
> +int exfat_zeroed_cluster(struct inode *dir, unsigned int clu)
> +{
> +	struct super_block *sb = dir->i_sb;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
> +	int nr_bhs = MAX_BUF_PER_PAGE;
> +	sector_t blknr, last_blknr;
> +	int err, i, n;
> +
> +	blknr = exfat_cluster_to_sector(sbi, clu);
> +	last_blknr = blknr + sbi->sect_per_clus;
> +
> +	if (last_blknr > sbi->num_sectors && sbi->num_sectors > 0) {
> +		exfat_fs_error_ratelimit(sb,
> +			"%s: out of range(sect:%llu len:%u)",
> +			__func__, (unsigned long long)blknr,
> +			sbi->sect_per_clus);
> +		return -EIO;
> +	}
> +
> +	/* Zeroing the unused blocks on this cluster */
> +	n = 0;
> +	while (blknr < last_blknr) {
> +		bhs[n] = sb_getblk(sb, blknr);
> +		if (!bhs[n]) {
> +			err = -ENOMEM;
> +			goto error;
> +		}
> +		memset(bhs[n]->b_data, 0, sb->s_blocksize);
> +		exfat_update_bh(sb, bhs[n], 0);
> +
> +		n++;
> +		blknr++;
> +
> +		if (n == nr_bhs) {
> +			if (IS_DIRSYNC(dir)) {
> +				err = exfat_sync_bhs(bhs, n);
> +				if (err)
> +					goto error;
> +			}
> +
> +			for (i = 0; i < n; i++)
> +				brelse(bhs[i]);
> +			n = 0;
> +		}
> +	}
> +
> +	if (IS_DIRSYNC(dir)) {
> +		err = exfat_sync_bhs(bhs, n);
> +		if (err)
> +			goto error;
> +	}
> +
> +	for (i = 0; i < n; i++)
> +		brelse(bhs[i]);
> +
> +	return 0;
> +
> +error:
> +	exfat_msg(sb, KERN_ERR, "failed zeroed sect %llu\n",
> +		(unsigned long long)blknr);
> +	for (i = 0; i < n; i++)
> +		bforget(bhs[i]);
> +
> +	return err;
> +}
> +
> +int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
> +		struct exfat_chain *p_chain)
> +{
> +	int ret = -ENOSPC;
> +	unsigned int num_clusters = 0, total_cnt;
> +	unsigned int hint_clu, new_clu, last_clu = EOF_CLUSTER;
> +	struct super_block *sb = inode->i_sb;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +
> +	total_cnt = sbi->num_clusters - BASE_CLUSTER;
> +
> +	if (unlikely(total_cnt < sbi->used_clusters)) {
> +		exfat_fs_error_ratelimit(sb,
> +			"%s: invalid used clusters(t:%u,u:%u)\n",
> +			__func__, total_cnt, sbi->used_clusters);
> +		return -EIO;
> +	}
> +
> +	if (num_alloc > total_cnt - sbi->used_clusters)
> +		return -ENOSPC;
> +
> +	hint_clu = p_chain->dir;
> +	/* find new cluster */
> +	if (hint_clu == EOF_CLUSTER) {
> +		if (sbi->clu_srch_ptr < BASE_CLUSTER) {
> +			exfat_msg(sb, KERN_ERR,
> +				"sbi->clu_srch_ptr is invalid (%u)\n",
> +				sbi->clu_srch_ptr);
> +			sbi->clu_srch_ptr = BASE_CLUSTER;
> +		}
> +
> +		hint_clu = exfat_test_bitmap(sb,
> +				sbi->clu_srch_ptr - BASE_CLUSTER);
> +		if (hint_clu == EOF_CLUSTER)
> +			return -ENOSPC;
> +	}
> +
> +	/* check cluster validation */
> +	if (hint_clu < BASE_CLUSTER && hint_clu >= sbi->num_clusters) {
> +		exfat_msg(sb, KERN_ERR, "hint_cluster is invalid (%u)\n",
> +			hint_clu);
> +		hint_clu = BASE_CLUSTER;
> +		if (p_chain->flags == 0x03) {
ditto
> +			if (exfat_chain_cont_cluster(sb, p_chain->dir,
> +					num_clusters))
> +				return -EIO;
> +			p_chain->flags = 0x01;
ditto
> +		}
> +	}
> +
> +	WRITE_ONCE(sbi->s_dirt, true);
> +
> +	p_chain->dir = EOF_CLUSTER;
> +
> +	while ((new_clu = exfat_test_bitmap(sb,
> +			hint_clu - BASE_CLUSTER)) != EOF_CLUSTER) {
> +		if (new_clu != hint_clu && p_chain->flags == 0x03) {
ditto
> +			if (exfat_chain_cont_cluster(sb, p_chain->dir,
> +					num_clusters)) {
> +				ret = -EIO;
> +				goto error;
> +			}
> +			p_chain->flags = 0x01;
ditto
> +		}
> +
> +		/* update allocation bitmap */
> +		if (exfat_set_bitmap(inode, new_clu - BASE_CLUSTER)) {
> +			ret = -EIO;
> +			goto error;
> +		}
> +
> +		num_clusters++;
> +
> +		/* update FAT table */
> +		if (p_chain->flags == 0x01) {
ditto
> +			if (exfat_ent_set(sb, new_clu, EOF_CLUSTER)) {
> +				ret = -EIO;
> +				goto error;
> +			}
> +		}
> +
> +		if (p_chain->dir == EOF_CLUSTER) {
> +			p_chain->dir = new_clu;
> +		} else if (p_chain->flags == 0x01) {
ditto
> +			if (exfat_ent_set(sb, last_clu, new_clu)) {
> +				ret = -EIO;
> +				goto error;
> +			}
> +		}
> +		last_clu = new_clu;
> +
> +		if (--num_alloc == 0) {
> +			sbi->clu_srch_ptr = hint_clu;
> +			sbi->used_clusters += num_clusters;
> +
> +			p_chain->size += num_clusters;
> +			return 0;
> +		}
> +
> +		hint_clu = new_clu + 1;
> +		if (hint_clu >= sbi->num_clusters) {
> +			hint_clu = BASE_CLUSTER;
> +
> +			if (p_chain->flags == 0x03) {
ditto
> +				if (exfat_chain_cont_cluster(sb, p_chain->dir,
> +						num_clusters)) {
> +					ret = -EIO;
> +					goto error;
> +				}
> +				p_chain->flags = 0x01;
ditto
> +			}
> +		}
> +	}
> +error:
> +	if (num_clusters)
> +		exfat_free_cluster(inode, p_chain);
> +	return ret;
> +}
> +
> +int exfat_count_num_clusters(struct super_block *sb,
> +		struct exfat_chain *p_chain, unsigned int *ret_count)
> +{
> +	unsigned int i, count;
> +	unsigned int clu;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +
> +	if (!p_chain->dir || p_chain->dir == EOF_CLUSTER) {
> +		*ret_count = 0;
> +		return 0;
> +	}
> +
> +	if (p_chain->flags == 0x03) {
ditto
> +		*ret_count = p_chain->size;
> +		return 0;
> +	}
> +
> +	clu = p_chain->dir;
> +	count = 0;
> +	for (i = BASE_CLUSTER; i < sbi->num_clusters; i++) {
> +		count++;
> +		if (exfat_ent_get(sb, clu, &clu))
> +			return -EIO;
> +		if (clu == EOF_CLUSTER)
> +			break;
> +	}
> +
> +	*ret_count = count;
> +	return 0;
> +}
> +
> +int exfat_mirror_bh(struct super_block *sb, sector_t sec,
> +		struct buffer_head *bh)
> +{
> +	struct buffer_head *c_bh;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	sector_t sec2;
> +	int err = 0;
> +
> +	if (sbi->FAT2_start_sector != sbi->FAT1_start_sector) {
> +		sec2 = sec - sbi->FAT1_start_sector + sbi->FAT2_start_sector;
> +		c_bh = sb_getblk(sb, sec2);
> +		if (!c_bh) {
> +			err = -ENOMEM;
> +			goto out;
> +		}
> +		memcpy(c_bh->b_data, bh->b_data, sb->s_blocksize);
> +		set_buffer_uptodate(c_bh);
> +		mark_buffer_dirty(c_bh);
> +		if (sb->s_flags & SB_SYNCHRONOUS)
> +			err = sync_dirty_buffer(c_bh);
> +		brelse(c_bh);
> +	}
> +out:
> +	return err;
> +}
> 
