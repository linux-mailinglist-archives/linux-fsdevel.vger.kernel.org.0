Return-Path: <linux-fsdevel+bounces-1537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAC87DB8CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 12:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6487EB20DAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 11:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7317C12E62;
	Mon, 30 Oct 2023 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jhZdaYZG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603F312E50
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 11:11:41 +0000 (UTC)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A13410B
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 04:11:37 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231030111132epoutp02301309e9bbed5a5f711e6937e69c6262~S3iyQoOfq2123221232epoutp02N
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 11:11:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231030111132epoutp02301309e9bbed5a5f711e6937e69c6262~S3iyQoOfq2123221232epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698664292;
	bh=7VgBKkAPdjWhT/D+3UxDJWnw+6WlkN0o3go1r7Z74rY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=jhZdaYZGT/ZieW+IdffcxcrbDTRFDCgrPYrZ8vQk4fnmX0zRYraL5PqvLo/L+YomC
	 lK2VBQosF71Evw5cvcjjAFpWsHRLxQr5/3Z3L63gayRiI57svrOPWEddjfrPYH7GK/
	 ckxDqaYTEur49b+dbmqLPmY5a9AwqG+VXWoyD8NQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231030111131epcas5p24ab3bcb7a9d00a674bc3977d2d34cdb8~S3ixvETKW2293122931epcas5p2R;
	Mon, 30 Oct 2023 11:11:31 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SJrDy0w3Cz4x9Pw; Mon, 30 Oct
	2023 11:11:30 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A0.30.19369.16F8F356; Mon, 30 Oct 2023 20:11:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20231030111129epcas5p33338b15a13d3f02552431e4be4c0afef~S3ivlJXuj2864328643epcas5p3w;
	Mon, 30 Oct 2023 11:11:29 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231030111129epsmtrp203a7b28a6d0bca80062b2e61519976a7~S3ivkY7Y52250622506epsmtrp2M;
	Mon, 30 Oct 2023 11:11:29 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-b1-653f8f612fed
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C2.C2.07368.16F8F356; Mon, 30 Oct 2023 20:11:29 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231030111126epsmtip2190349433dd0e9f27d1f509d7de7bd1f~S3itE2NN_1266612666epsmtip2a;
	Mon, 30 Oct 2023 11:11:26 +0000 (GMT)
