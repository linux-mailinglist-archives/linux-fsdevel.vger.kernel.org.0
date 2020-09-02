Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BBB25A67A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 09:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgIBHXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 03:23:31 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:24184 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIBHX2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599031408; x=1630567408;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=rgBt1y3DqK3OzxtZfmi4jEOz2WNpLq7i6qzFJ1jJrVX5WGiBb0/1fYSt
   fEldRDKkAn0djuaYt1wutVeimoeGS0KfPUg4CaNw7Nn7CfZs0N6fk5v2q
   A39pXIIMnArsHYY7LCfkuM3ZUXIVDqxx18fp7xh6RtjdjtNKayOAzDrlb
   QL6A4fm20qT75UouiNYmHScjDZpYd+z0Hr9htglrDvgHSqduY2yR6Cz9v
   vfXeYjVx2T9CAwV9MMXu09f48ksgGF8bXLFw7QOzfkaJPgMIrsT/SkpNX
   dEv+I/aRKJnfn3s2riZ4PHCRIyiOEN9Xn+4GbqdU3tG54JhfmtI1Efu3X
   Q==;
IronPort-SDR: iZA1NX4xGEX2tGQVEnUXM6v/RszU037qLisN/oD5kEqcWtAHPCeqP+xiGYfNRHvHbSOnUegy/t
 eG3HAdmT9GjkNYxacQdy1fxH0NEsN354NLii2CMUnu5uy8xGE6y7usxhvnHYtRzS+6EN5ev3DM
 ZYdg5bFnF0k9rBgdQbWSRGWm+2z0nUnMhtUkBwf49q8gB23O3EOgIec3M8bQFwBkqOVI+ZZBO3
 sX13NIl22igX5DZj9ogvJVqQzX0Tcgv8Ch5ebj4x7pcTs3HMXgorgaK1s1X3vcArwgMapCShYP
 6sA=
X-IronPort-AV: E=Sophos;i="5.76,381,1592841600"; 
   d="scan'208";a="255918286"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 15:23:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQ5rVktvpJ0QngXZfCTSvi8nr/kq1ppH/5RjCAqTO5FVQA2x797GqbzamJ3lpuG+HyaoIQfYwRFAC/S3M67xJ9G3zMJZ7kwaXH+Zm09Juk/87LUzdqp/+CZxfyQ8PAgtr/EDc0AAYVXIdoRKfHgB/AV+cRqY5aq4yZblvObKPmTqYHb/3B+uDlmKcPeKSNnCdT66IOvlXtJNbjPAgKOov3Js8M5xZ1k4Yf1NUNyQLpYzBLctzQ4gdUOFWcs5uQD3ZuFOR6ArRhb8C8hRNHuMn6F0gK4SIeZwKm+jPpBLivvo7dfjcCyhCn65dQTTB1206JZSSSixe0QSPK+7BeojHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=fC3431yZY+6fp8vcMTBO0UtABchjjTcwc2K01Mi9SysMHZEUWaoFWsxEh2UJu6ONPzfC+xupzHf2QZip4wXyDsCArBpkHYj2VfzBt/DnFybGPsMPaWE+I0CctU9YX3Uq6X9CD6LzzX9FFHs1KJyaDW4v8lHLU5y/m42T/yH6zpW6dRmKS4KYtZFAaaMqmz7er3/tBjjS1LXtv5EQBAKxewx2/QC0Pgy60BgljL/Yx3PdOBMCJ33KuvS3RO7uaws603MNW2/PGtTT3lcjOFx8I43oTNiBIY/66geFXW0FaL10ED4HIJp3Yb7UUgXBNP/PwberIgSOQb+nj1W9oDpU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=y2faa9HARq/vlPIM4F+piwd8/uWqdEoEH0vMKTbB+eYnuRMVqmAuoMz/faWYv4MaQtdB/RFrwT0lJzXELpUX5tJNYoFgaP3SIc64vfwXZsI0vRRJoiRdaYTLiMFw5m4Ke9ZYqSya3e7AqLHlkSZfI0vds1j708pvT4hoxrBa3FA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3966.namprd04.prod.outlook.com
 (2603:10b6:805:48::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 07:23:25 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 07:23:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Josef Bacik <josef@toxicpanda.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 4/9] block: add a new revalidate_disk_size helper
