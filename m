Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00710262766
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 08:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgIIGw5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 02:52:57 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:62837 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgIIGwx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 02:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599634372; x=1631170372;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=fBz7/axARZc7T9KRDWht484/hbFKScOv6F6ePe487Wv0E0lK2Op1OrYF
   NjKfnoE/UXqZbwBODyU9YzDZy6WUIaPSMXGtvhp4Lnkb/TVWLcXQKRP7p
   VY2cQSjJnGhPEEdlc6BCrSGQ66JV2naIar4DR9+X4eqUmgz2UKb4u+MuA
   LdrORJOUR+IOxioITphZbdgvMUSwTdn4WieIagmZb89Tq1/elboBirjp0
   srBJmzY8p4hHw4zXHY1ylgsFHkEXYavvifWDCCXAYskGOIzqbCuP2U45a
   MLEl0JrcBiqbPu9/zP9Gf0kg4Kdq60FjJsasGetbAHmm2n1g8AHujEZFw
   Q==;
IronPort-SDR: CWKV5ORr0aW8aM85R+SWsbX+IY3j2ML2KEy1BKyN3cGR2h4jxuOLhzQ4+4ZwAwXabbM+bnXX9S
 z9oqIKjx7UENziy1UyBKpfsituJY6e96iZeCYElDmkFe6Wv+jHgEX2xyDBQeu7cdTTwhaLQg9O
 Hv7zw0JOE27OzkGtLn80MrkfZhhFDANPVvQU6ejijxptRwiFRchgA9zS0NHinQY6ZTR2+KbOQe
 6fbEUNIa0psmBQ+he1ahnrklquKstDkbCudlyV+mXR/oaM/zh3JpcyZ1kt9i6BmKqA21OluhzR
 +9Y=
X-IronPort-AV: E=Sophos;i="5.76,408,1592841600"; 
   d="scan'208";a="146826324"
