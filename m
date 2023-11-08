Return-Path: <linux-fsdevel+bounces-2339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D9C7E4DF9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 01:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FB11C20C52
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 00:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21178384;
	Wed,  8 Nov 2023 00:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="u6d0eUMP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SFCgi0Ce"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D52815;
	Wed,  8 Nov 2023 00:28:00 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E987110F8;
	Tue,  7 Nov 2023 16:27:59 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 600C65C02CD;
	Tue,  7 Nov 2023 19:27:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 07 Nov 2023 19:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1699403279; x=
	1699489679; bh=HOoVPyQMSUyJ2ZjQyfX/E+uMFA1T0GfIkKxlOvitxrw=; b=u
	6d0eUMPFusPkT2pdfprjz6f6pBUrmQun6Yc8oJq3GJ75OKpecqf3TwDqtOoiKqZg
	YkxMnahzxPiOeH3rihxeuFMV8tOdh2LbJgk/r6/8w9udfLTRnr1vTnrYrQzzX/Fp
	r6rT5eE2BWEuQKW8xeT3254k8EX74lgjnV7f7UNC8h/dlLBqLPyLWABXmGVVxojx
	rUPOnpzaS52Pydyc1zs747txOQgmnDd1qxH83pgyPK4QOrkU3C4tMtYxMdeLftEe
	IwXZXhQpBn0MdhMTGzf/VHHU5voqcBNh5mw9tigFghqHiA8gC7KiIGD0PLM4zkMK
	23RntsIVRbcD0FsDiU+hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1699403279; x=
	1699489679; bh=HOoVPyQMSUyJ2ZjQyfX/E+uMFA1T0GfIkKxlOvitxrw=; b=S
	FCgi0CeSB5ACj7LBe2UYltaHpgv6FynEi6tzY60vllDWDKqjTXSt9usad3bRJZz4
	xK2EPHzg9cPlqkL3iuIibGmpFZ2ihRTRV+y8LwcZoGfJQe5RGG/VBaKUIp1NbAmA
	QqmuAkyDsI7jnDF8m/ZecrkY0ZrUEwX5ZccGyuC7KPS7Z1bKwnIvjbJxyAc97h1d
	BO8nstoGAkyYQHV0PDxGqFVF5/GnjtLnoRPSDawBTCukJz9Y27vW/AUAHc/01f64
	tFAMR4N2yFgkAKMxnP5oJm+2vwhKvc4YoBn5/7QWHPRKNLfVv2xk23kqZUCTlFSm
	kox/kuYhR6Wc7kT62j3Jg==
X-ME-Sender: <xms:D9ZKZaXhcOZuEQSONO2Tr33m0mTXeDo_WwHwxVaoOUxE1MNWyf3Eag>
    <xme:D9ZKZWlt3OoI-bfcgxIxjYnWN7kTKo0XCXcRDsFr-RkEYq1J1_f3w33lpAJysvOej
    1TjSTRV7y8tDoekyW0>
X-ME-Received: <xmr:D9ZKZeZDU-zuLOCrIA7IsiuV-scX-eVGy8YWx4Wx6T7rMGtGM4ErRb4It27_zsKJCY7EnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddukedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepvdegffehledvleejvdethffgieefveevhfeigefffffgheeguedtieek
    tdeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:D9ZKZRX5X78QACyeabw6kmnXaW8kN7HS_hYQykmzkMI8nuvmATkPJQ>
    <xmx:D9ZKZUmwRcf819Gd6NxqXTeUAqm2yETdlx2d4k75w1YOPfHr47WiEQ>
    <xmx:D9ZKZWdBQMezXuIExSZ5wytRcFpAlBB8F8Q5_Lc-g_GHnh6LKXjNBg>
    <xmx:D9ZKZe7xkuO-3xW-qVWP6nTaHESFzxlajJG0ffWj1pE24s8ajIrW2g>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Nov 2023 19:27:57 -0500 (EST)
From: Tycho Andersen <tycho@tycho.pizza>
To: cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Haitao Huang <haitao.huang@linux.intel.com>,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	Tycho Andersen <tandersen@netflix.com>
Subject: [RFC 3/6] misc: introduce misc_cg_charge()
Date: Tue,  7 Nov 2023 17:26:44 -0700
Message-Id: <20231108002647.73784-4-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108002647.73784-1-tycho@tycho.pizza>
References: <20231108002647.73784-1-tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tycho Andersen <tandersen@netflix.com>

Similar to cases in e.g. the pids cgroup with pids_charge(), if a migration
fails we will need to force-unwind it, which may put misc cgroups over
their limits. We need to charge them anyway, which is what this helper is
for.

Signed-off-by: Tycho Andersen <tandersen@netflix.com>
---
 include/linux/misc_cgroup.h |  1 +
 kernel/cgroup/misc.c        | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index e799b1f8d05b..6ddffeeb6f97 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -57,6 +57,7 @@ struct misc_cg {
 u64 misc_cg_res_total_usage(enum misc_res_type type);
 int misc_cg_set_capacity(enum misc_res_type type, u64 capacity);
 int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount);
+void misc_cg_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount);
 void misc_cg_uncharge(enum misc_res_type type, struct misc_cg *cg, u64 amount);
 
 /**
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index 79a3717a5803..bbce097270cf 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -121,6 +121,38 @@ static void misc_cg_cancel_charge(enum misc_res_type type, struct misc_cg *cg,
 		  misc_res_name[type]);
 }
 
+/**
+ * misc_cg_charge() - Charge the cgroup, ignoring limits/capacity.
+ * @type: Misc res type to charge.
+ * @cg: Misc cgroup which will be charged.
+ * @amount: Amount to charge.
+ *
+ * Charge @amount to the misc cgroup. Caller must use the same cgroup during
+ * the uncharge call.
+ *
+ * Context: Any context.
+ */
+void misc_cg_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount)
+{
+	struct misc_res *res;
+	struct misc_cg *i;
+
+	if (!(valid_type(type) && cg && READ_ONCE(misc_res_capacity[type]))) {
+		WARN_ON_ONCE(!valid_type(type));
+		return;
+	}
+
+	if (!amount)
+		return;
+
+	for (i = cg; i; i = parent_misc(i)) {
+		res = &i->res[type];
+
+		atomic_long_add(amount, &res->usage);
+	}
+}
+EXPORT_SYMBOL_GPL(misc_cg_charge);
+
 /**
  * misc_cg_try_charge() - Try charging the misc cgroup.
  * @type: Misc res type to charge.
-- 
2.34.1


