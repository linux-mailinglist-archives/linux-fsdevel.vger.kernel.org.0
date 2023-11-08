Return-Path: <linux-fsdevel+bounces-2336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F807E4DF4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 01:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330E32814AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 00:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627A47EE;
	Wed,  8 Nov 2023 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="na/RxMh9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R+qEu2QP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEDA62A;
	Wed,  8 Nov 2023 00:27:56 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5DC10F8;
	Tue,  7 Nov 2023 16:27:55 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 7095D5C02D1;
	Tue,  7 Nov 2023 19:27:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 07 Nov 2023 19:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm2; t=1699403273; x=1699489673; bh=9DHSCSCCw+
	fHIPee2ZQydX5YSNzCAEa1Ayi+g3+7mA0=; b=na/RxMh9cs+5YmDaRxIIsN6Zee
	vE/RBFFMOQ25VL2lg0tuQAJSeYRb7ZkBQH0GdCPTdSgb7P44Iay8X2nqpn2syK7o
	kWppXYVWAleRzL9v97be/LHpCzF7HTOZuscH8hmt8OL2t7yt7PD18dGdwCPMFnf+
	9qeAcbLYOy2f3gQhZbjMhMmmtfhiZMRB7gDbkg6kY6skogsAWOnfUuq6fG/JEJWg
	9e0X/S93PQxK9w7xKBpfIutf/e+pmJp2DsYrNzDHKjwa6qgofBCgKYYmMJDxAzvx
	vA53V5b9/9oXn79z6JFMofwWGmuXXn45jDZMSGGF9TLrhv+e27zqCwLkWyWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699403273; x=1699489673; bh=9DHSCSCCw+fHI
	Pee2ZQydX5YSNzCAEa1Ayi+g3+7mA0=; b=R+qEu2QPqnlP0rYvB00UuPlVqodaQ
	mVC22ycsNE8dwrK93pZmWdB7KywXpcQduVrWoB3prCxotGgjvuSVLzrhAP1EhOn1
	nWTOa5ACs63DutrSyvt59nCsbIiyOTkqq9GNV9qpEshWuPammBt1pDf3ZkGolRL4
	BgsUREPgNHq9IqSYKDApUNzNRpgHj7lUQXsGeWD12G1zj7CRP40F32GU9rcY374Q
	U/9NVz+iDS7hg1XzOlrS+WrvNl9CK6fSyX1oEEYfBVKTeMch9JVmI+el4yyAn6KA
	vWirCWkzwf0VpQn/9iybRBSsrCzYlYS9jV/Nb8UF8AvgnqsD0yX2IUdNw==
X-ME-Sender: <xms:CNZKZVIXVJvbSQB_7lUxZiiMJAdBOdPW7lhQtl7dTFb31l7S8wfEZQ>
    <xme:CNZKZRK2T5MLQB35e49AGv5v1dcBYn3EYO95DQKL-vP-xTPlkjr7oVDwgHDfN1mOJ
    gYGev8vCHW-wwikDFU>
X-ME-Received: <xmr:CNZKZdsJfcLNj7UpvCD_wvAQjh9CxQvBOWd4fjvg2LF7NbVvPcwvjxdJ2NXhq-vD8y3wHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddukedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfihtghhohcu
    tehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrfgrth
    htvghrnhephfehleehfeejtdehteejgeefueehtdeufedvhefghefggfeigfegleelvdeh
    gfejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:CNZKZWZg32p4RoeZyUhfjluRFKLfZ5WOOXz7FCJmCTmGNszP2iHzng>
    <xmx:CNZKZcZzA8B-g23Wd_zr-8t5elPKcttGvLaZB1qaYS2FjyiJf0AVgw>
    <xmx:CNZKZaDL6sp7zF1YWMdvurFuZi58uHyC0je3YaQU95X2jDONyFEpZg>
    <xmx:CdZKZc7oOjn-ZTjDy3dgyvl8lwa9hadL5RnSnT_pO_XQcWbjIY7IOQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Nov 2023 19:27:51 -0500 (EST)
From: Tycho Andersen <tycho@tycho.pizza>
To: cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Haitao Huang <haitao.huang@linux.intel.com>,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Tycho Andersen <tycho@tycho.pizza>
Subject: [RFC 0/6] tracking fd counts per cgroup
Date: Tue,  7 Nov 2023 17:26:41 -0700
Message-Id: <20231108002647.73784-1-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

At Netflix, we have a "canary" framework that will run test versions of
an application and automatically detect anomalies in various metrics. We
also have two "fleets", one full of virtual machines, and one that is a
multi-tenant container environment.

On our full-VM fleet, one of the metrics we analyze is the number of open file
descriptors, from /proc/sys/fs/file-nr. However, no equivalent exists for the
multi-tenant container fleet, which has lead to several production issues.

This idea is not new of course [1], but hopefully the existence of the new misc
cgroup will make it more tenable.

I'm not really tied to any of the semantics in this series (e.g. threads could
be double counted even with a shared table), and am open to implementing this
in other ways if it makes more sense.

Thoughts welcome,

Tycho

[1]: https://lore.kernel.org/all/1404311407-4851-1-git-send-email-merimus@google.com/

Tycho Andersen (6):
  fs: count_open_files() -> count_possible_open_files()
  fs: introduce count_open_files()
  misc: introduce misc_cg_charge()
  misc cgroup: introduce an fd counter
  selftests/cgroup: add a flags arg to clone_into_cgroup()
  selftests/cgroup: add a test for misc cgroup

 fs/file.c                                    |  82 +++-
 include/linux/fdtable.h                      |   6 +
 include/linux/misc_cgroup.h                  |   2 +
 kernel/cgroup/misc.c                         | 232 ++++++++++-
 tools/testing/selftests/cgroup/.gitignore    |   1 +
 tools/testing/selftests/cgroup/Makefile      |   2 +
 tools/testing/selftests/cgroup/cgroup_util.c |   8 +-
 tools/testing/selftests/cgroup/cgroup_util.h |   2 +-
 tools/testing/selftests/cgroup/test_core.c   |   4 +-
 tools/testing/selftests/cgroup/test_misc.c   | 385 +++++++++++++++++++
 10 files changed, 712 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/test_misc.c


base-commit: 13d88ac54ddd1011b6e94443958e798aa06eb835
-- 
2.34.1


