Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C3676B7D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 16:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbjHAOkl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 10:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjHAOkk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:40:40 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073BC9C
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 07:40:39 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7008D5C00BF;
        Tue,  1 Aug 2023 10:40:38 -0400 (EDT)
Received: from imap45 ([10.202.2.95])
  by compute3.internal (MEProxy); Tue, 01 Aug 2023 10:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1690900838; x=1690987238; bh=6Q
        lW7ISXgxfENRkudm9YoAkhQhZ6khmqnBISL9+JV5g=; b=SmyYSxqDte63qDEeV9
        vquEJW3XLgVVXbBYTUnPL5LoMsbxt0Tk9Fduu5xBkp94/koZtXQlJvAfDIFScf0z
        fqTpCCljFY6u2eNiTXbKht2WxFDQtVfD7HpJ+pRpLHUebff6wBY3IlUZ5dLgeqm2
        1grPb01ibgNnkW1tjaEe3Q3tj/UIiEYNEcfDEWdMiNr5GLXvvpm3jpKGuM4t2O9U
        wX5xHjXyalD8uckvI4+k8RTK1AJNJYky0ZDcS0mOx5izLZK/7k9iiPCTA2j3TKvt
        ANu0k9PD6Jsr1snss4omm0oXSjWXUyHAEJke02rA1cuAZeDhSm1mKllXfBP7s7uT
        cOrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690900838; x=1690987238; bh=6QlW7ISXgxfEN
        Rkudm9YoAkhQhZ6khmqnBISL9+JV5g=; b=qB702BZe1tphz0gSRNFEnkTYG5cE0
        EWJAdw/Lm/seaUrTTHmrG83V1HOyz148bQEX4mixpxc2IechOygSvuqJOdJjvJVG
        Y6B10uLbwIite48LMWSkKPNXn3k05olA/S9IdM/1DAvaSgA7Yu7CP/yHSHah5kRm
        YJ3UeugK1PfFM0nRZ1esVCwuBQM4I4qps8P/0TBGhLU1MQ6+nxgDaDmXa4pj9BWO
        d4QmXjwLxMUeiChylM6TJnoH5gN1MaMZW/kKyiIKDFYYwxccZhsMpgCY8wLL3bCH
        KLNr9DoNftJCYpNR63Rs/a3d//s/wNTq4k9LTylwuzpTQtXosvMEJ18Cg==
X-ME-Sender: <xms:ZhnJZDT1tRq5nVpxNhTiV6SBeZMzJmt-w0_UbJuLVaiX2D9LR_IM4A>
    <xme:ZhnJZEw7rEUyKerA7PMRMIwxcRc2fiUnmmMS17hWLRLbEQ_ulKZ_k-wn9bWVVIeyz
    vNJTyJmjXQGPl0G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeigdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfpihhk
    ohhlrghushcutfgrthhhfdcuoehnihhkohhlrghushesrhgrthhhrdhorhhgqeenucggtf
    frrghtthgvrhhnpeegvedttdeljefhgfdthfffjefguedtueffteetveelfedtfeegleeu
    leegveduveenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhikhholhgruhhssehrrghthhdr
    ohhrgh
X-ME-Proxy: <xmx:ZhnJZI3fC_EG03oJ_-gy5zIzBTTkvTQLwPagj18dldWA4QfvCKF0PQ>
    <xmx:ZhnJZDBJxu1R4zXZqzKhoCXvsm0Y0B0_6e4i-rPxu3TOWy81BLrN0g>
    <xmx:ZhnJZMgNsrcNYseS7bL6E1TZE9HM2sqifG627wTOIiE3HurmJVmE9w>
    <xmx:ZhnJZEfJwl_9_VDoN9Bz1F_Xjf1wxOMLy2yLNHnpPmY90GT08ynNwg>
