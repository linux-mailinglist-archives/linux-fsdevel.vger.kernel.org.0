Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F02FE1B69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 14:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391961AbfJWMxo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 08:53:44 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40249 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390962AbfJWMxo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:53:44 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C52EF20D84;
        Wed, 23 Oct 2019 08:53:42 -0400 (EDT)
Received: from imap37 ([10.202.2.87])
  by compute3.internal (MEProxy); Wed, 23 Oct 2019 08:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=EY3TAf
        ovGNEqGb0Fcc3g3/Pe2TDNMH3pMna4aigfHZE=; b=icYPPZTuPSobGVgBBfyo6P
        RypAxdIjfiIzRkkbFH53hafZteUbD0iUyDs4BRXnfil6k9wIqq1WUYpNDL26i+Jc
        q7rrwH2JfvWaNv9zR+k9r5Yzt012gspYRX/L2WTgzyfHxE0KOsHAAeVsfg0LFYyA
        hwL870e3/WZFI77pf5TA0xcD6KlAYbmi2BDdZZBr5yPcV5qcbwulsYBEiJWOzrWN
        vbU8TGglNIgTj3Akhkn33W488O3Vi/6outSs3U5VbzNnVPIX2Ge2SxjrBsTfoDtM
        SWwAOVFsVq46N8HxfXkaCkXNNUjnnwf9e3oLfXb4BTMINbDa7L2neudt9E1DBWZw
        ==
X-ME-Sender: <xms:Vk2wXVtHuAK_AAAqWJI_mhGbA1DCXgejVD5ztHCprcPSkIgxy6FUFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrkeelgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfveholhhi
    nhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenucffoh
    hmrghinhepghhithhhuhgsrdgtohhmnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifrghl
    thgvrhhssehvvghrsghumhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:Vk2wXaSOpyeCBSKQibqy2QFgSwXZPff2Ztq_i7ZhhJnq11PWKkJUVQ>
    <xmx:Vk2wXUJNAOxw2gETM8y7epT1mb1UJi9Wz_wypgBdkoy4XLpUajxkZw>
    <xmx:Vk2wXVtuEGnj0KhUIbJPRAo_I-pybN_N_JAwEiADBWrIqtGszwa6ww>
    <xmx:Vk2wXfF1QTNBK5HdyqgVYHJswb7Cd-TrqvIQFwUclZjaCiBlh16HPA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6256D684005F; Wed, 23 Oct 2019 08:53:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-470-gedfae93-fmstable-20191021v4
Mime-Version: 1.0
Message-Id: <521a5d27-dae9-44a3-bb90-43793bbde7d5@www.fastmail.com>
In-Reply-To: <CAJCQCtToPc5sZTzdxjoF305VBzuzAQ6K=RTpDtG6UjgbWp5E8g@mail.gmail.com>
References: <CAJCQCtQ38W2r7Cuu5ieKRQizeKF0tf--3Z8yOJeeR+ZZ4S6CVQ@mail.gmail.com>
 <CAFLxGvxdPQdzBz1rc3ZC+q1gLNCs9sbn8FOS6G-E1XxXeybyog@mail.gmail.com>
 <20191022105413.pj6i3ydetnfgnkzh@pali>
 <CAJCQCtToPc5sZTzdxjoF305VBzuzAQ6K=RTpDtG6UjgbWp5E8g@mail.gmail.com>
Date:   Wed, 23 Oct 2019 08:53:22 -0400
From:   "Colin Walters" <walters@verbum.org>
To:     "Chris Murphy" <lists@colorremedies.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "Richard Weinberger" <richard.weinberger@gmail.com>,
        "Linux FS Devel" <linux-fsdevel@vger.kernel.org>
Subject: Re: Is rename(2) atomic on FAT?
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Tue, Oct 22, 2019, at 8:10 PM, Chris Murphy wrote:
>
> For multiple kernels,  it doesn't matter if a crash happens anywhere
> from new kernel being written to FAT, through initramfs, because the
> old bootloader configuration still points to old kernel + initramfs.
> But in multiple kernel distros, the bootloader configuration needs
> modification or a new drop in scriptlet to point to the new
> kernel+initramfs pair. And that needs to be completely atomic: write
> new files to a tmp location, that way a crash won't matter. The tricky
> part is to write out the bootloader configuration change such that it
> can be an atomic operation.

Related: https://github.com/ostreedev/ostree/issues/1951
There I'm proposing there to not try to fix this at the kernel/filesystem
level (since we can't do much on FAT, and even on real filesystems we
have the journaling-vs-bootloader issues), but instead create a protocol
between things writing bootloader data and the bootloaders to help
verify integrity.
