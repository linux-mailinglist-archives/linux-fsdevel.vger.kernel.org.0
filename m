Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D300710ACA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 10:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfK0Jdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 04:33:31 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33279 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbfK0Jdb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 04:33:31 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 344EA22623;
        Wed, 27 Nov 2019 04:33:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 27 Nov 2019 04:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=from
        :to:cc:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=fm1; bh=lwe326uEXvaC7fsnwhP8exjpk7
        KcUMWJwe7cF/fYfQY=; b=IQpJuwgsfwjhgaBhxiMnF7MAr28r5I0rmRCW6YnusS
        xlCMVfBDi8yghZEghNc2OezkGJWCIAio2CdsLIw/s9ckP5Wnpu/CmP6p0Q6cR3p4
        wNBhEJ12PqW9o0WqegKnBcy9QR2LjKkn1Xyv//UTFEEvrsT1HDA6kRykIeDCbaYw
        +eSBEuq6KeRRvfadK7opdn8/40/LJcW09mCrqY2Frzx6Ax1tLp1YF//AjOSnnRRO
        zjsit5B2p1Q9GJ+MDrXg1dN3vKuAAS9qEn9y2Xjfdug01wB7HYa1CJ8d3lCU5nHE
        fYbSIcHMkCHxjyEKFplXAFIPViBQI9L7VGdrY8UtvGcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=lwe326
        uEXvaC7fsnwhP8exjpk7KcUMWJwe7cF/fYfQY=; b=ppmQtmPkVJnJxqUXbyD137
        E/On3lRMJmqbExKRAi0uPvOveH6i//AtiWj1eXadFrWWBsiuvfSuXgERKoxoI8hM
        89BKb7PEyw10qr9lc92TDw0MStERzcZbx4DyFbjhQM2FowazAjc2frR2Ayx+zoGH
        odsMOTKKJf3R1as464RiHWzfPSgCcNVcy61stt9liEVSnHUvjLGenViIHgp21FKB
        vcO9rzXNnbROcWAblUoHfk3JRbHDQdOdRpJ/HeyAQto4Z/8h9jBhwdy7qnzI+MBp
        nSpbBH9r7KnYK2ahAMdcXdEZigKsm7Bjnv8CzntTz3u/ExLiWdzfzN4KLvgpOf2Q
        ==
X-ME-Sender: <xms:6ULeXXZSwzcOI0CVSpVUWQDfpcMvpyxYe5RugtFIqL5P6lNj5coADw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeihedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfgfgggtgfesthhqtddttderjeenucfhrhhomheppfhikhholhgr
    uhhsucftrghthhcuoefpihhkohhlrghushesrhgrthhhrdhorhhgqeenucfkphepudekhe
    drfedrleegrdduleegnecurfgrrhgrmhepmhgrihhlfhhrohhmpefpihhkohhlrghushes
    rhgrthhhrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:6ULeXde2Y1McBDzSnvNwwPILGvFW9pAYbuhQ-mJteoy8tAtnjW7OzQ>
    <xmx:6ULeXRoluCGwdSBGcxXWALuKyZqVHvBhIdXtIpAGXUcpJ-Cnh0MZWw>
    <xmx:6ULeXUDcw1aLqQoFVwfwOd-m74NApQs7VkuWeIV7S-wa7JaKMugUKw>
    <xmx:6kLeXRkYu23ZEc3EGcKBOQSGQnoTIJYmZlzRQUHMYEGO1rxTGgsZUQ>
Received: from ebox.rath.org (ebox.rath.org [185.3.94.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4825E80060;
        Wed, 27 Nov 2019 04:33:29 -0500 (EST)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 3479333;
        Wed, 27 Nov 2019 09:33:28 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id 004C1E0451; Wed, 27 Nov 2019 09:33:27 +0000 (GMT)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     fuse-devel@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>
Subject: Handling of 32/64 bit off_t by getdents64()
Mail-Copies-To: never
Mail-Followup-To: fuse-devel@lists.sourceforge.net, linux-fsdevel
        <linux-fsdevel@vger.kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
Date:   Wed, 27 Nov 2019 09:33:27 +0000
Message-ID: <8736e9d5p4.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

For filesystems like ext4, the d_off values returned by getdents64()
seem to depend on the kind of process that issues the syscall.

For example, if I compile test program with -m32 I get:

$ ./readdir32=20
--------------- nread=3D616 ---------------
inode#    file type  d_reclen  d_off   d_name
32253478  ???          40  770981411  test_readlog.py
32260181  ???          24  776189020  ..
[...]

If I compile for 64 bit, I get:

$ ./readdir64=20
--------------- nread=3D616 ---------------
inode#    file type  d_reclen  d_off   d_name
32253478  ???          40 3311339950278905338  test_readlog.py
32260181  ???          24 3333706456980390508  ..
[...]

This is despite d_off being declared as ino64_t in the linux_dirent64
struct.


This is presumably intentional, because (again as far as I can tell), if
getdents64 returns a full 64 bit value for a 32 bit system, libc's
readdir() will return an error because it cannot fit the value into
struct dirent.


As far as I know, there is no way for a FUSE filesystem to tell if the
client process is 64 bit or 32 bit. So effectively, a FUSE filesystem is
limited to using only the lower 32 bits for readdir offsets. Is that
correct?

This would be quite annoying because it means that passthrough
filesystems cannot re-use the underlying filesystems d_off values
(since they will be full 64 bit for a 64 bit FUSE process).


Is there a way for a 64 bit process (in this case the FUSE daemon) to
ask for 32 bit d_off values from getdents64()?


Would it be feasible to extend the FUSE protocol to include information
about the available bits in d_off?


Best,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
