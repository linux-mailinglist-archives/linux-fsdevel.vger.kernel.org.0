Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A621AFF29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 02:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgDTAVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 20:21:34 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:7508 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgDTAVd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 20:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587342093; x=1618878093;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=CLhtgijO7VOhPlPrpLMnHG3NEZjPTSpZk+OVj3ubc3o=;
  b=nLnmpoMsxgAhM6qMBM1Bpymlw4z7wbrv1CxgGthJKuTOd5pp2dGb4J06
   0oenZg13f7NpMoSl0XUCmTEPE0wrHKt2pvcr7q6QYQX2GqWQDKoFUaFN3
   dOTio9fw5M4rt45sfK2ZeRiGaUxPDwdHf3PAL3yxa8JSE5OaPC1XCG0ew
   yWCxu7I921ki7KR2p9O4+Lrv+cCdC8/qOUfdHJugl7Gm0zYCswHjyAY3U
   xkPS7yBaZcy3q/cG0u7x0JJ/s7qhtmy0X8psjikckIoXdUpKQt0/YD0fn
   DyPFXEbIdly9kNMjZEPs/ls9+cA1EULEaAQLD6xDsizlnmOlFvU41+nSz
   w==;
IronPort-SDR: 08W8jnUyT3IV9Qs/fNM4QIkQAmKwOWzQ0AiPnqGFGhWzs+plWWM5lQ98tj40+e7BhDuXFHmp0v
 K/DobKZFErQLrQ/v8y4SCnv2hpiRxNIZl14CA2yTAnEr7XBkeqm4XIhe9gFOpMd1C2sd+CodFl
 lFtZFMu20aOYS7mxIVQip6nP0dLFizlLiYT7LBbi/FQTGBEOFfOtey6UyAneCZvffY6tx9L9aV
 7DMlnNyMAMKps5dELuM8RidiQCSxkq6SF4+m6vCLnQ5a600rxr9YQ055PU9I8EGenh1wLS3qR+
 VcY=
X-IronPort-AV: E=Sophos;i="5.72,405,1580745600"; 
   d="scan'208";a="244368798"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2020 08:21:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OghT0RvF7OKCai2FTQk4IFzIcduDsdl2x00vHaE8HDmTaoOQEuzCjb/4CI2m675Gwz3s+BqA8BivVwa0OIvMsTXZoi3uXZ/EceejzbFaAjMvZLwx4ewOcs7JOSPzuuExLcLqf71Rl9DDzzYlbsjnGIEflaHN7dhe9EtxwOT92Gm+N44jD2tjAaAEiQ6uKr6fn2dtUbaVWUeRkLCs0ESkRZ/KH1qpQyv9tSLDT+vqLHJGRfbRiFBJN37Inf18FM7C3VEoAwyoFCBETrQTaUhWfXG6cEAfbmT88n23OA502Za9PmaAZ29BWiNZ+BQTABSnx+AqVxKi77RYuZCx2SblSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLhtgijO7VOhPlPrpLMnHG3NEZjPTSpZk+OVj3ubc3o=;
 b=khp2OaeiaPM4spPWeOR3HrhTiHousdVFP+nvlnzsbQC5sL/2/xaFlU2gHkmt9xTTtbLmIgT7ISjCCVILZlRAyDne/6SEWlo8jFTQZ1l2aZFp21tWsvIZv2WLvulTHODm0PZgK/cZJ7OfmA32vyHrDQeZyGQbMnrAmMuTK9Vg+RAMcqgW/Dsg/smEyg8hKtSXS4q1JJ8PR8S60VyPQBn5+mMx3O4BkPhi7DMz1L3XrpxPm4+e6Bu1ZgM51AL5f1SxrTT2epvd1qA8LKk4W4YONlkPzY7a6x0qc8vfTTB3Io+OBU7EbbZst6IhhIREKyhdkgxGrIfY9S6KmHkhMIRCWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLhtgijO7VOhPlPrpLMnHG3NEZjPTSpZk+OVj3ubc3o=;
 b=kjFzbT/C1VJfdrO8QTMUDpGqNR4aDQ31VnDgdGI9r7RU0ztxhSaOsWCkIi+K8B5D0fREgPs+GGhro/zkABOEC9DBEEz6UhnRcNcAdGE+vF9WP05Z/nNb1jGP1/aIMaoyFYnLIbOfbenNxfuYUp9JRj86FXpKstrQMRszfK33crI=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6706.namprd04.prod.outlook.com (2603:10b6:a03:22e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 00:21:31 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%6]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 00:21:31 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v7 00/11] Introduce Zone Append for writing to zoned block
 devices
