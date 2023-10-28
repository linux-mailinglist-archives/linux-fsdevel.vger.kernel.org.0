Return-Path: <linux-fsdevel+bounces-1499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A46BA7DA986
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 23:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2D328129C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 21:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F161863A;
	Sat, 28 Oct 2023 21:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HvgVsjl6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F9B18C1A
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 21:15:55 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0813BFC
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 14:15:51 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231028211550euoutp027cef3522e732e9032102ca4302eeef09~SYf1mON-s0331103311euoutp02k
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 21:15:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231028211550euoutp027cef3522e732e9032102ca4302eeef09~SYf1mON-s0331103311euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698527750;
	bh=gxd/EGAczS5Sd2rHF+B8nzW13spueLXcZPpoB3AlPYI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=HvgVsjl64HvJ64ot77kmzDje+uQuxtA7zifALFjBJvDoDR4pE12gHKnQopPb9Q1Ki
	 JcsOmoG3yxeNnMF8nPokyO29MmGgAeRqQa/qZXip9wn/92O8bamlvsBdGOhyhREkOW
	 bBBKJ419K6MQ52U10yhCjUxALGKOW1hVkwIgykE8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231028211549eucas1p239234b06d304c44bb785b810de7b1834~SYf0zFEUx1087910879eucas1p2O;
	Sat, 28 Oct 2023 21:15:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id DD.57.37758.50A7D356; Sat, 28
	Oct 2023 22:15:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231028211548eucas1p18d34af3d578966ba6778d4e60751789d~SYf0Hvnnc0616106161eucas1p1U;
	Sat, 28 Oct 2023 21:15:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231028211548eusmtrp167fbd68caf98448438c2e2eab8a99c2b~SYf0HNAVQ0755507555eusmtrp1c;
	Sat, 28 Oct 2023 21:15:48 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-07-653d7a050245
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 03.52.10549.40A7D356; Sat, 28
	Oct 2023 22:15:48 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231028211548eusmtip138c1e7e6b533f290bc0b98246a985425~SYfz7zIWw0467404674eusmtip1S;
	Sat, 28 Oct 2023 21:15:48 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Sat, 28 Oct 2023 22:15:48 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Sat, 28 Oct
	2023 22:15:48 +0100
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
Subject: [RFC PATCH 08/11] shmem: add file length arg in shmem_get_folio()
 path
Thread-Topic: [RFC PATCH 08/11] shmem: add file length arg in
	shmem_get_folio() path
