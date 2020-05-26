Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA851E1C4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 09:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgEZHcp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 03:32:45 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:42443 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgEZHcp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 03:32:45 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200526073239epoutp0379acef783b44db7cfc0e2369507a8c8a~Sg6RClF7o1028410284epoutp03k
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 07:32:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200526073239epoutp0379acef783b44db7cfc0e2369507a8c8a~Sg6RClF7o1028410284epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590478359;
        bh=PfJimvdiNEazsfnAJ3KOEpunw/5Jm4262M9Vn1U1FA4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=n7F5ZXety9SDa2LC8LyBD1UkVqpuHL7pA6hWSBHJDn/vDCwjiV1GQmPJAkUd5MXpM
         cnluRGvbToEyRmrFFgkX52mzAm4w+JHwraAIwCJGK3DCWzS50k+SIwPR/9RNt55D9e
         fBInprpoO171PVWpiFn1QEzWnN5cF7wptgY+0Ypc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200526073239epcas1p104192b116709e48eb03e721eb6cfcc76~Sg6QmbRlm0183201832epcas1p15;
        Tue, 26 May 2020 07:32:39 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.160]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49WQfG32J7zMqYkr; Tue, 26 May
        2020 07:32:38 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.FD.04801.616CCCE5; Tue, 26 May 2020 16:32:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200526073237epcas1p3eabdc05a210b552797469acd103d0ba8~Sg6PIARzw1816618166epcas1p3i;
        Tue, 26 May 2020 07:32:37 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200526073237epsmtrp11924a4909ab68f7926c7e13659af52b5~Sg6PG8YlE1548215482epsmtrp1L;
        Tue, 26 May 2020 07:32:37 +0000 (GMT)
X-AuditID: b6c32a38-f89ff700000012c1-aa-5eccc6160fc8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.04.08303.516CCCE5; Tue, 26 May 2020 16:32:37 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200526073237epsmtip298d04cd994f4a19ba6079caaca4f365b~Sg6O6wMKE1888518885epsmtip2U;
        Tue, 26 May 2020 07:32:37 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200525115052.19243-4-kohada.t2@gmail.com>
