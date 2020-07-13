Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B075A21CE6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 06:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgGMEwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 00:52:51 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:58503 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgGMEwu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 00:52:50 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200713045245epoutp04c6ad44b3d4d72a563682ff893d13c80f~hNsWsTM-P2418024180epoutp04v
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2020 04:52:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200713045245epoutp04c6ad44b3d4d72a563682ff893d13c80f~hNsWsTM-P2418024180epoutp04v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594615965;
        bh=I5cL9FuCwCcdGU1fGtoRpCNr8gbu+uCnxfubUVaeCsU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=XgqehFBfDxx2Cnhha6kppQ54VihvC75uu8cit+vE+RzBAnZWA3KJ2fLUnEMZVwgf+
         iMR30Mu4TL3zfna1hK5S0xtjJAxCiptaRyUG3xjJ+pDp99Q/waKWMrzd7ynb1jhycL
         44BLG+1Xl2GpsqZFpXJ4YjMBpFQ1cerbdyiUky2c=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200713045245epcas1p232c02c960f5705eae10ddfa7ebb149a8~hNsWR53If0175901759epcas1p2Q;
        Mon, 13 Jul 2020 04:52:45 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.161]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4B4rqc2VcWzMqYkt; Mon, 13 Jul
        2020 04:52:44 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.E6.28578.C98EB0F5; Mon, 13 Jul 2020 13:52:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200713045243epcas1p2570d36dcc0c012233e551a7e00c21a0f~hNsVBzEXI0171901719epcas1p2l;
        Mon, 13 Jul 2020 04:52:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200713045243epsmtrp22505ca4fca6ffb1024d55b60cc388556~hNsVBFLWS1137211372epsmtrp2s;
        Mon, 13 Jul 2020 04:52:43 +0000 (GMT)
X-AuditID: b6c32a39-8dfff70000006fa2-72-5f0be89cd4b5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.97.08382.B98EB0F5; Mon, 13 Jul 2020 13:52:43 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200713045243epsmtip1e3998b2d569c8f0983dfbcbff1540629~hNsU3FDmH1324213242epsmtip1G;
        Mon, 13 Jul 2020 04:52:43 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200708095746.4179-1-kohada.t2@gmail.com>
