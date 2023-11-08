Return-Path: <linux-fsdevel+bounces-2395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF877E59E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 16:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583A7281484
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 15:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B46D30341;
	Wed,  8 Nov 2023 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SaDI8fKk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D9630333
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 15:17:47 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE341991
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 07:17:46 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231108151745euoutp023774b407991ff2c054504e4281af90b4~VrtUwV_k70847708477euoutp02f
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 15:17:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231108151745euoutp023774b407991ff2c054504e4281af90b4~VrtUwV_k70847708477euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1699456665;
	bh=CWM2/PR29WI4BU8PMbzFa7tHV4ws686nuD4G3Ms/niQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=SaDI8fKkSAZtBY//bRgS+Xrh6O3CSXfbGYoZOpCT5dxn8tjr0GUeyBKfdX9l9aNtw
	 kywZXxE/m+cnLyDzFfUQa9hpMwcxRRIojsyiqkmqRdD62ORSU62h0u5uxdUpEP6eyd
	 BmLVpLCFZGj6IZ9IcO5l3F0xtcWynZsPHf/KoyX4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231108151744eucas1p1ac0e2931bf373c55b122ae1022979f00~VrtUhISHi0618306183eucas1p1S;
	Wed,  8 Nov 2023 15:17:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 9F.94.11320.896AB456; Wed,  8
	Nov 2023 15:17:44 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231108151744eucas1p229d2073ae889eb95caed90b1f83821c3~VrtT-eDxw1167011670eucas1p2l;
	Wed,  8 Nov 2023 15:17:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231108151744eusmtrp2b4bce7395cd6fb9b5447d56a18b63d65~VrtT4RPV31279812798eusmtrp2B;
	Wed,  8 Nov 2023 15:17:44 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-28-654ba6989686
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id CC.C8.10549.796AB456; Wed,  8
	Nov 2023 15:17:43 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231108151743eusmtip1dde324c720cb47fc83c958904af08c84~VrtS3Tcbv2704427044eusmtip1t;
	Wed,  8 Nov 2023 15:17:43 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 8 Nov 2023 15:17:41 +0000
Date: Wed, 8 Nov 2023 16:17:40 +0100
From: Pankaj Raghav <p.raghav@samsung.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Hannes Reinecke
	<hare@suse.de>, Luis Chamberlain <mcgrof@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <p.raghav@samsung.com>
Subject: Re: [PATCH 5/5] buffer: Fix various functions for block size >
 PAGE_SIZE
