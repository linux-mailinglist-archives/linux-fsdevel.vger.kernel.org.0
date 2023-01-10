Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14F96636CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 02:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbjAJBkn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 20:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjAJBkU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 20:40:20 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF3A3C380
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 17:40:10 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-12c8312131fso10771270fac.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Jan 2023 17:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vo1e4WWMG0A+UpXNNq0JvhgPHSnNnupFRrUwtyDiEi8=;
        b=UVFtu729mVqGxLV9fgWbAgdeKymaXIXXaTe+t+mtZ6RJ5fKXI93ef8NdiulzsB+63q
         uIM3miO59Ubsi321YvyrJJwJK1f/WLy8CcblapK8wcKcXB1wAlboAeEGR3AGvsHiEqhn
         KrFniy1dOgycS207g/2DU1QxADZ+RPBtTXVt1UROtyjpwAoxqNnyj/ugK8DW4Sg6LFy5
         NW3+eztLkFDESMNhMPt/AYEmkNnkv5vGf+rbkQEJtKXY7/7JUoxr+Kmpf3tGmZJBuxBu
         iNetOy/UpWT/gaqjHyvZNftP0XG1kiBUjwmFMJZtLZNjwPGcNn2JLxf70VfptTkvJc3z
         pFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vo1e4WWMG0A+UpXNNq0JvhgPHSnNnupFRrUwtyDiEi8=;
        b=2cNmTVJbU6gNTBPhrwtzt9cuf6C8S2eFsNA0NBW2HP4wccyrz6b9lJMGE1TS8vbLQ/
         OiUWObdLDVuPPX22YrF/l3NlyJ2lzW70Y4+PHWgtbEZrSX8RD3W0GdwOhoF4LKwfee/w
         KzbYyD7scS8ZKLhEtzeJ87OKa3xIkkaXY3tbArK87ig/WzBFWsBpzYDH/mvqiYKtDqaC
         zr3rjj/qLTs9I5wcU8S3vatiOpi554Qp22xFUxea6gAST1YCvy0lTu6viJ+A64TuD6i7
         vsslYcjMeJUUfbX/E1R0M66KV/xsQe7EQ8nqeyTfsoMccH7/eJ/U+sq7U3mrMJsMH9Ge
         rshg==
X-Gm-Message-State: AFqh2kqydq8Bs9Ys/mWoysj9bNGgwfu6nEO/HdiO3PJnGedPv4BhIx4f
        M6bhOzadMyAtE3Mua23Y7YUUtdEBFOEolWUT
X-Google-Smtp-Source: AMrXdXv11hD6h514xocgmuNbpwdwVEaqCmSQ20fkSOuCjdQWqCcgpIsSP+dLtDehzf73vXScxO1wQg==
X-Received: by 2002:a05:6871:a186:b0:14f:e2b7:242d with SMTP id vt6-20020a056871a18600b0014fe2b7242dmr24041224oab.17.1673314809346;
        Mon, 09 Jan 2023 17:40:09 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id i8-20020a056871028800b0014c83629498sm5100802oae.43.2023.01.09.17.40.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jan 2023 17:40:09 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [External] [LSF/MM/BPF BoF] Session for Zoned Storage 2023
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <e4a972f4-50fd-4c0e-1b44-dc702fd9c445@kernel.dk>
Date:   Mon, 9 Jan 2023 17:39:57 -0800
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        lsf-pc@lists.linux-foundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B512D508-4460-44B8-9067-84F78BA43E0E@bytedance.com>
References: <F6BF25E2-FF26-48F2-8378-3CB36E362313@dubeyko.com>
 <Y7h0F0w06cNM89hO@bombadil.infradead.org>
 <4CC4F55E-17B3-47E2-A8C5-9098CCEB65D6@dubeyko.com>
 <CGME20230107015641eucas1p13c2b37b5ca7a5b64eb520b79316d5186@eucas1p1.samsung.com>
 <5DF10459-88F3-48DA-AEB2-5B436549A194@bytedance.com>
 <20230109153315.waqfokse4srv6xlz@mpHalley-2.localdomain>
 <AF3750AD-1B66-4F8A-936F-A14EC17DAC16@bytedance.com>
 <04cc803e-0246-bf8a-c083-f556a373ae4f@opensource.wdc.com>
 <ca30360e-ab51-6282-bd3c-208399e5a552@kernel.dk>
 <E2BA234A-D3D3-440B-BBDB-230B772B2D01@bytedance.com>
 <e4a972f4-50fd-4c0e-1b44-dc702fd9c445@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jan 9, 2023, at 5:09 PM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 1/9/23 4:20?PM, Viacheslav A.Dubeyko wrote:
>>=20
>>=20
>>> On Jan 9, 2023, at 3:00 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>>=20
>>>>> My point here that we could summarize:
>>>>> (1) what features already implemented and supported,
>>>>> (2) what features are under implementation and what is progress,
>>>>> (3) what features need to be implemented yet.
>>>>>=20
>>>>> Have we implemented everything already? :)
>>>>=20
>>>> Standards are full of features that are not useful in a general =
purpose
>>>> system. So we likely never will implement everything. We never did =
for
>>>> SCSI and ATA and never will either.
>>> Indeed, and that's a very important point. Some people read specs =
and
>>> find things that aren't in the Linux driver (any spec, not a =
specific
>>> one), and think they need to be added. No. We only add them if they =
make
>>> sense, both in terms of use cases, but also as long as they can get
>>> implemented cleanly. Parts of basically any spec is garbage and =
don't
>>> necessarily fit within the given subsystem either.
>>>=20
>>> The above would make me worried about patches coming from anyone =
with
>>> that mindset.
>>>=20
>>=20
>> OK. We already have discussion about garbage in spec. :)
>> So, what would we like finally implement and what never makes sense =
to do?
>> Should we identify really important stuff for implementation?
>=20
> Well if you did have that discussion, then it seemed you got nothing
> from it. Because asking that kind of question is EXACTLY what I'm =
saying
> is the opposite of what should be done. If there's a demand for a
> feature, then it can be looked at and ultimately implemented if it =
makes
> sense. You're still talking about proactively finding features and
> implementing them "just in case they are needed", which is very much =
the
> opposite and wrong approach, and how any kind of software ends up =
being
> bloated, slow, and buggy/useless.
>=20

I simply tried to suggest some space for this discussion and nothing =
more.
If all important features have been implemented already and nobody would
like to discuss new feature(s), then we can simply exclude this topic =
from the list.

If you would like to say that I am a reason of slow software, then I =
take this credit. :)

Thanks,
Slava.

