Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B38A25B04C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgIBPyy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:54:54 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:62314 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgIBPyt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599062090; x=1630598090;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=BOwsGITHCE1eDcWVfB2YPAqhzYaGzhJQwwSRqYSvL9Oidzy0y1MReRtC
   I5X+M+J7W4r0hRsVyrlWCXgl3mPPPSBGnhe1KA0iq3oVoUePVBvBeN2YJ
   TRKeeTDInBp8AJBOp603xy0zpPGh8wy6tqDECmUK2xYEFMKsshV5MqkEw
   wRB/xWmw+wYhkRrV2/UAYZrx5gLh07pbB8XyZiwuvGPCqn2d6yDwjp0aW
   RTXY5EzqqhFUYqDYifr7FvFFuYFvAZSJMD0x1n5aYGKytQ9jzfmTSiFuK
   htqLSa9dKOT8UseZBUEBAdAKSboKmJmygzQC7tazppoEEIA7ES9Yr57mG
   w==;
IronPort-SDR: lSNVUr8AMvDd4SfHH7Eqz9y7EnL9oqrnn0QQMTpoKjf/2rfoo4ogHbiqPlAIY/H2MCdiW7EfG1
 R6qwpLmnHTXAJWCfTXHOEGpnC/i8/+t1KsLuzDlRp8Miyxvz/4NxqEJUu3FADaoz/ilLNBWD2P
 cgXgO/uW5pRAnY+QA4Iukap0BVDPn/dRdjDiQYCUb5dGiasgfEHgKA+eRRcITQFsRlRBc/2YdR
 hdhgp3NIeb3gUTiE6LcJ9X9uXKDix/rJD3BqhLC9/cuObj7FN7LGEx3jpudoi1W2tLjHdnjjAZ
 n3M=
