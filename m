Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E722F29AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 09:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404377AbhALIHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 03:07:07 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:59401 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404365AbhALIHG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610438827; x=1641974827;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NEEiqnyR6AYDejVazhEdM1NiebL7QGa+hO89s2u/Ohg=;
  b=A6pw9wHDw3z2cx2WmNdQOyHe7NpP2+1SmDkAeIzFW8If+FwyV9ZtZbHF
   i9lTO2alm+tDCpwciB43DssnjkEvkWLbniSarHayfWt7HCRgKaT9aCv4U
   p+po4qfDeKQyxpmJf9FXF9TeNRqbnBl2Q8AKN+lhJxZJwDWcKTbpjCTVw
   hNwDr3hA5E6Ko1CvrZpTmXHpuaJuWjAl87lvDfEZy+2lOtPLuGpNtAH/r
   KCOU4Z+3SY2peoK+WosWzDdYWs5gcbpfAuLaxpLYiCyzQeOOCxABKyhrI
   yzp4mpPkV4K9dujb9O7jSJAyia4gVd9uq+Runf/Clt4LukmwuMAvIR+H2
   A==;
IronPort-SDR: Pwql7p+wmY53E9ARfPaVYdV8VnxhGaedpvrsTzp2vxaY341SEzBeb/wTyeng+zcR8Iac9kJ2oE
 Er3yLRUW204BOV+gpJAp2G4EKy1E7jCYrDprkRGFVq7jM0MjhcIGKw3VLSlkMfQTDH7FBV3Q40
 ZowS3PkiCzm8vIUDA1z85DHtAXX7jHhoYnzvXB8oPehApzoEEExYn0tuUJO0DnqNwLPbNYZ+aL
 X9wdbaSAQANjV2SRbIr434ym+frK3YGsZuFheDn7oChIS9cUNNLBPj5lGnxfP2Wv1NRrzpFbh7
 e+c=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="158394868"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 16:05:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmpUv4ynfLQ3zCvjGSbRdG150tpRFMuo/zItL9a1D8KH9ukrMLz3E2gqddaW2v3ggI88/Ja59m2zaHcIZ+bxnH7EfrQzJKT2ByvV2IEDoOwTKlajpp5w3Ep4QOftH7sFGOoYy+tz039Hl64fTmemqwXrsy8yEAfstMeTwuvj0uzkNgkjIeGdUIJsRbmGZUFOkjlbWrZlhe+kadNwpZ5HSk9o+5LZ/7Ba3kUfCYG20l8c5uEKJKlfVSFg7NUCmB2rPrYicvEr+b5QHBslRxfMNTmPl1EdMOqbNQKbfYOgwg2fjL6oIwgocZqT3UXWLpV4zn/1W6LBM/1rtG4qkdvXqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fe/5fKHoZxOFTUtE+juIZ28spvncTJM6qA1nCLvvpOA=;
 b=kHrY8G8c89EdSU9hzD2zmoomaHF0XyTHRwp8eQS5RObSTzJSigVf0IzhjGdOg/sIrabZtGGrvVLIUgj/3TN46kwK9VGegPoP51cIb06hPV4F8VcaA9c9L8oQ2+d2U/VjMbals5xQ9hotzt3kBAa298ih1MyKq1f5YFRsRxR/pBH5wMRwVjbzW0A8Ztb+cvb+uvJy7//W7Gz4q357e/0Kr2xK9Y9WuyLlOgjZzwjj6JdyT9GqVGHcN/Mm7099/on0KQsgcMuEkiVAqizBWLkP/GH0lRoyT0pG59/h8eKlS8JoNW0tvnszlyAi8tQvngef8BO2GGTOQNP+7eS0vEowFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fe/5fKHoZxOFTUtE+juIZ28spvncTJM6qA1nCLvvpOA=;
 b=CmtqVmBg3J0fz6G+DzgpmjPirxPjJNqyiFTu62zuBd5P4B6uCY/WqoI/LKtKiX0CwDaNDWtgKh305u10HHFca3HnU1wN9CnF1+e6Erucs8auqSjtPhfSQz8cR7zU1ndafqwID5FpqQHYlCmFtpLa8ZyF7F/oKwDfUBvwR6cKMMQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA0PR04MB7436.namprd04.prod.outlook.com
 (2603:10b6:806:e0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 08:05:50 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e%3]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 08:05:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v11 05/40] btrfs: release path before calling into
 btrfs_load_block_group_zone_info
Thread-Topic: [PATCH v11 05/40] btrfs: release path before calling into
 btrfs_load_block_group_zone_info
Thread-Index: AQHW2BWcsaxUISKqhk6MwbLgb5WmWw==
Date:   Tue, 12 Jan 2021 08:05:49 +0000
Message-ID: <SN4PR0401MB3598BAACCF1B65FF6FF40E7D9BAA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <8fa3073375cf26759f9c5d3ce083c64d573ad9a6.1608608848.git.naohiro.aota@wdc.com>
 <3f611f04-39fa-e95e-09f2-28c01f5e2a80@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15c4:1c01:480d:3d08:9ab6:e110]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3f44a631-fb5b-4b9d-33ed-08d8b6d0dffb