Thread-Index: AQHaCePr7bvMjV6bP0CdFgNDCwhrFA==
Date: Sat, 28 Oct 2023 21:15:47 +0000
Message-ID: <20231028211518.3424020-9-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djPc7qsVbapBqdbpSzmrF/DZrH6bj+b
	xeUnfBZPP/WxWOy9pW2xZ+9JFovLu+awWdxb85/VYtefHewWNyY8ZbRY9vU9u8XujYvYLH7/
	mMPmwOsxu+Eii8eCTaUem1doeVw+W+qxaVUnm8emT5PYPU7M+M3i8XmTXABHFJdNSmpOZllq
	kb5dAldG69KJbAWfrSomTH3I1sDYpd/FyMkhIWAicbf9I1MXIxeHkMAKRom1J34wQjhfGCUu
	fNsK5XxmlLh99QkjTMupR1tYIRLLGSUeX57IBJIAq9r0LQ8icYZRYtK2L6wQiZWMEvNnBYDY
	bAKaEvtObmIHKRIRmM0qcXhxB9hYZoE6iTXPZrF0MXJwCAsESvy/nQYSFhEIk/h0fCMThK0n
	0X7+CFg5i4CqxIVfU8Hm8wpYSyw7vpYdxOYUsJG4/207G4jNKCAr8WjlL3aI8eISt57MZ4L4
	QFBi0ew9zBC2mMS/XQ/ZIGwdibPXYb40kNi6dB8LhK0k8adjIdSZehI3pk5hg7C1JZYtfM0M
	cYOgxMmZT1hA/pIQaOKSOHT/C9RQF4nrVxqghgpLvDq+hR3ClpE4PbmHZQKj9iwk981CsmMW
	kh2zkOxYwMiyilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzC1nf53/OsOxhWvPuodYmTi
	YDzEKMHBrCTCy+xokyrEm5JYWZValB9fVJqTWnyIUZqDRUmcVzVFPlVIID2xJDU7NbUgtQgm
	y8TBKdXA1BJ/0l4obE7jb+lNRSf/LVVrDvgTqppwpun1lHtTzwLT4Yoqsd+qjisTg40fBeT5
	L9JNedjQecZ45dGI2amphyKVO69l9zV8k3weeuCsgASP6O9KbUMHy9CXylO3R4fkLtssvrdT
	/LtxmJa7rNktVraqeF5HhZniO3YekVjF5f+qzlZrcmhVhW2cWGBCz7GLcTu0XI2Vyu1lfmnF
	5boKs6w8Un/QIfyduHvWzkvP5zFsNXvz16ixpkEzWfnqWrs/iyJ+Jlv9VZozTYaVv2xvwtt9
	gU9XL0r6dm6jmIhvWfrrG5f7nSe8Kb4s+k07VYMzYOeNlNrmvevObA3o+b36OIvy9/1GNRni
	d1O8biixFGckGmoxFxUnAgAOHVg63AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsVy+t/xu7osVbapBo+W61vMWb+GzWL13X42
	i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
	MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKD2bovzSklSF
	jPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M1qUT2Qo+W1VMmPqQ
	rYGxS7+LkZNDQsBE4tSjLaxdjFwcQgJLGSUmXOpghkjISGz8cpUVwhaW+HOtiw2i6COjxNbO
	iWBFQgJnGCW6GiQgEiuBume/AOtgE9CU2HdyEztIQkRgNqvE4cUdjCAJZoE6iTXPZrF0MXJw
	CAsESvy/nQYSFhEIk9i5bSI7hK0n0X7+CFg5i4CqxIVfU8Fm8gpYSyw7vpYdpFVIIFeivy0T
	JMwpYCNx/9t2NhCbUUBW4tHKX+wQm8Qlbj2ZzwTxgIDEkj3noR4TlXj5+B/UYzoSZ68/YYSw
	DSS2Lt3HAmErSfzpWAh1sZ7EjalT2CBsbYllC18zQ5wjKHFy5hOWCYzSs5Csm4WkZRaSlllI
	WhYwsqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQITE7bjv3cvINx3quPeocYmTgYDzFKcDAr
	ifAyO9qkCvGmJFZWpRblxxeV5qQWH2I0BQbRRGYp0eR8YHrMK4k3NDMwNTQxszQwtTQzVhLn
	9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgYlcX/fQuqjyj5O0+T1Ff6ztTeKQ4ZwnMrTtQeyF+
	44ESE+nld02Wec2Nu6F7TCt7h1Q2Y0qXppNDvFL8Rl8F/ZlhitwCvyPY18g7HvJsK19we693
	1cXVLuLvebqnxVt1nKjbLvlD+OFHlpVCKmZ9a5ovLJryhjE3j0tkxvI/B6+bi76z5eSX7Wo8
	UZtmIVIkej99j4nQsSmW9zcUXHFe2LzHavHXeyczNgt9+7m5KPRS49K5h+Zs1fz1Qri98lDi
	/KnyFzyUz6nxP6i68O9DXJXIt0/+NTsZTNaI7Eu9s9pe5FNafWHz8WWlXae65Wbzq3YYfQ31
	PX1AWLXE+ZfzwTs2ecWmtzKfJOfsKp+pxFKckWioxVxUnAgAN/NqXtcDAAA=
X-CMS-MailID: 20231028211548eucas1p18d34af3d578966ba6778d4e60751789d
X-Msg-Generator: CA
X-RootMTR: 20231028211548eucas1p18d34af3d578966ba6778d4e60751789d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231028211548eucas1p18d34af3d578966ba6778d4e60751789d
References: <20230919135536.2165715-1-da.gomez@samsung.com>
	<20231028211518.3424020-1-da.gomez@samsung.com>
	<CGME20231028211548eucas1p18d34af3d578966ba6778d4e60751789d@eucas1p1.samsung.com>

In preparation for large folio in the write path, add file length
argument in shmem_get_folio() path to be able to calculate the folio
order based on the file size. Use of order-0 (PAGE_SIZE) for non write
paths such as read, page cache read, and vm fault.

