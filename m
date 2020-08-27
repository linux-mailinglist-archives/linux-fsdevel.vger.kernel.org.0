Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB70253C15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 05:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgH0DTm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 23:19:42 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:43604 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgH0DTk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 23:19:40 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200827031937epoutp01a47fb0dee20bbfce30fb78500e48ae57~vAc4l1dmI1652716527epoutp01J
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 03:19:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200827031937epoutp01a47fb0dee20bbfce30fb78500e48ae57~vAc4l1dmI1652716527epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598498377;
        bh=8XxM/zDxpeAap4gpZJRtmL5C1mmneA17PMn5eASABiQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=nG/X6uzjStWdi8XsCvLyxXBP7yNwcvrn9/585OxBy9eQYBbKQHyXNAIvEGd+mtGqJ
         bnuYxeB4UtyaF2YnvIMwWBWulppmhhZRhaz+xtQWNTyXnN8r8FiZfRAAQ1zKEdJ2l7
         xPXNAENGVrl1bFaN5gc2V/GvcXARqEPy3t+zRp9U=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200827031937epcas1p453ee2eb17c36d8f22bbf3d812914aef7~vAc4UYhZ72470024700epcas1p4J;
        Thu, 27 Aug 2020 03:19:37 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.165]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4BcSdN2VcpzMqYkZ; Thu, 27 Aug
        2020 03:19:36 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.88.28581.846274F5; Thu, 27 Aug 2020 12:19:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200827031935epcas1p38d23c935c9b4bdb260f16ecbd233b8ee~vAc2wEAfe1147811478epcas1p36;
        Thu, 27 Aug 2020 03:19:35 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200827031935epsmtrp11747c1a7c5d13c57efc83b1046ad39d2~vAc2sar7B2034920349epsmtrp1K;
        Thu, 27 Aug 2020 03:19:35 +0000 (GMT)
X-AuditID: b6c32a38-2cdff70000006fa5-2e-5f472648cc2a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.F5.08303.746274F5; Thu, 27 Aug 2020 12:19:35 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200827031935epsmtip18caf2079897509ba8d769cfb19ba8212~vAc2j76ij0609106091epsmtip1v;
        Thu, 27 Aug 2020 03:19:35 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826115742.21207-1-kohada.t2@gmail.com>
Subject: RE: [PATCH v4 1/5] exfat: integrates dir-entry getting and
 validation
