Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3E6229162
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 08:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbgGVGy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 02:54:57 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:4258 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbgGVGy4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 02:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595400896; x=1626936896;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Mf/HAZi0hlQyHsOJAqRX4fByTFGCVEgXSRxQNGkmG0E=;
  b=YZBnyVelQnCf2VdM/ibzzugOe6YGpyWFlLGCuiuyUoLC3U2dgCd0xxmd
   9gSpSXT7Xv0K4BpiyiHJhUeEFImqV2MXqZ8bjJK80PcbLb0iZ1zrbjeou
   UXijPtUhe5/AQ2IWGOL9eZIra8LPj459k8WrhYV+u6ugMC16t2+62Vp02
   uSgYSskXVTiV+C6s8F97JIpuATGYJicSF1bihUIjGl9khwEHj+hJmq/hI
   VQgKjFIHPCwR28cBZcF6XdAyO4te367xKRCnKGiIZGiIGJxVWe6pupTuP
   DVI2cMdSsVgtqAwGzk8iZrLquPBq+sg9vvvtiZUVGhZoPWz62VHTh5qQa
   g==;
IronPort-SDR: uX+mFOpiJ5WMYTqXRu+hTctVIkQQVPELRznVVqhpeCyEHEb1Zf62pe2bHdyuJRm1QYvBhvpj1J
 ixBPaAauYQgKN2rXhZiUVjFyQlhLBvfDgej4mWGNOM+4TTNeqN2af2ROTHlZtr7gZIdcMaCAtO
 5DfX7AMaQXIMxOx6lRa1qQA4elkNt5o8eKzW6nk1YEhCET3LkVTLe8mWhOZcFcQiTB2fzrRdLz
 YPf7t3FZeshKUuaLFO04C+3gAnEHsgeX56PprMQ4XnVngJakjnu9vTTzWFt6DwjrRD/AfcrzRo
 i34=
X-IronPort-AV: E=Sophos;i="5.75,381,1589212800"; 
   d="scan'208";a="252373980"
Received: from mail-bn3nam04lp2055.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.55])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2020 14:54:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h60Ivr3Xc0oExf+JN5C2VcMrZN2/eVG7btCxUvhW5hZov8x8MMzKWsLNvcLlD4mXyW5gqt/q8UERMiDL0cOGGKqqgyIbnr2q0CPFpi5tJh95Z6+joYY1iprZ4jJx3a4hDqm/UvkORrvTVERsxOzqNkHNkhMlxNgu5fbQ6xwvj2QPydYRh7ovprvn1fOGVGBshyq5G2fazARuSTyvBuHvbZ1t4WR3uzxcMWsjiD5UCoQgv3/st6zJMaNZNJNtAiBp6CEX49dPV/6VeJseMt42g4miSG0KTqgofMWz8taEvUEVGaTzur3M2OFdxmShh6zWokC9nnHD5MBaiPUypTeoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mf/HAZi0hlQyHsOJAqRX4fByTFGCVEgXSRxQNGkmG0E=;
 b=oakeSkymx0vsRqfsvCk4iGB68+XyklMH7Povy1vfVd2+11u6FWD/yk0kPsGIK/q1iOfrljUfdxzS2QGOeO0S4ihrI9/zpoNsjufnsfb64nScL90kpibXUyaTDfY0r9tfOuVsDa3BL4//TlbVGHMr8KYzRlbh8rUMqWSffC0l81qLuMAJpB3cZPeP0uIp37d+2r7mh+zAAR5US+n6MS46fFoqSk2JmxdLhx3MlLSQDChHBp/WB4f+wVfNudXo+IZLL//Sa3Zi+kk9/rPpE1Qj2i1Vy5h75FPE9E4kl5sG2gaqzSpSq7ZT7aDNK2YMKRmP0NFQW6nBgdscTM7dmHNlXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mf/HAZi0hlQyHsOJAqRX4fByTFGCVEgXSRxQNGkmG0E=;
 b=QV3tPH/FPauDbK+X0qyj938TZfVsJ3/YspaKqvUsEdMLbFERNXcGvbMk5Yr4rE1QRaW16Slk42OKw6CsTqtpmj4YugRxktCE8CpA6J4ChqzNNm7SkxoCwpS3AWYKrMP07+T7XHWBPlJTo3euNzbkNxPlylW13zYSYe1VeMxXDw0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2240.namprd04.prod.outlook.com
 (2603:10b6:804:e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Wed, 22 Jul
 2020 06:54:53 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 06:54:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH 01/14] fs: remove the unused SB_I_MULTIROOT flag
