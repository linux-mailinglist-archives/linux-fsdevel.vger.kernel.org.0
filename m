Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6635720337A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 11:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgFVJdq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 05:33:46 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40050 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgFVJdp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592818424; x=1624354424;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=EosOHdcNhIQZPsarzUipZwyuwMKIsqtaOVO4Tqf620zYrHGTI+fVgCPh
   JnBo7+al1asD+DA+H+jpjF5l5z0ECNVLe5G4Jwqw/8+5NRfL340P0RG/0
   sfmIq0F45GoPPXXANXM3LAv7Q4KIear+MVu0aZ6mrqBEVWdO8TCRUTh+O
   lqp0cX+TfvW2lP9r5PNilddO3J+c9fuadzQYf/LLM722v6UdQMnUhdPix
   jxNBl0yCN7zJhhNilNbyqPBQnycp1ZLy9dZuh/FGKmYL5yGFgRBZ7jvT+
   5R1btHUBxLwT39C9fZFUyMtgPwypoNTnbwz3rgUNlRC7rMwe0k/LqN8Bt
   Q==;
IronPort-SDR: td87eiWz1CCwjjWem5LNZqPOS6aBGd1pcfpPpm8JNGqEGiRHqCbyFoCgVWhjF2rKXy5JnQf8fZ
 YMWbji+7DdvkLQp1By0q0zV1bgndyQSHGvHRkPyOtMutlk+5D/FJBmec6kEymsN/1tmLLvar+j
 obkLOK/keTrM4A5Yi9jZvesjmB2D44Nvs3fNjK11JhwYUAkHIlELlFCx5J9MZxBaUUxpHPd6y/
 lTSLCWiW8esaX7hIE5L5cU6873wEmAj+zUfejcPorsgCW3ecWx876ROAwQwCyyVeZCGP9ZpFyk
 d7k=
X-IronPort-AV: E=Sophos;i="5.75,266,1589212800"; 
   d="scan'208";a="249799322"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2020 17:33:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnVW0v0ZBkcE4gudd808xkoKznqCdaVaX0mJK8y6B9EJuIOdW3XIDNczxhCXFGoXa0vqZjUSSzbAweuFQyjjFymaeWw5V1t/Vfirw3xFH+HwCDU13CLqkRC8zgU7SCz89uZaaIDYuaT3yM4bdKiaa13ZFc5wEZEMySPbe1ilcQ6/2oOWMbtp6ofq1wb19j8MvDbw3UUpnFH+lmePvHkx6U1qxH+ARVok7paOWcP5FAWcb+Ec//BPq5VT+ccbyfQE5x9YtrYj61h6TRIJdsAa0CNTAWtpbtc7w5iIR6dM0SXHDd0SmxnvCl1MITjiE+J4aS4plfbQSLeGwEdWHxcCDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=J+7+U8OMYqIw1rLC3McO6nhp+LN8iu1LuF1m9/EvfbJ3Hjdf1EUz1IYiGVbP82IOQ0+JnH1DKNuXGBMdcDHduj+S0ODB9roIUUMX+qe98l5Gqqd3bu1Zgvo1SD6LyDh2yTLYXoQ7duHiewDp4yG/Sp2QxmALszHNiIYtRmaA+p7nSJCggQHjR71CKT71LRe4n/9NFL37lgqZRLtijqQQbm+3iq3+ZSHxp6R2ERd6Y072A4holzqXG+Aul96G1j9tzgEZmkQlim5CzKKb9/CSK1pTYqI2+7sv0LTsVU0yrljvI7SKJQBbBUOjTEAE1DSULPrsrkQjkDZvZ1zLBpOZeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=SYwnbOUYIE4qyCXGe6IEUQ/3181uomx49BK5BnuuxfFm61bACZzO1MvmJS29Nx8BWNz7FqjdiTYqN7Y5+mPDxcom1hh7UvzO+LjOiMGC4UVKJgQmXzPa0KdxEKL+xB3mX+m13S70kBCPS28sIFHJJ3sg5ewuNutxp8wwkTyl5Xw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5325.namprd04.prod.outlook.com
 (2603:10b6:805:fb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.25; Mon, 22 Jun
 2020 09:33:41 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 09:33:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/10] block: move block-related definitions out of fs.h
