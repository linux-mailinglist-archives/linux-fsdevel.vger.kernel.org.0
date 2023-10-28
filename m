Return-Path: <linux-fsdevel+bounces-1497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC52D7DA981
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 23:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CAA01C209DF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 21:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71B518C17;
	Sat, 28 Oct 2023 21:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bjGf4PuO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140F618B0D
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 21:15:50 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D95CA
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 14:15:48 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231028211546euoutp011cdc392af4d8c04c201017ecb3a6f0c6~SYfyWIzJM2659126591euoutp01I
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 21:15:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231028211546euoutp011cdc392af4d8c04c201017ecb3a6f0c6~SYfyWIzJM2659126591euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698527746;
	bh=cqTk9J1wmzoKfcE/fbVQ1ZhNe/efGCweXy90QEX86kQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=bjGf4PuODXvBE+WtcNSzL/CGuJ1b5AEEdHtQz7pHlVmrkuMHVuyweXzVQWgG/atL9
	 wzuPX6jt6lRIWbVhOuxYDQbOfoD02yu1xpSqLVgyQWBUoXM5O3wVGJbtK4WAyHIQxa
	 Hv407t/IChRH42DXr+FKGurxlj6OzW9hDC5hL9E0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231028211546eucas1p2d9c87ac5195deeb424c6db2ee6b4bba0~SYfyAl9sB1224812248eucas1p2_;
	Sat, 28 Oct 2023 21:15:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id A2.20.11320.20A7D356; Sat, 28
	Oct 2023 22:15:46 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231028211545eucas1p2da564864423007a5ab006cdd1ab4d4a1~SYfxbyUZ41087910879eucas1p2I;
	Sat, 28 Oct 2023 21:15:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231028211545eusmtrp27f616722d703e49e984feaa6bd1f86ae~SYfxbQh_i1141411414eusmtrp2d;
	Sat, 28 Oct 2023 21:15:45 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-8b-653d7a029922
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id CE.F0.25043.10A7D356; Sat, 28
	Oct 2023 22:15:45 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231028211545eusmtip1ecd5e3b6d81770cd6ea6596dd01bf8b4~SYfxRlEbt0467404674eusmtip1O;
	Sat, 28 Oct 2023 21:15:45 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Sat, 28 Oct 2023 22:15:45 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Sat, 28 Oct
	2023 22:15:44 +0100
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
Subject: [RFC PATCH 06/11] shmem: trace shmem_add_to_page_cache folio order
Thread-Topic: [RFC PATCH 06/11] shmem: trace shmem_add_to_page_cache folio
	order
Thread-Index: AQHaCePpKnL5pBbYgEe8tpnCRhW3OA==
Date: Sat, 28 Oct 2023 21:15:44 +0000
Message-ID: <20231028211518.3424020-7-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djPc7pMVbapBrMfSFnMWb+GzWL13X42
	i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
	MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKC6blNSczLLU
	In27BK6MK9tmsxSsFq9Y+vE0ewPjJuEuRk4OCQETifavp1i6GLk4hARWMEpMaP3OBJIQEvjC
	KPF9ggtE4jOjxJHm/8wwHV0v77FCJJYzSrRt+MsMV9W4eRUbhHOGUWLytqOsELNWMkqs3uMO
	YrMJaErsO7mJHaRIRGA2q8ThxR2MIAlmgTqJNc9msYDYwgLeErcWX2cDsUUEgiSmr7rJBGHr
	STxvvQdUw8HBIqAqMf2TJkiYV8BaovvoZbBWTgEbifvftoO1MgrISjxa+YsdYry4xK0n85kg
	XhCUWDR7D9Q7YhL/dj1kg7B1JM5ef8IIYRtIbF26jwXCVpL407EQ6kw9iRtTp7BB2NoSyxa+
	Zoa4QVDi5Mwn4ICUEGjiktgx9zrUUBeJWX86oZYJS7w6voUdwpaR+L9zPtMERu1ZSO6bhWTH
	LCQ7ZiHZsYCRZRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZgajv97/iXHYzLX33UO8TI
	xMF4iFGCg1lJhJfZ0SZViDclsbIqtSg/vqg0J7X4EKM0B4uSOK9qinyqkEB6YklqdmpqQWoR
	TJaJg1OqgWmFlNN05d2HDmTuLhbQrGa7XyAV23fO1y3eUtbgiZjfQ74L7h7+UzYniP09s/uw
	3Zd5C/Jj71spHlT+8KI/M63ugPf9qvX7n97+cbuU9Vt7rvzv7d2n7mWwV02WvKXYGx6osVFc
	l/HEyot/RJxiuq4evPP94oXu/cGLdy3Lvnfswfptdde2frwb+VPeZPXuiF9hLsvtNWZO+utb
	GH+oxePW0ugaoT3TFJc9bvcU/Vaqbam0OWjhs1DzWN+sxUEXNcWeLDjt0LQ7YkeLSADngW3R
	nXkHrplbfXznr82n+7LSykiCW7282vjMCd+NNldFVl5Z7zDT8shMsUPpX8Q1N7Xeavx7P6W+
	4XLg81PrClOVWIozEg21mIuKEwGbRGDd3AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsVy+t/xu7qMVbapBkc3mFvMWb+GzWL13X42
	i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
	MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKD2bovzSklSF
	jPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MK9tmsxSsFq9Y+vE0
	ewPjJuEuRk4OCQETia6X91i7GLk4hASWMkr0TZvBDJGQkdj45SorhC0s8edaFxtE0UdGiSVn
	XzNBOGcYJc7faWaEcFYySrya/IEFpIVNQFNi38lN7CAJEYHZrBKHF3cwgiSYBeok1jybBVYk
	LOAtcWvxdTYQW0QgSOL4x6nMELaexPPWe0A1HBwsAqoS0z9pgoR5Bawluo9eBgsLCeRK9Ldl
	goQ5BWwk7n/bDjaFUUBW4tHKX+wQm8Qlbj2ZzwTxgYDEkj3noT4TlXj5+B/UZzoSZ68/YYSw
	DSS2Lt3HAmErSfzpWAh1sZ7EjalT2CBsbYllC18zQ5wjKHFy5hOWCYzSs5Csm4WkZRaSlllI
	WhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQITE/bjv3csoNx5auPeocYmTgYDzFKcDAr
	ifAyO9qkCvGmJFZWpRblxxeV5qQWH2I0BYbQRGYp0eR8YILMK4k3NDMwNTQxszQwtTQzVhLn
	9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgSr2q7VV9+HT5lx2zTu/N97C6+Fyy1nnjz6eXPux6
	ulttHZMtu1hh07z2JXLt157P7kioUk349e5HHNPijbLsYg0zz37KLHQMWdrxs6JZOvbC4w3P
	pzX9XfdEf/H29MXMot/OBwpOvhC1MHv2UcXPeT9WTRBMflCbwniooNU1VE9/UxpbQ86h+Rv3
	qx8XyPFbeF3Er+VCdWuMe13prGtiea8MHz3fzV0z54TW74MiFoc0mC+ZtPBNkd18lnuG1DUp
	BqO1ilVMy+rdFuasESy6IvFD/1ti0/tMv/V3+TZfW1F71Ipp1Sq/DJO1/zVmtl9K2Xtz3qZL
	XQE+PnGGYTsqdtZ8TOw13tibOzWSefOJQCWW4oxEQy3mouJEAMITPVjYAwAA
