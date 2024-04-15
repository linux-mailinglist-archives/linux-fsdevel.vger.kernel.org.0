Return-Path: <linux-fsdevel+bounces-16896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 527478A4675
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 03:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B240E1F21CA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 01:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F536748A;
	Mon, 15 Apr 2024 01:12:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E04633CA;
	Mon, 15 Apr 2024 01:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713143539; cv=none; b=CkfJQtNWAPhJbZb5FfXlIp9Uu66+hxQMU59Q0w355EdwK6KhkNDQd4Nsh5p9WMs8mZYuUKHYQWORvgyjFRKIYj7VgJxA0lJ3Q3r6YnUnLrdLeFzWW01ued4+QFMXh1Jp6vytuLkBqKnRSMiSrYQ6h+GKbiq825UfaLd/lBHn5Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713143539; c=relaxed/simple;
	bh=rHd+SpLhsrhPHmqesZ7e0CIStGoBSblWtlRhPMJ+jNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pkSPn2fkavAwwMc97/f/OwUZJ0G97fyMgSo5ADdxI9Kp+42SX8bEKjHI2Z0M7yzOGlqwe1bvwdwD3fZOXQ6C5af0zn9htIQWnu+m1m19bd7XreNTVyWBJjRDH+Y/4LSl1Vc5Wch7Mze+aPdg6/jVW8ziNkt2X1fRlCQyPG3tW3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VHpwX3HRwz2CcR6;
	Mon, 15 Apr 2024 09:09:16 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C93B1A0190;
	Mon, 15 Apr 2024 09:12:12 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 09:12:12 +0800
Message-ID: <d7e9f196-c3bd-47ca-87fb-b21f28f1680a@huawei.com>
Date: Mon, 15 Apr 2024 09:12:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bcachefs: bch_member.btree_allocated_bitmap
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>,
	<linux-bcachefs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240413215723.1543569-1-kent.overstreet@linux.dev>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240413215723.1543569-1-kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/4/14 5:57, Kent Overstreet wrote:
