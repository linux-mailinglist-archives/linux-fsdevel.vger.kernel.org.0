Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3FA1FA63F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 04:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgFPCEG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 22:04:06 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:64755 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgFPCED (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 22:04:03 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200616020357epoutp0373303e0010be4078e6fea918de177e84~Y4_RGfI1H0337703377epoutp03h
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2020 02:03:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200616020357epoutp0373303e0010be4078e6fea918de177e84~Y4_RGfI1H0337703377epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592273037;
        bh=E5XaHl8VcOyglecwgcc/oMFbC7Az7wMM8C7LHWkV8Q4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=hfGV0xkQEcnIETL4mx7bpMRIY7hbzeikQaR3OoIqB0ilLr331IDQSMOWBaqub1n7a
         8MXLYd5LKtIAW7irzo1eK5GJZN29fNYI8WTsMBU+ety5Ix8E3FUfus0hsTNxRC1tCO
         6liIiIoZxuH21nRPPOvoZg2qkqRELWbrK7MI32Vo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200616020355epcas1p1dbb86fd9b8f002affd93ba558b69299b~Y4_O-Le9-1593915939epcas1p1V;
        Tue, 16 Jun 2020 02:03:55 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.166]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49mBMG1mxvzMqYkn; Tue, 16 Jun
        2020 02:03:54 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.35.19033.A8828EE5; Tue, 16 Jun 2020 11:03:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200616020353epcas1p13f497e809808564c992de0f451c55ea9~Y4_NUdkjf1710517105epcas1p1D;
        Tue, 16 Jun 2020 02:03:53 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200616020353epsmtrp1cf8430db70de466e632066746ed49157~Y4_NTdF_73038430384epsmtrp19;
        Tue, 16 Jun 2020 02:03:53 +0000 (GMT)
X-AuditID: b6c32a36-16fff70000004a59-ec-5ee8288a4c16
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.8C.08303.98828EE5; Tue, 16 Jun 2020 11:03:53 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200616020353epsmtip287c7996a2f6cc26bf88faf36d6e3c719~Y4_NC6Nt80840908409epsmtip2Z;
        Tue, 16 Jun 2020 02:03:53 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200616002450.2522-1-kohada.t2@gmail.com>
