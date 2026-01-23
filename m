Return-Path: <linux-fsdevel+bounces-75302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCbBFlKQc2l0xAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 16:14:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0528777980
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 16:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72ED23012B98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C452E6CD0;
	Fri, 23 Jan 2026 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="hkgh8H4u";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="Is2SBDXd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58204225416
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180800; cv=none; b=XrgwWzvWqLxq+BmRjcJFNcRQtaURiV32ErlTH7yfUDmwCQOkRNQOMmxN1QYSwMZ94WnXHXrSQARFL01RzabD6viwhusrIkZukQ8+7BMqMhRDHRmKqR/oapSr8ipTl+VYeWerhO/Np8OGKBNNBh0iQytxRBUUuHEoYG1b+FTabMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180800; c=relaxed/simple;
	bh=XtiAGoBQ1blzOcjTq8pgxagTyavwnvETQwdQ0jnB2rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTy0/+3VVTGcYT3JaGdHaYSN3ptrrqmObknwbEtHhldEhYooQrpQdF60rp185qonhS5ok1a5W5Uhy5wghnYn6G6nYLPWehxdJIX0D61awzxM0Gt2R9Z2T/9oG1fb0jUG5jLHEWMsfuXZ1aZTDs1Pr50qaVjguir3xAb90dxL4+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=hkgh8H4u reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=Is2SBDXd; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1769181699; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=5hlZx6sa9MG8kpnxvIumfa5wATQurfzuGf1yx1tG58U=; b=hkgh8H4uBpFWL00bKwzTNtakru
	GA4XC/mw5vcYxDjmh7EKDhSQTC0LZf3kOcMOsaRYwyjtukTQ5QS2Z08cXDuac7CabCP11WT/KQh/4
	sZs4+MHJ0cZSe/9u80UjuETuaUwVyY7ua5xiVTONpmrKQYToLjDB1o0o7DZ1MsLYIM3hi2spDxBuB
	LjoEscLyMTGuzaKpLpgTQxiHkQwVVsUm5TQUuuFvd/kdYwDbWTDh/XZjR5weqKm1xQgd4bdOgmv7A
	zeqKkb6MsttNfQgjscm4dRuru9kKR+GTjxhThXJXor4OgfN+gXoOGmrEU5FSrAiDgvCkDiWsM1ppz
	1bwkhZhw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1769180799; h=from : subject
 : to : message-id : date;
 bh=5hlZx6sa9MG8kpnxvIumfa5wATQurfzuGf1yx1tG58U=;
 b=Is2SBDXdG1UDMS3KD0JTPkOTeLWJ2NuFxkRP1zZHp1FmQtMFEq2/jyILFnj5NQM5AKc/k
 g6y8qYDJ73ii0ExJwDhgqbFus+dAy/BVPS4iyX5CmCEYRekH5FM1SxjVaBYEemmyfaTN90j
 Q04o6VtNqmuzP03poh8kAyg1K7nkc9UH0bDbNNQinXxH+E6/kzNZk3Se7lHhQbKzNCcqQG+
 jSeMn4wkBwg/iYv05jB7GAyhXBd3Jy0hEpZOGhNWiSgtBD2Hz/L6NS4IiAcLeaMluGd/msN
 Kf5INNGEiLoRIIV8UAw84on+f98bHT08r/cLnCeRl/7x/2VfiCRwbdkcjZVA==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vjIjN-TRk3Nn-Sa; Fri, 23 Jan 2026 15:05:49 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vjIjN-AIkwcC8p21S-ImA4; Fri, 23 Jan 2026 15:05:49 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 v9fs@lists.linux.dev
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2 1/2] wait: Introduce io_wait_event_killable()
Date: Fri, 23 Jan 2026 15:48:07 +0100
Message-ID: <1b2870001ecd34fe6c05be2ddfefb3c798b11701.1769179462.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1769179462.git.repk@triplefau.lt>
References: <cover.1769179462.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: fA2OeBO86Rys.IIhATsx7FrMK.DvUe7gYHbxu
Feedback-ID: 510616m:510616apGKSTK:510616siuLes3UuY
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[triplefau.lt,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[triplefau.lt:s=s510616];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_MIXED(0.00)[];
	TAGGED_FROM(0.00)[bounces-75302-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_PERMFAIL(0.00)[smtpservice.net:s=maxzs0.a1-4.dyn];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[repk@triplefau.lt,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[smtpservice.net:~,triplefau.lt:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 0528777980
X-Rspamd-Action: no action

Add io_wait_event_killable(), a variant of wait_event_killable() that
uses io_schedule() instead of schedule(). This is to be used in
situation where waiting time is to be accounted as IO wait time.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/wait.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index f648044466d5..dce055e6add3 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -937,6 +937,21 @@ extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
 	__ret;									\
 })
 
+#define __io_wait_event_killable(wq, condition)					\
+	___wait_event(wq, condition, TASK_KILLABLE, 0, 0, io_schedule())
+
+/*
+ * wait_event_killable() - link wait_event_killable but with io_schedule()
+ */
+#define io_wait_event_killable(wq_head, condition)				\
+({										\
+	int __ret = 0;								\
+	might_sleep();								\
+	if (!(condition))							\
+		__ret = __io_wait_event_killable(wq_head, condition);		\
+	__ret;									\
+})
+
 #define __wait_event_state(wq, condition, state)				\
 	___wait_event(wq, condition, state, 0, 0, schedule())
 
-- 
2.50.1


