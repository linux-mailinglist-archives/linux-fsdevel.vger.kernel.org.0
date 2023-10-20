Return-Path: <linux-fsdevel+bounces-828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD5F7D0FF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 14:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 501B7B21515
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 12:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CE019BCF;
	Fri, 20 Oct 2023 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="fIXxtgV/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RSSgDYDC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C167412E58
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 12:55:44 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCCD9F;
	Fri, 20 Oct 2023 05:55:42 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 4658B5C0B39;
	Fri, 20 Oct 2023 08:55:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 20 Oct 2023 08:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1697806542; x=1697892942; bh=JrP4OJD8fPdXF4emMGv5dlwmzRtZ3Wzrsc0
	lqDZ4fxU=; b=fIXxtgV/kZPOplIHH7rOYkaStqdvbWfyCNZ2Pq9eKNPJIJAA3WM
	YYnSPETFaHL5eaonMI46L8cUFXutC6z2Y2sSmvIlI71mZnwHlgLxk1VNZTHZsk+Z
	WzlNT+KOSg0O0roohmEuvULXrxRMSecSRj4WdJ1r4HNL4GI2jiihGBTZfDylsWRB
	6xBf7HnoCpkbezwuYvltQPmqefvebxbyCNL+KTRi2sOgDj+ovWNIUJy7y5JXbEkW
	O+CFOQgi4vfFvScP/Px01aWOAXahBmVskn8YGE8vzF+93e1onI6xDDlg41w7jm8m
	xgWlQ+jBcqsMt9pgP8Mk+hendOuB8iTDOpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1697806542; x=1697892942; bh=JrP4OJD8fPdXF4emMGv5dlwmzRtZ3Wzrsc0
	lqDZ4fxU=; b=RSSgDYDCmxdp9hbtu7RwRfEA1fs8I26uGcleZ81ddoE3yWFfeHu
	j6QEjBe/yTlVXlKOxcJ0UBkgtJ407pPwBEBEJdQeyOKh2b+AAGaCLWIsKDvWtwL/
	DIQqYeZiku8aAhlzhU5doWEYa9LuoH8+B7QkPOXCIqnNghGyczTc1h1zU3ekI0j3
	vuEKADyIJTVPept3qCZDO9tq52+oDHOtkCW0A5VDybD2lddMA5RSjDjMSmhJ0h7G
	Xia+qKKC9LGOqkqACSmIgVSP8cXyI7vO4Yml9mmKBfnWvIpqLfZYOZ8qlwxri7ZS
	8NOdP0dlhExxY1fRBE5z/+rukhenWCSFPpQ==
X-ME-Sender: <xms:zXgyZXemfRB_G3f83C62sEOKagtd05pJBVSHhqZAqj5hwXllV931zQ>
    <xme:zXgyZdPmuNi1dZnQqOkENkfTi8zv1MEyZNgPJiATTl-eRbBartGK0jKH9ZbMlwYn_
    A9muW1OgIn4>
X-ME-Received: <xmr:zXgyZQgyACIef1meG8ouP7-0RwaRYmArJHgMf_lwjKOnDzRB5WsY1w6S8Tksy_xwxHr3P0PNVxUixydjwLgmO5oWqigooRkpthJWs046WZ3k22W_-r2cGQm8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeekgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duueeugfffuedtvdevueekieeuuddtvdevueffkedtueetudegfeduueehueevvdenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmpdhtuhigsghoohhtrdgtohhmpdhlihhnrghroh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:zXgyZY_pS_sTwcDuX9lUfgr5ULDNIH36fktMY8i0B3l_jkFdozwxJg>
    <xmx:zXgyZTuwQMFog_LAav6qNDvafQar9Y6PyK06hiSlB4abqByxwTr0pg>
    <xmx:zXgyZXGnKogLAdJJlrXX_-D0vPyFdyQVvCmeuKIk44pIBytBXi0z0A>
    <xmx:zngyZc_LxSLcRrUFzanMN6FHgHFvA1qyb4jlnsujhB1Wugq65MHwkg>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Oct 2023 08:55:35 -0400 (EDT)
Message-ID: <2fd96f3f-1325-9faa-1dfd-4208a1b062c5@themaw.net>
Date: Fri, 20 Oct 2023 20:55:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: autofs: add autofs_parse_fd()
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 linux-fsdevel@vger.kernel.org, autofs@vger.kernel.org,
 Bill O'Donnell <bodonnel@redhat.com>, Christian Brauner
 <brauner@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYt75r4i39DuB4E3y6jRLaLoSEHGbBcJy=AQZBQ2SmBbiQ@mail.gmail.com>
 <71adfca4-4e80-4a93-b480-3031e26db409@app.fastmail.com>
 <CA+G9fYtFqCX82L=oLvTpOQRWfz6CUKb79ybBncULkK2gK3aTrg@mail.gmail.com>
 <6dde13bc-590d-483c-950c-4d8aeee98823@app.fastmail.com>
