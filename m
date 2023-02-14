Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE20D696A64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 17:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjBNQxv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 11:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjBNQxu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:53:50 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C687727D7C;
        Tue, 14 Feb 2023 08:53:48 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A20B35C0178;
        Tue, 14 Feb 2023 11:53:44 -0500 (EST)
Received: from imap45 ([10.202.2.95])
  by compute3.internal (MEProxy); Tue, 14 Feb 2023 11:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1676393624; x=
        1676480024; bh=iWRZ71muFH5nPOBHkd4LTGSf+xAdZhitSiFH+zzKi10=; b=N
        01jp7DSdkTr1oqYNSRd9ds8gv3S3zV7CL7GZwJQV1tkd3Cl2B7TPzJFmQtviJ/ZY
        nNnZ/RUj2HqF+rkMlnJubLYlYg/XipJKgqn+wLGhQXqHkJpZKL5uSol063Pya8KA
        tHSiA08Idp51+IFPAMPl4/t7tr3jcY3Hns6svcK0ZAp+k5Kgwd+GeOOTZH1pG1jQ
        DohnGUHUh5Y3IjNRj2x/coKnJDFL/QC0O0j9R3bhhSvdTUrM1OtYUQ5RWWlI3Qtn
        RkhYtpoXjYtktOYCRki0d5+IMjPVdhFDAp35TdXrgQavkKbrRswTTWKXGoMDoFHs
        XO//0XQM2TUbph1LdtNuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676393624; x=
        1676480024; bh=iWRZ71muFH5nPOBHkd4LTGSf+xAdZhitSiFH+zzKi10=; b=M
        3GEHH+nl2rXpyAvrfvLeSYHfA1jLsLc7l5E0Lzi1v8ECVKkoCCRarrZhl02/hVUW
        3dyodFJMDhG2pW3L/NzMd8zk6hQIa3LthPn2Ax6dgwc/8zBC0xNpsDp9xjkHXcLA
        HNCw7cxM9trifld9LXPYXj+G5qNIfAEzYhLmbZdmTRU6mTzAVXvLCjNHBJSDp+LB
        Q2RI9SprPF1Qy/WNgBUuU4tMLMoW0ZMF7B/h/U5HAYLYFtb/kSLRMlw5ukiJHG5P
        4WYtaOLk8WlxhiPt+rvUpCV+i0EkKS2Oj87a0zS8+5HZR+rIhM4H5WR+B7fp6Ihl
        EZ5e8MwTWvIFIxeVOGUmw==
X-ME-Sender: <xms:mLzrY3g_vd82jtKIn7_GdnQnG70OJhGMr77JVB5015O1QiVmmSEYcg>
    <xme:mLzrY0DyLyVzlB_akk1kn59nO-2BjPkFO6rwZBTLIDWgJ4OTeFNMxoV7izWIgUwtV
    2TcYBKKVjbDI7Sf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeifedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfp
    ihhkohhlrghushcutfgrthhhfdcuoehnihhkohhlrghushesrhgrthhhrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeegudeihffggefglefgveevkedtlefhudeiveeikeeijedvkefg
    kedtfeejvedujeenucffohhmrghinheplhhinhhugihfohhunhgurghtihhonhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhk
    ohhlrghushesrhgrthhhrdhorhhg
X-ME-Proxy: <xmx:mLzrY3H9b7OSRrzt3ZzZ7Zz2tDYTrZFlgeAIsiJP9tycbyXGJDYSuA>
    <xmx:mLzrY0TbcetEoJCs3K6_noj-VhydyD2XY75Km_A1JH7HUrnTkkQZCw>
    <xmx:mLzrY0w4beFR1ztqUj42szQQtr80P3ko5qjSY_dQxO-V0TyD9NlssA>
    <xmx:mLzrY5p1AqqZD0JhDdNVrv5C52-slrteYqRB8gM3JF6vajV2m5ZqoA>
