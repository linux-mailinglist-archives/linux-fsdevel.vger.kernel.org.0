Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B44766795
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 10:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbjG1Iqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 04:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbjG1Iqe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:46:34 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE153C27
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 01:45:46 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id EAB435C00F1;
        Fri, 28 Jul 2023 04:45:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 28 Jul 2023 04:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1690533945; x=1690620345; bh=bZ
        ICWCiXBzwqJUYCmmk6QuGn8+ItZU5nJPTHbHYffMc=; b=RJW4HzLX7MQO5J9rOb
        1dPpj17krfp7u+vQ4wasMp3LpSKq+8wDoYe4VeORWm9Vxu7Jc1OUlIZoeYKZOici
        oyqcv6J0wlwcX20Asq+M32q6FutowjmPcK5m0YAOFpQwLwUuY2xFNGmoTxG+G/To
        F5rtc9z3FJWeH2N2mqCstR7JmjuFQUYrHfJgjF+Z6/nhRDwHPBEVgNJSL1NOibJB
        ZFVx+omoqy2LOZjKU12aqSTsu8KI60rhf49/tqsNWjIvQvtdQ4nrwX2btv5EOkAL
        lN5WgkAA1mD4jiPxN0iF7a/S1jIXfu8qZtFid5d0K5vcApJnp+KRa52YsiST5FC4
        gEIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690533945; x=1690620345; bh=bZICWCiXBzwqJ
        UYCmmk6QuGn8+ItZU5nJPTHbHYffMc=; b=QSr18lyQOMkmVKqN1IkKZnH//IQ/w
        bvWqdXu/ceG8qlLt3dhLcAkz46ntSM/7F9I46bWF0vCIdzpr6zh2IbZT4nX+IQU2
        /zaOqzOld9ZtPWYTyDKuaHR+nXahWKOLSqiRIEp03w3FSL8TQ9g8mOkN5C0jdWYz
        jhTMejXbyWZrxTqmMimZalDy2qe9etWICM4gZit+oZtpezVZrz9LnK74M+J0yZnC
        smXKTNWfV3JkRKLmu+IQEDxd+gei+evV623lBp3OpcAuE4x6TBt1ZgvxedKtoGcm
        0NNz1FeTCaM0Se5ALzXw+4ff65Ll2fuJJJmV4GKofqX9i613vdP0fEMJg==
X-ME-Sender: <xms:OYDDZE6pXAQdU45s6x8Q05G3Rqxwhg4fRcqh1Z_wSu6etXxf0C84xA>
    <xme:OYDDZF5GbhvL9MZNBaBrXCiUWuYD7Sfm8ZP1StNKueXoQhIdIHdQwCXljQAgz4GHx
    L7dowauugysNTUP>
X-ME-Received: <xmr:OYDDZDfCNBsjN21Mf3ehthZqJtfUY86-l6iQAm-qpCOOPmQSHnCFdqG4sy0NUMbyAAOgfFQ_NH0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieeigddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufhffjgfkfgggtgesthdttddttdertdenucfhrhhomheppfhikhholhgr
    uhhsucftrghthhcuoefpihhkohhlrghushesrhgrthhhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedtieekgeduleetueeuleeiiefffefgtdeivdejteeiffefgfeftdetudefleeh
    keenucffohhmrghinhepsghoohhtlhhinhdrtghomhdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheppfhikhholhgr
    uhhssehrrghthhdrohhrgh
X-ME-Proxy: <xmx:OYDDZJKHi_3qiHy6AwUwk7JETa9yKemxqyDXhdWM2R3-6ELq18JCbA>
    <xmx:OYDDZIKpESO9slmiVIHgv9QghCGa4oRKN357qQpLS0zsU1rpVlIaGg>
    <xmx:OYDDZKyUjk3lg_MrPfO8tyI18raRUlLF0tjhpRzN3DiJsxI57zZIng>
    <xmx:OYDDZCgEY3fUbsd8wKgJuxezlKDBylS4AOMpsNOUoXJDlCPZg7bJvg>
