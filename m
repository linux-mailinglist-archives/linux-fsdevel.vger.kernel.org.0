Return-Path: <linux-fsdevel+bounces-812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BC07D0B0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 11:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704A9281F24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 09:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D16711197;
	Fri, 20 Oct 2023 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="MRQLJuJP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oIyow9b1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610EC11189
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 09:02:28 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA85AB;
	Fri, 20 Oct 2023 02:02:26 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id E97685C0B5A;
	Fri, 20 Oct 2023 05:02:23 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 20 Oct 2023 05:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1697792543; x=1697878943; bh=FcZxcWmN4rt6MTl87TIqjXzrg56uxVeaVVC
	YhpBR/1c=; b=MRQLJuJP+RdPNLMAMRf+iNgyoLGXB9KXbG1vpvhq7wH+4P/CU1l
	zgTQpC3h4pdgs9A00oMW3iODj1i+tL5Zr/Ec2pRGpcuR3RisyfpjIOS1QxRp9HDz
	0jWBSev0WZtdnO2FrINsEklmKGeXcGvQ+q1qb3IqiCW1msYaE6Jrdx99QnkR6vKD
	8n8eZpSA2dI8r/Pk4nTV98lzjEO3iRVkCSP00Nx6vTNRVH09lI/Dn82RD0NbMUdo
	UorEI9ENA5745xsHM+IIp5PJY6fyiyLqeS3r21yQmnbh/5EtZJtoOM9ZjUm7UqqQ
	+no/IejmP8YpO7nZ6tCMvbdURxeZJQHMBdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1697792543; x=1697878943; bh=FcZxcWmN4rt6MTl87TIqjXzrg56uxVeaVVC
	YhpBR/1c=; b=oIyow9b1clhk2b+4VPVoCXOD13GCwm7ZrfX5pQRbJc0c6/tkKrK
	DiFiVAvvBWPxTpGgPT3L9MRIsEH8fDpWZ2DCO2xY0GDPBOJd6AyDp+l0f0Z6QtHn
	ILWGMnF0M8royoZhfSbrS2DtAv43Cnpnq/wBF+r2c1vPUBAbpbZ6NnugmWjOhrWc
	0Ivn4Rnt+wOaP3YjJS1bgaoCtxqdOnMDVpcwTuyIxjs4HCpllp+gA2WTwFkT+9Fz
	IOwhCNAjjc7/bS8nUKGgXmUSMvAEDjSp6wOkoN4pgoLjLL1SQkUYv0Fnbwrsdphf
	rRWnrWB40CbDYX//FuZQlQHfZ3u43WWGowA==
X-ME-Sender: <xms:H0IyZcsNoeD7WHl2NfcvBWpa0bqwchpfdF11BWjJIPqnkSmwfwvXqw>
    <xme:H0IyZZddEWAAC6i9C9hhnuI2B6QS-jp9ZuOffaDNi7NiqaXNLZCA7R7_302Juv69F
    bD8IDXcI_x_EfsxIn8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeekgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepleevgfettdduheetkedtgeefffdvtdduveehtdfgveehieelvdegffdvudek
    feelnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpthhugigsohhothdrtghomhdplh
    hinhgrrhhordhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:H0IyZXzbDrIy9AiOM4NBJ5cTO2Y8nRLXpziTecRaGL_5tTL6MtPx8g>
    <xmx:H0IyZfNHuEyZsZsGUNja40hZuaCluJS74nCk5hV9h_Ex2jnVbsmf-A>
    <xmx:H0IyZc-4YoUcUQdkzV7rmGIzcKolIZy2osuQCbF7G0MsFWGk4q-akw>
    <xmx:H0IyZZN7-YE7vs52Qzl4CwO-_Z4a7xZrJJUNHnCCLQjXm_KRZ07MDg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id F0C5EB60089; Fri, 20 Oct 2023 05:02:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6dde13bc-590d-483c-950c-4d8aeee98823@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYtFqCX82L=oLvTpOQRWfz6CUKb79ybBncULkK2gK3aTrg@mail.gmail.com>
References: 
 <CA+G9fYt75r4i39DuB4E3y6jRLaLoSEHGbBcJy=AQZBQ2SmBbiQ@mail.gmail.com>
 <71adfca4-4e80-4a93-b480-3031e26db409@app.fastmail.com>
 <CA+G9fYtFqCX82L=oLvTpOQRWfz6CUKb79ybBncULkK2gK3aTrg@mail.gmail.com>
Date: Fri, 20 Oct 2023 11:02:02 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>
Cc: "open list" <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 linux-fsdevel@vger.kernel.org, autofs@vger.kernel.org,
 "Ian Kent" <raven@themaw.net>, "Bill O'Donnell" <bodonnel@redhat.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>
