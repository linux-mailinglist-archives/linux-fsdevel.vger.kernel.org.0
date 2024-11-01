Return-Path: <linux-fsdevel+bounces-33475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A977E9B92AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 14:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13921F22892
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A349A1A254F;
	Fri,  1 Nov 2024 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b="REahKJe3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B5gfoaWL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D571A7273;
	Fri,  1 Nov 2024 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730469325; cv=none; b=CcEC0oul6q3edPN4P+xa4NDKkwBPabDF80YJBk2WC3+e43PvByZ1oRulCAddQbr6fiR2acJtyt7QfnE6hYK2hspjOvs7zD1R7XxOg2W6YWkrmUcGCs3PbnTpljwA3+tn7+K+r9JZs03PuY0TA8p1zHO8jActGcMB3TzVDSJz9TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730469325; c=relaxed/simple;
	bh=T0nDQFuEZwra84gxPs28eZs6BJBZo7mX8bcIGbUZRUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igCmVVf+iImySHZZpXjJ5qBTp0CL1UE/QSBRiOzNmGeRQocP/DkMGgfRmHPFVurs8c0MPvktfozX8dM8kdV/Womc8hqbc/QjkRhx5Z5OihqsUPrLZ42GhfHAdw+fDSpPNedo6wR6kgdEGwZMQ8OvFL6xe3EmSaLQb0raWERacqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu; spf=pass smtp.mailfrom=e43.eu; dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b=REahKJe3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B5gfoaWL; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e43.eu
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ACCC3254010F;
	Fri,  1 Nov 2024 09:55:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 01 Nov 2024 09:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e43.eu; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1730469322; x=
	1730555722; bh=cw7NL9F9LsI3qVysaim2aItN+y15bcgyhI4NNmXxdLg=; b=R
	EahKJe3qrw1iA/s52c1uUt4Onojem0oW/32rhKY/ZEm2rAjHKhKCCf4E9q01ptwT
	fP3QU8usMMfKKnbI0dGgMPrFavtAWr+6x/SKpm2b1di/wA2dZosHR34u5o0B6kEM
	OrH9VSP20MYPmjP/pz9NyoQOt9sZ6rxiDcTa32PA8YSHoOAsdqp6TuJKRNRdzAfl
	PxRUiscoQBEo+UOZnCtGFdThuGzUHDVY1DauJ23pejIr6E6zuASMv4WX6mtf6VRZ
	2zWGqrPygzB8n+JR98bpHzWSuAeEzUq4a/BIuYdD9rlC5QBDZiT44noLlknrpWne
	TL3EnvLfYNWec8i86QGvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730469322; x=1730555722; bh=c
	w7NL9F9LsI3qVysaim2aItN+y15bcgyhI4NNmXxdLg=; b=B5gfoaWL/1uOkWMGy
	XOk+6bzqWX8zFlGcu72k2biPJaMu1WveKY0++pF75m4YlhQmDf645KXNN57x7GLu
	R20o5T7r0k3YeGuyGzEnRmyXZoOLm5TUBs0oBbae7WZeBnha0fwbLm6D++yw7Wxa
	LNck4OxNrYO2+4Xa6wUAv2jwE9YPKzLbcF9XmHjjK6A/hNNyqmNg1uoSLUbs5vHd
	PIeseknVNjrukvPj3ihXj8gq7whLkx+RVXH2bwu2wpATAFrRCnwvL5q9tqNeusvu
	tEePeCk3IV/PoAK11mx6TUVxJAurY1iogjIF+Qs4Suby3cvyPLj0PpkF5M3OCaUa
	T+ZGw==
X-ME-Sender: <xms:yt0kZzCtcTbJjQpJ-7KzVYgc4JwuixTYYCBP3qVF6hlEt5D7Q1FRBA>
    <xme:yt0kZ5j5NeCy6YVm7AgAk6gSZAQjPYlNRJqmr4ZUeGyRrZ6c5TJtzms_hzz_YBYwx
    NDqfJ1BSOIf5lrbGTw>
