Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 427FBE21B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 19:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbfJWR0a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 13:26:30 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49077 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727079AbfJWR0a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:26:30 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 57E5D21C1C;
        Wed, 23 Oct 2019 13:26:29 -0400 (EDT)
Received: from imap37 ([10.202.2.87])
  by compute3.internal (MEProxy); Wed, 23 Oct 2019 13:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=0knanq
        ekLPQV87ERHw4iVDTDeinA++F4mZdOV96+DgA=; b=CfP4EN3+CmRvJCkL30vqVs
        4hMcXYkOQgYJ9PwfitBwhaDGNw38gZ98nchNKXWi/05gNL8HbCLnuYh/G8uSRQsW
        y9EaM+evY7Zo7uUp1X6H2S1G3v60rky0v5/tUzd8R98vcpWkRX9adFLPBEB/iJFY
        U6oBmU/MoUlIj2oQRTaaxuK9AyoEWcJxiqb4OkfgW9y+olIo3wnKX3h6nbBQyZql
        /bxWzCRhVBrYxkeL52sorR4UONy+1CrhKJMWm/RLLwOgSgXm8xG8Fw8kpHK1Mpl3
        9XLUeiD6VS6nER4AWIVrbdXhW8DcWprUBUfVu9fbMMSwfNVfCz7n8kX6abZV9q+g
        ==
X-ME-Sender: <xms:RI2wXYYHBDEq7C5dNqrH64npMfKRZMHrMlA0KKcPaFDbyEq2VuXRfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrkeelgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdevohhl
    ihhnucghrghlthgvrhhsfdcuoeifrghlthgvrhhssehvvghrsghumhdrohhrgheqnecuff
    homhgrihhnpehgihhthhhusgdrtghomhenucfrrghrrghmpehmrghilhhfrhhomhepfigr
    lhhtvghrshesvhgvrhgsuhhmrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:RI2wXXqNJkK9ejtmO3C-jfKUlGUA7yGtvZk7TwZbVoDjffU7JRyCLg>
    <xmx:RI2wXd_FqMd7Oa0S7h2iVqbmLUkpTgtiqjiGwon3gk4AdIFnSpwyLg>
    <xmx:RI2wXW-jNX-kPswBV6AQDOUzgnoLsvDyGIGPPNgMLVl5SrF_kNh6-g>
    <xmx:RY2wXWdD3SoIOOZj5ql3ZiiHQTxSo0X_6LXLlkuxB2xnPuQya1fkmA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8EB11684005F; Wed, 23 Oct 2019 13:26:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-470-gedfae93-fmstable-20191021v4
Mime-Version: 1.0
Message-Id: <f5328c94-1a98-4502-ab15-0984dafcb2de@www.fastmail.com>
In-Reply-To: <CAJCQCtSPkcrNfP89SNJzkaVuAL3FehUQLL9ZhU0ouhNdcOu+Yw@mail.gmail.com>
References: <CAJCQCtQ38W2r7Cuu5ieKRQizeKF0tf--3Z8yOJeeR+ZZ4S6CVQ@mail.gmail.com>
 <CAFLxGvxdPQdzBz1rc3ZC+q1gLNCs9sbn8FOS6G-E1XxXeybyog@mail.gmail.com>
 <20191022105413.pj6i3ydetnfgnkzh@pali>
 <CAJCQCtToPc5sZTzdxjoF305VBzuzAQ6K=RTpDtG6UjgbWp5E8g@mail.gmail.com>
 <521a5d27-dae9-44a3-bb90-43793bbde7d5@www.fastmail.com>
 <CAJCQCtSPkcrNfP89SNJzkaVuAL3FehUQLL9ZhU0ouhNdcOu+Yw@mail.gmail.com>
Date:   Wed, 23 Oct 2019 13:26:08 -0400
From:   "Colin Walters" <walters@verbum.org>
To:     "Chris Murphy" <lists@colorremedies.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        "Richard Weinberger" <richard.weinberger@gmail.com>,
        "Linux FS Devel" <linux-fsdevel@vger.kernel.org>
Subject: Re: Is rename(2) atomic on FAT?
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Wed, Oct 23, 2019, at 10:24 AM, Chris Murphy wrote:
> On Wed, Oct 23, 2019 at 2:53 PM Colin Walters <walters@verbum.org> wrote:
> >
> >
> >
> > On Tue, Oct 22, 2019, at 8:10 PM, Chris Murphy wrote:
> > >
> > > For multiple kernels,  it doesn't matter if a crash happens anywhere
> > > from new kernel being written to FAT, through initramfs, because the
> > > old bootloader configuration still points to old kernel + initramfs.
> > > But in multiple kernel distros, the bootloader configuration needs
> > > modification or a new drop in scriptlet to point to the new
> > > kernel+initramfs pair. And that needs to be completely atomic: write
> > > new files to a tmp location, that way a crash won't matter. The tricky
> > > part is to write out the bootloader configuration change such that it
> > > can be an atomic operation.
> >
> > Related: https://github.com/ostreedev/ostree/issues/1951
> > There I'm proposing there to not try to fix this at the kernel/filesystem
> > level (since we can't do much on FAT, and even on real filesystems we
> > have the journaling-vs-bootloader issues), but instead create a protocol
> > between things writing bootloader data and the bootloaders to help
> > verify integrity.
> 
> The symlink method now being used, you describe as an OSTree-specific
> invention. How is the new method you're proposing more generic such
> that it's not also an OSTree-specific invention?

It'd take a usual slow process of gathering consensus among the two groups of projects writing data in /boot, and bootloaders.
