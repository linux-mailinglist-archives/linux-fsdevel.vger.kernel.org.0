Return-Path: <linux-fsdevel+bounces-73215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD18D11F51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 11:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BDD8302CDC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 10:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE311322B68;
	Mon, 12 Jan 2026 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="iy39d/aD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="om4QsQ5h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2D2264609;
	Mon, 12 Jan 2026 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214411; cv=none; b=OVEk+7U9i/lGLPl8IkcvxsTEolUqs5XOvwBzb19e81RjN6LF2KkS6Jch4/KhYLulbc6pa1BXZTiSrsSR/cwW82JJVhWsJ3IoTjzxW01+a0hhrCO2Tf1P/fn0JX9YvMpnbgQ44IVHIjjzZ+gtfHWAG176UjFyH31UUCkjyH6NO1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214411; c=relaxed/simple;
	bh=n1ZqfUYKc67w6gTDwbMfLkZmAMlNvxbs/YD6x5yAjzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+yf62B4RPzsqCiUkqikzYK34d5Jh+Y8Cr/y7Uyzwhg/sh8pfBzzL/6pL++rEEB/B2pIEEzPJuKzGogcPloYTO0UjJD3hvAE9Wpcj6hIaponWf4maZcPkW9VrKXS+jdM1ULE7PF+bm/0Kz4E9romJ2p5L3Cd52QiXx2Mu0j+vDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=iy39d/aD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=om4QsQ5h; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8F4C614000E7;
	Mon, 12 Jan 2026 05:40:07 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 12 Jan 2026 05:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768214407;
	 x=1768300807; bh=lAmqMjPqgUrXMj9eO05lH7ah7ZIONYrhBPq/mk7Xnwk=; b=
	iy39d/aDDdGVLfvmUGqUiYCUCDm1rhx3qhV3lH6S+j9va8WSNbyWlGdxZRrTRwi1
	W5FrPQ0xSkLLBr/VuuNhXizSWIpNI5GpWU+xadNyzDGiY/A7nUFqLDEAF5XkPAmi
	Z1Jwny/T4GxJtsf2wM0lTmPeQcc0t6qKMOOGmkyuPi8c6oQqkQXhAZ7GOsNxGjxi
	u3zmA+zAkxz/2XDddyJhXskqLOAwGIvTOUZM75MTMzSECQUt/hc91usDDmIrGReV
	cH0jtTzuxvz7QYdpSur1xqdP07vsPtk51XO2yCLWCkipiwFdhumSnYa3OamfwzKB
	ttKM24DGV4UW0WKGGTKV2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768214407; x=
	1768300807; bh=lAmqMjPqgUrXMj9eO05lH7ah7ZIONYrhBPq/mk7Xnwk=; b=o
	m4QsQ5hscbvTEQ8dRlfznNJWWm3LvVnmJx1ETNpE0fCEXgmb8Qr8pLYbScrLtesq
	eY+qsvF+Q1axubTJ8mOLrqmW2tEn2SZYKQh72eMmfffxeBxEB3YZDyP8OOn4hQt3
	YiovBIek9n16ODVGAb/ev5C92dHw5Kzd3s6wq7R8oXMz+BzgWg/UV9yiu1vsFkK8
	Y0LyR9xBbHQDyQOG/CEM3JrTj2YBiuUfR9c+8wze9FNWMgY8zt2uXN65I0MbV+Fp
	gefMRF8IvPfI1xfyocQJhDsGcQSPXTyBfzp/FB4qpTBlG/oHZQmyM7ape0vufCf3
	cKP1jejk8fsRI4M0/JazA==
X-ME-Sender: <xms:h89kaRt8XjGUD8lifdsinBnlLXAGoiqV1LQ4MxEq04mO159G1GvQiw>
    <xme:h89kaUh57A3q_Tw_f6LyqkAjKBsP17wNSN0OZKJeFA1VGDrJuiLtGC8RpM_b9OjxT
    y_waTUnP9SOdbRyWaj07G346Y2heh7diZjZiFGE03vq2Qj33TQ3>
