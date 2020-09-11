Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B30A265ADA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 09:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgIKHwX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 03:52:23 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:59056 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgIKHwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599810742; x=1631346742;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QDOverA0mBpGPGXSqlGu3ZSDQMUWfquk+MG5oRXNAkU=;
  b=OjLFgsLAcD8J4IJNyvgoJQkb0VbTd4UwY8kzQeq2Lx8vBkOtvy5jw3na
   AYb6A6eCL3oY9DlXLwUCgHMvPoVIafLqwuFRKjsydcBnOO74bHE2z5v4j
   FJbYxrP9AWSqACpuhiRmvE6aBxaHXdx+tCJ0vtZpR8l7hadbeTNSpyIC4
   TfZqMIyOqx6y1t1cPW2yBmC4M9ByLtPbYYyFGObID9MvsmEGtSQmRj7uB
   u+8jzoliDfGpbIfsDT3TLEcz81yiPHSYtg2GCmW3/7To/BZYXQImX05mA
   gWi28tzcjhBWLsBElUkD4cgJ4TzWfGYaKZgc4g6FKj1AWMTjxM23IaDGj
   g==;
IronPort-SDR: 61kWTAZ+Cfo3GrbjyGLB5Pu3ShaILWKaQJqCvZD9iIYMDu5kKWuzVuNLjOH7l3T6Bahq4tBd7O
 /NifRL1C0ll73AMIlV3icOSq2OxS5T1gJ9djyMy18ncV6mp0t9saACosRdi1a2LLdykyKqctY6
 tPOVBiNb3VxthSl/ShEuKyIJEk7m3gn5x9yML3/EmE1fD+noeVFbKQWrlP2KhdoHMayWUAfMmU
 kBmVoqStrA2rvzLtYn6Isa6OmOml6WGzy7Ma3JDOQsdUGGtXFV6v0ou1WRmcdhKveWELN3/QpY
 qzw=
X-IronPort-AV: E=Sophos;i="5.76,414,1592841600"; 
   d="scan'208";a="147109538"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 15:52:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNADpNSGRxstg+69RUwqvfYvGlYFdm5vYNrSOo8hhs1N5tV/nUeTFuMCpZG+831+fzDfTL631YXxGTcpQ6c53zcFq8Z136aZ5I6yOefnSPpe/F/XB+hLK5DSu9ksES6mmxZWLbm02CTRSmMXBDOfYX09yuQWjYPbm6Ux93MRw7waaa2eG922QayIdhkrun2MEgZE4Cd3EHqZHNPiLXUlbWZLyE968/4Us72tsSekaReK6HJZzGZeaQdWOwiuLEwSEJZJdBy9S26q91HJp+aDVhkmTT00j5qQyuylknx1180Z7YL8wT1ih/RIcIdgehQaBK2w8xHV4LYmNupzZ669Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDOverA0mBpGPGXSqlGu3ZSDQMUWfquk+MG5oRXNAkU=;
 b=N39w1U+auyT7VETXcVLHDOihuqx6vsHJ+2j8I1pT4wa4tSAFLRAV0+HScHIe4x/J80NjxUNTgeeqRYz0jsJd4c7XuPvRD1JkMD4XhMjAf+Uiio6ATKi8CBBnXHxORcnBcFrAdWOlk3ku1Qzu7kekxm74fk/i4AnnVarkjMg23nfvvOI/eWTENA7i9CJFHKVEqbs6Uqq+DJJOgD7FV8afvnQEK/Qk2EElmTs8k5DLfzu0A7HR3AKrhz8V70nlO5YPrKhM2MUNjnWbFvG+Dz2vRtejBGntIxULz4DomYkHlIR18s8T+H6eF5UCeqYYxQPj+jvC3VvO931xgrL52mmX/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDOverA0mBpGPGXSqlGu3ZSDQMUWfquk+MG5oRXNAkU=;
 b=pqkRg+Ifgi/Tw8lnkT500yuCUy5XdRfSpBvxJMpxJYm5tiWBsUAmL7y2+ALT/qn0tjG38yUIrm367MnKdv5b6zsPevCI1m7+dMXlvCBcBgmTzw43jdUTD4H/4PsDiavBWENTwAk8EUTk8dBfL6mJeH62Us5iK85Y3AXhGCCXSdQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5005.namprd04.prod.outlook.com
 (2603:10b6:805:92::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 07:52:18 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3348.019; Fri, 11 Sep 2020
 07:52:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] zonefs: provide zonefs_io_error variant that can
 be called with i_truncate_mutex held
