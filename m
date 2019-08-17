Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A87390B9D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2019 02:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfHQAFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 20:05:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46317 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfHQAFL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 20:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566000310; x=1597536310;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=X6CFDQP40seQuaS4LyDxuv356P9fe6OsKMqbXxcv2p4=;
  b=MxSVHWZayPSkalGhG1HB2ruW3JVF9qSDT0sBgt9vLWOCYACx1FTXo3jP
   0P5p9M2cmZDAQB2dycbot+cD6aXGoQqRLLHbWVdWxkGg49v3QRAs7WBq9
   MTxaoJ9PWxjDGyIouF1nxE10VkQsBzSfVIb2GgiCx48n1sDS23xxDBB1L
   CLtyyP7fUd2cWmj6YjMWJZYXZbEiwZxjDayJaNU7zdIFr5imjiGZDB59Z
   3Bd/mN7LjR4l3FPYRGA35cez07d93ArUq5xfYDYYcUg9TS0g54dIKvZ9X
   2jg09zVT0Fol55FDFM7fbV7iv8iAxCZJwdnS16H2JcBfc225434YTDHfU
   g==;
IronPort-SDR: zuVy7dsPccrt5EyGqYt5sgUcbDMUqsHl48/A34VxLu4SANTAJ/G2tIhe8+NosWjc/hBOfX2Rix
 7q3to5A6f0ADlmBTuAY5pknbhOnEGVNeyo+KZIrS0vUlr07iZOi2VUlsY9FPwwSC6BNQm2Ew2d
 ikBQ2xYT/ZpiXeKG9FSFP+x7Kk+YU09G3aXx/1wsKOoAdRZ8vq2EUeensGkCc2IYkvjDaNISG0
 IHAfU0pKSbYsdVuLDQKKFlxoBJ9ImOEM5YFl6srRtjQbWKzrT/QDUbxhwZ2yYB7teuHBM8/vcE
 HCw=
X-IronPort-AV: E=Sophos;i="5.64,395,1559491200"; 
   d="scan'208";a="116963951"
Received: from mail-bl2nam02lp2051.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.51])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2019 08:05:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKsWz/9j9TWIlzbK2lSeB6s/GsGQCIYwQYYMqyCmzjZOHfCtQGdRfrqxJvctJQw009CbcrNgR07UwDtGCzZTWyV7kMFOCRiG65oLhJfWKKCGxbpzerSbVT5FOi2Q6S3lOi41hoWu1g2T4nodZjtXt+oO+IiTET3W67nc1+E91IrL53U6i3WNQ2givQbiP3VVdRjDvk1Lj2befd0eWeyxwFjePyyRukozT9Vb6fCc8h6WTWAZjzPbDRUGxAQVVcimK6HocHMIQX/ihBUYYAk8EiAFYXGp1DhSqZYSnUgRr7bq0gzIojUoVXjvDTWIRx4N8xs/btr0bp2CO4VgVHLbyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMoBj2oGSAWibT4HAOCJxtOCsy9UvV0qeWEFlaLWjzI=;
 b=KRe7VVVS0KgoZAvbRXWK4GLnX2bfhDe/SA7IkqHyNCYPYPMrnwWt5INlKgX35YtNXSUwvkB9uHfZcS9eFupozfnqEX9HYq4tK76GNjzVD3NsTaZ7ISZwvf+Gz17XHmbKFZTmEM/heutk4sBRhechn5+SoPNMtDHpriTu9J4TIVEE0pwlEbSpSpuqZo+VSJErVVOSmCHjKgX/ifXL11ywy88jpdOP9/gyqy/Dxvsb9kQJPkGhYtOPyi+uxKTS+tHC24q9LDXw45rXNCTDkqjnBsJcQxkehTrk3Wy1L/tkegNgtpFL2KDTk0t7Cp5FoyC7lByew/GSn3NYJetvVfDD9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMoBj2oGSAWibT4HAOCJxtOCsy9UvV0qeWEFlaLWjzI=;
 b=MO6cfLR4Qoq4wlkxAUwKNq0n8xSkOA7PIz81WCr3xcna80iTFDVoneaXGIarRcXmd+raaWyhZADbfrl78/8ReBo3l4CpLJ2Izqu3AexCR+D/TZqV916jBySYgbvU3AudHFZdM7rI57SBTK6yk7Huj4xVVbOnEXbj2YN2xuwi1dk=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4792.namprd04.prod.outlook.com (52.135.240.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Sat, 17 Aug 2019 00:05:07 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::a538:afd0:d62a:55bc]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::a538:afd0:d62a:55bc%7]) with mapi id 15.20.2157.022; Sat, 17 Aug 2019
 00:05:07 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 03/27] btrfs: Check and enable HMZONED mode
