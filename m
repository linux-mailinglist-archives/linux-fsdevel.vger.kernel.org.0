Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDD12E8E9D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jan 2021 22:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbhACV6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jan 2021 16:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbhACV6R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jan 2021 16:58:17 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5251C061573;
        Sun,  3 Jan 2021 13:57:36 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o13so60278598lfr.3;
        Sun, 03 Jan 2021 13:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/Pq5sbU8BF49DDG/JssIh+YGz0vHa+xobOtTqwvprwI=;
        b=X2mpdjF8uPsuY/VH55RxBw7BmzU4tZWHJFRgMOrVs3kBL8pC32nfM66pdsULk/yURw
         81cQM9Qe2VO+BT9odJPUKxUcK/tTSqPZgEVukeQni08x0tjfCM4RvP/TmuGDmNXCH5ji
         yrPGAMHuvSqRhOsaQhiaz1wvor1zCTjrr2zAuSNDfp2UEx4+PNA6nzNZ/1oLEKnH2SC1
         8h8NqxwfrtDc8WQvReABezPcupbM2DOQ8lYlwbs3gFa14Wc3GLs/TPuEd++TDXC/3TkD
         2o5JNA/rcdOtDqpKW4wFAn6b2wmXzVk51YoJ4gFD+MDd8OHe6KRL3VrEfaENCyamrB29
         XgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Pq5sbU8BF49DDG/JssIh+YGz0vHa+xobOtTqwvprwI=;
        b=my0arn2fPTs/RP0tmpzjFyXX84LusC+oV/DRSLopGfEy8Uq7UcvH+V1zMpOopEtKnS
         bOOA8g7gC0UNZb2iRkM40811BfGtkIar4q7j53bRbrCCB5LaZLa/3C4VFxzSIus3s/qL
         +Ud4epcCxnpw1t51ioxLr1XczqIPyks+EeS0c1+H2ivZm7WsQ147LCdAV7Y7zhnKVyFK
         0LFOIqIUFNX0OXsTX1m34FrNLZr1Zaj9igobNK6Qaw+N/Q8aCTRpsr78g0/ncWKutoz+
         d+t3T6xYCmd41iBW4qE0RMHX0YkVwEHHQfOb67h33F6qD29ZPpXOIWmAJ4h5Kc0XmlhD
         mHyw==
X-Gm-Message-State: AOAM533bE6wvjd2ydQTRfWFfxxCJ0pl5JRcNXn3pJGXZExPorRL3Kox6
        6NMyQCWlRY4YfnofauPS77P7cPgwRhdQ6A==
X-Google-Smtp-Source: ABdhPJxxb4CAuXqy7jwWYMSGMfdngNfIqm0fxbCtJWrT+iMA4a6nj7BRXZMAFxLoAer8m76eO3nlxw==
X-Received: by 2002:a2e:95d5:: with SMTP id y21mr35742934ljh.477.1609711055101;
        Sun, 03 Jan 2021 13:57:35 -0800 (PST)
Received: from kari-VirtualBox (87-95-193-210.bb.dnainternet.fi. [87.95.193.210])
        by smtp.gmail.com with ESMTPSA id z14sm7116593lfd.283.2021.01.03.13.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 13:57:34 -0800 (PST)
Date:   Sun, 3 Jan 2021 23:57:32 +0200
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com
Subject: Re: [PATCH v17 04/10] fs/ntfs3: Add file operations and
 implementation
Message-ID: <20210103215732.vbgcrf42xnao6gw2@kari-VirtualBox>
References: <20201231152401.3162425-1-almaz.alexandrovich@paragon-software.com>
 <20201231152401.3162425-5-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201231152401.3162425-5-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 31, 2020 at 06:23:55PM +0300, Konstantin Komarov wrote:
