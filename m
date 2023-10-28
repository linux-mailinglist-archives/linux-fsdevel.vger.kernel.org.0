Return-Path: <linux-fsdevel+bounces-1502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EAA7DA989
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 23:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1EA7B20FE9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 21:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC5919456;
	Sat, 28 Oct 2023 21:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Hmi+lFYm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEB51944D
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 21:16:05 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEDCD4C
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 14:15:57 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231028211555euoutp02602c6d6c59f285e57bb2960faf76e118~SYf6bAwkj0879208792euoutp02T
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 21:15:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231028211555euoutp02602c6d6c59f285e57bb2960faf76e118~SYf6bAwkj0879208792euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698527755;
	bh=vhkx9nEW1P7cUV8Zzx9SlNlxAL82sC2JgyqBVsGy9MY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=Hmi+lFYmkHisLsZG4VbgvaPvoiedms0z5nZdt23VzeCaQ4zTch+cDcnZoKOkjZexm
	 /vTxBQ0PS0S7S/vCmV+ontWsu8i0kpVGRzZBNKgTjMHBvhGggt2MHcoh0c1JqnGkqq
	 ARbkmZY90/TNfseuHtaw6TXdEUBbIaXDncT5gR60=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231028211555eucas1p2394b404cd93491ee5bf44a270047b733~SYf6NFJBV1224812248eucas1p2I;
	Sat, 28 Oct 2023 21:15:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 9F.57.37758.B0A7D356; Sat, 28
	Oct 2023 22:15:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231028211553eucas1p1a93637df6c46692531894e26023920d5~SYf441zj70616106161eucas1p1Z;
	Sat, 28 Oct 2023 21:15:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231028211553eusmtrp28117a3ed7ca27591a873d3f9be3ed510~SYf44SkDt1141411414eusmtrp2i;
	Sat, 28 Oct 2023 21:15:53 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-10-653d7a0b230b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id A1.01.25043.90A7D356; Sat, 28
	Oct 2023 22:15:53 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231028211553eusmtip2ab1bab33fda116438d8bc7115d2b0f8e~SYf4oIwLJ1182011820eusmtip2q;
	Sat, 28 Oct 2023 21:15:53 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Sat, 28 Oct 2023 22:15:53 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Sat, 28 Oct
	2023 22:15:53 +0100
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
Subject: [RFC PATCH 11/11] shmem: add per-block uptodate tracking
Thread-Topic: [RFC PATCH 11/11] shmem: add per-block uptodate tracking
Thread-Index: AQHaCePuWb31sxRneEm07VKavHLDZg==
Date: Sat, 28 Oct 2023 21:15:52 +0000
Message-ID: <20231028211518.3424020-12-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djP87rcVbapBmfWC1nMWb+GzWL13X42
	i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
	MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKC6blNSczLLU
	In27BK6Mw3f6mAtOelQ86drA0sB4zLqLkZNDQsBE4ury1exdjFwcQgIrGCUerZrOBOF8YZTY
	sH8NG4TzmVGibfUpZpiWZ7vfMEMkljNKbG9qYYKrOnXzEdSwM4wST/ddZgdpERJYySjRsVoR
	xGYT0JTYd3ITWJGIwGxWicOLOxhBEswCdRJrns1iAbGFBRwljj95BRYXEXCTmN3Sxgph60lc
	XrkdbCiLgKrEyw872UBsXgEbiW1/D4PFOYHs+9+2g8UZBWQlHq38xQ4xX1zi1pP5TBA/CEos
	mr0H6h8xiX+7HrJB2DoSZ68/YYSwDSS2Lt3HAmErSfzpWAh1p57EjalT2CBsbYllC18zQ9wg
	KHFy5hMWkMckBP5xSrz4cBNqgYvEqs87oAYJS7w6voUdwpaR+L9zPtMERu1ZSO6bhWTHLCQ7
	ZiHZsYCRZRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZgejv97/jXHYwrXn3UO8TIxMF4
	iFGCg1lJhJfZ0SZViDclsbIqtSg/vqg0J7X4EKM0B4uSOK9qinyqkEB6YklqdmpqQWoRTJaJ
	g1OqgUng8j/lnYXZ1UWJa+zn628q6ZS49+Y+y9T5ySabLx7Q2Zm2n39u0uuHi7Yf+m25qy3w
	6l1D1Xvtj3Scef2zBTUkduoJ21zbXfP5D/903RUNvu/fhjEbus8QlfU+f+J/gqiJ7ZaA5j1P
	PaIi3HcZSxwpujP18NwVPVfqPZY+3bHk9DTn3mJZUbsduSeKXx1w88lZJ/zCyVScv+Cm4Lkb
	k45JGXGs265cM6GRWUTxv1198o4arnNq6rJLg/W22DWEiNz8YsF1kld26iSG/xfULRYm3Ppd
	WOt7aK8qn7o5x5X8rSHdHyUyNgpVftCNtfp7PYrjpPS7rE3ZbWHbumVYi96vNJ7HvcOYd+/T
	noY0UyWW4oxEQy3mouJEACbzI/neAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsVy+t/xe7qcVbapBvN/G1jMWb+GzWL13X42
	i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
	MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKD2bovzSklSF
	jPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mw3f6mAtOelQ86drA
	0sB4zLqLkZNDQsBE4tnuN8wgtpDAUkaJ7++EIOIyEhu/XGWFsIUl/lzrYoOo+cgocfoHZxcj
	F5B9hlHi4scH7BDOSkaJq7tXMoJUsQloSuw7uQksISIwm1Xi8OIOsASzQJ3EmmezWEBsYQFH
	ieNPXoHFRQTcJGa3tLFC2HoSl1duZwexWQRUJV5+2Am2mlfARmLb38NAcQ6gbbkS/W2ZIGFO
	oPD9b9vBShgFZCUerfzFDrFKXOLWk/lMEB8ISCzZc54ZwhaVePn4H9RnOhJnrz9hhLANJLYu
	3ccCYStJ/OlYCHWynsSNqVPYIGxtiWULXzNDnCMocXLmE5YJjNKzkKybhaRlFpKWWUhaFjCy
	rGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAhMTtuO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8DI7
	2qQK8aYkVlalFuXHF5XmpBYfYjQFBtFEZinR5HxgeswriTc0MzA1NDGzNDC1NDNWEuf1LOhI
	FBJITyxJzU5NLUgtgulj4uCUamAK8Su9t4A1dfL8zhPeLTrCNgEbXsyONbGd+tjGQCXox5HS
	3rLggsakCS0Lb5R/8/w6v9qoWV59ZpHhI5PKzex/s4N2LgzfKCTwtXmeu++O+NKS+rTs/xNe
	fCx2vZt1/MbtC/dVzD/KHvzYxihx+XiuvkDISXWGvHjGd8fP++3pealQ5nbry3GpXIHmBQVb
	+e28FPN3Trm8YXJg2PpLr+aKvHbbLndBrS7/WkzNr0O3q1d1XrFQPPBX4vJEEYlrSQ8XyXk6
	S7/ftyamem7b6TStFa02djtyb7rxKfxm8HzxRVFVPkG7be/Odbq3ZjPveaGa/uKs8j3FkxP3
	mN+alyPDVFdftLSha/eDRJOLy8uUWIozEg21mIuKEwGITef91wMAAA==