Message-ID: <20231108151740.emlp6tvumdloxmbd@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231107194152.3374087-6-willy@infradead.org>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa1BMYRjH5z3ndPa0bHNs4bFRbDZKEpqxZMhtLPWBcfkgZOktpu1iL65j
	JDFqXKJs2RobyYaodsk2XbCEbIqssdWMkVHRMINdlChtx+3b//k/v+d9nv/My5DCQ24iZlui
	GisT5Qoxzacq7vc2Ts29GIFDmtqmSPNLS2hp9flThLS6pp6S2jM7kLSvJ58Od5OZigNlxsvp
	tOxhbh8lM1n3yhxGnxVu6/hzY7Bi2w6snDZvE3+r8ZEFJd/l7WptKKdSUBadgdwZYEOhvew5
	kYH4jJAtRvDFlkVyhROBRdvM4woHgvQuLfozYkzrQVzDgKDfXIf+Up3P7BRXmBAM1PXyXCMU
	OxHeOusGH2YYmg2EA+lDthc7E04abtEunmTLEHwfKOe5GE92FeSdXOhiBOwsaP9US3B6BNSf
	eUO5NMkGQUHVZ9qFk6w3GPoZl+3OhkGX7SzJHSqGFFMDxel9UHPw9lAaYO0M6HPeuHGNxWD/
	+fU35AndD67zOD0WBir1BKf3Qoe9j+SG0xCcqCwdWgyD2443KDhmAbT/eE1ytgfYP4zgzvSA
	UxU5v20BHDks5Gh/uPLyPZWJ/HT/BdP9F0z3L1gBIi+j0VijSojDqhmJeGewSp6g0iTGBW9J
	SjCiwZ9i7X/gNCND96dgCyIYZEHAkGIvwc/5MiwUxMh378HKpGilRoFVFuTNUOLRAkmMLxay
	cXI1jsc4GSv/dAnGXZRCmEMuhVXE5vUcbT5WZXZajhQWraoO5fv6NJrH8Qre56N0bBtzp1h3
	QF20/WNaRlBS5DWLtiZgjna5uaPyacj8Yf4lGyaVx3S2pjZHHtonke2/67Agx6wlLZs9bybH
	SlKt/qkF2VNe9o57JxQN7Apr+uLXEXV14w7Fylqb5tlaj1qRY646fqrT1PiNnVceYLRN0NfX
	Tj/xKvN0lfXrhNX1tnOx0fqW8QE5TffI9bO7WR29OWpRS4m2NEj2xCDYrVka/+IHVUFkX18W
	FXHsEaUuvK0LfzoZFd+xDpdQ+FbWSELbrBdFd0oyTUVVoy4YFvm0ec/OvtHWtUbv2fo4lJcj
	FVOqrfLpgaRSJf8FIjWSN5gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xu7rTl3mnGtx7bWkxZ/0aNos9iyYx
	WezZe5LF4saEp4wWv3/MYXNg9di8Qstj06pONo8TM36zeGw+Xe3xeZNcAGuUnk1RfmlJqkJG
	fnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsamU4cYCw6zV9w6s5Gl
	gXEyWxcjJ4eEgInEppYfjF2MXBxCAksZJRoObWaGSMhIbPxylRXCFpb4c62LDaLoI6PExO0d
	LCAJIYHNjBJLdmqC2CwCKhIvvhwFaubgYBPQkmjsZAcJiwgYS0xcvh+sl1lgA6PE8e+3WEFq
	hAWCJWZPdAKp4RUwl3j4cR8TxMhsiUNX17JAxAUlTs58AmYzC+hILNj9iQ2klVlAWmL5Pw6Q
	MKeAtcTzK/OgTlaSaNh8hgXCrpXofHWabQKj8Cwkk2YhmTQLYdICRuZVjCKppcW56bnFhnrF
	ibnFpXnpesn5uZsYgXG17djPzTsY5736qHeIkYmD8RCjBAezkgjvX3uPVCHelMTKqtSi/Pii
	0pzU4kOMpsCAmMgsJZqcD4zsvJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKY
	PiYOTqkGpkl7mLdGTOwrZl0g9+DEZ+ZPYs/e1hjLPlWddZGpVvujVNrSav+ivilz58if+tn1
	6FVaSBvf3/g7UdJ7C/gP3S17+0OjtqW3/W+WXKrPzsLJax3WvHmxJMDt8/L+Kq8gh9wvrW8m
	ztvt/s9BcM6bnHnmiXbrau827VnqKBzfx7bwuJiEW/+8hTOcG96o2zOu+D1j0eFf5gUcFrse
	/9j6aB2Lo+fpD8pLLp1bWMmi4DT70+sdj7v5T3ZKb1djvCipXHam5tiMvbuv7vJ4cUd/Z3ym
	Qf+X2fEzjHUvlKnq5LSdc2Izkk6dtOvNxOtN7Y7/4w/6Xo1/pRnzvGaX+8UtC7dePx1tXT1X
	94GjsF9FyVklluKMREMt5qLiRAA6YapJNAMAAA==
X-CMS-MailID: 20231108151744eucas1p229d2073ae889eb95caed90b1f83821c3
X-Msg-Generator: CA
X-RootMTR: 20231108151744eucas1p229d2073ae889eb95caed90b1f83821c3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231108151744eucas1p229d2073ae889eb95caed90b1f83821c3
References: <20231107194152.3374087-1-willy@infradead.org>
	<20231107194152.3374087-6-willy@infradead.org>
	<CGME20231108151744eucas1p229d2073ae889eb95caed90b1f83821c3@eucas1p2.samsung.com>

On Tue, Nov 07, 2023 at 07:41:52PM +0000, Matthew Wilcox (Oracle) wrote:
> If i_blkbits is larger than PAGE_SHIFT, we shift by a negative number,
> which is undefined.  It is safe to shift the block left as a block
> device must be smaller than MAX_LFS_FILESIZE, which is guaranteed to
> fit in loff_t.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

> ---
>  fs/buffer.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 2f08af3c47a2..5bdfcf8c6fe6 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -199,7 +199,7 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
>  	int all_mapped = 1;
>  	static DEFINE_RATELIMIT_STATE(last_warned, HZ, 1);
>  
> -	index = block >> (PAGE_SHIFT - bd_inode->i_blkbits);
> +	index = ((loff_t)block << bd_inode->i_blkbits) / PAGE_SIZE;

