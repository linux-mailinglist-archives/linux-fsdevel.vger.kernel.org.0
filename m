Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92DA1125AF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 06:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfLSFuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 00:50:21 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54237 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfLSFuV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 00:50:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576734622; x=1608270622;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GSbrsWDTBXgHv3L5mAv4ZzvX+qsh5gMKdqmsq6Kw2gs=;
  b=D8DXLk/exUy2cOv46NoOgm3NId9Onj5wDG+uWYSrGQ6odqKYGB2LUOr7
   K4080cRuxxJJnMul6/vriJ6PStzjalLihQtLplKcTV/y6tlMsxKrvTqEy
   oqJYGaopxnJQz96/7zleDY6OIJEIEzCARsHcobfmYrtFzho3YXHHIZovo
   VANV9bI0nGKXwts+MhR3+0feaSCexIVhmityDhx9Sv/BxIp0rgUHOGL/H
   CmHnKQMK/jeUxI+DgK58KMbf/Ekxn2reqAh6KSHK4UDSk4MeyIOxooTcu
   2nvzp2nHFG+QChksq2LO8niUTwpb6Hi2QRZNEyb5rh2frAGkgnpTAA9vN
   A==;
IronPort-SDR: pl8jH+D7IjC8IEupgG3gTKHC/ULEzq1wb/aF+3Orm7DMhtzoNJeXpA9b5S1bwQiJvSPE9m0NE6
 qTJxeS+y+rIepVt25BigOTYx1eybaRY5/ZkM3t8/pm4drai4kINQtJQcGv0HQhC0F0fLGbfnnk
 oHxP1Uq19j9A0XXkQJe6QzSpgjiGH0Jfsx/+j1/HT30H7FkRdAZaIfyMoZz1fRXpeEWghneyhE
 pklqpcAVNoir0y8fM07vDATa22i2BneVOSZ7KFs9/u6Z5cBwfdhIvyFYdMj/po7iiSOsQAfBkO
 C/s=
