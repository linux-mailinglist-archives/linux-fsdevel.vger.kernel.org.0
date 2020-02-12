Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9478615AB4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 15:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgBLOu6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 09:50:58 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17769 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgBLOu6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581519057; x=1613055057;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=ZmyVsgOtsoaLZWUrjGVMMDmSvb/cMujw43VHLfRLChImQBaS2oRCavoN
   gkm56qUQf8yNNIJzCSXZNa449hgwdNZW4GbY9ZHz48c8wDBBpky96UGGv
   Rf+sE8wMAGjM26/nv2Tl185u6mQz5V9Nnk0eVEZ9VsAvRXyrk55kK+Bj9
   oiKVnLD6RN8alv6nwU+ZJ5OOR2dJ/DIH4f9SS25wOmJuuaf18V+kdqVGf
   FyxkQFmeUpWSyeOa+EBygbZaf86gCIKskFgDGja+wEA//A7h6ZHZp1a1r
   xIAAJ9NVqEI5benvxSyLnACwRZV9HUnDJfYqIqYNCEFInGA62GO8xIVWP
   A==;
IronPort-SDR: 4yBuQevx3qgSODa0hb6CmtLd3kZCQ2vpU2WiZD5HX/Qm2rLjmqllfXlBQ4tJ6CJ0gjla8Eqg9t
 Rv3YKwD6/tL0UCHmmrNQztYIDL6jU93PinmUEjFXI4bl921kG7KU35mYQRRRJ6Or9t73jnExKD
 K0t5U/CTpNpPZ5Nmuh/YSGcj0vfSWyvn7aHM79Ua9bTy0xhfe8OW/9zoPV8aPvmGzEqrTrlpAV
 0D478Qw1JKhC5Fq6VbZO6ZJmrtlx7CcndNls5+X0qDoqh4aV5eP6N9xv30apbDnVsuTssVOSbp
 u9E=
X-IronPort-AV: E=Sophos;i="5.70,433,1574092800"; 
   d="scan'208";a="129679311"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 22:50:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oR9WByOuhIz4sDcJ1zq264SHrrlQ7UtvIWhcsCSd7bgkKCGFMfczvCsDsvyW8/ImPpB9VhkDmbCuO89yR9EEaLarAIfRXhd0551P/3FoXH9R3qs/Gktl/YxqV3GRn+pCtpypklpW94+iReA4ogSvqglMiImXYQRWz8oBBGvVfUK85ki9xa3rWTeEzNbJ8dwlet2PRMWK8A8fEBwu5JDST/gZbGOIm5Xcl7eEhvEfnfOxWpafpVuAC3/jbgJ9zBL66GNAVbPW+Wm+Bk3DVAjZfEV8Px13/ndIv5EMWzwJPcko0GzHmdvZKu2PCFjfCpqpvl2aWkBCoaBH0YK8M2t8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Mge9QeNAf5Wp/PppYyzLR4IpQRlaWGra+yPulNxYz62zhPVO+f3eYt5o9xtoYm4hUGJey+6gcIDgVs+uFDP8+laoZoUbEMz7rBnbOyvYfUtU3XSSyXB2tmp7RuUXdajdRGil0ITrPefSHHLVc8n65uHoSvHaWXoIHLEOq9y8ksMzFVD0wFOumKLwzZYY+iuJ2AKZJT8WAHJVDXTAcv2CxxH4DKmbBrnCRsu14cQgTYH5fdZictmjapXpmK2uywX/8Ni01ky0RY7J2askyWGmqtnmQRASc55PK1FUKSRenbr5xFpQpR9VPb5kORfksEL5uJOc9dr4eXcTAjC/e+66LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=JSBzT+NZY9Pv5Qq3mZgQ9CCLOzP2tSZFQb0QUWdD7S+qiav3+UXHTQIbRY6hnA565JNgpg36wzpk1pqFUBSFKvY4l+eA5vZ9szNKzZa2raBlZtV7kXKpcsBKt5bg3ios9ohHRrVBXJ1p4BtvGKF38uE95sueA05LaKlwP5uA3O4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3711.namprd04.prod.outlook.com (10.167.150.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Wed, 12 Feb 2020 14:50:56 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 14:50:56 +0000
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
Subject: Re: [PATCH v2 17/21] btrfs: factor out found_extent()
Thread-Topic: [PATCH v2 17/21] btrfs: factor out found_extent()
Thread-Index: AQHV4XUOLDYNa4s+I0GICPILOs3mjw==
Date:   Wed, 12 Feb 2020 14:50:56 +0000
Message-ID: <SN4PR0401MB35984C7911E491F39BADF47D9B1B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-18-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 71cf156a-0db4-4cee-7e5d-08d7afcaf741
x-ms-traffictypediagnostic: SN4PR0401MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3711005F059F0E278477EA599B1B0@SN4PR0401MB3711.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(189003)(199004)(9686003)(52536014)(5660300002)(2906002)(4326008)(4270600006)(110136005)(186003)(316002)(26005)(7696005)(71200400001)(8936002)(478600001)(55016002)(81166006)(81156014)(8676002)(86362001)(33656002)(6506007)(558084003)(66476007)(66556008)(54906003)(64756008)(66446008)(91956017)(19618925003)(66946007)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3711;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lit9EbeMn7jIuzHPQnYHNECtoZVzEEj6ou3Pr7YBpYrGM5V0IA8s4L6WZ0eBjacvOSCo6BfcWp3XO/IvVtN+AQd7ks1xOhODs88j2GCw+i5UT9H0/qpaCa/e4yPtSY3b3u35nNdvm9mJiXy53IZLYhECHS/SlAeRY00OHWJqAkZH+zeryl1/ushMjj6jIdHg0z6nPR1d7u0umee2T8pNzpNEL79h9OWyvSTCgWtyIqHUwi51Ivzd4Jkcjijk2aLD2aqlDfLIEduI3ZJym0d/fvOU606/o/X9HkDfQjbcwQhuO676MD2GoocLcFYoegztMvumjbwwMZ+h3xPrEWW+3uWaBrMxk+QlBD+q/GlyeuYGpYmBGDzKKkQm8ZPoOrTlZeFsUN3fklrGu7n+4Wc5NwlAQAsdi6zcKG30T1EeckmKWtgJRzeT84XJFLBbjiWg
x-ms-exchange-antispam-messagedata: 9bHXxc0H927n//cVPRv9aEmDEWa1EyRbXFGYLhLBGwPZivG6SSTlzyfH51AdBjYotqhcqEc1X3Grmuzipv3kQU7g0e8J+wfLBokB25W3LoqwI+3uEPTFnkYJP3KV47kqtdm2FOI+3tdwhqa3KEptow==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71cf156a-0db4-4cee-7e5d-08d7afcaf741
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 14:50:56.1884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bRNdT2j+kM+0f+RjNTBhZZIFQeEnKsrHdDaa1xNirBLNku4YHihodDhCGuvwz+Hg/UgjMYMKjvUJta8Wa27UHfWFjoGM/09hWkJr4Eq1wWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3711
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