Message-ID: <b3058ce6-e297-b4c3-71d4-4b76f76439ba@samsung.com>
Date: Mon, 30 Oct 2023 16:41:25 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v3 01/14] fs: Move enum rw_hint into a new header file
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, "Martin K . Petersen"
	<martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>, Niklas Cassel
	<Niklas.Cassel@wdc.com>, Avri Altman <Avri.Altman@wdc.com>, Bean Huo
	<huobean@gmail.com>, Daejun Park <daejun7.park@samsung.com>, Jan Kara
	<jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Jaegeuk Kim
	<jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20231017204739.3409052-2-bvanassche@acm.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xbVRzeube0F0zxrmXpSTWT3YQY6sqotHghZfgg8w4Wxc1kj2TAhd4A
	oa/ctm5goo3beGYD5h5SOkBFGLAA1k0eA0Ueko7BENaYoWwgZQ8niINhGNDZcpnjv+/3ne+X
	73y/3zkYKprhS7FMvZlh9bSW4Afwvu8JDZXTxbFM+GyZmnyw5OKTDePFfPJhzyNAnptbQsmB
	s4MI+XT8HkLWT+wn6xr6ENI+aEXI8vPHENLdZEPJpZp6Adk59hrZ0enkkUW/tvLJ2n4PQk6s
	TAnIG6v9fm+KqNGbCVSbbVxAjQ5aKEd9AZ+6esvKp/6ZHuNRpy7XA+p6Va+AmndspfK6ihDK
	4Z5BEl84lKXOYGgNwwYz+jSDJlOfHkMk7Et+J1kVGa6QK6LIN4hgPa1jYoi4PYnyXZlaby4i
	+CNaa/FSibTJROzYqWYNFjMTnGEwmWMIxqjRGpXGMBOtM1n06WF6xhytCA9/XeUVpmRl2Fay
	jVObj9ZMFKFWUBtYCPwxiCthz1A1rxAEYCK8A8A5eynKFY8AbOia9+OKRQDzB1d4z1rGzrQI
	uINOAL+7VrmumgHwdt9FP59KiO+En7U51jp4eAh0NxagHL8ZOsvca/wWPBU+cdmBD4vxeHj/
	+Ok1DYpL4Ji7EvHhIHwXtLra+T4DFP+BB4uv3PNaYxgfD4XDn1t8Gn88GnpcJYDrfQW2zNjX
	MkD8KQanPT1+3LXj4PD8H4DDYvhn/2UBh6VwfraTz+E0OFI2hHDYDKc6flrHsfDEtWLU54t6
	fZvad3BegfDkshvx0RAXwvxcEafeBm+fnl53lcDJL6rXMQXP3Gl/Pjin04OUgGDbhrHYNsS3
	bYhje+5cBXj1QMoYTbp0Jk1lVMj1zJH/N55m0DnA2ruXJbaChubVsG6AYKAbQAwlgoToW2pG
	JNTQ2TkMa0hmLVrG1A1U3gWVotItaQbvx9GbkxXKqHBlZGSkMioiUkFIhA9PXNCI8HTazGQx
	jJFhn/UhmL/UioDh3rzt7RclGmVjoTa740u20j3ntzCytdxx50LcgFXeRpcebqHOOx8HfLy6
	W/ZSSnpob+/X5V12JxH348nl7pFiscvySXxds2JbdF5BxIHFdyWbpiqSG4aaomxxR0JfzEl6
	kFQbEpVT823sgP1uxXTF0DHV3vyDc8340pO/DvTg92fUrUWp/v8GfMDOVnxqkL4fn6I5G6a7
	FfjzJvml6t/hypUKS8RhRJqykFq3r3x5u3hBdzfIlfRV2dHjixpZrWTy5RuHfntVptorexuz
	7i6nv6m6rl1MEA9+mOt8L8RjLmysOtU3emlUftXF3jyXxP5S4uYdFJrVk6t7kvbTj//O7SV4
	pgxaIUNZE/0fiIykKIAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsWy7bCSvG5iv32qwcsmKYuXP6+yWay+289m
	8frwJ0aLaR9+MlucnnqWyeL/3edMFqsehFusXH2UyWLO2QYmi9nTm5ksnqyfxWzxc9kqdou9
	t7Qt9uw9yWLRfX0Hm8Xy4/+YLB78ecxucf7vcVYHIY/LV7w9ds66y+5x+Wypx6ZVnWweu282
	sHl8fHqLxaNvyypGjzMLjrB7fN4k59F+oJvJY9OTt0wB3FFcNimpOZllqUX6dglcGbP+VBY8
	FqxY9qCbuYFxOV8XIyeHhICJxK0p29m7GLk4hAR2M0r0/X7IDpEQl2i+9gPKFpZY+e85VNFr
	Rok/qxeBJXgF7CSadm5iAbFZBFQlnqzrZIaIC0qcnPkELC4qkCSx534jE4gtLOAl8aJlElgN
	M9CCW0/mg8VFBNwkGq7uYgNZwCywj0Wi5ccOZohtexklTvx4AVTFwcEmoClxYXIpSAOngJXE
	v6sTGCEGmUl0be2CsuUltr+dwzyBUWgWkjtmIdk3C0nLLCQtCxhZVjFKphYU56bnJhsWGOal
	lusVJ+YWl+al6yXn525iBEe2lsYOxnvz/+kdYmTiYDzEKMHBrCTCy+xokyrEm5JYWZValB9f
	VJqTWnyIUZqDRUmc13DG7BQhgfTEktTs1NSC1CKYLBMHp1QDE8v++NBbd3c4/HHfIie/Z/Ks
	xk2pLEl5Ucae0pNfN4b93vfcuTtPUyubwYpHWuO6plsSw3xnJansv7WLV0rIXLX/dl7KX17P
	6EtKPYP5Zz8bzcVWUU/nSCrI+a5S7bdZs/eV/DIVY4PmNjVLm5qON4ef+bUrz2pc8PlKWw3v
	qcSlc+Va2y672m1cXHTtWOLFplbpq0uW3z0W8PjDHqEvTJ+TDCzl26c/qhN87FIolLTEhLPx
	oUbMoUCXtn1n3CwZCxZuE30qFdhazzUn8jzLwuqC6NppVdUyGwvaqtliArfOucDyPUyMMZPF
	bplovuWbrCWPLSy2Xnd0l5m6IVn21URVk/pDRg+Mbz4XSlJiKc5INNRiLipOBAAPh7zxWwMA
	AA==
