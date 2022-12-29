Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E71F658ADB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 10:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiL2JVG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 04:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiL2JVF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 04:21:05 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859C6DEC9;
        Thu, 29 Dec 2022 01:21:03 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 168385C024D;
        Thu, 29 Dec 2022 04:21:01 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 29 Dec 2022 04:21:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1672305661; x=1672392061; bh=L0EoTG3qDJ
        ubgjvELC5diq0fKOZgb4tkHLVSHGjypzo=; b=rlOYwqUNgdnXQ8AWOWDlf12lwY
        y3j9rkPML69pZMjIJvMHjx7zjNSVhQe1bOpgdrgpT20LV9z2bSUy8DZUZhDydFKD
        tqOp6doVG8dKpxNO20dNSIIJ3DKpC4xWP0rmPIBcLduCqnlC3pWpCMl/7b9guUzV
        8yYxWqQ6XpfJBa8OXlR8ASnl5QvAoacxuj06tc16fKj00UCwVrEL30N3tXQN/6uz
        IvhzHNk/n+TmUxdBwqStFOlwAEhQLP+JuczEWCuuP/aV/K4bwTABAspkPPWSnEOZ
        GYoi1PF9w3jeVnHJIdGJWndUgK3R/QDlK/ObyoNrqiKxGPWHlpAhziLUYTkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672305661; x=1672392061; bh=L0EoTG3qDJubgjvELC5diq0fKOZg
        b4tkHLVSHGjypzo=; b=PxswnNSvJtQ4X8wU9PkLBFhmfR094T+Ats/VFIzsTQSz
        S9QibOSuJUTpt/o5G7sMZw5zguZ1+Gp9X7gTMbbewxzH34s9jvXd7Nrk+tjxbyHP
        2fKLjI5D2AqtpbgzGigfEJjeAilVHN09IfwYWZ8lNAdv+OxIR06Z2SgoKkR03yUs
        KTnVDMu8yKDnpxLH4JTg0OkAukhIUIojVhGoJ0e/FosY7lCI+9oFv3K1xG1UDmQY
        IXNfEwRZlRffM4VvkaqbDSHlDECpuoB3rzddYBlBa0gbT7iIKbtA0TVBqaA4Krnw
        muZggS4Dwm4GcWT/rj4YcOlrHOuBdLw/nW8bJhpqJw==
X-ME-Sender: <xms:_FutY1Znxef4lyd5V0LmBdp0UHMJcThN_KZ-AulsFLrwAUXoCdSkzw>
    <xme:_FutY8ZfIilvqtcogVAL3r3CsDTRJsaSYRRqzWk9ypGEKMqjgozM1SokFYpH3r7ur
    T90C21CZr5dWueSEUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieeggddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:_FutY38Dl1u2sp8bIV_y36omhs0ePcMmwX1nUUNkcUF_j5okkUwdbw>
    <xmx:_FutYzoDaExNz3baC3l-UECJ_FbcsPHRxvZnE9yw6fAHGgZDfAXOkQ>
    <xmx:_FutYwpA63yAhIC8d0OSVosvBvxF5cmeo7bPpXChts6MfHMZTDt7Bg>
    <xmx:_VutY1Q8qItFw4NUkgJUOGdcZjWtPC-2GdsQKa3Ms1cg2UKWa69pfA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 56787B60089; Thu, 29 Dec 2022 04:21:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <e25ee08c-7692-4042-9961-a499600f0a49@app.fastmail.com>
In-Reply-To: <7815c8da-7d5f-c2c5-9dfd-7a77ac37c7f7@themaw.net>
References: <166606025456.13363.3829702374064563472.stgit@donald.themaw.net>
 <166606036215.13363.1288735296954908554.stgit@donald.themaw.net>
 <Y2BMonmS0SdOn5yh@slm.duckdns.org> <20221221133428.GE69385@mutt>
 <7815c8da-7d5f-c2c5-9dfd-7a77ac37c7f7@themaw.net>
Date:   Thu, 29 Dec 2022 10:20:40 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Ian Kent" <raven@themaw.net>,
        "Anders Roxell" <anders.roxell@linaro.org>,
        "Tejun Heo" <tj@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Minchan Kim" <minchan@kernel.org>,
        "Eric Sandeen" <sandeen@sandeen.net>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Rick Lindsley" <ricklind@linux.vnet.ibm.com>,
        "David Howells" <dhowells@redhat.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>,
        "Carlos Maiolino" <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        elver@google.com
Subject: Re: [PATCH 1/2] kernfs: dont take i_lock on inode attr read
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 23, 2022, at 00:11, Ian Kent wrote:
> On 21/12/22 21:34, Anders Roxell wrote:
>> On 2022-10-31 12:30, Tejun Heo wrote:
>>> On Tue, Oct 18, 2022 at 10:32:42AM +0800, Ian Kent wrote:
>>>> The kernfs write lock is held when the kernfs node inode attributes
>>>> are updated. Therefore, when either kernfs_iop_getattr() or
>>>> kernfs_iop_permission() are called the kernfs node inode attributes
>>>> won't change.
>>>>
>>>> Consequently concurrent kernfs_refresh_inode() calls always copy the
>>>> same values from the kernfs node.
>>>>
>>>> So there's no need to take the inode i_lock to get consistent values
>>>> for generic_fillattr() and generic_permission(), the kernfs read lock
>>>> is sufficient.
>>>>
>>>> Signed-off-by: Ian Kent <raven@themaw.net>
>>> Acked-by: Tejun Heo <tj@kernel.org>
>> Hi,
>>
>> Building an allmodconfig arm64 kernel on yesterdays next-20221220 and
>> booting that in qemu I see the following "BUG: KCSAN: data-race in
>> set_nlink / set_nlink".
>
>
> I'll check if I missed any places where set_link() could be
> called where the link count could be different.
>
>
> If there aren't any the question will then be can writing the
> same value to this location in multiple concurrent threads
> corrupt it?

I think the race that is getting reported for set_nlink()
is about this bit getting called simulatenously on multiple
CPUs with only the read lock held for the inode:

     /* Yes, some filesystems do change nlink from zero to one */
     if (inode->i_nlink == 0)
               atomic_long_dec(&inode->i_sb->s_remove_count);
     inode->__i_nlink = nlink;

Since i_nlink and __i_nlink refer to the same memory location,
the 'inode->i_nlink == 0' check can be true for all of them
before the nonzero nlink value gets set, and this results in
s_remove_count being decremented more than once.

      Arnd
