Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0547F2A31B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 18:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgKBRh7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 12:37:59 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:40152 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbgKBRh7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604338678; x=1635874678;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=2amOSHNx07MWIfpDcHeRBx/Nja66DFU6c5FPDcJv604=;
  b=E3NGmo7BJqpNEDkkTxUagq0rYXDF29UkA8bRCEpALgM2Qepmdxvam1l1
   x35H/Bpht3vy8loG5Kvid29nS4glNK7+EYhuHiQo141ZCmcoPAllRqvT3
   Pvrhg3U2ql58bG6KyEoCC8Nm86CNhNbvqlmMTtoK0UU5uZvimzynVFKc8
   ZZVbD4tPjuUzE8E2iwGa6cN2T3+4GflxUiGaGEdgMiKRvxqlT/j26ds/4
   Z7ZQEmxgSfCIXRjbr+6zX/dWuBJ9/iVDIUESiCBAl7RIly+NosY7koQvY
   U4gf3uz2heu9wVA8vSe6EzUWKYFqUeMUKMLrTe+FFKIWcDgVYmKwb+7LY
   Q==;
IronPort-SDR: 0H3oS9Md1/BPwrBU901nbqCBmLlzJHmXDpm1NbpLmbMQ2H0b2i8qTQ7Si1iZQ2Hp2etC5Lhk2q
 yQ4Ir3ngFWs1HfhRHzunl8QRUyCFQO+i6Xl0YDg6InixcMU5AyCTXCmQZfovPJItx+TD+o0YyF
 Q1GdReccWmuMQNZ11l1zJXuM7V5RZni2P4FxPoZi0SXSyLG4u+l6xLkh6RAcH4nWoiFmAOdu9g
 rE4F1EfucJaAqJ3YYFTC2edWRVoGpKauNE+5RpT9lWgCcd8y4YdkIj5Vp2KVdoWedhLqgSdK2n
 lBk=
X-IronPort-AV: E=Sophos;i="5.77,445,1596470400"; 
   d="scan'208";a="156008911"
Received: from mail-bn8nam08lp2044.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.44])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 01:37:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBBtNCp+k149nbfU07DPikc8V51IYgyuB4IgCrf13OeL9WWZkJMTBBkSpe7QiN9NGKNCeS0S8BlE606kxDYdamnm4x0mixppQe5bCFb2d9zY3flP58QG5QxbjO1Ee5Y+zjQJ0GHr8OMW7/8aL55KI7As+GbnQJaQy38mWDgZYMGETWvP4Ff+vrTsJrvEBuRzzxVVvsRXb5G00ulT2TX6vwOjeIEklca/sUcj0LuR6snNaLlgcuWyQTqqD0chOyCe/WbpLYZW3LBL8t90YVKSMqT3eBoUWI+dl0b9p2Ccl91ALTJfWMdxIxfuHrAIUZ/mbC5vwIrgOEamSMTT2+ndZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2amOSHNx07MWIfpDcHeRBx/Nja66DFU6c5FPDcJv604=;
 b=UROEVPfALQFziGuYAsTXbWQrafyM8bXjS0t9Se23dE8AkrJ4tLWOTjWsJEh2S0fd8qM0AuKDLQeyQsiHrZ4K0JjEexX2GvVG04VlrZCERue0JDl8RV9+RyU4gsFgr9LcWVlOh7atHSlvJuPjmtEvMq7/gI094Nak9Zt6sMtvOYUYCuW87zLMWBZNOFxJRv0+ASaL2rSQYdx8rwLRse5+tMCDE/HH7Vd2twQf/+9c6S5badg2MhD0XtKpBb+6y/5cj0aCpWwmThSDsu4OWoV29dytOXVfEuG1yJwkw75hOId8G/2EHurmoTFA8SChFeyrIlNtSy6GhE38KQ8bOXWO9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2amOSHNx07MWIfpDcHeRBx/Nja66DFU6c5FPDcJv604=;
 b=MTVU30JXXiKqtTtC2SyOXcYlCFfI36HhNyC3PXX8c4dpNl1hSlW4467d7n0V3hwKv1n4hZvlCWNIjSWHIugK1LfSG/2g6LfSKOoC8W+hkE9/e+UZATAU87GFY2G0cHxjwDTK3PWNi54IhJuvPolmYQmDnsJpAlnh1kmQuEyLP/Q=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4686.namprd04.prod.outlook.com
 (2603:10b6:805:b0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 17:37:52 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 17:37:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v9 07/41] btrfs: disallow space_cache in ZONED mode
