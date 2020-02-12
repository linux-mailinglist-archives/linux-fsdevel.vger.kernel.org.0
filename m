Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8092C15AB3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 15:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgBLOrn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 09:47:43 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:60131 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgBLOrn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:47:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581518867; x=1613054867;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=LN1Y7CdTXa0DHg/Uq8ETQ+AMOpXnRELlFerN2zd00+M=;
  b=p340XVXBRYNtW0dTDz8P0juRwvXTgAvXfo/3SZFQuag4F2S6MYbybncJ
   S0JJhA+Voc67VpteIn2KLUMATKw3snkfNHJ7WnHdobabY6e70RBJVcoaG
   836ZOxuvP+ACdiDpKzym6s40cqN1tBi7gPqpOaeTO+xlvWXQjHWoY10pD
   IchW+lenLOq01C2LR6BVO/5t68MsTCPd0HnnvodAxPEleWKAbeZO8k/3x
   FCKJmNMwa3TJ+VEXNhQp8vL9UN2SbX964//970TTPIHqP5UbbbZ7YQGMG
   atWc4OkLpY1eLlcEorZk9WDNgkc1vtGO+wITo0cLbrgC/McHkp8ktG7Cj
   w==;
IronPort-SDR: 6JKI9J3aEV8mkPtdKbR9Pt1GgbsbPq52qx9Pqjdb+Cfn6nrlDBc52qQuCWQ4XTjgCC59IZkM1e
 SR8XPEqoLg9NMg9oTE49hNuGwXjjzLVIML1UVRV1s5YFBuQBNmUo6JLYhiGd08I+V7vSguS2ZH
 kh5rsfU25XUx3P3l7syyOnmBMMxTFtGveC9lBHxpUyZcwjdXGJtB/waR9HRQtIiPev0cdkATZO
 3gHSQcEfj5VT3zBF2jCdrnw4AOODI3xlSgrSBHPbU1s3pBgChDDUncKMR3cwKk/0P75RzwY+Vu
 iG4=
