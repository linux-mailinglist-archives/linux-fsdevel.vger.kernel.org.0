Return-Path: <linux-fsdevel+bounces-74888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SILbHcIicWl8eQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:02:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 359705BBD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 789947282D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 17:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613F847DF8C;
	Wed, 21 Jan 2026 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W9rWsL1Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fFbJOGi3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W9rWsL1Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fFbJOGi3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E2399A73
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016499; cv=none; b=C6d73f/Qm8IcI8blwKboUn/7QpgsHGdL1YtzagJCFSUa8rIsvVY9K5jRs9rHK41zkF3rg7PFBn5aWyOeEDxeVFU7n8U6cKiqcCylJep/yngThJPr/hg+q051HGFcpIRDS7lHXVY6NzOLHX0FpoEwuUjMnZMZ+U2WirTqN/Ea6J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016499; c=relaxed/simple;
	bh=WGPfIueft7L7yN1+aQXK+/QOdt0AnbRHeNXhCsLEvOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xg0dKfiR20Rji2k8GXh+PgDDyyG0qt8KyOChm3T+oizTfyv3j0P49X0UUe8Fl4lHsZTpEtODBSO9xWldufXRkoEY1K3NPx5MiZSkGyiVvGsSkx9GFJgEDn4hM9eROr0xHXGSTitUj4/eFpd8xX4CKzda/MivZJqnY9BsJp1Gw7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W9rWsL1Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fFbJOGi3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W9rWsL1Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fFbJOGi3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5393B336F1;
	Wed, 21 Jan 2026 17:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769016474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ibujAzuKWiGRFXhgs1Pm7ASuBW5UrIH/69D/60DQ5G4=;
	b=W9rWsL1ZbiQqHN23N4ZfDpJEf5gYqFYNG05bz4H1SNiWtmJXsb3MGl9+UkzlXkkMUyw9hV
	nznYDQwhlhqi+FvFzL2wWb2urMaLmyjLN/K4CRvkOGA2r2f9GbCyZDZd93/wiUsHaRRde2
	3Xdf9E/A8k058UBmgT2f2NIBfBY44AM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769016474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ibujAzuKWiGRFXhgs1Pm7ASuBW5UrIH/69D/60DQ5G4=;
	b=fFbJOGi37axv962gdvtcuniY/YAOTuAGgWtOYPHmF4UJI0r1CqM20OfOxKEjIOvIzvAdzp
	6dvZIdKWVzpzXODA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=W9rWsL1Z;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fFbJOGi3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769016474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ibujAzuKWiGRFXhgs1Pm7ASuBW5UrIH/69D/60DQ5G4=;
	b=W9rWsL1ZbiQqHN23N4ZfDpJEf5gYqFYNG05bz4H1SNiWtmJXsb3MGl9+UkzlXkkMUyw9hV
	nznYDQwhlhqi+FvFzL2wWb2urMaLmyjLN/K4CRvkOGA2r2f9GbCyZDZd93/wiUsHaRRde2
	3Xdf9E/A8k058UBmgT2f2NIBfBY44AM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769016474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ibujAzuKWiGRFXhgs1Pm7ASuBW5UrIH/69D/60DQ5G4=;
	b=fFbJOGi37axv962gdvtcuniY/YAOTuAGgWtOYPHmF4UJI0r1CqM20OfOxKEjIOvIzvAdzp
	6dvZIdKWVzpzXODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21F943EA65;
	Wed, 21 Jan 2026 17:27:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uEv1BpoMcWlbHQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 21 Jan 2026 17:27:54 +0000
From: David Disseldorp <ddiss@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 7/8] vsprintf: Revert "add simple_strntoul"
Date: Thu, 22 Jan 2026 04:12:55 +1100
Message-ID: <20260121172749.32322-8-ddiss@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121172749.32322-1-ddiss@suse.de>
References: <20260121172749.32322-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74888-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[ddiss@suse.de,linux-fsdevel@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[suse.de,none];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 359705BBD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

No users anymore and none should be in the first place.

This reverts commit fcc155008a20fa31b01569e105250490750f0687.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/kstrtox.h | 1 -
 lib/vsprintf.c          | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
index 6ea897222af1d..7fcf29a4e0de4 100644
--- a/include/linux/kstrtox.h
+++ b/include/linux/kstrtox.h
@@ -143,7 +143,6 @@ static inline int __must_check kstrtos32_from_user(const char __user *s, size_t
  */
 
 extern unsigned long simple_strtoul(const char *,char **,unsigned int);
-extern unsigned long simple_strntoul(const char *,char **,unsigned int,size_t);
 extern long simple_strtol(const char *,char **,unsigned int);
 extern unsigned long long simple_strtoull(const char *,char **,unsigned int);
 extern long long simple_strtoll(const char *,char **,unsigned int);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index a3790c43a0aba..362a3d9ad62ec 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -128,13 +128,6 @@ unsigned long simple_strtoul(const char *cp, char **endp, unsigned int base)
 }
 EXPORT_SYMBOL(simple_strtoul);
 
-unsigned long simple_strntoul(const char *cp, char **endp, unsigned int base,
-			      size_t max_chars)
-{
-	return simple_strntoull(cp, endp, base, max_chars);
-}
-EXPORT_SYMBOL(simple_strntoul);
-
 /**
  * simple_strtol - convert a string to a signed long
  * @cp: The start of the string
-- 
2.51.0


