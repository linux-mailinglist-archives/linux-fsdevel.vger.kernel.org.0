Return-Path: <linux-fsdevel+bounces-8479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D4583754B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 22:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603AA2881B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 21:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A3A482F9;
	Mon, 22 Jan 2024 21:29:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7694482C3;
	Mon, 22 Jan 2024 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705958977; cv=none; b=GlIgcapnDOiBRVHUqM3Ifdl2KXYOREWKd4iH79GCm2719HVAjkgMloJopZF/4VtAEX0P4k0X5VIbNPrD4qeWsg94pVlcOfZzO5Cog+BmOUy+KJpYyRmLzgi1Wm+x3myxwoUAtbKedu+RJhhSQ+fT1TiRzxl6bXPP1VLjj6CdccI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705958977; c=relaxed/simple;
	bh=uqGhb9FFQBgRrR1qacwu/hQ+z8p8rflfiebaNbyDCt8=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=OjTSP7JZsZxmdSdwkqBNx4qIYrY5D5BK7EIUZg6qWxgTmEsmyvFdyniReWEFoL8bS+o8ATPoSfCevh9ZvNFez7trXF7B5zomgTRPk/90absJ02Z4HB9Cu9Ib/PLMV8Oi0FQrw6ElhP16UDO921SRW7qUvjXG8QcXxERZqMgZaUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:59060)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rS1QK-000S5r-Uu; Mon, 22 Jan 2024 14:01:41 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:56840 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rS1QJ-009TEc-RK; Mon, 22 Jan 2024 14:01:40 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Kees Cook <keescook@chromium.org>
Cc: Jan Bujak <j@exia.io>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  viro@zeniv.linux.org.uk,
  brauner@kernel.org,  linux-fsdevel@vger.kernel.org
References: <c7209e19-89c4-446a-b364-83100e30cc00@exia.io>
	<874jf5co8g.fsf@email.froward.int.ebiederm.org>
	<202401221226.DAFA58B78@keescook>
Date: Mon, 22 Jan 2024 15:01:06 -0600
In-Reply-To: <202401221226.DAFA58B78@keescook> (Kees Cook's message of "Mon,
	22 Jan 2024 12:48:06 -0800")
Message-ID: <87v87laxrh.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1rS1QJ-009TEc-RK;;;mid=<87v87laxrh.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/boYqZr0d2qjokihrLz2wqN5hYf1CEY2Q=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: 
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4855]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 496 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 4.4 (0.9%), b_tie_ro: 3.0 (0.6%), parse: 1.19
	(0.2%), extract_message_metadata: 18 (3.6%), get_uri_detail_list: 3.5
	(0.7%), tests_pri_-2000: 23 (4.6%), tests_pri_-1000: 1.82 (0.4%),
	tests_pri_-950: 0.97 (0.2%), tests_pri_-900: 0.83 (0.2%),
	tests_pri_-90: 81 (16.3%), check_bayes: 80 (16.1%), b_tokenize: 8
	(1.7%), b_tok_get_all: 11 (2.2%), b_comp_prob: 2.5 (0.5%),
	b_tok_touch_all: 55 (11.0%), b_finish: 0.74 (0.2%), tests_pri_0: 354
	(71.4%), check_dkim_signature: 0.44 (0.1%), check_dkim_adsp: 2.9
	(0.6%), poll_dns_idle: 1.53 (0.3%), tests_pri_10: 1.76 (0.4%),
	tests_pri_500: 6 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Recent-ish changes in binfmt_elf made my program segfault
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Kees Cook <keescook@chromium.org> writes:

