Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B1F66DAA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 11:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236508AbjAQKMM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 05:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbjAQKML (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:12:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142752717;
        Tue, 17 Jan 2023 02:12:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C908AB81259;
        Tue, 17 Jan 2023 10:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A719C433D2;
        Tue, 17 Jan 2023 10:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673950327;
        bh=1kyH8IayjBEYo1vGFsWKGLFFjLtTxI6sFci6Hm/EigU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OFPkcsKSyRqBVh9LCBlb7nQu8TNY4L+OwBEWFIEslja7kNRTijSUG87fIuc4XpS8Y
         tIOwmMStuhBFvIq4KOtboplWAz18pwvTNr1mDzFQyVmJ4tAgW61d2KpTQAiADEnIAL
         AMnI7fcrXTSAMKgTz38lpGceWiFuMi+a/BaNvNioxbmxckF9HQqj0FJYKzy4dyqYBT
         ka2LJIGY+K6kjxvHnibqJKIAOS0O4n9gw46dZrfHd5sRxSdoNsvH87PgxjtVmKAjoX
         ZzVzo/E/27qMYh0Uoq0cvAAdmkUzBnHJddXDME9xsuyUIvrWWSz6qUPMitFg2Sif1s
         IIAVutJkQKy+Q==
Date:   Tue, 17 Jan 2023 11:12:02 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
        Yurii Zubrytskyi <zyy@google.com>,
        Eugene Zemtsov <ezemtsov@google.com>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 0/6] Composefs: an opportunistically sharing verified
 image filesystem
Message-ID: <20230117101202.4v4zxuj2tbljogbx@wittgenstein>
References: <cover.1673623253.git.alexl@redhat.com>
 <3065ecb6-8e6a-307f-69ea-fb72854aeb0f@linux.alibaba.com>
 <d3c63da908ef16c43a6a65a22a8647bf874695c7.camel@redhat.com>
 <0a144ffd-38bb-0ff3-e8b2-bca5e277444c@linux.alibaba.com>
 <9d44494fdf07df000ce1b9bafea7725ea240ca41.camel@redhat.com>
 <d7c4686b-24cc-0991-d6db-0dec8fb9942e@linux.alibaba.com>
 <2856820a46a6e47206eb51a7f66ec51a7ef0bd06.camel@redhat.com>
 <8f854339-1cc0-e575-f320-50a6d9d5a775@linux.alibaba.com>
 <CAOQ4uxh34udueT-+Toef6TmTtyLjFUnSJs=882DH=HxADX8pKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh34udueT-+Toef6TmTtyLjFUnSJs=882DH=HxADX8pKw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 17, 2023 at 09:05:53AM +0200, Amir Goldstein wrote:
> > It seems rather another an incomplete EROFS from several points
> > of view.  Also see:
> > https://lore.kernel.org/all/1b192a85-e1da-0925-ef26-178b93d0aa45@plexistor.com/T/#u
> >
> 
> Ironically, ZUFS is one of two new filesystems that were discussed in LSFMM19,
> where the community reactions rhyme with the reactions to composefs.
> The discussion on Incremental FS resembles composefs case even more [1].
> AFAIK, Android is still maintaining Incremental FS out-of-tree.
> 
> Alexander and Giuseppe,
> 
> I'd like to join Gao is saying that I think it is in the best interest
> of everyone,
> composefs developers and prospect users included,
> if the composefs requirements would drive improvement to existing
> kernel subsystems rather than adding a custom filesystem driver
> that partly duplicates other subsystems.
> 
> Especially so, when the modifications to existing components
> (erofs and overlayfs) appear to be relatively minor and the maintainer
> of erofs is receptive to new features and happy to collaborate with you.
> 
> w.r.t overlayfs, I am not even sure that anything needs to be modified
> in the driver.
> overlayfs already supports "metacopy" feature which means that an upper layer
> could be composed in a way that the file content would be read from an arbitrary
> path in lower fs, e.g. objects/cc/XXX.
> 
> I gave a talk on LPC a few years back about overlayfs and container images [2].
> The emphasis was that overlayfs driver supports many new features, but userland
> tools for building advanced overlayfs images based on those new features are
> nowhere to be found.
> 
> I may be wrong, but it looks to me like composefs could potentially
> fill this void,
> without having to modify the overlayfs driver at all, or maybe just a
> little bit.
> Please start a discussion with overlayfs developers about missing driver
> features if you have any.

Surprising that I and others weren't Cced on this given that we had a
meeting with the main developers and a few others where we had said the
same thing. I hadn't followed this. 

We have at least 58 filesystems currently in the kernel (and that's a
conservative count just based on going by obvious directories and
ignoring most virtual filesystems).

A non-insignificant portion is probably slowly rotting away with little
fixes coming in, with few users, and not much attention is being paid to
syzkaller reports for them if they show up. I haven't quantified this of
course.

Taking in a new filesystems into kernel in the worst case means that
it's being dumped there once and will slowly become unmaintained. Then
we'll have a few users for the next 20 years and we can't reasonably
deprecate it (Maybe that's another good topic: How should we fade out
filesystems.).

Of course, for most fs developers it probably doesn't matter how many
other filesystems there are in the kernel (aside from maybe competing
for the same users).

But for developers who touch the vfs every new filesystems may increase
the cost of maintaining and reworking existing functionality, or adding
new functionality. Making it more likely to accumulate hacks, adding
workarounds, or flatout being unable to kill off infrastructure that
should reasonably go away. Maybe this is an unfair complaint but just
from experience a new filesystem potentially means one or two weeks to
make a larger vfs change.

I want to stress that I'm not at all saying "no more new fs" but we
should be hesitant before we merge new filesystems into the kernel.

Especially for filesystems that are tailored to special use-cases.
Every few years another filesystem tailored to container use-cases shows
up. And frankly, a good portion of the issues that they are trying to
solve are caused by design choices in userspace.

And I have to say I'm especially NAK-friendly about anything that comes
even close to yet another stacking filesystems or anything that layers
on top of a lower filesystem/mount such as ecryptfs, ksmbd, and
overlayfs. They are hard to get right, with lots of corner cases and
they cause the most headaches when making vfs changes.
