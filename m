Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662792309E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 14:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbgG1MXY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 08:23:24 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:50387 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgG1MXW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595939002; x=1627475002;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=PwD/AoUoCODzcuWQDM/WxDTZ3VqrJdl8wM50xgrppVvVcMDKwnB0oLvj
   qQAnYRP8NzJJ3obaH56MlQUPqwPPtaEMXgSepmhH1H85nuRRWAHci8J/u
   XJ4DWm6Qp4PIv+Z/4Del5Ikl4JbGXsfVg9AHxz7Vmkfk7UYqCxo/CKkBe
   gVXSZxpfb5XRXWr3GqHVvpBPIqf+tvHYYhqIleQ+OtCg+pBvCpLHA4zYa
   Mj++FbnxTL+41R8WzbChuHJDLyCUNN+QXFlTXsMLf6e5AypU7xCLcCFSs
   +mhN+U5swU/4fQ69qXwa9PBdXldIdSGnaCyMRM+5vw+Kda/xbq7ApV3B5
   Q==;
IronPort-SDR: nHwbTT2+vn9pF4EhYRMEHd7dKsa9G1qeLWUPXheti+Pz3Zc6oYAIeAym0RRYqLmfr3T7gCN13G
 hGUz1YRjBCThLrtiqVTJa8cS1sQp4CPgdkA9in8VzEE5kTj2vnkwgaK64Iii88kcCzIgmi6wen
 AUEmIBeY8P41CBdaTiqKM/XwD5j3Fpul8EVgqwwd7Es16E9eGa2oOEVE1xqXnBJ/5VcRhq1v5+
 5E8EKshIWQwQZ0tKScwy/wyU9aex3Q0n5Z6OBelkg73aa73WV6Apm74oXSQgjsQi4xYXvn3a1B
 VXY=
X-IronPort-AV: E=Sophos;i="5.75,406,1589212800"; 
   d="scan'208";a="147859977"
Received: from mail-bl2nam02lp2050.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.50])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2020 20:23:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dS58XHLfiOtAEZJ+0Nn9Kp1Y+ynt023kt+dNFh1PIXxff/XCNva3qhpj660DpW8+OZryh/j5l2/uaShUIP4YoKZH9Ns9F1XwjO6V+cdtF3pVVCEJxwsHdip/+NIAT2sQHpibPzk4X007cIlY7FdM1lTxIImQ9m3A9ZGjkbGsFzmCBzGcBx8MTKAO/uKwt43ikXDTK6MaRAytzvOreBMqAaOE9OeePpYy1qhtstjx4Q8a0xRGS0syWeFWXhlGPvwFuksyurODsDk73eaWMUjNsovF0kDrQ82DTL8MhfUVcsBdEEMF/H5KHgTOOMWNB++eBdLx2PK+O/kN944MEOvKyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=UUrVjbjEDAVWVmx7RzmSwpZrceWs22zKEfHHwqQIBJUh0n9k7hN8FGmQxMRTt6qmuCu4MnZfBP709cFx7zZ4NExyZQkfA8iamW2zux1d6678qGdsTJYToE9MRHXHlem+qQrvAVPA7FptHR0F1NPqWCOq4qJ/o3DOWOYtb8qLqbFU5VJsFwV3KHi3j1GpFNbTd0laipFgYCEmzh4nJj9wV0FIpr7AbHMyAoqXZEOGVf3vRmtgralmh92iVQF5jAlxkKFzZMASK4cc6DCSWw5eKBwNb7U5e+2DhaPZb6XDUq0x+T2kXWDnNbsKCzjO71Tv1hOQSBXXee85Qqke8FW8ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=QxItiRavHzYveDOEBW0UFViPWLwou38pbhYILYA52HxEGG6xoH1TcyNk5d4ns+x4D29on9arDMVefwoulp+6ZW4Xz21E5Y0RbdPrrH+Z9xiDAw3FbBAgR2Oo+pHcMCf1U3yTO1onnBdWoZmPCw0D8As+T1yeKLZXQiVl3fqsoUM=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM6PR04MB6042.namprd04.prod.outlook.com (2603:10b6:5:128::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 12:23:18 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573%5]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 12:23:18 +0000
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
Subject: Re: [PATCH 06/14] block: lift setting the readahead size into the
 block layer
