Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D76B1A4343
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 10:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgDJIBd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 04:01:33 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57875 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgDJIBc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 04:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586505693; x=1618041693;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4o3TisBG1Yclcv/K4CcJ6BW7Az2djfFo4ACWhV2a7sE=;
  b=Ug2g0NpyTD24E3qZaqtC2aF83ViRNDd09QH/rufX06ljfpgF7sRSzsZa
   MTz/CH4Uh7f21F4/Fx/Ug3c/ftk0ODysOBppb+bCoMsSeKEGl47RU1JC+
   xSIdDCaIz1Bh/5uepUsvNVylTv0/NPDXan86IBIBpFB16Ou+nLNGbFXTh
   IczmijHiBuQNPa0BJflR7QXtcrippxJtWQelPhAGyrWkz+34IqBQP31oF
   atC3aUXD4aeSVgp4fJKQKt6pmRbli0w+BQ0+/DYKkxxvKlQ6mDj3+91wW
   1pd18cGfbv+UIJ5aldbiVsSMFncIBMW2NTpCTAnpE09Xw6f0KOiF48d1C
   w==;
IronPort-SDR: kzfqaA+PzNxJJmB4B3OnDLN8m2MujzCu5M1PTxf0MQX2CwM6c3fBaZxzX4l2EqkfDBlbO5i8EH
 OfYYnb8eRgZpF/HYIp6shYzmG3EcsobldSIOGUK+kOLc/3QJ4LRpP6yi6rZ2sopaYGrL3j93UQ
 yLEWS7kT2zsYYrglblQED3tu2xkrpDJGXw9phDXiAh02GbRYbuURQA/DzzdvVP4VpLWLq2t1gq
 o6lbkSIZdIajxagVpi3AViDgW0OTU4Y7OaVJkMsV1LmLMxLTuRli6NiaqgIpOO4ubkweuhnLDv
 DRE=
