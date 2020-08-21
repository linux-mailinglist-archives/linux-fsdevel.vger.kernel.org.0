Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0197F24CE4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 08:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgHUGyB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 02:54:01 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:17361 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgHUGx7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 02:53:59 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200821065353epoutp0461a5698f76b74144cf9fedf51a3b3556~tNgQWiTfh0600006000epoutp04O
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 06:53:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200821065353epoutp0461a5698f76b74144cf9fedf51a3b3556~tNgQWiTfh0600006000epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597992834;
        bh=QoL2KUOrbp3JZtQcYhj+iPgKG5s+rgZTCV7dvzOkrTc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=G77Q6PUNQDyk6rI0pCfonWG4ODuc9DK49Dofx8TvVwoWlgW32sszEzam5TDA11bLe
         CJdK0wUmYeX35CCBqMOGe4z3zN9cVmJPkUODyg2YkvFBFljAb46OQoyARy6kGRYGpq
         YtXYvEuKhkcPLNW2ngo893InqE33NlCR97KReDfc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200821065353epcas1p4bb27acf2d7b35f4890f13a63f0dc1dbc~tNgQGvzD12693726937epcas1p4y;
        Fri, 21 Aug 2020 06:53:53 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.159]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4BXsgN2Fk3zMqYkb; Fri, 21 Aug
        2020 06:53:52 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.35.28578.F7F6F3F5; Fri, 21 Aug 2020 15:53:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200821065350epcas1p318f68b52929ab678bb3b8c6d20024eae~tNgNcXFlV1953619536epcas1p3p;
        Fri, 21 Aug 2020 06:53:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200821065350epsmtrp21199eb7bb4f506e69ed8c7b51d029f09~tNgNblh811561015610epsmtrp2S;
        Fri, 21 Aug 2020 06:53:50 +0000 (GMT)
X-AuditID: b6c32a39-8dfff70000006fa2-58-5f3f6f7f911e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.0E.08303.E7F6F3F5; Fri, 21 Aug 2020 15:53:50 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200821065350epsmtip21017cfb81d2ee5b534d5bcfe605f0173~tNgNOo9D61241012410epsmtip2E;
        Fri, 21 Aug 2020 06:53:50 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <ca3b2b52-1abc-939c-aa11-8c7d12e4eb2e@gmail.com>
