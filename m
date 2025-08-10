Return-Path: <linux-fsdevel+bounces-57199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B368B1F86C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 07:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C35189A679
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 05:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CFC1E32D3;
	Sun, 10 Aug 2025 05:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bzzt.net header.i=@bzzt.net header.b="RiOCAotp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d+AGpCL3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739A01DED4C;
	Sun, 10 Aug 2025 05:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754802617; cv=none; b=qQlndiAmz+vRHZnOpEFFriV77I++O6ZJI/1Kbu/PqLTLavC4cY9i7MxHtfJ//uBkGeGfVJrWu4N1/Vq04VlUvTP8E3A3ypTvXEQvM193RoPrLqsM7snk7yj6u4EwbeEbEh0IKdhLd0W1ZZZ5S041POMDaxxVFCBHKbxiDVTor5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754802617; c=relaxed/simple;
	bh=DWTCq8bkMNor4m4ua6gwcJThhUe0WQPRO1M8FnsLT8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocKDdVKeeLXE/NKYJ+o1EHipm46x3xj2KUbhu0Z7t7NhWjdq/rhoy+qu4mqKHZcG2cV7gj9NrBtkqnFcvPcncDVhlIsdqZKYO2grfLPL09fsSiW7I5DKmnChA9x9N8xTKDEs9TZOkhfuzT0zcfCCvi+X2hJWS7fi0eCN+3yddAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bzzt.net; spf=pass smtp.mailfrom=bzzt.net; dkim=pass (2048-bit key) header.d=bzzt.net header.i=@bzzt.net header.b=RiOCAotp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d+AGpCL3; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bzzt.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bzzt.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 99C27140007D;
	Sun, 10 Aug 2025 01:10:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 10 Aug 2025 01:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bzzt.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1754802614; x=
	1754889014; bh=OlCCal+fNGZcQ6+kJvw1v/1zAyc6Fk0jLbxn8+A2XYk=; b=R
	iOCAotp9kSEKPu99rcZfPqHMVaES+gpiF1ucYAfVLEBKwWo5Zeu+NkFbveerZleL
	FTyZLKGLeaY8KI7atqandh4n35/pIIu42ylV4lS69iP/oycoq9KFScxxeFjbnfKa
	wCOC+FuDQp+Vqci2L7/hSZkvEEkfql0Vy6HHB+RiMZF/Eu53oKq+umgXYN9+ZqRD
	jkFhmCPWqHDzLmURIwByrBddtturlWhonlITdSrDDZ+I6/2mNCBVqyciaIjxkxLd
	ROuUG2Dc4tN5XwQl8NmxjugXiY63XUxXBoAlDVJrwD/zcaE1RVq+q6CIfmaLRGPm
	PS0NZ83io74Xd2CW00h7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754802614; x=1754889014; bh=O
	lCCal+fNGZcQ6+kJvw1v/1zAyc6Fk0jLbxn8+A2XYk=; b=d+AGpCL3jwTFkV0b7
	hWX9nqmy9gXKP2qWrxdma5tfcHV4H1xC/T11t4SvvBph1abTW6H9nJ+u7923XwQm
	CI0G6C5o4kz7BTG4kmfH3fno0/n5xw93li7H+BGp6N3Z+TM+ca6V9nt0uaCFg5TE
	P/uYvWGHmLcmYKOobh4AyepqsIY+nUQVmkwao52ksd4gYxRmhdJRWUe7KR2gWp0b
	F4nyESqYWVsc0adubawIyItwbmRFCnGTT6gvpecjxMDvFd+NbgXYoycmztNbFYTa
	zmWLAhJqKshOZvVfryYBr0yfYcBYqlMM7tVph5n/qUMKJ1J+DcPUj5RyaCPxj73F
	haiLA==
X-ME-Sender: <xms:tSmYaM9dSkm7nxwzKCtigVyf7EHt4wR7jW1Iaxat3u-XFxzNUGHBzA>
    <xme:tSmYaLc7iYQmzkt2IjN7CuyZQWlEukeF3tYxMzjyWkEbgPbiN0_ymn3r00TAZ_2eP
    rMj-C4HiA1yyR8csRo>