> For those interested, this is a good tour of the facilities for rolling
> out new on disk format features.
> 
> -- >8 --
> 
> This adds a small (64 bit) per-device bitmap that tracks ranges that
> have btree nodes, for accelerating btree node scan if it is ever needed.
> 
> - New helpers, bch2_dev_btree_bitmap_marked() and
>    bch2_dev_bitmap_mark(), for checking and updating the bitmap
> 
> - Interior btree update path updates the bitmaps when required
> 
> - The check_allocations pass has a new fsck_err check,
>    btree_bitmap_not_marked
> 
> - New on disk format version, mi_btree_mitmap, which indicates the new
>    bitmap is present
> 
> - Upgrade table lists the required recovery pass and expected fsck error
> 
> - Btree node scan uses the bitmap to skip ranges if we're on the new
>    version
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>   fs/bcachefs/bcachefs_format.h       |  7 ++--
>   fs/bcachefs/btree_gc.c              | 13 +++++++
>   fs/bcachefs/btree_node_scan.c       |  9 +++--
>   fs/bcachefs/btree_update_interior.c | 24 +++++++++++++
>   fs/bcachefs/sb-downgrade.c          |  5 ++-
>   fs/bcachefs/sb-errors_types.h       |  3 +-
>   fs/bcachefs/sb-members.c            | 53 +++++++++++++++++++++++++++++
>   fs/bcachefs/sb-members.h            | 21 ++++++++++++
>   fs/bcachefs/sb-members_types.h      |  2 ++
>   9 files changed, 131 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_format.h
> index 9480f1b44f07..085987435a5e 100644
> --- a/fs/bcachefs/bcachefs_format.h
> +++ b/fs/bcachefs/bcachefs_format.h
> @@ -578,7 +578,8 @@ struct bch_member {
>   	__le64			nbuckets;	/* device size */
>   	__le16			first_bucket;   /* index of first bucket used */
>   	__le16			bucket_size;	/* sectors */
> -	__le32			pad;
> +	__u8			btree_bitmap_shift;
> +	__u8			pad[3];
>   	__le64			last_mount;	/* time_t */
>   
>   	__le64			flags;
> @@ -587,6 +588,7 @@ struct bch_member {
>   	__le64			errors_at_reset[BCH_MEMBER_ERROR_NR];
>   	__le64			errors_reset_time;
>   	__le64			seq;
> +	__le64			btree_allocated_bitmap;
>   };
>   
>   #define BCH_MEMBER_V1_BYTES	56
> @@ -876,7 +878,8 @@ struct bch_sb_field_downgrade {
>   	x(rebalance_work,		BCH_VERSION(1,  3))		\
>   	x(member_seq,			BCH_VERSION(1,  4))		\
>   	x(subvolume_fs_parent,		BCH_VERSION(1,  5))		\
> -	x(btree_subvolume_children,	BCH_VERSION(1,  6))
> +	x(btree_subvolume_children,	BCH_VERSION(1,  6))		\
> +	x(mi_btree_bitmap,		BCH_VERSION(1,  7))
>   
>   enum bcachefs_metadata_version {
>   	bcachefs_metadata_version_min = 9,
> diff --git a/fs/bcachefs/btree_gc.c b/fs/bcachefs/btree_gc.c
> index 10c41cf89212..a77c723a9cef 100644
> --- a/fs/bcachefs/btree_gc.c
> +++ b/fs/bcachefs/btree_gc.c
> @@ -822,6 +822,7 @@ static int bch2_gc_mark_key(struct btree_trans *trans, enum btree_id btree_id,
>   	struct bch_fs *c = trans->c;
>   	struct bkey deleted = KEY(0, 0, 0);
>   	struct bkey_s_c old = (struct bkey_s_c) { &deleted, NULL };
> +	struct printbuf buf = PRINTBUF;
>   	int ret = 0;
>   
>   	deleted.p = k->k->p;
> @@ -842,11 +843,23 @@ static int bch2_gc_mark_key(struct btree_trans *trans, enum btree_id btree_id,
>   	if (ret)
>   		goto err;
>   
> +	if (mustfix_fsck_err_on(level && !bch2_dev_btree_bitmap_marked(c, *k),
> +				c, btree_bitmap_not_marked,
> +				"btree ptr not marked in member info btree allocated bitmap\n  %s",
> +				(bch2_bkey_val_to_text(&buf, c, *k),
> +				 buf.buf))) {
> +		mutex_lock(&c->sb_lock);
> +		bch2_dev_btree_bitmap_mark(c, *k);
> +		bch2_write_super(c);
> +		mutex_unlock(&c->sb_lock);
> +	}
> +
>   	ret = commit_do(trans, NULL, NULL, 0,
>   			bch2_key_trigger(trans, btree_id, level, old,
>   					 unsafe_bkey_s_c_to_s(*k), BTREE_TRIGGER_gc));
>   fsck_err:
>   err:
> +	printbuf_exit(&buf);
>   	bch_err_fn(c, ret);
>   	return ret;
>   }
> diff --git a/fs/bcachefs/btree_node_scan.c b/fs/bcachefs/btree_node_scan.c
> index 20f2b37c4474..866bd278439f 100644
> --- a/fs/bcachefs/btree_node_scan.c
> +++ b/fs/bcachefs/btree_node_scan.c
> @@ -205,8 +205,13 @@ static int read_btree_nodes_worker(void *p)
>   				last_print = jiffies;
>   			}
>   
> -			try_read_btree_node(w->f, ca, bio, buf,
> -					    bucket * ca->mi.bucket_size + bucket_offset);
> +			u64 sector = bucket * ca->mi.bucket_size + bucket_offset;
> +
> +			if (c->sb.version_upgrade_complete >= bcachefs_metadata_version_mi_btree_bitmap &&
> +			    !bch2_dev_btree_bitmap_marked_sectors(ca, sector, btree_sectors(c)))
> +				continue;
> +
> +			try_read_btree_node(w->f, ca, bio, buf, sector);
>   		}
>   err:
>   	bio_put(bio);
> diff --git a/fs/bcachefs/btree_update_interior.c b/fs/bcachefs/btree_update_interior.c
> index 593241b15aa8..12ce6287416f 100644
> --- a/fs/bcachefs/btree_update_interior.c
> +++ b/fs/bcachefs/btree_update_interior.c
> @@ -21,6 +21,7 @@
>   #include "keylist.h"
>   #include "recovery_passes.h"
>   #include "replicas.h"
> +#include "sb-members.h"
>   #include "super-io.h"
>   #include "trace.h"
>   
> @@ -644,6 +645,26 @@ static int btree_update_nodes_written_trans(struct btree_trans *trans,
>   	return 0;
>   }
>   
> +static bool btree_update_new_nodes_marked_sb(struct btree_update *as)
> +{
> +	for_each_keylist_key(&as->new_keys, k)
> +		if (!bch2_dev_btree_bitmap_marked(as->c, bkey_i_to_s_c(k)))
> +			return false;
> +	return true;
> +}
> +
> +static void btree_update_new_nodes_mark_sb(struct btree_update *as)
> +{
> +	struct bch_fs *c = as->c;
> +
> +	mutex_lock(&c->sb_lock);
> +	for_each_keylist_key(&as->new_keys, k)
> +		bch2_dev_btree_bitmap_mark(c, bkey_i_to_s_c(k));
> +
> +	bch2_write_super(c);
> +	mutex_unlock(&c->sb_lock);
> +}
> +
>   static void btree_update_nodes_written(struct btree_update *as)
>   {
>   	struct bch_fs *c = as->c;
> @@ -664,6 +685,9 @@ static void btree_update_nodes_written(struct btree_update *as)
>   	if (ret)
>   		goto err;
>   
> +	if (!btree_update_new_nodes_marked_sb(as))
> +		btree_update_new_nodes_mark_sb(as);
> +
>   	/*
>   	 * Wait for any in flight writes to finish before we free the old nodes
>   	 * on disk:
> diff --git a/fs/bcachefs/sb-downgrade.c b/fs/bcachefs/sb-downgrade.c
> index 56ac8f35cdc3..90b06f8aa1df 100644
> --- a/fs/bcachefs/sb-downgrade.c
> +++ b/fs/bcachefs/sb-downgrade.c
> @@ -51,7 +51,10 @@
>   	  BCH_FSCK_ERR_subvol_fs_path_parent_wrong)		\
>   	x(btree_subvolume_children,				\
>   	  BIT_ULL(BCH_RECOVERY_PASS_check_subvols),		\
> -	  BCH_FSCK_ERR_subvol_children_not_set)
> +	  BCH_FSCK_ERR_subvol_children_not_set)			\
> +	x(mi_btree_bitmap,					\
> +	  BIT_ULL(BCH_RECOVERY_PASS_check_allocations),		\
> +	  BCH_FSCK_ERR_btree_bitmap_not_marked)
>   
>   #define DOWNGRADE_TABLE()
>   
> diff --git a/fs/bcachefs/sb-errors_types.h b/fs/bcachefs/sb-errors_types.h
> index d7d609131030..5b600c6d7aca 100644
> --- a/fs/bcachefs/sb-errors_types.h
> +++ b/fs/bcachefs/sb-errors_types.h
> @@ -270,7 +270,8 @@
>   	x(btree_ptr_v2_min_key_bad,				262)	\
>   	x(btree_root_unreadable_and_scan_found_nothing,		263)	\
>   	x(snapshot_node_missing,				264)	\
> -	x(dup_backpointer_to_bad_csum_extent,			265)
> +	x(dup_backpointer_to_bad_csum_extent,			265)	\
> +	x(btree_bitmap_not_marked,				266)
>   
>   enum bch_sb_error_id {
>   #define x(t, n) BCH_FSCK_ERR_##t = n,
> diff --git a/fs/bcachefs/sb-members.c b/fs/bcachefs/sb-members.c
> index 9b7a2f300182..d5937aba0910 100644
> --- a/fs/bcachefs/sb-members.c
> +++ b/fs/bcachefs/sb-members.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
>   #include "bcachefs.h"
> +#include "btree_cache.h"
>   #include "disk_groups.h"
>   #include "opts.h"
>   #include "replicas.h"
> @@ -378,3 +379,55 @@ void bch2_dev_errors_reset(struct bch_dev *ca)
>   	bch2_write_super(c);
>   	mutex_unlock(&c->sb_lock);
>   }
> +
> +/*
> + * Per member "range has btree nodes" bitmap:
> + *
> + * This is so that if we ever have to run the btree node scan to repair we don't
> + * have to scan full devices:
> + */
> +
> +bool bch2_dev_btree_bitmap_marked(struct bch_fs *c, struct bkey_s_c k)
> +{
> +	bkey_for_each_ptr(bch2_bkey_ptrs_c(k), ptr)
> +		if (!bch2_dev_btree_bitmap_marked_sectors(bch2_dev_bkey_exists(c, ptr->dev),
> +							  ptr->offset, btree_sectors(c)))
> +			return false;
> +	return true;
> +}
> +
> +static void __bch2_dev_btree_bitmap_mark(struct bch_sb_field_members_v2 *mi, unsigned dev,
> +				u64 start, unsigned sectors)
> +{
> +	struct bch_member *m = __bch2_members_v2_get_mut(mi, dev);
> +	u64 bitmap = le64_to_cpu(m->btree_allocated_bitmap);
> +
> +	u64 end = start + sectors;
> +
> +	int resize = ilog2(roundup_pow_of_two(end)) - (m->btree_bitmap_shift + 6);
> +	if (resize > 0) {
> +		u64 new_bitmap = 0;
> +
> +		for (unsigned i = 0; i < 64; i++)
> +			if (bitmap & BIT_ULL(i))
> +				new_bitmap |= BIT_ULL(i >> resize);
> +		bitmap = new_bitmap;
> +		m->btree_bitmap_shift += resize;
> +	}
> +
> +	for (unsigned bit = sectors >> m->btree_bitmap_shift;
> +	     bit << m->btree_bitmap_shift < end;
> +	     bit++)
> +		bitmap |= BIT_ULL(bit);
> +
> +	m->btree_allocated_bitmap = cpu_to_le64(bitmap);
> +}
> +
> +void bch2_dev_btree_bitmap_mark(struct bch_fs *c, struct bkey_s_c k)
> +{
> +	lockdep_assert_held(&c->sb_lock);
> +
> +	struct bch_sb_field_members_v2 *mi = bch2_sb_field_get(c->disk_sb.sb, members_v2);
> +	bkey_for_each_ptr(bch2_bkey_ptrs_c(k), ptr)
> +		__bch2_dev_btree_bitmap_mark(mi, ptr->dev, ptr->offset, btree_sectors(c));
> +}
> diff --git a/fs/bcachefs/sb-members.h b/fs/bcachefs/sb-members.h
> index bc3bcfef7b3a..8bbad30a4370 100644
> --- a/fs/bcachefs/sb-members.h
> +++ b/fs/bcachefs/sb-members.h
> @@ -3,6 +3,7 @@
>   #define _BCACHEFS_SB_MEMBERS_H
>   
>   #include "darray.h"
> +#include "bkey_types.h"
>   
>   extern char * const bch2_member_error_strs[];
>   
> @@ -234,6 +235,8 @@ static inline struct bch_member_cpu bch2_mi_to_cpu(struct bch_member *mi)
>   			: 1,
>   		.freespace_initialized = BCH_MEMBER_FREESPACE_INITIALIZED(mi),
>   		.valid		= bch2_member_alive(mi),
> +		.btree_bitmap_shift	= mi->btree_bitmap_shift,
> +		.btree_allocated_bitmap = le64_to_cpu(mi->btree_allocated_bitmap),
>   	};
>   }
>   
> @@ -242,4 +245,22 @@ void bch2_sb_members_from_cpu(struct bch_fs *);
>   void bch2_dev_io_errors_to_text(struct printbuf *, struct bch_dev *);
>   void bch2_dev_errors_reset(struct bch_dev *);
>   
> +static inline bool bch2_dev_btree_bitmap_marked_sectors(struct bch_dev *ca, u64 start, unsigned sectors)
> +{
> +	u64 end = start + sectors;
> +
> +	if (end > 64 << ca->mi.btree_bitmap_shift)
> +		return false;
> +
> +	for (unsigned bit = sectors >> ca->mi.btree_bitmap_shift;
> +	     bit << ca->mi.btree_bitmap_shift < end;
> +	     bit++)
> +		if (!(ca->mi.btree_allocated_bitmap & BIT_ULL(bit)))
Should it be transferred by le64_to_cpu?
> +			return false;
> +	return true;
> +}
> +
> +bool bch2_dev_btree_bitmap_marked(struct bch_fs *, struct bkey_s_c);
> +void bch2_dev_btree_bitmap_mark(struct bch_fs *, struct bkey_s_c);
> +
>   #endif /* _BCACHEFS_SB_MEMBERS_H */
> diff --git a/fs/bcachefs/sb-members_types.h b/fs/bcachefs/sb-members_types.h
> index 3f915536d554..c0eda888fe39 100644
> --- a/fs/bcachefs/sb-members_types.h
> +++ b/fs/bcachefs/sb-members_types.h
> @@ -14,6 +14,8 @@ struct bch_member_cpu {
>   	u8			durability;
>   	u8			freespace_initialized;
>   	u8			valid;
> +	u8			btree_bitmap_shift;
> +	u64			btree_allocated_bitmap;
>   };
>   
>   #endif /* _BCACHEFS_SB_MEMBERS_H */