x-ms-traffictypediagnostic: SA0PR04MB7436:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR04MB74364F45FBB10987D09CB7379BAA0@SA0PR04MB7436.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kE4LqDebRSd1OIWJFCJ1QQe/cBrR1OlQvFcO0rZFrdhAmTUs5L5dXaud+TNjDlrWS4C5ICPZCotyZRmR0xIycYGhbLNVzIllR/Gg8404wwVe6L+tjrXYtCvJtRkdOhoZ/KBBgwAuDIkhl7mmOaZx33JXGx4M+PcHP3o1tUAqn8N8Tgmdo4AKppUtIzgeaWoZHB2mmuJUI+IhS0AUO6SQgYLbuGUxkXFoW13DbhzEcVbB18sSWjUhauK6T9CK7y185YllbTDvwvbldh1nOVp73jFoBEP1FaygmE2H/H1luuTmZenje09kOpFiXo96XnYDtZGP66TLSB8GGGOz+ADrj8Oh7ew/QRQITk+fIVWSPpeITt4FIzHbdb/Tqyc4zIcSGQaWWE/S3iHBwQYmlnChuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(9686003)(7696005)(91956017)(5660300002)(186003)(52536014)(4326008)(8936002)(66476007)(83380400001)(478600001)(316002)(2906002)(53546011)(6506007)(33656002)(55016002)(4744005)(76116006)(64756008)(66556008)(54906003)(66946007)(86362001)(66446008)(110136005)(8676002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?n5F39BsG419pXTkNGQOd/5z9z1yapkVHClJ7RClGAhRrMIAga8boO9T/11Gv?=
 =?us-ascii?Q?XpJ4zZv2nj4zoqk2zL/Pe09zVbtkgU/Ukzhvg2v/vzyd1uAZEcxsd9D9jjLY?=
 =?us-ascii?Q?8c/D+pczkukCjoAkYraCdHwZxsBEfRt/2bYfwJqcD4S/Kvx/WKJqlkKHDG71?=
 =?us-ascii?Q?N7FCoOwww/iJRZPHUmCM7EwaghP1Qf3S7ai6o8Sv1xK9QHb5BAmWcSesvs6a?=
 =?us-ascii?Q?DoY89cl61CW8+E1MEbmWBEflDIIjzYqFYpwebFmBB6YhLQ2fZnaA81G4lIny?=
 =?us-ascii?Q?LuauvsReTEeKYfHr0WyKvxdiYiYUaGf+dKz1AV+1SrjUl9Q7rCNSJC+EMjT9?=
 =?us-ascii?Q?oL3X+odtH8FbV9tFhhigXupblF5/QoHLvgQz4l2bA8SRryvC9M1R3UGsISwv?=
 =?us-ascii?Q?UBxz2SAapSeMTU8f79zLSGg00B0oI6ISIG/7DupilqVVkjcq5qV2LzJmRW43?=
 =?us-ascii?Q?yKH3T9IDAkvukw6w4WBgCWIaY9R/zMLH0/UZeAtIFis0j4nJaaxCWpikcVe4?=
 =?us-ascii?Q?bwrC+Ua/Yt1RKUOlgjQFEP0p+xHMetZbQ5x/jwucGrbm4gnu1GfoEkeP10Kf?=
 =?us-ascii?Q?PfX1VfAiEgT8Z8rX0TtmtI6flVkXi0S7ztzf8qe7OEYcFU5k/QNixWCjrQb0?=
 =?us-ascii?Q?COaxjRG+Sk7zBne+BgU14kvUfOKx473KsmpI4MKgNnASas2p0F1yeZoVzR+y?=
 =?us-ascii?Q?ktEs7aTOtUQijjQK//Pa3g+BS6BibqgXFcpFrAkl39lrf7h+B83W4jW6DfDy?=
 =?us-ascii?Q?pgqRMmv6QgwT75X0V0tUf+t4Vb8UmaH9NA/RyEX+1fPXY+l64GWsUSCQI44i?=
 =?us-ascii?Q?ZdRrys3WATvxswjAeOhbOIBs3GWxkwwvHBf93b/6VJYVukWocNhtu1CnXcoh?=
 =?us-ascii?Q?6GhvzgrjoR4HsK+rGY5Y09v3PyYVndeRgL+pLg96xxW99bck4NrNQz0pZvyY?=
 =?us-ascii?Q?Emc+LdWGrDIXvLuPv+Xicm1WOF6SOAN3nWdE6DKeW09CUByTDcraE7uWZexF?=
 =?us-ascii?Q?hc12c20mPPKbpPg7noewEvY2ybbZXuPK/5iRriyc9uBF1gZ4UuZ6p3yi4Ewh?=
 =?us-ascii?Q?QuR6ns5z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f44a631-fb5b-4b9d-33ed-08d8b6d0dffb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 08:05:49.9230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C7wPj5o8ABtmVhgiay/31fX4Vinp4pC5A54/RQrKGQERwS4hW1EKVFBhtgZVvxKaQOhwz+qQgrtpkOyc3IYBL5QUN2rDPtrg8QYYVM7EZaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7436
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/01/2021 21:01, Josef Bacik wrote:=0A=
> Instead why don't we just read in the bgi into the stack, and pass the po=
inter =0A=
> into read_one_block_group(), drop the path before calling read_one_block_=
group? =0A=
>   We don't use the path in read_one_block_group, there's no reason to pas=
s it =0A=
> in.  It'll fix your problem and make it a little cleaner.=0A=
=0A=
Good point, I'll fix it up.=0A=
