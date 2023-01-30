Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D70680C1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 12:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbjA3LkO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 06:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjA3LkN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:40:13 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7971D2CC40
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 03:40:11 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cw4so5508892edb.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 03:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+z1TZ5dWKjmwb0nA4mLgax3nVn5AMhKS52rfwSoYsO0=;
        b=Kn5q5DB2IfPtw8RorarLuCa+SXt/43r8YhtaxYLWWICs9C5gaM+eF9cMKX6mzj7wG6
         WbPn/Bug3VqVrSMyv0gS6Xvskmxf+f3TeT4RVJ2GQX90A9S9NQ/1lmFAfCsE8nEEcOC/
         7VjlAHLsvib4VQ2ihT885de2pBHMxiv9xBWODdm/R9WTyh1YmiR7FyHeM0c4/2k93FRq
         cKcV8Jo3IJotlNKFEZNUfejozycxjfmc/Mq5d+Eag90ADgVDAKun17xrwZy8VbQs7Y6O
         90hauU5u/No7ySx+rSeFx0j6gLwhblzm3jYsqxIU6bX1R85SoxjfZe7hr/GmOu+/KDqe
         8q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+z1TZ5dWKjmwb0nA4mLgax3nVn5AMhKS52rfwSoYsO0=;
        b=qpdKymhrsKM2MrZPGal9h0Tlzr8VPZgfZJzepH9KeM4+RfYbh3eKsV1AqZdt1wjNIU
         8Du9l6XV8pdH893o7OcjxwKAvYXGxora06oqIaA+JcVKRjxtXcRZ8mTft1aW/ORXTxDh
         yhCQl0AJqlzTUXtCSWbQNa6amw3ps4Q5qLXKwnhkBXbW83Veo1UJuRuse9HkVbqDct8M
         JQ08WrXuADw6fOdpnvbR51LB6oRITJb/Ekf488B4IStl/xzKy1Iezsiztk6Ue6mVFY/O
         HvvTK6s158YHKZfInPVJduKv5/ptl2rEsQbZZPAGMXrcYubArTNUK1+dnR16ak8+FY3A
         Cgqw==
X-Gm-Message-State: AFqh2krwsAlZiedbBBpTj4s37Ky5i7bV9pM5KraMP/S7eK/EdEYS1LGf
        I3mixgj5g59VKg/wWcUT1l9VXOH3iRiAM6as
X-Google-Smtp-Source: AMrXdXsOoCDY3AFTbZkVVxZNV7DNVyTnQe5kZmjTZzQctK+rrRccUH451GKzCDJury4bqU0zvXB6sQ==
X-Received: by 2002:a05:6402:2990:b0:499:8849:5fb8 with SMTP id eq16-20020a056402299000b0049988495fb8mr54662401edb.30.1675078810007;
        Mon, 30 Jan 2023 03:40:10 -0800 (PST)
Received: from localhost ([194.62.217.4])
        by smtp.gmail.com with ESMTPSA id g5-20020a50ee05000000b004835bd8dfe5sm6744664eds.35.2023.01.30.03.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 03:40:09 -0800 (PST)
References: <F6BF25E2-FF26-48F2-8378-3CB36E362313@dubeyko.com>
 <Y7h0F0w06cNM89hO@bombadil.infradead.org>
 <4CC4F55E-17B3-47E2-A8C5-9098CCEB65D6@dubeyko.com>
 <5DF10459-88F3-48DA-AEB2-5B436549A194@bytedance.com>
 <Y9UIPsp479CysMmX@T590>
 <BN8PR04MB64170AF4B399B6A3E26BAAC6F1D39@BN8PR04MB6417.namprd04.prod.outlook.com>
User-agent: mu4e 1.8.13; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Matias =?utf-8?Q?Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Javier =?utf-8?Q?Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [External] [LSF/MM/BPF BoF] Session for Zoned Storage 2023
Date:   Mon, 30 Jan 2023 12:24:20 +0100
In-reply-to: <BN8PR04MB64170AF4B399B6A3E26BAAC6F1D39@BN8PR04MB6417.namprd04.prod.outlook.com>
Message-ID: <87pmawuu7b.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Ming, Matias,

Matias Bj=C3=B8rling <Matias.Bjorling@wdc.com> writes:

<snip>

>> >
>> > I think we can consider such discussions:
>> > (1) I assume that we still need to discuss PO2 zone sizes?
>> > (2) Status of ZNS SSD support in F2FS, btrfs (maybe, bcachefs and
>> > other file systems)
>> > (3) Any news from ZoneFS (+ ZenFS maybe)?
>> > (4) New ZNS standard features that we need to support on block layer +=
 FS
>> levels?
>> > (5) ZNS drive emulation + additional testing features?
>>=20
>> ZNS drive emulation can be done as one ublk target(userspace implementat=
ion
>> with ublk driver extension), and it was discussed before:
>>=20
>> https://github.com/ming1/ubdsrv/pull/28
>>=20
>>=20
>> Thanks,
>> Ming
>
> Hi Ming,=20
>
> Andreas recently transitioned from WD to another company. I am not sure i=
f he'll continue this specific work, if he isn=E2=80=99t, my team will pick=
 it up. It already looks very promising.
>
> Thanks, Matias

I joined Samsung recently, and I plan to continue the work on adding
zoned storage support to ublk in that context.

I will send the patches to the relevant lists when they get further
along. I hope your team will evaluate and provide feedback Matias :)

Best regards,
Andreas

