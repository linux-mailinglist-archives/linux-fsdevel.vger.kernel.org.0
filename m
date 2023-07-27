Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAB5765296
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 13:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjG0Lhd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 07:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjG0Lhc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:37:32 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CC3135
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 04:37:30 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1FB59320046F;
        Thu, 27 Jul 2023 07:37:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 27 Jul 2023 07:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1690457849; x=1690544249; bh=8m
        t7BlsoZ3JZK5KL25oPh4zBAwjMNg3JZHz2IsKdFGE=; b=IgAC9Zwix7I3ggB7v4
        tUemcdnpHwRoLtI/GRlvS2qT+sUIWePShqbO5/L8NffgqRAgiSNKWrg28LF9WfK+
        1riO3gl+LEL8wXnwnLeTsVmD7eTSI9VIuyp/hzCfbF+2eB29dHCIyXJJjcN6IIjD
        h3Is49naO6jWVIX29/Y7Izf4cE/K54FC5KsbqNYeliKKuxM1M/hXrwjIHNT3smXg
        xnniU1Kf2wmK3flcmL90elsMUZc5qLRoM+EbG49xf/IKyj4DMK9PqGGa8pWQ89qM
        08/xe6ErGKkUjU7tyAgZUEeDZAIrK2obl1paHRpMQHjuwXQKIDu4I79MAnU3RDQ/
        X7bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690457849; x=1690544249; bh=8mt7BlsoZ3JZK
        5KL25oPh4zBAwjMNg3JZHz2IsKdFGE=; b=c+N10ZQCvrxRS5HD6/ViKxamJ+Il8
        ls0d23PnvhhUMkAOKvkksLvc7IxGm+7uLQfynzht9CxXzFEm67yzl143vHGrtty6
        LzzJlSEs1KgiA75eOJbnh9+m1siqpyXaJ6dl5HlhAe0upgAePY54XYtSO/ArLTB3
        KcDquUaUBKNMMVC3enAKTlz6pBHRcLLtpjgSGbkMXY6mZrnzo2C0z7UtOiZu5QBH
        8pghiIS1Xc37V7TjBBauRTlcIcHbC7rtV6k55+jS2OkPH97i/mUoPGjMRckvdMlr
        2FNSqpCi9UaF1sbuSDCQplN8JFPhP77aLDOw+0nlBf+bfXFK1Z2vs6FlA==
X-ME-Sender: <xms:-VbCZENMcDlIZjY7mR98re02WfzrIe36YVn6-FL6ocLDk5qQbegwDw>
    <xme:-VbCZK_GDglhfmZgi8HJzeXkic95JuCjRcBKPLPT3qdXXDGQazMjy57XmiivEO0IJ
    VvlF4bLQHBr0ql5>
X-ME-Received: <xmr:-VbCZLQqgAT9tKZKBTuUfcvLVvcrpBp_p-FwO48LOAsV2ZJ6USgGxJzbb9iUG0XiBTC9rBJE7lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieeggdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufhfffgjkfgfgggtsehttddttddtredtnecuhfhrohhmpefpihhkohhl
    rghushcutfgrthhhuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecuggftrfgrth
    htvghrnhepjeeuveettdeugfeigeefveehhffhieegieetvdelgfelleekgffgvefhffeg
    udffnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheppfhikhholhgruhhssehrrghthhdrohhr
    gh
X-ME-Proxy: <xmx:-VbCZMtSw8vLzGO-_h9Zs5P-XidZW24Hf7RQGT54Qgsyy06dWf0agg>
    <xmx:-VbCZMdm9NeaH4IsAHkFAusAoqfKAWHVmq9vuaWqQcPLe1a3bWMmeQ>
    <xmx:-VbCZA0pwVnmFU4Qp8PiWkGaGbqOyJcrr3BDDqXN3tsgYsXMIe3kTg>
    <xmx:-VbCZBE6pzE3HPvOH6EeAQLKUYHEhTCtNMGc8zaypzaxQXavVQKqQA>
Feedback-ID: i53a843ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jul 2023 07:37:28 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 5D94C134;
        Thu, 27 Jul 2023 11:37:27 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id B917180832; Thu, 27 Jul 2023 12:37:26 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Miklos Szeredi via fuse-devel <fuse-devel@lists.sourceforge.net>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [fuse-devel] Semantics of fuse_notify_delete()
References: <87wmymk0k9.fsf@vostro.rath.org>
        <CAJfpegs+FfWGCOxX1XERGHfYRZzCzcLZ99mnchfb8o9U0kTS-A@mail.gmail.com>
Mail-Copies-To: never
Mail-Followup-To: Miklos Szeredi via fuse-devel
        <fuse-devel@lists.sourceforge.net>, Linux FS Devel
        <linux-fsdevel@vger.kernel.org>, miklos <mszeredi@redhat.com>, Miklos
        Szeredi <miklos@szeredi.hu>
Date:   Thu, 27 Jul 2023 12:37:26 +0100
In-Reply-To: <CAJfpegs+FfWGCOxX1XERGHfYRZzCzcLZ99mnchfb8o9U0kTS-A@mail.gmail.com>
        (Miklos Szeredi via fuse-devel's message of "Thu, 27 Jul 2023 10:04:56
        +0200")
Message-ID: <87tttpk2kp.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Jul 27 2023, Miklos Szeredi via fuse-devel <fuse-devel@lists.sourceforge.net> wrote:
> On Wed, 26 Jul 2023 at 20:09, Nikolaus Rath <Nikolaus@rath.org> wrote:
>>
>> Hello,
>>
>> It seems to me that fuse_notify_delete
>> (https://elixir.bootlin.com/linux/v6.1/source/fs/fuse/dev.c#L1512) fails
>> with ENOTEMPTY if there is a pending FORGET request for a directory
>> entry within. Is that correct?
>
> It's bug if it does that.
>
> The code related to NOTIFY_DELETE in fuse_reverse_inval_entry() seems
> historic.  It's supposed to be careful about mountpoints and
> referenced dentries, but d_invalidate() should have already gotten all
> that out of the way and left an unhashed dentry without any submounts
> or children. The checks just seem redundant, but not harmful.
>
> If you are managing to trigger the ENOTEMPTY case, then something
> strange is going on, and we need to investigate.

I can trigger this reliable on kernel 6.1.0-10-amd64 (Debian stable)
with this sequence of operations:

$ mkdir test
$ echo foo > test/bar
$ Trigger removal of test/bar and then test within the filesystem (not
through unlink()/rmdir() but out-of-band)


What can I do to help with the investigation?

Best,
-Nikolaus
