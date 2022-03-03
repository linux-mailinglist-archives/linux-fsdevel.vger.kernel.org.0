Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD1D4CC79E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 22:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbiCCVJi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 16:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiCCVJg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 16:09:36 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680B2DE2CC
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Mar 2022 13:08:50 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g20so8268768edw.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Mar 2022 13:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=PZ3qH7MSbcAoK3FAxg/4KuZZGhbpGE4nxaY+vX8catw=;
        b=iCyWf+R2uongqpZcOk3Xez8hmW8VSyyl0NXF0vjALeB6q+XBzAM3F7S7VKfpxCgLBg
         tutsHfZG7OvUMimiS9cUxGsjz/3hbboLU8h1PrM0YfkNSXu/GUZemn/RTGrRQ6Gwu9to
         A9RP/ceUXz/Um0sfKi93cdtsAiLCVDtSeqlmN+EHVx1IvPslc7axdYDSHWE1bEhKYmMX
         dkXobpqMlZQvGVoibbuiyI6z1tnZ12+/cIYl9My7d7sXvbgjWgFJmQH0UvelqxgCwBuK
         MYunEPm9w5/BoCHs9/Y+q9AvYaAGoiJluYCftgu92v1egN91TT4vrvlEDr5+OTPYff4+
         +7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=PZ3qH7MSbcAoK3FAxg/4KuZZGhbpGE4nxaY+vX8catw=;
        b=ra5Yx2LuJn+XdjpBDifMBorYYHZjSHe0N+9/zVGSI+u09we+JczZcx5x+7oQjvJqpI
         9TDq6R+Ikv/LkjDNBKsvHYd/sSoWWoSpJ64EKRJcwTLQFEb5srJAxduZGh9e24Ca3QK+
         QsLyshRODFmprY0u2IbjXwJy5ijxYesJnwThiMiMre0E1TyCCrOtdT8u7uA3NeIKC020
         9MGlMBP8A21QeL+cZ67UipbEwOpoqWY0ZMOY68aezxkb09XDVFRdvRphanz2mHUrekbv
         szhgX+Qb7UrO/g5sxMYe4CIyC3T2cyn1e/uw7myZpFyBjJAe4iOEw3SdiWoH0pMcqq9C
         TcTQ==
X-Gm-Message-State: AOAM533vvZsy+WojQw1yyKKi4ygVHOwF4hskuE3Gj315A2OVm5S1CyVO
        XqMHNY9+kvrrT0IyNAZX/sz2UA==
X-Google-Smtp-Source: ABdhPJz/d6L5ep+A8yHyDMjVnyUxv3WmiFO0CwUUPMKxal0ZtR803qeEjeuR0gXstZ+G/Zgk6DIXfg==
X-Received: by 2002:a05:6402:35d1:b0:412:b3df:a6d3 with SMTP id z17-20020a05640235d100b00412b3dfa6d3mr35662436edc.151.1646341728890;
        Thu, 03 Mar 2022 13:08:48 -0800 (PST)
Received: from smtpclient.apple (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
        by smtp.gmail.com with ESMTPSA id z15-20020a170906240f00b006d703ca573fsm1064600eja.85.2022.03.03.13.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 13:08:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Date:   Thu, 3 Mar 2022 22:08:47 +0100
Message-Id: <9151CBBD-F5A2-40F3-8864-11E771A8D562@javigon.com>
References: <20220303201831.GC11082@bgt-140510-bm01>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <keith.busch@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
In-Reply-To: <20220303201831.GC11082@bgt-140510-bm01>
To:     Adam Manzanares <a.manzanares@samsung.com>
X-Mailer: iPhone Mail (19D52)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On 3 Mar 2022, at 21.18, Adam Manzanares <a.manzanares@samsung.com> wrote:=

>=20
> =EF=BB=BFOn Thu, Mar 03, 2022 at 07:51:36PM +0000, Matias Bj=C3=B8rling wr=
ote:
>>> Sounds like you voluntered to teach zoned storage use 101. Can you teach=
 me
>>> how to calculate an LBA offset given a zone number when zone capacity is=
 not
>>> equal to zone size?
>>=20
>> zonesize_pow =3D x; // e.g., x =3D 32 if 2GiB Zone size /w 512B block siz=
e
>> zone_id =3D y; // valid zone id
>>=20
>> struct blk_zone zone =3D zones[zone_id]; // zones is a linear array of bl=
k_zone structs that holds per zone information.
>>=20
>> With that, one can do the following
>> 1a) first_lba_of_zone =3D  zone_id << zonesize_pow;
>> 1b) first_lba_of_zone =3D zone.start;
>=20
> 1b is interesting. What happens if i don't have struct blk_zone and zone s=
ize=20
> is not equal to zone capacity?
>=20
>> 2a) next_writeable_lba =3D (zoneid << zonesize_pow) + zone.wp;
>> 2b) next_writeable_lba =3D zone.start + zone.wp;
>=20
> Can we modify 2b to not use zone.start?
>=20
>> 3)   writeable_lbas_left =3D zone.len - zone.wp;
>> 4)   lbas_written =3D zone.wp - 1;
>>=20
>>> The second thing I would like to know is what happens when an applicatio=
n
>>> wants to map an object that spans multiple consecutive zones. Does the
>>> application have to be aware of the difference in zone capacity and zone=
 size?
>>=20
>> The zoned namespace command set specification does not allow variable zon=
e size. The zone size is fixed for all zones in a namespace. Only the zone c=
apacity has the capability to be variable. Usually, the zone capacity is fix=
ed, I have not yet seen implementations that have variable zone capacities.
>>=20
>=20
> IDK where variable zone size came from. I am talking about the fact that t=
he=20
> zone size does not have to equal zone capacity.=20
>=20
>> An application that wants to place a single object across a set of zones w=
ould have to be explicitly handled by the application. E.g., as well as the a=
pplication, should be aware of a zone's capacity, it should also be aware th=
at it should reset the set of zones and not a single zone. I.e., the applica=
tion must always be aware of the zones it uses.
>>=20
>> However, an end-user application should not (in my opinion) have to deal w=
ith this. It should use helper functions from a library that provides the ap=
propriate abstraction to the application, such that the applications don't h=
ave to care about either specific zone capacity/size, or multiple resets. Th=
is is similar to how file systems work with file system semantics. For examp=
le, a file can span multiple extents on disk, but all an application sees is=
 the file semantics.=20
>>=20
>=20
> I don't want to go so far as to say what the end user application should a=
nd=20
> should not do.

Adam, Matias, Damien,

Trying to bring us back to the original proposal.=20

I believe we all can agree that applications and file-systems that work in o=
bjects / extents / segments of PO2 can benefit from defining the zone bounda=
ry at a PO2. Based on the code I have seen so far, these applications will s=
till have to deal with the zone capacity. So if an application of FS needs t=
o align to a certain size, it is the capacity that will have to be considere=
d. Since there are plenty users, I am sure there are examples where this doe=
s not apply.=20

In my view, the point to remove this constraint is that there are users that=
 can deal with !PO2 zone sizes and imposing the unmapped LBAs for them is cr=
eating unnecessary hassle. This hurts the zoned ecosystem and therefore adop=
tion.=20

Even when we remove PO2 zone sizes, devices exposing PO2 zone sizes will of c=
ourse be supported, and probably preferred for the use-cases that make sense=
.=20

As we start to post patches, I hope these points become more clear.=20=
