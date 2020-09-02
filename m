Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758D325AFA1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgIBPma (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:42:30 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:61103 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbgIBPl6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599061325; x=1630597325;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=WoMlNwTRbXlmNhETKWZ1LwuxQ+54M8oS4KA1NusZYM0WNviDkZC/S9kB
   Qly/00zm0eJEzJKwqbjZ3nTUCDHXWlif6U/TZBNaQueUCZk3OEbs+H5Xo
   OMFEUDZECRXswHCi2vrDy3x63jclK5hxISaE0FBZuf2g93yLVr3gD5SEb
   AUget8Q2RuBvgV+o5xLdDDfaf+rvCqczMpHaouJuMz6IlidY22ftNhEEv
   r3BEzAirrnyxt9TtJen125Ugb8Wm8WVItMo1pQtkUHYF26/NtZzvcGlOl
   9W4JgCETF+ErJpkTChfg7kQnEFw9ezGyFN6/uZ6G8SBC2BCP3AlJMZ2zV
   Q==;
IronPort-SDR: SHEnDhS5jWUt92y7yPFhRM6I2UcFG017FCFr3acHTCWdebUc80CwLL7T3U9Tc5pE7lP3XlWoaI
 b6aYzMfbyL18LHMKAD1/Oct7fI+FEkovjs78EgSmIzLWOADf+asiWMSh0dmAOqo1TO1J0BJQhz
 UDKwnsV9JyCMrHMtQJMX2+GX4loUuVDSTPBHkud4sxsYo0PrlPPTThzh2weMgZQLel9CvxEZMz
 DL0mEV9L8LqQ3P65M6VWu3mKLPwbg26nhjt0FC+hN2oMJrrIwUjMuC2SDccWbUmtqL8WkZi6HN
 MDk=
X-IronPort-AV: E=Sophos;i="5.76,383,1592841600"; 
   d="scan'208";a="249682753"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 23:42:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+ORDsIbTCYt/hpu/Q2ggmCZBH4TDtsWHRYBswCUD9Z8ksY+Y9fIZEBPLOb8cX1mnwj4lMla+amkUV+uXsugmeYg+OOXjoxfCVfWZEahqPyaH8/NKT4KbtoMIu3vPjjdNxJf0LU4SO2O462lnIssAbNH8vNMXFuBE/kG0zkIZW8bfZSqQo6z364CgXlsB/v/b2opoEFrWPv/v+Jy/HiszejODF4Zx2xhKeTm7Iga7/MCv3Tpb7i/VGWYFj1J4B3iHs34cy/GeCRhdxyJ6YvCK2X2Lw8U4ztdtY8idb94psxPopMXgaGGKPaJyD0Nzxk5gFpT7JK3QW7BviVz0f346g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=GTlskERuO0iMkQ10UBI5Pjdiu80Vk7GgZRiRe1P/dSInGx4Fp1k1u3qz7Oba2SsPLV8eG4kwrF00OqUQDtWiX8nFfws6gNsMyFiEEm2qkuf3K/EMZwI3DBqivar8ARKPd8ZA7liHlsZTZqwyYdTJ9J1qTqosfxYTJC/fyeIpXdxSMUB58oKze7ykbUCVr7wi/rQ0lEMot8NNzQlIfYvmbifzWJd0vnAAPuwS1GkTCnPvi9XUlX659JQRfIT3sHg3CmKqTBU+PKyrA4KKDjddDmTMpIANihcF6JlFTTAXwE2mp+v0p+RXC5/YxCcNgTv+4P3e5+8j142ALCsFyQFo5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=rfm3ea94+vBgTSVSlhuv0ve/UhJ0cwYFxTPWeVAr1VMTb0IX9Q0zxV9vnbhyLk9Tfz8SmaJVwipzi6HZMIxw8GZgoy1VzQwewBkrEV2CG6+Ab8kfvDgC6nhwMXzvFvpVKmdCXX2KsIjxwCOJbn0vU65ploAC2Ma8kl0njZzhxEA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 15:41:54 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 15:41:54 +0000
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
Subject: Re: [PATCH 08/19] xsysace: use bdev_check_media_change
Thread-Topic: [PATCH 08/19] xsysace: use bdev_check_media_change
Thread-Index: AQHWgTgZo+/YCLl/MUSad88J1+57BQ==
Date:   Wed, 2 Sep 2020 15:41:54 +0000
Message-ID: <SN4PR0401MB35983F43E12EB25BC5FDD8EF9B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200902141218.212614-1-hch@lst.de>
 <20200902141218.212614-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:1584:4722:fd5f:b30e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6296487c-9925-40d1-6f25-08d84f56b7f2
x-ms-traffictypediagnostic: SN4PR0401MB3598:
x-microsoft-antispam-prvs: <SN4PR0401MB3598BF399EC6FEAFB6AC6DC09B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dlebVTo4Yw6icxRJc34zdSVcZM/jJzZobMNxAZt2kCP/9fJlWURt3IRW77tv6+tKDTGb4gFFttfPM0uoHCqzvlhfYUxkeLs6R0ecfkUCsZYGO9Y5cSyT8Xz4aJhtu4Z2Hj6MjrwhszUhuzF/WswO08qUMDkUspN2m+fz2xyegzQ5J0ADvjgjE/0v4uDe99BrsM+YVXC/5L/fvdQPKry6zPaKMbHfp884KRjBsvWPATPq0ISCUZFitPvwGMXUV2E69hQn8H3BFv+9feUCiaAeP4a6VBRn4SbTSvDemaYusCeXLAVpWSIxYIZbKxqSJpfsXqtduDrWZPMXpbW+Wqx03g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(8676002)(55016002)(52536014)(7416002)(66556008)(4270600006)(66476007)(4326008)(64756008)(9686003)(91956017)(76116006)(33656002)(66946007)(558084003)(8936002)(66446008)(2906002)(7696005)(54906003)(19618925003)(5660300002)(478600001)(86362001)(186003)(110136005)(71200400001)(316002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: PVKTchNdUNyWawWk7HdH8UQbpeUYlxvvAB6AK78b7PQQlLal7gHcfWu21ycQfWPg/9z61rV+8Drv+S9HRJDSz9fEoLoU/p4rKXbPAYt/IozwtTc4wWIcMHwpOlFMsYDGRMRrX1dP9hzpI6NPpF0xLtlA1NFdirCeJwCSKYRjwhf2tov8VQFiOa4lxbOB6gukfEBip7oFHocFiDpNMFl+FS3shT+ICWG6DZaUIOQjbKuhv/Njs5SQdwoyqXBCeCfFQVogkbCdFxLNxbc+F8K+pInTwMGOA+AIyE5YpEflor3SdZBdOplZS5zWTm50WEvZPhKiDyE17t71auzPr4+X9tJv0BtZGFfVw9E8xZydC4s0GTFgHXlv8QhiBY59VRuYNyScLwxHHmsN1MfOCuAoo2ItaUuJK1wQn3uOKRaTtNCtF/IUDdZlw3rAmyt/1Iy9nXtX0TdzitGt+OyPZjHdYftReIvvg+NfDvDZIwJn+W4HbZC7YzTNIf6e7TkHqIELoXRIz6/al+5Urb6oBhXCVBP3cPl97SrZrRPTg3TXFsx2UX3gaDkk1vWtUvV5RhpfVhvhmK9yOLJqg2egQA/25UpUqbl/1JLf3+ngy0h27S/otArP7dvFKK1XfsHaiZHpYdJiHx5rfqidbwsXX5I06xy73xzcfy3Hqw7do92VmxBWE/QtxjqdC0dkBVbkJ9BkySzjyNhtC1XYeVvpdEstVg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6296487c-9925-40d1-6f25-08d84f56b7f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 15:41:54.2796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DuHDqo24CNVXsUlU39W1t0GlOOCJXRfiE6NXdUvXiXysL3YhP2Npkb6teR3nqBZCliMJwBBii5/bEPAn+J2ymFutXBqmYwvBv0z9ZdP4W4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3598
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
