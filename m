Return-Path: <linux-fsdevel+bounces-73154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A11D0EB73
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 12:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C01B3300F31C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 11:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB75F33985B;
	Sun, 11 Jan 2026 11:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="H53l4ZS9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D712F3C34;
	Sun, 11 Jan 2026 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768131455; cv=none; b=gdYz/sMA8VHo76OYus9SkVZwGOkqlCz/MDOGdyN3A+rTt7bPGXxNyUIXWtYfq1BYGk22S23BWHd0fCCdKTzh4dqq4np970v3AO+9eGTseagQPnhdTkV5S7VEBth0Arqph7rTY569ruTptUH6iP3m4EIIQ/IVcyo7Eq4bWUQgnkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768131455; c=relaxed/simple;
	bh=lebpL3Sp1vUQHL7PtCrq03qU5HIMHV89z09xche3J4o=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=luFMMO5GFBkHNL3b0ElzU9LkbSdcXThnED48/AMGv+/vCn85ysvFMTcVOVK0t833jluAUKuNa6oIrohEsbSSItDxYCsE8KsLtpfoXGUuCAjhL5Mj1sx10TnTEi95kuaXZbKfj3y9dvhkBrUlNla2yskWxn7WSlfTX2VGo4X9f0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=H53l4ZS9; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Subject
	:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=JJYu6MDDks1v84AAohxz/CVFV9TSNzKOeI7DzNZb1vA=; t=1768131453; x=1768563453; 
	b=H53l4ZS9L442yLLRI1MAhSibVOTTry0ggKtMvk0gf/bJPdIlZbs2YRD7AlhEzR7f0pUiD06b9Se
	sX1EPo3A7l/DtHQbeMEXaM1WxdJDgKeTNBPACrQy189try+3buiVgcuLlaCczpb38ZEhWOt8e3iuH
	coJmGHrhdP5RrhcKZNqMTx1pRWCMn2E4dcMhf7WgRVE+ROE2EpOgucNvlSgv18GEVr4Dc2y6p2x4H
	azwtSqzKBnVMZbx3rsyLrHdvwhIDtRVH17rolu6x86/SURu1tGiuAWYFqf/tDwvOUkKyXRjDXR5ce
	ydfr4C2UhKbvs6logubtzq5m//XPN1YW4qFA==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1vetl8-002es8-0A;
	Sun, 11 Jan 2026 12:37:26 +0100
Message-ID: <7d4ac21f-491f-4f0a-bc50-7601cd1140ca@leemhuis.info>
Date: Sun, 11 Jan 2026 12:37:25 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [REGRESSION] fuse: xdg-document-portal gets stuck and causes suspend
 to fail in mainline