Thread-Topic: [PATCH 06/14] block: lift setting the readahead size into the
 block layer
Thread-Index: AQHWYYzl+a7Eqk4s2ka3fXGEsbV2jg==
Date:   Tue, 28 Jul 2020 12:23:18 +0000
Message-ID: <DM5PR0401MB359169BADDBE6B9F611B9BF19B730@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200724073313.138789-1-hch@lst.de>
 <20200724073313.138789-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41c6ceb7-578c-4100-8b52-08d832f102a7
x-ms-traffictypediagnostic: DM6PR04MB6042:
x-microsoft-antispam-prvs: <DM6PR04MB6042DE20A315424F8D2533529B730@DM6PR04MB6042.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CZdHaPqnktjMFEGBYJsxb6FTC8d0ugTzRNcXhnKqt0egUiYzymkMqsNmW+Sz+Zf41My3LEET5GE2/h6rewehBYCLLmhpPoo95Jknf2TLBh2ODw5HyNAVk811121hHOZaQKEhJ8PaWKQ0WIn+2hlH4+DiVdTWbCHeLI3cHqi7uDqxu2Ge9rav/L2d3nEceqktRk9ElOjv7nz/t+9qpwh4PnvZWbaytY1p/n+KxPI+g+IOo3NHQxqw2ky/VaNZ6lv4gFc2o+RBLt8SFnutCas2YVU9Ap4wrWe3FuH9TMibD597SVAKof4PlE8G8nYCwICGH9AN87jzKgfEkXpDUNA7Xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(54906003)(7696005)(110136005)(19618925003)(558084003)(64756008)(66446008)(66946007)(6506007)(66556008)(66476007)(71200400001)(186003)(76116006)(26005)(91956017)(52536014)(478600001)(4270600006)(5660300002)(33656002)(86362001)(8936002)(55016002)(9686003)(4326008)(7416002)(316002)(2906002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: whG+n3jqlXJuOd6kui3pyChonTerxMiCSOqI7YGRrP+w2/lRGm2YL+RH+sZDESLaYiv+hXSVyC+hCanAINAYHE3T0cIiuj7qMZyyVBMaSRh74e/m6YCVa1XRy+rIzSUrGV3Veif+hGffucuTeI5wfVIGfDGpkdjEwCrjfY1qMWUuIcWi4rFl5NZjezh6zdAiR4swYp/L0bWIRaeDmQCWR3DiHT4tYWidkpdCFupctf6ZVCbcp4J5w1FPd3rezNFP8RdDSrQNtKXvs5AWWDOltg2cTlcCRgJV6xZcDn6mkMBPEodOUhcWCzHAZfSVkKTBEPthT/VmbhGxAe/gGXOU8PV+YNRoXlozvPTtHS8781xPEAoDyhl6uvsegR9WK4jZ6a5IpllTfEeZ/5vo1mIlSyca0+Z8kXeiRYCFQg3cX2GstzQQ13tQjfCYKMeKVI3Q5dxbr67m8RD87SwzKzc3JXcRSLx0XyGkKxOX5aWrA9zqA3oCRgcYu/PP+wDuBt/6
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c6ceb7-578c-4100-8b52-08d832f102a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 12:23:18.5057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T9oxUAcaQH+FRTbrT5RxUaoJfIoRjFxeQz8cgTzgE7hbb+uOz8DI/06Y5E+Q81ZT8diU2rriYFvNdP2IraoC0vrCA3qPZPm+bSa7MmJ1F+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6042
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
