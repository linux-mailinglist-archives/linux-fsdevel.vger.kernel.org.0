Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C03D3A89F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 22:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFOUIK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 16:08:10 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:32607 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFOUIJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 16:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623787565; x=1655323565;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xBIQB4vlTsEluLKfUi5o6v1ueocAWo7LHLShDzzcEqo=;
  b=Ay9TwG78eVU4fsFbnjlnCXSwdizkNXvOywu/beqjQulSyTHdgNsS5tGi
   Gn+w8mDFZbc1zRHli8i/hwOqWPijUTMQboLyLZkMNbb9n3sjRiGq3RQjE
   xJ2cyKJrAoDZnt6dEuVCpO7EfyvaewA2PJm55Mnd4jokwwCC87j2hy9WT
   UIBacyY2E+bPTQvTEJ8dmcVCA+zVz6jnNs2u88WpB7n28YYvqsqoGkSmg
   l7/4Vr2/6S/CyefjvMM5LD5LD31blI88rVa+RSBhRtlPYPMaoi0flT6Zh
   2Lc4ySYLqAadaMBvESAr1/wR3Kh2USzlpsQaEHx1G6h6RBUOD6r2cOkwe
   g==;
IronPort-SDR: 4wOxhXQNjGldW3Gw5bz2D3PCjbQZoh+o7Y2xcPHSdxN6Qbzno2C7eK+FVuwC06dIi6/Ka1di/S
 3AOkccMt49zZimYA/8CXUSFafKj4kTBWVygNd9v1K/p9ceUgnB7V2y0m/eNy4YTTqX5gUVb9KT
 sgYqKJyBYO5TKS/d3xePH6qfMa7xmf6usirXymtNChLxAwBF5+LMBgeULsNzD1deLKbYfEFJHy
 g4JngCwJ1GiQBlUOZbs2vplDCDUq+CAbH4PVXGB3VD7/pKFOe4kmOwG6yKt/gpFDv0ZZwrvzi0
 RGo=
