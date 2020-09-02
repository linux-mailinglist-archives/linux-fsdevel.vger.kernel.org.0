Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6119525AFA4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgIBPl3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:41:29 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:6110 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbgIBPlU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599061279; x=1630597279;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=aWD+B/gJLV93nGJO4hx4f0p6KswjW3ldkXJS2DQGQrcIPqO/ySenbQB7
   gXP3DzPjExTpjFgotbvezZAPCJEntNfpZLxTiarmDE1xea9G9J4PFV5bL
   Qpz9QbNdFDA3CFhkbnqFA4+V3bFl9SpuND9WaSyrGQUirBK9htNqqijA+
   sMgauRu3yW+cCV/4o2Ch5sh73w9AKKXR1xQjo0+xX8XCfSzu4DhVYOedV
   sDtwVRft+Kib/E6rLqa8+pwIuhTA7cFvjjgnYQ9cCbdXL/HWpSq54/iVG
   OWj41jP+ApBnKpaMhzyEkY5cb8hJMMkEMeyGVvEDGEnVDj9jR9/54P1fR
   w==;
IronPort-SDR: gCaj3t/2VCR1QsnC23EEZBZ3PX+Q5LkBlQWyaufDtYJHsj3rn8PFE3dMxVd+1Jklrg95/VF2DN
 2X8PwukM3pkRUbUiwq3LlJpm1O0ZlgeBtKPisRePlDguIn6EOS08r96/I0555G7p7tzNTqOKSI
 wIfb5cTbfpRhT3bdtQM2d+PvHfSXkVbyzdOD97L2Iyo31DhxqUnqgoYMlgyMUJ9oQKIK0I9H51
 gCBhLYLR0JX1GmaUiYPe5cCTAKNek9WIqNBUXHOEXLctbEoRPq4dxSf/e53d/YJ/GzT6CJXMDc
 Vjk=
X-IronPort-AV: E=Sophos;i="5.76,383,1592841600"; 
   d="scan'208";a="146410079"
Received: from mail-sn1nam02lp2057.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.57])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 23:41:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNQ1nRrM2ZGPpucUJA3f7qUOd3BTswGF8iaaGaTdMpg4D2Pc2RjYqCrTVU9AcinHg3Ao8E0cu+bxAbXUmzNOMZbclSWky3lHGq2+aFjLVj9tHlo9EEwU5Sp7hFXWv+3uOC8Qr3BfcbPrQ1oJlKbcS1133ynKMkhlBvptgWypSWL2s261tqjT7fPdsIBovp3vkohjvbQcSCzrO9Y7YU9/Yb2T/r8QUjG2Gd7pXFHhZUcKKNn1e3ePQvF4d3PsoI+oFf5TjuJTiojetakv7qmVXBYdqIb4Jnj1iPrs98xqrgkIDQQ2BZwWw3czg17eOrFwV5pHhk8RTz2cVe88/HFZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ZX21ANKDq59Vj7cFuZZFXpADeqyQ6L1Qc/PwXeIg2vif9G4tVtiOUZzO3uq/zfnTemMaWFi2CuUWcSpOS+c5dzTK4ojiExy/+k3HBHaXXypOXHPAXooKgyDt3tCJp3zONgd/G1NlyJHDmm5Yh8PFXoV/mxaKzxBtT98tdPPZtxa57CBlaCpmdUrmX00uUsRIS/5Yic9W/f23viA78MXAzDS+A8ix4aJypPmLvUSZBBZblj5/2UZL6fA7TAPOuzuK5dLv+cNSEWfA9nekxBnkPz/xDo7sfr8o3oL7jW1BYCBuc8DDkN+P+wRCHt/9Jys8p0F15XHUjbJCxFH1YkVBhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=AHF79kQQ/nHPWHPcyplAjRGXi9sNJ75SkoVGP/t32I1Qmm9vsuIQAo2SCrobV9MFTbmXEWGCSLP9mlhDPhu95TS9t1C8A2qRB8qHGorfSl33eZPI0pLy0tDugwxrOJcWMQ3W0S2759s5llGH8DEKqNcG7L3pMsQW8bBKdRdgvgU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 15:41:13 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 15:41:13 +0000
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
Subject: Re: [PATCH 07/19] swim3: use bdev_check_media_changed
Thread-Topic: [PATCH 07/19] swim3: use bdev_check_media_changed
Thread-Index: AQHWgTbhYpsv0xAs9EuDcxQrdkmClw==
Date:   Wed, 2 Sep 2020 15:41:12 +0000
Message-ID: <SN4PR0401MB35983B23857F608B2D8564CB9B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200902141218.212614-1-hch@lst.de>
 <20200902141218.212614-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:1584:4722:fd5f:b30e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c6782f6-c840-4ab9-bfb5-08d84f569f3b