Thread-Topic: [PATCH 01/14] fs: remove the unused SB_I_MULTIROOT flag
Thread-Index: AQHWX/FDB40tZCzWM0ydmrzWX6HQ7w==
Date:   Wed, 22 Jul 2020 06:54:53 +0000
Message-ID: <SN4PR0401MB35987802444E56DED8C7962E9B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200722062552.212200-1-hch@lst.de>
 <20200722062552.212200-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3cc6b058-e96d-4554-6048-08d82e0c22d7
x-ms-traffictypediagnostic: SN2PR04MB2240:
x-microsoft-antispam-prvs: <SN2PR04MB2240AB2AA052BBB77780AF6C9B790@SN2PR04MB2240.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IDVmgvohX7JSexygYWy/gOHLtmMk0pYHg3OX93VX4WVrXR65igCwUFOiXSy/YcISEyC7S0LenThZvvTH9Hqkk+fQau0x5DI1D1sbJVBh/l+YrP8SC5QWxSGnldIeXgpYPqugyHzQB7wFu4DigmF/me5aKVWY0rlmCBvv0rTHC734WzcPVwj7aVwS+NElirKkzg+9psne5MLJmhk3C1LBqOcKncYE4m3x6wA/PYSywbjqs0ApTbT+OvQVgIrAcIsNdhCkjg985Ybvj9EFf/kSyzU39aRCGcCUf518jWY9NjQn0Pkr54KW+xf4ZnRMHYzD3l6vgLoOkwNi+OY1LT+5ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(71200400001)(558084003)(26005)(55016002)(478600001)(5660300002)(186003)(4326008)(6506007)(86362001)(8936002)(7696005)(33656002)(316002)(9686003)(8676002)(52536014)(66446008)(66556008)(64756008)(66476007)(76116006)(91956017)(66946007)(110136005)(2906002)(7416002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /27ro/TwgT3wmbz0gAlm/4yMGrMf4LxlNA6yKwS5muEQ3saFOCMlIP9lXn+bFE9pvh4/VSnXeAY3rlcMF6crS/VEU7Isdj3HpOGtaoEhESyOPpRo3Fe1STSm6+ntmFL9CnOwK5AT0Opvr+PMEmuDCeX1lTQW2IukYQ1T/XeTpCWeTELZEkx8XU50UWQQudQ3yQCOT0f5Pxc94V430bSiN3kgIwxexGTTHCkOV6wAphyDdraAbFl+EQkXfe7rJjBEsAcR+mb1OnGRYAV8Vqqj9QguxWjdICi7uhRITSy347pRdN9omKPKgmq1siH3iXrLThmW/sdd/Nkh6iqQNXOOjXwgw9noWKwhU8T1CWTdmRbw69QbYFSod+f9AFDWHevcQ3OvPk5lgHEnxITJUawsu5A/prRcUAZpyIkzGcnr9z5Rs1/t8zvhcu92nydjtdaq2hN4n2FRnSMGd4fAxp1dC2C5y3dAnTknVwgRMaQtGuBXPEHJxibYGi5ipPtwZgzN
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc6b058-e96d-4554-6048-08d82e0c22d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 06:54:53.0951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sK+zFm6//NsZ55QHbWcTkYXPaG6cMYoVQJQvSJlfcuZOIe5XRjNhiHNd+wkavDlBO3CLZbvQ0i0elGFSi5k1hA8123AIETr4T8yBNiqiEsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2240
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A little bit of git archeology shows the last user of SB_I_MULTIROOT is gon=
e with=0A=
f2aedb713c28 ("NFS: Add fs_context support.")=0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
