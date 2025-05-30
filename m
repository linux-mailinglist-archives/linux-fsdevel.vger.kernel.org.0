Return-Path: <linux-fsdevel+bounces-50231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF923AC92E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 18:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7EBE1BA48EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 15:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4198235346;
	Fri, 30 May 2025 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szCCOdrO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD9C20AF98;
	Fri, 30 May 2025 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748620717; cv=none; b=hiGAcSvi67+XYqzeIGWn6ZR2VO+5tg+d37ukI0DBGMjvJOUyRzEIT8Em7REzFEvhtyqV+h+KY8OKVJjsZfCUSRH/0DdAi67tIDPLfeL7xGvt019R3bWPAhMfcPdokwsmfowgrN83iUf8QIrFeRtIFX/1mDvkcDDWfIld/gBf8GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748620717; c=relaxed/simple;
	bh=Dn7w63nJ6Y9rLY2iVz6c/z004HPXclXizStSNQ97Z2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHpWNXzVv5LCG6ddXulpx714pFp6JC6+vYpBqUXQcdj0rrf2NvuIe+n5KGD0EB1bhdsciVbpP25hHcJF9K9ZpD8qzqUyu9X8AVNBis/8T/QvPfS9/eyOPPAriscllTZPK9PFqzOI6HyILYRh/0ZZcNbYBZpFo7xycL0e/K4BDxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szCCOdrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DB6C4CEE9;
	Fri, 30 May 2025 15:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748620716;
	bh=Dn7w63nJ6Y9rLY2iVz6c/z004HPXclXizStSNQ97Z2c=;
	h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
	b=szCCOdrO39lhUTIxUZu+KZi2JhkULZdjLFlWBRBCvhvJLc0qRyafF6ayAXDbVsvxd
	 hLm82UA3TGM2RrsHlsABUT5M3q7aPK835v3GvVNIHxUeUivWuK0IwhlmYa4WiLHJx7
	 Ip5K4cx6g1lsNDk1b3p1Qr/ZdhwxAIwiGB6ulCUU3t+ROHxfTYTaCd8MNDO0/0j1I/
	 hU8UWHu3fB3TWwcrRMEVdxu9HXrwUpZt6XftjV5S23f3ow3p6xsvrOBzsLx5AGV4QG
	 bmvso8T85n7F1gKnoasLsSdcwla5Ls3NEnrj7YtfyRiGSUJhiw5nwk53GDl/Zmf7m+
	 FC9hVX+65q0xg==
Message-ID: <7df55910-13b4-4ac5-b13b-22a44366e193@kernel.org>
Date: Fri, 30 May 2025 08:58:35 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: xarray regression: XArray: Add extra debugging check to xas_lock
 and friends
