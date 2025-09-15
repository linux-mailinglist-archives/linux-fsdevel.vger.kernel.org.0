Return-Path: <linux-fsdevel+bounces-61275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 652BCB56EBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 05:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D221D3AECE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 03:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1EF21883F;
	Mon, 15 Sep 2025 03:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="KcEL3OhZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gFdKNyX7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9764EED8;
	Mon, 15 Sep 2025 03:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757905963; cv=none; b=ZafjyZbcj+u+R0ydwgM/yV7CIz4jq8OLdmHNX484pYlpbUn3+dY0/L5PebNFPePJNEQtJkBH5JAV6nuy+aXEP/7fGZ87cKabchsAbfbpbusEUM8cApj78zzyJZ3J+BECXHRn1WWcDgfWGYdY7jmTD7FfQd4fUaeGyDXBPpwdktU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757905963; c=relaxed/simple;
	bh=/+JHqRO9tYa/FmaKLUTaMxX9CNXp2MA0cMjZcCj3uOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YM5xVY+joHpAIPq7A8DOxae9vsw0j8t2BKrFNUV/W+R0bPFdvLTVldx0ZARbdp+ydlj5jAE6snNzOoU6RcCIBTKaAA2PSWqu9zfQ7K/cvJ465L7gS373BWHJIP4bTR6sxKsT/T5RHniCIZ0n8bHcyerEkQuTcaZ7lf4XWUlEm0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=KcEL3OhZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gFdKNyX7; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id AB2481D000DB;
	Sun, 14 Sep 2025 23:12:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sun, 14 Sep 2025 23:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:reply-to
	:subject:subject:to:to; s=fm1; t=1757905960; x=1757992360; bh=ng
	HbGiFrNZkfU0quubCpFoslCUK/+QsHWXRwwn5rbjE=; b=KcEL3OhZgV6pJJQZ92
	r/6f6A5rJBUAxyiXH9OVqwIUMj0yoI4ZqCO2Ijnt7Vbf+OiAhMlrYRaNAm+yh0k2
	GUz3poyAr9O0o7vGkc3WFZiSzemSAhnEd+xL+M86FJmk+/zFxoiMatbFoyk59Z3h
	IrIoQPTRX0TRErD7TmUR2aMBbSm2VCATToOJAU/iNRNF2/cQbTTeHI2Qk6wNnFKA
	EkIcBDZzp7ZF+18C4PhTiYhZ6Gbgq4YeqM6nS9azacDLB29g/6Goy/3r12dtjj4P
	llPYzxhBUBOT05kPVcoDXCvZMEHrHDnNSGlidQMXMkqPqDFjsNGGISateoTXgacs
	iADQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1757905960; x=1757992360; bh=ngHbGiFrNZkfU
	0quubCpFoslCUK/+QsHWXRwwn5rbjE=; b=gFdKNyX77Bjj6MwyR9XlYCU6h/dt6
	569wlHIJvIL9xCD4HZ69znVqSEtUISnccraethWF6SnkPb7qBDzy7AsLMM9nzmHE
	iL7BtMORN+pTB4s2nhcElLEO9PexoZUtMXrxzGR7XJ0nT3njj+ediZvegG51+Jka
	CYWM9IZmjwLUmQ65boQ0gBtnoVDcE0bp4xANhfRX3pzhHRHWZ+ZH3kO39SFKo5F5
	9iMbkETut+v48XayFM7esbN+ImtReXGr8R/l6crjDKnclkvLufl+kLxg0SOOGnmb
	xwc8nQp7cFF6UasD92Nos1gblfmp5SkGoxOFsEwAZOJCxi1kFTX5AJCqA==
X-ME-Sender: <xms:KITHaAGS9ytbgG3l01-e9i0ZMuDLtMa3pTwSZ247MrIuJO989LDXEg>
    <xme:KITHaMYR98y3WJ0JBkSeh50_s9jN7cTlbgaI8c5zsoyg4LshJdeuWd17nKCE-dd-2
    YNox_o9TkQOrw>
X-ME-Received: <xmr:KITHaExN0LGRSj5vvED3z34qQHfK9AnrN8NZswswihpeevi_0wv5GcD4cvXMk18MQZwZbORK4xvIYUvCPstCX2ID-5QIbHUoL6RLhlJGwo5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefieehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfthf
    evqddqjfgurhdqufhushhpvggtthdqlhhoficuldehmdenogfthfevqddqjfgurhdqufhu
    shhpvggtthculddvtddmnecujfgurhephffvvefufffkofhrgghrgfestdekredtredttd
    enucfhrhhomheppfgvihhluehrohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvght
    qeenucggtffrrghtthgvrhhnpefgvdeuveeugfduuddvveeutdeiheefgfejuddvieekff
    fhjefhhfffvdfgteelueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhope
    elpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhi
    nhhugidrohhrghdruhhkpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpth
    htohepthhrohhnughmhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthho
    nheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegr
    mhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:KITHaOSoNd7Ye9cINXrwc-FwMdSiOMvLj3BK99soFqtlqWic6_yg5Q>
    <xmx:KITHaBIqhtAG0LkQBrQU5ebSMsL2TFxjt9Xsy7HxvCQBjHuiXxkCEA>
    <xmx:KITHaFUm9nmJUf5Y402wrd6wdpJKIvGJNzagpnMfpHeKMD8X8W5m-A>
    <xmx:KITHaFRyFarXTySZcIgoW2COHkK6nJmxbaNS6H5liG9eH-ZlAsl91g>
    <xmx:KITHaNYWSvhXEMqUeV18jrf_f8CzDwx3PfIe7NnSm59M0mim0XNG2ZQN>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 23:12:37 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	"Jan Kara" <jack@suse.cz>
Subject: VFS: change ->atomic_open() calling to always have exclusive access
Date: Mon, 15 Sep 2025 13:01:06 +1000
Message-ID: <20250915031134.2671907-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: NeilBrown <neil@brown.name>
Content-Transfer-Encoding: 8bit

->atomic_open() is called with only a shared lock on the directory when
O_CREAT wasn't requested.  If the dentry is negative it is still called
because the filesystem might want to revalidate-and-open in an atomic
operations.  NFS does this to fullfil close-to-open consistency
requirements.

NFS has complex code to drop the dentry and reallocate with
d_alloc_parallel() in this case to ensure that only one lookup/open
happens at a time.  It would be simpler to have NFS return zero from
->d_revalidate in this case so that d_alloc_parallel() will be calling
in lookup_open() and NFS wan't need to worry about concurrency.

So this series makes that change to NFS to simplify atomic_open and remove
the d_drop() and d_alloc_parallel(), and then changes lookup_open() so that
atomic_open() can never be called without exclusive access to the dentry.

NeilBrown

