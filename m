Return-Path: <linux-fsdevel+bounces-2338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA847E4DF8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 01:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D54B21144
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 00:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91266EA3;
	Wed,  8 Nov 2023 00:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="uI6qE7pG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JMleCSLs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B607E63D;
	Wed,  8 Nov 2023 00:27:58 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0727210F9;
	Tue,  7 Nov 2023 16:27:58 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 71E215C02BE;
	Tue,  7 Nov 2023 19:27:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 07 Nov 2023 19:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1699403277; x=
	1699489677; bh=Hm0IoV3pDT/7pWb7KELHc2mklxHo80myTh5Vqb0pVUA=; b=u
	I6qE7pGNXkx2BM35YFcr3pDtV/qb62c1nirCG+zOoAbFylgwKNq/TILtZ62Bel4f
	RPNa6zHnkLvD72VyYI7S1Id5uGdoudUyEAOErsoLDCg6dasKzKLI9ydStR2k2TGp
	B17Yjs9rRrl8rHkiKuXQ7WDyIudozHYmJa/VrlrBCbSe258aGrm50+Y6cT502UVP
	04seFsP0AYt4xaRiHiiyvTsTCnk/0SXoCrgEn/zNp5rrPUtuDeza/UKWZ6WxJn3R
	HVuXEWGgVRZXUf6VoTbeCovHvOdpALL8tuLz88uUsONgv6SwyRVKdEnHA1NsdtrI
	nQPk+r0ZYYIXeLUmEFfbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1699403277; x=
	1699489677; bh=Hm0IoV3pDT/7pWb7KELHc2mklxHo80myTh5Vqb0pVUA=; b=J
	MleCSLsNIDP5HU7NRgSt8295vj+sci0P8Y/rMqmnYzKxOUrJzb0olNysQz5Kgomj
	5olpKYTd9AQg8kvrTuRUSHZ9FOgeqa66YA0QO8fOapkQ5ujGRpJqYzEznA3Zkvcg
	vy+pr1/0mBKj4eNfkxy33HX/Q6LSRNpD3LFR7zEL1R7wQo2ISDDxFmg4eTXyefI3
	PPsAJ6lJapYXAloqLM+AQLAkb55vv4CipxRmzufuiCLUppDaaU9mNgBAQ3iv6YjJ
	17My1s8eE34l99klZaZ4fLh1UrsGIVgHfBh7vJ72OopGsfCYDHOoMnQ0zgL6+CVr
	XKL3P8qxySH1BZuNROv5g==
X-ME-Sender: <xms:DdZKZTtkak7-K0MXhOYDZirSFR5PqqG6Lzm_Gt1VBJ6MJMk8PDsS0Q>
    <xme:DdZKZUfLs9EVraXd3MgnG4CMqsvLCIJWu_igPNN3fuisgSO1kk6TiFDZhVgLj05E1
    ebo71wqXtKBypiNB5I>
X-ME-Received: <xmr:DdZKZWyvA8F32CY1rcCoq75-32sVidsISpu0vfHVhHs5oY-onrwchMi7I9BWai0x6gdHDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddukedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepvdegffehledvleejvdethffgieefveevhfeigefffffgheeguedtieek
    tdeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:DdZKZSMloCLUahVFU_n-exF6L65apga5N7mxx5p7lljKD5crSdzsEw>
    <xmx:DdZKZT8GFXKZR6peEReiHw4KM8t45WgWJ3YRLBsjw1f3KYTQyxqChg>
    <xmx:DdZKZSXfiluMA2t5O2Njgs60kabiuU5bIbHZPkoKLhHJDJh9lYkI6g>
    <xmx:DdZKZfRK7T2RUBYyN6oqsNEj8u6GPHc_DEVBS4fbqY6tcw0UZUyDtA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Nov 2023 19:27:55 -0500 (EST)
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
Subject: [RFC 2/6] fs: introduce count_open_files()
Date: Tue,  7 Nov 2023 17:26:43 -0700
Message-Id: <20231108002647.73784-3-tycho@tycho.pizza>
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

In future patches, we'll need a count of the number of open file
descriptors for misc NOFILE cgroup migration, so introduce a helper to do
this.

Signed-off-by: Tycho Andersen <tandersen@netflix.com>
---
 fs/file.c               | 10 ++++++++++
 include/linux/fdtable.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index b1633c00bd3c..539bead2364e 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -285,6 +285,16 @@ static unsigned int count_possible_open_files(struct fdtable *fdt)
 	return i;
 }
 
+u64 count_open_files(struct fdtable *fdt)
+{
+	int i;
+	u64 retval = 0;
+
+	for (i = 0; i < DIV_ROUND_UP(fdt->max_fds, BITS_PER_LONG); i++)
+		retval += hweight64((__u64)fdt->open_fds[i]);
+	return retval;
+}
+
 /*
  * Note that a sane fdtable size always has to be a multiple of
  * BITS_PER_LONG, since we have bitmaps that are sized by this.
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index bc4c3287a65e..d74234c5d4e9 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -77,6 +77,8 @@ struct dentry;
 #define files_fdtable(files) \
 	rcu_dereference_check_fdtable((files), (files)->fdt)
 
+u64 count_open_files(struct fdtable *fdt);
+
 /*
  * The caller must ensure that fd table isn't shared or hold rcu or file lock
  */
-- 
2.34.1