X-CMS-MailID: 20231028211553eucas1p1a93637df6c46692531894e26023920d5
X-Msg-Generator: CA
X-RootMTR: 20231028211553eucas1p1a93637df6c46692531894e26023920d5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231028211553eucas1p1a93637df6c46692531894e26023920d5
References: <20230919135536.2165715-1-da.gomez@samsung.com>
	<20231028211518.3424020-1-da.gomez@samsung.com>
	<CGME20231028211553eucas1p1a93637df6c46692531894e26023920d5@eucas1p1.samsung.com>

Current work in progress due to fsx regression (check below).

Based on iomap per-block dirty and uptodate state track, add support
for shmem_folio_state struct to track uptodate per-block when a folio is
larger than a block. In shmem, this is when large folios is used, as one
block is equal to one page in this context.

Add support for invalidate_folio, release_folio and is_partially_uptodate
address space operations. The first two are needed to be able to free
the new shmem_folio_state struct. The last callback is required for
large folios when enabling per-block tracking.

This was spotted when running fstests for tmpfs and regress on
generic/285 and generic/436 tests [1] with large folios support in the
fallocate path without having per-block uptodate tracking.

[1] tests:
generic/285: src/seek_sanity_test/test09()
generic/436: src/seek_sanity_test/test13()

How to reproduce:

```sh
mkdir -p /mnt/test-tmpfs
./src/seek_sanity_test -s 9 -e 9 /mnt/test-tmpfs/file
./src/seek_sanity_test -s 13 -e 13 /mnt/test-tmpfs/file
umount /mnt/test-tmpfs
```

After per-block uptodate support is added, fsx regresion is found when
running the following:

```sh
mkdir -p /mnt/test-tmpfs
mount -t tmpfs -o size=3D1G -o noswap tmpfs /mnt/test-tmpfs
/root/xfstests-dev/ltp/fsx /mnt/test-tmpfs/file -d -N 1200 -X
umount /mnt/test-tmpfs
```

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 mm/shmem.c | 169 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 159 insertions(+), 10 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index eb314927be78..fa67594495d5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -132,6 +132,94 @@ struct shmem_options {
 #define SHMEM_SEEN_QUOTA 32
 };

