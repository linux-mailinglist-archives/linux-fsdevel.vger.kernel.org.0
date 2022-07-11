Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59B256D82E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 10:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiGKIfP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 04:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiGKIek (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:34:40 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614ACDF8B
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 01:33:46 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 5D99C32007D7;
        Mon, 11 Jul 2022 04:33:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 11 Jul 2022 04:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1657528423; x=
        1657614823; bh=y3LUwrVXkGFUHqDs67lggoWMtERIGgc0O5oLxufAtSQ=; b=P
        uEpO2eyB3e8kaydspDboLAyLdXyMK21KaIsbgX1bsq1+3fX6+Nst7JbOB+M6y8bh
        wZdFTVpZdf4MrR9AOPs7XiNqtWPM6Gw1F6vrSvlmsnC8o939qD59u3JdjZOGQdn/
        Z2r/4zNSirggkWZRr1akwucYPR9Fw68aONo6Oh3kyouOmfMuv2fheL76yiAOiL8J
        5PaOno8/Aq1LdOcVnR58UUJkD4PbYjcXzKZ2WhXmh0TldfpTUvBhQkMX8ma21RrK
        M3QqC/wi2WYf6loT7iCbGhOBf2qE2sjPLGQwPfCTAuKAyPRqKnLM2ON0OjatUeU0
        QsAhO8lt/V7qkwBXyJevw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1657528423; x=
        1657614823; bh=y3LUwrVXkGFUHqDs67lggoWMtERIGgc0O5oLxufAtSQ=; b=Z
        MIg9n/PfBD+IbhPwOC/hZaaPaPhn4KJaa391K0l+A54zVUIHW3kQqRPZLn9uw8dp
        tyCRBSuX83Cw7o010MCeaUQzs1MhcG86cKtb7lh+UTBuGNKN1g2bqUty0+nEEhKl
        y48ZCzxBYcDSlH7MdX0FWrJV7PsLSGEd4/LMARHHLDZ/8OMLX2Ft77rJfC3DfM9h
        jvwLDjDocNOilJDRWfluxrEc0A4iE/pYR5UVXjBdy+l9v0JLSSTzIYktQWv9USPH
        bjteYVPIlB80T7QMz2WOElA0xzfXoi2JiNssx/dP4xL2YTjTGchik60cSLC1rSTM
        d0EKJoPbmoT1GzzSObzQg==
X-ME-Sender: <xms:Z-DLYmj8BQoKtpnZc7dyiS3QgzwkekCJjFAwUr4JAQSfmG_Qeku8nQ>
    <xme:Z-DLYnAEKM1O78_qfky34tgNfYL0aC9ToenBfjDVgOcHJx-xxFqViE-vwSKWIcaw6
    GKUvKMMb1eOFVB5>
X-ME-Received: <xmr:Z-DLYuHbpnya3hnFTZaEW436LpxvN7TZfbtnRv2ATRRkbuAej32Ptl61XjiRDtFt5565NCTleTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejfedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufhffjgfkfgggtgfgsehtqhdttddtreejnecuhfhrohhmpefpihhk
    ohhlrghushcutfgrthhhuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecuggftrf
    grthhtvghrnhepleffjefhgfffiedufeekvdeflefhheejjedugeejuefgleehvdejtdeg
    kedthfetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eppfhikhholhgruhhssehrrghthhdrohhrgh
X-ME-Proxy: <xmx:Z-DLYvQw5xKyJIxXG40x59IobUEVYLzknI7nXKdwWYH5i5EfT2f7fA>
    <xmx:Z-DLYjzUnrd-UqSHxVLN67HfsEKI7zkR6gNzGVbJGpgsC4Inx7aXpA>
    <xmx:Z-DLYt7hhBEX9zlEWdDnrS6GwjtnAYyvx2AuDi3Mr3D8BSRGzXvw3w>
    <xmx:Z-DLYuoP_oQi1ijdga5B8G3Nz0je7_AA1qNUWcdm4Trham9cKAIxhw>
Feedback-ID: i53a843ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Jul 2022 04:33:43 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 52257438;
        Mon, 11 Jul 2022 08:33:41 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id E7822D3481; Mon, 11 Jul 2022 10:33:40 +0200 (CEST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        miklos <mszeredi@redhat.com>
Subject: Re: [fuse-devel] potential race in FUSE's readdir() + releasedir()?
References: <87tu7yjm9x.fsf@vostro.rath.org>
        <CAJfpegvgWZcwP=M7hE44=jaKfmB2PXyzyodii63JZhGwVhaJHQ@mail.gmail.com>
Mail-Copies-To: never
Mail-Followup-To: Miklos Szeredi <miklos@szeredi.hu>, Linux FS Devel
        <linux-fsdevel@vger.kernel.org>, fuse-devel
        <fuse-devel@lists.sourceforge.net>, miklos <mszeredi@redhat.com>
Date:   Mon, 11 Jul 2022 09:33:40 +0100
In-Reply-To: <CAJfpegvgWZcwP=M7hE44=jaKfmB2PXyzyodii63JZhGwVhaJHQ@mail.gmail.com>
        (Miklos Szeredi's message of "Wed, 6 Jul 2022 10:35:56 +0200")
Message-ID: <878rp0xd3v.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Jul 06 2022, Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Sun, 3 Jul 2022 at 16:37, Nikolaus Rath <Nikolaus@rath.org> wrote:
>>
>> Hello,
>>
>> I am seeing something that to me looks like a race between FUSE's
>> readdir() and releasedir() handlers. On kernel 5.18, the FUSE daemon
>> seems to (ocasionally) receive a releasedir() request while a readdir()
>> request with the same `struct fuse_file_info *fi->fh` is still active
>> (i.e., the FUSE daemon hasn't sent a reply to the kernel for this yet).
>>
>> Could this be a bug in the kernel? Or is there something else that could
>> explain this?
>
> Is there a log where this can be observed?

Not so far, I haven't been able to reproduce it with debug logging
enabled.

The way that I'm inferring what's happening is from a crash due to
writing to freed memory. My fi->fh points to a malloc'ed area that is
free'd in releasedir(), and written to in readdir().


Best,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
