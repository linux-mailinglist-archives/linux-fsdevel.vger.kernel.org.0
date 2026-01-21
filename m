Return-Path: <linux-fsdevel+bounces-74872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLqFINQQcWlEcgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 18:45:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 419445AB85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 18:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B153D78B983
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 15:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B914BC029;
	Wed, 21 Jan 2026 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4sFTZSr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09B6436358
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007744; cv=none; b=sFTmF+eNN/VMWNkr/GeOd/o0Wp6pNNKIWovhvkyPRyYy30NhGh918srLnB3JyMDHEKAl9WtduXB5D+ekc50Shp2PLbDwD4zI4ki/SSB15mAftwlUWfbcRD+IQIyiXukQ/opOX8eX3VAxPZ0QDJPyq7JkLl/RpKbJ9skFX2eORbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007744; c=relaxed/simple;
	bh=N+DP0mic9dW2SwO8MufVMZAUv5nHtgU9Ibx3wfXW44Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sfe1/e/764UWocXejHDYS0ZV3s0eZn1g+fp74DlFiEHXA9veVkuD4WKc5i+ZgBy9/8s/ViYTg95jbO0IGTgCFR0RxSl/fQa6dh9ids4lyoha487BHoSomTk5yhxpjAxFbkOjTY0AhRdS3cePp1htgMCZvae+SM7MgMEzDzT13Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4sFTZSr; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so5043670a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 07:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769007741; x=1769612541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwL6JIRS2DILAHIQcR4xQA3DxSxHqsiHM2z6oLPh+Cg=;
        b=Q4sFTZSr4aNdokeESr+U5tRX59xfMMbxseV2yL9Ry4/PIJat25R+/7iO6WTp4aCpWS
         56MQ+IQK9BJgbNF/iHTmPMcbWvmAV2AY8eLW9yPx3PPye8xlMIC3gijwZz5/R33YXypB
         45BAEJM6sRMf8z90A1oh5ox8VSkCyfVaVjOpdy5lckUUigNDLlcsZifEJfKda1+3KpZO
         kO1alEGie+BEtu5i3T481cv63ET21hep3IfgAm30iqEYW8ooUwL7lkFil4dwwPl++9up
         s+0pZOY5HtwJZMsdP68xlhd3xPNhzRZ1/2PcvtLYnHtLWKE7QPbblpqRF9MK1O/ozxkz
         Vo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769007741; x=1769612541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TwL6JIRS2DILAHIQcR4xQA3DxSxHqsiHM2z6oLPh+Cg=;
        b=oHdQOh01aX5XRAluco69ZzWQry7hgLrY+0nswWGySSewr50KhmmukgBkI1cMQvEoYe
         iHM9BYkmn+vWQ2bXwS3WH+3XvqqYdfjejx4NGhyblBsYWQn4uWCD3HivTyCpsMLbA62G
         LWM1aoitAKxR+LcTX4fN17VxEkSkKdrH80wA/3+GVY4BebrnYJuBdXWP8qjiXKaOPfAD
         ulcAafLh9z0iEvKAI2DV3Jcfukd3e1RBffq8kLoJm2TUQjRlgBKURz0Hn8RS9qVYUnB5
         nx86orMPeoznkE6nKEytBGYTQ+vAiSXIpE9KgwlgPLnjFf5NVXdW43AX5pOSd5qgOdXq
         BdLg==
X-Gm-Message-State: AOJu0Yz11L2qfjocsTU+SfAtVzVF0LZlUyIqUlf/zASz9EBrUWhqo/g9
	FDabrDt1llWSDW+4+XUyfRvdbQoxEutdtOOLVxpuORWmXTVQYYJjp86F
X-Gm-Gg: AZuq6aJSj7rpFBt7NF6Mg/WvS5gwSY5w8dxEdm2eyf2GsXrzsnSM9jrRo0rmbDS+kjQ
	AqetefNVQsFbli8B9lqCL7Xt3DZTO1Tn6JdCezF5SeU8PQXY6WCvvWbsXH1xEAGwQ8WTOhsyBLg
	qLISrHpTB3lJbxAOgWgzxe3nqKHGKGV9uvqpK0doDeVkWbs87QqeJRFRKwaFLiJpqR5Nv28i8TU
	86AJVt6/ma/6zy2+q+Hu3Dz8AucFyYkzFa/gZIa6Dxe7H7h3Q2MeoZuHU9yGPT37nhmek71BKce
	/GCfDJ9ihaTFFCt/+afXqwzsNlGltvUVLNmyIY+WJ+2sYcn4uevXeDNnZHun9w5kgtKhf5313Wt
	S+gfVEfO3SAUKqZrPbJEb29s/NWrfpt7vUQI09H+9vxAwp2TXM/wfEBuVCoC9jW8+fcXsVk2aiR
	eeoRkASGgClr2gtcx3DAnHIRgqLPIf
X-Received: by 2002:a17:90b:3f8e:b0:353:883:aff6 with SMTP id 98e67ed59e1d1-3530883b063mr1407873a91.20.1769007740636;
        Wed, 21 Jan 2026 07:02:20 -0800 (PST)
Received: from localhost.localdomain ([111.125.231.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678c69fasm17882867a91.14.2026.01.21.07.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:02:20 -0800 (PST)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Prithvi Tambewagh <activprithvi@gmail.com>
Subject: Testing for v2: configfs: add lock class key to struct configfs_fragment for frag_sem
Date: Wed, 21 Jan 2026 20:32:11 +0530
Message-Id: <20260121150211.82216-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6767d8ea.050a0220.226966.0021.GAE@google.com>
References: <6767d8ea.050a0220.226966.0021.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlegroups.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74872-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[activprithvi@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel,f6e8174215573a84b797];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 419445AB85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

#syz test upstream 3a8660878839faadb4f1a6dd72c3179c1df56787

Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
---
 fs/configfs/configfs_internal.h | 1 +
 fs/configfs/dir.c               | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index 0b969d0eb8ff..15bcde6c878b 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -21,6 +21,7 @@
 struct configfs_fragment {
 	atomic_t frag_count;
 	struct rw_semaphore frag_sem;
+	struct lock_class_key frag_sem_key;
 	bool frag_dead;
 };
 
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 81f4f06bc87e..10c76cef88c9 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -163,6 +163,8 @@ static struct configfs_fragment *new_fragment(void)
 	if (p) {
 		atomic_set(&p->frag_count, 1);
 		init_rwsem(&p->frag_sem);
+		lockdep_register_key(&p->frag_sem_key);
+		lockdep_set_class(&p->frag_sem, &p->frag_sem_key);
 		p->frag_dead = false;
 	}
 	return p;
@@ -170,8 +172,10 @@ static struct configfs_fragment *new_fragment(void)
 
 void put_fragment(struct configfs_fragment *frag)
 {
-	if (frag && atomic_dec_and_test(&frag->frag_count))
+	if (frag && atomic_dec_and_test(&frag->frag_count)) {
+		lockdep_unregister_key(&frag->frag_sem_key);
 		kfree(frag);
+	}
 }
 
 struct configfs_fragment *get_fragment(struct configfs_fragment *frag)

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.34.1