Subject: RE: [PATCH] exfat: retain 'VolumeFlags' properly
Date:   Mon, 13 Jul 2020 13:52:43 +0900
Message-ID: <005101d658d1$7202e5d0$5608b170$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJOchBlupSQwdEhi4rggGDYoy3yLwE5agcKqAruaRA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmnu6cF9zxBrv7BCx+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsdjy7wirA7vHlznH2T3aJv9j92g+tpLNY+esu+wefVtW
        MXp83iQXwBaVY5ORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6Dr
        lpkDdIuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8DQoECvODG3uDQvXS85P9fK
        0MDAyBSoMiEnY//7mUwFU7Uqpn/YxdLA+FGxi5GTQ0LARGL6gutMXYxcHEICOxgl1jy6zg7h
        fGKUOPLwDQuE841R4uyJfkaYloaGFawQib2MEm2TJ7FBOC8ZJZbf3ckGUsUmoCvx789+MFtE
        QE/i5MnrYEXMAo1MEstPfGEGSXAKWEhcf98PZgsLWEq8nATRzCKgKjHnxFN2EJsXKL770FJW
        CFtQ4uTMJywgNrOAvMT2t3OYIU5SkPj5dBkrxDIricMHpjJB1IhIzO5sYwZZLCGwlEPiyMY+
        qB9cJLafuw5lC0u8Or6FHcKWkvj8bi/QERxAdrXEx/1Q8zsYJV58t4WwjSVurt/AClLCLKAp
        sX6XPkRYUWLn77mMEGv5JN597WGFmMIr0dEmBFGiKtF36TAThC0t0dX+gX0Co9IsJI/NQvLY
        LCQPzEJYtoCRZRWjWGpBcW56arFhgSlybG9iBCdULcsdjNPfftA7xMjEwXiIUYKDWUmEN1qU
        M16INyWxsiq1KD++qDQntfgQoykwqCcyS4km5wNTel5JvKGpkbGxsYWJmbmZqbGSOO+/s+zx
        QgLpiSWp2ampBalFMH1MHJxSDUyT2jO59tnHnJjX02kj3Z33/9SzlxLiK3slGM9xepkV2FxR
        2j0pkKdR4d/bFelGJf9Xzr6qt+HQvow1noEWotumdXQE1rw94JQ7ofKQyrNdqdaRy5j3fJ52
        vl2v//f9k+VtTQbtCebXDtRmXDypfJth3a79nycYHPXaJ5S7y9OXv2td+rZjJsY875q29C7y
        WTmJ+dPDmYFJSokxxjrCd6bv/9q+/WFYeNhhs2f3M7n83n3ds53NhH8WY6/hUun5Mg/LZp6/
        oOZavKMj+5G8lX28bHL2q6j2g9ZzlzPKHdj7pKVgr3phNtdje94tnwXOmvdEyVc3SXVdmxX6
        b97afQm5Rfd1/ou4/ijieL055L0SS3FGoqEWc1FxIgAo3mFyMQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJTnf2C+54g+lbjC1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsdjy7wirA7vHlznH2T3aJv9j92g+tpLNY+esu+wefVtW
        MXp83iQXwBbFZZOSmpNZllqkb5fAlbH//UymgqlaFdM/7GJpYPyo2MXIySEhYCLR0LCCtYuR
        i0NIYDejxKPXx5ggEtISx06cYe5i5ACyhSUOHy6GqHnOKHF993tWkBo2AV2Jf3/2s4HYIgJ6
        EidPXmcDKWIWaGaS+PZsCTNIQkigk1Hi5AsWEJtTwELi+vt+sLiwgKXEy0k7wZpZBFQl5px4
        yg5i8wLFdx9aygphC0qcnPmEBeQIZqAFbRsZQcLMAvIS29/OYYa4U0Hi59NlrBA3WEkcPjCV
        CaJGRGJ2ZxvzBEbhWUgmzUKYNAvJpFlIOhYwsqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dL
        zs/dxAiOKi3NHYzbV33QO8TIxMF4iFGCg1lJhDdalDNeiDclsbIqtSg/vqg0J7X4EKM0B4uS
        OO+NwoVxQgLpiSWp2ampBalFMFkmDk6pBqZrBucDj4RvFzps4xJRtP7Kk4/35apzBM5KLe49
        HiF44E7Bg98PXT3WbpzwXNPi+8GgMw2n1We46ax8f2vivNa8hS+XcYa/WxRvXZF87PyTk59W
        L+TyuBJpIlK0sGblG739SRoav2YmiWcfTolRSrbzn3HE44kKr8DsfVc/rtpkKWS+nWvC0Zd/
        +OfMls5/8fy/SUve44hr+U+iHazjSt2mT5toGSd/cLbopuR15W2XvvodmvJhv8xPsep2Lp/A
        7McdfOWxihF+2VfyJpxzXydwzXX7q825bxJ4dskk/jn28rrM79/uqy3yC6uv/d53Purns3Vp
        4d7HJDa+tJvuqNXy+UCGzgPGTc6zgzM+h69ercRSnJFoqMVcVJwIAOCAXFsZAwAA
X-CMS-MailID: 20200713045243epcas1p2570d36dcc0c012233e551a7e00c21a0f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200708095813epcas1p2277cdf7de6a8bb20c27bcd030eec431f
References: <CGME20200708095813epcas1p2277cdf7de6a8bb20c27bcd030eec431f@epcas1p2.samsung.com>
        <20200708095746.4179-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Tetsuhiro,

