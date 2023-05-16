Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA0A704A48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 12:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjEPKQ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 06:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjEPKQ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 06:16:56 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94550E6A
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 03:16:55 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 03CEB5C00F7;
        Tue, 16 May 2023 06:16:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 16 May 2023 06:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1684232214; x=1684318614; bh=qGhMGRAtjxAyCpT0id+n/1+YA9bnkK17mkA
        CkqhUL14=; b=RophgP+4WwdiSvewq4TqNNQj3wy7J4uDBzgAccpqAMsoDtlOCNy
        PCrbPy0bkjeaBVDGOwrmGRL0WDblN0rbmUk5lqB6pydNrCgYIjBcir43y9GNJwCk
        7QfQJpfwZpMpHABO+F38mrCnxSs1W/NZO1oIuaH8wkSMg1qANJWFifFHimApY7Bg
        c2F/qZJaOWbcETFF+7T00OYZCFBmDYOKtZ+nLUQJKcgZKj73CwT7M0Hdnxb0nUSd
        TRLoOrKfhinYxnnOdpCJuUsSzrkz5XfrzoQmeWkwSIKvmkMsvcMHsWz0ZVYdNCsN
        eMqCv/3H6X+EkTpsiMuhS83RbgnH+Ygu/5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684232214; x=1684318614; bh=qGhMGRAtjxAyCpT0id+n/1+YA9bnkK17mkA
        CkqhUL14=; b=Hxu1NIUZ14WENPhCdzf59xS367C6dtub7jAo7isSqE8XkpE6eFX
        0Em3CUmXOyBsZcmMHBC3SvD/B7MbCGHme52LSTMlmZ5HKfR0TSuL3C6gCg6VWtSv
        q9gOGfC8UPhEOOtEMNbz/+oayJLf1VVXFyfFGSKvYf7iiyYmCNYE2ZqiyqcqusZb
        Jq28XeLPdu2a/2qW21uQ9kK2hjf/j78zzdkx0Vh3k3VxstMcbkkmycqdsW3o7S9H
        F+Y2bu6XXPVJNjCgLoyYQ7nZhUDDeEwxC2kRQceyCp245fdGSN499uaa67ZEGKeX
        asxJkLfR+hNAJzZWaaXiOogj7scT/nYxGzA==
X-ME-Sender: <xms:FlhjZDXnQ_ITeIu7Ktc2dcW5WuvKjJdl-oT_hPqL_RyeaqhRwfaPug>
    <xme:FlhjZLkrdYtnZiDlSCPCWTZqRXv8MM7aSawUGIsrUJItVUKNDWvnL5AUZudg_dL1j
    Mp4_gaWlfOKbZLY>
X-ME-Received: <xmr:FlhjZPYrGFo_RZXb3MCeuSvLXtB3XHxLKfC0bFUiyOgUFI_uOUrv149M-lfhOo85I_eNKNIrjHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehledgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufhffjgfkfgggtgfgsehtqhdttddtreejnecuhfhrohhmpefpihhk
    ohhlrghushcutfgrthhhuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecuggftrf
    grthhtvghrnhepleffjefhgfffiedufeekvdeflefhheejjedugeejuefgleehvdejtdeg
    kedthfetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eppfhikhholhgruhhssehrrghthhdrohhrgh
X-ME-Proxy: <xmx:FlhjZOUndTP386Pp-imacI-8TEQASvCKye5O-jHAbpyhFXb0y9lSkQ>
    <xmx:FlhjZNl-GcSjZT13i157maFLz8gKWUq2OCW2LnUPWjoTHSh-0YCOhQ>
    <xmx:FlhjZLeUxAUIB0X6i8uX1Pa_DP-JLOwB5hdrktvryjEYcyQ4DBk_pw>
    <xmx:FlhjZHqkSBiAdvEYD5jScK9xxh-oFi51pbJzf3DzzMG0ZDv-tkQ-lQ>
Feedback-ID: i53a843ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 May 2023 06:16:53 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 84D35DBE;
        Tue, 16 May 2023 10:16:52 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id 6DBFAD131C; Tue, 16 May 2023 11:16:50 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Miklos Szeredi via fuse-devel <fuse-devel@lists.sourceforge.net>
Cc:     Paul Lawrence <paullawrence@google.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jens Axboe <axboe@kernel.dk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Peng Tao <bergwolf@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jann Horn <jannh@google.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>,
        Martijn Coenen <maco@android.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Stefano Duo <duostefano93@gmail.com>,
        David Anderson <dvander@google.com>,
        Akilesh Kailash <akailash@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        wuyan <wu-yan@tcl.com>, kernel-team <kernel-team@android.com>
Subject: Re: [fuse-devel] [PATCH RESEND V12 3/8] fuse: Definitions and ioctl
 for passthrough
