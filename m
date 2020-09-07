Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95A025F5A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 10:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgIGItq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 04:49:46 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:48667 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbgIGItp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599468609; x=1631004609;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=M0i372mkEiyUbczugpwH8iGlTI46/ILGGcUAS6rgj3w=;
  b=IXmaN4uRxI0QAY4HM6lur3+Gz8KMYBHzM3huuk294oF8DZfKmQPqT88P
   WpGmE62VOfoHNx52fzuA8NODK7i8Vihx8f9ptRcZXUiTEv438TPkwU8EM
   JQAsG6pSY22iHVcB32DuUfP5JqMADWxinbWbffJ53jylIol4dsghgneVX
   NzLkNVuywxxSA+4cbsBAitaTWsunUTsap7Rk2PWrUxSxuOS/IJDaiMI4r
   MM5/po4blMBU8yfrptFzQtVlPFUQDgGG7mi1c7upbznVg1Jol+NtLleyw
   txUzvwe+UU7lOlMOCoCXCKkm7DiGu46+nKGlm9RfafI0Di05q89Al6Zrn
   g==;
IronPort-SDR: FGjMck0NYJlX9u+AA9jl1INiM9jbBIJwAP7trJBfQw52oahVXyyNkA+3fAoFQ+spv2u8uKcD5e
 m9Ab0Weqeu8pdjgS3XMcIcSFszIdGmkHcheBU5KWQj1zt0navlOTrTs4c//3ga5EXPB2rXhiFn
 hbhF1syU2hN+e1kECnRYU2zsZm2GFNaynmz30q1IGSF9f8XDsDhM2ypxH29Dq9xStvR2d7Om2V
 fOL4uWtx5+c+DzC/EGxKiXJmz3muhhMuGIH5gyg4Lis6xJkqniWBKW+ORjgSW9g/qhTbJZa2A/
 0Z8=
X-IronPort-AV: E=Sophos;i="5.76,401,1592841600"; 
   d="scan'208";a="250015932"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2020 16:49:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EInxf8nxDYfszk3ZhLEoK+siFFVsZYYYUu4wy1GPalvdkwH6tvRkUUdh2Gnx2PXd2dAUvNVgJjz25++dVpdYa1SLT+ltD5hvlsuyO2MLN3BbdyXqdgV52bz++ILlG7G1+QL4SOyq9bthrd+3KhZp54TeqUg88xd+IF5rTRrSgMgWmbJPVYnPJ58sOm9B01Fl5QxPGCAQOQE4TREyaLADrVUzPh5jz8pomfnDCSIN82Pu7UOKZSb3VBQlJaJg1SHmdyJzraaQRWTgPGCxFQRxVGt1uR9ZeTPuZVBRmOBcn7wTZDFVjYxFkz4FSJpZImmUYWGq50XJbeKiqGMIrNn7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0i372mkEiyUbczugpwH8iGlTI46/ILGGcUAS6rgj3w=;
 b=h5ug7bVSNi1XgQr7RE7UNlHr1bH3Mp4dO6nzWVMMiha/oYb+7jPPN9ZjAbqbgkV7MhGelCDmisR+hDvfH72IRt30dSMP6/WwD8mnVRo87w6XYG3+hOivHVxQSOm3+HATVf2xZ2vl94LUmYs69twfnz4BNjGdPmRxNSTHGZoQu15L2QyrPs0gaEqxTn7FNJExG+5YNOEolLonSg1JQOLJBVS4XMk0y7V7rbB+LNf2GXwJEwQvOHmJabmAN+HBz7DqdboLEmcloBvPNcK/FuAbQo3RZjArQUgKrzvRx7WcI3r3mH7/+ORKMZfXco0r3dt/Vtw5PgBhcRd4PbYFIMB20g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0i372mkEiyUbczugpwH8iGlTI46/ILGGcUAS6rgj3w=;
 b=rD/xLNCB7O3tRo68UuaW4CVIYK8TreBrzRK2o9zwDmQVQrV+8ixlQkiaWkJfkMxluy4yxsh1wGf1LOvI+GeCfSgKsOdwIGZDX+oBVctoo872B9G+mWOKr4KYcfDLRmhWBpUjoC9bzUxewjbFeBJsuoxXQlMFZ58Fuarzy7Nsvi4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4238.namprd04.prod.outlook.com
 (2603:10b6:805:2c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.19; Mon, 7 Sep
 2020 08:49:35 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 08:49:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/3] zonefs: open/close zone on file open/close