Subject: RE: [PATCH v2] exfat: remove EXFAT_SB_DIRTY flag
Date:   Tue, 16 Jun 2020 11:03:53 +0900
Message-ID: <2c3a01d64382$62b44880$281cd980$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQEqEoK6htQ0ZOXnD5Nf2qZjEI4DMAIbzqlXqiIAnIA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmvm6Xxos4g1OPuS1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsfgxvd6B3ePLnOPsHm2T/7F7NB9byeaxc9Zddo++LasY
        PT5vkgtgi8qxyUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
        zAE6RUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhQoFecmFtcmpeul5yfa2Vo
        YGBkClSZkJNx4vozpoJdURW3/u5ibWDc4NnFyMkhIWAise7iL0YQW0hgB6PExC/MXYxcQPYn
        Ron3LWsYIZzPjBIb1+1mh+k49P4yO0RiF6PEnrb/UM5LRom109awglSxCehKPLnxkxnEFhHQ
        kzh58jobiM0s0MgkceJlNojNKWAh0TxlB9hUYQFLiWNbj4HVsAioSrx5chHsJl6g+Ja3b9gg
        bEGJkzOfsEDMkZfY/nYOM8RFChK7Px1lhdhlJbFzwismiBoRidmdbWD/SAjM5ZC4sH0qVIOL
        RMeTSywQtrDEq+NboF6TknjZ3wZl10vsXnWKBaK5gVHiyKOFUA3GEvNbFgIN4gDaoCmxfpc+
        RFhRYufvuYwQi/kk3n3tYQUpkRDglehoE4IoUZH4/mEnC8yqKz+uMk1gVJqF5LVZSF6bheSF
        WQjLFjCyrGIUSy0ozk1PLTYsMEKO7U2M4HSqZbaDcdLbD3qHGJk4GA8xSnAwK4nwHpJ/HifE
        m5JYWZValB9fVJqTWnyI0RQY2BOZpUST84EJPa8k3tDUyNjY2MLEzNzM1FhJnFdN5kKckEB6
        YklqdmpqQWoRTB8TB6dUA5Nq4KRXYTnXWZu4mU1XXp6VsiXOLSLvwQRHEynjcoPb58NU2/U/
        vr67opLnwmP7A4eTkqe8ZfgYfnGZb9fFmGv73rZM8E6bKXBA5xrnhaiHO9pqA09sebc9JpjH
        SvjmJW/2U5Yf97C8XlD0ocFq3s3+nRXP/q4KPLVBpkXj0TumTafuzbu+/kDCw2izU0rXVYUY
        J13PFjwv0XmjN+nxRef9M7bcFIwyLbt8dHbxk8Zn8mFpfPXZuZqPV8efTFb6tu/I6g8vTBpc
        16gkRp3dz/Lf33lOV5B6eEnxekH1qMKdLt4zplzuuWg3Pe74pdm8gWbtz7SfR67786k6/oXj
        n7icPVuU9toumF8SL/brSkKyEktxRqKhFnNRcSIA7bqTFjAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJXrdT40WcwZol6hY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWPyYXu/A7vFlznF2j7bJ/9g9mo+tZPPYOesuu0ffllWM
        Hp83yQWwRXHZpKTmZJalFunbJXBlnLj+jKlgV1TFrb+7WBsYN3h2MXJySAiYSBx6f5m9i5GL
        Q0hgB6PE94tr2boYOYASUhIH92lCmMIShw8XQ5Q8Z5S4+Og9I0gvm4CuxJMbP5lBbBEBPYmT
        J6+zgRQxCzQzSbR+aWaC6OhklFjVDVHFKWAh0TxlBzuILSxgKXFs6zE2EJtFQFXizZOLYFN5
        geJb3r5hg7AFJU7OfMICcgUz0Ia2jWAlzALyEtvfzmGGeEBBYveno6wQR1hJ7JzwigmiRkRi
        dmcb8wRG4VlIJs1CmDQLyaRZSDoWMLKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQI
        jiktrR2Me1Z90DvEyMTBeIhRgoNZSYT3kPzzOCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8X2ct
        jBMSSE8sSc1OTS1ILYLJMnFwSjUwpd7dG1O18lHQ2oKcnRX8fyT23/ptbhbSdGjRkxvz4u3P
        2ksp/bjyyeGMUtWl7U/KzuRbWWhkzfA0kd+41IH1dpz5r31r9q3OYtv9J0qhYl61zrPlYauy
        bkV4bJhcIRWSu/GVdIb8x8TEff4OmYsmlEol7v2alLiijtnvoedNg8txWu+5v1UI67Z/zrhX
        rL16/jvVhN8fJ8/Xt2relP2k5KxN8T7L8ETOy9ntb54KbyqepBsc/Mx7mn+KD+vrWWb8+xj+
        9rXuPblIsm9JxdQ10YFvqv9sNvc6tPiRTlxFi43ty+DHHjv8tq91ktQ6kSlxudRU9VTU59dq
        u47WNyZfrajLmJSmHLe7qUV+X/IKJZbijERDLeai4kQAQUYdgRgDAAA=
X-CMS-MailID: 20200616020353epcas1p13f497e809808564c992de0f451c55ea9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200616002500epcas1p19135f6f329fbf8c90df1b3ba8a1f67f7
References: <CGME20200616002500epcas1p19135f6f329fbf8c90df1b3ba8a1f67f7@epcas1p1.samsung.com>
        <20200616002450.2522-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> remove EXFAT_SB_DIRTY flag and related codes.
