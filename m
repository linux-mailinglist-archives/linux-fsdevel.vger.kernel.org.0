Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227DC2030B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 09:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbgFVHfL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 03:35:11 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:33741 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731323AbgFVHfK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:35:10 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id B5534FE9;
        Mon, 22 Jun 2020 03:35:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 22 Jun 2020 03:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=from
        :to:cc:subject:references:date:in-reply-to:message-id
        :mime-version:content-type:content-transfer-encoding; s=fm2; bh=
        9J0MA+owJTES6VlBwwJwkP9QNd2iN8Nn7MVpzFfGH/A=; b=0QrH+cRz+rCUBDFf
        xtERZ1IcgAqvIGtf3FtH9ExWrn7W2tljbqmGC+m4m5ZBpAWeGxJw1rbt/3UmRk78
        OHv3s/YSmtv4RBIP8eVX8uBekucXHCeYvnJ95N5E9ehJnaJkraaFgRrTxBmXRr9C
        KMw9QPmHOmUE7F0Z/RobyjiU6X9lML+Oe/fpc/dwS95dAN8FoELn+j4jJcIKXYOU
        WHvy70o0vcz+L/2Dis9pJcyl1PddTXUcCDIRUx5Pew891YS4/xHF5j+/Nzx4Qhh+
        EcNpPo4/ignZtezJRnYHq4UIMDWNqjv5fhXXa5+OzEh+y9Wy+CDl8Dg73PgBUoZS
        Yqk8Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=9J0MA+owJTES6VlBwwJwkP9QNd2iN8Nn7MVpzFfGH
        /A=; b=nBII26kH2a0EZciIXfW6L+aCl54zJWFgPVRbVfA+Cp4duXOF4gsq17GRw
        IS0COnoed2vrVKMeUw5bY+pqVCpm+Xe/9+heNwAH62/hZRoy5nmt+zrrPL3e5LsS
        JwuIxcz+zRmT1G3Vh7jcrK1jNHwsfd9MoA0l7bcz2tqHLRV5JW8EHX9Ph+YoMjaI
        MOYJ0zH7DqIw3+DodtZHMDS1Sxz1K6zp6cac08iwIn4qSOawsNUlNdJ0WgcJ8u9a
        gdIE4/usaRiTYVqIKXJPyCs8seSr5NTo/L1AipIfaufZj+FROT135B2wiNadft3W
        jexw2iNVc7upmbokd5ihYJ5MS214Q==
X-ME-Sender: <xms:KF_wXukL_fxXVrRFoNsVMnvr6Uv36RclspJhFpaNYcJSeaacxLFmcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudekuddguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufhffjgfkfgggtgfgsehtqhdttddtreejnecuhfhrohhmpefpihhk
    ohhlrghushcutfgrthhhuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecuggftrf
    grthhtvghrnhepgeefjedvueejueekgffhtdefteeihfetvdfgvefgheffhefgkedtgfek
    vdfgveefnecuffhomhgrihhnpehophgvnhhgrhhouhhprdhorhhgnecukfhppedukeehrd
    efrdelgedrudelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpefpihhkohhlrghushesrhgrthhhrdhorhhg
X-ME-Proxy: <xmx:KF_wXl2EM2FHgiYYHnf12vDmvJKw9AmKIR0rvlSRNLTGdokI0TDc1A>
    <xmx:KF_wXspB904TYurOZ9HIKnfPlMHSCIaVYUR7Qx1piFVXxW7dAPlruA>
    <xmx:KF_wXinrfds68S2qYlPYSC6NPY-9V9ZMW63zzSBOmmILXpHmL8DyWw>
    <xmx:LV_wXg_EurRWPv2kDHYYPcsveQKPGbIHpPbKN6F75Fc48DQZkI2qWw>
