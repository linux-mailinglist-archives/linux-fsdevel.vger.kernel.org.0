Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0331AE40C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 19:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgDQRsX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 13:48:23 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19423 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729736AbgDQRsX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587145702; x=1618681702;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=adV8Gpr8MHweAYhq9tiHEXkdyPEny8cb3eGRce2pzfw=;
  b=MF8+ckPNL23/FmazpAz2Xah4UptofCUgw6URCNUROoYyS2Wu1wy4ahy3
   COh6yghUTRDp5kY5zlQn7ww3GJTAvwcvsSyauAQizpc4DuwvGO9/4kLEb
   nK69532No46LDcR3pnFKqm6o/Ql3js3MtBguoqBfeUE/zI7KWerlwhEe/
   lpOEapB2KiIdhmuT8ud4hpNMfFNBw9vzkG0OQGxhp2SdsBMsGHPXY6PIA
   RSw0AYJcTFORW7GDFCvMl+Vg/YgPNLDyudNTLdXoFzPEpGPMQOeoH7/ZW
   EzE4paYVqRLU2y9VpY/mTjxU1DJxSdgPP35Ni6gz8f/aXWEJSmBjGWF4u
   A==;
IronPort-SDR: f1adXbzvecV6U5jHIWZZS5T1yk1nU3gNVVH5XcQLocgZPeBG9HwJTPy4FOrCV8fE7/IcZo4D0A
 6b95FELRW25bgHWArws6ZzQO0tOAnoTFetVvEnn0iVgTCV9vB3d+NiqddEENQ9BvNI5bJcJq6L
 42Zdql4zMnsavO0ltYjOEQ3WAUXVcWSadNSGUxNJUa3n+vbRUHKREBLJfYm5iKK+ovYJ4239yh
 Kn0nUTX+hOTUVW8eR7SAWfJJAb2iugMnSfHgGeegCWIa9Zo/RhVlPnb6s6x6ApStPE1mGAStxa
 aiM=
X-IronPort-AV: E=Sophos;i="5.72,395,1580745600"; 
   d="scan'208";a="244253074"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2020 01:48:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fb3S0Fg/7DhJG7SzKhLl4RF/aqtsqYv7iiB+8S5myRS4YZFD/k2nWBklUxH3FUjXmWrQcdUF7LmDjoKDzTM2tbWr4KdM/6TcaUsijUb1+FdJXazhX+Znu8tMCQ5vdmuSRU6grcseBPWTQZ45L1fLiCKBA0G08wjIp2R31EsQPAaJ7XkHUsMFstw6qTZ7pGOLFcBLk+sz4Nw7qx3zUUNkeAPZGcDq1PLMDyu0pvelKgr4fyM4sgS3fvPtSa2gpjJay1AS3eBTJiBpF3GOIl+FsbR2KLuaTlyJFGP0ngb7QmuA30dNGICvvHK/0oVlTIQ25G1+NKuKHfdvNAkSmaFAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NI+8VuiSZQPh23FSjynwla8g8vjLDcUKZXNngAV3RgY=;
 b=I638cBDH27CBDXmOq0s02c0A2BcjGOyLpSf7eiAYsETfC3tUT+9rmf33a1pImnxdxzjq5WjJ/1q4b+bhwzLoIW7KyNjjbBI1Lc4/oFD+lhLru4cpxIddHXH6YunBOuS9IAeD4cscjtp924iG4L5IljGFrEPKpawLZqCTf3ND6DUzgNVl9u+BiUKedj09Sx1lmOKTYfVxjdWPsTMmA9w/Gzbqp952Y41SXOOKHIPn3rMvkbYxZQD8PrmSZMbB6p2AmG8FXvhmhba3qb15sMBIZzcc3qltV5AO86Hf/zSHWJVU4vAEx3wPaFD9A/Y0iQOIeMsHkCsPFSyVcd/zP9//Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NI+8VuiSZQPh23FSjynwla8g8vjLDcUKZXNngAV3RgY=;
 b=ts1BlNwd4te2xHQXSVTy1MTL45WlyPHspGKOamm0Fp3Uekox8yNjdXnuKitj96jNgcZZqnKKjW6lBB0HuVOKOxlSYumZmqSpKzHaNj/U/LNUJo4VVCmhd4Rcd5oOJxLtrRvLibWS9U24lNUlyFS7wVpogIKPLCmsswJyUIoB2+A=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3615.namprd04.prod.outlook.com
 (2603:10b6:803:47::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Fri, 17 Apr
 2020 17:48:20 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 17:48:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v7 00/11] Introduce Zone Append for writing to zoned block
 devices
