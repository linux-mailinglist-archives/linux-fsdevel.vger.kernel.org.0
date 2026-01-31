Return-Path: <linux-fsdevel+bounces-75974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CASbEtdJfWlZRQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 01:16:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AADB4BF8E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 01:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 897C0303D700
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 00:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62D82FDC27;
	Sat, 31 Jan 2026 00:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1zPPWW9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260BB2F5A3D
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jan 2026 00:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769818549; cv=none; b=SjZ1u4Z124wmhUzTyYFVDUVOkqhmn3J52RC+IgxQM450qcDGMBzRZiEFOTWsQcywzxR0RiF7e3HwsLUVCVpdlrCjmaPzzxAGi2xXUBvaPc9ZCKcCYbo8ldkiZjGYLFV+yYhiBP06CxvP5wxJCTmDYEHi/IpXU5A3nAP4vGPcha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769818549; c=relaxed/simple;
	bh=yh5kAh18cBogYAATy2I7lcJQCwjv7XVTR/hdtC7DjdU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oqlp6IEa10LxZqjEt0sqGJO/pNHNj09SGAbVXiuMb5Yrbc5KaTVaE+DChLcwHxOdjGJcXfdpowkz7KeQkJ3mawA1zNU1UbI3iJr7qgGCKt4k1rgcB4iSAHIA4SRBG2qqzLABxJcKHWdbIZ+bYOvv1c+MCGE16vAF/i9Qo0gxIEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u1zPPWW9; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c5291b89733so1669142a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 16:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769818547; x=1770423347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JBT3eXirMhITfHBhMfm7jmk9GgDGwvmhXO+L7+fYBQE=;
        b=u1zPPWW9tboKsJs7a6EIfO7xX69K9uslVUqrd1quQZAq0pDUzzryhTqV7iL1FVOSUi
         9sgrSUjOIHDdcw2DKRlWjcNdV4qxWjbhR4Ourf2OGRMknYhb9zyUoIfdgq5WMlWjhh20
         MhU4NajepoNh05vUvp5tnWOSVKRX1Uks/8PBMNKzdPcGnppy37cikocuazJKU7179urR
         yfcBaPHWlY+0khv05igQul1lkmpFA+ec2drJPkXqFHADda1ml73sKjBn0Bx19m9vulXN
         IvxTugppoN6Qyek0wYqFX+89QIZzEWsqdtSrFU+tj++vSmJ3z5VNh0OJJXlaj8ZOFCS3
         UiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769818547; x=1770423347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBT3eXirMhITfHBhMfm7jmk9GgDGwvmhXO+L7+fYBQE=;
        b=MSP5HyZfc8w7xtvOSMupUoo96y/gOwVZZfCLsJ+7hkvAPevTBVMt9F2xYirxqNYDpq
         thjNJf/g0rbiz7D8Lt6HmXVXpwRfpXsZ6WGwc9DLu6MmWcLu1397c8lPPTPh1YCuynDG
         DeUTLIa5NTZFIKxtTvAz3NkdWX54rVbPAjExgfMtEVupmE/9yrc3x3qkyRMd0PRXhA6D
         Ualy6GQ4I12bdo8gLXiM0kmL6krcvkB4hI/4YmyFp2Y+Fcgazmp99zamr8tyz/LjY5ac
         LKNTOIjhQAjKi8wdaBnml45mnT+cVYrXOoA1M+CHbdrtb0DBwtXK+z8JIMenj6wjNAzB
         31MA==
X-Forwarded-Encrypted: i=1; AJvYcCWXsRK8BWA6z2EnDtR01J+4IdG0Ti1WxQcrbvzLLgjS/JaRf1qLg3aIT04tBWBfpeMJZRXQLDFZ9MhQbjvS@vger.kernel.org
X-Gm-Message-State: AOJu0YyEGN9a+0gVtochn5ZaY4OA2lWuMZTg1KYrEHHVFVZS7PSIzkIK
	8IoHcwEr0NELsKG4NC7CJTTXlp5xUrN4dTBbs9rSioIEksZNiAwxBb4x474cGmkbCyigkb1EULB
	Uizmm4EJyLjJn8NZSnTxMN8RvFg==
X-Received: from plgx11.prod.google.com ([2002:a17:902:ec8b:b0:2a8:7205:a979])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:244b:b0:38d:f745:4d43 with SMTP id adf61e73a8af0-392e01329b9mr4952220637.57.1769818547428;
 Fri, 30 Jan 2026 16:15:47 -0800 (PST)
Date: Fri, 30 Jan 2026 16:15:37 -0800
In-Reply-To: <cover.1769818406.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1769818406.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <720e32d8e185d5c82659bbdede05e87b3318c413.1769818406.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 1/2] XArray tests: Fix check_split tests to store correctly
From: Ackerley Tng <ackerleytng@google.com>
To: willy@infradead.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: david@redhat.com, michael.roth@amd.com, dev.jain@arm.com, 
	vannapurve@google.com, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75974-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AADB4BF8E4
X-Rspamd-Action: no action

__xa_store() does not set up xas->xa_sibs, and when it calls xas_store(),
xas_store() stops prematurely and does not update node->nr_values to count
all values and siblings. Hence, when working with multi-index XArrays,
__xa_store() cannot be used.

Fix tests by calling xas_store() directly with xas->xa_sibs correctly set
up.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 lib/test_xarray.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 5ca0aefee9aa..e71e8ff76900 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1846,8 +1846,14 @@ static void check_split_1(struct xarray *xa, unsigned long index,
 	xas_split_alloc(&xas, xa, order, GFP_KERNEL);
 	xas_lock(&xas);
 	xas_split(&xas, xa, order);
-	for (i = 0; i < (1 << order); i += (1 << new_order))
-		__xa_store(xa, index + i, xa_mk_index(index + i), 0);
+	for (i = 0; i < (1 << order); i += (1 << new_order)) {
+		xas_set_order(&xas, index + i, new_order);
+		/*
+		 * Don't worry about -ENOMEM, xas_split_alloc() and
+		 * xas_split() ensures that all nodes are allocated.
+		 */
+		xas_store(&xas, xa_mk_index(index + i));
+	}
 	xas_unlock(&xas);
 
 	for (i = 0; i < (1 << order); i++) {
@@ -1893,8 +1899,14 @@ static void check_split_2(struct xarray *xa, unsigned long index,
 		xas_unlock(&xas);
 		goto out;
 	}
-	for (i = 0; i < (1 << order); i += (1 << new_order))
-		__xa_store(xa, index + i, xa_mk_index(index + i), 0);
+	for (i = 0; i < (1 << order); i += (1 << new_order)) {
+		xas_set_order(&xas, index + i, new_order);
+		/*
+		 * Don't worry about -ENOMEM, xas_split_alloc() and
+		 * xas_split() ensures that all nodes are allocated.
+		 */
+		xas_store(&xas, xa_mk_index(index + i));
+	}
 	xas_unlock(&xas);
 
 	for (i = 0; i < (1 << order); i++) {
-- 
2.53.0.rc1.225.gd81095ad13-goog


