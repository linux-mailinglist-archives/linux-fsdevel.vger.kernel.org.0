Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A0C1AFEBE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 00:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgDSWvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 18:51:18 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56147 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgDSWvR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 18:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587336677; x=1618872677;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mTTmK7q0yO4coGpWvIlpGfYcfoxGCqL05iuS3kfF9wA=;
  b=QMK+SYEaFg0K4gTKIIKQmVh0jrkrAQSPIQZHuPmlVXVBvUeaNwK8uOaM
   fL24FgC70izTt8cOcOHok9ld0xlC37DTp/GgH10qGQPQwiupm9o+wbYrJ
   ds8y6Zm12c3vvWuSwc7LwBQ0vGGSi3S5xZLKoli5qTR6ez6vhYZ/rQCQT
   dxYXTt4iFHoSWOQZwouLLFFALQM/F4AJ5GzLrC3Ztps8fDFgZqGxJMs67
   wfGrQuhofOhOSLfPcE1j3tHHRFLxfbXbExYyJVpMjfae+O92RereiB8sF
   8XSHu8upCKCVIV13ClRzQUUIQt9UBfdBJgMWQIdham8oGAzP3teJ/OmbA
   A==;
IronPort-SDR: 3siX3UDCHATzkeFJgFPfJG/yaQqom8458cy+J17NW4hkFiQ19AxcZbM6rI5VbtrOblm3EdAwE1
 BlogCofU7HZutdc4X+ZwHJpH1oA1grnCLXASg5I/bY7sUGJYCyxqi4eDEjoo4DeAhp8jsPD/l5
 kv/BE27XTNdL5oa94ugtcBJQoCwZdmhWLtZtrGKt2oH84gdbTDJFf9ZLDRWU4dB1V0G+CG593R
 44qB+iyjOslkKPgexzO3GLwXesLdOGJ2FI8MQvZTO+M5FYQ34+MChuiIKbEvcd42wkJ7g4Ymxf
 6X0=
X-IronPort-AV: E=Sophos;i="5.72,404,1580745600"; 
   d="scan'208";a="135974969"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2020 06:51:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMNWlF/v3JsXn3BDQC5RYN3dGl+gn0vYSsjZLpIAAvcygP3b8dGEpmQh97BFo71M9/IGH5wcmGNYV/butBHW/f2Vrq2yeu6X1QoclPrzxjtDiaQb4/eME3zgXnvDHvlm1ji8hAKkCwAB36sS0TerTcnksKOiPdwI8c2n3LxySgO6uyqA9Lm+UN9CB3ZCj5IK09/px1JzW6jJ2xXC0l9zp2RH6x90sKkIiKBP++xsb+3DYG3V+89OWJT7scLcgUoyTGosIOVyb+otGw2yf3gp1UAFoLf845tPg6fzEvSskitvPBpieytXTJv/Dh3pfmLE5V8sQrU32fD4gWKvQY938A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2DHOOq2Kq+LQtWs9Pbp263CdiewWOt/5BpAI+RjcIs=;
 b=O2uQ/o3WoBsFBEs+jNWV7BiutZNiGlrc1IYhBhmXQO+BdW5ikUpVCDR+jVTtrIyAwZfwX4Noq3mf/VBLO6xaio3XoZ8mn9iVElLPg4CrhGMU2IMTbaZ+gf5pMcl4/OXU9JNCR48TLgdX3NAfzaHOU44pr5qWI9nQCAxO4HDfH6seGjHpPaqV4MRfdqw+pvUv9r+rFjDuut1kh7r2DSXdHe93pfJNDXIBInvJzhVthNtglPWLu34vN9zC1Vt/fiRHFU2IrMJg+hf1ghsYgWPHnp6CRmwuwETi/A0VypWRI3yQRISARlyxNuKsaY6Llg+ysw/7mHR4adysIbXprJEyAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2DHOOq2Kq+LQtWs9Pbp263CdiewWOt/5BpAI+RjcIs=;
 b=h/tIxyM30j/lHmoVBE4rb/EoBX6Fjz3l72AwvZDpWKIkLNxBnQ+GW+PycDTdwuINPUhgZ1NwENur0T2Jea8Y6c30KqlZzgjv8p3MVv+O4vMNd6tnyNL3mOvxRo8F3cT2ZicPiAQknbn+PWrWMAVdyNY5TXEej3ncI6w8gnUiMBE=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6707.namprd04.prod.outlook.com (2603:10b6:a03:218::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Sun, 19 Apr
 2020 22:51:14 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%6]) with mapi id 15.20.2921.027; Sun, 19 Apr 2020
 22:51:14 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v7 00/11] Introduce Zone Append for writing to zoned block
 devices
Thread-Topic: [PATCH v7 00/11] Introduce Zone Append for writing to zoned
 block devices