Thread-Topic: [PATCH 4/9] block: add a new revalidate_disk_size helper
Thread-Index: AQHWgHkHpPMQqO6xLU+e8pkytfnbLA==
Date:   Wed, 2 Sep 2020 07:23:25 +0000
Message-ID: <SN4PR0401MB35985F2B6C51B7C5027A636A9B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200901155748.2884-1-hch@lst.de>
 <20200901155748.2884-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:bd07:d1f9:7e6b:2014]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 69ff8bf9-9625-4006-fd36-08d84f111505
x-ms-traffictypediagnostic: SN6PR04MB3966:
x-microsoft-antispam-prvs: <SN6PR04MB396665A7C92AC855B3F8521D9B2F0@SN6PR04MB3966.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hgwi3BfWhnnnDgIkp4JinEsRPsE9l/yp8NCvdT7W6LJBOoaGMIOiRWpIxbuZbKjS9fQp8Vx/GfBCs3NdvuK2i7CNXGzLM725FuN3jB9/uvEsOYrNJ6FdwaAY8HIYCKbmGAp8zuRGXHHn3rMwpE9+2seFjIB6vv2SSYkf9y+xFqEjdUh4Nz5KcBiAafed/fA/axjnlt74UVOFiWCPHIDqTZmEbE1J1Fom2fvlutbZpVgmqeMlB9YPaSpdK6/04ccMfYnco0qoVCGA8OGGwx6NKxNIwd9iElv8z+Uztf3VkmiVGO1em6jird+TPQAxKJL6tgXwKOsS/DRf0GMEVYqstA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(55016002)(4270600006)(8676002)(110136005)(54906003)(86362001)(8936002)(186003)(478600001)(2906002)(6506007)(19618925003)(7696005)(52536014)(316002)(558084003)(71200400001)(33656002)(66476007)(7416002)(66946007)(5660300002)(76116006)(9686003)(4326008)(66446008)(91956017)(66556008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: vFNLHs9b/kHj2fYG590roNRfcL1zbCslxrK2eVoil5j0AK565ejnlNmH5xKU9d/qL7938mcPHoDIytiL6QUvAjDmo3imZfkgrzu0BgVzHTlf7nAPoclVZwDELdZ+11YmcUVEztgDcDnOozwhMtVTazfIrhKEJp2tqJNTfCb4QLHY2WOI3NGsZZbpoh12khwHU7M21d1QwufhmT90SlI+2RiWutthWMgxOM0hmbLpMry2GzuK/0PChKAUrLyDyU5eUKhfpyWXpwUA14QTsrrKq3B6ibO+Ro+ECQhZXGNK+po2c7jNT3N1aZGjMIfFpoNB1c4gjTV5dHBQJdq6VX2eppQcBBStwquSfjW8jj4GLNIdv74oJEOIxZ8zUdzcPjhjFHE7qecXooGNqNiKwL0W0fDiYGPxofmApMclzC2c6Uu+YQx1+uf99riMDPzEloiK/EYuZ74RXmxn6CaWiboYFPp7vlq29BY/xFcE/YJ5O00wSOVbn1W4HKwKPRgDO5+7VUga1dw7F88u6Y8Z/jFQVw0KuFQfNB6zvgVFX2Hc5vkoDwVmu3M+7WC3mrSpEK4IXKL28fsBAxXNylrOTWB8IhzIt+QLOXRy0zZSYUn6myBSJ4UuPsZWoKmZvSfxSXETjOgELSEyqZluB3AjF/wHK/hDOne/w58Cax7cBVCdSD3x0251lgqfR8Zwr72JxuRpZY0DT6vQue1l/gZpNkAyxg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ff8bf9-9625-4006-fd36-08d84f111505
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 07:23:25.7788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gSCYLg1WwyTg/4+RKE47zQdd/De9ENoFOHq1+cShPscgTp4vBJU1xTwIdaMHtqE873+RA9d83BOEusc2S7rOhb4WCX5rcvtCHk6TkhLjZ7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3966
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
