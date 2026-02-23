Return-Path: <linux-fsdevel+bounces-77919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHk7MGoDnGkn/AMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 08:36:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC45172BFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 08:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 173B630364E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 07:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4DC34CFC4;
	Mon, 23 Feb 2026 07:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wr9mKf6G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D3234BA2E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771832068; cv=none; b=X9asSdN+Xo1NYyaqnnBwUJhvFdOzyeRrmSLxtj9/ZDZJrj4Q8EgNUh0unvuMe7SGTUwRQcBL/LJ+K4GUBzqmqkyhs4K1LJmSd2aRBoQ/f3JL9kx4EMnc8x///sP7jJdM1jFKyVw4NEYlJmb40zlbTtkr6ENfT4Y3CdCqv/muw4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771832068; c=relaxed/simple;
	bh=iq53DsPecxUJv9f/n8TBeugQc53j2Da8dw7zuDKVyiI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FeX37oQF9j/zYetEPb23xTePXR4dR9js2OgNHPAf/CZtsnyixWkUepfKa/UPhIIExVYfcrTM10UjnJ+j8fc6mJz6CcPLBwBbauuw3FzxsKH34SaAFbnbzC11n2irfHajDMUjkjRw/Yxh6xIAsfDtMzAq10hcHu4ZduuiL85edok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wr9mKf6G; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35620e2faf0so3299341a91.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Feb 2026 23:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771832066; x=1772436866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H4IDTTN2imEE24tZz4W9ct9niFiZM+M1v4/EEqKS/dA=;
        b=Wr9mKf6G1NW6hbUa9sz4KKHVwn2byXn5Bh8UQ9qmm3g8Gu0b+i8GaaDfqDiTs8og+E
         LuG0pXvdJN8s18X3ddmUEg24eUh3uYXd10a/BL4pknZKCHjGZ0RZ41mOasI/6V0gKb+2
         5gXcvEtypUnCEjmd3h9sYWqB/TbQdbF08D/z5WNZGi4v9XdQ+yrqfTkP4TlR1YpOXjue
         lbuSZEyEz4q2EelKW8pT9QEtGTxgEW8kBTYxxCAHJaU4Ljz90PiHq0fEPXR82shLOCHb
         6gWT7h6A6wh4jN61LBxwSJQZ0qs1muDPVMK2P64LFR5UtaaVeiz3VvGiqZzO+iTV/h7g
         FOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771832066; x=1772436866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4IDTTN2imEE24tZz4W9ct9niFiZM+M1v4/EEqKS/dA=;
        b=Fmy2zC3bNQJvw7GD4lVphY/Zs2by56H26TGSi5SpuBvb+GvDeCbSGKdoWK9Pj6z5WD
         ADHpZGAUaW6wVLmK5TAUWbWELcoBNDyH+cOnuntJ+F9Rl+ldifEVgcTVZrM5ba4qXYDo
         qt79VEnOHOMEjDzDXdK5W1fysmg0iHRgEDM9XO/iCclPkdC7D5fTmZiw0v+skuHBUge4
         bpz6jYFGmec1vBEigCU6QicLiJSqEMlS3gT/reT47tJKECSUFT/+KHMQn1kgpHbW14dj
         ROHw1eGYcOCUGKfyLraMCE/E2I8jGjW5a4luwa+ateeHFrzmULcrKdluMn7+q+9PzAOy
         lhmw==
X-Forwarded-Encrypted: i=1; AJvYcCXGNyZM0d1HRR0SLGTiJoNsaOsKdihegcHRRncUCqDOwxBAsKs9h9QMFDJV6rUlZjY5Kw/kBwE9Y/EkqrUY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw20XYlpDs2sWcDPGOLrVCENghWrBJ0L9z/txgxQ6haJPFlFIKE
	D9QWOij19KJdrlnaEEskCmT0Syeel9GuQy11LUHe/pcZuYsn0lwtbyXKKRYJapv3Sr5u7wS6hQP
	Vj6hk0FkSFAZLWH3W0lYhO+C/5A==
X-Received: from pjbbx20.prod.google.com ([2002:a17:90a:f494:b0:34c:dd6d:b10e])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17c8:b0:353:6373:590b with SMTP id 98e67ed59e1d1-358ae7c352bmr6655610a91.7.1771832066318;
 Sun, 22 Feb 2026 23:34:26 -0800 (PST)
Date: Mon, 23 Feb 2026 07:34:14 +0000
In-Reply-To: <cover.1771831836.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1771831836.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <bad1921421199c3009a773d006c1f8782e90452b.1771831836.git.ackerleytng@google.com>
Subject: [RFC PATCH v3 2/2] XArray tests: Verify xa_erase behavior in check_split
From: Ackerley Tng <ackerleytng@google.com>
To: willy@infradead.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: david@kernel.org, michael.roth@amd.com, dev.jain@arm.com, 
	vannapurve@google.com, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77919-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FC45172BFC
X-Rspamd-Action: no action

Both __xa_store() and xa_erase() use xas_store() under the hood, but when
the entry being stored is NULL (as in the case of xa_erase()),
xas->xa_sibs (and max) is only checked if the next entry is not a sibling,
hence allowing xas_store() to keep iterating, hence updating
node->nr_values correctly.

Add xa_erase() to check_split tests that verify functionality, with the
added intent to illustrate the usage differences between __xa_store(),
xas_store() and xa_erase() with regard to multi-index XArrays.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 lib/test_xarray.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index e71e8ff76900b..bb9471a3df65c 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1874,6 +1874,10 @@ static void check_split_1(struct xarray *xa, unsigned long index,
 	rcu_read_unlock();
 	XA_BUG_ON(xa, found != 1 << (order - new_order));
 
+	for (i = 0; i < (1 << order); i += (1 << new_order))
+		xa_erase(xa, index + i);
+	XA_BUG_ON(xa, !xa_empty(xa));
+
 	xa_destroy(xa);
 }
 
@@ -1926,6 +1930,10 @@ static void check_split_2(struct xarray *xa, unsigned long index,
 	}
 	rcu_read_unlock();
 	XA_BUG_ON(xa, found != 1 << (order - new_order));
+
+	for (i = 0; i < (1 << order); i += (1 << new_order))
+		xa_erase(xa, index + i);
+	XA_BUG_ON(xa, !xa_empty(xa));
 out:
 	xas_destroy(&xas);
 	xa_destroy(xa);
-- 
2.53.0.345.g96ddfc5eaa-goog


