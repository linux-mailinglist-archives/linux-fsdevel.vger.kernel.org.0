Return-Path: <linux-fsdevel+bounces-5604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AC980E0BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 02:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51411F21C18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 01:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C87800;
	Tue, 12 Dec 2023 01:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uxfZQN2P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A624BE
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 17:15:53 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231212011550epoutp02e5e78f35e7250cc368b460c8e86bd56f~f8J8qY4gA2605126051epoutp02T
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 01:15:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231212011550epoutp02e5e78f35e7250cc368b460c8e86bd56f~f8J8qY4gA2605126051epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1702343750;
	bh=vF9TkwvPGsZOZGYo12+3lKTTAS6O8AfxR4eJEuLsiAg=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=uxfZQN2PIms6jeopo8QpESQUMUBS+QRpO2YEgy0z3r407Kixdf8P9pMrp9V8LgiZn
	 iQypI+A7rPwkVg4fme/nbUzdp7NG0aAMEDDTTwESA4laB1U0GEBJ3mpToc3jDzqeko
	 z3LR+P4XWgRZNVV6ScX4Kj3h+hJlbHe2RL/FLz6M=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231212011550epcas1p1a89e3e17df00544ea0ac7b3de5e9bb6a~f8J8e-fEm1922319223epcas1p1l;
	Tue, 12 Dec 2023 01:15:50 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.225]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Sq0zp0FWcz4x9Q5; Tue, 12 Dec
	2023 01:15:50 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0F.4E.19104.544B7756; Tue, 12 Dec 2023 10:15:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20231212011549epcas1p367428782c92cdf677bf1564c66bb07e3~f8J70i6Xn1387013870epcas1p3h;
	Tue, 12 Dec 2023 01:15:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231212011549epsmtrp258546396025553d9e8aade6b5af8842c~f8J7zrQDf0884408844epsmtrp2E;
	Tue, 12 Dec 2023 01:15:49 +0000 (GMT)
X-AuditID: b6c32a4c-559ff70000004aa0-65-6577b445dc71
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	59.71.08755.544B7756; Tue, 12 Dec 2023 10:15:49 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20231212011549epsmtip16e00bba33e7b42fb4b96f99d31e8fc71~f8J7r3XpH2542825428epsmtip1N;
	Tue, 12 Dec 2023 01:15:49 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: "'John Sanpe'" <sanpeqf@gmail.com>, <linkinjeon@kernel.org>,
	<willy@infradead.org>
