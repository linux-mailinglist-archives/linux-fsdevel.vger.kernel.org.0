Return-Path: <linux-fsdevel+bounces-1496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC797DA980
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 23:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FEBD28120E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 21:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B532B18C05;
	Sat, 28 Oct 2023 21:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="d0BEWt0N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2481863A
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 21:15:48 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ABFE1
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 14:15:46 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231028211545euoutp01503202edc99ab40a78560def43ba063a~SYfwxaJsR2292822928euoutp01X
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 21:15:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231028211545euoutp01503202edc99ab40a78560def43ba063a~SYfwxaJsR2292822928euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698527745;
	bh=/CvASZfCabc/Ew9WG/OE+/8Wt2GCjn+VDx2yMe2ZiFk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=d0BEWt0NRJ+q9fKwIT9WCJmLwnptxbJk8cHMt4E1+uBYIQAsZ8HmB0fV81C9HGMNh
	 eplHCmHGAfK9UKuEM3ZkMU9SC9sskXWwIUvxl9OaeWtjnzZO7Uztce5QNGgW6Ll1S3
	 V0XCcJJ7oPcp//iGDSuKTptzJTpA26oYwVacTJPc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231028211544eucas1p2dd80d12755f4916b3ddb921b0f269b68~SYfwUtLgi1224812248eucas1p27;
	Sat, 28 Oct 2023 21:15:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id FB.57.37758.00A7D356; Sat, 28
	Oct 2023 22:15:44 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231028211543eucas1p2c980dda91fdccaa0b5af3734c357b2f7~SYfvYfPTw1090610906eucas1p2I;
	Sat, 28 Oct 2023 21:15:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231028211543eusmtrp23d56e547237e332334313cc821183188~SYfvX96w-1141411414eusmtrp2c;
	Sat, 28 Oct 2023 21:15:43 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-ff-653d7a00f0a9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id DD.F0.25043.FF97D356; Sat, 28
	Oct 2023 22:15:43 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231028211543eusmtip1c2729878b21b7ae72b87f193ecb7dc7d~SYfvKXDWf0467404674eusmtip1M;
	Sat, 28 Oct 2023 21:15:43 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Sat, 28 Oct 2023 22:15:42 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Sat, 28 Oct
	2023 22:15:42 +0100
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
Subject: [RFC PATCH 05/11] shmem: account for large order folios
Thread-Topic: [RFC PATCH 05/11] shmem: account for large order folios
Thread-Index: AQHaCePog3tlS7SbBUi1hq/vgcoYwQ==
Date: Sat, 28 Oct 2023 21:15:42 +0000
Message-ID: <20231028211518.3424020-6-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djPc7oMVbapBvtfaVrMWb+GzWL13X42
	i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
	MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKC6blNSczLLU
	In27BK6Mm39bmAveSFRMmHSIvYFxn0gXIyeHhICJRNfqZWxdjFwcQgIrGCUeXZjFCuF8YZT4
	8uIPO0iVkMBnRom2zjCYjl/HJrJCxJczSpy9lQLRAFTz6P9BZgjnDKPEyS+7GSGclYwSl06+
	BRvFJqApse/kJnaQhIjAbFaJw4s7GEESzAJ1EmuezWLpYuTgEBZwkHi7pAQkLCLgKnFtbQc7
	SFhEQE9i6pdCkDCLgKrE72W7mUDCvALWEj+u1YGEOQVsJO5/284GYjMKyEo8WvmLHWK4uMSt
	J/OZIB4QlFg0ew8zhC0m8W/XQzYIW0fi7PUnjBC2gcTWpftYIGwliT8dC6GO1JO4MXUKG4St
	LbFs4WuwObxAM0/OfMIC8pWEQBeXxNeGLVDNLhI3fmxlh7CFJV4d3wJly0j83zmfaQKj9iwk
	981CsmMWkh2zkOxYwMiyilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzCtnf53/OsOxhWv
	PuodYmTiYDzEKMHBrCTCy+xokyrEm5JYWZValB9fVJqTWnyIUZqDRUmcVzVFPlVIID2xJDU7
	NbUgtQgmy8TBKdXAtNDL3OBolMrUQi8T8Qdn9shfs7vHkFkwtcSANTi+wIvluOzn5//vHq26
	d2PiTtEZnvwbxP4k3dJapy0YFeK0Z2+wuKXTqZoZYpzZOgwr7yxKcPHRu9afW7zANsUvIcxk
	bc/+mM2XG6U23nXv+eL8keX04ln8ZYwlKy/Kq+28ynu3oNnpYZjtT+kZb3wfyc7Un6Bfs2BG
	/e4LEiueCPd7ft21o+9ghuhf59pD85Ue925e6h/y8vr8vfz+gdaxXwplPgvL3X7+cZmuKgtf
	WLtoY+uXz++Ct50r2KA7k7/4i5T4kj0lB/7vDDYWzCg1OuS7o+z4kn7mmcVWwaf258cZmLiU
	cO+fs2zuv9g1qs21SizFGYmGWsxFxYkAMM+ictoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsVy+t/xu7r/K21TDR58VLOYs34Nm8Xqu/1s
	Fpef8Fk8/dTHYrH3lrbFnr0nWSwu75rDZnFvzX9Wi11/drBb3JjwlNFi2df37Ba7Ny5is/j9
	Yw6bA6/H7IaLLB4LNpV6bF6h5XH5bKnHplWdbB6bPk1i9zgx4zeLx+dNcgEcUXo2RfmlJakK
	GfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZN/+2MBe8kaiYMOkQ
	ewPjPpEuRk4OCQETiV/HJrJ2MXJxCAksZZQ4sO0AO0RCRmLjl6usELawxJ9rXWwQRR8ZJVq+
	LITqOMMoceP4FnYIZyWjxKHGJ0wgLWwCmhL7Tm4CS4gIzGaVOLy4gxEkwSxQJ7Hm2SyWLkYO
	DmEBB4m3S0pAwiICrhLX1nawg4RFBPQkpn4pBAmzCKhK/F62mwkkzCtgLfHjWh2IKSSQK9Hf
	lglSwSlgI3H/23Y2EJtRQFbi0cpf7BB7xCVuPZnPBHG/gMSSPeeZIWxRiZeP/0H9pSNx9voT
	RgjbQGLr0n0sELaSxJ+OhVD36kncmDqFDcLWlli28DXYHF4BQYmTM5+wTGCUnoVk3SwkLbOQ
	tMxC0rKAkWUVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYGraduznlh2MK1991DvEyMTBeIhR
	goNZSYSX2dEmVYg3JbGyKrUoP76oNCe1+BCjKTCEJjJLiSbnA5NjXkm8oZmBqaGJmaWBqaWZ
	sZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDk/fytR9TvLfETli83Ur+17c7XmwevVNerzoz
	Z1/Ty5XWT21PfvvuYcp9+YBq0ETujSeLm0Nj+X16t2jZG6VKuljv9GRZdeGRZdtL7rM7xNi3
	ltXujS561NBpck7XdsuJ6es3aa+Z+e7m7rsRHCqxE5K18zqVLbdw6JvqFzHN491+aknSTaaI
	VbL9v/1sdP+d5Fyx/27I3um6p1d8OMm7uM5QVbmrjm8Ly82mo8v+Ha0XdXDzNHHJ3SlnJWf0
	4+OxtbGiwvlzZ7w5dtrzZ8sr973zpa8d+sIVfqbj6/QTS+Lzf2kG89xbIbi/VvGGbLfajIem
	O2xv3Pd+fUjos8EHluizHJv9WW7Mkbp08RhbgLUSS3FGoqEWc1FxIgDmdKNI1gMAAA==