X-IronPort-AV: E=Sophos;i="5.83,276,1616428800"; 
   d="scan'208";a="172575951"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2021 04:06:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmSUJ0G4eV8wsMptfAdZtYCV31V5gfqhgmlxkti/yZI2zQKzPYRSwUJ6SlBcnjZNvOXJ2Rx0drhuN1pIzsqlziJ95l7DO1QAKAIAOCMQiU5iV4lRBl1vcllGCUw+k6idhgDLZVLducJT9YDqCXR2C72bEr7EY7qW557D3s1LkcCQtpT/Ph69aOzd3bqibljFYfBsPK3FxYMCegga0yy/BrNewmfep34Ry7cljd/zeWsDBPH0Zjcuwxm74LKd4PJxVeLSTHycDrugoWDDagOjAg3cA5DaIzpq1iaz2BFN1T6FD2mLbJ3T8BLkiYEY8pyDWzhNE96WNgf9CBpXDXgZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBIQB4vlTsEluLKfUi5o6v1ueocAWo7LHLShDzzcEqo=;
 b=d2pCEsJzr6fqLHsKL5mviu9Bu5idxHRm7b2vUkkltFzR37EEycspMYELehT5XvUZ1PcT5tD6R+Tt76Dc/R4erLOB3rrMH/ddjIbNp3teJJEGhu8pIjbu3/YMasI0Eeueh7p/Oq59CaLRoFblX0fvOXdmqZbz+2AEawAjk1zj9j4wn0kA01Uigw4bHxBT+39icAy9iqM05PXLWx6O5HXZRtVC5igsyvApSEsZRynjuxuCzV7CJZFs1ctDEuZGU4iyYo602oJRaSCyUFDKT+EFORjIJEugETBHdNxFi1N7Bp0WW4glABWyaKSzL7n4UVuvkgSJa1oXUS5jXcAqBn5LWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBIQB4vlTsEluLKfUi5o6v1ueocAWo7LHLShDzzcEqo=;
 b=udVz1nL3EgkY9URSVfGxUacGRNsQPm7uJprBuBcRJhuwJ2F2f14MNfN2fo2kWAtchwe6hJ2eQ6koAK9qF8QYbX7xYBkOoSw5eEXIy+z81E18PkTh9KMS4ncNW8O7IP6zDJaV2IZAIhIeLWys22ro9g0/Pu+XkGSm/S9QOiEOyMk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6101.namprd04.prod.outlook.com (2603:10b6:a03:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Tue, 15 Jun
 2021 20:06:00 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 20:06:00 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Stef Bon <stefbon@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Tests available for list implementation.
Thread-Topic: Tests available for list implementation.
Thread-Index: AQHXYiFMe5755RWny0uXHslp7WVncg==
Date:   Tue, 15 Jun 2021 20:06:00 +0000
Message-ID: <BYAPR04MB49653F0A26E0F40C2357FAE886309@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <CANXojcxGPS-3CqCNx3MuwtHBsu+tD2RFWszD7qcRMn2wZkANZw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc45fa4f-9a51-4e34-0a48-08d93038ff23
x-ms-traffictypediagnostic: BYAPR04MB6101:
x-microsoft-antispam-prvs: <BYAPR04MB6101E488C0EACBF344494E1686309@BYAPR04MB6101.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mwJx9i8rCOALY2eX6fXTQ4bwRPyZC4tCr/u8Pa5HncVAKCxnqguQEwhhggFiT2aSfoibRPdnsqKfLMtFJ0qem6g8gsXjOpRR2NgdsBBR+4PlAlbP0NtGOcbPd23QAqBp/qEZqKJCRG4RTMMbQg/1hraK6KhYqrHjrNbxxzhDAr0dgIePtLHwbw9b7dlm274E+plQeKx3oKY/a/zzYrIGdkvO4kmsMPb/YW8xo2OjePJn34bRxi6qH7e1z1Kxj+KX+HX+Kqxcz3nmbwvuw8Xmt1an3Zhpbsrxf5OQrzA8ThwJCUEF2gvvBCV0ROgiRDC2h0YMvP5+35zZwzfk5GZVlPUN+Td0+Lt8bWRHqcWiogCBjfaX6KkFax+RLnAXCKU0J9WLS+KgnvR+WRix6v66DIGXWB+LnkIzc7cLKYgtHzNqr6mr5Noap22gh4r/uQme6C6F4grbiua8Bk/yLcNHg08Ryu2+vtIBsrXJFDabHUrdSeE4eKHePx8vjadCsXXY01mBcHFVkBJWC1d53qskwpnJM5jj9Xf1eWNvuVYdtSq3P8w8cJEMQJ4BEZIb0FgffieWuPHdfcGX63AN1XXgHekSlD4/M3pueBNCL6wsAEgJwOqLE36bfQ+kjjH1Ol1FwOLwna2ovWS09S5Ndhy7zaP4U0/EewwMmV6lIrj/9jsFjq+eLOkYAS+QBkhslfl2IotWZ5VhbKQJneY4KGFtELUOb9HZkpIyyOIorfpLRfvHOpmPH8YyNUVZxGNrEa28
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(4744005)(110136005)(186003)(5660300002)(55016002)(52536014)(7696005)(64756008)(66446008)(8676002)(76116006)(8936002)(66946007)(53546011)(9686003)(66476007)(66556008)(6506007)(86362001)(26005)(316002)(122000001)(33656002)(966005)(2906002)(478600001)(38100700002)(83380400001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EnVxzJMmM/6Kdypy/GH4IqGMWQmvC37nw56lJiWD3K1ewDyNTwHB00PPNrJ2?=
 =?us-ascii?Q?lvqF4Zc1WSvBj3nt8ofsGd78KSY/NF4SwJ07m+m++xNUl3F2pIP3T3pf9tGP?=
 =?us-ascii?Q?Taef0EhiyPmTQltp7jpJHeOTP+y7CjIEYG9qBrWqc0ltspoK99HVGkBOFo+b?=
 =?us-ascii?Q?jydl7819Ih/xmE5QubqXnzWW2NSkDXe4mPiDAOiSoMKcO/uLlegqdKYnLdah?=
 =?us-ascii?Q?6PpRu3v9gXWiLt8kDjLas9YCwtbnN5iVfl01OdtoDh6NzAQ9zEZwF6S5FNaX?=
 =?us-ascii?Q?Pn1vlAJLfkOFV5mQfMi12VrERRIRiZbpPvdkcEApWO9o6QAQ8iD2Fla7g4Fi?=
 =?us-ascii?Q?Qtfbgd+3lGv5AyIIO8mYnNkvrv2+5nspyUxjgUCw7ET2j62+9ahtUI3yX/yu?=
 =?us-ascii?Q?bqr3YaZ5uDzjjvdvn7M3rSBQwWmZTSDguCzyqeg9EPygIgQW5PC+js54T6YH?=
 =?us-ascii?Q?qQS6iSsyXGDBAyFys2zC46HOgYEULLuQRdq3Dw1WS1ppiDEgOd9bk8gJp98U?=
 =?us-ascii?Q?Ri05jxPyXJW3FxZgN8ecw4K5+9ixFck/bJYwhsKlcOcUX6RIjP+SKOW6S/D1?=
 =?us-ascii?Q?rvlGY5+lftgdI1lxgWLt3rvW+9adnneJLA+nVejDkBVSS0OTP/79uT2Q4G9Q?=
 =?us-ascii?Q?leIBvwuK+cQe1YqvLuX3VX6/2N3Hij+PFbgHsuSstPmazgVqPX8NXKuVgF5f?=
 =?us-ascii?Q?uULAW+eonfKKuyKCf0DS1+k/dHqOH9xhupMyInqt7xFtHwd8hw6CEnCm6G4G?=
 =?us-ascii?Q?myh+rWPn9tnuc7vlohqj+W7rGwQv2XL+8A+PWKU5d1dWgsSY5RJSq4o/DkLa?=
 =?us-ascii?Q?yJHM2YtkmnyxZR9SD6we0Gz0eG6/1npUWMVEq8bxEFrWlU7dUKNiwWaY7cao?=
 =?us-ascii?Q?WM+SVscOKw6ATS/XP68J+2Pw/cWRLrCnm6uo+ZT7sOK6dGLSw3n15CTeX9We?=
 =?us-ascii?Q?65R0M1daC1MTjgHosUFK+2MJpnozupRA2aUg5LTyswbqZqvtG+yoc3sICHsk?=
 =?us-ascii?Q?YeUtJSnqc56oNkhJX3QGBqT1FqjX8D6YzUAZ/S3jKJlGddrT6mK0ByS1YTPn?=
 =?us-ascii?Q?xR+rnWWFPw7lwmN8eWBFgrVk/4+G2k4E6x0WhaItGx5ZjO5o+lROQLJ1FRPr?=
 =?us-ascii?Q?DwVcfmLU+exjdxH0rOKqXPioFwYGMZsAtDjKXwgzmbW7uXnsnmyLyqNXdIj/?=
 =?us-ascii?Q?Xkg4qt5CYINSFwbLA6LR+Z1yj59KKl+fJm9uNaisaB7Qr+L0SY0nfro7s4ix?=
 =?us-ascii?Q?AMl+aLZp0LqJJJNLcX6SKsbe3LiHV1j2jSdnxkSPa/OMgU/3JmT4X7do+D2G?=
 =?us-ascii?Q?g3QR+EvCQHW29fEVp2MrEdki?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc45fa4f-9a51-4e34-0a48-08d93038ff23
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 20:06:00.5274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wQ3pRV5TLC9ldzgGLZWFCtGSjP+DsZLVIv62Iz/sB9EWzdlLIn3TINCcy36k2OSt6XAGhcFa/tmffiqUdF0/+7EVK+p+FZjUND1Z8Z/5R4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6101
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/15/21 13:01, Stef Bon wrote:=0A=
> Hi all,=0A=
>=0A=
> I've been working on the implementation of a linked list, and the=0A=
> basic operations on insert after, insert before and delete of a list=0A=
> element. See:=0A=
>=0A=
> https://github.com/stefbon/OSNS/blob/main/src/lib/list/simple-list.h=0A=
> https://github.com/stefbon/OSNS/blob/main/src/lib/list/simple-list.c=0A=
>=0A=
> I want to test it and compare it with other implementations. Is there=0A=
> such a test tool?=0A=
>=0A=
> Thanks in advance,=0A=
>=0A=
> Stef Bon=0A=
> the Netherlands=0A=
>=0A=
=0A=
=0A=
If you want this to be reviewed send patch series.=0A=
=0A=
=0A=
