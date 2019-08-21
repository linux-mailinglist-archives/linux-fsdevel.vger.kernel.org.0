Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED1296F69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 04:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfHUCYW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 22:24:22 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31275 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfHUCYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 22:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566354263; x=1597890263;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PWpfmpcO/F0DJeoiQRbmmuTDD7JIiuVS+QVS+Lb9p/I=;
  b=gmGHB3o2NISkw3HpC2Kn8xb7D/C/vveUec5uQ1TUSVdQUyoLIUzwPfZB
   HtiNXxwXGTVCuZPko1yUMk3Cd+Q1CMn6TYCpQzVNsDuyVbAXl1VEyZpu3
   KtkgsVkp0S8UquidEXkz0JCqFTPZDBuuwLz9ruehQukGfLZ9th1HjS+cB
   QQu27MSGLiNQRWY+a716tNSRvc/W2arlk/7KuNxv6diT2I0Co3dHoWN0a
   c0d4C/y8Vutl4hUkBuUCX6UpXxMVmeGMKJJQ0dJgd+gQw4rZSEbd9KKC/
   jhBHHUP5yL2OraMATQMiois1ubMXUxBFPE9+/IOak8qieTEEsm1u+AkKC
   g==;
IronPort-SDR: v+uoOayGunHZVnskt5iuWMWnircJvW5zoDCZfKz5jCxOXtZY6wRqPLWt92uYMMRYdxO5G7RcZv
 8S/kBMoZCzPWcGl7L7rDuMdt8OSDvYeXcjGpCBRPSJnnAU1Q3oCEN4QhYaERmjnzFgPXS0LB4J
 qrMKO9ppn2IvGKN3EnBUbUrLe5Omle+X2TwxSTk4z7rqcxxfVOrzYcGjx7DzkpuIveqFO1sBUJ
 yh0iJ0E5H8rpUSt8d+FXZzNCjaKKiAVBoq7juhp5Hlub7aT+SmeJPqid4Ci47eOt2KPdcQWe87
 jZU=
X-IronPort-AV: E=Sophos;i="5.64,410,1559491200"; 
   d="scan'208";a="117228346"
Received: from mail-bn3nam04lp2053.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.53])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2019 10:24:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0mL70LtSiG6K6CHov9KENPgiWMK5pUfVEYlIO553eeQNbeMokWeS5I3hurICt1FZ5D6hlzb8p2oKK6ePlx2rTGVpDY6ypeXZCRZfUK7+lmF7XMHb4ZQLVe6iK8O5vtGtPM+Yy8YmFU1xZGqWp/BcvyltfB08JLLH/SpHqGt7Kn6ox6UvGwyUVFY+N5WPU1ErirnSZscKPtQ0QLIEbVAYCrpbYHfvwqXQ69+2SVm6A4ACgpjJ02C02twZuJ6C6lW3+H15H9lyocWclT/HATUJMjoCIkYfNtJZdYQB0m48R+Nx8BgRlQA9hV+J0LiCcMwkIfeHltVu4lksZNNfMEXjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWpfmpcO/F0DJeoiQRbmmuTDD7JIiuVS+QVS+Lb9p/I=;
 b=Y0ffbPnksbJrGXgeOJmQKsi1OUuvrYRrL4OprS5boxq6G/n2k8cWD2+gMgod4UDUaeYllD65OUgEsZSjblHFzXaIGTkGojrIJ0gM5I2IUpc2uUwvxkMd1hBrSX7FdVfhoJ25ac4YR8O8XGGawv2yEYt729G9PyG0oj75GDNQ/8i3N0AH9JBP9BsWmf/wmRS5GDFXxAKXAQKwyKtAAPPEbbiEwtd71McWsOANThZ9XUUM9rqzOm1KM9+xpE4hNMmyzk0f/cBauH8CWgjgyVa0U7L06wqnRG3nzFs9RE6J+0s0NqkpijMpkTQo7I2EOWTvxhGrblZNpgzRDW+MeSy//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWpfmpcO/F0DJeoiQRbmmuTDD7JIiuVS+QVS+Lb9p/I=;
 b=naVxIL0ztLZcYJkyq1TrJRAxSIITa942zk0Tb3WVY04a4/PYqr98VHw3RwwUyw3nTy6ezXLdNnaMozE2a4hkXyBBVRvh6a77T29tUHkaQ4Ito3D5NoeF2tV9bAgN6vWiJe793D7T+7T2MBfkcoO+T7caxJSftX8hISCTCTGetcQ=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4054.namprd04.prod.outlook.com (52.135.215.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 02:24:19 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::a538:afd0:d62a:55bc]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::a538:afd0:d62a:55bc%7]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 02:24:19 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Dave Chinner <david@fromorbit.com>,
        Hannes Reinecke <hare@suse.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH V2] fs: New zonefs file system
