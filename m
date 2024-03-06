Return-Path: <linux-fsdevel+bounces-13833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB3D8743D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 00:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4757A283079
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 23:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E0B1CD05;
	Wed,  6 Mar 2024 23:24:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BA81B5AD;
	Wed,  6 Mar 2024 23:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767451; cv=none; b=J14Smb2POXIMYxUi2okQIgiC8tYarzFgxX8hEXoLksEatdymRQktkYrV9I5sEYaQDoh4ykdU8llKKkx9015bLEAf0LuhX4Tr8XRf5guuNKoNWWROd4nZUauFa+iiLZ+B8bqzrw6nc1Rd/0Tb2CW5BIzPNlqJ+A3b8pP3uF9KDfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767451; c=relaxed/simple;
	bh=/NJQnJUP9KeAbbkS/bZ+JfTIzgdyiZEeY9P1FHS/klc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LSDfH5ZTpdLmspjZk31J8+4duwV8uMpSiFAMSHWvCTkw4A5VltwJHwJ5XEjxUwzD7KlLRSvAjaVZg69qSy4ctT1nyiOthaaZ5o0ebSAELaqrawnWPI29Ec2ebS9ohJYM6fOO79Dprh2vQ7luDaK6WAdoLb/SKOqqjDHp/DTJNPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 31F55644CE7D;
	Thu,  7 Mar 2024 00:24:00 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id oPswx8eCA2gS; Thu,  7 Mar 2024 00:23:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id BA63A644CE7B;
	Thu,  7 Mar 2024 00:23:59 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3UwmHEFZi2bY; Thu,  7 Mar 2024 00:23:59 +0100 (CET)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 474EC644CE7C;
	Thu,  7 Mar 2024 00:23:59 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	upstream+pagemap@sigma-star.at,
	adobriyan@gmail.com,
	wangkefeng.wang@huawei.com,
	ryan.roberts@arm.com,
	hughd@google.com,
	peterx@redhat.com,
	david@redhat.com,
	avagin@google.com,
	lstoakes@gmail.com,
	vbabka@suse.cz,
	akpm@linux-foundation.org,
	usama.anjum@collabora.com,
	corbet@lwn.net,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/2] [RFC] pagemap.rst: Document write bit
Date: Thu,  7 Mar 2024 00:23:39 +0100
Message-Id: <20240306232339.29659-2-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240306232339.29659-1-richard@nod.at>
References: <20240306232339.29659-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Bit 58 denotes that a PTE is writable.
The main use case is detecting CoW mappings.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 Documentation/admin-guide/mm/pagemap.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/adm=
in-guide/mm/pagemap.rst
index f5f065c67615..81ffe3601b96 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -21,7 +21,8 @@ There are four components to pagemap:
     * Bit  56    page exclusively mapped (since 4.2)
     * Bit  57    pte is uffd-wp write-protected (since 5.13) (see
       Documentation/admin-guide/mm/userfaultfd.rst)
-    * Bits 58-60 zero
+    * Bit  58    pte is writable (since 6.10)
+    * Bits 59-60 zero
     * Bit  61    page is file-page or shared-anon (since 3.5)
     * Bit  62    page swapped
     * Bit  63    page present
@@ -37,6 +38,11 @@ There are four components to pagemap:
    precisely which pages are mapped (or in swap) and comparing mapped
    pages between processes.
=20
+   Bit 58 is useful to detect CoW mappings; however, it does not indicat=
e
+   whether the page mapping is writable or not. If an anonymous mapping =
is
+   writable but the write bit is not set, it means that the next write a=
ccess
+   will cause a page fault, and copy-on-write will happen.
+
    Efficient users of this interface will use ``/proc/pid/maps`` to
    determine which areas of memory are actually mapped and llseek to
    skip over unmapped regions.
--=20
2.35.3


