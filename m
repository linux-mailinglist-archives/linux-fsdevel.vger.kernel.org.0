Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543E820325E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 10:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgFVIr7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 04:47:59 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:24570 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgFVIr6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592815678; x=1624351678;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=OSNznTDG9GhBqqzzztzwFJvVEI+9trpylvGNuDSTUl1NGVJc37BF0fqn
   wLd28hfC/stsz6MlXrxHWfIuCE4kemVc7aOpmLUHTKddr6MWQRDnlEmyF
   U+Jgw8BygvyHD9MurzTsZ7n4Q2KYbNgkF3nJDPjU9ruKyLAPdtTNkDwOv
   /ILZ4HxsIEJkDkHbgjOy9g4aQqT95JVW8ED3cfR2Kcbfcf9pRxxCYdycc
   fccCiV+InFAlXsrdiJiaGkBI8N0NlEfnl7AvWwpM1lCQWL8Huup17BxhI
   cVUJ5vn6eQqsCslSg0gWF04HDEX6f5b6qfE+3Nb65l8QHXr1AOa6XhHtK
   w==;
IronPort-SDR: JIDCc/xgnM7f209KYdbA3eZQEtTbhIshFfslTXFrRC5AksvbektAiIcMNhG66DVi+cDMues1Iy
 ULEKtNcTGEe1+Zh4SGpZS5vl6r8EcWhJ3qCdSjRfH5UyA/r9/lL721ae2o7Jcf+5wdwf664UlF
 poB+0qy1evAF958bLKgJ1Rq4K2kdMFmpottinQOqw/MNLdrzc+0ZdrfKT+0tMlXADHWhXg2Idn
 DJeCZ0CHP1PIcVXhkUfoRgfG0L0WCr5e2NyOcY1yIkE9dOgjyhJ72PmwO//gMnn1I37nSfdAa+
 6ho=
X-IronPort-AV: E=Sophos;i="5.75,266,1589212800"; 
   d="scan'208";a="249796329"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2020 16:47:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfqgANpY6zoUV+0F4dlOlf+nT1Ipvfse1964GX3lKgHG6G2hpvK+spjfKepzpImru7/VdMjeelWna5+zBhVBdMegQx2z9fR5PGTcjY5KdLSWhvaJfoUo8ZXPwFdjQcYnOI7y92SjizYHvMlEqwjGucfMeDtSfLxja8AjgCnk8qKwd29+6dsKrJTizQjPch3LPEKRfnEjMKJhls6ABv5VtsuVBdfIhmd/V9A+sEglNLm9Srs5W6BDcR1c3rHre3lXq8n6RE1ijkGhShkxMJ7Aw4a4JNzu81EyOaNQ+QnDpuAEiGCqc/S2TiBGZKSMWAWAwWqLjdwjJBOoQlTe1DZ5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=niYo+/2PksUXY4xh7hTIPU7S1k3MOgvPbey2x+GlrmdmlHidoyiI7T72Uw1Sha9Pm2iOS8WTvxPQsPVJmM9Dl4N1coeluSLeXg2r6JPlsQb7nL1grS1fkodE+AAVkVu6pcRYYq4eM9Zlnk1ItwFafzlfjZnVaVsuy3h5kFeaj9snAii5FkWB8mNWtWLSB5KHVKb3NEyaHidGkItJk9A/qqzGafENqvNgftSfECWreAhJJ1Wo9TsZXMo3r5IZrQZ9MD+v+H1MuNRZwX81zmXsnQXCxEl5O0bLw55EgfZcjQvgyYi/GY4j0vSJbcCOVbF04IOVl46GJCdbiySKALCMJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=NYzVu4razF5DZILzUWxSy0tKnXkXAy9uzyiyN7erAKqnVd+VMTpvezsiD3O0qXv+zmnSY4l0M7BB3jLUjlvgN06Ul1bEVkra2fmTT/jro8xtZlR2Q4OPB1n55Wm9iY/vJ7QOHU0gfyPypi001aI3vcd5ZNES4YaT9hiUh5KBhaQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5117.namprd04.prod.outlook.com
 (2603:10b6:805:93::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 08:47:55 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 08:47:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/10] block: mark bd_finish_claiming static
