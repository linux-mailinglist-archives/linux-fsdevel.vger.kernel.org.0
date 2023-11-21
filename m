Return-Path: <linux-fsdevel+bounces-3314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D268F7F3213
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 16:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D08282881
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5D956753;
	Tue, 21 Nov 2023 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hgdqeObS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cLNVVaek"
X-Original-To: linux-fsdevel@vger.kernel.org
X-Greylist: delayed 608 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Nov 2023 07:15:50 PST
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD30BB;
	Tue, 21 Nov 2023 07:15:50 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id 2B7105815D2;
	Tue, 21 Nov 2023 10:05:39 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 21 Nov 2023 10:05:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1700579139; x=1700586339; bh=kU
	zhY3aPA9uxQWEn4jiRHeQXcTUR9GIV1qaAWo562aw=; b=hgdqeObSLjCXCERey/
	lhYeOe+4VGySwlXIiettstQFnTjTEjxu6tdt2flSUKkVEZ/8KvkKO/UGRnWa3PP9
	6hcyusHXrWr9RwM6CbMTnoMWXbGBZPyanj//33swIsn4CvR7Ynv0VN26+SCBKymR
	n2GgEKaZUo/JZT5OTIAIoZuWnZPoqE3VclbBkG+fLaojVD5U8AKQkIZoIj8i6spE
	4UCFNSKM6xRWR7JqmjuwH+W5yyCi90AkORZ4gIa5kHP4qczmObtLaoZN/oMu7Dj4
	ZwrGaLn6035M00bWIJwrQFHrUApywkRY2m15Ak0anscVepuEi/IBuM2/otX8JOW1
	bZsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700579139; x=1700586339; bh=kUzhY3aPA9uxQ
	WEn4jiRHeQXcTUR9GIV1qaAWo562aw=; b=cLNVVaekcEje0hKqj5BSAf0WltS6+
	6At0E9xuZHlFuISR3cBCWfhb2BVFXksnV4sp4Jj5gOnv9Rjda9s2lGbdAA/1q8Z3
	OLswZANcMl16M2EGu0JhLRG16ZIPCfPQBE0mBEKoYHF5bWXNwmadY/JXGQqzcMEZ
	Hzpv6hz+vbUC6QF7KO9ZnXWArgr2mcroyD2vSz8wY/91uJOVPQ7vvsGvnnMCCwPU
	UVd3eJPUnj0/UPQAVVZkp+KjyB5uEKYr38FjAHhMd3Tzs0x7/escjTuL4W5RRBqc
	UtjzbjSxH5BTHJ1ee907FxmTQWARZ4BkBt8AbbOEty3U7TUzUI0w1lIng==
X-ME-Sender: <xms:QcdcZaY19pQeUxvRaxOF_JYNyRwwxYro6C2QYa127G0LFDiYlK9pcg>
    <xme:QcdcZdYXBlJId5GsbX5WdwfrxNBqVPIOGPvZ_EcafznBzIOyJ9qRvIsdVWJR6SXVl
    Wm1jSkJEGyS6UzXXkY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegledgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:QcdcZU_Cquqtktz26f1F6Pj-3yE5wzdiL7UfD3vCv9cObuzs-mrdrQ>
    <xmx:QcdcZcoh_zzCzJz8ZWSX1eAekoj-QQmEFCy32ntsgIKWn50E4Jursw>
    <xmx:QcdcZVqjeL8az68VSD4BZgSiiW2pP0-KF4N-_AbeI7f61Cc7EGt_LQ>
    <xmx:Q8dcZWTJsZcFozmSH9puz359823LiOBk5E5Tlm15Z4k7b_z5Y-ULNg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5A704B60089; Tue, 21 Nov 2023 10:05:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b78e0487-d9e7-4584-8d6b-7de119ee7769@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYvcaozQvas-h55FPjXk+uomF2CyeYbWGCsXM8yGo4SZgA@mail.gmail.com>
References: 
 <CA+G9fYvcaozQvas-h55FPjXk+uomF2CyeYbWGCsXM8yGo4SZgA@mail.gmail.com>
Date: Tue, 21 Nov 2023 16:05:17 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 linux-fsdevel@vger.kernel.org, "open list" <linux-kernel@vger.kernel.org>,
 regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
 "Linux-sh list" <linux-sh@vger.kernel.org>
Cc: "Miklos Szeredi" <mszeredi@redhat.com>, "Ian Kent" <raven@themaw.net>,
 "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Rich Felker" <dalias@libc.org>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>
Subject: Re: SuperH: fs/namespace.c: In function '__se_sys_listmount':
 syscalls.h:258:9: internal compiler error: in change_address_1, at
 emit-rtl.c:2275
Content-Type: text/plain

On Tue, Nov 21, 2023, at 15:25, Naresh Kamboju wrote:
> The SuperH tinyconfig and allnoconfig builds started failing from 20231120 tag
> Please find the following builds warnings / errors.
>
> /builds/linux/include/linux/syscalls.h:233:9: note: in expansion of
> macro '__SYSCALL_DEFINEx'
>   233 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~~~
> /builds/linux/include/linux/syscalls.h:225:36: note: in expansion of
> macro 'SYSCALL_DEFINEx'
>   225 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name,
> __VA_ARGS__)
>       |                                    ^~~~~~~~~~~~~~~
> /builds/linux/fs/namespace.c:5019:1: note: in expansion of macro
> 'SYSCALL_DEFINE4'
>  5019 | SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
>       | ^~~~~~~~~~~~~~~
> 0x129d9d7 internal_error(char const*, ...)
> ???:0
> 0x5dbc4d fancy_abort(char const*, int, char const*)
> ???:0
> 0x7ddd3e adjust_address_1(rtx_def*, machine_mode, poly_int<1u, long>,
> int, int, int, poly_int<1u, long>)
> ???:0
> 0x81dd91 output_operand(rtx_def*, int)
> ???:0
> 0x81e5a4 output_asm_insn(char const*, rtx_def**)
> ???:0
> 0x8226a8 final_scan_insn(rtx_insn*, _IO_FILE*, int, int, int*)
> ???:0
> Please submit a full bug report,
> with preprocessed source if appropriate.
> Please include the complete backtrace with any bug report.
> See <file:///usr/share/doc/gcc-11/README.Bugs> for instructions.

It's clearly a compiler bug, and I get the same thing with
all sh4 compilers I have on my machine, I tried with gcc-7.5
through gcc-13.

I also see that the defconfigs work fine, so it's probably
just hitting some weird corner case. You could try opening
a bug report against gcc, but I'm not sure it's worth it.

      Arnd

