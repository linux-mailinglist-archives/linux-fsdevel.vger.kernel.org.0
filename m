Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEA9703E70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 22:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245296AbjEOUSL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 16:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245287AbjEOUSK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 16:18:10 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B15083F5
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 13:17:38 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5F1385C0078;
        Mon, 15 May 2023 16:16:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 15 May 2023 16:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1684181808; x=1684268208; bh=pQT0ocGBIE4BN6uIPNwuxYxnjGLsrtMPQ2t
        DqN/xvnY=; b=DnU0FHmr5EhTxoPttUbw5k/oeqFXPW3FvwiysK1dcLVNsbW/xut
        XIhdBBeZa2YecTJm2ThI9mmSuhBl9nW4lJJFpNwvdhcd+OkLaPOtssEpHdtrv0Xh
        UZ6uMieb0wX0YYJtyzApCLYP0xvs6bvDyNhFrAUV+TqKt5UuPh22X+0JSQ9CSbh5
        euviV5i8TlAxUOzUXm+sWYyNF8XMs2CZOBD2EBmo6WBybLem3kRx1zbqmN81+v9B
        USPv8XKjOJnN5/9yTuC+Tm3JjTBBNnpJwlhi/uITVGXW6kG/cWcYgc9AVcd1eo/2
        kklujPl6PJ+UiSz7dkCMGQOiKzKKpF+mEAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684181808; x=1684268208; bh=pQT0ocGBIE4BN6uIPNwuxYxnjGLsrtMPQ2t
        DqN/xvnY=; b=nHpKzrZFuACoeQN3wM/HOTFljyJZo9SEKu8ekR4iY/0RNFFQyfX
        VGdwzN/GSU5V6tvx+Lwvyqds+i2VjwhphnBMBz0odiYftSWEtjVH5x52JKziIUS0
        OA4rb8LzsRp1WO5UkgOfVMVLPy61AA8sdBqkEsyj3vRDHeGgqqgKMClBT1gYFoeP
        y7jbl7uls/ilqW4/RPag21BxM1WaEmHC2ByGYOapcv8WQBxQy8bij7HKsoTrm92t
        7gix24Nlkfz6xQR9TjKnaBjNEmlLkpau99sdsZ1FFv55g8KChS9UXh5RoV1vcozj
        Ltw9cN17PPBQ4CU9eDh7/Ite8cM+ygRycRw==
X-ME-Sender: <xms:L5NiZEpz4Xlhx5q_slnRfV9Vnsbg4BGyCEKtwdPedM2wsyyluT4GBQ>
    <xme:L5NiZKquwC7ZKqPEqGUwNBBn8__DmJu83SsUceNKVCyKDHov5pTFFtIBBuCptp9Al
    yO-jXSV89iFln1b>
X-ME-Received: <xmr:L5NiZJNyD20ahurZPuIj9DOh3eWOSwlIn5QZUymGUXu3APqJqEBsIp0QkqD26UlQiGNpCBGUSkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehjedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufhfffgjkfgfgggtgfesthhqtddttderjeenucfhrhhomheppfhi
    khholhgruhhsucftrghthhcuoefpihhkohhlrghushesrhgrthhhrdhorhhgqeenucggtf
    frrghtthgvrhhnpeelffejhffgffeiudefkedvfeelhfehjeejudegjeeugfelhedvjedt
    geektdfhteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpefpihhkohhlrghushesrhgrthhhrdhorhhg
X-ME-Proxy: <xmx:L5NiZL5G667SKbPlGp3B8ULNdrss_UqPvoH6iahyeoklzjSJo5cTjQ>
    <xmx:L5NiZD6XJxODn4DEm-9IF0vPOoT_HTZw_WLj7ovGZcMWHp2G-J381g>
    <xmx:L5NiZLi1y2v4CrMpIwMvUyiiEt_2-zcsqmeZFDiukXmLATeRbU2tEA>
    <xmx:MJNiZAx8PKoDgpZXg61gN9l3T5EzrKj-6mcc10apXqMsEtKIwPPCPQ>
