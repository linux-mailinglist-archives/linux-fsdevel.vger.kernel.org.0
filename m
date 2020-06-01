Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44451EA3A3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 14:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgFAMTx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 08:19:53 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:30193 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgFAMTw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:19:52 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200601121949epoutp026fd76034b1da979b9e0794ed53101bc4~UasspR7WT0691006910epoutp02Y
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2020 12:19:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200601121949epoutp026fd76034b1da979b9e0794ed53101bc4~UasspR7WT0691006910epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591013989;
        bh=2isW1mmA+SasxMpG2XdpT1OqpqXgSDxRM1m8fJgKNUM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=pvIkAPsVUslFT5wZG730BqRHQMyrUxWanP+GUCJoYvx3j6i0tYT45I7orDbUx/3zp
         Q5iTezEZxFY78E950KZ1AjGJNnQd5x7N//t2fLwcor/8FP3tfs6mL9r841NfefthA5
         zEjdCWzTl7H/IJp8PjMDqXQRp1yCpi66Dh1TjNYU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200601121948epcas1p33c8fbe9ddf01209369fc4e084b4c7bce~UassVMNz10148901489epcas1p3N;
        Mon,  1 Jun 2020 12:19:48 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.165]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49bDkq5k3DzMqYkZ; Mon,  1 Jun
        2020 12:19:47 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.AB.28581.362F4DE5; Mon,  1 Jun 2020 21:19:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200601121947epcas1p1de4d70f6f187d235b65223df7d6527ae~UasrATjTD0408304083epcas1p1S;
        Mon,  1 Jun 2020 12:19:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200601121947epsmtrp2937af80b3515b66bf17abf40bf1bb024~Uasq-t0HF2229322293epsmtrp2U;
        Mon,  1 Jun 2020 12:19:47 +0000 (GMT)
X-AuditID: b6c32a38-2cdff70000006fa5-18-5ed4f263ed2f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.63.08303.362F4DE5; Mon,  1 Jun 2020 21:19:47 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200601121947epsmtip258f70f63f41fb368d67125fafe60d057~Uasq0tVbC0351103511epsmtip2O;
        Mon,  1 Jun 2020 12:19:47 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200529101459.8546-2-kohada.t2@gmail.com>
