Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3504419BAE7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 06:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgDBEMM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 00:12:12 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:52100 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgDBEMM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 00:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585800732; x=1617336732;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=emDVFJso3jKtMkekXhKuaTYAI1IeqKn1hjxX+lft1VA=;
  b=R1w6opyaLsAYRYFsAcmOCgTAdFYQbVfoNzoj+BoqMUPDBGTfy5shpHX5
   8xKzB/yPdtPIwm9DSCYXD1b5aY8Ik1MejJ4cErXUSyzrCeQqMrY4/pgwf
   0GJNjo6Ih9+lvDT+O3nq/ZjFTpoIGHXEfprnC48fW2V/1bIc2e6nhGVA5
   grGOSpgRYptUAmjHnkwyztvNafs6rANRyZ42JeMWC3SxuCPCBgw1Ngc3+
   A32ILiz0u9cDtYc2YJz22kHu2WLX7AbDhe1sg0+J1dXStF78AdKd0laAU
   jsEmiIGZcGECuAkFSZt+yXrJwArLWsmFfENjSOdPkqvOWyvJV4orG/5y1
   Q==;
IronPort-SDR: dPlBT7PgeexH4TM/sWJTPJqa/qCpggCKFAHL+mHULDrhvNJUWL2PJuZWqfpoLUo/HLzMoXVwMW
 qy0I9ddaxAFX75qfOwLiPo3PBYhyxDJt7cf9azJoI1cZzrUFhOk0Xk4L3FT96EzsRCxDiCsdn+
 cqAgEButON9lM0R/84bPUzTmw7ccYuGVoNWm50mjHelkOH5C/TF/csJzp5eepesHzXnN8pc3Or
 Wj/lMhN2qcGpoVhmpWjPXv200oRO/kdrXEVNEKO7naqoedI1gAwDp7fPrQ0auLlTjIdTYh+Haf
 uFk=
