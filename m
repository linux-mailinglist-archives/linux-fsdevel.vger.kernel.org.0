Return-Path: <linux-fsdevel+bounces-1501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AB77DA988
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 23:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B755FB21673
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 21:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9B619447;
	Sat, 28 Oct 2023 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ug90+BkE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBFF18C29
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 21:15:59 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7484A1A7
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 14:15:55 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231028211553euoutp01523bf614ef78c3baef69285999bfa26d~SYf4LA-Vi2292822928euoutp01g
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 21:15:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231028211553euoutp01523bf614ef78c3baef69285999bfa26d~SYf4LA-Vi2292822928euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698527753;
	bh=V58CpUMglUVRv2d2n4PjwOPxGbR6MAVB1lgi43BKbik=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=Ug90+BkEzSkTyQzxO6IX69s40XfH1kin4j5qyV0qRip82QwCoST7VXdZhGtirfp/C
	 eCUwW7HRdmW9RoJGBubVMRkje6dh2LhFr2aY5RD5wPKF7i+0tilH+Z95hxaUGhQlqG
	 PwLLloFWfV3YsuaTmdl68/3RahrJys8XbK1q3o3E=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231028211552eucas1p2368f287afd825b44877b59399542f661~SYf3yR5P21087910879eucas1p2Q;
	Sat, 28 Oct 2023 21:15:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id A3.20.11320.80A7D356; Sat, 28
	Oct 2023 22:15:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231028211551eucas1p1552b7695f12c27f4ea1b92ecb6259b31~SYf3Amogw0616106161eucas1p1Y;
	Sat, 28 Oct 2023 21:15:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231028211551eusmtrp166725da83a27a1657bdc91947630f5f0~SYf3AFyW50755507555eusmtrp1e;
	Sat, 28 Oct 2023 21:15:51 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-94-653d7a08c743
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 04.52.10549.70A7D356; Sat, 28
	Oct 2023 22:15:51 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231028211551eusmtip146fad08e90fd824bcd219c14210d9955~SYf206cR30467404674eusmtip1U;
	Sat, 28 Oct 2023 21:15:51 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Sat, 28 Oct 2023 22:15:51 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Sat, 28 Oct
	2023 22:15:51 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: "minchan@kernel.org" <minchan@kernel.org>, "senozhatsky@chromium.org"
	<senozhatsky@chromium.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"djwong@kernel.org" <djwong@kernel.org>, "willy@infradead.org"
	<willy@infradead.org>, "hughd@google.com" <hughd@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mcgrof@kernel.org"
	<mcgrof@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
CC: "gost.dev@samsung.com" <gost.dev@samsung.com>, Pankaj Raghav
	<p.raghav@samsung.com>, Daniel Gomez <da.gomez@samsung.com>
Subject: [RFC PATCH 10/11] shmem: add large folio support to the write path
Thread-Topic: [RFC PATCH 10/11] shmem: add large folio support to the write
	path