X-IronPort-AV: E=Sophos;i="5.72,366,1580745600"; 
   d="scan'208";a="139359330"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2020 16:01:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+jdwJmBTRUUHybO2EIXox9hjLolfqVlq7WM99pD7YPwtHA8rbKPQJ8cYDQu4Tb/ue29hSvFTGhAkpt58KmAow5k02axfcrI7JLyYQ8NV6Z0Ho4YjTBiucT6Jb1XpQUXSXfqV6G4+NV2jn03bT0qsLJa9GJQXxUQpG9rMtYvZ5yCxs0U8C1EmR4HiAgdSxdnqJf08nqyHmDxk6CJoFjFvyRy2t+EREndxl6qOfOnWS7VhLGQouwrrim/LaMEqmyvyQWFw4bFgWto4Xd3TtRGCRNCxeN5wIX2MNrDRtsu5Rosg02lYgAgyvMaQbCZT9lcP3ClO9SXEiO4ueaLin+o9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNGDoxVqol+AGNgz1SwgR7+Xgb/QNRuYTHRnEeyCMZY=;
 b=L3LYkYCB+loW8XjcHkGMBr/8X00nB/zxQXg1zHpjDqJ6SenUqyPrFP24vMYc49zzje4NZTTkFXynGo7pA1st0s9hp7gLibVbjfYyWpIhbeqvCiqhanPH3YdpZ1t1OEp5baPif2VOfY2+DKrMEQarF8bmKsPVHTjPYWuNQu0IxKqV4kJh+tOUDpRQWGcZPLebkMhW0wshLDfbcjF4YRu7GUGFkzp1URfPOqr4soZOy5L5Jfd9s07LQK/LjoaJxdJ2jThIIB0bLcs8xU0VnEThPARbnpHQdY/RticnAwKO96sbqHIH/zBviJM53W0fI0EM8HYkQdLkixZmFKXBhtDmyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNGDoxVqol+AGNgz1SwgR7+Xgb/QNRuYTHRnEeyCMZY=;
 b=amU6DeUA5gwGL9cLNF5ts9WcDK9ecl/HMEQtIaNHMqD5nmnUm902ctBG2M+2LRaDhVOMeuvmqjyZbpcUx9Y3itzXrMHMSwAL37CcuRGguC73d3lvYHvMU8S122jD7v5GRQ+EpNswy5BvNapHlFfiva+Mqq8aha32EFKh+S7n7W8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3661.namprd04.prod.outlook.com
 (2603:10b6:803:45::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Fri, 10 Apr
 2020 08:01:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2878.018; Fri, 10 Apr 2020
 08:01:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 07/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Topic: [PATCH v5 07/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Index: AQHWDo9/7/TsxA+1IEecB4cF8olDQw==
Date:   Fri, 10 Apr 2020 08:01:29 +0000
Message-ID: <SN4PR0401MB3598BD2ABC30EE4413BAD2DB9BDE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
 <20200409165352.2126-8-johannes.thumshirn@wdc.com>
 <20200410061822.GB4791@infradead.org> <20200410063855.GC4791@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ab216b1-6d89-407b-2460-08d7dd2560a2
x-ms-traffictypediagnostic: SN4PR0401MB3661:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3661C3D276F14AC294FC50389BDE0@SN4PR0401MB3661.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(71200400001)(53546011)(6506007)(186003)(6916009)(26005)(5660300002)(7696005)(54906003)(8676002)(4744005)(81156014)(33656002)(52536014)(8936002)(478600001)(91956017)(66446008)(4326008)(66946007)(86362001)(76116006)(66556008)(66476007)(64756008)(316002)(9686003)(55016002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +JkZQ7FVGQC/M+Taoh9aCsRuo5FDgiaTIWftG+ojps6I6bGZFBQK3ZfLcQoyAuACmKEXxLWaTzKyn9moZwnBzxRu3eaelHYxuXy7qRcRlEG91ysULouhCGz0pQXxXc8igjjGJ0KUXOj7ZoO5Jfk/wFOXWbWyOGkg84+OnySv2aXXvIXqi4O2sed6Gvabig7DMVyHeZTpB3sy2KYNQ9FW3OGu5km+te40GRqaPdf6Wb/Nsm6mQhiz2eUFQLZwAWpnnOiTzqLSfEB8HY/28+JXjlJGkQsOQE81RY8c3exfUEaNCFI9Zhw+6IOoxP3oZuztdwAS34DoIE9qI5hYyvqVFBNUDWdH7rM4wPu49rO1r5I8heZmUXWZyG9OnRU++TTlScNCMc5ZsSg1PcsOLeu17UMzRrxSCUxIttXnHNhf05VbB/XPmPtiyzXNqiN2NJo3
x-ms-exchange-antispam-messagedata: FsmP9vVovD3dbExBTI/4kSU0Q4LcfBdl7pOz/Msk6g7FrwT93MKgwGgjo1B1LGt5uvZ/tFRse9GYeZLE2CADthHQghn1gHNwGrtY5RDCQKVlqYlq36Neiam8xyRTinbXhr+YlLjgC3paQMiSRY6ZpQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab216b1-6d89-407b-2460-08d7dd2560a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 08:01:29.9542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RhiDu2lJdFRYQxFyaqxj1Zl3tt9IwvuMGAgUptM2nrHirN22qg/DZ3WkQcEuKkZ0fHVU8dPi8htA6sxgItK6+f0GNCDDzvQWCnCtsnjXTDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3661
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/04/2020 08:39, Christoph Hellwig wrote:=0A=
> Looking more the situation seems even worse.  If scsi_mq_prep_fn=0A=
> isn't successfull we never seem to free the sgtables, even for fatal=0A=
> errors.  So I think we need a real bug fix here in front of the series.=
=0A=
> =0A=
=0A=
I'll look at in on Tuesday, Easter holidays here.=0A=