Thread-Index: AQHWFLHwkjv8AGgYT068A9OaCOXxMg==
Date:   Sun, 19 Apr 2020 22:51:14 +0000
Message-ID: <BY5PR04MB69009EF812BBB66AA6739984E7D70@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
 <20200417160326.GK5187@mit.edu>
 <SN4PR0401MB3598F054B867C929827E23F49BD90@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200418010055.GO5187@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 907fb480-9b1a-4c81-02f0-08d7e4b42a24
x-ms-traffictypediagnostic: BY5PR04MB6707:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB67072CD4F6D693B179BD5CA2E7D70@BY5PR04MB6707.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0378F1E47A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(6636002)(5660300002)(7696005)(4326008)(110136005)(54906003)(478600001)(2906002)(64756008)(66556008)(52536014)(66446008)(66476007)(55016002)(66946007)(76116006)(9686003)(81156014)(71200400001)(86362001)(8936002)(33656002)(53546011)(186003)(316002)(8676002)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VGBx19SrYjkXBFxK25BwhA8Fvq39bpiwYjz13+0A5g5kF7XuGW+VNgD3h0/fB6rdT2qnVRFeW559t3a4vVxPu7746bPGg2xqIWhCGYeDF2+YjskdTPpx6e11rSBLq4Lobx8e0TZKlwSiSzB7L4XcJyP6ga4pLo8YLNn9Wpgz3eueeyQAzZ43EZfiedb4+n3ehunK/G9d9o2kU1MbX6Cfurl90P11k8xqx4DLhNUsna1c4LU/73Cfq6i8nHNor8If8IwhqT6pEMC1HmRXsZ/P6Sn8iFlXREMeEVWsFWzaXXplvMmR4vizwe1DhAgzuMcGa7xr2hdJcS8Nbf5WGIz1Mc6NsjeekoLIOTwMZsKcjObMnHtvA5iMcvPzgM+sevw+LKNYvpIYSDY5bBDQamqtXDpqYvryqKiza+xGy4mQ/haLemOFrrkNi9kUFgm+FO0R
x-ms-exchange-antispam-messagedata: mgjG2LrCIuLDeyT7Qwh4hoCd+zZ8CGhV6hQWHuOlZEtmYjvbv8AiQx2gzR7W8zU6K1sIa4QmQb7J4xTx05Hq24l9Pfi6crVNPNAMNdqAsjDwtEenXu6YWKTwn+gW7e4f5qX1MJeDF9FY6WYct+Hm6Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907fb480-9b1a-4c81-02f0-08d7e4b42a24
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2020 22:51:14.6402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5u9rWPUkxtPgy63GUAIEmTout86t/LSC7f517IsS8JwsjbimJScxjKQ6SBkPluR2ws3x2RNLNjIO4tknacMq/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6707
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/04/18 10:01, Theodore Y. Ts'o wrote:=0A=
> On Fri, Apr 17, 2020 at 05:48:20PM +0000, Johannes Thumshirn wrote:=0A=
>> For "userspace's responsibility", I'd re-phrase this as "a consumer's =
=0A=
>> responsibility", as we don't have an interface which aims at user-space =
=0A=
>> yet. The only consumer this series implements is zonefs, although we did=
 =0A=
>> have an AIO implementation for early testing and io_uring shouldn't be =
=0A=
>> too hard to implement.=0A=
> =0A=
> Ah, I had assumed that userspace interface exposed would be opening=0A=
> the block device with the O_APPEND flag.  (Which raises interesting=0A=
> questions if the block device is also opened without O_APPEND and some=0A=
> other thread was writing to the same zone, in which case the order in=0A=
> which requests are processed would control whether the I/O would=0A=
> fail.)=0A=
=0A=
O_APPEND has no effect for raw block device files since the file size is al=
ways=0A=
0. While we did use this flag initially for quick tests of user space inter=
face,=0A=
it was a hack. Any proper implementation of a user space interface will pro=
bably=0A=
need a new RWF_ flag that can be passed to aios (io_submit() and io_uring) =
and=0A=
preadv2()/pwritev2() calls.=0A=
=0A=
As for the case of one application doing regular writes and another doing z=
one=0A=
append writes to the same zone, you are correct, there will be errors. But =
not=0A=
for the zone append writes: they will all succeed since by definition, thes=
e do=0A=
not need the current zone write pointer and always append at the zone curre=
nt=0A=
wp, wherever it is (with the zone not being full that is). Most of the regu=
lar=0A=
writes will likely fail since without synchronization between the applicati=
ons,=0A=
the write pointer for the target zone would constantly change under the iss=
uer=0A=
of the regular writes, even if that issuer uses report zones before any wri=
te=0A=
operation.=0A=
=0A=
There is no automatic synchronization in the kernel for this and we do not=
=0A=
intend to add any: such bad use case is similar to 2 non-synchronized write=
rs=0A=
issuing regular writes to the same zone. This cannot work correctly without=
=0A=
mutual exclusion in the IOs issuing path and that is the responsibility of =
the=0A=
user, be it an application process or an in-kernel component.=0A=
=0A=
As Johannes pointed out, once BIOs aare submitted, the kernel does guarante=
e=0A=
ordered dispatching of writes per zone with zone write locking (mq-deadline=
).=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