> On Mon, Jan 22, 2024 at 10:43:59AM -0600, Eric W. Biederman wrote:
>> Jan Bujak <j@exia.io> writes:
>>=20
>> > Hi.
>> >
>> > I recently updated my kernel and one of my programs started segfaultin=
g.
>> >
>> > The issue seems to be related to how the kernel interprets PT_LOAD hea=
ders;
>> > consider the following program headers (from 'readelf' of my reproduct=
ion):
>> >
>> > Program Headers:
>> > =C2=A0 Type=C2=A0 Offset=C2=A0=C2=A0 VirtAddr=C2=A0 PhysAddr=C2=A0 Fil=
eSiz=C2=A0 MemSiz=C2=A0=C2=A0 Flg Align
>> > =C2=A0 LOAD=C2=A0 0x001000 0x10000=C2=A0=C2=A0 0x10000=C2=A0=C2=A0 0x0=
00010 0x000010 R=C2=A0=C2=A0 0x1000
>> > =C2=A0 LOAD=C2=A0 0x002000 0x11000=C2=A0=C2=A0 0x11000=C2=A0=C2=A0 0x0=
00010 0x000010 RW=C2=A0 0x1000
>> > =C2=A0 LOAD=C2=A0 0x002010 0x11010=C2=A0=C2=A0 0x11010=C2=A0=C2=A0 0x0=
00000 0x000004 RW=C2=A0 0x1000
>> > =C2=A0 LOAD=C2=A0 0x003000 0x12000=C2=A0=C2=A0 0x12000=C2=A0=C2=A0 0x0=
000d2 0x0000d2 R E 0x1000
>> > =C2=A0 LOAD=C2=A0 0x004000 0x20000=C2=A0=C2=A0 0x20000=C2=A0=C2=A0 0x0=
00004 0x000004 RW=C2=A0 0x1000
>> >
>> > Old kernels load this ELF file in the following way ('/proc/self/maps'=
):
>> >
>> > 00010000-00011000 r--p 00001000 00:02 131=C2=A0 ./bug-reproduction
>> > 00011000-00012000 rw-p 00002000 00:02 131=C2=A0 ./bug-reproduction
>> > 00012000-00013000 r-xp 00003000 00:02 131=C2=A0 ./bug-reproduction
>> > 00020000-00021000 rw-p 00004000 00:02 131=C2=A0 ./bug-reproduction
>> >
>> > And new kernels do it like this:
>> >
>> > 00010000-00011000 r--p 00001000 00:02 131=C2=A0 ./bug-reproduction
>> > 00011000-00012000 rw-p 00000000 00:00 0
>> > 00012000-00013000 r-xp 00003000 00:02 131=C2=A0 ./bug-reproduction
>> > 00020000-00021000 rw-p 00004000 00:02 131=C2=A0 ./bug-reproduction
>> >
>> > That map between 0x11000 and 0x12000 is the program's '.data' and '.bs=
s'
>> > sections to which it tries to write to, and since the kernel doesn't m=
ap
>> > them anymore it crashes.
>> >
>> > I bisected the issue to the following commit:
>> >
>> > commit 585a018627b4d7ed37387211f667916840b5c5ea
>> > Author: Eric W. Biederman <ebiederm@xmission.com>
>> > Date:=C2=A0=C2=A0 Thu Sep 28 20:24:29 2023 -0700
>> >
>> > =C2=A0=C2=A0=C2=A0 binfmt_elf: Support segments with 0 filesz and misa=
ligned starts
>> >
>> > I can confirm that with this commit the issue reproduces, and with it
>> > reverted it doesn't.
>> >
>> > I have prepared a minimal reproduction of the problem available here,
>> > along with all of the scripts I used for bisecting:
>> >
>> > https://github.com/koute/linux-elf-loading-bug
>> >
>> > You can either compile it from source (requires Rust and LLD), or ther=
e's
>> > a prebuilt binary in 'bin/bug-reproduction` which you can run. (It's t=
iny,
>> > so you can easily check with 'objdump -d' that it isn't malicious).
>> >
>> > On old kernels this will run fine, and on new kernels it will
>> > segfault.
>>=20
>> Frankly your ELF binary is buggy, and probably the best fix would be to
>> fix the linker script that is used to generate your binary.
>>=20
>> The problem is the SYSV ABI defines everything in terms of pages and so
>> placing two ELF segments on the same page results in undefined behavior.
>>=20
>> The code was fixed to honor your .bss segment and now your .data segment
>> is being stomped, because you defined them to overlap.
>>=20
>> Ideally your linker script would place both your .data and .bss in
>> the same segment.  That would both fix the issue and give you a more
>> compact elf binary, while not changing the generated code at all.
>>=20
>>=20
>> That said regressions suck and it would be good if we could update the
>> code to do something reasonable in this case.
>>=20
>> We can perhaps we can update the .bss segment to just memset an existing
>> page if one has already been mapped.  Which would cleanly handle a case
>> like yours.  I need to think about that for a moment to see what the
>> code would look like to do that.
>
> It's the "if one has already been mapped" part which might
> become expensive...

I am wondering if perhaps we can add MAP_FIXED_NOREPLACE and take
some appropriate action if there is already a mapping there.

Such as printing a warning and skipping the action entirely for
a pure bss segment.  That would essentially replicate the previous
behavior.

At a minimum adding MAP_FIXED_NOREPLACE should allow us to
deterministically detect and warn about problems, making it easier
for people to understand why their binary won't run.

Eric