X-IronPort-AV: E=Sophos;i="5.72,334,1580745600"; 
   d="scan'208";a="134696696"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2020 12:12:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvJ3iX0lBM6ggWmREHk6J6i8F/BBQmnNhYy/onGOzv4Fj0Tx0glCSQDcHYkDBYwdEjqF4YXJ++JF3Pd2EkyRDBNVa20+7i//y1XyHzf4vx1QuUccwyLZfffY4ztTofyUOxEhv5ga7meI16ejoPJn5fLnp/ohI0Tf7bTHzEtT0ZMil1NsdfSDlukiaHpVLO+nX7T6Ur93Yy1Y+z8VbBGc2CoAZhaks2XUTis+gJ/bnPAsk8iHr/fdvSXpvYV2EpnYdChUEgdw4RYezGMrlt/8JWJy/4qfLQ9kYmLVE2O/C6KMcchOqqZTH2X9miWzef5WlCkhYfInw+SWjhTP1E9vaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emDVFJso3jKtMkekXhKuaTYAI1IeqKn1hjxX+lft1VA=;
 b=CuAYxdYQiAQvnrwtUXSU22cH2nbT8d5VcpGpGdgIhab1c11riz8KqHrof0VydrAXTWn6ciUdktExwF9AeqineghGbQsAb0FSOhVyt2mWJijSLCZ4xAQrN8DIux55SxSzCKrLgavNp5a4/woqIc6nBkazZ126pTRlTJfYsv/0tQT2suQaa4V7MzwgGIvjzPtOd+RaOpJbQ8nQX0wHPRg3CfOPL2xAmWnkCpWSEx816225limlX/TeQalooo2wZZ5t4idxt6+zsCRRnJsHJQP5XtcGFjlHrucfnURnqpuyznxyaqSg6YFx+aH1J2f41XNzsHOQe70VC23zer59Z62pIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emDVFJso3jKtMkekXhKuaTYAI1IeqKn1hjxX+lft1VA=;
 b=JWUXaob901YqpCl9LGPGFSLhxVAGNJkQ8YdQpe/tdmIrUBLlTW+h5e0+6l2IJ1kwru3I+4Jvh0QT3mbgDMj7OoSD+c3JD3y670gUssNCnLp2fOkiwEcoNSVecn+Vo95ssy758YIKUEdcU/r/K0iZZoUVFzhXVZdo3dPWa/MGBhc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4230.namprd04.prod.outlook.com (2603:10b6:a02:ef::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Thu, 2 Apr
 2020 04:12:06 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 04:12:06 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Chucheng Luo <luochucheng@vivo.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: Re: [PATCH v2] fs: Fix missing 'bit' in comment
Thread-Topic: [PATCH v2] fs: Fix missing 'bit' in comment
Thread-Index: AQHWCKL1dFE7Boy2C0eAyyMMCZ6Wow==
Date:   Thu, 2 Apr 2020 04:12:06 +0000
Message-ID: <BYAPR04MB4965E726FCB157878F11139786C60@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200402035807.10611-1-luochucheng@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 296e5e08-74f7-4464-e473-08d7d6bc01cf
x-ms-traffictypediagnostic: BYAPR04MB4230:
x-microsoft-antispam-prvs: <BYAPR04MB4230B55163A77599A5F705A886C60@BYAPR04MB4230.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(66556008)(7696005)(66446008)(64756008)(66476007)(66946007)(76116006)(9686003)(55016002)(186003)(26005)(558084003)(478600001)(81156014)(8676002)(8936002)(81166006)(2906002)(53546011)(52536014)(6506007)(5660300002)(71200400001)(110136005)(4326008)(316002)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p//2SAUi7spf/SJYFV/k+Qg9IHTGomGi4LvQUirWlgJWU7WAqgltDRJoSTU1WcmkdnOMXyHEDEYa7e32WpkzUOHBPwyG4glkFW2PzufV16lxHBOicN3GVfTZE6YHR51jj6eIto/rpyLSwgY9ziLU/VWOPdFjgGPjrO/lxoKaoP3JLKCd4Jw/V8A1mSRWPZBvVtpz3gNtLqHc/pHzmQk2wU3UN0mFrQFOoNrQgCucj571IpY2YRGv3T/6wzmAbKan5D633Z1+9QpXLwtpWdgNGplrLFgc+LXbyfstmfPb+/8XgwVH7ZoNG5awFqV7pItXjEspoq7ObnnODCZrliT0YvjD3XekqViE5Mol3XdFXcY+1dGLzus6LDKUns/aMsZ1JXLmnNmWBgIqGSd03S2P/J0KKU/raKY31OB72akHJFZFiTWFzEOSDqw31ku1yLcg
x-ms-exchange-antispam-messagedata: gPnmug7EYxdDFYir76lfj1g2j+okNg1UHsrMNlyPxkeZ7XGmTqr4liGnf4BlvVUaKyvwO2n7Q+yigTT54aDSr2xiFN+2JTASrkp0d5PQnCKSkT7xnRLFyMb90c7w4YPRSJ3tXjE0p1Jf8/i+0QLAIA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 296e5e08-74f7-4464-e473-08d7d6bc01cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 04:12:06.7062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t7OJJYx6NQtn6YZJQd3kaVmCKnB3KU+KJUxysJym48AN3GS9TC2xoECgfZTKnwas3BnMXpMu0uyIPqGGE6qcY+KjymQJIIcULd+zFgsXKdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4230
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/1/20 8:58 PM, Chucheng Luo wrote:=0A=
> The missing word may make it hard for other developers to=0A=
> understand it.=0A=
>=0A=
> Signed-off-by: Chucheng Luo <luochucheng@vivo.com>=0A=
> Acked-by: Hans de Goede <hdegoede@redhat.com>=0A=
> Acked-by: Andreas Dilger <adilger@dilger.ca>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