+/*
+ * Structure allocated for each folio to track per-block uptodate state.
+ *
+ * Like buffered-io shmem_folio_state struct but only for uptodate.
+ */
+struct shmem_folio_state {
+	spinlock_t state_lock;
+	unsigned long state[];
+};
+
+static inline bool sfs_is_fully_uptodate(struct folio *folio,
+					 struct shmem_folio_state *sfs)
+{
+	struct inode *inode =3D folio->mapping->host;
+
+	return bitmap_full(sfs->state, i_blocks_per_folio(inode, folio));
+}
+
+static inline bool sfs_block_is_uptodate(struct shmem_folio_state *sfs,
+					 unsigned int block)
+{
+	return test_bit(block, sfs->state);
+}
+
+static void sfs_set_range_uptodate(struct folio *folio,
+				   struct shmem_folio_state *sfs, size_t off,
+				   size_t len)
+{
+	struct inode *inode =3D folio->mapping->host;
+	unsigned int first_blk =3D off >> inode->i_blkbits;
+	unsigned int last_blk =3D (off + len - 1) >> inode->i_blkbits;
+	unsigned int nr_blks =3D last_blk - first_blk + 1;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sfs->state_lock, flags);
+	bitmap_set(sfs->state, first_blk, nr_blks);
+	if (sfs_is_fully_uptodate(folio, sfs))
+		folio_mark_uptodate(folio);
+	spin_unlock_irqrestore(&sfs->state_lock, flags);
+}
+
+static void shmem_set_range_uptodate(struct folio *folio, size_t off,
+				     size_t len)
+{
+	struct shmem_folio_state *sfs =3D folio->private;
+
+	if (sfs)
+		sfs_set_range_uptodate(folio, sfs, off, len);
+	else
+		folio_mark_uptodate(folio);
+}
+
+static struct shmem_folio_state *sfs_alloc(struct inode *inode,
+					   struct folio *folio, gfp_t gfp)
+{
+	struct shmem_folio_state *sfs =3D folio->private;
+	unsigned int nr_blocks =3D i_blocks_per_folio(inode, folio);
+
+	if (sfs || nr_blocks <=3D 1)
+		return sfs;
+
+	/*
+	 * sfs->state tracks uptodate flag when the block size is smaller
+	 * than the folio size.
+	 */
+	sfs =3D kzalloc(struct_size(sfs, state, BITS_TO_LONGS(nr_blocks)), gfp);
+	if (!sfs)
+		return sfs;
+
+	spin_lock_init(&sfs->state_lock);
+	if (folio_test_uptodate(folio))
+		bitmap_set(sfs->state, 0, nr_blocks);
+	folio_attach_private(folio, sfs);
+
+	return sfs;
+}
+
+static void sfs_free(struct folio *folio)
+{
+	struct shmem_folio_state *sfs =3D folio_detach_private(folio);
+
+	if (!sfs)
+		return;
+	WARN_ON_ONCE(sfs_is_fully_uptodate(folio, sfs) !=3D
+		     folio_test_uptodate(folio));
+	kfree(sfs);
+}
+
 #ifdef CONFIG_TMPFS
 static unsigned long shmem_default_max_blocks(void)
 {
@@ -1495,7 +1583,7 @@ static int shmem_writepage(struct page *page, struct =
writeback_control *wbc)
 		}
 		folio_zero_range(folio, 0, folio_size(folio));
 		flush_dcache_folio(folio);
-		folio_mark_uptodate(folio);
+		shmem_set_range_uptodate(folio, 0, folio_size(folio));
 	}

 	swap =3D folio_alloc_swap(folio);
@@ -1676,6 +1764,7 @@ static struct folio *shmem_alloc_and_add_folio(gfp_t =
gfp,
 	struct shmem_inode_info *info =3D SHMEM_I(inode);
 	unsigned int order =3D shmem_mapping_size_order(mapping, index, len,
 						      SHMEM_SB(inode->i_sb));
+	struct shmem_folio_state *sfs;
 	struct folio *folio;
 	long pages;
 	int error;
@@ -1755,6 +1844,10 @@ static struct folio *shmem_alloc_and_add_folio(gfp_t=
 gfp,
 		}
 	}

+	sfs =3D sfs_alloc(inode, folio, gfp);
+	if (!sfs && i_blocks_per_folio(inode, folio) > 1)
+		goto unlock;
+
 	trace_mm_shmem_add_to_page_cache(folio);
 	shmem_recalc_inode(inode, pages, 0);
 	folio_add_lru(folio);
