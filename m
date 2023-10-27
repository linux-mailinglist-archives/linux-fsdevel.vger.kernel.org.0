Return-Path: <linux-fsdevel+bounces-1452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FBE7DA2AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 23:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585A61C2112D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 21:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC9F3FE52;
	Fri, 27 Oct 2023 21:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="VsiA8AVU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F8E3FE47
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 21:52:06 +0000 (UTC)
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Oct 2023 14:52:05 PDT
Received: from weasel.tulip.relay.mailchannels.net (weasel.tulip.relay.mailchannels.net [23.83.218.247])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AE8D43
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 14:52:04 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 47CAF761E9D
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 21:47:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a302.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0AA40761FA1
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 21:47:00 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1698443220; a=rsa-sha256;
	cv=none;
	b=czLQRo5lU0gmk07N37k3GQViQYCXGA7T9bchbLT1hZ+CJxqvntvttGtxNdRxNbvunqN5YC
	e1EVjtM6QAD5ebEToPZ14CW7WTIiEeHaApIX1GgwcDm23z6nPsJnVv81u0E1FZ+okv9Qma
	2DeKNnhVqEcceWiQqEPi7S9KFUZ6VQyWXAQjAc6AXfCKf5nFP3EDc/8muPPNAJ4oZseq+/
	fWVq1m4rpeODBVz26nTBitYDGvoDF/W7975ig1NyX2EpjalRrKwun8+1daSe/3F3SjjVnk
	Wy2jYiPe5/KTzhXXbptNgp3bR228yDSvI/dPnq4WpFbkYXT8qsjR+ZM0x8zPmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1698443220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=JUpmUW5lV5go/OajmI3/1d9ZjKGRKa+65scvMbQY/vk=;
	b=DVDZpB9Y++6tSzwViqzw6pq4FhFoFv9flubOwWne7BHtupq3TNGS/kkeu3rBzcivMEDdFy
	NgEbzdnhRn/JlIzKK6MYv03V2P5M9iYDjCwvVE520yZCAN6NHPt/+p6jN0sg/QzrH0OWJe
	IHwpFm+MksUFV87wdSIpX9WyZJ4AABVLBzJZmiAR4S6yn87vN/bHW44fHwAYIPyYdUOjsi
	EjPeIrUeAQegLCalTwT8M4StZJtw1ugbL+PcbqoSvVC36TM2zZhnfD5PnvO7o6Tf/cuOed
	vxX+tjTeHOvPz19zJJpBMcXPvtlTzU/CG/5z/cw7EhQEgQLZgPJGLhaFtOzXdA==
ARC-Authentication-Results: i=1;
	rspamd-86646d89b6-6jlm5;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Harmony-Bottle: 6d83100633773f06_1698443220163_2696480518
X-MC-Loop-Signature: 1698443220163:4103661791
X-MC-Ingress-Time: 1698443220163
Received: from pdx1-sub0-mail-a302.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.115.216.135 (trex/6.9.2);
	Fri, 27 Oct 2023 21:47:00 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a302.dreamhost.com (Postfix) with ESMTPSA id 4SHGTb2Lbzz19h
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 14:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1698443219;
	bh=JUpmUW5lV5go/OajmI3/1d9ZjKGRKa+65scvMbQY/vk=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=VsiA8AVUfWorW32LYiaLgP281KPEpsVkgPRM4zVH/QbXXZqnL0oX3KHdXC9qXqGtm
	 xkFO8YmAiW9RC1EiY+QDVNi+xjh4WEBBXKsu2tC/xbO7wuabG856mwCU5wd90bBQoL
	 S3cgLX5EDukmI1gDg/TswfaYPB+E88/w4Om9BDlP76RBHgFUSzBZIYxM7tK3BzPEUQ
	 KLCcmopm2uFFZZLVD51xcKyvqcwp9DQeLsECw2XZ3T61zOWSYhgWIY+Grv5sCXR8mi
	 NscD7w6VpwPuHMaSKOxQfsU1pkZ0AaO6ORQ+mRtAVKCzGes151EjXrjQV478IAhGyQ
	 RtKZABtt/N8VA==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e00e5
	by kmjvbox (DragonFly Mail Agent v0.12);
	Fri, 27 Oct 2023 14:46:26 -0700
Date: Fri, 27 Oct 2023 14:46:26 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	Iurii Zaikin <yzaikin@google.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Vlastimil Babka <vbabka@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
	Lecopzer Chen <lecopzer.chen@mediatek.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Hildenbrand <david@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Pingfan Liu <kernelfans@gmail.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Petr Mladek <pmladek@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Guilherme G. Piccoli" <kernel@gpiccoli.net>,
	Mike Rapoport <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/2] Triggering a softlockup panic during SMP boot
Message-ID: <cover.1698441495.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
This pair of patches was the result of an unsuccessful attempt to set
softlockup_panic before SMP boot.  The rationale for wanting to set this
parameter is that some of the VMs that my team runs will occasionally
get stuck while onlining the non-boot processors as part of SMP boot.

In the cases where this happens, we find out about it after the instance
successfully boots; however, the machines can get stuck for tens of
minutes at a time before finally completing onlining processors.  Since
we pay per minute for many of these VMs there were two goals for setting
this value on boot: first, fail fast and hope that a subsequent boot
attempt will be successful.  Second, a panic is a little easier to keep
track of, especially if we're scraping serial logs after the fact.  In
essence, the goal is to trigger the failure earlier and hopefully get
more useful information for further debugging the problem as well.

While testing to make sure that this value was getting correctly set on
boot, I ran into a pair of surprises.  First, when the softlockup_panic
parameter was migrated to a sysctl alias, it had the side effect of
setting the parameter value after SMP boot has occurred, when it used to
be set before this.  Second, testing revealed that even though the
aliases were being correctly processed, the kernel was reporting the
commandline arguments as unrecognized. This generated a message in the
logs about an unrecognized parameter (even though it was) and the
parameter was passed as an environment variable to init.

The first patch ensures that aliased sysctl arguments are not reported
as unrecognized boot arguments.

The second patch moves the setting of softlockup_panic earlier in boot,
where it can take effect before SMP boot beings.

Thanks,

-K

Krister Johansen (2):
  proc: sysctl: prevent aliased sysctls from getting passed to init
  watchdog: move softlockup_panic back to early_param

 fs/proc/proc_sysctl.c  | 8 +++++++-
 include/linux/sysctl.h | 6 ++++++
 init/main.c            | 4 ++++
 kernel/watchdog.c      | 7 +++++++
 4 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.25.1