X-ME-Received: <xmr:h89kaUqv4BSg9RTUds44Yhc0LSJEoRydONKx2vN8mNaRg2MRrtmBtNkHaINP8g1Lg-riSEh_IUz_ISp6dG71V6Z4FI69v5eoyi1LbQ_7fNlUl3gkbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeejgfeljeeuffehhfeukedvudfhteethedtheefjefhveduteehhfdttedv
    keekveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtgho
    mhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnh
    gvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopehlihhnuhigsehlvggvmhhhuhhi
    shdrihhnfhhopdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtph
    htthhopehrvghgrhgvshhsihhonhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:h89kaZsZyBMEpZwwBGssVYG_QmnOK4fQj3PobihNVsu9ZrUzdKVRNA>
    <xmx:h89kafbmpMu7lr96fO8MUEw9SSFrCw_ypLZhWqTNGpQXHA-fKyHaMQ>
    <xmx:h89kaYZ4aJBbQULGEtKNieAYc20Y-vcgnLOrDQ79mDGwy-rCCgm-HQ>
    <xmx:h89kaYlDitCL8l9mucysORTpEYDACAOtzdKNCLnQb-1yJBgwp-8q0w>
    <xmx:h89kaVqCARovQ6t40rLZnrl2Vxh-TXLkRD6mHYsVFLLQy-ZF05AlwGZ4>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 05:40:06 -0500 (EST)
Message-ID: <787edd09-6f86-406c-a466-083366967723@bsbernd.com>
Date: Mon, 12 Jan 2026 11:40:04 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] fuse: xdg-document-portal gets stuck and causes
 suspend to fail in mainline
To: NeilBrown <neil@brown.name>
Cc: Thorsten Leemhuis <linux@leemhuis.info>,
 Miklos Szeredi <miklos@szeredi.hu>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>
References: <7d4ac21f-491f-4f0a-bc50-7601cd1140ca@leemhuis.info>
 <ff46166e-6795-4cab-bfef-d0724200bc62@bsbernd.com>
 <176819030053.16766.15730807505551833487@noble.neil.brown.name>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <176819030053.16766.15730807505551833487@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/12/26 04:58, NeilBrown wrote:
