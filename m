Return-Path: <linux-fsdevel+bounces-74731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAcCEynxb2m+UQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:18:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E50DB4C1D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B96966E710
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C76E3AEF2D;
	Tue, 20 Jan 2026 20:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHZQIU1X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DF33BB9F2
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 20:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768942110; cv=none; b=SH7GilOYzxlmWIPPdkjLseXp1ro3ft0UJULtVpfADLMP1rwhutHXJs3ubo3O0JWUVSRBBxO2mrrEmSQc4LYXFdJItxYjQF/ZYdt2EIW1sv3lLrv32aBKy6l8v3TdwGq1hyx311DWk78TTIuKwxMY9rkI48E2OG62qLt9MteilJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768942110; c=relaxed/simple;
	bh=idZzD+qmASeZyd4nOwqF6riq/XRhSnW4bOxcRz99q4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uDGVJeOE2HjqNzGUULmXYh7DxL82S7U5f7ZhXIIjrxIVqQgDk6VEmRJQfP3p2U2lZBJlHV4WzTWz90cQpybfRnTL4ph6p1EX1q2RYyl6zJ2nRTRYNORpvDRQiBoXU7PsJekaaWLf08N/10QGDMwbB1W7w3onauO1jqjStpue7oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHZQIU1X; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so1344868466b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 12:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768942106; x=1769546906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+k1PJboJMDuM0TRQLWkcucgCYVlpX1tanOnKHKQcsmk=;
        b=JHZQIU1X0VjPQbq8qrCq8cns6nQqukRXqHY/wR5FHt0hBafPF1KgdoFo8Aj0PtI78s
         HoZ5EdI44B2oNWUbqHsD2/WLXMFCVjqvMdVZ6kEFzJR7o8xyiIMrf8g3DH6Dh6fwRyp6
         NDkiDB6IGgeE3B+8QSP4y3gMNSnPZfi+JbQJent1OkzbvOylS2YJF8ttEKH3uy4xyajm
         19ZMvpe9Nl+NBYjLEUJAB+o5OzU7RZBSXseSI2yRYZEihmqA2Ll1DdvnVnkPy63SEy/Z
         yaUuN9JNylvjOje7935/DCc6yTrLp5FGK+PovKDaHpjU4vuWOgc0+rFoVCQFmqVKb2Lp
         aPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768942106; x=1769546906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+k1PJboJMDuM0TRQLWkcucgCYVlpX1tanOnKHKQcsmk=;
        b=aKksQYSmyh8gqiJnxZ/hJR56SLCiqbzLn3jjRBfVtAfEL7kYDScojbSRb31cfNd/43
         QJorxZiv7v1i78jsRK/uUHOsDpOdlAWesD41p71P5vPl1jMeAQ9k8cwJTomUhlGeC6mh
         KIJrVffpalw7wSY+ulNWPaguxMBp53EmIhgtljPywiipE1L46BIiZWp2DYyR5TsyEWrr
         nc6zR70CHhtz/ZW43PFLBqRpUBT3QG7UHHowkzTX9ISmANEYmKKfBDf4bqQsebm4ruh8
         CJQRDT5lGaIlshxhWPqfNHHO8VotMqUIpTa8lxcCjpdqj6mK/9cNh/H3lQyGSJDXri7y
         EKjw==
X-Forwarded-Encrypted: i=1; AJvYcCXUAPzlG6qs+wBtp9eerVRjW0oOq2QRcsxnPTBVwKXwuhQKRISBRbOzhP6+AB7FqdrBHYc/KigKezboce4t@vger.kernel.org
X-Gm-Message-State: AOJu0YyJEm9LqFEkxDV+D4sPmdoGogab7ABQdMMsnuqwTeOebQYNeyyu
	qtrYc71uK0rg0zIemmGmdDqv05euwVRpXRATZ0F1qCocnnWCKaHPk60a
X-Gm-Gg: AZuq6aLQqQ/UXC12Hj/zHqEu3NhzSIp0PCkD16iCaEI3LWsMuHJDyhB01y29U/2RY+r
	eJpyGNYtWwA4lrK43J4PzznI25c948kVMiaZ15YhUgLaqG1o6HMx4egGBJ3VALdCqPxShVm8+ae
	9FxdB9ZkNCmqttLeEKUaX/3EA/7lq21f3T/qgZwYmzHA+ZwQGlKjDCF6PUstSyd13XJ4f9KxZK/
	xfFTiKIN9tjENnD7UtrCarUNDeaHD43CQ/BBjlUEdpiM9BTzK9Gpw/C/cG4eN8xHB1LPJANlaqO
	ZAnYXwfmRy2VSXsXhLsTLFaIhAkgcKaR7/gesKHdfDmFD4favJvYJ1+swYEvjE2eLYnZl1rtWwy
	ViM1Ati0/XIRtEW5PRvtX0d78Cz2b/m+UP/La3q/rQRSxTmrNzf2PjaBw+SIk8xOtFSYq+ZmR7/
	UdEASj6TAmkwAu+mO53KKSmnF5rZf3HU83o8KhsaiTrsffcXKiIYWlzmVF3Ml7zg==
X-Received: by 2002:a17:907:7fa0:b0:b73:826a:9102 with SMTP id a640c23a62f3a-b880036e4f4mr262368966b.49.1768942105332;
        Tue, 20 Jan 2026 12:48:25 -0800 (PST)
Received: from f.. (cst-prg-85-136.cust.vodafone.cz. [46.135.85.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879516900csm1590732766b.23.2026.01.20.12.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:48:24 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] pid: reorder fields in pid_namespace to reduce false sharing
Date: Tue, 20 Jan 2026 21:48:20 +0100
Message-ID: <20260120204820.1497002-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-74731-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,suse.cz,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: E50DB4C1D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

alloc_pid() loads pid_cachep, level and pid_max prior to taking the
lock.

It dirties idr and pid_allocated with the lock.

Some of these fields share the cacheline as is, split them up.

No change in the size of the struct.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

this is independent of other patches

i got an inconsistent win in terms of throughput rate, but relative
contention between pidmap lock and the rest went down

 include/linux/pid_namespace.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 0e7ae12c96d2..b20baaa7e62b 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -27,6 +27,13 @@ struct pid_namespace {
 	struct idr idr;
 	struct rcu_head rcu;
 	unsigned int pid_allocated;
+#ifdef CONFIG_SYSCTL
+#if defined(CONFIG_MEMFD_CREATE)
+	int memfd_noexec_scope;
+#endif
+	struct ctl_table_set	set;
+	struct ctl_table_header *sysctls;
+#endif
 	struct task_struct *child_reaper;
 	struct kmem_cache *pid_cachep;
 	unsigned int level;
@@ -40,13 +47,6 @@ struct pid_namespace {
 	int reboot;	/* group exit code if this pidns was rebooted */
 	struct ns_common ns;
 	struct work_struct	work;
-#ifdef CONFIG_SYSCTL
-	struct ctl_table_set	set;
-	struct ctl_table_header *sysctls;
-#if defined(CONFIG_MEMFD_CREATE)
-	int memfd_noexec_scope;
-#endif
-#endif
 } __randomize_layout;
 
 extern struct pid_namespace init_pid_ns;
-- 
2.48.1