Cc: <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20231207234701.566133-1-sanpeqf@gmail.com>
Subject: RE: [PATCH] exfat/balloc: using ffs instead of internal logic
Date: Tue, 12 Dec 2023 10:15:49 +0900
Message-ID: <1185d01da2c98$bdfee260$39fca720$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQI0WxECuqVU2a75Fb4ZifduF4T/9AGjxp5ar+NczOA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNJsWRmVeSWpSXmKPExsWy7bCmvq7rlvJUg871VhYTpy1lttiz9ySL
	xZH2JewWv3/MYXNg8dg56y67x+YVWh6bVnWyeXzeJBfAEtXAaJNYlJyRWZaqkJqXnJ+SmZdu
	qxQa4qZroaSQkV9cYqsUbWhopGdoYK5nZGSkZ2oUa2VkqqSQl5ibaqtUoQvVq6RQlFwAVJtb
	WQw0ICdVDyquV5yal+KQlV8KcqZecWJucWleul5yfq6SQlliTinQCCX9hG+MGX/bJrAU3Fap
	OD5VvIFxgkwXIyeHhICJxL6eaexdjFwcQgJ7GCWmr/jDDOF8YpR48nsvK4TzjVHixrWzTDAt
	Cz/MZIFI7GWU2Hn1PSOE85JRYkvnHjaQKjYBXYknN34yg9giAhES9zsbgIo4OJgFlCVWfgkG
	CXMKWEj8vnMArERYwE3i9f2NYAtYBFQl5uxvZQWxeQWsJJ7O+MIMYQtKnJz5hAXEZhaQl9j+
	dg4zxEEKErs/HWWFWGUlcXHaBiaIGhGJ2Z1tYO9ICPxkl/g2+xsbRIOLRPeXE4wQtrDEq+Nb
	2CFsKYnP7/ayQTR0M0oc//iOBSIxg1FiSYcDhG0v0dzazAbxjKbE+l36EGFFiZ2/5zJCLOaT
	ePe1hxUiLihx+lo3M0i5hACvREebEERYReL7h50sExiVZyF5bRaS12YheWEWwrIFjCyrGKVS
	C4pz01OTDQsMdfNSy5HjfBMjOJ1q+exg/L7+r94hRiYOxkOMEhzMSiK8MkeKU4V4UxIrq1KL
	8uOLSnNSiw8xJgMDfCKzlGhyPjCh55XEG5qZWVpYGpkYGpsZGhIWNrE0MDEzMrEwtjQ2UxLn
	PXOlLFVIID2xJDU7NbUgtQhmCxMHp1QDk/b8jnLjVdN+XJEoyttjFy7/MHyuj3zlyjiDa1VN
	/cYe6tEXCzv1zgXLp/yvEWw5n/1Z8J/3p+AptRu5Vz+8Kl+V1zFpdcXbQyYT595+5iT9U0eA
	Q98lO9r0R4vQvGmHY61/f1IN+7HM8sjh/y3PA7ovrohaP3XOvv8Pl206NdHb41i5hN0jrYqp
	d9gZmT7bR6+yuKnQb5BjIurU/u3Z+8rmdXoPRS9MuHAx2uZWvcOhyy/ndXDde6XNf4tZb//p
	6LTK+FDz66pynLunxmWaHmW+f9rr0CYhB6dwCemNMlEhkw5PFclUyj36uSxc45i9fPfe7R6L
	N4XpsUpJqk8sa3mbwBUgdV7Spq9RRum3EktxRqKhFnNRcSIA72n/4V4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSnK7rlvJUg64eVYuJ05YyW+zZe5LF
	4kj7EnaL3z/msDmweOycdZfdY/MKLY9NqzrZPD5vkgtgieKySUnNySxLLdK3S+DK+Ns2gaXg
	tkrF8aniDYwTZLoYOTkkBEwkFn6YydLFyMUhJLCbUeLHy0dsXYwcQAkpiYP7NCFMYYnDh4sh
	Sp4zSvTtbmYD6WUT0JV4cuMnM4gtIhAlse1IP1grs4CyxMovwRD1nYwSW6esZwep4RSwkPh9
	5wBYvbCAm8Tr+xuZQGwWAVWJOftbWUFsXgEriaczvjBD2IISJ2c+YYGYqSfRtpERJMwsIC+x
	/e0cZojzFSR2fzrKCnGClcTFaRuYIGpEJGZ3tjFPYBSehWTSLIRJs5BMmoWkYwEjyypGydSC
	4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjODY0NLcwbh91Qe9Q4xMHIyHGCU4mJVEeGWOFKcK
	8aYkVlalFuXHF5XmpBYfYpTmYFES5xV/0ZsiJJCeWJKanZpakFoEk2Xi4JRqYIp3aZmtJvTa
	Tb5D49CbpoSSZ2vbtl6ZYja/s8BqfYpARymzpOrJiWe0u6smLzvRONOCycTE6XfJaUu5wkof
	yTcusrNn2h749TQjdp1Yz7Kr5zd0Xjhtdrd7WsG8T2onpoaXLp/nXh9lmPj/6LH/V7w7cmW/
	smleUnBkv8hU3fflDBdn6PyTl1WldwpGSCvk89yUspX5rBeuEpytUKPTw/nC3Tzk1Lbm94EL
	Y4Ov3Hi6f57bnpX1/MfmlnR8ev1OWr5T7taUabcsgzd6d/Punrir62KKJ6Nv1JOXMjYdRwpL
	/t+f80MvOOraycO87it3Ju48cXftyf/mF9Zcztkd8WQn88/bXcuZGf8X313M80KJpTgj0VCL
	uag4EQAJ/gx1/AIAAA==
X-CMS-MailID: 20231212011549epcas1p367428782c92cdf677bf1564c66bb07e3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231209203819epcas1p469c0aecdc6a27fff7895a93ed5f3c4ec
References: <CGME20231209203819epcas1p469c0aecdc6a27fff7895a93ed5f3c4ec@epcas1p4.samsung.com>
	<20231207234701.566133-1-sanpeqf@gmail.com>

> Replaced the internal table lookup algorithm with ffs of the bitops
> library with better performance.
> 
> Use it to increase the single processing length of the
> exfat_find_free_bitmap function, from single-byte search to long type.
> 
> Signed-off-by: John Sanpe <sanpeqf@gmail.com>

Looks good. Thanks for your patch.
Acked-by: Sungjong Seo <sj1557.seo@samsung.com>

