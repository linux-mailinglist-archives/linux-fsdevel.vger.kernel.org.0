Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784581FC723
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 09:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgFQHUt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 03:20:49 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:24684 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQHUs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:20:48 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200617072042epoutp02c6a906bc3708ed1f85f013556b2a3e20~ZQ8Gol5Ey1222812228epoutp02n
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2020 07:20:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200617072042epoutp02c6a906bc3708ed1f85f013556b2a3e20~ZQ8Gol5Ey1222812228epoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592378442;
        bh=x/kh1K4fCvJoyH4QRZXx+v26thUifv6xFZtA85cF5l0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=JDa1Hx4agkMKYhpLThiTFyu1GesIoLKHbWOFAbECADuPjD1X2EYm8UDQY/GwvEnKJ
         um1CNZTYZrnWtWzIkz+JfeRQ2sKgIAgzFYeSkuaYip5r2M25W5y/rre7FLysP1Ha2k
         52qx6no1oCm6dRndGmFJzviQr6r+gQlcpcbhvrVw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200617072041epcas1p49cae5b7aa1c554f4c3055a3b1d2e088a~ZQ8GL2LEH0961309613epcas1p4a;
        Wed, 17 Jun 2020 07:20:41 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.165]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49mxLJ6C76zMqYkx; Wed, 17 Jun
        2020 07:20:40 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.39.19033.844C9EE5; Wed, 17 Jun 2020 16:20:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200617072038epcas1p4c9c86c54b9fd6d46640c0380c3ea6016~ZQ8C8KvR20961809618epcas1p4d;
        Wed, 17 Jun 2020 07:20:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200617072038epsmtrp22b945c0e524873e259092b064540316d~ZQ8C7RvtM0087800878epsmtrp2h;
        Wed, 17 Jun 2020 07:20:38 +0000 (GMT)
X-AuditID: b6c32a36-159ff70000004a59-8d-5ee9c448a4d4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.4B.08303.644C9EE5; Wed, 17 Jun 2020 16:20:38 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200617072038epsmtip2e39e928efd195bd62987a0c84c859835~ZQ8CuULp_0381503815epsmtip2R;
        Wed, 17 Jun 2020 07:20:38 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200616021808.5222-1-kohada.t2@gmail.com>
