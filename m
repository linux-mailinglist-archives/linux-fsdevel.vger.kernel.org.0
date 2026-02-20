Return-Path: <linux-fsdevel+bounces-77765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C6mM233l2ks+wIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 06:55:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0350E164DB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 06:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1AED6300E191
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 05:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE32832E6AB;
	Fri, 20 Feb 2026 05:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SZ9kflJm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615BA326D4A
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 05:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771566916; cv=none; b=oGuIDPyRcv5qe7QMWYvWdtQ4GIEImGT7vynOuL5cyJLnYUs1ve1W7jFYj+NwDVW1rYDKrE27buk9Asz2sVFQK0TscGcB+Etjv5+dvsOe/HdZaCL5QJZfyh+QTCv5QphjQ/vvpMbwNUmY/BqyqeZr1Y4jSe/DfjNw82nD+0eEzkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771566916; c=relaxed/simple;
	bh=d/Njxo6LsxfyrmnJNgQrbf4Jrkxu+B4X3AZ0DsjVEVo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jI2BPBtnxfv27S/ArK8ygHYPtaw5/ASQPlNaZ32ci5EPOpcVbgVUCORfFRQrPMQodozU4aNYFBI6htBz1HYEZIbVy5rZ8AZdyTt0iPA95IlM02gNTw3uh7+9NV2RRkFRgGbbVOBdsTXbP3N64ozm9qukXMckK4kFrF9zqHPe/pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SZ9kflJm; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aae3810558so22026565ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 21:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771566915; x=1772171715; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ej8LZF1b2o/Ks4R9g/3WwRmZsBfUCiZmdJJkOcGo2tM=;
        b=SZ9kflJmOLf6mfxQZrtOSRooBSwUjxlYGdxn0wXR68/2lgpl9UvUKfnKAVue4uRi7O
         zlf+ld9GMTgb9fO4szslpS75J1Avk2LvZbLEDiOzCVafZteADj2sfHhQXpEyjzE0kWa6
         ZLzDQt0+6QrA1JpfIwn2Wux7dZtwwDsfRD2NeGxKYY8fVCmDa8ktXY4RanZ3vw0RmBK/
         j1AG1U8Ib3IXyE7y1W46/8AC1wgiJzDCSBZrEq2U0vM3+UhwShGaaDFGdOZ5wIwmZiz9
         vuhHTJtiPKXZWH/T3P1TxV14OiIR+T3fEcUpgsPEcSWaqG7hx+S0KMc21HemBrwAFbTK
         6fNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771566915; x=1772171715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ej8LZF1b2o/Ks4R9g/3WwRmZsBfUCiZmdJJkOcGo2tM=;
        b=bTY9XXKmwkf9L4K8AlrmYk9RTXdf4Ib0aXyJhCnu8KJvGkqKK6UvWuay9bZQIEVhOe
         xEbOMX/PECF+tY31HvO7ZZ/gsqeMpCZ5SN4JcUxTAPmgBQs6E+LzLeRzDoZzvoC10dX2
         UbcBzfw5pufDLEejQ6Q1p1/SDE4RI8s35o0FG3yqsX95F7xOsv4qOD9d+zrCa1BY87g0
         VOUAXvqaqsJnog9s2OBAgudvcdUFEpdJsnAA8nnEDFvGf4hgUQJUR0rouh3ful4BQ9lX
         sGVDLpVxtUDyXnHDX0vkLZuSnkXItQfrL1L0U3BRh/nJ3H2CPZgLIoJ8KSux1R83Gagk
         zXXg==
X-Forwarded-Encrypted: i=1; AJvYcCXKVl7Alyblsy9ii+Btj+hCxTLrvRd9xD6hb1VRG3xe8+djTcCuRtqRIjFEtYnwP8iuJwNmVGmpByE0Pf7J@vger.kernel.org
X-Gm-Message-State: AOJu0YwoWqreB4pkCpYgFnFcbeV1JxmbTegGyE8a2igJU1a2WW4kmjsU
	yC+a3Ceez4rdSeD/spVz2oNYj/RnDyOcN98E65Z95X7BOmdE6JOHbnTbfOU7pd4TZZqCoTiKJJW
	IXR0Ee8TmJSXu1qxdwA==
X-Received: from plma8.prod.google.com ([2002:a17:902:7d88:b0:2a0:92b7:79c1])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3bd0:b0:2aa:dc84:251f with SMTP id d9443c01a7336-2ad5aec750dmr47251955ad.2.1771566914488;
 Thu, 19 Feb 2026 21:55:14 -0800 (PST)
Date: Thu, 19 Feb 2026 21:54:46 -0800
In-Reply-To: <20260220055449.3073-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260220055449.3073-1-tjmercier@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260220055449.3073-2-tjmercier@google.com>
Subject: [PATCH v4 1/3] kernfs: Don't set_nlink for directories being removed
From: "T.J. Mercier" <tjmercier@google.com>
To: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77765-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,suse.cz,gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0350E164DB3
X-Rspamd-Action: no action

If a directory is already in the process of removal its i_nlink count
becomes irrelevant because its contents are also about to be removed and
any pending filesystem operations on it or its contents will soon start
to fail. So we can avoid setting it for directories already flagged for
removal.

This avoids a race in the next patch, which adds clearing of the i_nlink
count for kernfs nodes being removed to support inotify delete events.

Use protection from the kernfs_iattr_rwsem to avoid adding more
contention to the kernfs_rwsem for calls to kernfs_refresh_inode.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 fs/kernfs/dir.c   | 2 ++
 fs/kernfs/inode.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 29baeeb97871..5b6ce2351a53 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1491,12 +1491,14 @@ static void __kernfs_remove(struct kernfs_node *kn)
 	pr_debug("kernfs %s: removing\n", kernfs_rcu_name(kn));
 
 	/* prevent new usage by marking all nodes removing and deactivating */
+	down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
 		pos->flags |= KERNFS_REMOVING;
 		if (kernfs_active(pos))
 			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
 	}
+	up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 
 	/* deactivate and unlink the subtree node-by-node */
 	do {
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index a36aaee98dce..afdc4021e81a 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -178,7 +178,7 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 		 */
 		set_inode_attr(inode, attrs);
 
-	if (kernfs_type(kn) == KERNFS_DIR)
+	if (kernfs_type(kn) == KERNFS_DIR && !(kn->flags & KERNFS_REMOVING))
 		set_nlink(inode, kn->dir.subdirs + 2);
 }
 
-- 
2.53.0.414.gf7e9f6c205-goog