> 
> This flag is set/reset in exfat_put_super()/exfat_sync_fs() to avoid
> sync_blockdev().
> However ...
> - exfat_put_super():
> Before calling this, the VFS has already called sync_filesystem(), so sync
> is never performed here.
> - exfat_sync_fs():
> After calling this, the VFS calls sync_blockdev(), so, it is meaningless
> to check EXFAT_SB_DIRTY or to bypass sync_blockdev() here.
> Not only that, but in some cases can't clear VOL_DIRTY.
> ex:
> VOL_DIRTY is set when rmdir starts, but when non-empty-dir is detected,
> return error without setting EXFAT_SB_DIRTY.
> If performe 'sync' in this state, VOL_DIRTY will not be cleared.
> 
> Remove the EXFAT_SB_DIRTY check to ensure synchronization.
> And, remove the code related to the flag.
> 
> Suggested-by: Sungjong Seo <sj1557.seo@samsung.com>
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
> ---
> Changes in v2:
>  - exfat_sync_fs() avoids synchronous processing when wait=0
> 
>  fs/exfat/balloc.c   |  4 ++--
>  fs/exfat/dir.c      | 16 ++++++++--------
>  fs/exfat/exfat_fs.h |  5 +----
>  fs/exfat/fatent.c   |  7 ++-----
>  fs/exfat/misc.c     |  3 +--
>  fs/exfat/namei.c    | 12 ++++++------
>  fs/exfat/super.c    | 14 ++++++--------
>  7 files changed, 26 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c index
> 4055eb00ea9b..a987919686c0 100644
> --- a/fs/exfat/balloc.c
> +++ b/fs/exfat/balloc.c
> @@ -158,7 +158,7 @@ int exfat_set_bitmap(struct inode *inode, unsigned int
> clu)
>  	b = BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent_idx);
> 
>  	set_bit_le(b, sbi->vol_amap[i]->b_data);
> -	exfat_update_bh(sb, sbi->vol_amap[i], IS_DIRSYNC(inode));
> +	exfat_update_bh(sbi->vol_amap[i], IS_DIRSYNC(inode));
>  	return 0;
>  }
> 
> @@ -180,7 +180,7 @@ void exfat_clear_bitmap(struct inode *inode, unsigned
> int clu)
>  	b = BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent_idx);
> 
>  	clear_bit_le(b, sbi->vol_amap[i]->b_data);
> -	exfat_update_bh(sb, sbi->vol_amap[i], IS_DIRSYNC(inode));
> +	exfat_update_bh(sbi->vol_amap[i], IS_DIRSYNC(inode));
> 
>  	if (opts->discard) {
>  		int ret_discard;
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
> 8e775bd5d523..02acbb6ddf02 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -470,7 +470,7 @@ int exfat_init_dir_entry(struct inode *inode, struct
> exfat_chain *p_dir,
>  			&ep->dentry.file.access_date,
>  			NULL);
> 
> -	exfat_update_bh(sb, bh, IS_DIRSYNC(inode));
> +	exfat_update_bh(bh, IS_DIRSYNC(inode));
>  	brelse(bh);
> 
>  	ep = exfat_get_dentry(sb, p_dir, entry + 1, &bh, &sector); @@ -
> 480,7 +480,7 @@ int exfat_init_dir_entry(struct inode *inode, struct
> exfat_chain *p_dir,
>  	exfat_init_stream_entry(ep,
>  		(type == TYPE_FILE) ? ALLOC_FAT_CHAIN : ALLOC_NO_FAT_CHAIN,
>  		start_clu, size);
> -	exfat_update_bh(sb, bh, IS_DIRSYNC(inode));
> +	exfat_update_bh(bh, IS_DIRSYNC(inode));
>  	brelse(bh);
> 
>  	return 0;
> @@ -516,7 +516,7 @@ int exfat_update_dir_chksum(struct inode *inode,
> struct exfat_chain *p_dir,
>  	}
> 
>  	fep->dentry.file.checksum = cpu_to_le16(chksum);
> -	exfat_update_bh(sb, fbh, IS_DIRSYNC(inode));
> +	exfat_update_bh(fbh, IS_DIRSYNC(inode));
>  release_fbh:
>  	brelse(fbh);
>  	return ret;
> @@ -538,7 +538,7 @@ int exfat_init_ext_entry(struct inode *inode, struct
> exfat_chain *p_dir,
>  		return -EIO;
> 
>  	ep->dentry.file.num_ext = (unsigned char)(num_entries - 1);
> -	exfat_update_bh(sb, bh, sync);
> +	exfat_update_bh(bh, sync);
>  	brelse(bh);
> 
>  	ep = exfat_get_dentry(sb, p_dir, entry + 1, &bh, &sector); @@ -
> 547,7 +547,7 @@ int exfat_init_ext_entry(struct inode *inode, struct
> exfat_chain *p_dir,
> 
>  	ep->dentry.stream.name_len = p_uniname->name_len;
>  	ep->dentry.stream.name_hash = cpu_to_le16(p_uniname->name_hash);
> -	exfat_update_bh(sb, bh, sync);
> +	exfat_update_bh(bh, sync);
>  	brelse(bh);
> 
>  	for (i = EXFAT_FIRST_CLUSTER; i < num_entries; i++) { @@ -556,7
> +556,7 @@ int exfat_init_ext_entry(struct inode *inode, struct exfat_chain
> *p_dir,
>  			return -EIO;
> 
>  		exfat_init_name_entry(ep, uniname);
> -		exfat_update_bh(sb, bh, sync);
> +		exfat_update_bh(bh, sync);
>  		brelse(bh);
>  		uniname += EXFAT_FILE_NAME_LEN;
>  	}
> @@ -580,7 +580,7 @@ int exfat_remove_entries(struct inode *inode, struct
> exfat_chain *p_dir,
>  			return -EIO;
> 
>  		exfat_set_entry_type(ep, TYPE_DELETED);
> -		exfat_update_bh(sb, bh, IS_DIRSYNC(inode));
> +		exfat_update_bh(bh, IS_DIRSYNC(inode));
>  		brelse(bh);
>  	}
> 
> @@ -610,7 +610,7 @@ void exfat_free_dentry_set(struct
> exfat_entry_set_cache *es, int sync)
> 
>  	for (i = 0; i < es->num_bh; i++) {
>  		if (es->modified)
> -			exfat_update_bh(es->sb, es->bh[i], sync);
> +			exfat_update_bh(es->bh[i], sync);
>  		brelse(es->bh[i]);
>  	}
>  	kfree(es);
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h index
> 595f3117f492..84664024e51e 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -13,8 +13,6 @@
>  #define EXFAT_SUPER_MAGIC       0x2011BAB0UL
>  #define EXFAT_ROOT_INO		1
> 
> -#define EXFAT_SB_DIRTY		0
> -
>  #define EXFAT_CLUSTERS_UNTRACKED (~0u)
> 
>  /*
> @@ -238,7 +236,6 @@ struct exfat_sb_info {
>  	unsigned int clu_srch_ptr; /* cluster search pointer */
>  	unsigned int used_clusters; /* number of used clusters */
> 
> -	unsigned long s_state;
>  	struct mutex s_lock; /* superblock lock */
>  	struct exfat_mount_options options;
>  	struct nls_table *nls_io; /* Charset used for input and display */
> @@ -514,7 +511,7 @@ void exfat_set_entry_time(struct exfat_sb_info *sbi,
> struct timespec64 *ts,
>  		u8 *tz, __le16 *time, __le16 *date, u8 *time_cs);
>  u16 exfat_calc_chksum16(void *data, int len, u16 chksum, int type);
>  u32 exfat_calc_chksum32(void *data, int len, u32 chksum, int type); -void
> exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int sync);
> +void exfat_update_bh(struct buffer_head *bh, int sync);
>  void exfat_chain_set(struct exfat_chain *ec, unsigned int dir,
>  		unsigned int size, unsigned char flags);  void
> exfat_chain_dup(struct exfat_chain *dup, struct exfat_chain *ec); diff --
> git a/fs/exfat/fatent.c b/fs/exfat/fatent.c index
> 4e5c5c9c0f2d..82ee8246c080 100644
> --- a/fs/exfat/fatent.c
> +++ b/fs/exfat/fatent.c
> @@ -75,7 +75,7 @@ int exfat_ent_set(struct super_block *sb, unsigned int
> loc,
> 
>  	fat_entry = (__le32 *)&(bh->b_data[off]);
>  	*fat_entry = cpu_to_le32(content);
> -	exfat_update_bh(sb, bh, sb->s_flags & SB_SYNCHRONOUS);
> +	exfat_update_bh(bh, sb->s_flags & SB_SYNCHRONOUS);
>  	exfat_mirror_bh(sb, sec, bh);
>  	brelse(bh);
>  	return 0;
> @@ -174,7 +174,6 @@ int exfat_free_cluster(struct inode *inode, struct
> exfat_chain *p_chain)
>  		return -EIO;
>  	}
> 
> -	set_bit(EXFAT_SB_DIRTY, &sbi->s_state);
>  	clu = p_chain->dir;
> 
>  	if (p_chain->flags == ALLOC_NO_FAT_CHAIN) { @@ -274,7 +273,7 @@ int
> exfat_zeroed_cluster(struct inode *dir, unsigned int clu)
>  			goto release_bhs;
>  		}
>  		memset(bhs[n]->b_data, 0, sb->s_blocksize);
> -		exfat_update_bh(sb, bhs[n], 0);
> +		exfat_update_bh(bhs[n], 0);
> 
>  		n++;
>  		blknr++;
> @@ -358,8 +357,6 @@ int exfat_alloc_cluster(struct inode *inode, unsigned
> int num_alloc,
>  		}
>  	}
> 
> -	set_bit(EXFAT_SB_DIRTY, &sbi->s_state);
> -
>  	p_chain->dir = EXFAT_EOF_CLUSTER;
> 
>  	while ((new_clu = exfat_find_free_bitmap(sb, hint_clu)) != diff --
> git a/fs/exfat/misc.c b/fs/exfat/misc.c index 17d41f3d3709..8a3dde59052b
> 100644
> --- a/fs/exfat/misc.c
> +++ b/fs/exfat/misc.c
> @@ -163,9 +163,8 @@ u32 exfat_calc_chksum32(void *data, int len, u32
> chksum, int type)
>  	return chksum;
>  }
> 
> -void exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int
> sync)
> +void exfat_update_bh(struct buffer_head *bh, int sync)
>  {
> -	set_bit(EXFAT_SB_DIRTY, &EXFAT_SB(sb)->s_state);
>  	set_buffer_uptodate(bh);
>  	mark_buffer_dirty(bh);
> 
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c index
> edd8023865a0..5eef2217fcf2 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -387,7 +387,7 @@ static int exfat_find_empty_entry(struct inode *inode,
>  			ep->dentry.stream.valid_size = cpu_to_le64(size);
>  			ep->dentry.stream.size =
ep->dentry.stream.valid_size;
>  			ep->dentry.stream.flags = p_dir->flags;
> -			exfat_update_bh(sb, bh, IS_DIRSYNC(inode));
> +			exfat_update_bh(bh, IS_DIRSYNC(inode));
>  			brelse(bh);
>  			if (exfat_update_dir_chksum(inode, &(ei->dir),
>  			    ei->entry))
> @@ -1071,7 +1071,7 @@ static int exfat_rename_file(struct inode *inode,
> struct exfat_chain *p_dir,
>  			epnew->dentry.file.attr |=
cpu_to_le16(ATTR_ARCHIVE);
>  			ei->attr |= ATTR_ARCHIVE;
>  		}
> -		exfat_update_bh(sb, new_bh, sync);
> +		exfat_update_bh(new_bh, sync);
>  		brelse(old_bh);
>  		brelse(new_bh);
> 
> @@ -1087,7 +1087,7 @@ static int exfat_rename_file(struct inode *inode,
> struct exfat_chain *p_dir,
>  		}
> 
>  		memcpy(epnew, epold, DENTRY_SIZE);
> -		exfat_update_bh(sb, new_bh, sync);
> +		exfat_update_bh(new_bh, sync);
>  		brelse(old_bh);
>  		brelse(new_bh);
> 
> @@ -1104,7 +1104,7 @@ static int exfat_rename_file(struct inode *inode,
> struct exfat_chain *p_dir,
>  			epold->dentry.file.attr |=
cpu_to_le16(ATTR_ARCHIVE);
>  			ei->attr |= ATTR_ARCHIVE;
>  		}
> -		exfat_update_bh(sb, old_bh, sync);
> +		exfat_update_bh(old_bh, sync);
>  		brelse(old_bh);
>  		ret = exfat_init_ext_entry(inode, p_dir, oldentry,
>  			num_new_entries, p_uniname);
> @@ -1159,7 +1159,7 @@ static int exfat_move_file(struct inode *inode,
> struct exfat_chain *p_olddir,
>  		epnew->dentry.file.attr |= cpu_to_le16(ATTR_ARCHIVE);
>  		ei->attr |= ATTR_ARCHIVE;
>  	}
> -	exfat_update_bh(sb, new_bh, IS_DIRSYNC(inode));
> +	exfat_update_bh(new_bh, IS_DIRSYNC(inode));
>  	brelse(mov_bh);
>  	brelse(new_bh);
> 
> @@ -1175,7 +1175,7 @@ static int exfat_move_file(struct inode *inode,
> struct exfat_chain *p_olddir,
>  	}
> 
>  	memcpy(epnew, epmov, DENTRY_SIZE);
> -	exfat_update_bh(sb, new_bh, IS_DIRSYNC(inode));
> +	exfat_update_bh(new_bh, IS_DIRSYNC(inode));
>  	brelse(mov_bh);
>  	brelse(new_bh);
> 
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c index
> e650e65536f8..49804d369b51 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -45,9 +45,6 @@ static void exfat_put_super(struct super_block *sb)
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> 
>  	mutex_lock(&sbi->s_lock);
> -	if (test_and_clear_bit(EXFAT_SB_DIRTY, &sbi->s_state))
> -		sync_blockdev(sb->s_bdev);
> -	exfat_set_vol_flags(sb, VOL_CLEAN);
>  	exfat_free_bitmap(sbi);
>  	brelse(sbi->boot_bh);
>  	mutex_unlock(&sbi->s_lock);
> @@ -60,13 +57,14 @@ static int exfat_sync_fs(struct super_block *sb, int
> wait)
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>  	int err = 0;
> 
> +	if (!wait)
> +		return;

Need to return 0.

> +
>  	/* If there are some dirty buffers in the bdev inode */
>  	mutex_lock(&sbi->s_lock);
> -	if (test_and_clear_bit(EXFAT_SB_DIRTY, &sbi->s_state)) {
> -		sync_blockdev(sb->s_bdev);
> -		if (exfat_set_vol_flags(sb, VOL_CLEAN))
> -			err = -EIO;
> -	}
> +	sync_blockdev(sb->s_bdev);
> +	if (exfat_set_vol_flags(sb, VOL_CLEAN))
> +		err = -EIO;
>  	mutex_unlock(&sbi->s_lock);
>  	return err;
>  }
> --
> 2.25.1