To: Luis Chamberlain <mcgrof@kernel.org>, Matthew Wilcox <willy@infradead.org>
Cc: Daniel Gomez <da.gomez@samsung.com>, Tamir Duberstein <tamird@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, kdevops@lists.linux.dev
References: <aAG_Sz_a2j3ummY2@bombadil.infradead.org>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Reply-To: da.gomez@kernel.org
Organization: kernel.org
In-Reply-To: <aAG_Sz_a2j3ummY2@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/04/2025 19.56, Luis Chamberlain wrote:
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: BUG at xa_alloc_index:57
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: CPU: 1 UID: 0 PID: 874 Comm: modprobe Tainted: G        W           6.15.0-rc2-next-20250417 #5 PREEMPT(full)
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Tainted: [W]=WARN
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.11-5 01/28/2025
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Call Trace:
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel:  <TASK>
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: dump_stack_lvl (lib/dump_stack.c:122) 
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: xa_alloc_index.constprop.0.cold (lib/test_xarray.c:602) test_xarray 
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: check_xa_alloc_1 (lib/test_xarray.c:940) test_xarray 
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: ? __pfx_xarray_checks (lib/test_xarray.c:2233) test_xarray 
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: check_xa_alloc (lib/test_xarray.c:1106) test_xarray 
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: xarray_checks (lib/test_xarray.c:2250) test_xarray 
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: do_one_initcall (init/main.c:1271) 
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: do_init_module (kernel/module/main.c:2930) 
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: init_module_from_file (kernel/module/main.c:3587) 
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: idempotent_init_module (./include/linux/spinlock.h:351 kernel/module/main.c:3528 kernel/module/main.c:3600) 
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: __x64_sys_finit_module (./include/linux/file.h:62 (discriminator 1) ./include/linux/file.h:83 (discriminator 1) kernel/module/main.c:3622 (discriminator 1) kernel/module/main.c:3609 (discriminator 1) kernel/module/main.c:3609 (discriminator 1)) 
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1)) 
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RIP: 0033:0x7f0a99f18779
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
> All code
> ========
>    0:	ff c3                	inc    %ebx
>    2:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
>    9:	00 00 00 
>    c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>   11:	48 89 f8             	mov    %rdi,%rax
>   14:	48 89 f7             	mov    %rsi,%rdi
>   17:	48 89 d6             	mov    %rdx,%rsi
>   1a:	48 89 ca             	mov    %rcx,%rdx
>   1d:	4d 89 c2             	mov    %r8,%r10
>   20:	4d 89 c8             	mov    %r9,%r8
>   23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
>   28:	0f 05                	syscall
>   2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
>   30:	73 01                	jae    0x33
>   32:	c3                   	ret
>   33:	48 8b 0d 4f 86 0d 00 	mov    0xd864f(%rip),%rcx        # 0xd8689
>   3a:	f7 d8                	neg    %eax
>   3c:	64 89 01             	mov    %eax,%fs:(%rcx)
>   3f:	48                   	rex.W
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
>    6:	73 01                	jae    0x9
>    8:	c3                   	ret
>    9:	48 8b 0d 4f 86 0d 00 	mov    0xd864f(%rip),%rcx        # 0xd865f
>   10:	f7 d8                	neg    %eax
>   12:	64 89 01             	mov    %eax,%fs:(%rcx)
>   15:	48                   	rex.W
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RSP: 002b:00007fffcb2588c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RAX: ffffffffffffffda RBX: 000055e8f735a970 RCX: 00007f0a99f18779
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RDX: 0000000000000000 RSI: 000055e8e9dd2328 RDI: 0000000000000003
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: 000055e8f735c410
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 000055e8e9dd2328
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: R13: 0000000000040000 R14: 000055e8f735aa80 R15: 0000000000000000
> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel:  </TASK>

I've been looking into this issue and noticed that setting the XArray operation
state to a valid state was removed in patch [1]. Can you elaborate more why this
was removed?

[1] 6684aba0780da "XArray: Add extra debugging check to xas_lock and friends"

Reverting behaviour makes it work again:

diff --git a/lib/xarray.c b/lib/xarray.c
index ee826f1a21fe..00b15287c292 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -2386,6 +2386,8 @@ void xa_destroy(struct xarray *xa)
        xas_lock_irqsave(&xas, flags);
        entry = xa_head_locked(xa);
        RCU_INIT_POINTER(xa->xa_head, NULL);
+       if (xas_top(xas.xa_node))
+               xas.xa_node = NULL;
        xas_init_marks(&xas);
        if (xa_zero_busy(xa))
                xa_mark_clear(xa, XA_FREE_MARK);

However, based on [2], this might not be the right fix.

[2]
https://lore.kernel.org/all/Z98oChgU7Z9wyTw1@casper.infradead.org/

The problem shows up in a test from check_xa_alloc_1(). The xa_state
is initialized during __xa_alloc() (via xa_alloc_index() → xa_alloc() →
__xa_alloc()), but the internal xa_node stays in an invalid state. So when we
try to allocate again at that same index after xa_destroy(), xas is still
invalid, leading to the BUG above. This has nothing to do with the debug check
added in commit [1].

Also, since xas stays invalid, xa_destroy() skips setting XA_FREE_MARK (via
xas_init_marks()), which I think is needed because we declared the array with
XA_FLAGS_TRACK_FREE flag in DEFINE_XARRAY_ALLOC(xa0).

Can you clarify why we cannot set the XArray state to valid and what would be
the expected behaviour? As Luis reported, this is failing in kdevops CI which is
now testing XArray tests among others in a daily basis.


