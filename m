Return-Path: <linux-fsdevel+bounces-50545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFA2ACD104
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 02:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 099FD17768C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 00:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CDF6F073;
	Wed,  4 Jun 2025 00:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="AzLdJ6J/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ncijGMWZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714FA2AE74;
	Wed,  4 Jun 2025 00:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998056; cv=none; b=RT7EIm1TkQ2x9yXM24w5ScwcaRuDzTvxeGCoTDjbaUlF/gF7ZwGi4PhaTlrCa4joBtJXE9ZLjdxTXXyC047X+rgDV4l6Ysh2o1300ga7IkCnmd+IdegGa2sgTLta3Pbg3BdQ16CuwXSPqOtEnvAfhtZFAMqvueJ7p8bkdZ8sVSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998056; c=relaxed/simple;
	bh=3cAUV+sySaTMyujkdgVHbVJwhToJF5rtzjhHRHQ6WY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YTy5hfg/W4Y81GPCbo+i02bOZxhPlXF6qWuoOPNU3yqqOj3HWEymp6KCXM8NyLWimUg65bADk9v+7eoUA3EL6ckyp+YO+UGwS99w6Knndarlvkgt36G6ziPNbPeS5GQavoI9yDfudDRCyrVrlrAPU4ECgVmRg0pSho6bFVf7AA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=AzLdJ6J/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ncijGMWZ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 21893254018B;
	Tue,  3 Jun 2025 20:47:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 03 Jun 2025 20:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1748998052; x=1749084452; bh=8E
	4r5jm5r5WrHurKT57Scu95isdwqwEQuleyrqi6IJI=; b=AzLdJ6J/tVxEYBvWOs
	MNVDU1e8WqPTE0VAcUDvQzFOTcAPLO9+j921wKu3Cd0PRmWh2eqsl5qVgLJlJlvS
	mnWmdCw6KKXyIAAV/Q/8lY+ULDN12h2e9jXlFsh/ITgWaf5/zhvuYup1Oh2hjykG
	yc7gQ90XSQbpW8ir+0fZ0xF0VeI5YEaAEOQyEvFqQReCd35JkyQScAwbB9+RqAn5
	BWqK+kNT/KP7XDI56exf7B8fHsA+zSyFhjbZtl3iobk+cQrfDyIPhNvH758wFwtK
	Suje5WnR1XQiNA1x5kuHpbmSVnB38BGGF+uFzNbmXdhRTFYHKRDpXamhSyRKP6Ec
	P4sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1748998052; x=1749084452; bh=8E4r5jm5r5WrHurKT57Scu95isdw
	qwEQuleyrqi6IJI=; b=ncijGMWZyzqKxRdqy/UvWgjouR+3r+MX5qymTvtOhfps
	+ggrB8AYuN4z540IOYfFmTPJmkUK3ZA84O6hNH+CyslnwRZ4CXLqr9bPMzaWG6e+
	wkiA0DGo4QPUl3TTPoTl20R8TPz2sI2LJ3yoKIxk82dtz9zXnhMHUY2mk7qj44Id
	SsQY2HR7VFXiqPan2LPX4g8x7Lsp08PyVCSnC+Lr5k0XH9ydaeccBfUPkaQG4J0P
	8HHGxC8vjk6+T/PbeJi21l07Mcxl77pRHPOthHcGrotBzlEkWgw005EuPTLCGJUS
	i+YTsN6kW+9SWwm1ThO0qWRu6EdwQeWl1K61rH/jeA==
X-ME-Sender: <xms:pJc_aJ7uhTMSgIYwcUX3yrZMd30vLBKb1_4R2tlI4q2xGyz4E8LbSA>
    <xme:pJc_aG6pBoqWnBLBNfy2P1aXLP53BUbhG_wGky05ua_meQQ4SDHCIO2vdo4Fgw1z9
    Vnp7Czcg0XobZ3hnIY>