This enables high order folios in the write and fallocate paths once the
folio order is calculated based on the length.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 include/linux/shmem_fs.h |  2 +-
 mm/khugepaged.c          |  3 ++-
 mm/shmem.c               | 33 ++++++++++++++++++---------------
 mm/userfaultfd.c         |  2 +-
 4 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 2caa6b86106a..7138ea980884 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -137,7 +137,7 @@ enum sgp_type {
 };

 int shmem_get_folio(struct inode *inode, pgoff_t index, struct folio **fol=
iop,
-		enum sgp_type sgp);
+		enum sgp_type sgp, size_t len);
 struct folio *shmem_read_folio_gfp(struct address_space *mapping,
 		pgoff_t index, gfp_t gfp);

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 064654717843..fcde8223b507 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1855,7 +1855,8 @@ static int collapse_file(struct mm_struct *mm, unsign=
ed long addr,
 				xas_unlock_irq(&xas);
 				/* swap in or instantiate fallocated page */
 				if (shmem_get_folio(mapping->host, index,
-						&folio, SGP_NOALLOC)) {
+						    &folio, SGP_NOALLOC,
+						    PAGE_SIZE)) {
 					result =3D SCAN_FAIL;
 					goto xa_unlocked;
 				}
diff --git a/mm/shmem.c b/mm/shmem.c
index 9d68211373c4..d8dc2ceaba18 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -958,7 +958,7 @@ static struct folio *shmem_get_partial_folio(struct ino=
de *inode, pgoff_t index)
 	 * (although in some cases this is just a waste of time).
 	 */
 	folio =3D NULL;
-	shmem_get_folio(inode, index, &folio, SGP_READ);
+	shmem_get_folio(inode, index, &folio, SGP_READ, PAGE_SIZE);
 	return folio;
 }

@@ -1644,7 +1644,7 @@ static struct folio *shmem_alloc_folio(gfp_t gfp,

 static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
 		struct inode *inode, pgoff_t index,
-		struct mm_struct *fault_mm)
+		struct mm_struct *fault_mm, size_t len)
 {
 	struct address_space *mapping =3D inode->i_mapping;
 	struct shmem_inode_info *info =3D SHMEM_I(inode);
@@ -1969,7 +1969,7 @@ static int shmem_swapin_folio(struct inode *inode, pg=
off_t index,
  */
 static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		struct folio **foliop, enum sgp_type sgp, gfp_t gfp,
-		struct vm_fault *vmf, vm_fault_t *fault_type)
+		struct vm_fault *vmf, vm_fault_t *fault_type, size_t len)
 {
 	struct vm_area_struct *vma =3D vmf ? vmf->vma : NULL;
 	struct mm_struct *fault_mm;
@@ -2051,7 +2051,7 @@ static int shmem_get_folio_gfp(struct inode *inode, p=
goff_t index,
 		huge_gfp =3D vma_thp_gfp_mask(vma);
 		huge_gfp =3D limit_gfp_mask(huge_gfp, gfp);
 		folio =3D shmem_alloc_and_add_folio(huge_gfp,
-				inode, index, fault_mm);
+				inode, index, fault_mm, len);
 		if (!IS_ERR(folio)) {
 			count_vm_event(THP_FILE_ALLOC);
 			goto alloced;
@@ -2060,7 +2060,7 @@ static int shmem_get_folio_gfp(struct inode *inode, p=
goff_t index,
 			goto repeat;
 	}

-	folio =3D shmem_alloc_and_add_folio(gfp, inode, index, fault_mm);
+	folio =3D shmem_alloc_and_add_folio(gfp, inode, index, fault_mm, len);
 	if (IS_ERR(folio)) {
 		error =3D PTR_ERR(folio);
 		if (error =3D=3D -EEXIST)
@@ -2140,10 +2140,10 @@ static int shmem_get_folio_gfp(struct inode *inode,=
 pgoff_t index,
 }

 int shmem_get_folio(struct inode *inode, pgoff_t index, struct folio **fol=
iop,
-		enum sgp_type sgp)
+		enum sgp_type sgp, size_t len)
 {
 	return shmem_get_folio_gfp(inode, index, foliop, sgp,
-			mapping_gfp_mask(inode->i_mapping), NULL, NULL);
+			mapping_gfp_mask(inode->i_mapping), NULL, NULL, len);
 }

 /*
@@ -2237,7 +2237,7 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)

 	WARN_ON_ONCE(vmf->page !=3D NULL);
 	err =3D shmem_get_folio_gfp(inode, vmf->pgoff, &folio, SGP_CACHE,
-				  gfp, vmf, &ret);
+				  gfp, vmf, &ret, PAGE_SIZE);
 	if (err)
 		return vmf_error(err);
 	if (folio) {
@@ -2716,6 +2716,9 @@ shmem_write_begin(struct file *file, struct address_s=
pace *mapping,
 	struct folio *folio;
 	int ret =3D 0;

+	if (!mapping_large_folio_support(mapping))
+		len =3D min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
+
 	/* i_rwsem is held by caller */
 	if (unlikely(info->seals & (F_SEAL_GROW |
 				   F_SEAL_WRITE | F_SEAL_FUTURE_WRITE))) {
@@ -2725,7 +2728,7 @@ shmem_write_begin(struct file *file, struct address_s=
pace *mapping,
 			return -EPERM;
 	}

-	ret =3D shmem_get_folio(inode, index, &folio, SGP_WRITE);
+	ret =3D shmem_get_folio(inode, index, &folio, SGP_WRITE, len);
 	if (ret)
 		return ret;

@@ -2796,7 +2799,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *ioc=
b, struct iov_iter *to)
 				break;
 		}

