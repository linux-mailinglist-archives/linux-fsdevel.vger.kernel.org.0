Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713E076D057
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 16:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbjHBOnZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 10:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjHBOnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:43:24 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09525E62
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 07:43:22 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id AB68F5C0078;
        Wed,  2 Aug 2023 10:43:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 02 Aug 2023 10:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1690987399; x=1691073799; bh=/l
        k1BzPvZPL1NHodEevLiXC5I8ZD4Nn8OvqJGs1zbkI=; b=no1jfhsUn5wsIGrLoa
        AbZah6bjh4GAa8BS2/YaPrNcNjd9JRM2ypDvjVMQkP76mhS9KzrIYqsYK+iNeOKf
        yA+rqtfdG2lvFK6MUTb5v8FBQAseE0U+sxvqTns3a6cgToVqC0F6rpHITYNCy44D
        QUx1OhpL9y5qSi0ICgZywW/UJaujmz240ZeXyX7Yjh83zwrxqC/7VPfl0vT3Qt/U
        dFFXZdMnmObzNJLnd8GVMpjWFWw8Np9SeCyArJQGG770duPudP4e3qd0/Ow/cYUK
        SW4t/BIcJTeuZA9Z2eg/vUprR8udA1g9MIAq45EhDzeWANne6OM+qs7BiLd1gscG
        mwDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690987399; x=1691073799; bh=/lk1BzPvZPL1N
        HodEevLiXC5I8ZD4Nn8OvqJGs1zbkI=; b=pamDoIlkGh3w01ynAZycjBeqcVvyI
        BWgV9Fbxs1zFJQhCa2KsMja7vOLwdFdcWTN13k3SlvzM/g5RZiKvafTQ+T3a3P/x
        +PhEjhlJvb2eNhgAREsWxxrYpZuEaR4cISdNW9owSLqGKRZgYGBwFKx1YQM1Q/uj
        g9hCTlndqXf1+aaS8gNwldfxEKvYMGZAqPo48UV57b8Q6RX043l/X7M1APRJy1jl
        5kkmngbHOZqwya7MdqyNogEQFgmwkKQfCtb19D39CpRZd/GLf/TU4YNQv7YPMrz0
        fL9HdRVewbvoDSbNre23AfoLdXHSblDuzKEEosWi6+mo7oTSU5rpr6N2w==
X-ME-Sender: <xms:h2vKZEbs-lm9xgcC7aCY73BRhXroLu2bR9e8betmfzQczQBQalZvgA>
    <xme:h2vKZPaZm4yYGyNJb-TjtMuNs9jTm3wxMQgI4-TbHQfb66lLMARmp9tYvi3VjzHcJ
    rsve5TXU9x0MZBy>
X-ME-Received: <xmr:h2vKZO_pu-RMQFON3ufg7VC1EsEUmC0Qn_h9JHUBBRziN1XWojLXMqFk4awPCcGEAE4hDVRrfVs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeekgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufhfffgjkfgfgggtsehttddttddtredtnecuhfhrohhmpefpihhkohhl
    rghushcutfgrthhhuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecuggftrfgrth
    htvghrnhepjeeuveettdeugfeigeefveehhffhieegieetvdelgfelleekgffgvefhffeg
    udffnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheppfhikhholhgruhhssehrrghthhdrohhr
    gh
X-ME-Proxy: <xmx:h2vKZOrAZmfd7vUGP8ot_JEN41v5f8XDsiwMXiULiej2mJnxKQmvoA>
    <xmx:h2vKZPojDlg0WPA7IzeHI4F7jnNb9waLku62ngBKPA5hDWKVK69XEw>
    <xmx:h2vKZMSJtqmFw0cAEsY4erQDcVf_CajTEPWMnaIifiBwYSUJglHb7A>
    <xmx:h2vKZAB-MKTIMRvdi9yRJDlTQD7Skx_bO6Shmwhj-gzr9xGOnGJyOQ>
