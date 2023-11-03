Return-Path: <linux-fsdevel+bounces-1896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 189027DFE92
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 05:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B2E281D9C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 04:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CBB17D4;
	Fri,  3 Nov 2023 04:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RbDVU+ev"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB672D600
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 04:40:11 +0000 (UTC)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF78A1A1
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 21:40:06 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231103044002epoutp020b63de96a81b69f6994e0c8fef2446be~UAyG96NIS2908029080epoutp02D
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 04:40:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231103044002epoutp020b63de96a81b69f6994e0c8fef2446be~UAyG96NIS2908029080epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698986402;
	bh=+o3JZVG7m0Uc2NPlnJg9mEFZSsW6OaBiaMi5m2nZT9c=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=RbDVU+ev3NK3h4LkIHh/S3buc1NeOOBWc6h5iApBt9bqzI8SyGEk2DapXCTqc2+nf
	 MvHGAQIGpPPAFOdmOPR7XVg+0Du5/LUKcqMhVrYKc7MUDla3CctPCnJAziIpep/GTA
	 3OuA4IFWvYyzg3D8k58EaDl2n1xdQPiCjXpF9m7w=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20231103044002epcas1p35cf8b22ac9d8ef408ee558f25de14265~UAyGmNyvk1227712277epcas1p32;
	Fri,  3 Nov 2023 04:40:02 +0000 (GMT)
Received: from epcpadp3 (unknown [182.195.40.17]) by epsnrtp2.localdomain
	(Postfix) with ESMTP id 4SM7MQ3BNgz4x9QB; Fri,  3 Nov 2023 04:40:02 +0000
	(GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20231103043523epcas1p4d1ac625ab3386e88c7d06b68790283df~UAuC5te0S1975919759epcas1p4c;
	Fri,  3 Nov 2023 04:35:23 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231103043523epsmtrp2a83740c02ff3411134a620e9da3dfc49~UAuC4zIjE0154001540epsmtrp2J;
	Fri,  3 Nov 2023 04:35:23 +0000 (GMT)
X-AuditID: b6c32a2a-403fa70000002271-9e-6544788b60d5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5F.55.08817.B8874456; Fri,  3 Nov 2023 13:35:23 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20231103043523epsmtip18794b46675171d2c6a76a64816e58bc4~UAuCnkbYj0726207262epsmtip13;
	Fri,  3 Nov 2023 04:35:23 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: <Yuezhang.Mo@sony.com>, <linkinjeon@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <Andy.Wu@sony.com>,
	<Wataru.Aoyama@sony.com>, <jlayton@kernel.com>
In-Reply-To: <PUZPR04MB63168C9C4A8EE4321AC575AA81A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v1 0/2] exfat: bugfix for timespec update
Date: Fri, 3 Nov 2023 13:35:23 +0900
Message-ID: <1891546521.01698986402427.JavaMail.epsvc@epcpadp3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQK5RxYHki+nLewzbIocPyf1i0NlxQKms4ldrpQjMnA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJTre7wiXVYOosWYvWI/sYLV4e0rSY
	NN/SYuK0pcwWe/aeZLHY8u8Iq8XHB7sZLa6/ecjqwOFxrG8fs8emVZ1sHn1bVjF6tE/Yyezx
	eZNcAGsUl01Kak5mWWqRvl0CV8bx699YCyayVNxb8IatgXEOcxcjB4eEgInEgk0FXYxcHEIC
	uxkl/i78wwQRl5I4uE8TwhSWOHy4GKLkOaPEucVzgVo5OdgEdCWe3PgJZosImEp8uXyCDcRm
	FsiV2DbrNCtEwzpGie5F51lAEpwCsRJ/H89hARkqLGArsfWPGEiYRUBF4vvWo+wgNq+ApcS5
	m7PZIGxBiZMzn7BAzNSWeHrzKZQtL7H97RywvRICChK7Px1lhbjBSmL55S9QN4hIzO5sY57A
	KDwLyahZSEbNQjJqFpKWBYwsqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxguNJS2sH
	455VH/QOMTJxMB5ilOBgVhLhdfR2SRXiTUmsrEotyo8vKs1JLT7EKM3BoiTO++11b4qQQHpi
	SWp2ampBahFMlomDU6qBqVhLmpPdM+H6sXmuhTNtXls8lW14aOhlYrjnttq9Q2zsqj4htxKW
	rWzJnrLC+Cq/55w6iX1PtA0NP76V1Lwqve9JQ4bzwbkPj9snrDC3X87+44DsN8U/Bzd8+nZr
	hvHZuB8it1fWT677ef6G850nH44bvfBLWqIl5DTLYt+TzJOXov7++uQ067DWuX3nXnZFbnBr
	TLpsP1VwW4PCHsadXEva/D0jFr2cXp4kdeA7+zG93wvCayzWd/gdKHDafzO/bPXkhENqaZvv
	s32bMe+PnxVftNYVscOl7G0ls7Pul/6Tslk4bXqHMPNhT5PiBN+105y/BcdwZG3LyHMv3TCD
	dcXvA8m7b/952FIy6Xvg5lglluKMREMt5qLiRADpXRQJFgMAAA==
X-CMS-MailID: 20231103043523epcas1p4d1ac625ab3386e88c7d06b68790283df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
X-Hop-Count: 3
X-CMS-RootMailID: 20231102061033epcas1p2080c6a5b43272c57f85e056f8222ea51
References: <CGME20231102061033epcas1p2080c6a5b43272c57f85e056f8222ea51@epcas1p2.samsung.com>
	<PUZPR04MB63168C9C4A8EE4321AC575AA81A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>

> These patches aim to fix the bugs which caused by commit
> (4c72a36edd54 exfat: convert to new timestamp accessors).
> 
> The bugs cause xfstests generic/003 generic/192 generic/221 to fail.
> 
> Yuezhang Mo (2):
>   exfat: fix setting uninitialized time to ctime/atime
>   exfat: fix ctime is not updated
> 
>  fs/exfat/file.c  | 1 +
>  fs/exfat/inode.c | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)

Looks good. Thanks.

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> 
> --
> 2.25.1



