Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18CB76B2C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 13:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbjHALL3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 07:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjHALLI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:11:08 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F425596
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 04:05:54 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 9602C3200949;
        Tue,  1 Aug 2023 06:54:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 01 Aug 2023 06:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1690887241; x=1690973641; bh=pq
        AfVAOBgNH89VnT1sNRoh//H19UgtS1l21yV37M7FI=; b=imUZd2gNN8C6zInFFG
        RvJHujwCh+/jHPbOld5dIeubHrlOM9XxTVnvZLw8J1buYpp3SV2I8r0UHcQL1slB
        4LNaJsCGVRyB4WYbvnPRmtxxE2Xu+4q0o7wh8kLj2mRbZiP2TtSAAjoZljib1xAd
        OSqY8/Q9QCnMg4jdc87BECU/liBvWfVhKb/8vcHi14feZ4spBQbyyqVQ0FbiT5cp
        lO67SIZbTTaiyrMSPtkY6Zi7YhqojQwj4FyDMno5CCZsPP2wP7itrVCUUjdD0E+l
        DRO3Vx0GWP+PKPpiawZzzxF4iV6yt5tz4x1x2xBBR6tiaUepCYowT+7lXtV8gPY9
        V1Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690887241; x=1690973641; bh=pqAfVAOBgNH89
        VnT1sNRoh//H19UgtS1l21yV37M7FI=; b=Br2PEJzmo1C2khGzjA9cJPFr3zWeo
        s/XhzWGpANzhWORaIrv6qJqNUoORWArUE6KkqRG/DAA6pogHtRnCyonMdv3bDqCr
        DktFYQhiMJA4QiXX1MzcgEtcxlXTPcVfKgwTLjnMLB2qWH2smgp4bd26w5FK2/8G
        Se3biC8ZiOWP+rpJkaX0d2poOD5OyNE8CXMS/zIm7LvIGuWiFjFKEhlaXPPVnfCL
        XphQn7EFAiVLHD8UfcSfBhWOvXE/Nvv1PIpO2bYN2NbtAaQVVUUd1Ybd6+pcrCqV
        USgoIOJUEoIVy7seOZzPxZlioHhfP253T2FBoQZOrZ3GnaG7yW89AyFZA==
X-ME-Sender: <xms:SOTIZGg35uYgMu7PwZ1cwLhr5bzw-HwECPFJxI5vxm62DvFyLxaPEA>
    <xme:SOTIZHAjo7ElJGX2CnBn3eIU_6IswtNWpg9WuXNcAVdV7onWdyyxQsj6bjC1VUOAc
    2gp0N5zjJP0fqno>
X-ME-Received: <xmr:SOTIZOEO7fb3IQLU9DgsCbcBONh0kGdOE7zJTECkv_r-Gn99pNmnGIyGFu8U5CUEt-pqxx8INh4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeigdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufhfffgjkfgfgggtsehttddttddtredtnecuhfhrohhmpefpihhkohhl
    rghushcutfgrthhhuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecuggftrfgrth
    htvghrnhepteekleehieffleeuvdelkeekvdettedtteehhfeiheektdeljeelffeuvdej
    udevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpefpihhkohhlrghushesrhgrthhhrdhorhhg
X-ME-Proxy: <xmx:SOTIZPTnnDh6N279815dRDk8K9CecL5fLYCtBP3kqA-QR8BZHjP6eQ>
    <xmx:SOTIZDy_Z7xybpcpxDOYzxmOwS8T_HvH5_fLBot8MJisPAp6YOEBtw>
    <xmx:SOTIZN7wMkLM4y4-sEEMkp1fp9vlC_jJPEdVG8Scv766b84ik8U8MQ>
    <xmx:SeTIZOoWdmlU73Ib9voGUd5LuitdHomkrCY0VEDi8SrGVqDVr6-dmA>
Feedback-ID: i53a843ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Aug 2023 06:54:00 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id EC395111E;
        Tue,  1 Aug 2023 10:53:58 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id 756CB87336; Tue,  1 Aug 2023 11:53:58 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Miklos Szeredi via fuse-devel <fuse-devel@lists.sourceforge.net>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [fuse-devel] Semantics of fuse_notify_delete()
