Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A4A232C1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 08:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgG3Gxb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 02:53:31 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:24373 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgG3Gxa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:53:30 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200730065326epoutp0353eeac6ea351665d37fedf9027fcbdb4~mdTkh5vcV0382903829epoutp03Y
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2020 06:53:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200730065326epoutp0353eeac6ea351665d37fedf9027fcbdb4~mdTkh5vcV0382903829epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596092006;
        bh=BCF3goyIi3+VaW0+1hMSkq9RuVCsd5zEfooNwWgsf4k=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=JnLn/F+mtS72sKlUjMAv3ZNpAcUqHGVNIODKADTBfe1lKVyWLZTCvCbsAiHZb64Lv
         1N6T/PdfRMHW6jp769XhWRm61dvn/3S1YGsvf+m6P1nT08LUNjj4+xbvEfGC0yF9Qj
         so67U0q7lu4q/LxGy0qmoKHvcfSqkEcpwAUiwsOQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200730065325epcas1p321f8d566239f85f959fcf89102b3451b~mdTkGPy_u1027910279epcas1p3l;
        Thu, 30 Jul 2020 06:53:25 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.160]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4BHLj05zmfzMqYkg; Thu, 30 Jul
        2020 06:53:24 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.5E.28578.46E622F5; Thu, 30 Jul 2020 15:53:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200730065324epcas1p1632f50b497993358a53e2cd34e23adbd~mdTitVV6L3183031830epcas1p1H;
        Thu, 30 Jul 2020 06:53:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200730065324epsmtrp201cc4d5939807ec556efde31fe2cfe28~mdTiq3ylM2525225252epsmtrp2C;
        Thu, 30 Jul 2020 06:53:24 +0000 (GMT)
X-AuditID: b6c32a39-8c9ff70000006fa2-c3-5f226e645d20
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.37.08382.46E622F5; Thu, 30 Jul 2020 15:53:24 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200730065323epsmtip1bcf061b44cc8af304f58e9e3f0a48d86~mdTiU1AVX3184231842epsmtip16;
        Thu, 30 Jul 2020 06:53:23 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200715012249.16378-1-kohada.t2@gmail.com>