Subject: RE: [PATCH 4/4] exfat: standardize checksum calculation
Date:   Tue, 26 May 2020 16:32:37 +0900
Message-ID: <00d301d6332f$d4a52300$7def6900$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEl0VwLAqGTGno4seWfP7lwGg+RAAKJW6foAcSd2fWp+EvHYA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRTu3b3bruXiNq0ORrkuWCrMNuf0WhphUoP6odUPK3De9LZJd9tl
        d/ZhBH2YlYmW5o/WrAy0FM1Q8QtFp5WNPiDLVMK+cJCVUaZUFNrmVfLfc57znPOc876HwJQ1
        shAi2+pg7VaGo2SL8ebeCI16xcMn6ZpPxUD/Kn+N0188ZTjd0enB6RftLhn9YmYCp6smS3G6
        afq+dIvcMOnqkxvyS6flhjMPq2WGNueI3FDUVIMMPxrWpMj2cQlmlsli7SrWmmnLyraaEqkd
        u41bjfpYjVatjafjKJWVsbCJVPLOFPW2bM43C6U6zHA5PiqFEQRqw+YEuy3HwarMNsGRSLF8
        FsdrNXyUwFiEHKspKtNm2ajVaKL1PmUGZx6v65bwn+OPvh94i51EI+oCFEAAGQMzD9yoAC0m
        lGQrgo6p+WACQVvnGYkY/EBwo2hGNl9S9LtBJibaEXh/euViMIbgw7BL6lfJSDVM/+2arQgm
        o8DjGZytwMhTErj9aBLzJwLIeHg8ddXnQRBB5BZ4UBHup3EyDN60NCM/VvgkVZ8HcBEvA8/V
        0VmMkaHQMu7CxIlU8NtbJRW9kiDvSiESNcFw7UI+5vcFsoKAYW/Z3ArJcPd6iUTEQfCpr0ku
        4hAYK86X++cB8jh875rrfx7Bx5+JItbBcP09qV+CkRFQ375BpNdC25/yOdul8HWqUCp2UcD5
        fKUoCYOi/t4501VQcO6b/BKinAsWcy5YzLlgAed/s5sIr0ErWF6wmFhBy8cs/OwGNHunkXQr
        6ni2sweRBKICFXTt43SllDksHLP0ICAwKliR9NRHKbKYY7ms3Wa053Cs0IP0vne/jIUsz7T5
        rt7qMGr10Tqdjo6JjYvV66iVirJBLl1JmhgHe4hledY+XychAkJOovCVguJAZVit+1rJ+kBO
        X6jc0Xhk/9hoVZ37zui6tP5Nvalfw6gTmcY9Q3RX7NDziZp4d3Nx6t68tLGmitBI4Psb245L
        KpnastHynvtnX14/vf3dSPfgriMZUXGh7tUDt94evHgumXlVvYgwv+y7NZ5retU8PFDxLdcT
        5Hq3mfcuoXDBzGgjMbvA/AOYB9KpvQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJXlf02Jk4gyV9+hY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWGz5d4TVgd3jy5zj7B5tk/+xezQfW8nmsXPWXXaPvi2r
        GD0+b5ILYIvisklJzcksSy3St0vgyni79gBTwWvLiodX7zM3MN7V7WLk5JAQMJHo+7mJrYuR
        i0NIYAejRO/mZUwQCWmJYyfOMHcxcgDZwhKHDxdD1DxnlFjy/zY7SA2bgK7Evz/72UBsEQE9
        iZMnr4MNYhZoZpL49mwJM0hCSGA7o8TtK9UgNqeApcTprzOZQIYKCzhIHF2oARJmEVCVuLd9
        GyOIzQtUsuz1VRYIW1Di5MwnLCDlzEDz2zaClTALyEtsfzuHGeJMBYmfT5exQpzgJNEypQeq
        RkRidmcb8wRG4VlIJs1CmDQLyaRZSDoWMLKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P
        3cQIjiktrR2Me1Z90DvEyMTBeIhRgoNZSYTX6ezpOCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
        X2ctjBMSSE8sSc1OTS1ILYLJMnFwSjUwGQgdY1YsKFxj/O+d2E1utW7RuRMT378Sr5HmUd90
        0tOL07AyKySGKZR/muy/rPaSy6sfFTF33/p9SSTivtObaz76QS/2eD/9GLpS6v+sR0lRYfdF
        K8L7tu8IumsVwPmr5IKXuomVam744ayTZ3nZ/sVKJbGuZfixxZpl8c+3KhdOm+c1vL20R2Vl
        Cl+AyaGNesEvOr+t0Pxe+Xz6b09u7zdbzby1Qvc4HtY2mPu2V0bllE6eg+PWiXG7Raw/LogS
        ynbML9beGRZ07fesfX+ffE44/6F1dnS025YOSftGD23R6HkFj9O2tobzh6ldaNvyW2Wua/IC
        p53WhS9Xssctfnus9HJQ+t3e2+d7D21UYinOSDTUYi4qTgQAD3ZAbBgDAAA=
X-CMS-MailID: 20200526073237epcas1p3eabdc05a210b552797469acd103d0ba8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200525115121epcas1p2843be2c4af35d5d7e176c68af95052f8
References: <20200525115052.19243-1-kohada.t2@gmail.com>
        <CGME20200525115121epcas1p2843be2c4af35d5d7e176c68af95052f8@epcas1p2.samsung.com>
        <20200525115052.19243-4-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> To clarify that it is a 16-bit checksum, the parts related to the 16-bit checksum are renamed and
> change type to u16.
> Furthermore, replace checksum calculation in exfat_load_upcase_table() with exfat_calc_checksum32().
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>

I can not apply this patch to exfat dev tree. Could you please check it ?
patching file fs/exfat/dir.c
Hunk #1 succeeded at 491 (offset -5 lines).
Hunk #2 succeeded at 500 (offset -5 lines).
Hunk #3 succeeded at 508 (offset -5 lines).
Hunk #4 FAILED at 600.
Hunk #5 succeeded at 1000 (offset -47 lines).
1 out of 5 hunks FAILED -- saving rejects to file fs/exfat/dir.c.rej
patching file fs/exfat/exfat_fs.h
Hunk #1 succeeded at 137 (offset -2 lines).
Hunk #2 succeeded at 512 (offset -3 lines).
patching file fs/exfat/misc.c
patching file fs/exfat/nls.c