Feedback-ID: i53a843ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 May 2023 16:16:47 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 529E25C5;
        Mon, 15 May 2023 20:16:45 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id 8DC05D028C; Mon, 15 May 2023 21:16:44 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Jens Axboe <axboe@kernel.dk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jann Horn <jannh@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        kernel-team <kernel-team@android.com>,
        Peng Tao <bergwolf@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Stefano Duo <duostefano93@gmail.com>,
        David Anderson <dvander@google.com>, wuyan <wu-yan@tcl.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Akilesh Kailash <akailash@google.com>,
        Martijn Coenen <maco@android.com>
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
Mail-Copies-To: never
Mail-Followup-To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi
        <miklos@szeredi.hu>, Jens Axboe <axboe@kernel.dk>, Giuseppe Scrivano
        <gscrivan@redhat.com>, fuse-devel <fuse-devel@lists.sourceforge.net>,
        Daniel Borkmann <daniel@iogearbox.net>, Jann Horn <jannh@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team
        <kernel-team@android.com>, Peng Tao <bergwolf@gmail.com>, Palmer
        Dabbelt <palmer@dabbelt.com>, Stefano Duo <duostefano93@gmail.com>,
        David Anderson <dvander@google.com>, wuyan <wu-yan@tcl.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Akilesh Kailash <akailash@google.com>, Martijn Coenen
        <maco@android.com>
Date:   Mon, 15 May 2023 21:16:44 +0100
In-Reply-To: <CAOQ4uxjrhf8D081Z8aG71=Kjjub28MwR3xsaAHD4cK48-FzjNA@mail.gmail.com>
        (Amir Goldstein's message of "Mon, 15 May 2023 17:00:16 +0300")
Message-ID: <87353xjqoj.fsf@vostro.rath.org>
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

On May 15 2023, Amir Goldstein <amir73il@gmail.com> wrote:
> On Mon, May 15, 2023 at 10:29=E2=80=AFAM Miklos Szeredi <miklos@szeredi.h=
u> wrote:
>> On Fri, 12 May 2023 at 21:37, Amir Goldstein <amir73il@gmail.com> wrote:
>>
>> > I was waiting for LSFMM to see if and how FUSE-BPF intends to
>> > address the highest value use case of read/write passthrough.
>> >
>> > From what I've seen, you are still taking a very broad approach of
>> > all-or-nothing which still has a lot of core design issues to address,
>> > while these old patches already address the most important use case
>> > of read/write passthrough of fd without any of the core issues
>> > (credentials, hidden fds).
>> >
>> > As far as I can tell, this old implementation is mostly independent of=
 your
>> > lookup based approach - they share the low level read/write passthrough
>> > functions but not much more than that, so merging them should not be
>> > a blocker to your efforts in the longer run.
>> > Please correct me if I am wrong.
>> >
>> > As things stand, I intend to re-post these old patches with mandatory
>> > FOPEN_PASSTHROUGH_AUTOCLOSE to eliminate the open
>> > questions about managing mappings.
>> >
>> > Miklos, please stop me if I missed something and if you do not
>> > think that these two approaches are independent.
>>
>> Do you mean that the BPF patches should use their own passthrough mechan=
ism?
>>
>> I think it would be better if we could agree on a common interface for
>> passthough (or per Paul's suggestion: backing) mechanism.
>
> Well, not exactly different.
> With BFP patches, if you have a backing inode that was established during
> LOOKUP with rules to do passthrough for open(), you'd get a backing file =
and
> that backing file would be used to passthrough read/write.
>
> FOPEN_PASSTHROUGH is another way to configure passthrough read/write
> to a backing file that is controlled by the server per open fd instead of=
 by BFP
> for every open of the backing inode.
>
> Obviously, both methods would use the same backing_file field and
> same read/write passthrough methods regardless of how the backing file
> was setup.
>
> Obviously, the BFP patches will not use the same ioctl to setup passthrou=
gh
> (and/or BPF program) to a backing inode, but I don't think that matters m=
uch.
> When we settle on ioctls for setting up backing inodes, we can also add n=
ew
> ioctls for setting up backing file with optional BPF program.

> I don't see any reason to make the first ioctl more complicated than this:
>
> struct fuse_passthrough_out {
>         uint32_t        fd;
>         /* For future implementation */
>         uint32_t        len;
>         void            *vec;
> };
>
> One advantage with starting with FOPEN_PASSTHROUGH, besides
> dealing with the highest priority performance issue, is how it deals with
> resource limits on open files.

One thing that struck me when we discussed FUSE-BPF at LSF was that from
a userspace point of view, FUSE-BPF presents an almost completely
different API than traditional FUSE (at least in its current form).

As long as there is no support for falling back to standard FUSE
callbacks, using FUSE-BPF means that most of the existing API no longer
works, and instead there is a large new API surface that doesn't work in
standard FUSE (the pre-filter and post-filter callbacks for each
operation).

I think this means that FUSE-BPF file systems won't work with FUSE, and
FUSE filesystems won't work with FUSE-BPF.

Would it be worth thinking about FUSE-BPF as a completely separate
approach that stands next to FUSE, as opposed to considering it an
extension?

In that case, we wouldn't need to worry about a FUSE-passthrough
implementation being forward compatible with FUSE-BPF or not.



Best,
-Nikolaus


--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F