X-ME-Received: <xmr:pJc_aAdQ1026Y6zhOhc5s4gaHsDE6iiyLB4cpOB0aOAQvQpGb1aytbDWcw3SaEUPcqdpwFOb-Fdc0WPFQHHflkcfgeiJ9QNKuDfqvtzUY82Ox8BdLt2EHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddufeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecu
    hfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepteetueetkeelffethfevvdfgtddvheelheduhfffgfdvtdeivdet
    vddtlefgfeejnecuffhomhgrihhnpehmrghofihtmhdrohhrghdpkhgvrhhnvghlrdhorh
    hgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepuddtpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvght
    pdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhroh
    esiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepmhesmhgrohifthhm
    rdhorhhgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopegrlhgvgigvihdrshhtrghrohhv
    ohhithhovhesghhmrghilhdrtghomhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pJc_aCLJ6rNQOOH-eN14f9HgiN8mJrGzhW2P-9vPrg2Jer_WzWS_-Q>
    <xmx:pJc_aNLzR6-Tay5sVNEJ05iJAvcxUgpGTZSbbxfwVBKHv5e6Iz2bjw>
    <xmx:pJc_aLwYMKlvaP9Gze2Vi3i2iNetsrJX0L70ni62nT8MyN_Rxw9DzA>
    <xmx:pJc_aJIBoYcpRiH8I4TBN0ulAGLBVvWY9kiiAAl2kdpbL8ivC5CWPg>
    <xmx:pJc_aCXT5uLLmxGoA1EmBQAB9Dvhr57UdKGRAvS3T4BdiSzG8HHojMl8>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 20:47:30 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Song Liu <song@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 0/3] landlock: walk parent dir with RCU, without taking references
Date: Wed,  4 Jun 2025 01:45:42 +0100
Message-ID: <cover.1748997840.git.m@maowtm.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mickaël, Song, Al and other reviewers,

In this series I present some experiments and investigations I did on a
potential optimization for Landlock, which is to avoid taking references
during the walk from the target being accessed toward the global root.  I
initially made this change and tested it, but did not send for review as I
was slightly uncertain about the correctness here, but I did saw
significant performance improvements.  However, earlier I saw Al Viro mention
in another discussion [1]:

> Note, BTW, that it might be better off by doing that similar to
> d_path.c - without arseloads of dget_parent/dput et.al.; not sure
> how feasible it is, but if everything in it can be done under
> rcu_read_lock(), that's something to look into.

which prompted me to pick this up again (even though I realize in the
reply to [1] Song wasn't sure this would work).  After some thinking, I
can think of one particular case where a simple chase of `d_parent`s would
be incorrect - that is, when unlinks are involved and dentry can turn
negative.  I _think_ that if we can check the global rename seqcount and
restart the pathwalk with the old approach if it changes, we might avoid
these sort of issues.  However I'm new to this and very welcome to be
proven wrong here :)

I realize that Song has already submitted a patch [2] to extract out the
pathwalk logic here and improve the mountpoint handling, and I don't want
this to block that in any way, but I think this is worth looking into
separate from that, based on the benchmarking results below:

Earlier when testing other Landlock performance improvement ideas I came
up with what I think is a "typical" workload [3] involving two layers and
a few rules to places like $HOME, /tmp, /proc etc. (Note that this is just
something I came up with, and Mickaël might not agree on the "typicalness"
here.)  With that we have:

Comparing:                    original pathwalk-noref
  // this is the % of time spent in Landlock within an openat syscall
  landlock_overhead:    avg = 33       27      (-6)      (%)
                     median = 34       28      (-6)      (%)
  // absolute time spent in Landlock
  landlock_hook:        avg = 852      627     (-26.4%)  (ns)
                     median = 827      611     (-26.1%)  (ns)
  // duration of the entire openat syscall
  open_syscall:         avg = 2507     2260    (-9.9%)   (ns)
                     median = 2451     2222    (-9.3%)   (ns)

I also ran the benchmarks Mickaël created [4], which tests openat
performance at various depths in the file hierarchy, all with 2 rules, and
the results are basically:

depth inc. /    % change in median time spent in Landlock
                          % change in median openat duration
                                   % in Landlock, old -> new
           1    -21.9%    +3.4%    9 -> 7
          10    -45.3%    -2.4%    16 -> 9
          20    -57.2%    -7.7%    21 -> 10
          30    -61.1%    -75.9%   22 -> 11
                        // ^^ On the unchanged kernel, this seems to be a bimodal
                        // distribution when landlock is involved.  Outliers happens
                        // much less on the kernel with this patch applied.

Raw results including histograms at https://fileshare.maowtm.org/landlock/20250603/index.html

[1]: https://lore.kernel.org/all/20250529231018.GP2023217@ZenIV/
[2]: https://lore.kernel.org/all/20250603065920.3404510-1-song@kernel.org/
[3]: https://github.com/torvalds/linux/commit/f1865ce970af97ac3b6f4edf580529b8cdc66371
[4]: https://github.com/landlock-lsm/landlock-test-tools/pull/16

Tingmao Wang (3):
  landlock: walk parent dir without taking references
  selftests/landlock: Add fs_race_test
  Restart pathwalk on rename seqcount change

 security/landlock/fs.c                        | 133 ++++-
 .../testing/selftests/landlock/fs_race_test.c | 505 ++++++++++++++++++
 2 files changed, 617 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/fs_race_test.c


base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21
--
2.49.0

