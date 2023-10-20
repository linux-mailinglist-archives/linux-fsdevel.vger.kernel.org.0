Return-Path: <linux-fsdevel+bounces-829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFE17D102E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 15:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948D52824DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 13:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD121A727;
	Fri, 20 Oct 2023 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="DblyNsic";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qPDrbMUa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F711A70E
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 13:01:39 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011229F;
	Fri, 20 Oct 2023 06:01:37 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 6D7B55C0A81;
	Fri, 20 Oct 2023 09:01:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 20 Oct 2023 09:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1697806897; x=1697893297; bh=n3tK9iXwjjzkU82IWrN3D9zRjZ6TKtX5x7y
	fON1fVRk=; b=DblyNsic0DxzymS3EJcfMCdfKODSCWNIbgJMhoMlGI4nxXSqM9U
	IaUEEWsZlaEuAXfEpkHseLPR5gB8Mw7ozEf2dLIcafPsm62VB11Sgp20wmKIAwdz
	OsyxlHdZ54hRODQhHvGEez8oEVe55PFlbnQROFMoldejaQYwaWb7qeU6c/SKldat
	2CqVObLNPc76DrB7Efpg+czfXFQ7BChLPbkuK3/ElXTTkzMdzqM6NF3cGLvk8GN9
	yHxnP9YhYxr3IJ3DVlEd7LFFmgTO39cad6uWvb0SktPWI4orl24D9lACtB/VT2hG
	/uEQl0/bCuEuxswotYhPSO9yFcVtbDND87g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1697806897; x=1697893297; bh=n3tK9iXwjjzkU82IWrN3D9zRjZ6TKtX5x7y
	fON1fVRk=; b=qPDrbMUaN39DePSqgkqrjRnnero0F4K3TiReBSJi8JTM+5hQ9yI
	+jkK96OgrBS80jAMJmmKclWMK9AbPkyuff8z4oBNJ22EALZfd1UDbQXajfuTZvO+
	Y6eSqg6hpU/uYYe5OIBbpGJbJJNgbzZiM1Ap9HkJTNLa3t7O1O7cKKndg9HgxadJ
	8dR04uUOt6Lz2vD76WwqFSzmjlEjK2UogYZjL2B7qi5orEFyNdSAY8ftSQpA6Ot2
	nqKqpTxJyS4TxalL4e9YwP7/C2zdpFsRjS0OO3d68pskPfUa7GIQd0UgP+OkxCWB
	OlkueejwkPd9J6SbyZz/dte45iHsIAUumJA==
X-ME-Sender: <xms:MXoyZcV6-fqn7pysfcwU-lVJeznbeE69NCNZR9Qxan7_PE-hHdChNA>
    <xme:MXoyZQlgGEy6UfRQBoWVhESVmY9lUZUz3jCC5m5ucmx-c_XACHPG1RMFh2BZRQ89K
    GtRLSBe1KRf>
X-ME-Received: <xmr:MXoyZQZSVZrOsQBxbPT5Ei7tPNRxOcbfjofodHMlzwvsrCH4eu9Rw3R3iaSga-zBPOLjnoQwmx-ivQebaOcxBXr-Ilt-3GVWX2MkZ2BIcg5-WhqBaOkeqE67>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeekgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duueeugfffuedtvdevueekieeuuddtvdevueffkedtueetudegfeduueehueevvdenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmpdhtuhigsghoohhtrdgtohhmpdhlihhnrghroh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:MXoyZbW8cHS_DHGtf5lx6DukFlYNaA91nZg6XSb9RSYjygP9uvf78Q>
    <xmx:MXoyZWm7qgYFYX2vV7atFJ6yJ90fBS0X_tTzUcubpF3r6b_mUULzvg>
    <xmx:MXoyZQe-xI6FQb0HB9ZHo0vWsEa-IdhooNXHqRxjS0JNvJaTpAj7BQ>
    <xmx:MXoyZYX-bVlwSLy7lzuCIqJi3pOMbo_S_9ajpNjt0F_LQJY6zvQBjQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Oct 2023 09:01:33 -0400 (EDT)
Message-ID: <21c5f793-5894-5101-6c7a-bc27c59b9487@themaw.net>
Date: Fri, 20 Oct 2023 21:01:30 +0800
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
To: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 linux-fsdevel@vger.kernel.org, autofs@vger.kernel.org,
 Bill O'Donnell <bodonnel@redhat.com>, Christian Brauner
 <brauner@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
References: <CA+G9fYt75r4i39DuB4E3y6jRLaLoSEHGbBcJy=AQZBQ2SmBbiQ@mail.gmail.com>
 <71adfca4-4e80-4a93-b480-3031e26db409@app.fastmail.com>
 <CA+G9fYtFqCX82L=oLvTpOQRWfz6CUKb79ybBncULkK2gK3aTrg@mail.gmail.com>
 <6dde13bc-590d-483c-950c-4d8aeee98823@app.fastmail.com>
 <CADYN=9+O4ZGjewzkk90zis85+AQWKbNz6ttMKZiFravHuy4Vqw@mail.gmail.com>
