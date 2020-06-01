Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97821EA3A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 14:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgFAMSf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 08:18:35 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:46708 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgFAMSe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:18:34 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200601121831epoutp032c5b910becc314fd36eedd185524f3ad~UarkL9az63044830448epoutp03N
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2020 12:18:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200601121831epoutp032c5b910becc314fd36eedd185524f3ad~UarkL9az63044830448epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591013911;
        bh=FI4hB0IZkiFVBnRVOoJY44uSsBK0SGUyB1rfRSJBeKg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=eSfNi7dncQqKSuUoF5dvhycfYRD6NCU4+MJ8OP6o6Uoqz37prUC3BKreTpWHEOepV
         nW9RLHz825Kz6KyBoOfqfJCHL57JbSiV7/Kb7mpvxu78mZzhIm0w/EHqoSLPMNMC83
         J7HDDvDDtzDUkhyuXt82nuVG2reSsDB6HNcQJpnw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200601121830epcas1p122a584785445e5366bf1224fcb7287c2~Uari-YcYn1530515305epcas1p1s;
        Mon,  1 Jun 2020 12:18:30 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.162]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49bDjK1F3tzMqYkc; Mon,  1 Jun
        2020 12:18:29 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.F3.19033.512F4DE5; Mon,  1 Jun 2020 21:18:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200601121828epcas1p1b3c5202ffe1596f586bc43a4193763ee~UarhhTzXj1753717537epcas1p1n;
        Mon,  1 Jun 2020 12:18:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200601121828epsmtrp2f3fb641f2743d83592bc24ca9c6b1ae0~Uarhgf0Ds2229322293epsmtrp2w;
        Mon,  1 Jun 2020 12:18:28 +0000 (GMT)
X-AuditID: b6c32a36-16fff70000004a59-6c-5ed4f2154bf7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.83.08382.412F4DE5; Mon,  1 Jun 2020 21:18:28 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200601121828epsmtip1990cd3368fe6862a108a6ffe645cf923~UarhOt9he3048030480epsmtip1M;
        Mon,  1 Jun 2020 12:18:28 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200529101459.8546-1-kohada.t2@gmail.com>
