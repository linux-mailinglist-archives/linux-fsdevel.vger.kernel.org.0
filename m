Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14B55B0937
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 17:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiIGPuz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 11:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiIGPug (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:50:36 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D803F1D2
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Sep 2022 08:50:22 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 56F015C0166;
        Wed,  7 Sep 2022 11:50:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 07 Sep 2022 11:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1662565821; x=
        1662652221; bh=3i/QkCZmuHB1ScMUZZPWUUAJ2jsbjEER/GlelbIHRD0=; b=i
        oG3+gH/u6bKFoEaFtFuQ6S456pQr4rru2t/zzdyXwzy4Eou9lwJ+sclp0v4HS9om
        5P7xEmjEaBG+ExsVwg0dlRHMKtAN3QVbsff9VG5ivkgC1vwprQ/vZ/ZjqS3k4y2n
        Yimqw/Q1YeXGiDx8Wv3P11aaV6s0mjYWBcwsma66cOmpV9Ffsxf6XfRxljVUPrBX
        FlrPubXyBAThUs50rlaIr3i/7xgvCogLssBfZLTyOo64YJnAlbduklFN54tcbxp0
        hQ54+1V7PBT+WXM8LGJ9+3sAQL+FKh0B4PErWpMufLWbbw+PBVEOfueEzEQbIoiW
        paGZwaH3Nm2uoxHzLZSQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662565821; x=
        1662652221; bh=3i/QkCZmuHB1ScMUZZPWUUAJ2jsbjEER/GlelbIHRD0=; b=G
        Q3OjQU6PrURFXjFZ+jn3Q8EQgcRTqxBmBFTHsXzudIRXJLi0JPbERF7Kogmv12Iv
        sQD/ojnic3HQgdxyveh09Q900o4d35YTHrgZOM2WhBfA+ZkOqqLOoiDD+yL3+9v7
        AnVCOT7quIgzTvNoBinEAreNC87qXJKbhN3AAYmABaZ1ospLT6HrqbnxdrURsS7Y
        6gQvEcBqUJGgChw4Ztd/evIoUvvzALsMtXfu/+ud/aHQalNaPQh0c+n9DK1IFbKI
        xP7LUwwd86zuH0xdNMCqzTglKe5oqI2WwfkirlD0cb4kIeEzHAt8KG1ON8jNzzJJ
        VeY1t52SMFkrFicpcLJwg==
X-ME-Sender: <xms:vL0YY_LJfNlfFT29jucWYB4QrzZpFPR0qeXK7iDHtsbzdKRHDOlkaA>
    <xme:vL0YYzKEnwZKMWWqXtbc-7GyH1BPKGCFjvTWYTXViCEjrp0Lu11ia-suTeUeTg0fB
    1g6nyE8bpSVGSaO>
X-ME-Received: <xmr:vL0YY3uNKFQjpL2r7tZocw-E1xvgbux-vsJ6-TAB_JesRSKr-bY5dGM22Mp_22RzPkbGvcSAmXU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedttddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufhffjgfkfgggtgfgsehtqhdttddtreejnecuhfhrohhmpefpihhk
    ohhlrghushcutfgrthhhuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecuggftrf
    grthhtvghrnhepudelffdujeeujeelgeejveeufeekiefgkedvffeihfekvedvtdevtdeh
    leefvdefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpnhgrrhhkihhvvgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpefpihhk
    ohhlrghushesrhgrthhhrdhorhhg
X-ME-Proxy: <xmx:vb0YY4YrqKAurLkpn4UHyC3stfQnsccJXMQRO_hly9ScsTZrZN6vGA>
    <xmx:vb0YY2awgA5aNyXEywyNBU5psmEbx1bbBUmEELR3SzMW-_5w5Kl5wg>
    <xmx:vb0YY8BbNV6bkmVC4zh8X3rKySEfL0mjlFpyoKPOPcdxU_MH-ESUKQ>
    <xmx:vb0YY7OPWB_rDie0Z1MssyQtnd64EJjgRL2PkVI8MnvO7yMJtWznAA>
Feedback-ID: i53a843ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Sep 2022 11:50:20 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 8B236475;
        Wed,  7 Sep 2022 15:50:18 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id B779ADC054; Wed,  7 Sep 2022 16:50:17 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     nbd@other.debian.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>, Wouter Verhelst <w@uter.be>
Subject: Re: Why do NBD requests prevent hibernation, and FUSE requests do not?
References: <87k06qb5to.fsf@vostro.rath.org>
        <f7110017-8606-8e50-7d86-fc53324a571d@fastmail.fm>
Mail-Copies-To: never
Mail-Followup-To: Bernd Schubert <bernd.schubert@fastmail.fm>,
        nbd@other.debian.org, Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>, Wouter Verhelst <w@uter.be>
Date:   Wed, 07 Sep 2022 16:50:17 +0100
In-Reply-To: <f7110017-8606-8e50-7d86-fc53324a571d@fastmail.fm> (Bernd
        Schubert's message of "Wed, 31 Aug 2022 01:02:16 +0200")
Message-ID: <87zgfbqj46.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Aug 31 2022, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
> On 8/30/22 08:31, Nikolaus Rath wrote:
>> Hello,
>> I am comparing the behavior of FUSE and NBD when attempting to hibernate
>> the system.
>> FUSE seems to be mostly compatible, I am able to suspend the system even
>> when there is ongoing I/O on the fuse filesystem.
>>=20
>
> ....
>
>> As far as I can tell, the problem is that while an NBD request is
>> pending, the atsk that waits for the result (in this case *rsync*) is
>> refusing to freeze. This happens even when setting a 5 minute timeout
>> for freezing (which is more than enough time for the NBD request to
>> complete), so I suspect that the NBD server task (in this case nbdkit)
>> has already been frozen and is thus unable to make progress.
>> However, I do not understand why the same is not happening for FUSE
>> (with FUSE requests being stuck because the FUSE daemon is already
>> frozen). Was I just very lucky in my tests? Or are tasks waiting for
>> FUSE request in a different kind of state? Or is NBD a red-herring here,
>> and the real trouble is with ZFS?
>> It would be great if someone  could shed some light on what's going on.
>
> I guess it is a generic issue also affecting fuse, see this patch
>
> https://lore.kernel.org/lkml/20220511013057.245827-1-dlunev@chromium.org/
>
> A bit down the thread you can find a reference to this ancient patch
>
> https://linux-kernel.vger.kernel.narkive.com/UeBWfN1V/patch-fuse-make-fus=
e-daemon-frozen-along-with-kernel-threads

Interesting, thank you for the link! So it seems that I just got lucky
with FUSE.

Does anyone know in which order the kernel freezes processes by default?
Could I perhaps work around the problem by calling the FUSE/NBD daemon
something like "zzzzz_mydaemon"?


Best,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