X-CMS-MailID: 20231030111129epcas5p33338b15a13d3f02552431e4be4c0afef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231017204823epcas5p2798d17757d381aaf7ad4dd235f3f0da3
References: <20231017204739.3409052-1-bvanassche@acm.org>
	<CGME20231017204823epcas5p2798d17757d381aaf7ad4dd235f3f0da3@epcas5p2.samsung.com>
	<20231017204739.3409052-2-bvanassche@acm.org>

On 10/18/2023 2:17 AM, Bart Van Assche wrote:
> - * Write life time hint values.
> - * Stored in struct inode as u8.
> - */
> -enum rw_hint {
> -	WRITE_LIFE_NOT_SET	= 0,
> -	WRITE_LIFE_NONE		= RWH_WRITE_LIFE_NONE,
> -	WRITE_LIFE_SHORT	= RWH_WRITE_LIFE_SHORT,
> -	WRITE_LIFE_MEDIUM	= RWH_WRITE_LIFE_MEDIUM,
> -	WRITE_LIFE_LONG		= RWH_WRITE_LIFE_LONG,
> -	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
> -};
> -
>   /* Match RWF_* bits to IOCB bits */
>   #define IOCB_HIPRI		(__force int) RWF_HIPRI
>   #define IOCB_DSYNC		(__force int) RWF_DSYNC
> @@ -677,7 +665,7 @@ struct inode {
>   	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
>   	unsigned short          i_bytes;
>   	u8			i_blkbits;
> -	u8			i_write_hint;
> +	enum rw_hint		i_write_hint;
>   	blkcnt_t		i_blocks;
>   
>   #ifdef __NEED_I_SIZE_ORDERED
> diff --git a/include/linux/rw_hint.h b/include/linux/rw_hint.h
> new file mode 100644
> index 000000000000..4a7d28945973
> --- /dev/null
> +++ b/include/linux/rw_hint.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_RW_HINT_H
> +#define _LINUX_RW_HINT_H
> +
> +#include <linux/build_bug.h>
> +#include <linux/compiler_attributes.h>
> +
> +/* Block storage write lifetime hint values. */
> +enum rw_hint {
> +	WRITE_LIFE_NOT_SET	= 0, /* RWH_WRITE_LIFE_NOT_SET */
> +	WRITE_LIFE_NONE		= 1, /* RWH_WRITE_LIFE_NONE */
> +	WRITE_LIFE_SHORT	= 2, /* RWH_WRITE_LIFE_SHORT */
> +	WRITE_LIFE_MEDIUM	= 3, /* RWH_WRITE_LIFE_MEDIUM */
> +	WRITE_LIFE_LONG		= 4, /* RWH_WRITE_LIFE_LONG */
> +	WRITE_LIFE_EXTREME	= 5, /* RWH_WRITE_LIFE_EXTREME */
> +} __packed;
> +
> +static_assert(sizeof(enum rw_hint) == 1);

Does it make sense to do away with these, and have temperature-neutral 
names instead e.g., WRITE_LIFE_1, WRITE_LIFE_2?

With the current choice:
- If the count goes up (beyond 5 hints), infra can scale fine but these 
names do not. Imagine ULTRA_EXTREME after EXTREME.
- Applications or in-kernel users can specify LONG hint with data that 
actually has a SHORT lifetime. Nothing really ensures that LONG is 
really LONG.

Temperature-neutral names seem more generic/scalable and do not present 
the unnecessary need to be accurate with relative temperatures.