X-IronPort-AV: E=Sophos;i="5.70,433,1574092800"; 
   d="scan'208";a="231474566"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 22:47:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRObzuxOjfrPxyRiyNgq1LFL5TRGFc7hSn+z+dM5Sb7fX59S8V+VO0oiS2IvSy0rH/6UhWciQiWNpqKf3DcUrThqsWdHYiShlz2qmjxegKxTMZIwCOVm9J7ALvOe1tRd2xTj/QYpPXiKUuCANSv1fY4ZCMHjtecsNJBmEWb99PyZhZ9DikmVNwulLXSQl40MZOk/HBv7T486kRIEkXpx6mXhJxG0T1Fp1FGBb7m8dYKiogj7DsvJkmxs6lLQ4DxWlxbUYSOw801tj20hjztphLGAd9rFPddFkx6g9L0r9Pu1xoF4gL9cFrp5ngo7zgGELaIBKmWSwpwl9Akc9FKo0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LN1Y7CdTXa0DHg/Uq8ETQ+AMOpXnRELlFerN2zd00+M=;
 b=JbG2ttTRraO7SJWS97sn/P0+6RBGF94I99GJZ5Ho5+k9ZlcWlMGl6WFkm2Kj8SbGdvLSx1gxk8s39+sWJObPifHqauZWfnQYkcTn4O27Ar2z+i/nlz7uirX7JB/HYmgfAq5UADAMSqhcIDIwrHnozqkTfokJmR/MGPg8NEZDidzHdDFysVW5eXd7FeIlthQqSLEgPYPRoLKH4ILgTk9EkBocF4eOWAA/B12xMPsaoIleXyfqEHuf//zD+gIhioJcAd7H0x2QaNRqynu9Jt0EfFUlgA0mqGw1/v8WeYDP7NCLtPqBcpxmRkBk2OVET7ep0gwf2NhN2SEINTixypJNaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LN1Y7CdTXa0DHg/Uq8ETQ+AMOpXnRELlFerN2zd00+M=;
 b=cpo2J4b0QZ8AGQWiQoU07G5fm3A6h12XvE2qPpjfYMxsvZOLxQgqDVYC68HR2ATPscJNJPfyraU3vPvcigMD4Xe8lV25XtQze8/IBFOS+e5o5Z0TjuX2n8NiMYG4oy4Pcbi3AOmvi3LCvekc0/COP7DwlvFTim+RK355Bsv7fy8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3711.namprd04.prod.outlook.com (10.167.150.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Wed, 12 Feb 2020 14:47:40 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 14:47:40 +0000
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
Subject: Re: [PATCH v2 15/21] btrfs: drop unnecessary arguments from clustered
 allocation functions
Thread-Topic: [PATCH v2 15/21] btrfs: drop unnecessary arguments from
 clustered allocation functions
Thread-Index: AQHV4XUL0pYma8JOgkKGP7uQSxosgw==
Date:   Wed, 12 Feb 2020 14:47:40 +0000
Message-ID: <SN4PR0401MB3598E3B82E7598B74E7F11489B1B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-16-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42b27dab-9595-447f-8c6b-08d7afca82bd
x-ms-traffictypediagnostic: SN4PR0401MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3711CC2C58F99BDCB6E5C22F9B1B0@SN4PR0401MB3711.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(199004)(189003)(81166006)(81156014)(8676002)(86362001)(33656002)(53546011)(6506007)(71200400001)(478600001)(55016002)(8936002)(76116006)(558084003)(66446008)(66946007)(91956017)(66476007)(66556008)(54906003)(64756008)(110136005)(186003)(2906002)(4326008)(316002)(52536014)(9686003)(5660300002)(26005)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3711;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pKfeSbj9jtuYnZKmMD+o7nN3GJQIwLlrCerR5yo+h2MI60qp18F68p0+y/w+SAr33s5SZLhouuhK5nrL73p1RjbxP078bzyfNv8gbH0p4Sv7mT8/CA6F2r9lgIsCrydCVLPQQ4l2Xwon+I9a+wk7Gu2QiCJwvX/r994WABlupI0asgoc2m/PzZu9xTV/Lav+s/luKpuDpYdmaGpLz15vWFctN8dFyur/kcHG/pKHqm7+h159aXHZbIN7X3hzRYZWHVd+0lB5zltLxb5XmbPCWoYrY9jwuDF8+linkctUPS3r4EtOYwuLheBtqjEeLPJ9HZ8p7YXLv1yrwyCpe2EjDk/pET68+2b0QswVYJaZebZEjdp0/o2hzb8gnicTqZIjYQw05zFUCXhsZRVHF9wH+NVI766c5HiSjA7JsumMrswgFiP6BxgXjcR2p9zmYXz9
x-ms-exchange-antispam-messagedata: ci2GWpvGcgAKiL/3xrukNQJSuaE5nAmftJ6P8bgds6a7TAQOVNxnfI/MDcxGClMBhHTk4TtncBynri1bXgbEMf7BomWQrNAV/IGY9WxRz7l4a8Sga7JxKy7tgQoW1GaLDhtx0hQRhVgqNHc2GPAIIA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b27dab-9595-447f-8c6b-08d7afca82bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 14:47:40.6740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vg62ldb7WqE0V8wMwJMwjjzjxBHNLhs8CSGXhWY2+i6mbiF75/FYe2PLT5b/nnI/othioRlBU0zFg92jI2Ul4s3DVshjr0U9vgbGfqaxwpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3711
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/02/2020 08:21, Naohiro Aota wrote:=0A=
> Now that, find_free_extent_clustered() and find_free_extent_unclustered()=
=0A=
> can access "last_ptr" from the "clustered" variable. So, we can drop it=
=0A=
> from the arguments.=0A=
=0A=
I'd drop the ". So", like:=0A=
=0A=
[...] from the "clustered" variable, we can [...]=0A=