Feedback-ID: i53a843ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Jul 2023 04:45:45 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id E648E53E;
        Fri, 28 Jul 2023 08:45:43 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id 5F08780A23; Fri, 28 Jul 2023 09:45:43 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Miklos Szeredi via fuse-devel <fuse-devel@lists.sourceforge.net>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [fuse-devel] Semantics of fuse_notify_delete()
References: <87wmymk0k9.fsf@vostro.rath.org>
        <CAJfpegs+FfWGCOxX1XERGHfYRZzCzcLZ99mnchfb8o9U0kTS-A@mail.gmail.com>
        <87tttpk2kp.fsf@vostro.rath.org>
Mail-Copies-To: never
Mail-Followup-To: Miklos Szeredi via fuse-devel
        <fuse-devel@lists.sourceforge.net>, Linux FS Devel
        <linux-fsdevel@vger.kernel.org>, miklos <mszeredi@redhat.com>, Miklos
        Szeredi <miklos@szeredi.hu>
Date:   Fri, 28 Jul 2023 09:45:43 +0100
In-Reply-To: <87tttpk2kp.fsf@vostro.rath.org> (Nikolaus Rath's message of
        "Thu, 27 Jul 2023 12:37:26 +0100")
Message-ID: <87r0osjufc.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Jul 27 2023, Nikolaus Rath <Nikolaus@rath.org> wrote:
> On Jul 27 2023, Miklos Szeredi via fuse-devel <fuse-devel@lists.sourceforge.net> wrote:
>> On Wed, 26 Jul 2023 at 20:09, Nikolaus Rath <Nikolaus@rath.org> wrote:
>>>
>>> Hello,
>>>
>>> It seems to me that fuse_notify_delete
>>> (https://elixir.bootlin.com/linux/v6.1/source/fs/fuse/dev.c#L1512) fails
>>> with ENOTEMPTY if there is a pending FORGET request for a directory
>>> entry within. Is that correct?
>>
>> It's bug if it does that.
>>
>> The code related to NOTIFY_DELETE in fuse_reverse_inval_entry() seems
>> historic.  It's supposed to be careful about mountpoints and
>> referenced dentries, but d_invalidate() should have already gotten all
>> that out of the way and left an unhashed dentry without any submounts
>> or children. The checks just seem redundant, but not harmful.
>>
>> If you are managing to trigger the ENOTEMPTY case, then something
>> strange is going on, and we need to investigate.
>
> I can trigger this reliable on kernel 6.1.0-10-amd64 (Debian stable)
> with this sequence of operations:
>
> $ mkdir test
> $ echo foo > test/bar
> $ Trigger removal of test/bar and then test within the filesystem (not
> through unlink()/rmdir() but out-of-band)
>
>
> What can I do to help with the investigation?


I've pushed an instrumented snapshot to
https://github.com/s3ql/s3ql/tree/notify_delete_bug. For me, this
reliably reproduces the problem:

$ python3 setup.py build_cython build_ext --inplace
$ md bucket
$ bin/mkfs.s3ql --plain local://bucket
[...]
$ bin/mount.s3ql --fg local://bucket mnt &
[...]
$ md mnt/test; echo foo > mnt/test/bar
$ bin/s3qlrm mnt/test
fuse: writing device: Directory not empty
ERROR: Failed to submit invalidate_entry request for parent inode 1, name b'test'
Traceback (most recent call last):
  File "src/internal.pxi", line 125, in pyfuse3._notify_loop
  File "src/pyfuse3.pyx", line 915, in pyfuse3.invalidate_entry
OSError: [Errno 39] fuse_lowlevel_notify_delete returned: Directory not
empty


I've looked into reproducing this with e.g. example/passthrough_ll.c,
but it's non-trivial because of the need to run notify_delete in a
separate thread and giving it all the right arguments. I can look into
it more if that's needed though.

Best,
-Nikolaus