Subject: RE: [PATCH 2/4 v3] exfat: separate the boot sector analysis
Date:   Mon, 1 Jun 2020 21:19:47 +0900
Message-ID: <1ffe01d6380e$f0a52260$d1ef6720$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQECpNOBCAKs/TRXObwEq14CKUeHvgG0v48kAkVSecmqSwNY8A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmvm7ypytxBiu7dS1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsfgxvd6B3ePLnOPsHm2T/7F7NB9byeaxc9Zddo++LasY
        PT5vkgtgi8qxyUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
        zAE6RUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhQoFecmFtcmpeul5yfa2Vo
        YGBkClSZkJPRuGMra8FJy4pPv9pYGxiP6XYxcnJICJhIzPi6gLGLkYtDSGAHo8SSfdvYIZxP
        jBLP765mhnA+M0psf/eJHablw455rBCJXYwS049cgKp6ySgxb0sLC0gVm4CuxJMbP5lBbBEB
        PYmTJ6+zgdjMAo1MEideZncxcnBwClhILO+uAQkLC7hI/OqeC7aARUBFYvqz3WDlvAKWEg9P
        /WOFsAUlTs58wgIxRl5i+9s5zBAHKUjs/nSUFWKVk8TxZdPZIWpEJGZ3toHdJiEwl0Ni9+dW
        JogGF4kD/3ZAfSMs8er4FihbSuLzu71sEHYzo0TfXU+I5hZGiVU7mqASxhKfPn9mBHmAWUBT
        Yv0ufYiwosTO33MZIRbzSbz72sMKUiIhwCvR0SYEUaIi8f3DThaYVVd+XGWawKg0C8lrs5C8
        NgvJC7MQli1gZFnFKJZaUJybnlpsWGCCHNubGMHpVMtiB+Pctx/0DjEycTAeYpTgYFYS4Z2s
        filOiDclsbIqtSg/vqg0J7X4EKMpMLAnMkuJJucDE3peSbyhqZGxsbGFiZm5mamxkjjvSasL
        cUIC6YklqdmpqQWpRTB9TBycUg1MPEbW8n2TDD5VC1ukhMnPYf/Xv+dMpM2xHZwxpyZ+y+tj
        +LNZ+tDDq2t/bfzdbvrg2IT1mn62c2cIsD24Ej5VNnrb82+b396/o7P0wc/nzlfM5xZpbphv
        w96gXHuoMs6wfGfFR/kNexLuKx59vZKTJ2W64p7eqaUa37pMT/GoTZ/6zqmcZ1fmC9ejC1s5
        fmRtvr/nNGNz5gzZ6Vz/zc1FNbTOpU6MOntpR7em0WO9X3237tT9v2rJmPlY6u0fb9YfpRFS
        Ny6+3SZpXjaN78bWdaf0k8o2/U+6byGQfstvo97HIl0ptlQL45TI9/mcZ1K9WS/+2fRQZYF5
        ivibqbclMidIuHzJ2y0//9bcTyHSj5RYijMSDbWYi4oTAacAWUcwBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXjf505U4g1/zhC1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsfgxvd6B3ePLnOPsHm2T/7F7NB9byeaxc9Zddo++LasY
        PT5vkgtgi+KySUnNySxLLdK3S+DKaNyxlbXgpGXFp19trA2Mx3S7GDk5JARMJD7smMfaxcjF
        ISSwg1Hi4ORGpi5GDqCElMTBfZoQprDE4cPFECXPGSV2L93PDNLLJqAr8eTGTzBbREBP4uTJ
        62wgRcwCzUwSrV+amSA6tjJK/Lx3D2wop4CFxPLuGpAGYQEXiV/dc9lBbBYBFYnpz3azgdi8
        ApYSD0/9Y4WwBSVOznzCAtLKDLSgbSMjSJhZQF5i+9s5zBD3K0js/nSUFeIGJ4njy6azQ9SI
        SMzubGOewCg8C8mkWQiTZiGZNAtJxwJGllWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmb
        GMERpaW1g3HPqg96hxiZOBgPMUpwMCuJ8E5WvxQnxJuSWFmVWpQfX1Sak1p8iFGag0VJnPfr
        rIVxQgLpiSWp2ampBalFMFkmDk6pBiZpoVvuC0NP9p96VHP9RWvR5Efqa1XT7D/axVwLvdA/
        cV/+vO1GE+PmPw9czzdTOmDbDR2Lm/w/uR9vM/619sP90DBFPr58KYGQa4+dOWP+qLodtzG4
        0PeOP9a1WnhXndiFzZLtus9XebWx3PU9fGDWZVavyD5Pq5Nri+QnyTwrPpqz2WZOo9Mz7Yww
        h2NtYlt36Snt3Wh76Paa3zW+Nu17zrfXFAifW8f852HCL4mZSR8Mepfp7Cjb3sy2L2bxRtdd
        00Xe7F7Fe09J2Jv7xqnUDi8hrckdXp7RE5tu5W+oW9TUZ9yfb+z+OFj6zeWIxBXcqfPvz81a
        KNqsGdmhdDwgyURA+VrUR+mIrQy20kosxRmJhlrMRcWJAK4lC2MXAwAA
X-CMS-MailID: 20200601121947epcas1p1de4d70f6f187d235b65223df7d6527ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200529101551epcas1p2c4b1121befee21519192957a28f468db
References: <20200529101459.8546-1-kohada.t2@gmail.com>
        <CGME20200529101551epcas1p2c4b1121befee21519192957a28f468db@epcas1p2.samsung.com>
        <20200529101459.8546-2-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Separate the boot sector analysis to read_boot_sector().
> And add a check for the fs_name field.
> Furthermore, add a strict consistency check, because overlapping areas can
> cause serious corruption.
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