> Retain ActiveFat, MediaFailure and ClearToZero fields.
> And, never clear VolumeDirty, if it is dirty at mount.
> 
> In '3.1.13.3 Media Failure Field' of exfat specification says ...
>  If, upon mounting a volume, the value of this field is 1, implementations  which scan the entire
> volume for media failures and record all failures as  "bad" clusters in the FAT (or otherwise resolve
> media failures) may clear  the value of this field to 0.
> Therefore, should not clear MediaFailure without scanning volume.
> 
> In '8.1 Recommended Write Ordering' of exfat specification says ...
>  Clear the value of the VolumeDirty field to 0, if its value prior to the  first step was 0 Therefore,
> should not clear VolumeDirty when mounted.
> 
> Also, rename ERR_MEDIUM to MED_FAILURE.
I think that MEDIA_FAILURE looks better.
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
> ---
>  fs/exfat/exfat_fs.h  |  5 +++--
>  fs/exfat/exfat_raw.h |  2 +-
>  fs/exfat/super.c     | 22 ++++++++++++++--------
>  3 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h index cb51d6e83199..3f8dc4ca8109 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -224,7 +224,8 @@ struct exfat_sb_info {
>  	unsigned int num_FAT_sectors; /* num of FAT sectors */
>  	unsigned int root_dir; /* root dir cluster */
>  	unsigned int dentries_per_clu; /* num of dentries per cluster */
> -	unsigned int vol_flag; /* volume dirty flag */
> +	unsigned int vol_flags; /* volume flags */
> +	unsigned int vol_flags_noclear; /* volume flags to retain */
>  	struct buffer_head *boot_bh; /* buffer_head of BOOT sector */
> 
>  	unsigned int map_clu; /* allocation bitmap start cluster */ @@ -380,7 +381,7 @@ static inline
> int exfat_sector_to_cluster(struct exfat_sb_info *sbi,  }
> 
>  /* super.c */
> -int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag);
> +int exfat_set_vol_flags(struct super_block *sb, unsigned short
> +new_flags);
> 
>  /* fatent.c */
>  #define exfat_get_next_cluster(sb, pclu) exfat_ent_get(sb, *(pclu), pclu) diff --git
> a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h index 350ce59cc324..d86a8a6b0601 100644
> --- a/fs/exfat/exfat_raw.h
> +++ b/fs/exfat/exfat_raw.h
> @@ -16,7 +16,7 @@
> 
>  #define VOL_CLEAN		0x0000
>  #define VOL_DIRTY		0x0002
> -#define ERR_MEDIUM		0x0004
> +#define MED_FAILURE		0x0004
> 
>  #define EXFAT_EOF_CLUSTER	0xFFFFFFFFu
>  #define EXFAT_BAD_CLUSTER	0xFFFFFFF7u
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c index b5bf6dedbe11..c26b0f5a0875 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -96,17 +96,22 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	return 0;
>  }
> 
> -int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
> +int exfat_set_vol_flags(struct super_block *sb, unsigned short
> +new_flags)
>  {
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>  	struct boot_sector *p_boot = (struct boot_sector *)sbi->boot_bh->b_data;
>  	bool sync;
If dirty bit is set in on-disk volume flags, we can just return 0 at the beginning
of this function ?

> 
> +	if (new_flags == VOL_CLEAN)
> +		new_flags = (sbi->vol_flags & ~VOL_DIRTY) | sbi->vol_flags_noclear;
> +	else
> +		new_flags |= sbi->vol_flags;
> +
>  	/* flags are not changed */
> -	if (sbi->vol_flag == new_flag)
> +	if (sbi->vol_flags == new_flags)
>  		return 0;
> 
> -	sbi->vol_flag = new_flag;
> +	sbi->vol_flags = new_flags;
> 
>  	/* skip updating volume dirty flag,
>  	 * if this volume has been mounted with read-only @@ -114,9 +119,9 @@ int
> exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
>  	if (sb_rdonly(sb))
>  		return 0;
> 
> -	p_boot->vol_flags = cpu_to_le16(new_flag);
> +	p_boot->vol_flags = cpu_to_le16(new_flags);
How about set or clear only dirty bit to on-disk volume flags instead of using
sbi->vol_flags_noclear ?
       if (set)
               p_boot->vol_flags |= cpu_to_le16(VOL_DIRTY);
       else
               p_boot->vol_flags &= cpu_to_le16(~VOL_DIRTY);

> 
> -	if (new_flag == VOL_DIRTY && !buffer_dirty(sbi->boot_bh))
> +	if ((new_flags & VOL_DIRTY) && !buffer_dirty(sbi->boot_bh))
>  		sync = true;
>  	else
>  		sync = false;
> @@ -457,7 +462,8 @@ static int exfat_read_boot_sector(struct super_block *sb)
>  	sbi->dentries_per_clu = 1 <<
>  		(sbi->cluster_size_bits - DENTRY_SIZE_BITS);
> 
> -	sbi->vol_flag = le16_to_cpu(p_boot->vol_flags);
> +	sbi->vol_flags = le16_to_cpu(p_boot->vol_flags);
> +	sbi->vol_flags_noclear = sbi->vol_flags & (VOL_DIRTY | MED_FAILURE);
>  	sbi->clu_srch_ptr = EXFAT_FIRST_CLUSTER;
>  	sbi->used_clusters = EXFAT_CLUSTERS_UNTRACKED;
> 
> @@ -472,9 +478,9 @@ static int exfat_read_boot_sector(struct super_block *sb)
>  		exfat_err(sb, "bogus data start sector");
>  		return -EINVAL;
>  	}
> -	if (sbi->vol_flag & VOL_DIRTY)
> +	if (sbi->vol_flags & VOL_DIRTY)
>  		exfat_warn(sb, "Volume was not properly unmounted. Some data may be corrupt. Please run
> fsck.");
> -	if (sbi->vol_flag & ERR_MEDIUM)
> +	if (sbi->vol_flags & MED_FAILURE)
>  		exfat_warn(sb, "Medium has reported failures. Some data may be lost.");
> 
>  	/* exFAT file size is limited by a disk volume size */
> --
> 2.25.1


