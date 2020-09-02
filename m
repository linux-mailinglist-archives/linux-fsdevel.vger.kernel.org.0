Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D340725AEAB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgIBPUd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:20:33 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5635 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgIBPUB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599060001; x=1630596001;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=QtDyXSnHchQIIL7qZGAUIMNu0JwTlPJSBC1pPJDB+EmHLZYrnz7zRd19
   jJnbiD8DSs+VrW78GxNu2+0nTp/o1lK1MO82pIHgFsy+q8kgAGMiwTOne
   wEIpV0vYVzGyJ3j5HWsxOc9c/8CxXpTeNhW1dS+Z7PowCe6kYzPZ0Xcm5
   lRpiYCVeeRd53yGH1Y59/8Ufc7FXrWGbIdf5GnGLgnjjO0Be+rtvSFJMp
   +LQ84LvDkkjEC03hAMnLsiD8Iuw4CJffUhLFJZ8RXhYG80gELYWkkrH/h
   d4h5T5Gb4ER+F+W1MyywxxKhhd5r+XCVCcYNDyNm5z+Q37kaBFXFetSK9
   g==;
IronPort-SDR: qm+wkq8xFrBae+pSqXChyUNW3LLtctHSjSZX/A28gRinVARs+rUfXd7luQJy8v4T6Av9H5BSMk
 E+zgoDUSe+LphL1y6oR5lJ4oTofOW/n7LeblS2uLCUN4nDR2zN7UyyHtb6YfB7eJoSx2RLeTyB
 RQCCLdSg7iw93V4dLzxrZq27IaayBumdO7GGTDCGxWWow1KQtCwzz76kg3+0i30Fp22bQwWl+N
 KHtRf/tZDB8bmBxgmsdoP20ivoQk6JRAhoAADo7jMQRK4gKjnWRd3/a+TyVWX7LK3lV8Lq0bPM
 7iU=
X-IronPort-AV: E=Sophos;i="5.76,383,1592841600"; 
   d="scan'208";a="150759789"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 23:17:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJPrkFdgIMNdbbeGB/EZYXlcTzBIvkcdBxiThdfYqypkuF+JXQ1rTXsSA7U0XnJXR6p49f33Lb8DyHKmafIZsJTew9ICAQgJQaZtOBo5DOQi5XhP89DdPDhzWbTSSlhS3yKutzcHbTWzoZVYxbbGVy/OZz8IMifFUQSf6+r+N/6GkMrkMoeWknPYxUbKK0TWudDQxw+l11Y1XkxWHR0wApgc6/jdnBvnX4JiEPDQCafJ2m6b6n3oTfDR3CHkMAHSu0xcLMmSoPepjPASxLrumWFRZCubKAHd7T+cgpfLUswUN8ucltafwfgcw7Tv9cNGFr0HL3JqNXkL4qzS+pmrgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=nDKVkL11rluBInr3sV+3EcYSQ1yPkQsd+a6xEx140hLzlYiBSX+9dSrpeaKjiot5EVObHhBo0ULe5v4g09GlB9kZqs6ANMeGg2KaYKtD07QFr35hsBUzeLR2zK4NLisV5fmthc/RHIjbKh0jjnIPf25+liP6ti/AfxH0rQA/GKXfLT1t0kT/W1nsFb3O3WPEQqyMS76sI3vEfnsI1H36+97JokFqXEYwNkH1n/TwcIcg3VpQKGvDsbup07vfEQpQtxldQ5UDT+IA15gyuIGuWA3EjFfS1e6GJPKAWzQq6ahBI2hZ7VSBLGtoBEAbWwbauMimRcxiOhT6Xh8k+bq6mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Nj82cxBA5MfD0fSxT1RCG6oEmkUG/yFDFpcUBdlCbCCCb4PGkHDX+tbKv/czGJhhXbOukXDh8fBMcZx2YqMGfpL334bLZXQc8W7u6XL728AxOjMD5v2tz6fJmWaMjFPHgFD6FmVfahJnxxhBAK0Ecm2Snzaibe383wS4YboXwFo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4687.namprd04.prod.outlook.com
 (2603:10b6:805:aa::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 15:17:57 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 15:17:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Denis Efremov <efremov@linux.com>, Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 01/19] block: add a bdev_check_media_change helper