Subject: RE: [PATCH v3] exfat: integrates dir-entry getting and validation
Date:   Fri, 21 Aug 2020 15:53:50 +0900
Message-ID: <000001d67787$d3abcbb0$7b036310$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH6G9isXEQ9sMxkt33jRW4ItYjr3QIF0gSvAfjtwRwBp6Lp0ajNX1mQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmrm59vn28QfttXosfc2+zWLw5OZXF
        Ys/ekywWl3fNYbO4/P8Ti8WyL5NZLLb8O8LqwO7xZc5xdo+2yf/YPZqPrWTz2DnrLrtH35ZV
        jB6fN8kFsEXl2GSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
        ZeYA3aKkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTA0KNArTswtLs1L10vOz7Uy
        NDAwMgWqTMjJaH9wnrlg8nTGipcP/7A1ML6r6mLk5JAQMJHo2bGbtYuRi0NIYAejxIP7TUwQ
        zidGiVnTZkI5nxklLi08xwLT0njiKiNEYhejRN/tLewQzktGiXUn1jGCVLEJ6Er8+7OfDcQW
        EdCTOHnyOhtIEbNAI5PE8hNfmEESnAK2EguX/AHazsEhLOAlMa9XCiTMIqAqcfXWdEaQMK+A
        pcSFCSkgYV4BQYmTM5+AHcEsIC+x/e0cZoiDFCR+Pl3GCrHKTeL65TvMEDUiErM725hB1koI
        LOWQ+PT1DdgqCQEXiTUNMhC9whKvjoPcD2JLSXx+t5cNoqRa4uN+qPEdjBIvvttC2MYSN9dv
        AJvCLKApsX6XPkRYUWLn77mMEFv5JN597YFaxCvR0SYEUaIq0XfpMBOELS3R1f6BfQKj0iwk
        f81C8tcsJPfPQli2gJFlFaNYakFxbnpqsWGBKXJcb2IEJ1Mtyx2M099+0DvEyMTBeIhRgoNZ
        SYS3d691vBBvSmJlVWpRfnxRaU5q8SFGU2BAT2SWEk3OB6bzvJJ4Q1MjY2NjCxMzczNTYyVx
        3oe3FOKFBNITS1KzU1MLUotg+pg4OKUamAoO1LhPfNgvudHqutvvK0a7v+sdXcDoHnPk3WWb
        A/GpVXf4OQtswg9FWBrFSSR+fdurVWvFGn2Y81/JjpPC9le3+kcpPFNnWHDIw4ix7B3rXK3U
        3rldExZee31o8fGenN12CZ1X/yx8pOh9wjlN6+mpCzZbzsTfDJ/2ybJFxeeJ9ve46y1ZvuHL
        BUPOF/yXf8517qzr1g8KnL+3v3MuTvnUn/JuzyzW5ytFZwff6DITd1lyKtZbfMmKo+6Rjyfs
        8ru7Yu+HPwd0t/3iOnXpy3UXNpVrzRLWtcuOCQr8OduZtMVP4I7wk4lhJ/e8nRm5fpe/nqFn
        pXvcoQ6eWwx3uaeymUsFrrES2va1aMnmPTJKLMUZiYZazEXFiQC2LYhdLwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJXrcu3z7e4G2zrsWPubdZLN6cnMpi
        sWfvSRaLy7vmsFlc/v+JxWLZl8ksFlv+HWF1YPf4Muc4u0fb5H/sHs3HVrJ57Jx1l92jb8sq
        Ro/Pm+QC2KK4bFJSczLLUov07RK4MtofnGcumDydseLlwz9sDYzvqroYOTkkBEwkGk9cZexi
        5OIQEtjBKHH2zGl2iIS0xLETZ5i7GDmAbGGJw4eLIWqeM0pcOLESrIZNQFfi35/9bCC2iICe
        xMmT19lAipgFmpkkvj1bwgzR8ZJR4tKnu2AdnAK2EguX/GEFmSos4CUxr1cKJMwioCpx9dZ0
        RpAwr4ClxIUJKSBhXgFBiZMzn7CA2MwC2hJPbz6FsuUltr+dwwxxp4LEz6fLWCFucJO4fvkO
        M0SNiMTszjbmCYzCs5CMmoVk1Cwko2YhaVnAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10v
        OT93EyM4srS0djDuWfVB7xAjEwfjIUYJDmYlEd7evdbxQrwpiZVVqUX58UWlOanFhxilOViU
        xHm/zloYJySQnliSmp2aWpBaBJNl4uCUamBa8NcwzSH25eoz+g9Oqz6U135+8v32Ga/t11xX
        +7nsa+df3ovnny/eME281N1u21Tm/UtjAmP4tvck/T24pPfxucaOpATW0FTzN9M6emtvFL9N
        9a1i2+H+OO9CcoPw33W+rDk7Vu7Yu8h20c1vJob/5kwXXdd/MmTizzTJTaLrJTbPi/jOf9wt
        m3vRlYkXYk3V/V6+PBa7pu8Rs/pxg6KDxtZ3VKo+f3qwqSjRRWd23qqXF1kkam6pb9vjoWh4
        pNH2nFKO887TB95WXjbilTmxIO+OZud0k6N3wu3eeHr2rdum6LO3f3XM/DdHeQTCvsrY6RVc
        +fbQfo96qvwrEfWz5SEih7dPSl33yewKp/RHUSWW4oxEQy3mouJEABHEqrcbAwAA
X-CMS-MailID: 20200821065350epcas1p318f68b52929ab678bb3b8c6d20024eae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200806010250epcas1p482847d6d906fbf0ccd618c7d1cacd12e
References: <CGME20200806010250epcas1p482847d6d906fbf0ccd618c7d1cacd12e@epcas1p4.samsung.com>
        <20200806010229.24690-1-kohada.t2@gmail.com>
        <003c01d66edc$edbb1690$c93143b0$@samsung.com>
        <ca3b2b52-1abc-939c-aa11-8c7d12e4eb2e@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> Thank you for your reply.