Thanks!
> ---
>  fs/exfat/dir.c      | 12 ++++++------
>  fs/exfat/exfat_fs.h |  5 ++---
>  fs/exfat/misc.c     | 10 ++++------
>  fs/exfat/nls.c      | 19 +++++++------------
>  4 files changed, 19 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index b5a237c33d50..b673362a895c 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -496,7 +496,7 @@ int exfat_update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
>  	int ret = 0;
>  	int i, num_entries;
>  	sector_t sector;
> -	unsigned short chksum;
> +	u16 chksum;
>  	struct exfat_dentry *ep, *fep;
>  	struct buffer_head *fbh, *bh;
> 
> @@ -505,7 +505,7 @@ int exfat_update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
>  		return -EIO;
> 
>  	num_entries = fep->dentry.file.num_ext + 1;
> -	chksum = exfat_calc_chksum_2byte(fep, DENTRY_SIZE, 0, CS_DIR_ENTRY);
> +	chksum = exfat_calc_chksum16(fep, DENTRY_SIZE, 0, CS_DIR_ENTRY);
> 
>  	for (i = 1; i < num_entries; i++) {
>  		ep = exfat_get_dentry(sb, p_dir, entry + i, &bh, NULL); @@ -513,7 +513,7 @@ int
> exfat_update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
>  			ret = -EIO;
>  			goto release_fbh;
>  		}
> -		chksum = exfat_calc_chksum_2byte(ep, DENTRY_SIZE, chksum,
> +		chksum = exfat_calc_chksum16(ep, DENTRY_SIZE, chksum,
>  				CS_DEFAULT);
>  		brelse(bh);
>  	}
> @@ -600,10 +600,10 @@ int exfat_update_dir_chksum_with_entry_set(struct super_block *sb,
>  	int chksum_type = CS_DIR_ENTRY, i, num_entries = es->num_entries;
>  	unsigned int buf_off = (off - es->offset);
>  	unsigned int remaining_byte_in_sector, copy_entries, clu;
> -	unsigned short chksum = 0;
> +	u16 chksum = 0;
> 
>  	for (i = 0; i < num_entries; i++) {
> -		chksum = exfat_calc_chksum_2byte(&es->entries[i], DENTRY_SIZE,
> +		chksum = exfat_calc_chksum16(&es->entries[i], DENTRY_SIZE,
>  			chksum, chksum_type);
>  		chksum_type = CS_DEFAULT;
>  	}
> @@ -1047,7 +1047,7 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
>  			}
> 
>  			if (entry_type == TYPE_STREAM) {
> -				unsigned short name_hash;
> +				u16 name_hash;
> 
>  				if (step != DIRENT_STEP_STRM) {
>  					step = DIRENT_STEP_FILE;
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h index 15817281b3c8..993d13bbebec 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -139,7 +139,7 @@ struct exfat_dentry_namebuf {  struct exfat_uni_name {
>  	/* +3 for null and for converting */
>  	unsigned short name[MAX_NAME_LENGTH + 3];
> -	unsigned short name_hash;
> +	u16 name_hash;
>  	unsigned char name_len;
>  };
> 
> @@ -515,8 +515,7 @@ void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,  void
> exfat_truncate_atime(struct timespec64 *ts);  void exfat_set_entry_time(struct exfat_sb_info *sbi,
> struct timespec64 *ts,
>  		u8 *tz, __le16 *time, __le16 *date, u8 *time_cs); -unsigned short
> exfat_calc_chksum_2byte(void *data, int len,
> -		unsigned short chksum, int type);
> +u16 exfat_calc_chksum16(void *data, int len, u16 chksum, int type);
>  u32 exfat_calc_chksum32(void *data, int len, u32 chksum, int type);  void exfat_update_bh(struct
> super_block *sb, struct buffer_head *bh, int sync);  void exfat_chain_set(struct exfat_chain *ec,
> unsigned int dir, diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c index b82d2dd5bd7c..17d41f3d3709
> 100644
> --- a/fs/exfat/misc.c
> +++ b/fs/exfat/misc.c
> @@ -136,17 +136,15 @@ void exfat_truncate_atime(struct timespec64 *ts)
>  	ts->tv_nsec = 0;
>  }
> 
> -unsigned short exfat_calc_chksum_2byte(void *data, int len,
> -		unsigned short chksum, int type)
> +u16 exfat_calc_chksum16(void *data, int len, u16 chksum, int type)
>  {
>  	int i;
> -	unsigned char *c = (unsigned char *)data;
> +	u8 *c = (u8 *)data;
> 
>  	for (i = 0; i < len; i++, c++) {
> -		if (((i == 2) || (i == 3)) && (type == CS_DIR_ENTRY))
> +		if (unlikely(type == CS_DIR_ENTRY && (i == 2 || i == 3)))
>  			continue;
> -		chksum = (((chksum & 1) << 15) | ((chksum & 0xFFFE) >> 1)) +
> -			(unsigned short)*c;
> +		chksum = ((chksum << 15) | (chksum >> 1)) + *c;
>  	}
>  	return chksum;
>  }
> diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c index 1ebda90cbdd7..19321773dd07 100644
> --- a/fs/exfat/nls.c
> +++ b/fs/exfat/nls.c
> @@ -527,7 +527,7 @@ static int exfat_utf8_to_utf16(struct super_block *sb,
> 
>  	*uniname = '\0';
>  	p_uniname->name_len = unilen;
> -	p_uniname->name_hash = exfat_calc_chksum_2byte(upname, unilen << 1, 0,
> +	p_uniname->name_hash = exfat_calc_chksum16(upname, unilen << 1, 0,
>  			CS_DEFAULT);
> 
>  	if (p_lossy)
> @@ -623,7 +623,7 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
> 
>  	*uniname = '\0';
>  	p_uniname->name_len = unilen;
> -	p_uniname->name_hash = exfat_calc_chksum_2byte(upname, unilen << 1, 0,
> +	p_uniname->name_hash = exfat_calc_chksum16(upname, unilen << 1, 0,
>  			CS_DEFAULT);
> 
>  	if (p_lossy)
> @@ -655,7 +655,8 @@ static int exfat_load_upcase_table(struct super_block *sb,  {
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>  	unsigned int sect_size = sb->s_blocksize;
> -	unsigned int i, index = 0, checksum = 0;
> +	unsigned int i, index = 0;
> +	u32 chksum = 0;
>  	int ret;
>  	unsigned char skip = false;
>  	unsigned short *upcase_table;
> @@ -681,13 +682,6 @@ static int exfat_load_upcase_table(struct super_block *sb,
>  		for (i = 0; i < sect_size && index <= 0xFFFF; i += 2) {
>  			unsigned short uni = get_unaligned_le16(bh->b_data + i);
> 
> -			checksum = ((checksum & 1) ? 0x80000000 : 0) +
> -				(checksum >> 1) +
> -				*(((unsigned char *)bh->b_data) + i);
> -			checksum = ((checksum & 1) ? 0x80000000 : 0) +
> -				(checksum >> 1) +
> -				*(((unsigned char *)bh->b_data) + (i + 1));
> -
>  			if (skip) {
>  				index += uni;
>  				skip = false;
> @@ -701,13 +695,14 @@ static int exfat_load_upcase_table(struct super_block *sb,
>  			}
>  		}
>  		brelse(bh);
> +		chksum = exfat_calc_chksum32(bh->b_data, i, chksum, CS_DEFAULT);
>  	}
> 
> -	if (index >= 0xFFFF && utbl_checksum == checksum)
> +	if (index >= 0xFFFF && utbl_checksum == chksum)
>  		return 0;
> 
>  	exfat_err(sb, "failed to load upcase table (idx : 0x%08x, chksum : 0x%08x, utbl_chksum :
> 0x%08x)",
> -		  index, checksum, utbl_checksum);
> +		  index, chksum, utbl_checksum);
>  	ret = -EINVAL;
>  free_table:
>  	exfat_free_upcase_table(sbi);
> --
> 2.25.1