Subject: RE: [PATCH v2] exfat: integrates dir-entry getting and validation
Date:   Thu, 30 Jul 2020 15:53:24 +0900
Message-ID: <015d01d6663e$1eb8c780$5c2a5680$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJkKvf3lVanaAlN2afWcUIlbNXqzwJnQ0rYp/DmSOA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmrm5KnlK8Qc9HPYsfc2+zWLw5OZXF
        Ys/ekywWl3fNYbO4/P8Ti8WyL5NZLLb8O8LqwO7xZc5xdo+2yf/YPZqPrWTz2DnrLrtH35ZV
        jB6fN8kFsEXl2GSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
        ZeYA3aKkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTA0KNArTswtLs1L10vOz7Uy
        NDAwMgWqTMjJmH5/C1vB8+KKy90X2BoYJ8V0MXJySAiYSHS/XsrWxcjFISSwg1Fi7fl9jCAJ
        IYFPjBK9TUEQiW+MEku/bmWE6fj67AAjRGIvo8T8c/9ZIDpeMkq8/acBYrMJ6Er8+7OfDcQW
        EdCTOHnyOtgKZoFGJonlJ74wgyQ4BSwllrdeZgexhQW8JJZM28QEYrMIqErMPH8XrIYXqKbr
        5jkWCFtQ4uTMJ2A2s4C8xPa3c5ghLlKQ+Pl0GSvEMiuJNbunMkHUiEjM7mxjBlksIbCQQ+Ls
        h99sEA0uEo83LWeHsIUlXh3fAmVLSXx+txeohgPIrpb4uB9qfgejxIvvthC2scTN9RtYQUqY
        BTQl1u/ShwgrSuz8PZcRYi2fxLuvPawQU3glOtqEIEpUJfouHWaCsKUluto/sE9gVJqF5LFZ
        SB6bheSBWQjLFjCyrGIUSy0ozk1PLTYsMEWO602M4GSqZbmDcfrbD3qHGJk4GA8xSnAwK4nw
        tnMpxAvxpiRWVqUW5ccXleakFh9iNAUG9URmKdHkfGA6zyuJNzQ1MjY2tjAxMzczNVYS5314
        C6hJID2xJDU7NbUgtQimj4mDU6qBaU5MX3WvsbVinUrAhQkOLeFKb62OMh6bPPNH66e9rT2S
        +Uo/AngmXnj47u55eZUieeHt3ivN9+bvtTOdsf9SWOj6SfGLXGfFXdyQw+G+5bbl3on9btWN
        alumHsiZ8P5Qv2i4pCDfHaab71PntBWdjMqYGl26on7B6aTzFsyP2rnr5K9fX7Av10jeXfh7
        wIUpk3pySqNv3BSbd/X9FM6dS469bdBoe1/r6WnxfkdUz+FGS4+fva+P71yeIPTk6LyGLXKf
        7l3Ozm18aV32ONsz+1OD6M/d5+ruuzw+8vtuvNax/UIz/yzZbHXtffh3s/Ti5TmzmrdMLXbb
        umfJc5/bh8U2Ptq0yqdxmvWEtozEuMdKLMUZiYZazEXFiQAbaD35LwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJTjclTyne4OJhVosfc2+zWLw5OZXF
        Ys/ekywWl3fNYbO4/P8Ti8WyL5NZLLb8O8LqwO7xZc5xdo+2yf/YPZqPrWTz2DnrLrtH35ZV
        jB6fN8kFsEVx2aSk5mSWpRbp2yVwZUy/v4Wt4HlxxeXuC2wNjJNiuhg5OSQETCS+PjvA2MXI
        xSEksJtRYv+5bUwQCWmJYyfOMHcxcgDZwhKHDxdD1DxnlHj4toUNpIZNQFfi35/9YLaIgJ7E
        yZPX2UCKmAWamSS+PVvCDNHRxSjx78QsdpAqTgFLieWtl8FsYQEviSXTNoFtYxFQlZh5/i4z
        iM0LVNN18xwLhC0ocXLmExaQK5iBNrRtZAQJMwvIS2x/O4cZ4lAFiZ9Pl7FCHGElsWb3VCaI
        GhGJ2Z1tzBMYhWchmTQLYdIsJJNmIelYwMiyilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/
        dxMjOK60NHcwbl/1Qe8QIxMH4yFGCQ5mJRHedi6FeCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
        NwoXxgkJpCeWpGanphakFsFkmTg4pRqYdugLvj3/7PbDcxccEhJ1DztzpphsXvJczpOVgbvZ
        8ndojFqKYlDvjLnXAhjUJ1tEGIoYyP6b4eDmr87z7uj7tbcnzEiYreUkGfrW+BT/slB5q29p
        N9Rvvp/3x/c+w3GWxekzjGQnfW3ImZk2dVrITIZUjZ+bMkti7Dwnz2+Va17uPv3ZlEcXbqbm
        yjqwrpHJiL+lfGzR+a7kwBm//a8Ihq+bVW2bfutJ1K0zdWpbSl594Q+sVw9MUNQ34Pl8a8er
        63dFry77cNHl9jWGly5dRzQVVgjXHTVjZqn3PrLBd0W+bJJya+G7Mw9dXh74vuyircpme+n8
        2PxrX6O9RLeX9TJW7Nz/5s7CX0bmmjUsSizFGYmGWsxFxYkAcPOG/xoDAAA=
X-CMS-MailID: 20200730065324epcas1p1632f50b497993358a53e2cd34e23adbd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200715012304epcas1p23e9f45415afc551beea122e4e1bdb933
References: <CGME20200715012304epcas1p23e9f45415afc551beea122e4e1bdb933@epcas1p2.samsung.com>
        <20200715012249.16378-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Add validation for num, bh and type on getting dir-entry.