Feedback-ID: i53a843ae:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F3068272007B; Tue,  1 Aug 2023 10:40:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <2e44acdd-b113-43c3-80cb-150f09478383@app.fastmail.com>
In-Reply-To: <CAJfpegvTTUvrcpzVsJwH63n+zNw+h6krtiCPATCzZ+ePZMVt2Q@mail.gmail.com>
References: <87wmymk0k9.fsf@vostro.rath.org>
 <CAJfpegs+FfWGCOxX1XERGHfYRZzCzcLZ99mnchfb8o9U0kTS-A@mail.gmail.com>
 <87tttpk2kp.fsf@vostro.rath.org> <87r0osjufc.fsf@vostro.rath.org>
 <CAJfpegu7BtYzPE-NK_t3nFBT3fy2wGyyuJRP=wVGnvZh2oQPBA@mail.gmail.com>
 <CAJfpeguJESTqU7d0d0_2t=99P3Yt5a8-T4ADTF3tUdg5ou2qow@mail.gmail.com>
 <87o7jrjant.fsf@vostro.rath.org>
 <CAJfpegvTTUvrcpzVsJwH63n+zNw+h6krtiCPATCzZ+ePZMVt2Q@mail.gmail.com>
Date:   Tue, 01 Aug 2023 15:40:09 +0100
From:   "Nikolaus Rath" <nikolaus@rath.org>
To:     "Miklos Szeredi" <miklos@szeredi.hu>,
        "Martin Kaspar via fuse-devel" <fuse-devel@lists.sourceforge.net>
Cc:     "Linux FS Devel" <linux-fsdevel@vger.kernel.org>,
        "Miklos Szeredi" <mszeredi@redhat.com>
Subject: Re: [fuse-devel] Semantics of fuse_notify_delete()
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 1 Aug 2023, at 13:53, Miklos Szeredi via fuse-devel wrote:
> Here's one with the virtual env and the correct head:
>
> root@kvm:~/s3ql# git log -1 --pretty="%h %s"
> 3d35f18543d9 Reproducer for notify_delete issue. To confirm:
> root@kvm:~/s3ql# ~/s3ql-python-env/bin/python bin/s3qlrm mnt/test
> WARNING: Received unknown command via control inode
> ERROR: Uncaught top-level exception:
> Traceback (most recent call last):
>   File "/root/s3ql/bin/s3qlrm", line 21, in <module>
>     s3ql.remove.main(sys.argv[1:])
>   File "/root/s3ql/src/s3ql/remove.py", line 72, in main
>     pyfuse3.setxattr(ctrlfile, 'rmtree', cmd)
>   File "src/pyfuse3.pyx", line 629, in pyfuse3.setxattr
> OSError: [Errno 22] Invalid argument: 'mnt/test/.__s3ql__ctrl__'

This is odd. I have never heard of anyone having this problem before and it also works fine in the CI.

I apologize that this is taking so much of your time.

I have changed the code a bit to print out what exactly it is receiving: https://github.com/s3ql/s3ql/commit/eb31f7bff4bd985d68fa20c793c2f2edf5db61a5

Would you mind updating your branch and trying again? (You'll need to fetch and reset, since I rebased on top of current master just to be sure).

I can still reproduce this every time (without any other error):

$ mkdir bucket
$ bin/mkfs.s3ql --plain local://bucket
Before using S3QL, make sure to read the user's guide, especially
the 'Important Rules to Avoid Losing Data' section.
Creating metadata tables...
Uploading metadata...
Uploading metadata...
Uploaded 1 out of ~1 dirty blocks (100%)
Calculating metadata checksum...
$ mkdir mnt
$ bin/mount.s3ql --fg local://bucket mnt &
Using 10 upload threads.
Autodetected 1048514 file descriptors available for cache entries
Using cached metadata.
Setting cache size to 315297 MB
Mounting local:///home/nikratio/in-progress/s3ql/bucket/ at /home/nikratio/in-progress/s3ql/mnt...

$ md mnt/test; echo foo > mnt/test/bar
$ bin/s3qlrm mnt/test
fuse: writing device: Directory not empty
ERROR: Failed to submit invalidate_entry request for parent inode 1, name b'test'
Traceback (most recent call last):
  File "src/internal.pxi", line 125, in pyfuse3._notify_loop
  File "src/pyfuse3.pyx", line 915, in pyfuse3.invalidate_entry
OSError: [Errno 39] fuse_lowlevel_notify_delete returned: Directory not empty

nikratio@vostro ~/i/s3ql (notify_delete_bug)> 


Best,
-Nikolaus