> 
> >> @@ -171,7 +174,9 @@ struct exfat_entry_set_cache {
> >>   	unsigned int start_off;
> >>   	int num_bh;
> >>   	struct buffer_head *bh[DIR_CACHE_SIZE];
> >> -	unsigned int num_entries;
> >> +	int num_entries;
> >> +	struct exfat_de_file *de_file;
> >> +	struct exfat_de_stream *de_stream;
> > I prefer to assign validated entries to **de and use it using enum value.
> > 	struct exfat_dentry **de;
> 
> I've tried several implementations that add a struct exfat_dentry type.(*de0 & *de1;  *de[2]; etc...)
> The problem with the struct exfat_dentry type is that it is too flexible for type.
> This means weak typing.
> Therefore, when using them,
> 	de[XXX_FILE]->dentry.file.zzz ...
> It is necessary to re-specify the type. (against the DRY principle) Strong typing prevents use with
> wrong type, at compiling.
> 
> I think the approach of using de_file/de_stream could be strongly typed.
> I don't think we need excessive flexibility.

Could you check the following change ?
If you think it's okay, please add it to your patch series.

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 573659bfbc55..37e0f92f74b3 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -44,14 +44,12 @@ static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
 	 * Third entry  : first file-name entry
 	 * So, the index of first file-name dentry should start from 2.
 	 */
-	for (i = 2; i < es->num_entries; i++) {
-		struct exfat_dentry *ep = exfat_get_dentry_cached(es, i);
-
+	for (i = ENTRY_NAME; i < es->num_entries; i++) {
 		/* end of name entry */
-		if (exfat_get_entry_type(ep) != TYPE_EXTEND)
+		if (exfat_get_entry_type(es->de[i]) != TYPE_NAME)
 			break;
 
-		exfat_extract_uni_name(ep, uniname);
+		exfat_extract_uni_name(es->de[i], uniname);
 		uniname += EXFAT_FILE_NAME_LEN;
 	}
 
@@ -372,7 +370,7 @@ unsigned int exfat_get_entry_type(struct exfat_dentry *ep)
 		if (ep->type == EXFAT_STREAM)
 			return TYPE_STREAM;
 		if (ep->type == EXFAT_NAME)
-			return TYPE_EXTEND;
+			return TYPE_NAME;
 		if (ep->type == EXFAT_ACL)
 			return TYPE_ACL;
 		return TYPE_CRITICAL_SEC;
@@ -388,7 +386,7 @@ static void exfat_set_entry_type(struct exfat_dentry *ep, unsigned int type)
 		ep->type &= EXFAT_DELETE;
 	} else if (type == TYPE_STREAM) {
 		ep->type = EXFAT_STREAM;
-	} else if (type == TYPE_EXTEND) {
+	} else if (type == TYPE_NAME) {
 		ep->type = EXFAT_NAME;
 	} else if (type == TYPE_BITMAP) {
 		ep->type = EXFAT_BITMAP;
@@ -421,7 +419,7 @@ static void exfat_init_name_entry(struct exfat_dentry *ep,
 {
 	int i;
 
-	exfat_set_entry_type(ep, TYPE_EXTEND);
+	exfat_set_entry_type(ep, TYPE_NAME);
 	ep->dentry.name.flags = 0x0;
 
 	for (i = 0; i < EXFAT_FILE_NAME_LEN; i++) {
@@ -591,16 +589,13 @@ void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
 {
 	int chksum_type = CS_DIR_ENTRY, i;
 	unsigned short chksum = 0;
-	struct exfat_dentry *ep;
 
 	for (i = 0; i < es->num_entries; i++) {
-		ep = exfat_get_dentry_cached(es, i);
-		chksum = exfat_calc_chksum16(ep, DENTRY_SIZE, chksum,
+		chksum = exfat_calc_chksum16(es->de[i], DENTRY_SIZE, chksum,
 					     chksum_type);
 		chksum_type = CS_DEFAULT;
 	}
-	ep = exfat_get_dentry_cached(es, 0);
-	ep->dentry.file.checksum = cpu_to_le16(chksum);
+	ES_FILE(es).checksum = cpu_to_le16(chksum);
 	es->modified = true;
 }
 
@@ -741,59 +736,8 @@ struct exfat_dentry *exfat_get_dentry(struct super_block *sb,
 	return (struct exfat_dentry *)((*bh)->b_data + off);
 }
 
-enum exfat_validate_dentry_mode {
-	ES_MODE_STARTED,
-	ES_MODE_GET_FILE_ENTRY,
-	ES_MODE_GET_STRM_ENTRY,
-	ES_MODE_GET_NAME_ENTRY,
-	ES_MODE_GET_CRITICAL_SEC_ENTRY,
-};
-
-static bool exfat_validate_entry(unsigned int type,
-		enum exfat_validate_dentry_mode *mode)
-{
-	if (type == TYPE_UNUSED || type == TYPE_DELETED)
-		return false;
-
-	switch (*mode) {
-	case ES_MODE_STARTED:
-		if  (type != TYPE_FILE && type != TYPE_DIR)
-			return false;
-		*mode = ES_MODE_GET_FILE_ENTRY;
-		return true;
-	case ES_MODE_GET_FILE_ENTRY:
-		if (type != TYPE_STREAM)
-			return false;
-		*mode = ES_MODE_GET_STRM_ENTRY;
-		return true;
-	case ES_MODE_GET_STRM_ENTRY:
-		if (type != TYPE_EXTEND)
-			return false;
-		*mode = ES_MODE_GET_NAME_ENTRY;
-		return true;
-	case ES_MODE_GET_NAME_ENTRY:
-		if (type == TYPE_STREAM)
-			return false;
-		if (type != TYPE_EXTEND) {
-			if (!(type & TYPE_CRITICAL_SEC))
-				return false;
-			*mode = ES_MODE_GET_CRITICAL_SEC_ENTRY;
-		}
-		return true;
-	case ES_MODE_GET_CRITICAL_SEC_ENTRY:
-		if (type == TYPE_EXTEND || type == TYPE_STREAM)
-			return false;
-		if ((type & TYPE_CRITICAL_SEC) != TYPE_CRITICAL_SEC)
-			return false;
-		return true;
-	default:
-		WARN_ON_ONCE(1);
-		return false;
-	}
-}
-
-struct exfat_dentry *exfat_get_dentry_cached(
-	struct exfat_entry_set_cache *es, int num)
+struct exfat_dentry *exfat_get_dentry_cached(struct exfat_entry_set_cache *es,
+		int num)
 {
 	int off = es->start_off + num * DENTRY_SIZE;
 	struct buffer_head *bh = es->bh[EXFAT_B_TO_BLK(off, es->sb)];
@@ -817,16 +761,14 @@ struct exfat_dentry *exfat_get_dentry_cached(
  *   NULL on failure.
  */
 struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
-		struct exfat_chain *p_dir, int entry, unsigned int type)
+		struct exfat_chain *p_dir, int entry, int max_entries)
 {
-	int ret, i, num_bh;
-	unsigned int off, byte_offset, clu = 0;
+	int i, num_bh, num_entries, last_name_entry;
+	unsigned int clu = 0;
 	sector_t sec;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_entry_set_cache *es;
 	struct exfat_dentry *ep;
-	int num_entries;
-	enum exfat_validate_dentry_mode mode = ES_MODE_STARTED;
 	struct buffer_head *bh;
 
 	if (p_dir->dir == DIR_DELETED) {
@@ -834,42 +776,31 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 		return NULL;
 	}
 
-	byte_offset = EXFAT_DEN_TO_B(entry);
-	ret = exfat_walk_fat_chain(sb, p_dir, byte_offset, &clu);
-	if (ret)
+	ep = exfat_get_dentry(sb, p_dir, entry, &bh, &sec);
+	if (!ep || ep->type != EXFAT_FILE) {
+		brelse(bh);
 		return NULL;
+	}
 
-	es = kzalloc(sizeof(*es), GFP_KERNEL);
-	if (!es)
+	max_entries = max(max_entries, ES_2_ENTRIES);
+	num_entries = min(ep->dentry.file.num_ext + 1, max_entries);
+	es = kzalloc(sizeof(*es) + num_entries * sizeof(struct exfat_dentry *),
+			GFP_KERNEL);
+	if (!es) {
+		brelse(bh);
 		return NULL;
+	}
+
 	es->sb = sb;
 	es->modified = false;
-
-	/* byte offset in cluster */
-	byte_offset = EXFAT_CLU_OFFSET(byte_offset, sbi);
-
-	/* byte offset in sector */
-	off = EXFAT_BLK_OFFSET(byte_offset, sb);
-	es->start_off = off;
-
-	/* sector offset in cluster */
-	sec = EXFAT_B_TO_BLK(byte_offset, sb);
-	sec += exfat_cluster_to_sector(sbi, clu);
-
-	bh = sb_bread(sb, sec);
-	if (!bh)
-		goto free_es;
-	es->bh[es->num_bh++] = bh;
-
-	ep = exfat_get_dentry_cached(es, 0);
-	if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
-		goto free_es;
-
-	num_entries = type == ES_ALL_ENTRIES ?
-		ep->dentry.file.num_ext + 1 : type;
 	es->num_entries = num_entries;
+	es->de[ENTRY_FILE] = ep;
+	es->bh[es->num_bh++] = bh;
+	/* byte offset in sector */
+	es->start_off = EXFAT_BLK_OFFSET(EXFAT_DEN_TO_B(entry), sb);
 
-	num_bh = EXFAT_B_TO_BLK_ROUND_UP(off + num_entries * DENTRY_SIZE, sb);
+	clu = exfat_sector_to_cluster(sbi, sec);
+	num_bh = EXFAT_B_TO_BLK_ROUND_UP(es->start_off + num_entries * DENTRY_SIZE, sb);
 	for (i = 1; i < num_bh; i++) {
 		/* get the next sector */
 		if (exfat_is_last_sector_in_cluster(sbi, sec)) {
@@ -888,14 +819,27 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 		es->bh[es->num_bh++] = bh;
 	}
 
-	/* validiate cached dentries */
-	for (i = 1; i < num_entries; i++) {
-		ep = exfat_get_dentry_cached(es, i);
-		if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
+	ep = exfat_get_dentry_cached(es, ENTRY_STREAM);
+	if (!ep || ep->type != EXFAT_STREAM)
+		goto free_es;
+	es->de[ENTRY_STREAM] = ep;
+
+	last_name_entry =
+		ENTRY_NAME + ES_STREAM(es).name_len / EXFAT_FILE_NAME_LEN;
+	for (i = ENTRY_NAME; i < es->num_entries; i++) {
+		es->de[i] = exfat_get_dentry_cached(es, i);
+
+		if (i <= last_name_entry) {
+			if (exfat_get_entry_type(es->de[i]) != TYPE_NAME)
+				goto free_es;
+			continue;
+		}
+
+		if (!(exfat_get_entry_type(es->de[i]) & TYPE_SECONDARY))
 			goto free_es;
 	}
-	return es;
 
+	return es;
 free_es:
 	exfat_free_dentry_set(es, false);
 	return NULL;
@@ -1028,7 +972,7 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 			}
 
 			brelse(bh);
-			if (entry_type == TYPE_EXTEND) {
+			if (entry_type == TYPE_NAME) {
 				unsigned short entry_uniname[16], unichar;
 
 				if (step != DIRENT_STEP_NAME) {
@@ -1144,7 +1088,7 @@ int exfat_count_ext_entries(struct super_block *sb, struct exfat_chain *p_dir,
 
 		type = exfat_get_entry_type(ext_ep);
 		brelse(bh);
-		if (type == TYPE_EXTEND || type == TYPE_STREAM)
+		if (type == TYPE_NAME || type == TYPE_STREAM)
 			count++;
 		else
 			break;
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 44dc04520175..0e4cc8ba2f8e 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -33,6 +33,12 @@ enum {
 	NLS_NAME_OVERLEN,	/* the length is over than its limit */
 };
 
+enum {
+	ENTRY_FILE,
+	ENTRY_STREAM,
+	ENTRY_NAME,
+};
+
 #define EXFAT_HASH_BITS		8
 #define EXFAT_HASH_SIZE		(1UL << EXFAT_HASH_BITS)
 
@@ -40,7 +46,7 @@ enum {
  * Type Definitions
  */
 #define ES_2_ENTRIES		2
-#define ES_ALL_ENTRIES		0
+#define ES_ALL_ENTRIES		256
 
 #define DIR_DELETED		0xFFFF0321
 
@@ -56,7 +62,7 @@ enum {
 #define TYPE_FILE		0x011F
 #define TYPE_CRITICAL_SEC	0x0200
 #define TYPE_STREAM		0x0201
-#define TYPE_EXTEND		0x0202
+#define TYPE_NAME		0x0202
 #define TYPE_ACL		0x0203
 #define TYPE_BENIGN_PRI		0x0400
 #define TYPE_GUID		0x0401
@@ -65,6 +71,8 @@ enum {
 #define TYPE_BENIGN_SEC		0x0800
 #define TYPE_ALL		0x0FFF
 
+#define TYPE_SECONDARY		(TYPE_CRITICAL_SEC | TYPE_BENIGN_SEC)
+
 #define MAX_CHARSET_SIZE	6 /* max size of multi-byte character */
 #define MAX_NAME_LENGTH		255 /* max len of file name excluding NULL */
 #define MAX_VFSNAME_BUF_SIZE	((MAX_NAME_LENGTH + 1) * MAX_CHARSET_SIZE)
@@ -126,6 +134,9 @@ enum {
 #define BITS_PER_BYTE_MASK	0x7
 #define IGNORED_BITS_REMAINED(clu, clu_base) ((1 << ((clu) - (clu_base))) - 1)
 
+#define ES_FILE(es)	(es->de[ENTRY_FILE]->dentry.file)
+#define ES_STREAM(es)	(es->de[ENTRY_STREAM]->dentry.stream)
+
 struct exfat_dentry_namebuf {
 	char *lfn;
 	int lfnbuf_len; /* usually MAX_UNINAME_BUF_SIZE */
@@ -171,7 +182,8 @@ struct exfat_entry_set_cache {
 	unsigned int start_off;
 	int num_bh;
 	struct buffer_head *bh[DIR_CACHE_SIZE];
-	unsigned int num_entries;
+	int num_entries;
+	struct exfat_dentry *de[0];
 };
 
 struct exfat_dir_entry {
@@ -461,7 +473,7 @@ struct exfat_dentry *exfat_get_dentry(struct super_block *sb,
 struct exfat_dentry *exfat_get_dentry_cached(struct exfat_entry_set_cache *es,
 		int num);
 struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
-		struct exfat_chain *p_dir, int entry, unsigned int type);
+		struct exfat_chain *p_dir, int entry, int max_entries);
 int exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync);
 int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir);
 
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 4831a39632a1..504ffcaffacc 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -152,7 +152,6 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
 	/* update the directory entry */
 	if (!evict) {
 		struct timespec64 ts;
-		struct exfat_dentry *ep, *ep2;
 		struct exfat_entry_set_cache *es;
 		int err;
 
@@ -160,32 +159,30 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
 				ES_ALL_ENTRIES);
 		if (!es)
 			return -EIO;
-		ep = exfat_get_dentry_cached(es, 0);
-		ep2 = exfat_get_dentry_cached(es, 1);
 
 		ts = current_time(inode);
 		exfat_set_entry_time(sbi, &ts,
-				&ep->dentry.file.modify_tz,
-				&ep->dentry.file.modify_time,
-				&ep->dentry.file.modify_date,
-				&ep->dentry.file.modify_time_cs);
-		ep->dentry.file.attr = cpu_to_le16(ei->attr);
+				&ES_FILE(es).modify_tz,
+				&ES_FILE(es).modify_time,
+				&ES_FILE(es).modify_date,
+				&ES_FILE(es).modify_time_cs);
+		ES_FILE(es).attr = cpu_to_le16(ei->attr);
 
 		/* File size should be zero if there is no cluster allocated */
 		if (ei->start_clu == EXFAT_EOF_CLUSTER) {
-			ep2->dentry.stream.valid_size = 0;
-			ep2->dentry.stream.size = 0;
+			ES_STREAM(es).valid_size = 0;
+			ES_STREAM(es).size = 0;
 		} else {
-			ep2->dentry.stream.valid_size = cpu_to_le64(new_size);
-			ep2->dentry.stream.size = ep2->dentry.stream.valid_size;
+			ES_STREAM(es).valid_size = cpu_to_le64(new_size);
+			ES_STREAM(es).size = ES_STREAM(es).valid_size;
 		}
 
 		if (new_size == 0) {
 			/* Any directory can not be truncated to zero */
 			WARN_ON(ei->type != TYPE_FILE);
 
-			ep2->dentry.stream.flags = ALLOC_FAT_CHAIN;
-			ep2->dentry.stream.start_clu = EXFAT_FREE_CLUSTER;
+			ES_STREAM(es).flags = ALLOC_FAT_CHAIN;
+			ES_STREAM(es).start_clu = EXFAT_FREE_CLUSTER;
 		}
 
 		exfat_update_dir_chksum_with_entry_set(es);
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 7f90204adef5..a6be7ab76a72 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -20,7 +20,6 @@
 static int __exfat_write_inode(struct inode *inode, int sync)
 {
 	unsigned long long on_disk_size;
-	struct exfat_dentry *ep, *ep2;
 	struct exfat_entry_set_cache *es = NULL;
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
@@ -45,26 +44,24 @@ static int __exfat_write_inode(struct inode *inode, int sync)
 	es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry, ES_ALL_ENTRIES);
 	if (!es)
 		return -EIO;
-	ep = exfat_get_dentry_cached(es, 0);
-	ep2 = exfat_get_dentry_cached(es, 1);
 
-	ep->dentry.file.attr = cpu_to_le16(exfat_make_attr(inode));
+	ES_FILE(es).attr = cpu_to_le16(exfat_make_attr(inode));
 
 	/* set FILE_INFO structure using the acquired struct exfat_dentry */
 	exfat_set_entry_time(sbi, &ei->i_crtime,
-			&ep->dentry.file.create_tz,
-			&ep->dentry.file.create_time,
-			&ep->dentry.file.create_date,
-			&ep->dentry.file.create_time_cs);
+			&ES_FILE(es).create_tz,
+			&ES_FILE(es).create_time,
+			&ES_FILE(es).create_date,
+			&ES_FILE(es).create_time_cs);
 	exfat_set_entry_time(sbi, &inode->i_mtime,
-			&ep->dentry.file.modify_tz,
-			&ep->dentry.file.modify_time,
-			&ep->dentry.file.modify_date,
-			&ep->dentry.file.modify_time_cs);
+			&ES_FILE(es).modify_tz,
+			&ES_FILE(es).modify_time,
+			&ES_FILE(es).modify_date,
+			&ES_FILE(es).modify_time_cs);
 	exfat_set_entry_time(sbi, &inode->i_atime,
-			&ep->dentry.file.access_tz,
-			&ep->dentry.file.access_time,
-			&ep->dentry.file.access_date,
+			&ES_FILE(es).access_tz,
+			&ES_FILE(es).access_time,
+			&ES_FILE(es).access_date,
 			NULL);
 
 	/* File size should be zero if there is no cluster allocated */
@@ -73,8 +70,8 @@ static int __exfat_write_inode(struct inode *inode, int sync)
 	if (ei->start_clu == EXFAT_EOF_CLUSTER)
 		on_disk_size = 0;
 
-	ep2->dentry.stream.valid_size = cpu_to_le64(on_disk_size);
-	ep2->dentry.stream.size = ep2->dentry.stream.valid_size;
+	ES_STREAM(es).valid_size = cpu_to_le64(on_disk_size);
+	ES_STREAM(es).size = ES_STREAM(es).valid_size;
 
 	exfat_update_dir_chksum_with_entry_set(es);
 	return exfat_free_dentry_set(es, sync);
@@ -219,7 +216,6 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 		*clu = new_clu.dir;
 
 		if (ei->dir.dir != DIR_DELETED && modified) {
-			struct exfat_dentry *ep;
 			struct exfat_entry_set_cache *es;
 			int err;
 
@@ -227,17 +223,12 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 				ES_ALL_ENTRIES);
 			if (!es)
 				return -EIO;
-			/* get stream entry */
-			ep = exfat_get_dentry_cached(es, 1);
 
 			/* update directory entry */
-			ep->dentry.stream.flags = ei->flags;
-			ep->dentry.stream.start_clu =
-				cpu_to_le32(ei->start_clu);
-			ep->dentry.stream.valid_size =
-				cpu_to_le64(i_size_read(inode));
-			ep->dentry.stream.size =
-				ep->dentry.stream.valid_size;
+			ES_STREAM(es).flags = ei->flags;
+			ES_STREAM(es).start_clu = cpu_to_le32(ei->start_clu);
+			ES_STREAM(es).valid_size = cpu_to_le64(i_size_read(inode));
+			ES_STREAM(es).size = ES_STREAM(es).valid_size;
 
 			exfat_update_dir_chksum_with_entry_set(es);
 			err = exfat_free_dentry_set(es, inode_needs_sync(inode));
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 2aff6605fecc..469fe075dc1f 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -658,25 +658,21 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 
 		info->num_subdirs = count;
 	} else {
-		struct exfat_dentry *ep, *ep2;
 		struct exfat_entry_set_cache *es;
 
 		es = exfat_get_dentry_set(sb, &cdir, dentry, ES_2_ENTRIES);
 		if (!es)
 			return -EIO;
-		ep = exfat_get_dentry_cached(es, 0);
-		ep2 = exfat_get_dentry_cached(es, 1);
 
-		info->type = exfat_get_entry_type(ep);
-		info->attr = le16_to_cpu(ep->dentry.file.attr);
-		info->size = le64_to_cpu(ep2->dentry.stream.valid_size);
+		info->type = exfat_get_entry_type(es->de[ENTRY_FILE]);
+		info->attr = le16_to_cpu(ES_FILE(es).attr);
+		info->size = le64_to_cpu(ES_STREAM(es).valid_size);
 		if ((info->type == TYPE_FILE) && (info->size == 0)) {
 			info->flags = ALLOC_NO_FAT_CHAIN;
 			info->start_clu = EXFAT_EOF_CLUSTER;
 		} else {
-			info->flags = ep2->dentry.stream.flags;
-			info->start_clu =
-				le32_to_cpu(ep2->dentry.stream.start_clu);
+			info->flags = ES_STREAM(es).flags;
+			info->start_clu = le32_to_cpu(ES_STREAM(es).start_clu);
 		}
 
 		if (ei->start_clu == EXFAT_FREE_CLUSTER) {
@@ -688,19 +684,19 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 		}
 
 		exfat_get_entry_time(sbi, &info->crtime,
-				ep->dentry.file.create_tz,
-				ep->dentry.file.create_time,
-				ep->dentry.file.create_date,
-				ep->dentry.file.create_time_cs);
+				ES_FILE(es).create_tz,
+				ES_FILE(es).create_time,
+				ES_FILE(es).create_date,
+				ES_FILE(es).create_time_cs);
 		exfat_get_entry_time(sbi, &info->mtime,
-				ep->dentry.file.modify_tz,
-				ep->dentry.file.modify_time,
-				ep->dentry.file.modify_date,
-				ep->dentry.file.modify_time_cs);
+				ES_FILE(es).modify_tz,
+				ES_FILE(es).modify_time,
+				ES_FILE(es).modify_date,
+				ES_FILE(es).modify_time_cs);
 		exfat_get_entry_time(sbi, &info->atime,
-				ep->dentry.file.access_tz,
-				ep->dentry.file.access_time,
-				ep->dentry.file.access_date,
+				ES_FILE(es).access_tz,
+				ES_FILE(es).access_time,
+				ES_FILE(es).access_date,
 				0);
 		exfat_free_dentry_set(es, false);
 
-- 
2.17.1

> 
> 
> BR
> ---
> Tetsuhiro Kohada <kohada.t2@gmail.com>

