Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8772660BAE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jan 2023 02:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjAGB4j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 20:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjAGB4i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 20:56:38 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ACF6B5F9
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jan 2023 17:56:37 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id r205so2528203oib.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jan 2023 17:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9ykbBgKBZV6FU4/LOBwCWniqrM4IT15rEg/LDaszi0=;
        b=Hp7RDK1T4MTeLPWqoateGOJUUNQXKsaqDz53JVg8WmdPsfDAh7yOnQByCLm/cz69ao
         xujnVoSsVoSpwYTwojx8VRI6xyaRQO32MQ3MdWcCuWz0wUY8My1LjRJU4BgJ7L4LG0fB
         jCR5fPkFRpPWvzmGtqDF9m946/zeiPegD21MRirOZ/Qfnuw/hMeuhGNCHaT+i6bq5Rt5
         0Wy+BlUcdnv1+cXLmGWZOytIUH8X2P1U8xn4S/TZCdpH2VsuMF2/f+aSPt3LCpcMenDn
         3YF9kKedrkqXj70gUSYik3Cf+C2nwcqvUg0x1kOGsM/YFAEtEpQGwxdpuls0Q5cla1Z+
         ZZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9ykbBgKBZV6FU4/LOBwCWniqrM4IT15rEg/LDaszi0=;
        b=KaeAzFLvINZV2QPveke/TaHdwYel/shcpXiFR0S7DeTyqbLVXcWebjalzlVMSBjwOE
         EDViJgxOPjGCvRz/kra4Hx4EC5508iqKOTfvRZBOIMspC4J1MJWLQ7sgD3BiXzIdvQBN
         zer9NmjkAHZRP78TS1XxoYDD9rkDi667OB9F1RK6oahVcUn8vhkRAzioxvXOgc4VecV2
         +UDqzE31Cuf0TBv/KwaFmdYrbDPZAc2spF51UMY2yykD8m6RV9pCl2plRgOY2HSO8pjj
         RWRgz8VabT/M5PHouQpETLGKcX12K/ODyq81xLY8ZiqyIv2ZSIG+7domKkqEzS9nspWj
         lmKA==
X-Gm-Message-State: AFqh2krc56USqmLiyxuKhuZ5vWOXbzAUEA7aq7GAAH+bIR+ExX4xZjsn
        HTn1ZdlcEtYjpCTBqfk4rmB7cg==
X-Google-Smtp-Source: AMrXdXsX7/ocgMuBmhZAyTiWEsO26xIEVMPm87p+6teNszs25TWA/cRXzEPG3ohOcSqgH7/lPrPTRQ==
X-Received: by 2002:a05:6808:1414:b0:35e:d937:7d35 with SMTP id w20-20020a056808141400b0035ed9377d35mr35703216oiv.11.1673056596809;
        Fri, 06 Jan 2023 17:56:36 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id w18-20020a056830411200b00670747b88c9sm1287038ott.39.2023.01.06.17.56.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jan 2023 17:56:36 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [External] [LSF/MM/BPF BoF] Session for Zoned Storage 2023
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <4CC4F55E-17B3-47E2-A8C5-9098CCEB65D6@dubeyko.com>
Date:   Fri, 6 Jan 2023 17:56:24 -0800
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        lsf-pc@lists.linux-foundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5DF10459-88F3-48DA-AEB2-5B436549A194@bytedance.com>
References: <F6BF25E2-FF26-48F2-8378-3CB36E362313@dubeyko.com>
 <Y7h0F0w06cNM89hO@bombadil.infradead.org>
 <4CC4F55E-17B3-47E2-A8C5-9098CCEB65D6@dubeyko.com>
To:     Viacheslav Dubeyko <slava@dubeyko.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jan 6, 2023, at 11:30 AM, Viacheslav Dubeyko <slava@dubeyko.com> =
wrote:
>=20
>=20
>=20
>> On Jan 6, 2023, at 11:18 AM, Luis Chamberlain <mcgrof@kernel.org> =
wrote:
>>=20
>> On Fri, Jan 06, 2023 at 11:17:19AM -0800, Viacheslav Dubeyko wrote:
>>> Hello,
>>>=20
>>> As far as I can see, I have two topics for discussion.
>>=20
>> What's that?
>=20
> I am going to share these topics in separate emails. :)
>=20
> (1) I am going to share SSDFS patchset soon. And topic is:
> SSDFS + ZNS SSD: deterministic architecture decreasing TCO cost of =
data infrastructure.
>=20
> (2) Second topic is:
> How to achieve better lifetime and performance of caching layer with =
ZNS SSD?
>=20

I think we can consider such discussions:
(1) I assume that we still need to discuss PO2 zone sizes?
(2) Status of ZNS SSD support in F2FS, btrfs (maybe, bcachefs and other =
file systems)
(3) Any news from ZoneFS (+ ZenFS maybe)?
(4) New ZNS standard features that we need to support on block layer + =
FS levels?
(5) ZNS drive emulation + additional testing features?
(6) ZNS + computational drive? What new features would we like to see =
from ZNS SSD?
(7) ZNS + CXL: does it make sense?

Thanks,
Slava