Autocrypt: addr=linux@leemhuis.info; keydata=
 xsFNBFJ4AQ0BEADCz16x4kl/YGBegAsYXJMjFRi3QOr2YMmcNuu1fdsi3XnM+xMRaukWby47
 JcsZYLDKRHTQ/Lalw9L1HI3NRwK+9ayjg31wFdekgsuPbu4x5RGDIfyNpd378Upa8SUmvHik
 apCnzsxPTEE4Z2KUxBIwTvg+snEjgZ03EIQEi5cKmnlaUynNqv3xaGstx5jMCEnR2X54rH8j
 QPvo2l5/79Po58f6DhxV2RrOrOjQIQcPZ6kUqwLi6EQOi92NS9Uy6jbZcrMqPIRqJZ/tTKIR
 OLWsEjNrc3PMcve+NmORiEgLFclN8kHbPl1tLo4M5jN9xmsa0OZv3M0katqW8kC1hzR7mhz+
 Rv4MgnbkPDDO086HjQBlS6Zzo49fQB2JErs5nZ0mwkqlETu6emhxneAMcc67+ZtTeUj54K2y
 Iu8kk6ghaUAfgMqkdIzeSfhO8eURMhvwzSpsqhUs7pIj4u0TPN8OFAvxE/3adoUwMaB+/plk
 sNe9RsHHPV+7LGADZ6OzOWWftk34QLTVTcz02bGyxLNIkhY+vIJpZWX9UrfGdHSiyYThHCIy
 /dLz95b9EG+1tbCIyNynr9TjIOmtLOk7ssB3kL3XQGgmdQ+rJ3zckJUQapLKP2YfBi+8P1iP
 rKkYtbWk0u/FmCbxcBA31KqXQZoR4cd1PJ1PDCe7/DxeoYMVuwARAQABzSdUaG9yc3RlbiBM
 ZWVtaHVpcyA8bGludXhAbGVlbWh1aXMuaW5mbz7CwZQEEwEKAD4CGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AWIQSoq8a+lZZX4oPULXVytubvTFg9LQUCaOO74gUJHfEI0wAKCRBytubv
 TFg9Lc4iD/4omf2z88yGmior2f1BCQTAWxI2Em3S4EJY2+Drs8ZrJ1vNvdWgBrqbOtxN6xHF
 uvrpM6nbYIoNyZpsZrqS1mCA4L7FwceFBaT9CTlQsZLVV/vQvh2/3vbj6pQbCSi7iemXklF7
 y6qMfA7rirvojSJZ2mi6tKIQnD2ndVhSsxmo/mAAJc4tiEL+wkdaX1p7bh2Ainp6sfxTqL6h
 z1kYyjnijpnHaPgQ6GQeGG1y+TSQFKkb/FylDLj3b3efzyNkRjSohcauTuYIq7bniw7sI8qY
 KUuUkrw8Ogi4e6GfBDgsgHDngDn6jUR2wDAiT6iR7qsoxA+SrJDoeiWS/SK5KRgiKMt66rx1
 Jq6JowukzNxT3wtXKuChKP3EDzH9aD+U539szyKjfn5LyfHBmSfR42Iz0sofE4O89yvp0bYz
 GDmlgDpYWZN40IFERfCSxqhtHG1X6mQgxS0MknwoGkNRV43L3TTvuiNrsy6Mto7rrQh0epSn
 +hxwwS0bOTgJQgOO4fkTvto2sEBYXahWvmsEFdLMOcAj2t7gJ+XQLMsBypbo94yFYfCqCemJ
 +zU5X8yDUeYDNXdR2veePdS3Baz23/YEBCOtw+A9CP0U4ImXzp82U+SiwYEEQIGWx+aVjf4n
 RZ/LLSospzO944PPK+Na+30BERaEjx04MEB9ByDFdfkSbM7BTQRSeAENARAAzu/3satWzly6
 +Lqi5dTFS9+hKvFMtdRb/vW4o9CQsMqL2BJGoE4uXvy3cancvcyodzTXCUxbesNP779JqeHy
 s7WkF2mtLVX2lnyXSUBm/ONwasuK7KLz8qusseUssvjJPDdw8mRLAWvjcsYsZ0qgIU6kBbvY
 ckUWkbJj/0kuQCmmulRMcaQRrRYrk7ZdUOjaYmjKR+UJHljxLgeregyiXulRJxCphP5migoy
 ioa1eset8iF9fhb+YWY16X1I3TnucVCiXixzxwn3uwiVGg28n+vdfZ5lackCOj6iK4+lfzld
 z4NfIXK+8/R1wD9yOj1rr3OsjDqOaugoMxgEFOiwhQDiJlRKVaDbfmC1G5N1YfQIn90znEYc
 M7+Sp8Rc5RUgN5yfuwyicifIJQCtiWgjF8ttcIEuKg0TmGb6HQHAtGaBXKyXGQulD1CmBHIW
 zg7bGge5R66hdbq1BiMX5Qdk/o3Sr2OLCrxWhqMdreJFLzboEc0S13BCxVglnPqdv5sd7veb
 0az5LGS6zyVTdTbuPUu4C1ZbstPbuCBwSwe3ERpvpmdIzHtIK4G9iGIR3Seo0oWOzQvkFn8m
 2k6H2/Delz9IcHEefSe5u0GjIA18bZEt7R2k8CMZ84vpyWOchgwXK2DNXAOzq4zwV8W4TiYi
 FiIVXfSj185vCpuE7j0ugp0AEQEAAcLBfAQYAQoAJgIbDBYhBKirxr6Vllfig9QtdXK25u9M
 WD0tBQJo47viBQkd8QjTAAoJEHK25u9MWD0tCH8P/1b+AZ8K3D4TCBzXNS0muN6pLnISzFa0
 cWcylwxX2TrZeGpJkg14v2R0cDjLRre9toM44izLaz4SKyfgcBSj9XET0103cVXUKt6SgT1o
 tevoEqFMKKp3vjDpKEnrcOSOCnfH9W0mXx/jDWbjlKbBlN7UBVoZD/FMM5Ul0KSVFJ9Uij0Z
 S2WAg50NQi71NBDPcga21BMajHKLFzb4wlBWSmWyryXI6ouabvsbsLjkW3IYl2JupTbK3viH
 pMRIZVb/serLqhJgpaakqgV7/jDplNEr/fxkmhjBU7AlUYXe2BRkUCL5B8KeuGGvG0AEIQR0
 dP6QlNNBV7VmJnbU8V2X50ZNozdcvIB4J4ncK4OznKMpfbmSKm3t9Ui/cdEK+N096ch6dCAh
 AeZ9dnTC7ncr7vFHaGqvRC5xwpbJLg3xM/BvLUV6nNAejZeAXcTJtOM9XobCz/GeeT9prYhw
 8zG721N4hWyyLALtGUKIVWZvBVKQIGQRPtNC7s9NVeLIMqoH7qeDfkf10XL9tvSSDY6KVl1n
 K0gzPCKcBaJ2pA1xd4pQTjf4jAHHM4diztaXqnh4OFsu3HOTAJh1ZtLvYVj5y9GFCq2azqTD
 pPI3FGMkRipwxdKGAO7tJVzM7u+/+83RyUjgAbkkkD1doWIl+iGZ4s/Jxejw1yRH0R5/uTaB MEK4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1768131453;a780db02;