> This adds file operations and implementation
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/dir.c     |  570 ++++++++
>  fs/ntfs3/file.c    | 1140 ++++++++++++++++
>  fs/ntfs3/frecord.c | 3088 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/ntfs3/namei.c   |  590 +++++++++
>  fs/ntfs3/record.c  |  614 +++++++++
>  fs/ntfs3/run.c     | 1254 ++++++++++++++++++
>  6 files changed, 7256 insertions(+)
>  create mode 100644 fs/ntfs3/dir.c
>  create mode 100644 fs/ntfs3/file.c
>  create mode 100644 fs/ntfs3/frecord.c
>  create mode 100644 fs/ntfs3/namei.c
>  create mode 100644 fs/ntfs3/record.c
>  create mode 100644 fs/ntfs3/run.c
> 
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c

> +int ntfs_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
> +{
> +	return generic_file_fsync(filp, start, end, datasync);
> +}

Do we have a reson why we implement this if we just use generic. Isn't
it more clear if we use generic fsync straight away?

> +static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
> +{

> +	/* Return error if mode is not supported */
> +	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
> +		     FALLOC_FL_COLLAPSE_RANGE))
> +		return -EOPNOTSUPP;

> +
> +	if (mode & FALLOC_FL_PUNCH_HOLE) {

> +	} else if (mode & FALLOC_FL_COLLAPSE_RANGE) {

> +	} else {
> +		/*
> +		 * normal file: allocate clusters, do not change 'valid' size
> +		 */
> +		err = ntfs_set_size(inode, max(end, i_size));
> +		if (err)
> +			goto out;
> +
> +		if (is_sparsed(ni) || is_compressed(ni)) {
> +			CLST vcn_v = ni->i_valid >> sbi->cluster_bits;
> +			CLST vcn = vbo >> sbi->cluster_bits;
> +			CLST cend = bytes_to_cluster(sbi, end);
> +			CLST lcn, clen;
> +			bool new;
> +
> +			/*
> +			 * allocate but not zero new clusters (see below comments)
> +			 * this breaks security (one can read unused on-disk areas)
> +			 * zeroing these clusters may be too long
> +			 * may be we should check here for root rights?
> +			 */
> +			for (; vcn < cend; vcn += clen) {
> +				err = attr_data_get_block(ni, vcn, cend - vcn,
> +							  &lcn, &clen, &new);
> +				if (err)
> +					goto out;
> +				if (!new || vcn >= vcn_v)
> +					continue;
> +
> +				/*
> +				 * Unwritten area
> +				 * NTFS is not able to store several unwritten areas
> +				 * Activate 'ntfs_sparse_cluster' to zero new allocated clusters
> +				 *
> +				 * Dangerous in case:
> +				 * 1G of sparsed clusters + 1 cluster of data =>
> +				 * valid_size == 1G + 1 cluster
> +				 * fallocate(1G) will zero 1G and this can be very long
> +				 * xfstest 016/086 will fail whithout 'ntfs_sparse_cluster'
> +				 */
> +				/*ntfs_sparse_cluster(inode, NULL, vcn,
> +				 *		    min(vcn_v - vcn, clen));
> +				 */
> +			}
> +		}
> +
> +		if (mode & FALLOC_FL_KEEP_SIZE) {

Isn't this hole else already (mode & FALLOC_FL_KEEP_SIZE?

> +			ni_lock(ni);
> +			/*true - keep preallocated*/
> +			err = attr_set_size(ni, ATTR_DATA, NULL, 0,
> +					    &ni->file.run, i_size, &ni->i_valid,
> +					    true, NULL);
> +			ni_unlock(ni);
> +		}
> +	}
> +
> +	if (!err) {
> +		inode->i_ctime = inode->i_mtime = current_time(inode);
> +		mark_inode_dirty(inode);
> +	}
> +out:
> +	if (err == -EFBIG)
> +		err = -ENOSPC;
> +
> +	inode_unlock(inode);
> +	return err;
> +}

> diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c