Received: from mail-dm6nam08lp2041.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.41])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2020 14:52:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edTJiZaLqD8W/PKWVRXX6V7lk1ZfigMqaTeimGp44LRCRolhT9Im9A9TLA+YXRZtko7tdEe4ymI9itv1MIdzt+a5JMQMXso5ER1gHeqtT1BRlu0lIEpLIY2hFECFm3PCUd4w20mT5IXGLUOf3k/ONsufV1M0B8kMriSP2iXdheYt6alLsHBXf4v/Y44Bnj3dpeo2xf+un27uBg5hf/46E3ghGasgOqzI2mrdHhkSjXAi9WSORfx42o4pQfyUKw5IMIrSLRq9dIPZAH9Yi1IekFfMdxtQ2ULtvqlBDak5fN7yG+O9yCVmSRBOe8tH2ibR0rcJSs1xitX8jNdTz+hjyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=VwDFmvjyOqsnHZTZC2OEHmG+2C43XZjOBtZykuo6qt118Ua6G5nKuUP+dBEHYjxJZwKnzghd4+dovmuxt6MOKFGG7ZAjaFxOLiC2hJmCQniAdP1Gpfi6C4ARq8Hn5cJUuSksZ15zuLP1/v/qF+nDGofWPPiHBdRuA+jGroH5Soz9jUzRMLYAAfiXfLzhOzm61jxYfwWDvmpPtKerIk0jguvMkpvU+hcucLDsGJ7tAOIi8pqvAhTF/UDSraCwFyKEtpkLHxiut/VJzSR2UtY0vVpB/xpp0Wtq+lD3mqHnEuQz8erYaIGlnGEsv3Aagi+t6Gd2UGBslDAe00jWBSsRig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=mmeO5Eo01Ac05IhEkRfMaDjVvGFphdoOINT5EmWtMyLTA4qy4TNvj4A/Xbxo44i3FVGCZrTWmTffd0GbWbLBUQNO1GSvdKHCl9KuGuwNz4madzsRTiT2dvVCP04Ov+d1WoehldKuKCXRrHDu1fejAnNmoAE+JH8IRImPeBPHOlQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2318.namprd04.prod.outlook.com
 (2603:10b6:804:17::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.19; Wed, 9 Sep
 2020 06:52:49 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 06:52:49 +0000
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
Subject: Re: [PATCH 04/19] floppy: use bdev_check_media_change
Thread-Topic: [PATCH 04/19] floppy: use bdev_check_media_change
Thread-Index: AQHWhhiAcGP3UdSVIUmIdasmUqfYBA==
Date:   Wed, 9 Sep 2020 06:52:48 +0000
Message-ID: <SN4PR0401MB35989A8FE1EFDBDD18EDDA429B260@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200908145347.2992670-1-hch@lst.de>
 <20200908145347.2992670-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c580840-1dc4-4abd-f50b-08d8548cf712
x-ms-traffictypediagnostic: SN2PR04MB2318:
x-microsoft-antispam-prvs: <SN2PR04MB2318FEAACA7A9DFD8770B6779B260@SN2PR04MB2318.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W5rMWm3wGZp+beSBFXDNZADtw0PA9VVpp2R+eulmZ0OiJ6tf1wUmGU35Uzi8o7d0LiS+d7oYkTajLpLlHaiRBaeo59ji/IQ9lVf01vA/vg+JnoXPEFFO49jW+lhHv4iRaYN1XVfMGwHyqweF+zRWQNSRhVsDfBJokFu7OH1L6JgxaLLg1QtPS0UMk2Uo6BO3021like26bnF4VQqPnOVgGiUIH9xjQYkwmARMvvD00JFuXM2Sadc2MpTU8UI8Rh5kjkBAX7c6XAbVdytRBVHZi9BXkyOSC8UMXMYxNf1YNbDq8uL7+y4ItSDM+BnV75BddACqQNeggUwI8QD97mYOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(4326008)(8676002)(558084003)(8936002)(19618925003)(33656002)(91956017)(66476007)(52536014)(64756008)(66946007)(5660300002)(76116006)(71200400001)(66446008)(86362001)(66556008)(2906002)(7696005)(7416002)(110136005)(54906003)(4270600006)(316002)(6506007)(9686003)(26005)(478600001)(55016002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 0VfZxJ0OZAbIo8CJ9j6lq0HTYiTCwh5Ker3DWmDbeQROKUrMZvk9OvCrsdXVa0Rxqx7uE82fIas0g97HMKH43JDbkG62zKtPeB/oD06HsHoOjPQGgZmjeLhSuIxgD1wk1Nu5dRGHm/d5DFQvo1HIcumRUv/srcRkyigz80EJq3mATd/ZxxYLAJUFoTx8W2uPrySp6Ccl7tdgFP443FRh/SeUtMgQt/EGAwwzx04meSfu4mWjB4YEvclq0xfbUvHS8/5XQQL7kUf27np3AoW7JVPDsmXy4eVx5ahs4n5icJuYniKxB8Vg/fw/AfHtj/PZC/Y6airxkUhx9IQmT3zdd6mVjv7kkW+eQAF6qmxriL6bGlnxDEx+gYBnmTeQF4Fwe1MQ/7tP2UY4T6jEt+jG9B0E+9mz23WJBIJmxYfR0WCDQ5eI8g2DPIS3rX2ANbRScJCZxs6uw2zwWH1Y1K1WS2mPxKG1+ds7F0qNRq/dk5GaVUMo+8aGK0+3A+cYKjRmd/0kEx/fYzhePBQVoXD7nDKxK8UsUW3Kpq8NYq8yBCs3rJPtuAsjpRUWVtalXc46/5OrOEqFM+HX8kvMpaF2fIce2sH7bR7rVrMP1YDm7Ine7Mo5tnANElq+hqyK0/LZGwWKEZYxCuxvklUz1ju1/g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c580840-1dc4-4abd-f50b-08d8548cf712
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 06:52:48.9445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h98h5sIzX5RfClA98aYqBCej6ApCvwDTamNQ8ZPTWhVdp69Kg0nPXAt+ruQOup6fNDOAS1Rcj0rMRuwuAokdauxn5nmJyCylgcQCh9nRVhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2318
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
