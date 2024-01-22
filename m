Return-Path: <linux-fsdevel+bounces-8461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0166C836EBE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 19:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256681C2964B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 18:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217F4612D0;
	Mon, 22 Jan 2024 17:24:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1737054BD7;
	Mon, 22 Jan 2024 17:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944282; cv=none; b=pWCta0azXIVQP4CbMftiMXZojWWTcbiAVKooD3rhoddPv12iMMBG90kkw8kskG6c50cLtHBxCTiKIk6H4ynn8vQKZimgsJchdKdWP9yJaDJlViM65qoK+j0AxvvJUARCY3ov0afO5FKZw6FhmMF9Jfjw1X/WOnK5IAsSbN/LLXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944282; c=relaxed/simple;
	bh=8nUGe8Li9gSxAKAhNYilV377xCO4oLUVdvIXdSPhhd8=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type:Subject; b=hjh7AW0M+Oh4Hd+HDLvQWxm9PdTffyh0/VRs6vRs4xtPMDLfodV8nmiC14GKzoR4XvJ2Al4oEV8z5/wdmB49wQk4/XqCKVqtOx2cep4uDzQncrok/vWZ8SeFjLrOlPS8JyqpS2f88r20APessygqQBvo/Anjdxdl+FMHj6jaKXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:40338)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rRxP4-0021o7-AB; Mon, 22 Jan 2024 09:44:06 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:39350 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rRxP3-008l5j-AU; Mon, 22 Jan 2024 09:44:05 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Jan Bujak <j@exia.io>
Cc: keescook@chromium.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  viro@zeniv.linux.org.uk,
  brauner@kernel.org,  linux-fsdevel@vger.kernel.org
In-Reply-To: <c7209e19-89c4-446a-b364-83100e30cc00@exia.io> (Jan Bujak's
	message of "Mon, 22 Jan 2024 21:01:06 +0900")
References: <c7209e19-89c4-446a-b364-83100e30cc00@exia.io>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Mon, 22 Jan 2024 10:43:59 -0600
Message-ID: <874jf5co8g.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1rRxP3-008l5j-AU;;;mid=<874jf5co8g.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/lma+EuFr0ycc+e9TktIXJpZ8FYTzs3UU=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4925]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Jan Bujak <j@exia.io>
X-Spam-Relay-Country: 
X-Spam-Timing: total 445 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 11 (2.5%), b_tie_ro: 10 (2.1%), parse: 1.21
	(0.3%), extract_message_metadata: 18 (4.1%), get_uri_detail_list: 3.2
	(0.7%), tests_pri_-2000: 14 (3.2%), tests_pri_-1000: 2.3 (0.5%),
	tests_pri_-950: 1.20 (0.3%), tests_pri_-900: 0.99 (0.2%),
	tests_pri_-90: 66 (14.8%), check_bayes: 64 (14.4%), b_tokenize: 9
	(2.0%), b_tok_get_all: 10 (2.3%), b_comp_prob: 3.3 (0.7%),
	b_tok_touch_all: 38 (8.6%), b_finish: 0.93 (0.2%), tests_pri_0: 317
	(71.1%), check_dkim_signature: 0.58 (0.1%), check_dkim_adsp: 2.7
	(0.6%), poll_dns_idle: 1.10 (0.2%), tests_pri_10: 3.0 (0.7%),
	tests_pri_500: 8 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Recent-ish changes in binfmt_elf made my program segfault
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Jan Bujak <j@exia.io> writes:

> Hi.
>
> I recently updated my kernel and one of my programs started segfaulting.
>
> The issue seems to be related to how the kernel interprets PT_LOAD header=
s;
> consider the following program headers (from 'readelf' of my reproduction=
):
>
> Program Headers:
> =C2=A0 Type=C2=A0 Offset=C2=A0=C2=A0 VirtAddr=C2=A0 PhysAddr=C2=A0 FileSi=
z=C2=A0 MemSiz=C2=A0=C2=A0 Flg Align
> =C2=A0 LOAD=C2=A0 0x001000 0x10000=C2=A0=C2=A0 0x10000=C2=A0=C2=A0 0x0000=
10 0x000010 R=C2=A0=C2=A0 0x1000
> =C2=A0 LOAD=C2=A0 0x002000 0x11000=C2=A0=C2=A0 0x11000=C2=A0=C2=A0 0x0000=
10 0x000010 RW=C2=A0 0x1000
> =C2=A0 LOAD=C2=A0 0x002010 0x11010=C2=A0=C2=A0 0x11010=C2=A0=C2=A0 0x0000=
00 0x000004 RW=C2=A0 0x1000
> =C2=A0 LOAD=C2=A0 0x003000 0x12000=C2=A0=C2=A0 0x12000=C2=A0=C2=A0 0x0000=
d2 0x0000d2 R E 0x1000
> =C2=A0 LOAD=C2=A0 0x004000 0x20000=C2=A0=C2=A0 0x20000=C2=A0=C2=A0 0x0000=
04 0x000004 RW=C2=A0 0x1000
>
> Old kernels load this ELF file in the following way ('/proc/self/maps'):
>
> 00010000-00011000 r--p 00001000 00:02 131=C2=A0 ./bug-reproduction
> 00011000-00012000 rw-p 00002000 00:02 131=C2=A0 ./bug-reproduction
> 00012000-00013000 r-xp 00003000 00:02 131=C2=A0 ./bug-reproduction
> 00020000-00021000 rw-p 00004000 00:02 131=C2=A0 ./bug-reproduction
>
> And new kernels do it like this:
>
> 00010000-00011000 r--p 00001000 00:02 131=C2=A0 ./bug-reproduction
> 00011000-00012000 rw-p 00000000 00:00 0
> 00012000-00013000 r-xp 00003000 00:02 131=C2=A0 ./bug-reproduction
> 00020000-00021000 rw-p 00004000 00:02 131=C2=A0 ./bug-reproduction
>
> That map between 0x11000 and 0x12000 is the program's '.data' and '.bss'
> sections to which it tries to write to, and since the kernel doesn't map
> them anymore it crashes.
>
> I bisected the issue to the following commit:
>
> commit 585a018627b4d7ed37387211f667916840b5c5ea
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:=C2=A0=C2=A0 Thu Sep 28 20:24:29 2023 -0700
>
> =C2=A0=C2=A0=C2=A0 binfmt_elf: Support segments with 0 filesz and misalig=
ned starts
>
> I can confirm that with this commit the issue reproduces, and with it
> reverted it doesn't.
>
> I have prepared a minimal reproduction of the problem available here,
> along with all of the scripts I used for bisecting:
>
> https://github.com/koute/linux-elf-loading-bug
>
> You can either compile it from source (requires Rust and LLD), or there's
> a prebuilt binary in 'bin/bug-reproduction` which you can run. (It's tiny,
> so you can easily check with 'objdump -d' that it isn't malicious).
>
> On old kernels this will run fine, and on new kernels it will
> segfault.

Frankly your ELF binary is buggy, and probably the best fix would be to
fix the linker script that is used to generate your binary.

The problem is the SYSV ABI defines everything in terms of pages and so
placing two ELF segments on the same page results in undefined behavior.

The code was fixed to honor your .bss segment and now your .data segment
is being stomped, because you defined them to overlap.

Ideally your linker script would place both your .data and .bss in
the same segment.  That would both fix the issue and give you a more
compact elf binary, while not changing the generated code at all.


That said regressions suck and it would be good if we could update the
code to do something reasonable in this case.

We can perhaps we can update the .bss segment to just memset an existing
page if one has already been mapped.  Which would cleanly handle a case
like yours.  I need to think about that for a moment to see what the
code would look like to do that.

Eric

