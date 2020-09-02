Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89DC25AEE0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgIBPai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:30:38 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:59350 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbgIBPaT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599060619; x=1630596619;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Tt9BLtkysFXPF66nNHl7neFrmawdQIbAbjpVhEBGRKs=;
  b=KH2bphu9PkEFvncTXEZdlzon9K6bpMORo9Z98/C8q4GFFTbZE48QiGEl
   teJMn+2oPMBHhWH5LujTyaRwx8DszajM3Y/CoGegBmhYaQzAXWKK2mM6a
   FjuHNCwgg/gVAuHGQWAZpRl4WCt3p0xCRLEAoN6iSfyezudHS/0RfIVb4
   qPzrK5CWZyM82LmCzSBwUPKp+Y8OGUZF8xvSpPUYqeS9Zg0o9Ncrh6lLf
   Mu/tYH8rRGLYNWKmia8m5+rsXPHfl2PtvQZ1EJ5zV3yg1HgWXtzQbh+qQ
   6D6ZLvfnv7vWxI/VxPkvqJioo2WNK0IPxx8VSCyxhu7lYt7r4npwH7pN0
   Q==;
IronPort-SDR: ul+8WGaS9Q6UHdbADKmLUuKNblUloYfhycMSdyP1lItExoM/yiZVyTWahevYXZOksdHkGE1w4L
 NqPXXNg624Nsn1grxNzby/sBzbMFLNkkjPozsN30ZPdARRVHlBRGqotPAfWdYi9eu6IlK8t50t
 GAuN1WPPfmB+A15nr7NnFqfh56dt1GOPdyY6ks2bhD0LOBfSKGuXg4+K5i12tEllj69Q/Sowca
 Z7d7f5caUQsM9Sb27BGlh6lCNpQBJVY6O3xcPT23+teM5E/CbqREs5Y7qR2paTDKXH+q9JAczk
 C74=