Thread-Topic: [PATCH v7 00/11] Introduce Zone Append for writing to zoned
 block devices
Thread-Index: AQHWFLHx0jzddk9TS0yhYXDfmQ7NPQ==
Date:   Fri, 17 Apr 2020 17:48:20 +0000
Message-ID: <SN4PR0401MB3598F054B867C929827E23F49BD90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
 <20200417160326.GK5187@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cdf777e4-6a62-4e4f-aed6-08d7e2f7847f
x-ms-traffictypediagnostic: SN4PR0401MB3615:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB36155C9879E21FF34998C8F99BD90@SN4PR0401MB3615.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(9686003)(5660300002)(186003)(4326008)(33656002)(8936002)(53546011)(66946007)(478600001)(2906002)(71200400001)(7696005)(81156014)(316002)(6506007)(76116006)(66476007)(26005)(91956017)(6916009)(66446008)(64756008)(55016002)(54906003)(86362001)(8676002)(66556008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /MyVk1Xr4TNOBmlrS2wgEN9T6ayoPVwJR4BgpwHEjrUkNlNZ+G2JkW5TpFApTnHvGoi0qQ9SpKEJtFSHiAMWWRZ6Txps0ZDpXak9ERID+WyluHEjf4kHm7JFREuaXVT6348IuGm1gaqn9DkHOdJbx6QUnFBexmA3oRiuxSagFLYorG64mfssrPHN3djBfgmcqbf/4sX9oL9mptAtZYAUIQEJi4ZcwOD6dvSQHX/x3/QgeVxvvcLhxCKJEI5mplOx5LiRTNBS9C9AtIQQTQaOyI7LiAomV2zDEZQWIl8tJVkohj8K2084+6KgReODZctaTwJxyXjUVaiYk5Wf02S759dhqzCJNjmhFDxFwghamBW96FRtotFmaZvYhOKipelGzc/uZ/ySNqPLtjCtx3H0YNNJiMMT0K7XzyOabaQpxDm00C9oFLre4JI1VjLJ+gN9
x-ms-exchange-antispam-messagedata: KdQHw4/Q/YAq0F3dTXNG8WRqt+uC1XNDqgpdBW9XKPs/N18SPnCd0Qjfia8o05A9/+CuphPVDQ7BwNUkiplq5qRkVsmedeyoP1Hic7ryA9ubP/z04xkU9u6SBZFVeob4HoOPdj7iv62DtgSsp5zZWA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf777e4-6a62-4e4f-aed6-08d7e2f7847f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 17:48:20.2422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jr7mA1IK6sbWD/DTx3LPdNgiKVem/GFITTN5oYhH+xm5NNvdIDnDCesNjzRAqVlEDQa1n6OvL2+j4UBX5f2VSMgiOjXYns4/3c+hThoVuC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3615
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17/04/2020 18:04, Theodore Y. Ts'o wrote:=0A=
> What sort of reordering can take place due to I/O schedulers and or=0A=
> racing write appends from different CPU's?  Is it purely the=0A=
> userspace's responsibility to avoid racings writes to a particular=0A=
> zone?=0A=
=0A=
For normal writes (i.e.: REQ_OP_WRITE) the zone will be locked by the =0A=
I/O scheduler (namely mq-deadline as it's currently the one which does =0A=
have support for zoned block devices). For REQ_OP_ZONE_APPEND we have a =0A=
trylock scheme in the SCSI emulation of ZONE_APPEND, which is fine, as =0A=
SCSI disks are single queue only.=0A=
=0A=
A scenario that can of cause happen is concurring REQ_OP_ZONE_APPEND =0A=
writes from different CPUs to the same zone. This is fine *iff* the sum =0A=
of all writes stays within the free space of the zone. If one if the =0A=
writes will cross a zone boundary it'll get EIO, obviously.=0A=
=0A=
For "userspace's responsibility", I'd re-phrase this as "a consumer's =0A=
responsibility", as we don't have an interface which aims at user-space =0A=
yet. The only consumer this series implements is zonefs, although we did =
=0A=
have an AIO implementation for early testing and io_uring shouldn't be =0A=
too hard to implement.=0A=
