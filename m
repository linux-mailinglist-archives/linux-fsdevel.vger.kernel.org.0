Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB52135AB61
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Apr 2021 08:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhDJGdO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Apr 2021 02:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhDJGdN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Apr 2021 02:33:13 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1FAC061762
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Apr 2021 23:32:59 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u17so11975522ejk.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Apr 2021 23:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=QmBA/khm9QQj8QSTpq8GUmMDxfR3EYkN2ltUuGJAbWQ=;
        b=sYihbTj0ySH56E1/o08bUwUHP6PyMBpmkgNghaJfVEKAxJr6SwXUAXRRgAbBC/Bzs6
         XCmi+fNGzSELeEOU9OyM5gKWSCuhiaTBo8xg5JOR1Xx5YhMEyV5UoZRlzGvOCBFxfdnb
         Y4XuBjJrymTHqG4Q9c4L/6mmF0Y28mUwbQA1Pievd7aBVzSEiSirgpM/5BDL+f3GB6hH
         akcyRLY3HEflOUB++qOGJgYxTP9/zppRBr6LWHBQooOIim3A4sdddrOCduKHbzLbGxCf
         Y8xxy+DyzLOE1m84KcHyUnaOjgn3AqxfX4rVJEXqpze20A3tB7uDXjDBDbGYmlx2eivb
         nPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=QmBA/khm9QQj8QSTpq8GUmMDxfR3EYkN2ltUuGJAbWQ=;
        b=XAIWwMTK8FOc41Jr1WrY9VwUfCWJTaZIoAR7dSkN/AlTR3PF53n3vPGvUYWMwGSyWz
         zwO/i6kQiVcHwE3eC1L4zNCGdx4pTmAy/1GmbTpXjJwK7gaSp7lhbGgo6mkPyxHB8AmF
         olLqACUxNyHF137CS5uRWd5PMc6Ug5y1cSqyQTeJsgLljQ3O2lX/kchPZLUyf2ZOqMN4
         ZLHHIw+L/zYRLtC+vCRT3ayWbv+x+mBZ6HGi5pelJWy3PfPD+qwHVkeCt3RwtaQN0/xe
         B0TD0WNf4bSx0MnoD4MXpAFKkUWVYJEYf9ZJYP5jf1fZ99CDGx0AWn0ZVjCVlI5Yc6r6
         cpvA==
X-Gm-Message-State: AOAM532QWCHYNOxFQdy/xj6803XEEqUOa/FPVxQAUdVvRlQ4PkahH5ow
        UR8QUG4jyMmGWnNen1L6930OwQ==
X-Google-Smtp-Source: ABdhPJwG75/xQdAUY5SZ7i9s/RKcSTINm5eq6NN0AZ16BVTCynQFcgZwYqtZ3G/MLDxy4IQWenOqbw==
X-Received: by 2002:a17:906:1d0e:: with SMTP id n14mr19377458ejh.97.1618036378037;
        Fri, 09 Apr 2021 23:32:58 -0700 (PDT)
Received: from [192.168.10.20] (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id ck29sm2558898edb.47.2021.04.09.23.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 23:32:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v5 0/4] add simple copy support
Date:   Sat, 10 Apr 2021 08:32:56 +0200
Message-Id: <5BE5E1D9-675F-4122-A845-B0A29BB74447@javigon.com>
References: <BYAPR04MB49652982D00724001AE758C986729@BYAPR04MB4965.namprd04.prod.outlook.com>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        linux-nvme@lists.infradead.org, axboe@kernel.dk,
        Damien Le Moal <damien.lemoal@wdc.com>, kch@kernel.org,
        sagi@grimberg.me, snitzer@redhat.com, selvajove@gmail.com,
        linux-kernel@vger.kernel.org, nj.shetty@samsung.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, joshi.k@samsung.com, javier.gonz@samsung.com,
        kbusch@kernel.org, joshiiitr@gmail.com, hch@lst.de
In-Reply-To: <BYAPR04MB49652982D00724001AE758C986729@BYAPR04MB4965.namprd04.prod.outlook.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
X-Mailer: iPhone Mail (18D70)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On 10 Apr 2021, at 02.30, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com> w=
rote:
>=20
> =EF=BB=BFOn 4/9/21 17:22, Max Gurtovoy wrote:
>>> On 2/19/2021 2:45 PM, SelvaKumar S wrote:
>>> This patchset tries to add support for TP4065a ("Simple Copy Command"),
>>> v2020.05.04 ("Ratified")
>>>=20
>>> The Specification can be found in following link.
>>> https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1=
.zip
>>>=20
>>> Simple copy command is a copy offloading operation and is  used to copy
>>> multiple contiguous ranges (source_ranges) of LBA's to a single destinat=
ion
>>> LBA within the device reducing traffic between host and device.
>>>=20
>>> This implementation doesn't add native copy offload support for stacked
>>> devices rather copy offload is done through emulation. Possible use
>>> cases are F2FS gc and BTRFS relocation/balance.
>>>=20
>>> *blkdev_issue_copy* takes source bdev, no of sources, array of source
>>> ranges (in sectors), destination bdev and destination offset(in sectors)=
.
>>> If both source and destination block devices are same and copy_offload =3D=
 1,
>>> then copy is done through native copy offloading. Copy emulation is used=

>>> in other cases.
>>>=20
>>> As SCSI XCOPY can take two different block devices and no of source rang=
e is
>>> equal to 1, this interface can be extended in future to support SCSI XCO=
PY.
>> Any idea why this TP wasn't designed for copy offload between 2=20
>> different namespaces in the same controller ?
>=20
> Yes, it was the first attempt so to keep it simple.
>=20
> Further work is needed to add incremental TP so that we can also do a copy=

> between the name-spaces of same controller (if we can't already) and to th=
e
> namespaces that belongs to the different controller.
>=20
>> And a simple copy will be the case where the src_nsid =3D=3D dst_nsid ?
>>=20
>> Also why there are multiple source ranges and only one dst range ? We=20
>> could add a bit to indicate if this range is src or dst..

One of the target use cases was ZNS in order to avoid fabric transfers durin=
g host GC. You can see how this plays well with several zone ranges and a si=
ngle zone destination.=20

If we start getting support in Linux through the different past copy offload=
 efforts, I=E2=80=99m sure we can extend this TP in the future.=20