> On Mon, 12 Jan 2026, Bernd Schubert wrote:
>>
>> On 1/11/26 12:37, Thorsten Leemhuis wrote:
>>> Lo! I can reliably get xdg-document-portal stuck on latest -mainline
>>> (and -next, too; 6.18.4. works fine) trough the Signal flatpak, which
>>> then causes suspend to fail:
>>>
>>> """
>>>> [  194.439381] PM: suspend entry (s2idle)
>>>> [  194.454708] Filesystems sync: 0.015 seconds
>>>> [  194.696767] Freezing user space processes
>>>> [  214.700978] Freezing user space processes failed after 20.004 seconds (1 tasks refusing to freeze, wq_busy=0):
>>>> [  214.701143] task:xdg-document-po state:D stack:0     pid:2651  tgid:2651  ppid:1939   task_flags:0x400000 flags:0x00080002
>>>> [  214.701151] Call Trace:
>>>> [  214.701154]  <TASK>
>>>> [  214.701167]  __schedule+0x2b8/0x5e0
>>>> [  214.701181]  schedule+0x27/0x80
>>>> [  214.701188]  request_wait_answer+0xce/0x260 [fuse]
>>>> [  214.701202]  ? __pfx_autoremove_wake_function+0x10/0x10
>>>> [  214.701212]  __fuse_simple_request+0x120/0x340 [fuse]
>>>> [  214.701219]  fuse_lookup_name+0xc3/0x210 [fuse]
>>>> [  214.701235]  fuse_lookup+0x99/0x1c0 [fuse]
>>>> [  214.701242]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [  214.701247]  ? fuse_dentry_init+0x23/0x50 [fuse]
>>>> [  214.701257]  lookup_one_qstr_excl+0xa8/0xf0
>>
>> Introduced by c9ba789dad15 ("VFS: introduce start_creating_noperm() and
>> start_removing_noperm()")?
>>
>> Why is the new code doing a lookup on an entry that is about to be
>> invalidated?
>>
>>
>> In order to handle this at least one fuse server process needs to be
>> available, but for this specific case the lookup still doesn't make sense.
>>
>> We could do something like this
>>
>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>> index 4b6b3d2758ff..7edbace7eddc 100644
>> --- a/fs/fuse/dir.c
>> +++ b/fs/fuse/dir.c
>> @@ -1599,6 +1599,15 @@ int fuse_reverse_inval_entry(struct fuse_conn
>> *fc, u64 parent_nodeid,
>>         if (!dir)
>>                 goto put_parent;
>>
>> +       /* Check dcache first - if not cached, nothing to invalidate */
>> +       name->hash = full_name_hash(dir, name->name, name->len);
>> +       entry = d_lookup(dir, name);
>> +       if (!entry) {
>> +               err = 0;
>> +               dput(dir);
>> +               goto put_parent;
>> +       }
>> +
>>         entry = start_removing_noperm(dir, name);
>>         dput(dir);
>>         if (IS_ERR(entry))
>>
>>
>> But let's assume the dentry exists - start_removing_noperm() will now
>> trigger a revalidate and get the same issue. From my point of view the
>> above commit should be reverted for fuse.
>>
>>
>>>> [  214.701264]  start_removing_noperm+0x59/0x80
>>>> [  214.701268]  ? d_find_alias+0x82/0xd0
>>>> [  214.701273]  fuse_reverse_inval_entry+0x7d/0x1f0 [fuse]
>>>> [  214.701280]  ? fuse_copy_do+0x5f/0xa0 [fuse]
>>>> [  214.701287]  fuse_notify+0x4a1/0x750 [fuse]
>>>> [  214.701295]  ? iov_iter_get_pages2+0x1d/0x40
>>>> [  214.701301]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [  214.701305]  fuse_dev_do_write+0x2e4/0x440 [fuse]
>>>> [  214.701313]  fuse_dev_write+0x6b/0xa0 [fuse]
>>>> [  214.701320]  do_iter_readv_writev+0x161/0x260
>>>> [  214.701327]  vfs_writev+0x168/0x3c0
>>>> [  214.701334]  ? ksys_write+0xcd/0xf0
>>>> [  214.701338]  ? do_writev+0x7f/0x110
>>>> [  214.701341]  do_writev+0x7f/0x110
>>>> [  214.701344]  do_syscall_64+0x7e/0x6b0
>>>> [  214.701350]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [  214.701352]  ? __handle_mm_fault+0x445/0x690
>>>> [  214.701359]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [  214.701363]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [  214.701365]  ? count_memcg_events+0xd6/0x210
>>>> [  214.701371]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [  214.701373]  ? handle_mm_fault+0x212/0x340
>>>> [  214.701377]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [  214.701379]  ? do_user_addr_fault+0x2b4/0x7b0
>>>> [  214.701387]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [  214.701389]  ? irqentry_exit+0x6d/0x540
>>>> [  214.701393]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [  214.701395]  ? exc_page_fault+0x7e/0x1a0
>>>> [  214.701398]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>> [  214.701402] RIP: 0033:0x7f3c144f9982
>>>> [  214.701467] RSP: 002b:00007fff80e2f388 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
>>>> [  214.701470] RAX: ffffffffffffffda RBX: 00007f3bec000cf0 RCX: 00007f3c144f9982
>>>> [  214.701472] RDX: 0000000000000003 RSI: 00007fff80e2f460 RDI: 0000000000000007
>>>> [  214.701474] RBP: 00007fff80e2f3b0 R08: 0000000000000000 R09: 0000000000000000
>>>> [  214.701475] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>>>> [  214.701477] R13: 00007f3bec000cf0 R14: 00007f3c14bb8280 R15: 00007f3be8001200
>>>> [  214.701481]  </TASK>
>>> """
>>>
>>> Killing the mentioned process using "kill -9" doesn't help. I can
>>> reliably trigger this in -mainline and -next using the Signal flatpak on
>>> Fedora 43 by trying to send a picture (which gets xdg-document-portal
>>> involved). It works the first time, but trying again won't and will
>>> cause Signal to get stuck for a few seconds. Works fine in 6.18.4.
>>>
>>> Is this maybe known already or does anybody have an idea what's wrong?
>>> If not I guess I'll have to bisect this.
>>>
>>> Ciao, Thorsten
>>>
>>> #regzbot introduced: v6.18..
>>> #regzbot title: fuse: xdg-document-portal gets stuck and causes suspend
>>> to fail
>>>
>>>
>>
>> Thanks,
>> Bernd
>>
> 
> I post a fix
> 
>   https://lore.kernel.org/all/176454037897.634289.3566631742434963788@noble.neil.brown.name/
> 
> a while ago.  There was some talk in that thread of reverting the
> breaking change instead.  I seems nothing happened.
> 
> Christian: should I resend my patch?

This didn't go to linux-fsdevel and I'm not subscribed to the other
lists. Might be the same for others. The patch looks good to me

Reviewed-by: Bernd Schubert <bschubert@ddn.com>



