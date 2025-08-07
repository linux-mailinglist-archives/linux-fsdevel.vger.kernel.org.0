Return-Path: <linux-fsdevel+bounces-56978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D39BB1D799
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 14:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4A356255C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 12:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B972C25CC42;
	Thu,  7 Aug 2025 12:15:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4477B25BEF8;
	Thu,  7 Aug 2025 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754568904; cv=none; b=WV7yJZ2W3+5O7APZUxLs/IGuiiKYB7VNeqTwzYyVqWC6XpncE7cvzbjpAODzR2Bn14zBY6cq9Lx5XXh73Pp/PzCDDhqu5uG0p5CnTSU2PJGhSykKsuBrOzfHppT5kQxib4nHxpFNcRIxbZ5gEjlrVmg/FCcOy/UVL2tc5yKn6Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754568904; c=relaxed/simple;
	bh=1k3Xoc4SLZQp+ojYSPnjMqj1UYbiAPh1DFzrfR5rr1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dNmnZsWq5LhPB/1vqUf4tUJLeRRJ/qhS0WJyIv+fp8LmGQd6h0+dCj7hWyDyVQY+eXNht2UGdxQ7UGXBSjxmsjdTiPBAJ8bFKttCo3zRNCjHS21veaTEMFAgfEJV79Ad6hANcvQUlp+7jFr3ga5uOR0DzlA6RbfWkU9I8aPg8TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 21419812738811f0b29709d653e92f7d-20250807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:bb2b8d20-fc11-4a08-a86e-c3ccd7360bda,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:051d5319b82a10187433fbc93a60ff3c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 21419812738811f0b29709d653e92f7d-20250807
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2002267490; Thu, 07 Aug 2025 20:14:55 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 8F097E01A758;
	Thu,  7 Aug 2025 20:14:55 +0800 (CST)
X-ns-mid: postfix-689498BF-34637367
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 1DCC0E0000B0;
	Thu,  7 Aug 2025 20:14:52 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	len brown <len.brown@intel.com>,
	pavel machek <pavel@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Nico Pache <npache@redhat.com>,
	xu xin <xu.xin16@zte.com.cn>,
	wangfushuai <wangfushuai@baidu.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	linux-pm@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [RFC PATCH v1 5/9] freezer: set default freeze priority for PF_SUSPEND_TASK processes
Date: Thu,  7 Aug 2025 20:14:14 +0800
Message-Id: <20250807121418.139765-6-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250807121418.139765-1-zhangzihuan@kylinos.cn>
References: <20250807121418.139765-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Tasks marked with PF_SUSPEND_TASK are involved in system suspend or
hibernate operations. These tasks must not be frozen, as they are
responsible for coordinating or executing parts of the suspend/resume
sequence.

This patch explicitly sets their freeze_priority to FREEZE_PRIORITY_NEVER
during initialization. This makes their exemption from the freezer logic
clear in the new freeze-priority model and avoids redundant evaluations
during process traversal.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 kernel/power/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 06eafdb32abb..21bbca7040cf 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -147,6 +147,7 @@ int freeze_processes(void)
=20
 	pm_wakeup_clear(0);
 	pm_freezing =3D true;
+	freeze_set_default_priority(current, FREEZE_PRIORITY_NEVER);
 	error =3D try_to_freeze_tasks(true);
 	if (!error)
 		__usermodehelper_set_disable_depth(UMH_DISABLED);
@@ -218,6 +219,7 @@ void thaw_processes(void)
 	WARN_ON(!(curr->flags & PF_SUSPEND_TASK));
 	curr->flags &=3D ~PF_SUSPEND_TASK;
=20
+	freeze_set_default_priority(current, FREEZE_PRIORITY_NORMAL);
 	usermodehelper_enable();
=20
 	schedule();
--=20
2.25.1


