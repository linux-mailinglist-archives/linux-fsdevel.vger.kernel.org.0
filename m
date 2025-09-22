Return-Path: <linux-fsdevel+bounces-62395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C43DB912B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 14:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BEA218A1C52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 12:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34CC308F34;
	Mon, 22 Sep 2025 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lx8fbZ0e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2870C238C07;
	Mon, 22 Sep 2025 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544968; cv=none; b=GrlwX9imMhegSmFb3AOEqp38XduMM+cKEx+uRo/xcx31gVYoS8o13bKhUzguSuEvghT+vkdGG7oUgWpvyyFSLi1webzwWmiMZtY1mH1Rch2CLT/hWNoumehuCt293Eh+mU+T+OuwVQaxLgVbZaUwMoQSy1PfUQZ+TTLhYIGdMD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544968; c=relaxed/simple;
	bh=xTj2GqY6eh1mrhnqYkTIpgU48XOTV32ty+z3ZuqOVvw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RRhQhy28irFt2Unaeu6OFuGCY116AGvVy2uFdY5cmuqWHPhibJxvTGkyR/vHoxFhnY4IXEOKLytWgkpsBbey+phhjvqUqovvbXkZvFtdDw0w/sHtl4sosOxeG1xYV2KexCncnGKZPT/8+LOKjBoJORzxNnWjixyo21xn9w5jlZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lx8fbZ0e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DD4C4CEF7;
	Mon, 22 Sep 2025 12:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758544967;
	bh=xTj2GqY6eh1mrhnqYkTIpgU48XOTV32ty+z3ZuqOVvw=;
	h=From:Subject:Date:To:Cc:From;
	b=Lx8fbZ0er/OxSygY4vc6+ss6bGwujEQtI2QBZD5y5VlL40ZolTYQtkjNNy/YR8y0r
	 rlsHJhXdBhiBOQ1i+xDS3vz3lr/mJH99vo4M7Z9VMCgVQb3EQ8ZKph/k8Xx8TCwoJJ
	 vgy/Fydw7wAuZ35BUX7nzegD0s9BE3lrHf3pYOXFlID7kpPOPrZ3nOnGEgJZW9Kgu+
	 xWMgKYdHdD6k1loMSFO2zKB1kuPeYHECnNqtFMGjeHMve79+sZ8ygmtM0uq1Ja+9fF
	 DDnHe2in25JVIzoA9XlOw0ufBHY0bTUm4PH5yHt+haDJsGWAs2ZAmlDX5HC5Hc/v9v
	 MQe6PwxIGz1FQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/3] ns: minor tweaks
Date: Mon, 22 Sep 2025 14:42:34 +0200
Message-Id: <20250922-work-namespace-ns_common-fixes-v1-0-3c26aeb30831@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADpE0WgC/0XM0QqCQBCF4VeRuW5KF7K1V5GIcR11SGdlByoQ3
 72tmy5/zuHbwDgJG1yLDRI/xSRqjupQQJhIR0bpc4Mr3blsnMNXTA9UWthWCoxq9xCXJSoO8mb
 DvqaGhnz0Fw8ZWRP/hmy0t9wdGWOXSMP0ZWOSURRpnk9/sz5WHvb9A2vlEimcAAAA
X-Change-ID: 20250922-work-namespace-ns_common-fixes-d6a9af922878
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=967; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xTj2GqY6eh1mrhnqYkTIpgU48XOTV32ty+z3ZuqOVvw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcdHHWFq0IPuiecmbF31aB5DdzSyfm152ujRCqZanTc
 rrSZX2uo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLZvowMmwvu3M4x3xh5X7JC
 5bWiB8/+3AiNE5dfbLK4k9/TIHnzBSPDheMVy+Oup+rOmHTLQS3qVb+0nVXiOdtdxdeuZ0rdvqD
 KDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A few minor tweaks for the namespace rework.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (3):
      cgroup: add missing ns_common include
      ns: simplify ns_common_init() further
      ns: add ns_debug()

 fs/namespace.c                   |  4 +--
 include/linux/cgroup_namespace.h |  2 ++
 include/linux/ns_common.h        | 30 ++++++++++++++++++++---
 ipc/namespace.c                  |  2 +-
 kernel/cgroup/namespace.c        |  2 +-
 kernel/nscommon.c                | 53 ++++++++++++++++++++++++++++++++++++++++
 kernel/pid_namespace.c           |  2 +-
 kernel/time/namespace.c          |  2 +-
 kernel/user_namespace.c          |  2 +-
 kernel/utsname.c                 |  2 +-
 net/core/net_namespace.c         |  9 +------
 11 files changed, 90 insertions(+), 20 deletions(-)
---
base-commit: 7cf730321132e726ff949c6f3c0d5c598788f7a2
change-id: 20250922-work-namespace-ns_common-fixes-d6a9af922878


