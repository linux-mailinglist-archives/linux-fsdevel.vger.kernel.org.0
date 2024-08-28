Return-Path: <linux-fsdevel+bounces-27570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B041962704
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 14:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFF71F23DD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84E0176228;
	Wed, 28 Aug 2024 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="m9CzRuMF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ckmK29ZZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82AA16A95E;
	Wed, 28 Aug 2024 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847896; cv=none; b=XXvtg1NHtHfZ0pTi1Qv480FF8CkqwlFV321Y7KFSAdcjPtuLsbHcmToF0+sgWu2wIcZCFKaWlG5ypYIEuJFchk6zxoJYKiTBQo09wweFqgCIIde30ZJsGU+l2Sduhf5Bw/YEgicdsa7elA8mh1Jm5AexIAtFZ8haheVRqd4xB5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847896; c=relaxed/simple;
	bh=UpZnwEa31kn/hNxSXGRyh4ZaCG4Zoa9CmZAVBWiAjLo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FaT5+j8rMny3sz7k7zOEva0nU3ySeoB+1+IigaeXinhGJzIMilyswARCplsrIynV+XjexU8LV9rR3JLzh/qRytzUxby+l+rMmllc5nsuSlUymJaT+7eeAaFhMku4yI7kmALMvOrjUMENPkY20SXdHkL6IYIynuUfurlcn8eU1pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=m9CzRuMF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ckmK29ZZ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B595D1151B67;
	Wed, 28 Aug 2024 08:24:52 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Wed, 28 Aug 2024 08:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1724847892;
	 x=1724934292; bh=tY4Yx5IDHNetp4MTmQE+UU5YSZdVDbIQ+s16XnY6VHA=; b=
	m9CzRuMFuDktN8Yxab7/MTUNiNtnaAIQOREZk9jjycv6D91m5zjje3Pmc6icfTK0
	q0K27qIOs4UyDrAKJQJX0FBIO+tUmWddth1CEgvorBEOCG6l6nz9N8YvXLk5axtj
	i0ajed/S70WicxTwpgdUm1TJzgsOgXN/nX1xgzxuOkH4ZSN/h3lWoqz/1ZWsuIPt
	Zplth0SYdgt0mWLMzPgrlNPLzG91C2tPxk2KsjmQFcLeWDvkXvy3ySf092PbG6YN
	WKeqlKsiXplWIYoTCcRBBUIUK53bivDgxOcfRkSS+ZC7MzWvEeYtNV/6ImvSmjy6
	er1//mswqR8MEvwaCWrfnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724847892; x=
	1724934292; bh=tY4Yx5IDHNetp4MTmQE+UU5YSZdVDbIQ+s16XnY6VHA=; b=c
	kmK29ZZccV35e8dETfYrVy65EUSjgfRcekjV/BZAAtL1g0vJGdlvpDVedxeUMD8j
	atB9GnwQ2Q2fozkN1Gl0AxVYJQY9M+pQUZEch8yoFYuB2kaL9EoKwMHR3rqEPYH/
	zpm7XaFTgbv+OGCRaSZ0uNyGfB+nro9AMXdCf1G5Q34/ZXdjn6WtvUZuU2mnlrnP
	RblNo27ua/jI4uOp8sUyBIatt9ZCLwXcx2kSS3GOpIVrTQtqj0kcx1HFJ5La9qjw
	9w//s7t+lw0idbi26p9SkRfnU9ytRRrb5+HPohHAksSRwse5UGmB+COWpQurKeO8
	Y49ciEs5aU++Tbhj2lqvw==
X-ME-Sender: <xms:ExfPZgpmmCTaWmb1k5uO4H68WiOjVz5lzVAlBpXUHsvhA8nWgn9Fjg>
    <xme:ExfPZmqKvoWcmA08FwAKPqAKwN2LVWH9_UesOzSoxCdIkcUzymv4dURsVgy-CYSGb
    6p5bmgmrIuDaO78i0o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefvddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdek
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprh
    gtphhtthhopehvihhntggvnhiiohdrfhhrrghstghinhhosegrrhhmrdgtohhmpdhrtghp
    thhtoheptghhrhhishhtohhphhgvrdhlvghrohihsegtshhgrhhouhhprdgvuhdprhgtph
    htthhopehmrghthhhivghurdguvghsnhhohigvrhhssegvfhhfihgtihhoshdrtghomhdp
    rhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopehnph
    highhgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgu
    mhhishdrohhrghdprhgtphhtthhopehsvghghhgvrheskhgvrhhnvghlrdgtrhgrshhhih
    hnghdrohhrghdprhgtphhtthhopegvsghighhgvghrsheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ExfPZlODlJ_zCkkXWT9Y-0sIxDZ8NvMj0IB_XcmqAB3mVKQNFWXDGA>
    <xmx:ExfPZn7on6_zmOjYvJdPBIO3av104-XvmzFPSMnBvrdixITq_grskA>
    <xmx:ExfPZv71YkY3sqPjtxMWeEc76-CNYwacmMVUgQGZijeq4yttJsb6mQ>
    <xmx:ExfPZniNM2xn1Wo8ehGmIW8Y3Vuvhtc4oct4DQfUsBRyWz-yzPOoMA>
    <xmx:FBfPZj7W4QeHlPPFDOB1-T6Fhpnlj9dtVl-xMRU7bvSsvfwYiXmSUGNy>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id EFF1B222006F; Wed, 28 Aug 2024 08:24:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 28 Aug 2024 12:24:12 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Segher Boessenkool" <segher@kernel.crashing.org>
Cc: "Eric Biggers" <ebiggers@kernel.org>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>, "Naveen N Rao" <naveen@kernel.org>,
 "Andy Lutomirski" <luto@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Theodore Ts'o" <tytso@mit.edu>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Message-Id: <fc19bf63-d519-46e2-be70-80202c85ff92@app.fastmail.com>
In-Reply-To: <Zs8HirKLk-SrwTIu@zx2c4.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <5deb67090b214f0e6eae96b7c406546d1a16f89b.1724309198.git.christophe.leroy@csgroup.eu>
 <20240827180819.GB2049@sol.localdomain>
 <20240827225330.GC29862@gate.crashing.org> <Zs8HirKLk-SrwTIu@zx2c4.com>
Subject: Re: [PATCH v2 05/17] vdso: Avoid call to memset() by getrandom
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Aug 28, 2024, at 11:18, Jason A. Donenfeld wrote:
> On Tue, Aug 27, 2024 at 05:53:30PM -0500, Segher Boessenkool wrote:
>> On Tue, Aug 27, 2024 at 11:08:19AM -0700, Eric Biggers wrote:
>> > 
>> > Is there a compiler flag that could be used to disable the generation of calls
>> > to memset?
>> 
>> -fno-tree-loop-distribute-patterns .  But, as always, read up on it, see
>> what it actually does (and how it avoids your problem, and mostly: learn
>> what the actual problem *was*!)
>
> This might help with various loops, but it doesn't help with the matter
> that this patch fixes, which is struct initialization. I just tried it
> with the arm64 patch to no avail.

Maybe -ffreestanding can help here? That should cause the vdso to be built
with the assumption that there is no libc, so it would neither add nor
remove standard library calls. Not sure if that causes other problems,
e.g. if the calling conventions are different.

       Arnd