Thread-Topic: [PATCH v4 2/4] zonefs: provide zonefs_io_error variant that can
 be called with i_truncate_mutex held
Thread-Index: AQHWh3/38ZzB/2VsEEixqDZEgRurew==
Date:   Fri, 11 Sep 2020 07:52:18 +0000
Message-ID: <SN4PR0401MB3598ECA82EECD65922C9DB599B240@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200910143744.17295-1-johannes.thumshirn@wdc.com>
 <20200910143744.17295-3-johannes.thumshirn@wdc.com>
 <CY4PR04MB375191672451DED79B0D7775E7240@CY4PR04MB3751.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:142d:5701:f81a:38dd:93b0:f1b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08b5babe-7582-4288-15e1-08d856279b91
x-ms-traffictypediagnostic: SN6PR04MB5005:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB5005541E50F6677F1EE545CE9B240@SN6PR04MB5005.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jJwgUv/+sf1PfVHgFeFbjIPThMp698RMn1FGNStHOO9FttZQP1DRpIu0qGywjFu2yUjvs6/jsd/BRiKVqHpw/CspQcYtCc/Owocc+j5mCqbT8+pX7kzG5LbTIGbtGQM8j4a6U1x3Kh1LFTI+V2lfR3bQ5WQqUbqxrRZlzxsE76Fe/MN27b7GB3HPysaHqrUd4PmnbA721iJnRy3LU+irxzYtSavu4PLKRMCCiO8PTfjpMcHMKGnhLVyd4tY4qLoAG+2z6/COftmWOKQ5dj/S0Ikps7MhtHjRRPhU0fpEzrEo33C5O9+b4lwHH1huRg88
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(33656002)(91956017)(66946007)(66446008)(64756008)(66476007)(66556008)(76116006)(5660300002)(7696005)(316002)(558084003)(186003)(52536014)(6506007)(53546011)(4326008)(9686003)(6636002)(2906002)(6862004)(478600001)(8936002)(71200400001)(8676002)(86362001)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: A2OcTB7ZElXo0V4SX/D6Ch/2bmbhQNfZkSrQ8jYr38JnDS1g/oRAuTdvM3DriJ8UVLC4hRT7Xg5Al43mCg+H37e/ifDooNf3R/4ao4ykAcqjO1+k2Td4+/Sj0JCEiFQ4ChoCI0MUunHstHmiQRi7QxH4Vjmhi0WEt4tb0q1+Fvz4lVKoeMVIypU2+IICS45sajwNMwL2m4UqrkIIHzwceC/qx/gki5RShm9nVidZ7uyx1ql95vIULxRpcSiBecBjL1VadJj+Hcoirv8zq9P9694ReZ7/H0BGh5mp6gCw6O1Kr0PFu8odA39kB/M93iVprF2E7xW9Z3N2xJwmmCnMWXlf0y2/KEjGaOceTtPlwK742za59NYoiXj5t6zu7jlJdvxyCoyMvk5FMc5cBT0lOKiltDwq7hdKcaaW7mdTupDffrUufYoyG1Z3e++uJJ8gJKC3+Mku3seLnNZsI6EAhHND4zsbdX93EyniHjSfkigMddbxxl7uxLkecWaGW6hUwx90zMoH7y9kOswZhAlMCugrJQqDjGZwmFIwTkK2N5qOlmwrdExhzxe10QKLuOF989XQqANinXDIFmKmNC4mDQ4YHw0VMB7nz4lZ7eUKhT/XxrYqftxkQc6OqFT5dTlnN9OOvyDwA4KlLwPGLqC18uAD8Af//keKApnMg/rSfIdYT4wbqoy1dLYUNsGghhgPsj74C8JeSls97CgNsGSWKw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b5babe-7582-4288-15e1-08d856279b91
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 07:52:18.5246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bMWOo+UxaZJkKDP/DbhTGVfOPHY5007c0N8iJyx6ifU2NBxgd02/3KZaT/twhYoDWUOOC2V6wCQg8hZ/CAP4hR49zLR7rqYhO5dPK025nqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5005
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/09/2020 07:05, Damien Le Moal wrote:=0A=
> I would prefer to leave this comment attached to the function body, so=0A=
> __zonefs_io_error() now.=0A=
=0A=
Also fixed.=0A=
=0A=
Last test run is running and then I'm sending out the new version.=0A=