Thread-Topic: [PATCH 01/19] block: add a bdev_check_media_change helper
Thread-Index: AQHWgTf75qeqMepUBUy1dxdYyrma3w==
Date:   Wed, 2 Sep 2020 15:17:57 +0000
Message-ID: <SN4PR0401MB3598CB5E6250A5B2A091C2509B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200902141218.212614-1-hch@lst.de>
 <20200902141218.212614-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:1584:4722:fd5f:b30e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 12fc4811-5949-4793-9bbb-08d84f535f45
x-ms-traffictypediagnostic: SN6PR04MB4687:
x-microsoft-antispam-prvs: <SN6PR04MB4687E991A78B5EE6752CA2CC9B2F0@SN6PR04MB4687.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7UcKQgibhhz8i6YTzhrno02hgDkKf/35L1vhTlWqBlxZOVOZ5pnEB6InbbIdCwffqUEEtEVcAHMms/mj2hh5Lh9u8HLOpP2+EwhEJzrE6h+xUc7pVEwTqTJynEXx7FO4JBAerIQRUCGzu60bBdHM0WKZROo6Hcq8U7GLpEl72/NiF+hFzlj1/PJz//apww08v3sBoBYh0ptybS5RyQlzA7bK0BGfpj6Pe4bUhDcUk5Qyb0pEn9shImQygNB6pL8Zb/GdBiqU1iZmIybMeYChvDJDw5SFIIpDw+eAObo56ex5Cpum0Zav0pQLN4F5v3hz/JmU8vijDmnXb5OQRLmf/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(376002)(346002)(136003)(366004)(478600001)(186003)(4270600006)(55016002)(8676002)(110136005)(54906003)(8936002)(2906002)(52536014)(6506007)(7696005)(19618925003)(86362001)(66446008)(558084003)(71200400001)(9686003)(66946007)(64756008)(33656002)(66476007)(7416002)(76116006)(66556008)(5660300002)(4326008)(91956017)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: x1dvDWvH89OyRHg01tNakc2osJy+psdEyke29wtH1m2rR9/UxTCcH6HQJnIWPoEWasAoX0SuRcI59+Z9u7saPOtg5MJgyq6OEFB/nyyfqH2Y7kWCBrGTFO1AWFveo9zXDQgsO/TeK7aT7jjGXL3iyCjJD+4vFuYUzJW38THzNriuedAc2qz4L2w03PdqKHbIPNYWBh+OgpWR6z4lJWH/70AWG9IVgIto0zshz4y/EGi2Lfd7bTghCBFAuaXGJIsZsIIYmJMlj9DVt24P9uLgRLCQn7pXUsuwxMwNPwzBa6YCkEBQBj//J3Tv/XtupmQnS6QDsydIJ2b7Cdnv0MXTV6q5iiYV7Zqg3VVf3SV9JQPxEbXoPpkk9guChg0oiNhSeY5vYvkx3hKAi+Jua+FG20yWlZ7yTNdJdCqf22YssBhCgJD+L9IZUizfyiakdSG4TCSQmHHJWkV4dD36Lvq5GlOUUHKo8p2B9DQ13Dp5B/7vkMkDuyZ8fvXoVPFTAgalAie7/Q+9gtTPSWertugVY1qO5ewFjrdQx+OyADgJpwLIQCHclI7EgEpQfdw81hL7+Sn8mOCF2CXm8yJeazpT9eCwo3uaOXaTRYbMv8WZwe7qL55r1igXX0Oq6gUrysIYRmTqdEi3x1Bopvq0BsaqYJy3A3+2nivxLv6CWZRqlovAwFlm3npknwkBGWEPcU9cOKAMEuhDkxj2nN4zDVEJfw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fc4811-5949-4793-9bbb-08d84f535f45
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 15:17:57.0753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: poi3qVj1Bt8H4c9Cd3vj2oxQ4KEEz8EKRxQ+9t+jv1UjVQMpQnYsYNoS/uIfUGPhYuYQYatI35Ikd3i7dxdqvWn/9DS7DpgZ5pA5ImrZdgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4687
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
