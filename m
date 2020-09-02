Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E6F25AFCD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgIBPoX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:44:23 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:6321 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgIBPoF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599061444; x=1630597444;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=gPgKsMD2clp/MAqbtb8vMB+m2843zbzu+eL7CZeBAkoDaAv/jRgtkhnb
   B1j5XXPpRdtVwTDXWizGrYSEJzxYKuEhRLZ8Qfnx9UE1DSGmmetJ4p/Lk
   GboR8Nh31s5Cq4sfn0eDSETU+O8tpkKXYvZJIZYS75uGFY1grYK7YY1JG
   b4d1Z6bWFzvxNS6WhllFo14/hfZ+MdeM51fUsufWepIvCHKepyOVKQL43
   XSN4JiYItFfIIvgI3CWPljEC1rlDu35kr6v5B8BqfzVgDZd/HgZIFd8yz
   FCjIelznK+tIhZpJUZ2S4dqF57Nw1mRGLdj7L524BYmR74Agdk8fvxC07
   A==;
IronPort-SDR: gI/PzTlFNqOP5P3XJpE1Tdrp7iLQ2Mid8wZxnDG4usAc9SVITR55d/R3zIkOT/NbBKQckHWR8J
 lwPS9VHJV0VKjUOCnOqVDC7RYdnWamvbIFJtvgeOS79gNCwd56uOOwyTsAdeB7bY8SiFCeXf2L
 hNXoqYI1SZX5FBRD8RyQxdrbcscCfrjYeQnStAOIrjFzPmksv8mUh7kKn4hpu2dpxTVcYzm5ca
 a/dzLYQYY12GdPkqTYhsq5gs4BSuZFk6dsT7+xNifMvAJXB+zb92VvdWucvP11AZNfyOAOUuhm
 lOc=
X-IronPort-AV: E=Sophos;i="5.76,383,1592841600"; 
   d="scan'208";a="146410276"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 23:44:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkVIJpMaSPCdPe+J7Lh3/O4htdw8Sg+qWhX+pf3D2WqgE6ifKRmEN+POugShL9lwG1oCbUQjkzRK62smYshDa6xGQgyZjPAYDgWFUmsmk2x0J3dL/h/o23OTtOPkWW9+pMcKpo1u3w150yc50sR60rWMiWK7KeMicg2powJYv8i3h+aWQR7FCWZdrdW5znDE3THIxG5dooTw+1Liw32rtu3dG728b2Vjt3Lt9uxzyX5XXWCm3a5bBap8QkBvfcvuLa0IV1LhvByYlnc+i/ea5jX+e8kAt66alXDfmluKz8lsprkrpAkdroCd0bmmvNO8Z0NiVFwfOd17jzcWd+2X4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=QGu+miUVBRKhPXJKnpFvxwR8lucRdYRJhz7MMM6VNPXK6+J02w5zo8TSe0xDAFMcgGCExMoiqF4g8UQBqOZ6rPGo57OWaSIOyQYQ3eo8JuRHewn4T22fjoPDH9Jb/SFffLgqFyHebt5zbjc3qe6uUpIMPln3QrxYQ4PqswrcYd/t5X+8XBtuNCi4hjQygBKoOjNLUhq3B9YB4kw1tNEqIK8rnAXntQ51iV++KaesQttOKLS5/GTxKjCV5yY65+Ccdv5vHsTE3glol5ccpXHOt/efJJM+t8eut4TAe5Ft1BhGJc8OfPdmuPzmmMvee668BVNFcH9kMpd4vDwiB8j4Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ER5u2Ck2Qtl35SGU1cxhxLOFGpuH5UIIMDaGrECn86sRLsnYqRQfq2uDpbr2PeJQPDU0D7TQPxAzhtdr9drz5n16lYO/4u99yAU9U2ngSgnzX2zH/Jz74NrA6vRyUhYmuOYnwzCfG5+QiRhyAXl6SBl6BbWAnEm6XPcbTVybyoo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 15:44:01 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 15:44:01 +0000
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
Subject: Re: [PATCH 10/19] paride/pcd: use bdev_check_media_change
Thread-Topic: [PATCH 10/19] paride/pcd: use bdev_check_media_change
Thread-Index: AQHWgTcB3lYU4stXr02VhlgTPYa/Eg==
Date:   Wed, 2 Sep 2020 15:44:01 +0000
Message-ID: <SN4PR0401MB35985603C01643B387863CDD9B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200902141218.212614-1-hch@lst.de>
 <20200902141218.212614-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:1584:4722:fd5f:b30e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4eb1d8c2-b365-4cfd-e4e3-08d84f5703a8