Feedback-ID: i53a843ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Aug 2023 10:43:19 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id A54F853;
        Wed,  2 Aug 2023 14:43:17 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id BA1D087689; Wed,  2 Aug 2023 15:43:17 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Miklos Szeredi via fuse-devel <fuse-devel@lists.sourceforge.net>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>
Subject: Re: [fuse-devel] Semantics of fuse_notify_delete()
References: <87wmymk0k9.fsf@vostro.rath.org>
        <CAJfpegs+FfWGCOxX1XERGHfYRZzCzcLZ99mnchfb8o9U0kTS-A@mail.gmail.com>
        <87tttpk2kp.fsf@vostro.rath.org>
        <CAJfpegvbNKiRggOKysv1QyoG4xsZkrEt0LUuehV+SfN=ByQnig@mail.gmail.com>
Mail-Copies-To: never
Mail-Followup-To: Miklos Szeredi via fuse-devel
        <fuse-devel@lists.sourceforge.net>, Miklos Szeredi
        <miklos@szeredi.hu>, Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>
Date:   Wed, 02 Aug 2023 15:43:17 +0100
In-Reply-To: <CAJfpegvbNKiRggOKysv1QyoG4xsZkrEt0LUuehV+SfN=ByQnig@mail.gmail.com>
        (Miklos Szeredi via fuse-devel's message of "Wed, 2 Aug 2023 15:18:22
        +0200")
Message-ID: <87jzudqzcq.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
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

On Aug 02 2023, Miklos Szeredi via fuse-devel <fuse-devel@lists.sourceforge.net> wrote:
> On Thu, 27 Jul 2023 at 13:37, Nikolaus Rath <Nikolaus@rath.org> wrote:
>>
>> On Jul 27 2023, Miklos Szeredi via fuse-devel <fuse-devel@lists.sourceforge.net> wrote:
>> > On Wed, 26 Jul 2023 at 20:09, Nikolaus Rath <Nikolaus@rath.org> wrote:
>> >>
>> >> Hello,
>> >>
>> >> It seems to me that fuse_notify_delete
>> >> (https://elixir.bootlin.com/linux/v6.1/source/fs/fuse/dev.c#L1512) fails
>> >> with ENOTEMPTY if there is a pending FORGET request for a directory
>> >> entry within. Is that correct?
>> >
>> > It's bug if it does that.
>> >
>> > The code related to NOTIFY_DELETE in fuse_reverse_inval_entry() seems
>> > historic.  It's supposed to be careful about mountpoints and
>> > referenced dentries, but d_invalidate() should have already gotten all
>> > that out of the way and left an unhashed dentry without any submounts
>> > or children. The checks just seem redundant, but not harmful.
>> >
>> > If you are managing to trigger the ENOTEMPTY case, then something
>> > strange is going on, and we need to investigate.
>>
>> I can trigger this reliable on kernel 6.1.0-10-amd64 (Debian stable)
>> with this sequence of operations:
>>
>> $ mkdir test
>> $ echo foo > test/bar
>> $ Trigger removal of test/bar and then test within the filesystem (not
>> through unlink()/rmdir() but out-of-band)
>
> Issue is that "test/.__s3ql__ctrl__" is still positive.  I.e. the
> directory is *really* not empty.
>
> I thought that that's okay, and d_invalidate will recursively unhash
> dentries, but that's not the case.   d_invalidate removes submounts
> but only unhashes the root of the subtree, leaving the rest intact.
>
> So the solution here is to invoke NOTIFY_DELETE on
> "test/.__s3ql__ctrl__"  before doing it on "test" itself.

Ah, thanks a lot for your help! I did not think of the potential
connection to this pseudo-file.

Will think about how to best fix that. The problem is that LOOKUP for
the ctrl file name always succeeds (no matter the directory), so we'd
have to issue an additional NOTIFY_DELETE for every directory *and*
there'd still be a race condition with LOOKUP(ctrl_file) being called
in-between.



Best,
-Nikolaus