-		error =3D shmem_get_folio(inode, index, &folio, SGP_READ);
+		error =3D shmem_get_folio(inode, index, &folio, SGP_READ, PAGE_SIZE);
 		if (error) {
 			if (error =3D=3D -EINVAL)
 				error =3D 0;
@@ -2973,7 +2976,7 @@ static ssize_t shmem_file_splice_read(struct file *in=
, loff_t *ppos,
 			break;

 		error =3D shmem_get_folio(inode, *ppos / PAGE_SIZE, &folio,
-					SGP_READ);
+					SGP_READ, PAGE_SIZE);
 		if (error) {
 			if (error =3D=3D -EINVAL)
 				error =3D 0;
@@ -3160,7 +3163,7 @@ static long shmem_fallocate(struct file *file, int mo=
de, loff_t offset,
 			error =3D -ENOMEM;
 		else
 			error =3D shmem_get_folio(inode, index, &folio,
-						SGP_FALLOC);
+						SGP_FALLOC, (end - index) << PAGE_SHIFT);
 		if (error) {
 			info->fallocend =3D undo_fallocend;
 			/* Remove the !uptodate folios we added */
@@ -3511,7 +3514,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, str=
uct inode *dir,
 		inode->i_op =3D &shmem_short_symlink_operations;
 	} else {
 		inode_nohighmem(inode);
-		error =3D shmem_get_folio(inode, 0, &folio, SGP_WRITE);
+		error =3D shmem_get_folio(inode, 0, &folio, SGP_WRITE, PAGE_SIZE);
 		if (error)
 			goto out_remove_offset;
 		inode->i_mapping->a_ops =3D &shmem_aops;
@@ -3558,7 +3561,7 @@ static const char *shmem_get_link(struct dentry *dent=
ry, struct inode *inode,
 			return ERR_PTR(-ECHILD);
 		}
 	} else {
-		error =3D shmem_get_folio(inode, 0, &folio, SGP_READ);
+		error =3D shmem_get_folio(inode, 0, &folio, SGP_READ, PAGE_SIZE);
 		if (error)
 			return ERR_PTR(error);
 		if (!folio)
@@ -4923,7 +4926,7 @@ struct folio *shmem_read_folio_gfp(struct address_spa=
ce *mapping,

 	BUG_ON(!shmem_mapping(mapping));
 	error =3D shmem_get_folio_gfp(inode, index, &folio, SGP_CACHE,
-				    gfp, NULL, NULL);
+				    gfp, NULL, NULL, PAGE_SIZE);
 	if (error)
 		return ERR_PTR(error);

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 96d9eae5c7cc..aab8679b322a 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -256,7 +256,7 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
 	struct page *page;
 	int ret;

-	ret =3D shmem_get_folio(inode, pgoff, &folio, SGP_NOALLOC);
+	ret =3D shmem_get_folio(inode, pgoff, &folio, SGP_NOALLOC, PAGE_SIZE);
 	/* Our caller expects us to return -EFAULT if we failed to find folio */
 	if (ret =3D=3D -ENOENT)
 		ret =3D -EFAULT;
--
2.39.2

