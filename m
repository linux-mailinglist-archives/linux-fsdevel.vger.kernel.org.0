Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956C4294A6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 11:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394617AbgJUJYB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 05:24:01 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:29963 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394575AbgJUJYB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 05:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603273154; x=1634809154;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dQ3fJeOKq/DMyS1gQPR4jXbeM/56cY3TNJo4t1Skj/g=;
  b=etEhYaM7SWecMldZ8btAkxkKqMOuWEZNScTSKajo9bahJpVz2EwnGuXz
   uFg7lwnAMm/5otlAH3wR7qSesIWE69AjPdsIyTSzBmt1niWmiT784QA2j
   cbSZXxFJ0CUnQxF6k1rMl8P64swrdAG5qbxiEYG9h35lcYXoRd8lshOpM
   vTkDHMpSd18T/4W5tkY4JJ2+zZFY6mp4hJYJbhX2z8vVNBAUOoWO+ex1i
   q9z7nyx9LWxAYf43eWY8BIw6f21CV8zLDR79rBCXxVNsqi0tOfuJWmX5q
   iuM8Fsw2hptHFDeEZSxJ1N9u27Av7UJE03Kg7YAS2ZPqzvErYOSBqI/A9
   A==;
IronPort-SDR: 3t/M2vVqaQBifwAhgn/SQxwhuqbH4L/rwEVWvmxbJSSmQCxBbGzYXFULyj8GOOxTf4M+6OtNpW
 Px5OyeKG+8Xs02eGti5ngN9fkxwL9fh7lJNQ+PM2eKWmlLB6Uu0DM6AH0e7S0EMy8pked465d1
 17oVo2A5wbtuWVEj36M+Ul+FhBF8hV+OIHCpzFQWcUAAo/2CPB+2USYSpH4kY3NWCg08SS06SM
 jM8Xbb4SvwhggodX4piId/VUfH2m6lWM1PbOIBxSj5vCF8PVzEb9XSytwX4y4tgx8K2yYzOhG5
 t3w=
X-IronPort-AV: E=Sophos;i="5.77,400,1596470400"; 
   d="scan'208";a="253998709"
Received: from mail-sn1nam02lp2053.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.53])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2020 17:39:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQ47KQV8/aZYFDkVyh6QRXck8Imow+lxg+jRoFrfhbKmWNBg9Bm/U1YwTXb3rB+zBkqTzi78+GRP63g9jfQrniUmBNtZRINSbko9J8WQSxIo8X5brcqp0K+l+sP5goun1vUYkv/Ba7/LwJXYwZ4rdVLmayxYLr71WX8JCXLhR8f1+BSwgHKAwGOS6IQLG80szggevIY7v6t3vpkyVBjcUWTxrM0vktJGcpN70L0w+PoTKV9cg+EfbtRT+M52SRCbkJr/YMqg2w7cyvqmp3o96TVndm9dridHpL/rbX8XpuA6umwNp646U0pTNuqUaPSb03JM2tA/iUS7rktFGR6/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRAH0jPsHKn/Rel6OzU5cfBuDH6jC0dRxZ8LmT8Envg=;
 b=TBLHZMHi4/8nXpN3fEcb13pbu941axdDCiBQ1COwRz40wkLNDwdgOeUtJ3ucLDcGveUQcHMP70ExvdqFdt5/BU7mTnHApSdsh9AfeB5sPPsDCXWtURKlJI4wD14oGDd3S0kQFscQZ89O79tgI976JTQYcQj2t3jlaus//GFF1TDKn7p2pOrQhmBHy/05722hr9ECYX40t3DGhXJ9tI0tlQ4v7NhPfCenKH+lCe5fEVonJQDmllAaI/DbaNVUEmPLQFth5OO9GnxvCOH0gAmh6AEI1bkfZYech+GS1R/L2oJfxiuyFzMOaWve1/9JMJfhq4vgHEwBUqTOEgw8xQukWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRAH0jPsHKn/Rel6OzU5cfBuDH6jC0dRxZ8LmT8Envg=;
 b=RR+C6EvXUgIFk/qt3bUTNka6OscJ/QeKl4Dq7jk8i449sfkIbMAZ1ARH5zlR3N17ov5M0XmyzsHNWjFNcZJgns9N8QkuGVA2/TixrRLeXGDCXf+p13Q59YXTA6CakknDRVzyxpni9+32hSTpWBxZQ/ikiqJ+WjuhMwnejxKo5JA=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6446.namprd04.prod.outlook.com (2603:10b6:208:1aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Wed, 21 Oct
 2020 09:23:46 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 09:23:46 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "hch@infradead.org" <hch@infradead.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "jack@suse.cz" <jack@suse.cz>, "tj@kernel.org" <tj@kernel.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] blk-snap - snapshots and change-tracking for block
 devices
Thread-Topic: [PATCH 2/2] blk-snap - snapshots and change-tracking for block
 devices
Thread-Index: AQHWp4lJdYkB5530LUao1vU1j+0tNA==
Date:   Wed, 21 Oct 2020 09:23:45 +0000
Message-ID: <BL0PR04MB65142D9F391FE8777F096EF5E71C0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
 <1603271049-20681-3-git-send-email-sergei.shtepa@veeam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: veeam.com; dkim=none (message not signed)
 header.d=none;veeam.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:ccac:9944:3b6:800f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 03b5fe2a-2d04-4da0-5cc0-08d875a302eb
x-ms-traffictypediagnostic: MN2PR04MB6446:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6446B4A2AC5728173489C898E71C0@MN2PR04MB6446.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:16;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3wiXec0S6722chXwdpjd29Jm2CT/SpFyVmi010e5nCRb+UAkXXfxzxLU08ZUXP650Fc3iO96FFIH6w7YIOa7bQtbdL1hAY87sHXQZBzPB4hkFbSPzpPOphJv6GzKxu4z3/894iJQde/k72RGWyRZUIuodUhYSpX0CjeeCLcZgSe7/ibBvbEhVqYrA8HM4bAFhX4pfQAYrIaclinyfGmkGhBBlSPnwI8iW2SzRfQ0sRn4+uSRs+QvFSkoOxqOHlASetPBLw5Po9QY2dGBW8aPcaCe+/QZFAc/X0ASdbzCre8Cr5nIsBdlEyrnBfuYOaUX9Sfgffp9IzHvpwJ37KMXhX20egAp44F/sfvp6TAmRtQVReD8ImGl9nJVQLFZdiTk1+wEkuZo0qSHaPm5BozbqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(316002)(83380400001)(76116006)(66556008)(91956017)(110136005)(478600001)(5660300002)(55016002)(71200400001)(66446008)(64756008)(6506007)(52536014)(8676002)(53546011)(7696005)(66476007)(8936002)(7416002)(2906002)(9686003)(66946007)(30864003)(186003)(86362001)(33656002)(921003)(559001)(569008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: mXLx1hQzQ2IR49QYPqFLuc1IwNrIyrYO0rW7ctOOHDOl1hOrPyQRDsV/zt1oz2WheNF7IhWhvnab3KWOFvKm5RXcSFmznhXsdSZvMziWu5sr3BvrVPoe6ua/pYafV2JobUfLnhR1Yg0Fo3I/80BwzBAtfSbGOvBw0ETjb6dXWoqvE5IVqtFI47I526cR6bWAztpwWUeho54SaO5DL0vLzbnCrwlQgWjLniUCxqwkuhODmOI4/81U/CWPdXVVN4vou/ORUAQEgzxLcFGe+5cosAbTr4Tf4fjIudRLBirMn7tEWGH0A4MzgK5vFaivh/czGoKg8gmlEyOsL/x/x8GhRzWQdevzfXJf+/2p8yGVkVg1ptOdWQvp96HlDdEeOKdc3EyZIim1bPB1B4doS+JH7Py1DgKmXJwmnJFW+ZHME2d0MLr6LPGuyItYR7NhwNnOWZ0WQTCMrCfsIZDdoGBU1y9b0Jy1ATR+LuzhIhny0X5v6rKfIbVlpP5Oi4BJlp2ev7t4Bby8T+ORUehPKjMfbI++BF1m8ycEDkyb5hYQW+EHnE4zBbs616TPhYRXxNRqgbq1RWoCCihjRfo12YPVsHqmL+mgSLWrXeDHmGTO5e6PVhVA5yyeMbPCPOQ32Y/3BZQuJgNOXjsH9Mj9rByP+P0FTQQUAfWmQVrap6CirdTtJ+DLdXwFzsEuyzk0lLV5CugeiZsbqKaoPJ96YbdJtQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b5fe2a-2d04-4da0-5cc0-08d875a302eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 09:23:45.9335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gdCGDSLKqR2IceHgaeYjvOOFW8koMEcCEbzLwxo8gvK5FQkuwpmH1mN7glmnl0jh6tm3DVsUqOnCf0LYqBeQaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6446
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No commit message...=0A=
=0A=
And this is a 8600+ lines patch.=0A=
Can you split this into manageable pieces ?=0A=
=0A=
I do not think anybody will review such a huge patch.=0A=
=0A=
On 2020/10/21 18:05, Sergei Shtepa wrote:=0A=
> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>=0A=
> ---=0A=
>  drivers/block/Kconfig                       |   2 +=0A=
>  drivers/block/Makefile                      |   1 +=0A=
>  drivers/block/blk-snap/Kconfig              |  24 +=0A=
>  drivers/block/blk-snap/Makefile             |  28 +=0A=
>  drivers/block/blk-snap/big_buffer.c         | 193 ++++=0A=
>  drivers/block/blk-snap/big_buffer.h         |  24 +=0A=
>  drivers/block/blk-snap/blk-snap-ctl.h       | 190 ++++=0A=
>  drivers/block/blk-snap/blk_deferred.c       | 566 +++++++++++=0A=
>  drivers/block/blk-snap/blk_deferred.h       |  67 ++=0A=
>  drivers/block/blk-snap/blk_descr_file.c     |  82 ++=0A=
>  drivers/block/blk-snap/blk_descr_file.h     |  26 +=0A=
>  drivers/block/blk-snap/blk_descr_mem.c      |  66 ++=0A=
>  drivers/block/blk-snap/blk_descr_mem.h      |  14 +=0A=
>  drivers/block/blk-snap/blk_descr_multidev.c |  86 ++=0A=
>  drivers/block/blk-snap/blk_descr_multidev.h |  25 +=0A=
>  drivers/block/blk-snap/blk_descr_pool.c     | 190 ++++=0A=
>  drivers/block/blk-snap/blk_descr_pool.h     |  38 +=0A=
>  drivers/block/blk-snap/blk_redirect.c       | 507 ++++++++++=0A=
>  drivers/block/blk-snap/blk_redirect.h       |  73 ++=0A=
>  drivers/block/blk-snap/blk_util.c           |  33 +=0A=
>  drivers/block/blk-snap/blk_util.h           |  33 +=0A=
>  drivers/block/blk-snap/cbt_map.c            | 210 +++++=0A=
>  drivers/block/blk-snap/cbt_map.h            |  62 ++=0A=
>  drivers/block/blk-snap/common.h             |  31 +=0A=
>  drivers/block/blk-snap/ctrl_fops.c          | 691 ++++++++++++++=0A=
>  drivers/block/blk-snap/ctrl_fops.h          |  19 +=0A=
>  drivers/block/blk-snap/ctrl_pipe.c          | 562 +++++++++++=0A=
>  drivers/block/blk-snap/ctrl_pipe.h          |  34 +=0A=
>  drivers/block/blk-snap/ctrl_sysfs.c         |  73 ++=0A=
>  drivers/block/blk-snap/ctrl_sysfs.h         |   5 +=0A=
>  drivers/block/blk-snap/defer_io.c           | 397 ++++++++=0A=
>  drivers/block/blk-snap/defer_io.h           |  39 +=0A=
>  drivers/block/blk-snap/main.c               |  82 ++=0A=
>  drivers/block/blk-snap/params.c             |  58 ++=0A=
>  drivers/block/blk-snap/params.h             |  29 +=0A=
>  drivers/block/blk-snap/rangevector.c        |  85 ++=0A=
>  drivers/block/blk-snap/rangevector.h        |  31 +=0A=
>  drivers/block/blk-snap/snapimage.c          | 982 ++++++++++++++++++++=
=0A=
>  drivers/block/blk-snap/snapimage.h          |  16 +=0A=
>  drivers/block/blk-snap/snapshot.c           | 225 +++++=0A=
>  drivers/block/blk-snap/snapshot.h           |  17 +=0A=
>  drivers/block/blk-snap/snapstore.c          | 929 ++++++++++++++++++=0A=
>  drivers/block/blk-snap/snapstore.h          |  68 ++=0A=
>  drivers/block/blk-snap/snapstore_device.c   | 532 +++++++++++=0A=
>  drivers/block/blk-snap/snapstore_device.h   |  63 ++=0A=
>  drivers/block/blk-snap/snapstore_file.c     |  52 ++=0A=
>  drivers/block/blk-snap/snapstore_file.h     |  15 +=0A=
>  drivers/block/blk-snap/snapstore_mem.c      |  91 ++=0A=
>  drivers/block/blk-snap/snapstore_mem.h      |  20 +=0A=
>  drivers/block/blk-snap/snapstore_multidev.c | 118 +++=0A=
>  drivers/block/blk-snap/snapstore_multidev.h |  22 +=0A=
>  drivers/block/blk-snap/tracker.c            | 449 +++++++++=0A=
>  drivers/block/blk-snap/tracker.h            |  38 +=0A=
>  drivers/block/blk-snap/tracking.c           | 270 ++++++=0A=
>  drivers/block/blk-snap/tracking.h           |  13 +=0A=
>  drivers/block/blk-snap/version.h            |   7 +=0A=
>  56 files changed, 8603 insertions(+)=0A=
>  create mode 100644 drivers/block/blk-snap/Kconfig=0A=
>  create mode 100644 drivers/block/blk-snap/Makefile=0A=
>  create mode 100644 drivers/block/blk-snap/big_buffer.c=0A=
>  create mode 100644 drivers/block/blk-snap/big_buffer.h=0A=
>  create mode 100644 drivers/block/blk-snap/blk-snap-ctl.h=0A=
>  create mode 100644 drivers/block/blk-snap/blk_deferred.c=0A=
>  create mode 100644 drivers/block/blk-snap/blk_deferred.h=0A=
>  create mode 100644 drivers/block/blk-snap/blk_descr_file.c=0A=
>  create mode 100644 drivers/block/blk-snap/blk_descr_file.h=0A=
>  create mode 100644 drivers/block/blk-snap/blk_descr_mem.c=0A=
>  create mode 100644 drivers/block/blk-snap/blk_descr_mem.h=0A=
>  create mode 100644 drivers/block/blk-snap/blk_descr_multidev.c=0A=
>  create mode 100644 drivers/block/blk-snap/blk_descr_multidev.h=0A=
>  create mode 100644 drivers/block/blk-snap/blk_descr_pool.c=0A=
>  create mode 100644 drivers/block/blk-snap/blk_descr_pool.h=0A=
>  create mode 100644 drivers/block/blk-snap/blk_redirect.c=0A=
>  create mode 100644 drivers/block/blk-snap/blk_redirect.h=0A=
>  create mode 100644 drivers/block/blk-snap/blk_util.c=0A=
>  create mode 100644 drivers/block/blk-snap/blk_util.h=0A=
>  create mode 100644 drivers/block/blk-snap/cbt_map.c=0A=
>  create mode 100644 drivers/block/blk-snap/cbt_map.h=0A=
>  create mode 100644 drivers/block/blk-snap/common.h=0A=
>  create mode 100644 drivers/block/blk-snap/ctrl_fops.c=0A=
>  create mode 100644 drivers/block/blk-snap/ctrl_fops.h=0A=
>  create mode 100644 drivers/block/blk-snap/ctrl_pipe.c=0A=
>  create mode 100644 drivers/block/blk-snap/ctrl_pipe.h=0A=
>  create mode 100644 drivers/block/blk-snap/ctrl_sysfs.c=0A=
>  create mode 100644 drivers/block/blk-snap/ctrl_sysfs.h=0A=
>  create mode 100644 drivers/block/blk-snap/defer_io.c=0A=
>  create mode 100644 drivers/block/blk-snap/defer_io.h=0A=
>  create mode 100644 drivers/block/blk-snap/main.c=0A=
>  create mode 100644 drivers/block/blk-snap/params.c=0A=
>  create mode 100644 drivers/block/blk-snap/params.h=0A=
>  create mode 100644 drivers/block/blk-snap/rangevector.c=0A=
>  create mode 100644 drivers/block/blk-snap/rangevector.h=0A=
>  create mode 100644 drivers/block/blk-snap/snapimage.c=0A=
>  create mode 100644 drivers/block/blk-snap/snapimage.h=0A=
>  create mode 100644 drivers/block/blk-snap/snapshot.c=0A=
>  create mode 100644 drivers/block/blk-snap/snapshot.h=0A=
>  create mode 100644 drivers/block/blk-snap/snapstore.c=0A=
>  create mode 100644 drivers/block/blk-snap/snapstore.h=0A=
>  create mode 100644 drivers/block/blk-snap/snapstore_device.c=0A=
>  create mode 100644 drivers/block/blk-snap/snapstore_device.h=0A=
>  create mode 100644 drivers/block/blk-snap/snapstore_file.c=0A=
>  create mode 100644 drivers/block/blk-snap/snapstore_file.h=0A=
>  create mode 100644 drivers/block/blk-snap/snapstore_mem.c=0A=
>  create mode 100644 drivers/block/blk-snap/snapstore_mem.h=0A=
>  create mode 100644 drivers/block/blk-snap/snapstore_multidev.c=0A=
>  create mode 100644 drivers/block/blk-snap/snapstore_multidev.h=0A=
>  create mode 100644 drivers/block/blk-snap/tracker.c=0A=
>  create mode 100644 drivers/block/blk-snap/tracker.h=0A=
>  create mode 100644 drivers/block/blk-snap/tracking.c=0A=
>  create mode 100644 drivers/block/blk-snap/tracking.h=0A=
>  create mode 100644 drivers/block/blk-snap/version.h=0A=
> =0A=
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig=0A=
> index ecceaaa1a66f..c53ef661110f 100644=0A=
> --- a/drivers/block/Kconfig=0A=
> +++ b/drivers/block/Kconfig=0A=
> @@ -460,4 +460,6 @@ config BLK_DEV_RSXX=0A=
>  =0A=
>  source "drivers/block/rnbd/Kconfig"=0A=
>  =0A=
> +source "drivers/block/blk-snap/Kconfig"=0A=
> +=0A=
>  endif # BLK_DEV=0A=
> diff --git a/drivers/block/Makefile b/drivers/block/Makefile=0A=
> index e1f63117ee94..312000598944 100644=0A=
> --- a/drivers/block/Makefile=0A=
> +++ b/drivers/block/Makefile=0A=
> @@ -40,6 +40,7 @@ obj-$(CONFIG_BLK_DEV_PCIESSD_MTIP32XX)	+=3D mtip32xx/=
=0A=
>  obj-$(CONFIG_BLK_DEV_RSXX) +=3D rsxx/=0A=
>  obj-$(CONFIG_ZRAM) +=3D zram/=0A=
>  obj-$(CONFIG_BLK_DEV_RNBD)	+=3D rnbd/=0A=
> +obj-$(CONFIG_BLK_SNAP)	+=3D blk-snap/=0A=
>  =0A=
>  obj-$(CONFIG_BLK_DEV_NULL_BLK)	+=3D null_blk.o=0A=
>  null_blk-objs	:=3D null_blk_main.o=0A=
> diff --git a/drivers/block/blk-snap/Kconfig b/drivers/block/blk-snap/Kcon=
fig=0A=
> new file mode 100644=0A=
> index 000000000000..7a2db99a80dd=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/Kconfig=0A=
> @@ -0,0 +1,24 @@=0A=
> +# SPDX-License-Identifier: GPL-2.0=0A=
> +#=0A=
> +# blk-snap block io layer filter module configuration=0A=
> +#=0A=
> +#=0A=
> +#select BLK_FILTER=0A=
> +=0A=
> +config BLK_SNAP=0A=
> +	tristate "Block device snapshot filter"=0A=
> +	depends on BLK_FILTER=0A=
> +	help=0A=
> +=0A=
> +	  Allow to create snapshots and track block changes for a block=0A=
> +	  devices. Designed for creating backups for any block devices=0A=
> +	  (without device mapper). Snapshots are temporary and are released=0A=
> +	  then backup is completed. Change block tracking allows you to=0A=
> +	  create incremental or differential backups.=0A=
> +=0A=
> +config BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +	bool "Multi device snapstore configuration support"=0A=
> +	depends on BLK_SNAP=0A=
> +	help=0A=
> +=0A=
> +	  Allow to create snapstore on multiple block devices.=0A=
> diff --git a/drivers/block/blk-snap/Makefile b/drivers/block/blk-snap/Mak=
efile=0A=
> new file mode 100644=0A=
> index 000000000000..1d628e8e1862=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/Makefile=0A=
> @@ -0,0 +1,28 @@=0A=
> +# SPDX-License-Identifier: GPL-2.0=0A=
> +blk-snap-y +=3D blk_deferred.o=0A=
> +blk-snap-y +=3D blk_descr_file.o=0A=
> +blk-snap-y +=3D blk_descr_mem.o=0A=
> +blk-snap-y +=3D blk_descr_multidev.o=0A=
> +blk-snap-y +=3D blk_descr_pool.o=0A=
> +blk-snap-y +=3D blk_redirect.o=0A=
> +blk-snap-y +=3D blk_util.o=0A=
> +blk-snap-y +=3D cbt_map.o=0A=
> +blk-snap-y +=3D ctrl_fops.o=0A=
> +blk-snap-y +=3D ctrl_pipe.o=0A=
> +blk-snap-y +=3D ctrl_sysfs.o=0A=
> +blk-snap-y +=3D defer_io.o=0A=
> +blk-snap-y +=3D main.o=0A=
> +blk-snap-y +=3D params.o=0A=
> +blk-snap-y +=3D big_buffer.o=0A=
> +blk-snap-y +=3D rangevector.o=0A=
> +blk-snap-y +=3D snapimage.o=0A=
> +blk-snap-y +=3D snapshot.o=0A=
> +blk-snap-y +=3D snapstore.o=0A=
> +blk-snap-y +=3D snapstore_device.o=0A=
> +blk-snap-y +=3D snapstore_file.o=0A=
> +blk-snap-y +=3D snapstore_mem.o=0A=
> +blk-snap-y +=3D snapstore_multidev.o=0A=
> +blk-snap-y +=3D tracker.o=0A=
> +blk-snap-y +=3D tracking.o=0A=
> +=0A=
> +obj-$(CONFIG_BLK_SNAP)	 +=3D blk-snap.o=0A=
> diff --git a/drivers/block/blk-snap/big_buffer.c b/drivers/block/blk-snap=
/big_buffer.c=0A=
> new file mode 100644=0A=
> index 000000000000..c0a75255a807=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/big_buffer.c=0A=
> @@ -0,0 +1,193 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#include "common.h"=0A=
> +#include <linux/mm.h>=0A=
> +#include "big_buffer.h"=0A=
> +=0A=
> +static inline size_t page_count_calc(size_t buffer_size)=0A=
> +{=0A=
> +	size_t page_count =3D buffer_size / PAGE_SIZE;=0A=
> +=0A=
> +	if (buffer_size & (PAGE_SIZE - 1))=0A=
> +		page_count +=3D 1;=0A=
> +	return page_count;=0A=
> +}=0A=
> +=0A=
> +struct big_buffer *big_buffer_alloc(size_t buffer_size, int gfp_opt)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	struct big_buffer *bbuff;=0A=
> +	size_t count;=0A=
> +	size_t inx;=0A=
> +=0A=
> +	count =3D page_count_calc(buffer_size);=0A=
> +=0A=
> +	bbuff =3D kzalloc(sizeof(struct big_buffer) + count * sizeof(void *), g=
fp_opt);=0A=
> +	if (bbuff =3D=3D NULL)=0A=
> +		return NULL;=0A=
> +=0A=
> +	bbuff->pg_cnt =3D count;=0A=
> +	for (inx =3D 0; inx < bbuff->pg_cnt; ++inx) {=0A=
> +		struct page *pg =3D alloc_page(gfp_opt);=0A=
> +=0A=
> +		if (!pg) {=0A=
> +			res =3D -ENOMEM;=0A=
> +			break;=0A=
> +		}=0A=
> +		bbuff->pg[inx] =3D page_address(pg);=0A=
> +	}=0A=
> +=0A=
> +	if (res !=3D SUCCESS) {=0A=
> +		big_buffer_free(bbuff);=0A=
> +		return NULL;=0A=
> +	}=0A=
> +=0A=
> +	return bbuff;=0A=
> +}=0A=
> +=0A=
> +void big_buffer_free(struct big_buffer *bbuff)=0A=
> +{=0A=
> +	size_t inx;=0A=
> +	size_t count =3D bbuff->pg_cnt;=0A=
> +=0A=
> +	if (bbuff =3D=3D NULL)=0A=
> +		return;=0A=
> +=0A=
> +	for (inx =3D 0; inx < count; ++inx)=0A=
> +		if (bbuff->pg[inx] !=3D NULL)=0A=
> +			free_page((unsigned long)bbuff->pg[inx]);=0A=
> +=0A=
> +	kfree(bbuff);=0A=
> +}=0A=
> +=0A=
> +size_t big_buffer_copy_to_user(char __user *dst_user, size_t offset, str=
uct big_buffer *bbuff,=0A=
> +			       size_t length)=0A=
> +{=0A=
> +	size_t left_data_length;=0A=
> +	int page_inx =3D offset / PAGE_SIZE;=0A=
> +	size_t processed_len =3D 0;=0A=
> +	size_t unordered =3D offset & (PAGE_SIZE - 1);=0A=
> +=0A=
> +	if (unordered !=3D 0) { //first=0A=
> +		size_t page_len =3D min_t(size_t, (PAGE_SIZE - unordered), length);=0A=
> +=0A=
> +		left_data_length =3D copy_to_user(dst_user + processed_len,=0A=
> +						bbuff->pg[page_inx] + unordered, page_len);=0A=
> +		if (left_data_length !=3D 0) {=0A=
> +			pr_err("Failed to copy data from big_buffer to user buffer\n");=0A=
> +			return processed_len;=0A=
> +		}=0A=
> +=0A=
> +		++page_inx;=0A=
> +		processed_len +=3D page_len;=0A=
> +	}=0A=
> +=0A=
> +	while ((processed_len < length) && (page_inx < bbuff->pg_cnt)) {=0A=
> +		size_t page_len =3D min_t(size_t, PAGE_SIZE, (length - processed_len))=
;=0A=
> +=0A=
> +		left_data_length =3D=0A=
> +			copy_to_user(dst_user + processed_len, bbuff->pg[page_inx], page_len)=
;=0A=
> +		if (left_data_length !=3D 0) {=0A=
> +			pr_err("Failed to copy data from big_buffer to user buffer\n");=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		++page_inx;=0A=
> +		processed_len +=3D page_len;=0A=
> +	}=0A=
> +=0A=
> +	return processed_len;=0A=
> +}=0A=
> +=0A=
> +size_t big_buffer_copy_from_user(const char __user *src_user, size_t off=
set,=0A=
> +				 struct big_buffer *bbuff, size_t length)=0A=
> +{=0A=
> +	size_t left_data_length;=0A=
> +	int page_inx =3D offset / PAGE_SIZE;=0A=
> +	size_t processed_len =3D 0;=0A=
> +	size_t unordered =3D offset & (PAGE_SIZE - 1);=0A=
> +=0A=
> +	if (unordered !=3D 0) { //first=0A=
> +		size_t page_len =3D min_t(size_t, (PAGE_SIZE - unordered), length);=0A=
> +=0A=
> +		left_data_length =3D copy_from_user(bbuff->pg[page_inx] + unordered,=
=0A=
> +						  src_user + processed_len, page_len);=0A=
> +		if (left_data_length !=3D 0) {=0A=
> +			pr_err("Failed to copy data from user buffer to big_buffer\n");=0A=
> +			return processed_len;=0A=
> +		}=0A=
> +=0A=
> +		++page_inx;=0A=
> +		processed_len +=3D page_len;=0A=
> +	}=0A=
> +=0A=
> +	while ((processed_len < length) && (page_inx < bbuff->pg_cnt)) {=0A=
> +		size_t page_len =3D min_t(size_t, PAGE_SIZE, (length - processed_len))=
;=0A=
> +=0A=
> +		left_data_length =3D=0A=
> +			copy_from_user(bbuff->pg[page_inx], src_user + processed_len, page_le=
n);=0A=
> +		if (left_data_length !=3D 0) {=0A=
> +			pr_err("Failed to copy data from user buffer to big_buffer\n");=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		++page_inx;=0A=
> +		processed_len +=3D page_len;=0A=
> +	}=0A=
> +=0A=
> +	return processed_len;=0A=
> +}=0A=
> +=0A=
> +void *big_buffer_get_element(struct big_buffer *bbuff, size_t index, siz=
e_t sizeof_element)=0A=
> +{=0A=
> +	size_t elements_in_page =3D PAGE_SIZE / sizeof_element;=0A=
> +	size_t pg_inx =3D index / elements_in_page;=0A=
> +	size_t pg_ofs =3D (index - (pg_inx * elements_in_page)) * sizeof_elemen=
t;=0A=
> +=0A=
> +	if (pg_inx >=3D bbuff->pg_cnt)=0A=
> +		return NULL;=0A=
> +=0A=
> +	return bbuff->pg[pg_inx] + pg_ofs;=0A=
> +}=0A=
> +=0A=
> +void big_buffer_memset(struct big_buffer *bbuff, int value)=0A=
> +{=0A=
> +	size_t inx;=0A=
> +=0A=
> +	for (inx =3D 0; inx < bbuff->pg_cnt; ++inx)=0A=
> +		memset(bbuff->pg[inx], value, PAGE_SIZE);=0A=
> +}=0A=
> +=0A=
> +void big_buffer_memcpy(struct big_buffer *dst, struct big_buffer *src)=
=0A=
> +{=0A=
> +	size_t inx;=0A=
> +	size_t count =3D min_t(size_t, dst->pg_cnt, src->pg_cnt);=0A=
> +=0A=
> +	for (inx =3D 0; inx < count; ++inx)=0A=
> +		memcpy(dst->pg[inx], src->pg[inx], PAGE_SIZE);=0A=
> +}=0A=
> +=0A=
> +int big_buffer_byte_get(struct big_buffer *bbuff, size_t inx, u8 *value)=
=0A=
> +{=0A=
> +	size_t page_inx =3D inx >> PAGE_SHIFT;=0A=
> +	size_t byte_pos =3D inx & (PAGE_SIZE - 1);=0A=
> +=0A=
> +	if (page_inx >=3D bbuff->pg_cnt)=0A=
> +		return -ENODATA;=0A=
> +=0A=
> +	*value =3D bbuff->pg[page_inx][byte_pos];=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +int big_buffer_byte_set(struct big_buffer *bbuff, size_t inx, u8 value)=
=0A=
> +{=0A=
> +	size_t page_inx =3D inx >> PAGE_SHIFT;=0A=
> +	size_t byte_pos =3D inx & (PAGE_SIZE - 1);=0A=
> +=0A=
> +	if (page_inx >=3D bbuff->pg_cnt)=0A=
> +		return -ENODATA;=0A=
> +=0A=
> +	bbuff->pg[page_inx][byte_pos] =3D value;=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> diff --git a/drivers/block/blk-snap/big_buffer.h b/drivers/block/blk-snap=
/big_buffer.h=0A=
> new file mode 100644=0A=
> index 000000000000..f38ab5288b05=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/big_buffer.h=0A=
> @@ -0,0 +1,24 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
> +#pragma once=0A=
> +=0A=
> +struct big_buffer {=0A=
> +	size_t pg_cnt;=0A=
> +	u8 *pg[0];=0A=
> +};=0A=
> +=0A=
> +struct big_buffer *big_buffer_alloc(size_t count, int gfp_opt);=0A=
> +void big_buffer_free(struct big_buffer *bbuff);=0A=
> +=0A=
> +size_t big_buffer_copy_to_user(char __user *dst_user_buffer, size_t offs=
et,=0A=
> +			       struct big_buffer *bbuff, size_t length);=0A=
> +size_t big_buffer_copy_from_user(const char __user *src_user_buffer, siz=
e_t offset,=0A=
> +				 struct big_buffer *bbuff, size_t length);=0A=
> +=0A=
> +void *big_buffer_get_element(struct big_buffer *bbuff, size_t index, siz=
e_t sizeof_element);=0A=
> +=0A=
> +void big_buffer_memset(struct big_buffer *bbuff, int value);=0A=
> +void big_buffer_memcpy(struct big_buffer *dst, struct big_buffer *src);=
=0A=
> +=0A=
> +//byte access=0A=
> +int big_buffer_byte_get(struct big_buffer *bbuff, size_t inx, u8 *value)=
;=0A=
> +int big_buffer_byte_set(struct big_buffer *bbuff, size_t inx, u8 value);=
=0A=
> diff --git a/drivers/block/blk-snap/blk-snap-ctl.h b/drivers/block/blk-sn=
ap/blk-snap-ctl.h=0A=
> new file mode 100644=0A=
> index 000000000000..4ffd836836b1=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/blk-snap-ctl.h=0A=
> @@ -0,0 +1,190 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
> +#pragma once=0A=
> +=0A=
> +#define MODULE_NAME "blk-snap"=0A=
> +#define SNAP_IMAGE_NAME "blk-snap-image"=0A=
> +=0A=
> +#define SUCCESS 0=0A=
> +=0A=
> +#define MAX_TRACKING_DEVICE_COUNT 256=0A=
> +=0A=
> +#define BLK_SNAP 'V'=0A=
> +=0A=
> +#pragma pack(push, 1)=0A=
> +////////////////////////////////////////////////////////////////////////=
//=0A=
> +// version=0A=
> +=0A=
> +#define BLK_SNAP_COMPATIBILITY_SNAPSTORE 0x0000000000000001ull /* rudime=
nt */=0A=
> +//#define BLK_SNAP_COMPATIBILITY_BTRFS	 0x0000000000000002ull /* rudimen=
t */=0A=
> +#define BLK_SNAP_COMPATIBILITY_MULTIDEV 0x0000000000000004ull=0A=
> +=0A=
> +struct ioctl_compatibility_flags_s {=0A=
> +	unsigned long long flags;=0A=
> +};=0A=
> +#define IOCTL_COMPATIBILITY_FLAGS _IOW(BLK_SNAP, 0, struct ioctl_compati=
bility_flags_s)=0A=
> +=0A=
> +struct ioctl_getversion_s {=0A=
> +	unsigned short major;=0A=
> +	unsigned short minor;=0A=
> +	unsigned short revision;=0A=
> +	unsigned short build;=0A=
> +};=0A=
> +#define IOCTL_GETVERSION _IOW(BLK_SNAP, 1, struct ioctl_getversion_s)=0A=
> +=0A=
> +////////////////////////////////////////////////////////////////////////=
//=0A=
> +// tracking=0A=
> +struct ioctl_dev_id_s {=0A=
> +	int major;=0A=
> +	int minor;=0A=
> +};=0A=
> +#define IOCTL_TRACKING_ADD _IOW(BLK_SNAP, 2, struct ioctl_dev_id_s)=0A=
> +=0A=
> +#define IOCTL_TRACKING_REMOVE _IOW(BLK_SNAP, 3, struct ioctl_dev_id_s)=
=0A=
> +=0A=
> +struct cbt_info_s {=0A=
> +	struct ioctl_dev_id_s dev_id;=0A=
> +	unsigned long long dev_capacity;=0A=
> +	unsigned int cbt_map_size;=0A=
> +	unsigned char snap_number;=0A=
> +	unsigned char generationId[16];=0A=
> +};=0A=
> +struct ioctl_tracking_collect_s {=0A=
> +	unsigned int count;=0A=
> +	union {=0A=
> +		struct cbt_info_s *p_cbt_info;=0A=
> +		unsigned long long ull_cbt_info;=0A=
> +	};=0A=
> +};=0A=
> +#define IOCTL_TRACKING_COLLECT _IOW(BLK_SNAP, 4, struct ioctl_tracking_c=
ollect_s)=0A=
> +=0A=
> +#define IOCTL_TRACKING_BLOCK_SIZE _IOW(BLK_SNAP, 5, unsigned int)=0A=
> +=0A=
> +struct ioctl_tracking_read_cbt_bitmap_s {=0A=
> +	struct ioctl_dev_id_s dev_id;=0A=
> +	unsigned int offset;=0A=
> +	unsigned int length;=0A=
> +	union {=0A=
> +		unsigned char *buff;=0A=
> +		unsigned long long ull_buff;=0A=
> +	};=0A=
> +};=0A=
> +#define IOCTL_TRACKING_READ_CBT_BITMAP _IOR(BLK_SNAP, 6, struct ioctl_tr=
acking_read_cbt_bitmap_s)=0A=
> +=0A=
> +struct block_range_s {=0A=
> +	unsigned long long ofs; //sectors=0A=
> +	unsigned long long cnt; //sectors=0A=
> +};=0A=
> +=0A=
> +struct ioctl_tracking_mark_dirty_blocks_s {=0A=
> +	struct ioctl_dev_id_s image_dev_id;=0A=
> +	unsigned int count;=0A=
> +	union {=0A=
> +		struct block_range_s *p_dirty_blocks;=0A=
> +		unsigned long long ull_dirty_blocks;=0A=
> +	};=0A=
> +};=0A=
> +#define IOCTL_TRACKING_MARK_DIRTY_BLOCKS                                =
                           \=0A=
> +	_IOR(BLK_SNAP, 7, struct ioctl_tracking_mark_dirty_blocks_s)=0A=
> +////////////////////////////////////////////////////////////////////////=
//=0A=
> +// snapshot=0A=
> +=0A=
> +struct ioctl_snapshot_create_s {=0A=
> +	unsigned long long snapshot_id;=0A=
> +	unsigned int count;=0A=
> +	union {=0A=
> +		struct ioctl_dev_id_s *p_dev_id;=0A=
> +		unsigned long long ull_dev_id;=0A=
> +	};=0A=
> +};=0A=
> +#define IOCTL_SNAPSHOT_CREATE _IOW(BLK_SNAP, 0x10, struct ioctl_snapshot=
_create_s)=0A=
> +=0A=
> +#define IOCTL_SNAPSHOT_DESTROY _IOR(BLK_SNAP, 0x11, unsigned long long)=
=0A=
> +=0A=
> +struct ioctl_snapshot_errno_s {=0A=
> +	struct ioctl_dev_id_s dev_id;=0A=
> +	int err_code;=0A=
> +};=0A=
> +#define IOCTL_SNAPSHOT_ERRNO _IOW(BLK_SNAP, 0x12, struct ioctl_snapshot_=
errno_s)=0A=
> +=0A=
> +struct ioctl_range_s {=0A=
> +	unsigned long long left;=0A=
> +	unsigned long long right;=0A=
> +};=0A=
> +=0A=
> +////////////////////////////////////////////////////////////////////////=
//=0A=
> +// snapstore=0A=
> +struct ioctl_snapstore_create_s {=0A=
> +	unsigned char id[16];=0A=
> +	struct ioctl_dev_id_s snapstore_dev_id;=0A=
> +	unsigned int count;=0A=
> +	union {=0A=
> +		struct ioctl_dev_id_s *p_dev_id;=0A=
> +		unsigned long long ull_dev_id;=0A=
> +	};=0A=
> +};=0A=
> +#define IOCTL_SNAPSTORE_CREATE _IOR(BLK_SNAP, 0x28, struct ioctl_snapsto=
re_create_s)=0A=
> +=0A=
> +struct ioctl_snapstore_file_add_s {=0A=
> +	unsigned char id[16];=0A=
> +	unsigned int range_count;=0A=
> +	union {=0A=
> +		struct ioctl_range_s *ranges;=0A=
> +		unsigned long long ull_ranges;=0A=
> +	};=0A=
> +};=0A=
> +#define IOCTL_SNAPSTORE_FILE _IOR(BLK_SNAP, 0x29, struct ioctl_snapstore=
_file_add_s)=0A=
> +=0A=
> +struct ioctl_snapstore_memory_limit_s {=0A=
> +	unsigned char id[16];=0A=
> +	unsigned long long size;=0A=
> +};=0A=
> +#define IOCTL_SNAPSTORE_MEMORY _IOR(BLK_SNAP, 0x2A, struct ioctl_snapsto=
re_memory_limit_s)=0A=
> +=0A=
> +struct ioctl_snapstore_cleanup_s {=0A=
> +	unsigned char id[16];=0A=
> +	unsigned long long filled_bytes;=0A=
> +};=0A=
> +#define IOCTL_SNAPSTORE_CLEANUP _IOW(BLK_SNAP, 0x2B, struct ioctl_snapst=
ore_cleanup_s)=0A=
> +=0A=
> +struct ioctl_snapstore_file_add_multidev_s {=0A=
> +	unsigned char id[16];=0A=
> +	struct ioctl_dev_id_s dev_id;=0A=
> +	unsigned int range_count;=0A=
> +	union {=0A=
> +		struct ioctl_range_s *ranges;=0A=
> +		unsigned long long ull_ranges;=0A=
> +	};=0A=
> +};=0A=
> +#define IOCTL_SNAPSTORE_FILE_MULTIDEV                                   =
                           \=0A=
> +	_IOR(BLK_SNAP, 0x2C, struct ioctl_snapstore_file_add_multidev_s)=0A=
> +////////////////////////////////////////////////////////////////////////=
//=0A=
> +// collect snapshot images=0A=
> +=0A=
> +struct image_info_s {=0A=
> +	struct ioctl_dev_id_s original_dev_id;=0A=
> +	struct ioctl_dev_id_s snapshot_dev_id;=0A=
> +};=0A=
> +=0A=
> +struct ioctl_collect_snapshot_images_s {=0A=
> +	int count; //=0A=
> +	union {=0A=
> +		struct image_info_s *p_image_info;=0A=
> +		unsigned long long ull_image_info;=0A=
> +	};=0A=
> +};=0A=
> +#define IOCTL_COLLECT_SNAPSHOT_IMAGES _IOW(BLK_SNAP, 0x30, struct ioctl_=
collect_snapshot_images_s)=0A=
> +=0A=
> +#pragma pack(pop)=0A=
> +=0A=
> +// commands for character device interface=0A=
> +#define BLK_SNAP_CHARCMD_UNDEFINED 0x00=0A=
> +#define BLK_SNAP_CHARCMD_ACKNOWLEDGE 0x01=0A=
> +#define BLK_SNAP_CHARCMD_INVALID 0xFF=0A=
> +// to module commands=0A=
> +#define BLK_SNAP_CHARCMD_INITIATE 0x21=0A=
> +#define BLK_SNAP_CHARCMD_NEXT_PORTION 0x22=0A=
> +#define BLK_SNAP_CHARCMD_NEXT_PORTION_MULTIDEV 0x23=0A=
> +// from module commands=0A=
> +#define BLK_SNAP_CHARCMD_HALFFILL 0x41=0A=
> +#define BLK_SNAP_CHARCMD_OVERFLOW 0x42=0A=
> +#define BLK_SNAP_CHARCMD_TERMINATE 0x43=0A=
> diff --git a/drivers/block/blk-snap/blk_deferred.c b/drivers/block/blk-sn=
ap/blk_deferred.c=0A=
> new file mode 100644=0A=
> index 000000000000..1d0b7d2c4d71=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/blk_deferred.c=0A=
> @@ -0,0 +1,566 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#define BLK_SNAP_SECTION "-deferred"=0A=
> +#include "common.h"=0A=
> +=0A=
> +#include "blk_deferred.h"=0A=
> +#include "blk_util.h"=0A=
> +#include "snapstore.h"=0A=
> +#include "params.h"=0A=
> +=0A=
> +struct bio_set blk_deferred_bioset =3D { 0 };=0A=
> +=0A=
> +struct dio_bio_complete {=0A=
> +	struct blk_deferred_request *dio_req;=0A=
> +	sector_t bio_sect_len;=0A=
> +};=0A=
> +=0A=
> +struct dio_deadlocked_list {=0A=
> +	struct list_head link;=0A=
> +=0A=
> +	struct blk_deferred_request *dio_req;=0A=
> +};=0A=
> +=0A=
> +LIST_HEAD(dio_deadlocked_list);=0A=
> +DEFINE_RWLOCK(dio_deadlocked_list_lock);=0A=
> +=0A=
> +atomic64_t dio_alloc_count =3D ATOMIC64_INIT(0);=0A=
> +atomic64_t dio_free_count =3D ATOMIC64_INIT(0);=0A=
> +=0A=
> +void blk_deferred_done(void)=0A=
> +{=0A=
> +	struct dio_deadlocked_list *dio_locked;=0A=
> +=0A=
> +	do {=0A=
> +		dio_locked =3D NULL;=0A=
> +=0A=
> +		write_lock(&dio_deadlocked_list_lock);=0A=
> +		if (!list_empty(&dio_deadlocked_list)) {=0A=
> +			dio_locked =3D list_entry(dio_deadlocked_list.next,=0A=
> +						struct dio_deadlocked_list, link);=0A=
> +=0A=
> +			list_del(&dio_locked->link);=0A=
> +		}=0A=
> +		write_unlock(&dio_deadlocked_list_lock);=0A=
> +=0A=
> +		if (dio_locked) {=0A=
> +			if (dio_locked->dio_req->sect_len =3D=3D=0A=
> +			    atomic64_read(&dio_locked->dio_req->sect_processed))=0A=
> +				blk_deferred_request_free(dio_locked->dio_req);=0A=
> +			else=0A=
> +				pr_err("Locked defer IO is still in memory\n");=0A=
> +=0A=
> +			kfree(dio_locked);=0A=
> +		}=0A=
> +	} while (dio_locked);=0A=
> +}=0A=
> +=0A=
> +void blk_deferred_request_deadlocked(struct blk_deferred_request *dio_re=
q)=0A=
> +{=0A=
> +	struct dio_deadlocked_list *dio_locked =3D=0A=
> +		kzalloc(sizeof(struct dio_deadlocked_list), GFP_KERNEL);=0A=
> +=0A=
> +	dio_locked->dio_req =3D dio_req;=0A=
> +=0A=
> +	write_lock(&dio_deadlocked_list_lock);=0A=
> +	list_add_tail(&dio_locked->link, &dio_deadlocked_list);=0A=
> +	write_unlock(&dio_deadlocked_list_lock);=0A=
> +=0A=
> +	pr_warn("Deadlock with defer IO\n");=0A=
> +}=0A=
> +=0A=
> +void blk_deferred_free(struct blk_deferred_io *dio)=0A=
> +{=0A=
> +	size_t inx =3D 0;=0A=
> +=0A=
> +	if (dio->page_array !=3D NULL) {=0A=
> +		while (dio->page_array[inx] !=3D NULL) {=0A=
> +			__free_page(dio->page_array[inx]);=0A=
> +			dio->page_array[inx] =3D NULL;=0A=
> +=0A=
> +			++inx;=0A=
> +		}=0A=
> +=0A=
> +		kfree(dio->page_array);=0A=
> +		dio->page_array =3D NULL;=0A=
> +	}=0A=
> +	kfree(dio);=0A=
> +}=0A=
> +=0A=
> +struct blk_deferred_io *blk_deferred_alloc(unsigned long block_index,=0A=
> +					   union blk_descr_unify blk_descr)=0A=
> +{=0A=
> +	size_t inx;=0A=
> +	size_t page_count;=0A=
> +	struct blk_deferred_io *dio =3D kmalloc(sizeof(struct blk_deferred_io),=
 GFP_NOIO);=0A=
> +=0A=
> +	if (dio =3D=3D NULL)=0A=
> +		return NULL;=0A=
> +=0A=
> +	INIT_LIST_HEAD(&dio->link);=0A=
> +=0A=
> +	dio->blk_descr =3D blk_descr;=0A=
> +	dio->blk_index =3D block_index;=0A=
> +=0A=
> +	dio->sect.ofs =3D block_index << snapstore_block_shift();=0A=
> +	dio->sect.cnt =3D snapstore_block_size();=0A=
> +=0A=
> +	page_count =3D snapstore_block_size() / (PAGE_SIZE / SECTOR_SIZE);=0A=
> +	/*=0A=
> +	 * empty pointer on the end=0A=
> +	 */=0A=
> +	dio->page_array =3D kzalloc((page_count + 1) * sizeof(struct page *), G=
FP_NOIO);=0A=
> +	if (dio->page_array =3D=3D NULL) {=0A=
> +		blk_deferred_free(dio);=0A=
> +		return NULL;=0A=
> +	}=0A=
> +=0A=
> +	for (inx =3D 0; inx < page_count; inx++) {=0A=
> +		dio->page_array[inx] =3D alloc_page(GFP_NOIO);=0A=
> +		if (dio->page_array[inx] =3D=3D NULL) {=0A=
> +			pr_err("Failed to allocate page\n");=0A=
> +			blk_deferred_free(dio);=0A=
> +			return NULL;=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	return dio;=0A=
> +}=0A=
> +=0A=
> +int blk_deferred_bioset_create(void)=0A=
> +{=0A=
> +	return bioset_init(&blk_deferred_bioset, 64, sizeof(struct dio_bio_comp=
lete),=0A=
> +			   BIOSET_NEED_BVECS | BIOSET_NEED_RESCUER);=0A=
> +}=0A=
> +=0A=
> +void blk_deferred_bioset_free(void)=0A=
> +{=0A=
> +	bioset_exit(&blk_deferred_bioset);=0A=
> +}=0A=
> +=0A=
> +struct bio *_blk_deferred_bio_alloc(int nr_iovecs)=0A=
> +{=0A=
> +	struct bio *new_bio =3D bio_alloc_bioset(GFP_NOIO, nr_iovecs, &blk_defe=
rred_bioset);=0A=
> +=0A=
> +	if (new_bio =3D=3D NULL)=0A=
> +		return NULL;=0A=
> +=0A=
> +	new_bio->bi_end_io =3D blk_deferred_bio_endio;=0A=
> +	new_bio->bi_private =3D ((void *)new_bio) - sizeof(struct dio_bio_compl=
ete);=0A=
> +=0A=
> +	return new_bio;=0A=
> +}=0A=
> +=0A=
> +static void blk_deferred_complete(struct blk_deferred_request *dio_req, =
sector_t portion_sect_cnt,=0A=
> +				  int result)=0A=
> +{=0A=
> +	atomic64_add(portion_sect_cnt, &dio_req->sect_processed);=0A=
> +=0A=
> +	if (dio_req->sect_len =3D=3D atomic64_read(&dio_req->sect_processed))=
=0A=
> +		complete(&dio_req->complete);=0A=
> +=0A=
> +	if (result !=3D SUCCESS) {=0A=
> +		dio_req->result =3D result;=0A=
> +		pr_err("Failed to process defer IO request. errno=3D%d\n", result);=0A=
> +	}=0A=
> +}=0A=
> +=0A=
> +void blk_deferred_bio_endio(struct bio *bio)=0A=
> +{=0A=
> +	int local_err;=0A=
> +	struct dio_bio_complete *complete_param =3D (struct dio_bio_complete *)=
bio->bi_private;=0A=
> +=0A=
> +	if (complete_param =3D=3D NULL) {=0A=
> +		//bio already complete=0A=
> +	} else {=0A=
> +		if (bio->bi_status !=3D BLK_STS_OK)=0A=
> +			local_err =3D -EIO;=0A=
> +		else=0A=
> +			local_err =3D SUCCESS;=0A=
> +=0A=
> +		blk_deferred_complete(complete_param->dio_req, complete_param->bio_sec=
t_len,=0A=
> +				      local_err);=0A=
> +		bio->bi_private =3D NULL;=0A=
> +	}=0A=
> +=0A=
> +	bio_put(bio);=0A=
> +}=0A=
> +=0A=
> +static inline size_t _page_count_calculate(sector_t size_sector)=0A=
> +{=0A=
> +	size_t page_count =3D size_sector / (PAGE_SIZE / SECTOR_SIZE);=0A=
> +=0A=
> +	if (unlikely(size_sector & ((PAGE_SIZE / SECTOR_SIZE) - 1)))=0A=
> +		page_count +=3D 1;=0A=
> +=0A=
> +	return page_count;=0A=
> +}=0A=
> +=0A=
> +sector_t _blk_deferred_submit_pages(struct block_device *blk_dev,=0A=
> +				    struct blk_deferred_request *dio_req, int direction,=0A=
> +				    sector_t arr_ofs, struct page **page_array, sector_t ofs_sector,=
=0A=
> +				    sector_t size_sector)=0A=
> +{=0A=
> +	struct bio *bio =3D NULL;=0A=
> +	int nr_iovecs;=0A=
> +	int page_inx =3D arr_ofs >> (PAGE_SHIFT - SECTOR_SHIFT);=0A=
> +	sector_t process_sect =3D 0;=0A=
> +=0A=
> +	nr_iovecs =3D _page_count_calculate(size_sector);=0A=
> +=0A=
> +	while (NULL =3D=3D (bio =3D _blk_deferred_bio_alloc(nr_iovecs))) {=0A=
> +		size_sector =3D (size_sector >> 1) & ~((PAGE_SIZE / SECTOR_SIZE) - 1);=
=0A=
> +		if (size_sector =3D=3D 0)=0A=
> +			return 0;=0A=
> +=0A=
> +		nr_iovecs =3D _page_count_calculate(size_sector);=0A=
> +	}=0A=
> +=0A=
> +	bio_set_dev(bio, blk_dev);=0A=
> +=0A=
> +	if (direction =3D=3D READ)=0A=
> +		bio_set_op_attrs(bio, REQ_OP_READ, 0);=0A=
> +	else=0A=
> +		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);=0A=
> +=0A=
> +	bio->bi_iter.bi_sector =3D ofs_sector;=0A=
> +=0A=
> +	{ //add first=0A=
> +		sector_t unordered =3D arr_ofs & ((PAGE_SIZE / SECTOR_SIZE) - 1);=0A=
> +		sector_t bvec_len_sect =3D=0A=
> +			min_t(sector_t, ((PAGE_SIZE / SECTOR_SIZE) - unordered), size_sector)=
;=0A=
> +		struct page *page =3D page_array[page_inx];=0A=
> +		unsigned int len =3D (unsigned int)from_sectors(bvec_len_sect);=0A=
> +		unsigned int offset =3D (unsigned int)from_sectors(unordered);=0A=
> +=0A=
> +		if (unlikely(page =3D=3D NULL)) {=0A=
> +			pr_err("NULL found in page array");=0A=
> +			bio_put(bio);=0A=
> +			return 0;=0A=
> +		}=0A=
> +		if (unlikely(bio_add_page(bio, page, len, offset) !=3D len)) {=0A=
> +			bio_put(bio);=0A=
> +			return 0;=0A=
> +		}=0A=
> +		++page_inx;=0A=
> +		process_sect +=3D bvec_len_sect;=0A=
> +	}=0A=
> +=0A=
> +	while (process_sect < size_sector) {=0A=
> +		sector_t bvec_len_sect =3D=0A=
> +			min_t(sector_t, (PAGE_SIZE / SECTOR_SIZE), (size_sector - process_sec=
t));=0A=
> +		struct page *page =3D page_array[page_inx];=0A=
> +		unsigned int len =3D (unsigned int)from_sectors(bvec_len_sect);=0A=
> +=0A=
> +=0A=
> +		if (unlikely(page =3D=3D NULL)) {=0A=
> +			pr_err("NULL found in page array");=0A=
> +			break;=0A=
> +		}=0A=
> +		if (unlikely(bio_add_page(bio, page, len, 0) !=3D len))=0A=
> +			break;=0A=
> +=0A=
> +		++page_inx;=0A=
> +		process_sect +=3D bvec_len_sect;=0A=
> +	}=0A=
> +=0A=
> +	((struct dio_bio_complete *)bio->bi_private)->dio_req =3D dio_req;=0A=
> +	((struct dio_bio_complete *)bio->bi_private)->bio_sect_len =3D process_=
sect;=0A=
> +=0A=
> +	submit_bio_direct(bio);=0A=
> +=0A=
> +	return process_sect;=0A=
> +}=0A=
> +=0A=
> +sector_t blk_deferred_submit_pages(struct block_device *blk_dev,=0A=
> +				   struct blk_deferred_request *dio_req, int direction,=0A=
> +				   sector_t arr_ofs, struct page **page_array, sector_t ofs_sector,=
=0A=
> +				   sector_t size_sector)=0A=
> +{=0A=
> +	sector_t process_sect =3D 0;=0A=
> +=0A=
> +	do {=0A=
> +		sector_t portion_sect =3D _blk_deferred_submit_pages(=0A=
> +			blk_dev, dio_req, direction, arr_ofs + process_sect, page_array,=0A=
> +			ofs_sector + process_sect, size_sector - process_sect);=0A=
> +		if (portion_sect =3D=3D 0) {=0A=
> +			pr_err("Failed to submit defer IO pages. Only [%lld] sectors processe=
d\n",=0A=
> +			       process_sect);=0A=
> +			break;=0A=
> +		}=0A=
> +		process_sect +=3D portion_sect;=0A=
> +	} while (process_sect < size_sector);=0A=
> +=0A=
> +	return process_sect;=0A=
> +}=0A=
> +=0A=
> +struct blk_deferred_request *blk_deferred_request_new(void)=0A=
> +{=0A=
> +	struct blk_deferred_request *dio_req =3D NULL;=0A=
> +=0A=
> +	dio_req =3D kzalloc(sizeof(struct blk_deferred_request), GFP_NOIO);=0A=
> +	if (dio_req =3D=3D NULL)=0A=
> +		return NULL;=0A=
> +=0A=
> +	INIT_LIST_HEAD(&dio_req->dios);=0A=
> +=0A=
> +	dio_req->result =3D SUCCESS;=0A=
> +	atomic64_set(&dio_req->sect_processed, 0);=0A=
> +	dio_req->sect_len =3D 0;=0A=
> +	init_completion(&dio_req->complete);=0A=
> +=0A=
> +	return dio_req;=0A=
> +}=0A=
> +=0A=
> +bool blk_deferred_request_already_added(struct blk_deferred_request *dio=
_req,=0A=
> +					unsigned long block_index)=0A=
> +{=0A=
> +	bool result =3D false;=0A=
> +	struct list_head *_list_head;=0A=
> +=0A=
> +	if (list_empty(&dio_req->dios))=0A=
> +		return result;=0A=
> +=0A=
> +	list_for_each(_list_head, &dio_req->dios) {=0A=
> +		struct blk_deferred_io *dio =3D list_entry(_list_head, struct blk_defe=
rred_io, link);=0A=
> +=0A=
> +		if (dio->blk_index =3D=3D block_index) {=0A=
> +			result =3D true;=0A=
> +			break;=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
> +int blk_deferred_request_add(struct blk_deferred_request *dio_req, struc=
t blk_deferred_io *dio)=0A=
> +{=0A=
> +	list_add_tail(&dio->link, &dio_req->dios);=0A=
> +	dio_req->sect_len +=3D dio->sect.cnt;=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +void blk_deferred_request_free(struct blk_deferred_request *dio_req)=0A=
> +{=0A=
> +	if (dio_req !=3D NULL) {=0A=
> +		while (!list_empty(&dio_req->dios)) {=0A=
> +			struct blk_deferred_io *dio =3D=0A=
> +				list_entry(dio_req->dios.next, struct blk_deferred_io, link);=0A=
> +=0A=
> +			list_del(&dio->link);=0A=
> +=0A=
> +			blk_deferred_free(dio);=0A=
> +		}=0A=
> +		kfree(dio_req);=0A=
> +	}=0A=
> +}=0A=
> +=0A=
> +void blk_deferred_request_waiting_skip(struct blk_deferred_request *dio_=
req)=0A=
> +{=0A=
> +	init_completion(&dio_req->complete);=0A=
> +	atomic64_set(&dio_req->sect_processed, 0);=0A=
> +}=0A=
> +=0A=
> +int blk_deferred_request_wait(struct blk_deferred_request *dio_req)=0A=
> +{=0A=
> +	u64 start_jiffies =3D get_jiffies_64();=0A=
> +	u64 current_jiffies;=0A=
> +=0A=
> +	while (wait_for_completion_timeout(&dio_req->complete, (HZ * 1)) =3D=3D=
 0) {=0A=
> +		current_jiffies =3D get_jiffies_64();=0A=
> +		if (jiffies_to_msecs(current_jiffies - start_jiffies) > 60 * 1000) {=
=0A=
> +			pr_warn("Defer IO request timeout\n");=0A=
> +			return -EDEADLK;=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	return dio_req->result;=0A=
> +}=0A=
> +=0A=
> +int blk_deferred_request_read_original(struct block_device *original_blk=
_dev,=0A=
> +				       struct blk_deferred_request *dio_copy_req)=0A=
> +{=0A=
> +	int res =3D -ENODATA;=0A=
> +	struct list_head *_list_head;=0A=
> +=0A=
> +	blk_deferred_request_waiting_skip(dio_copy_req);=0A=
> +=0A=
> +	if (list_empty(&dio_copy_req->dios))=0A=
> +		return res;=0A=
> +=0A=
> +	list_for_each(_list_head, &dio_copy_req->dios) {=0A=
> +		struct blk_deferred_io *dio =3D list_entry(_list_head, struct blk_defe=
rred_io, link);=0A=
> +=0A=
> +		sector_t ofs =3D dio->sect.ofs;=0A=
> +		sector_t cnt =3D dio->sect.cnt;=0A=
> +=0A=
> +		if (cnt !=3D blk_deferred_submit_pages(original_blk_dev, dio_copy_req,=
 READ, 0,=0A=
> +						     dio->page_array, ofs, cnt)) {=0A=
> +			pr_err("Failed to submit reading defer IO request. offset=3D%lld\n",=
=0A=
> +			       dio->sect.ofs);=0A=
> +			res =3D -EIO;=0A=
> +			break;=0A=
> +		}=0A=
> +		res =3D SUCCESS;=0A=
> +	}=0A=
> +=0A=
> +	if (res =3D=3D SUCCESS)=0A=
> +		res =3D blk_deferred_request_wait(dio_copy_req);=0A=
> +=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +=0A=
> +static int _store_file(struct block_device *blk_dev, struct blk_deferred=
_request *dio_copy_req,=0A=
> +		       struct blk_descr_file *blk_descr, struct page **page_array)=0A=
> +{=0A=
> +	struct list_head *_rangelist_head;=0A=
> +	sector_t page_array_ofs =3D 0;=0A=
> +=0A=
> +	if (unlikely(list_empty(&blk_descr->rangelist))) {=0A=
> +		pr_err("Invalid block descriptor");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +	list_for_each(_rangelist_head, &blk_descr->rangelist) {=0A=
> +		struct blk_range_link *range_link;=0A=
> +		sector_t process_sect;=0A=
> +=0A=
> +		range_link =3D list_entry(_rangelist_head, struct blk_range_link, link=
);=0A=
> +		process_sect =3D blk_deferred_submit_pages(blk_dev, dio_copy_req, WRIT=
E,=0A=
> +							 page_array_ofs, page_array,=0A=
> +							 range_link->rg.ofs, range_link->rg.cnt);=0A=
> +		if (range_link->rg.cnt !=3D process_sect) {=0A=
> +			pr_err("Failed to submit defer IO request for storing\n");=0A=
> +			return -EIO;=0A=
> +		}=0A=
> +		page_array_ofs +=3D range_link->rg.cnt;=0A=
> +	}=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +int blk_deferred_request_store_file(struct block_device *blk_dev,=0A=
> +				    struct blk_deferred_request *dio_copy_req)=0A=
> +{=0A=
> +	struct list_head *_dio_list_head;=0A=
> +=0A=
> +	blk_deferred_request_waiting_skip(dio_copy_req);=0A=
> +=0A=
> +	if (unlikely(list_empty(&dio_copy_req->dios))) {=0A=
> +		pr_err("Invalid deferred io request");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +	list_for_each(_dio_list_head, &dio_copy_req->dios) {=0A=
> +		int res;=0A=
> +		struct blk_deferred_io *dio;=0A=
> +=0A=
> +		dio =3D list_entry(_dio_list_head, struct blk_deferred_io, link);=0A=
> +		res =3D _store_file(blk_dev, dio_copy_req, dio->blk_descr.file, dio->p=
age_array);=0A=
> +		if (res !=3D SUCCESS)=0A=
> +			return res;=0A=
> +	}=0A=
> +=0A=
> +	return blk_deferred_request_wait(dio_copy_req);=0A=
> +}=0A=
> +=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +=0A=
> +static int _store_multidev(struct blk_deferred_request *dio_copy_req,=0A=
> +			   struct blk_descr_multidev *blk_descr, struct page **page_array)=0A=
> +{=0A=
> +	struct list_head *_ranges_list_head;=0A=
> +	sector_t page_array_ofs =3D 0;=0A=
> +=0A=
> +	if (unlikely(list_empty(&blk_descr->rangelist))) {=0A=
> +		pr_err("Invalid block descriptor");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +	list_for_each(_ranges_list_head, &blk_descr->rangelist) {=0A=
> +		sector_t process_sect;=0A=
> +		struct blk_range_link_ex *range_link;=0A=
> +=0A=
> +		range_link =3D list_entry(_ranges_list_head, struct blk_range_link_ex,=
 link);=0A=
> +		process_sect =3D blk_deferred_submit_pages(range_link->blk_dev, dio_co=
py_req, WRITE,=0A=
> +							 page_array_ofs, page_array,=0A=
> +							 range_link->rg.ofs, range_link->rg.cnt);=0A=
> +		if (range_link->rg.cnt !=3D process_sect) {=0A=
> +			pr_err("Failed to submit defer IO request for storing\n");=0A=
> +			return -EIO;=0A=
> +		}=0A=
> +=0A=
> +		page_array_ofs +=3D range_link->rg.cnt;=0A=
> +	}=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +int blk_deferred_request_store_multidev(struct blk_deferred_request *dio=
_copy_req)=0A=
> +{=0A=
> +	struct list_head *_dio_list_head;=0A=
> +=0A=
> +	blk_deferred_request_waiting_skip(dio_copy_req);=0A=
> +=0A=
> +	if (unlikely(list_empty(&dio_copy_req->dios))) {=0A=
> +		pr_err("Invalid deferred io request");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +	list_for_each(_dio_list_head, &dio_copy_req->dios) {=0A=
> +		int res;=0A=
> +		struct blk_deferred_io *dio;=0A=
> +=0A=
> +		dio =3D list_entry(_dio_list_head, struct blk_deferred_io, link);=0A=
> +		res =3D _store_multidev(dio_copy_req, dio->blk_descr.multidev, dio->pa=
ge_array);=0A=
> +		if (res !=3D SUCCESS)=0A=
> +			return res;=0A=
> +	}=0A=
> +=0A=
> +	return blk_deferred_request_wait(dio_copy_req);=0A=
> +}=0A=
> +#endif=0A=
> +=0A=
> +static size_t _store_pages(void *dst, struct page **page_array, size_t l=
ength)=0A=
> +{=0A=
> +	size_t page_inx =3D 0;=0A=
> +	size_t processed_len =3D 0;=0A=
> +=0A=
> +	while ((processed_len < length) && (page_array[page_inx] !=3D NULL)) {=
=0A=
> +		void *src;=0A=
> +		size_t page_len =3D min_t(size_t, PAGE_SIZE, (length - processed_len))=
;=0A=
> +=0A=
> +		src =3D page_address(page_array[page_inx]);=0A=
> +		memcpy(dst + processed_len, src, page_len);=0A=
> +=0A=
> +		++page_inx;=0A=
> +		processed_len +=3D page_len;=0A=
> +	}=0A=
> +=0A=
> +	return processed_len;=0A=
> +}=0A=
> +=0A=
> +int blk_deferred_request_store_mem(struct blk_deferred_request *dio_copy=
_req)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	sector_t processed =3D 0;=0A=
> +=0A=
> +	if (!list_empty(&dio_copy_req->dios)) {=0A=
> +		struct list_head *_list_head;=0A=
> +=0A=
> +		list_for_each(_list_head, &dio_copy_req->dios) {=0A=
> +			size_t length;=0A=
> +			size_t portion;=0A=
> +			struct blk_deferred_io *dio;=0A=
> +=0A=
> +			dio =3D list_entry(_list_head, struct blk_deferred_io, link);=0A=
> +			length =3D snapstore_block_size() * SECTOR_SIZE;=0A=
> +=0A=
> +			portion =3D _store_pages(dio->blk_descr.mem->buff, dio->page_array, l=
ength);=0A=
> +			if (unlikely(portion !=3D length)) {=0A=
> +				res =3D -EIO;=0A=
> +				break;=0A=
> +			}=0A=
> +			processed +=3D (sector_t)to_sectors(portion);=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	blk_deferred_complete(dio_copy_req, processed, res);=0A=
> +	return res;=0A=
> +}=0A=
> diff --git a/drivers/block/blk-snap/blk_deferred.h b/drivers/block/blk-sn=
ap/blk_deferred.h=0A=
> new file mode 100644=0A=
> index 000000000000..3c516a835c25=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/blk_deferred.h=0A=
> @@ -0,0 +1,67 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
> +#pragma once=0A=
> +=0A=
> +#include "blk_descr_file.h"=0A=
> +#include "blk_descr_mem.h"=0A=
> +#include "blk_descr_multidev.h"=0A=
> +=0A=
> +#define DEFER_IO_DIO_REQUEST_LENGTH 250=0A=
> +#define DEFER_IO_DIO_REQUEST_SECTORS_COUNT (10 * 1024 * 1024 / SECTOR_SI=
ZE)=0A=
> +=0A=
> +struct blk_deferred_io {=0A=
> +	struct list_head link;=0A=
> +=0A=
> +	unsigned long blk_index;=0A=
> +	union blk_descr_unify blk_descr;=0A=
> +=0A=
> +	struct blk_range sect;=0A=
> +=0A=
> +	struct page **page_array; //null pointer on tail=0A=
> +};=0A=
> +=0A=
> +struct blk_deferred_request {=0A=
> +	struct completion complete;=0A=
> +	sector_t sect_len;=0A=
> +	atomic64_t sect_processed;=0A=
> +	int result;=0A=
> +=0A=
> +	struct list_head dios;=0A=
> +};=0A=
> +=0A=
> +void blk_deferred_done(void);=0A=
> +=0A=
> +struct blk_deferred_io *blk_deferred_alloc(unsigned long block_index,=0A=
> +					   union blk_descr_unify blk_descr);=0A=
> +void blk_deferred_free(struct blk_deferred_io *dio);=0A=
> +=0A=
> +void blk_deferred_bio_endio(struct bio *bio);=0A=
> +=0A=
> +sector_t blk_deferred_submit_pages(struct block_device *blk_dev,=0A=
> +				   struct blk_deferred_request *dio_req, int direction,=0A=
> +				   sector_t arr_ofs, struct page **page_array, sector_t ofs_sector,=
=0A=
> +				   sector_t size_sector);=0A=
> +=0A=
> +struct blk_deferred_request *blk_deferred_request_new(void);=0A=
> +=0A=
> +bool blk_deferred_request_already_added(struct blk_deferred_request *dio=
_req,=0A=
> +					unsigned long block_index);=0A=
> +=0A=
> +int blk_deferred_request_add(struct blk_deferred_request *dio_req, struc=
t blk_deferred_io *dio);=0A=
> +void blk_deferred_request_free(struct blk_deferred_request *dio_req);=0A=
> +void blk_deferred_request_deadlocked(struct blk_deferred_request *dio_re=
q);=0A=
> +=0A=
> +void blk_deferred_request_waiting_skip(struct blk_deferred_request *dio_=
req);=0A=
> +int blk_deferred_request_wait(struct blk_deferred_request *dio_req);=0A=
> +=0A=
> +int blk_deferred_bioset_create(void);=0A=
> +void blk_deferred_bioset_free(void);=0A=
> +=0A=
> +int blk_deferred_request_read_original(struct block_device *original_blk=
_dev,=0A=
> +				       struct blk_deferred_request *dio_copy_req);=0A=
> +=0A=
> +int blk_deferred_request_store_file(struct block_device *blk_dev,=0A=
> +				    struct blk_deferred_request *dio_copy_req);=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +int blk_deferred_request_store_multidev(struct blk_deferred_request *dio=
_copy_req);=0A=
> +#endif=0A=
> +int blk_deferred_request_store_mem(struct blk_deferred_request *dio_copy=
_req);=0A=
> diff --git a/drivers/block/blk-snap/blk_descr_file.c b/drivers/block/blk-=
snap/blk_descr_file.c=0A=
> new file mode 100644=0A=
> index 000000000000..fca298d35744=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/blk_descr_file.c=0A=
> @@ -0,0 +1,82 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#define BLK_SNAP_SECTION "-blk_descr"=0A=
> +#include "common.h"=0A=
> +=0A=
> +#include "blk_descr_file.h"=0A=
> +=0A=
> +static inline void list_assign(struct list_head *dst, struct list_head *=
src)=0A=
> +{=0A=
> +	dst->next =3D src->next;=0A=
> +	dst->prev =3D src->prev;=0A=
> +=0A=
> +	src->next->prev =3D dst;=0A=
> +	src->prev->next =3D dst;=0A=
> +}=0A=
> +=0A=
> +static inline void blk_descr_file_init(struct blk_descr_file *blk_descr,=
=0A=
> +				       struct list_head *rangelist)=0A=
> +{=0A=
> +	list_assign(&blk_descr->rangelist, rangelist);=0A=
> +}=0A=
> +=0A=
> +static inline void blk_descr_file_done(struct blk_descr_file *blk_descr)=
=0A=
> +{=0A=
> +	struct blk_range_link *range_link;=0A=
> +=0A=
> +	while (!list_empty(&blk_descr->rangelist)) {=0A=
> +		range_link =3D list_entry(blk_descr->rangelist.next, struct blk_range_=
link, link);=0A=
> +=0A=
> +		list_del(&range_link->link);=0A=
> +		kfree(range_link);=0A=
> +	}=0A=
> +}=0A=
> +=0A=
> +void blk_descr_file_pool_init(struct blk_descr_pool *pool)=0A=
> +{=0A=
> +	blk_descr_pool_init(pool, 0);=0A=
> +}=0A=
> +=0A=
> +void _blk_descr_file_cleanup(void *descr_array, size_t count)=0A=
> +{=0A=
> +	size_t inx;=0A=
> +	struct blk_descr_file *file_blocks =3D descr_array;=0A=
> +=0A=
> +	for (inx =3D 0; inx < count; ++inx)=0A=
> +		blk_descr_file_done(file_blocks + inx);=0A=
> +}=0A=
> +=0A=
> +void blk_descr_file_pool_done(struct blk_descr_pool *pool)=0A=
> +{=0A=
> +	blk_descr_pool_done(pool, _blk_descr_file_cleanup);=0A=
> +}=0A=
> +=0A=
> +static union blk_descr_unify _blk_descr_file_allocate(void *descr_array,=
 size_t index, void *arg)=0A=
> +{=0A=
> +	union blk_descr_unify blk_descr;=0A=
> +	struct blk_descr_file *file_blocks =3D descr_array;=0A=
> +=0A=
> +	blk_descr.file =3D &file_blocks[index];=0A=
> +=0A=
> +	blk_descr_file_init(blk_descr.file, (struct list_head *)arg);=0A=
> +=0A=
> +	return blk_descr;=0A=
> +}=0A=
> +=0A=
> +int blk_descr_file_pool_add(struct blk_descr_pool *pool, struct list_hea=
d *rangelist)=0A=
> +{=0A=
> +	union blk_descr_unify blk_descr;=0A=
> +=0A=
> +	blk_descr =3D blk_descr_pool_alloc(pool, sizeof(struct blk_descr_file),=
=0A=
> +					 _blk_descr_file_allocate, (void *)rangelist);=0A=
> +	if (blk_descr.ptr =3D=3D NULL) {=0A=
> +		pr_err("Failed to allocate block descriptor\n");=0A=
> +		return -ENOMEM;=0A=
> +	}=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +union blk_descr_unify blk_descr_file_pool_take(struct blk_descr_pool *po=
ol)=0A=
> +{=0A=
> +	return blk_descr_pool_take(pool, sizeof(struct blk_descr_file));=0A=
> +}=0A=
> diff --git a/drivers/block/blk-snap/blk_descr_file.h b/drivers/block/blk-=
snap/blk_descr_file.h=0A=
> new file mode 100644=0A=
> index 000000000000..0e9a5e3efdea=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/blk_descr_file.h=0A=
> @@ -0,0 +1,26 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
> +#pragma once=0A=
> +=0A=
> +#include "blk_descr_pool.h"=0A=
> +=0A=
> +struct blk_descr_file {=0A=
> +	struct list_head rangelist;=0A=
> +};=0A=
> +=0A=
> +struct blk_range_link {=0A=
> +	struct list_head link;=0A=
> +	struct blk_range rg;=0A=
> +};=0A=
> +=0A=
> +void blk_descr_file_pool_init(struct blk_descr_pool *pool);=0A=
> +void blk_descr_file_pool_done(struct blk_descr_pool *pool);=0A=
> +=0A=
> +/*=0A=
> + * allocate new empty block in pool=0A=
> + */=0A=
> +int blk_descr_file_pool_add(struct blk_descr_pool *pool, struct list_hea=
d *rangelist);=0A=
> +=0A=
> +/*=0A=
> + * take empty block from pool=0A=
> + */=0A=
> +union blk_descr_unify blk_descr_file_pool_take(struct blk_descr_pool *po=
ol);=0A=
> diff --git a/drivers/block/blk-snap/blk_descr_mem.c b/drivers/block/blk-s=
nap/blk_descr_mem.c=0A=
> new file mode 100644=0A=
> index 000000000000..cd326ac150b6=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/blk_descr_mem.c=0A=
> @@ -0,0 +1,66 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#define BLK_SNAP_SECTION "-blk_descr"=0A=
> +#include "common.h"=0A=
> +#include "blk_descr_mem.h"=0A=
> +=0A=
> +#define SECTION "blk_descr "=0A=
> +=0A=
> +static inline void blk_descr_mem_init(struct blk_descr_mem *blk_descr, v=
oid *ptr)=0A=
> +{=0A=
> +	blk_descr->buff =3D ptr;=0A=
> +}=0A=
> +=0A=
> +static inline void blk_descr_mem_done(struct blk_descr_mem *blk_descr)=
=0A=
> +{=0A=
> +	blk_descr->buff =3D NULL;=0A=
> +}=0A=
> +=0A=
> +void blk_descr_mem_pool_init(struct blk_descr_pool *pool, size_t availab=
le_blocks)=0A=
> +{=0A=
> +	blk_descr_pool_init(pool, available_blocks);=0A=
> +}=0A=
> +=0A=
> +void blk_descr_mem_cleanup(void *descr_array, size_t count)=0A=
> +{=0A=
> +	size_t inx;=0A=
> +	struct blk_descr_mem *mem_blocks =3D descr_array;=0A=
> +=0A=
> +	for (inx =3D 0; inx < count; ++inx)=0A=
> +		blk_descr_mem_done(mem_blocks + inx);=0A=
> +}=0A=
> +=0A=
> +void blk_descr_mem_pool_done(struct blk_descr_pool *pool)=0A=
> +{=0A=
> +	blk_descr_pool_done(pool, blk_descr_mem_cleanup);=0A=
> +}=0A=
> +=0A=
> +static union blk_descr_unify blk_descr_mem_alloc(void *descr_array, size=
_t index, void *arg)=0A=
> +{=0A=
> +	union blk_descr_unify blk_descr;=0A=
> +	struct blk_descr_mem *mem_blocks =3D descr_array;=0A=
> +=0A=
> +	blk_descr.mem =3D &mem_blocks[index];=0A=
> +=0A=
> +	blk_descr_mem_init(blk_descr.mem, (void *)arg);=0A=
> +=0A=
> +	return blk_descr;=0A=
> +}=0A=
> +=0A=
> +int blk_descr_mem_pool_add(struct blk_descr_pool *pool, void *buffer)=0A=
> +{=0A=
> +	union blk_descr_unify blk_descr;=0A=
> +=0A=
> +	blk_descr =3D blk_descr_pool_alloc(pool, sizeof(struct blk_descr_mem),=
=0A=
> +					 blk_descr_mem_alloc, buffer);=0A=
> +	if (blk_descr.ptr =3D=3D NULL) {=0A=
> +		pr_err("Failed to allocate block descriptor\n");=0A=
> +		return -ENOMEM;=0A=
> +	}=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +union blk_descr_unify blk_descr_mem_pool_take(struct blk_descr_pool *poo=
l)=0A=
> +{=0A=
> +	return blk_descr_pool_take(pool, sizeof(struct blk_descr_mem));=0A=
> +}=0A=
> diff --git a/drivers/block/blk-snap/blk_descr_mem.h b/drivers/block/blk-s=
nap/blk_descr_mem.h=0A=
> new file mode 100644=0A=
> index 000000000000..43e8de76c07c=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/blk_descr_mem.h=0A=
> @@ -0,0 +1,14 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
> +#pragma once=0A=
> +=0A=
> +#include "blk_descr_pool.h"=0A=
> +=0A=
> +struct blk_descr_mem {=0A=
> +	void *buff; //pointer to snapstore block in memory=0A=
> +};=0A=
> +=0A=
> +void blk_descr_mem_pool_init(struct blk_descr_pool *pool, size_t availab=
le_blocks);=0A=
> +void blk_descr_mem_pool_done(struct blk_descr_pool *pool);=0A=
> +=0A=
> +int blk_descr_mem_pool_add(struct blk_descr_pool *pool, void *buffer);=
=0A=
> +union blk_descr_unify blk_descr_mem_pool_take(struct blk_descr_pool *poo=
l);=0A=
> diff --git a/drivers/block/blk-snap/blk_descr_multidev.c b/drivers/block/=
blk-snap/blk_descr_multidev.c=0A=
> new file mode 100644=0A=
> index 000000000000..cf5e0ed6f781=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/blk_descr_multidev.c=0A=
> @@ -0,0 +1,86 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#define BLK_SNAP_SECTION "-blk_descr"=0A=
> +#include "common.h"=0A=
> +=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +#include "blk_descr_multidev.h"=0A=
> +=0A=
> +static inline void list_assign(struct list_head *dst, struct list_head *=
src)=0A=
> +{=0A=
> +	dst->next =3D src->next;=0A=
> +	dst->prev =3D src->prev;=0A=
> +=0A=
> +	src->next->prev =3D dst;=0A=
> +	src->prev->next =3D dst;=0A=
> +}=0A=
> +=0A=
> +static inline void blk_descr_multidev_init(struct blk_descr_multidev *bl=
k_descr,=0A=
> +					   struct list_head *rangelist)=0A=
> +{=0A=
> +	list_assign(&blk_descr->rangelist, rangelist);=0A=
> +}=0A=
> +=0A=
> +static inline void blk_descr_multidev_done(struct blk_descr_multidev *bl=
k_descr)=0A=
> +{=0A=
> +	struct blk_range_link_ex *rangelist;=0A=
> +=0A=
> +	while (!list_empty(&blk_descr->rangelist)) {=0A=
> +		rangelist =3D list_entry(blk_descr->rangelist.next,=0A=
> +				       struct blk_range_link_ex, link);=0A=
> +=0A=
> +		list_del(&rangelist->link);=0A=
> +		kfree(rangelist);=0A=
> +	}=0A=
> +}=0A=
> +=0A=
> +void blk_descr_multidev_pool_init(struct blk_descr_pool *pool)=0A=
> +{=0A=
> +	blk_descr_pool_init(pool, 0);=0A=
> +}=0A=
> +=0A=
> +static void blk_descr_multidev_cleanup(void *descr_array, size_t count)=
=0A=
> +{=0A=
> +	size_t inx;=0A=
> +	struct blk_descr_multidev *descr_multidev =3D descr_array;=0A=
> +=0A=
> +	for (inx =3D 0; inx < count; ++inx)=0A=
> +		blk_descr_multidev_done(descr_multidev + inx);=0A=
> +}=0A=
> +=0A=
> +void blk_descr_multidev_pool_done(struct blk_descr_pool *pool)=0A=
> +{=0A=
> +	blk_descr_pool_done(pool, blk_descr_multidev_cleanup);=0A=
> +}=0A=
> +=0A=
> +static union blk_descr_unify blk_descr_multidev_allocate(void *descr_arr=
ay, size_t index, void *arg)=0A=
> +{=0A=
> +	union blk_descr_unify blk_descr;=0A=
> +	struct blk_descr_multidev *multidev_blocks =3D descr_array;=0A=
> +=0A=
> +	blk_descr.multidev =3D &multidev_blocks[index];=0A=
> +=0A=
> +	blk_descr_multidev_init(blk_descr.multidev, (struct list_head *)arg);=
=0A=
> +=0A=
> +	return blk_descr;=0A=
> +}=0A=
> +=0A=
> +int blk_descr_multidev_pool_add(struct blk_descr_pool *pool, struct list=
_head *rangelist)=0A=
> +{=0A=
> +	union blk_descr_unify blk_descr;=0A=
> +=0A=
> +	blk_descr =3D blk_descr_pool_alloc(pool, sizeof(struct blk_descr_multid=
ev),=0A=
> +					 blk_descr_multidev_allocate, (void *)rangelist);=0A=
> +	if (blk_descr.ptr =3D=3D NULL) {=0A=
> +		pr_err("Failed to allocate block descriptor\n");=0A=
> +		return -ENOMEM;=0A=
> +	}=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +union blk_descr_unify blk_descr_multidev_pool_take(struct blk_descr_pool=
 *pool)=0A=
> +{=0A=
> +	return blk_descr_pool_take(pool, sizeof(struct blk_descr_multidev));=0A=
> +}=0A=
> +=0A=
> +#endif //CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> diff --git a/drivers/block/blk-snap/blk_descr_multidev.h b/drivers/block/=
blk-snap/blk_descr_multidev.h=0A=
> new file mode 100644=0A=
> index 000000000000..0145b0d78b10=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/blk_descr_multidev.h=0A=
> @@ -0,0 +1,25 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
> +#pragma once=0A=
> +=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +=0A=
> +#include "blk_descr_pool.h"=0A=
> +=0A=
> +struct blk_descr_multidev {=0A=
> +	struct list_head rangelist;=0A=
> +};=0A=
> +=0A=
> +struct blk_range_link_ex {=0A=
> +	struct list_head link;=0A=
> +	struct blk_range rg;=0A=
> +	struct block_device *blk_dev;=0A=
> +};=0A=
> +=0A=
> +void blk_descr_multidev_pool_init(struct blk_descr_pool *pool);=0A=
> +void blk_descr_multidev_pool_done(struct blk_descr_pool *pool);=0A=
> +=0A=
> +int blk_descr_multidev_pool_add(struct blk_descr_pool *pool,=0A=
> +				struct list_head *rangelist); //allocate new empty block=0A=
> +union blk_descr_unify blk_descr_multidev_pool_take(struct blk_descr_pool=
 *pool); //take empty=0A=
> +=0A=
> +#endif //CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> diff --git a/drivers/block/blk-snap/blk_descr_pool.c b/drivers/block/blk-=
snap/blk_descr_pool.c=0A=
> new file mode 100644=0A=
> index 000000000000..b1fe2ba9c2d0=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/blk_descr_pool.c=0A=
> @@ -0,0 +1,190 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#define BLK_SNAP_SECTION "-blk_descr"=0A=
> +#include "common.h"=0A=
> +#include "blk_descr_pool.h"=0A=
> +#include "params.h"=0A=
> +=0A=
> +struct pool_el {=0A=
> +	struct list_head link;=0A=
> +=0A=
> +	size_t used_cnt; // used blocks=0A=
> +	size_t capacity; // blocks array capacity=0A=
> +=0A=
> +	u8 descr_array[0];=0A=
> +};=0A=
> +=0A=
> +static void *kmalloc_huge(size_t max_size, size_t min_size, gfp_t flags,=
 size_t *p_allocated_size)=0A=
> +{=0A=
> +	void *ptr =3D NULL;=0A=
> +=0A=
> +	do {=0A=
> +		ptr =3D kmalloc(max_size, flags | __GFP_NOWARN | __GFP_RETRY_MAYFAIL);=
=0A=
> +=0A=
> +		if (ptr !=3D NULL) {=0A=
> +			*p_allocated_size =3D max_size;=0A=
> +			return ptr;=0A=
> +		}=0A=
> +		pr_err("Failed to allocate buffer size=3D%zu\n", max_size);=0A=
> +		max_size =3D max_size >> 1;=0A=
> +	} while (max_size >=3D min_size);=0A=
> +=0A=
> +	pr_err("Failed to allocate buffer.");=0A=
> +	return NULL;=0A=
> +}=0A=
> +=0A=
> +static struct pool_el *pool_el_alloc(size_t blk_descr_size)=0A=
> +{=0A=
> +	size_t el_size;=0A=
> +	struct pool_el *el;=0A=
> +=0A=
> +	el =3D kmalloc_huge(8 * PAGE_SIZE, PAGE_SIZE, GFP_NOIO, &el_size);=0A=
> +	if (el =3D=3D NULL)=0A=
> +		return NULL;=0A=
> +=0A=
> +	el->capacity =3D (el_size - sizeof(struct pool_el)) / blk_descr_size;=
=0A=
> +	el->used_cnt =3D 0;=0A=
> +=0A=
> +	INIT_LIST_HEAD(&el->link);=0A=
> +=0A=
> +	return el;=0A=
> +}=0A=
> +=0A=
> +static void _pool_el_free(struct pool_el *el)=0A=
> +{=0A=
> +	if (el !=3D NULL)=0A=
> +		kfree(el);=0A=
> +}=0A=
> +=0A=
> +void blk_descr_pool_init(struct blk_descr_pool *pool, size_t available_b=
locks)=0A=
> +{=0A=
> +	mutex_init(&pool->lock);=0A=
> +=0A=
> +	INIT_LIST_HEAD(&pool->head);=0A=
> +=0A=
> +	pool->blocks_cnt =3D 0;=0A=
> +=0A=
> +	pool->total_cnt =3D available_blocks;=0A=
> +	pool->take_cnt =3D 0;=0A=
> +}=0A=
> +=0A=
> +void blk_descr_pool_done(struct blk_descr_pool *pool,=0A=
> +			 void (*blocks_cleanup_cb)(void *descr_array, size_t count))=0A=
> +{=0A=
> +	mutex_lock(&pool->lock);=0A=
> +	while (!list_empty(&pool->head)) {=0A=
> +		struct pool_el *el;=0A=
> +=0A=
> +		el =3D list_entry(pool->head.next, struct pool_el, link);=0A=
> +		if (el =3D=3D NULL)=0A=
> +			break;=0A=
> +=0A=
> +		list_del(&el->link);=0A=
> +		--pool->blocks_cnt;=0A=
> +=0A=
> +		pool->total_cnt -=3D el->used_cnt;=0A=
> +=0A=
> +		blocks_cleanup_cb(el->descr_array, el->used_cnt);=0A=
> +=0A=
> +		_pool_el_free(el);=0A=
> +	}=0A=
> +	mutex_unlock(&pool->lock);=0A=
> +}=0A=
> +=0A=
> +union blk_descr_unify blk_descr_pool_alloc(=0A=
> +	struct blk_descr_pool *pool, size_t blk_descr_size,=0A=
> +	union blk_descr_unify (*block_alloc_cb)(void *descr_array, size_t index=
, void *arg),=0A=
> +	void *arg)=0A=
> +{=0A=
> +	union blk_descr_unify blk_descr =3D { NULL };=0A=
> +=0A=
> +	mutex_lock(&pool->lock);=0A=
> +	do {=0A=
> +		struct pool_el *el =3D NULL;=0A=
> +=0A=
> +		if (!list_empty(&pool->head)) {=0A=
> +			el =3D list_entry(pool->head.prev, struct pool_el, link);=0A=
> +			if (el->used_cnt =3D=3D el->capacity)=0A=
> +				el =3D NULL;=0A=
> +		}=0A=
> +=0A=
> +		if (el =3D=3D NULL) {=0A=
> +			el =3D pool_el_alloc(blk_descr_size);=0A=
> +			if (el =3D=3D NULL)=0A=
> +				break;=0A=
> +=0A=
> +			list_add_tail(&el->link, &pool->head);=0A=
> +=0A=
> +			++pool->blocks_cnt;=0A=
> +		}=0A=
> +=0A=
> +		blk_descr =3D block_alloc_cb(el->descr_array, el->used_cnt, arg);=0A=
> +=0A=
> +		++el->used_cnt;=0A=
> +		++pool->total_cnt;=0A=
> +=0A=
> +	} while (false);=0A=
> +	mutex_unlock(&pool->lock);=0A=
> +=0A=
> +	return blk_descr;=0A=
> +}=0A=
> +=0A=
> +static union blk_descr_unify __blk_descr_pool_at(struct blk_descr_pool *=
pool, size_t blk_descr_size,=0A=
> +						 size_t index)=0A=
> +{=0A=
> +	union blk_descr_unify bkl_descr =3D { NULL };=0A=
> +	size_t curr_inx =3D 0;=0A=
> +	struct pool_el *el;=0A=
> +	struct list_head *_list_head;=0A=
> +=0A=
> +	if (list_empty(&(pool)->head))=0A=
> +		return bkl_descr;=0A=
> +=0A=
> +	list_for_each(_list_head, &(pool)->head) {=0A=
> +		el =3D list_entry(_list_head, struct pool_el, link);=0A=
> +=0A=
> +		if ((index >=3D curr_inx) && (index < (curr_inx + el->used_cnt))) {=0A=
> +			bkl_descr.ptr =3D el->descr_array + (index - curr_inx) * blk_descr_si=
ze;=0A=
> +			break;=0A=
> +		}=0A=
> +		curr_inx +=3D el->used_cnt;=0A=
> +	}=0A=
> +=0A=
> +	return bkl_descr;=0A=
> +}=0A=
> +=0A=
> +union blk_descr_unify blk_descr_pool_take(struct blk_descr_pool *pool, s=
ize_t blk_descr_size)=0A=
> +{=0A=
> +	union blk_descr_unify result =3D { NULL };=0A=
> +=0A=
> +	mutex_lock(&pool->lock);=0A=
> +	do {=0A=
> +		if (pool->take_cnt >=3D pool->total_cnt) {=0A=
> +			pr_err("Unable to get block descriptor: ");=0A=
> +			pr_err("not enough descriptors, already took %zu, total %zu\n",=0A=
> +			       pool->take_cnt, pool->total_cnt);=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		result =3D __blk_descr_pool_at(pool, blk_descr_size, pool->take_cnt);=
=0A=
> +		if (result.ptr =3D=3D NULL) {=0A=
> +			pr_err("Unable to get block descriptor: ");=0A=
> +			pr_err("not enough descriptors, already took %zu, total %zu\n",=0A=
> +			       pool->take_cnt, pool->total_cnt);=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		++pool->take_cnt;=0A=
> +	} while (false);=0A=
> +	mutex_unlock(&pool->lock);=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
> +bool blk_descr_pool_check_halffill(struct blk_descr_pool *pool, sector_t=
 empty_limit,=0A=
> +				   sector_t *fill_status)=0A=
> +{=0A=
> +	size_t empty_blocks =3D (pool->total_cnt - pool->take_cnt);=0A=
> +=0A=
> +	*fill_status =3D (sector_t)(pool->take_cnt) << snapstore_block_shift();=
=0A=
> +=0A=
> +	return (empty_blocks < (size_t)(empty_limit >> snapstore_block_shift())=
);=0A=
> +}=0A=
> diff --git a/drivers/block/blk-snap/blk_descr_pool.h b/drivers/block/blk-=
snap/blk_descr_pool.h=0A=
> new file mode 100644=0A=
> index 000000000000..32f8b8c4103e=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/blk_descr_pool.h=0A=
> @@ -0,0 +1,38 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
> +#pragma once=0A=
> +=0A=
> +struct blk_descr_mem;=0A=
> +struct blk_descr_file;=0A=
> +struct blk_descr_multidev;=0A=
> +=0A=
> +union blk_descr_unify {=0A=
> +	void *ptr;=0A=
> +	struct blk_descr_mem *mem;=0A=
> +	struct blk_descr_file *file;=0A=
> +	struct blk_descr_multidev *multidev;=0A=
> +};=0A=
> +=0A=
> +struct blk_descr_pool {=0A=
> +	struct list_head head;=0A=
> +	struct mutex lock;=0A=
> +=0A=
> +	size_t blocks_cnt; // count of struct pool_el=0A=
> +=0A=
> +	size_t total_cnt;  // total count of block descriptors=0A=
> +	size_t take_cnt;   // take count of block descriptors=0A=
> +};=0A=
> +=0A=
> +void blk_descr_pool_init(struct blk_descr_pool *pool, size_t available_b=
locks);=0A=
> +=0A=
> +void blk_descr_pool_done(struct blk_descr_pool *pool,=0A=
> +			 void (*blocks_cleanup_cb)(void *descr_array, size_t count));=0A=
> +=0A=
> +union blk_descr_unify blk_descr_pool_alloc(=0A=
> +	struct blk_descr_pool *pool, size_t blk_descr_size,=0A=
> +	union blk_descr_unify (*block_alloc_cb)(void *descr_array, size_t index=
, void *arg),=0A=
> +	void *arg);=0A=
> +=0A=
> +union blk_descr_unify blk_descr_pool_take(struct blk_descr_pool *pool, s=
ize_t blk_descr_size);=0A=
> +=0A=
> +bool blk_descr_pool_check_halffill(struct blk_descr_pool *pool, sector_t=
 empty_limit,=0A=
> +				   sector_t *fill_status);=0A=
> diff --git a/drivers/block/blk-snap/blk_redirect.c b/drivers/block/blk-sn=
ap/blk_redirect.c=0A=
> new file mode 100644=0A=
> index 000000000000..4c28a8cb4275=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/blk_redirect.c=0A=
> @@ -0,0 +1,507 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#define BLK_SNAP_SECTION "-redirect"=0A=
> +#include "common.h"=0A=
> +#include "blk_util.h"=0A=
> +#include "blk_redirect.h"=0A=
> +=0A=
> +#define bio_vec_sectors(bv) (bv.bv_len >> SECTOR_SHIFT)=0A=
> +=0A=
> +struct bio_set blk_redirect_bioset =3D { 0 };=0A=
> +=0A=
> +int blk_redirect_bioset_create(void)=0A=
> +{=0A=
> +	return bioset_init(&blk_redirect_bioset, 64, 0, BIOSET_NEED_BVECS | BIO=
SET_NEED_RESCUER);=0A=
> +}=0A=
> +=0A=
> +void blk_redirect_bioset_free(void)=0A=
> +{=0A=
> +	bioset_exit(&blk_redirect_bioset);=0A=
> +}=0A=
> +=0A=
> +void blk_redirect_bio_endio(struct bio *bb)=0A=
> +{=0A=
> +	struct blk_redirect_bio *rq_redir =3D (struct blk_redirect_bio *)bb->bi=
_private;=0A=
> +=0A=
> +	if (rq_redir !=3D NULL) {=0A=
> +		int err =3D SUCCESS;=0A=
> +=0A=
> +		if (bb->bi_status !=3D BLK_STS_OK)=0A=
> +			err =3D -EIO;=0A=
> +=0A=
> +		if (err !=3D SUCCESS) {=0A=
> +			pr_err("Failed to process redirect IO request. errno=3D%d\n", 0 - err=
);=0A=
> +=0A=
> +			if (rq_redir->err =3D=3D SUCCESS)=0A=
> +				rq_redir->err =3D err;=0A=
> +		}=0A=
> +=0A=
> +		if (atomic64_dec_and_test(&rq_redir->bio_count))=0A=
> +			blk_redirect_complete(rq_redir, rq_redir->err);=0A=
> +	}=0A=
> +	bio_put(bb);=0A=
> +}=0A=
> +=0A=
> +struct bio *_blk_dev_redirect_bio_alloc(int nr_iovecs, void *bi_private)=
=0A=
> +{=0A=
> +	struct bio *new_bio;=0A=
> +=0A=
> +	new_bio =3D bio_alloc_bioset(GFP_NOIO, nr_iovecs, &blk_redirect_bioset)=
;=0A=
> +	if (new_bio =3D=3D NULL)=0A=
> +		return NULL;=0A=
> +=0A=
> +	new_bio->bi_end_io =3D blk_redirect_bio_endio;=0A=
> +	new_bio->bi_private =3D bi_private;=0A=
> +=0A=
> +	return new_bio;=0A=
> +}=0A=
> +=0A=
> +struct blk_redirect_bio_list *_redirect_bio_allocate_list(struct bio *ne=
w_bio)=0A=
> +{=0A=
> +	struct blk_redirect_bio_list *next;=0A=
> +=0A=
> +	next =3D kzalloc(sizeof(struct blk_redirect_bio_list), GFP_NOIO);=0A=
> +	if (next =3D=3D NULL)=0A=
> +		return NULL;=0A=
> +=0A=
> +	next->next =3D NULL;=0A=
> +	next->this =3D new_bio;=0A=
> +=0A=
> +	return next;=0A=
> +}=0A=
> +=0A=
> +int bio_endio_list_push(struct blk_redirect_bio *rq_redir, struct bio *n=
ew_bio)=0A=
> +{=0A=
> +	struct blk_redirect_bio_list *head;=0A=
> +=0A=
> +	if (rq_redir->bio_list_head =3D=3D NULL) {=0A=
> +		//list is empty, add first bio=0A=
> +		rq_redir->bio_list_head =3D _redirect_bio_allocate_list(new_bio);=0A=
> +		if (rq_redir->bio_list_head =3D=3D NULL)=0A=
> +			return -ENOMEM;=0A=
> +		return SUCCESS;=0A=
> +	}=0A=
> +=0A=
> +	// seek end of list=0A=
> +	head =3D rq_redir->bio_list_head;=0A=
> +	while (head->next !=3D NULL)=0A=
> +		head =3D head->next;=0A=
> +=0A=
> +	//append new bio to the end of list=0A=
> +	head->next =3D _redirect_bio_allocate_list(new_bio);=0A=
> +	if (head->next =3D=3D NULL)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +void bio_endio_list_cleanup(struct blk_redirect_bio_list *curr)=0A=
> +{=0A=
> +	while (curr !=3D NULL) {=0A=
> +		struct blk_redirect_bio_list *next;=0A=
> +=0A=
> +		next =3D curr->next;=0A=
> +		kfree(curr);=0A=
> +		curr =3D next;=0A=
> +	}=0A=
> +}=0A=
> +=0A=
> +static unsigned int get_max_sect(struct block_device *blk_dev)=0A=
> +{=0A=
> +	struct request_queue *q =3D bdev_get_queue(blk_dev);=0A=
> +=0A=
> +	return min((unsigned int)(BIO_MAX_PAGES << (PAGE_SHIFT - SECTOR_SHIFT))=
,=0A=
> +		   q->limits.max_sectors);=0A=
> +}=0A=
> +=0A=
> +static int _blk_dev_redirect_part_fast(struct blk_redirect_bio *rq_redir=
, int direction,=0A=
> +				       struct block_device *blk_dev, sector_t target_pos,=0A=
> +				       sector_t rq_ofs, sector_t rq_count)=0A=
> +{=0A=
> +	__label__ _fail_out;=0A=
> +	__label__ _reprocess_bv;=0A=
> +=0A=
> +	int res =3D SUCCESS;=0A=
> +=0A=
> +	struct bio_vec bvec;=0A=
> +	struct bvec_iter iter;=0A=
> +=0A=
> +	struct bio *new_bio =3D NULL;=0A=
> +=0A=
> +	sector_t sect_ofs =3D 0;=0A=
> +	sector_t processed_sectors =3D 0;=0A=
> +	int nr_iovecs;=0A=
> +	struct blk_redirect_bio_list *bio_endio_rec;=0A=
> +=0A=
> +	nr_iovecs =3D get_max_sect(blk_dev) >> (PAGE_SHIFT - SECTOR_SHIFT);=0A=
> +=0A=
> +	bio_for_each_segment(bvec, rq_redir->bio, iter) {=0A=
> +		sector_t bvec_ofs;=0A=
> +		sector_t bvec_sectors;=0A=
> +=0A=
> +		unsigned int len;=0A=
> +		unsigned int offset;=0A=
> +=0A=
> +		if ((sect_ofs + bio_vec_sectors(bvec)) <=3D rq_ofs) {=0A=
> +			sect_ofs +=3D bio_vec_sectors(bvec);=0A=
> +			continue;=0A=
> +		}=0A=
> +		if (sect_ofs >=3D (rq_ofs + rq_count))=0A=
> +			break;=0A=
> +=0A=
> +		bvec_ofs =3D 0;=0A=
> +		if (sect_ofs < rq_ofs)=0A=
> +			bvec_ofs =3D rq_ofs - sect_ofs;=0A=
> +=0A=
> +		bvec_sectors =3D bio_vec_sectors(bvec) - bvec_ofs;=0A=
> +		if (bvec_sectors > (rq_count - processed_sectors))=0A=
> +			bvec_sectors =3D rq_count - processed_sectors;=0A=
> +=0A=
> +		if (bvec_sectors =3D=3D 0) {=0A=
> +			res =3D -EIO;=0A=
> +			goto _fail_out;=0A=
> +		}=0A=
> +=0A=
> +_reprocess_bv:=0A=
> +		if (new_bio =3D=3D NULL) {=0A=
> +			new_bio =3D _blk_dev_redirect_bio_alloc(nr_iovecs, rq_redir);=0A=
> +			while (new_bio =3D=3D NULL) {=0A=
> +				pr_err("Unable to allocate new bio for redirect IO.\n");=0A=
> +				res =3D -ENOMEM;=0A=
> +				goto _fail_out;=0A=
> +			}=0A=
> +=0A=
> +			bio_set_dev(new_bio, blk_dev);=0A=
> +=0A=
> +			if (direction =3D=3D READ)=0A=
> +				bio_set_op_attrs(new_bio, REQ_OP_READ, 0);=0A=
> +=0A=
> +			if (direction =3D=3D WRITE)=0A=
> +				bio_set_op_attrs(new_bio, REQ_OP_WRITE, 0);=0A=
> +=0A=
> +			new_bio->bi_iter.bi_sector =3D target_pos + processed_sectors;=0A=
> +		}=0A=
> +=0A=
> +		len =3D (unsigned int)from_sectors(bvec_sectors);=0A=
> +		offset =3D bvec.bv_offset + (unsigned int)from_sectors(bvec_ofs);=0A=
> +		if (unlikely(bio_add_page(new_bio, bvec.bv_page, len, offset) !=3D len=
)) {=0A=
> +			if (bio_sectors(new_bio) =3D=3D 0) {=0A=
> +				res =3D -EIO;=0A=
> +				goto _fail_out;=0A=
> +			}=0A=
> +=0A=
> +			res =3D bio_endio_list_push(rq_redir, new_bio);=0A=
> +			if (res !=3D SUCCESS) {=0A=
> +				pr_err("Failed to add bio into bio_endio_list\n");=0A=
> +				goto _fail_out;=0A=
> +			}=0A=
> +=0A=
> +			atomic64_inc(&rq_redir->bio_count);=0A=
> +			new_bio =3D NULL;=0A=
> +=0A=
> +			goto _reprocess_bv;=0A=
> +		}=0A=
> +		processed_sectors +=3D bvec_sectors;=0A=
> +=0A=
> +		sect_ofs +=3D bio_vec_sectors(bvec);=0A=
> +	}=0A=
> +=0A=
> +	if (new_bio !=3D NULL) {=0A=
> +		res =3D bio_endio_list_push(rq_redir, new_bio);=0A=
> +		if (res !=3D SUCCESS) {=0A=
> +			pr_err("Failed to add bio into bio_endio_list\n");=0A=
> +			goto _fail_out;=0A=
> +		}=0A=
> +=0A=
> +		atomic64_inc(&rq_redir->bio_count);=0A=
> +		new_bio =3D NULL;=0A=
> +	}=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +=0A=
> +_fail_out:=0A=
> +	bio_endio_rec =3D rq_redir->bio_list_head;=0A=
> +	while (bio_endio_rec !=3D NULL) {=0A=
> +		if (bio_endio_rec->this !=3D NULL)=0A=
> +			bio_put(bio_endio_rec->this);=0A=
> +=0A=
> +		bio_endio_rec =3D bio_endio_rec->next;=0A=
> +	}=0A=
> +=0A=
> +	bio_endio_list_cleanup(bio_endio_rec);=0A=
> +=0A=
> +	pr_err("Failed to process part of redirect IO request. rq_ofs=3D%lld, r=
q_count=3D%lld\n",=0A=
> +	       rq_ofs, rq_count);=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +int blk_dev_redirect_part(struct blk_redirect_bio *rq_redir, int directi=
on,=0A=
> +			  struct block_device *blk_dev, sector_t target_pos, sector_t rq_ofs,=
=0A=
> +			  sector_t rq_count)=0A=
> +{=0A=
> +	struct request_queue *q =3D bdev_get_queue(blk_dev);=0A=
> +	sector_t logical_block_size_mask =3D=0A=
> +		(sector_t)((q->limits.logical_block_size >> SECTOR_SHIFT) - 1);=0A=
> +=0A=
> +	if (likely(logical_block_size_mask =3D=3D 0))=0A=
> +		return _blk_dev_redirect_part_fast(rq_redir, direction, blk_dev, targe=
t_pos, rq_ofs,=0A=
> +						   rq_count);=0A=
> +=0A=
> +	if (likely((0 =3D=3D (target_pos & logical_block_size_mask)) &&=0A=
> +		   (0 =3D=3D (rq_count & logical_block_size_mask))))=0A=
> +		return _blk_dev_redirect_part_fast(rq_redir, direction, blk_dev, targe=
t_pos, rq_ofs,=0A=
> +						   rq_count);=0A=
> +=0A=
> +	return -EFAULT;=0A=
> +}=0A=
> +=0A=
> +void blk_dev_redirect_submit(struct blk_redirect_bio *rq_redir)=0A=
> +{=0A=
> +	struct blk_redirect_bio_list *head;=0A=
> +	struct blk_redirect_bio_list *curr;=0A=
> +=0A=
> +	head =3D curr =3D rq_redir->bio_list_head;=0A=
> +	rq_redir->bio_list_head =3D NULL;=0A=
> +=0A=
> +	while (curr !=3D NULL) {=0A=
> +		submit_bio_direct(curr->this);=0A=
> +=0A=
> +		curr =3D curr->next;=0A=
> +	}=0A=
> +=0A=
> +	bio_endio_list_cleanup(head);=0A=
> +}=0A=
> +=0A=
> +int blk_dev_redirect_memcpy_part(struct blk_redirect_bio *rq_redir, int =
direction, void *buff,=0A=
> +				 sector_t rq_ofs, sector_t rq_count)=0A=
> +{=0A=
> +	struct bio_vec bvec;=0A=
> +	struct bvec_iter iter;=0A=
> +=0A=
> +	sector_t sect_ofs =3D 0;=0A=
> +	sector_t processed_sectors =3D 0;=0A=
> +=0A=
> +	bio_for_each_segment(bvec, rq_redir->bio, iter) {=0A=
> +		void *mem;=0A=
> +		sector_t bvec_ofs;=0A=
> +		sector_t bvec_sectors;=0A=
> +=0A=
> +		if ((sect_ofs + bio_vec_sectors(bvec)) <=3D rq_ofs) {=0A=
> +			sect_ofs +=3D bio_vec_sectors(bvec);=0A=
> +			continue;=0A=
> +		}=0A=
> +=0A=
> +		if (sect_ofs >=3D (rq_ofs + rq_count))=0A=
> +			break;=0A=
> +=0A=
> +		bvec_ofs =3D 0;=0A=
> +		if (sect_ofs < rq_ofs)=0A=
> +			bvec_ofs =3D rq_ofs - sect_ofs;=0A=
> +=0A=
> +		bvec_sectors =3D bio_vec_sectors(bvec) - bvec_ofs;=0A=
> +		if (bvec_sectors > (rq_count - processed_sectors))=0A=
> +			bvec_sectors =3D rq_count - processed_sectors;=0A=
> +=0A=
> +		mem =3D kmap_atomic(bvec.bv_page);=0A=
> +		if (direction =3D=3D READ) {=0A=
> +			memcpy(mem + bvec.bv_offset + (unsigned int)from_sectors(bvec_ofs),=
=0A=
> +			       buff + (unsigned int)from_sectors(processed_sectors),=0A=
> +			       (unsigned int)from_sectors(bvec_sectors));=0A=
> +		} else {=0A=
> +			memcpy(buff + (unsigned int)from_sectors(processed_sectors),=0A=
> +			       mem + bvec.bv_offset + (unsigned int)from_sectors(bvec_ofs),=
=0A=
> +			       (unsigned int)from_sectors(bvec_sectors));=0A=
> +		}=0A=
> +		kunmap_atomic(mem);=0A=
> +=0A=
> +		processed_sectors +=3D bvec_sectors;=0A=
> +=0A=
> +		sect_ofs +=3D bio_vec_sectors(bvec);=0A=
> +	}=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +int blk_dev_redirect_zeroed_part(struct blk_redirect_bio *rq_redir, sect=
or_t rq_ofs,=0A=
> +				 sector_t rq_count)=0A=
> +{=0A=
> +	struct bio_vec bvec;=0A=
> +	struct bvec_iter iter;=0A=
> +=0A=
> +	sector_t sect_ofs =3D 0;=0A=
> +	sector_t processed_sectors =3D 0;=0A=
> +=0A=
> +	bio_for_each_segment(bvec, rq_redir->bio, iter) {=0A=
> +		void *mem;=0A=
> +		sector_t bvec_ofs;=0A=
> +		sector_t bvec_sectors;=0A=
> +=0A=
> +		if ((sect_ofs + bio_vec_sectors(bvec)) <=3D rq_ofs) {=0A=
> +			sect_ofs +=3D bio_vec_sectors(bvec);=0A=
> +			continue;=0A=
> +		}=0A=
> +=0A=
> +		if (sect_ofs >=3D (rq_ofs + rq_count))=0A=
> +			break;=0A=
> +=0A=
> +		bvec_ofs =3D 0;=0A=
> +		if (sect_ofs < rq_ofs)=0A=
> +			bvec_ofs =3D rq_ofs - sect_ofs;=0A=
> +=0A=
> +		bvec_sectors =3D bio_vec_sectors(bvec) - bvec_ofs;=0A=
> +		if (bvec_sectors > (rq_count - processed_sectors))=0A=
> +			bvec_sectors =3D rq_count - processed_sectors;=0A=
> +=0A=
> +		mem =3D kmap_atomic(bvec.bv_page);=0A=
> +		memset(mem + bvec.bv_offset + (unsigned int)from_sectors(bvec_ofs), 0,=
=0A=
> +		       (unsigned int)from_sectors(bvec_sectors));=0A=
> +		kunmap_atomic(mem);=0A=
> +=0A=
> +		processed_sectors +=3D bvec_sectors;=0A=
> +=0A=
> +		sect_ofs +=3D bio_vec_sectors(bvec);=0A=
> +	}=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +int blk_dev_redirect_read_zeroed(struct blk_redirect_bio *rq_redir, stru=
ct block_device *blk_dev,=0A=
> +				 sector_t rq_pos, sector_t blk_ofs_start, sector_t blk_ofs_count,=0A=
> +				 struct rangevector *zero_sectors)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	struct blk_range_tree_node *range_node;=0A=
> +=0A=
> +	sector_t ofs =3D 0;=0A=
> +=0A=
> +	sector_t from =3D rq_pos + blk_ofs_start;=0A=
> +	sector_t to =3D rq_pos + blk_ofs_start + blk_ofs_count - 1;=0A=
> +=0A=
> +	down_read(&zero_sectors->lock);=0A=
> +	range_node =3D blk_range_rb_iter_first(&zero_sectors->root, from, to);=
=0A=
> +	while (range_node) {=0A=
> +		struct blk_range *zero_range =3D &range_node->range;=0A=
> +		sector_t current_portion;=0A=
> +=0A=
> +		if (zero_range->ofs > rq_pos + blk_ofs_start + ofs) {=0A=
> +			sector_t pre_zero_cnt =3D zero_range->ofs - (rq_pos + blk_ofs_start +=
 ofs);=0A=
> +=0A=
> +			res =3D blk_dev_redirect_part(rq_redir, READ, blk_dev,=0A=
> +						    rq_pos + blk_ofs_start + ofs,=0A=
> +						    blk_ofs_start + ofs, pre_zero_cnt);=0A=
> +			if (res !=3D SUCCESS)=0A=
> +				break;=0A=
> +=0A=
> +			ofs +=3D pre_zero_cnt;=0A=
> +		}=0A=
> +=0A=
> +		current_portion =3D min_t(sector_t, zero_range->cnt, blk_ofs_count - o=
fs);=0A=
> +=0A=
> +		res =3D blk_dev_redirect_zeroed_part(rq_redir, blk_ofs_start + ofs, cu=
rrent_portion);=0A=
> +		if (res !=3D SUCCESS)=0A=
> +			break;=0A=
> +=0A=
> +		ofs +=3D current_portion;=0A=
> +=0A=
> +		range_node =3D blk_range_rb_iter_next(range_node, from, to);=0A=
> +	}=0A=
> +	up_read(&zero_sectors->lock);=0A=
> +=0A=
> +	if (res =3D=3D SUCCESS)=0A=
> +		if ((blk_ofs_count - ofs) > 0)=0A=
> +			res =3D blk_dev_redirect_part(rq_redir, READ, blk_dev,=0A=
> +						    rq_pos + blk_ofs_start + ofs,=0A=
> +						    blk_ofs_start + ofs, blk_ofs_count - ofs);=0A=
> +=0A=
> +	return res;=0A=
> +}=0A=
> +void blk_redirect_complete(struct blk_redirect_bio *rq_redir, int res)=
=0A=
> +{=0A=
> +	rq_redir->complete_cb(rq_redir->complete_param, rq_redir->bio, res);=0A=
> +	redirect_bio_queue_free(rq_redir);=0A=
> +}=0A=
> +=0A=
> +void redirect_bio_queue_init(struct redirect_bio_queue *queue)=0A=
> +{=0A=
> +	INIT_LIST_HEAD(&queue->list);=0A=
> +=0A=
> +	spin_lock_init(&queue->lock);=0A=
> +=0A=
> +	atomic_set(&queue->in_queue_cnt, 0);=0A=
> +	atomic_set(&queue->alloc_cnt, 0);=0A=
> +=0A=
> +	atomic_set(&queue->active_state, true);=0A=
> +}=0A=
> +=0A=
> +struct blk_redirect_bio *redirect_bio_queue_new(struct redirect_bio_queu=
e *queue)=0A=
> +{=0A=
> +	struct blk_redirect_bio *rq_redir =3D kzalloc(sizeof(struct blk_redirec=
t_bio), GFP_NOIO);=0A=
> +=0A=
> +	if (rq_redir =3D=3D NULL)=0A=
> +		return NULL;=0A=
> +=0A=
> +	atomic_inc(&queue->alloc_cnt);=0A=
> +=0A=
> +	INIT_LIST_HEAD(&rq_redir->link);=0A=
> +	rq_redir->queue =3D queue;=0A=
> +=0A=
> +	return rq_redir;=0A=
> +}=0A=
> +=0A=
> +void redirect_bio_queue_free(struct blk_redirect_bio *rq_redir)=0A=
> +{=0A=
> +	if (rq_redir) {=0A=
> +		if (rq_redir->queue)=0A=
> +			atomic_dec(&rq_redir->queue->alloc_cnt);=0A=
> +=0A=
> +		kfree(rq_redir);=0A=
> +	}=0A=
> +}=0A=
> +=0A=
> +int redirect_bio_queue_push_back(struct redirect_bio_queue *queue,=0A=
> +				 struct blk_redirect_bio *rq_redir)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +=0A=
> +	spin_lock(&queue->lock);=0A=
> +=0A=
> +	if (atomic_read(&queue->active_state)) {=0A=
> +		INIT_LIST_HEAD(&rq_redir->link);=0A=
> +		list_add_tail(&rq_redir->link, &queue->list);=0A=
> +		atomic_inc(&queue->in_queue_cnt);=0A=
> +	} else=0A=
> +		res =3D -EACCES;=0A=
> +=0A=
> +	spin_unlock(&queue->lock);=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +struct blk_redirect_bio *redirect_bio_queue_get_first(struct redirect_bi=
o_queue *queue)=0A=
> +{=0A=
> +	struct blk_redirect_bio *rq_redir =3D NULL;=0A=
> +=0A=
> +	spin_lock(&queue->lock);=0A=
> +=0A=
> +	if (!list_empty(&queue->list)) {=0A=
> +		rq_redir =3D list_entry(queue->list.next, struct blk_redirect_bio, lin=
k);=0A=
> +		list_del(&rq_redir->link);=0A=
> +		atomic_dec(&queue->in_queue_cnt);=0A=
> +	}=0A=
> +=0A=
> +	spin_unlock(&queue->lock);=0A=
> +=0A=
> +	return rq_redir;=0A=
> +}=0A=
> +=0A=
> +bool redirect_bio_queue_active(struct redirect_bio_queue *queue, bool st=
ate)=0A=
> +{=0A=
> +	bool prev_state;=0A=
> +=0A=
> +	spin_lock(&queue->lock);=0A=
> +=0A=
> +	prev_state =3D atomic_read(&queue->active_state);=0A=
> +	atomic_set(&queue->active_state, state);=0A=
> +=0A=
> +	spin_unlock(&queue->lock);=0A=
> +=0A=
> +	return prev_state;=0A=
> +}=0A=
> diff --git a/drivers/block/blk-snap/blk_redirect.h b/drivers/block/blk-sn=
ap/blk_redirect.h=0A=
> new file mode 100644=0A=
> index 000000000000..aae23e78ebe2=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/blk_redirect.h=0A=
> @@ -0,0 +1,73 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
> +#pragma once=0A=
> +=0A=
> +#include "rangevector.h"=0A=
> +=0A=
> +int blk_redirect_bioset_create(void);=0A=
> +void blk_redirect_bioset_free(void);=0A=
> +=0A=
> +void blk_redirect_bio_endio(struct bio *bb);=0A=
> +=0A=
> +struct blk_redirect_bio_list {=0A=
> +	struct blk_redirect_bio_list *next;=0A=
> +	struct bio *this;=0A=
> +};=0A=
> +=0A=
> +struct redirect_bio_queue {=0A=
> +	struct list_head list;=0A=
> +	spinlock_t lock;=0A=
> +=0A=
> +	atomic_t active_state;=0A=
> +	atomic_t in_queue_cnt;=0A=
> +	atomic_t alloc_cnt;=0A=
> +};=0A=
> +=0A=
> +struct blk_redirect_bio {=0A=
> +	struct list_head link;=0A=
> +	struct redirect_bio_queue *queue;=0A=
> +=0A=
> +	struct bio *bio;=0A=
> +	int err;=0A=
> +	struct blk_redirect_bio_list *bio_list_head; //list of created bios=0A=
> +	atomic64_t bio_count;=0A=
> +=0A=
> +	void *complete_param;=0A=
> +	void (*complete_cb)(void *complete_param, struct bio *rq, int err);=0A=
> +};=0A=
> +=0A=
> +int blk_dev_redirect_part(struct blk_redirect_bio *rq_redir, int directi=
on,=0A=
> +			  struct block_device *blk_dev, sector_t target_pos, sector_t rq_ofs,=
=0A=
> +			  sector_t rq_count);=0A=
> +=0A=
> +void blk_dev_redirect_submit(struct blk_redirect_bio *rq_redir);=0A=
> +=0A=
> +int blk_dev_redirect_memcpy_part(struct blk_redirect_bio *rq_redir, int =
direction, void *src_buff,=0A=
> +				 sector_t rq_ofs, sector_t rq_count);=0A=
> +=0A=
> +int blk_dev_redirect_zeroed_part(struct blk_redirect_bio *rq_redir, sect=
or_t rq_ofs,=0A=
> +				 sector_t rq_count);=0A=
> +=0A=
> +int blk_dev_redirect_read_zeroed(struct blk_redirect_bio *rq_redir, stru=
ct block_device *blk_dev,=0A=
> +				 sector_t rq_pos, sector_t blk_ofs_start, sector_t blk_ofs_count,=0A=
> +				 struct rangevector *zero_sectors);=0A=
> +=0A=
> +void blk_redirect_complete(struct blk_redirect_bio *rq_redir, int res);=
=0A=
> +=0A=
> +void redirect_bio_queue_init(struct redirect_bio_queue *queue);=0A=
> +=0A=
> +struct blk_redirect_bio *redirect_bio_queue_new(struct redirect_bio_queu=
e *queue);=0A=
> +=0A=
> +void redirect_bio_queue_free(struct blk_redirect_bio *rq_redir);=0A=
> +=0A=
> +int redirect_bio_queue_push_back(struct redirect_bio_queue *queue,=0A=
> +				 struct blk_redirect_bio *rq_redir);=0A=
> +=0A=
> +struct blk_redirect_bio *redirect_bio_queue_get_first(struct redirect_bi=
o_queue *queue);=0A=
> +=0A=
> +bool redirect_bio_queue_active(struct redirect_bio_queue *queue, bool st=
ate);=0A=
> +=0A=
> +#define redirect_bio_queue_empty(queue) (atomic_read(&(queue).in_queue_c=
nt) =3D=3D 0)=0A=
> +=0A=
> +#define redirect_bio_queue_unactive(queue)                              =
                           \=0A=
> +	((atomic_read(&((queue).active_state)) =3D=3D false) &&                =
                        \=0A=
> +	 (atomic_read(&((queue).alloc_cnt)) =3D=3D 0))=0A=
> diff --git a/drivers/block/blk-snap/blk_util.c b/drivers/block/blk-snap/b=
lk_util.c=0A=
> new file mode 100644=0A=
> index 000000000000..57db70b86516=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/blk_util.c=0A=
> @@ -0,0 +1,33 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#include "common.h"=0A=
> +#include "blk_util.h"=0A=
> +=0A=
> +int blk_dev_open(dev_t dev_id, struct block_device **p_blk_dev)=0A=
> +{=0A=
> +	int result =3D SUCCESS;=0A=
> +	struct block_device *blk_dev;=0A=
> +	int refCount;=0A=
> +=0A=
> +	blk_dev =3D bdget(dev_id);=0A=
> +	if (blk_dev =3D=3D NULL) {=0A=
> +		pr_err("Unable to open device [%d:%d]: bdget return NULL\n", MAJOR(dev=
_id),=0A=
> +		       MINOR(dev_id));=0A=
> +		return -ENODEV;=0A=
> +	}=0A=
> +=0A=
> +	refCount =3D blkdev_get(blk_dev, FMODE_READ | FMODE_WRITE, NULL);=0A=
> +	if (refCount < 0) {=0A=
> +		pr_err("Unable to open device [%d:%d]: blkdev_get return error code %d=
\n",=0A=
> +		       MAJOR(dev_id), MINOR(dev_id), 0 - refCount);=0A=
> +		result =3D refCount;=0A=
> +	}=0A=
> +=0A=
> +	if (result =3D=3D SUCCESS)=0A=
> +		*p_blk_dev =3D blk_dev;=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
> +void blk_dev_close(struct block_device *blk_dev)=0A=
> +{=0A=
> +	blkdev_put(blk_dev, FMODE_READ);=0A=
> +}=0A=
> diff --git a/drivers/block/blk-snap/blk_util.h b/drivers/block/blk-snap/b=
lk_util.h=0A=
> new file mode 100644=0A=
> index 000000000000..0776f2faa668=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/blk_util.h=0A=
> @@ -0,0 +1,33 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
> +#pragma once=0A=
> +=0A=
> +int blk_dev_open(dev_t dev_id, struct block_device **p_blk_dev);=0A=
> +void blk_dev_close(struct block_device *blk_dev);=0A=
> +=0A=
> +/*=0A=
> + * this function was copied from block/blk.h=0A=
> + */=0A=
> +static inline sector_t part_nr_sects_read(struct hd_struct *part)=0A=
> +{=0A=
> +#if (BITS_PER_LONG =3D=3D 32) && defined(CONFIG_SMP)=0A=
> +	sector_t nr_sects;=0A=
> +	unsigned int seq;=0A=
> +=0A=
> +	do {=0A=
> +		seq =3D read_seqcount_begin(&part->nr_sects_seq);=0A=
> +		nr_sects =3D part->nr_sects;=0A=
> +	} while (read_seqcount_retry(&part->nr_sects_seq, seq));=0A=
> +=0A=
> +	return nr_sects;=0A=
> +#elif (BITS_PER_LONG =3D=3D 32) && defined(CONFIG_PREEMPTION)=0A=
> +	sector_t nr_sects;=0A=
> +=0A=
> +	preempt_disable();=0A=
> +	nr_sects =3D part->nr_sects;=0A=
> +	preempt_enable();=0A=
> +=0A=
> +	return nr_sects;=0A=
> +#else=0A=
> +	return part->nr_sects;=0A=
> +#endif=0A=
> +}=0A=
> diff --git a/drivers/block/blk-snap/cbt_map.c b/drivers/block/blk-snap/cb=
t_map.c=0A=
> new file mode 100644=0A=
> index 000000000000..e913069d1a57=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/cbt_map.c=0A=
> @@ -0,0 +1,210 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#define BLK_SNAP_SECTION "-cbt_map"=0A=
> +#include "common.h"=0A=
> +#include "cbt_map.h"=0A=
> +=0A=
> +int cbt_map_allocate(struct cbt_map *cbt_map, unsigned int cbt_sect_in_b=
lock_degree,=0A=
> +		     sector_t device_capacity)=0A=
> +{=0A=
> +	sector_t size_mod;=0A=
> +=0A=
> +	cbt_map->sect_in_block_degree =3D cbt_sect_in_block_degree;=0A=
> +	cbt_map->device_capacity =3D device_capacity;=0A=
> +	cbt_map->map_size =3D (device_capacity >> (sector_t)cbt_sect_in_block_d=
egree);=0A=
> +=0A=
> +	pr_info("Allocate CBT map of %zu\n", cbt_map->map_size);=0A=
> +=0A=
> +	size_mod =3D (device_capacity & ((sector_t)(1 << cbt_sect_in_block_degr=
ee) - 1));=0A=
> +	if (size_mod)=0A=
> +		cbt_map->map_size++;=0A=
> +=0A=
> +	cbt_map->read_map =3D big_buffer_alloc(cbt_map->map_size, GFP_KERNEL);=
=0A=
> +	if (cbt_map->read_map !=3D NULL)=0A=
> +		big_buffer_memset(cbt_map->read_map, 0);=0A=
> +=0A=
> +	cbt_map->write_map =3D big_buffer_alloc(cbt_map->map_size, GFP_KERNEL);=
=0A=
> +	if (cbt_map->write_map !=3D NULL)=0A=
> +		big_buffer_memset(cbt_map->write_map, 0);=0A=
> +=0A=
> +	if ((cbt_map->read_map =3D=3D NULL) || (cbt_map->write_map =3D=3D NULL)=
) {=0A=
> +		pr_err("Cannot allocate CBT map. map_size=3D%zu\n", cbt_map->map_size)=
;=0A=
> +		return -ENOMEM;=0A=
> +	}=0A=
> +=0A=
> +	cbt_map->snap_number_previous =3D 0;=0A=
> +	cbt_map->snap_number_active =3D 1;=0A=
> +	generate_random_uuid(cbt_map->generationId.b);=0A=
> +	cbt_map->active =3D true;=0A=
> +=0A=
> +	cbt_map->state_changed_sectors =3D 0;=0A=
> +	cbt_map->state_dirty_sectors =3D 0;=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +void cbt_map_deallocate(struct cbt_map *cbt_map)=0A=
> +{=0A=
> +	if (cbt_map->read_map !=3D NULL) {=0A=
> +		big_buffer_free(cbt_map->read_map);=0A=
> +		cbt_map->read_map =3D NULL;=0A=
> +	}=0A=
> +=0A=
> +	if (cbt_map->write_map !=3D NULL) {=0A=
> +		big_buffer_free(cbt_map->write_map);=0A=
> +		cbt_map->write_map =3D NULL;=0A=
> +	}=0A=
> +=0A=
> +	cbt_map->active =3D false;=0A=
> +}=0A=
> +=0A=
> +static void cbt_map_destroy(struct cbt_map *cbt_map)=0A=
> +{=0A=
> +	pr_info("CBT map destroy\n");=0A=
> +	if (cbt_map !=3D NULL) {=0A=
> +		cbt_map_deallocate(cbt_map);=0A=
> +=0A=
> +		kfree(cbt_map);=0A=
> +	}=0A=
> +}=0A=
> +=0A=
> +struct cbt_map *cbt_map_create(unsigned int cbt_sect_in_block_degree, se=
ctor_t device_capacity)=0A=
> +{=0A=
> +	struct cbt_map *cbt_map =3D NULL;=0A=
> +=0A=
> +	pr_info("CBT map create\n");=0A=
> +=0A=
> +	cbt_map =3D kzalloc(sizeof(struct cbt_map), GFP_KERNEL);=0A=
> +	if (cbt_map =3D=3D NULL)=0A=
> +		return NULL;=0A=
> +=0A=
> +	if (cbt_map_allocate(cbt_map, cbt_sect_in_block_degree, device_capacity=
) !=3D SUCCESS) {=0A=
> +		cbt_map_destroy(cbt_map);=0A=
> +		return NULL;=0A=
> +	}=0A=
> +=0A=
> +	spin_lock_init(&cbt_map->locker);=0A=
> +	init_rwsem(&cbt_map->rw_lock);=0A=
> +	kref_init(&cbt_map->refcount);=0A=
> +=0A=
> +	return cbt_map;=0A=
> +}=0A=
> +=0A=
> +void cbt_map_destroy_cb(struct kref *kref)=0A=
> +{=0A=
> +	cbt_map_destroy(container_of(kref, struct cbt_map, refcount));=0A=
> +}=0A=
> +=0A=
> +struct cbt_map *cbt_map_get_resource(struct cbt_map *cbt_map)=0A=
> +{=0A=
> +	if (cbt_map)=0A=
> +		kref_get(&cbt_map->refcount);=0A=
> +=0A=
> +	return cbt_map;=0A=
> +}=0A=
> +=0A=
> +void cbt_map_put_resource(struct cbt_map *cbt_map)=0A=
> +{=0A=
> +	if (cbt_map)=0A=
> +		kref_put(&cbt_map->refcount, cbt_map_destroy_cb);=0A=
> +}=0A=
> +=0A=
> +void cbt_map_switch(struct cbt_map *cbt_map)=0A=
> +{=0A=
> +	pr_info("CBT map switch\n");=0A=
> +	spin_lock(&cbt_map->locker);=0A=
> +=0A=
> +	big_buffer_memcpy(cbt_map->read_map, cbt_map->write_map);=0A=
> +=0A=
> +	cbt_map->snap_number_previous =3D cbt_map->snap_number_active;=0A=
> +	++cbt_map->snap_number_active;=0A=
> +	if (cbt_map->snap_number_active =3D=3D 256) {=0A=
> +		cbt_map->snap_number_active =3D 1;=0A=
> +=0A=
> +		big_buffer_memset(cbt_map->write_map, 0);=0A=
> +=0A=
> +		generate_random_uuid(cbt_map->generationId.b);=0A=
> +=0A=
> +		pr_info("CBT reset\n");=0A=
> +	}=0A=
> +	spin_unlock(&cbt_map->locker);=0A=
> +}=0A=
> +=0A=
> +int _cbt_map_set(struct cbt_map *cbt_map, sector_t sector_start, sector_=
t sector_cnt,=0A=
> +		 u8 snap_number, struct big_buffer *map)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	size_t cbt_block;=0A=
> +	size_t cbt_block_first =3D (size_t)(sector_start >> cbt_map->sect_in_bl=
ock_degree);=0A=
> +	size_t cbt_block_last =3D (size_t)((sector_start + sector_cnt - 1) >>=
=0A=
> +					 cbt_map->sect_in_block_degree); //inclusive=0A=
> +=0A=
> +	for (cbt_block =3D cbt_block_first; cbt_block <=3D cbt_block_last; ++cb=
t_block) {=0A=
> +		if (cbt_block < cbt_map->map_size) {=0A=
> +			u8 num;=0A=
> +=0A=
> +			res =3D big_buffer_byte_get(map, cbt_block, &num);=0A=
> +			if (res =3D=3D SUCCESS)=0A=
> +				if (num < snap_number)=0A=
> +					res =3D big_buffer_byte_set(map, cbt_block, snap_number);=0A=
> +		} else=0A=
> +			res =3D -EINVAL;=0A=
> +=0A=
> +		if (res !=3D SUCCESS) {=0A=
> +			pr_err("Block index is too large. #%zu was demanded, map size %zu\n",=
=0A=
> +			       cbt_block, cbt_map->map_size);=0A=
> +			break;=0A=
> +		}=0A=
> +	}=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +int cbt_map_set(struct cbt_map *cbt_map, sector_t sector_start, sector_t=
 sector_cnt)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +=0A=
> +	spin_lock(&cbt_map->locker);=0A=
> +=0A=
> +	res =3D _cbt_map_set(cbt_map, sector_start, sector_cnt, (u8)cbt_map->sn=
ap_number_active,=0A=
> +			   cbt_map->write_map);=0A=
> +	cbt_map->state_changed_sectors +=3D sector_cnt;=0A=
> +=0A=
> +	spin_unlock(&cbt_map->locker);=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +int cbt_map_set_both(struct cbt_map *cbt_map, sector_t sector_start, sec=
tor_t sector_cnt)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +=0A=
> +	spin_lock(&cbt_map->locker);=0A=
> +=0A=
> +	res =3D _cbt_map_set(cbt_map, sector_start, sector_cnt,=0A=
> +			   (u8)cbt_map->snap_number_active, cbt_map->write_map);=0A=
> +	if (res =3D=3D SUCCESS)=0A=
> +		res =3D _cbt_map_set(cbt_map, sector_start, sector_cnt,=0A=
> +				   (u8)cbt_map->snap_number_previous, cbt_map->read_map);=0A=
> +	cbt_map->state_dirty_sectors +=3D sector_cnt;=0A=
> +=0A=
> +	spin_unlock(&cbt_map->locker);=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +size_t cbt_map_read_to_user(struct cbt_map *cbt_map, void __user *user_b=
uff, size_t offset,=0A=
> +			    size_t size)=0A=
> +{=0A=
> +	size_t readed =3D 0;=0A=
> +	size_t left_size;=0A=
> +	size_t real_size =3D min((cbt_map->map_size - offset), size);=0A=
> +=0A=
> +	left_size =3D real_size -=0A=
> +		    big_buffer_copy_to_user(user_buff, offset, cbt_map->read_map, real=
_size);=0A=
> +=0A=
> +	if (left_size =3D=3D 0)=0A=
> +		readed =3D real_size;=0A=
> +	else {=0A=
> +		pr_err("Not all CBT data was read. Left [%zu] bytes\n", left_size);=0A=
> +		readed =3D real_size - left_size;=0A=
> +	}=0A=
> +=0A=
> +	return readed;=0A=
> +}=0A=
> diff --git a/drivers/block/blk-snap/cbt_map.h b/drivers/block/blk-snap/cb=
t_map.h=0A=
> new file mode 100644=0A=
> index 000000000000..cb52b09531fe=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/cbt_map.h=0A=
> @@ -0,0 +1,62 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
> +#pragma once=0A=
> +=0A=
> +#include "big_buffer.h"=0A=
> +#include <linux/kref.h>=0A=
> +#include <linux/uuid.h>=0A=
> +=0A=
> +struct cbt_map {=0A=
> +	struct kref refcount;=0A=
> +=0A=
> +	spinlock_t locker;=0A=
> +=0A=
> +	size_t sect_in_block_degree;=0A=
> +	sector_t device_capacity;=0A=
> +	size_t map_size;=0A=
> +=0A=
> +	struct big_buffer *read_map;=0A=
> +	struct big_buffer *write_map;=0A=
> +=0A=
> +	unsigned long snap_number_active;=0A=
> +	unsigned long snap_number_previous;=0A=
> +	uuid_t generationId;=0A=
> +=0A=
> +	bool active;=0A=
> +=0A=
> +	struct rw_semaphore rw_lock;=0A=
> +=0A=
> +	sector_t state_changed_sectors;=0A=
> +	sector_t state_dirty_sectors;=0A=
> +};=0A=
> +=0A=
> +struct cbt_map *cbt_map_create(unsigned int cbt_sect_in_block_degree, se=
ctor_t device_capacity);=0A=
> +=0A=
> +struct cbt_map *cbt_map_get_resource(struct cbt_map *cbt_map);=0A=
> +void cbt_map_put_resource(struct cbt_map *cbt_map);=0A=
> +=0A=
> +void cbt_map_switch(struct cbt_map *cbt_map);=0A=
> +int cbt_map_set(struct cbt_map *cbt_map, sector_t sector_start, sector_t=
 sector_cnt);=0A=
> +int cbt_map_set_both(struct cbt_map *cbt_map, sector_t sector_start, sec=
tor_t sector_cnt);=0A=
> +=0A=
> +size_t cbt_map_read_to_user(struct cbt_map *cbt_map, void __user *user_b=
uffer, size_t offset,=0A=
> +			    size_t size);=0A=
> +=0A=
> +static inline void cbt_map_read_lock(struct cbt_map *cbt_map)=0A=
> +{=0A=
> +	down_read(&cbt_map->rw_lock);=0A=
> +};=0A=
> +=0A=
> +static inline void cbt_map_read_unlock(struct cbt_map *cbt_map)=0A=
> +{=0A=
> +	up_read(&cbt_map->rw_lock);=0A=
> +};=0A=
> +=0A=
> +static inline void cbt_map_write_lock(struct cbt_map *cbt_map)=0A=
> +{=0A=
> +	down_write(&cbt_map->rw_lock);=0A=
> +};=0A=
> +=0A=
> +static inline void cbt_map_write_unlock(struct cbt_map *cbt_map)=0A=
> +{=0A=
> +	up_write(&cbt_map->rw_lock);=0A=
> +};=0A=
> diff --git a/drivers/block/blk-snap/common.h b/drivers/block/blk-snap/com=
mon.h=0A=
> new file mode 100644=0A=
> index 000000000000..bbd5e98ab2a6=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/common.h=0A=
> @@ -0,0 +1,31 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
> +#pragma once=0A=
> +=0A=
> +#ifndef BLK_SNAP_SECTION=0A=
> +#define BLK_SNAP_SECTION ""=0A=
> +#endif=0A=
> +#define pr_fmt(fmt) KBUILD_MODNAME BLK_SNAP_SECTION ": " fmt=0A=
> +=0A=
> +#include <linux/version.h> /*rudiment - needed for using KERNEL_VERSION =
*/=0A=
> +=0A=
> +#include <linux/types.h>=0A=
> +#include <linux/errno.h>=0A=
> +#include <linux/mutex.h>=0A=
> +#include <linux/rwsem.h>=0A=
> +#include <linux/spinlock.h>=0A=
> +#include <linux/slab.h>=0A=
> +#include <linux/list.h>=0A=
> +#include <linux/atomic.h>=0A=
> +#include <linux/blkdev.h>=0A=
> +=0A=
> +#define from_sectors(_sectors) (_sectors << SECTOR_SHIFT)=0A=
> +#define to_sectors(_byte_size) (_byte_size >> SECTOR_SHIFT)=0A=
> +=0A=
> +struct blk_range {=0A=
> +	sector_t ofs;=0A=
> +	blkcnt_t cnt;=0A=
> +};=0A=
> +=0A=
> +#ifndef SUCCESS=0A=
> +#define SUCCESS 0=0A=
> +#endif=0A=
> diff --git a/drivers/block/blk-snap/ctrl_fops.c b/drivers/block/blk-snap/=
ctrl_fops.c=0A=
> new file mode 100644=0A=
> index 000000000000..b7b18539ee96=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/ctrl_fops.c=0A=
> @@ -0,0 +1,691 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#define BLK_SNAP_SECTION "-ctrl"=0A=
> +#include "common.h"=0A=
> +#include "blk-snap-ctl.h"=0A=
> +#include "ctrl_fops.h"=0A=
> +#include "version.h"=0A=
> +#include "tracking.h"=0A=
> +#include "snapshot.h"=0A=
> +#include "snapstore.h"=0A=
> +#include "snapimage.h"=0A=
> +#include "tracker.h"=0A=
> +#include "blk_deferred.h"=0A=
> +#include "big_buffer.h"=0A=
> +#include "params.h"=0A=
> +=0A=
> +#include <linux/module.h>=0A=
> +#include <linux/poll.h>=0A=
> +#include <linux/uaccess.h>=0A=
> +=0A=
> +int blk_snap_major; //zero by default=0A=
> +=0A=
> +const struct file_operations ctrl_fops =3D { .owner =3D THIS_MODULE,=0A=
> +					   .read =3D ctrl_read,=0A=
> +					   .write =3D ctrl_write,=0A=
> +					   .open =3D ctrl_open,=0A=
> +					   .release =3D ctrl_release,=0A=
> +					   .poll =3D ctrl_poll,=0A=
> +					   .unlocked_ioctl =3D ctrl_unlocked_ioctl };=0A=
> +=0A=
> +atomic_t dev_open_cnt =3D ATOMIC_INIT(0);=0A=
> +=0A=
> +const struct ioctl_getversion_s version =3D { .major =3D FILEVER_MAJOR,=
=0A=
> +					    .minor =3D FILEVER_MINOR,=0A=
> +					    .revision =3D FILEVER_REVISION,=0A=
> +					    .build =3D 0 };=0A=
> +=0A=
> +int get_blk_snap_major(void)=0A=
> +{=0A=
> +	return blk_snap_major;=0A=
> +}=0A=
> +=0A=
> +int ctrl_init(void)=0A=
> +{=0A=
> +	int ret;=0A=
> +=0A=
> +	ret =3D register_chrdev(0, MODULE_NAME, &ctrl_fops);=0A=
> +	if (ret < 0) {=0A=
> +		pr_err("Failed to register a character device. errno=3D%d\n", blk_snap=
_major);=0A=
> +		return ret;=0A=
> +	}=0A=
> +=0A=
> +	blk_snap_major =3D ret;=0A=
> +	pr_info("Module major [%d]\n", blk_snap_major);=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +void ctrl_done(void)=0A=
> +{=0A=
> +	unregister_chrdev(blk_snap_major, MODULE_NAME);=0A=
> +	ctrl_pipe_done();=0A=
> +}=0A=
> +=0A=
> +ssize_t ctrl_read(struct file *fl, char __user *buffer, size_t length, l=
off_t *offset)=0A=
> +{=0A=
> +	ssize_t bytes_read =3D 0;=0A=
> +	struct ctrl_pipe *pipe =3D (struct ctrl_pipe *)fl->private_data;=0A=
> +=0A=
> +	if (pipe =3D=3D NULL) {=0A=
> +		pr_err("Unable to read from pipe: invalid pipe pointer\n");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	bytes_read =3D ctrl_pipe_read(pipe, buffer, length);=0A=
> +	if (bytes_read =3D=3D 0)=0A=
> +		if (fl->f_flags & O_NONBLOCK)=0A=
> +			bytes_read =3D -EAGAIN;=0A=
> +=0A=
> +	return bytes_read;=0A=
> +}=0A=
> +=0A=
> +ssize_t ctrl_write(struct file *fl, const char __user *buffer, size_t le=
ngth, loff_t *offset)=0A=
> +{=0A=
> +	struct ctrl_pipe *pipe =3D (struct ctrl_pipe *)fl->private_data;=0A=
> +=0A=
> +	if (pipe =3D=3D NULL) {=0A=
> +		pr_err("Unable to write into pipe: invalid pipe pointer\n");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	return ctrl_pipe_write(pipe, buffer, length);=0A=
> +}=0A=
> +=0A=
> +unsigned int ctrl_poll(struct file *fl, struct poll_table_struct *wait)=
=0A=
> +{=0A=
> +	struct ctrl_pipe *pipe =3D (struct ctrl_pipe *)fl->private_data;=0A=
> +=0A=
> +	if (pipe =3D=3D NULL) {=0A=
> +		pr_err("Unable to poll pipe: invalid pipe pointer\n");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	return ctrl_pipe_poll(pipe);=0A=
> +}=0A=
> +=0A=
> +int ctrl_open(struct inode *inode, struct file *fl)=0A=
> +{=0A=
> +	fl->f_pos =3D 0;=0A=
> +=0A=
> +	if (false =3D=3D try_module_get(THIS_MODULE))=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	fl->private_data =3D (void *)ctrl_pipe_new();=0A=
> +	if (fl->private_data =3D=3D NULL) {=0A=
> +		pr_err("Failed to open ctrl file\n");=0A=
> +		return -ENOMEM;=0A=
> +	}=0A=
> +=0A=
> +	atomic_inc(&dev_open_cnt);=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +int ctrl_release(struct inode *inode, struct file *fl)=0A=
> +{=0A=
> +	int result =3D SUCCESS;=0A=
> +=0A=
> +	if (atomic_read(&dev_open_cnt) > 0) {=0A=
> +		module_put(THIS_MODULE);=0A=
> +		ctrl_pipe_put_resource((struct ctrl_pipe *)fl->private_data);=0A=
> +=0A=
> +		atomic_dec(&dev_open_cnt);=0A=
> +	} else {=0A=
> +		pr_err("Unable to close ctrl file: the file is already closed\n");=0A=
> +		result =3D -EALREADY;=0A=
> +	}=0A=
> +=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
> +int ioctl_compatibility_flags(unsigned long arg)=0A=
> +{=0A=
> +	unsigned long len;=0A=
> +	struct ioctl_compatibility_flags_s param;=0A=
> +=0A=
> +	param.flags =3D 0;=0A=
> +	param.flags |=3D BLK_SNAP_COMPATIBILITY_SNAPSTORE;=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +	param.flags |=3D BLK_SNAP_COMPATIBILITY_MULTIDEV;=0A=
> +#endif=0A=
> +	len =3D copy_to_user((void *)arg, &param, sizeof(struct ioctl_compatibi=
lity_flags_s));=0A=
> +	if (len !=3D 0) {=0A=
> +		pr_err("Unable to get compatibility flags: invalid user buffer\n");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +int ioctl_get_version(unsigned long arg)=0A=
> +{=0A=
> +	unsigned long len;=0A=
> +=0A=
> +	pr_info("Get version\n");=0A=
> +=0A=
> +	len =3D copy_to_user((void *)arg, &version, sizeof(struct ioctl_getvers=
ion_s));=0A=
> +	if (len !=3D 0) {=0A=
> +		pr_err("Unable to get version: invalid user buffer\n");=0A=
> +		return -ENODATA;=0A=
> +	}=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +int ioctl_tracking_add(unsigned long arg)=0A=
> +{=0A=
> +	unsigned long len;=0A=
> +	struct ioctl_dev_id_s dev;=0A=
> +=0A=
> +	len =3D copy_from_user(&dev, (void *)arg, sizeof(struct ioctl_dev_id_s)=
);=0A=
> +	if (len !=3D 0) {=0A=
> +		pr_err("Unable to add device under tracking: invalid user buffer\n");=
=0A=
> +		return -ENODATA;=0A=
> +	}=0A=
> +=0A=
> +	return tracking_add(MKDEV(dev.major, dev.minor), 0ull);=0A=
> +}=0A=
> +=0A=
> +int ioctl_tracking_remove(unsigned long arg)=0A=
> +{=0A=
> +	struct ioctl_dev_id_s dev;=0A=
> +=0A=
> +	if (copy_from_user(&dev, (void *)arg, sizeof(struct ioctl_dev_id_s)) !=
=3D 0) {=0A=
> +		pr_err("Unable to remove device from tracking: invalid user buffer\n")=
;=0A=
> +		return -ENODATA;=0A=
> +	}=0A=
> +	return tracking_remove(MKDEV(dev.major, dev.minor));=0A=
> +	;=0A=
> +}=0A=
> +=0A=
> +int ioctl_tracking_collect(unsigned long arg)=0A=
> +{=0A=
> +	unsigned long len;=0A=
> +	int res;=0A=
> +	struct ioctl_tracking_collect_s get;=0A=
> +=0A=
> +	pr_info("Collecting tracking devices:\n");=0A=
> +=0A=
> +	len =3D copy_from_user(&get, (void *)arg, sizeof(struct ioctl_tracking_=
collect_s));=0A=
> +	if (len  !=3D 0) {=0A=
> +		pr_err("Unable to collect tracking devices: invalid user buffer\n");=
=0A=
> +		return -ENODATA;=0A=
> +	}=0A=
> +=0A=
> +	if (get.p_cbt_info =3D=3D NULL) {=0A=
> +		res =3D tracking_collect(0x7FFFffff, NULL, &get.count);=0A=
> +		if (res =3D=3D SUCCESS) {=0A=
> +			len =3D copy_to_user((void *)arg, (void *)&get,=0A=
> +					   sizeof(struct ioctl_tracking_collect_s));=0A=
> +			if (len !=3D 0) {=0A=
> +				pr_err("Unable to collect tracking devices: invalid user buffer for =
arguments\n");=0A=
> +				res =3D -ENODATA;=0A=
> +			}=0A=
> +		} else {=0A=
> +			pr_err("Failed to execute tracking_collect. errno=3D%d\n", res);=0A=
> +		}=0A=
> +	} else {=0A=
> +		struct cbt_info_s *p_cbt_info =3D NULL;=0A=
> +=0A=
> +		p_cbt_info =3D kcalloc(get.count, sizeof(struct cbt_info_s), GFP_KERNE=
L);=0A=
> +		if (p_cbt_info =3D=3D NULL)=0A=
> +			return -ENOMEM;=0A=
> +=0A=
> +		do {=0A=
> +			res =3D tracking_collect(get.count, p_cbt_info, &get.count);=0A=
> +			if (res !=3D SUCCESS) {=0A=
> +				pr_err("Failed to execute tracking_collect. errno=3D%d\n", res);=0A=
> +				break;=0A=
> +			}=0A=
> +			len =3D copy_to_user(get.p_cbt_info, p_cbt_info,=0A=
> +					      get.count * sizeof(struct cbt_info_s));=0A=
> +			if (len !=3D 0) {=0A=
> +				pr_err("Unable to collect tracking devices: invalid user buffer for =
CBT info\n");=0A=
> +				res =3D -ENODATA;=0A=
> +				break;=0A=
> +			}=0A=
> +=0A=
> +			len =3D copy_to_user((void *)arg, (void *)&get,=0A=
> +					   sizeof(struct ioctl_tracking_collect_s));=0A=
> +			if (len !=3D 0) {=0A=
> +				pr_err("Unable to collect tracking devices: invalid user buffer for =
arguments\n");=0A=
> +				res =3D -ENODATA;=0A=
> +				break;=0A=
> +			}=0A=
> +=0A=
> +		} while (false);=0A=
> +=0A=
> +		kfree(p_cbt_info);=0A=
> +		p_cbt_info =3D NULL;=0A=
> +	}=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +int ioctl_tracking_block_size(unsigned long arg)=0A=
> +{=0A=
> +	unsigned long len;=0A=
> +	unsigned int blk_sz =3D change_tracking_block_size();=0A=
> +=0A=
> +	len =3D copy_to_user((void *)arg, &blk_sz, sizeof(unsigned int));=0A=
> +	if (len !=3D 0) {=0A=
> +		pr_err("Unable to get tracking block size: invalid user buffer for arg=
uments\n");=0A=
> +		return -ENODATA;=0A=
> +	}=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +int ioctl_tracking_read_cbt_map(unsigned long arg)=0A=
> +{=0A=
> +	dev_t dev_id;=0A=
> +	unsigned long len;=0A=
> +	struct ioctl_tracking_read_cbt_bitmap_s readbitmap;=0A=
> +=0A=
> +	len =3D copy_from_user(&readbitmap, (void *)arg,=0A=
> +				sizeof(struct ioctl_tracking_read_cbt_bitmap_s));=0A=
> +	if (len !=3D 0) {=0A=
> +		pr_err("Unable to read CBT map: invalid user buffer\n");=0A=
> +		return -ENODATA;=0A=
> +	}=0A=
> +=0A=
> +	dev_id =3D MKDEV(readbitmap.dev_id.major, readbitmap.dev_id.minor);=0A=
> +	return tracking_read_cbt_bitmap(dev_id, readbitmap.offset, readbitmap.l=
ength,=0A=
> +					(void *)readbitmap.buff);=0A=
> +}=0A=
> +=0A=
> +int ioctl_tracking_mark_dirty_blocks(unsigned long arg)=0A=
> +{=0A=
> +	unsigned long len;=0A=
> +	struct ioctl_tracking_mark_dirty_blocks_s param;=0A=
> +	struct block_range_s *p_dirty_blocks;=0A=
> +	size_t buffer_size;=0A=
> +	int result =3D SUCCESS;=0A=
> +=0A=
> +	len =3D copy_from_user(&param, (void *)arg,=0A=
> +			     sizeof(struct ioctl_tracking_mark_dirty_blocks_s));=0A=
> +	if (len !=3D 0) {=0A=
> +		pr_err("Unable to mark dirty blocks: invalid user buffer\n");=0A=
> +		return -ENODATA;=0A=
> +	}=0A=
> +=0A=
> +	buffer_size =3D param.count * sizeof(struct block_range_s);=0A=
> +	p_dirty_blocks =3D kzalloc(buffer_size, GFP_KERNEL);=0A=
> +	if (p_dirty_blocks =3D=3D NULL) {=0A=
> +		pr_err("Unable to mark dirty blocks: cannot allocate [%zu] bytes\n", b=
uffer_size);=0A=
> +		return -ENOMEM;=0A=
> +	}=0A=
> +=0A=
> +	do {=0A=
> +		dev_t image_dev_id;=0A=
> +=0A=
> +		len =3D copy_from_user(p_dirty_blocks, (void *)param.p_dirty_blocks, b=
uffer_size);=0A=
> +		if (len !=3D 0) {=0A=
> +			pr_err("Unable to mark dirty blocks: invalid user buffer\n");=0A=
> +			result =3D -ENODATA;=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		image_dev_id =3D MKDEV(param.image_dev_id.major, param.image_dev_id.mi=
nor);=0A=
> +		result =3D snapimage_mark_dirty_blocks(image_dev_id, p_dirty_blocks, p=
aram.count);=0A=
> +	} while (false);=0A=
> +	kfree(p_dirty_blocks);=0A=
> +=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
> +int ioctl_snapshot_create(unsigned long arg)=0A=
> +{=0A=
> +	unsigned long len;=0A=
> +	size_t dev_id_buffer_size;=0A=
> +	int status;=0A=
> +	struct ioctl_snapshot_create_s param;=0A=
> +	struct ioctl_dev_id_s *pk_dev_id =3D NULL;=0A=
> +=0A=
> +	len =3D copy_from_user(&param, (void *)arg, sizeof(struct ioctl_snapsho=
t_create_s));=0A=
> +	if (len !=3D 0) {=0A=
> +		pr_err("Unable to create snapshot: invalid user buffer\n");=0A=
> +		return -ENODATA;=0A=
> +	}=0A=
> +=0A=
> +	dev_id_buffer_size =3D sizeof(struct ioctl_dev_id_s) * param.count;=0A=
> +	pk_dev_id =3D kzalloc(dev_id_buffer_size, GFP_KERNEL);=0A=
> +	if (pk_dev_id =3D=3D NULL) {=0A=
> +		pr_err("Unable to create snapshot: cannot allocate [%zu] bytes\n",=0A=
> +		       dev_id_buffer_size);=0A=
> +		return -ENOMEM;=0A=
> +	}=0A=
> +=0A=
> +	do {=0A=
> +		size_t dev_buffer_size;=0A=
> +		dev_t *p_dev =3D NULL;=0A=
> +		int inx =3D 0;=0A=
> +=0A=
> +		len =3D copy_from_user(pk_dev_id, (void *)param.p_dev_id,=0A=
> +				     param.count * sizeof(struct ioctl_dev_id_s));=0A=
> +		if (len !=3D 0) {=0A=
> +			pr_err("Unable to create snapshot: invalid user buffer for parameters=
\n");=0A=
> +			status =3D -ENODATA;=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		dev_buffer_size =3D sizeof(dev_t) * param.count;=0A=
> +		p_dev =3D kzalloc(dev_buffer_size, GFP_KERNEL);=0A=
> +		if (p_dev =3D=3D NULL) {=0A=
> +			pr_err("Unable to create snapshot: cannot allocate [%zu] bytes\n",=0A=
> +			       dev_buffer_size);=0A=
> +			status =3D -ENOMEM;=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		for (inx =3D 0; inx < param.count; ++inx)=0A=
> +			p_dev[inx] =3D MKDEV(pk_dev_id[inx].major, pk_dev_id[inx].minor);=0A=
> +=0A=
> +		status =3D snapshot_create(p_dev, param.count, &param.snapshot_id);=0A=
> +=0A=
> +		kfree(p_dev);=0A=
> +		p_dev =3D NULL;=0A=
> +=0A=
> +	} while (false);=0A=
> +	kfree(pk_dev_id);=0A=
> +	pk_dev_id =3D NULL;=0A=
> +=0A=
> +	if (status =3D=3D SUCCESS) {=0A=
> +		len =3D copy_to_user((void *)arg, &param, sizeof(struct ioctl_snapshot=
_create_s));=0A=
> +		if (len !=3D 0) {=0A=
> +			pr_err("Unable to create snapshot: invalid user buffer\n");=0A=
> +			status =3D -ENODATA;=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	return status;=0A=
> +}=0A=
> +=0A=
> +int ioctl_snapshot_destroy(unsigned long arg)=0A=
> +{=0A=
> +	unsigned long len;=0A=
> +	unsigned long long param;=0A=
> +=0A=
> +	len =3D copy_from_user(&param, (void *)arg, sizeof(unsigned long long))=
;=0A=
> +	if (len !=3D 0) {=0A=
> +		pr_err("Unable to destroy snapshot: invalid user buffer\n");=0A=
> +		return -ENODATA;=0A=
> +	}=0A=
> +=0A=
> +	return snapshot_destroy(param);=0A=
> +}=0A=
> +=0A=
> +static inline dev_t _snapstore_dev(struct ioctl_dev_id_s *dev_id)=0A=
> +{=0A=
> +	if ((dev_id->major =3D=3D 0) && (dev_id->minor =3D=3D 0))=0A=
> +		return 0; //memory snapstore=0A=
> +=0A=
> +	if ((dev_id->major =3D=3D -1) && (dev_id->minor =3D=3D -1))=0A=
> +		return 0xFFFFffff; //multidevice snapstore=0A=
> +=0A=
> +	return MKDEV(dev_id->major, dev_id->minor);=0A=
> +}=0A=
> +=0A=
> +int ioctl_snapstore_create(unsigned long arg)=0A=
> +{=0A=
> +	unsigned long len;=0A=
> +	int res =3D SUCCESS;=0A=
> +	struct ioctl_snapstore_create_s param;=0A=
> +	size_t inx =3D 0;=0A=
> +	dev_t *dev_id_set =3D NULL;=0A=
> +=0A=
> +	len =3D copy_from_user(&param, (void *)arg, sizeof(struct ioctl_snapsto=
re_create_s));=0A=
> +	if (len !=3D 0) {=0A=
> +		pr_err("Unable to create snapstore: invalid user buffer\n");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	dev_id_set =3D kcalloc(param.count, sizeof(dev_t), GFP_KERNEL);=0A=
> +	if (dev_id_set =3D=3D NULL)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	for (inx =3D 0; inx < param.count; ++inx) {=0A=
> +		struct ioctl_dev_id_s dev_id;=0A=
> +=0A=
> +		len =3D copy_from_user(&dev_id, param.p_dev_id + inx, sizeof(struct io=
ctl_dev_id_s));=0A=
> +		if (len !=3D 0) {=0A=
> +			pr_err("Unable to create snapstore: ");=0A=
> +			pr_err("invalid user buffer for parameters\n");=0A=
> +=0A=
> +			res =3D -ENODATA;=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		dev_id_set[inx] =3D MKDEV(dev_id.major, dev_id.minor);=0A=
> +	}=0A=
> +=0A=
> +	if (res =3D=3D SUCCESS)=0A=
> +		res =3D snapstore_create((uuid_t *)param.id, _snapstore_dev(&param.sna=
pstore_dev_id),=0A=
> +				       dev_id_set, (size_t)param.count);=0A=
> +=0A=
> +	kfree(dev_id_set);=0A=
> +=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +int ioctl_snapstore_file(unsigned long arg)=0A=
> +{=0A=
> +	unsigned long len;=0A=
> +	int res =3D SUCCESS;=0A=
> +	struct ioctl_snapstore_file_add_s param;=0A=
> +	struct big_buffer *ranges =3D NULL;=0A=
> +	size_t ranges_buffer_size;=0A=
> +=0A=
> +	len =3D copy_from_user(&param, (void *)arg, sizeof(struct ioctl_snapsto=
re_file_add_s));=0A=
> +	if (len !=3D 0) {=0A=
> +		pr_err("Unable to add file to snapstore: invalid user buffer\n");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	ranges_buffer_size =3D sizeof(struct ioctl_range_s) * param.range_count=
;=0A=
> +=0A=
> +	ranges =3D big_buffer_alloc(ranges_buffer_size, GFP_KERNEL);=0A=
> +	if (ranges =3D=3D NULL) {=0A=
> +		pr_err("Unable to add file to snapstore: cannot allocate [%zu] bytes\n=
",=0A=
> +		       ranges_buffer_size);=0A=
> +		return -ENOMEM;=0A=
> +	}=0A=
> +=0A=
> +	if (big_buffer_copy_from_user((void *)param.ranges, 0, ranges, ranges_b=
uffer_size)=0A=
> +		!=3D ranges_buffer_size) {=0A=
> +=0A=
> +		pr_err("Unable to add file to snapstore: invalid user buffer for param=
eters\n");=0A=
> +		res =3D -ENODATA;=0A=
> +	} else=0A=
> +		res =3D snapstore_add_file((uuid_t *)(param.id), ranges, (size_t)param=
.range_count);=0A=
> +=0A=
> +	big_buffer_free(ranges);=0A=
> +=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +int ioctl_snapstore_memory(unsigned long arg)=0A=
> +{=0A=
> +	unsigned long len;=0A=
> +	int res =3D SUCCESS;=0A=
> +	struct ioctl_snapstore_memory_limit_s param;=0A=
> +=0A=
> +	len =3D copy_from_user(&param, (void *)arg, sizeof(struct ioctl_snapsto=
re_memory_limit_s));=0A=
> +	if (len !=3D 0) {=0A=
> +		pr_err("Unable to add memory block to snapstore: invalid user buffer\n=
");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	res =3D snapstore_add_memory((uuid_t *)param.id, param.size);=0A=
> +=0A=
> +	return res;=0A=
> +}=0A=
> +int ioctl_snapstore_cleanup(unsigned long arg)=0A=
> +{=0A=
> +	unsigned long len;=0A=
> +	int res =3D SUCCESS;=0A=
> +	struct ioctl_snapstore_cleanup_s param;=0A=
> +=0A=
> +	len =3D copy_from_user(&param, (void *)arg, sizeof(struct ioctl_snapsto=
re_cleanup_s));=0A=
> +	if (len !=3D 0) {=0A=
> +		pr_err("Unable to perform snapstore cleanup: invalid user buffer\n");=
=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	pr_info("Cleanup snapstore %pUB\n", (uuid_t *)param.id);=0A=
> +	res =3D snapstore_cleanup((uuid_t *)param.id, &param.filled_bytes);=0A=
> +=0A=
> +	if (res =3D=3D SUCCESS) {=0A=
> +		if (0 !=3D=0A=
> +		    copy_to_user((void *)arg, &param, sizeof(struct ioctl_snapstore_cl=
eanup_s))) {=0A=
> +			pr_err("Unable to perform snapstore cleanup: invalid user buffer\n");=
=0A=
> +			res =3D -ENODATA;=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +int ioctl_snapstore_file_multidev(unsigned long arg)=0A=
> +{=0A=
> +	unsigned long len;=0A=
> +	int res =3D SUCCESS;=0A=
> +	struct ioctl_snapstore_file_add_multidev_s param;=0A=
> +	struct big_buffer *ranges =3D NULL; //struct ioctl_range_s* ranges =3D =
NULL;=0A=
> +	size_t ranges_buffer_size;=0A=
> +=0A=
> +	len =3D copy_from_user(&param, (void *)arg,=0A=
> +				sizeof(struct ioctl_snapstore_file_add_multidev_s));=0A=
> +	if (len !=3D 0) {=0A=
> +		pr_err("Unable to add file to multidev snapstore: invalid user buffer\=
n");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	ranges_buffer_size =3D sizeof(struct ioctl_range_s) * param.range_count=
;=0A=
> +=0A=
> +	ranges =3D big_buffer_alloc(ranges_buffer_size, GFP_KERNEL);=0A=
> +	if (ranges =3D=3D NULL) {=0A=
> +		pr_err("Unable to add file to multidev snapstore: cannot allocate [%zu=
] bytes\n",=0A=
> +		       ranges_buffer_size);=0A=
> +		return -ENOMEM;=0A=
> +	}=0A=
> +=0A=
> +	do {=0A=
> +		uuid_t *id =3D (uuid_t *)(param.id);=0A=
> +		dev_t snapstore_device =3D MKDEV(param.dev_id.major, param.dev_id.mino=
r);=0A=
> +		size_t ranges_cnt =3D (size_t)param.range_count;=0A=
> +=0A=
> +		if (ranges_buffer_size !=3D big_buffer_copy_from_user((void *)param.ra=
nges, 0, ranges,=0A=
> +								    ranges_buffer_size)) {=0A=
> +			pr_err("Unable to add file to snapstore: invalid user buffer for para=
meters\n");=0A=
> +			res =3D -ENODATA;=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		res =3D snapstore_add_multidev(id, snapstore_device, ranges, ranges_cn=
t);=0A=
> +	} while (false);=0A=
> +	big_buffer_free(ranges);=0A=
> +=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +#endif=0A=
> +////////////////////////////////////////////////////////////////////////=
//=0A=
> +=0A=
> +/*=0A=
> + * Snapshot get errno for device=0A=
> + */=0A=
> +int ioctl_snapshot_errno(unsigned long arg)=0A=
> +{=0A=
> +	unsigned long len;=0A=
> +	int res;=0A=
> +	struct ioctl_snapshot_errno_s param;=0A=
> +=0A=
> +	len =3D copy_from_user(&param, (void *)arg, sizeof(struct ioctl_dev_id_=
s));=0A=
> +	if (len !=3D 0) {=0A=
> +		pr_err("Unable failed to get snapstore error code: invalid user buffer=
\n");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	res =3D snapstore_device_errno(MKDEV(param.dev_id.major, param.dev_id.m=
inor),=0A=
> +				     &param.err_code);=0A=
> +=0A=
> +	if (res !=3D SUCCESS)=0A=
> +		return res;=0A=
> +=0A=
> +	len =3D copy_to_user((void *)arg, &param, sizeof(struct ioctl_snapshot_=
errno_s));=0A=
> +	if (len !=3D 0) {=0A=
> +		pr_err("Unable to get snapstore error code: invalid user buffer\n");=
=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +int ioctl_collect_snapimages(unsigned long arg)=0A=
> +{=0A=
> +	unsigned long len;=0A=
> +	int status =3D SUCCESS;=0A=
> +	struct ioctl_collect_snapshot_images_s param;=0A=
> +=0A=
> +	len =3D copy_from_user(&param, (void *)arg, sizeof(struct ioctl_collect=
_snapshot_images_s));=0A=
> +	if (len !=3D 0) {=0A=
> +		pr_err("Unable to collect snapshot images: invalid user buffer\n");=0A=
> +		return -ENODATA;=0A=
> +	}=0A=
> +=0A=
> +	status =3D snapimage_collect_images(param.count, param.p_image_info, &p=
aram.count);=0A=
> +=0A=
> +	len =3D copy_to_user((void *)arg, &param, sizeof(struct ioctl_collect_s=
napshot_images_s));=0A=
> +	if (len !=3D 0) {=0A=
> +		pr_err("Unable to collect snapshot images: invalid user buffer\n");=0A=
> +		return -ENODATA;=0A=
> +	}=0A=
> +=0A=
> +	return status;=0A=
> +}=0A=
> +=0A=
> +struct blk_snap_ioctl_table {=0A=
> +	unsigned int cmd;=0A=
> +	int (*fn)(unsigned long arg);=0A=
> +};=0A=
> +=0A=
> +static struct blk_snap_ioctl_table blk_snap_ioctl_table[] =3D {=0A=
> +	{ (IOCTL_COMPATIBILITY_FLAGS), ioctl_compatibility_flags },=0A=
> +	{ (IOCTL_GETVERSION), ioctl_get_version },=0A=
> +=0A=
> +	{ (IOCTL_TRACKING_ADD), ioctl_tracking_add },=0A=
> +	{ (IOCTL_TRACKING_REMOVE), ioctl_tracking_remove },=0A=
> +	{ (IOCTL_TRACKING_COLLECT), ioctl_tracking_collect },=0A=
> +	{ (IOCTL_TRACKING_BLOCK_SIZE), ioctl_tracking_block_size },=0A=
> +	{ (IOCTL_TRACKING_READ_CBT_BITMAP), ioctl_tracking_read_cbt_map },=0A=
> +	{ (IOCTL_TRACKING_MARK_DIRTY_BLOCKS), ioctl_tracking_mark_dirty_blocks =
},=0A=
> +=0A=
> +	{ (IOCTL_SNAPSHOT_CREATE), ioctl_snapshot_create },=0A=
> +	{ (IOCTL_SNAPSHOT_DESTROY), ioctl_snapshot_destroy },=0A=
> +	{ (IOCTL_SNAPSHOT_ERRNO), ioctl_snapshot_errno },=0A=
> +=0A=
> +	{ (IOCTL_SNAPSTORE_CREATE), ioctl_snapstore_create },=0A=
> +	{ (IOCTL_SNAPSTORE_FILE), ioctl_snapstore_file },=0A=
> +	{ (IOCTL_SNAPSTORE_MEMORY), ioctl_snapstore_memory },=0A=
> +	{ (IOCTL_SNAPSTORE_CLEANUP), ioctl_snapstore_cleanup },=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +	{ (IOCTL_SNAPSTORE_FILE_MULTIDEV), ioctl_snapstore_file_multidev },=0A=
> +#endif=0A=
> +	{ (IOCTL_COLLECT_SNAPSHOT_IMAGES), ioctl_collect_snapimages },=0A=
> +	{ 0, NULL }=0A=
> +};=0A=
> +=0A=
> +long ctrl_unlocked_ioctl(struct file *filp, unsigned int cmd, unsigned l=
ong arg)=0A=
> +{=0A=
> +	long status =3D -ENOTTY;=0A=
> +	size_t inx =3D 0;=0A=
> +=0A=
> +	while (blk_snap_ioctl_table[inx].cmd !=3D 0) {=0A=
> +		if (blk_snap_ioctl_table[inx].cmd =3D=3D cmd) {=0A=
> +			status =3D blk_snap_ioctl_table[inx].fn(arg);=0A=
> +			break;=0A=
> +		}=0A=
> +		++inx;=0A=
> +	}=0A=
> +=0A=
> +	return status;=0A=
> +}=0A=
> diff --git a/drivers/block/blk-snap/ctrl_fops.h b/drivers/block/blk-snap/=
ctrl_fops.h=0A=
> new file mode 100644=0A=
> index 000000000000..98072b61aa96=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/ctrl_fops.h=0A=
> @@ -0,0 +1,19 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
> +#pragma once=0A=
> +=0A=
> +#include <linux/fs.h>=0A=
> +=0A=
> +int get_blk_snap_major(void);=0A=
> +=0A=
> +int ctrl_init(void);=0A=
> +void ctrl_done(void);=0A=
> +=0A=
> +int ctrl_open(struct inode *inode, struct file *file);=0A=
> +int ctrl_release(struct inode *inode, struct file *file);=0A=
> +=0A=
> +ssize_t ctrl_read(struct file *filp, char __user *buffer, size_t length,=
 loff_t *offset);=0A=
> +ssize_t ctrl_write(struct file *filp, const char __user *buffer, size_t =
length, loff_t *offset);=0A=
> +=0A=
> +unsigned int ctrl_poll(struct file *filp, struct poll_table_struct *wait=
);=0A=
> +=0A=
> +long ctrl_unlocked_ioctl(struct file *file, unsigned int cmd, unsigned l=
ong arg);=0A=
> diff --git a/drivers/block/blk-snap/ctrl_pipe.c b/drivers/block/blk-snap/=
ctrl_pipe.c=0A=
> new file mode 100644=0A=
> index 000000000000..73cfbca93487=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/ctrl_pipe.c=0A=
> @@ -0,0 +1,562 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#define BLK_SNAP_SECTION "-ctrl"=0A=
> +#include "common.h"=0A=
> +#include "ctrl_pipe.h"=0A=
> +#include "version.h"=0A=
> +#include "blk-snap-ctl.h"=0A=
> +#include "snapstore.h"=0A=
> +#include "big_buffer.h"=0A=
> +=0A=
> +#include <linux/poll.h>=0A=
> +#include <linux/uuid.h>=0A=
> +=0A=
> +#define CMD_TO_USER_FIFO_SIZE 1024=0A=
> +=0A=
> +LIST_HEAD(ctl_pipes);=0A=
> +DECLARE_RWSEM(ctl_pipes_lock);=0A=
> +=0A=
> +=0A=
> +static void ctrl_pipe_push_request(struct ctrl_pipe *pipe, unsigned int =
*cmd, size_t cmd_len)=0A=
> +{=0A=
> +	kfifo_in_spinlocked(&pipe->cmd_to_user, cmd, (cmd_len * sizeof(unsigned=
 int)),=0A=
> +			    &pipe->cmd_to_user_lock);=0A=
> +=0A=
> +	wake_up(&pipe->readq);=0A=
> +}=0A=
> +=0A=
> +static void ctrl_pipe_request_acknowledge(struct ctrl_pipe *pipe, unsign=
ed int result)=0A=
> +{=0A=
> +	unsigned int cmd[2];=0A=
> +=0A=
> +	cmd[0] =3D BLK_SNAP_CHARCMD_ACKNOWLEDGE;=0A=
> +	cmd[1] =3D result;=0A=
> +=0A=
> +	ctrl_pipe_push_request(pipe, cmd, 2);=0A=
> +}=0A=
> +=0A=
> +static inline dev_t _snapstore_dev(struct ioctl_dev_id_s *dev_id)=0A=
> +{=0A=
> +	if ((dev_id->major =3D=3D 0) && (dev_id->minor =3D=3D 0))=0A=
> +		return 0; //memory snapstore=0A=
> +=0A=
> +	if ((dev_id->major =3D=3D -1) && (dev_id->minor =3D=3D -1))=0A=
> +		return 0xFFFFffff; //multidevice snapstore=0A=
> +=0A=
> +	return MKDEV(dev_id->major, dev_id->minor);=0A=
> +}=0A=
> +=0A=
> +static ssize_t ctrl_pipe_command_initiate(struct ctrl_pipe *pipe, const =
char __user *buffer,=0A=
> +					  size_t length)=0A=
> +{=0A=
> +	unsigned long len;=0A=
> +	int result =3D SUCCESS;=0A=
> +	ssize_t processed =3D 0;=0A=
> +	char *kernel_buffer;=0A=
> +=0A=
> +	kernel_buffer =3D kmalloc(length, GFP_KERNEL);=0A=
> +	if (kernel_buffer =3D=3D NULL)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	len =3D copy_from_user(kernel_buffer, buffer, length);=0A=
> +	if (len !=3D 0) {=0A=
> +		kfree(kernel_buffer);=0A=
> +		pr_err("Unable to write to pipe: invalid user buffer\n");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	do {=0A=
> +		u64 stretch_empty_limit;=0A=
> +		unsigned int dev_id_list_length;=0A=
> +		uuid_t *unique_id;=0A=
> +		struct ioctl_dev_id_s *snapstore_dev_id;=0A=
> +		struct ioctl_dev_id_s *dev_id_list;=0A=
> +=0A=
> +		//get snapstore uuid=0A=
> +		if ((length - processed) < 16) {=0A=
> +			pr_err("Unable to get snapstore uuid: invalid ctrl pipe initiate comm=
and. length=3D%zu\n",=0A=
> +			       length);=0A=
> +			break;=0A=
> +		}=0A=
> +		unique_id =3D (uuid_t *)(kernel_buffer + processed);=0A=
> +		processed +=3D 16;=0A=
> +=0A=
> +		//get snapstore empty limit=0A=
> +		if ((length - processed) < sizeof(u64)) {=0A=
> +			pr_err("Unable to get stretch snapstore limit: invalid ctrl pipe init=
iate command. length=3D%zu\n",=0A=
> +			       length);=0A=
> +			break;=0A=
> +		}=0A=
> +		stretch_empty_limit =3D *(u64 *)(kernel_buffer + processed);=0A=
> +		processed +=3D sizeof(u64);=0A=
> +=0A=
> +		//get snapstore device id=0A=
> +		if ((length - processed) < sizeof(struct ioctl_dev_id_s)) {=0A=
> +			pr_err("Unable to get snapstore device id: invalid ctrl pipe initiate=
 command. length=3D%zu\n",=0A=
> +			       length);=0A=
> +			break;=0A=
> +		}=0A=
> +		snapstore_dev_id =3D (struct ioctl_dev_id_s *)(kernel_buffer + process=
ed);=0A=
> +		processed +=3D sizeof(struct ioctl_dev_id_s);=0A=
> +=0A=
> +		//get device id list length=0A=
> +		if ((length - processed) < 4) {=0A=
> +			pr_err("Unable to get device id list length: ivalid ctrl pipe initiat=
e command. length=3D%zu\n",=0A=
> +			       length);=0A=
> +			break;=0A=
> +		}=0A=
> +		dev_id_list_length =3D *(unsigned int *)(kernel_buffer + processed);=
=0A=
> +		processed +=3D sizeof(unsigned int);=0A=
> +=0A=
> +		//get devices id list=0A=
> +		if ((length - processed) < (dev_id_list_length * sizeof(struct ioctl_d=
ev_id_s))) {=0A=
> +			pr_err("Unable to get all devices from device id list: invalid ctrl p=
ipe initiate command. length=3D%zu\n",=0A=
> +			       length);=0A=
> +			break;=0A=
> +		}=0A=
> +		dev_id_list =3D (struct ioctl_dev_id_s *)(kernel_buffer + processed);=
=0A=
> +		processed +=3D (dev_id_list_length * sizeof(struct ioctl_dev_id_s));=
=0A=
> +=0A=
> +		{=0A=
> +			size_t inx;=0A=
> +			dev_t *dev_set;=0A=
> +			size_t dev_id_set_length =3D (size_t)dev_id_list_length;=0A=
> +=0A=
> +			dev_set =3D kcalloc(dev_id_set_length, sizeof(dev_t), GFP_KERNEL);=0A=
> +			if (dev_set =3D=3D NULL) {=0A=
> +				result =3D -ENOMEM;=0A=
> +				break;=0A=
> +			}=0A=
> +=0A=
> +			for (inx =3D 0; inx < dev_id_set_length; ++inx)=0A=
> +				dev_set[inx] =3D=0A=
> +					MKDEV(dev_id_list[inx].major, dev_id_list[inx].minor);=0A=
> +=0A=
> +			result =3D snapstore_create(unique_id, _snapstore_dev(snapstore_dev_i=
d),=0A=
> +						  dev_set, dev_id_set_length);=0A=
> +			kfree(dev_set);=0A=
> +			if (result !=3D SUCCESS) {=0A=
> +				pr_err("Failed to create snapstore\n");=0A=
> +				break;=0A=
> +			}=0A=
> +=0A=
> +			result =3D snapstore_stretch_initiate(=0A=
> +				unique_id, pipe, (sector_t)to_sectors(stretch_empty_limit));=0A=
> +			if (result !=3D SUCCESS) {=0A=
> +				pr_err("Failed to initiate stretch snapstore %pUB\n", unique_id);=0A=
> +				break;=0A=
> +			}=0A=
> +		}=0A=
> +	} while (false);=0A=
> +	kfree(kernel_buffer);=0A=
> +	ctrl_pipe_request_acknowledge(pipe, result);=0A=
> +=0A=
> +	if (result =3D=3D SUCCESS)=0A=
> +		return processed;=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
> +static ssize_t ctrl_pipe_command_next_portion(struct ctrl_pipe *pipe, co=
nst char __user *buffer,=0A=
> +					      size_t length)=0A=
> +{=0A=
> +	unsigned long len;=0A=
> +	int result =3D SUCCESS;=0A=
> +	ssize_t processed =3D 0;=0A=
> +	struct big_buffer *ranges =3D NULL;=0A=
> +=0A=
> +	do {=0A=
> +		uuid_t unique_id;=0A=
> +		unsigned int ranges_length;=0A=
> +		size_t ranges_buffer_size;=0A=
> +=0A=
> +		//get snapstore id=0A=
> +		if ((length - processed) < 16) {=0A=
> +			pr_err("Unable to get snapstore id: ");=0A=
> +			pr_err("invalid ctrl pipe next portion command. length=3D%zu\n",=0A=
> +			       length);=0A=
> +			break;=0A=
> +		}=0A=
> +		len =3D copy_from_user(&unique_id, buffer + processed, sizeof(uuid_t))=
;=0A=
> +		if (len !=3D 0) {=0A=
> +			pr_err("Unable to write to pipe: invalid user buffer\n");=0A=
> +			processed =3D -EINVAL;=0A=
> +			break;=0A=
> +		}=0A=
> +		processed +=3D 16;=0A=
> +=0A=
> +		//get ranges length=0A=
> +		if ((length - processed) < 4) {=0A=
> +			pr_err("Unable to get device id list length: ");=0A=
> +			pr_err("invalid ctrl pipe next portion command. length=3D%zu\n",=0A=
> +			       length);=0A=
> +			break;=0A=
> +		}=0A=
> +		len =3D copy_from_user(&ranges_length, buffer + processed, sizeof(unsi=
gned int));=0A=
> +		if (len !=3D 0) {=0A=
> +			pr_err("Unable to write to pipe: invalid user buffer\n");=0A=
> +			processed =3D -EINVAL;=0A=
> +			break;=0A=
> +		}=0A=
> +		processed +=3D sizeof(unsigned int);=0A=
> +=0A=
> +		ranges_buffer_size =3D ranges_length * sizeof(struct ioctl_range_s);=
=0A=
> +=0A=
> +		// ranges=0A=
> +		if ((length - processed) < (ranges_buffer_size)) {=0A=
> +			pr_err("Unable to get all ranges: ");=0A=
> +			pr_err("invalid ctrl pipe next portion command. length=3D%zu\n",=0A=
> +			       length);=0A=
> +			break;=0A=
> +		}=0A=
> +		ranges =3D big_buffer_alloc(ranges_buffer_size, GFP_KERNEL);=0A=
> +		if (ranges =3D=3D NULL) {=0A=
> +			pr_err("Unable to allocate page array buffer: ");=0A=
> +			pr_err("failed to process next portion command\n");=0A=
> +			processed =3D -ENOMEM;=0A=
> +			break;=0A=
> +		}=0A=
> +		if (ranges_buffer_size !=3D=0A=
> +		    big_buffer_copy_from_user(buffer + processed, 0, ranges, ranges_bu=
ffer_size)) {=0A=
> +			pr_err("Unable to process next portion command: ");=0A=
> +			pr_err("invalid user buffer for parameters\n");=0A=
> +			processed =3D -EINVAL;=0A=
> +			break;=0A=
> +		}=0A=
> +		processed +=3D ranges_buffer_size;=0A=
> +=0A=
> +		{=0A=
> +			result =3D snapstore_add_file(&unique_id, ranges, ranges_length);=0A=
> +=0A=
> +			if (result !=3D SUCCESS) {=0A=
> +				pr_err("Failed to add file to snapstore\n");=0A=
> +				result =3D -ENODEV;=0A=
> +				break;=0A=
> +			}=0A=
> +		}=0A=
> +	} while (false);=0A=
> +	if (ranges)=0A=
> +		big_buffer_free(ranges);=0A=
> +=0A=
> +	if (result =3D=3D SUCCESS)=0A=
> +		return processed;=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +static ssize_t ctrl_pipe_command_next_portion_multidev(struct ctrl_pipe =
*pipe,=0A=
> +						       const char __user *buffer, size_t length)=0A=
> +{=0A=
> +	unsigned long len;=0A=
> +	int result =3D SUCCESS;=0A=
> +	ssize_t processed =3D 0;=0A=
> +	struct big_buffer *ranges =3D NULL;=0A=
> +=0A=
> +	do {=0A=
> +		uuid_t unique_id;=0A=
> +		int snapstore_major;=0A=
> +		int snapstore_minor;=0A=
> +		unsigned int ranges_length;=0A=
> +		size_t ranges_buffer_size;=0A=
> +=0A=
> +		//get snapstore id=0A=
> +		if ((length - processed) < 16) {=0A=
> +			pr_err("Unable to get snapstore id: ");=0A=
> +			pr_err("invalid ctrl pipe next portion command. length=3D%zu\n",=0A=
> +			       length);=0A=
> +			break;=0A=
> +		}=0A=
> +		len =3D copy_from_user(&unique_id, buffer + processed, sizeof(uuid_t))=
;=0A=
> +		if (len !=3D 0) {=0A=
> +			pr_err("Unable to write to pipe: invalid user buffer\n");=0A=
> +			processed =3D -EINVAL;=0A=
> +			break;=0A=
> +		}=0A=
> +		processed +=3D 16;=0A=
> +=0A=
> +		//get device id=0A=
> +		if ((length - processed) < 8) {=0A=
> +			pr_err("Unable to get device id list length: ");=0A=
> +			pr_err("invalid ctrl pipe next portion command. length=3D%zu\n", leng=
th);=0A=
> +			break;=0A=
> +		}=0A=
> +		len =3D copy_from_user(&snapstore_major, buffer + processed, sizeof(un=
signed int));=0A=
> +		if (len !=3D 0) {=0A=
> +			pr_err("Unable to write to pipe: invalid user buffer\n");=0A=
> +			processed =3D -EINVAL;=0A=
> +			break;=0A=
> +		}=0A=
> +		processed +=3D sizeof(unsigned int);=0A=
> +=0A=
> +		len =3D copy_from_user(&snapstore_minor, buffer + processed, sizeof(un=
signed int));=0A=
> +		if (len !=3D 0) {=0A=
> +			pr_err("Unable to write to pipe: invalid user buffer\n");=0A=
> +			processed =3D -EINVAL;=0A=
> +			break;=0A=
> +		}=0A=
> +		processed +=3D sizeof(unsigned int);=0A=
> +=0A=
> +		//get ranges length=0A=
> +		if ((length - processed) < 4) {=0A=
> +			pr_err("Unable to get device id list length: ");=0A=
> +			pr_err("invalid ctrl pipe next portion command. length=3D%zu\n",=0A=
> +			       length);=0A=
> +			break;=0A=
> +		}=0A=
> +		len =3D copy_from_user(&ranges_length, buffer + processed, sizeof(unsi=
gned int));=0A=
> +		if (len !=3D 0) {=0A=
> +			pr_err("Unable to write to pipe: invalid user buffer\n");=0A=
> +			processed =3D -EINVAL;=0A=
> +			break;=0A=
> +		}=0A=
> +		processed +=3D sizeof(unsigned int);=0A=
> +=0A=
> +		ranges_buffer_size =3D ranges_length * sizeof(struct ioctl_range_s);=
=0A=
> +=0A=
> +		// ranges=0A=
> +		if ((length - processed) < (ranges_buffer_size)) {=0A=
> +			pr_err("Unable to get all ranges: ");=0A=
> +			pr_err("invalid ctrl pipe next portion command.  length=3D%zu\n",=0A=
> +			       length);=0A=
> +			break;=0A=
> +		}=0A=
> +		ranges =3D big_buffer_alloc(ranges_buffer_size, GFP_KERNEL);=0A=
> +		if (ranges =3D=3D NULL) {=0A=
> +			pr_err("Unable to process next portion command: ");=0A=
> +			pr_err("failed to allocate page array buffer\n");=0A=
> +			processed =3D -ENOMEM;=0A=
> +			break;=0A=
> +		}=0A=
> +		if (ranges_buffer_size !=3D=0A=
> +		    big_buffer_copy_from_user(buffer + processed, 0, ranges, ranges_bu=
ffer_size)) {=0A=
> +			pr_err("Unable to process next portion command: ");=0A=
> +			pr_err("invalid user buffer from parameters\n");=0A=
> +			processed =3D -EINVAL;=0A=
> +			break;=0A=
> +		}=0A=
> +		processed +=3D ranges_buffer_size;=0A=
> +=0A=
> +		{=0A=
> +			result =3D snapstore_add_multidev(&unique_id,=0A=
> +							MKDEV(snapstore_major, snapstore_minor),=0A=
> +							ranges, ranges_length);=0A=
> +=0A=
> +			if (result !=3D SUCCESS) {=0A=
> +				pr_err("Failed to add file to snapstore\n");=0A=
> +				result =3D -ENODEV;=0A=
> +				break;=0A=
> +			}=0A=
> +		}=0A=
> +	} while (false);=0A=
> +	if (ranges)=0A=
> +		big_buffer_free(ranges);=0A=
> +=0A=
> +	if (result =3D=3D SUCCESS)=0A=
> +		return processed;=0A=
> +=0A=
> +	return result;=0A=
> +}=0A=
> +#endif=0A=
> +=0A=
> +static void ctrl_pipe_release_cb(struct kref *kref)=0A=
> +{=0A=
> +	struct ctrl_pipe *pipe =3D container_of(kref, struct ctrl_pipe, refcoun=
t);=0A=
> +=0A=
> +	down_write(&ctl_pipes_lock);=0A=
> +	list_del(&pipe->link);=0A=
> +	up_write(&ctl_pipes_lock);=0A=
> +=0A=
> +	kfifo_free(&pipe->cmd_to_user);=0A=
> +=0A=
> +	kfree(pipe);=0A=
> +}=0A=
> +=0A=
> +struct ctrl_pipe *ctrl_pipe_get_resource(struct ctrl_pipe *pipe)=0A=
> +{=0A=
> +	if (pipe)=0A=
> +		kref_get(&pipe->refcount);=0A=
> +=0A=
> +	return pipe;=0A=
> +}=0A=
> +=0A=
> +void ctrl_pipe_put_resource(struct ctrl_pipe *pipe)=0A=
> +{=0A=
> +	if (pipe)=0A=
> +		kref_put(&pipe->refcount, ctrl_pipe_release_cb);=0A=
> +}=0A=
> +=0A=
> +void ctrl_pipe_done(void)=0A=
> +{=0A=
> +	bool is_empty;=0A=
> +=0A=
> +	pr_info("Ctrl pipes - done\n");=0A=
> +=0A=
> +	down_write(&ctl_pipes_lock);=0A=
> +	is_empty =3D list_empty(&ctl_pipes);=0A=
> +	up_write(&ctl_pipes_lock);=0A=
> +=0A=
> +	if (!is_empty)=0A=
> +		pr_err("Unable to perform ctrl pipes cleanup: container is not empty\n=
");=0A=
> +}=0A=
> +=0A=
> +struct ctrl_pipe *ctrl_pipe_new(void)=0A=
> +{=0A=
> +	int ret;=0A=
> +	struct ctrl_pipe *pipe;=0A=
> +=0A=
> +	pipe =3D kzalloc(sizeof(struct ctrl_pipe), GFP_KERNEL);=0A=
> +	if (pipe =3D=3D NULL)=0A=
> +		return NULL;=0A=
> +=0A=
> +	INIT_LIST_HEAD(&pipe->link);=0A=
> +=0A=
> +	ret =3D kfifo_alloc(&pipe->cmd_to_user, CMD_TO_USER_FIFO_SIZE, GFP_KERN=
EL);=0A=
> +	if (ret) {=0A=
> +		pr_err("Failed to allocate fifo. errno=3D%d.\n", ret);=0A=
> +		kfree(pipe);=0A=
> +		return NULL;=0A=
> +	}=0A=
> +	spin_lock_init(&pipe->cmd_to_user_lock);=0A=
> +=0A=
> +	kref_init(&pipe->refcount);=0A=
> +=0A=
> +	init_waitqueue_head(&pipe->readq);=0A=
> +=0A=
> +	down_write(&ctl_pipes_lock);=0A=
> +	list_add_tail(&pipe->link, &ctl_pipes);=0A=
> +	up_write(&ctl_pipes_lock);=0A=
> +=0A=
> +	return pipe;=0A=
> +}=0A=
> +=0A=
> +ssize_t ctrl_pipe_read(struct ctrl_pipe *pipe, char __user *buffer, size=
_t length)=0A=
> +{=0A=
> +	int ret;=0A=
> +	unsigned int processed =3D 0;=0A=
> +=0A=
> +	if (kfifo_is_empty_spinlocked(&pipe->cmd_to_user, &pipe->cmd_to_user_lo=
ck)) {=0A=
> +		//nothing to read=0A=
> +		ret =3D wait_event_interruptible(pipe->readq,=0A=
> +					       !kfifo_is_empty_spinlocked(&pipe->cmd_to_user,=0A=
> +									&pipe->cmd_to_user_lock));=0A=
> +		if (ret) {=0A=
> +			pr_err("Unable to wait for pipe read queue: interrupt signal was rece=
ived\n");=0A=
> +			return -ERESTARTSYS;=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	ret =3D kfifo_to_user(&pipe->cmd_to_user, buffer, length, &processed);=
=0A=
> +	if (ret) {=0A=
> +		pr_err("Failed to read command from ctrl pipe\n");=0A=
> +		return ret;=0A=
> +	}=0A=
> +=0A=
> +	return (ssize_t)processed;=0A=
> +}=0A=
> +=0A=
> +ssize_t ctrl_pipe_write(struct ctrl_pipe *pipe, const char __user *buffe=
r, size_t length)=0A=
> +{=0A=
> +	ssize_t processed =3D 0;=0A=
> +=0A=
> +	do {=0A=
> +		unsigned long len;=0A=
> +		unsigned int command;=0A=
> +=0A=
> +		if ((length - processed) < 4) {=0A=
> +			pr_err("Unable to write command to ctrl pipe: invalid command length=
=3D%zu\n",=0A=
> +			       length);=0A=
> +			break;=0A=
> +		}=0A=
> +		len =3D copy_from_user(&command, buffer + processed, sizeof(unsigned i=
nt));=0A=
> +		if (len !=3D 0) {=0A=
> +			pr_err("Unable to write to pipe: invalid user buffer\n");=0A=
> +			processed =3D -EINVAL;=0A=
> +			break;=0A=
> +		}=0A=
> +		processed +=3D sizeof(unsigned int);=0A=
> +		//+4=0A=
> +		switch (command) {=0A=
> +		case BLK_SNAP_CHARCMD_INITIATE: {=0A=
> +			ssize_t res =3D ctrl_pipe_command_initiate(pipe, buffer + processed,=
=0A=
> +								 length - processed);=0A=
> +			if (res >=3D 0)=0A=
> +				processed +=3D res;=0A=
> +			else=0A=
> +				processed =3D res;=0A=
> +		} break;=0A=
> +		case BLK_SNAP_CHARCMD_NEXT_PORTION: {=0A=
> +			ssize_t res =3D ctrl_pipe_command_next_portion(pipe, buffer + process=
ed,=0A=
> +								     length - processed);=0A=
> +			if (res >=3D 0)=0A=
> +				processed +=3D res;=0A=
> +			else=0A=
> +				processed =3D res;=0A=
> +		} break;=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +		case BLK_SNAP_CHARCMD_NEXT_PORTION_MULTIDEV: {=0A=
> +			ssize_t res =3D ctrl_pipe_command_next_portion_multidev(=0A=
> +				pipe, buffer + processed, length - processed);=0A=
> +			if (res >=3D 0)=0A=
> +				processed +=3D res;=0A=
> +			else=0A=
> +				processed =3D res;=0A=
> +		} break;=0A=
> +#endif=0A=
> +		default:=0A=
> +			pr_err("Ctrl pipe write error: invalid command [0x%x] received\n", co=
mmand);=0A=
> +			break;=0A=
> +		}=0A=
> +	} while (false);=0A=
> +	return processed;=0A=
> +}=0A=
> +=0A=
> +unsigned int ctrl_pipe_poll(struct ctrl_pipe *pipe)=0A=
> +{=0A=
> +	unsigned int mask =3D 0;=0A=
> +=0A=
> +	if (!kfifo_is_empty_spinlocked(&pipe->cmd_to_user, &pipe->cmd_to_user_l=
ock))=0A=
> +		mask |=3D (POLLIN | POLLRDNORM); /* readable */=0A=
> +=0A=
> +	mask |=3D (POLLOUT | POLLWRNORM); /* writable */=0A=
> +=0A=
> +	return mask;=0A=
> +}=0A=
> +=0A=
> +void ctrl_pipe_request_halffill(struct ctrl_pipe *pipe, unsigned long lo=
ng filled_status)=0A=
> +{=0A=
> +	unsigned int cmd[3];=0A=
> +=0A=
> +	pr_info("Snapstore is half-full\n");=0A=
> +=0A=
> +	cmd[0] =3D (unsigned int)BLK_SNAP_CHARCMD_HALFFILL;=0A=
> +	cmd[1] =3D (unsigned int)(filled_status & 0xFFFFffff); //lo=0A=
> +	cmd[2] =3D (unsigned int)(filled_status >> 32);=0A=
> +=0A=
> +	ctrl_pipe_push_request(pipe, cmd, 3);=0A=
> +}=0A=
> +=0A=
> +void ctrl_pipe_request_overflow(struct ctrl_pipe *pipe, unsigned int err=
or_code,=0A=
> +				unsigned long long filled_status)=0A=
> +{=0A=
> +	unsigned int cmd[4];=0A=
> +=0A=
> +	pr_info("Snapstore overflow\n");=0A=
> +=0A=
> +	cmd[0] =3D (unsigned int)BLK_SNAP_CHARCMD_OVERFLOW;=0A=
> +	cmd[1] =3D error_code;=0A=
> +	cmd[2] =3D (unsigned int)(filled_status & 0xFFFFffff); //lo=0A=
> +	cmd[3] =3D (unsigned int)(filled_status >> 32);=0A=
> +=0A=
> +	ctrl_pipe_push_request(pipe, cmd, 4);=0A=
> +}=0A=
> +=0A=
> +void ctrl_pipe_request_terminate(struct ctrl_pipe *pipe, unsigned long l=
ong filled_status)=0A=
> +{=0A=
> +	unsigned int cmd[3];=0A=
> +=0A=
> +	pr_info("Snapstore termination\n");=0A=
> +=0A=
> +	cmd[0] =3D (unsigned int)BLK_SNAP_CHARCMD_TERMINATE;=0A=
> +	cmd[1] =3D (unsigned int)(filled_status & 0xFFFFffff); //lo=0A=
> +	cmd[2] =3D (unsigned int)(filled_status >> 32);=0A=
> +=0A=
> +	ctrl_pipe_push_request(pipe, cmd, 3);=0A=
> +}=0A=
> diff --git a/drivers/block/blk-snap/ctrl_pipe.h b/drivers/block/blk-snap/=
ctrl_pipe.h=0A=
> new file mode 100644=0A=
> index 000000000000..1aa1099eec25=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/ctrl_pipe.h=0A=
> @@ -0,0 +1,34 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
> +#pragma once=0A=
> +=0A=
> +#include <linux/kref.h>=0A=
> +#include <linux/wait.h>=0A=
> +#include <linux/kfifo.h>=0A=
> +=0A=
> +struct ctrl_pipe {=0A=
> +	struct list_head link;=0A=
> +=0A=
> +	struct kref refcount;=0A=
> +=0A=
> +	wait_queue_head_t readq;=0A=
> +=0A=
> +	struct kfifo cmd_to_user;=0A=
> +	spinlock_t cmd_to_user_lock;=0A=
> +};=0A=
> +=0A=
> +struct ctrl_pipe *ctrl_pipe_get_resource(struct ctrl_pipe *pipe);=0A=
> +void ctrl_pipe_put_resource(struct ctrl_pipe *pipe);=0A=
> +=0A=
> +void ctrl_pipe_done(void);=0A=
> +=0A=
> +struct ctrl_pipe *ctrl_pipe_new(void);=0A=
> +=0A=
> +ssize_t ctrl_pipe_read(struct ctrl_pipe *pipe, char __user *buffer, size=
_t length);=0A=
> +ssize_t ctrl_pipe_write(struct ctrl_pipe *pipe, const char __user *buffe=
r, size_t length);=0A=
> +=0A=
> +unsigned int ctrl_pipe_poll(struct ctrl_pipe *pipe);=0A=
> +=0A=
> +void ctrl_pipe_request_halffill(struct ctrl_pipe *pipe, unsigned long lo=
ng filled_status);=0A=
> +void ctrl_pipe_request_overflow(struct ctrl_pipe *pipe, unsigned int err=
or_code,=0A=
> +				unsigned long long filled_status);=0A=
> +void ctrl_pipe_request_terminate(struct ctrl_pipe *pipe, unsigned long l=
ong filled_status);=0A=
> diff --git a/drivers/block/blk-snap/ctrl_sysfs.c b/drivers/block/blk-snap=
/ctrl_sysfs.c=0A=
> new file mode 100644=0A=
> index 000000000000..4ec78e85b510=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/ctrl_sysfs.c=0A=
> @@ -0,0 +1,73 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#define BLK_SNAP_SECTION "-ctrl"=0A=
> +#include "common.h"=0A=
> +#include "ctrl_sysfs.h"=0A=
> +#include "ctrl_fops.h"=0A=
> +#include "blk-snap-ctl.h"=0A=
> +=0A=
> +#include <linux/blkdev.h>=0A=
> +#include <linux/sysfs.h>=0A=
> +=0A=
> +static ssize_t major_show(struct class *class, struct class_attribute *a=
ttr, char *buf)=0A=
> +{=0A=
> +	sprintf(buf, "%d", get_blk_snap_major());=0A=
> +	return strlen(buf);=0A=
> +}=0A=
> +=0A=
> +CLASS_ATTR_RO(major); // declare class_attr_major=0A=
> +static struct class *blk_snap_class;=0A=
> +=0A=
> +static struct device *blk_snap_device;=0A=
> +=0A=
> +int ctrl_sysfs_init(void)=0A=
> +{=0A=
> +	struct device *dev;=0A=
> +	int res;=0A=
> +=0A=
> +	blk_snap_class =3D class_create(THIS_MODULE, MODULE_NAME);=0A=
> +	if (IS_ERR(blk_snap_class)) {=0A=
> +		res =3D PTR_ERR(blk_snap_class);=0A=
> +=0A=
> +		pr_err("Bad class create. errno=3D%d\n", 0 - res);=0A=
> +		return res;=0A=
> +	}=0A=
> +=0A=
> +	pr_info("Create 'major' sysfs attribute\n");=0A=
> +	res =3D class_create_file(blk_snap_class, &class_attr_major);=0A=
> +	if (res !=3D SUCCESS) {=0A=
> +		pr_err("Failed to create 'major' sysfs file\n");=0A=
> +=0A=
> +		class_destroy(blk_snap_class);=0A=
> +		blk_snap_class =3D NULL;=0A=
> +		return res;=0A=
> +	}=0A=
> +=0A=
> +	dev =3D device_create(blk_snap_class, NULL, MKDEV(get_blk_snap_major(),=
 0), NULL,=0A=
> +			    MODULE_NAME);=0A=
> +	if (IS_ERR(dev)) {=0A=
> +		res =3D PTR_ERR(dev);=0A=
> +		pr_err("Failed to create device, errno=3D%d\n", res);=0A=
> +=0A=
> +		class_remove_file(blk_snap_class, &class_attr_major);=0A=
> +		class_destroy(blk_snap_class);=0A=
> +		blk_snap_class =3D NULL;=0A=
> +		return res;=0A=
> +	}=0A=
> +=0A=
> +	blk_snap_device =3D dev;=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +void ctrl_sysfs_done(void)=0A=
> +{=0A=
> +	if (blk_snap_device) {=0A=
> +		device_unregister(blk_snap_device);=0A=
> +		blk_snap_device =3D NULL;=0A=
> +	}=0A=
> +=0A=
> +	if (blk_snap_class !=3D NULL) {=0A=
> +		class_remove_file(blk_snap_class, &class_attr_major);=0A=
> +		class_destroy(blk_snap_class);=0A=
> +		blk_snap_class =3D NULL;=0A=
> +	}=0A=
> +}=0A=
> diff --git a/drivers/block/blk-snap/ctrl_sysfs.h b/drivers/block/blk-snap=
/ctrl_sysfs.h=0A=
> new file mode 100644=0A=
> index 000000000000..27a2a4d3da4c=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/ctrl_sysfs.h=0A=
> @@ -0,0 +1,5 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
> +#pragma once=0A=
> +=0A=
> +int ctrl_sysfs_init(void);=0A=
> +void ctrl_sysfs_done(void);=0A=
> diff --git a/drivers/block/blk-snap/defer_io.c b/drivers/block/blk-snap/d=
efer_io.c=0A=
> new file mode 100644=0A=
> index 000000000000..309216fe7319=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/defer_io.c=0A=
> @@ -0,0 +1,397 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#define BLK_SNAP_SECTION "-defer_io"=0A=
> +#include "common.h"=0A=
> +#include "defer_io.h"=0A=
> +#include "blk_deferred.h"=0A=
> +#include "tracker.h"=0A=
> +#include "blk_util.h"=0A=
> +=0A=
> +#include <linux/kthread.h>=0A=
> +=0A=
> +#define BLK_IMAGE_THROTTLE_TIMEOUT (1 * HZ) //delay 1 sec=0A=
> +//#define BLK_IMAGE_THROTTLE_TIMEOUT ( HZ/1000 * 10 )	//delay 10 ms=0A=
> +=0A=
> +=0A=
> +=0A=
> +struct defer_io_orig_rq {=0A=
> +	struct list_head link;=0A=
> +	struct defer_io_queue *queue;=0A=
> +=0A=
> +	struct bio *bio;=0A=
> +	struct tracker *tracker;=0A=
> +};=0A=
> +=0A=
> +static inline void defer_io_queue_init(struct defer_io_queue *queue)=0A=
> +{=0A=
> +	INIT_LIST_HEAD(&queue->list);=0A=
> +=0A=
> +	spin_lock_init(&queue->lock);=0A=
> +=0A=
> +	atomic_set(&queue->in_queue_cnt, 0);=0A=
> +	atomic_set(&queue->active_state, true);=0A=
> +}=0A=
> +=0A=
> +static inline struct defer_io_orig_rq *defer_io_queue_new(struct defer_i=
o_queue *queue, struct bio *bio)=0A=
> +{=0A=
> +	struct defer_io_orig_rq *dio_rq;=0A=
> +=0A=
> +	dio_rq =3D kzalloc(sizeof(struct defer_io_orig_rq), GFP_NOIO);=0A=
> +	if (dio_rq =3D=3D NULL)=0A=
> +		return NULL;=0A=
> +=0A=
> +	dio_rq->bio =3D bio;=0A=
> +	bio_get(dio_rq->bio);=0A=
> +=0A=
> +	INIT_LIST_HEAD(&dio_rq->link);=0A=
> +	dio_rq->queue =3D queue;=0A=
> +=0A=
> +	return dio_rq;=0A=
> +}=0A=
> +=0A=
> +static inline void defer_io_queue_free(struct defer_io_orig_rq *dio_rq)=
=0A=
> +{=0A=
> +	if (likely(dio_rq)) {=0A=
> +		if (likely(dio_rq->bio)) {=0A=
> +			bio_put(dio_rq->bio);=0A=
> +			dio_rq->bio =3D NULL;=0A=
> +		}=0A=
> +		kfree(dio_rq);=0A=
> +	}=0A=
> +}=0A=
> +=0A=
> +static int defer_io_queue_push_back(struct defer_io_queue *queue, struct=
 defer_io_orig_rq *dio_rq)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +=0A=
> +	spin_lock(&queue->lock);=0A=
> +=0A=
> +	if (atomic_read(&queue->active_state)) {=0A=
> +		list_add_tail(&dio_rq->link, &queue->list);=0A=
> +		atomic_inc(&queue->in_queue_cnt);=0A=
> +	} else=0A=
> +		res =3D -EACCES;=0A=
> +=0A=
> +	spin_unlock(&queue->lock);=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +static struct defer_io_orig_rq *defer_io_queue_get_first(struct defer_io=
_queue *queue)=0A=
> +{=0A=
> +	struct defer_io_orig_rq *dio_rq =3D NULL;=0A=
> +=0A=
> +	spin_lock(&queue->lock);=0A=
> +=0A=
> +	if (!list_empty(&queue->list)) {=0A=
> +		dio_rq =3D list_entry(queue->list.next, struct defer_io_orig_rq, link)=
;=0A=
> +		list_del(&dio_rq->link);=0A=
> +		atomic_dec(&queue->in_queue_cnt);=0A=
> +	}=0A=
> +=0A=
> +	spin_unlock(&queue->lock);=0A=
> +=0A=
> +	return dio_rq;=0A=
> +}=0A=
> +=0A=
> +static bool defer_io_queue_active(struct defer_io_queue *queue, bool sta=
te)=0A=
> +{=0A=
> +	bool prev_state;=0A=
> +=0A=
> +	spin_lock(&queue->lock);=0A=
> +=0A=
> +	prev_state =3D atomic_read(&queue->active_state);=0A=
> +	atomic_set(&queue->active_state, state);=0A=
> +=0A=
> +	spin_unlock(&queue->lock);=0A=
> +=0A=
> +	return prev_state;=0A=
> +}=0A=
> +=0A=
> +#define defer_io_queue_empty(queue) (atomic_read(&(queue).in_queue_cnt) =
=3D=3D 0)=0A=
> +=0A=
> +static void _defer_io_finish(struct defer_io *defer_io, struct defer_io_=
queue *queue_in_progress)=0A=
> +{=0A=
> +	while (!defer_io_queue_empty(*queue_in_progress)) {=0A=
> +		struct tracker *tracker =3D NULL;=0A=
> +		bool cbt_locked =3D false;=0A=
> +		bool is_write_bio;=0A=
> +		sector_t sectCount =3D 0;=0A=
> +=0A=
> +		struct defer_io_orig_rq *orig_req =3D defer_io_queue_get_first(queue_i=
n_progress);=0A=
> +=0A=
> +		is_write_bio =3D bio_data_dir(orig_req->bio) && bio_has_data(orig_req-=
>bio);=0A=
> +=0A=
> +		if (orig_req->tracker && is_write_bio) {=0A=
> +			tracker =3D orig_req->tracker;=0A=
> +			cbt_locked =3D tracker_cbt_bitmap_lock(tracker);=0A=
> +			if (cbt_locked) {=0A=
> +				sectCount =3D bio_sectors(orig_req->bio);=0A=
> +				tracker_cbt_bitmap_set(tracker, orig_req->bio->bi_iter.bi_sector,=0A=
> +						       sectCount);=0A=
> +			}=0A=
> +		}=0A=
> +=0A=
> +		submit_bio_direct(orig_req->bio);=0A=
> +=0A=
> +		if (cbt_locked)=0A=
> +			tracker_cbt_bitmap_unlock(tracker);=0A=
> +=0A=
> +		defer_io_queue_free(orig_req);=0A=
> +	}=0A=
> +}=0A=
> +=0A=
> +static int _defer_io_copy_prepare(struct defer_io *defer_io,=0A=
> +				  struct defer_io_queue *queue_in_process,=0A=
> +				  struct blk_deferred_request **dio_copy_req)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	int dios_count =3D 0;=0A=
> +	sector_t dios_sectors_count =3D 0;=0A=
> +=0A=
> +	//fill copy_request set=0A=
> +	while (!defer_io_queue_empty(defer_io->dio_queue) &&=0A=
> +	       (dios_count < DEFER_IO_DIO_REQUEST_LENGTH) &&=0A=
> +	       (dios_sectors_count < DEFER_IO_DIO_REQUEST_SECTORS_COUNT)) {=0A=
> +		struct defer_io_orig_rq *dio_orig_req =3D=0A=
> +			(struct defer_io_orig_rq *)defer_io_queue_get_first(&defer_io->dio_qu=
eue);=0A=
> +		atomic_dec(&defer_io->queue_filling_count);=0A=
> +=0A=
> +		defer_io_queue_push_back(queue_in_process, dio_orig_req);=0A=
> +=0A=
> +		if (!kthread_should_stop() &&=0A=
> +		    !snapstore_device_is_corrupted(defer_io->snapstore_device)) {=0A=
> +			if (bio_data_dir(dio_orig_req->bio) && bio_has_data(dio_orig_req->bio=
)) {=0A=
> +				struct blk_range copy_range;=0A=
> +=0A=
> +				copy_range.ofs =3D dio_orig_req->bio->bi_iter.bi_sector;=0A=
> +				copy_range.cnt =3D bio_sectors(dio_orig_req->bio);=0A=
> +				res =3D snapstore_device_prepare_requests(defer_io->snapstore_device=
,=0A=
> +									&copy_range, dio_copy_req);=0A=
> +				if (res !=3D SUCCESS) {=0A=
> +					pr_err("Unable to execute Copy On Write algorithm: failed to add ra=
nges to copy to snapstore request. errno=3D%d\n",=0A=
> +					       res);=0A=
> +					break;=0A=
> +				}=0A=
> +=0A=
> +				dios_sectors_count +=3D copy_range.cnt;=0A=
> +			}=0A=
> +		}=0A=
> +		++dios_count;=0A=
> +	}=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +static int defer_io_work_thread(void *p)=0A=
> +{=0A=
> +	struct defer_io_queue queue_in_process =3D { 0 };=0A=
> +	struct defer_io *defer_io =3D NULL;=0A=
> +=0A=
> +	//set_user_nice( current, -20 ); //MIN_NICE=0A=
> +	defer_io_queue_init(&queue_in_process);=0A=
> +=0A=
> +	defer_io =3D defer_io_get_resource((struct defer_io *)p);=0A=
> +	pr_info("Defer IO thread for original device [%d:%d] started\n",=0A=
> +		MAJOR(defer_io->original_dev_id), MINOR(defer_io->original_dev_id));=
=0A=
> +=0A=
> +	while (!kthread_should_stop() || !defer_io_queue_empty(defer_io->dio_qu=
eue)) {=0A=
> +		if (defer_io_queue_empty(defer_io->dio_queue)) {=0A=
> +			int res =3D wait_event_interruptible_timeout(=0A=
> +				defer_io->queue_add_event,=0A=
> +				(!defer_io_queue_empty(defer_io->dio_queue)),=0A=
> +				BLK_IMAGE_THROTTLE_TIMEOUT);=0A=
> +			if (-ERESTARTSYS =3D=3D res)=0A=
> +				pr_err("Signal received in defer IO thread. Waiting for completion w=
ith code ERESTARTSYS\n");=0A=
> +		}=0A=
> +=0A=
> +		if (!defer_io_queue_empty(defer_io->dio_queue)) {=0A=
> +			int dio_copy_result =3D SUCCESS;=0A=
> +			struct blk_deferred_request *dio_copy_req =3D NULL;=0A=
> +=0A=
> +			mutex_lock(&defer_io->snapstore_device->store_block_map_locker);=0A=
> +			do {=0A=
> +				dio_copy_result =3D _defer_io_copy_prepare(=0A=
> +					defer_io, &queue_in_process, &dio_copy_req);=0A=
> +				if (dio_copy_result !=3D SUCCESS) {=0A=
> +					pr_err("Unable to process defer IO request: failed to prepare copy =
request. erro=3D%d\n",=0A=
> +					       dio_copy_result);=0A=
> +					break;=0A=
> +				}=0A=
> +				if (dio_copy_req =3D=3D NULL)=0A=
> +					break; //nothing to copy=0A=
> +=0A=
> +				dio_copy_result =3D blk_deferred_request_read_original(=0A=
> +					defer_io->original_blk_dev, dio_copy_req);=0A=
> +				if (dio_copy_result !=3D SUCCESS) {=0A=
> +					pr_err("Unable to process defer IO request: failed to read data to =
copy request. errno=3D%d\n",=0A=
> +					       dio_copy_result);=0A=
> +					break;=0A=
> +				}=0A=
> +				dio_copy_result =3D snapstore_device_store(defer_io->snapstore_devic=
e,=0A=
> +									 dio_copy_req);=0A=
> +				if (dio_copy_result !=3D SUCCESS) {=0A=
> +					pr_err("Unable to process defer IO request: failed to write data fr=
om copy request. errno=3D%d\n",=0A=
> +					       dio_copy_result);=0A=
> +					break;=0A=
> +				}=0A=
> +=0A=
> +			} while (false);=0A=
> +			_defer_io_finish(defer_io, &queue_in_process);=0A=
> +			mutex_unlock(&defer_io->snapstore_device->store_block_map_locker);=0A=
> +=0A=
> +			if (dio_copy_req) {=0A=
> +				if (dio_copy_result =3D=3D -EDEADLK)=0A=
> +					blk_deferred_request_deadlocked(dio_copy_req);=0A=
> +				else=0A=
> +					blk_deferred_request_free(dio_copy_req);=0A=
> +			}=0A=
> +		}=0A=
> +=0A=
> +		//wake up snapimage if defer io queue empty=0A=
> +		if (defer_io_queue_empty(defer_io->dio_queue))=0A=
> +			wake_up_interruptible(&defer_io->queue_throttle_waiter);=0A=
> +	}=0A=
> +	defer_io_queue_active(&defer_io->dio_queue, false);=0A=
> +=0A=
> +	//waiting for all sent request complete=0A=
> +	_defer_io_finish(defer_io, &defer_io->dio_queue);=0A=
> +=0A=
> +	pr_info("Defer IO thread for original device [%d:%d] completed\n",=0A=
> +		MAJOR(defer_io->original_dev_id), MINOR(defer_io->original_dev_id));=
=0A=
> +	defer_io_put_resource(defer_io);=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +static void _defer_io_destroy(struct defer_io *defer_io)=0A=
> +{=0A=
> +	if (defer_io =3D=3D NULL)=0A=
> +		return;=0A=
> +=0A=
> +	if (defer_io->dio_thread)=0A=
> +		defer_io_stop(defer_io);=0A=
> +=0A=
> +	if (defer_io->snapstore_device)=0A=
> +		snapstore_device_put_resource(defer_io->snapstore_device);=0A=
> +=0A=
> +	kfree(defer_io);=0A=
> +	pr_info("Defer IO processor was destroyed\n");=0A=
> +}=0A=
> +=0A=
> +static void defer_io_destroy_cb(struct kref *kref)=0A=
> +{=0A=
> +	_defer_io_destroy(container_of(kref, struct defer_io, refcount));=0A=
> +}=0A=
> +=0A=
> +struct defer_io *defer_io_get_resource(struct defer_io *defer_io)=0A=
> +{=0A=
> +	if (defer_io)=0A=
> +		kref_get(&defer_io->refcount);=0A=
> +=0A=
> +	return defer_io;=0A=
> +}=0A=
> +=0A=
> +void defer_io_put_resource(struct defer_io *defer_io)=0A=
> +{=0A=
> +	if (defer_io)=0A=
> +		kref_put(&defer_io->refcount, defer_io_destroy_cb);=0A=
> +}=0A=
> +=0A=
> +int defer_io_create(dev_t dev_id, struct block_device *blk_dev, struct d=
efer_io **pp_defer_io)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	struct defer_io *defer_io =3D NULL;=0A=
> +	struct snapstore_device *snapstore_device;=0A=
> +=0A=
> +	pr_info("Defer IO processor was created for device [%d:%d]\n", MAJOR(de=
v_id),=0A=
> +		MINOR(dev_id));=0A=
> +=0A=
> +	defer_io =3D kzalloc(sizeof(struct defer_io), GFP_KERNEL);=0A=
> +	if (defer_io =3D=3D NULL)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	snapstore_device =3D snapstore_device_find_by_dev_id(dev_id);=0A=
> +	if (snapstore_device =3D=3D NULL) {=0A=
> +		pr_err("Unable to create defer IO processor: failed to initialize snap=
shot data for device [%d:%d]\n",=0A=
> +		       MAJOR(dev_id), MINOR(dev_id));=0A=
> +=0A=
> +		kfree(defer_io);=0A=
> +		return -ENODATA;=0A=
> +	}=0A=
> +=0A=
> +	defer_io->snapstore_device =3D snapstore_device_get_resource(snapstore_=
device);=0A=
> +	defer_io->original_dev_id =3D dev_id;=0A=
> +	defer_io->original_blk_dev =3D blk_dev;=0A=
> +=0A=
> +	kref_init(&defer_io->refcount);=0A=
> +=0A=
> +	defer_io_queue_init(&defer_io->dio_queue);=0A=
> +=0A=
> +	init_waitqueue_head(&defer_io->queue_add_event);=0A=
> +=0A=
> +	atomic_set(&defer_io->queue_filling_count, 0);=0A=
> +=0A=
> +	init_waitqueue_head(&defer_io->queue_throttle_waiter);=0A=
> +=0A=
> +	defer_io->dio_thread =3D kthread_create(defer_io_work_thread, (void *)d=
efer_io,=0A=
> +					      "blksnapdeferio%d:%d", MAJOR(dev_id), MINOR(dev_id));=0A=
> +	if (IS_ERR(defer_io->dio_thread)) {=0A=
> +		res =3D PTR_ERR(defer_io->dio_thread);=0A=
> +		pr_err("Unable to create defer IO processor: failed to create thread. =
errno=3D%d\n",=0A=
> +		       res);=0A=
> +=0A=
> +		_defer_io_destroy(defer_io);=0A=
> +		defer_io =3D NULL;=0A=
> +		*pp_defer_io =3D NULL;=0A=
> +=0A=
> +		return res;=0A=
> +	}=0A=
> +=0A=
> +	wake_up_process(defer_io->dio_thread);=0A=
> +=0A=
> +	*pp_defer_io =3D defer_io;=0A=
> +	pr_info("Defer IO processor was created\n");=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +int defer_io_stop(struct defer_io *defer_io)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +=0A=
> +	pr_info("Defer IO thread for the device stopped [%d:%d]\n",=0A=
> +		MAJOR(defer_io->original_dev_id), MINOR(defer_io->original_dev_id));=
=0A=
> +=0A=
> +	if (defer_io->dio_thread !=3D NULL) {=0A=
> +		struct task_struct *dio_thread =3D defer_io->dio_thread;=0A=
> +=0A=
> +		defer_io->dio_thread =3D NULL;=0A=
> +		res =3D kthread_stop(dio_thread); //stopping and waiting.=0A=
> +		if (res !=3D SUCCESS)=0A=
> +			pr_err("Failed to stop defer IO thread. errno=3D%d\n", res);=0A=
> +	}=0A=
> +=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +int defer_io_redirect_bio(struct defer_io *defer_io, struct bio *bio, vo=
id *tracker)=0A=
> +{=0A=
> +	struct defer_io_orig_rq *dio_orig_req;=0A=
> +=0A=
> +	if (snapstore_device_is_corrupted(defer_io->snapstore_device))=0A=
> +		return -ENODATA;=0A=
> +=0A=
> +	dio_orig_req =3D defer_io_queue_new(&defer_io->dio_queue, bio);=0A=
> +	if (dio_orig_req =3D=3D NULL)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	dio_orig_req->tracker =3D (struct tracker *)tracker;=0A=
> +=0A=
> +	if (defer_io_queue_push_back(&defer_io->dio_queue, dio_orig_req) !=3D S=
UCCESS) {=0A=
> +		defer_io_queue_free(dio_orig_req);=0A=
> +		return -EFAULT;=0A=
> +	}=0A=
> +=0A=
> +	atomic_inc(&defer_io->queue_filling_count);=0A=
> +=0A=
> +	wake_up_interruptible(&defer_io->queue_add_event);=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> diff --git a/drivers/block/blk-snap/defer_io.h b/drivers/block/blk-snap/d=
efer_io.h=0A=
> new file mode 100644=0A=
> index 000000000000..27c3bb03241f=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/defer_io.h=0A=
> @@ -0,0 +1,39 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
> +#pragma once=0A=
> +=0A=
> +#include <linux/kref.h>=0A=
> +#include "snapstore_device.h"=0A=
> +=0A=
> +struct defer_io_queue {=0A=
> +	struct list_head list;=0A=
> +	spinlock_t lock;=0A=
> +=0A=
> +	atomic_t active_state;=0A=
> +	atomic_t in_queue_cnt;=0A=
> +};=0A=
> +=0A=
> +struct defer_io {=0A=
> +	struct kref refcount;=0A=
> +=0A=
> +	wait_queue_head_t queue_add_event;=0A=
> +=0A=
> +	atomic_t queue_filling_count;=0A=
> +	wait_queue_head_t queue_throttle_waiter;=0A=
> +=0A=
> +	dev_t original_dev_id;=0A=
> +	struct block_device *original_blk_dev;=0A=
> +=0A=
> +	struct snapstore_device *snapstore_device;=0A=
> +=0A=
> +	struct task_struct *dio_thread;=0A=
> +=0A=
> +	struct defer_io_queue dio_queue;=0A=
> +};=0A=
> +=0A=
> +int defer_io_create(dev_t dev_id, struct block_device *blk_dev, struct d=
efer_io **pp_defer_io);=0A=
> +int defer_io_stop(struct defer_io *defer_io);=0A=
> +=0A=
> +struct defer_io *defer_io_get_resource(struct defer_io *defer_io);=0A=
> +void defer_io_put_resource(struct defer_io *defer_io);=0A=
> +=0A=
> +int defer_io_redirect_bio(struct defer_io *defer_io, struct bio *bio, vo=
id *tracker);=0A=
> diff --git a/drivers/block/blk-snap/main.c b/drivers/block/blk-snap/main.=
c=0A=
> new file mode 100644=0A=
> index 000000000000..d1d4e08a4890=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/main.c=0A=
> @@ -0,0 +1,82 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#include "common.h"=0A=
> +#include "version.h"=0A=
> +#include "blk-snap-ctl.h"=0A=
> +#include "params.h"=0A=
> +#include "ctrl_fops.h"=0A=
> +#include "ctrl_pipe.h"=0A=
> +#include "ctrl_sysfs.h"=0A=
> +#include "snapimage.h"=0A=
> +#include "snapstore.h"=0A=
> +#include "snapstore_device.h"=0A=
> +#include "snapshot.h"=0A=
> +#include "tracker.h"=0A=
> +#include "tracking.h"=0A=
> +#include <linux/module.h>=0A=
> +=0A=
> +int __init blk_snap_init(void)=0A=
> +{=0A=
> +	int result =3D SUCCESS;=0A=
> +=0A=
> +	pr_info("Loading\n");=0A=
> +=0A=
> +	params_check();=0A=
> +=0A=
> +	result =3D ctrl_init();=0A=
> +	if (result !=3D SUCCESS)=0A=
> +		return result;=0A=
> +=0A=
> +	result =3D blk_redirect_bioset_create();=0A=
> +	if (result !=3D SUCCESS)=0A=
> +		return result;=0A=
> +=0A=
> +	result =3D blk_deferred_bioset_create();=0A=
> +	if (result !=3D SUCCESS)=0A=
> +		return result;=0A=
> +=0A=
> +	result =3D snapimage_init();=0A=
> +	if (result !=3D SUCCESS)=0A=
> +		return result;=0A=
> +=0A=
> +	result =3D ctrl_sysfs_init();=0A=
> +	if (result !=3D SUCCESS)=0A=
> +		return result;=0A=
> +=0A=
> +	result =3D tracking_init();=0A=
> +	if (result !=3D SUCCESS)=0A=
> +		return result;=0A=
> +=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
> +void __exit blk_snap_exit(void)=0A=
> +{=0A=
> +	pr_info("Unloading module\n");=0A=
> +=0A=
> +	ctrl_sysfs_done();=0A=
> +=0A=
> +	snapshot_done();=0A=
> +=0A=
> +	snapstore_device_done();=0A=
> +	snapstore_done();=0A=
> +=0A=
> +	tracker_done();=0A=
> +	tracking_done();=0A=
> +=0A=
> +	snapimage_done();=0A=
> +=0A=
> +	blk_deferred_bioset_free();=0A=
> +	blk_deferred_done();=0A=
> +=0A=
> +	blk_redirect_bioset_free();=0A=
> +=0A=
> +	ctrl_done();=0A=
> +}=0A=
> +=0A=
> +module_init(blk_snap_init);=0A=
> +module_exit(blk_snap_exit);=0A=
> +=0A=
> +MODULE_DESCRIPTION("Block Layer Snapshot Kernel Module");=0A=
> +MODULE_VERSION(FILEVER_STR);=0A=
> +MODULE_AUTHOR("Veeam Software Group GmbH");=0A=
> +MODULE_LICENSE("GPL");=0A=
> diff --git a/drivers/block/blk-snap/params.c b/drivers/block/blk-snap/par=
ams.c=0A=
> new file mode 100644=0A=
> index 000000000000..7eba3c8bf395=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/params.c=0A=
> @@ -0,0 +1,58 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#include "common.h"=0A=
> +#include "params.h"=0A=
> +#include <linux/module.h>=0A=
> +=0A=
> +int snapstore_block_size_pow =3D 14;=0A=
> +int change_tracking_block_size_pow =3D 18;=0A=
> +=0A=
> +int get_snapstore_block_size_pow(void)=0A=
> +{=0A=
> +	return snapstore_block_size_pow;=0A=
> +}=0A=
> +=0A=
> +int inc_snapstore_block_size_pow(void)=0A=
> +{=0A=
> +	if (snapstore_block_size_pow > 30)=0A=
> +		return -EFAULT;=0A=
> +=0A=
> +	++snapstore_block_size_pow;=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +int get_change_tracking_block_size_pow(void)=0A=
> +{=0A=
> +	return change_tracking_block_size_pow;=0A=
> +}=0A=
> +=0A=
> +void params_check(void)=0A=
> +{=0A=
> +	pr_info("snapstore_block_size_pow: %d\n", snapstore_block_size_pow);=0A=
> +	pr_info("change_tracking_block_size_pow: %d\n", change_tracking_block_s=
ize_pow);=0A=
> +=0A=
> +	if (snapstore_block_size_pow > 23) {=0A=
> +		snapstore_block_size_pow =3D 23;=0A=
> +		pr_info("Limited snapstore_block_size_pow: %d\n", snapstore_block_size=
_pow);=0A=
> +	} else if (snapstore_block_size_pow < 12) {=0A=
> +		snapstore_block_size_pow =3D 12;=0A=
> +		pr_info("Limited snapstore_block_size_pow: %d\n", snapstore_block_size=
_pow);=0A=
> +	}=0A=
> +=0A=
> +	if (change_tracking_block_size_pow > 23) {=0A=
> +		change_tracking_block_size_pow =3D 23;=0A=
> +		pr_info("Limited change_tracking_block_size_pow: %d\n",=0A=
> +			change_tracking_block_size_pow);=0A=
> +	} else if (change_tracking_block_size_pow < 12) {=0A=
> +		change_tracking_block_size_pow =3D 12;=0A=
> +		pr_info("Limited change_tracking_block_size_pow: %d\n",=0A=
> +			change_tracking_block_size_pow);=0A=
> +	}=0A=
> +}=0A=
> +=0A=
> +module_param_named(snapstore_block_size_pow, snapstore_block_size_pow, i=
nt, 0644);=0A=
> +MODULE_PARM_DESC(snapstore_block_size_pow,=0A=
> +		 "Snapstore block size binary pow. 20 for 1MiB block size");=0A=
> +=0A=
> +module_param_named(change_tracking_block_size_pow, change_tracking_block=
_size_pow, int, 0644);=0A=
> +MODULE_PARM_DESC(change_tracking_block_size_pow,=0A=
> +		 "Change-tracking block size binary pow. 18 for 256 KiB block size");=
=0A=
> diff --git a/drivers/block/blk-snap/params.h b/drivers/block/blk-snap/par=
ams.h=0A=
> new file mode 100644=0A=
> index 000000000000..c1b853a1363b=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/params.h=0A=
> @@ -0,0 +1,29 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
> +#pragma once=0A=
> +=0A=
> +int get_snapstore_block_size_pow(void);=0A=
> +int inc_snapstore_block_size_pow(void);=0A=
> +=0A=
> +static inline sector_t snapstore_block_shift(void)=0A=
> +{=0A=
> +	return get_snapstore_block_size_pow() - SECTOR_SHIFT;=0A=
> +};=0A=
> +=0A=
> +static inline sector_t snapstore_block_size(void)=0A=
> +{=0A=
> +	return 1ull << snapstore_block_shift();=0A=
> +};=0A=
> +=0A=
> +static inline sector_t snapstore_block_mask(void)=0A=
> +{=0A=
> +	return snapstore_block_size() - 1ull;=0A=
> +};=0A=
> +=0A=
> +int get_change_tracking_block_size_pow(void);=0A=
> +=0A=
> +static inline unsigned int change_tracking_block_size(void)=0A=
> +{=0A=
> +	return 1 << get_change_tracking_block_size_pow();=0A=
> +};=0A=
> +=0A=
> +void params_check(void);=0A=
> diff --git a/drivers/block/blk-snap/rangevector.c b/drivers/block/blk-sna=
p/rangevector.c=0A=
> new file mode 100644=0A=
> index 000000000000..49fe4589b6f7=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/rangevector.c=0A=
> @@ -0,0 +1,85 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#include "common.h"=0A=
> +#include "rangevector.h"=0A=
> +=0A=
> +#define SECTION "ranges	"=0A=
> +=0A=
> +static inline sector_t range_node_start(struct blk_range_tree_node *rang=
e_node)=0A=
> +{=0A=
> +	return range_node->range.ofs;=0A=
> +}=0A=
> +=0A=
> +static inline sector_t range_node_last(struct blk_range_tree_node *range=
_node)=0A=
> +{=0A=
> +	return range_node->range.ofs + range_node->range.cnt - 1;=0A=
> +}=0A=
> +=0A=
> +#ifndef INTERVAL_TREE_DEFINE=0A=
> +#pragma message("INTERVAL_TREE_DEFINE is undefined")=0A=
> +#endif=0A=
> +INTERVAL_TREE_DEFINE(struct blk_range_tree_node, _node, sector_t, _subtr=
ee_last,=0A=
> +		     range_node_start, range_node_last, static inline, _blk_range_rb)=
=0A=
> +=0A=
> +void blk_range_rb_insert(struct blk_range_tree_node *node, struct rb_roo=
t_cached *root)=0A=
> +{=0A=
> +	_blk_range_rb_insert(node, root);=0A=
> +}=0A=
> +=0A=
> +void blk_range_rb_remove(struct blk_range_tree_node *node, struct rb_roo=
t_cached *root)=0A=
> +{=0A=
> +	_blk_range_rb_remove(node, root);=0A=
> +}=0A=
> +=0A=
> +struct blk_range_tree_node *blk_range_rb_iter_first(struct rb_root_cache=
d *root, sector_t start,=0A=
> +						    sector_t last)=0A=
> +{=0A=
> +	return _blk_range_rb_iter_first(root, start, last);=0A=
> +}=0A=
> +=0A=
> +struct blk_range_tree_node *blk_range_rb_iter_next(struct blk_range_tree=
_node *node, sector_t start,=0A=
> +						   sector_t last)=0A=
> +{=0A=
> +	return _blk_range_rb_iter_next(node, start, last);=0A=
> +}=0A=
> +=0A=
> +void rangevector_init(struct rangevector *rangevector)=0A=
> +{=0A=
> +	init_rwsem(&rangevector->lock);=0A=
> +=0A=
> +	rangevector->root =3D RB_ROOT_CACHED;=0A=
> +}=0A=
> +=0A=
> +void rangevector_done(struct rangevector *rangevector)=0A=
> +{=0A=
> +	struct rb_node *rb_node =3D NULL;=0A=
> +=0A=
> +	down_write(&rangevector->lock);=0A=
> +	rb_node =3D rb_first_cached(&rangevector->root);=0A=
> +	while (rb_node) {=0A=
> +		struct blk_range_tree_node *range_node =3D (struct blk_range_tree_node=
 *)=0A=
> +			rb_node; //container_of(rb_node, struct blk_range_tree_node, node);=
=0A=
> +=0A=
> +		blk_range_rb_remove(range_node, &rangevector->root);=0A=
> +		kfree(range_node);=0A=
> +=0A=
> +		rb_node =3D rb_first_cached(&rangevector->root);=0A=
> +	}=0A=
> +	up_write(&rangevector->lock);=0A=
> +}=0A=
> +=0A=
> +int rangevector_add(struct rangevector *rangevector, struct blk_range *r=
g)=0A=
> +{=0A=
> +	struct blk_range_tree_node *range_node;=0A=
> +=0A=
> +	range_node =3D kzalloc(sizeof(struct blk_range_tree_node), GFP_KERNEL);=
=0A=
> +	if (range_node)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	range_node->range =3D *rg;=0A=
> +=0A=
> +	down_write(&rangevector->lock);=0A=
> +	blk_range_rb_insert(range_node, &rangevector->root);=0A=
> +	up_write(&rangevector->lock);=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> diff --git a/drivers/block/blk-snap/rangevector.h b/drivers/block/blk-sna=
p/rangevector.h=0A=
> new file mode 100644=0A=
> index 000000000000..5ff439423178=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/rangevector.h=0A=
> @@ -0,0 +1,31 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
> +#pragma once=0A=
> +=0A=
> +#include <linux/interval_tree_generic.h>=0A=
> +=0A=
> +struct blk_range_tree_node {=0A=
> +	struct rb_node _node;=0A=
> +	struct blk_range range;=0A=
> +	sector_t _subtree_last;=0A=
> +};=0A=
> +=0A=
> +void blk_range_rb_insert(struct blk_range_tree_node *node, struct rb_roo=
t_cached *root);=0A=
> +=0A=
> +void blk_range_rb_remove(struct blk_range_tree_node *node, struct rb_roo=
t_cached *root);=0A=
> +=0A=
> +struct blk_range_tree_node *blk_range_rb_iter_first(struct rb_root_cache=
d *root, sector_t start,=0A=
> +						    sector_t last);=0A=
> +=0A=
> +struct blk_range_tree_node *blk_range_rb_iter_next(struct blk_range_tree=
_node *node, sector_t start,=0A=
> +						   sector_t last);=0A=
> +=0A=
> +struct rangevector {=0A=
> +	struct rb_root_cached root;=0A=
> +	struct rw_semaphore lock;=0A=
> +};=0A=
> +=0A=
> +void rangevector_init(struct rangevector *rangevector);=0A=
> +=0A=
> +void rangevector_done(struct rangevector *rangevector);=0A=
> +=0A=
> +int rangevector_add(struct rangevector *rangevector, struct blk_range *r=
g);=0A=
> diff --git a/drivers/block/blk-snap/snapimage.c b/drivers/block/blk-snap/=
snapimage.c=0A=
> new file mode 100644=0A=
> index 000000000000..da971486cbef=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/snapimage.c=0A=
> @@ -0,0 +1,982 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#define BLK_SNAP_SECTION "-snapimage"=0A=
> +#include "common.h"=0A=
> +#include "snapimage.h"=0A=
> +#include "blk_util.h"=0A=
> +#include "defer_io.h"=0A=
> +#include "cbt_map.h"=0A=
> +#include "tracker.h"=0A=
> +=0A=
> +#include <asm/div64.h>=0A=
> +#include <linux/cdrom.h>=0A=
> +#include <linux/blk-mq.h>=0A=
> +#include <linux/hdreg.h>=0A=
> +#include <linux/kthread.h>=0A=
> +=0A=
> +#define SNAPIMAGE_MAX_DEVICES 2048=0A=
> +=0A=
> +int snapimage_major;=0A=
> +unsigned long *snapimage_minors;=0A=
> +DEFINE_SPINLOCK(snapimage_minors_lock);=0A=
> +=0A=
> +LIST_HEAD(snap_images);=0A=
> +DECLARE_RWSEM(snap_images_lock);=0A=
> +=0A=
> +DECLARE_RWSEM(snap_image_destroy_lock);=0A=
> +=0A=
> +struct snapimage {=0A=
> +	struct list_head link;=0A=
> +=0A=
> +	sector_t capacity;=0A=
> +	dev_t original_dev;=0A=
> +=0A=
> +	struct defer_io *defer_io;=0A=
> +	struct cbt_map *cbt_map;=0A=
> +=0A=
> +	dev_t image_dev;=0A=
> +=0A=
> +	struct request_queue *queue;=0A=
> +	struct gendisk *disk;=0A=
> +=0A=
> +	atomic_t own_cnt;=0A=
> +=0A=
> +	struct redirect_bio_queue image_queue;=0A=
> +=0A=
> +	struct task_struct *rq_processor;=0A=
> +=0A=
> +	wait_queue_head_t rq_proc_event;=0A=
> +	wait_queue_head_t rq_complete_event;=0A=
> +=0A=
> +	struct mutex open_locker;=0A=
> +	struct block_device *open_bdev;=0A=
> +=0A=
> +	size_t open_cnt;=0A=
> +};=0A=
> +=0A=
> +int _snapimage_open(struct block_device *bdev, fmode_t mode)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +=0A=
> +	if (bdev->bd_disk =3D=3D NULL) {=0A=
> +		pr_err("Unable to open snapshot image: bd_disk is NULL. Device [%d:%d]=
\n",=0A=
> +		       MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));=0A=
> +		pr_err("Block device object %p\n", bdev);=0A=
> +		return -ENODEV;=0A=
> +	}=0A=
> +=0A=
> +	down_read(&snap_image_destroy_lock);=0A=
> +	do {=0A=
> +		struct snapimage *image =3D bdev->bd_disk->private_data;=0A=
> +=0A=
> +		if (image =3D=3D NULL) {=0A=
> +			pr_err("Unable to open snapshot image: private data is not initialize=
d. Block device object %p\n",=0A=
> +			       bdev);=0A=
> +			res =3D -ENODEV;=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		mutex_lock(&image->open_locker);=0A=
> +		{=0A=
> +			if (image->open_cnt =3D=3D 0)=0A=
> +				image->open_bdev =3D bdev;=0A=
> +=0A=
> +			image->open_cnt++;=0A=
> +		}=0A=
> +		mutex_unlock(&image->open_locker);=0A=
> +	} while (false);=0A=
> +	up_read(&snap_image_destroy_lock);=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +static inline uint64_t do_div_inline(uint64_t division, uint32_t divisor=
)=0A=
> +{=0A=
> +	do_div(division, divisor);=0A=
> +	return division;=0A=
> +}=0A=
> +=0A=
> +int _snapimage_getgeo(struct block_device *bdev, struct hd_geometry *geo=
)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	sector_t quotient;=0A=
> +=0A=
> +	down_read(&snap_image_destroy_lock);=0A=
> +	do {=0A=
> +		struct snapimage *image =3D bdev->bd_disk->private_data;=0A=
> +=0A=
> +		if (image =3D=3D NULL) {=0A=
> +			pr_err("Unable to open snapshot image: private data is not initialize=
d. Block device object %p\n",=0A=
> +			       bdev);=0A=
> +			res =3D -ENODEV;=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		pr_info("Getting geo for snapshot image device [%d:%d]\n", MAJOR(image=
->image_dev),=0A=
> +			MINOR(image->image_dev));=0A=
> +=0A=
> +		geo->start =3D 0;=0A=
> +		if (image->capacity > 63) {=0A=
> +			geo->sectors =3D 63;=0A=
> +			quotient =3D do_div_inline(image->capacity + (63 - 1), 63);=0A=
> +=0A=
> +			if (quotient > 255ULL) {=0A=
> +				geo->heads =3D 255;=0A=
> +				geo->cylinders =3D=0A=
> +					(unsigned short)do_div_inline(quotient + (255 - 1), 255);=0A=
> +			} else {=0A=
> +				geo->heads =3D (unsigned char)quotient;=0A=
> +				geo->cylinders =3D 1;=0A=
> +			}=0A=
> +		} else {=0A=
> +			geo->sectors =3D (unsigned char)image->capacity;=0A=
> +			geo->cylinders =3D 1;=0A=
> +			geo->heads =3D 1;=0A=
> +		}=0A=
> +=0A=
> +		pr_info("Image device geo: capacity=3D%lld, heads=3D%d, cylinders=3D%d=
, sectors=3D%d\n",=0A=
> +			image->capacity, geo->heads, geo->cylinders, geo->sectors);=0A=
> +	} while (false);=0A=
> +	up_read(&snap_image_destroy_lock);=0A=
> +=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +void _snapimage_close(struct gendisk *disk, fmode_t mode)=0A=
> +{=0A=
> +	if (disk->private_data !=3D NULL) {=0A=
> +		down_read(&snap_image_destroy_lock);=0A=
> +		do {=0A=
> +			struct snapimage *image =3D disk->private_data;=0A=
> +=0A=
> +			mutex_lock(&image->open_locker);=0A=
> +			{=0A=
> +				if (image->open_cnt > 0)=0A=
> +					image->open_cnt--;=0A=
> +=0A=
> +				if (image->open_cnt =3D=3D 0)=0A=
> +					image->open_bdev =3D NULL;=0A=
> +			}=0A=
> +			mutex_unlock(&image->open_locker);=0A=
> +		} while (false);=0A=
> +		up_read(&snap_image_destroy_lock);=0A=
> +	} else=0A=
> +		pr_err("Unable to close snapshot image: private data is not initialize=
d\n");=0A=
> +}=0A=
> +=0A=
> +int _snapimage_ioctl(struct block_device *bdev, fmode_t mode, unsigned i=
nt cmd, unsigned long arg)=0A=
> +{=0A=
> +	int res =3D -ENOTTY;=0A=
> +=0A=
> +	down_read(&snap_image_destroy_lock);=0A=
> +	{=0A=
> +		struct snapimage *image =3D bdev->bd_disk->private_data;=0A=
> +=0A=
> +		switch (cmd) {=0A=
> +			/*=0A=
> +			 * The only command we need to interpret is HDIO_GETGEO, since=0A=
> +			 * we can't partition the drive otherwise.  We have no real=0A=
> +			 * geometry, of course, so make something up.=0A=
> +			 */=0A=
> +		case HDIO_GETGEO: {=0A=
> +			unsigned long len;=0A=
> +			struct hd_geometry geo;=0A=
> +=0A=
> +			res =3D _snapimage_getgeo(bdev, &geo);=0A=
> +=0A=
> +			len =3D copy_to_user((void *)arg, &geo, sizeof(geo));=0A=
> +			if (len !=3D 0)=0A=
> +				res =3D -EFAULT;=0A=
> +			else=0A=
> +				res =3D SUCCESS;=0A=
> +		} break;=0A=
> +		case CDROM_GET_CAPABILITY: //0x5331  / * get capabilities * /=0A=
> +		{=0A=
> +			struct gendisk *disk =3D bdev->bd_disk;=0A=
> +=0A=
> +			if (bdev->bd_disk && (disk->flags & GENHD_FL_CD))=0A=
> +				res =3D SUCCESS;=0A=
> +			else=0A=
> +				res =3D -EINVAL;=0A=
> +		} break;=0A=
> +=0A=
> +		default:=0A=
> +			pr_info("Snapshot image ioctl receive unsupported command\n");=0A=
> +			pr_info("Device [%d:%d], command 0x%x, arg 0x%lx\n",=0A=
> +				MAJOR(image->image_dev), MINOR(image->image_dev), cmd, arg);=0A=
> +=0A=
> +			res =3D -ENOTTY; /* unknown command */=0A=
> +		}=0A=
> +	}=0A=
> +	up_read(&snap_image_destroy_lock);=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +blk_qc_t _snapimage_submit_bio(struct bio *bio);=0A=
> +=0A=
> +const struct block_device_operations snapimage_ops =3D {=0A=
> +	.owner =3D THIS_MODULE,=0A=
> +	.submit_bio =3D _snapimage_submit_bio,=0A=
> +	.open =3D _snapimage_open,=0A=
> +	.ioctl =3D _snapimage_ioctl,=0A=
> +	.release =3D _snapimage_close,=0A=
> +};=0A=
> +=0A=
> +static inline int _snapimage_request_read(struct snapimage *image,=0A=
> +					  struct blk_redirect_bio *rq_redir)=0A=
> +{=0A=
> +	struct snapstore_device *snapstore_device =3D image->defer_io->snapstor=
e_device;=0A=
> +=0A=
> +	return snapstore_device_read(snapstore_device, rq_redir);=0A=
> +}=0A=
> +=0A=
> +int _snapimage_request_write(struct snapimage *image, struct blk_redirec=
t_bio *rq_redir)=0A=
> +{=0A=
> +	struct snapstore_device *snapstore_device;=0A=
> +	struct cbt_map *cbt_map;=0A=
> +	int res =3D SUCCESS;=0A=
> +=0A=
> +	if (unlikely((image->defer_io =3D=3D NULL) || (image->cbt_map =3D=3D NU=
LL))) {=0A=
> +		pr_err("Invalid snapshot image structure");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +=0A=
> +	snapstore_device =3D image->defer_io->snapstore_device;=0A=
> +	cbt_map =3D image->cbt_map;=0A=
> +=0A=
> +	if (snapstore_device_is_corrupted(snapstore_device))=0A=
> +		return -ENODATA;=0A=
> +=0A=
> +	if (!bio_has_data(rq_redir->bio)) {=0A=
> +		pr_warn("Snapshot image receive empty block IO. flags=3D%u\n",=0A=
> +			rq_redir->bio->bi_flags);=0A=
> +=0A=
> +		blk_redirect_complete(rq_redir, SUCCESS);=0A=
> +		return SUCCESS;=0A=
> +	}=0A=
> +=0A=
> +	if (cbt_map !=3D NULL) {=0A=
> +		sector_t ofs =3D rq_redir->bio->bi_iter.bi_sector;=0A=
> +		sector_t cnt =3D bio_sectors(rq_redir->bio);=0A=
> +=0A=
> +		res =3D cbt_map_set_both(cbt_map, ofs, cnt);=0A=
> +		if (res !=3D SUCCESS)=0A=
> +			pr_err("Unable to write data to snapshot image: failed to set CBT map=
. errno=3D%d\n",=0A=
> +			       res);=0A=
> +	}=0A=
> +=0A=
> +	res =3D snapstore_device_write(snapstore_device, rq_redir);=0A=
> +=0A=
> +	if (res !=3D SUCCESS) {=0A=
> +		pr_err("Failed to write data to snapshot image\n");=0A=
> +		return res;=0A=
> +	}=0A=
> +=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +void _snapimage_processing(struct snapimage *image)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	struct blk_redirect_bio *rq_redir;=0A=
> +=0A=
> +	rq_redir =3D redirect_bio_queue_get_first(&image->image_queue);=0A=
> +=0A=
> +	if (bio_data_dir(rq_redir->bio) =3D=3D READ) {=0A=
> +		res =3D _snapimage_request_read(image, rq_redir);=0A=
> +		if (res !=3D SUCCESS)=0A=
> +			pr_err("Failed to read data from snapshot image. errno=3D%d\n", res);=
=0A=
> +=0A=
> +	} else {=0A=
> +		res =3D _snapimage_request_write(image, rq_redir);=0A=
> +		if (res !=3D SUCCESS)=0A=
> +			pr_err("Failed to write data to snapshot image. errno=3D%d\n", res);=
=0A=
> +	}=0A=
> +=0A=
> +	if (res !=3D SUCCESS)=0A=
> +		blk_redirect_complete(rq_redir, res);=0A=
> +}=0A=
> +=0A=
> +int snapimage_processor_waiting(struct snapimage *image)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +=0A=
> +	if (redirect_bio_queue_empty(image->image_queue)) {=0A=
> +		res =3D wait_event_interruptible_timeout(=0A=
> +			image->rq_proc_event,=0A=
> +			(!redirect_bio_queue_empty(image->image_queue) || kthread_should_stop=
()),=0A=
> +			5 * HZ);=0A=
> +		if (res > 0)=0A=
> +			res =3D SUCCESS;=0A=
> +		else if (res =3D=3D 0)=0A=
> +			res =3D -ETIME;=0A=
> +	}=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +int snapimage_processor_thread(void *data)=0A=
> +{=0A=
> +	struct snapimage *image =3D data;=0A=
> +=0A=
> +	pr_info("Snapshot image thread for device [%d:%d] start\n", MAJOR(image=
->image_dev),=0A=
> +		MINOR(image->image_dev));=0A=
> +=0A=
> +	add_disk(image->disk);=0A=
> +=0A=
> +	//priority=0A=
> +	set_user_nice(current, -20); //MIN_NICE=0A=
> +=0A=
> +	while (!kthread_should_stop()) {=0A=
> +		int res =3D snapimage_processor_waiting(image);=0A=
> +=0A=
> +		if (res =3D=3D SUCCESS) {=0A=
> +			if (!redirect_bio_queue_empty(image->image_queue))=0A=
> +				_snapimage_processing(image);=0A=
> +		} else if (res !=3D -ETIME) {=0A=
> +			pr_err("Failed to wait snapshot image thread queue. errno=3D%d\n", re=
s);=0A=
> +			return res;=0A=
> +		}=0A=
> +		schedule();=0A=
> +	}=0A=
> +	pr_info("Snapshot image disk delete\n");=0A=
> +	del_gendisk(image->disk);=0A=
> +=0A=
> +	while (!redirect_bio_queue_empty(image->image_queue))=0A=
> +		_snapimage_processing(image);=0A=
> +=0A=
> +	pr_info("Snapshot image thread for device [%d:%d] complete", MAJOR(imag=
e->image_dev),=0A=
> +		MINOR(image->image_dev));=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +static inline void _snapimage_bio_complete(struct bio *bio, int err)=0A=
> +{=0A=
> +	if (err =3D=3D SUCCESS)=0A=
> +		bio->bi_status =3D BLK_STS_OK;=0A=
> +	else=0A=
> +		bio->bi_status =3D BLK_STS_IOERR;=0A=
> +=0A=
> +	bio_endio(bio);=0A=
> +}=0A=
> +=0A=
> +void _snapimage_bio_complete_cb(void *complete_param, struct bio *bio, i=
nt err)=0A=
> +{=0A=
> +	struct snapimage *image =3D (struct snapimage *)complete_param;=0A=
> +=0A=
> +	_snapimage_bio_complete(bio, err);=0A=
> +=0A=
> +	if (redirect_bio_queue_unactive(image->image_queue))=0A=
> +		wake_up_interruptible(&image->rq_complete_event);=0A=
> +=0A=
> +	atomic_dec(&image->own_cnt);=0A=
> +}=0A=
> +=0A=
> +int _snapimage_throttling(struct defer_io *defer_io)=0A=
> +{=0A=
> +	return wait_event_interruptible(defer_io->queue_throttle_waiter,=0A=
> +					redirect_bio_queue_empty(defer_io->dio_queue));=0A=
> +}=0A=
> +=0A=
> +blk_qc_t _snapimage_submit_bio(struct bio *bio)=0A=
> +{=0A=
> +	blk_qc_t result =3D SUCCESS;=0A=
> +	struct request_queue *q =3D bio->bi_disk->queue;=0A=
> +	struct snapimage *image =3D q->queuedata;=0A=
> +=0A=
> +	if (unlikely(blk_mq_queue_stopped(q))) {=0A=
> +		pr_info("Failed to make snapshot image request. Queue already is not a=
ctive.");=0A=
> +		pr_info("Queue flags=3D%lx\n", q->queue_flags);=0A=
> +=0A=
> +		_snapimage_bio_complete(bio, -ENODEV);=0A=
> +=0A=
> +		return result;=0A=
> +	}=0A=
> +=0A=
> +	atomic_inc(&image->own_cnt);=0A=
> +	do {=0A=
> +		int res;=0A=
> +		struct blk_redirect_bio *rq_redir;=0A=
> +=0A=
> +		if (false =3D=3D atomic_read(&(image->image_queue.active_state))) {=0A=
> +			_snapimage_bio_complete(bio, -ENODEV);=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		if (snapstore_device_is_corrupted(image->defer_io->snapstore_device)) =
{=0A=
> +			_snapimage_bio_complete(bio, -ENODATA);=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		res =3D _snapimage_throttling(image->defer_io);=0A=
> +		if (res !=3D SUCCESS) {=0A=
> +			pr_err("Failed to throttle snapshot image device. errno=3D%d\n", res)=
;=0A=
> +			_snapimage_bio_complete(bio, res);=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		rq_redir =3D redirect_bio_queue_new(&image->image_queue);=0A=
> +		if (rq_redir =3D=3D NULL) {=0A=
> +			pr_err("Unable to make snapshot image request: failed to allocate red=
irect bio structure\n");=0A=
> +			_snapimage_bio_complete(bio, -ENOMEM);=0A=
> +			break;=0A=
> +		}=0A=
> +		rq_redir->bio =3D bio;=0A=
> +		rq_redir->complete_cb =3D _snapimage_bio_complete_cb;=0A=
> +		rq_redir->complete_param =3D (void *)image;=0A=
> +		atomic_inc(&image->own_cnt);=0A=
> +=0A=
> +		res =3D redirect_bio_queue_push_back(&image->image_queue, rq_redir);=
=0A=
> +		if (res =3D=3D SUCCESS)=0A=
> +			wake_up(&image->rq_proc_event);=0A=
> +		else {=0A=
> +			redirect_bio_queue_free(rq_redir);=0A=
> +			_snapimage_bio_complete(bio, -EIO);=0A=
> +=0A=
> +			if (redirect_bio_queue_unactive(image->image_queue))=0A=
> +				wake_up_interruptible(&image->rq_complete_event);=0A=
> +		}=0A=
> +=0A=
> +	} while (false);=0A=
> +	atomic_dec(&image->own_cnt);=0A=
> +=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
> +struct blk_dev_info {=0A=
> +	size_t blk_size;=0A=
> +	sector_t start_sect;=0A=
> +	sector_t count_sect;=0A=
> +=0A=
> +	unsigned int io_min;=0A=
> +	unsigned int physical_block_size;=0A=
> +	unsigned short logical_block_size;=0A=
> +};=0A=
> +=0A=
> +static int _blk_dev_get_info(struct block_device *blk_dev, struct blk_de=
v_info *pdev_info)=0A=
> +{=0A=
> +	sector_t SectorStart;=0A=
> +	sector_t SectorsCapacity;=0A=
> +=0A=
> +	if (blk_dev->bd_part)=0A=
> +		SectorsCapacity =3D blk_dev->bd_part->nr_sects;=0A=
> +	else if (blk_dev->bd_disk)=0A=
> +		SectorsCapacity =3D get_capacity(blk_dev->bd_disk);=0A=
> +	else=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	SectorStart =3D get_start_sect(blk_dev);=0A=
> +=0A=
> +	pdev_info->physical_block_size =3D blk_dev->bd_disk->queue->limits.phys=
ical_block_size;=0A=
> +	pdev_info->logical_block_size =3D blk_dev->bd_disk->queue->limits.logic=
al_block_size;=0A=
> +	pdev_info->io_min =3D blk_dev->bd_disk->queue->limits.io_min;=0A=
> +=0A=
> +	pdev_info->blk_size =3D block_size(blk_dev);=0A=
> +	pdev_info->start_sect =3D SectorStart;=0A=
> +	pdev_info->count_sect =3D SectorsCapacity;=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +static int blk_dev_get_info(dev_t dev_id, struct blk_dev_info *pdev_info=
)=0A=
> +{=0A=
> +	int result =3D SUCCESS;=0A=
> +	struct block_device *blk_dev;=0A=
> +=0A=
> +	result =3D blk_dev_open(dev_id, &blk_dev);=0A=
> +	if (result !=3D SUCCESS) {=0A=
> +		pr_err("Failed to open device [%d:%d]\n", MAJOR(dev_id), MINOR(dev_id)=
);=0A=
> +		return result;=0A=
> +	}=0A=
> +=0A=
> +	result =3D _blk_dev_get_info(blk_dev, pdev_info);=0A=
> +	if (result !=3D SUCCESS)=0A=
> +		pr_err("Failed to identify block device [%d:%d]\n", MAJOR(dev_id), MIN=
OR(dev_id));=0A=
> +=0A=
> +	blk_dev_close(blk_dev);=0A=
> +=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
> +static inline void _snapimage_free(struct snapimage *image)=0A=
> +{=0A=
> +	defer_io_put_resource(image->defer_io);=0A=
> +	cbt_map_put_resource(image->cbt_map);=0A=
> +	image->defer_io =3D NULL;=0A=
> +}=0A=
> +=0A=
> +static void _snapimage_stop(struct snapimage *image)=0A=
> +{=0A=
> +	if (image->rq_processor !=3D NULL) {=0A=
> +		if (redirect_bio_queue_active(&image->image_queue, false)) {=0A=
> +			struct request_queue *q =3D image->queue;=0A=
> +=0A=
> +			pr_info("Snapshot image request processing stop\n");=0A=
> +=0A=
> +			if (!blk_queue_stopped(q)) {=0A=
> +				blk_sync_queue(q);=0A=
> +				blk_mq_stop_hw_queues(q);=0A=
> +			}=0A=
> +		}=0A=
> +=0A=
> +		pr_info("Snapshot image thread stop\n");=0A=
> +		kthread_stop(image->rq_processor);=0A=
> +		image->rq_processor =3D NULL;=0A=
> +=0A=
> +		while (!redirect_bio_queue_unactive(image->image_queue))=0A=
> +			wait_event_interruptible(image->rq_complete_event,=0A=
> +						 redirect_bio_queue_unactive(image->image_queue));=0A=
> +	}=0A=
> +}=0A=
> +=0A=
> +static void _snapimage_destroy(struct snapimage *image)=0A=
> +{=0A=
> +	if (image->rq_processor !=3D NULL)=0A=
> +		_snapimage_stop(image);=0A=
> +=0A=
> +	if (image->queue) {=0A=
> +		pr_info("Snapshot image queue cleanup\n");=0A=
> +		blk_cleanup_queue(image->queue);=0A=
> +		image->queue =3D NULL;=0A=
> +	}=0A=
> +=0A=
> +	if (image->disk !=3D NULL) {=0A=
> +		struct gendisk *disk;=0A=
> +=0A=
> +		disk =3D image->disk;=0A=
> +		image->disk =3D NULL;=0A=
> +=0A=
> +		pr_info("Snapshot image disk structure release\n");=0A=
> +=0A=
> +		disk->private_data =3D NULL;=0A=
> +		put_disk(disk);=0A=
> +	}=0A=
> +=0A=
> +	spin_lock(&snapimage_minors_lock);=0A=
> +	bitmap_clear(snapimage_minors, MINOR(image->image_dev), 1u);=0A=
> +	spin_unlock(&snapimage_minors_lock);=0A=
> +}=0A=
> +=0A=
> +int snapimage_create(dev_t original_dev)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	struct tracker *tracker =3D NULL;=0A=
> +	struct snapimage *image =3D NULL;=0A=
> +	struct gendisk *disk =3D NULL;=0A=
> +	int minor;=0A=
> +	struct blk_dev_info original_dev_info;=0A=
> +=0A=
> +	pr_info("Create snapshot image for device [%d:%d]\n", MAJOR(original_de=
v),=0A=
> +		MINOR(original_dev));=0A=
> +=0A=
> +	res =3D blk_dev_get_info(original_dev, &original_dev_info);=0A=
> +	if (res !=3D SUCCESS) {=0A=
> +		pr_err("Failed to obtain original device info\n");=0A=
> +		return res;=0A=
> +	}=0A=
> +=0A=
> +	res =3D tracker_find_by_dev_id(original_dev, &tracker);=0A=
> +	if (res !=3D SUCCESS) {=0A=
> +		pr_err("Unable to create snapshot image: cannot find tracker for devic=
e [%d:%d]\n",=0A=
> +		       MAJOR(original_dev), MINOR(original_dev));=0A=
> +		return res;=0A=
> +	}=0A=
> +=0A=
> +	image =3D kzalloc(sizeof(struct snapimage), GFP_KERNEL);=0A=
> +	if (image =3D=3D NULL)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	INIT_LIST_HEAD(&image->link);=0A=
> +=0A=
> +	do {=0A=
> +		spin_lock(&snapimage_minors_lock);=0A=
> +		minor =3D bitmap_find_free_region(snapimage_minors, SNAPIMAGE_MAX_DEVI=
CES, 0);=0A=
> +		spin_unlock(&snapimage_minors_lock);=0A=
> +=0A=
> +		if (minor < SUCCESS) {=0A=
> +			pr_err("Failed to allocate minor for snapshot image device. errno=3D%=
d\n",=0A=
> +			       0 - minor);=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		image->rq_processor =3D NULL;=0A=
> +=0A=
> +		image->capacity =3D original_dev_info.count_sect;=0A=
> +=0A=
> +		image->defer_io =3D defer_io_get_resource(tracker->defer_io);=0A=
> +		image->cbt_map =3D cbt_map_get_resource(tracker->cbt_map);=0A=
> +		image->original_dev =3D original_dev;=0A=
> +=0A=
> +		image->image_dev =3D MKDEV(snapimage_major, minor);=0A=
> +		pr_info("Snapshot image device id [%d:%d]\n", MAJOR(image->image_dev),=
=0A=
> +			MINOR(image->image_dev));=0A=
> +=0A=
> +		atomic_set(&image->own_cnt, 0);=0A=
> +=0A=
> +		mutex_init(&image->open_locker);=0A=
> +		image->open_bdev =3D NULL;=0A=
> +		image->open_cnt =3D 0;=0A=
> +=0A=
> +		image->queue =3D blk_alloc_queue(NUMA_NO_NODE);=0A=
> +		if (image->queue =3D=3D NULL) {=0A=
> +			res =3D -ENOMEM;=0A=
> +			break;=0A=
> +		}=0A=
> +		image->queue->queuedata =3D image;=0A=
> +=0A=
> +		blk_queue_max_segment_size(image->queue, 1024 * PAGE_SIZE);=0A=
> +=0A=
> +		{=0A=
> +			unsigned int physical_block_size =3D original_dev_info.physical_block=
_size;=0A=
> +			unsigned short logical_block_size =3D original_dev_info.logical_block=
_size;=0A=
> +=0A=
> +			pr_info("Snapshot image physical block size %d\n", physical_block_siz=
e);=0A=
> +			pr_info("Snapshot image logical block size %d\n", logical_block_size)=
;=0A=
> +=0A=
> +			blk_queue_physical_block_size(image->queue, physical_block_size);=0A=
> +			blk_queue_logical_block_size(image->queue, logical_block_size);=0A=
> +		}=0A=
> +		disk =3D alloc_disk(1); //only one partition on disk=0A=
> +		if (disk =3D=3D NULL) {=0A=
> +			pr_err("Failed to allocate disk for snapshot image device\n");=0A=
> +			res =3D -ENOMEM;=0A=
> +			break;=0A=
> +		}=0A=
> +		image->disk =3D disk;=0A=
> +=0A=
> +		if (snprintf(disk->disk_name, DISK_NAME_LEN, "%s%d", SNAP_IMAGE_NAME, =
minor) < 0) {=0A=
> +			pr_err("Unable to set disk name for snapshot image device: invalid mi=
nor %d\n",=0A=
> +			       minor);=0A=
> +			res =3D -EINVAL;=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		pr_info("Snapshot image disk name [%s]", disk->disk_name);=0A=
> +=0A=
> +		disk->flags |=3D GENHD_FL_NO_PART_SCAN;=0A=
> +		disk->flags |=3D GENHD_FL_REMOVABLE;=0A=
> +=0A=
> +		disk->major =3D snapimage_major;=0A=
> +		disk->minors =3D 1; // one disk have only one partition.=0A=
> +		disk->first_minor =3D minor;=0A=
> +=0A=
> +		disk->private_data =3D image;=0A=
> +=0A=
> +		disk->fops =3D &snapimage_ops;=0A=
> +		disk->queue =3D image->queue;=0A=
> +=0A=
> +		set_capacity(disk, image->capacity);=0A=
> +		pr_info("Snapshot image device capacity %lld bytes",=0A=
> +			(u64)from_sectors(image->capacity));=0A=
> +=0A=
> +		//res =3D -ENOMEM;=0A=
> +		redirect_bio_queue_init(&image->image_queue);=0A=
> +=0A=
> +		{=0A=
> +			struct task_struct *task =3D=0A=
> +				kthread_create(snapimage_processor_thread, image, disk->disk_name);=
=0A=
> +			if (IS_ERR(task)) {=0A=
> +				res =3D PTR_ERR(task);=0A=
> +				pr_err("Failed to create request processing thread for snapshot imag=
e device. errno=3D%d\n",=0A=
> +				       res);=0A=
> +				break;=0A=
> +			}=0A=
> +			image->rq_processor =3D task;=0A=
> +		}=0A=
> +		init_waitqueue_head(&image->rq_complete_event);=0A=
> +=0A=
> +		init_waitqueue_head(&image->rq_proc_event);=0A=
> +		wake_up_process(image->rq_processor);=0A=
> +	} while (false);=0A=
> +=0A=
> +	if (res =3D=3D SUCCESS) {=0A=
> +		down_write(&snap_images_lock);=0A=
> +		list_add_tail(&image->link, &snap_images);=0A=
> +		up_write(&snap_images_lock);=0A=
> +	} else {=0A=
> +		_snapimage_destroy(image);=0A=
> +		_snapimage_free(image);=0A=
> +=0A=
> +		kfree(image);=0A=
> +		image =3D NULL;=0A=
> +	}=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +static struct snapimage *snapimage_find(dev_t original_dev)=0A=
> +{=0A=
> +	struct snapimage *image =3D NULL;=0A=
> +=0A=
> +	down_read(&snap_images_lock);=0A=
> +	if (!list_empty(&snap_images)) {=0A=
> +		struct list_head *_list_head;=0A=
> +=0A=
> +		list_for_each(_list_head, &snap_images) {=0A=
> +			struct snapimage *_image =3D list_entry(_list_head, struct snapimage,=
 link);=0A=
> +=0A=
> +			if (_image->original_dev =3D=3D original_dev) {=0A=
> +				image =3D _image;=0A=
> +				break;=0A=
> +			}=0A=
> +		}=0A=
> +	}=0A=
> +	up_read(&snap_images_lock);=0A=
> +=0A=
> +	return image;=0A=
> +}=0A=
> +=0A=
> +void snapimage_stop(dev_t original_dev)=0A=
> +{=0A=
> +	struct snapimage *image;=0A=
> +=0A=
> +	pr_info("Snapshot image processing stop for original device [%d:%d]\n",=
 MAJOR(original_dev),=0A=
> +		MINOR(original_dev));=0A=
> +=0A=
> +	down_read(&snap_image_destroy_lock);=0A=
> +=0A=
> +	image =3D snapimage_find(original_dev);=0A=
> +	if (image !=3D NULL)=0A=
> +		_snapimage_stop(image);=0A=
> +	else=0A=
> +		pr_err("Snapshot image [%d:%d] not found\n", MAJOR(original_dev),=0A=
> +		       MINOR(original_dev));=0A=
> +=0A=
> +	up_read(&snap_image_destroy_lock);=0A=
> +}=0A=
> +=0A=
> +void snapimage_destroy(dev_t original_dev)=0A=
> +{=0A=
> +	struct snapimage *image =3D NULL;=0A=
> +=0A=
> +	pr_info("Destroy snapshot image for device [%d:%d]\n", MAJOR(original_d=
ev),=0A=
> +		MINOR(original_dev));=0A=
> +=0A=
> +	down_write(&snap_images_lock);=0A=
> +	if (!list_empty(&snap_images)) {=0A=
> +		struct list_head *_list_head;=0A=
> +=0A=
> +		list_for_each(_list_head, &snap_images) {=0A=
> +			struct snapimage *_image =3D list_entry(_list_head, struct snapimage,=
 link);=0A=
> +=0A=
> +			if (_image->original_dev =3D=3D original_dev) {=0A=
> +				image =3D _image;=0A=
> +				list_del(&image->link);=0A=
> +				break;=0A=
> +			}=0A=
> +		}=0A=
> +	}=0A=
> +	up_write(&snap_images_lock);=0A=
> +=0A=
> +	if (image !=3D NULL) {=0A=
> +		down_write(&snap_image_destroy_lock);=0A=
> +=0A=
> +		_snapimage_destroy(image);=0A=
> +		_snapimage_free(image);=0A=
> +=0A=
> +		kfree(image);=0A=
> +		image =3D NULL;=0A=
> +=0A=
> +		up_write(&snap_image_destroy_lock);=0A=
> +	} else=0A=
> +		pr_err("Snapshot image [%d:%d] not found\n", MAJOR(original_dev),=0A=
> +		       MINOR(original_dev));=0A=
> +}=0A=
> +=0A=
> +void snapimage_destroy_for(dev_t *p_dev, int count)=0A=
> +{=0A=
> +	int inx =3D 0;=0A=
> +=0A=
> +	for (; inx < count; ++inx)=0A=
> +		snapimage_destroy(p_dev[inx]);=0A=
> +}=0A=
> +=0A=
> +int snapimage_create_for(dev_t *p_dev, int count)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	int inx =3D 0;=0A=
> +=0A=
> +	for (; inx < count; ++inx) {=0A=
> +		res =3D snapimage_create(p_dev[inx]);=0A=
> +		if (res !=3D SUCCESS) {=0A=
> +			pr_err("Failed to create snapshot image for original device [%d:%d]\n=
",=0A=
> +			       MAJOR(p_dev[inx]), MINOR(p_dev[inx]));=0A=
> +			break;=0A=
> +		}=0A=
> +	}=0A=
> +	if (res !=3D SUCCESS)=0A=
> +		if (inx > 0)=0A=
> +			snapimage_destroy_for(p_dev, inx - 1);=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +int snapimage_init(void)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +=0A=
> +	res =3D register_blkdev(snapimage_major, SNAP_IMAGE_NAME);=0A=
> +	if (res >=3D SUCCESS) {=0A=
> +		snapimage_major =3D res;=0A=
> +		pr_info("Snapshot image block device major %d was registered\n", snapi=
mage_major);=0A=
> +		res =3D SUCCESS;=0A=
> +=0A=
> +		spin_lock(&snapimage_minors_lock);=0A=
> +		snapimage_minors =3D bitmap_zalloc(SNAPIMAGE_MAX_DEVICES, GFP_KERNEL);=
=0A=
> +		spin_unlock(&snapimage_minors_lock);=0A=
> +=0A=
> +		if (snapimage_minors =3D=3D NULL)=0A=
> +			pr_err("Failed to initialize bitmap of minors\n");=0A=
> +	} else=0A=
> +		pr_err("Failed to register snapshot image block device. errno=3D%d\n",=
 res);=0A=
> +=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +void snapimage_done(void)=0A=
> +{=0A=
> +	down_write(&snap_image_destroy_lock);=0A=
> +	while (true) {=0A=
> +		struct snapimage *image =3D NULL;=0A=
> +=0A=
> +		down_write(&snap_images_lock);=0A=
> +		if (!list_empty(&snap_images)) {=0A=
> +			image =3D list_entry(snap_images.next, struct snapimage, link);=0A=
> +=0A=
> +			list_del(&image->link);=0A=
> +		}=0A=
> +		up_write(&snap_images_lock);=0A=
> +=0A=
> +		if (image =3D=3D NULL)=0A=
> +			break;=0A=
> +=0A=
> +		pr_err("Snapshot image for device was unexpectedly removed [%d:%d]\n",=
=0A=
> +		       MAJOR(image->original_dev), MINOR(image->original_dev));=0A=
> +=0A=
> +		_snapimage_destroy(image);=0A=
> +		_snapimage_free(image);=0A=
> +=0A=
> +		kfree(image);=0A=
> +		image =3D NULL;=0A=
> +	}=0A=
> +=0A=
> +	spin_lock(&snapimage_minors_lock);=0A=
> +	bitmap_free(snapimage_minors);=0A=
> +	snapimage_minors =3D NULL;=0A=
> +	spin_unlock(&snapimage_minors_lock);=0A=
> +=0A=
> +	if (!list_empty(&snap_images))=0A=
> +		pr_err("Failed to release snapshot images container\n");=0A=
> +=0A=
> +	unregister_blkdev(snapimage_major, SNAP_IMAGE_NAME);=0A=
> +	pr_info("Snapshot image block device [%d] was unregistered\n", snapimag=
e_major);=0A=
> +=0A=
> +	up_write(&snap_image_destroy_lock);=0A=
> +}=0A=
> +=0A=
> +int snapimage_collect_images(int count, struct image_info_s *p_user_imag=
e_info, int *p_real_count)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	int real_count =3D 0;=0A=
> +=0A=
> +	down_read(&snap_images_lock);=0A=
> +	if (!list_empty(&snap_images)) {=0A=
> +		struct list_head *_list_head;=0A=
> +=0A=
> +		list_for_each(_list_head, &snap_images)=0A=
> +			real_count++;=0A=
> +	}=0A=
> +	up_read(&snap_images_lock);=0A=
> +	*p_real_count =3D real_count;=0A=
> +=0A=
> +	if (count < real_count)=0A=
> +		res =3D -ENODATA;=0A=
> +=0A=
> +	real_count =3D min(count, real_count);=0A=
> +	if (real_count > 0) {=0A=
> +		unsigned long len;=0A=
> +		struct image_info_s *p_kernel_image_info =3D NULL;=0A=
> +		size_t buff_size;=0A=
> +=0A=
> +		buff_size =3D sizeof(struct image_info_s) * real_count;=0A=
> +		p_kernel_image_info =3D kzalloc(buff_size, GFP_KERNEL);=0A=
> +		if (p_kernel_image_info =3D=3D NULL) {=0A=
> +			pr_err("Unable to collect snapshot images: not enough memory. size=3D=
%zu\n",=0A=
> +			       buff_size);=0A=
> +			return res =3D -ENOMEM;=0A=
> +		}=0A=
> +=0A=
> +		down_read(&snap_image_destroy_lock);=0A=
> +		down_read(&snap_images_lock);=0A=
> +=0A=
> +		if (!list_empty(&snap_images)) {=0A=
> +			size_t inx =3D 0;=0A=
> +			struct list_head *_list_head;=0A=
> +=0A=
> +			list_for_each(_list_head, &snap_images) {=0A=
> +				struct snapimage *img =3D=0A=
> +					list_entry(_list_head, struct snapimage, link);=0A=
> +=0A=
> +				real_count++;=0A=
> +=0A=
> +				p_kernel_image_info[inx].original_dev_id.major =3D=0A=
> +					MAJOR(img->original_dev);=0A=
> +				p_kernel_image_info[inx].original_dev_id.minor =3D=0A=
> +					MINOR(img->original_dev);=0A=
> +=0A=
> +				p_kernel_image_info[inx].snapshot_dev_id.major =3D=0A=
> +					MAJOR(img->image_dev);=0A=
> +				p_kernel_image_info[inx].snapshot_dev_id.minor =3D=0A=
> +					MINOR(img->image_dev);=0A=
> +=0A=
> +				++inx;=0A=
> +				if (inx > real_count)=0A=
> +					break;=0A=
> +			}=0A=
> +		}=0A=
> +=0A=
> +		up_read(&snap_images_lock);=0A=
> +		up_read(&snap_image_destroy_lock);=0A=
> +=0A=
> +		len =3D copy_to_user(p_user_image_info, p_kernel_image_info, buff_size=
);=0A=
> +		if (len !=3D 0) {=0A=
> +			pr_err("Unable to collect snapshot images: failed to copy data to use=
r buffer\n");=0A=
> +			res =3D -ENODATA;=0A=
> +		}=0A=
> +=0A=
> +		kfree(p_kernel_image_info);=0A=
> +	}=0A=
> +=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +int snapimage_mark_dirty_blocks(dev_t image_dev_id, struct block_range_s=
 *block_ranges,=0A=
> +				unsigned int count)=0A=
> +{=0A=
> +	size_t inx =3D 0;=0A=
> +	int res =3D SUCCESS;=0A=
> +=0A=
> +	pr_info("Marking [%d] dirty blocks for image device [%d:%d]\n", count, =
MAJOR(image_dev_id),=0A=
> +		MINOR(image_dev_id));=0A=
> +=0A=
> +	down_read(&snap_image_destroy_lock);=0A=
> +	do {=0A=
> +		struct snapimage *image =3D snapimage_find(image_dev_id);=0A=
> +=0A=
> +		if (image =3D=3D NULL) {=0A=
> +			pr_err("Cannot find device [%d:%d]\n", MAJOR(image_dev_id),=0A=
> +			       MINOR(image_dev_id));=0A=
> +			res =3D -ENODEV;=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		for (inx =3D 0; inx < count; ++inx) {=0A=
> +			sector_t ofs =3D (sector_t)block_ranges[inx].ofs;=0A=
> +			sector_t cnt =3D (sector_t)block_ranges[inx].cnt;=0A=
> +=0A=
> +			res =3D cbt_map_set_both(image->cbt_map, ofs, cnt);=0A=
> +			if (res !=3D SUCCESS) {=0A=
> +				pr_err("Failed to set CBT table. errno=3D%d\n", res);=0A=
> +				break;=0A=
> +			}=0A=
> +		}=0A=
> +	} while (false);=0A=
> +	up_read(&snap_image_destroy_lock);=0A=
> +=0A=
> +	return res;=0A=
> +}=0A=
> diff --git a/drivers/block/blk-snap/snapimage.h b/drivers/block/blk-snap/=
snapimage.h=0A=
> new file mode 100644=0A=
> index 000000000000..67995c321496=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/snapimage.h=0A=
> @@ -0,0 +1,16 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
> +#pragma once=0A=
> +=0A=
> +#include "blk-snap-ctl.h"=0A=
> +=0A=
> +int snapimage_init(void);=0A=
> +void snapimage_done(void);=0A=
> +int snapimage_create_for(dev_t *p_dev, int count);=0A=
> +=0A=
> +void snapimage_stop(dev_t original_dev);=0A=
> +void snapimage_destroy(dev_t original_dev);=0A=
> +=0A=
> +int snapimage_collect_images(int count, struct image_info_s *p_user_imag=
e_info, int *p_real_count);=0A=
> +=0A=
> +int snapimage_mark_dirty_blocks(dev_t image_dev_id, struct block_range_s=
 *block_ranges,=0A=
> +				unsigned int count);=0A=
> diff --git a/drivers/block/blk-snap/snapshot.c b/drivers/block/blk-snap/s=
napshot.c=0A=
> new file mode 100644=0A=
> index 000000000000..fdef713103d2=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/snapshot.c=0A=
> @@ -0,0 +1,225 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#define BLK_SNAP_SECTION "-snapshot"=0A=
> +#include "common.h"=0A=
> +#include "snapshot.h"=0A=
> +#include "tracker.h"=0A=
> +#include "snapimage.h"=0A=
> +#include "tracking.h"=0A=
> +=0A=
> +LIST_HEAD(snapshots);=0A=
> +DECLARE_RWSEM(snapshots_lock);=0A=
> +=0A=
> +=0A=
> +static int _snapshot_remove_device(dev_t dev_id)=0A=
> +{=0A=
> +	int result;=0A=
> +	struct tracker *tracker =3D NULL;=0A=
> +=0A=
> +	result =3D tracker_find_by_dev_id(dev_id, &tracker);=0A=
> +	if (result !=3D SUCCESS) {=0A=
> +		if (result =3D=3D -ENODEV)=0A=
> +			pr_err("Cannot find device by device id=3D[%d:%d]\n", MAJOR(dev_id),=
=0A=
> +			       MINOR(dev_id));=0A=
> +		else=0A=
> +			pr_err("Failed to find device by device id=3D[%d:%d]\n", MAJOR(dev_id=
),=0A=
> +			       MINOR(dev_id));=0A=
> +		return SUCCESS;=0A=
> +	}=0A=
> +=0A=
> +	if (result !=3D SUCCESS)=0A=
> +		return result;=0A=
> +=0A=
> +	tracker->snapshot_id =3D 0ull;=0A=
> +=0A=
> +	pr_info("Device [%d:%d] successfully removed from snapshot\n", MAJOR(de=
v_id),=0A=
> +		MINOR(dev_id));=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +static void _snapshot_cleanup(struct snapshot *snapshot)=0A=
> +{=0A=
> +	int inx;=0A=
> +=0A=
> +	for (inx =3D 0; inx < snapshot->dev_id_set_size; ++inx) {=0A=
> +=0A=
> +		if (_snapshot_remove_device(snapshot->dev_id_set[inx]) !=3D SUCCESS)=
=0A=
> +			pr_err("Failed to remove device [%d:%d] from snapshot\n",=0A=
> +			       MAJOR(snapshot->dev_id_set[inx]), MINOR(snapshot->dev_id_set[i=
nx]));=0A=
> +	}=0A=
> +=0A=
> +	if (snapshot->dev_id_set !=3D NULL)=0A=
> +		kfree(snapshot->dev_id_set);=0A=
> +	kfree(snapshot);=0A=
> +}=0A=
> +=0A=
> +static void _snapshot_destroy(struct snapshot *snapshot)=0A=
> +{=0A=
> +	size_t inx;=0A=
> +=0A=
> +	for (inx =3D 0; inx < snapshot->dev_id_set_size; ++inx)=0A=
> +		snapimage_stop(snapshot->dev_id_set[inx]);=0A=
> +=0A=
> +	pr_info("Release snapshot [0x%llx]\n", snapshot->id);=0A=
> +=0A=
> +	tracker_release_snapshot(snapshot->dev_id_set, snapshot->dev_id_set_siz=
e);=0A=
> +=0A=
> +	for (inx =3D 0; inx < snapshot->dev_id_set_size; ++inx)=0A=
> +		snapimage_destroy(snapshot->dev_id_set[inx]);=0A=
> +=0A=
> +	_snapshot_cleanup(snapshot);=0A=
> +}=0A=
> +=0A=
> +=0A=
> +static int _snapshot_new(dev_t *p_dev, int count, struct snapshot **pp_s=
napshot)=0A=
> +{=0A=
> +	struct snapshot *p_snapshot =3D NULL;=0A=
> +	dev_t *snap_set =3D NULL;=0A=
> +=0A=
> +	p_snapshot =3D kzalloc(sizeof(struct snapshot), GFP_KERNEL);=0A=
> +	if (p_snapshot =3D=3D NULL)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	INIT_LIST_HEAD(&p_snapshot->link);=0A=
> +=0A=
> +	p_snapshot->id =3D (unsigned long)(p_snapshot);=0A=
> +=0A=
> +	snap_set =3D kcalloc(count, sizeof(dev_t), GFP_KERNEL);=0A=
> +	if (snap_set =3D=3D NULL) {=0A=
> +		kfree(p_snapshot);=0A=
> +=0A=
> +		pr_err("Unable to create snapshot: faile to allocate memory for snapsh=
ot map\n");=0A=
> +		return -ENOMEM;=0A=
> +	}=0A=
> +	memcpy(snap_set, p_dev, sizeof(dev_t) * count);=0A=
> +=0A=
> +	p_snapshot->dev_id_set_size =3D count;=0A=
> +	p_snapshot->dev_id_set =3D snap_set;=0A=
> +=0A=
> +	down_write(&snapshots_lock);=0A=
> +	list_add_tail(&snapshots, &p_snapshot->link);=0A=
> +	up_write(&snapshots_lock);=0A=
> +=0A=
> +	*pp_snapshot =3D p_snapshot;=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +void snapshot_done(void)=0A=
> +{=0A=
> +	struct snapshot *snap;=0A=
> +=0A=
> +	pr_info("Removing all snapshots\n");=0A=
> +	do {=0A=
> +		snap =3D NULL;=0A=
> +		down_write(&snapshots_lock);=0A=
> +		if (!list_empty(&snapshots)) {=0A=
> +			struct snapshot *snap =3D list_entry(snapshots.next, struct snapshot,=
 link);=0A=
> +=0A=
> +			list_del(&snap->link);=0A=
> +		}=0A=
> +		up_write(&snapshots_lock);=0A=
> +=0A=
> +		if (snap)=0A=
> +			_snapshot_destroy(snap);=0A=
> +=0A=
> +	} while (snap);=0A=
> +}=0A=
> +=0A=
> +int snapshot_create(dev_t *dev_id_set, unsigned int dev_id_set_size,=0A=
> +		    unsigned long long *p_snapshot_id)=0A=
> +{=0A=
> +	struct snapshot *snapshot =3D NULL;=0A=
> +	int result =3D SUCCESS;=0A=
> +	unsigned int inx;=0A=
> +=0A=
> +	pr_info("Create snapshot for devices:\n");=0A=
> +	for (inx =3D 0; inx < dev_id_set_size; ++inx)=0A=
> +		pr_info("\t%d:%d\n", MAJOR(dev_id_set[inx]), MINOR(dev_id_set[inx]));=
=0A=
> +=0A=
> +	result =3D _snapshot_new(dev_id_set, dev_id_set_size, &snapshot);=0A=
> +	if (result !=3D SUCCESS) {=0A=
> +		pr_err("Unable to create snapshot: failed to allocate snapshot structu=
re\n");=0A=
> +		return result;=0A=
> +	}=0A=
> +=0A=
> +	do {=0A=
> +		result =3D -ENODEV;=0A=
> +		for (inx =3D 0; inx < snapshot->dev_id_set_size; ++inx) {=0A=
> +			dev_t dev_id =3D snapshot->dev_id_set[inx];=0A=
> +=0A=
> +			result =3D tracking_add(dev_id, snapshot->id);=0A=
> +			if (result =3D=3D -EALREADY)=0A=
> +				result =3D SUCCESS;=0A=
> +			else if (result !=3D SUCCESS) {=0A=
> +				pr_err("Unable to create snapshot\n");=0A=
> +				pr_err("Failed to add device [%d:%d] to snapshot tracking\n",=0A=
> +				       MAJOR(dev_id), MINOR(dev_id));=0A=
> +				break;=0A=
> +			}=0A=
> +		}=0A=
> +		if (result !=3D SUCCESS)=0A=
> +			break;=0A=
> +=0A=
> +		result =3D tracker_capture_snapshot(snapshot->dev_id_set, snapshot->de=
v_id_set_size);=0A=
> +		if (result !=3D SUCCESS) {=0A=
> +			pr_err("Unable to create snapshot: failed to capture snapshot [0x%llx=
]\n",=0A=
> +			       snapshot->id);=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		result =3D snapimage_create_for(snapshot->dev_id_set, snapshot->dev_id=
_set_size);=0A=
> +		if (result !=3D SUCCESS) {=0A=
> +			pr_err("Unable to create snapshot\n");=0A=
> +			pr_err("Failed to create snapshot image devices\n");=0A=
> +=0A=
> +			tracker_release_snapshot(snapshot->dev_id_set, snapshot->dev_id_set_s=
ize);=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		*p_snapshot_id =3D snapshot->id;=0A=
> +		pr_info("Snapshot [0x%llx] was created\n", snapshot->id);=0A=
> +	} while (false);=0A=
> +=0A=
> +	if (result !=3D SUCCESS) {=0A=
> +		pr_info("Snapshot [0x%llx] cleanup\n", snapshot->id);=0A=
> +=0A=
> +		down_write(&snapshots_lock);=0A=
> +		list_del(&snapshot->link);=0A=
> +		up_write(&snapshots_lock);=0A=
> +=0A=
> +		_snapshot_cleanup(snapshot);=0A=
> +	}=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
> +int snapshot_destroy(unsigned long long snapshot_id)=0A=
> +{=0A=
> +	struct snapshot *snapshot =3D NULL;=0A=
> +=0A=
> +	pr_info("Destroy snapshot [0x%llx]\n", snapshot_id);=0A=
> +=0A=
> +	down_read(&snapshots_lock);=0A=
> +	if (!list_empty(&snapshots)) {=0A=
> +		struct list_head *_head;=0A=
> +=0A=
> +		list_for_each(_head, &snapshots) {=0A=
> +			struct snapshot *_snap =3D list_entry(_head, struct snapshot, link);=
=0A=
> +=0A=
> +			if (_snap->id =3D=3D snapshot_id) {=0A=
> +				snapshot =3D _snap;=0A=
> +				list_del(&snapshot->link);=0A=
> +				break;=0A=
> +			}=0A=
> +		}=0A=
> +	}=0A=
> +	up_read(&snapshots_lock);=0A=
> +=0A=
> +	if (snapshot =3D=3D NULL) {=0A=
> +		pr_err("Unable to destroy snapshot [0x%llx]: cannot find snapshot by i=
d\n",=0A=
> +		       snapshot_id);=0A=
> +		return -ENODEV;=0A=
> +	}=0A=
> +=0A=
> +	_snapshot_destroy(snapshot);=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> diff --git a/drivers/block/blk-snap/snapshot.h b/drivers/block/blk-snap/s=
napshot.h=0A=
> new file mode 100644=0A=
> index 000000000000..59fb4dba0241=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/snapshot.h=0A=
> @@ -0,0 +1,17 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
> +#pragma once=0A=
> +=0A=
> +struct snapshot {=0A=
> +	struct list_head link;=0A=
> +	unsigned long long id;=0A=
> +=0A=
> +	dev_t *dev_id_set; //array of assigned devices=0A=
> +	int dev_id_set_size;=0A=
> +};=0A=
> +=0A=
> +void snapshot_done(void);=0A=
> +=0A=
> +int snapshot_create(dev_t *dev_id_set, unsigned int dev_id_set_size,=0A=
> +		    unsigned long long *p_snapshot_id);=0A=
> +=0A=
> +int snapshot_destroy(unsigned long long snapshot_id);=0A=
> diff --git a/drivers/block/blk-snap/snapstore.c b/drivers/block/blk-snap/=
snapstore.c=0A=
> new file mode 100644=0A=
> index 000000000000..0bedeaeec021=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/snapstore.c=0A=
> @@ -0,0 +1,929 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#define BLK_SNAP_SECTION "-snapstore"=0A=
> +#include "common.h"=0A=
> +#include "snapstore.h"=0A=
> +#include "snapstore_device.h"=0A=
> +#include "big_buffer.h"=0A=
> +#include "params.h"=0A=
> +=0A=
> +LIST_HEAD(snapstores);=0A=
> +DECLARE_RWSEM(snapstores_lock);=0A=
> +=0A=
> +bool _snapstore_check_halffill(struct snapstore *snapstore, sector_t *fi=
ll_status)=0A=
> +{=0A=
> +	struct blk_descr_pool *pool =3D NULL;=0A=
> +=0A=
> +	if (snapstore->file)=0A=
> +		pool =3D &snapstore->file->pool;=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +	else if (snapstore->multidev)=0A=
> +		pool =3D &snapstore->multidev->pool;=0A=
> +#endif=0A=
> +	else if (snapstore->mem)=0A=
> +		pool =3D &snapstore->mem->pool;=0A=
> +=0A=
> +	if (pool)=0A=
> +		return blk_descr_pool_check_halffill(pool, snapstore->empty_limit, fil=
l_status);=0A=
> +=0A=
> +	return false;=0A=
> +}=0A=
> +=0A=
> +void _snapstore_destroy(struct snapstore *snapstore)=0A=
> +{=0A=
> +	sector_t fill_status;=0A=
> +=0A=
> +	pr_info("Destroy snapstore with id %pUB\n", &snapstore->id);=0A=
> +=0A=
> +	_snapstore_check_halffill(snapstore, &fill_status);=0A=
> +=0A=
> +	down_write(&snapstores_lock);=0A=
> +	list_del(&snapstore->link);=0A=
> +	up_write(&snapstores_lock);=0A=
> +=0A=
> +	if (snapstore->mem !=3D NULL)=0A=
> +		snapstore_mem_destroy(snapstore->mem);=0A=
> +	if (snapstore->multidev !=3D NULL)=0A=
> +		snapstore_multidev_destroy(snapstore->multidev);=0A=
> +	if (snapstore->file !=3D NULL)=0A=
> +		snapstore_file_destroy(snapstore->file);=0A=
> +=0A=
> +	if (snapstore->ctrl_pipe) {=0A=
> +		struct ctrl_pipe *pipe;=0A=
> +=0A=
> +		pipe =3D snapstore->ctrl_pipe;=0A=
> +		snapstore->ctrl_pipe =3D NULL;=0A=
> +=0A=
> +		ctrl_pipe_request_terminate(pipe, fill_status);=0A=
> +=0A=
> +		ctrl_pipe_put_resource(pipe);=0A=
> +	}=0A=
> +=0A=
> +	kfree(snapstore);=0A=
> +}=0A=
> +=0A=
> +static void _snapstore_destroy_cb(struct kref *kref)=0A=
> +{=0A=
> +	struct snapstore *snapstore =3D container_of(kref, struct snapstore, re=
fcount);=0A=
> +=0A=
> +	_snapstore_destroy(snapstore);=0A=
> +}=0A=
> +=0A=
> +struct snapstore *snapstore_get(struct snapstore *snapstore)=0A=
> +{=0A=
> +	if (snapstore)=0A=
> +		kref_get(&snapstore->refcount);=0A=
> +=0A=
> +	return snapstore;=0A=
> +}=0A=
> +=0A=
> +void snapstore_put(struct snapstore *snapstore)=0A=
> +{=0A=
> +	if (snapstore)=0A=
> +		kref_put(&snapstore->refcount, _snapstore_destroy_cb);=0A=
> +}=0A=
> +=0A=
> +void snapstore_done(void)=0A=
> +{=0A=
> +	bool is_empty;=0A=
> +=0A=
> +	down_read(&snapstores_lock);=0A=
> +	is_empty =3D list_empty(&snapstores);=0A=
> +	up_read(&snapstores_lock);=0A=
> +=0A=
> +	if (!is_empty)=0A=
> +		pr_err("Unable to perform snapstore cleanup: container is not empty\n"=
);=0A=
> +}=0A=
> +=0A=
> +int snapstore_create(uuid_t *id, dev_t snapstore_dev_id, dev_t *dev_id_s=
et,=0A=
> +		     size_t dev_id_set_length)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	size_t dev_id_inx;=0A=
> +	struct snapstore *snapstore =3D NULL;=0A=
> +=0A=
> +	if (dev_id_set_length =3D=3D 0)=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	snapstore =3D kzalloc(sizeof(struct snapstore), GFP_KERNEL);=0A=
> +	if (snapstore =3D=3D NULL)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	INIT_LIST_HEAD(&snapstore->link);=0A=
> +	uuid_copy(&snapstore->id, id);=0A=
> +=0A=
> +	pr_info("Create snapstore with id %pUB\n", &snapstore->id);=0A=
> +=0A=
> +	snapstore->mem =3D NULL;=0A=
> +	snapstore->multidev =3D NULL;=0A=
> +	snapstore->file =3D NULL;=0A=
> +=0A=
> +	snapstore->ctrl_pipe =3D NULL;=0A=
> +	snapstore->empty_limit =3D (sector_t)(64 * (1024 * 1024 / SECTOR_SIZE))=
; //by default value=0A=
> +	snapstore->halffilled =3D false;=0A=
> +	snapstore->overflowed =3D false;=0A=
> +=0A=
> +	if (snapstore_dev_id =3D=3D 0)=0A=
> +		pr_info("Memory snapstore create\n");=0A=
> +=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +	else if (snapstore_dev_id =3D=3D 0xFFFFffff) {=0A=
> +		struct snapstore_multidev *multidev =3D NULL;=0A=
> +=0A=
> +		res =3D snapstore_multidev_create(&multidev);=0A=
> +		if (res !=3D SUCCESS) {=0A=
> +			kfree(snapstore);=0A=
> +=0A=
> +			pr_err("Failed to create multidevice snapstore %pUB\n", id);=0A=
> +			return res;=0A=
> +		}=0A=
> +		snapstore->multidev =3D multidev;=0A=
> +	}=0A=
> +#endif=0A=
> +	else {=0A=
> +		struct snapstore_file *file =3D NULL;=0A=
> +=0A=
> +		res =3D snapstore_file_create(snapstore_dev_id, &file);=0A=
> +		if (res !=3D SUCCESS) {=0A=
> +			kfree(snapstore);=0A=
> +=0A=
> +			pr_err("Failed to create snapstore file for snapstore %pUB\n", id);=
=0A=
> +			return res;=0A=
> +		}=0A=
> +		snapstore->file =3D file;=0A=
> +	}=0A=
> +=0A=
> +	down_write(&snapstores_lock);=0A=
> +	list_add_tail(&snapstores, &snapstore->link);=0A=
> +	up_write(&snapstores_lock);=0A=
> +=0A=
> +	kref_init(&snapstore->refcount);=0A=
> +=0A=
> +	for (dev_id_inx =3D 0; dev_id_inx < dev_id_set_length; ++dev_id_inx) {=
=0A=
> +		res =3D snapstore_device_create(dev_id_set[dev_id_inx], snapstore);=0A=
> +		if (res !=3D SUCCESS)=0A=
> +			break;=0A=
> +	}=0A=
> +=0A=
> +	if (res !=3D SUCCESS)=0A=
> +		snapstore_device_cleanup(id);=0A=
> +=0A=
> +	snapstore_put(snapstore);=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +int snapstore_create_multidev(uuid_t *id, dev_t *dev_id_set, size_t dev_=
id_set_length)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	size_t dev_id_inx;=0A=
> +	struct snapstore *snapstore =3D NULL;=0A=
> +	struct snapstore_multidev *multidev =3D NULL;=0A=
> +=0A=
> +	if (dev_id_set_length =3D=3D 0)=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	snapstore =3D kzalloc(sizeof(struct snapstore), GFP_KERNEL);=0A=
> +	if (snapstore =3D=3D NULL)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	INIT_LIST_HEAD(&snapstore->link);=0A=
> +=0A=
> +	uuid_copy(&snapstore->id, id);=0A=
> +=0A=
> +	pr_info("Create snapstore with id %pUB\n", &snapstore->id);=0A=
> +=0A=
> +	snapstore->mem =3D NULL;=0A=
> +	snapstore->file =3D NULL;=0A=
> +	snapstore->multidev =3D NULL;=0A=
> +=0A=
> +	snapstore->ctrl_pipe =3D NULL;=0A=
> +	snapstore->empty_limit =3D (sector_t)(64 * (1024 * 1024 / SECTOR_SIZE))=
; //by default value=0A=
> +	snapstore->halffilled =3D false;=0A=
> +	snapstore->overflowed =3D false;=0A=
> +=0A=
> +	res =3D snapstore_multidev_create(&multidev);=0A=
> +	if (res !=3D SUCCESS) {=0A=
> +		kfree(snapstore);=0A=
> +=0A=
> +		pr_err("Failed to create snapstore file for snapstore %pUB\n", id);=0A=
> +		return res;=0A=
> +	}=0A=
> +	snapstore->multidev =3D multidev;=0A=
> +=0A=
> +	down_write(&snapstores_lock);=0A=
> +	list_add_tail(&snapstore->link, &snapstores);=0A=
> +	up_write(&snapstores_lock);=0A=
> +=0A=
> +	kref_init(&snapstore->refcount);=0A=
> +=0A=
> +	for (dev_id_inx =3D 0; dev_id_inx < dev_id_set_length; ++dev_id_inx) {=
=0A=
> +		res =3D snapstore_device_create(dev_id_set[dev_id_inx], snapstore);=0A=
> +		if (res !=3D SUCCESS)=0A=
> +			break;=0A=
> +	}=0A=
> +=0A=
> +	if (res !=3D SUCCESS)=0A=
> +		snapstore_device_cleanup(id);=0A=
> +=0A=
> +	snapstore_put(snapstore);=0A=
> +	return res;=0A=
> +}=0A=
> +#endif=0A=
> +=0A=
> +int snapstore_cleanup(uuid_t *id, u64 *filled_bytes)=0A=
> +{=0A=
> +	int res;=0A=
> +	sector_t filled;=0A=
> +=0A=
> +	res =3D snapstore_check_halffill(id, &filled);=0A=
> +	if (res =3D=3D SUCCESS) {=0A=
> +		*filled_bytes =3D (u64)from_sectors(filled);=0A=
> +=0A=
> +		pr_info("Snapstore fill size: %lld MiB\n", (*filled_bytes >> 20));=0A=
> +	} else {=0A=
> +		*filled_bytes =3D -1;=0A=
> +		pr_err("Failed to obtain snapstore data filled size\n");=0A=
> +	}=0A=
> +=0A=
> +	return snapstore_device_cleanup(id);=0A=
> +}=0A=
> +=0A=
> +struct snapstore *_snapstore_find(uuid_t *id)=0A=
> +{=0A=
> +	struct snapstore *result =3D NULL;=0A=
> +=0A=
> +	down_read(&snapstores_lock);=0A=
> +	if (!list_empty(&snapstores)) {=0A=
> +		struct list_head *_head;=0A=
> +=0A=
> +		list_for_each(_head, &snapstores) {=0A=
> +			struct snapstore *snapstore =3D list_entry(_head, struct snapstore, l=
ink);=0A=
> +=0A=
> +			if (uuid_equal(&snapstore->id, id)) {=0A=
> +				result =3D snapstore;=0A=
> +				break;=0A=
> +			}=0A=
> +		}=0A=
> +	}=0A=
> +	up_read(&snapstores_lock);=0A=
> +=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
> +int snapstore_stretch_initiate(uuid_t *unique_id, struct ctrl_pipe *ctrl=
_pipe, sector_t empty_limit)=0A=
> +{=0A=
> +	struct snapstore *snapstore;=0A=
> +=0A=
> +	snapstore =3D _snapstore_find(unique_id);=0A=
> +	if (snapstore =3D=3D NULL) {=0A=
> +		pr_err("Unable to initiate stretch snapstore: ");=0A=
> +		pr_err("cannot find snapstore by uuid %pUB\n", unique_id);=0A=
> +		return -ENODATA;=0A=
> +	}=0A=
> +=0A=
> +	snapstore->ctrl_pipe =3D ctrl_pipe_get_resource(ctrl_pipe);=0A=
> +	snapstore->empty_limit =3D empty_limit;=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +int snapstore_add_memory(uuid_t *id, unsigned long long sz)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	struct snapstore *snapstore =3D NULL;=0A=
> +	size_t available_blocks =3D (size_t)(sz >> (snapstore_block_shift() + S=
ECTOR_SHIFT));=0A=
> +	size_t current_block =3D 0;=0A=
> +=0A=
> +	pr_info("Adding %lld bytes to the snapstore\n", sz);=0A=
> +=0A=
> +	snapstore =3D _snapstore_find(id);=0A=
> +	if (snapstore =3D=3D NULL) {=0A=
> +		pr_err("Unable to add memory block to the snapstore: ");=0A=
> +		pr_err("cannot found snapstore by id %pUB\n", id);=0A=
> +		return -ENODATA;=0A=
> +	}=0A=
> +=0A=
> +	if (snapstore->file !=3D NULL) {=0A=
> +		pr_err("Unable to add memory block to the snapstore: ");=0A=
> +		pr_err("snapstore file is already created\n");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +	if (snapstore->multidev !=3D NULL) {=0A=
> +		pr_err("Unable to add memory block to the snapstore: ");=0A=
> +		pr_err("snapstore multidevice is already created\n");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +#endif=0A=
> +	if (snapstore->mem !=3D NULL) {=0A=
> +		pr_err("Unable to add memory block to the snapstore: ");=0A=
> +		pr_err("snapstore memory buffer is already created\n");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	snapstore->mem =3D snapstore_mem_create(available_blocks);=0A=
> +	for (current_block =3D 0; current_block < available_blocks; ++current_b=
lock) {=0A=
> +		void *buffer =3D snapstore_mem_get_block(snapstore->mem);=0A=
> +=0A=
> +		if (buffer =3D=3D NULL) {=0A=
> +			pr_err("Unable to add memory block to the snapstore: ");=0A=
> +			pr_err("not enough memory\n");=0A=
> +			res =3D -ENOMEM;=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		res =3D blk_descr_mem_pool_add(&snapstore->mem->pool, buffer);=0A=
> +		if (res !=3D SUCCESS) {=0A=
> +			pr_err("Unable to add memory block to the snapstore: ");=0A=
> +			pr_err("failed to initialize new block\n");=0A=
> +			break;=0A=
> +		}=0A=
> +	}=0A=
> +	if (res !=3D SUCCESS) {=0A=
> +		snapstore_mem_destroy(snapstore->mem);=0A=
> +		snapstore->mem =3D NULL;=0A=
> +	}=0A=
> +=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +int rangelist_add(struct list_head *rglist, struct blk_range *rg)=0A=
> +{=0A=
> +	struct blk_range_link *range_link;=0A=
> +=0A=
> +	range_link =3D kzalloc(sizeof(struct blk_range_link), GFP_KERNEL);=0A=
> +	if (range_link =3D=3D NULL)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	INIT_LIST_HEAD(&range_link->link);=0A=
> +=0A=
> +	range_link->rg.ofs =3D rg->ofs;=0A=
> +	range_link->rg.cnt =3D rg->cnt;=0A=
> +=0A=
> +	list_add_tail(&range_link->link, rglist);=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +int snapstore_add_file(uuid_t *id, struct big_buffer *ranges, size_t ran=
ges_cnt)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	struct snapstore *snapstore =3D NULL;=0A=
> +	struct snapstore_device *snapstore_device =3D NULL;=0A=
> +	sector_t current_blk_size =3D 0;=0A=
> +	LIST_HEAD(blk_rangelist);=0A=
> +	size_t inx;=0A=
> +=0A=
> +	pr_info("Snapstore add %zu ranges\n", ranges_cnt);=0A=
> +=0A=
> +	if ((ranges_cnt =3D=3D 0) || (ranges =3D=3D NULL))=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	snapstore =3D _snapstore_find(id);=0A=
> +	if (snapstore =3D=3D NULL) {=0A=
> +		pr_err("Unable to add file to snapstore: ");=0A=
> +		pr_err("cannot find snapstore by id %pUB\n", id);=0A=
> +		return -ENODATA;=0A=
> +	}=0A=
> +=0A=
> +	if (snapstore->file =3D=3D NULL) {=0A=
> +		pr_err("Unable to add file to snapstore: ");=0A=
> +		pr_err("snapstore file was not initialized\n");=0A=
> +		return -EFAULT;=0A=
> +	}=0A=
> +=0A=
> +	snapstore_device =3D=0A=
> +		snapstore_device_find_by_dev_id(snapstore->file->blk_dev_id); //for ze=
roed=0A=
> +=0A=
> +	for (inx =3D 0; inx < ranges_cnt; ++inx) {=0A=
> +		size_t blocks_count =3D 0;=0A=
> +		sector_t range_offset =3D 0;=0A=
> +=0A=
> +		struct blk_range range;=0A=
> +		struct ioctl_range_s *ioctl_range;=0A=
> +=0A=
> +		ioctl_range =3D big_buffer_get_element(ranges, inx, sizeof(struct ioct=
l_range_s));=0A=
> +		if (ioctl_range =3D=3D NULL) {=0A=
> +			pr_err("Invalid count of ranges\n");=0A=
> +			res =3D -ENODATA;=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		range.ofs =3D (sector_t)to_sectors(ioctl_range->left);=0A=
> +		range.cnt =3D (blkcnt_t)to_sectors(ioctl_range->right) - range.ofs;=0A=
> +=0A=
> +		while (range_offset < range.cnt) {=0A=
> +			struct blk_range rg;=0A=
> +=0A=
> +			rg.ofs =3D range.ofs + range_offset;=0A=
> +			rg.cnt =3D min_t(sector_t, (range.cnt - range_offset),=0A=
> +				       (snapstore_block_size() - current_blk_size));=0A=
> +=0A=
> +			range_offset +=3D rg.cnt;=0A=
> +=0A=
> +			res =3D rangelist_add(&blk_rangelist, &rg);=0A=
> +			if (res !=3D SUCCESS) {=0A=
> +				pr_err("Unable to add file to snapstore: ");=0A=
> +				pr_err("cannot add range to rangelist\n");=0A=
> +				break;=0A=
> +			}=0A=
> +=0A=
> +			//zero sectors logic=0A=
> +			if (snapstore_device !=3D NULL) {=0A=
> +				res =3D rangevector_add(&snapstore_device->zero_sectors, &rg);=0A=
> +				if (res !=3D SUCCESS) {=0A=
> +					pr_err("Unable to add file to snapstore: ");=0A=
> +					pr_err("cannot add range to zero_sectors tree\n");=0A=
> +					break;=0A=
> +				}=0A=
> +			}=0A=
> +=0A=
> +			current_blk_size +=3D rg.cnt;=0A=
> +=0A=
> +			if (current_blk_size =3D=3D snapstore_block_size()) { //allocate  blo=
ck=0A=
> +				res =3D blk_descr_file_pool_add(&snapstore->file->pool,=0A=
> +							      &blk_rangelist);=0A=
> +				if (res !=3D SUCCESS) {=0A=
> +					pr_err("Unable to add file to snapstore: ");=0A=
> +					pr_err("cannot initialize new block\n");=0A=
> +					break;=0A=
> +				}=0A=
> +=0A=
> +				snapstore->halffilled =3D false;=0A=
> +=0A=
> +				current_blk_size =3D 0;=0A=
> +				INIT_LIST_HEAD(&blk_rangelist); //renew list=0A=
> +				++blocks_count;=0A=
> +			}=0A=
> +		}=0A=
> +		if (res !=3D SUCCESS)=0A=
> +			break;=0A=
> +	}=0A=
> +=0A=
> +	if ((res =3D=3D SUCCESS) && (current_blk_size !=3D 0))=0A=
> +		pr_warn("Snapstore portion was not ordered by Copy-on-Write block size=
\n");=0A=
> +=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +static int rangelist_ex_add(struct list_head *list, struct blk_range *rg=
,=0A=
> +			    struct block_device *blk_dev)=0A=
> +{=0A=
> +	struct blk_range_link_ex *range_link =3D=0A=
> +		kzalloc(sizeof(struct blk_range_link_ex), GFP_KERNEL);=0A=
> +	if (range_link =3D=3D NULL)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	INIT_LIST_HEAD(&range_link->link);=0A=
> +=0A=
> +	range_link->rg.ofs =3D rg->ofs;=0A=
> +	range_link->rg.cnt =3D rg->cnt;=0A=
> +	range_link->blk_dev =3D blk_dev;=0A=
> +=0A=
> +	list_add_tail(&range_link->link, list);=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +int snapstore_add_multidev(uuid_t *id, dev_t dev_id, struct big_buffer *=
ranges, size_t ranges_cnt)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	struct snapstore *snapstore =3D NULL;=0A=
> +	sector_t current_blk_size =3D 0;=0A=
> +	size_t inx;=0A=
> +	LIST_HEAD(blk_rangelist);=0A=
> +=0A=
> +	pr_info("Snapstore add %zu ranges for device [%d:%d]\n", ranges_cnt, MA=
JOR(dev_id),=0A=
> +		MINOR(dev_id));=0A=
> +=0A=
> +	if ((ranges_cnt =3D=3D 0) || (ranges =3D=3D NULL))=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	snapstore =3D _snapstore_find(id);=0A=
> +	if (snapstore =3D=3D NULL) {=0A=
> +		pr_err("Unable to add file to multidevice snapstore: ");=0A=
> +		pr_err("cannot find snapstore by id %pUB\n", id);=0A=
> +		return -ENODATA;=0A=
> +	}=0A=
> +=0A=
> +	if (snapstore->multidev =3D=3D NULL) {=0A=
> +		pr_err("Unable to add file to multidevice snapstore: ");=0A=
> +		pr_err("it was not initialized\n");=0A=
> +		return -EFAULT;=0A=
> +	}=0A=
> +=0A=
> +	for (inx =3D 0; inx < ranges_cnt; ++inx) {=0A=
> +		size_t blocks_count =3D 0;=0A=
> +		sector_t range_offset =3D 0;=0A=
> +		struct blk_range range;=0A=
> +		struct ioctl_range_s *data;=0A=
> +=0A=
> +		data =3D big_buffer_get_element(ranges, inx, sizeof(struct ioctl_range=
_s));=0A=
> +		if (data =3D=3D NULL) {=0A=
> +			pr_err("Invalid count of ranges\n");=0A=
> +			res =3D -ENODATA;=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		range.ofs =3D (sector_t)to_sectors(data->left);=0A=
> +		range.cnt =3D (blkcnt_t)to_sectors(data->right) - range.ofs;=0A=
> +=0A=
> +		while (range_offset < range.cnt) {=0A=
> +			struct blk_range rg;=0A=
> +			struct block_device *blk_dev =3D NULL;=0A=
> +=0A=
> +			rg.ofs =3D range.ofs + range_offset;=0A=
> +			rg.cnt =3D min_t(sector_t,=0A=
> +				       range.cnt - range_offset,=0A=
> +				       snapstore_block_size() - current_blk_size);=0A=
> +=0A=
> +			range_offset +=3D rg.cnt;=0A=
> +=0A=
> +			blk_dev =3D snapstore_multidev_get_device(snapstore->multidev, dev_id=
);=0A=
> +			if (blk_dev =3D=3D NULL) {=0A=
> +				pr_err("Cannot find or open device [%d:%d] for multidevice snapstore=
\n",=0A=
> +				       MAJOR(dev_id), MINOR(dev_id));=0A=
> +				res =3D -ENODEV;=0A=
> +				break;=0A=
> +			}=0A=
> +=0A=
> +			res =3D rangelist_ex_add(&blk_rangelist, &rg, blk_dev);=0A=
> +			if (res !=3D SUCCESS) {=0A=
> +				pr_err("Unable to add file to multidevice snapstore: ");=0A=
> +				pr_err("failed to add range to rangelist\n");=0A=
> +				break;=0A=
> +			}=0A=
> +=0A=
> +			/*=0A=
> +			 * zero sectors logic is not implemented for multidevice snapstore=0A=
> +			 */=0A=
> +=0A=
> +			current_blk_size +=3D rg.cnt;=0A=
> +=0A=
> +			if (current_blk_size =3D=3D snapstore_block_size()) { //allocate  blo=
ck=0A=
> +				res =3D blk_descr_multidev_pool_add(&snapstore->multidev->pool,=0A=
> +								  &blk_rangelist);=0A=
> +				if (res !=3D SUCCESS) {=0A=
> +					pr_err("Unable to add file to multidevice snapstore: ");=0A=
> +					pr_err("failed to initialize new block\n");=0A=
> +					break;=0A=
> +				}=0A=
> +=0A=
> +				snapstore->halffilled =3D false;=0A=
> +=0A=
> +				current_blk_size =3D 0;=0A=
> +				INIT_LIST_HEAD(&blk_rangelist);=0A=
> +				++blocks_count;=0A=
> +			}=0A=
> +		}=0A=
> +		if (res !=3D SUCCESS)=0A=
> +			break;=0A=
> +	}=0A=
> +=0A=
> +	if ((res =3D=3D SUCCESS) && (current_blk_size !=3D 0))=0A=
> +		pr_warn("Snapstore portion was not ordered by Copy-on-Write block size=
\n");=0A=
> +=0A=
> +	return res;=0A=
> +}=0A=
> +#endif=0A=
> +=0A=
> +void snapstore_order_border(struct blk_range *in, struct blk_range *out)=
=0A=
> +{=0A=
> +	struct blk_range unorder;=0A=
> +=0A=
> +	unorder.ofs =3D in->ofs & snapstore_block_mask();=0A=
> +	out->ofs =3D in->ofs & ~snapstore_block_mask();=0A=
> +	out->cnt =3D in->cnt + unorder.ofs;=0A=
> +=0A=
> +	unorder.cnt =3D out->cnt & snapstore_block_mask();=0A=
> +	if (unorder.cnt !=3D 0)=0A=
> +		out->cnt +=3D (snapstore_block_size() - unorder.cnt);=0A=
> +}=0A=
> +=0A=
> +union blk_descr_unify snapstore_get_empty_block(struct snapstore *snapst=
ore)=0A=
> +{=0A=
> +	union blk_descr_unify result =3D { NULL };=0A=
> +=0A=
> +	if (snapstore->overflowed)=0A=
> +		return result;=0A=
> +=0A=
> +	if (snapstore->file !=3D NULL)=0A=
> +		result =3D blk_descr_file_pool_take(&snapstore->file->pool);=0A=
> +	else if (snapstore->multidev !=3D NULL)=0A=
> +		result =3D blk_descr_multidev_pool_take(&snapstore->multidev->pool);=
=0A=
> +	else if (snapstore->mem !=3D NULL)=0A=
> +		result =3D blk_descr_mem_pool_take(&snapstore->mem->pool);=0A=
> +=0A=
> +	if (result.ptr =3D=3D NULL) {=0A=
> +		if (snapstore->ctrl_pipe) {=0A=
> +			sector_t fill_status;=0A=
> +=0A=
> +			_snapstore_check_halffill(snapstore, &fill_status);=0A=
> +			ctrl_pipe_request_overflow(snapstore->ctrl_pipe, -EINVAL,=0A=
> +						   (u64)from_sectors(fill_status));=0A=
> +		}=0A=
> +		snapstore->overflowed =3D true;=0A=
> +	}=0A=
> +=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
> +int snapstore_check_halffill(uuid_t *unique_id, sector_t *fill_status)=
=0A=
> +{=0A=
> +	struct snapstore *snapstore;=0A=
> +=0A=
> +	snapstore =3D _snapstore_find(unique_id);=0A=
> +	if (snapstore =3D=3D NULL) {=0A=
> +		pr_err("Cannot find snapstore by uuid %pUB\n", unique_id);=0A=
> +		return -ENODATA;=0A=
> +	}=0A=
> +=0A=
> +	_snapstore_check_halffill(snapstore, fill_status);=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +int snapstore_request_store(struct snapstore *snapstore, struct blk_defe=
rred_request *dio_copy_req)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +=0A=
> +	if (snapstore->ctrl_pipe) {=0A=
> +		if (!snapstore->halffilled) {=0A=
> +			sector_t fill_status =3D 0;=0A=
> +=0A=
> +			if (_snapstore_check_halffill(snapstore, &fill_status)) {=0A=
> +				snapstore->halffilled =3D true;=0A=
> +				ctrl_pipe_request_halffill(snapstore->ctrl_pipe,=0A=
> +							   (u64)from_sectors(fill_status));=0A=
> +			}=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	if (snapstore->file)=0A=
> +		res =3D blk_deferred_request_store_file(snapstore->file->blk_dev, dio_=
copy_req);=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +	else if (snapstore->multidev)=0A=
> +		res =3D blk_deferred_request_store_multidev(dio_copy_req);=0A=
> +#endif=0A=
> +	else if (snapstore->mem)=0A=
> +		res =3D blk_deferred_request_store_mem(dio_copy_req);=0A=
> +	else=0A=
> +		res =3D -EINVAL;=0A=
> +=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +static int _snapstore_redirect_read_file(struct blk_redirect_bio *rq_red=
ir,=0A=
> +					 struct block_device *snapstore_blk_dev,=0A=
> +					 struct blk_descr_file *file,=0A=
> +					 sector_t block_ofs,=0A=
> +					 sector_t rq_ofs, sector_t rq_count)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	sector_t current_ofs =3D 0;=0A=
> +	struct list_head *_list_head;=0A=
> +=0A=
> +	if (unlikely(list_empty(&file->rangelist))) {=0A=
> +		pr_err("Invalid file block descriptor");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	list_for_each(_list_head, &file->rangelist) {=0A=
> +		struct blk_range_link *range_link;=0A=
> +=0A=
> +		range_link =3D list_entry(_list_head, struct blk_range_link, link);=0A=
> +		if (current_ofs >=3D rq_count)=0A=
> +			break;=0A=
> +=0A=
> +		if (range_link->rg.cnt > block_ofs) {=0A=
> +			sector_t pos =3D range_link->rg.ofs + block_ofs;=0A=
> +			sector_t len =3D min_t(sector_t,=0A=
> +					     range_link->rg.cnt - block_ofs,=0A=
> +					     rq_count - current_ofs);=0A=
> +=0A=
> +			res =3D blk_dev_redirect_part(rq_redir, READ, snapstore_blk_dev, pos,=
=0A=
> +						    rq_ofs + current_ofs, len);=0A=
> +			if (res !=3D SUCCESS) {=0A=
> +				pr_err("Failed to read from snapstore file. Sector #%lld\n",=0A=
> +				       pos);=0A=
> +				break;=0A=
> +			}=0A=
> +=0A=
> +			current_ofs +=3D len;=0A=
> +			block_ofs =3D 0;=0A=
> +		} else=0A=
> +			block_ofs -=3D range_link->rg.cnt;=0A=
> +	}=0A=
> +=0A=
> +	if (res !=3D SUCCESS)=0A=
> +		pr_err("Failed to read from file snapstore\n");=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +static int _snapstore_redirect_read_multidev(struct blk_redirect_bio *rq=
_redir,=0A=
> +					      struct blk_descr_multidev *multidev,=0A=
> +					      sector_t block_ofs,=0A=
> +					      sector_t rq_ofs, sector_t rq_count)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	sector_t current_ofs =3D 0;=0A=
> +	struct list_head *_list_head;=0A=
> +=0A=
> +	if (unlikely(list_empty(&multidev->rangelist))) {=0A=
> +		pr_err("Invalid multidev block descriptor");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	list_for_each(_list_head, &multidev->rangelist) {=0A=
> +		struct blk_range_link_ex *range_link =3D=0A=
> +			list_entry(_list_head, struct blk_range_link_ex, link);=0A=
> +=0A=
> +		if (current_ofs >=3D rq_count)=0A=
> +			break;=0A=
> +=0A=
> +		if (range_link->rg.cnt > block_ofs) {=0A=
> +			sector_t pos =3D range_link->rg.ofs + block_ofs;=0A=
> +			sector_t len =3D min_t(sector_t,=0A=
> +					     range_link->rg.cnt - block_ofs,=0A=
> +					     rq_count - current_ofs);=0A=
> +=0A=
> +			res =3D blk_dev_redirect_part(rq_redir, READ, range_link->blk_dev, po=
s,=0A=
> +						    rq_ofs + current_ofs, len);=0A=
> +=0A=
> +			if (res !=3D SUCCESS) {=0A=
> +				pr_err("Failed to read from snapstore file. Sector #%lld\n", pos);=
=0A=
> +				break;=0A=
> +			}=0A=
> +=0A=
> +			current_ofs +=3D len;=0A=
> +			block_ofs =3D 0;=0A=
> +		} else=0A=
> +			block_ofs -=3D range_link->rg.cnt;=0A=
> +	}=0A=
> +=0A=
> +	if (res !=3D SUCCESS)=0A=
> +		pr_err("Failed to read from multidev snapstore\n");=0A=
> +	return res;=0A=
> +}=0A=
> +#endif=0A=
> +=0A=
> +int snapstore_redirect_read(struct blk_redirect_bio *rq_redir, struct sn=
apstore *snapstore,=0A=
> +			    union blk_descr_unify blk_descr, sector_t target_pos, sector_t rq=
_ofs,=0A=
> +			    sector_t rq_count)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	sector_t block_ofs =3D target_pos & snapstore_block_mask();=0A=
> +=0A=
> +	if (snapstore->file)=0A=
> +		res =3D _snapstore_redirect_read_file(rq_redir, snapstore->file->blk_d=
ev,=0A=
> +						    blk_descr.file, block_ofs, rq_ofs, rq_count);=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +	else if (snapstore->multidev)=0A=
> +		res =3D _snapstore_redirect_read_multidev(rq_redir, blk_descr.multidev=
, block_ofs,=0A=
> +							rq_ofs, rq_count);=0A=
> +#endif=0A=
> +	else if (snapstore->mem) {=0A=
> +		res =3D blk_dev_redirect_memcpy_part(=0A=
> +			rq_redir, READ, blk_descr.mem->buff + (size_t)from_sectors(block_ofs)=
,=0A=
> +			rq_ofs, rq_count);=0A=
> +=0A=
> +		if (res !=3D SUCCESS)=0A=
> +			pr_err("Failed to read from snapstore memory\n");=0A=
> +	} else=0A=
> +		res =3D -EINVAL;=0A=
> +=0A=
> +	if (res !=3D SUCCESS)=0A=
> +		pr_err("Failed to read from snapstore. Offset %lld sector\n", target_p=
os);=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +static int _snapstore_redirect_write_file(struct blk_redirect_bio *rq_re=
dir,=0A=
> +					  struct block_device *snapstore_blk_dev,=0A=
> +					  struct blk_descr_file *file,=0A=
> +					  sector_t block_ofs,=0A=
> +					  sector_t rq_ofs, sector_t rq_count)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	sector_t current_ofs =3D 0;=0A=
> +	struct list_head *_list_head;=0A=
> +=0A=
> +	if (unlikely(list_empty(&file->rangelist))) {=0A=
> +		pr_err("Invalid file block descriptor");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	list_for_each(_list_head, &file->rangelist) {=0A=
> +		struct blk_range_link *range_link;=0A=
> +=0A=
> +		range_link =3D list_entry(_list_head, struct blk_range_link, link);=0A=
> +		if (current_ofs >=3D rq_count)=0A=
> +			break;=0A=
> +=0A=
> +		if (range_link->rg.cnt > block_ofs) {=0A=
> +			sector_t pos =3D range_link->rg.ofs + block_ofs;=0A=
> +			sector_t len =3D min_t(sector_t,=0A=
> +					     range_link->rg.cnt - block_ofs,=0A=
> +					     rq_count - current_ofs);=0A=
> +=0A=
> +			res =3D blk_dev_redirect_part(rq_redir, WRITE, snapstore_blk_dev, pos=
,=0A=
> +						    rq_ofs + current_ofs, len);=0A=
> +=0A=
> +			if (res !=3D SUCCESS) {=0A=
> +				pr_err("Failed to write to snapstore file. Sector #%lld\n",=0A=
> +				       pos);=0A=
> +				break;=0A=
> +			}=0A=
> +=0A=
> +			current_ofs +=3D len;=0A=
> +			block_ofs =3D 0;=0A=
> +		} else=0A=
> +			block_ofs -=3D range_link->rg.cnt;=0A=
> +	}=0A=
> +	if (res !=3D SUCCESS)=0A=
> +		pr_err("Failed to write to file snapstore\n");=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +static int _snapstore_redirect_write_multidev(struct blk_redirect_bio *r=
q_redir,=0A=
> +					      struct blk_descr_multidev *multidev,=0A=
> +					      sector_t block_ofs,=0A=
> +					      sector_t rq_ofs, sector_t rq_count)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	sector_t current_ofs =3D 0;=0A=
> +	struct list_head *_list_head;=0A=
> +=0A=
> +	if (unlikely(list_empty(&multidev->rangelist))) {=0A=
> +		pr_err("Invalid multidev block descriptor");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	list_for_each(_list_head, &multidev->rangelist) {=0A=
> +		struct blk_range_link_ex *range_link;=0A=
> +=0A=
> +		range_link =3D list_entry(_list_head, struct blk_range_link_ex, link);=
=0A=
> +		if (current_ofs >=3D rq_count)=0A=
> +			break;=0A=
> +=0A=
> +		if (range_link->rg.cnt > block_ofs) {=0A=
> +			sector_t pos =3D range_link->rg.ofs + block_ofs;=0A=
> +			sector_t len =3D min_t(sector_t,=0A=
> +					     range_link->rg.cnt - block_ofs,=0A=
> +					     rq_count - current_ofs);=0A=
> +=0A=
> +			res =3D blk_dev_redirect_part(rq_redir, WRITE, range_link->blk_dev, p=
os,=0A=
> +						    rq_ofs + current_ofs, len);=0A=
> +=0A=
> +			if (res !=3D SUCCESS) {=0A=
> +				pr_err("Failed to write to snapstore file. Sector #%lld\n",=0A=
> +				       pos);=0A=
> +				break;=0A=
> +			}=0A=
> +=0A=
> +			current_ofs +=3D len;=0A=
> +			block_ofs =3D 0;=0A=
> +		} else=0A=
> +			block_ofs -=3D range_link->rg.cnt;=0A=
> +	}=0A=
> +=0A=
> +	if (res !=3D SUCCESS)=0A=
> +		pr_err("Failed to write to multidevice snapstore\n");=0A=
> +	return res;=0A=
> +}=0A=
> +#endif=0A=
> +=0A=
> +int snapstore_redirect_write(struct blk_redirect_bio *rq_redir, struct s=
napstore *snapstore,=0A=
> +			     union blk_descr_unify blk_descr, sector_t target_pos, sector_t r=
q_ofs,=0A=
> +			     sector_t rq_count)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	sector_t block_ofs =3D target_pos & snapstore_block_mask();=0A=
> +=0A=
> +	if (snapstore->file)=0A=
> +		res =3D _snapstore_redirect_write_file(rq_redir, snapstore->file->blk_=
dev,=0A=
> +						     blk_descr.file, block_ofs, rq_ofs, rq_count);=0A=
> +=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +	else if (snapstore->multidev)=0A=
> +		res =3D _snapstore_redirect_write_multidev(rq_redir, blk_descr.multide=
v,=0A=
> +							 block_ofs, rq_ofs, rq_count);=0A=
> +#endif=0A=
> +	else if (snapstore->mem) {=0A=
> +		res =3D blk_dev_redirect_memcpy_part(=0A=
> +			rq_redir, WRITE, blk_descr.mem->buff + (size_t)from_sectors(block_ofs=
),=0A=
> +			rq_ofs, rq_count);=0A=
> +=0A=
> +		if (res !=3D SUCCESS)=0A=
> +			pr_err("Failed to write to memory snapstore\n");=0A=
> +	} else {=0A=
> +		pr_err("Unable to write to snapstore: invalid type of snapstore device=
\n");=0A=
> +		res =3D -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	if (res !=3D SUCCESS)=0A=
> +		pr_err("Failed to write to snapstore. Offset %lld sector\n", target_po=
s);=0A=
> +	return res;=0A=
> +}=0A=
> diff --git a/drivers/block/blk-snap/snapstore.h b/drivers/block/blk-snap/=
snapstore.h=0A=
> new file mode 100644=0A=
> index 000000000000..db34ad2e2c58=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/snapstore.h=0A=
> @@ -0,0 +1,68 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
> +#pragma once=0A=
> +=0A=
> +#include <linux/uuid.h>=0A=
> +#include <linux/kref.h>=0A=
> +#include "blk-snap-ctl.h"=0A=
> +#include "rangevector.h"=0A=
> +#include "snapstore_mem.h"=0A=
> +#include "snapstore_file.h"=0A=
> +#include "snapstore_multidev.h"=0A=
> +#include "blk_redirect.h"=0A=
> +#include "ctrl_pipe.h"=0A=
> +#include "big_buffer.h"=0A=
> +=0A=
> +struct snapstore {=0A=
> +	struct list_head link;=0A=
> +	struct kref refcount;=0A=
> +=0A=
> +	uuid_t id;=0A=
> +=0A=
> +	struct snapstore_mem *mem;=0A=
> +	struct snapstore_file *file;=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +	struct snapstore_multidev *multidev;=0A=
> +#endif=0A=
> +=0A=
> +	struct ctrl_pipe *ctrl_pipe;=0A=
> +	sector_t empty_limit;=0A=
> +=0A=
> +	bool halffilled;=0A=
> +	bool overflowed;=0A=
> +};=0A=
> +=0A=
> +void snapstore_done(void);=0A=
> +=0A=
> +int snapstore_create(uuid_t *id, dev_t snapstore_dev_id, dev_t *dev_id_s=
et,=0A=
> +		     size_t dev_id_set_length);=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +int snapstore_create_multidev(uuid_t *id, dev_t *dev_id_set, size_t dev_=
id_set_length);=0A=
> +#endif=0A=
> +int snapstore_cleanup(uuid_t *id, u64 *filled_bytes);=0A=
> +=0A=
> +struct snapstore *snapstore_get(struct snapstore *snapstore);=0A=
> +void snapstore_put(struct snapstore *snapstore);=0A=
> +=0A=
> +int snapstore_stretch_initiate(uuid_t *unique_id, struct ctrl_pipe *ctrl=
_pipe,=0A=
> +			       sector_t empty_limit);=0A=
> +=0A=
> +int snapstore_add_memory(uuid_t *id, unsigned long long sz);=0A=
> +int snapstore_add_file(uuid_t *id, struct big_buffer *ranges, size_t ran=
ges_cnt);=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +int snapstore_add_multidev(uuid_t *id, dev_t dev_id, struct big_buffer *=
ranges, size_t ranges_cnt);=0A=
> +#endif=0A=
> +=0A=
> +void snapstore_order_border(struct blk_range *in, struct blk_range *out)=
;=0A=
> +=0A=
> +union blk_descr_unify snapstore_get_empty_block(struct snapstore *snapst=
ore);=0A=
> +=0A=
> +int snapstore_request_store(struct snapstore *snapstore, struct blk_defe=
rred_request *dio_copy_req);=0A=
> +=0A=
> +int snapstore_redirect_read(struct blk_redirect_bio *rq_redir, struct sn=
apstore *snapstore,=0A=
> +			    union blk_descr_unify blk_descr, sector_t target_pos, sector_t rq=
_ofs,=0A=
> +			    sector_t rq_count);=0A=
> +int snapstore_redirect_write(struct blk_redirect_bio *rq_redir, struct s=
napstore *snapstore,=0A=
> +			     union blk_descr_unify blk_descr, sector_t target_pos, sector_t r=
q_ofs,=0A=
> +			     sector_t rq_count);=0A=
> +=0A=
> +int snapstore_check_halffill(uuid_t *unique_id, sector_t *fill_status);=
=0A=
> diff --git a/drivers/block/blk-snap/snapstore_device.c b/drivers/block/bl=
k-snap/snapstore_device.c=0A=
> new file mode 100644=0A=
> index 000000000000..6fdeebacce22=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/snapstore_device.c=0A=
> @@ -0,0 +1,532 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#define BLK_SNAP_SECTION "-snapstore"=0A=
> +#include "common.h"=0A=
> +#include "snapstore_device.h"=0A=
> +#include "snapstore.h"=0A=
> +#include "params.h"=0A=
> +#include "blk_util.h"=0A=
> +=0A=
> +LIST_HEAD(snapstore_devices);=0A=
> +DECLARE_RWSEM(snapstore_devices_lock);=0A=
> +=0A=
> +static inline void _snapstore_device_descr_write_lock(struct snapstore_d=
evice *snapstore_device)=0A=
> +{=0A=
> +	mutex_lock(&snapstore_device->store_block_map_locker);=0A=
> +}=0A=
> +static inline void _snapstore_device_descr_write_unlock(struct snapstore=
_device *snapstore_device)=0A=
> +{=0A=
> +	mutex_unlock(&snapstore_device->store_block_map_locker);=0A=
> +}=0A=
> +=0A=
> +void snapstore_device_done(void)=0A=
> +{=0A=
> +	struct snapstore_device *snapstore_device =3D NULL;=0A=
> +=0A=
> +	do {=0A=
> +		down_write(&snapstore_devices_lock);=0A=
> +		if (!list_empty(&snapstore_devices)) {=0A=
> +			snapstore_device =3D=0A=
> +				list_entry(snapstore_devices.next, struct snapstore_device, link);=
=0A=
> +			list_del(&snapstore_device->link);=0A=
> +		}=0A=
> +		up_write(&snapstore_devices_lock);=0A=
> +=0A=
> +		if (snapstore_device)=0A=
> +			snapstore_device_put_resource(snapstore_device);=0A=
> +	} while (snapstore_device);=0A=
> +}=0A=
> +=0A=
> +struct snapstore_device *snapstore_device_find_by_dev_id(dev_t dev_id)=
=0A=
> +{=0A=
> +	struct snapstore_device *result =3D NULL;=0A=
> +=0A=
> +	down_read(&snapstore_devices_lock);=0A=
> +	if (!list_empty(&snapstore_devices)) {=0A=
> +		struct list_head *_head;=0A=
> +=0A=
> +		list_for_each(_head, &snapstore_devices) {=0A=
> +			struct snapstore_device *snapstore_device =3D=0A=
> +				list_entry(_head, struct snapstore_device, link);=0A=
> +=0A=
> +			if (dev_id =3D=3D snapstore_device->dev_id) {=0A=
> +				result =3D snapstore_device;=0A=
> +				break;=0A=
> +			}=0A=
> +		}=0A=
> +	}=0A=
> +	up_read(&snapstore_devices_lock);=0A=
> +=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
> +struct snapstore_device *_snapstore_device_get_by_snapstore_id(uuid_t *i=
d)=0A=
> +{=0A=
> +	struct snapstore_device *result =3D NULL;=0A=
> +=0A=
> +	down_write(&snapstore_devices_lock);=0A=
> +	if (!list_empty(&snapstore_devices)) {=0A=
> +		struct list_head *_head;=0A=
> +=0A=
> +		list_for_each(_head, &snapstore_devices) {=0A=
> +			struct snapstore_device *snapstore_device =3D=0A=
> +				list_entry(_head, struct snapstore_device, link);=0A=
> +=0A=
> +			if (uuid_equal(id, &snapstore_device->snapstore->id)) {=0A=
> +				result =3D snapstore_device;=0A=
> +				list_del(&snapstore_device->link);=0A=
> +				break;=0A=
> +			}=0A=
> +		}=0A=
> +	}=0A=
> +	up_write(&snapstore_devices_lock);=0A=
> +=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
> +static void _snapstore_device_destroy(struct snapstore_device *snapstore=
_device)=0A=
> +{=0A=
> +	pr_info("Destroy snapstore device\n");=0A=
> +=0A=
> +	xa_destroy(&snapstore_device->store_block_map);=0A=
> +=0A=
> +	if (snapstore_device->orig_blk_dev !=3D NULL)=0A=
> +		blk_dev_close(snapstore_device->orig_blk_dev);=0A=
> +=0A=
> +	rangevector_done(&snapstore_device->zero_sectors);=0A=
> +=0A=
> +	if (snapstore_device->snapstore) {=0A=
> +		pr_info("Snapstore uuid %pUB\n", &snapstore_device->snapstore->id);=0A=
> +=0A=
> +		snapstore_put(snapstore_device->snapstore);=0A=
> +		snapstore_device->snapstore =3D NULL;=0A=
> +	}=0A=
> +=0A=
> +	kfree(snapstore_device);=0A=
> +}=0A=
> +=0A=
> +static void snapstore_device_free_cb(struct kref *kref)=0A=
> +{=0A=
> +	struct snapstore_device *snapstore_device =3D=0A=
> +		container_of(kref, struct snapstore_device, refcount);=0A=
> +=0A=
> +	_snapstore_device_destroy(snapstore_device);=0A=
> +}=0A=
> +=0A=
> +struct snapstore_device *snapstore_device_get_resource(struct snapstore_=
device *snapstore_device)=0A=
> +{=0A=
> +	if (snapstore_device)=0A=
> +		kref_get(&snapstore_device->refcount);=0A=
> +=0A=
> +	return snapstore_device;=0A=
> +};=0A=
> +=0A=
> +void snapstore_device_put_resource(struct snapstore_device *snapstore_de=
vice)=0A=
> +{=0A=
> +	if (snapstore_device)=0A=
> +		kref_put(&snapstore_device->refcount, snapstore_device_free_cb);=0A=
> +};=0A=
> +=0A=
> +int snapstore_device_cleanup(uuid_t *id)=0A=
> +{=0A=
> +	int result =3D SUCCESS;=0A=
> +	struct snapstore_device *snapstore_device =3D NULL;=0A=
> +=0A=
> +	while (NULL !=3D (snapstore_device =3D _snapstore_device_get_by_snapsto=
re_id(id))) {=0A=
> +		pr_info("Cleanup snapstore device for device [%d:%d]\n",=0A=
> +			MAJOR(snapstore_device->dev_id), MINOR(snapstore_device->dev_id));=0A=
> +=0A=
> +		snapstore_device_put_resource(snapstore_device);=0A=
> +	}=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
> +int snapstore_device_create(dev_t dev_id, struct snapstore *snapstore)=
=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	struct snapstore_device *snapstore_device =3D=0A=
> +		kzalloc(sizeof(struct snapstore_device), GFP_KERNEL);=0A=
> +=0A=
> +	if (snapstore_device =3D=3D NULL)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	INIT_LIST_HEAD(&snapstore_device->link);=0A=
> +	snapstore_device->dev_id =3D dev_id;=0A=
> +=0A=
> +	res =3D blk_dev_open(dev_id, &snapstore_device->orig_blk_dev);=0A=
> +	if (res !=3D SUCCESS) {=0A=
> +		kfree(snapstore_device);=0A=
> +=0A=
> +		pr_err("Unable to create snapstore device: failed to open original dev=
ice [%d:%d]\n",=0A=
> +		       MAJOR(dev_id), MINOR(dev_id));=0A=
> +		return res;=0A=
> +	}=0A=
> +=0A=
> +	kref_init(&snapstore_device->refcount);=0A=
> +=0A=
> +	snapstore_device->snapstore =3D NULL;=0A=
> +	snapstore_device->err_code =3D SUCCESS;=0A=
> +	snapstore_device->corrupted =3D false;=0A=
> +	atomic_set(&snapstore_device->req_failed_cnt, 0);=0A=
> +=0A=
> +	mutex_init(&snapstore_device->store_block_map_locker);=0A=
> +=0A=
> +	rangevector_init(&snapstore_device->zero_sectors);=0A=
> +=0A=
> +	xa_init(&snapstore_device->store_block_map);=0A=
> +=0A=
> +	snapstore_device->snapstore =3D snapstore_get(snapstore);=0A=
> +=0A=
> +	down_write(&snapstore_devices_lock);=0A=
> +	list_add_tail(&snapstore_device->link, &snapstore_devices);=0A=
> +	up_write(&snapstore_devices_lock);=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +int snapstore_device_add_request(struct snapstore_device *snapstore_devi=
ce,=0A=
> +				 unsigned long block_index,=0A=
> +				 struct blk_deferred_request **dio_copy_req)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	union blk_descr_unify blk_descr =3D { NULL };=0A=
> +	struct blk_deferred_io *dio =3D NULL;=0A=
> +	bool req_new =3D false;=0A=
> +=0A=
> +	blk_descr =3D snapstore_get_empty_block(snapstore_device->snapstore);=
=0A=
> +	if (blk_descr.ptr =3D=3D NULL) {=0A=
> +		pr_err("Unable to add block to defer IO request: failed to allocate ne=
xt block\n");=0A=
> +		return -ENODATA;=0A=
> +	}=0A=
> +=0A=
> +	res =3D xa_err(=0A=
> +		xa_store(&snapstore_device->store_block_map, block_index, blk_descr.pt=
r, GFP_NOIO));=0A=
> +	if (res !=3D SUCCESS) {=0A=
> +		pr_err("Unable to add block to defer IO request: failed to set block d=
escriptor to descriptors array. errno=3D%d\n",=0A=
> +		       res);=0A=
> +		return res;=0A=
> +	}=0A=
> +=0A=
> +	if (*dio_copy_req =3D=3D NULL) {=0A=
> +		*dio_copy_req =3D blk_deferred_request_new();=0A=
> +		if (*dio_copy_req =3D=3D NULL) {=0A=
> +			pr_err("Unable to add block to defer IO request: failed to allocate d=
efer IO request\n");=0A=
> +			return -ENOMEM;=0A=
> +		}=0A=
> +		req_new =3D true;=0A=
> +	}=0A=
> +=0A=
> +	do {=0A=
> +		dio =3D blk_deferred_alloc(block_index, blk_descr);=0A=
> +		if (dio =3D=3D NULL) {=0A=
> +			pr_err("Unabled to add block to defer IO request: failed to allocate =
defer IO\n");=0A=
> +			res =3D -ENOMEM;=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		res =3D blk_deferred_request_add(*dio_copy_req, dio);=0A=
> +		if (res !=3D SUCCESS)=0A=
> +			pr_err("Unable to add block to defer IO request: failed to add defer =
IO to request\n");=0A=
> +	} while (false);=0A=
> +=0A=
> +	if (res !=3D SUCCESS) {=0A=
> +		if (dio !=3D NULL) {=0A=
> +			blk_deferred_free(dio);=0A=
> +			dio =3D NULL;=0A=
> +		}=0A=
> +		if (req_new) {=0A=
> +			blk_deferred_request_free(*dio_copy_req);=0A=
> +			*dio_copy_req =3D NULL;=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +int snapstore_device_prepare_requests(struct snapstore_device *snapstore=
_device,=0A=
> +				      struct blk_range *copy_range,=0A=
> +				      struct blk_deferred_request **dio_copy_req)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	unsigned long inx =3D 0;=0A=
> +	unsigned long first =3D (unsigned long)(copy_range->ofs >> snapstore_bl=
ock_shift());=0A=
> +	unsigned long last =3D=0A=
> +		(unsigned long)((copy_range->ofs + copy_range->cnt - 1) >> snapstore_b=
lock_shift());=0A=
> +=0A=
> +	for (inx =3D first; inx <=3D last; inx++) {=0A=
> +		if (xa_load(&snapstore_device->store_block_map, inx) =3D=3D NULL) {=0A=
> +			res =3D snapstore_device_add_request(snapstore_device, inx, dio_copy_=
req);=0A=
> +			if (res !=3D SUCCESS) {=0A=
> +				pr_err("Failed to create copy defer IO request. errno=3D%d\n", res);=
=0A=
> +				break;=0A=
> +			}=0A=
> +		}=0A=
> +		/*=0A=
> +		 * If xa_load() return not NULL, then block already stored.=0A=
> +		 */=0A=
> +	}=0A=
> +	if (res !=3D SUCCESS)=0A=
> +		snapstore_device_set_corrupted(snapstore_device, res);=0A=
> +=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +int snapstore_device_store(struct snapstore_device *snapstore_device,=0A=
> +			   struct blk_deferred_request *dio_copy_req)=0A=
> +{=0A=
> +	int res;=0A=
> +=0A=
> +	res =3D snapstore_request_store(snapstore_device->snapstore, dio_copy_r=
eq);=0A=
> +	if (res !=3D SUCCESS)=0A=
> +		snapstore_device_set_corrupted(snapstore_device, res);=0A=
> +=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +int snapstore_device_read(struct snapstore_device *snapstore_device,=0A=
> +			  struct blk_redirect_bio *rq_redir)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +=0A=
> +	unsigned long block_index;=0A=
> +	unsigned long block_index_last;=0A=
> +	unsigned long block_index_first;=0A=
> +=0A=
> +	sector_t blk_ofs_start =3D 0; //device range start=0A=
> +	sector_t blk_ofs_count =3D 0; //device range length=0A=
> +=0A=
> +	struct blk_range rq_range;=0A=
> +	struct rangevector *zero_sectors =3D &snapstore_device->zero_sectors;=
=0A=
> +=0A=
> +	if (snapstore_device_is_corrupted(snapstore_device))=0A=
> +		return -ENODATA;=0A=
> +=0A=
> +	rq_range.cnt =3D bio_sectors(rq_redir->bio);=0A=
> +	rq_range.ofs =3D rq_redir->bio->bi_iter.bi_sector;=0A=
> +=0A=
> +	if (!bio_has_data(rq_redir->bio)) {=0A=
> +		pr_warn("Empty bio was found during reading from snapstore device. fla=
gs=3D%u\n",=0A=
> +			rq_redir->bio->bi_flags);=0A=
> +=0A=
> +		blk_redirect_complete(rq_redir, SUCCESS);=0A=
> +		return SUCCESS;=0A=
> +	}=0A=
> +=0A=
> +	block_index_first =3D (unsigned long)(rq_range.ofs >> snapstore_block_s=
hift());=0A=
> +	block_index_last =3D=0A=
> +		(unsigned long)((rq_range.ofs + rq_range.cnt - 1) >> snapstore_block_s=
hift());=0A=
> +=0A=
> +	_snapstore_device_descr_write_lock(snapstore_device);=0A=
> +	for (block_index =3D block_index_first; block_index <=3D block_index_la=
st; ++block_index) {=0A=
> +		union blk_descr_unify blk_descr;=0A=
> +=0A=
> +		blk_ofs_count =3D min_t(sector_t,=0A=
> +				      (((sector_t)(block_index + 1)) << snapstore_block_shift()) -=
=0A=
> +					      (rq_range.ofs + blk_ofs_start),=0A=
> +				      rq_range.cnt - blk_ofs_start);=0A=
> +=0A=
> +		blk_descr =3D (union blk_descr_unify)xa_load(&snapstore_device->store_=
block_map,=0A=
> +							   block_index);=0A=
> +		if (blk_descr.ptr) {=0A=
> +			//push snapstore read=0A=
> +			res =3D snapstore_redirect_read(rq_redir, snapstore_device->snapstore=
,=0A=
> +						      blk_descr, rq_range.ofs + blk_ofs_start,=0A=
> +						      blk_ofs_start, blk_ofs_count);=0A=
> +			if (res !=3D SUCCESS) {=0A=
> +				pr_err("Failed to read from snapstore device\n");=0A=
> +				break;=0A=
> +			}=0A=
> +		} else {=0A=
> +			//device read with zeroing=0A=
> +			if (zero_sectors)=0A=
> +				res =3D blk_dev_redirect_read_zeroed(rq_redir,=0A=
> +								   snapstore_device->orig_blk_dev,=0A=
> +								   rq_range.ofs, blk_ofs_start,=0A=
> +								   blk_ofs_count, zero_sectors);=0A=
> +			else=0A=
> +				res =3D blk_dev_redirect_part(rq_redir, READ,=0A=
> +							    snapstore_device->orig_blk_dev,=0A=
> +							    rq_range.ofs + blk_ofs_start,=0A=
> +							    blk_ofs_start, blk_ofs_count);=0A=
> +=0A=
> +			if (res !=3D SUCCESS) {=0A=
> +				pr_err("Failed to redirect read request to the original device [%d:%=
d]\n",=0A=
> +				       MAJOR(snapstore_device->dev_id),=0A=
> +				       MINOR(snapstore_device->dev_id));=0A=
> +				break;=0A=
> +			}=0A=
> +		}=0A=
> +=0A=
> +		blk_ofs_start +=3D blk_ofs_count;=0A=
> +	}=0A=
> +=0A=
> +	if (res =3D=3D SUCCESS) {=0A=
> +		if (atomic64_read(&rq_redir->bio_count) > 0ll) //async direct access n=
eeded=0A=
> +			blk_dev_redirect_submit(rq_redir);=0A=
> +		else=0A=
> +			blk_redirect_complete(rq_redir, res);=0A=
> +	} else {=0A=
> +		pr_err("Failed to read from snapstore device. errno=3D%d\n", res);=0A=
> +		pr_err("Position %lld sector, length %lld sectors\n", rq_range.ofs, rq=
_range.cnt);=0A=
> +	}=0A=
> +	_snapstore_device_descr_write_unlock(snapstore_device);=0A=
> +=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +int _snapstore_device_copy_on_write(struct snapstore_device *snapstore_d=
evice,=0A=
> +				    struct blk_range *rq_range)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	struct blk_deferred_request *dio_copy_req =3D NULL;=0A=
> +=0A=
> +	mutex_lock(&snapstore_device->store_block_map_locker);=0A=
> +	do {=0A=
> +		res =3D snapstore_device_prepare_requests(snapstore_device, rq_range, =
&dio_copy_req);=0A=
> +		if (res !=3D SUCCESS) {=0A=
> +			pr_err("Failed to create defer IO request for range. errno=3D%d\n", r=
es);=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		if (dio_copy_req =3D=3D NULL)=0A=
> +			break; //nothing to copy=0A=
> +=0A=
> +		res =3D blk_deferred_request_read_original(snapstore_device->orig_blk_=
dev,=0A=
> +							 dio_copy_req);=0A=
> +		if (res !=3D SUCCESS) {=0A=
> +			pr_err("Failed to read data from the original device. errno=3D%d\n", =
res);=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		res =3D snapstore_device_store(snapstore_device, dio_copy_req);=0A=
> +		if (res !=3D SUCCESS) {=0A=
> +			pr_err("Failed to write data to snapstore. errno=3D%d\n", res);=0A=
> +			break;=0A=
> +		}=0A=
> +	} while (false);=0A=
> +	mutex_unlock(&snapstore_device->store_block_map_locker);=0A=
> +=0A=
> +	if (dio_copy_req) {=0A=
> +		if (res =3D=3D -EDEADLK)=0A=
> +			blk_deferred_request_deadlocked(dio_copy_req);=0A=
> +		else=0A=
> +			blk_deferred_request_free(dio_copy_req);=0A=
> +	}=0A=
> +=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +int snapstore_device_write(struct snapstore_device *snapstore_device,=0A=
> +			   struct blk_redirect_bio *rq_redir)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	unsigned long block_index;=0A=
> +	unsigned long block_index_last;=0A=
> +	unsigned long block_index_first;=0A=
> +	sector_t blk_ofs_start =3D 0; //device range start=0A=
> +	sector_t blk_ofs_count =3D 0; //device range length=0A=
> +	struct blk_range rq_range;=0A=
> +=0A=
> +	if (snapstore_device_is_corrupted(snapstore_device))=0A=
> +		return -ENODATA;=0A=
> +=0A=
> +	rq_range.cnt =3D bio_sectors(rq_redir->bio);=0A=
> +	rq_range.ofs =3D rq_redir->bio->bi_iter.bi_sector;=0A=
> +=0A=
> +	if (!bio_has_data(rq_redir->bio)) {=0A=
> +		pr_warn("Empty bio was found during reading from snapstore device. fla=
gs=3D%u\n",=0A=
> +			rq_redir->bio->bi_flags);=0A=
> +=0A=
> +		blk_redirect_complete(rq_redir, SUCCESS);=0A=
> +		return SUCCESS;=0A=
> +	}=0A=
> +=0A=
> +	// do copy to snapstore previously=0A=
> +	res =3D _snapstore_device_copy_on_write(snapstore_device, &rq_range);=
=0A=
> +=0A=
> +	block_index_first =3D (unsigned long)(rq_range.ofs >> snapstore_block_s=
hift());=0A=
> +	block_index_last =3D=0A=
> +		(unsigned long)((rq_range.ofs + rq_range.cnt - 1) >> snapstore_block_s=
hift());=0A=
> +=0A=
> +	_snapstore_device_descr_write_lock(snapstore_device);=0A=
> +	for (block_index =3D block_index_first; block_index <=3D block_index_la=
st; ++block_index) {=0A=
> +		union blk_descr_unify blk_descr;=0A=
> +=0A=
> +		blk_ofs_count =3D min_t(sector_t,=0A=
> +				      (((sector_t)(block_index + 1)) << snapstore_block_shift()) -=
=0A=
> +					      (rq_range.ofs + blk_ofs_start),=0A=
> +				      rq_range.cnt - blk_ofs_start);=0A=
> +=0A=
> +		blk_descr =3D (union blk_descr_unify)xa_load(&snapstore_device->store_=
block_map,=0A=
> +							   block_index);=0A=
> +		if (blk_descr.ptr =3D=3D NULL) {=0A=
> +			pr_err("Unable to write from snapstore device: invalid snapstore bloc=
k descriptor\n");=0A=
> +			res =3D -EIO;=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		res =3D snapstore_redirect_write(rq_redir, snapstore_device->snapstore=
, blk_descr,=0A=
> +					       rq_range.ofs + blk_ofs_start, blk_ofs_start,=0A=
> +					       blk_ofs_count);=0A=
> +		if (res !=3D SUCCESS) {=0A=
> +			pr_err("Unable to write from snapstore device: failed to redirect wri=
te request to snapstore\n");=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		blk_ofs_start +=3D blk_ofs_count;=0A=
> +	}=0A=
> +	if (res =3D=3D SUCCESS) {=0A=
> +		if (atomic64_read(&rq_redir->bio_count) > 0) { //async direct access n=
eeded=0A=
> +			blk_dev_redirect_submit(rq_redir);=0A=
> +		} else {=0A=
> +			blk_redirect_complete(rq_redir, res);=0A=
> +		}=0A=
> +	} else {=0A=
> +		pr_err("Failed to write from snapstore device. errno=3D%d\n", res);=0A=
> +		pr_err("Position %lld sector, length %lld sectors\n", rq_range.ofs, rq=
_range.cnt);=0A=
> +=0A=
> +		snapstore_device_set_corrupted(snapstore_device, res);=0A=
> +	}=0A=
> +	_snapstore_device_descr_write_unlock(snapstore_device);=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +bool snapstore_device_is_corrupted(struct snapstore_device *snapstore_de=
vice)=0A=
> +{=0A=
> +	if (snapstore_device =3D=3D NULL)=0A=
> +		return true;=0A=
> +=0A=
> +	if (snapstore_device->corrupted) {=0A=
> +		if (atomic_read(&snapstore_device->req_failed_cnt) =3D=3D 0)=0A=
> +			pr_err("Snapshot device is corrupted for [%d:%d]\n",=0A=
> +			       MAJOR(snapstore_device->dev_id), MINOR(snapstore_device->dev_i=
d));=0A=
> +=0A=
> +		atomic_inc(&snapstore_device->req_failed_cnt);=0A=
> +		return true;=0A=
> +	}=0A=
> +=0A=
> +	return false;=0A=
> +}=0A=
> +=0A=
> +void snapstore_device_set_corrupted(struct snapstore_device *snapstore_d=
evice, int err_code)=0A=
> +{=0A=
> +	if (!snapstore_device->corrupted) {=0A=
> +		atomic_set(&snapstore_device->req_failed_cnt, 0);=0A=
> +		snapstore_device->corrupted =3D true;=0A=
> +		snapstore_device->err_code =3D abs(err_code);=0A=
> +=0A=
> +		pr_err("Set snapshot device is corrupted for [%d:%d]\n",=0A=
> +		       MAJOR(snapstore_device->dev_id), MINOR(snapstore_device->dev_id=
));=0A=
> +	}=0A=
> +}=0A=
> +=0A=
> +int snapstore_device_errno(dev_t dev_id, int *p_err_code)=0A=
> +{=0A=
> +	struct snapstore_device *snapstore_device;=0A=
> +=0A=
> +	snapstore_device =3D snapstore_device_find_by_dev_id(dev_id);=0A=
> +	if (snapstore_device =3D=3D NULL)=0A=
> +		return -ENODATA;=0A=
> +=0A=
> +	*p_err_code =3D snapstore_device->err_code;=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> diff --git a/drivers/block/blk-snap/snapstore_device.h b/drivers/block/bl=
k-snap/snapstore_device.h=0A=
> new file mode 100644=0A=
> index 000000000000..729b3c05ef70=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/snapstore_device.h=0A=
> @@ -0,0 +1,63 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
> +#pragma once=0A=
> +=0A=
> +#include "rangevector.h"=0A=
> +#include "blk_deferred.h"=0A=
> +#include "blk_redirect.h"=0A=
> +#include "snapstore.h"=0A=
> +#include <linux/xarray.h>=0A=
> +#include <linux/kref.h>=0A=
> +=0A=
> +struct snapstore_device {=0A=
> +	struct list_head link;=0A=
> +	struct kref refcount;=0A=
> +=0A=
> +	dev_t dev_id;=0A=
> +	struct snapstore *snapstore;=0A=
> +=0A=
> +	struct block_device *orig_blk_dev;=0A=
> +=0A=
> +	struct xarray store_block_map; // map block index to read block offset=
=0A=
> +	struct mutex store_block_map_locker;=0A=
> +=0A=
> +	struct rangevector zero_sectors;=0A=
> +=0A=
> +	atomic_t req_failed_cnt;=0A=
> +	int err_code;=0A=
> +	bool corrupted;=0A=
> +};=0A=
> +=0A=
> +void snapstore_device_done(void);=0A=
> +=0A=
> +struct snapstore_device *snapstore_device_get_resource(struct snapstore_=
device *snapstore_device);=0A=
> +void snapstore_device_put_resource(struct snapstore_device *snapstore_de=
vice);=0A=
> +=0A=
> +struct snapstore_device *snapstore_device_find_by_dev_id(dev_t dev_id);=
=0A=
> +=0A=
> +int snapstore_device_create(dev_t dev_id, struct snapstore *snapstore);=
=0A=
> +=0A=
> +int snapstore_device_cleanup(uuid_t *id);=0A=
> +=0A=
> +int snapstore_device_prepare_requests(struct snapstore_device *snapstore=
_device,=0A=
> +				      struct blk_range *copy_range,=0A=
> +				      struct blk_deferred_request **dio_copy_req);=0A=
> +int snapstore_device_store(struct snapstore_device *snapstore_device,=0A=
> +			   struct blk_deferred_request *dio_copy_req);=0A=
> +=0A=
> +int snapstore_device_read(struct snapstore_device *snapstore_device,=0A=
> +			  struct blk_redirect_bio *rq_redir); //request from image=0A=
> +int snapstore_device_write(struct snapstore_device *snapstore_device,=0A=
> +			   struct blk_redirect_bio *rq_redir); //request from image=0A=
> +=0A=
> +bool snapstore_device_is_corrupted(struct snapstore_device *snapstore_de=
vice);=0A=
> +void snapstore_device_set_corrupted(struct snapstore_device *snapstore_d=
evice, int err_code);=0A=
> +int snapstore_device_errno(dev_t dev_id, int *p_err_code);=0A=
> +=0A=
> +static inline void _snapstore_device_descr_read_lock(struct snapstore_de=
vice *snapstore_device)=0A=
> +{=0A=
> +	mutex_lock(&snapstore_device->store_block_map_locker);=0A=
> +}=0A=
> +static inline void _snapstore_device_descr_read_unlock(struct snapstore_=
device *snapstore_device)=0A=
> +{=0A=
> +	mutex_unlock(&snapstore_device->store_block_map_locker);=0A=
> +}=0A=
> diff --git a/drivers/block/blk-snap/snapstore_file.c b/drivers/block/blk-=
snap/snapstore_file.c=0A=
> new file mode 100644=0A=
> index 000000000000..a5c959a8070c=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/snapstore_file.c=0A=
> @@ -0,0 +1,52 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#define BLK_SNAP_SECTION "-snapstore"=0A=
> +#include "common.h"=0A=
> +#include "snapstore_file.h"=0A=
> +#include "blk_util.h"=0A=
> +=0A=
> +int snapstore_file_create(dev_t dev_id, struct snapstore_file **pfile)=
=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	struct snapstore_file *file;=0A=
> +=0A=
> +	pr_info("Single device file snapstore was created on device [%d:%d]\n",=
 MAJOR(dev_id),=0A=
> +	       MINOR(dev_id));=0A=
> +=0A=
> +	file =3D kzalloc(sizeof(struct snapstore_file), GFP_KERNEL);=0A=
> +	if (file =3D=3D NULL)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	res =3D blk_dev_open(dev_id, &file->blk_dev);=0A=
> +	if (res !=3D SUCCESS) {=0A=
> +		kfree(file);=0A=
> +		pr_err("Unable to create snapstore file: failed to open device [%d:%d]=
. errno=3D%d",=0A=
> +		       MAJOR(dev_id), MINOR(dev_id), res);=0A=
> +		return res;=0A=
> +	}=0A=
> +	{=0A=
> +		struct request_queue *q =3D bdev_get_queue(file->blk_dev);=0A=
> +=0A=
> +		pr_info("snapstore device logical block size %d\n", q->limits.logical_=
block_size);=0A=
> +		pr_info("snapstore device physical block size %d\n", q->limits.physica=
l_block_size);=0A=
> +	}=0A=
> +=0A=
> +	file->blk_dev_id =3D dev_id;=0A=
> +	blk_descr_file_pool_init(&file->pool);=0A=
> +=0A=
> +	*pfile =3D file;=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +void snapstore_file_destroy(struct snapstore_file *file)=0A=
> +{=0A=
> +	if (file) {=0A=
> +		blk_descr_file_pool_done(&file->pool);=0A=
> +=0A=
> +		if (file->blk_dev !=3D NULL) {=0A=
> +			blk_dev_close(file->blk_dev);=0A=
> +			file->blk_dev =3D NULL;=0A=
> +		}=0A=
> +=0A=
> +		kfree(file);=0A=
> +	}=0A=
> +}=0A=
> diff --git a/drivers/block/blk-snap/snapstore_file.h b/drivers/block/blk-=
snap/snapstore_file.h=0A=
> new file mode 100644=0A=
> index 000000000000..effd9d888781=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/snapstore_file.h=0A=
> @@ -0,0 +1,15 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
> +#pragma once=0A=
> +=0A=
> +#include "blk_deferred.h"=0A=
> +=0A=
> +struct snapstore_file {=0A=
> +	dev_t blk_dev_id;=0A=
> +	struct block_device *blk_dev;=0A=
> +=0A=
> +	struct blk_descr_pool pool;=0A=
> +};=0A=
> +=0A=
> +int snapstore_file_create(dev_t dev_id, struct snapstore_file **pfile);=
=0A=
> +=0A=
> +void snapstore_file_destroy(struct snapstore_file *file);=0A=
> diff --git a/drivers/block/blk-snap/snapstore_mem.c b/drivers/block/blk-s=
nap/snapstore_mem.c=0A=
> new file mode 100644=0A=
> index 000000000000..29a607617d99=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/snapstore_mem.c=0A=
> @@ -0,0 +1,91 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#define BLK_SNAP_SECTION "-snapstore"=0A=
> +#include "common.h"=0A=
> +#include "snapstore_mem.h"=0A=
> +#include "params.h"=0A=
> +=0A=
> +#include <linux/vmalloc.h>=0A=
> +=0A=
> +struct buffer_el {=0A=
> +	struct list_head link;=0A=
> +	void *buff;=0A=
> +};=0A=
> +=0A=
> +struct snapstore_mem *snapstore_mem_create(size_t available_blocks)=0A=
> +{=0A=
> +	struct snapstore_mem *mem =3D kzalloc(sizeof(struct snapstore_mem), GFP=
_KERNEL);=0A=
> +=0A=
> +	if (mem =3D=3D NULL)=0A=
> +		return NULL;=0A=
> +=0A=
> +	blk_descr_mem_pool_init(&mem->pool, available_blocks);=0A=
> +=0A=
> +	mem->blocks_limit =3D available_blocks;=0A=
> +=0A=
> +	INIT_LIST_HEAD(&mem->blocks);=0A=
> +	mutex_init(&mem->blocks_lock);=0A=
> +=0A=
> +	return mem;=0A=
> +}=0A=
> +=0A=
> +void snapstore_mem_destroy(struct snapstore_mem *mem)=0A=
> +{=0A=
> +	struct buffer_el *buffer_el;=0A=
> +=0A=
> +	if (mem =3D=3D NULL)=0A=
> +		return;=0A=
> +=0A=
> +	do {=0A=
> +		buffer_el =3D NULL;=0A=
> +=0A=
> +		mutex_lock(&mem->blocks_lock);=0A=
> +		if (!list_empty(&mem->blocks)) {=0A=
> +			buffer_el =3D list_entry(mem->blocks.next, struct buffer_el, link);=
=0A=
> +=0A=
> +			list_del(&buffer_el->link);=0A=
> +		}=0A=
> +		mutex_unlock(&mem->blocks_lock);=0A=
> +=0A=
> +		if (buffer_el) {=0A=
> +			vfree(buffer_el->buff);=0A=
> +			kfree(buffer_el);=0A=
> +		}=0A=
> +	} while (buffer_el);=0A=
> +=0A=
> +	blk_descr_mem_pool_done(&mem->pool);=0A=
> +=0A=
> +	kfree(mem);=0A=
> +}=0A=
> +=0A=
> +void *snapstore_mem_get_block(struct snapstore_mem *mem)=0A=
> +{=0A=
> +	struct buffer_el *buffer_el;=0A=
> +=0A=
> +	if (mem->blocks_allocated >=3D mem->blocks_limit) {=0A=
> +		pr_err("Unable to get block from snapstore in memory\n");=0A=
> +		pr_err("Block limit is reached, allocated %zu, limit %zu\n", mem->bloc=
ks_allocated,=0A=
> +		       mem->blocks_limit);=0A=
> +		return NULL;=0A=
> +	}=0A=
> +=0A=
> +	buffer_el =3D kzalloc(sizeof(struct buffer_el), GFP_KERNEL);=0A=
> +	if (buffer_el =3D=3D NULL)=0A=
> +		return NULL;=0A=
> +	INIT_LIST_HEAD(&buffer_el->link);=0A=
> +=0A=
> +	buffer_el->buff =3D vmalloc(snapstore_block_size() * SECTOR_SIZE);=0A=
> +	if (buffer_el->buff =3D=3D NULL) {=0A=
> +		kfree(buffer_el);=0A=
> +		return NULL;=0A=
> +	}=0A=
> +=0A=
> +	++mem->blocks_allocated;=0A=
> +	if (0 =3D=3D (mem->blocks_allocated & 0x7F))=0A=
> +		pr_info("%zu MiB was allocated\n", mem->blocks_allocated);=0A=
> +=0A=
> +	mutex_lock(&mem->blocks_lock);=0A=
> +	list_add_tail(&buffer_el->link, &mem->blocks);=0A=
> +	mutex_unlock(&mem->blocks_lock);=0A=
> +=0A=
> +	return buffer_el->buff;=0A=
> +}=0A=
> diff --git a/drivers/block/blk-snap/snapstore_mem.h b/drivers/block/blk-s=
nap/snapstore_mem.h=0A=
> new file mode 100644=0A=
> index 000000000000..9044a6525966=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/snapstore_mem.h=0A=
> @@ -0,0 +1,20 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
> +#pragma once=0A=
> +=0A=
> +#include "blk_descr_mem.h"=0A=
> +=0A=
> +struct snapstore_mem {=0A=
> +	struct list_head blocks;=0A=
> +	struct mutex blocks_lock;=0A=
> +=0A=
> +	size_t blocks_limit;=0A=
> +	size_t blocks_allocated;=0A=
> +=0A=
> +	struct blk_descr_pool pool;=0A=
> +};=0A=
> +=0A=
> +struct snapstore_mem *snapstore_mem_create(size_t available_blocks);=0A=
> +=0A=
> +void snapstore_mem_destroy(struct snapstore_mem *mem);=0A=
> +=0A=
> +void *snapstore_mem_get_block(struct snapstore_mem *mem);=0A=
> diff --git a/drivers/block/blk-snap/snapstore_multidev.c b/drivers/block/=
blk-snap/snapstore_multidev.c=0A=
> new file mode 100644=0A=
> index 000000000000..bb6bfefa68d7=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/snapstore_multidev.c=0A=
> @@ -0,0 +1,118 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#define BLK_SNAP_SECTION "-snapstore"=0A=
> +#include "common.h"=0A=
> +=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +=0A=
> +#include "snapstore_multidev.h"=0A=
> +#include "blk_util.h"=0A=
> +=0A=
> +struct multidev_el {=0A=
> +	struct list_head link;=0A=
> +=0A=
> +	dev_t dev_id;=0A=
> +	struct block_device *blk_dev;=0A=
> +};=0A=
> +=0A=
> +int snapstore_multidev_create(struct snapstore_multidev **p_multidev)=0A=
> +{=0A=
> +	int res =3D SUCCESS;=0A=
> +	struct snapstore_multidev *multidev;=0A=
> +=0A=
> +	pr_info("Multidevice file snapstore create\n");=0A=
> +=0A=
> +	multidev =3D kzalloc(sizeof(struct snapstore_multidev), GFP_KERNEL);=0A=
> +	if (multidev =3D=3D NULL)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	INIT_LIST_HEAD(&multidev->devicelist);=0A=
> +	spin_lock_init(&multidev->devicelist_lock);=0A=
> +=0A=
> +	blk_descr_multidev_pool_init(&multidev->pool);=0A=
> +=0A=
> +	*p_multidev =3D multidev;=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +void snapstore_multidev_destroy(struct snapstore_multidev *multidev)=0A=
> +{=0A=
> +	struct multidev_el *el;=0A=
> +=0A=
> +	blk_descr_multidev_pool_done(&multidev->pool);=0A=
> +=0A=
> +	do {=0A=
> +		el =3D NULL;=0A=
> +		spin_lock(&multidev->devicelist_lock);=0A=
> +		if (!list_empty(&multidev->devicelist)) {=0A=
> +			el =3D list_entry(multidev->devicelist.next, struct multidev_el, link=
);=0A=
> +=0A=
> +			list_del(&el->link);=0A=
> +		}=0A=
> +		spin_unlock(&multidev->devicelist_lock);=0A=
> +=0A=
> +		if (el) {=0A=
> +			blk_dev_close(el->blk_dev);=0A=
> +=0A=
> +			pr_info("Close device for multidevice snapstore [%d:%d]\n",=0A=
> +				MAJOR(el->dev_id), MINOR(el->dev_id));=0A=
> +=0A=
> +			kfree(el);=0A=
> +		}=0A=
> +	} while (el);=0A=
> +=0A=
> +	kfree(multidev);=0A=
> +}=0A=
> +=0A=
> +struct multidev_el *snapstore_multidev_find(struct snapstore_multidev *m=
ultidev, dev_t dev_id)=0A=
> +{=0A=
> +	struct multidev_el *el =3D NULL;=0A=
> +=0A=
> +	spin_lock(&multidev->devicelist_lock);=0A=
> +	if (!list_empty(&multidev->devicelist)) {=0A=
> +		struct list_head *_head;=0A=
> +=0A=
> +		list_for_each(_head, &multidev->devicelist) {=0A=
> +			struct multidev_el *_el =3D list_entry(_head, struct multidev_el, lin=
k);=0A=
> +=0A=
> +			if (_el->dev_id =3D=3D dev_id) {=0A=
> +				el =3D _el;=0A=
> +				break;=0A=
> +			}=0A=
> +		}=0A=
> +	}=0A=
> +	spin_unlock(&multidev->devicelist_lock);=0A=
> +=0A=
> +	return el;=0A=
> +}=0A=
> +=0A=
> +struct block_device *snapstore_multidev_get_device(struct snapstore_mult=
idev *multidev,=0A=
> +						   dev_t dev_id)=0A=
> +{=0A=
> +	int res;=0A=
> +	struct block_device *blk_dev =3D NULL;=0A=
> +	struct multidev_el *el =3D snapstore_multidev_find(multidev, dev_id);=
=0A=
> +=0A=
> +	if (el)=0A=
> +		return el->blk_dev;=0A=
> +=0A=
> +	res =3D blk_dev_open(dev_id, &blk_dev);=0A=
> +	if (res !=3D SUCCESS) {=0A=
> +		pr_err("Unable to add device to snapstore multidevice file\n");=0A=
> +		pr_err("Failed to open [%d:%d]. errno=3D%d", MAJOR(dev_id), MINOR(dev_=
id), res);=0A=
> +		return NULL;=0A=
> +	}=0A=
> +=0A=
> +	el =3D kzalloc(sizeof(struct multidev_el), GFP_KERNEL);=0A=
> +	INIT_LIST_HEAD(&el->link);=0A=
> +=0A=
> +	el->blk_dev =3D blk_dev;=0A=
> +	el->dev_id =3D dev_id;=0A=
> +=0A=
> +	spin_lock(&multidev->devicelist_lock);=0A=
> +	list_add_tail(&el->link, &multidev->devicelist);=0A=
> +	spin_unlock(&multidev->devicelist_lock);=0A=
> +=0A=
> +	return el->blk_dev;=0A=
> +}=0A=
> +=0A=
> +#endif=0A=
> diff --git a/drivers/block/blk-snap/snapstore_multidev.h b/drivers/block/=
blk-snap/snapstore_multidev.h=0A=
> new file mode 100644=0A=
> index 000000000000..40c1c3a41b08=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/snapstore_multidev.h=0A=
> @@ -0,0 +1,22 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
> +#pragma once=0A=
> +=0A=
> +#ifdef CONFIG_BLK_SNAP_SNAPSTORE_MULTIDEV=0A=
> +=0A=
> +#include "blk_deferred.h"=0A=
> +#include "blk_descr_multidev.h"=0A=
> +=0A=
> +struct snapstore_multidev {=0A=
> +	struct list_head devicelist; //for mapping device id to opened device s=
truct pointer=0A=
> +	spinlock_t devicelist_lock;=0A=
> +=0A=
> +	struct blk_descr_pool pool;=0A=
> +};=0A=
> +=0A=
> +int snapstore_multidev_create(struct snapstore_multidev **p_file);=0A=
> +=0A=
> +void snapstore_multidev_destroy(struct snapstore_multidev *file);=0A=
> +=0A=
> +struct block_device *snapstore_multidev_get_device(struct snapstore_mult=
idev *multidev,=0A=
> +						   dev_t dev_id);=0A=
> +#endif=0A=
> diff --git a/drivers/block/blk-snap/tracker.c b/drivers/block/blk-snap/tr=
acker.c=0A=
> new file mode 100644=0A=
> index 000000000000..3cda996d3f0a=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/tracker.c=0A=
> @@ -0,0 +1,449 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#define BLK_SNAP_SECTION "-tracker"=0A=
> +#include "common.h"=0A=
> +#include "tracker.h"=0A=
> +#include "blk_util.h"=0A=
> +#include "params.h"=0A=
> +=0A=
> +LIST_HEAD(trackers);=0A=
> +DEFINE_RWLOCK(trackers_lock);=0A=
> +=0A=
> +void tracker_done(void)=0A=
> +{=0A=
> +	tracker_remove_all();=0A=
> +}=0A=
> +=0A=
> +int tracker_find_by_bio(struct bio *bio, struct tracker **ptracker)=0A=
> +{=0A=
> +	int result =3D -ENODATA;=0A=
> +=0A=
> +	read_lock(&trackers_lock);=0A=
> +	if (!list_empty(&trackers)) {=0A=
> +		struct list_head *_head;=0A=
> +=0A=
> +		list_for_each(_head, &trackers) {=0A=
> +			struct tracker *_tracker =3D list_entry(_head, struct tracker, link);=
=0A=
> +=0A=
> +			if ((bio->bi_disk =3D=3D _tracker->target_dev->bd_disk) &&=0A=
> +			    (bio->bi_partno =3D=3D _tracker->target_dev->bd_partno)) {=0A=
> +				if (ptracker !=3D NULL)=0A=
> +					*ptracker =3D _tracker;=0A=
> +=0A=
> +				result =3D SUCCESS;=0A=
> +				break;=0A=
> +			}=0A=
> +		}=0A=
> +	}=0A=
> +	read_unlock(&trackers_lock);=0A=
> +=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
> +int tracker_find_by_dev_id(dev_t dev_id, struct tracker **ptracker)=0A=
> +{=0A=
> +	int result =3D -ENODATA;=0A=
> +=0A=
> +	read_lock(&trackers_lock);=0A=
> +	if (!list_empty(&trackers)) {=0A=
> +		struct list_head *_head;=0A=
> +=0A=
> +		list_for_each(_head, &trackers) {=0A=
> +			struct tracker *_tracker =3D list_entry(_head, struct tracker, link);=
=0A=
> +=0A=
> +			if (_tracker->original_dev_id =3D=3D dev_id) {=0A=
> +				if (ptracker !=3D NULL)=0A=
> +					*ptracker =3D _tracker;=0A=
> +=0A=
> +				result =3D SUCCESS;=0A=
> +				break;=0A=
> +			}=0A=
> +		}=0A=
> +	}=0A=
> +	read_unlock(&trackers_lock);=0A=
> +=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
> +int tracker_enum_cbt_info(int max_count, struct cbt_info_s *p_cbt_info, =
int *p_count)=0A=
> +{=0A=
> +	int result =3D SUCCESS;=0A=
> +	int count =3D 0;=0A=
> +=0A=
> +	read_lock(&trackers_lock);=0A=
> +	if (!list_empty(&trackers)) {=0A=
> +		struct list_head *_head;=0A=
> +=0A=
> +		list_for_each(_head, &trackers) {=0A=
> +			struct tracker *tracker =3D list_entry(_head, struct tracker, link);=
=0A=
> +=0A=
> +			if (count >=3D max_count) {=0A=
> +				result =3D -ENOBUFS;=0A=
> +				break; //don`t continue=0A=
> +			}=0A=
> +=0A=
> +			if (p_cbt_info !=3D NULL) {=0A=
> +				p_cbt_info[count].dev_id.major =3D MAJOR(tracker->original_dev_id);=
=0A=
> +				p_cbt_info[count].dev_id.minor =3D MINOR(tracker->original_dev_id);=
=0A=
> +=0A=
> +				if (tracker->cbt_map) {=0A=
> +					p_cbt_info[count].cbt_map_size =3D tracker->cbt_map->map_size;=0A=
> +					p_cbt_info[count].snap_number =3D=0A=
> +						(unsigned char)=0A=
> +							tracker->cbt_map->snap_number_previous;=0A=
> +					uuid_copy((uuid_t *)(p_cbt_info[count].generationId),=0A=
> +						  &tracker->cbt_map->generationId);=0A=
> +				} else {=0A=
> +					p_cbt_info[count].cbt_map_size =3D 0;=0A=
> +					p_cbt_info[count].snap_number =3D 0;=0A=
> +				}=0A=
> +=0A=
> +				p_cbt_info[count].dev_capacity =3D (u64)from_sectors(=0A=
> +					part_nr_sects_read(tracker->target_dev->bd_part));=0A=
> +			}=0A=
> +=0A=
> +			++count;=0A=
> +		}=0A=
> +	}=0A=
> +	read_unlock(&trackers_lock);=0A=
> +=0A=
> +	if (result =3D=3D SUCCESS)=0A=
> +		if (count =3D=3D 0)=0A=
> +			result =3D -ENODATA;=0A=
> +=0A=
> +	*p_count =3D count;=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
> +static void blk_thaw_bdev(dev_t dev_id, struct block_device *device,=0A=
> +					 struct super_block *superblock)=0A=
> +{=0A=
> +	if (superblock =3D=3D NULL)=0A=
> +		return;=0A=
> +=0A=
> +	if (thaw_bdev(device, superblock) =3D=3D SUCCESS)=0A=
> +		pr_info("Device [%d:%d] was unfrozen\n", MAJOR(dev_id), MINOR(dev_id))=
;=0A=
> +	else=0A=
> +		pr_err("Failed to unfreeze device [%d:%d]\n", MAJOR(dev_id), MINOR(dev=
_id));=0A=
> +}=0A=
> +=0A=
> +static int blk_freeze_bdev(dev_t dev_id, struct block_device *device,=0A=
> +			   struct super_block **psuperblock)=0A=
> +{=0A=
> +	struct super_block *superblock;=0A=
> +=0A=
> +	if (device->bd_super =3D=3D NULL) {=0A=
> +		pr_warn("Unable to freeze device [%d:%d]: no superblock was found\n",=
=0A=
> +			MAJOR(dev_id), MINOR(dev_id));=0A=
> +		return SUCCESS;=0A=
> +	}=0A=
> +=0A=
> +	superblock =3D freeze_bdev(device);=0A=
> +	if (IS_ERR_OR_NULL(superblock)) {=0A=
> +		int result;=0A=
> +=0A=
> +		pr_err("Failed to freeze device [%d:%d]\n", MAJOR(dev_id), MINOR(dev_i=
d));=0A=
> +=0A=
> +		if (superblock =3D=3D NULL)=0A=
> +			result =3D -ENODEV;=0A=
> +		else {=0A=
> +			result =3D PTR_ERR(superblock);=0A=
> +			pr_err("Error code: %d\n", result);=0A=
> +		}=0A=
> +		return result;=0A=
> +	}=0A=
> +=0A=
> +	pr_info("Device [%d:%d] was frozen\n", MAJOR(dev_id), MINOR(dev_id));=
=0A=
> +	*psuperblock =3D superblock;=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +int _tracker_create(struct tracker *tracker, void *filter, bool attach_f=
ilter)=0A=
> +{=0A=
> +	int result =3D SUCCESS;=0A=
> +	unsigned int sect_in_block_degree;=0A=
> +	sector_t capacity;=0A=
> +	struct super_block *superblock =3D NULL;=0A=
> +=0A=
> +	result =3D blk_dev_open(tracker->original_dev_id, &tracker->target_dev)=
;=0A=
> +	if (result !=3D SUCCESS)=0A=
> +		return ENODEV;=0A=
> +=0A=
> +	pr_info("Create tracker for device [%d:%d]. Capacity 0x%llx sectors\n",=
=0A=
> +		MAJOR(tracker->original_dev_id), MINOR(tracker->original_dev_id),=0A=
> +		(unsigned long long)part_nr_sects_read(tracker->target_dev->bd_part));=
=0A=
> +=0A=
> +	sect_in_block_degree =3D get_change_tracking_block_size_pow() - SECTOR_=
SHIFT;=0A=
> +	capacity =3D part_nr_sects_read(tracker->target_dev->bd_part);=0A=
> +=0A=
> +	tracker->cbt_map =3D cbt_map_create(sect_in_block_degree, capacity);=0A=
> +	if (tracker->cbt_map =3D=3D NULL) {=0A=
> +		pr_err("Failed to create tracker for device [%d:%d]\n",=0A=
> +		       MAJOR(tracker->original_dev_id), MINOR(tracker->original_dev_id=
));=0A=
> +		tracker_remove(tracker);=0A=
> +		return -ENOMEM;=0A=
> +	}=0A=
> +=0A=
> +	tracker->snapshot_id =3D 0ull;=0A=
> +=0A=
> +	if (attach_filter) {=0A=
> +		blk_freeze_bdev(tracker->original_dev_id, tracker->target_dev, &superb=
lock);=0A=
> +=0A=
> +		blk_filter_attach(tracker->original_dev_id, filter, tracker);=0A=
> +=0A=
> +		blk_thaw_bdev(tracker->original_dev_id, tracker->target_dev, superbloc=
k);=0A=
> +	}=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +int tracker_create(dev_t dev_id, void *filter, struct tracker **ptracker=
)=0A=
> +{=0A=
> +	int ret;=0A=
> +	struct tracker *tracker =3D NULL;=0A=
> +=0A=
> +	*ptracker =3D NULL;=0A=
> +=0A=
> +	tracker =3D kzalloc(sizeof(struct tracker), GFP_KERNEL);=0A=
> +	if (tracker =3D=3D NULL)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	INIT_LIST_HEAD(&tracker->link);=0A=
> +	atomic_set(&tracker->is_captured, false);=0A=
> +	tracker->original_dev_id =3D dev_id;=0A=
> +=0A=
> +	write_lock(&trackers_lock);=0A=
> +	list_add_tail(&tracker->link, &trackers);=0A=
> +	write_unlock(&trackers_lock);=0A=
> +=0A=
> +	ret =3D _tracker_create(tracker, filter, true);=0A=
> +	if (ret < 0) {=0A=
> +		tracker_remove(tracker);=0A=
> +		return ret;=0A=
> +	}=0A=
> +=0A=
> +	*ptracker =3D tracker;=0A=
> +	if (ret =3D=3D ENODEV)=0A=
> +		pr_info("Cannot attach to unknown device [%d:%d]",=0A=
> +		       MAJOR(tracker->original_dev_id), MINOR(tracker->original_dev_id=
));=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +void _tracker_remove(struct tracker *tracker, bool detach_filter)=0A=
> +{=0A=
> +	struct super_block *superblock =3D NULL;=0A=
> +=0A=
> +	if (tracker->target_dev !=3D NULL) {=0A=
> +		if (detach_filter) {=0A=
> +			blk_freeze_bdev(tracker->original_dev_id, tracker->target_dev, &super=
block);=0A=
> +=0A=
> +			blk_filter_detach(tracker->original_dev_id);=0A=
> +=0A=
> +			blk_thaw_bdev(tracker->original_dev_id, tracker->target_dev, superblo=
ck);=0A=
> +		}=0A=
> +=0A=
> +		blk_dev_close(tracker->target_dev);=0A=
> +		tracker->target_dev =3D NULL;=0A=
> +	}=0A=
> +=0A=
> +	if (tracker->cbt_map !=3D NULL) {=0A=
> +		cbt_map_put_resource(tracker->cbt_map);=0A=
> +		tracker->cbt_map =3D NULL;=0A=
> +	}=0A=
> +}=0A=
> +=0A=
> +void tracker_remove(struct tracker *tracker)=0A=
> +{=0A=
> +	_tracker_remove(tracker, true);=0A=
> +=0A=
> +	write_lock(&trackers_lock);=0A=
> +	list_del(&tracker->link);=0A=
> +	write_unlock(&trackers_lock);=0A=
> +=0A=
> +	kfree(tracker);=0A=
> +}=0A=
> +=0A=
> +void tracker_remove_all(void)=0A=
> +{=0A=
> +	struct tracker *tracker;=0A=
> +=0A=
> +	pr_info("Removing all devices from tracking\n");=0A=
> +=0A=
> +	do {=0A=
> +		tracker =3D NULL;=0A=
> +=0A=
> +		write_lock(&trackers_lock);=0A=
> +		if (!list_empty(&trackers)) {=0A=
> +			tracker =3D list_entry(trackers.next, struct tracker, link);=0A=
> +=0A=
> +			list_del(&tracker->link);=0A=
> +		}=0A=
> +		write_unlock(&trackers_lock);=0A=
> +=0A=
> +		if (tracker) {=0A=
> +			_tracker_remove(tracker, true);=0A=
> +			kfree(tracker);=0A=
> +		}=0A=
> +	} while (tracker);=0A=
> +}=0A=
> +=0A=
> +void tracker_cbt_bitmap_set(struct tracker *tracker, sector_t sector, se=
ctor_t sector_cnt)=0A=
> +{=0A=
> +	if (tracker->cbt_map =3D=3D NULL)=0A=
> +		return;=0A=
> +=0A=
> +	if (tracker->cbt_map->device_capacity !=3D part_nr_sects_read(tracker->=
target_dev->bd_part)) {=0A=
> +		pr_warn("Device resize detected\n");=0A=
> +		tracker->cbt_map->active =3D false;=0A=
> +		return;=0A=
> +	}=0A=
> +=0A=
> +	if (cbt_map_set(tracker->cbt_map, sector, sector_cnt) !=3D SUCCESS) { /=
/cbt corrupt=0A=
> +		pr_warn("CBT fault detected\n");=0A=
> +		tracker->cbt_map->active =3D false;=0A=
> +		return;=0A=
> +	}=0A=
> +}=0A=
> +=0A=
> +bool tracker_cbt_bitmap_lock(struct tracker *tracker)=0A=
> +{=0A=
> +	if (tracker->cbt_map =3D=3D NULL)=0A=
> +		return false;=0A=
> +=0A=
> +	cbt_map_read_lock(tracker->cbt_map);=0A=
> +	if (!tracker->cbt_map->active) {=0A=
> +		cbt_map_read_unlock(tracker->cbt_map);=0A=
> +		return false;=0A=
> +	}=0A=
> +=0A=
> +	return true;=0A=
> +}=0A=
> +=0A=
> +void tracker_cbt_bitmap_unlock(struct tracker *tracker)=0A=
> +{=0A=
> +	if (tracker->cbt_map)=0A=
> +		cbt_map_read_unlock(tracker->cbt_map);=0A=
> +}=0A=
> +=0A=
> +int _tracker_capture_snapshot(struct tracker *tracker)=0A=
> +{=0A=
> +	int result =3D SUCCESS;=0A=
> +=0A=
> +	result =3D defer_io_create(tracker->original_dev_id, tracker->target_de=
v, &tracker->defer_io);=0A=
> +	if (result !=3D SUCCESS) {=0A=
> +		pr_err("Failed to create defer IO processor\n");=0A=
> +		return result;=0A=
> +	}=0A=
> +=0A=
> +	atomic_set(&tracker->is_captured, true);=0A=
> +=0A=
> +	if (tracker->cbt_map !=3D NULL) {=0A=
> +		cbt_map_write_lock(tracker->cbt_map);=0A=
> +		cbt_map_switch(tracker->cbt_map);=0A=
> +		cbt_map_write_unlock(tracker->cbt_map);=0A=
> +=0A=
> +		pr_info("Snapshot captured for device [%d:%d]. New snap number %ld\n",=
=0A=
> +			MAJOR(tracker->original_dev_id), MINOR(tracker->original_dev_id),=0A=
> +			tracker->cbt_map->snap_number_active);=0A=
> +	}=0A=
> +=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
> +int tracker_capture_snapshot(dev_t *dev_id_set, int dev_id_set_size)=0A=
> +{=0A=
> +	int result =3D SUCCESS;=0A=
> +	int inx =3D 0;=0A=
> +=0A=
> +	for (inx =3D 0; inx < dev_id_set_size; ++inx) {=0A=
> +		struct super_block *superblock =3D NULL;=0A=
> +		struct tracker *tracker =3D NULL;=0A=
> +		dev_t dev_id =3D dev_id_set[inx];=0A=
> +=0A=
> +		result =3D tracker_find_by_dev_id(dev_id, &tracker);=0A=
> +		if (result !=3D SUCCESS) {=0A=
> +			pr_err("Unable to capture snapshot: cannot find device [%d:%d]\n",=0A=
> +			       MAJOR(dev_id), MINOR(dev_id));=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +=0A=
> +		blk_freeze_bdev(tracker->original_dev_id, tracker->target_dev, &superb=
lock);=0A=
> +		blk_filter_freeze(tracker->target_dev);=0A=
> +=0A=
> +		result =3D _tracker_capture_snapshot(tracker);=0A=
> +		if (result !=3D SUCCESS)=0A=
> +			pr_err("Failed to capture snapshot for device [%d:%d]\n",=0A=
> +			       MAJOR(dev_id), MINOR(dev_id));=0A=
> +=0A=
> +		blk_filter_thaw(tracker->target_dev);=0A=
> +		blk_thaw_bdev(tracker->original_dev_id, tracker->target_dev, superbloc=
k);=0A=
> +	}=0A=
> +	if (result !=3D SUCCESS)=0A=
> +		return result;=0A=
> +=0A=
> +	for (inx =3D 0; inx < dev_id_set_size; ++inx) {=0A=
> +		struct tracker *tracker =3D NULL;=0A=
> +		dev_t dev_id =3D dev_id_set[inx];=0A=
> +=0A=
> +		result =3D tracker_find_by_dev_id(dev_id, &tracker);=0A=
> +		if (result !=3D SUCCESS) {=0A=
> +			pr_err("Unable to capture snapshot: cannot find device [%d:%d]\n",=0A=
> +			       MAJOR(dev_id), MINOR(dev_id));=0A=
> +			continue;=0A=
> +		}=0A=
> +=0A=
> +		if (snapstore_device_is_corrupted(tracker->defer_io->snapstore_device)=
) {=0A=
> +			pr_err("Unable to freeze devices [%d:%d]: snapshot data is corrupted\=
n",=0A=
> +			       MAJOR(dev_id), MINOR(dev_id));=0A=
> +			result =3D -EDEADLK;=0A=
> +			break;=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	if (result !=3D SUCCESS) {=0A=
> +		pr_err("Failed to capture snapshot. errno=3D%d\n", result);=0A=
> +=0A=
> +		tracker_release_snapshot(dev_id_set, dev_id_set_size);=0A=
> +	}=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
> +void _tracker_release_snapshot(struct tracker *tracker)=0A=
> +{=0A=
> +	struct super_block *superblock =3D NULL;=0A=
> +	struct defer_io *defer_io =3D tracker->defer_io;=0A=
> +=0A=
> +	blk_freeze_bdev(tracker->original_dev_id, tracker->target_dev, &superbl=
ock);=0A=
> +	blk_filter_freeze(tracker->target_dev);=0A=
> +	{ //locked region=0A=
> +		atomic_set(&tracker->is_captured, false); //clear freeze flag=0A=
> +=0A=
> +		tracker->defer_io =3D NULL;=0A=
> +	}=0A=
> +	blk_filter_thaw(tracker->target_dev);=0A=
> +=0A=
> +	blk_thaw_bdev(tracker->original_dev_id, tracker->target_dev, superblock=
);=0A=
> +=0A=
> +	defer_io_stop(defer_io);=0A=
> +	defer_io_put_resource(defer_io);=0A=
> +}=0A=
> +=0A=
> +void tracker_release_snapshot(dev_t *dev_id_set, int dev_id_set_size)=0A=
> +{=0A=
> +	int inx =3D 0;=0A=
> +=0A=
> +	for (; inx < dev_id_set_size; ++inx) {=0A=
> +		int status;=0A=
> +		struct tracker *p_tracker =3D NULL;=0A=
> +		dev_t dev =3D dev_id_set[inx];=0A=
> +=0A=
> +		status =3D tracker_find_by_dev_id(dev, &p_tracker);=0A=
> +		if (status =3D=3D SUCCESS)=0A=
> +			_tracker_release_snapshot(p_tracker);=0A=
> +		else=0A=
> +			pr_err("Unable to release snapshot: cannot find tracker for device [%=
d:%d]\n",=0A=
> +			       MAJOR(dev), MINOR(dev));=0A=
> +	}=0A=
> +}=0A=
> diff --git a/drivers/block/blk-snap/tracker.h b/drivers/block/blk-snap/tr=
acker.h=0A=
> new file mode 100644=0A=
> index 000000000000..9fff7c0942c3=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/tracker.h=0A=
> @@ -0,0 +1,38 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
> +#pragma once=0A=
> +#include "cbt_map.h"=0A=
> +#include "defer_io.h"=0A=
> +#include "blk-snap-ctl.h"=0A=
> +#include "snapshot.h"=0A=
> +=0A=
> +struct tracker {=0A=
> +	struct list_head link;=0A=
> +	dev_t original_dev_id;=0A=
> +	struct block_device *target_dev;=0A=
> +	struct cbt_map *cbt_map;=0A=
> +	atomic_t is_captured;=0A=
> +	struct defer_io *defer_io;=0A=
> +	unsigned long long snapshot_id; // current snapshot for this device=0A=
> +};=0A=
> +=0A=
> +void tracker_done(void);=0A=
> +=0A=
> +int tracker_find_by_bio(struct bio *bio, struct tracker **ptracker);=0A=
> +int tracker_find_by_dev_id(dev_t dev_id, struct tracker **ptracker);=0A=
> +=0A=
> +int tracker_enum_cbt_info(int max_count, struct cbt_info_s *p_cbt_info, =
int *p_count);=0A=
> +=0A=
> +int tracker_capture_snapshot(dev_t *dev_id_set, int dev_id_set_size);=0A=
> +void tracker_release_snapshot(dev_t *dev_id_set, int dev_id_set_size);=
=0A=
> +=0A=
> +int _tracker_create(struct tracker *tracker, void *filter, bool attach_f=
ilter);=0A=
> +int tracker_create(dev_t dev_id, void *filter, struct tracker **ptracker=
);=0A=
> +=0A=
> +void _tracker_remove(struct tracker *tracker, bool detach_filter);=0A=
> +void tracker_remove(struct tracker *tracker);=0A=
> +void tracker_remove_all(void);=0A=
> +=0A=
> +void tracker_cbt_bitmap_set(struct tracker *tracker, sector_t sector, se=
ctor_t sector_cnt);=0A=
> +=0A=
> +bool tracker_cbt_bitmap_lock(struct tracker *tracker);=0A=
> +void tracker_cbt_bitmap_unlock(struct tracker *tracker);=0A=
> diff --git a/drivers/block/blk-snap/tracking.c b/drivers/block/blk-snap/t=
racking.c=0A=
> new file mode 100644=0A=
> index 000000000000..55e18891bb96=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/tracking.c=0A=
> @@ -0,0 +1,270 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +#define BLK_SNAP_SECTION "-tracking"=0A=
> +#include "common.h"=0A=
> +#include "tracking.h"=0A=
> +#include "tracker.h"=0A=
> +#include "blk_util.h"=0A=
> +#include "defer_io.h"=0A=
> +#include "params.h"=0A=
> +=0A=
> +#include <linux/blk-filter.h>=0A=
> +=0A=
> +/* pointer to block layer filter */=0A=
> +void *filter;=0A=
> +=0A=
> +/*=0A=
> + * _tracking_submit_bio() - Intercept bio by block io layer filter=0A=
> + */=0A=
> +static bool _tracking_submit_bio(struct bio *bio, void *filter_data)=0A=
> +{=0A=
> +	int res;=0A=
> +	bool cbt_locked =3D false;=0A=
> +	struct tracker *tracker =3D filter_data;=0A=
> +=0A=
> +	if (!tracker)=0A=
> +		return false;=0A=
> +=0A=
> +	//intercepting=0A=
> +	if (atomic_read(&tracker->is_captured)) {=0A=
> +		//snapshot is captured, call bio redirect algorithm=0A=
> +=0A=
> +		res =3D defer_io_redirect_bio(tracker->defer_io, bio, tracker);=0A=
> +		if (res =3D=3D SUCCESS)=0A=
> +			return true;=0A=
> +	}=0A=
> +=0A=
> +	cbt_locked =3D false;=0A=
> +	if (tracker && bio_data_dir(bio) && bio_has_data(bio)) {=0A=
> +		//call CBT algorithm=0A=
> +		cbt_locked =3D tracker_cbt_bitmap_lock(tracker);=0A=
> +		if (cbt_locked) {=0A=
> +			sector_t sectStart =3D bio->bi_iter.bi_sector;=0A=
> +			sector_t sectCount =3D bio_sectors(bio);=0A=
> +=0A=
> +			tracker_cbt_bitmap_set(tracker, sectStart, sectCount);=0A=
> +		}=0A=
> +	}=0A=
> +	if (cbt_locked)=0A=
> +		tracker_cbt_bitmap_unlock(tracker);=0A=
> +=0A=
> +	return false;=0A=
> +}=0A=
> +=0A=
> +static bool _tracking_part_add(dev_t devt, void **p_filter_data)=0A=
> +{=0A=
> +	int result;=0A=
> +	struct tracker *tracker =3D NULL;=0A=
> +=0A=
> +	pr_info("new block device [%d:%d] in system\n", MAJOR(devt), MINOR(devt=
));=0A=
> +=0A=
> +	result =3D tracker_find_by_dev_id(devt, &tracker);=0A=
> +	if (result !=3D SUCCESS)=0A=
> +		return false; /*do not track this device*/=0A=
> +=0A=
> +	if (_tracker_create(tracker, filter, false)) {=0A=
> +		pr_err("Failed to attach new device to tracker. errno=3D%d\n", result)=
;=0A=
> +		return false; /*failed to attach new device to tracker*/=0A=
> +	}=0A=
> +=0A=
> +	*p_filter_data =3D tracker;=0A=
> +	return true;=0A=
> +}=0A=
> +=0A=
> +static void _tracking_part_del(void *private_data)=0A=
> +{=0A=
> +	struct tracker *tracker =3D private_data;=0A=
> +=0A=
> +	if (!tracker)=0A=
> +		return;=0A=
> +=0A=
> +	pr_info("delete block device [%d:%d] from system\n",=0A=
> +		MAJOR(tracker->original_dev_id), MINOR(tracker->original_dev_id));=0A=
> +=0A=
> +	_tracker_remove(tracker, false);=0A=
> +}=0A=
> +=0A=
> +struct blk_filter_ops filter_ops =3D {=0A=
> +	.filter_bio =3D _tracking_submit_bio,=0A=
> +	.part_add =3D _tracking_part_add,=0A=
> +	.part_del =3D _tracking_part_del };=0A=
> +=0A=
> +=0A=
> +=0A=
> +int tracking_init(void)=0A=
> +{=0A=
> +	filter =3D blk_filter_register(&filter_ops);=0A=
> +	if (!filter)=0A=
> +		return -ENOMEM;=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +void tracking_done(void)=0A=
> +{=0A=
> +	if (filter) {=0A=
> +		blk_filter_unregister(filter);=0A=
> +		filter =3D NULL;=0A=
> +	}=0A=
> +}=0A=
> +=0A=
> +static int _add_already_tracked(dev_t dev_id, unsigned long long snapsho=
t_id,=0A=
> +				struct tracker *tracker)=0A=
> +{=0A=
> +	int result =3D SUCCESS;=0A=
> +	bool cbt_reset_needed =3D false;=0A=
> +=0A=
> +	if ((snapshot_id !=3D 0ull) && (tracker->snapshot_id =3D=3D 0ull))=0A=
> +		tracker->snapshot_id =3D snapshot_id; // set new snapshot id=0A=
> +=0A=
> +	if (tracker->cbt_map =3D=3D NULL) {=0A=
> +		unsigned int sect_in_block_degree =3D=0A=
> +			get_change_tracking_block_size_pow() - SECTOR_SHIFT;=0A=
> +		tracker->cbt_map =3D cbt_map_create(sect_in_block_degree - SECTOR_SHIF=
T,=0A=
> +						  part_nr_sects_read(tracker->target_dev->bd_part));=0A=
> +		if (tracker->cbt_map =3D=3D NULL)=0A=
> +			return -ENOMEM;=0A=
> +=0A=
> +		// skip snapshot id=0A=
> +		tracker->snapshot_id =3D snapshot_id;=0A=
> +		return SUCCESS;=0A=
> +	}=0A=
> +=0A=
> +	if (!tracker->cbt_map->active) {=0A=
> +		cbt_reset_needed =3D true;=0A=
> +		pr_warn("Nonactive CBT table detected. CBT fault\n");=0A=
> +	}=0A=
> +=0A=
> +	if (tracker->cbt_map->device_capacity !=3D part_nr_sects_read(tracker->=
target_dev->bd_part)) {=0A=
> +		cbt_reset_needed =3D true;=0A=
> +		pr_warn("Device resize detected. CBT fault\n");=0A=
> +	}=0A=
> +=0A=
> +	if (!cbt_reset_needed)=0A=
> +		return SUCCESS;=0A=
> +=0A=
> +	_tracker_remove(tracker, true);=0A=
> +=0A=
> +	result =3D _tracker_create(tracker, filter, true);=0A=
> +	if (result !=3D SUCCESS) {=0A=
> +		pr_err("Failed to create tracker. errno=3D%d\n", result);=0A=
> +		return result;=0A=
> +	}=0A=
> +=0A=
> +	tracker->snapshot_id =3D snapshot_id;=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +static int _create_new_tracker(dev_t dev_id, unsigned long long snapshot=
_id)=0A=
> +{=0A=
> +	int result;=0A=
> +	struct tracker *tracker =3D NULL;=0A=
> +=0A=
> +	result =3D tracker_create(dev_id, filter, &tracker);=0A=
> +	if (result !=3D SUCCESS) {=0A=
> +		pr_err("Failed to create tracker. errno=3D%d\n", result);=0A=
> +		return result;=0A=
> +	}=0A=
> +=0A=
> +	tracker->snapshot_id =3D snapshot_id;=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +=0A=
> +int tracking_add(dev_t dev_id, unsigned long long snapshot_id)=0A=
> +{=0A=
> +	int result;=0A=
> +	struct tracker *tracker =3D NULL;=0A=
> +=0A=
> +	pr_info("Adding device [%d:%d] under tracking\n", MAJOR(dev_id), MINOR(=
dev_id));=0A=
> +=0A=
> +	result =3D tracker_find_by_dev_id(dev_id, &tracker);=0A=
> +	if (result =3D=3D SUCCESS) {=0A=
> +		//pr_info("Device [%d:%d] is already tracked\n", MAJOR(dev_id), MINOR(=
dev_id));=0A=
> +		result =3D _add_already_tracked(dev_id, snapshot_id, tracker);=0A=
> +		if (result =3D=3D SUCCESS)=0A=
> +			result =3D -EALREADY;=0A=
> +	} else if (-ENODATA =3D=3D result)=0A=
> +		result =3D _create_new_tracker(dev_id, snapshot_id);=0A=
> +	else {=0A=
> +		pr_err("Unable to add device [%d:%d] under tracking\n", MAJOR(dev_id),=
=0A=
> +			MINOR(dev_id));=0A=
> +		pr_err("Invalid trackers container. errno=3D%d\n", result);=0A=
> +	}=0A=
> +=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
> +int tracking_remove(dev_t dev_id)=0A=
> +{=0A=
> +	int result;=0A=
> +	struct tracker *tracker =3D NULL;=0A=
> +=0A=
> +	pr_info("Removing device [%d:%d] from tracking\n", MAJOR(dev_id), MINOR=
(dev_id));=0A=
> +=0A=
> +	result =3D tracker_find_by_dev_id(dev_id, &tracker);=0A=
> +	if (result !=3D SUCCESS) {=0A=
> +		pr_err("Unable to remove device [%d:%d] from tracking: ",=0A=
> +		       MAJOR(dev_id), MINOR(dev_id));=0A=
> +=0A=
> +		if (-ENODATA =3D=3D result)=0A=
> +			pr_err("tracker not found\n");=0A=
> +		else=0A=
> +			pr_err("tracker container failed. errno=3D%d\n", result);=0A=
> +=0A=
> +		return result;=0A=
> +	}=0A=
> +=0A=
> +	if (tracker->snapshot_id !=3D 0ull) {=0A=
> +		pr_err("Unable to remove device [%d:%d] from tracking: ",=0A=
> +		       MAJOR(dev_id), MINOR(dev_id));=0A=
> +		pr_err("snapshot [0x%llx] already exist\n", tracker->snapshot_id);=0A=
> +		return -EBUSY;=0A=
> +	}=0A=
> +=0A=
> +	tracker_remove(tracker);=0A=
> +=0A=
> +	return SUCCESS;=0A=
> +}=0A=
> +=0A=
> +int tracking_collect(int max_count, struct cbt_info_s *p_cbt_info, int *=
p_count)=0A=
> +{=0A=
> +	int res =3D tracker_enum_cbt_info(max_count, p_cbt_info, p_count);=0A=
> +=0A=
> +	if (res =3D=3D SUCCESS)=0A=
> +		pr_info("%d devices found under tracking\n", *p_count);=0A=
> +	else if (res =3D=3D -ENODATA) {=0A=
> +		pr_info("There are no devices under tracking\n");=0A=
> +		*p_count =3D 0;=0A=
> +		res =3D SUCCESS;=0A=
> +	} else=0A=
> +		pr_err("Failed to collect devices under tracking. errno=3D%d", res);=
=0A=
> +=0A=
> +	return res;=0A=
> +}=0A=
> +=0A=
> +int tracking_read_cbt_bitmap(dev_t dev_id, unsigned int offset, size_t l=
ength,=0A=
> +			     void __user *user_buff)=0A=
> +{=0A=
> +	int result =3D SUCCESS;=0A=
> +	struct tracker *tracker =3D NULL;=0A=
> +=0A=
> +	result =3D tracker_find_by_dev_id(dev_id, &tracker);=0A=
> +	if (result =3D=3D SUCCESS) {=0A=
> +		if (atomic_read(&tracker->is_captured))=0A=
> +			result =3D cbt_map_read_to_user(tracker->cbt_map, user_buff, offset, =
length);=0A=
> +		else {=0A=
> +			pr_err("Unable to read CBT bitmap for device [%d:%d]: ", MAJOR(dev_id=
),=0A=
> +			       MINOR(dev_id));=0A=
> +			pr_err("device is not captured by snapshot\n");=0A=
> +			result =3D -EPERM;=0A=
> +		}=0A=
> +	} else if (-ENODATA =3D=3D result) {=0A=
> +		pr_err("Unable to read CBT bitmap for device [%d:%d]: ", MAJOR(dev_id)=
,=0A=
> +		       MINOR(dev_id));=0A=
> +		pr_err("device not found\n");=0A=
> +	} else=0A=
> +		pr_err("Failed to find devices under tracking. errno=3D%d", result);=
=0A=
> +=0A=
> +	return result;=0A=
> +}=0A=
> diff --git a/drivers/block/blk-snap/tracking.h b/drivers/block/blk-snap/t=
racking.h=0A=
> new file mode 100644=0A=
> index 000000000000..22bd5ba54963=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/tracking.h=0A=
> @@ -0,0 +1,13 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
> +#pragma once=0A=
> +#include "blk-snap-ctl.h"=0A=
> +#include <linux/bio.h>=0A=
> +=0A=
> +int  tracking_init(void);=0A=
> +void tracking_done(void);=0A=
> +=0A=
> +int tracking_add(dev_t dev_id, unsigned long long snapshot_id);=0A=
> +int tracking_remove(dev_t dev_id);=0A=
> +int tracking_collect(int max_count, struct cbt_info_s *p_cbt_info, int *=
p_count);=0A=
> +int tracking_read_cbt_bitmap(dev_t dev_id, unsigned int offset, size_t l=
ength,=0A=
> +			     void __user *user_buff);=0A=
> diff --git a/drivers/block/blk-snap/version.h b/drivers/block/blk-snap/ve=
rsion.h=0A=
> new file mode 100644=0A=
> index 000000000000..a4431da73611=0A=
> --- /dev/null=0A=
> +++ b/drivers/block/blk-snap/version.h=0A=
> @@ -0,0 +1,7 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
> +#pragma once=0A=
> +=0A=
> +#define FILEVER_MAJOR 5=0A=
> +#define FILEVER_MINOR 0=0A=
> +#define FILEVER_REVISION 0=0A=
> +#define FILEVER_STR "5.0.0"=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
