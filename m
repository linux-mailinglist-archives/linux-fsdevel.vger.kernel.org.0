Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3BB10B95B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 21:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbfK0UwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 15:52:22 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51515 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730596AbfK0UwV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:52:21 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C6A41227BA;
        Wed, 27 Nov 2019 15:52:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 27 Nov 2019 15:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=from
        :to:cc:subject:references:date:in-reply-to:message-id
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        V0nvbw8WupJOsKEB+UWGp4IdWzQhYIZ2S+3nnXpSNeU=; b=UqD+YE72uKeDOGtV
        J88ybhO5cDKXxNtFffy8Q2AaN67/FbopNXNFhSrHrBcAuj2d68lhRns1ioPqOqok
        a1mQtbgmC/E8zALXGD84+5Q6VXbPKT8rbwT3EXTo+MDkFvbghGmNQ4hh7dem14cG
        9f+0fFtpZ0bhdkb+harmobbShWkYc4+BoVi5NOiXNoaWSqqgw+pXdo2MaR2uTZnM
        mA/j4qVusHv2Oa5HR4McOiIuW4GoC4CEAsoFfFhtp6HjjoWAn6ULFVjguj3GWfQt
        KmBu5jIps6WEiod/L2GL5dYaILnJ8787786qGdWNnzzYIxy2MAGsw+46A2Jpktt9
        C3fWiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=V0nvbw8WupJOsKEB+UWGp4IdWzQhYIZ2S+3nnXpSN
        eU=; b=vJwGywUmenFrYeVTix8SPcSQe15Ch7li2MGJzWIEVxmlvCulWsp5Fzdtj
        eixLX6i5lXX1SuJeP4KmSaCvttdMm+4fjlpw5pqJbpHe9dsgYCwt7SNpCgbwY1EN
        k90soD+/BepH5jAzG9YJ1puCU0CA4zui7qMOo3thQcBc1IXeZe6XXjUNJaHH6N0H
        qzANaFzh0N2TxcBZXG9NA1Ji9yayQCuqiSEtkF8MW8eOu1MhL9n643OdFS5ljtky
        GVBfMeuUoh+CLSFx1DtU85mT1w3Je0562oLjYCqJXT4OIMPAZcmZOHZMJWu3NbY2
        eecC0OurqY0XLoS9PZknv8cIu67pQ==
X-ME-Sender: <xms:BOLeXdZb4j-TtnZsNJnaYgwC-qUIKANVGPSBDuQ9HMp_wijve6uNHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeihedgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufhffjgfkfgggtgfgsehtqhdttddtreejnecuhfhrohhmpefpihhk
    ohhlrghushcutfgrthhhuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecukfhppe
    dukeehrdefrdelgedrudelgeenucfrrghrrghmpehmrghilhhfrhhomheppfhikhholhgr
    uhhssehrrghthhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:BOLeXXV8LN9ZAzuepSK7Rj8ONk-vA9IGp2aKIMUZCnoAdZCYAM4EbQ>
    <xmx:BOLeXYJwZoxc2ABd2DmIGMThlUvvI1kvncVwEmBP2Ys3F1Dng3kUtQ>
    <xmx:BOLeXadXhOGXY3L9xGWqBErA3e4d_3VnNWr32fmHDxiYnEfIlaf4bg>
    <xmx:BOLeXdsImfE1E-5Z0YI6Ioep7GypL8POoAs8sUfS8BrV0f9dp8SPQw>
Received: from ebox.rath.org (ebox.rath.org [185.3.94.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id DF1B83060060;
        Wed, 27 Nov 2019 15:52:19 -0500 (EST)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id E6EB945;
        Wed, 27 Nov 2019 20:52:18 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id AFD63E1E90; Wed, 27 Nov 2019 20:52:18 +0000 (GMT)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [fuse-devel] Handling of 32/64 bit off_t by getdents64()
References: <8736e9d5p4.fsf@vostro.rath.org>
        <CAJfpegtOf6mV4m3W1v2N8eOD-ep=tFOhKDCFk+-M3=tzc7wVig@mail.gmail.com>
Mail-Copies-To: never
Mail-Followup-To: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel
        <fuse-devel@lists.sourceforge.net>, linux-fsdevel
        <linux-fsdevel@vger.kernel.org>
Date:   Wed, 27 Nov 2019 20:52:18 +0000
In-Reply-To: <CAJfpegtOf6mV4m3W1v2N8eOD-ep=tFOhKDCFk+-M3=tzc7wVig@mail.gmail.com>
        (Miklos Szeredi's message of "Wed, 27 Nov 2019 15:30:30 +0100")
Message-ID: <87muchyrct.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Nov 27 2019, Miklos Szeredi <miklos@szeredi.hu> wrote:
>> Is there a way for a 64 bit process (in this case the FUSE daemon) to
>> ask for 32 bit d_off values from getdents64()?
>
> Looking at ext4 d_off encoding, it looks like the simple workaround is
> to use the *high* 32 bits of the offset.
>
> Just tried, and this works.  The lower bits are the "minor" number of
> the offset, and no issue with zeroing those bits out, other than
> increasing the chance of hash collision from practically zero to very
> close to zero.
>
>> Would it be feasible to extend the FUSE protocol to include information
>> about the available bits in d_off?
>
> Yes.
>
> The relevant bits from ext4 are:
>
> static inline int is_32bit_api(void)
> {
> #ifdef CONFIG_COMPAT
>     return in_compat_syscall();
> #else
>     return (BITS_PER_LONG =3D=3D 32);
> #endif
> }

Thanks for the quick response!

Is there a way to do the same without relying on ext4 internals, i.e. by
manually calling getdents64() in such a way that in_compat_syscall()
gives true even if the caller is 64 bit?



Best,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