X-IronPort-AV: E=Sophos;i="5.76,383,1592841600"; 
   d="scan'208";a="249683662"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 23:54:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTuAjvLv39qXYkIHqPCWxgFzOd34nP2dDbY9XsxK4rv/3Wgsxkh4VFS6MbIm/mP+IwYWfTbkgXXEvh/rraDaUcIFKDw+v73ySaOvcGPMbVWbt2oA7i/wlerOD1a7Z5Pi+tFONZlb7tBLTWkc9kfQAw/7hunYxitSOHz6iQJi4hmcZkaXDw6yP5Ju5/ODg10L+xoCefo1jmKJfQp0eydHgoWcBn1eLGUPEYezxbOdU4B00zVLkSkak8bZhbTTcBf17Cbai70BYg4OwZzoER9iMbiGpyqoNpnpbtiVpeijVGpjVwR4xkCBOdCIf1bYZQIlnT+nv62fNre6VaP/8QKqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=D8vyknZtntywevN5CLZdovrI+pu9mK59NFDXyaCgk3c6+YQjuckpwg+DUldhLzbTNvmTL7fM7G1sDMxZtzBYFWpYfKlKl+RyA2MLEr1L9c43YpaoXoNXASVXTn/lnLqRggKtCurAh+69Q3T0vqR0WHpOd9jgoc24wd/1QrHQJS1ri9D/LLnhJn4BF46Phbu/tO4/1zcxWu2z6Xqojd4Kox/bUcyw6hfmO6VpbJHEVFJ71lz7JUpanEH2UImdKa/1EnCDXcT37WgUUzykRffMzH/t4HZQmk/5Z4mMp0N6H6lHBy4WvCi9+CLN0rbqzcC+HlxNQDSy5cCn6NBp2qjHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=IDFUGwZlbpnNbjER3KJTuNFvLQBK6JOyrb+Tg58RiyeOgnsgA1ySPWtiqndbWlqyIRW75FR/HsORkQhrb067RjNYnRssLevkrku/ZZF1zcQNPmdG6288aPP4aVCBZWwYJuzWzeFWtbxX9dwpeJ+zYdqYfvX68933vzD3A3Fu8Ts=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2142.namprd04.prod.outlook.com
 (2603:10b6:804:16::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 2 Sep
 2020 15:54:45 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 15:54:45 +0000
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
Subject: Re: [PATCH 19/19] block: remove check_disk_change
Thread-Topic: [PATCH 19/19] block: remove check_disk_change
Thread-Index: AQHWgTTM/VMdxHIOSki4rSDxObQdDA==
Date:   Wed, 2 Sep 2020 15:54:45 +0000
Message-ID: <SN4PR0401MB3598D00C3B1D7DE2DE13EB659B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200902141218.212614-1-hch@lst.de>
 <20200902141218.212614-20-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:1584:4722:fd5f:b30e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2efcab8a-0de2-4dcd-abd6-08d84f58837e
x-ms-traffictypediagnostic: SN2PR04MB2142:
x-microsoft-antispam-prvs: <SN2PR04MB2142B6E7FEDE109FB8BCD27F9B2F0@SN2PR04MB2142.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3chquWAona7oNgqHSaHq7hSibThOsxNBPSjF0OL02GAJNctZ8rhRDcxlKe6k/imhwFycD543BseqeNRwXnh0V1Gqo7tOlGINNeXkWOQXiOT/Lxd1GKDCKVjZt3y7hnigh6W+tMp8BaC6e0ddLziQQQfv2lMQ3nVrSyU/hdwullPkHrc5Uz6CiUdBJV8efskxBixkB8kDlMYizIxELvfoM0WK+bmBXH4Kt3JA91YlH+wZW0flGDVuwoQfjtEc8QOF6I9WEav0qUz+QONXV3spcrNPpUucw3xJGksJuc3wnZSxud4tHBWbm731jkbiQHC4P/1C0GLYmY7uc4tUiXSAgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(136003)(346002)(396003)(366004)(76116006)(66446008)(186003)(7696005)(91956017)(8676002)(5660300002)(66556008)(7416002)(6506007)(64756008)(52536014)(66946007)(19618925003)(66476007)(8936002)(110136005)(316002)(55016002)(478600001)(558084003)(4326008)(54906003)(4270600006)(9686003)(71200400001)(86362001)(2906002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: zWWeH+lwWT2qJgiJSPJFvsVZClbv9TVV6lc58lwzRepeHH3BrMyCnQ3EpbSoE3pI220c39AXU+MxegW0Ab/7iGBk5Bkg1Qgf0QGBQ6U2Xgqov6ds3I5chT8721RhlN//lXOC8Xp184olX2QiH/R/xPehG+xf14RcK8R5fBGCeKpubyXSBi+35v8sKFBEvpKa2bIUuLDNme/ia7RLH/kjy55h8oxOnutRY8w53HAVrl+Q2zq1I4seAy8VGgidzLu+1lnuhsHUs3ci/YM7dSqhFyzmXLiTPajnMV2IHu0vKe4ZlZ/vpTTZsk6pg0TynUnRbedYUp1jkx7OAvhlSfBLR9RRdyaO6hQaVxXNl05twM+hbMYZT3kPpEcjbuaeCsWKGyZDVj47Q91J9+dNctvIgyv7pKsjB5q6E9VU2zEfWbs5tDa0f7wvxT1m7+nqbl8YX0DuZH8sH/czKhGM7cd+j2LB16F6SKmn1Ei1cxHRNVxcBYabExzJz9QrzNhRZUZoXyTLm/dxxA9Ri1CsE1MdKn6oforepmFU1L8ksalqINRShmqu8XvRDQd5WEKqLOAQ4rZmAu5uxoC6qU14ZOt2xR5FDY4libqUKzA67TWKjHMVmE0KBEIa4G9UTw2loeyWnqr+tI1MrWsSGlIai/K5bLlgndaK8Eufiegz5GK9WNsh406Q6QJ8RL8FU8obObfNa80EhBSP5V3RwYZMIvHb4Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efcab8a-0de2-4dcd-abd6-08d84f58837e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 15:54:45.2819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lilrbp7kQ67XgWn5bHsx0R4QfP4xNRpGsYSCNZhvGI3Rmi6UwoRXk0fQDLaFF5Xf/enoKm4KtDLUZYoeicOw6vR3HmyasVdM5ND5owIEBdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2142
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