References: <20210125153057.3623715-1-balsini@android.com>
        <20210125153057.3623715-4-balsini@android.com>
        <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com>
        <CA+a=Yy5=4SJJoDLOPCYDh-Egk8gTv0JgCU-w-AT+Hxhua3_B2w@mail.gmail.com>
        <CAJfpegtmXegm0FFxs-rs6UhJq4raktiyuzO483wRatj5HKZvYA@mail.gmail.com>
        <YD0evc676pdANlHQ@google.com>
        <CAOQ4uxjCT+gJVeMsnjyFZ9n6Z0+jZ6V4s_AtyPmHvBd52+zF7Q@mail.gmail.com>
        <CAJfpegsKJ38rmZT=VrOYPOZt4pRdQGjCFtM-TV+TRtcKS5WSDQ@mail.gmail.com>
        <CAOQ4uxg-r3Fy-pmFrA0L2iUbUVcPz6YZMGrAH2LO315aE-6DzA@mail.gmail.com>
        <CAJfpegvbMKadnsBZmEvZpCxeWaMEGDRiDBqEZqaBSXcWyPZnpA@mail.gmail.com>
        <CAOQ4uxgXhVOpF8NgAcJCeW67QMKBOytzMXwy-GjdmS=DGGZ0hA@mail.gmail.com>
        <CAOQ4uxg2k3DsTdiMKNm4ESZinjS513Pj2EeKGW4jQR_o5Mp3-Q@mail.gmail.com>
        <CAJfpegv1ByQg750uHTGOTZ7CJ4OrYp6i4MKXU13mwZPUEk+pnA@mail.gmail.com>
        <CAOQ4uxjrhf8D081Z8aG71=Kjjub28MwR3xsaAHD4cK48-FzjNA@mail.gmail.com>
        <87353xjqoj.fsf@vostro.rath.org>
        <93b77b5d-a1bc-7bb9-ffea-3876068bd369@fastmail.fm>
        <CAL=UVf78XujrotZnLjLcOYaaFHAjVEof-Qx_+peOtpdaRMoCow@mail.gmail.com>
        <CAJfpegv5haUDq=gMQZhpS0k8e4r_99Ms-ut8J+dyBm4Bo4OCwQ@mail.gmail.com>
Mail-Copies-To: never
Mail-Followup-To: Miklos Szeredi via fuse-devel
        <fuse-devel@lists.sourceforge.net>, Paul Lawrence
        <paullawrence@google.com>, Miklos Szeredi <miklos@szeredi.hu>, Jens
        Axboe <axboe@kernel.dk>, Giuseppe Scrivano <gscrivan@redhat.com>, Peng
        Tao <bergwolf@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Jann
        Horn <jannh@google.com>, Bernd Schubert <bernd.schubert@fastmail.fm>,
        Martijn Coenen <maco@android.com>, Zimuzo Ezeozue
        <zezeozue@google.com>, Palmer Dabbelt <palmer@dabbelt.com>, Stefano
        Duo <duostefano93@gmail.com>, David Anderson <dvander@google.com>,
        Akilesh Kailash <akailash@google.com>, "linux-fsdevel@vger.kernel.org"
        <linux-fsdevel@vger.kernel.org>, wuyan <wu-yan@tcl.com>, kernel-team
        <kernel-team@android.com>
Date:   Tue, 16 May 2023 11:16:50 +0100
In-Reply-To: <CAJfpegv5haUDq=gMQZhpS0k8e4r_99Ms-ut8J+dyBm4Bo4OCwQ@mail.gmail.com>
        (Miklos Szeredi via fuse-devel's message of "Tue, 16 May 2023 10:43:28
        +0200")
Message-ID: <87y1loinsd.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On May 16 2023, Miklos Szeredi via fuse-devel <fuse-devel@lists.sourceforge=
.net> wrote:
> On Mon, 15 May 2023 at 23:45, Paul Lawrence <paullawrence@google.com> wro=
te:
>>
>> On Mon, May 15, 2023 at 2:11=E2=80=AFPM Bernd Schubert
>> <bernd.schubert@fastmail.fm> wrote:
>> > On 5/15/23 22:16, Nikolaus Rath wrote:
>
>> > > One thing that struck me when we discussed FUSE-BPF at LSF was that =
from
>> > > a userspace point of view, FUSE-BPF presents an almost completely
>> > > different API than traditional FUSE (at least in its current form).
>> > >
>> > > As long as there is no support for falling back to standard FUSE
>> > > callbacks, using FUSE-BPF means that most of the existing API no lon=
ger
>> > > works, and instead there is a large new API surface that doesn't wor=
k in
>> > > standard FUSE (the pre-filter and post-filter callbacks for each
>> > > operation).
>> > >
>> > > I think this means that FUSE-BPF file systems won't work with FUSE, =
and
>> > > FUSE filesystems won't work with FUSE-BPF.
>> >
>> > Is that so? I think found some incompatibilities in the patches (need =
to
>> > double check), but doesn't it just do normal fuse operations and then
>> > replies with an ioctl to do passthrough? BPF is used for additional
>> > filtering, that would have to be done otherwise in userspace.
>
> I think Nikolaus' concern is that the BPF hooks add a major upgrade to
> the API, i.e. it looks very difficult to port a BPF based fs to
> non-BPF based fuse.  The new API should at least come with sufficient
> warnings about portability issues.
>
> I don't think the other direction has problems. The fuse API/ABI must
> remain backward compatible and old filesystems must be able to work
> after this feature is added.

I wouldn't say I'm concerned, it's more of an observation.

To me it seemed like we are combining two very different
approaches/interfaces in the same kernel module / userspace
library. This doesn't result in a compatibility problem, but it seems to
me that we could cleanly split this into two different components (that
may share code) with almost no API overlap.

But it seems I may have misunderstood some aspects about how the
fallback works. Let's wait for the FUSE-BPF patches and then revisit the
question :-).



Best,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F