Date:   Thu, 27 Aug 2020 12:19:35 +0900
Message-ID: <011101d67c20$e3d604e0$ab820ea0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGQvXwC1x7VdWWIHEXRa8VfNNWTPQHPSuiOqcgQDTA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmrq6Hmnu8wckpQhY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWGz5d4TVgd3jy5zj7B5tk/+xezQfW8nmsXPWXXaPvi2r
        GD0+b5ILYIvKsclITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1
        y8wBukVJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BoUKBXnJhbXJqXrpecn2tl
        aGBgZApUmZCT8an9JXPBXeOK/49OszYwLtDsYuTkkBAwkbj4qJWli5GLQ0hgB6PEwo5zjBDO
        J0aJ1Z8mMUM4nxklVs3bzwzTsu7OBzaIxC5GidvvzzKCJIQEXjJK9O2oArHZBHQl/v3ZzwZi
        iwjoSZw8eR2sgVmgkUli+YkvYJM4BSwlejYvZwWxhQUCJNYfvskCYrMIqEqcnj8HqIGDgxeo
        ZsOSdJAwr4CgxMmZT8BKmAXkJba/nQN1kILEz6fLWCF2WUncPX6WHaJGRGJ2ZxvYBxICCzkk
        7v9/xQjR4CIx+eQrdghbWOLV8S1QtpTEy/42dpC9EgLVEh9hHu5glHjx3RbCNpa4uX4DK0gJ
        s4CmxPpd+hBhRYmdv+cyQqzlk3j3tYcVYgqvREebEESJqkTfpcNMELa0RFf7B/YJjEqzkDw2
        C8ljs5A8MAth2QJGllWMYqkFxbnpqcWGBSbIcb2JEZxMtSx2MM59+0HvECMTB+MhRgkOZiUR
        XsGLzvFCvCmJlVWpRfnxRaU5qcWHGE2BIT2RWUo0OR+YzvNK4g1NjYyNjS1MzMzNTI2VxHkf
        3lKIFxJITyxJzU5NLUgtgulj4uCUamDSNlkW6/+lUObEPn+hBnGfxS2Pnl/tSjljZ5lVEHkv
        cRNv0uIAheK/xZ/4wnQ/ek7gOJC+/O/UWS1h89k806O+ZfozrJ/4vPiJxsKNvvc8Qr/Pj5cz
        VAvzl1F3jXRvb+7f5rLsyrsXB1d/NvFONuiYssRsw8bVeaw1L5/NsHC9F7eztiine6Nw3Afl
        I70BE45+kDA1n/1i5/OJujaTHXLDWIOnrX3l39W/dkGwb9lf8anupqKf257Vc3UyZX2w7Fkb
        fyL6ltcsdqmFmjuSat69vX+1RN6jq/TJ+Qv9S4Mjd/fMUtrn9eVSnJKbahSXxyxH45Tr4r3Z
        Ydec+ep8QprkEnz3SNwq3mD+8BOfsxJLcUaioRZzUXEiAH1+5KovBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJTtddzT3e4OBDJYsfc2+zWLw5OZXF
        Ys/ekywWl3fNYbO4/P8Ti8WyL5NZLLb8O8LqwO7xZc5xdo+2yf/YPZqPrWTz2DnrLrtH35ZV
        jB6fN8kFsEVx2aSk5mSWpRbp2yVwZXxqf8lccNe44v+j06wNjAs0uxg5OSQETCTW3fnA1sXI
        xSEksINRYsXXn8wQCWmJYyfOANkcQLawxOHDxRA1zxklvmx+ygZSwyagK/Hvz34wW0RAT+Lk
        yetgg5gFmpkkvj1bwgzR0cUo0XN+KQtIFaeApUTP5uWsILawgJ/EuonbwGwWAVWJ0/PnsIFs
        4wWq2bAkHSTMKyAocXLmExaQMDPQgraNjCBhZgF5ie1v50DdqSDx8+kyVogbrCTuHj/LDlEj
        IjG7s415AqPwLCSTZiFMmoVk0iwkHQsYWVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+du
        YgRHlZbWDsY9qz7oHWJk4mA8xCjBwawkwit40TleiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/X
        WQvjhATSE0tSs1NTC1KLYLJMHJxSDUwLW9uUZW2vlMSu3nFXMf//7DtVLmtzNHnWcjXPXZrj
        sLswMVI4zEuFacpP0cOL3MTucGcahc2sXH+h8g3jx2d5QtcXdzxfkiCgUR82TWFf2fFWvQ/M
        l/uiP7ufUV7m9Oet5LXL7X4qU648a0n7ejqjXrvynrb2+gqnQ9Oee07jO+3sqB+y/MKm9S5z
        trWu8tik3Xey6H6tVod6O5t8X+LlijivvSnLpJjlTSPjGUPLFsjVem9qncQYaG8gem09z8xZ
        fy+Ipnuk6gfvS89xzfs4Nc3uK6vY73qGj3eXvt1m8nPVVUH+h8t/7j7/l5fv/rVT17T/LvN8
        /+/f5IDr1/ZpGJRufqhVUT1zYxv3uZ9KLMUZiYZazEXFiQDhZKKkGQMAAA==
X-CMS-MailID: 20200827031935epcas1p38d23c935c9b4bdb260f16ecbd233b8ee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200826115753epcas1p3321f1021e92cfba8279d8976e835d436
References: <CGME20200826115753epcas1p3321f1021e92cfba8279d8976e835d436@epcas1p3.samsung.com>
        <20200826115742.21207-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	i = ES_INDEX_NAME;