Subject: Re: autofs: add autofs_parse_fd()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023, at 09:48, Naresh Kamboju wrote:
> On Fri, 20 Oct 2023 at 12:07, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Thu, Oct 19, 2023, at 17:27, Naresh Kamboju wrote:
>> > The qemu-x86_64 and x86_64 booting with 64bit kernel and 32bit root=
fs we call
>> > it as compat mode boot testing. Recently it started to failed to ge=
t login
>> > prompt.
>> >
>> > We have not seen any kernel crash logs.
>> >
>> > Anders, bisection is pointing to first bad commit,
>> > 546694b8f658 autofs: add autofs_parse_fd()
>> >
>> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>> > Reported-by: Anders Roxell <anders.roxell@linaro.org>
>>
>> I tried to find something in that commit that would be different
>> in compat mode, but don't see anything at all -- this appears
>> to be just a simple refactoring of the code, unlike the commits
>> that immediately follow it and that do change the mount
>> interface.
>>
>> Unfortunately this makes it impossible to just revert the commit
>> on top of linux-next. Can you double-check your bisection by
>> testing 546694b8f658 and the commit before it again?
>
> I will try your suggested ways.
>
> Is this information helpful ?
> Linux-next the regression started happening from next-20230925.
>
> GOOD: next-20230925
> BAD: next-20230926
>
> $ git log --oneline next-20230925..next-20230926 -- fs/autofs/
> dede367149c4 autofs: fix protocol sub version setting
> e6ec453bd0f0 autofs: convert autofs to use the new mount api
> 1f50012d9c63 autofs: validate protocol version
> 9b2731666d1d autofs: refactor parse_options()
> 7efd93ea790e autofs: reformat 0pt enum declaration
> a7467430b4de autofs: refactor super block info init
> 546694b8f658 autofs: add autofs_parse_fd()
> bc69fdde0ae1 autofs: refactor autofs_prepare_pipe()

Right, and it looks like the bottom five patches of this
should be fairly harmless as they only try to move code
around in preparation of the later changes, and even the
other ones should not cause any difference between a 32-bit
or a 64-bit /sbin/mount binary.

If the native (full 64-bit or full 32-bit) test run still
works with the same version, there may be some other difference
here.

>> What are the exact mount options you pass to autofs in your fstab?
>
> mount output shows like this,
> systemd-1 on /proc/sys/fs/binfmt_misc type autofs
> (rw,relatime,fd=3D30,pgrp=3D1,timeout=3D0,minproto=3D5,maxproto=3D5,di=
rect,pipe_ino=3D1421)

This is only the binfmt-misc mount, which should not
prevent your rootfs from getting mounted, but it's possible
that failure to mount this prevents you from running
32-bit binaries.

I see this comes from the "proc-sys-fs-binfmt_misc.automount"
service in systemd.  I see this is defined in
https://github.com/systemd/systemd/blob/main/units/proc-sys-fs-binfmt_mi=
sc.automount
but I don't know exactly what its purpose is here. On a
64-bit system, you normally use compat_binfmt_elf.ko to run
32-bit binaries, and this does not require any specific mount
points. Alternatively, you could use binfmt_misc.ko with
the procfs mount to configure running arbitrary binary
formats such as arm32 on x86_64 with qemu-user emulation.

I double-checked your rootfs image from=20
https://storage.tuxboot.com/debian/bookworm/i386/rootfs.ext4.xz
to ensure that this indeed contains i386 executables rather than
arm32 ones, and that is all fine.

I also see in your log file at
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230926=
/testrun/20125035/suite/boot/test/gcc-13-lkftconfig-compat/log
that it is running the i386 binaries from the rootfs, but
it does get stuck soon after trying to set up the binfmt-misc
mount at the end of the log:

[[0;32m  OK  [0m] Reached target [0;1;39mlocal-fs.target[0m - Local File=
 Systems.
         Starting [0;1;39msystemd-binfmt.se=C3=A2=E2=82=AC=C2=A6et Up Ad=
ditional Binary Formats...
         Starting [0;1;39msystemd-tmpfiles-=C3=A2=E2=82=AC=C2=A6 Volatil=
e Files and Directories...
         Starting [0;1;39msystemd-udevd.ser=C3=A2=E2=82=AC=C2=A6ger for =
Device Events and Files...
[   15.869404] igb 0000:01:00.0 eno1: renamed from eth0 (while UP)
[   15.883753] igb 0000:02:00.0 eno2: renamed from eth1
[   20.053885] (udev-worker) (175) used greatest stack depth: 12416 byte=
s left
=1Dquit

I'm a bit out of ideas at that point, my best guess now is
that your bisection points to something in autofs that makes
it hang while setting up autofs, but that neither autofs
nor binfmt-misc are actually being used otherwise.

Maybe you can try to modify your rootfs to disable or remove
the systemd-binfmt.service, to confirm that autofs is not
actually needed here but does cause the crash?

     Arnd

