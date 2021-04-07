Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09087356C54
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 14:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243157AbhDGMkj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 08:40:39 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:49388 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhDGMkh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617799228; x=1649335228;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rtK0Ox/F6AoWBEIBgpPLkdwY3Q6kj00LyodP850GjGI=;
  b=d69le2IGkeB3tkEmPS4xt46PhZkswt5mpfKGy8qkB/3LwpOdZM/Qlddt
   cAqnuMlOFGCzr/4v6YLPoXTDWdpo+kPHZGe5hsxfR0cpejx5yFDED2j+Y
   SfFCbk2YKM7HzcO745uYH8KstzaidCHrJymoWy92P/M13AxG5Ws2HrjCY
   eY3tYI7CHYsEApeUF3S+dylaadJh2llTfWCJerx2icN2TZygER2HSbkP5
   Ze6W8hGQOOpUN+uOTn4tkLiTU5ILJNyOKvFkAF9Bke5AB4TqVCg7ufK7X
   BAfMqLhLUtxAwPVU9UaPQEpSnHEg6D1iuTFlu+xZ3pBQ8v8vccus2hlUt
   Q==;
IronPort-SDR: wbiBz2ihjSp01Tf4eSsvvsHVdE8NhWE3iQhNM3BRledS365rys+d5ZoGq7O63AsLk1gp3D90XC
 TwZ3t/CQjfck7uqS7QZplddgPXV8P5HOapNDsx3Ek7DZvN5dGlmb+D2jppyXMDCjT2Gq7vXUv/
 29+xZMbLYsAy4l1lHvZpC9wG9yQyrlwrc83P0S26Cmkw9GF/ZGprY1cFBL8bgd8XwEOXJDtYfd
 ziVtYAOq39VYxwuMGtGTsE55ZJNlHepsV+8S079SGak+0iOKORU7eEfF+7bdQeeXpFzz06XoVE
 Hjk=
X-IronPort-AV: E=Sophos;i="5.82,203,1613404800"; 
   d="scan'208";a="163830502"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2021 20:40:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcOfiqm8s6QHAyem+xOPkA3gc6+OEjSwH6i3H7u8wxvn0LgDCX1aPXvUgwD+DjltteY9cZu6gfcT8z1m4SBDhCJZEB9ZRi148UY0TrlKoIpuvvybmhqFTBCDC86cbKqL3fwo4hROGO1qEThHdkq7D6paf0UZ6zPhaa4CGhrDJR6ni+ukfD88aDSXBd3YqnMWg6MNE+3pP51sJTNcUvNO+HUpcSLVTWkgjqzf76KiFsfZWeyxHpNwd+qyO32KcwmceP5FhbpIRIJ8mDEhpYUaMZfuhmai/fi+C4zRpQhHlw8S3QhNmr6/FZodgNahSh1pea6c2h9VbzcTEC9Rel4ULA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMOueMvcX5yM8V1KG0//76einmIxZvXS/dBvNHF8NEs=;
 b=b6WX2cYBqEV3PNIlojhYpU2W7/NjeKnK8T6ZVkHB5qB8Ma6V8w/G3q4I91tUbyRBKp+0YxqcuzbJEk5CtBRHL1eCZVBdDAcCW2kgJTdBAQLHEc1xbaqnYyOgN1nTC+zPkNmS2UOQyXiJKGUxY6bP7r64DvJlJlEAQPejIa6iCLgFTjNU+ZCXzd46zpK+UOLLbYDXoq0JBGWzLkKgcgLFvx+7hTWzDcq5kZ+tdyHJRlgR8W07K8Uan2uXQCr57HP+R2agMYkoO9s7gbujNWZhKV0Kggvgy4uW4tZ/f0KmBzdBSfuaC2D6HMQvMXqFBLJ2cdxL7BhNIPw+fkI8lmJ8uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMOueMvcX5yM8V1KG0//76einmIxZvXS/dBvNHF8NEs=;
 b=G+4fLvCPaPO7Mi8rmMg3i2b2x7B49jz1aktrwnk3xd4wjyCKCSXU5/fjZ+tHCXHNFschVKK9lb4onPgsNOD/12xfTaqPx46bljLFPf46HPPbiR9vsuyJDDnc0pcOTcbZqsM50Xy+8Q+muYIQNuo2iJGBgYl8hkg5WBGUSf9fsqg=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6478.namprd04.prod.outlook.com (2603:10b6:208:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Wed, 7 Apr
 2021 12:39:55 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 12:39:55 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] uapi: fix comment about block device ioctl