Thread-Index: AQHaCePt75l+dUBUfkS9wehNfGwv9w==
Date: Sat, 28 Oct 2023 21:15:50 +0000
Message-ID: <20231028211518.3424020-11-da.gomez@samsung.com>
In-Reply-To: <20231028211518.3424020-1-da.gomez@samsung.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.103]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjmOzs7O65WpyntU7uuJHK6mRWcwCIp8FAQXcio6LLypJWaba2L
	Rs0wbEMsNaFdKi95aS2mq0zMGc1srSlltrSFhjYtjFLTynRYm2eF/573ed7nfd7348NZfDs7
	BD+ceoKWpUqThRgXrXn2+2Uknr6ajrrTE07qTUaMvNN5GSPb3DPI3u+5KGlxich6ix0l2+r0
	GNll/MMm6zy1HLLjSi8gy38McMhH1SUYOT6qx9byKJ2yFaWKzArqXmU41daioMwGFUaZv+dz
	qOfXxlFq2DxvM76LG5NAJx8+Scska/Zzk765+pC0/tDTqjdsJbg7Ww0CcEisgJ5uD1sNuDif
	qARwqETvL0YAbHmRgzLFMIBV7V3oP0tldpu/qwJAzS8j539XzjeVX2n2KtlWFlPcBnBU7eT4
	/BixFDbYzZOWIELHho2ll4BPYBHnoLFPOxkSSGyEat1LxIeDiK1QVTXsnYR7sRjmmfg+GiXC
	oNPowXw0j4iBFucOHx3ghR9+PsR8GBBzYc/tMQ4zXQBd7psIc8IsWKKrZzF4Npyo68YYHAFb
	2t2AwVHwQVmD/2Qh9Fwq9m8phh2FVzEGi2B58ZfJOTzvTLvGPflekJgIgJ/euTiMeT0ccjzz
	BwfCftt9Pz8HOgpy0CtApJ2yn3ZKhnZKhnZKRhFADUBAK+QpibQ8OpU+JZZLU+SK1ETxwWMp
	ZuD9bY4J20gtqOgfElsBggMrgDhLGMRjxcbQfF6C9Ew6LTu2T6ZIpuVWEIqjQgEvLGE+zScS
	pSfoozSdRsv+qQgeEKJE5i//ql6W4dwcqNuQsPSGctH0n9kr25EDTdNb8euZUR8zsyLinzsD
	t29aXbBlYLdh59vfYUe1NVW2EE2kQSM595pXai/r3VXKFYWmVUeT7vsOW0ZElct9vDk/Djmo
	2vteYNmwCpfsF9BNSwp7zkpuGanqGGmpq1H5+HxSrEyTaY5+ldt89q648NCRkxe4ow3TbtWb
	ihokkcFdktqHrWOfLzwZYiODfU8/lnXk2bIuJq1akC6yFECVZ1tdfOg60Q7HI8Hgq25Rsbtp
	bOOgfmFn5/jcgdz8dl7rptrglmufyDjX4qzYRnNwRb+8e+RIdZZhZob1zx7PD5FJsqjGmhdn
	EqLyJOmycJZMLv0LX4liiNwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsVy+t/xu7rsVbapBofPmlrMWb+GzWL13X42
	i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
	MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKD2bovzSklSF
	jPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Md7eeMRW8kq7ovMLa
	wLhWrIuRk0NCwERiRftl1i5GLg4hgaWMEg0HX7FAJGQkNn65ygphC0v8udbFBlH0kVFiWvcN
	qI4zjBJvZp6HclYySrzomMwI0sImoCmx7+QmdpCEiMBsVonDizvAEswCdRJrns0C2yEs4C3R
	Nfs8E4gtIhAkcXjpUqBJHEC2nsTE9UIgYRYBVYmra/6wgYR5BWwk9l4NBzGFBHIl+tsyQSo4
	gaL3v21nA7EZBWQlHq38xQ6xSFzi1pP5TBAPCEgs2XOeGcIWlXj5+B/UYzoSZ68/YYSwDSS2
	Lt0H9bySxJ+OhVAH60ncmDqFDcLWlli28DXYHF4BQYmTM5+wTGCUnoVk3SwkLbOQtMxC0rKA
	kWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYGraduzn5h2M81591DvEyMTBeIhRgoNZSYSX
	2dEmVYg3JbGyKrUoP76oNCe1+BCjKTCEJjJLiSbnA5NjXkm8oZmBqaGJmaWBqaWZsZI4r2dB
	R6KQQHpiSWp2ampBahFMHxMHp1QDU0CAsoTS1hAGmS/nH3i36u929eEWimr/tZDT+c+W9zdk
	+j7s2BBvKC2z605S8rkvx6zP7W76dXdpiD1nSUCCzzKz5+//acvJXYzLU9dRFOwRv7rpzSVr
	prif27hWlFeseN8dwbHrtGKr7et7BevnuVody/ztGbJti0zUyv+27/oS65/7LOU+3VBofMyU
	ba9bTIDa0tPsS0+auyyOkO79Fc3ie2qNyC/p6H9n7FOfzFvkdt3+P+uf9zcMHmnJeP6yecp3
	L4fX6NlNa4Z0JrPtjH7Mn3uDbx282qlQsc/b0zl292vXxYLP/rz7eylyVlNTK091Z+fPjF6e
	pqvmcyRzN6l/04ttmFnDl7CJ8zeDEktxRqKhFnNRcSIABtzmANYDAAA=
