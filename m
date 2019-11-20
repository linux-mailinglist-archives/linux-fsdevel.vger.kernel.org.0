Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFFA10368E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 10:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfKTJYG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 04:24:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:41298 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726762AbfKTJYF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 04:24:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C0DCFAFBE;
        Wed, 20 Nov 2019 09:24:02 +0000 (UTC)
Subject: Re: [PATCH v2 07/13] exfat: add bitmap operations
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de, sj1557.seo@samsung.com
References: <20191119071107.1947-1-namjae.jeon@samsung.com>
 <CGME20191119071405epcas1p2c282cb850ef14d181208554796403739@epcas1p2.samsung.com>
 <20191119071107.1947-8-namjae.jeon@samsung.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <09920df0-ff2d-72f9-b82f-21e0ac5499ac@suse.com>
Date:   Wed, 20 Nov 2019 11:24:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191119071107.1947-8-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 19.11.19 г. 9:11 ч., Namjae Jeon wrote:
> This adds the implementation of bitmap operations for exfat.
> 
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> ---
>  fs/exfat/balloc.c | 271 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 271 insertions(+)
>  create mode 100644 fs/exfat/balloc.c
> 
> diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
> new file mode 100644
> index 000000000000..930e0ea3dbfd
> --- /dev/null
> +++ b/fs/exfat/balloc.c
> @@ -0,0 +1,271 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
> + */
> +
> +#include <linux/blkdev.h>
> +#include <linux/slab.h>
> +#include <linux/buffer_head.h>
> +
> +#include "exfat_raw.h"
> +#include "exfat_fs.h"
> +
> +static const unsigned char free_bit[] = {
> +	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2,/*  0 ~  19*/
> +	0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 5, 0, 1, 0, 2, 0, 1, 0, 3,/* 20 ~  39*/
> +	0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2,/* 40 ~  59*/
> +	0, 1, 0, 6, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4,/* 60 ~  79*/
> +	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 5, 0, 1, 0, 2,/* 80 ~  99*/
> +	0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3,/*100 ~ 119*/
> +	0, 1, 0, 2, 0, 1, 0, 7, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2,/*120 ~ 139*/
> +	0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 5,/*140 ~ 159*/
> +	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2,/*160 ~ 179*/
> +	0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 6, 0, 1, 0, 2, 0, 1, 0, 3,/*180 ~ 199*/
> +	0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2,/*200 ~ 219*/
> +	0, 1, 0, 5, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4,/*220 ~ 239*/
> +	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0                /*240 ~ 254*/
> +};
> +
> +static const unsigned char used_bit[] = {
> +	0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4, 1, 2, 2, 3,/*  0 ~  19*/
> +	2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, 1, 2, 2, 3, 2, 3, 3, 4,/* 20 ~  39*/
> +	2, 3, 3, 4, 3, 4, 4, 5, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5,/* 40 ~  59*/
> +	4, 5, 5, 6, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,/* 60 ~  79*/
> +	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 2, 3, 3, 4,/* 80 ~  99*/
> +	3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5, 4, 5, 5, 6,/*100 ~ 119*/
> +	4, 5, 5, 6, 5, 6, 6, 7, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4,/*120 ~ 139*/
> +	3, 4, 4, 5, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,/*140 ~ 159*/
> +	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5,/*160 ~ 179*/
> +	4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7, 2, 3, 3, 4, 3, 4, 4, 5,/*180 ~ 199*/
> +	3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6,/*200 ~ 219*/
> +	5, 6, 6, 7, 3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,/*220 ~ 239*/
> +	4, 5, 5, 6, 5, 6, 6, 7, 5, 6, 6, 7, 6, 7, 7, 8             /*240 ~ 255*/
> +};
> +
> +/*
> + *  Allocation Bitmap Management Functions
> + */
> +static int exfat_allocate_bitmap(struct super_block *sb,
> +		struct exfat_dentry *ep)
> +{
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	long long map_size;
> +	unsigned int i, need_map_size;
> +	sector_t sector;
> +
> +	sbi->map_clu = le32_to_cpu(ep->bitmap_start_clu);
> +	map_size = le64_to_cpu(ep->bitmap_size);
> +	need_map_size = (((sbi->num_clusters - BASE_CLUSTER) - 1) >> 3) + 1;
> +	if (need_map_size != map_size) {
> +		exfat_msg(sb, KERN_ERR,
> +				"bogus allocation bitmap size(need : %u, cur : %lld)",
> +				need_map_size, map_size);
> +		/*
> +		 * Only allowed when bogus allocation
> +		 * bitmap size is large
> +		 */
> +		if (need_map_size > map_size)
> +			return -EIO;
> +	}
> +	sbi->map_sectors = ((need_map_size - 1) >>
> +			(sb->s_blocksize_bits)) + 1;
> +	sbi->vol_amap = kmalloc_array(sbi->map_sectors,
> +				sizeof(struct buffer_head *), GFP_KERNEL);
> +	if (!sbi->vol_amap)
> +		return -ENOMEM;
> +
> +	sector = exfat_cluster_to_sector(sbi, sbi->map_clu);
> +	for (i = 0; i < sbi->map_sectors; i++) {
> +		sbi->vol_amap[i] = sb_bread(sb, sector + i);
> +		if (!sbi->vol_amap[i]) {
> +			/* release all buffers and free vol_amap */
> +			int j = 0;
> +
> +			while (j < i)
> +				brelse(sbi->vol_amap[j++]);
> +
> +			kfree(sbi->vol_amap);
> +			sbi->vol_amap = NULL;
> +			return -EIO;
> +		}
> +	}
> +
> +	sbi->pbr_bh = NULL;
> +	return 0;
> +}
> +
> +int exfat_load_bitmap(struct super_block *sb)
> +{
> +	unsigned int i, type;
> +	struct exfat_chain clu;
> +	struct exfat_dentry *ep = NULL;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	struct buffer_head *bh;
> +
> +	exfat_chain_set(&clu, sbi->root_dir, 0, 0x01);

magic constant for the 4th parameter
> +
> +	while (clu.dir != EOF_CLUSTER) {
> +		for (i = 0; i < sbi->dentries_per_clu; i++) {
> +			ep = exfat_get_dentry(sb, &clu, i, &bh, NULL);
> +			if (!ep)
> +				return -EIO;
> +
> +			type = exfat_get_entry_type(ep);
> +			if (type == TYPE_UNUSED)
> +				break;
> +			if (type != TYPE_BITMAP)
> +				continue;
> +			if (ep->bitmap_flags == 0x0) {
> +				int err;
> +
> +				err = exfat_allocate_bitmap(sb, ep);
> +				brelse(bh);
> +				return err;
> +			}
> +		}
> +
> +		if (exfat_get_next_cluster(sb, &clu.dir))
> +			return -EIO;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +void exfat_free_bitmap(struct super_block *sb)
> +{
> +	int i;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +
> +	brelse(sbi->pbr_bh);
> +
> +	for (i = 0; i < sbi->map_sectors; i++)
> +		__brelse(sbi->vol_amap[i]);
> +
> +	kfree(sbi->vol_amap);
> +	sbi->vol_amap = NULL;
> +}
> +
> +/*
> + * If the value of "clu" is 0, it means cluster 2 which is the first cluster of
> + * the cluster heap.
> + */
> +int exfat_set_bitmap(struct inode *inode, unsigned int clu)
> +{
> +	int i, b;
> +	struct super_block *sb = inode->i_sb;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +
> +	i = clu >> (sb->s_blocksize_bits + 3);
> +	b = clu & ((sb->s_blocksize << 3) - 1);
> +
> +	set_bit_le(b, sbi->vol_amap[i]->b_data);
> +	exfat_update_bh(sb, sbi->vol_amap[i], IS_DIRSYNC(inode));
> +
> +	return 0;
> +}
> +
> +/*
> + * If the value of "clu" is 0, it means cluster 2 which is the first cluster of
> + * the cluster heap.
> + */
> +void exfat_clear_bitmap(struct inode *inode, unsigned int clu)
> +{
> +	int i, b;
> +	struct super_block *sb = inode->i_sb;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	struct exfat_mount_options *opts = &sbi->options;
> +
> +	i = clu >> (sb->s_blocksize_bits + 3);
> +	b = clu & ((sb->s_blocksize << 3) - 1);
> +
> +	clear_bit_le(b, sbi->vol_amap[i]->b_data);
> +	exfat_update_bh(sb, sbi->vol_amap[i], IS_DIRSYNC(inode));
> +
> +	if (opts->discard) {
> +		int ret_discard;
> +
> +		ret_discard = sb_issue_discard(sb,
> +				exfat_cluster_to_sector(sbi, clu + 2),
> +				(1 << sbi->sect_per_clus_bits), GFP_NOFS, 0);
> +
> +		if (ret_discard == -EOPNOTSUPP) {
> +			exfat_msg(sb, KERN_ERR,
> +				"discard not supported by device, disabling");
> +			opts->discard = 0;
> +		}
> +	}
> +}
> +
> +/*
> + * If the value of "clu" is 0, it means cluster 2 which is the first cluster of
> + * the cluster heap.
> + */
> +unsigned int exfat_test_bitmap(struct super_block *sb, unsigned int clu)
> +{
> +	unsigned int i, map_i, map_b;
> +	unsigned int clu_base, clu_free;
> +	unsigned char k, clu_mask;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +
> +	clu_base = (clu & ~(0x7)) + 2;
> +	clu_mask = (1 << (clu - clu_base + 2)) - 1;
> +
> +	map_i = clu >> (sb->s_blocksize_bits + 3);
> +	map_b = (clu >> 3) & (unsigned int)(sb->s_blocksize - 1);
> +
> +	for (i = 2; i < sbi->num_clusters; i += 8) {
> +		k = *(sbi->vol_amap[map_i]->b_data + map_b);
> +		if (clu_mask > 0) {
> +			k |= clu_mask;
> +			clu_mask = 0;
> +		}
> +		if (k < 0xFF) {
> +			clu_free = clu_base + free_bit[k];
> +			if (clu_free < sbi->num_clusters)
> +				return clu_free;
> +		}
> +		clu_base += 8;
> +
> +		if (++map_b >= sb->s_blocksize ||
> +		    clu_base >= sbi->num_clusters) {
> +			if (++map_i >= sbi->map_sectors) {
> +				clu_base = 2;
> +				map_i = 0;
> +			}
> +			map_b = 0;
> +		}
> +	}
> +
> +	return EOF_CLUSTER;
> +}
> +
> +int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count)
> +{
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	unsigned int count = 0;
> +	unsigned int i, map_i = 0, map_b = 0;
> +	unsigned int total_clus = sbi->num_clusters - 2;
> +	unsigned int last_mask = total_clus & 7;
> +	unsigned char clu_bits;
> +	const unsigned char last_bit_mask[] = {0, 0b00000001, 0b00000011,
> +		0b00000111, 0b00001111, 0b00011111, 0b00111111, 0b01111111};
> +
> +	total_clus &= ~last_mask;
> +	for (i = 0; i < total_clus; i += 8) {
> +		clu_bits = *(sbi->vol_amap[map_i]->b_data + map_b);
> +		count += used_bit[clu_bits];
> +		if (++map_b >= (unsigned int)sb->s_blocksize) {
> +			map_i++;
> +			map_b = 0;
> +		}
> +	}
> +
> +	if (last_mask) {
> +		clu_bits = *(sbi->vol_amap[map_i]->b_data + map_b);
> +		clu_bits &= last_bit_mask[last_mask];
> +		count += used_bit[clu_bits];
> +	}
> +
> +	*ret_count = count;
> +	return 0;
> +}
> 