> ('file' and 'stream-ext' dir-entries are pre-validated to ensure success) Renamed
> exfat_get_dentry_cached() to exfat_get_validated_dentry() due to a change in functionality.
> 
> Integrate type-validation with simplified.
> This will also recognize a dir-entry set that contains 'benign secondary'
> dir-entries.
> 
> And, rename TYPE_EXTEND to TYPE_NAME.
> 
> Suggested-by: Sungjong Seo <sj1557.seo@samsung.com>
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
> ---
> Changes in v2
>  - Change verification order
>  - Verification loop start with index 2
> 
>  fs/exfat/dir.c      | 144 ++++++++++++++++++--------------------------
>  fs/exfat/exfat_fs.h |  15 +++--
>  fs/exfat/file.c     |   4 +-
>  fs/exfat/inode.c    |   6 +-
>  fs/exfat/namei.c    |   4 +-
>  5 files changed, 73 insertions(+), 100 deletions(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index 573659bfbc55..09b85746e760 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -33,6 +33,7 @@ static void exfat_get_uniname_from_ext_entry(struct super_block *sb,  {
>  	int i;
>  	struct exfat_entry_set_cache *es;
> +	struct exfat_dentry *ep;
> 
>  	es = exfat_get_dentry_set(sb, p_dir, entry, ES_ALL_ENTRIES);
>  	if (!es)
> @@ -44,13 +45,9 @@ static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
>  	 * Third entry  : first file-name entry
>  	 * So, the index of first file-name dentry should start from 2.
>  	 */
> -	for (i = 2; i < es->num_entries; i++) {
> -		struct exfat_dentry *ep = exfat_get_dentry_cached(es, i);
> -
> -		/* end of name entry */
> -		if (exfat_get_entry_type(ep) != TYPE_EXTEND)
> -			break;
> 
> +	i = 2;
> +	while ((ep = exfat_get_validated_dentry(es, i++, TYPE_NAME))) {
As Sungjong said, I think that TYPE_NAME seems right to be validated in exfat_get_dentry_set().

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
>  	for (i = 0; i < EXFAT_FILE_NAME_LEN; i++) { @@ -594,12 +591,12 @@ void
> exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
>  	struct exfat_dentry *ep;
> 
>  	for (i = 0; i < es->num_entries; i++) {
> -		ep = exfat_get_dentry_cached(es, i);
> +		ep = exfat_get_validated_dentry(es, i, TYPE_ALL);
>  		chksum = exfat_calc_chksum16(ep, DENTRY_SIZE, chksum,
>  					     chksum_type);
>  		chksum_type = CS_DEFAULT;
>  	}
> -	ep = exfat_get_dentry_cached(es, 0);
> +	ep = exfat_get_validated_dentry(es, 0, TYPE_FILE);
>  	ep->dentry.file.checksum = cpu_to_le16(chksum);
>  	es->modified = true;
>  }
> @@ -741,92 +738,66 @@ struct exfat_dentry *exfat_get_dentry(struct super_block *sb,
>  	return (struct exfat_dentry *)((*bh)->b_data + off);  }
> 
> -enum exfat_validate_dentry_mode {
> -	ES_MODE_STARTED,
> -	ES_MODE_GET_FILE_ENTRY,
> -	ES_MODE_GET_STRM_ENTRY,
> -	ES_MODE_GET_NAME_ENTRY,
> -	ES_MODE_GET_CRITICAL_SEC_ENTRY,
> -};
> -
> -static bool exfat_validate_entry(unsigned int type,
> -		enum exfat_validate_dentry_mode *mode)
> -{
> -	if (type == TYPE_UNUSED || type == TYPE_DELETED)
> -		return false;
> -
> -	switch (*mode) {
> -	case ES_MODE_STARTED:
> -		if  (type != TYPE_FILE && type != TYPE_DIR)
> -			return false;
> -		*mode = ES_MODE_GET_FILE_ENTRY;
> -		return true;
> -	case ES_MODE_GET_FILE_ENTRY:
> -		if (type != TYPE_STREAM)
> -			return false;
> -		*mode = ES_MODE_GET_STRM_ENTRY;
> -		return true;
> -	case ES_MODE_GET_STRM_ENTRY:
> -		if (type != TYPE_EXTEND)
> -			return false;
> -		*mode = ES_MODE_GET_NAME_ENTRY;
> -		return true;
> -	case ES_MODE_GET_NAME_ENTRY:
> -		if (type == TYPE_STREAM)
> -			return false;
> -		if (type != TYPE_EXTEND) {
> -			if (!(type & TYPE_CRITICAL_SEC))
> -				return false;
> -			*mode = ES_MODE_GET_CRITICAL_SEC_ENTRY;
> -		}
> -		return true;
> -	case ES_MODE_GET_CRITICAL_SEC_ENTRY:
> -		if (type == TYPE_EXTEND || type == TYPE_STREAM)
> -			return false;
> -		if ((type & TYPE_CRITICAL_SEC) != TYPE_CRITICAL_SEC)
> -			return false;
> -		return true;
> -	default:
> -		WARN_ON_ONCE(1);
> -		return false;
> -	}
> -}
> -
> -struct exfat_dentry *exfat_get_dentry_cached(
> -	struct exfat_entry_set_cache *es, int num)
> +struct exfat_dentry *exfat_get_validated_dentry(struct exfat_entry_set_cache *es,
> +						int num, unsigned int type)
Please use two tabs.

>  {
>  	int off = es->start_off + num * DENTRY_SIZE;
> -	struct buffer_head *bh = es->bh[EXFAT_B_TO_BLK(off, es->sb)];
> -	char *p = bh->b_data + EXFAT_BLK_OFFSET(off, es->sb);
> +	struct buffer_head *bh;
> +	struct exfat_dentry *ep;
> 
> -	return (struct exfat_dentry *)p;
> +	if (num >= es->num_entries)
> +		return NULL;
> +
> +	bh = es->bh[EXFAT_B_TO_BLK(off, es->sb)];
> +	if (!bh)
> +		return NULL;
> +
> +	ep = (struct exfat_dentry *)
> +		(bh->b_data + EXFAT_BLK_OFFSET(off, es->sb));
> +
> +	switch (type) {
> +	case TYPE_ALL: /* accept any */
> +		break;
> +	case TYPE_FILE:
> +		if (ep->type != EXFAT_FILE)
> +			return NULL;
> +		break;
> +	case TYPE_SECONDARY:
> +		if (!(type & exfat_get_entry_type(ep)))
> +			return NULL;
> +		break;
Type check should be in this order : FILE->STREAM->NAME->{CRITICAL_SEC|BENIGN_SEC}
I think that you are missing TYPE_NAME check here.
> +	default:
> +		if (type != exfat_get_entry_type(ep))
> +			return NULL;
> +	}
> +	return ep;
>  }
> 
>  /*
>   * Returns a set of dentries for a file or dir.
>   *
> - * Note It provides a direct pointer to bh->data via exfat_get_dentry_cached().
> + * Note It provides a direct pointer to bh->data via exfat_get_validated_dentry().
>   * User should call exfat_get_dentry_set() after setting 'modified' to apply
>   * changes made in this entry set to the real device.
>   *
>   * in:
>   *   sb+p_dir+entry: indicates a file/dir
> - *   type:  specifies how many dentries should be included.
> + *   max_entries:  specifies how many dentries should be included.
>   * return:
>   *   pointer of entry set on success,
>   *   NULL on failure.
> + * note:
> + *   On success, guarantee the correct 'file' and 'stream-ext' dir-entries.
This comment seems unnecessary.

>   */
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
>  	struct exfat_dentry *ep;
> -	int num_entries;
> -	enum exfat_validate_dentry_mode mode = ES_MODE_STARTED;
>  	struct buffer_head *bh;
> 
>  	if (p_dir->dir == DIR_DELETED) {
> @@ -844,13 +815,13 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
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
>  	sec = EXFAT_B_TO_BLK(byte_offset, sb); @@ -861,15 +832,12 @@ struct exfat_entry_set_cache
> *exfat_get_dentry_set(struct super_block *sb,
>  		goto free_es;
>  	es->bh[es->num_bh++] = bh;
> 
> -	ep = exfat_get_dentry_cached(es, 0);
> -	if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
> +	ep = exfat_get_validated_dentry(es, 0, TYPE_FILE);
> +	if (!ep)
>  		goto free_es;
> +	es->num_entries = min(ep->dentry.file.num_ext + 1, max_entries);
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
>  		if (exfat_is_last_sector_in_cluster(sbi, sec)) { @@ -889,11 +857,13 @@ struct
> exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
>  	}
> 
>  	/* validiate cached dentries */
> -	for (i = 1; i < num_entries; i++) {
> -		ep = exfat_get_dentry_cached(es, i);
> -		if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
> +	if (!exfat_get_validated_dentry(es, 1, TYPE_STREAM))
> +		goto free_es;
> +	for (i = 2; i < es->num_entries; i++) {
> +		if (!exfat_get_validated_dentry(es, i, TYPE_SECONDARY))
>  			goto free_es;
>  	}
> +
>  	return es;
> 
>  free_es:
> @@ -1028,7 +998,7 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
>  			}
> 
>  			brelse(bh);
> -			if (entry_type == TYPE_EXTEND) {
> +			if (entry_type == TYPE_NAME) {
>  				unsigned short entry_uniname[16], unichar;
> 
>  				if (step != DIRENT_STEP_NAME) {
> @@ -1144,7 +1114,7 @@ int exfat_count_ext_entries(struct super_block *sb, struct exfat_chain *p_dir,
> 
>  		type = exfat_get_entry_type(ext_ep);
>  		brelse(bh);
> -		if (type == TYPE_EXTEND || type == TYPE_STREAM)
> +		if (type == TYPE_NAME || type == TYPE_STREAM)
>  			count++;
>  		else
>  			break;
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h index cb51d6e83199..7e07f4645696 100644
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
> +#define TYPE_SECONDARY		(TYPE_CRITICAL_SEC | TYPE_BENIGN_SEC)
> +
>  #define MAX_CHARSET_SIZE	6 /* max size of multi-byte character */
>  #define MAX_NAME_LENGTH		255 /* max len of file name excluding NULL */
>  #define MAX_VFSNAME_BUF_SIZE	((MAX_NAME_LENGTH + 1) * MAX_CHARSET_SIZE)
> @@ -171,7 +174,7 @@ struct exfat_entry_set_cache {
>  	unsigned int start_off;
>  	int num_bh;
>  	struct buffer_head *bh[DIR_CACHE_SIZE];
> -	unsigned int num_entries;
> +	int num_entries;
>  };
> 
>  struct exfat_dir_entry {
> @@ -456,10 +459,10 @@ int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir,
> struct exfat_dentry *exfat_get_dentry(struct super_block *sb,
>  		struct exfat_chain *p_dir, int entry, struct buffer_head **bh,
>  		sector_t *sector);
> -struct exfat_dentry *exfat_get_dentry_cached(struct exfat_entry_set_cache *es,
> -		int num);
> +struct exfat_dentry *exfat_get_validated_dentry(struct exfat_entry_set_cache *es,
> +		int num, unsigned int type);
>  struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
> -		struct exfat_chain *p_dir, int entry, unsigned int type);
> +		struct exfat_chain *p_dir, int entry, int max_entries);
>  int exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync);  int
> exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir);
> 
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c index 6707f3eb09b5..b6b458e6f5e3 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -160,8 +160,8 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
>  				ES_ALL_ENTRIES);
>  		if (!es)
>  			return -EIO;
> -		ep = exfat_get_dentry_cached(es, 0);
> -		ep2 = exfat_get_dentry_cached(es, 1);
> +		ep = exfat_get_validated_dentry(es, 0, TYPE_FILE);
> +		ep2 = exfat_get_validated_dentry(es, 1, TYPE_STREAM);
TYPE_FILE and TYPE_STREAM was already validated in exfat_get_dentry_set().
Isn't it unnecessary duplication check ?

> 
>  		ts = current_time(inode);
>  		exfat_set_entry_time(sbi, &ts,
> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c index f0160a7892a8..e7bc1ee1761a 100644
> --- a/fs/exfat/inode.c
> +++ b/fs/exfat/inode.c
> @@ -45,8 +45,8 @@ static int __exfat_write_inode(struct inode *inode, int sync)
>  	es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry, ES_ALL_ENTRIES);
>  	if (!es)
>  		return -EIO;
> -	ep = exfat_get_dentry_cached(es, 0);
> -	ep2 = exfat_get_dentry_cached(es, 1);
> +	ep = exfat_get_validated_dentry(es, 0, TYPE_FILE);
> +	ep2 = exfat_get_validated_dentry(es, 1, TYPE_STREAM);
Ditto.
> 
>  	ep->dentry.file.attr = cpu_to_le16(exfat_make_attr(inode));
> 
> @@ -228,7 +228,7 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
>  			if (!es)
>  				return -EIO;
>  			/* get stream entry */
> -			ep = exfat_get_dentry_cached(es, 1);
> +			ep = exfat_get_validated_dentry(es, 1, TYPE_STREAM);
> 
>  			/* update directory entry */
>  			ep->dentry.stream.flags = ei->flags; diff --git a/fs/exfat/namei.c
> b/fs/exfat/namei.c index 126ed3ba8f47..47fef6b75f28 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -664,8 +664,8 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
>  		es = exfat_get_dentry_set(sb, &cdir, dentry, ES_2_ENTRIES);
>  		if (!es)
>  			return -EIO;
> -		ep = exfat_get_dentry_cached(es, 0);
> -		ep2 = exfat_get_dentry_cached(es, 1);
> +		ep = exfat_get_validated_dentry(es, 0, TYPE_FILE);
> +		ep2 = exfat_get_validated_dentry(es, 1, TYPE_STREAM);
Ditto.
> 
>  		info->type = exfat_get_entry_type(ep);
>  		info->attr = le16_to_cpu(ep->dentry.file.attr);
> --
> 2.25.1