X-IronPort-AV: E=Sophos;i="5.76,383,1592841600"; 
   d="scan'208";a="147641356"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 23:30:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLJ7rU1S6O9c+bzrMp7GS//8uwKW8JKFRzfMV9421yTD82HbiZwpq4TQJ8PSSHUpywC98utC68u1mPK9sgsBYKwFXpXxFgR7YqPsIKSoRYogTyp6PZ2xCmzZeFCJ6zq2B+ZgvpyuRYSr5ohHmcae4JEAkHbYXO+DBYIgmNvmQfY+N+yUnP7xTcsibG21D/NG/2D/sMc5V+PA35xEmiYndJ73f2U6GSOIzarHqrpnWJMgr+1J7y488v80LhmBGa9PZTFvRNyYI0fyrVOmHadr/AnXLuhMGbWXGwa7E2y4S6UsFKqtNPgH80wmFE96ZFsapWbRqDxoK2CVUgfB5xTWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tt9BLtkysFXPF66nNHl7neFrmawdQIbAbjpVhEBGRKs=;
 b=nYhzrBorooVEz+j63pmlZpLmvSYBRwdifSHd0uBZxxaoEr9/4EtbBqUDb5ogTNeShNFzB1+IueeHgBSCdTeCYQz4Wj4SRaN/lm20Qvzg5wnjdJMa4/CRFIciNl4lxpQdCxn8vDIl951p6BRH+L3jNz6g41lxS5UjFjQ1E++HX84xK5X+McHo1zBjO8+lZcxVTYPbRYobG7YMSPJiCuPmXaOM3sR5QXFgLVdvTaM/xuEciniYHmuhd0RCPZAuN11sm+XnPkMjGPhmqk6ZaJIp9OOa3OBk8YiwVLQg0nVywtdkGbDqv/AFde26B8RpDQdiqFpPC12fgWES6tQ5s93gtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tt9BLtkysFXPF66nNHl7neFrmawdQIbAbjpVhEBGRKs=;
 b=iMLSBu9eAFjAKj0MieInIskmoReipjbMuYsc6JquX5wnfTBDeihIGW4GkgzwV2p+TqiKOvNkuQShHFOiyy+Hcqvyhv7W0v/dQ0pdx6DzKSStkztqmzZ9oPCUt1bemE+W6O2XpYwHl7KvWdCYtrXe5b+LjiQBKOHij/OIwkpUsyA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3600.namprd04.prod.outlook.com
 (2603:10b6:803:46::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 15:30:15 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 15:30:15 +0000
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
Subject: Re: [PATCH 05/19] swim: use bdev_check_media_change
Thread-Topic: [PATCH 05/19] swim: use bdev_check_media_change
Thread-Index: AQHWgTcWjjeF2Hw+gkWVVA7OvkInPg==
Date:   Wed, 2 Sep 2020 15:30:14 +0000
Message-ID: <SN4PR0401MB359876A023673111737EB7BE9B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200902141218.212614-1-hch@lst.de>
 <20200902141218.212614-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:1584:4722:fd5f:b30e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ba315de2-1f2b-4556-573d-08d84f55170a
x-ms-traffictypediagnostic: SN4PR0401MB3600:
x-microsoft-antispam-prvs: <SN4PR0401MB36006DAEEA65F49A41B03D829B2F0@SN4PR0401MB3600.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8t7GXuMIYkT7GcBpwgM5y7hMDmFkm/RSrpiB9Ocu29400Q/r+eRESqpXWjRoax7MPqz1AaCrV4feXZ/I2iiz5DHxrILPY8AMPijcqgV/OT9KOtRH8Q/r+T3x+D71pD65DA7ZkXQCwlq48n1qi6/d5Aibuzl8/C35X4vNNBAPpXFpuqH9IkWaX7dj6IguI+erw6dVwaRuWD/qWeL0I6nlRM2XYsQrH2zqfXKK4wFcNOB2elsLzWF1uZ6oJP9GOIYQY6tJZlJlGqs0jlvWZ7ckErcnwV2PlSBaHJVYlWcOw2Xac1hf6bfHCY4NqmftPXTViegqrOcSNxMZNHkUe8lQbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39850400004)(366004)(396003)(52536014)(9686003)(8676002)(66946007)(86362001)(7416002)(54906003)(33656002)(316002)(64756008)(66446008)(8936002)(478600001)(66476007)(66556008)(186003)(110136005)(55016002)(6506007)(83380400001)(2906002)(7696005)(91956017)(71200400001)(5660300002)(558084003)(76116006)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7UFA+LdLILSaTgerBOMq8m+G+HusU/ssY38AT0dHFGX2W16kXcBQEtsVPxyE+j7uVn2nvr1+1Yi+x8wc1hqqyLoiOD9wT/5lWg+Q3hLTwoc6sMxTePe7UAoz3V65KRukzQsePJnBLCqYnlMDxQ4oycJYGut3sUrxS0kOkpb1ktwZPdh/ME5TiSxVmzlFpM+ST8exjkf4t1tJkqqILc/oqCG3yt6+jmU0Sc+xkedIfwPbjFt9626K6PFWbCyOWZeRp18k+kKZyjv2fLPcYrSO9HIqS5KOmEt4274zUztaI0Cm7ySTzIiucW38gFIhpdOeUFPkh5EVHu4FupDIe4n6O8cyFw3TveiXy75zrCqALKUbn6EU5TqO/rXjjGTn1ZHnpyohVLH94kfXPYH5ycbzP+FZrixcZvLFR8Z/GFvf8IBvNPznNWP8UjovnVxo0GVi7VccR8pxduoxPwicaTVjzFys/nvxD32/dL/srYzphSvv4DHzFGR8FHciys3hoLHd0y/y7Op0sDQafLbKuC47YSl1x1vNefaZaNF5Xp9MMTWFGLBeN7o6y4pmr5VlTAop+r1OzDM/Xy9WGX5Y9T2YXBWgOmZhB9cU5abM9/tdV12VvDEPJ6n80ucjBgl/afvx2evDZRB1eysfdsO7/2jBHmGIgYkmHq7lh77fPXBHANN0ebH0gcQE/8B69ynHNc9rZSdoaXM74JT+plij+92Bag==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba315de2-1f2b-4556-573d-08d84f55170a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 15:30:14.8564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5rXXUbdKq87JO/eqXQDDd8T8BG9Fyih/KpOIQ7ccfrO0JaL1e+G1ik1YKe/yJq5vtxH8bWg/QsJNrusysImI9m8slOLy+RqAp9AGAScRBgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3600
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
> +static int floppy_revalidate(struct gendisk *disk);=0A=
=0A=
Completely unrelated to this series but, this is the 3rd floppy =0A=
driver in the series defining it's own floppy_revalidate() and =0A=
naming it floppy_revalidate().=0A=
=0A=
This makes grepping and reviewing a pain.=0A=
=0A=