X-ME-Received: <xmr:yt0kZ-ktutSfyfM9mglR_WatxsXYgmY9R6hFfz-jtPAL3LuMobeW4rQz4ya9YPKbFrVVQxmhNjv6Afl_iKfBWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekledgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefgrhhinhcuufhhvghphhgvrhgu
    uceovghrihhnrdhshhgvphhhvghrugesvgegfedrvghuqeenucggtffrrghtthgvrhhnpe
    eggedvkedtuedvgfevvdehieevveejkeelieektdfggeevgfeiieejtdffledtieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegvrhhinhdrsh
    hhvghphhgvrhgusegvgeefrdgvuhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnsegsrhgruhhnvghrrdhioh
    dprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtohep
    sghluhgtrgesuggvsghirghnrdhorhhgpdhrtghpthhtohepvghrihhnrdhshhgvphhhvg
    hrugesvgegfedrvghu
X-ME-Proxy: <xmx:yt0kZ1xONH7CFD_MIESZPlpaDCGxU8KeVVDmwH5x4v_F1YFBwxxkfw>
    <xmx:yt0kZ4TJv_uEyNWAXWnOXOZFZjlAS1pQJoaaB7K_kHMaK8eVh4GlHA>
    <xmx:yt0kZ4YBTD4prWsoTdYqIhzLC_wFQcRo9x14b-sSRKd_D6Z5R5M98Q>
    <xmx:yt0kZ5Sb4N12WilTo0cTYUR4m1g-5nwW95SmEbuThkfORvfr34VtSg>
    <xmx:yt0kZ3G-ZNv3BjCqTi6zyuL6q5QIEbin87z63FZNGAzgGxMZtXsp8Dzn>
Feedback-ID: i313944f9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 09:55:21 -0400 (EDT)
From: Erin Shepherd <erin.shepherd@e43.eu>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: christian@brauner.io,
	paul@paul-moore.com,
	bluca@debian.org,
	erin.shepherd@e43.eu
Subject: [PATCH 3/4] pid: introduce find_get_pid_ns
Date: Fri,  1 Nov 2024 13:54:51 +0000
Message-ID: <20241101135452.19359-4-erin.shepherd@e43.eu>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241101135452.19359-1-erin.shepherd@e43.eu>
References: <20241101135452.19359-1-erin.shepherd@e43.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some situations it is useful to be able to atomically get a PID
from a specific PID namespace.

Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
---
 include/linux/pid.h |  1 +
 kernel/pid.c        | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index a3aad9b4074c..965f8b3ff9a8 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -124,6 +124,7 @@ extern struct pid *find_vpid(int nr);
 /*
  * Lookup a PID in the hash table, and return with it's count elevated.
  */
+extern struct pid *find_get_pid_ns(int nr, struct pid_namespace *ns);
 extern struct pid *find_get_pid(int nr);
 extern struct pid *find_ge_pid(int nr, struct pid_namespace *);
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 2715afb77eab..2967f8a98330 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -470,16 +470,22 @@ struct task_struct *get_pid_task(struct pid *pid, enum pid_type type)
 }
 EXPORT_SYMBOL_GPL(get_pid_task);
 
-struct pid *find_get_pid(pid_t nr)
+struct pid *find_get_pid_ns(pid_t nr, struct pid_namespace *ns)
 {
 	struct pid *pid;
 
 	rcu_read_lock();
-	pid = get_pid(find_vpid(nr));
+	pid = get_pid(find_pid_ns(nr, ns));
 	rcu_read_unlock();
 
 	return pid;
 }
+EXPORT_SYMBOL_GPL(find_get_pid_ns);
+
+struct pid *find_get_pid(pid_t nr)
+{
+	return find_get_pid_ns(nr, task_active_pid_ns(current));
+}
 EXPORT_SYMBOL_GPL(find_get_pid);
 
 pid_t pid_nr_ns(struct pid *pid, struct pid_namespace *ns)
-- 
2.46.1