Received: from ebox.rath.org (ebox.rath.org [185.3.94.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2F9133067331;
        Mon, 22 Jun 2020 03:35:04 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 5782438;
        Mon, 22 Jun 2020 07:35:03 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id 35B02E28AF; Mon, 22 Jun 2020 08:35:03 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [fuse-devel] 512 byte aligned write + O_DIRECT for xfstests
References: <CAMHtQmP_TVR8QA+noWQk04Nj_8AxMXfjCj1K_k0Zf6BN-Bq9sg@mail.gmail.com>
        <87bllhh7mg.fsf@vostro.rath.org>
        <CAMHtQmPcADq0WSAY=uFFyRgAeuCCAo=8dOHg37304at1SRjGBg@mail.gmail.com>
        <877dw0g0wn.fsf@vostro.rath.org>
        <CAJfpegs3xthDEuhx_vHUtjJ7BAbVfoDu9voNPPAqJo4G3BBYZQ@mail.gmail.com>
        <87sgensmsk.fsf@vostro.rath.org>
        <CAOQ4uxiYG3Z9rnXB6F+fnRtoV1e3k=WP5-mgphgkKsWw+jUK=Q@mail.gmail.com>
Mail-Copies-To: never
Mail-Followup-To: Amir Goldstein <amir73il@gmail.com>, fuse-devel
        <fuse-devel@lists.sourceforge.net>, linux-fsdevel
        <linux-fsdevel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>, Dave Chinner
        <dchinner@redhat.com>
Date:   Mon, 22 Jun 2020 08:35:03 +0100
In-Reply-To: <CAOQ4uxiYG3Z9rnXB6F+fnRtoV1e3k=WP5-mgphgkKsWw+jUK=Q@mail.gmail.com>
        (Amir Goldstein's message of "Mon, 22 Jun 2020 09:37:35 +0300")
Message-ID: <87mu4vsgd4.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Jun 22 2020, Amir Goldstein <amir73il@gmail.com> wrote:
> [+CC fsdevel folks]
>
> On Mon, Jun 22, 2020 at 8:33 AM Nikolaus Rath <Nikolaus@rath.org> wrote:
>>
>> On Jun 21 2020, Miklos Szeredi <miklos@szeredi.hu> wrote:
>> >> I am not sure that is correct. At step 6, the write() request from
>> >> userspace is still being processed. I don't think that it is reasonab=
le
>> >> to expect that the write() request is atomic, i.e. you can't expect to
>> >> see none or all of the data that is *currently being written*.
>> >
>> > Apparently the standard is quite clear on this:
>> >
>> >   "All of the following functions shall be atomic with respect to each
>> > other in the effects specified in POSIX.1-2017 when they operate on
>> > regular files or symbolic links:
>> >
>> > [...]
>> > pread()
>> > read()
>> > readv()
>> > pwrite()
>> > write()
>> > writev()
>> > [...]
>> >
>> > If two threads each call one of these functions, each call shall
>> > either see all of the specified effects of the other call, or none of
>> > them."[1]
>> >
>> > Thanks,
>> > Miklos
>> >
>> > [1]
>> > https://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.h=
tml#tag_15_09_07
>>
>> Thanks for digging this up, I did not know about this.
>>
>> That leaves FUSE in a rather uncomfortable place though, doesn't it?
>> What does the kernel do when userspace issues a write request that's
>> bigger than FUSE userspace pipe? It sounds like either the request must
>> be splitted (so it becomes non-atomic), or you'd have to return a short
>> write (which IIRC is not supposed to happen for local filesystems).
>>
>
> What makes you say that short writes are not supposed to happen?

I don't think it was an authoritative source, but I I've repeatedly read
that "you do not have to worry about short reads/writes when accessing
the local disk". I expect this to be a common expectation to be baked
into programs, no matter if valid or not.

> Seems like the options for FUSE are:
> - Take shared i_rwsem lock on read like XFS and regress performance of
>   mixed rw workload
> - Do the above only for non-direct and writeback_cache to minimize the
>   damage potential
> - Return short read/write for direct IO if request is bigger that FUSE
> buffer size
> - Add a FUSE mode that implements direct IO internally as something like
>   RWF_UNCACHED [2] - this is a relaxed version of "no caching" in client =
or
>   a stricter version of "cache write-through"  in the sense that
> during an ongoing
>   large write operation, read of those fresh written bytes only is served
>   from the client cache copy and not from the server.

I didn't understand all of that, but it seems to me that there is a
fundamental problem with splitting up a single write into multiple FUSE
requests, because the second request may fail after the first one
succeeds.=20

Best,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