x-ms-traffictypediagnostic: SN4PR0401MB3598:
x-microsoft-antispam-prvs: <SN4PR0401MB3598EE666311A8A5D7BEC03C9B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7qIzKE+YyETVgxbYEyv3WANMgNiO85xElM/Xx44DZDocwkEen1iB7cHIKRL02PQLyVacwtffj7fVq7wQ5CoU7r8cJKGCPOhQ+oPzUqUpOHN6Dqdc02ZAS0HQifcQSmtdHQXPmZ/skPji2HJ5SX9G9sYEs6z754wi/p8nW7FyZXKTtMzxeiusiSaeEmvKOYyVUTHQB4VsOoHY60tjfLqN1P4mKIuxDn1B4YTb5Qy3Mgh4sQ7DqX1Bhlk8n7NvL5HDmpkx3+mt6t1TWgwVrx3KWlpRMVUA/xKN7hCmVBpUcICGP9zaOx8D6aMQFgYHiArlw1gX/TnqQW9n43nWm5aKYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(8676002)(55016002)(52536014)(7416002)(66556008)(4270600006)(66476007)(4326008)(64756008)(9686003)(91956017)(76116006)(33656002)(66946007)(558084003)(8936002)(66446008)(2906002)(7696005)(54906003)(19618925003)(5660300002)(478600001)(86362001)(186003)(110136005)(71200400001)(316002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: AEucRMi6R1ZDJMs1ayT1jwQ93iQ8UAkeMNEzsSaS8XeLzt7Jc6mw4nzS6hrOaETqUssyaZB4prilA41CAuhdQ07iXxg2UAoqjpqdyaiBYk0wpUz4j35JkgZL+IZu2OXYM/SHsdr/lHfYONqr1CYv8UfmjH8A9YOYuUUYilvNrzXcqfeRbxs8GoaWzDvQHCdvx3XxZnCFtJnBKykJFMjR5/PIgZwqgWdnFLZUI74XlwnLQSYS0LZdHJuTRzQ2S0tsoCerfV7BMzr0+g1dWqDJ2q80prPSOA56VLHP6OgprDttopRtH46x7k1cFN2Avo2PJHWQaw4THSJeyuPbqNoOOPwENRU7MxRNewD5lTErsNfsR9ISGANvI5up4UAlzQIvXxJ4bdmVDUs4UC3yhVGJ6lVaouS0btxr9Sa2VyvCHSJfpQvGDB8XdsUY/p54RGDd6Iaws8sbFPtGN7746TfmAYpPF/2K1IyZcNxmm7kjpPtSGZq6jZHokEmm63fjc4gpn81Dn2mJvdPPAWj6WRRS3XXCM1FhTTlhL/Tt3Y7h/8v45i5swm5GARBIfaWIWYH94nFKUiXDLZ02cXwLVanhXxYuadSvu5kIBuJ6RJiUEiR5D8bNkv2rX539h1jygNx/nBOcM7l+1SkZLOoA0NdFnfOt+nCA6CzqDanV3gWBIVMxaOqoqyPcZ5es6khc0UbgYX+t8PuV9UCV6h5ndf+qzg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb1d8c2-b365-4cfd-e4e3-08d84f5703a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 15:44:01.3235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yyvm2HOKCCrguDw6D3SOrDKj/Ddj2QAYnAc5+sGINWz+dZJy3dCfxGToWZhIi2H5XAEMZmD1oqUCRZNg0v6DfPTFnsP/hkSmsoFnuFmW32E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3598
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