Thread-Topic: [PATCH V2] fs: New zonefs file system
Thread-Index: AQHVVy8UVAVGvwSe4Um+ID5oFBsG3w==
Date:   Wed, 21 Aug 2019 02:24:19 +0000
Message-ID: <BYAPR04MB5816BAB2EA50F571311AFB7AE7AA0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190820081249.27353-1-damien.lemoal@wdc.com>
 <20190820152638.GA1037422@magnolia>
 <BYAPR04MB58160FB257F05BB93D3367BFE7AA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20190821014333.GD1037350@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfe941c7-f9f2-44cd-334b-08d725deabfb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB4054;
x-ms-traffictypediagnostic: BYAPR04MB4054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB405438BD3F87B78FFD020FE2E7AA0@BYAPR04MB4054.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(189003)(199004)(55016002)(52536014)(76176011)(5660300002)(7696005)(99286004)(305945005)(33656002)(229853002)(2906002)(54906003)(6916009)(316002)(7736002)(6116002)(3846002)(74316002)(558084003)(478600001)(86362001)(8936002)(256004)(81156014)(8676002)(81166006)(71190400001)(71200400001)(66066001)(14454004)(4326008)(66946007)(6506007)(6436002)(446003)(53546011)(186003)(25786009)(91956017)(76116006)(53936002)(64756008)(102836004)(476003)(26005)(66446008)(66476007)(66556008)(486006)(9686003)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4054;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AzxQdq8DbOfTaCUvo44T6pAYRBbyiIqgelA3E7eyK+aurUKoira5+5Q1znLYiXmtgJx3XO4a4fW3LsI/8ySFlNR0nVObpQ6lTvSJ0TB0JIp9LAddRrWp+b6WgYhuppONX1mW2pJDTlVD6X5wl2JA7z6JkA5SuXuc05gfx3vnByrcqUMexg10XB6AjxIoiHAdE2KQcyMmWyM5FsMm0PpZmpyPDmkJVc/HiUY6x7TkupgWjVtYNXf7w3kfCE7e6U8X5mIWm1EFc9rnwyKwk4C1qeRX4cdUBl+obvMljH7Bb+bb2Ep1dU4Hjgga22DkouYBxcmT4fyH3Tdywf6Tlb8d6Oy/etqWfrHWoccAHWont5XamoO2Qvmm7/JP/s0t7a05nXZcE5UJglVHpS3PiuBjIkiZC3yOAUn9QWkMa1qf+hU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe941c7-f9f2-44cd-334b-08d725deabfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 02:24:19.3299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ugI4wT+fxPPF07aFuM1LL0gBU0KTC21v7FxNt9T36PdFeb3yUM/wZNVGMTrKMKIYJT4VoGRP+Uy/BUv5Z0Nhww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4054
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/08/21 10:43, Darrick J. Wong wrote:=0A=
> Generally, *-for-next is the branch you want, particularly if you decide=
=0A=
> at some point to add your zonedfs tree to the for-next zoo.=0A=
=0A=
OK. Rebasing and sending a v3 with corrections.=0A=
=0A=
Thanks.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