Thread-Topic: [PATCH 2/3] zonefs: open/close zone on file open/close
Thread-Index: AQHWgq3YPlp6RQIWlkex6nUu1mudEg==
Date:   Mon, 7 Sep 2020 08:49:35 +0000
Message-ID: <SN4PR0401MB3598E132449AAF0432C909E19B280@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200904112328.28887-1-johannes.thumshirn@wdc.com>
 <20200904112328.28887-3-johannes.thumshirn@wdc.com>
 <CY4PR04MB375199CF79949920633AE2F1E7280@CY4PR04MB3751.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:5817:1b3:3c71:ea81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 611c13ae-8b88-4770-e413-08d8530af2ab
x-ms-traffictypediagnostic: SN6PR04MB4238:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB42386F5004317AA4520DF3A19B280@SN6PR04MB4238.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X4QijJ7dZRPcEBVdX6JQq/EEVexZMai6qesxBd14ocF5eYhgAtwVDFL+V+fFvY4Tc64UQaHrmRoJLQNgZBt1Ej+17sR7j0O0R8jCuQba4DSMK6epkcT9Gt48cZitmQKHa9IsVAN8kA8s0yw20R6KNn2ZwJZqtTnbaXGBDen74ZQqrYy4B9d28mqSZaROd93JYuo74kTQEFq5gfb4AaFqvdmY1uBDogJ5qLAUr85TnmW0uF9+fs71VR+wHj1Iolkvrp/9kZ/h1ASoETKgjvXrvDrvFRnpYQnJNzTw4d6NGZasl9iz7rrqLKkrF9dL7sGKoifdxBDk0AEM0t7xEJ3PhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(8936002)(8676002)(478600001)(2906002)(316002)(76116006)(71200400001)(66556008)(86362001)(55016002)(66946007)(64756008)(66446008)(91956017)(6636002)(186003)(66476007)(9686003)(33656002)(4744005)(53546011)(5660300002)(4326008)(6506007)(52536014)(7696005)(6862004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 4IOE5QXs2cv4Ik+GMLHYW/dWc67g1BTs9tFQQP//T3G/Jx+fN/uhelv18TdohynzCH/1qF+eVwto9mY+A7zNBHgEUw4XS524sO81cwn/t+X07khhGjus/VyfVJRvx+C3BiQlyjrKfn4yed6M+HkH99Fx05t4puSgeK1Md6tMAC7/WxKqJS8CWFnhBaBHSND66O4Lm7g/XeOdermVkcbCYUrU79CM6RioaiYAamUtpBd8kGR5mHkZpEU4weEgScdjPUpDD9QTUDYjX0GMwgrZC/DvPZpE3kzZ0jGdnvBT/GjKAiT/b1p62YXUgO7VQzABm9nG7ctTcvUhdQZo0V53hqT719WiOVIATwttRwHBO2a8DJJkvWMVveWgYhgsR0hf780q/l/uBY+KanNkJmO/6HvO1xDDSF2MeL/jOHUX3V1apVA8ePUWIfysgUrgrZe978wGtG2ksjluv+BvIZKcX2a999GWIprH1m2CIiga7rQ+34ENz3IWHsbiFQjk3eZ8qHOfYoStmz1OprF1CCzWT1QTSlS8av0llB+WbmYs307JRlnOV4XA3nZX/sZyMk0l5PWaz3ixqJLTOzOFZn9g3W4uqemtP333zLrqA5TJMkrqQVFytEmY7y2Zqz6q407BwUYdX1W86HhNYs7WbZ8YxnevMV2y0sDtSKrw+gGVZ1nKkzIiHkeFGFjxLOzjR7SpFJm1oNvYqJtxOv7vvzkcXw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 611c13ae-8b88-4770-e413-08d8530af2ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 08:49:35.7765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aBiG5azMEE8dORXV9PUl6NZjfWkshj4mIS1OdI6Dh35QtDkiVG1lfZbNnZwdI7Olb6BzX8ZCSSEzyhPMEVMwGs+O9rH5GIF5QyAwR4OyrSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4238
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/09/2020 05:06, Damien Le Moal wrote:=0A=
> May be you meant something like "leave a zone not active after a truncate=
 when=0A=
> the zone file is open for writing" ?=0A=
=0A=
No I meant, we shouldn't decrement the 's_open_zones' count on truncate to =
0=0A=
or full, when a zone is still opened for write. Because if we do, another t=
hread=0A=
could open the last available open zone and the application won't be able t=
o write=0A=
to a previously opened zone, if that makes sense.=0A=