X-HE-SMSGID: 1vetl8-002es8-0A

Lo! I can reliably get xdg-document-portal stuck on latest -mainline
(and -next, too; 6.18.4. works fine) trough the Signal flatpak, which
then causes suspend to fail:

"""
> [  194.439381] PM: suspend entry (s2idle)
> [  194.454708] Filesystems sync: 0.015 seconds
> [  194.696767] Freezing user space processes
> [  214.700978] Freezing user space processes failed after 20.004 seconds (1 tasks refusing to freeze, wq_busy=0):
> [  214.701143] task:xdg-document-po state:D stack:0     pid:2651  tgid:2651  ppid:1939   task_flags:0x400000 flags:0x00080002
> [  214.701151] Call Trace:
> [  214.701154]  <TASK>
> [  214.701167]  __schedule+0x2b8/0x5e0
> [  214.701181]  schedule+0x27/0x80
> [  214.701188]  request_wait_answer+0xce/0x260 [fuse]
> [  214.701202]  ? __pfx_autoremove_wake_function+0x10/0x10
> [  214.701212]  __fuse_simple_request+0x120/0x340 [fuse]
> [  214.701219]  fuse_lookup_name+0xc3/0x210 [fuse]
> [  214.701235]  fuse_lookup+0x99/0x1c0 [fuse]
> [  214.701242]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  214.701247]  ? fuse_dentry_init+0x23/0x50 [fuse]
> [  214.701257]  lookup_one_qstr_excl+0xa8/0xf0
> [  214.701264]  start_removing_noperm+0x59/0x80
> [  214.701268]  ? d_find_alias+0x82/0xd0
> [  214.701273]  fuse_reverse_inval_entry+0x7d/0x1f0 [fuse]
> [  214.701280]  ? fuse_copy_do+0x5f/0xa0 [fuse]
> [  214.701287]  fuse_notify+0x4a1/0x750 [fuse]
> [  214.701295]  ? iov_iter_get_pages2+0x1d/0x40
> [  214.701301]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  214.701305]  fuse_dev_do_write+0x2e4/0x440 [fuse]
> [  214.701313]  fuse_dev_write+0x6b/0xa0 [fuse]
> [  214.701320]  do_iter_readv_writev+0x161/0x260
> [  214.701327]  vfs_writev+0x168/0x3c0
> [  214.701334]  ? ksys_write+0xcd/0xf0
> [  214.701338]  ? do_writev+0x7f/0x110
> [  214.701341]  do_writev+0x7f/0x110
> [  214.701344]  do_syscall_64+0x7e/0x6b0
> [  214.701350]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  214.701352]  ? __handle_mm_fault+0x445/0x690
> [  214.701359]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  214.701363]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  214.701365]  ? count_memcg_events+0xd6/0x210
> [  214.701371]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  214.701373]  ? handle_mm_fault+0x212/0x340
> [  214.701377]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  214.701379]  ? do_user_addr_fault+0x2b4/0x7b0
> [  214.701387]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  214.701389]  ? irqentry_exit+0x6d/0x540
> [  214.701393]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  214.701395]  ? exc_page_fault+0x7e/0x1a0
> [  214.701398]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  214.701402] RIP: 0033:0x7f3c144f9982
> [  214.701467] RSP: 002b:00007fff80e2f388 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
> [  214.701470] RAX: ffffffffffffffda RBX: 00007f3bec000cf0 RCX: 00007f3c144f9982
> [  214.701472] RDX: 0000000000000003 RSI: 00007fff80e2f460 RDI: 0000000000000007
> [  214.701474] RBP: 00007fff80e2f3b0 R08: 0000000000000000 R09: 0000000000000000
> [  214.701475] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> [  214.701477] R13: 00007f3bec000cf0 R14: 00007f3c14bb8280 R15: 00007f3be8001200
> [  214.701481]  </TASK>
"""

Killing the mentioned process using "kill -9" doesn't help. I can
reliably trigger this in -mainline and -next using the Signal flatpak on
Fedora 43 by trying to send a picture (which gets xdg-document-portal
involved). It works the first time, but trying again won't and will
cause Signal to get stuck for a few seconds. Works fine in 6.18.4.

Is this maybe known already or does anybody have an idea what's wrong?
If not I guess I'll have to bisect this.

Ciao, Thorsten

#regzbot introduced: v6.18..
#regzbot title: fuse: xdg-document-portal gets stuck and causes suspend
to fail


