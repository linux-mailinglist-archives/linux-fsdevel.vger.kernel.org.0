Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E90415430E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 12:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgBFLaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 06:30:09 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:7210 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgBFLaJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580988608; x=1612524608;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3OVVOd5NnsA/ZVPeEp2WZiNMNgkl2Bu7CcZlX4sG5no=;
  b=aKHOqjw+j19DJjeyXcldMUGOOFUpJQQcYXVMVKgdVD6/K4bLjGr+gWbc
   PedIZyVZLhd4uKynbZ6umxs4XRcE9aOUUyA3CEPmzb8nexldArv3A40Ob
   LJn7IKJ514It5wpBtDjB0seS/zLfBqL8bA75McydPRRtNeNs9QWo5xBkL
   FkZPfYjmGLaID8f/4+Fb/cAs3dbgMzr87HwoaNOnliEb3OP5f3VhpWFjh
   RxspBDv/Hpzs4MLg+EDrXETWoQzYcI8zFaK98+tU/hLjETzT9K7rWujQK
   4d0heG+FKjif0UN+agh2HSO9RYL/hxXMXzmmuJCtqoLd5iT6iG98eWjNS
   w==;
IronPort-SDR: C5ydVfSfGBNGtiySQjJ2OonDcGkIyMlz3Jw3dmk1wU/wYj5c4pKlslgbHnGsJ/TgcvdUbmLvF/
 nF/zJmTeaqqMR5r/QBXtxr4rSEc2sop7xyYICiC7MCClY82d6CwqW4OyIj4F7tDauPVZ3wmLtS
 ZjhrHEulNB8IQGsKOfRIAg5kVW+RoVh6HQkps8yotT/JgoywRMRPuFoTNZH/y5jmHdzQFwJKeq
 8hAbzATyhg6LNKkrF5VUK1H0k/RQ97mHDgxBClDsGXxDaAoHSELB881WZA12lQaauiLAg3mj+z
 yak=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237212533"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 19:30:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayPqrXveRPpyi2O3fxlDVvhWboIvJZXusg0e/+LnRukLHbhD6IrPGc5WcbJ2xogiG73D1E41fhI0x4it2S1vTa0YHnLpb8I/ISeW4ezBMtgIfB5QDAG1EuAiKR/em4Ui7/D+OLyu1k/r6e1fSWBm1nXdPqXH7OrDidNjUYga6OaV2AcDc+WvfgT5gzNKmtFD+vQPMVFKfNqJIoSefSNT3YiRmIeTk8DOnoEc4RxDgOGBGr63V0MwKD0cVVRRz9nk83hS8aQu3mVvkgasBLyA42sw/IdFIlYPDAR/POdwOxJMngsSgBt3Bytdvw6W+MphlttluL0P1rxsy6p9mTksfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OVVOd5NnsA/ZVPeEp2WZiNMNgkl2Bu7CcZlX4sG5no=;
 b=lGcNQmjBTFKIAZyOR+fOWg6ezpL8GBSLOVM+BrnCUfrSiNLvTftKjegluNbjfwqxWAW54Jadaak3p78KyleOTBQ481RkviQrBlCRSAjxN1Loy1H10P3JjkFIPUS+pnx0sNuXmsmVJ0XBntk95um21EYyUZcxpditsH2R6FFx+FGAcYFo+FnzoDwBbpV17C1/gGSsTE+QjC8K7W8LOYLSYakrulgotMKApo1q34PdX101aoeseRobn14IuMikTP2Uyn6upAl6OmMUvAP+9Z95vfbkFfNk1gkgmvWHdxNraU0arveMMZrM3tG/qxybZSBwk0o5BDxhWihFB2F2A65rwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OVVOd5NnsA/ZVPeEp2WZiNMNgkl2Bu7CcZlX4sG5no=;
 b=ZHvi08HeuP59Nu8LDHzctU9+8lwjUt/a3jKhDQcD5j5a452wVEcue06G0g8/8opN/kDuF5wyu+9Bcjp5PwMGQoGyGIpr0ozbjhB5kqw2o/1gOsC+Y4fjA8jcQ3z7FWEjARy0PkeHnG4geNBnHfaVsiZmPTdTiQ7MUMKGhoWKVbM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3661.namprd04.prod.outlook.com (10.167.129.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Thu, 6 Feb 2020 11:30:06 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.036; Thu, 6 Feb 2020
 11:30:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 02/20] btrfs: introduce chunk allocation policy
Thread-Topic: [PATCH 02/20] btrfs: introduce chunk allocation policy
Thread-Index: AQHV3NpndJGNN0dhfkKjTmpPEJ2Cxw==
Date:   Thu, 6 Feb 2020 11:30:06 +0000
Message-ID: <SN4PR0401MB3598D9897CF42A343A03D4739B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-3-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b6f4d918-f44e-4537-4d34-08d7aaf7ea9c
x-ms-traffictypediagnostic: SN4PR0401MB3661:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB36615DFDB46F2B245F34E2369B1D0@SN4PR0401MB3661.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:181;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(189003)(199004)(54906003)(110136005)(316002)(71200400001)(91956017)(558084003)(7696005)(52536014)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(26005)(186003)(5660300002)(86362001)(4326008)(55016002)(9686003)(33656002)(478600001)(2906002)(8676002)(53546011)(8936002)(6506007)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3661;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ftXR9osUvmDMo6fxomqegKp7P8ggaKA9UqhkWkqME5b8GGsXmQ7DQlFPyhYn4p2n0PjC82tbdL/Vg9jWSWg38LXioeBvixPqmrMDl0vcSatkfX8OJVqXm3lBEJQgxr1DHwMsDfksSMVMCNRG//RyzfoWvB93OeRVfjVhGGLiEqkutm7fnVZ8zFGasvUhllGa3hwYTrVrNNizgzVdlL+x/9+PLC0JQEl+jHCJTYzCo0tPoewQgjPBzNsjHVjLhrDwBEH6CMruU0rUDkvDJ23p5uJ7PbDC5AqlRlblWVD3of4KEewHrnC7t1FNb8k0GI3iI26V6/INyfHbg7hPMneb1aFJrJ1HgYNZAohFVxVTMFH8CDrAeCogu7P/8xadhNs1Z5Lc1Dleob7cc7skZ0V+p6WBuWAfitVKzuH5jHpOs8HCnm271MrUo7Lb9341VtrF
x-ms-exchange-antispam-messagedata: iZR/2LAmxH93h58rXaGjxsGw9yfIn4olEcsDD7vtosH1V8oQr+mrjeKWnoudiFGSFfj6y+tGSPwP4raeaMhU2A4QLEl8i8qmXqgZO4/m48S3UldMc3gWYAnrBxGN5cvnTiYtYbQtNGwomZv/Y8k8eQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f4d918-f44e-4537-4d34-08d7aaf7ea9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 11:30:06.4351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OM/BojyBIsy0xIO+ETiAnl+e6Znqmj3/P8vfhkdSwR649Sfyg+bAgnPRFzrK3Uv9hjLnSr6vmYpyFkljBjNay7Xqi+UJvcPgP6Gbu5Gi4JE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3661
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/02/2020 11:44, Naohiro Aota wrote:=0A=
> This commit introduces chuk allocation policy for btrfs. =0A=
=0A=
Maybe "Introduce a per-device chink allocation policy for btrfs."=0A=
=0A=
Code wise,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