Thread-Topic: [PATCH] uapi: fix comment about block device ioctl
Thread-Index: AQHXGgJOtyAvB6cIX02Rb32MAZI59A==
Date:   Wed, 7 Apr 2021 12:39:55 +0000
Message-ID: <BL0PR04MB6514BD9DCA151A7A514D8274E7759@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210316011755.122306-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f060:aa0a:9ee0:dfa8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff2da0b9-b926-4722-4578-08d8f9c23f76
x-ms-traffictypediagnostic: MN2PR04MB6478:
x-microsoft-antispam-prvs: <MN2PR04MB64782C2D1CF34089771EF221E7759@MN2PR04MB6478.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5dWY9PpRz/bDMWB+OKxHNayMv1S/l4PnnyAqcQkUHe+O624mddI4XGHyvcmMzTkajLSTHnumDtFbALA7G9AT9vwajeS/K1y8OKRivGd3+WsHFVpbHbe4e1AEv1pWA4D7tNtMlJZcnn3Tnhy8dNGc8DFE1SH8OwGf5PmwSmuGvlf7RmkIM11rmozAwDtIOXFMUUBQ8fgx2w77Ii/TJgjeB7NCAnTGsf5Aac435hiE7Ys63l03xmiDlTMe0EVe0gzissFRq9j0CmrgXGrw14xqHtuyh/1ILVHroqqciIJpnrHwoFSHoYNNXA5uj7pT9bsDS5Na16tvtlEjSXaMytX43bJb+imeSqCGD8RRoAQ9n3boa68OacG7C8L86OzpOufBng9+HMSy8daLdKR65nM6CWAGpgaMlc7NE8kVmKuk/ev7PZ2KlzElKJOymVW+EvT8Vnantfq2lr2wXcD0QsQuJvdTUJjvgctonC07edsKu9GZgkZvgbHEyMiqggA/AfwTuigFhrA0wRCn3c6E42ATxy3P3uxATvQTgRxguc0Yr95VorTg05gaFZTWLJoo0g5jfuAntTcr0oIdLosW6kkzhUc9HSqmoSxY+4tUmDdTINWNnSO0wV1okQvL0AoIBsD5YIhsxs2WdjOxfH0uHyYYm6nZjGYRRES6CidK1udQX78=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(110136005)(316002)(9686003)(4744005)(55016002)(8936002)(186003)(8676002)(71200400001)(7696005)(86362001)(2906002)(38100700001)(478600001)(64756008)(66446008)(66556008)(66476007)(76116006)(66946007)(91956017)(5660300002)(33656002)(52536014)(6506007)(53546011)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kUCOL+JZDMT2BbzlVjwd1TGz4BZEsyeGr6W9WPeVVzwI/IBk4+gacBS3SPO4?=
 =?us-ascii?Q?aLDMkQWLv3M3uEsgKCAHppxoSenas+hyBnGNktAqsMQhCIbF2lUeBmXzviKp?=
 =?us-ascii?Q?LLWnPIOt0fi+Ug+S57EtrKbLfiEQLU5BuUh49YMRiUnzAFl3PGgDnG/iUtfK?=
 =?us-ascii?Q?v/bqnGGpVM4Oz9QSNgy7NMV5fiuUwxDGRp2z6iwgziI+jX880hKwi9hBFetq?=
 =?us-ascii?Q?UUyHNrBWhULj8jStz5LdJ5p2uNCWbuix1ht3n0ZTKNsJZfp3I6ds3ZRhyAd0?=
 =?us-ascii?Q?YEqZfqf1NgIVMzRHCNdgGcfcvmvLzGPJVxP8HJUXTiGkjnqh8ikB3zJWgB+j?=
 =?us-ascii?Q?Or0F3BYQzCGsb+x/P0YPDfIsvtYTPFN7wtrQ1ZseEzFik7GdXYs50IHOBjD5?=
 =?us-ascii?Q?+FMCVLVYz76GnrU8VqSSDBjsQnhivzJgeAbJwnlCF4YuRZtJRjYoazWQ6rhx?=
 =?us-ascii?Q?Nxqc8BYspzgOs/bsrjHSOg7v3oPUdBiLtVJjr616vPztCdZJanc3HbnmL8aU?=
 =?us-ascii?Q?DKksxJKidCGcovwL2AzWUuoNBG5K0Sxtb3M1EjDWbAvB2CUfJ1uoJNJhPHmu?=
 =?us-ascii?Q?IyIvcKYkBEelt+1f+nMxT9jNICkMCtrTt+UewgTvXk2OIUmijzkTyTsqfcA9?=
 =?us-ascii?Q?e0dTp1EkYq2weK8A/Z8YqRHWt3t3fI8o415MCLsG6Ikn19kIav6vPKZj9O3o?=
 =?us-ascii?Q?HFaBnIWGEjZjG3paOvEeBp2QGGxjQDHZKhVmgY94fOmpksy9+W/oQk9sCJ46?=
 =?us-ascii?Q?4X55d59Qyx8qJ0PRrQaQYmpbuzVtFwF93moE02mz2KQ8pFIM1e8gMi4fAzme?=
 =?us-ascii?Q?ZTQKbje/rJk2rXkhPPb71hHN5HNplZhQmJKmE+GMAK93Ij1ygLmIzTF2aYIV?=
 =?us-ascii?Q?cvYt3SNL34VjToh1vbVXpKxZ1rkqZWBQTJQ9fqsFD5Uh4gqd/UdQWjC5DcJS?=
 =?us-ascii?Q?/4Q7IB9aeyr7a45i8GJYvWe9IlGW3HZX4b4Zg6gFkSMV10h2Kv9eqkf1YYy8?=
 =?us-ascii?Q?y1f/IhU4noCZPOrLXW7e8gnTX3zePyByt96hiTk+xT7WF9UAPsdMUoqP+OGb?=
 =?us-ascii?Q?B44CCOVG7JYM780zEuMAgxYSrU2CdouizsWtGHKe5LYNyvv9DU9CSyM0+9KB?=
 =?us-ascii?Q?MTiO79/VEcH7Aw4MKw56/fMv1uIGCIe7b8qL5MVt9nJEWzwyrS6V3XBeajN9?=
 =?us-ascii?Q?HhB7im6OYNVChu9oQeqnPnhYNCw/4zicd/z5SPTx4rty0qpgx8sR13e/34HL?=
 =?us-ascii?Q?X6hsBkzsw/y3TUtc1RxJ0I2yyqppMEVbbpp/jUDHn8GLidZrMwLrDDIh62gI?=
 =?us-ascii?Q?tjYAidaLf0Hkoo10et9jRPrCLnJnfTi3G4QQWZQUZ8lQpESO7N/UKu6lk1gC?=
 =?us-ascii?Q?ODBDmU4qGN/NbgusJkbPC+A4rTX6yXyy8CGEKRHJkPTQGnif1Q=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2da0b9-b926-4722-4578-08d8f9c23f76
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 12:39:55.5547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8bmQgXT1SEN7c1cORgnWxy48SF1CL80TyKlWcXLGAwS8McoEtu3SEI/ZXeZBPyo76kF+1bTaxZ1mSp/vxp4/dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6478
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/03/16 10:18, Damien Le Moal wrote:=0A=
> Fix the comment mentioning ioctl command range used for zoned block=0A=
> devices to reflect the range of commands actually implemented.=0A=
> =0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> ---=0A=
>  include/uapi/linux/fs.h | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h=0A=
> index f44eb0a04afd..4c32e97dcdf0 100644=0A=
> --- a/include/uapi/linux/fs.h=0A=
> +++ b/include/uapi/linux/fs.h=0A=
> @@ -185,7 +185,7 @@ struct fsxattr {=0A=
>  #define BLKROTATIONAL _IO(0x12,126)=0A=
>  #define BLKZEROOUT _IO(0x12,127)=0A=
>  /*=0A=
> - * A jump here: 130-131 are reserved for zoned block devices=0A=
> + * A jump here: 130-136 are reserved for zoned block devices=0A=
>   * (see uapi/linux/blkzoned.h)=0A=
>   */=0A=
=0A=
Al,=0A=
=0A=
Ping ?=0A=
Can you take this or should it go through the blok tree ?=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