Thread-Topic: [PATCH 07/10] block: move block-related definitions out of fs.h
Thread-Index: AQHWRtLg+Bzh3rXpJEW1DgooscmfuA==
Date:   Mon, 22 Jun 2020 09:33:41 +0000
Message-ID: <SN4PR0401MB359891149C00C30AD3DAC7D59B970@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200620071644.463185-1-hch@lst.de>
 <20200620071644.463185-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1597:de01:e494:6330:3987:7eb6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 486f92b4-ae5b-44d5-08bd-08d8168f59a0
x-ms-traffictypediagnostic: SN6PR04MB5325:
x-microsoft-antispam-prvs: <SN6PR04MB532554B2B248A70677E66DDA9B970@SN6PR04MB5325.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BYjVq/4zvsD2WrbTLssvDjjB6WvwzjgBXpHp/HUCuur/NCuQV2Qd7sRKQS8cknV9XIifOtXWLPQd8nQU9ehUgRAGsqTXKCrQhAFRKtMq3VKPl8NuO7AHfZ9tH6+n+I03mV3moxsXELNwR8y0Q6OtjVpqpo0CIdm3jYuNX/cUNzgJFuUIj+UaSSQk38fsxkQV19Hg9DevOOXRTotIJk0tEMS9BVbn0yUbCdhLbswNULOGTOPXozc8Axqg/8JK5NUr2pOnDw0eCo7TUeQQ4N0JaJTvi30pgOX8R2dLuzXonDee+s0aSXieri+t6emDMOMFYzlTXsJA0jPg2h9qPHXrxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(91956017)(76116006)(66946007)(33656002)(55016002)(52536014)(4270600006)(9686003)(186003)(2906002)(8676002)(8936002)(4326008)(7696005)(54906003)(110136005)(316002)(558084003)(71200400001)(6506007)(5660300002)(64756008)(66446008)(66476007)(66556008)(86362001)(478600001)(19618925003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: UmqoOm8Lo+617HIelYNVX4UGD9wf+Yb9Bh29QCgV45jsexvYu+WzXc8p8uCYs47ZVEkV73qCqc3M8E+3ykBiY8dNwv13hkmttSs0bOXsE6diU4f4dhcqs9qasF63GtXLuUa3NLX7/0NlJTwIuxkFtHjiPfCzRCHituC6bsPeOHmsrRm9jabpL4RU6XGjjG2xdOtvV/KO9jUtUhUpdyb+6AxHBhREDNYxTIW88KoTYlvTPlzRgiPlTD+GP+pp+7QwOkl4moFajD2nTTjAUG7wWx9VqKPe/rJQjhTKDzrgr2J0NHuT+rBWQAJaFyot6imNCGz+dc7UyAX8gIJ591disZIFJZgXBG/ieWz7U3UgbCqNDS0QY4KJKqnUJm6K76KcO269r8x8EWmtiS4U+kbqAKZikry22RCRTU4TG828KV0anngvAqr/fk9E1c+yYr0NvLNKtf1bJLOr5K51Em/dO+45HmmkkHKqs6x3InFZKx6xMUWkseZoWXVwBTgvmq1U+FENf1xTB4YIn0cMZl7mK1BzuA/Z+VhQSuYqe/UqjMMs+MIe/aTMitwVRYJbcpD9
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486f92b4-ae5b-44d5-08bd-08d8168f59a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 09:33:41.1916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8LuK4huvsq66S5GsLpS+8Br3ctYLr1e8IcMawVjBoRQvZIYwbthpixSdPSn8T1aRQG+dLjCiNfgo7oCFb968qn7rfAdD4X1gSww0PA00UU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5325
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