X-CMS-MailID: 20231028211545eucas1p2da564864423007a5ab006cdd1ab4d4a1
X-Msg-Generator: CA
X-RootMTR: 20231028211545eucas1p2da564864423007a5ab006cdd1ab4d4a1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231028211545eucas1p2da564864423007a5ab006cdd1ab4d4a1
References: <20230919135536.2165715-1-da.gomez@samsung.com>
	<20231028211518.3424020-1-da.gomez@samsung.com>
	<CGME20231028211545eucas1p2da564864423007a5ab006cdd1ab4d4a1@eucas1p2.samsung.com>

To be able to trace and account for order of the folio.

Based on include/trace/filemap.h.

Update MAINTAINERS file list for SHMEM.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 MAINTAINERS                  |  1 +
 include/trace/events/shmem.h | 52 ++++++++++++++++++++++++++++++++++++
 mm/shmem.c                   |  4 +++
 3 files changed, 57 insertions(+)
 create mode 100644 include/trace/events/shmem.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bdc4638b2df5..befa63e7cb28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21923,6 +21923,7 @@ M:	Hugh Dickins <hughd@google.com>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	include/linux/shmem_fs.h
+F:	include/trace/events/shmem.h
 F:	mm/shmem.c
=20
 TOMOYO SECURITY MODULE
diff --git a/include/trace/events/shmem.h b/include/trace/events/shmem.h
new file mode 100644
index 000000000000..223f78f11457
--- /dev/null
+++ b/include/trace/events/shmem.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM shmem
+
+#if !defined(_TRACE_SHMEM_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SHMEM_H
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(mm_shmem_op_page_cache,
+
+	TP_PROTO(struct folio *folio),
+
+	TP_ARGS(folio),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, pfn)
+		__field(unsigned long, i_ino)
+		__field(unsigned long, index)
+		__field(dev_t, s_dev)
+		__field(unsigned char, order)
+	),
+
+	TP_fast_assign(
+		__entry->pfn =3D folio_pfn(folio);
+		__entry->i_ino =3D folio->mapping->host->i_ino;
+		__entry->index =3D folio->index;
+		if (folio->mapping->host->i_sb)
+			__entry->s_dev =3D folio->mapping->host->i_sb->s_dev;
+		else
+			__entry->s_dev =3D folio->mapping->host->i_rdev;
+		__entry->order =3D folio_order(folio);
+	),
+
+	TP_printk("dev %d:%d ino %lx pfn=3D0x%lx ofs=3D%lu order=3D%u",
+		MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
+		__entry->i_ino,
+		__entry->pfn,
+		__entry->index << PAGE_SHIFT,
+		__entry->order)
+);
+
+DEFINE_EVENT(mm_shmem_op_page_cache, mm_shmem_add_to_page_cache,
+	TP_PROTO(struct folio *folio),
+	TP_ARGS(folio)
+	);
+
+#endif /* _TRACE_SHMEM_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/shmem.c b/mm/shmem.c
index ab31d2880e5d..e2893cf2287f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -84,6 +84,9 @@ static struct vfsmount *shm_mnt __ro_after_init;
=20
 #include "internal.h"
=20
+#define CREATE_TRACE_POINTS
+#include <trace/events/shmem.h>
+
 #define VM_ACCT(size)    (PAGE_ALIGN(size) >> PAGE_SHIFT)
=20
 /* Pretend that each entry is of this size in directory's i_size */
@@ -1726,6 +1729,7 @@ static struct folio *shmem_alloc_and_add_folio(gfp_t =
gfp,
 		}
 	}
=20
+	trace_mm_shmem_add_to_page_cache(folio);
 	shmem_recalc_inode(inode, pages, 0);
 	folio_add_lru(folio);
 	return folio;
--=20
2.39.2

