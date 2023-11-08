Return-Path: <linux-fsdevel+bounces-2337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9B67E4DF5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 01:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B831C1C20CB8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 00:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A257D806;
	Wed,  8 Nov 2023 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="OlXedrGD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vbjQI9mj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB44962D;
	Wed,  8 Nov 2023 00:27:56 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B52110FA;
	Tue,  7 Nov 2023 16:27:56 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 76B955C0216;
	Tue,  7 Nov 2023 19:27:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 07 Nov 2023 19:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1699403275; x=
	1699489675; bh=7qsPYrBQ/D97s0QKymD5BefTnJXQJEdfpXeGyJowg60=; b=O
	lXedrGD06b81Ftc4jMavpd3+ZWarDRi9eoWzVZo7hXzWXCjkV2F8ZiJrTNj0PKDG
	rrbHKy//Ara6xhyv1+fnnejylZcqj4Uj+cH0AWlcqxYlGtPoCLdnBi8utrtZbYEP
	bR6YP94TNc5K0u4kW7k3gOaSD797ffuMr+PnidHY6iRm6AD35B3sibswXeM60WcT
	4V4UQttt6eGqJqkUxALrxQEi5cyCSzK2vcN6BS+4EUuueuNK/tJLgmR13YHw0YhY
	5Bid2fLXx8uJwNSFw1koqWSZLb1I8wmYg/35ow2XDTga6S4PwIsGyOCsgSyiNdQj
	yKbLxkR5AXka8Zz2wXNpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1699403275; x=
	1699489675; bh=7qsPYrBQ/D97s0QKymD5BefTnJXQJEdfpXeGyJowg60=; b=v
	bjQI9mjku0s1SRfye3ymCiKOvetxVSrZMzQAzGkKwU+W1PROAv8XLg/tPccmTZZ7
	O/Hdu9GKfmJqNmZ7L3uSmQH/ySsqMbe1UPVKJQYKY3xXnPKPNwO4HTAxbbxCK3pV
	cpOuxtYrlenh7/adjB0bIH0mRM22XDGGsE8Dd3BoqBWan8XLZwj3lDvjKZJwL6nG
	6F/4EYrV3Z+WMsbu7trdrUhoXMVFgcinj7YSUmC5Gpe5a6P0e2RXRXUu6w7VR86G
	skm4A6jxb23Fh+BUyBe1aTk2Q8O3wpWV3bkaLyVoKNfFRivQRz3yIMgmDXAZAkWY
	90V4HkUm6/FxjWcRccxZg==
X-ME-Sender: <xms:C9ZKZfW61WqI6EHaEthoklwsTr8513BhJJsWD1jl-fXS82ljUrjXvA>
    <xme:C9ZKZXnUyppzM0k1zc8tBwZWWzaW6dFcTQRlAxxYLJbXwkTvBcXvnhld3gUQyR77t
    fKjQ1pN6eqq7oaSFBw>
X-ME-Received: <xmr:C9ZKZbaFLej0Xx6bsOkGGE5MZy8YDDzFXeyUjYfkXkIo2BH-6XRyP4RppowZBr6ijUotfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddukedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepvdegffehledvleejvdethffgieefveevhfeigefffffgheeguedtieek
    tdeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:C9ZKZaXeLh4BipiExfJ9f1phhA5lgs5szVMlam6KLgllL1xaBPTtIw>
    <xmx:C9ZKZZnOXIgoaC5b3s6GtExwh9OxQmiE5laG9WWN0nAlxoskQa6XOQ>
    <xmx:C9ZKZXcJFBXU-niND0iuvmpmlbIWjm1X-tZRPyPMmou_TEe7skU9Rg>
    <xmx:C9ZKZb5HwVwOvtWSJc3fsd28PPds3o8tIFW-aVKomjc6CuAOC_F6aQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Nov 2023 19:27:53 -0500 (EST)
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
Subject: [RFC 1/6] fs: count_open_files() -> count_possible_open_files()
Date: Tue,  7 Nov 2023 17:26:42 -0700
Message-Id: <20231108002647.73784-2-tycho@tycho.pizza>
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

This doesn't really count the number of open files, but the max possible
number of open files in an fd table.

In the next patch, we're going to introduce a helper to compute this number
exactly, so rename this one. (It is only called in one place, maybe we
should just inline it?)

Signed-off-by: Tycho Andersen <tandersen@netflix.com>
---
 fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 5fb0b146e79e..b1633c00bd3c 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -271,7 +271,7 @@ static inline void __clear_open_fd(unsigned int fd, struct fdtable *fdt)
 	__clear_bit(fd / BITS_PER_LONG, fdt->full_fds_bits);
 }
 
-static unsigned int count_open_files(struct fdtable *fdt)
+static unsigned int count_possible_open_files(struct fdtable *fdt)
 {
 	unsigned int size = fdt->max_fds;
 	unsigned int i;
@@ -302,7 +302,7 @@ static unsigned int sane_fdtable_size(struct fdtable *fdt, unsigned int max_fds)
 {
 	unsigned int count;
 
-	count = count_open_files(fdt);
+	count = count_possible_open_files(fdt);
 	if (max_fds < NR_OPEN_DEFAULT)
 		max_fds = NR_OPEN_DEFAULT;
 	return ALIGN(min(count, max_fds), BITS_PER_LONG);
-- 
2.34.1