X-CMS-MailID: 20231028211543eucas1p2c980dda91fdccaa0b5af3734c357b2f7
X-Msg-Generator: CA
X-RootMTR: 20231028211543eucas1p2c980dda91fdccaa0b5af3734c357b2f7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231028211543eucas1p2c980dda91fdccaa0b5af3734c357b2f7
References: <20230919135536.2165715-1-da.gomez@samsung.com>
	<20231028211518.3424020-1-da.gomez@samsung.com>
	<CGME20231028211543eucas1p2c980dda91fdccaa0b5af3734c357b2f7@eucas1p2.samsung.com>

From: Luis Chamberlain <mcgrof@kernel.org>

shmem uses the shem_info_inode alloced, swapped to account
for allocated pages and swapped pages. In preparation for large
order folios adjust the accounting to use folio_nr_pages().

This should produce no functional changes yet as larger order
folios are not yet used or supported in shmem.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 mm/shmem.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 9f4c9b9286e5..ab31d2880e5d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -856,16 +856,16 @@ unsigned long shmem_partial_swap_usage(struct address=
_space *mapping,
 						pgoff_t start, pgoff_t end)
 {
 	XA_STATE(xas, &mapping->i_pages, start);
-	struct page *page;
+	struct folio *folio;
 	unsigned long swapped =3D 0;
 	unsigned long max =3D end - 1;
=20
 	rcu_read_lock();
-	xas_for_each(&xas, page, max) {
-		if (xas_retry(&xas, page))
+	xas_for_each(&xas, folio, max) {
+		if (xas_retry(&xas, folio))
 			continue;
-		if (xa_is_value(page))
-			swapped++;
+		if (xa_is_value(folio))
+			swapped +=3D folio_nr_pages(folio);
 		if (xas.xa_index =3D=3D max)
 			break;
 		if (need_resched()) {
@@ -1514,7 +1514,7 @@ static int shmem_writepage(struct page *page, struct =
writeback_control *wbc)
 	if (add_to_swap_cache(folio, swap,
 			__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
 			NULL) =3D=3D 0) {
-		shmem_recalc_inode(inode, 0, 1);
+		shmem_recalc_inode(inode, 0, folio_nr_pages(folio));
 		swap_shmem_alloc(swap);
 		shmem_delete_from_page_cache(folio, swp_to_radix_entry(swap));
=20
@@ -1828,6 +1828,7 @@ static void shmem_set_folio_swapin_error(struct inode=
 *inode, pgoff_t index,
 	struct address_space *mapping =3D inode->i_mapping;
 	swp_entry_t swapin_error;
 	void *old;
+	long num_swap_pages;
=20
 	swapin_error =3D make_poisoned_swp_entry();
 	old =3D xa_cmpxchg_irq(&mapping->i_pages, index,
@@ -1837,13 +1838,14 @@ static void shmem_set_folio_swapin_error(struct ino=
de *inode, pgoff_t index,
 		return;
=20
 	folio_wait_writeback(folio);
+	num_swap_pages =3D folio_nr_pages(folio);
 	delete_from_swap_cache(folio);
 	/*
 	 * Don't treat swapin error folio as alloced. Otherwise inode->i_blocks
 	 * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
 	 * in shmem_evict_inode().
 	 */
-	shmem_recalc_inode(inode, -1, -1);
+	shmem_recalc_inode(inode, -num_swap_pages, -num_swap_pages);
 	swap_free(swap);
 }
=20
@@ -1928,7 +1930,7 @@ static int shmem_swapin_folio(struct inode *inode, pg=
off_t index,
 	if (error)
 		goto failed;
=20
-	shmem_recalc_inode(inode, 0, -1);
+	shmem_recalc_inode(inode, 0, -folio_nr_pages(folio));
=20
 	if (sgp =3D=3D SGP_WRITE)
 		folio_mark_accessed(folio);
@@ -2684,7 +2686,7 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 	if (ret)
 		goto out_delete_from_cache;
=20
-	shmem_recalc_inode(inode, 1, 0);
+	shmem_recalc_inode(inode, folio_nr_pages(folio), 0);
 	folio_unlock(folio);
 	return 0;
 out_delete_from_cache:
--=20
2.39.2

