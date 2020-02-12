Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A33A515AB70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 15:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBLO4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 09:56:13 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41558 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgBLO4N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581519373; x=1613055373;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=ADllbKKcq+AfMfM0/jqkm9USavz2mbtMkuUY1Cm9DBKRs3ASH3ArqJlH
   R8hOaSr94WUGqBWJ6ZhJ8FVUraDiDbV8CfziCDXJ1cJBqscO/SsHoMbrW
   oropd4aI4ufLfUn3IWOWbzMmL4Zfi+cGrTzBGcUH0fTOJ5HGaokxNIAnv
   LAo0wZf2PDbWE2P1ZYo6riyPTs4hzRR2MiMRO6Dcc1Op6CBegSXQvCj10
   GWld1Wx8XnYnjv5jDeUwczssx74tiloaavRbpfzG1a+eNwIebvEXp3pFf
   /GmwnmZCl4HJRuV32BpSkWb49mtN9WSHUuDr+j7isSg2YSG2K1GtQJPHJ
   g==;
IronPort-SDR: hizFvGaLVrXdO1JQuK1S2Vd2akR/YH9hAs9hgptJuTjNTjH3tf1KHf76yEgyxVR/8OBNzwVslh
 70nXLwBACziFNxTqo5kKvQpz0ilK1/cKcoPppx1L27Gs8v+0aneP6DPQx6RgDh7rcuxpy2SvIB
 AZj6fqC37buHTFEdy2XdIA/lnRx7V1SOnfOaCUdiYR7XmiVeesvCF7K8AXQP4uuH6aBg7axfl6
 r9xXe9PD+0mLUes2FnD2s9CAcTRl/t6ktWRPhp+ezRmtIC4wicdSOB+ZsRhR6Bg2KLXIfcTfkP
 bu8=
X-IronPort-AV: E=Sophos;i="5.70,433,1574092800"; 
   d="scan'208";a="134035436"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 22:56:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzXCK+fhIabeA0f6Sp/zSo3J97C/V42XCyz6B/DArnOOf4XFykuBI5MkVATtyC799gXJ08Q35EgQ9UuinMGNaXcLSC/AU6nLiETGq81LSZPb0TjxUOmpm2UU/y2EasVSsMlLnCIQhppIcD/7JlMUNTW6X6wsJCcyRNT3Me+/7Yul4/+ML5cUz9kJsNK5vhCCyXZnlqVBe8mYkJreoIjVfAO6cWcMfXI/Kas3Q5qdNXQVCyQ0itG3oWcFuygEzJTLlfY4/EIvB98LMYwBTQf/K7MHf2jlXES0zbzw5C3UqM6O+9494aQyoIl9m9ZTznpLZHMRe+UuvPb9eVLj6tFoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=CVtRuclaL5vKWECzcLYhiwzLxXlDso5iZTPN2tvNxOvo8+m78Ind3wPTBZ1FrAET5V4ikblDXmEKswD++3xQeLI24OMJHamQ55uvwyqXN1AOUwu4/mKzvjL2V3tZILsnRtYhHJ8dA1nZTAYJ54JG8MOsClCVpGmAF1QDNdXUgGcCzhb3Pqv1DJP8/ONUEwNMZ0QLwzJwov2aippe+IRD43xJiDRbduAlZBlcSsxn96Z+Wh+8xyPlstESNbVKC1JQxHzG3GJshKSr6+G9KTj5kDogsIVN+9ktz5dC1Do5VOfhwkxBzVz+jBV2bLAe7K/acR5zwV6dkmcnCDRX0+ybbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=z2WlcM/bul7gdmJ/1sTAMkqadzgOxnKgFW1Knzq+UndZH50uE+X9vfe81IixN1WTtW0296FNriof2HenP+9oEwgna7vZhpkOQFhcfo782faX/Hqtn0O5xEx//6AZ1J7Ur9q3fm0oIZGak05JhZaRn/fyZk4ZXf3msGI6qHz6mug=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3583.namprd04.prod.outlook.com (10.167.150.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 12 Feb 2020 14:56:10 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 14:56:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 19/21] btrfs: factor out chunk_allocation_failed()
Thread-Topic: [PATCH v2 19/21] btrfs: factor out chunk_allocation_failed()
Thread-Index: AQHV4XUR+flC3SVyuUGX1Qvh/tRH3g==
Date:   Wed, 12 Feb 2020 14:56:10 +0000
Message-ID: <SN4PR0401MB3598ECC755F4FA6A1FB179349B1B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-20-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9c0e245-982c-4b25-8452-08d7afcbb258
x-ms-traffictypediagnostic: SN4PR0401MB3583:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB35833D604EDE059CFA61A3C19B1B0@SN4PR0401MB3583.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(189003)(199004)(5660300002)(8936002)(86362001)(9686003)(66476007)(66946007)(66446008)(55016002)(6506007)(4326008)(76116006)(64756008)(91956017)(7696005)(66556008)(478600001)(71200400001)(52536014)(558084003)(2906002)(19618925003)(81156014)(33656002)(81166006)(186003)(54906003)(110136005)(26005)(8676002)(4270600006)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3583;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +saq8mpgomWjaonHf9zGnEPkbGAqA4wSPzI3D1fCFJM59k2aunNmNTf8tQcXOu1U98PgNfL9QYitLcLfgjAK5H5RvbLthFHerK0EmZE4r2mAszeuoABftme5FsBpi0wlL1Hdm3w/uRkSQ0PyrMISgKOLirnla0u06Wd9/dHtk3zecKcOfrW0Fkbxwr7z7gjGEnQGxgtZZKyssVlQtFG7ogDAE7wekZfgQZiVnac/PkAkQ1fgPTA6pahFC2adHbVVzGIXBe4XjaXxz+9Gvcx674dQ2K9pP6dw/Kk2E6P1+QqrCgFx26j0PtrmGNG2z8hTWeUNv6gCuB7HxKyRuyasbZhvEEawcEF6tSyf3U7UWwquywiprERCbYmqMyH/Toc0VDcwl+pfr56AegXvVf2oO1sj/8m9fPO8ODthUbbJ5m/q/f5E1LLRExkwPjfj86Mq
x-ms-exchange-antispam-messagedata: g/y9siE7PDK81xKZ7aLnnZCDOfymmws4x+QoUh9x05irSx9JHene+/WZF6zHph7mtIYQoc4WWXsjF8PAwpBkWMEEh7+jVZlxUMzFbazhDYEMpuBD2G1eMW/1hjHT47qjkI066eAFJY8SSMq05hFTrg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c0e245-982c-4b25-8452-08d7afcbb258
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 14:56:10.0212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m4dVviHig0IgR/XwQbGSC53k3FskgYT5LK2iBVg8lumtfVxrZurBHWXcFM3KpvLZvI70ESiRr1xKHBucFWuSMJ92LV/suyMD3u7OPERuqB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3583
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