From: Ian Kent <raven@themaw.net>
In-Reply-To: <6dde13bc-590d-483c-950c-4d8aeee98823@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 20/10/23 17:02, Arnd Bergmann wrote:
> On Fri, Oct 20, 2023, at 09:48, Naresh Kamboju wrote:
>> On Fri, 20 Oct 2023 at 12:07, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Thu, Oct 19, 2023, at 17:27, Naresh Kamboju wrote:
>>>> The qemu-x86_64 and x86_64 booting with 64bit kernel and 32bit rootfs we call
>>>> it as compat mode boot testing. Recently it started to failed to get login
>>>> prompt.
>>>>
>>>> We have not seen any kernel crash logs.
>>>>
>>>> Anders, bisection is pointing to first bad commit,
>>>> 546694b8f658 autofs: add autofs_parse_fd()
>>>>
>>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>> Reported-by: Anders Roxell <anders.roxell@linaro.org>
>>> I tried to find something in that commit that would be different
>>> in compat mode, but don't see anything at all -- this appears
>>> to be just a simple refactoring of the code, unlike the commits
>>> that immediately follow it and that do change the mount
>>> interface.
>>>
>>> Unfortunately this makes it impossible to just revert the commit
>>> on top of linux-next. Can you double-check your bisection by
>>> testing 546694b8f658 and the commit before it again?
>> I will try your suggested ways.
>>
>> Is this information helpful ?
>> Linux-next the regression started happening from next-20230925.
>>
>> GOOD: next-20230925
>> BAD: next-20230926
>>
>> $ git log --oneline next-20230925..next-20230926 -- fs/autofs/
>> dede367149c4 autofs: fix protocol sub version setting
>> e6ec453bd0f0 autofs: convert autofs to use the new mount api
>> 1f50012d9c63 autofs: validate protocol version
>> 9b2731666d1d autofs: refactor parse_options()
>> 7efd93ea790e autofs: reformat 0pt enum declaration
>> a7467430b4de autofs: refactor super block info init
>> 546694b8f658 autofs: add autofs_parse_fd()
>> bc69fdde0ae1 autofs: refactor autofs_prepare_pipe()
> Right, and it looks like the bottom five patches of this
> should be fairly harmless as they only try to move code
> around in preparation of the later changes, and even the
> other ones should not cause any difference between a 32-bit
> or a 64-bit /sbin/mount binary.
>
> If the native (full 64-bit or full 32-bit) test run still
> works with the same version, there may be some other difference
> here.
>
>>> What are the exact mount options you pass to autofs in your fstab?
>> mount output shows like this,
>> systemd-1 on /proc/sys/fs/binfmt_misc type autofs
>> (rw,relatime,fd=30,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=1421)
> This is only the binfmt-misc mount, which should not
> prevent your rootfs from getting mounted, but it's possible
> that failure to mount this prevents you from running
> 32-bit binaries.
>
> I see this comes from the "proc-sys-fs-binfmt_misc.automount"
> service in systemd.  I see this is defined in
> https://github.com/systemd/systemd/blob/main/units/proc-sys-fs-binfmt_misc.automount
> but I don't know exactly what its purpose is here. On a
> 64-bit system, you normally use compat_binfmt_elf.ko to run
> 32-bit binaries, and this does not require any specific mount
> points. Alternatively, you could use binfmt_misc.ko with
> the procfs mount to configure running arbitrary binary
> formats such as arm32 on x86_64 with qemu-user emulation.
>
> I double-checked your rootfs image from
> https://storage.tuxboot.com/debian/bookworm/i386/rootfs.ext4.xz
> to ensure that this indeed contains i386 executables rather than
> arm32 ones, and that is all fine.
>
> I also see in your log file at
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230926/testrun/20125035/suite/boot/test/gcc-13-lkftconfig-compat/log
> that it is running the i386 binaries from the rootfs, but
> it does get stuck soon after trying to set up the binfmt-misc
> mount at the end of the log:
>
> [[0;32m  OK  [0m] Reached target [0;1;39mlocal-fs.target[0m - Local File Systems.
>           Starting [0;1;39msystemd-binfmt.seâ€¦et Up Additional Binary Formats...
>           Starting [0;1;39msystemd-tmpfiles-â€¦ Volatile Files and Directories...
>           Starting [0;1;39msystemd-udevd.serâ€¦ger for Device Events and Files...
> [   15.869404] igb 0000:01:00.0 eno1: renamed from eth0 (while UP)
> [   15.883753] igb 0000:02:00.0 eno2: renamed from eth1
> [   20.053885] (udev-worker) (175) used greatest stack depth: 12416 bytes left
> quit

Were there any console log messages at the time the problem occurred?


>
> I'm a bit out of ideas at that point, my best guess now is
> that your bisection points to something in autofs that makes
> it hang while setting up autofs, but that neither autofs
> nor binfmt-misc are actually being used otherwise.
>
> Maybe you can try to modify your rootfs to disable or remove
> the systemd-binfmt.service, to confirm that autofs is not
> actually needed here but does cause the crash?
>
>       Arnd

