Return-Path: <linux-fsdevel+bounces-79666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBsXI4k5q2nZbAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 21:31:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E218E227841
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 21:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91AB9307B227
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 20:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB2B3793AB;
	Fri,  6 Mar 2026 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lf5sZqK9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1759113AA2D
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772829052; cv=none; b=XUAhZ+HQJIAp/QSo54+Y3Msqfa3QPK0150maCpNXJX8J5EAR2MMpTNg1NEqv3D3jnd5IpYBVYyvwoxMZHYczfBXJXnLbWWIQd+TdhUTQwjGe6T41RmeYG5G/RQ82wbKXnK2+RrqUSDBaEqdGyphATP72jYc6pxpB8KVozo243C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772829052; c=relaxed/simple;
	bh=YmC+F54J3lrxGj0/scpVc7eZoatE1MdmYUym4wBHbzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HvA8Wxb6Nbskn5JDqdtM9i2QkDn58ud+gs1GPfjRJaFom1mscvdetqPD7n4lKjfJEaeCbBBQdSW5H3CUPgWbfBdDuAifEIAjcvfe/iAvlIHkAYvz90Y85irPxQdpygzGoQpL0JVPxu6zTmRs64CSueIsXwLNwVGn7o5TaogNkbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lf5sZqK9; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb39f64348so954399085a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2026 12:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772829049; x=1773433849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NAflFpld1ziWQP59fOhP77lxkMaSDWfKofqGmD46Gx4=;
        b=Lf5sZqK9/7m96dbDRoGxg/M7OgI/WMvK46CO/B4zeUuStcf8eh7OB8NCGvWaY4hw8N
         W4k8BImGhBswleV5SYBjYb7txk+0desJ3ZW6EHI1WwcywJszHZBad52q84NaSeVUlZ+0
         T536NqXhulgS0npMPIBunsZHsjJBlfQtyN/whk5I1dsbulvd9zvP82dh2EiMRMQ7nhHJ
         Gd7AUbctS4zoz4GQzkoD0NaOiFCwDmAc5Zj+txX50pPYlGPpF5Kl5A1ay54EYptFuaVs
         4GfbzEjN7Jk9gZqbFK6h4CKfbPffUt302N/RtX+G7YitZY5OgGhBaGj9uMUS9H6eQh44
         pxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772829049; x=1773433849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAflFpld1ziWQP59fOhP77lxkMaSDWfKofqGmD46Gx4=;
        b=QO5vx97MqeR+o64/zrQD98vlLHxSiU/JdgH7dw6HbO82e0SZRNQAWakusVl6PQG6Sa
         wv+CglG8CayI+GZYyL64bLvc8jw2LEmWxVmNNB7aIeACK+TE1o6CRmAWYG6hR0umsveg
         xMhpGwMGoKnoJ9DzTfQuNPJq97cIH8DfFP/cSNi0oluKYkAt0rUiwHM/2VJ0kyvfyART
         L/GuM+Ic1xDwveWaolGYRLokLupP5b656s0GxboJjYdVq3kpWmzEgJ0apitO7BlkBuTe
         qfhygFEq1OYpKPlSfvK7OSpK32JwMif75b/ipaMYIUD5OvrO+2EZMU8MWQqBI64rzWwc
         jXPw==
X-Forwarded-Encrypted: i=1; AJvYcCVT8ZU29U2W1d5WlitTTivX8bctSNf1ckAUmkZ6uHVBLtqTdwIpDDfRFzNIdKIx10ZS8p3M7F+GlCbxa1LQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwnbJNasyJsZZOQOjAVOmSF8BP60pBcjP6xnq+RFKh5ea8tvGrZ
	RNCtFcMp+fwJ4QQ2hGNHQN5ccDUKItECH9DEshfloBAMdeiXHlGoOtht
X-Gm-Gg: ATEYQzwD0HD2ZqeCaajs0FUMGI063OPWSUfKGoUejHFre+/SkqlC4MlU0rb+DDMdVp7
	ZODEyTl1VHI2zZ1vdwtW6oCXma/T9bu/fdBuEWIth8NVKor0BUrMEcxXP7cRNm3WwQ0UfEG6MVm
	kHhAZiUgRhokb59NAVs5IK+N8PVUNhP9yAZIPpD6Jb5sCsrudd10YGXLh9z3N3IMAUyO0v21Aw7
	A2p/cJ2japg+jMAxsILI4NihUrbkDQBbz+8pAb8m0BbdC2PgItyxbjARVU7S2gsxUwT+NfN+x+d
	jO4PmtRZa4nH/U/51rYGhTzfLeoTcLlDT+pqHH1LQolEXGdC6/pUbZT6YzXZ9pyUIZ53Fq0IeKC
	pwEuxSIswHgs7utPKTn3WvgHt+VaSaE96y9/7NvdqpseIqWOMmGyI1bIOD5D6SbKzGIENful+H2
	IRzXSXOuoiGHO3fxBHEyQyBnMPsrEQCqfnje5KUEa82nkVLqNJfpXRRK3jfKJy/5rwJRcmUDoyU
	/R/
X-Received: by 2002:a05:620a:468a:b0:8ca:2baa:76e with SMTP id af79cd13be357-8cd6d35b59amr471988985a.19.1772829048832;
        Fri, 06 Mar 2026 12:30:48 -0800 (PST)