> ---
>  fs/exfat/balloc.c   | 41 +++++++++++++++--------------------------
>  fs/exfat/exfat_fs.h |  3 +--
>  2 files changed, 16 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c index
> 3e3e9e4cce2f..4bacbb0cf5da 100644
> --- a/fs/exfat/balloc.c
> +++ b/fs/exfat/balloc.c
> @@ -14,29 +14,15 @@
>  #if BITS_PER_LONG == 32
>  #define __le_long __le32
>  #define lel_to_cpu(A) le32_to_cpu(A)
> +#define cpu_to_lel(A) cpu_to_le32(A)
>  #elif BITS_PER_LONG == 64
>  #define __le_long __le64
>  #define lel_to_cpu(A) le64_to_cpu(A)
> +#define cpu_to_lel(A) cpu_to_le64(A)
>  #else
>  #error "BITS_PER_LONG not 32 or 64"
>  #endif
> 
> -static const unsigned char free_bit[] = {
> -	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2,/*  0 ~
> 19*/
> -	0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 5, 0, 1, 0, 2, 0, 1, 0, 3,/* 20 ~
> 39*/
> -	0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2,/* 40 ~
> 59*/
> -	0, 1, 0, 6, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4,/* 60 ~
> 79*/
> -	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 5, 0, 1, 0, 2,/* 80 ~
> 99*/
> -	0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3,/*100 ~
> 119*/
> -	0, 1, 0, 2, 0, 1, 0, 7, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2,/*120 ~
> 139*/
> -	0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 5,/*140 ~
> 159*/
> -	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2,/*160 ~
> 179*/
> -	0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 6, 0, 1, 0, 2, 0, 1, 0, 3,/*180 ~
> 199*/
> -	0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2,/*200 ~
> 219*/
> -	0, 1, 0, 5, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4,/*220 ~
> 239*/
> -	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0                /*240 ~
> 254*/
> -};
> -
>  /*
>   *  Allocation Bitmap Management Functions
>   */
> @@ -195,32 +181,35 @@ unsigned int exfat_find_free_bitmap(struct
> super_block *sb, unsigned int clu)  {
>  	unsigned int i, map_i, map_b, ent_idx;
>  	unsigned int clu_base, clu_free;
> -	unsigned char k, clu_mask;
> +	unsigned long clu_bits, clu_mask;
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	__le_long bitval;
> 
>  	WARN_ON(clu < EXFAT_FIRST_CLUSTER);
> -	ent_idx = CLUSTER_TO_BITMAP_ENT(clu);
> -	clu_base = BITMAP_ENT_TO_CLUSTER(ent_idx & ~(BITS_PER_BYTE_MASK));
> +	ent_idx = ALIGN_DOWN(CLUSTER_TO_BITMAP_ENT(clu), BITS_PER_LONG);
> +	clu_base = BITMAP_ENT_TO_CLUSTER(ent_idx);
>  	clu_mask = IGNORED_BITS_REMAINED(clu, clu_base);
> 
>  	map_i = BITMAP_OFFSET_SECTOR_INDEX(sb, ent_idx);
>  	map_b = BITMAP_OFFSET_BYTE_IN_SECTOR(sb, ent_idx);
> 
>  	for (i = EXFAT_FIRST_CLUSTER; i < sbi->num_clusters;
> -	     i += BITS_PER_BYTE) {
> -		k = *(sbi->vol_amap[map_i]->b_data + map_b);
> +	     i += BITS_PER_LONG) {
> +		bitval = *(__le_long *)(sbi->vol_amap[map_i]->b_data +
> map_b);
>  		if (clu_mask > 0) {
> -			k |= clu_mask;
> +			bitval |= cpu_to_lel(clu_mask);
>  			clu_mask = 0;
>  		}
> -		if (k < 0xFF) {
> -			clu_free = clu_base + free_bit[k];
> +		if (bitval != ULONG_MAX) {
> +			clu_bits = lel_to_cpu(bitval);
> +			clu_free = clu_base + ffz(clu_bits);
>  			if (clu_free < sbi->num_clusters)
>  				return clu_free;
>  		}
> -		clu_base += BITS_PER_BYTE;
> +		clu_base += BITS_PER_LONG;
> +		map_b += sizeof(long);
> 
> -		if (++map_b >= sb->s_blocksize ||
> +		if (map_b >= sb->s_blocksize ||
>  		    clu_base >= sbi->num_clusters) {
>  			if (++map_i >= sbi->map_sectors) {
>  				clu_base = EXFAT_FIRST_CLUSTER;
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h index
> a7a2c35d74fb..8030780a199b 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -135,8 +135,7 @@ enum {
>  #define BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent) (ent &
> BITS_PER_SECTOR_MASK(sb))  #define BITMAP_OFFSET_BYTE_IN_SECTOR(sb, ent) \
>  	((ent / BITS_PER_BYTE) & ((sb)->s_blocksize - 1))
> -#define BITS_PER_BYTE_MASK	0x7
> -#define IGNORED_BITS_REMAINED(clu, clu_base) ((1 << ((clu) - (clu_base)))
> - 1)
> +#define IGNORED_BITS_REMAINED(clu, clu_base) ((1UL << ((clu) -
> +(clu_base))) - 1)
> 
>  #define ES_ENTRY_NUM(name_len)	(ES_IDX_LAST_FILENAME(name_len) + 1)
>  /* 19 entries = 1 file entry + 1 stream entry + 17 filename entries */
> --
> 2.43.0