Thread-Topic: [PATCH v7 00/11] Introduce Zone Append for writing to zoned
 block devices
Thread-Index: AQHWFLHwkjv8AGgYT068A9OaCOXxMg==
Date:   Mon, 20 Apr 2020 00:21:31 +0000
Message-ID: <BY5PR04MB6900CA6DD8B3354981DB688BE7D40@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
 <afefece2-3016-8b58-fda4-1fbd7fcac75c@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd20842e-a67d-4690-544d-08d7e4c0c6cb
x-ms-traffictypediagnostic: BY5PR04MB6706:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6706484B6EBA528BCE0AAA4FE7D40@BY5PR04MB6706.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(55016002)(4326008)(9686003)(86362001)(33656002)(8676002)(81156014)(8936002)(2906002)(110136005)(54906003)(7696005)(64756008)(66476007)(316002)(53546011)(6506007)(71200400001)(5660300002)(26005)(186003)(76116006)(66946007)(66556008)(66446008)(52536014)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wCfvw2/zxQdtoc0fugNvv41I0lpokGYMBqiBNqbqYJbzNPIKt1GYeDd/qJN3pYHaY0n8EKQ2qk1jqj0t++ODZ36W9ErR97HkWch0wLFMgOSXXItaPKozyf+TpC5kt4l8t72UaZ0qD8FWuwWdC2jgzUHpVbEGjlJwIAGG3GhGDcIS1u8rpMCcQBkbtvD9mIULsVEoc/lHd05jE43ej26byeltr8TjxPkE8I048RFdlodT1kZHDNkesAicGH3JV0GtVQJjmltJwdVbxNQCZJ3Eyqi7atb/K7q/KdFNmj4kL+UNtkUOwzmD2hgOTvUwZwfuedDkfQl5y6ZOQnapxU6kkL3Beq0kNbqMEf2S0we2cz7xrEXodOskJ1tB0mqn7pmgxb5ErWWkmynREOdp8eT1vwjbhisqf0bZfeIr4MgdesXQ1B9hy8AC8F3HmCP9imwI
x-ms-exchange-antispam-messagedata: 2Va7pqOmd+65jpd52tvhhd+oSLgBn+LIX6TeDSXCFRqdNY8BNH3aqRMSek2nqCUckymVHXkijX/8pgqa89VbHH91LognyzETISg0AAJujNmTidkfWO/SWgXiilGgzM9Cq+YfClF80r0zeSLa2BBfuA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd20842e-a67d-4690-544d-08d7e4c0c6cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 00:21:31.4679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9A/J8PcDqhqGqbhnla3PJHtGsU6IuSceMDVkl7ljod2DwghsoL68MwLwcrZEyjymLkAvHzGtWgR8zkPY3OHpGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6706
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/04/19 0:56, Bart Van Assche wrote:=0A=
> On 2020-04-17 05:15, Johannes Thumshirn wrote:=0A=
>> In order to reduce memory consumption, the only cached item is the offse=
t=0A=
>> of the write pointer from the start of the zone, everything else can be=
=0A=
>> calculated. On an example drive with 52156 zones, the additional memory=
=0A=
>> consumption of the cache is thus 52156 * 4 =3D 208624 Bytes or 51 4k Byt=
e=0A=
>> pages. The performance impact is neglectable for a spinning drive.=0A=
> =0A=
> What will happen if e.g. syzkaller mixes write() system calls with SG_IO=
=0A=
> writes? Can that cause a mismatch between the cached write pointer and=0A=
> the write pointer maintained by the drive? If so, should SG_IO perhaps=0A=
> be disallowed if the write pointer is cached?=0A=
=0A=
Bart,=0A=
=0A=
Yes, SG_IO write will change the WP on the device side, causing the driver =
WP=0A=
cache to go out of sync with the device. We actually use that for testing a=
nd=0A=
generating write errors.=0A=
=0A=
But that is not a problem limited to this new write pointer caching scheme.=
 Any=0A=
zoned drive user can hit this problem (dm-zoned or f2fs currently). More=0A=
generally speaking, SG_IO writes can corrupt data/metadata on any regular d=
isk=0A=
without (for instance) the file system noticing until the corrupted=0A=
data/metadata is accessed. SG_IO to a disk is not disabled if the disk has =
a=0A=
mounted file system. Also, since the series adds unconditional write pointe=
r=0A=
caching with CONFIG_BLK_DEV_ZONED enabled, that would disable SG_IO permane=
ntly=0A=
in this case, and negatively impact a lot of userspace tools relying on it =
(FW=0A=
update, power management, SMART, etc).=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