X-ME-Received: <xmr:tSmYaDy3fKuB53mbg4XUFm17Kk7DzOu3-ts2uOShBTBv85Gp77Jvqg3eCtOkuTq0VarMiU3npS39>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdekjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetrhhnohhuthcugfhnghgvlhgvnhcuoegrrhhnohhuthessgii
    iihtrdhnvghtqeenucggtffrrghtthgvrhhnpefgiedutdehffehfeevieelhfefueejgf
    ehveeljeettddugeehvdekjeetveehgeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegrrhhnohhuthessgiiiihtrdhnvghtpdhnsggprhgtph
    htthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguhhhofigvlhhlshes
    rhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnthhonhihsehphhgvnhhomhgvrdhorh
    hgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehmrgigihhmihhlihgrnhesmhgsohhstghhrdhmvgdprhgtphhtthhopehrvghgrh
    gvshhsihhonhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepshgvuggr
    thdrughilhgvkhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:tSmYaILBJ4t7M7GCTW-NbnpsFDd8W-VM558U06fvAI-y3F0g6IyttA>
    <xmx:tSmYaNHlLCWS4IXys-Rw5VXpLLr_BN6QolGnm6CXkZRn9ECVe7HkiQ>
    <xmx:tSmYaM_Pw8bxkZ3hdEnE67Vfo9F6iWGyQx1EQyMlOy0yYCKNZ-Hhtg>
    <xmx:tSmYaFIribQT5hDrm91cGdt56OVBkF6Sf_v-Y5UEIaQWaaDoFMFN5A>
    <xmx:timYaKkT_tM1vC6Lge2HUUoCbzj3FpffXG1rSNCdMsTDs9bVEKFtp38x>
Feedback-ID: i8a1146c4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Aug 2025 01:10:12 -0400 (EDT)
From: Arnout Engelen <arnout@bzzt.net>
To: dhowells@redhat.com
Cc: antony@phenome.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	maximilian@mbosch.me,
	regressions@lists.linux.dev,
	sedat.dilek@gmail.com
Subject: Re: [REGRESSION] 9pfs issues on 6.12-rc1
Date: Sun, 10 Aug 2025 07:10:11 +0200
Message-ID: <20250810051011.1387079-1-arnout@bzzt.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2171405.1729521950@warthog.procyon.org.uk>
References: <2171405.1729521950@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Can you tell me what parameters you're mounting 9p with?  Looking at the
> backtrace:
> 
> [   32.390878]  bad_page+0x70/0x110
> [   32.391056]  free_unref_page+0x363/0x4f0
> [   32.391257]  p9_release_pages+0x41/0x90 [9pnet]
> [   32.391627]  p9_virtio_zc_request+0x3d4/0x720 [9pnet_virtio]
> [   32.391896]  ? p9pdu_finalize+0x32/0xa0 [9pnet]
> [   32.392153]  p9_client_zc_rpc.constprop.0+0x102/0x310 [9pnet]
> [   32.392447]  ? kmem_cache_free+0x36/0x370
> [   32.392703]  p9_client_read_once+0x1a6/0x310 [9pnet]
> [   32.392992]  p9_client_read+0x56/0x80 [9pnet]
> [   32.393238]  v9fs_issue_read+0x50/0xd0 [9p]
> [   32.393467]  netfs_read_to_pagecache+0x20c/0x480 [netfs]
> [   32.393832]  netfs_readahead+0x225/0x330 [netfs]
> [   32.394154]  read_pages+0x6a/0x250
> 
> it's using buffered I/O, but when I try and use 9p from qemu, it wants to use
> unbuffered/direct I/O.

The NixOS integration tests mount 9p with 'cache=loose' which triggers the
buffered I/O.

(I'm still seeing an issue in this area on 6.16-rc6, which remains also with
'only' 'cache=lookahead' - I'll do some more analysis before sharing more
about that, though)


Kind regards,

Arnout