Thread-Topic: [PATCH v9 07/41] btrfs: disallow space_cache in ZONED mode
Thread-Index: AQHWrsP+2e1f8RuAsUqKrkts9lcv+w==
Date:   Mon, 2 Nov 2020 17:37:52 +0000
Message-ID: <SN4PR0401MB3598C23CC8FFD406852AAF4E9B100@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <f0a4ae9168940bf1756f89a140cabedb8972e0d1.1604065695.git.naohiro.aota@wdc.com>
 <4a2f90c0-e595-1a0f-5373-80517f9b9843@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a46f7569-63f9-4210-7722-08d87f560654
x-ms-traffictypediagnostic: SN6PR04MB4686:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB468643725356E32A5B3211709B100@SN6PR04MB4686.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VbpwbNnRfOLflsVZTwCXLo5a9pJZiy5wUUjYbhaj7E3SAFsRyvET+PetPpBtasAQi3E+InxmE2dHLVOrkI+AaLl9KXgJ9VwyrTBGwrM8b3zPqhLjsH0OjGiK3PDXKdNkqoZIbm88/7CiCTaWlaXfTTNlLXvmot8p0se5XMOKCdp7EIjjG7EicGj7kfAmcU7IhmcDBlxp+MZ7Eeqx2cW9aZtSnspiBeeIW0M/b0VnlqYjEJWIAIZuG6Z0LxtKLXfrf3bFUbtSGTt+8sNC56sKXcFQxXB6RTXqfw2Kj6KK+vWRvWyvr5s+tUh4jHdVt092+LChWZ3mNeTeOhnO903DuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(110136005)(54906003)(66446008)(4326008)(64756008)(8676002)(8936002)(66946007)(86362001)(66556008)(66476007)(316002)(76116006)(91956017)(55016002)(2906002)(478600001)(53546011)(6506007)(7696005)(26005)(71200400001)(558084003)(33656002)(52536014)(9686003)(5660300002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 23s5DVIs0pKYh8h0v26A5V4VLb4UXTrVCeqo3zVLJJ5d+Osz5QNTQ1nkRujtb197HRoUpptPNAQbsLy5dHKUuHsUmzOKWodep6Px8PML3y9BgktYHNA/1IfeXMdi67978p7izXeys3ilVUwj73tvl8ROQx7qbEbetX2yLC9kDr7elc7JWGaKYRSDk2B/yrsdVTPNOOmSgC/z8eXUNpwV/F4paF60zq6WiiNWMqGI6YWbYDUXMFMC+HaSrXnlDrT3FNnDTED6hY783GbcdK54SgeKqThQJ+D140BPwQrx0OIjjPfB2WqAa5Y9nlWQP0Ct8zo6lf71crsOUkZKhPTe9MEbmZmIoWKdwebHLMYH24I3gN8SSQQ6mi6QOtiWj6tYtOd14a0YDkua85XRqL/5PAol2KH5U22ZjEeF3BJ7lw9qhHpiPtYxLjLnmpBSbg0uoVMNjw2etiolnMDNN2C2kRldHx64FzEnU+C7qYGlBJ6jYRSuhfqZg+VCTIJvvHsAEe7m7MsL/Qff1wmTJxFtTqFJbx1nM5SDLQ8o6/eub8nlhy8aou33bMmKINr+s/XQXio7FuBBk5amEgF2/3o4kRYa5ROPGPGXEnIRxB1faNzrR7MKc2Xq8w1u+1+D1Rpo5sr85iPmjXZVpH3BcFrOvw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a46f7569-63f9-4210-7722-08d87f560654
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 17:37:52.2080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lXMflfupxgqXsjZ/ZM0ztUF//gyGnmbfE4Oi3be1FaryFMnYOckPAW0gCkQ+eD4HRnUsmdlK2Mh7WoEo0NgNQdrKIMlVTy+d27IxUOs2/Lg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4686
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02/11/2020 18:02, Josef Bacik wrote:=0A=
> 'clearing', and then you can add=0A=
=0A=
Fixed up, thanks=0A=