Feedback-ID: i53a843ae:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4AEB1272007A; Tue, 14 Feb 2023 11:53:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <56d5ac0e-4c54-46b7-85d3-5de127562630@app.fastmail.com>
In-Reply-To: <CAJfpegsocoi-KobnSpD9dHvZDeDwG+ZPKRV9Yo-4i8utZa5Jww@mail.gmail.com>
References: <20221122021536.1629178-1-drosen@google.com>
 <CAOQ4uxiyRxsZjkku_V2dBMvh1AGiKQx-iPjsD5tmGPv1PgJHvQ@mail.gmail.com>
 <CA+PiJmRLTXfjJmgJm9VRBQeLVkWgaqSq0RMrRY1Vj7q6pV+omw@mail.gmail.com>
 <2dc5e840-0ce8-dae9-99b9-e33d6ccbb016@fastmail.fm>
 <CAOQ4uxiBD5NXLMXFev7vsCLU5-_o8-_H-XcoMY1aqhOwnADo9w@mail.gmail.com>
 <283b5344-3ef5-7799-e243-13c707388cd8@fastmail.fm>
 <CAOQ4uxjvUukDSBk977csO5cX=-1HiMHmyQxycbYQgrpLaanddw@mail.gmail.com>
 <CAJfpegvHKkCn0UnNRVxFXjjnkOuq0N4xLN4WzpqVX+56DqdjUw@mail.gmail.com>
 <81e010cc-b52b-4b20-8d08-631ce8ca7fad@app.fastmail.com>
 <CAJfpegsocoi-KobnSpD9dHvZDeDwG+ZPKRV9Yo-4i8utZa5Jww@mail.gmail.com>
Date:   Tue, 14 Feb 2023 16:53:09 +0000
From:   "Nikolaus Rath" <nikolaus@rath.org>
To:     "Miklos Szeredi" <miklos@szeredi.hu>
Cc:     "Amir Goldstein" <amir73il@gmail.com>,
        "Bernd Schubert" <bernd.schubert@fastmail.fm>,
        "Daniel Rosenberg" <drosen@google.com>,
        "Linux FS Devel" <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@android.com>,
        "Vivek Goyal" <vgoyal@redhat.com>,
        "Josef Bacik" <josef@toxicpanda.com>
Subject: Attending LFS (was: [RFC PATCH v2 00/21] FUSE BPF: A Stacked Filesystem
 Extension for FUSE)
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

I've looked into this in more detail. =20

I wouldn't be able to get the travel funded by my employer, and I don't =
think I'm a suitable recipient for the Linux Foundation's travel fund. T=
herefore, I think it would make more sense for me to attend potentially =
relevant sessions remotely.

If there's anything I need to do for that, please let me know. Otherwise=
 I'll assume that at some point I'll get a meeting invite from someone :=
-).

If there's a way to schedule these sessions in a Europe-friendly time th=
at would be much appreciated!

Best,
-Nikolaus

--
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=AB

On Fri, 10 Feb 2023, at 10:53, Miklos Szeredi wrote:
> On Fri, 10 Feb 2023 at 10:42, Nikolaus Rath <nikolaus@rath.org> wrote:
>>
>> On Fri, 10 Feb 2023, at 09:38, Miklos Szeredi wrote:
>> > On Fri, 3 Feb 2023 at 12:43, Amir Goldstein <amir73il@gmail.com> wr=
ote:
>> >
>> >> > Thanks a lot Amir, I'm going to send out an invitation tomorrow.=
 Maybe
>> >> > Nikolaus as libfuse maintainer could also attend?
>> >> >
>> >>
>> >> Since this summit is about kernel filesystem development, I am not=
 sure
>> >> on-prem attendance will be the best option for Nikolaus as we do h=
ave
>> >> a quota for
>> >> on-prem attendees, but we should have an option for connecting spe=
cific
>> >> attendees remotely for specific sessions, so that could be great.
>> >
>> > Not sure.  I think including non-kernel people might be beneficial =
to
>> > the whole fs development community.  Not saying LSF is the best pla=
ce,
>> > but it's certainly a possibility.
>> >
>> > Nikolaus, I don't even know where you're located.  Do you think it
>> > would make sense for you to attend?
>>
>> Hi folks,
>>
>> I'm located in London.
>>
>> I've never been at LHS, so it's hard for me to tell if I'd be useful =
there or not. If there's interest, then I would make an effort to attend.
>>
>> Are we talking about the event in Vancouver on May 8th?
>
> Yes, that's the one.
>
> I'd certainly think it would be useful, since there will be people
> with interest in fuse filesystems and hashing out the development
> direction involves libfuse as well.
>
> Here's the CFP and attendance request if you are interested:
>
>   https://events.linuxfoundation.org/lsfmm/program/cfp/
>
> Thanks,
> Miklos
