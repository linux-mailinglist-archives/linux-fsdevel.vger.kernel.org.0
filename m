Return-Path: <linux-fsdevel+bounces-58703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E1FB30997
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE446608489
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EBB2EA74C;
	Thu, 21 Aug 2025 22:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="maERdqmL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UktnjxML"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200312E2F03;
	Thu, 21 Aug 2025 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755816571; cv=none; b=GzBta5WGh8f6qPB2pPaV/U36qgzLB7oFKbSSqHfNwKjB6fQw+EwbAfluK5FX3zt4Zzey5wtaOEPAIZoSXS3pXu6zD0IIUYxXLe7RS72uhsByCHNZf4cQeJPeGfgQP8OY4qFeoF4B49l5xLpurCP8+YxldgJ/8ysOa03XBRAEcNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755816571; c=relaxed/simple;
	bh=Yh1rgkdPuSXMRL65slcWDxV3Rt21KI7pAV5SY1tD8Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGVX5gVmiuz7h9q6YO14PvG+NecHcLR5yQfRuAPwUJglEhn3B+jBTrIaSloXCWIMNHkPUc1M4znqYcwXG5sEfw33q0XT1FfEIOYKG1rRL3taxxQN1qs6WMPK5E2TFfQWy+evCoCi6CZJ6501/V+bBeoqrDqs0eN3TTnWd9rOmi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=maERdqmL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UktnjxML; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 023491D001EB;
	Thu, 21 Aug 2025 18:49:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 21 Aug 2025 18:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1755816567; x=
	1755902967; bh=Qz8k9Dq+BLY/ejp2bsbmNLU/oeah8tJNSPR8Lkv6lzs=; b=m
	aERdqmL7f+UgTVNEijJ8MTqdc8nis81Cf1Y7XVkmII4pOxGTTB1MXZb+8K/yS0V1
	lLjajlwOXkflisOLgfiqq6ycEpoMlhyVzIEu7kMj5WQ92bsKlOMWBTEIbpZV/8rT
	i31yXeGs8JPrMvgwUQIV5Wy6oqrGcZCSd/E3NqtiCGs2p1IGOMOlFKERnf2psfXg
	uBSili3ULneGLFReQKDxWxKYgsSODJlUj4G4pOgh8bA6FwNfLzTQFMjYyHE7at/7
	ZF65N6fIZfxH64Oc/+IgPLT5W9Vfj7D8oxxVbrBvySl08xez+vKUWLYLFBkcnaWP
	17Jvvt3WaVVXGw4ly7qwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1755816567; x=1755902967; bh=Q
	z8k9Dq+BLY/ejp2bsbmNLU/oeah8tJNSPR8Lkv6lzs=; b=UktnjxMLIEn2L57Ys
	NGpTai2dIdF6PhZd8XzV1hgC8oAjZ7yyHjD5qHFIRuXKgHm6cAm2t43sJ99Vu8yz
	wGgod6uXOf+oW3kL5843UIPORr6Q7kbpz4gId+BqTq6cQSO7lmp8XgSzDnMSCrfn
	X8z6UdTyqIY6fD3RdUQw4wAeVfKZ3ZDBMuTb17iA3XBH3u3CFY1YhTyAM34ZxtS3
	EZ1WWht36gAg7CETYzdBd1kqEZWMwhIFTo5iCN88cFAgAlA/eafmmZf6CDroPAEs
	24O/oRGH/0gHNzNLmnlcrzTAkKKWIy0DSL1HZdoin6NTjrIF2Fr+ifNatDFjl/M8
	c4/UA==
X-ME-Sender: <xms:d6KnaDCzhHnvfHvuHCCL4qcU-NFiMgKmNsAm9wT41e2w8tTXHyyLpg>
    <xme:d6KnaPABSA3S2Y7j2HymIGkpODH7YgoJEccFDlUoueX-i2sszJxmUb_PuIqcgigjL
    8M0YRcoHMdWNEYJn00>
X-ME-Received: <xmr:d6KnaNpEpW04h_Y6NuC4ZIfjOSy2tTzaWe7Mw5y4zGdCT8YFRHdMqXE1IimkZIB4w5XBO7mYATqs6768vcnOuTLWXRo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepgeduteffveeileetueejheevveeugfdttddvgfeije
    fhjeetjeduffehkeelkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeduvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgu
    rghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomhdprhgtphhtthho
    pehshhgrkhgvvghlrdgsuhhttheslhhinhhugidruggvvhdprhgtphhtthhopeifqhhuse
    hsuhhsvgdrtghomhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhg
    pdhrtghpthhtohepmhhhohgtkhhosehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:d6KnaKE6y3mZz_JB1eJVZPfB1IhwDO6PzYHq_F8LKknWFyxDgJndPA>
    <xmx:d6KnaBsbC29AeQtHuhwoTibIYfUFxX3iQiq4-tN--1eYXpJKsfcbeg>
    <xmx:d6KnaAbu6CU2JbjeeCQ_rBNkUozqnK_-vwenWbyfNEtvw6a4IyeSLQ>
    <xmx:d6KnaB5c_HCt8z2br-SbgT_81pRZlhI4iLcYDoGVdC-EeivmPOko9A>
    <xmx:d6KnaB-7zm1FGxyW80blCA5aKir2c85km7fFkV5aje-6JQlY6n2NoVoB>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 18:49:26 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: akpm@linux-foundation.org
Cc: linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com,
	shakeel.butt@linux.dev,
	wqu@suse.com,
	willy@infradead.org,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	hannes@cmpxchg.org
Subject: [PATCH] mm: fix CONFIG_MEMCG build for AS_KERNEL_FILE
Date: Thu, 21 Aug 2025 15:51:22 -0700
Message-ID: <6de59ddeec81b5c294d337c001ba0061631d4ec6.1755816635.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <f09c4e2c90351d4cb30a1969f7a863b9238bd291.1755812945.git.boris@bur.io>
References: <f09c4e2c90351d4cb30a1969f7a863b9238bd291.1755812945.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

this needs to be folded into

mm/filemap: add AS_KERNEL_FILE

for it to build with CONFIG_MEMCG unset. Apologies for the churn.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 include/linux/memcontrol.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 9fa3afc90dd5..e693978b2022 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1059,6 +1059,8 @@ extern int mem_cgroup_init(void);
 
 #define MEM_CGROUP_ID_SHIFT	0
 
+#define root_mem_cgroup		(NULL)
+
 static inline struct mem_cgroup *folio_memcg(struct folio *folio)
 {
 	return NULL;
-- 
2.50.1