From: Ian Kent <raven@themaw.net>
In-Reply-To: <CADYN=9+O4ZGjewzkk90zis85+AQWKbNz6ttMKZiFravHuy4Vqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/10/23 17:57, Anders Roxell wrote:
> On Fri, 20 Oct 2023 at 11:02, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Fri, Oct 20, 2023, at 09:48, Naresh Kamboju wrote:
>>> On Fri, 20 Oct 2023 at 12:07, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> On Thu, Oct 19, 2023, at 17:27, Naresh Kamboju wrote:
>>>>> The qemu-x86_64 and x86_64 booting with 64bit kernel and 32bit rootfs we call
>>>>> it as compat mode boot testing. Recently it started to failed to get login
>>>>> prompt.
>>>>>
>>>>> We have not seen any kernel crash logs.
>>>>>
>>>>> Anders, bisection is pointing to first bad commit,
>>>>> 546694b8f658 autofs: add autofs_parse_fd()
>>>>>
>>>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>>> Reported-by: Anders Roxell <anders.roxell@linaro.org>
>>>> I tried to find something in that commit that would be different
>>>> in compat mode, but don't see anything at all -- this appears
>>>> to be just a simple refactoring of the code, unlike the commits
>>>> that immediately follow it and that do change the mount
>>>> interface.
>>>>
>>>> Unfortunately this makes it impossible to just revert the commit
>>>> on top of linux-next. Can you double-check your bisection by
>>>> testing 546694b8f658 and the commit before it again?
>>> I will try your suggested ways.
>>>
>>> Is this information helpful ?
>>> Linux-next the regression started happening from next-20230925.
>>>
>>> GOOD: next-20230925
>>> BAD: next-20230926
>>>
>>> $ git log --oneline next-20230925..next-20230926 -- fs/autofs/
>>> dede367149c4 autofs: fix protocol sub version setting
>>> e6ec453bd0f0 autofs: convert autofs to use the new mount api
>>> 1f50012d9c63 autofs: validate protocol version
>>> 9b2731666d1d autofs: refactor parse_options()
>>> 7efd93ea790e autofs: reformat 0pt enum declaration
>>> a7467430b4de autofs: refactor super block info init
>>> 546694b8f658 autofs: add autofs_parse_fd()
>>> bc69fdde0ae1 autofs: refactor autofs_prepare_pipe()
>> Right, and it looks like the bottom five patches of this
>> should be fairly harmless as they only try to move code
>> around in preparation of the later changes, and even the
>> other ones should not cause any difference between a 32-bit
>> or a 64-bit /sbin/mount binary.
>>
>> If the native (full 64-bit or full 32-bit) test run still
>> works with the same version, there may be some other difference
>> here.
>>
>>>> What are the exact mount options you pass to autofs in your fstab?
>>> mount output shows like this,
>>> systemd-1 on /proc/sys/fs/binfmt_misc type autofs
>>> (rw,relatime,fd=30,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=1421)
>> This is only the binfmt-misc mount, which should not
>> prevent your rootfs from getting mounted, but it's possible
>> that failure to mount this prevents you from running
>> 32-bit binaries.
>>
>> I see this comes from the "proc-sys-fs-binfmt_misc.automount"
>> service in systemd.  I see this is defined in
>> https://github.com/systemd/systemd/blob/main/units/proc-sys-fs-binfmt_misc.automount
>> but I don't know exactly what its purpose is here. On a
>> 64-bit system, you normally use compat_binfmt_elf.ko to run
>> 32-bit binaries, and this does not require any specific mount
>> points. Alternatively, you could use binfmt_misc.ko with
>> the procfs mount to configure running arbitrary binary
>> formats such as arm32 on x86_64 with qemu-user emulation.
>>
>> I double-checked your rootfs image from
>> https://storage.tuxboot.com/debian/bookworm/i386/rootfs.ext4.xz
>> to ensure that this indeed contains i386 executables rather than
>> arm32 ones, and that is all fine.
>>
>> I also see in your log file at
>> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230926/testrun/20125035/suite/boot/test/gcc-13-lkftconfig-compat/log
>> that it is running the i386 binaries from the rootfs, but
>> it does get stuck soon after trying to set up the binfmt-misc
>> mount at the end of the log:
>>
>> [[0;32m  OK  [0m] Reached target [0;1;39mlocal-fs.target[0m - Local File Systems.
>>           Starting [0;1;39msystemd-binfmt.seâ€¦et Up Additional Binary Formats...
>>           Starting [0;1;39msystemd-tmpfiles-â€¦ Volatile Files and Directories...
>>           Starting [0;1;39msystemd-udevd.serâ€¦ger for Device Events and Files...
>> [   15.869404] igb 0000:01:00.0 eno1: renamed from eth0 (while UP)
>> [   15.883753] igb 0000:02:00.0 eno2: renamed from eth1
>> [   20.053885] (udev-worker) (175) used greatest stack depth: 12416 bytes left
>>   quit
>>
>> I'm a bit out of ideas at that point, my best guess now is
>> that your bisection points to something in autofs that makes
>> it hang while setting up autofs, but that neither autofs
>> nor binfmt-misc are actually being used otherwise.
>>
>> Maybe you can try to modify your rootfs to disable or remove
>> the systemd-binfmt.service, to confirm that autofs is not
>> actually needed here but does cause the crash?
> I removed systemd-binfmt.service from the rootfs and booted
> 546694b8f658 ("autofs: add autofs_parse_fd()") and now it booted fine.

I don't suppose you could try an automount after the boot is completed?


It seems a bit odd, it must be some sort of object lifetime inconsistency

but if that was the case automounts would at least fail to function mmm ...


Ian



