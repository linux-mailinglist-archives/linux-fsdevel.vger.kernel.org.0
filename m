Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7B625B039
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgIBPxx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:53:53 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:27158 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgIBPxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599062028; x=1630598028;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=ecnoOnaNG6+F6/YVR8jRNnbYb+ix6lr9gPXz2kROInRJ7HiAfNYQFE3f
   Wf3UycVt6ZZaTkrq2aNgM/CgZRigVHrBixRSANyamhSSFU/5q6SMxfwzT
   xB/LmaPHFacf7zlJ+0AafJuoWuG91Yn7blfe2xMfEaz6rrSrvGgevWMqO
   1S5XGNCf211ZJiq0VUOPEVmJicuDdLTziV6H5iK6gSUWhEUNz8MqWxYHw
   Zq/tPQZtem4fr+7kSaTXnucrLEJWlyQaLF/ffYDc4kQn/XGEJKGvPDQ28
   uwXczqcjp5MO7QZAD9zDrZnQsxq4k4BGj/tJmE8F7l1IkOQdVSrLOnKHe
   w==;
IronPort-SDR: GzHsi6/v1n3VrQk6RT0xqlSckGdocaIigp89tJ8GIDmBPKp6pmPpUvnjItrJKVTjjrbAhF0rfD
 8a+NsbJ18tYX9XwvriontTCEtvcvQ1Jch439i83TocYKjoKxev3bgwLYk/cIfKVYK1PhegyGBg
 rjPL/oT1goVaCxHTdfLnXHxwIRaKj0FVmlDpNHQHrFqXjYF43MOE3yiVQ2o4kGz+2Vq2YBsE/k
 NP9lSo7Vs29OyfMDZXsAC+ZtrhMxx28EdBhaKGC6TJG81zon4PPrT29GKiO/KBG6EeLDy/1+i4
 odw=