> +	while ((ep = exfat_get_validated_dentry(es, i++, TYPE_NAME))) {
Please find the way to access name entries like ep_file, ep_stream
without calling exfat_get_validated_dentry().
>  		exfat_extract_uni_name(ep, uniname);
>  		uniname += EXFAT_FILE_NAME_LEN;
>  	}
> @@ -372,7 +369,7 @@ unsigned int exfat_get_entry_type(struct exfat_dentry *ep)
>  		if (ep->type == EXFAT_STREAM)
>  			return TYPE_STREAM;
>  		if (ep->type == EXFAT_NAME)
> -			return TYPE_EXTEND;
> +			return TYPE_NAME;
>  		if (ep->type == EXFAT_ACL)
>  			return TYPE_ACL;
>  		return TYPE_CRITICAL_SEC;
> @@ -388,7 +385,7 @@ static void exfat_set_entry_type(struct exfat_dentry *ep, unsigned int type)
>  		ep->type &= EXFAT_DELETE;
>  	} else if (type == TYPE_STREAM) {
>  		ep->type = EXFAT_STREAM;
> -	} else if (type == TYPE_EXTEND) {
> +	} else if (type == TYPE_NAME) {
>  		ep->type = EXFAT_NAME;
>  	} else if (type == TYPE_BITMAP) {
>  		ep->type = EXFAT_BITMAP;
> @@ -421,7 +418,7 @@ static void exfat_init_name_entry(struct exfat_dentry *ep,  {
>  	int i;
> 
> -	exfat_set_entry_type(ep, TYPE_EXTEND);
> +	exfat_set_entry_type(ep, TYPE_NAME);
>  	ep->dentry.name.flags = 0x0;
> 
>  	for (i = 0; i < EXFAT_FILE_NAME_LEN; i++) { @@ -550,7 +547,7 @@ int exfat_init_ext_entry(struct
> inode *inode, struct exfat_chain *p_dir,
>  	exfat_update_bh(bh, sync);
>  	brelse(bh);
> 
> -	for (i = EXFAT_FIRST_CLUSTER; i < num_entries; i++) {
> +	for (i = ES_INDEX_NAME; i < num_entries; i++) {
>  		ep = exfat_get_dentry(sb, p_dir, entry + i, &bh, &sector);
>  		if (!ep)
>  			return -EIO;
> @@ -590,17 +587,16 @@ int exfat_remove_entries(struct inode *inode, struct exfat_chain *p_dir,  void
> exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)  {
>  	int chksum_type = CS_DIR_ENTRY, i;
> -	unsigned short chksum = 0;
> +	u16 chksum = 0;
>  	struct exfat_dentry *ep;
> 
>  	for (i = 0; i < es->num_entries; i++) {
> -		ep = exfat_get_dentry_cached(es, i);
> +		ep = exfat_get_validated_dentry(es, i, TYPE_ALL);
Ditto, You do not need to repeatedly call exfat_get_validated_dentry() for the entries
which got from exfat_get_dentry_set().
>  		chksum = exfat_calc_chksum16(ep, DENTRY_SIZE, chksum,
>  					     chksum_type);
>  		chksum_type = CS_DEFAULT;
>  	}
> -	ep = exfat_get_dentry_cached(es, 0);
> -	ep->dentry.file.checksum = cpu_to_le16(chksum);
> +	ES_FILE(es).checksum = cpu_to_le16(chksum);
>  	es->modified = true;
>  }
> 
>  struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
> -		struct exfat_chain *p_dir, int entry, unsigned int type)
> +		struct exfat_chain *p_dir, int entry, int max_entries)
>  {
>  	int ret, i, num_bh;
> -	unsigned int off, byte_offset, clu = 0;
> +	unsigned int byte_offset, clu = 0;
>  	sector_t sec;
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>  	struct exfat_entry_set_cache *es;
> -	struct exfat_dentry *ep;
> -	int num_entries;
> -	enum exfat_validate_dentry_mode mode = ES_MODE_STARTED;
>  	struct buffer_head *bh;
> 
>  	if (p_dir->dir == DIR_DELETED) {
> @@ -844,13 +811,13 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
>  		return NULL;
>  	es->sb = sb;
>  	es->modified = false;
> +	es->num_entries = 1;
> 
>  	/* byte offset in cluster */
>  	byte_offset = EXFAT_CLU_OFFSET(byte_offset, sbi);
> 
>  	/* byte offset in sector */
> -	off = EXFAT_BLK_OFFSET(byte_offset, sb);
> -	es->start_off = off;
> +	es->start_off = EXFAT_BLK_OFFSET(byte_offset, sb);
> 
>  	/* sector offset in cluster */
>  	sec = EXFAT_B_TO_BLK(byte_offset, sb); @@ -861,15 +828,12 @@ struct exfat_entry_set_cache
> *exfat_get_dentry_set(struct super_block *sb,
>  		goto free_es;
>  	es->bh[es->num_bh++] = bh;
> 
> -	ep = exfat_get_dentry_cached(es, 0);
> -	if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
> +	es->ep_file = exfat_get_validated_dentry(es, ES_INDEX_FILE, TYPE_FILE);
> +	if (!es->ep_file)
>  		goto free_es;
> +	es->num_entries = min(ES_FILE(es).num_ext + 1, max_entries);
> 
> -	num_entries = type == ES_ALL_ENTRIES ?
> -		ep->dentry.file.num_ext + 1 : type;
> -	es->num_entries = num_entries;
> -
> -	num_bh = EXFAT_B_TO_BLK_ROUND_UP(off + num_entries * DENTRY_SIZE, sb);
> +	num_bh = EXFAT_B_TO_BLK_ROUND_UP(es->start_off  + es->num_entries *
> +DENTRY_SIZE, sb);
>  	for (i = 1; i < num_bh; i++) {
>  		/* get the next sector */
>  		if (exfat_is_last_sector_in_cluster(sbi, sec)) { @@ -889,10 +853,17 @@ struct
> exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
>  	}
> 
>  	/* validiate cached dentries */
> -	for (i = 1; i < num_entries; i++) {
> -		ep = exfat_get_dentry_cached(es, i);
> -		if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
> -			goto free_es;
> +	es->ep_stream = exfat_get_validated_dentry(es, ES_INDEX_STREAM, TYPE_STREAM);
> +	if (!es->ep_stream)
> +		goto free_es;
> +
> +	if (max_entries == ES_ALL_ENTRIES) {
> +		for (i = 0; i < ES_FILE(es).num_ext; i++)
> +			if (!exfat_get_validated_dentry(es, ES_INDEX_STREAM + i, TYPE_SECONDARY))
> +				goto free_es;
> +		for (i = 0; i * EXFAT_FILE_NAME_LEN < ES_STREAM(es).name_len; i++)
> +			if (!exfat_get_validated_dentry(es, ES_INDEX_NAME + i, TYPE_NAME))
> +				goto free_es;
Why do you unnecessarily check entries with two loops?
Please refer to the patch I sent.

>  	}
>  	return es;

> 
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h index 44dc04520175..e46f3e0c16b7 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -40,7 +40,7 @@ enum {
>   * Type Definitions
>   */
>  #define ES_2_ENTRIES		2
> -#define ES_ALL_ENTRIES		0
> +#define ES_ALL_ENTRIES		256
> 
>  #define DIR_DELETED		0xFFFF0321
> 
> @@ -56,7 +56,7 @@ enum {
>  #define TYPE_FILE		0x011F
>  #define TYPE_CRITICAL_SEC	0x0200
>  #define TYPE_STREAM		0x0201
> -#define TYPE_EXTEND		0x0202
> +#define TYPE_NAME		0x0202
>  #define TYPE_ACL		0x0203
>  #define TYPE_BENIGN_PRI		0x0400
>  #define TYPE_GUID		0x0401
> @@ -65,6 +65,9 @@ enum {
>  #define TYPE_BENIGN_SEC		0x0800
>  #define TYPE_ALL		0x0FFF
> 
> +#define TYPE_PRIMARY		(TYPE_CRITICAL_PRI | TYPE_BENIGN_PRI)
Where is this in use? If it is not used, Do not need to add it.
> +#define TYPE_SECONDARY		(TYPE_CRITICAL_SEC | TYPE_BENIGN_SEC)
> +
>  #define MAX_CHARSET_SIZE	6 /* max size of multi-byte character */
>  #define MAX_NAME_LENGTH		255 /* max len of file name excluding NULL */
>  #define MAX_VFSNAME_BUF_SIZE	((MAX_NAME_LENGTH + 1) * MAX_CHARSET_SIZE)