Subject: RE: [PATCH 1/4 v3] exfat: redefine PBR as boot_sector
Date:   Mon, 1 Jun 2020 21:18:28 +0900
Message-ID: <1ffd01d6380e$c18bcab0$44a36010$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQI7k4sUwKqWitwghFE4b9wMMqm66QECpNOBp/DgdxA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmga7opytxBpu2sVn8mHubxeLNyaks
        Fnv2nmSxuLxrDpvF5f+fWCyWfZnMYvFjer0Du8eXOcfZPdom/2P3aD62ks1j56y77B59W1Yx
        enzeJBfAFpVjk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuW
        mQN0ipJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwNCgQK84Mbe4NC9dLzk/18rQ
        wMDIFKgyISfj+45trAWboyuu3t3H2MC4z7OLkZNDQsBE4uPhE8wgtpDADkaJwzOMuxi5gOxP
        jBJ/tx5jgXC+MUps/7SLEaZj958LzBCJvYwS8w9cZ4RwXjJKTH50jAmkik1AV+LJjZ9gc0UE
        9CROnrzOBmIzCzQySZx4mQ1icwpYSKy7tYwdxBYWsJM4OKORFcRmEVCRuN80C8zmFbCUuLGz
        nx3CFpQ4OfMJC8QceYntb+cwQ1ykILH701FWiF1WEu+mHWeEqBGRmN3ZBnaphMBCDok332Yy
        QTS4SJz+tIsFwhaWeHV8CzuELSXx+d1eNgi7mVGi764nRHMLo8SqHU1QCWOJT58/A23gANqg
        KbF+lz5EWFFi5++5UIv5JN597WEFKZEQ4JXoaBOCKFGR+P5hJwvMqis/rjJNYFSaheS1WUhe
        m4XkhVkIyxYwsqxiFEstKM5NTy02LDBCju1NjOB0qmW2g3HS2w96hxiZOBgPMUpwMCuJ8E5W
        vxQnxJuSWFmVWpQfX1Sak1p8iNEUGNgTmaVEk/OBCT2vJN7Q1MjY2NjCxMzczNRYSZxXTeZC
        nJBAemJJanZqakFqEUwfEwenVAOTj+nbPwL336088/PbHt7CTwKH9uodU5muqH7UVMHW1nrj
        N5GFv8wbHUoOl3LGMU4zWyjwmTs4yvLlhtLdCz1XegQ/q+6/+zX+tULM4q++cm7f/tnaas7Z
        yf/5bs/TE+aZbKk9Zl+KNx+5X2BRc+SC1ar05ENzk/6tXxGxatnx3hNZ26xn3ln50O3anzWn
        eSfZlt/bPyf0t9nzKzveu23N7Mv/9u54yElx36BvxTPb5C5rXY78H7huefP5y+seH2ReMbnm
        xce60GDj43U7L5xf5O2jvnJOoezUdL9FeZ85WTIX6D16oK/25KiLT8KvA0E3LOS7bATvzWM4
        UelXteyJhPNbI3bB5aeuv1Gssd/xvkaJpTgj0VCLuag4EQAWmm1zMAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJTlfk05U4g/bLIhY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWPyYXu/A7vFlznF2j7bJ/9g9mo+tZPPYOesuu0ffllWM
        Hp83yQWwRXHZpKTmZJalFunbJXBlfN+xjbVgc3TF1bv7GBsY93l2MXJySAiYSOz+c4G5i5GL
        Q0hgN6PE0x9v2boYOYASUhIH92lCmMIShw8XQ5Q8Z5ToPziXDaSXTUBX4smNn8wgtoiAnsTJ
        k9fZQIqYBZqZJFq/NDNBdHQySrzeO4cJpIpTwEJi3a1l7CC2sICdxMEZjawgNouAisT9pllg
        Nq+ApcSNnf3sELagxMmZT1hArmAG2tC2kREkzCwgL7H97RxmiAcUJHZ/OsoKcYSVxLtpx6Fq
        RCRmd7YxT2AUnoVk0iyESbOQTJqFpGMBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95Pzc
        TYzgmNLS3MG4fdUHvUOMTByMhxglOJiVRHgnq1+KE+JNSaysSi3Kjy8qzUktPsQozcGiJM57
        o3BhnJBAemJJanZqakFqEUyWiYNTqoHJ4dM+YRduD7MUXb3fyq2Js/rlXhYss/oSYGi1eNtW
        yYMOmcoWqpZPWBvfPbdd2ZCwzbHUbXJJld+D7zvvSvZymTj1O53ZYfJ5fn/w1aI0+bipLf4y
        kl4MZV4JQrtOMF3W/c/5fFbytyX2OgdKH8Xp8YgWGU3Kidt58L2wtnjIgUaPyT2Jzyp9l5T9
        9WFM3sTy5Wvlmuc56t7XFZZdF08TuN4+OfB2+FGzBJ1S1sbGzV1/E66tWiZ6bu7yh+HLyyc/
        PCdRYSGc5/puxpvFD7ZIHPoqzeoakc5TbK9YeXqb2XK/Q+u3LJ2z89dSsUN2Ziysi0vLp1/4
        qJxweMY6i66Zl5o6T1b4WvQZW/yZ8FqJpTgj0VCLuag4EQD5I5JRGAMAAA==
X-CMS-MailID: 20200601121828epcas1p1b3c5202ffe1596f586bc43a4193763ee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200529101523epcas1p192c6ad12d846dc9119b9a755a3650fd0
References: <CGME20200529101523epcas1p192c6ad12d846dc9119b9a755a3650fd0@epcas1p1.samsung.com>
        <20200529101459.8546-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Aggregate PBR related definitions and redefine as "boot_sector" to comply
> with the exFAT specification.
> And, rename variable names including 'pbr'.
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