X-IronPort-AV: E=Sophos;i="5.69,330,1571673600"; 
   d="scan'208";a="227287347"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2019 13:50:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7Gwy03+7HYqeulaUjJhPbMdmxSjxQGLF4ZZTIp4tWtaUG6061BZA7kC3uVc0rINxOawR/HXXy0Y55+7nrRG5ZOgo7WJDFn3CBK24qPX7EaUyN/i30RzaxwLL6UdILgI0Fa20TPItywLE/ZLc7oDu/xlWr3xkM8af2y0927zRFc4AKfAdtY5mYurkU4dSOBf3YhFiE8bHgiawj1H4Zph7pLXGMpsfQHRlxYDuaQqq371P5atkBJFLbAOz4TAs3BN7CVKXX2XaATwnS5rXRxEvV5PFcyyBdhGAXpQHBuBhvWIMSwFfrIo6BfsrJHHeSigrHG0k5HZieHq34jYn8/Znw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=au2TeOyuXzWOq3tHvcR/f6Kt/0KqUXEd2nKodGWrGOQ=;
 b=JWvN8L+4b2b5S7BrrBE+ZD61mGqeKknHB/ck8sUxDmgDe8Egx1ZtJaMEqtQL03oUSzOocy5FWUxYlmoeWRTnndWAqVc4VF5yMMsf2RIMHGxQA4Z/ZffnfoWnV/WHQ41g2CcwQchEvdUZEZqnMhDMVEp978BUpX50bnwjPeFkItM1L6F7JHLhr/CqL+K5VJ7WhBjWsEjY+s3BiDDsjEyIxhY+OgTYHNRX5upkEEJSxkBzniZBgSL5QtuLy0gY02a7MK8pJWWkyVnGX7nR9kVgSGKb7PGa+bYRYcIfeXyXcXte4Zi/S4nIjHbWPM2PlJDdSp9QwatqQMZjwPdejRojTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=au2TeOyuXzWOq3tHvcR/f6Kt/0KqUXEd2nKodGWrGOQ=;
 b=bnnEHC3ecIk8rxI3H9QJYZIGI2Bq3CsbV7zEQ9C126r2g2vYH5i71v1Q523HlxXHxbbzIUIrpufwcCavlBANl+RgjsrhQbrp2zOKwLc4uVUcxhIApqWA1criVRhreDYpyKtVN5KQtb5MH3+yMqei7fzXbxhnwetTltlHPFHXcIk=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4232.namprd04.prod.outlook.com (20.176.250.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Thu, 19 Dec 2019 05:50:17 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2559.015; Thu, 19 Dec 2019
 05:50:17 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Omar Sandoval <osandov@fb.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: add blktrace
 extension support
Thread-Topic: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: add blktrace
 extension support
Thread-Index: AQHVr+qGZa1SvOsf40W81LFPPtqF+Q==
Date:   Thu, 19 Dec 2019 05:50:16 +0000
Message-ID: <BYAPR04MB5749EDD9E5928E769413B38086520@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <BYAPR04MB5749B4DC50C43EE845A04612865A0@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01e547f0-d8db-49fe-b66c-08d784475340
x-ms-traffictypediagnostic: BYAPR04MB4232:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4232FC16811E558C08DC976686520@BYAPR04MB4232.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(78114003)(189003)(199004)(66476007)(66556008)(8676002)(66446008)(54906003)(4326008)(53546011)(71200400001)(8936002)(9686003)(7416002)(76116006)(478600001)(64756008)(186003)(316002)(52536014)(26005)(5660300002)(33656002)(6916009)(55016002)(86362001)(7696005)(81166006)(81156014)(2906002)(66946007)(6506007)(966005)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4232;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3U/+slddiThf7MTVPaAj1qHkNMn7HrKngqwUfK7uY2PQcLvCxvA+u4i5+FX+snXBBHbZSnqcOZLlomtRjSPySuyEqvHmIC+CLplYU0EsgH7Cj+Zhhu8flzFNoiB3kHFVXv6i2MKJAg1uyhZS/FsZCVTpwk3slZ14YUZpT0smwHOXVbLrwFQEasIn9p46YejttIqOQUGoIzSWzOXBbgttZDy5iFo0vhPasWGFwR31pOJlpXjrp3jEJ3MkWZ3NuehI9NmyMnywG9b+FNvfPS4JnBNKasVAWZrn7K8EYVwHGxZ5XywISw362a+NA23OtvaGMv2LEVmBo0s9IjffF4YGFjz9Lc2aGJlSH3QHeHvE03qD+/PitxmjOLwgw+WA2oLdZLF/Merx0EhyzWZ8ewJjnqcLEra/1vxWyXf6/ZOU6v3DqRqIharuOud25SwSz2Eokfm9Gl6F37VIj5/7CjnNctL0CbFrfU3vGBORVYb/0hsK47pxTdtoznv5W8br1IJWGkw+bXEXf4bBVK2q339bS3SihRKjyDPvw/xcYO4aCFxwkulyNbojAG1lEf+g64yf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e547f0-d8db-49fe-b66c-08d784475340
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 05:50:16.9489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Btgr0pNs1NbnT8VTmGcUIAO7ay+JEmp8bo4mKNJufK3bl9s67FcTmLE2Dkic13v2SQo+OiK9XNME6S7dA+rUSCTN2PweK8dAS0uFzh/IJVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4232
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adding Damien to this thread.=0A=
On 12/10/2019 10:17 PM, Chaitanya Kulkarni wrote:=0A=
> Hi,=0A=
>=0A=
> * Background:-=0A=
> -----------------------------------------------------------------------=
=0A=
>=0A=
> Linux Kernel Block layer now supports new Zone Management operations=0A=
> (REQ_OP_ZONE_[OPEN/CLOSE/FINISH] [1]).=0A=
>=0A=
> These operations are added mainly to support NVMe Zoned Namespces=0A=
> (ZNS) [2]. We are adding support for ZNS in Linux Kernel Block layer,=0A=
> user-space tools (sys-utils/nvme-cli), NVMe driver, File Systems,=0A=
> Device-mapper in order to support these devices in the field.=0A=
>=0A=
> Over the years Linux kernel block layer tracing infrastructure=0A=
> has proven to be not only extremely useful but essential for:-=0A=
>=0A=
> 1. Debugging the problems in the development of kernel block drivers.=0A=
> 2. Solving the issues at the customer sites.=0A=
> 3. Speeding up the development for the file system developers.=0A=
> 4. Finding the device-related issues on the fly without modifying=0A=
>      the kernel.=0A=
> 5. Building white box test-cases around the complex areas in the=0A=
>      linux-block layer.=0A=
>=0A=
> * Problem with block layer tracing infrastructure:-=0A=
> -----------------------------------------------------------------------=
=0A=
>=0A=
> If blktrace is such a great tool why we need this session for ?=0A=
>=0A=
> Existing blktrace infrastructure lacks the number of free bits that are=
=0A=
> available to track the new trace category. With the addition of new=0A=
> REQ_OP_ZONE_XXX we need more bits to expand the blktrace so that we can=
=0A=
> track more number of requests.=0A=
>=0A=
> * Current state of the work:-=0A=
> -----------------------------------------------------------------------=
=0A=
>=0A=
> RFC implementations [3] has been posted with the addition of new IOCTLs=
=0A=
> which is far from the production so that it can provide a basis to get=0A=
> the discussion started.=0A=
>=0A=
> This RFC implementation provides:-=0A=
> 1. Extended bits to track new trace categories.=0A=
> 2. Support for tracing per trace priorities.=0A=
> 3. Support for priority mask.=0A=
> 4. New IOCTLs so that user-space tools can setup the extensions.=0A=
> 5. Ability to track the integrity fields.=0A=
> 6. blktrace and blkparse implementation which supports the above=0A=
>      mentioned features.=0A=
>=0A=
> Bart and Martin has suggested changes which I've incorporated in the RFC=
=0A=
> revisions.=0A=
>=0A=
> * What we will discuss in the proposed session ?=0A=
> -----------------------------------------------------------------------=
=0A=
>=0A=
> I'd like to propose a session for Storage track to go over the following=
=0A=
> discussion points:-=0A=
>=0A=
> 1. What is the right approach to move this work forward?=0A=
> 2. What are the other information bits we need to add which will help=0A=
>      kernel community to speed up the development and improve tracing?=0A=
> 3. What are the other tracepoints we need to add in the block layer=0A=
>      to improve the tracing?=0A=
> 4. What are device driver callbacks tracing we can add in the block=0A=
>      layer?=0A=
> 5. Since polling is becoming popular what are the new tracepoints=0A=
>      we need to improve debugging ?=0A=
>=0A=
>=0A=
> * Required Participants:-=0A=
> -----------------------------------------------------------------------=
=0A=
>=0A=
> I'd like to invite block layer, device drivers and file system=0A=
> developers to:-=0A=
>=0A=
> 1. Share their opinion on the topic.=0A=
> 2. Share their experience and any other issues with blktrace=0A=
>      infrastructure.=0A=
> 3. Uncover additional details that are missing from this proposal.=0A=
>=0A=
> Regards,=0A=
> Chaitanya=0A=
>=0A=
> References :-=0A=
>=0A=
> [1] https://www.spinics.net/lists/linux-block/msg46043.html=0A=
> [2] https://nvmexpress.org/new-nvmetm-specification-defines-zoned-=0A=
> namespaces-zns-as-go-to-industry-technology/=0A=
> [3] https://www.spinics.net/lists/linux-btrace/msg01106.html=0A=
>       https://www.spinics.net/lists/linux-btrace/msg01002.html=0A=
>       https://www.spinics.net/lists/linux-btrace/msg01042.html=0A=
>       https://www.spinics.net/lists/linux-btrace/msg00880.html=0A=
>=0A=
=0A=