X-IronPort-AV: E=Sophos;i="5.76,383,1592841600"; 
   d="scan'208";a="255954033"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 23:53:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1Dgnlsr+YwgVDQ5wFOiB/qNDF4YdAvPFE3eMgppRS2Pm47JFFL/laFed71zzHJY4Dyha56fhn43LXooIJYuc0lO4wmj2VTWI6a07SHf3mJjirOee2Opdka+gckx1W2yexae21EtukTizVO3VC6GO8JvlrwNGf8lnc/9Bw/5H05fcYIHWRWdLtdO5YTnR1dtfKAaDhe+k2VB0UyduDLJeqPne22IbLCVx94JmzsDCwhERMm0qJqETDbSNnG81R0hu8SFlANHu36Oqb/icLPlYazUmx2D/zGtI0kVREjARY0DpD7CAALY2apNP+dx2rQeTEx3x9UwtsOCmJCgiUZ7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=YUiQ6E7UXOEbvDD9sMdCFcjsHQZfpR+z1F4c4yRfz1PafyE2t5OPClKRG108mBG1/KPeOyeLYO1djU5KvZmlZz7Vc8ESFBltJpo9yOcNlIkppb5ct+Da3bhIV0I7OWm9ikBV1PU7MRp8Dq0n890kV1GdM4eYHBCHoooiZ3EtXoNxL8RsUrhgo8HmgYRYPkAoyyvVkVY+TCtnL4QbHSoBs7ChAsajJseIo9fheokHQXxlBFX4fIkBkEGdwJVSFu/hNNpk5KrHT1zvSMvPwJiXaCX0MS/PCZ/oLAx6n5n7TXgFrDuHtfm/bVoalN3psbcJn2Gwlr6VJnoXu95bzR/mQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=lndVtbvUl8TE7l0fgq8Mq2uYty7AhyzxK/Gd5hz8Z3ooAXgk7DpBVwlNhxsAhRdXOQPNF4B1u0Bp76lwVNxHcasrILVBm1nNQn6ni307JEkqs72D5KLgK75YHlFMnuPbdqO4qevbksuS+Z1qhFPCkS3sOf0HSluKWHvVrXGh8pg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2142.namprd04.prod.outlook.com
 (2603:10b6:804:16::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 2 Sep
 2020 15:53:44 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 15:53:43 +0000
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
Subject: Re: [PATCH 18/19] sr: simplify sr_block_revalidate_disk
Thread-Topic: [PATCH 18/19] sr: simplify sr_block_revalidate_disk
Thread-Index: AQHWgTTJFIkcfKmUzE+ho0okEObFEw==
Date:   Wed, 2 Sep 2020 15:53:43 +0000
Message-ID: <SN4PR0401MB359888A8534B366B13EDD39A9B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200902141218.212614-1-hch@lst.de>
 <20200902141218.212614-19-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:1584:4722:fd5f:b30e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a0569756-2a97-492c-ea3d-08d84f585ed9
x-ms-traffictypediagnostic: SN2PR04MB2142:
x-microsoft-antispam-prvs: <SN2PR04MB21426307C8ECA4256B9320449B2F0@SN2PR04MB2142.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OpEfuGdaeKF1KYzVUfZcIv2NF0ETrQnte9YJ47bU8PqLsXGj+zLv5VoOF2yQMPP/z5d+oJbjpt+OkePcqCcWZoN1BJm8Kb2I9gWUiFkrSHgzN/P4PZPMbevMs5sHqwzFqHuvcAZ9gSKXNYx/CGENnqQXoheb/I52i7gDu62JlkcyZRxnmKchaR3/RNyAdgjmeipEnmIaV4BJH28WgTpFHpL4kPY17xlxGy2NmQzVAumjRsmAAWKPhQsFcIj6kD/EfoE28RwI6vL52sCojXP/o4ESQP4PNQXvGguiMdNeqdMx3eEup03OzIYKvhc7JcR2lnl6vlMi76OJ/jyp8DMStw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(136003)(346002)(396003)(366004)(76116006)(66446008)(186003)(7696005)(91956017)(8676002)(5660300002)(66556008)(7416002)(6506007)(64756008)(52536014)(66946007)(19618925003)(66476007)(8936002)(110136005)(316002)(55016002)(478600001)(558084003)(4326008)(54906003)(4270600006)(9686003)(71200400001)(86362001)(2906002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BFfbe94YzCKwfa33HbsoNHHDdx1ZrhkDhaTtG6bLSRaJKV4qXmHAExtt9lhJJeWYyJIRX3REQG+fCDXccRQrdkrI6qqsrSTPDMs3vGjV5KnKzQG2fpMimplILiW9k/dmPYT3lARXrUl4R1Fgijw1DrV8tqPqBTNkMXwOgKi86mqV/pkuwMvbRK8JobO0adakOkCzYZyQnnLT6TDrIl3o+iujnOg2dzJOhq9BPP/Sgs4j6j3FmiqK/OGk/v51qzhGp66K6hHN9mWF5Ter4gH6kdjjm0AaZQZD+F30y5zY5OyB76jOXb1ePUKLXx0UwU7eXLXHBkPiwhhSYzv0RG1rti+BpXeU694GhtJ4h74ekxP9aXYc0tNX8s6kYZB66buw8R9PTIjxCVndRuSthYkcff4T15U52E9+MPsFk7pe4g//OUuvtcPFX9M2DiyX4Cp4xcJdlI16WTg82kdqjuSI4Ojk6kRWyAbG9a7tfuQ4XvCqmC1tZveHTSMrt3LqzBjkI9TXUlpcke12/P1uq4ZWbSsZ9ZOuWwCFsHObEv1oKiYdcVfPrjfRQNF5rf3kfCNxuFmHJtE3FD1eIRpJE5myZ3B57vbz5UCrU/VGe/IvKxuDFmxAr9Odakc2v3vontXAt9dz3r68TxKvsSCS5j40DhnjJoGIFVPGuiHuKNWhMYQ8SVYGL/Om4p7SmiBu4oXnkszPbu0tVhSSfWyh9NeHlg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0569756-2a97-492c-ea3d-08d84f585ed9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 15:53:43.8302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Uc4BT3oHok8xSSAoZWJ9iTmwoza4TTFV0SpfZI6GrZfDd5cffHFlvIT03tNQDD6+FsNQwk4kKVSf6zp6sW+oGQsla+YXg6w+zySs4JUouk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2142
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