X-CMS-MailID: 20231028211551eucas1p1552b7695f12c27f4ea1b92ecb6259b31
X-Msg-Generator: CA
X-RootMTR: 20231028211551eucas1p1552b7695f12c27f4ea1b92ecb6259b31
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231028211551eucas1p1552b7695f12c27f4ea1b92ecb6259b31
References: <20230919135536.2165715-1-da.gomez@samsung.com>
	<20231028211518.3424020-1-da.gomez@samsung.com>
	<CGME20231028211551eucas1p1552b7695f12c27f4ea1b92ecb6259b31@eucas1p1.samsung.com>

Current work in progress. Large folios in the fallocate path makes
regress fstests generic/285 and generic/436.

Add large folio support for shmem write path matching the same high
order preference mechanism used for iomap buffered IO path as used in
__filemap_get_folio().

Add shmem_mapping_size_order to get a hint for the order of the folio
based on the file size which takes care of the mapping requirements.

Swap does not support high order folios for now, so make it order 0 in
case swap is enabled.

Add the __GFP_COMP flag for high order folios except when huge is
enabled. This fixes a memory leak when allocating high order folios.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 mm/shmem.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index fc7605da4316..eb314927be78 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1621,6 +1621,9 @@ static struct folio *shmem_alloc_folio(gfp_t gfp, str=
uct shmem_inode_info *info,
 	pgoff_t ilx;
 	struct page *page;
=20
+	if ((order !=3D 0) && !(gfp & VM_HUGEPAGE))
+		gfp |=3D __GFP_COMP;
+
 	mpol =3D shmem_get_pgoff_policy(info, index, order, &ilx);
 	page =3D alloc_pages_mpol(gfp, order, mpol, ilx, numa_node_id());
 	mpol_cond_put(mpol);
@@ -1628,17 +1631,56 @@ static struct folio *shmem_alloc_folio(gfp_t gfp, s=
truct shmem_inode_info *info,
 	return page_rmappable_folio(page);
 }
=20
+/**
+ * shmem_mapping_size_order - Get maximum folio order for the given file s=
ize.
+ * @mapping: Target address_space.
+ * @index: The page index.
+ * @size: The suggested size of the folio to create.
+ *
+ * This returns a high order for folios (when supported) based on the file=
 size
+ * which the mapping currently allows at the given index. The index is rel=
evant
+ * due to alignment considerations the mapping might have. The returned or=
der
+ * may be less than the size passed.
+ *
+ * Like __filemap_get_folio order calculation.
+ *
+ * Return: The order.
+ */
+static inline unsigned int
+shmem_mapping_size_order(struct address_space *mapping, pgoff_t index,
+			 size_t size, struct shmem_sb_info *sbinfo)
+{
+	unsigned int order =3D ilog2(size);
+
+	if ((order <=3D PAGE_SHIFT) ||
+	    (!mapping_large_folio_support(mapping) || !sbinfo->noswap))
+		return 0;
+
+	order -=3D PAGE_SHIFT;
+
+	/* If we're not aligned, allocate a smaller folio */
+	if (index & ((1UL << order) - 1))
+		order =3D __ffs(index);
+
+	order =3D min_t(size_t, order, MAX_PAGECACHE_ORDER);
+
+	/* Order-1 not supported due to THP dependency */
+	return (order =3D=3D 1) ? 0 : order;
+}
+
 static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
 		struct inode *inode, pgoff_t index,
 		struct mm_struct *fault_mm, size_t len)
 {
 	struct address_space *mapping =3D inode->i_mapping;
 	struct shmem_inode_info *info =3D SHMEM_I(inode);
-	unsigned int order =3D 0;
+	unsigned int order =3D shmem_mapping_size_order(mapping, index, len,
+						      SHMEM_SB(inode->i_sb));
 	struct folio *folio;
 	long pages;
 	int error;
=20
+neworder:
 	if (gfp & VM_HUGEPAGE) {
 		pages =3D HPAGE_PMD_NR;
 		index =3D round_down(index, HPAGE_PMD_NR);
@@ -1721,6 +1763,11 @@ static struct folio *shmem_alloc_and_add_folio(gfp_t=
 gfp,
 unlock:
 	folio_unlock(folio);
 	folio_put(folio);
+	if (order !=3D 0) {
+		if (--order =3D=3D 1)
+			order =3D 0;
+		goto neworder;
+	}
 	return ERR_PTR(error);
 }
=20
--=20
2.39.2