Subject: RE: [PATCH v3] exfat: remove EXFAT_SB_DIRTY flag
Date:   Wed, 17 Jun 2020 16:20:37 +0900
Message-ID: <414101d64477$ccb661f0$662325d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQF0BoMPlscPSpT3Th8lCwQKqdMbhQJGtMGMqY6njNA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmga7HkZdxBnen8Vj8mHubxeLNyaks
        Fnv2nmSxuLxrDpvF5f+fWCyWfZnMYvFjer0Du8eXOcfZPdom/2P3aD62ks1j56y77B59W1Yx
        enzeJBfAFpVjk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuW
        mQN0ipJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwNCgQK84Mbe4NC9dLzk/18rQ
        wMDIFKgyISdj9fQ5bAW9MRWTZ8xgbGC87tXFyMkhIWAisfPbBqYuRi4OIYEdjBJPd51jBkkI
        CXxilDgzuQgi8ZlR4kLjf3aYjsY981kgErsYJfqOH2CDcF4ySsx7vR6sik1AV+LJjZ9go0QE
        9CROnrzOBmIzCzQySZx4mQ1icwpYSPS+fgJUw8EhLGApsfC6MkiYRUBVYmLfW7ByXqDwvckX
        WCBsQYmTM5+wQIyRl9j+dg4zxEEKErs/HWWFWGUl0fP9HCtEjYjE7M42ZpDbJAQWckgcOfEa
        qsFFomn7MlYIW1ji1fEtUJ9JSXx+t5cNwq6X2L3qFAtEcwOjxJFHC1kgEsYS81sWgh3NLKAp
        sX6XPkRYUWLn77mMEIv5JN597WEFKZEQ4JXoaBOCKFGR+P5hJwvMqis/rjJNYFSaheS1WUhe
        m4XkhVkIyxYwsqxiFEstKM5NTy02LDBCjuxNjOBkqmW2g3HS2w96hxiZOBgPMUpwMCuJ8Dr/
        fhEnxJuSWFmVWpQfX1Sak1p8iNEUGNgTmaVEk/OB6TyvJN7Q1MjY2NjCxMzczNRYSZxXTeZC
        nJBAemJJanZqakFqEUwfEwenVANT9uzn+qaJDJeNX8Q3M5oF+VwKtpvy5q2CaOL8aU3i/WWN
        Gt2nny+VPfvl7LNovfhIp7t9GbcOuJ9n+Xe8Piuls1vm2Tb1mMg9DhuY8i5d0uNp+fNv//Tk
        gHM71Pz/1c23PuA1If+BiVqgbmJ/Q7Er/7+wjTeW3wpXdk3YmmF/8KGgL5vjtS8huXm9JW1/
        PpTPc3n6rlh8T8Au5aD7kxcdXi2wqNZjtw7P2pdPKtc6Vpiz3Bao7T+3oc7jEGt1bL7g8bBz
        Oq4bH/e805yafX3GpPw/Env+1IczNc9kuFEt+jdK7OBXi5dv2VRW/bXJqjJZt/N0yO22ujyF
        t4vf3dkeZRdyc/VbiRir3seHmrOVWIozEg21mIuKEwHZ0FMhLwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJXtftyMs4g9eL+Sx+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsfgxvd6B3ePLnOPsHm2T/7F7NB9byeaxc9Zddo++LasY
        PT5vkgtgi+KySUnNySxLLdK3S+DKWD19DltBb0zF5BkzGBsYr3t1MXJySAiYSDTumc/SxcjF
        ISSwg1FiRctjpi5GDqCElMTBfZoQprDE4cPFECXPGSW+X9jMBNLLJqAr8eTGT2YQW0RAT+Lk
        yetsIEXMAs1MEq1fmsGKhAQ6GSUmTNADsTkFLCR6Xz9hBhkqLGApsfC6MkiYRUBVYmLfWzYQ
        mxcofG/yBRYIW1Di5MwnLCDlzEDz2zYygoSZBeQltr+dwwxxvoLE7k9HWSFOsJLo+X6OFaJG
        RGJ2ZxvzBEbhWUgmzUKYNAvJpFlIOhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/d
        xAiOJy2tHYx7Vn3QO8TIxMF4iFGCg1lJhNf594s4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxf
        Zy2MExJITyxJzU5NLUgtgskycXBKNTClK/Ls0JobOm8265OCc8GlHJ8DWa4e23nDKuO765UT
        U20bjmy3uHNIpF08zOWWufX6hPoWhR/8Gxatv6z72DLQ8uDb20fSdswOunn0r/6T/3cijq/d
        OallTURDjvW7y4UR/Bd1Fi7+O3+x7JKZ5zpjZH/PdDaJvPEpMIzvf9X2Wxt2n8vwTHxnNiVq
        MmPbS9Pfitr1ypPTd1/kvy+3+tH7k78l11lmrE29otRSGJX/h4HdO/5TptD3VpUDXeZPttn8
        49pYwMS6QlJZZFXg5JMstdtOVW3v3DPd5FlXWu7aCzJy/yd7nilPiNq18kuL+Yt3vAeea2qX
        +wbpfHrSUVS4Kf9tAYvZxre3X+XwxKeeVGIpzkg01GIuKk4EAH632V0WAwAA
X-CMS-MailID: 20200617072038epcas1p4c9c86c54b9fd6d46640c0380c3ea6016
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200616021816epcas1p2bb235df44c0b6f74cdec2f12072891e3
References: <CGME20200616021816epcas1p2bb235df44c0b6f74cdec2f12072891e3@epcas1p2.samsung.com>
        <20200616021808.5222-1-kohada.t2@gmail.com>
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

Since this patch does not resolve 'VOL_DIRTY in ENOTEMPTY' problem you
mentioned,
it would be better to remove the description above for that and to make new
patch.

> Remove the EXFAT_SB_DIRTY check to ensure synchronization.
> And, remove the code related to the flag.
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

> ---
> Changes in v2:
>  - exfat_sync_fs() avoids synchronous processing when wait=0 Changes in
v3:
>  - fix return value in exfat_sync_fs()
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
> e650e65536f8..8cb146376d6b 100644
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
> +		return 0;
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