x-ms-traffictypediagnostic: SN4PR0401MB3598:
x-microsoft-antispam-prvs: <SN4PR0401MB35982FB48730D9514E9AC9669B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wbb8fWiVKoRZq7+NPkhA9O99uqJuyeWHubObupD05TVIfE/iMg+X3yz6asSl987FSjVKSeKXb2n3N/s+4lv4y1wjnbVLcX11yrSuJXsEO9KgZB6sDeOAVw4aeZ1K9KLT9EtpLTgCqU/nXKfUw8kIynCdlZn2WfYBy+GQ9eDRijpZPmykXipNKil0Zi/MN9PNwT5UB+Gl14VvMFLnY8eRjxp8r4+K1OG6pVK6CAlCe6CaO1/1/eeifXeEtgUImieABJRwOhCBKmOSDsTwrLMcUTSyd9J5nKVUTYdCkNDR9eodi0X0OgjxohnLqVLxcpve1n9owMgucWlkJrOh214DxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(8676002)(55016002)(52536014)(7416002)(66556008)(4270600006)(66476007)(4326008)(64756008)(9686003)(91956017)(76116006)(33656002)(66946007)(558084003)(8936002)(66446008)(2906002)(7696005)(54906003)(19618925003)(5660300002)(478600001)(86362001)(186003)(110136005)(71200400001)(316002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: T/kcrZqNLLpQYoCRpURmbuNig9xHACriQ8obcu7UkK30zruHEjadZvU/SZbN0xI2BchPeiRc+9dRFqMrPSeck48FotZkJHC/G6W2raSU38PZtI9G3QIUOan6Dt+zoWmBsMTnfiIs9d+V/g1kQ0XJcQife1iAcGlGFA8tOfXIYUsyEitY+PglAvatPejQU+Y9ITOUQSgP6XDZS6ehyuv8+ca1O/cC1T1GLXJeqR1HjeUyhVd1mczixkrq6sNumPiexSMSrCFXQ4EvO+0v4WpISudI7C2/pl+A93moy5BwSHs/gnlge3EPG3siVKWgpFdFqHvI/KpKaF+pzemmZE3ZTArM7QYRh9jkO9KNNjRw1/j4yxEQQ0K0KqRFUyXUMNTJPImEcSAKWNEqamqgovaJMu+Vtl3mPLlMISoeqHFDefscICM0cyLuPmD69sI1XZp6DSigIWJ2PFbn79CZNhw2waEBcMPdywWWj20oQAd21hBkYGVsCuUiAWkp92+4nCvQG1bn/CuzwSXi7GUul9IqoUwFOZe7iBCp7ePtQR4+L9YmFF4kxT7Ugi4ru5X8T4IN3jfXz1wGY+mDImn+wbBgTMpOb0k99SbPswdchqlBj/tgtAMCt+od7ogI5ykQNzc2nRU8DO9Vn1/4aLVotF2Iw1Ro+YlSCHdcaYgBpOq7e1JgMJ18MzXvGfsQQehZFeejxKqxjgpKVyOZjJw5DOO1ZA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6782f6-c840-4ab9-bfb5-08d84f569f3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 15:41:12.9120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1WhoEIxIcNjRyrPLpgv65o2R9zy3Opc4v0e5YVn67Yl+/4gckMCU0lywkLUWiJokdijja097XAfk65n30UK81Jrrds5IwmJF3Q5WvS1z2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3598
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