> +int mi_get(struct ntfs_sb_info *sbi, CLST rno, struct mft_inode **mi)
> +{
> +	int err;
> +	struct mft_inode *m = ntfs_alloc(sizeof(struct mft_inode), 1);
> +
> +	if (!m)
> +		return -ENOMEM;
> +
> +	err = mi_init(m, sbi, rno);

If error happend should we just free end exit. Now we call mi_put() to
clean up.

> +	if (!err)
> +		err = mi_read(m, false);
> +
> +	if (err) {
> +		mi_put(m);
> +		return err;
> +	}
> +
> +	*mi = m;
> +	return 0;
> +}

> +struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
> +{
> +	const struct MFT_REC *rec = mi->mrec;
> +	u32 used = le32_to_cpu(rec->used);
> +	u32 t32, off, asize;
> +	u16 t16;
> +
> +	if (!attr) {
> +		u32 total = le32_to_cpu(rec->total);
> +
> +		off = le16_to_cpu(rec->attr_off);
> +
> +		if (used > total)
> +			goto out;
> +
> +		if (off >= used || off < MFTRECORD_FIXUP_OFFSET_1 ||
> +		    !IsDwordAligned(off)) {
> +			goto out;
> +		}
> +
> +		/* Skip non-resident records */
> +		if (!is_rec_inuse(rec))
> +			goto out;
> +
> +		attr = Add2Ptr(rec, off);
> +	} else {
> +		/* Check if input attr inside record */
> +		off = PtrOffset(rec, attr);
> +		if (off >= used)
> +			goto out;
> +
> +		asize = le32_to_cpu(attr->size);
> +		if (asize < SIZEOF_RESIDENT)
> +			goto out;
> +
> +		attr = Add2Ptr(attr, asize);
> +		off += asize;
> +	}
> +
> +	asize = le32_to_cpu(attr->size);
> +
> +	/* Can we use the first field (attr->type) */
> +	if (off + 8 > used) {
> +		static_assert(QuadAlign(sizeof(enum ATTR_TYPE)) == 8);
> +		goto out;
> +	}
> +
> +	if (attr->type == ATTR_END) {
> +		if (used != off + 8)
> +			goto out;

This if is not needed if there is return NULL after. But return
NULL might also be bug.

> +		return NULL;
> +	}
> +
> +	t32 = le32_to_cpu(attr->type);
> +	if ((t32 & 0xf) || (t32 > 0x100))
> +		goto out;
> +
> +	/* Check boundary */
> +	if (off + asize > used)
> +		goto out;
> +
> +	/* Check size of attribute */
> +	if (!attr->non_res) {
> +		if (asize < SIZEOF_RESIDENT)
> +			goto out;
> +
> +		t16 = le16_to_cpu(attr->res.data_off);
> +
> +		if (t16 > asize)
> +			goto out;
> +
> +		t32 = le32_to_cpu(attr->res.data_size);
> +		if (t16 + t32 > asize)
> +			goto out;
> +
> +		return attr;
> +	}
> +
> +	/* Check some nonresident fields */
> +	if (attr->name_len &&
> +	    le16_to_cpu(attr->name_off) + sizeof(short) * attr->name_len >
> +		    le16_to_cpu(attr->nres.run_off)) {
> +		goto out;
> +	}
> +
> +	if (attr->nres.svcn || !is_attr_ext(attr)) {
> +		if (asize + 8 < SIZEOF_NONRESIDENT)
> +			goto out;
> +
> +		if (attr->nres.c_unit)
> +			goto out;
> +	} else if (asize + 8 < SIZEOF_NONRESIDENT_EX)
> +		goto out;
> +
> +	return attr;
> +
> +out:
> +	return NULL;
> +}

> diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c