Thread-Topic: [PATCH 02/10] block: mark bd_finish_claiming static
Thread-Index: AQHWRtLoL2GtRs5txECaKpy2txbRcg==
Date:   Mon, 22 Jun 2020 08:47:55 +0000
Message-ID: <SN4PR0401MB35987754B7AC39A6ECB0AFC29B970@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200620071644.463185-1-hch@lst.de>
 <20200620071644.463185-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1597:de01:e494:6330:3987:7eb6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a2589c8a-bf47-460f-cbae-08d81688f506
x-ms-traffictypediagnostic: SN6PR04MB5117:
x-microsoft-antispam-prvs: <SN6PR04MB5117B8AB4622D25E83B44E259B970@SN6PR04MB5117.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sFFMjJM1C6UFpp+4KVdhCvZkBQlT8wsoNNogMzuiANX1paQMP0RS2EzsC9PQkAuChrGC81kraK/+zQhfRzHVGitt+fF+wCWpOKoAZ6m6enPqeMUyle6yZRr5x/3IUFBu9/ucLU1Kekg7H7dvgj6F/a+txZX7tBsxvSxRvTOm3skL+BvVoTcuxhoGROjH0VO5B/cgYMKbrbDC/CIDLMAA2443U0keGffC6AVbg5RbF/OblBpMr9ljzoBYD7dszSTQbZhnThFXSuOiNwX1FNRfbg4ZeKiyX93SFvGOju0Jenq+JvkWanfj57TRp7oOAKXl+2r2mKNXjhKHyVe7Bh57tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(478600001)(5660300002)(52536014)(76116006)(8676002)(91956017)(54906003)(66446008)(66946007)(8936002)(110136005)(19618925003)(4270600006)(316002)(66556008)(64756008)(66476007)(558084003)(9686003)(4326008)(33656002)(86362001)(186003)(6506007)(55016002)(2906002)(7696005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: eB91wJBVmxxTtAwB/gDMsNJ30VqtwTbeDot3Cw5KU2xcRbdB7kcKUri2vk+95i8ESHhgnMggbWOq2dhK2BMbntF8LqBTKWukmTdnmWz7E5x9KsV1AlAnYR+79kkdzONx8nZyafMXOfEU1p4HO/E3pvKETUp0GjRdSyfsx5kOEoo/H608LWmNTUxP22owGsZLUR2CnQGFkL7tYPo4Hinb+pk5omMBIUD1uwBV00EHtuP4Fe/8AHoNTac0X/tcb3fMWJqu58lJu6yZCr3vG07CoyZGcMadtXbWlGnpJnG5Tbw0crqCktPOJgUMVpgH51bV8/xdONHHcUWFHjkWug458ojQzhMxlBmrEOC+6ycKzdU3GWKihx85yDgfILojETKh//wpDnOwXc76delhLWMJqfM7wZJCbd0hhxmxeS0ljmniH/uMiMmbLm9RxxlHGh1w3o3srnlGSjH2IPwM95gN7U8/Z6NENEWyfpGo0sdizLd9BsIDPH6pu8JBhGyyoLKzD+AW9GUSr2dKwj+5xsBeUkJwuvFYCne8f2fFxnLh/SjCM5/fu77PY8hTnInHPGak
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2589c8a-bf47-460f-cbae-08d81688f506
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 08:47:55.4018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRqcTJy0+jaSkOsKKKvonAhCYITQBIF3+yXsbARZN1uEUioqmmHgenM4k8LeHXguKSq5atx1lcjgpE0Pq9hVXRcGPCA1Ep1lDwzj98Ouj/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5117
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
