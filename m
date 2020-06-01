Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AE01EA3A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 14:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgFAMUc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 08:20:32 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:30306 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgFAMUb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:20:31 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200601122028epoutp024af02ddcf7dcc7b0996d20ea1c0860ad~UatRZq3kK0691006910epoutp02l
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2020 12:20:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200601122028epoutp024af02ddcf7dcc7b0996d20ea1c0860ad~UatRZq3kK0691006910epoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591014028;
        bh=dy69MGQgELlHLL4nuipB9eWH9vUU1X+psE1Q1svnC+Q=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=DIR8jNmzag2Gz8ba1mv5pnQv5a/+JiNXxZZGt7ZSef7RxYZ8hV4LNZlkHqm4LHYlW
         J8x5RY/zbIdfU+jx6PpQ7jE6XZYAoXgLgUnw9h4F5cpHV+d6zcy4UEVwPokkZku+l7
         PVnMuJJMyhXmUQ1FmPWWR4bvomaEQsX+QCUXFonk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200601122028epcas1p2ff39bf4111e69ee6d9ff974427e1727f~UatQ65CSS2504625046epcas1p2x;
        Mon,  1 Jun 2020 12:20:28 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.161]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49bDlb1mvkzMqYkb; Mon,  1 Jun
        2020 12:20:27 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.CB.28581.B82F4DE5; Mon,  1 Jun 2020 21:20:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200601122026epcas1p22567fb0e0b9aeae89556e59a6f50ef67~UatPgBfk92949729497epcas1p2T;
        Mon,  1 Jun 2020 12:20:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200601122026epsmtrp15694e23b5327fe306dd7ddf83f8cf11e~UatPfbEEn1178611786epsmtrp1U;
        Mon,  1 Jun 2020 12:20:26 +0000 (GMT)
X-AuditID: b6c32a38-2cdff70000006fa5-94-5ed4f28bff21
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.A3.08382.A82F4DE5; Mon,  1 Jun 2020 21:20:26 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200601122026epsmtip21ea8f739fab07ad4f07e5273a9aa9a43~UatPTUecf0351003510epsmtip2W;
        Mon,  1 Jun 2020 12:20:26 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200529101459.8546-4-kohada.t2@gmail.com>
Subject: RE: [PATCH 4/4 v3] exfat: standardize checksum calculation
Date:   Mon, 1 Jun 2020 21:20:26 +0900
Message-ID: <1fff01d6380f$07fdd970$17f98c50$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQECpNOBCAKs/TRXObwEq14CKUeHvgGnqJluAgpaxnmqTUQv4A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmnm73pytxBp8O81j8mHubxeLNyaks
        Fnv2nmSxuLxrDpvF5f+fWCyWfZnMYvFjer0Du8eXOcfZPdom/2P3aD62ks1j56y77B59W1Yx
        enzeJBfAFpVjk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuW
        mQN0ipJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwNCgQK84Mbe4NC9dLzk/18rQ
        wMDIFKgyISfjT0sXW8Eus4rtnT0sDYy3tLoYOTkkBEwkZpxcyNTFyMUhJLCDUaJ5/kMWCOcT
        o8Sla//ZIZxvjBLvZ89kg2l5t385G0RiL6PE5FsvWSGcl4wSM84/ZAapYhPQlXhy4yeYLSKg
        J3Hy5HWwbmaBRiaJEy+zQWxOAQuJTS0NYDXCAs4SByY+ZgKxWQRUJOaf/QcW5xWwlPgz/wmU
        LShxcuYTFog58hLb385hhrhIQWL3p6OsELucJDq2foWqEZGY3dnGDHKchMBCDonW9m1QL7hI
        TDu7gwXCFpZ4dXwLO4QtJfGyvw3KbmaU6LvrCdHcwiixakcTVLOxxKfPnxm7GDmANmhKrN+l
        DxFWlNj5ey4jxGI+iXdfe1hBSiQEeCU62oQgSlQkvn/YyQKz6sqPq0wTGJVmIXltFpLXZiF5
        YRbCsgWMLKsYxVILinPTU4sNC0yQo3sTIzihalnsYJz79oPeIUYmDsZDjBIczEoivJPVL8UJ
        8aYkVlalFuXHF5XmpBYfYjQFBvZEZinR5HxgSs8riTc0NTI2NrYwMTM3MzVWEuc9aXUhTkgg
        PbEkNTs1tSC1CKaPiYNTqoGpSuR8fi/bMn/5qquL3QRU2Ba2cZ1zf/dgzgxLhwmcM4LuGml2
        eX2yvdbR9lJCpMfEUebuik+P30eZp+2+/oTN5qAE9+09M2Y2dlbrHNtarb3C7NASs6OPbbO+
        PqwzMJslauiyuyr1ZU/okrxG59MvH93w617DcT/ZLGO50zKp2hamN6YTzNaEbLzZG7foNVul
        2eSPMZPfOjC9V7TamCWYv37XF3sH2cth5/rFZu9/Ffuu5juv3rFVH/bO47p1SPnoXf6b2ol2
        n+fxJr//cId5yx17maC1DzX+7+i7vtXfttO9IWqWnAZ75QSlmr68Sxb26VFThHviVe8dTmEU
        4nRm+HV8r2iq4YLPFunT/HiUWIozEg21mIuKEwFyrTSLMQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXrfr05U4g0MrZS1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsfgxvd6B3ePLnOPsHm2T/7F7NB9byeaxc9Zddo++LasY
        PT5vkgtgi+KySUnNySxLLdK3S+DK+NPSxVawy6xie2cPSwPjLa0uRk4OCQETiXf7l7N1MXJx
        CAnsZpS4OWMBcxcjB1BCSuLgPk0IU1ji8OFiiJLnjBKbLhxmBullE9CVeHLjJ5gtIqAncfLk
        dbA5zALNTBKtX5qZQBJCAlsZJT4u4AWxOQUsJDa1NIA1CAs4SxyY+BishkVARWL+2X9gcV4B
        S4k/859A2YISJ2c+YQE5ghloQdtGRpAws4C8xPa3c5gh7leQ2P3pKCvEDU4SHVu/skDUiEjM
        7mxjnsAoPAvJpFkIk2YhmTQLSccCRpZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjB
        EaWluYNx+6oPeocYmTgYDzFKcDArifBOVr8UJ8SbklhZlVqUH19UmpNafIhRmoNFSZz3RuHC
        OCGB9MSS1OzU1ILUIpgsEwenVAOTUuW8J8yHjh+LYf9duTaUv4w/5UZT9H2Bbq+3S/seWn/J
        vpN4UuQC44cZPxZxLz+96NQtzlkHZA/cfXlbv2jfIcZAsT9nDNKLZy3WNvaLf83BWTjJ5tGv
        KX1f+gWF7zE9CnE8vUzss4GYVNrb8EdiFvvqns9h/sXxu/ig1b7E58d3hfd/nRD99JrSgoBu
        beepq0OKltr46DbzX14w8eqOr8mXV39+XX16c9bxvZtqT5c+fHaEO0xAMX07g6jRhs6zujyF
        5dtObNTcufrPBIuCgFsv3139G8DI/b/a/NqrSRuZHk5NvRUjcMuz92DZ07CWieJ7vHIrhG59
        UQ/RnyT54p6D9LOShRZGdTaHww6uDlJiKc5INNRiLipOBABEZTelFwMAAA==