References: <87wmymk0k9.fsf@vostro.rath.org>
        <CAJfpegs+FfWGCOxX1XERGHfYRZzCzcLZ99mnchfb8o9U0kTS-A@mail.gmail.com>
        <87tttpk2kp.fsf@vostro.rath.org> <87r0osjufc.fsf@vostro.rath.org>
        <CAJfpegu7BtYzPE-NK_t3nFBT3fy2wGyyuJRP=wVGnvZh2oQPBA@mail.gmail.com>
        <CAJfpeguJESTqU7d0d0_2t=99P3Yt5a8-T4ADTF3tUdg5ou2qow@mail.gmail.com>
Mail-Copies-To: never
Mail-Followup-To: Miklos Szeredi via fuse-devel
        <fuse-devel@lists.sourceforge.net>, Linux FS Devel
        <linux-fsdevel@vger.kernel.org>, miklos <mszeredi@redhat.com>, Miklos
        Szeredi <miklos@szeredi.hu>
Date:   Tue, 01 Aug 2023 11:53:58 +0100
In-Reply-To: <CAJfpeguJESTqU7d0d0_2t=99P3Yt5a8-T4ADTF3tUdg5ou2qow@mail.gmail.com>
        (Miklos Szeredi via fuse-devel's message of "Mon, 31 Jul 2023 16:12:15
        +0200")
Message-ID: <87o7jrjant.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Jul 31 2023, Miklos Szeredi via fuse-devel <fuse-devel@lists.sourceforge.net> wrote:
> On Fri, 28 Jul 2023 at 10:52, Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>> On Fri, 28 Jul 2023 at 10:45, Nikolaus Rath <Nikolaus@rath.org> wrote:
>>
>> > I've pushed an instrumented snapshot to
>> > https://github.com/s3ql/s3ql/tree/notify_delete_bug. For me, this
>> > reliably reproduces the problem:
>> >
>> > $ python3 setup.py build_cython build_ext --inplace
>> > $ md bucket
>> > $ bin/mkfs.s3ql --plain local://bucket
>> > [...]
>> > $ bin/mount.s3ql --fg local://bucket mnt &
>> > [...]
>> > $ md mnt/test; echo foo > mnt/test/bar
>> > $ bin/s3qlrm mnt/test
>> > fuse: writing device: Directory not empty
>> > ERROR: Failed to submit invalidate_entry request for parent inode 1, name b'test'
>> > Traceback (most recent call last):
>> >   File "src/internal.pxi", line 125, in pyfuse3._notify_loop
>> >   File "src/pyfuse3.pyx", line 915, in pyfuse3.invalidate_entry
>> > OSError: [Errno 39] fuse_lowlevel_notify_delete returned: Directory not
>> > empty
>
> I get this:
>
> root@kvm:~/s3ql# bin/s3qlrm mnt/test
> WARNING: Received unknown command via control inode
> ERROR: Uncaught top-level exception:
> Traceback (most recent call last):
>   File "/root/s3ql/bin/s3qlrm", line 21, in <module>
>     s3ql.remove.main(sys.argv[1:])
>   File "/root/s3ql/src/s3ql/remove.py", line 74, in main
>     pyfuse3.setxattr(ctrlfile, 'rmtree', cmd)
>   File "src/pyfuse3.pyx", line 629, in pyfuse3.setxattr
> OSError: [Errno 22] Invalid argument: 'mnt/test/.__s3ql__ctrl__'
>
> All packages are from debian/testing, except python3-dugong, which is
> from bullseye (oldstable), becase apparently it was removed from the
> recent release.

This sounds like you're using s3qlrm from one version of S3QL, and
mount.s3ql from a different one.

What do you mean with "all packages are from debian/testing"? If this
includes S3QL, then it won't work: you need the one from the Git
repository above because it's instrumented to reproduce the problem
reliably.

If you want to keep the Python packages separate, the best way is to use
a virtual environment:

# mkdir ~/s3ql-python-env
# python3 -m venv --system-side-packages ~/s3ql-python-env
# ~/s3ql-python-env/bin/python -m pip install --upgrade cryptography defusedxml apsw trio pyfuse3 dugong pytest requests cython
# ~/s3ql-python-env/bin/python setup.py build_cython build_ext --inplace
# ~/s3ql-python-env/bin/python bin/mount.s3ql [...]
# ~/s3ql-python-env/bin/python bin/s3qlrm [...]



Best,
-Nikolaus
