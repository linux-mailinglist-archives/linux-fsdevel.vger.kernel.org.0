Return-Path: <linux-fsdevel+bounces-6353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF4D816A0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 10:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDBD284945
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 09:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C87125AF;
	Mon, 18 Dec 2023 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FF+gEf2e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WhIgoAM0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A8A134A3;
	Mon, 18 Dec 2023 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 477A3320034E;
	Mon, 18 Dec 2023 04:42:50 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 18 Dec 2023 04:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702892569; x=1702978969; bh=mDWXZC69A6
	okUKP72dg3ZZtzd8Dk/1nTRHU5WID4VDk=; b=FF+gEf2eEqNKbCPqEHE/MJctvu
	YL/mjMIskG8Lcb94dQ0IVI75tnmYgeEPmnGWn/BhdJJrpa4hqFXnjKr5++Rowjj+
	WuySNlYTOlgIxYoGrB4thbso3MR1HcGUnR1NYHjqrJ6qOv7rz7wuynVjEJcesviy
	f3uRttpYs0qRfiG4zZFCGvrpMClhHIypHRvDM25AsKQ8DZdJxQl40vufy7FJPk0r
	QsqYclvOIIm27QqGt/knaG2CtYbZs657+MxxdtaQVfcNVT0f46BIBZvLmSzPzHuF
	LTv+jWOPyBCRTyCrnW23J5Z/1HBZe/sDa0IMxOd/YJicZDyu1DG57ey1jDXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702892569; x=1702978969; bh=mDWXZC69A6okUKP72dg3ZZtzd8Dk
	/1nTRHU5WID4VDk=; b=WhIgoAM04uashNnOmj846P1I+ZxCaxOaD/IMVvtoxMPf
	a8UZ80KWhqm0akyt3SKfZwfBLxaE9HHIZyk7F0JBpQqsdyB8jsQ53HRZHxRKF7+E
	kKq2RsnGysRn8vPro3+/AOvAUEheUKeVTbRtl+6MWtEUazg9aTESy2MUtJUzzgjt
	rb9swOI/ijc52EGfR17s7eDCbYIntDHcd1R2nCqE629KFoslksDoJG+dVJ+2tBqm
	dYyI/NL762VMd7u9O3gK8akrDwbHmX7sVaiOBuTw0ZNlTZrB14tz+uK8aNfM221N
	Tz45E28cL4Tc4mizBHtiUxDWzdjsNXneI6X4/L02dw==
X-ME-Sender: <xms:FxSAZd521pKA808EQk541HkeGJK-r4MFWuhS1Nde_6XPuWwPdemmeg>
    <xme:FxSAZa4supT8ca-xRayfkeWgU-tPgkkdwB_dijVqxeyYNqPmpjGuKqSS3bnwZE02M
    0XGJ0sPoG_X8GVEhoE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:FxSAZUeyMaP1VvEAnE1nQV1Jes0dFJ7uYFt4Z26Ii7rC0diBpOjnXA>
    <xmx:FxSAZWIerFJTWmjw6KofChm1eZgANQporkBL16hdyJ5NVhKtpbTFrA>
    <xmx:FxSAZRLAMBEUsHwfUwWsA4ODh4Wj9vaH9i6cCWZCtuKTiyeZYqPTGA>
    <xmx:GRSAZQo_bk88XlARSnNJVMvwMJVxAsg05dMaFM8FGaRL3Ocpjzf7xw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id AE437B6008F; Mon, 18 Dec 2023 04:42:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1283-g327e3ec917-fm-20231207.002-g327e3ec9
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3cfc21ef-107f-419e-b31d-20f31d68126e@app.fastmail.com>
In-Reply-To: <20231213224118.1949-1-gregory.price@memverge.com>
References: <20231213224118.1949-1-gregory.price@memverge.com>
Date: Mon, 18 Dec 2023 09:42:29 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Gregory Price" <gourry.memverge@gmail.com>, linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Andy Lutomirski" <luto@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Michal Hocko" <mhocko@kernel.org>,
 "Tejun Heo" <tj@kernel.org>, "Ying Huang" <ying.huang@intel.com>,
 "Gregory Price" <gregory.price@memverge.com>,
 "Jonathan Corbet" <corbet@lwn.net>, rakie.kim@sk.com,
 "Hyeongtak Ji" <hyeongtak.ji@sk.com>, honggyu.kim@sk.com,
 vtavarespetr@micron.com, "Peter Zijlstra" <peterz@infradead.org>,
 jgroves@micron.com, ravis.opensrc@micron.com, sthanneeru@micron.com,
 emirakhur@micron.com, Hasan.Maruf@amd.com, seungjun.ha@samsung.com,
 "Johannes Weiner" <hannes@cmpxchg.org>,
 "Hasan Al Maruf" <hasanalmaruf@fb.com>, "Hao Wang" <haowang3@fb.com>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Michal Hocko" <mhocko@suse.com>,
 "Zhongkun He" <hezhongkun.hzk@bytedance.com>,
 "Frank van der Linden" <fvdl@google.com>,
 "John Groves" <john@jagalactic.com>,
 "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>
Subject: Re: [PATCH v3 00/11] mempolicy2, mbind2, and weighted interleave
Content-Type: text/plain

On Wed, Dec 13, 2023, at 22:41, Gregory Price wrote:
>  .../ABI/testing/sysfs-kernel-mm-mempolicy     |   4 +
>  ...fs-kernel-mm-mempolicy-weighted-interleave |  22 +
>  .../admin-guide/mm/numa_memory_policy.rst     |  67 ++
>  arch/alpha/kernel/syscalls/syscall.tbl        |   3 +
>  arch/arm/tools/syscall.tbl                    |   3 +
>  arch/m68k/kernel/syscalls/syscall.tbl         |   3 +
>  arch/microblaze/kernel/syscalls/syscall.tbl   |   3 +

In the patches that add the system call numbers, you still need to
modify __NR_compat_syscalls in arch/arm64/include/asm/unistd.h,
and add the compat syscall in arch/arm64/include/asm/unistd32.h.

One day I'll get around to fixing this so it's no longer
necessary.

      Arnd