@@ -1818,7 +1911,7 @@ static int shmem_replace_folio(struct folio **foliop,=
 gfp_t gfp,

 	__folio_set_locked(new);
 	__folio_set_swapbacked(new);
-	folio_mark_uptodate(new);
+	shmem_set_range_uptodate(new, 0, folio_size(new));
 	new->swap =3D entry;
 	folio_set_swapcache(new);

@@ -2146,7 +2239,7 @@ static int shmem_get_folio_gfp(struct inode *inode, p=
goff_t index,
 		for (i =3D 0; i < n; i++)
 			clear_highpage(folio_page(folio, i));
 		flush_dcache_folio(folio);
-		folio_mark_uptodate(folio);
+		shmem_set_range_uptodate(folio, 0, folio_size(folio));
 	}

 	/* Perhaps the file has been truncated since we checked */
@@ -2788,13 +2881,18 @@ shmem_write_end(struct file *file, struct address_s=
pace *mapping,
 	if (pos + copied > inode->i_size)
 		i_size_write(inode, pos + copied);

+	if (unlikely(copied < len && !folio_test_uptodate(folio)))
+		return 0;
+
 	if (!folio_test_uptodate(folio)) {
-		if (copied < folio_size(folio)) {
-			size_t from =3D offset_in_folio(folio, pos);
-			folio_zero_segments(folio, 0, from,
-					from + copied, folio_size(folio));
-		}
-		folio_mark_uptodate(folio);
+		size_t from =3D offset_in_folio(folio, pos);
+		if (!folio_test_large(folio) && copied < folio_size(folio))
+			folio_zero_segments(folio, 0, from, from + copied,
+					    folio_size(folio));
+		if (folio_test_large(folio) && copied < PAGE_SIZE)
+			folio_zero_segments(folio, from, from, from + copied,
+					    folio_size(folio));
+		shmem_set_range_uptodate(folio, from, len);
 	}
 	folio_mark_dirty(folio);
 	folio_unlock(folio);
@@ -2803,6 +2901,54 @@ shmem_write_end(struct file *file, struct address_sp=
ace *mapping,
 	return copied;
 }

+void shmem_invalidate_folio(struct folio *folio, size_t offset, size_t len=
)
+{
+	/*
+	 * If we're invalidating the entire folio, clear the dirty state
+	 * from it and release it to avoid unnecessary buildup of the LRU.
+	 */
+	if (offset =3D=3D 0 && len =3D=3D folio_size(folio)) {
+		WARN_ON_ONCE(folio_test_writeback(folio));
+		folio_cancel_dirty(folio);
+		sfs_free(folio);
+	}
+}
+
+bool shmem_release_folio(struct folio *folio, gfp_t gfp_flags)
+{
+	sfs_free(folio);
+	return true;
+}
+
+/*
+ * shmem_is_partially_uptodate checks whether blocks within a folio are
+ * uptodate or not.
+ *
+ * Returns true if all blocks which correspond to the specified part
+ * of the folio are uptodate.
+ */
+bool shmem_is_partially_uptodate(struct folio *folio, size_t from, size_t =
count)
+{
+	struct shmem_folio_state *sfs =3D folio->private;
+	struct inode *inode =3D folio->mapping->host;
+	unsigned first, last, i;
+
+	if (!sfs)
+		return false;
+
+	/* Caller's range may extend past the end of this folio */
+	count =3D min(folio_size(folio) - from, count);
+
+	/* First and last blocks in range within folio */
+	first =3D from >> inode->i_blkbits;
+	last =3D (from + count - 1) >> inode->i_blkbits;
+
+	for (i =3D first; i <=3D last; i++)
+		if (!sfs_block_is_uptodate(sfs, i))
+			return false;
+	return true;
+}
+
 static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *t=
o)
 {
 	struct file *file =3D iocb->ki_filp;
@@ -3554,7 +3700,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, str=
uct inode *dir,
 		inode->i_mapping->a_ops =3D &shmem_aops;
 		inode->i_op =3D &shmem_symlink_inode_operations;
 		memcpy(folio_address(folio), symname, len);
-		folio_mark_uptodate(folio);
+		shmem_set_range_uptodate(folio, 0, folio_size(folio));
 		folio_mark_dirty(folio);
 		folio_unlock(folio);
 		folio_put(folio);
@@ -4524,6 +4670,9 @@ const struct address_space_operations shmem_aops =3D =
{
 #ifdef CONFIG_MIGRATION
 	.migrate_folio	=3D migrate_folio,
 #endif
+	.invalidate_folio =3D shmem_invalidate_folio,
+	.release_folio	=3D shmem_release_folio,
+	.is_partially_uptodate =3D shmem_is_partially_uptodate,
 	.error_remove_page =3D shmem_error_remove_page,
 };
 EXPORT_SYMBOL(shmem_aops);
--
2.39.2