Thread-Topic: [PATCH v3 03/27] btrfs: Check and enable HMZONED mode
Thread-Index: AQHVTcwLvihvHr6r6EyyA8TQQ8Cdzg==
Date:   Sat, 17 Aug 2019 00:05:07 +0000
Message-ID: <BYAPR04MB5816C9F8F5D36B492B33AFB4E7AE0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
 <20190808093038.4163421-4-naohiro.aota@wdc.com>
 <edcb46f5-1c3e-0b69-a2d9-66164e64b07e@oracle.com>
 <BYAPR04MB5816FCD8F3A0330C8B3DC609E7AF0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <86ef7944-0029-3d61-0ae3-874015726751@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [66.201.36.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8390f7fa-4403-4bf2-9074-08d722a69003
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4792;
x-ms-traffictypediagnostic: BYAPR04MB4792:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB479235F6EA3FC4BBE9770313E7AE0@BYAPR04MB4792.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0132C558ED
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(189003)(199004)(54534003)(14444005)(256004)(81166006)(66476007)(66946007)(9686003)(8676002)(66556008)(14454004)(66446008)(476003)(446003)(81156014)(6436002)(8936002)(26005)(54906003)(33656002)(110136005)(71190400001)(71200400001)(55016002)(2501003)(7696005)(64756008)(76176011)(316002)(186003)(53546011)(6506007)(102836004)(478600001)(99286004)(5660300002)(25786009)(2906002)(305945005)(486006)(52536014)(66066001)(7736002)(6116002)(3846002)(74316002)(4326008)(53936002)(229853002)(86362001)(6246003)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4792;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gk14QzkhcKEx5sYpnryVPobYa1hoKyecTkNNkoBvJ7+1iiLf5PH4SycFRduia2MbDNjQ2Ocm/qK58NrwAOYQ+uFdOkbtTXt/r3s+zWEgURVjPlnMkAqYyIr6cnWTmSHDY3kZWhTxRwTZ4KJrLVo5u67DHb9kWQ/8VvM7mtPe/pNpwIqLVPvslFZohFPYonAi22dc1of6MM5icKPLp0s9eb7+GWm3u3MybMDctbui8Jvcv/K2pUFrzmezEjfPNTFXuWXOd9bDqmcYf9AURknT4DD2sXchPERmJjAv1yrq+hfg+thU/surmL4VdczckoSZ1dryfvVi8+hu7iNcWaPaNhhFu99TAEBR66pPrKwcF3BpuyA9IucNXo5liBUu/oMLgc+il4+ISP3z8cUohtl12VyE2e2COu9KHGSCDwje4aI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8390f7fa-4403-4bf2-9074-08d722a69003
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2019 00:05:07.1093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pfXHvlBVP+efkpdMgx8j8a6sArnfBHJ4ofZA/1dUImXcafcUHTmTCszUp2RcQXkcKoRLUJSJSmh1c3Y8B8+NoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4792
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/08/16 16:57, Anand Jain wrote:=0A=
> =0A=
> =0A=
> On 8/16/19 10:23 PM, Damien Le Moal wrote:=0A=
>> On 2019/08/15 22:46, Anand Jain wrote:=0A=
>>> On 8/8/19 5:30 PM, Naohiro Aota wrote:=0A=
>>>> HMZONED mode cannot be used together with the RAID5/6 profile for now.=
=0A=
>>>> Introduce the function btrfs_check_hmzoned_mode() to check this. This=
=0A=
>>>> function will also check if HMZONED flag is enabled on the file system=
 and=0A=
>>>> if the file system consists of zoned devices with equal zone size.=0A=
>>>>=0A=
>>>> Additionally, as updates to the space cache are in-place, the space ca=
che=0A=
>>>> cannot be located over sequential zones and there is no guarantees tha=
t the=0A=
>>>> device will have enough conventional zones to store this cache. Resolv=
e=0A=
>>>> this problem by disabling completely the space cache.  This does not=
=0A=
>>>> introduces any problems with sequential block groups: all the free spa=
ce is=0A=
>>>> located after the allocation pointer and no free space before the poin=
ter.=0A=
>>>> There is no need to have such cache.=0A=
>>>>=0A=
>>>> For the same reason, NODATACOW is also disabled.=0A=
>>>>=0A=
>>>> Also INODE_MAP_CACHE is also disabled to avoid preallocation in the=0A=
>>>> INODE_MAP_CACHE inode.=0A=
>>>=0A=
>>>    A list of incompatibility features with zoned devices. This need bet=
ter=0A=
>>>    documentation, may be a table and its reason is better.=0A=
>>=0A=
>> Are you referring to the format of the commit message itself ? Or would =
you like=0A=
>> to see a documentation added to Documentation/filesystems/btrfs.txt ?=0A=
> =0A=
>   Documenting in the commit change log is fine. But it can be better=0A=
>   documented in a listed format as it looks like we have a list of=0A=
>   features which will be incompatible with zoned devices.=0A=
=0A=
OK. We can update btrfs.txt doc file.=0A=
=0A=
> =0A=
> more below..=0A=
[...]>>>> +	if (!hmzoned_devices && incompat_hmzoned) {=0A=
>>>> +		/* No zoned block device found on HMZONED FS */=0A=
>>>> +		btrfs_err(fs_info, "HMZONED enabled file system should have zoned d=
evices");=0A=
>>>> +		ret =3D -EINVAL;=0A=
>>>> +		goto out;=0A=
>>>=0A=
>>>=0A=
>>>    When does the HMZONED gets enabled? I presume during mkfs. Where are=
=0A=
>>>    the related btrfs-progs patches? Searching for the related btrfs-pro=
gs=0A=
>>>    patches doesn't show up anything in the ML. Looks like I am missing=
=0A=
>>>    something, nor the cover letter said anything about the progs part.=
=0A=
> =0A=
> =0A=
>   Any idea about this comment above?=0A=
=0A=
Yep, the feature is set at format time if some of the devices in the volume=
 are=0A=
zoned. The btrfs-progs changes to handle that are ready too.=0A=
=0A=
Naohiro, please re-post btrfs-progs too !=0A=
=0A=
> =0A=
> Thanks, Anand=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