> +static inline int run_packed_size(const s64 *n)
> +{
> +#ifdef __BIG_ENDIAN

These are whole functions with ifdef. It would be maybe more clear
that there really is whole functions to both endiand.

> +	const u8 *p = (const u8 *)n + sizeof(*n) - 1;
> +
> +	if (*n >= 0) {
> +		if (p[-7] || p[-6] || p[-5] || p[-4])
> +			p -= 4;
> +		if (p[-3] || p[-2])
> +			p -= 2;
> +		if (p[-1])
> +			p -= 1;
> +		if (p[0] & 0x80)
> +			p -= 1;
> +	} else {
> +		if (p[-7] != 0xff || p[-6] != 0xff || p[-5] != 0xff ||
> +		    p[-4] != 0xff)
> +			p -= 4;
> +		if (p[-3] != 0xff || p[-2] != 0xff)
> +			p -= 2;
> +		if (p[-1] != 0xff)
> +			p -= 1;
> +		if (!(p[0] & 0x80))
> +			p -= 1;
> +	}
> +	return (const u8 *)n + sizeof(*n) - p;

}
#else
static inline int run_packed_size(const s64 *n)
{

Something like this.

> +	const u8 *p = (const u8 *)n;
> +
> +	if (*n >= 0) {
> +		if (p[7] || p[6] || p[5] || p[4])
> +			p += 4;
> +		if (p[3] || p[2])
> +			p += 2;
> +		if (p[1])
> +			p += 1;
> +		if (p[0] & 0x80)
> +			p += 1;
> +	} else {
> +		if (p[7] != 0xff || p[6] != 0xff || p[5] != 0xff ||
> +		    p[4] != 0xff)
> +			p += 4;
> +		if (p[3] != 0xff || p[2] != 0xff)
> +			p += 2;
> +		if (p[1] != 0xff)
> +			p += 1;
> +		if (!(p[0] & 0x80))
> +			p += 1;
> +	}
> +
> +	return 1 + p - (const u8 *)n;
> +#endif
> +}
> +
> +/*
> + * run_pack
> + *
> + * packs runs into buffer
> + * packed_vcns - how much runs we have packed
> + * packed_size - how much bytes we have used run_buf
> + */
> +int run_pack(const struct runs_tree *run, CLST svcn, CLST len, u8 *run_buf,
> +	     u32 run_buf_size, CLST *packed_vcns)
> +{
> +	CLST next_vcn, vcn, lcn;
> +	CLST prev_lcn = 0;
> +	CLST evcn1 = svcn + len;
> +	int packed_size = 0;
> +	size_t i;
> +	bool ok;
> +	s64 dlcn, len64;
> +	int offset_size, size_size, t;
> +	const u8 *p;
> +
> +	next_vcn = vcn = svcn;
> +
> +	*packed_vcns = 0;
> +
> +	if (!len)
> +		goto out;
> +
> +	ok = run_lookup_entry(run, vcn, &lcn, &len, &i);
> +
> +	if (!ok)
> +		goto error;
> +
> +	if (next_vcn != vcn)
> +		goto error;
> +
> +	for (;;) {
> +		/* offset of current fragment relatively to previous fragment */
> +		dlcn = 0;

This dlcn

> +		next_vcn = vcn + len;
> +
> +		if (next_vcn > evcn1)
> +			len = evcn1 - vcn;
> +
> +		/*
> +		 * mirror of len, but signed, because run_packed_size()
> +		 * works with signed int only
> +		 */
> +		len64 = len;
> +
> +		/* how much bytes is packed len64 */
> +		size_size = run_packed_size(&len64);

Does (s64 *)&len work just fine?

> +
> +		/* offset_size - how much bytes is packed dlcn */
> +		if (lcn == SPARSE_LCN) {
> +			offset_size = 0;

dlcn might be better to live here?

> +		} else {
> +			/* NOTE: lcn can be less than prev_lcn! */
> +			dlcn = (s64)lcn - prev_lcn;
> +			offset_size = run_packed_size(&dlcn);
> +			prev_lcn = lcn;
> +		}
> +
> +		t = run_buf_size - packed_size - 2 - offset_size;
> +		if (t <= 0)
> +			goto out;
> +
> +		/* can we store this entire run */
> +		if (t < size_size)
> +			goto out;
> +
> +		if (run_buf) {
> +			p = (u8 *)&len64;
> +
> +			/* pack run header */
> +			run_buf[0] = ((u8)(size_size | (offset_size << 4)));
> +			run_buf += 1;
> +
> +			/* Pack the length of run */
> +			switch (size_size) {
> +#ifdef __BIG_ENDIAN
> +			case 8:
> +				run_buf[7] = p[0];
> +				fallthrough;
> +			case 7:
> +				run_buf[6] = p[1];
> +				fallthrough;
> +			case 6:
> +				run_buf[5] = p[2];
> +				fallthrough;
> +			case 5:
> +				run_buf[4] = p[3];
> +				fallthrough;
> +			case 4:
> +				run_buf[3] = p[4];
> +				fallthrough;
> +			case 3:
> +				run_buf[2] = p[5];
> +				fallthrough;
> +			case 2:
> +				run_buf[1] = p[6];
> +				fallthrough;
> +			case 1:
> +				run_buf[0] = p[7];
> +#else
> +			case 8:
> +				run_buf[7] = p[7];
> +				fallthrough;
> +			case 7:
> +				run_buf[6] = p[6];
> +				fallthrough;
> +			case 6:
> +				run_buf[5] = p[5];
> +				fallthrough;
> +			case 5:
> +				run_buf[4] = p[4];
> +				fallthrough;
> +			case 4:
> +				run_buf[3] = p[3];
> +				fallthrough;
> +			case 3:
> +				run_buf[2] = p[2];
> +				fallthrough;
> +			case 2:
> +				run_buf[1] = p[1];
> +				fallthrough;
> +			case 1:
> +				run_buf[0] = p[0];
> +#endif
> +			}

Why is this not own function? We use this like 5 places. Also isn't
little endian just memcopy()

> +
> +			run_buf += size_size;
> +			p = (u8 *)&dlcn;

I think that when we have function for that switch tmp p is not needed
anymore.

> +
> +			/* Pack the offset from previous lcn */
> +			switch (offset_size) {
> +#ifdef __BIG_ENDIAN
> +			case 8:
> +				run_buf[7] = p[0];
> +				fallthrough;
> +			case 7:
> +				run_buf[6] = p[1];
> +				fallthrough;
> +			case 6:
> +				run_buf[5] = p[2];
> +				fallthrough;
> +			case 5:
> +				run_buf[4] = p[3];
> +				fallthrough;
> +			case 4:
> +				run_buf[3] = p[4];
> +				fallthrough;
> +			case 3:
> +				run_buf[2] = p[5];
> +				fallthrough;
> +			case 2:
> +				run_buf[1] = p[6];
> +				fallthrough;
> +			case 1:
> +				run_buf[0] = p[7];
> +#else
> +			case 8:
> +				run_buf[7] = p[7];
> +				fallthrough;
> +			case 7:
> +				run_buf[6] = p[6];
> +				fallthrough;
> +			case 6:
> +				run_buf[5] = p[5];
> +				fallthrough;
> +			case 5:
> +				run_buf[4] = p[4];
> +				fallthrough;
> +			case 4:
> +				run_buf[3] = p[3];
> +				fallthrough;
> +			case 3:
> +				run_buf[2] = p[2];
> +				fallthrough;
> +			case 2:
> +				run_buf[1] = p[1];
> +				fallthrough;
> +			case 1:
> +				run_buf[0] = p[0];
> +#endif
> +			}

> +int run_get_highest_vcn(CLST vcn, const u8 *run_buf, u64 *highest_vcn)
> +{

> +		/* skip size_size */
> +		run += size_size;
> +
> +		if (!len)
> +			goto error;
> +
> +		run += offset_size;

Can this be straight
run += size_size + offset_size;

> +
> +#ifdef NTFS3_64BIT_CLUSTER
> +		if ((vcn >> 32) || (len >> 32))
> +			goto error;
> +#endif
> +		vcn64 += len;
> +	}
> +
> +	*highest_vcn = vcn64 - 1;
> +	return 0;
> +}