X-CMS-MailID: 20200601122026epcas1p22567fb0e0b9aeae89556e59a6f50ef67
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200529101637epcas1p24499ced02928374f9140d59dc7c1e99c
References: <20200529101459.8546-1-kohada.t2@gmail.com>
        <CGME20200529101637epcas1p24499ced02928374f9140d59dc7c1e99c@epcas1p2.samsung.com>
        <20200529101459.8546-4-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> To clarify that it is a 16-bit checksum, the parts related to the 16-bit
> checksum are renamed and change type to u16.
> Furthermore, replace checksum calculation in exfat_load_upcase_table()
> with exfat_calc_checksum32().
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

> ---
> Changes in v2:
>  - rebase with patch 'optimize dir-cache' applied Changes in v3:
>  - based on '[PATCH 2/4 v3] exfat: separate the boot sector analysis'
> 
>  fs/exfat/dir.c      | 12 ++++++------
>  fs/exfat/exfat_fs.h |  5 ++---
>  fs/exfat/misc.c     | 10 ++++------
>  fs/exfat/nls.c      | 19 +++++++------------
>  4 files changed, 19 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
> 2902d285bf20..de43534aa299 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -491,7 +491,7 @@ int exfat_update_dir_chksum(struct inode *inode,
> struct exfat_chain *p_dir,
>  	int ret = 0;
>  	int i, num_entries;
>  	sector_t sector;
> -	unsigned short chksum;
> +	u16 chksum;
>  	struct exfat_dentry *ep, *fep;
>  	struct buffer_head *fbh, *bh;
> 
> @@ -500,7 +500,7 @@ int exfat_update_dir_chksum(struct inode *inode,
> struct exfat_chain *p_dir,
>  		return -EIO;
> 
>  	num_entries = fep->dentry.file.num_ext + 1;
> -	chksum = exfat_calc_chksum_2byte(fep, DENTRY_SIZE, 0, CS_DIR_ENTRY);
> +	chksum = exfat_calc_chksum16(fep, DENTRY_SIZE, 0, CS_DIR_ENTRY);
> 
>  	for (i = 1; i < num_entries; i++) {
>  		ep = exfat_get_dentry(sb, p_dir, entry + i, &bh, NULL); @@ -
> 508,7 +508,7 @@ int exfat_update_dir_chksum(struct inode *inode, struct
> exfat_chain *p_dir,
>  			ret = -EIO;
>  			goto release_fbh;
>  		}
> -		chksum = exfat_calc_chksum_2byte(ep, DENTRY_SIZE, chksum,
> +		chksum = exfat_calc_chksum16(ep, DENTRY_SIZE, chksum,
>  				CS_DEFAULT);
>  		brelse(bh);
>  	}
> @@ -593,8 +593,8 @@ void exfat_update_dir_chksum_with_entry_set(struct
> exfat_entry_set_cache *es)
> 
>  	for (i = 0; i < es->num_entries; i++) {
>  		ep = exfat_get_dentry_cached(es, i);
> -		chksum = exfat_calc_chksum_2byte(ep, DENTRY_SIZE, chksum,
> -						 chksum_type);
> +		chksum = exfat_calc_chksum16(ep, DENTRY_SIZE, chksum,
> +					     chksum_type);
>  		chksum_type = CS_DEFAULT;
>  	}
>  	ep = exfat_get_dentry_cached(es, 0);
> @@ -1000,7 +1000,7 @@ int exfat_find_dir_entry(struct super_block *sb,
> struct exfat_inode_info *ei,
>  			}
> 
>  			if (entry_type == TYPE_STREAM) {
> -				unsigned short name_hash;
> +				u16 name_hash;
> 
>  				if (step != DIRENT_STEP_STRM) {
>  					step = DIRENT_STEP_FILE;
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h index
> eebbe5a84b2b..9188985694f0 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -137,7 +137,7 @@ struct exfat_dentry_namebuf {  struct exfat_uni_name {
>  	/* +3 for null and for converting */
>  	unsigned short name[MAX_NAME_LENGTH + 3];
> -	unsigned short name_hash;
> +	u16 name_hash;
>  	unsigned char name_len;
>  };
> 
> @@ -512,8 +512,7 @@ void exfat_get_entry_time(struct exfat_sb_info *sbi,
> struct timespec64 *ts,  void exfat_truncate_atime(struct timespec64 *ts);
> void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64
*ts,
>  		u8 *tz, __le16 *time, __le16 *date, u8 *time_cs); -unsigned
> short exfat_calc_chksum_2byte(void *data, int len,
> -		unsigned short chksum, int type);
> +u16 exfat_calc_chksum16(void *data, int len, u16 chksum, int type);
>  u32 exfat_calc_chksum32(void *data, int len, u32 chksum, int type);  void
> exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int sync);
> void exfat_chain_set(struct exfat_chain *ec, unsigned int dir, diff --git
> a/fs/exfat/misc.c b/fs/exfat/misc.c index b82d2dd5bd7c..17d41f3d3709
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
> diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c index
> 1ebda90cbdd7..19321773dd07 100644
> --- a/fs/exfat/nls.c
> +++ b/fs/exfat/nls.c
> @@ -527,7 +527,7 @@ static int exfat_utf8_to_utf16(struct super_block *sb,
> 
>  	*uniname = '\0';
>  	p_uniname->name_len = unilen;
> -	p_uniname->name_hash = exfat_calc_chksum_2byte(upname, unilen << 1,
> 0,
> +	p_uniname->name_hash = exfat_calc_chksum16(upname, unilen << 1, 0,
>  			CS_DEFAULT);
> 
>  	if (p_lossy)
> @@ -623,7 +623,7 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
> 
>  	*uniname = '\0';
>  	p_uniname->name_len = unilen;
> -	p_uniname->name_hash = exfat_calc_chksum_2byte(upname, unilen << 1,
> 0,
> +	p_uniname->name_hash = exfat_calc_chksum16(upname, unilen << 1, 0,
>  			CS_DEFAULT);
> 
>  	if (p_lossy)
> @@ -655,7 +655,8 @@ static int exfat_load_upcase_table(struct super_block
> *sb,  {
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>  	unsigned int sect_size = sb->s_blocksize;
> -	unsigned int i, index = 0, checksum = 0;
> +	unsigned int i, index = 0;
> +	u32 chksum = 0;
>  	int ret;
>  	unsigned char skip = false;
>  	unsigned short *upcase_table;
> @@ -681,13 +682,6 @@ static int exfat_load_upcase_table(struct super_block
> *sb,
>  		for (i = 0; i < sect_size && index <= 0xFFFF; i += 2) {
>  			unsigned short uni = get_unaligned_le16(bh->b_data +
> i);
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
> @@ -701,13 +695,14 @@ static int exfat_load_upcase_table(struct
> super_block *sb,
>  			}
>  		}
>  		brelse(bh);
> +		chksum = exfat_calc_chksum32(bh->b_data, i, chksum,
> CS_DEFAULT);
>  	}
> 
> -	if (index >= 0xFFFF && utbl_checksum == checksum)
> +	if (index >= 0xFFFF && utbl_checksum == chksum)
>  		return 0;
> 
>  	exfat_err(sb, "failed to load upcase table (idx : 0x%08x, chksum :
> 0x%08x, utbl_chksum : 0x%08x)",
> -		  index, checksum, utbl_checksum);
> +		  index, chksum, utbl_checksum);
>  	ret = -EINVAL;
>  free_table:
>  	exfat_free_upcase_table(sbi);
> --
> 2.25.1