> ---
> Changes in v2:
>  - rebase with patch 'optimize dir-cache' applied Changes in v3:
>  - rename BOOTSEC_OEM_NAME_LEN to BOOTSEC_FS_NAME_LEN
>  - rename oem_name to fs_name in struct boot_sector
> 
>  fs/exfat/exfat_fs.h  |  2 +-
>  fs/exfat/exfat_raw.h | 79 +++++++++++++++--------------------------
>  fs/exfat/super.c     | 84 ++++++++++++++++++++++----------------------
>  3 files changed, 72 insertions(+), 93 deletions(-)
> 
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h index
> 5caad1380818..9673e2d31045 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -227,7 +227,7 @@ struct exfat_sb_info {
>  	unsigned int root_dir; /* root dir cluster */
>  	unsigned int dentries_per_clu; /* num of dentries per cluster */
>  	unsigned int vol_flag; /* volume dirty flag */
> -	struct buffer_head *pbr_bh; /* buffer_head of PBR sector */
> +	struct buffer_head *boot_bh; /* buffer_head of BOOT sector */
> 
>  	unsigned int map_clu; /* allocation bitmap start cluster */
>  	unsigned int map_sectors; /* num of allocation bitmap sectors */
> diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h index
> 8d6c64a7546d..07f74190df44 100644
> --- a/fs/exfat/exfat_raw.h
> +++ b/fs/exfat/exfat_raw.h
> @@ -8,7 +8,8 @@
> 
>  #include <linux/types.h>
> 
> -#define PBR_SIGNATURE		0xAA55
> +#define BOOT_SIGNATURE		0xAA55
> +#define EXBOOT_SIGNATURE	0xAA550000
> 
>  #define EXFAT_MAX_FILE_LEN	255
> 
> @@ -55,7 +56,7 @@
> 
>  /* checksum types */
>  #define CS_DIR_ENTRY		0
> -#define CS_PBR_SECTOR		1
> +#define CS_BOOT_SECTOR		1
>  #define CS_DEFAULT		2
> 
>  /* file attributes */
> @@ -69,57 +70,35 @@
>  #define ATTR_RWMASK		(ATTR_HIDDEN | ATTR_SYSTEM | ATTR_VOLUME
> | \
>  				 ATTR_SUBDIR | ATTR_ARCHIVE)
> 
> -#define PBR64_JUMP_BOOT_LEN		3
> -#define PBR64_OEM_NAME_LEN		8
> -#define PBR64_RESERVED_LEN		53
> +#define BOOTSEC_JUMP_BOOT_LEN		3
> +#define BOOTSEC_FS_NAME_LEN		8
> +#define BOOTSEC_OLDBPB_LEN		53
> 
>  #define EXFAT_FILE_NAME_LEN		15
> 
> -/* EXFAT BIOS parameter block (64 bytes) */ -struct bpb64 {
> -	__u8 jmp_boot[PBR64_JUMP_BOOT_LEN];
> -	__u8 oem_name[PBR64_OEM_NAME_LEN];
> -	__u8 res_zero[PBR64_RESERVED_LEN];
> -} __packed;
> -
> -/* EXFAT EXTEND BIOS parameter block (56 bytes) */ -struct bsx64 {
> -	__le64 vol_offset;
> -	__le64 vol_length;
> -	__le32 fat_offset;
> -	__le32 fat_length;
> -	__le32 clu_offset;
> -	__le32 clu_count;
> -	__le32 root_cluster;
> -	__le32 vol_serial;
> -	__u8 fs_version[2];
> -	__le16 vol_flags;
> -	__u8 sect_size_bits;
> -	__u8 sect_per_clus_bits;
> -	__u8 num_fats;
> -	__u8 phy_drv_no;
> -	__u8 perc_in_use;
> -	__u8 reserved2[7];
> -} __packed;
> -
> -/* EXFAT PBR[BPB+BSX] (120 bytes) */
> -struct pbr64 {
> -	struct bpb64 bpb;
> -	struct bsx64 bsx;
> -} __packed;
> -
> -/* Common PBR[Partition Boot Record] (512 bytes) */ -struct pbr {
> -	union {
> -		__u8 raw[64];
> -		struct bpb64 f64;
> -	} bpb;
> -	union {
> -		__u8 raw[56];
> -		struct bsx64 f64;
> -	} bsx;
> -	__u8 boot_code[390];
> -	__le16 signature;
> +/* EXFAT: Main and Backup Boot Sector (512 bytes) */ struct boot_sector
> +{
> +	__u8	jmp_boot[BOOTSEC_JUMP_BOOT_LEN];
> +	__u8	fs_name[BOOTSEC_FS_NAME_LEN];
> +	__u8	must_be_zero[BOOTSEC_OLDBPB_LEN];
> +	__le64	partition_offset;
> +	__le64	vol_length;
> +	__le32	fat_offset;
> +	__le32	fat_length;
> +	__le32	clu_offset;
> +	__le32	clu_count;
> +	__le32	root_cluster;
> +	__le32	vol_serial;
> +	__u8	fs_revision[2];
> +	__le16	vol_flags;
> +	__u8	sect_size_bits;
> +	__u8	sect_per_clus_bits;
> +	__u8	num_fats;
> +	__u8	drv_sel;
> +	__u8	percent_in_use;
> +	__u8	reserved[7];
> +	__u8	boot_code[390];
> +	__le16	signature;
>  } __packed;
> 
>  struct exfat_dentry {
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c index
> c1f47f4071a8..e60d28e73ff0 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -49,7 +49,7 @@ static void exfat_put_super(struct super_block *sb)
>  		sync_blockdev(sb->s_bdev);
>  	exfat_set_vol_flags(sb, VOL_CLEAN);
>  	exfat_free_bitmap(sbi);
> -	brelse(sbi->pbr_bh);
> +	brelse(sbi->boot_bh);
>  	mutex_unlock(&sbi->s_lock);
> 
>  	call_rcu(&sbi->rcu, exfat_delayed_free); @@ -101,7 +101,7 @@ static
> int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)  int
> exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)  {
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> -	struct pbr64 *bpb = (struct pbr64 *)sbi->pbr_bh->b_data;
> +	struct boot_sector *p_boot = (struct boot_sector
> +*)sbi->boot_bh->b_data;
>  	bool sync;
> 
>  	/* flags are not changed */
> @@ -116,18 +116,18 @@ int exfat_set_vol_flags(struct super_block *sb,
> unsigned short new_flag)
>  	if (sb_rdonly(sb))
>  		return 0;
> 
> -	bpb->bsx.vol_flags = cpu_to_le16(new_flag);
> +	p_boot->vol_flags = cpu_to_le16(new_flag);
> 
> -	if (new_flag == VOL_DIRTY && !buffer_dirty(sbi->pbr_bh))
> +	if (new_flag == VOL_DIRTY && !buffer_dirty(sbi->boot_bh))
>  		sync = true;
>  	else
>  		sync = false;
> 
> -	set_buffer_uptodate(sbi->pbr_bh);
> -	mark_buffer_dirty(sbi->pbr_bh);
> +	set_buffer_uptodate(sbi->boot_bh);
> +	mark_buffer_dirty(sbi->boot_bh);
> 
>  	if (sync)
> -		sync_dirty_buffer(sbi->pbr_bh);
> +		sync_dirty_buffer(sbi->boot_bh);
>  	return 0;
>  }
> 
> @@ -366,13 +366,14 @@ static int exfat_read_root(struct inode *inode)
>  	return 0;
>  }
> 
> -static struct pbr *exfat_read_pbr_with_logical_sector(struct super_block
> *sb)
> +static struct boot_sector *exfat_read_boot_with_logical_sector(
> +		struct super_block *sb)
>  {
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> -	struct pbr *p_pbr = (struct pbr *) (sbi->pbr_bh)->b_data;
> +	struct boot_sector *p_boot = (struct boot_sector
> +*)sbi->boot_bh->b_data;
>  	unsigned short logical_sect = 0;
> 
> -	logical_sect = 1 << p_pbr->bsx.f64.sect_size_bits;
> +	logical_sect = 1 << p_boot->sect_size_bits;
> 
>  	if (!is_power_of_2(logical_sect) ||
>  	    logical_sect < 512 || logical_sect > 4096) { @@ -387,49 +388,48
> @@ static struct pbr *exfat_read_pbr_with_logical_sector(struct
> super_block *sb)
>  	}
> 
>  	if (logical_sect > sb->s_blocksize) {
> -		brelse(sbi->pbr_bh);
> -		sbi->pbr_bh = NULL;
> +		brelse(sbi->boot_bh);
> +		sbi->boot_bh = NULL;
> 
>  		if (!sb_set_blocksize(sb, logical_sect)) {
>  			exfat_err(sb, "unable to set blocksize %u",
>  				  logical_sect);
>  			return NULL;
>  		}
> -		sbi->pbr_bh = sb_bread(sb, 0);
> -		if (!sbi->pbr_bh) {
> +		sbi->boot_bh = sb_bread(sb, 0);
> +		if (!sbi->boot_bh) {
>  			exfat_err(sb, "unable to read boot sector (logical
> sector size = %lu)",
>  				  sb->s_blocksize);
>  			return NULL;
>  		}
> 
> -		p_pbr = (struct pbr *)sbi->pbr_bh->b_data;
> +		p_boot = (struct boot_sector *)sbi->boot_bh->b_data;
>  	}
> -	return p_pbr;
> +	return p_boot;
>  }
> 
>  /* mount the file system volume */
>  static int __exfat_fill_super(struct super_block *sb)  {
>  	int ret;
> -	struct pbr *p_pbr;
> -	struct pbr64 *p_bpb;
> +	struct boot_sector *p_boot;
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> 
>  	/* set block size to read super block */
>  	sb_min_blocksize(sb, 512);
> 
>  	/* read boot sector */
> -	sbi->pbr_bh = sb_bread(sb, 0);
> -	if (!sbi->pbr_bh) {
> +	sbi->boot_bh = sb_bread(sb, 0);
> +	if (!sbi->boot_bh) {
>  		exfat_err(sb, "unable to read boot sector");
>  		return -EIO;
>  	}
> 
>  	/* PRB is read */
> -	p_pbr = (struct pbr *)sbi->pbr_bh->b_data;
> +	p_boot = (struct boot_sector *)sbi->boot_bh->b_data;
> 
> -	/* check the validity of PBR */
> -	if (le16_to_cpu((p_pbr->signature)) != PBR_SIGNATURE) {
> +	/* check the validity of BOOT */
> +	if (le16_to_cpu((p_boot->signature)) != BOOT_SIGNATURE) {
>  		exfat_err(sb, "invalid boot record signature");
>  		ret = -EINVAL;
>  		goto free_bh;
> @@ -437,8 +437,8 @@ static int __exfat_fill_super(struct super_block *sb)
> 
> 
>  	/* check logical sector size */
> -	p_pbr = exfat_read_pbr_with_logical_sector(sb);
> -	if (!p_pbr) {
> +	p_boot = exfat_read_boot_with_logical_sector(sb);
> +	if (!p_boot) {
>  		ret = -EIO;
>  		goto free_bh;
>  	}
> @@ -447,43 +447,43 @@ static int __exfat_fill_super(struct super_block
*sb)
>  	 * res_zero field must be filled with zero to prevent mounting
>  	 * from FAT volume.
>  	 */
> -	if (memchr_inv(p_pbr->bpb.f64.res_zero, 0,
> -			sizeof(p_pbr->bpb.f64.res_zero))) {
> +	if (memchr_inv(p_boot->must_be_zero, 0,
> +			sizeof(p_boot->must_be_zero))) {
>  		ret = -EINVAL;
>  		goto free_bh;
>  	}
> 
> -	p_bpb = (struct pbr64 *)p_pbr;
> -	if (!p_bpb->bsx.num_fats) {
> +	p_boot = (struct boot_sector *)p_boot;
> +	if (!p_boot->num_fats) {
>  		exfat_err(sb, "bogus number of FAT structure");
>  		ret = -EINVAL;
>  		goto free_bh;
>  	}
> 
> -	sbi->sect_per_clus = 1 << p_bpb->bsx.sect_per_clus_bits;
> -	sbi->sect_per_clus_bits = p_bpb->bsx.sect_per_clus_bits;
> +	sbi->sect_per_clus = 1 << p_boot->sect_per_clus_bits;
> +	sbi->sect_per_clus_bits = p_boot->sect_per_clus_bits;
>  	sbi->cluster_size_bits = sbi->sect_per_clus_bits + sb-
> >s_blocksize_bits;
>  	sbi->cluster_size = 1 << sbi->cluster_size_bits;
> -	sbi->num_FAT_sectors = le32_to_cpu(p_bpb->bsx.fat_length);
> -	sbi->FAT1_start_sector = le32_to_cpu(p_bpb->bsx.fat_offset);
> -	sbi->FAT2_start_sector = p_bpb->bsx.num_fats == 1 ?
> +	sbi->num_FAT_sectors = le32_to_cpu(p_boot->fat_length);
> +	sbi->FAT1_start_sector = le32_to_cpu(p_boot->fat_offset);
> +	sbi->FAT2_start_sector = p_boot->num_fats == 1 ?
>  		sbi->FAT1_start_sector :
>  			sbi->FAT1_start_sector + sbi->num_FAT_sectors;
> -	sbi->data_start_sector = le32_to_cpu(p_bpb->bsx.clu_offset);
> -	sbi->num_sectors = le64_to_cpu(p_bpb->bsx.vol_length);
> +	sbi->data_start_sector = le32_to_cpu(p_boot->clu_offset);
> +	sbi->num_sectors = le64_to_cpu(p_boot->vol_length);
>  	/* because the cluster index starts with 2 */
> -	sbi->num_clusters = le32_to_cpu(p_bpb->bsx.clu_count) +
> +	sbi->num_clusters = le32_to_cpu(p_boot->clu_count) +
>  		EXFAT_RESERVED_CLUSTERS;
> 
> -	sbi->root_dir = le32_to_cpu(p_bpb->bsx.root_cluster);
> +	sbi->root_dir = le32_to_cpu(p_boot->root_cluster);
>  	sbi->dentries_per_clu = 1 <<
>  		(sbi->cluster_size_bits - DENTRY_SIZE_BITS);
> 
> -	sbi->vol_flag = le16_to_cpu(p_bpb->bsx.vol_flags);
> +	sbi->vol_flag = le16_to_cpu(p_boot->vol_flags);
>  	sbi->clu_srch_ptr = EXFAT_FIRST_CLUSTER;
>  	sbi->used_clusters = EXFAT_CLUSTERS_UNTRACKED;
> 
> -	if (le16_to_cpu(p_bpb->bsx.vol_flags) & VOL_DIRTY) {
> +	if (le16_to_cpu(p_boot->vol_flags) & VOL_DIRTY) {
>  		sbi->vol_flag |= VOL_DIRTY;
>  		exfat_warn(sb, "Volume was not properly unmounted. Some data
> may be corrupt. Please run fsck.");
>  	}
> @@ -517,7 +517,7 @@ static int __exfat_fill_super(struct super_block *sb)
>  free_upcase_table:
>  	exfat_free_upcase_table(sbi);
>  free_bh:
> -	brelse(sbi->pbr_bh);
> +	brelse(sbi->boot_bh);
>  	return ret;
>  }
> 
> @@ -608,7 +608,7 @@ static int exfat_fill_super(struct super_block *sb,
> struct fs_context *fc)
>  free_table:
>  	exfat_free_upcase_table(sbi);
>  	exfat_free_bitmap(sbi);
> -	brelse(sbi->pbr_bh);
> +	brelse(sbi->boot_bh);
> 
>  check_nls_io:
>  	unload_nls(sbi->nls_io);
> --
> 2.25.1