Received: from instance-20260207-1316.vcn12250046.oraclevcn.com ([150.136.248.187])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd6f53b83esm183253785a.29.2026.03.06.12.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 12:30:48 -0800 (PST)
From: Josh Law <hlcj1234567@gmail.com>
X-Google-Original-From: Josh Law <objecting@objecting.org>
To: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2] lib/idr: fix ida_find_first_range() missing IDs across chunk boundaries
Date: Fri,  6 Mar 2026 20:30:47 +0000
Message-ID: <20260306203047.2821852-1-objecting@objecting.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E218E227841
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79666-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hlcj1234567@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.962];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,objecting.org:mid,objecting.org:email,intel.com:email,ziepe.ca:email]
X-Rspamd-Action: no action

From: Josh Law <objecting@objecting.org>

ida_find_first_range() only examines the first XArray entry returned by
xa_find(). If that entry does not contain a set bit at or above the
requested offset, the function returns -ENOENT without searching
subsequent entries, even though later chunks may contain allocated IDs
within the requested range.

For example, a DRM driver using IDA to manage connector IDs may allocate
IDs across multiple 1024-bit IDA chunks. If early IDs are freed and the
driver calls ida_find_first_range() with a min that falls into a
sparsely populated first chunk, valid IDs in higher chunks are silently
missed. This can cause the driver to incorrectly conclude no connectors
exist in the queried range, leading to stale connector state or failed
hotplug detection.

Fix this by looping over xa_find()/xa_find_after() to continue searching
subsequent entries when the current one has no matching bit.

Fixes: 7fe6b987166b ("ida: Add ida_find_first_range()")
Cc: Yi Liu <yi.l.liu@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/idr.c      | 55 ++++++++++++++++++++++----------------------------
 lib/test_ida.c | 14 +++++++++++++
 2 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/lib/idr.c b/lib/idr.c
index 69bee5369670..1649f41016e7 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -495,10 +495,9 @@ int ida_find_first_range(struct ida *ida, unsigned int min, unsigned int max)
 	unsigned long index = min / IDA_BITMAP_BITS;
 	unsigned int offset = min % IDA_BITMAP_BITS;
 	unsigned long *addr, size, bit;
-	unsigned long tmp = 0;
+	unsigned long tmp;
 	unsigned long flags;
 	void *entry;
-	int ret;
 
 	if ((int)min < 0)
 		return -EINVAL;
@@ -508,40 +507,34 @@ int ida_find_first_range(struct ida *ida, unsigned int min, unsigned int max)
 	xa_lock_irqsave(&ida->xa, flags);
 
 	entry = xa_find(&ida->xa, &index, max / IDA_BITMAP_BITS, XA_PRESENT);
-	if (!entry) {
-		ret = -ENOENT;
-		goto err_unlock;
-	}
-
-	if (index > min / IDA_BITMAP_BITS)
-		offset = 0;
-	if (index * IDA_BITMAP_BITS + offset > max) {
-		ret = -ENOENT;
-		goto err_unlock;
-	}
-
-	if (xa_is_value(entry)) {
-		tmp = xa_to_value(entry);
-		addr = &tmp;
-		size = BITS_PER_XA_VALUE;
-	} else {
-		addr = ((struct ida_bitmap *)entry)->bitmap;
-		size = IDA_BITMAP_BITS;
-	}
-
-	bit = find_next_bit(addr, size, offset);
+	while (entry) {
+		if (index > min / IDA_BITMAP_BITS)
+			offset = 0;
+		if (index * IDA_BITMAP_BITS + offset > max)
+			break;
 
-	xa_unlock_irqrestore(&ida->xa, flags);
+		if (xa_is_value(entry)) {
+			tmp = xa_to_value(entry);
+			addr = &tmp;
+			size = BITS_PER_XA_VALUE;
+		} else {
+			addr = ((struct ida_bitmap *)entry)->bitmap;
+			size = IDA_BITMAP_BITS;
+		}
 
-	if (bit == size ||
-	    index * IDA_BITMAP_BITS + bit > max)
-		return -ENOENT;
+		bit = find_next_bit(addr, size, offset);
+		if (bit < size &&
+		    index * IDA_BITMAP_BITS + bit <= max) {
+			xa_unlock_irqrestore(&ida->xa, flags);
+			return index * IDA_BITMAP_BITS + bit;
+		}
 
-	return index * IDA_BITMAP_BITS + bit;
+		entry = xa_find_after(&ida->xa, &index,
+				      max / IDA_BITMAP_BITS, XA_PRESENT);
+	}
 
-err_unlock:
 	xa_unlock_irqrestore(&ida->xa, flags);
-	return ret;
+	return -ENOENT;
 }
 EXPORT_SYMBOL(ida_find_first_range);
 
diff --git a/lib/test_ida.c b/lib/test_ida.c
index 63078f8dc13f..d242549e16b6 100644
--- a/lib/test_ida.c
+++ b/lib/test_ida.c
@@ -256,6 +256,20 @@ static void ida_check_find_first(struct ida *ida)
 	ida_free(ida, (1 << 20) - 1);
 
 	IDA_BUG_ON(ida, !ida_is_empty(ida));
+
+	/* 
+	 * Test cross-chunk search.
+	 * Allocate ID in chunk 0 and ID in chunk 1.
+	 * Search for ID >= 1. min=1 maps to chunk 0. Chunk 0 has no IDs >= 1.
+	 * It should continue to chunk 1 and return 1024.
+	 */
+	IDA_BUG_ON(ida, ida_alloc_min(ida, 0, GFP_KERNEL) != 0);
+	IDA_BUG_ON(ida, ida_alloc_min(ida, 1024, GFP_KERNEL) != 1024);
+	IDA_BUG_ON(ida, ida_find_first_range(ida, 1, INT_MAX) != 1024);
+	ida_free(ida, 0);
+	ida_free(ida, 1024);
+
+	IDA_BUG_ON(ida, !ida_is_empty(ida));
 }
 
 static DEFINE_IDA(ida);
-- 
2.43.0