> ---
> Changes in v2:
>  - rebase with patch 'optimize dir-cache' applied Changes in v3:
>  - add a check for the fs_name field
> 
>  fs/exfat/exfat_raw.h |  2 +
>  fs/exfat/super.c     | 97 ++++++++++++++++++++++++--------------------
>  2 files changed, 56 insertions(+), 43 deletions(-)
> 
> diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h index
> 07f74190df44..350ce59cc324 100644
> --- a/fs/exfat/exfat_raw.h
> +++ b/fs/exfat/exfat_raw.h
> @@ -10,11 +10,13 @@
> 
>  #define BOOT_SIGNATURE		0xAA55
>  #define EXBOOT_SIGNATURE	0xAA550000
> +#define STR_EXFAT		"EXFAT   "	/* size should be 8 */
> 
>  #define EXFAT_MAX_FILE_LEN	255
> 
>  #define VOL_CLEAN		0x0000
>  #define VOL_DIRTY		0x0002
> +#define ERR_MEDIUM		0x0004
> 
>  #define EXFAT_EOF_CLUSTER	0xFFFFFFFFu
>  #define EXFAT_BAD_CLUSTER	0xFFFFFFF7u
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c index
> e60d28e73ff0..6a1330be5a9a 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -366,25 +366,20 @@ static int exfat_read_root(struct inode *inode)
>  	return 0;
>  }
> 
> -static struct boot_sector *exfat_read_boot_with_logical_sector(
> -		struct super_block *sb)
> +static int exfat_calibrate_blocksize(struct super_block *sb, int
> +logical_sect)
>  {
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> -	struct boot_sector *p_boot = (struct boot_sector *)sbi->boot_bh-
> >b_data;
> -	unsigned short logical_sect = 0;
> -
> -	logical_sect = 1 << p_boot->sect_size_bits;
> 
>  	if (!is_power_of_2(logical_sect) ||
>  	    logical_sect < 512 || logical_sect > 4096) {
>  		exfat_err(sb, "bogus logical sector size %u", logical_sect);
> -		return NULL;
> +		return -EIO;
>  	}
> 
>  	if (logical_sect < sb->s_blocksize) {
>  		exfat_err(sb, "logical sector size too small for device
> (logical sector size = %u)",
>  			  logical_sect);
> -		return NULL;
> +		return -EIO;
>  	}
> 
>  	if (logical_sect > sb->s_blocksize) {
> @@ -394,24 +389,20 @@ static struct boot_sector
> *exfat_read_boot_with_logical_sector(
>  		if (!sb_set_blocksize(sb, logical_sect)) {
>  			exfat_err(sb, "unable to set blocksize %u",
>  				  logical_sect);
> -			return NULL;
> +			return -EIO;
>  		}
>  		sbi->boot_bh = sb_bread(sb, 0);
>  		if (!sbi->boot_bh) {
>  			exfat_err(sb, "unable to read boot sector (logical
> sector size = %lu)",
>  				  sb->s_blocksize);
> -			return NULL;
> +			return -EIO;
>  		}
> -
> -		p_boot = (struct boot_sector *)sbi->boot_bh->b_data;
>  	}
> -	return p_boot;
> +	return 0;
>  }
> 
> -/* mount the file system volume */
> -static int __exfat_fill_super(struct super_block *sb)
> +static int exfat_read_boot_sector(struct super_block *sb)
>  {
> -	int ret;
>  	struct boot_sector *p_boot;
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> 
> @@ -424,51 +415,41 @@ static int __exfat_fill_super(struct super_block
*sb)
>  		exfat_err(sb, "unable to read boot sector");
>  		return -EIO;
>  	}
> -
> -	/* PRB is read */
>  	p_boot = (struct boot_sector *)sbi->boot_bh->b_data;
> 
>  	/* check the validity of BOOT */
>  	if (le16_to_cpu((p_boot->signature)) != BOOT_SIGNATURE) {
>  		exfat_err(sb, "invalid boot record signature");
> -		ret = -EINVAL;
> -		goto free_bh;
> +		return -EINVAL;
>  	}
> 
> -
> -	/* check logical sector size */
> -	p_boot = exfat_read_boot_with_logical_sector(sb);
> -	if (!p_boot) {
> -		ret = -EIO;
> -		goto free_bh;
> +	if (memcmp(p_boot->fs_name, STR_EXFAT, BOOTSEC_FS_NAME_LEN)) {
> +		exfat_err(sb, "invalid fs_name"); /* fs_name may unprintable
> */
> +		return -EINVAL;
>  	}
> 
>  	/*
> -	 * res_zero field must be filled with zero to prevent mounting
> +	 * must_be_zero field must be filled with zero to prevent mounting
>  	 * from FAT volume.
>  	 */
> -	if (memchr_inv(p_boot->must_be_zero, 0,
> -			sizeof(p_boot->must_be_zero))) {
> -		ret = -EINVAL;
> -		goto free_bh;
> -	}
> +	if (memchr_inv(p_boot->must_be_zero, 0, sizeof(p_boot-
> >must_be_zero)))
> +		return -EINVAL;
> 
> -	p_boot = (struct boot_sector *)p_boot;
> -	if (!p_boot->num_fats) {
> +	if (p_boot->num_fats != 1 && p_boot->num_fats != 2) {
>  		exfat_err(sb, "bogus number of FAT structure");
> -		ret = -EINVAL;
> -		goto free_bh;
> +		return -EINVAL;
>  	}
> 
>  	sbi->sect_per_clus = 1 << p_boot->sect_per_clus_bits;
>  	sbi->sect_per_clus_bits = p_boot->sect_per_clus_bits;
> -	sbi->cluster_size_bits = sbi->sect_per_clus_bits + sb-
> >s_blocksize_bits;
> +	sbi->cluster_size_bits = p_boot->sect_per_clus_bits +
> +		p_boot->sect_size_bits;
>  	sbi->cluster_size = 1 << sbi->cluster_size_bits;
>  	sbi->num_FAT_sectors = le32_to_cpu(p_boot->fat_length);
>  	sbi->FAT1_start_sector = le32_to_cpu(p_boot->fat_offset);
> -	sbi->FAT2_start_sector = p_boot->num_fats == 1 ?
> -		sbi->FAT1_start_sector :
> -			sbi->FAT1_start_sector + sbi->num_FAT_sectors;
> +	sbi->FAT2_start_sector = le32_to_cpu(p_boot->fat_offset);
> +	if (p_boot->num_fats == 2)
> +		sbi->FAT2_start_sector += sbi->num_FAT_sectors;
>  	sbi->data_start_sector = le32_to_cpu(p_boot->clu_offset);
>  	sbi->num_sectors = le64_to_cpu(p_boot->vol_length);
>  	/* because the cluster index starts with 2 */ @@ -483,15 +464,45 @@
> static int __exfat_fill_super(struct super_block *sb)
>  	sbi->clu_srch_ptr = EXFAT_FIRST_CLUSTER;
>  	sbi->used_clusters = EXFAT_CLUSTERS_UNTRACKED;
> 
> -	if (le16_to_cpu(p_boot->vol_flags) & VOL_DIRTY) {
> -		sbi->vol_flag |= VOL_DIRTY;
> -		exfat_warn(sb, "Volume was not properly unmounted. Some data
> may be corrupt. Please run fsck.");
> +	/* check consistencies */
> +	if (sbi->num_FAT_sectors << p_boot->sect_size_bits <
> +	    sbi->num_clusters * 4) {
> +		exfat_err(sb, "bogus fat length");
> +		return -EINVAL;
> +	}
> +	if (sbi->data_start_sector <
> +	    sbi->FAT1_start_sector + sbi->num_FAT_sectors *
p_boot->num_fats)
> {
> +		exfat_err(sb, "bogus data start sector");
> +		return -EINVAL;
>  	}
> +	if (sbi->vol_flag & VOL_DIRTY)
> +		exfat_warn(sb, "Volume was not properly unmounted. Some data
> may be corrupt. Please run fsck.");
> +	if (sbi->vol_flag & ERR_MEDIUM)
> +		exfat_warn(sb, "Medium has reported failures. Some data may
> be
> +lost.");
> 
>  	/* exFAT file size is limited by a disk volume size */
>  	sb->s_maxbytes = (u64)(sbi->num_clusters - EXFAT_RESERVED_CLUSTERS)
> <<
>  		sbi->cluster_size_bits;
> 
> +	/* check logical sector size */
> +	if (exfat_calibrate_blocksize(sb, 1 << p_boot->sect_size_bits))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +/* mount the file system volume */
> +static int __exfat_fill_super(struct super_block *sb) {
> +	int ret;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +
> +	ret = exfat_read_boot_sector(sb);
> +	if (ret) {
> +		exfat_err(sb, "failed to read boot sector");
> +		goto free_bh;
> +	}
> +
>  	ret = exfat_create_upcase_table(sb);
>  	if (ret) {
>  		exfat_err(sb, "failed to load upcase table");
> --
> 2.25.1


