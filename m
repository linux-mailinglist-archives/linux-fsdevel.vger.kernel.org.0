Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A848B25A6A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 09:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgIBHZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 03:25:33 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:33919 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIBHZ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599031527; x=1630567527;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=b7qb3TCiajUu7YTebKvXGvLqXQlfNc5YW6gu5KIJeI04aMp4BcO/A9TN
   VLrnY3QRsQCAxwdq+/tRBGoYxTVHdFgv0bKvy3CmQSgr9PxByhSmlpYO7
   iInwuTlMg5VhyVSUtl/FjBmwP79qcWu9Omom+5Vr/y/O0hjA1GhHOtDnR
   JcXuzUTYxaj2imY9n40F23xSjcnMVBtdNB5eLaQxzEKfQtkWzkreyvrWz
   dskBsHiNxfAp/GAkAhdUGf7baHEFBodOJN7x0vK8GZNx1D6mx3jwJcs5P
   K+GWLravCE78ZjPrfWI3IlTIt963NmhJopGEFHs2fgbAKNDFYpVMo8Esn
   g==;
IronPort-SDR: fXJETAcNQLN7LEW7VpJYhBjGKo7gZ7wKCRkpHIeQWNg6YWpSvmXvjeFax5RC5M9pEhVD63Nv6C
 VLxrIgtl4qDdoHxwiVWobhBvn2+jo/RP0wRUB6N1EJFj9ohUlJu8Efi1gA1PmgBjKKI/oHIXLY
 hmvGhRTgfUI0KYj7v5UEau64H90BxuKe8uQHTKTroOmIrcuNtuPSKVmJmN+RkiR4XrMJ7S1X2+
 oByl2eZ2K2yyupZt46GJNXR2ckVRzBxlf/QKT0enddBtX9cHuEqRQUzNOuz8C13P8dwq1ZEuur
 wxQ=
X-IronPort-AV: E=Sophos;i="5.76,381,1592841600"; 
   d="scan'208";a="150728301"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 15:25:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAumDdQ379wMVhjMVIlCBsNHlf0I7TylEa01yaiVQCu45oSUsNhfSvaxuux/lpHwGG+an5lmKaM/IedmF0nEjje6djK4qZrcjxo6X/3oNCppSbORkNBpOS7Hb5JCYeRrlDg8RwxnoFyrJ57972yX7+LwlcT0aP909yXP/eNqhV/ET9vgocNlUhEm9pQPz9Bqhecx3A62N17Cj3OOvt39SUjVMe603G8/wQSTg2x/oERZy2g5Yf0O9WfUavMlWou5+nZiBOwpUEezuPHFo4sDBP36b7OuGNFPGTZ27j0sLz+Z+FmzpFEpdL0uUcjtX6brQdfyDk6RV1gu4wl8fqr4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=GV7P0RlHcFuIoOFDIjg+jzrj7HeLUPdQSLb+xr6FNShXkeS3+dRyuLkER98+UceXRIFD7RvMbkj7MdzW/dNAQuxbCAxQAmK3I6kZ42euingdwY2i89f+YZjvWnuZDn8S7fvjOFqsnbqgaigBkj8tghUWTYcVb4h4NhGSKvBHi7AhbWIN5eo35i6YA1wIMHrgKuLZWbPlDOWRA9ejLr7w8TT57fYrz5K5be7rgxHtaBVPkcYu1h0zr4O5HzsM1Jyubz7W3qFjKZ9TyqB5OYD39M1EHaaZ+GSX8WLzgH6Dt9MLz2l1xYcbi3nTnNa1Zakqxx7b3CPXJcqwaMCCFSH9UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=cesCGjJeg67Fr/o+mffwEK2tKaA/9Xq+dcQTCLG/hIz/S90fBAqrcc6/QHxisuVuHGUcEM6SzYv9FZX8BAN1FJcmCR+KR8eoxCBG3vWy7cMD7XBQXmWpz37eOsIZ8AePqLzyrkon2Q+Welk/SUbU5ix53KOLQzyNZFZ0y6+oUqE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4238.namprd04.prod.outlook.com
 (2603:10b6:805:2c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 2 Sep
 2020 07:25:24 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 07:25:24 +0000
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
Subject: Re: [PATCH 9/9] block: remove revalidate_disk()
Thread-Topic: [PATCH 9/9] block: remove revalidate_disk()
Thread-Index: AQHWgHjsV9Wx4QVWTUmpDJeETk/HdA==
Date:   Wed, 2 Sep 2020 07:25:24 +0000
Message-ID: <SN4PR0401MB3598AEA05439AFC90EC56A5B9B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200901155748.2884-1-hch@lst.de>
 <20200901155748.2884-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:bd07:d1f9:7e6b:2014]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 56a9516e-9407-4c12-2214-08d84f115bf4
x-ms-traffictypediagnostic: SN6PR04MB4238:
x-microsoft-antispam-prvs: <SN6PR04MB4238A60483B44842DE54E14F9B2F0@SN6PR04MB4238.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +QuZyk93hFCG+4OoRyiTp8yfdan5CCNsg1rveJPbezwv4RfQDVnNUewO8TCxY4Ojzk2wzTjVGEUyvlY9Eirbpu7ayh9JdAfZO8gq2MFhNyR8HEAqTO2ity+LzQ418vLBkwwnHU6UC5beXkShDrK37fThx0P7fxGBAcfTe635uUeZr/HnakuXd3Ovi3B2Eewza580RmLcoFeN8GNRPosL7i8bLRg8ciJ84I8mpI6mE65Z3dqhSy1YE6Hn2HlXUdF2Rvgy6973iivq/FCpb+60WuOm3qd8YDdUHda/CdC/qaw3xvEjDVKjB50M2ybJsMIKW9+bWt7h29t4YdBsIC+Wfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(7416002)(2906002)(19618925003)(76116006)(8936002)(5660300002)(558084003)(66946007)(33656002)(91956017)(86362001)(66556008)(7696005)(64756008)(66446008)(66476007)(316002)(52536014)(8676002)(9686003)(71200400001)(186003)(6506007)(54906003)(478600001)(4270600006)(4326008)(55016002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: yYWhuFO3+1mVufL+7/XDMetN8PFJUrNbHwiKu3VgtUw3teOPU9Gdef21UCo/B8dWn7/i3WN4PSaiMwg5r5suGsCwCqs53dcz4PixltVNvR+X3H4cCtWV07CseGuH1VnTXZJhX6/UKc2WcUNLp4gAwIE05kRG02yVo92oXcQ2E9yyZdIXrKdORjJ+tGRK8CEKXD2QWrSDPo55VXGi6K6hbRHY3mJdFsgDF8uibBcz2Jl29RypT2/39fU0RW9wL0z9bINjNUZeQdl2wmMjH5RhivQJg4CmQCR8VWnluy5G2Ud61BOo8tJ3L0wQLXCgjXA5IeAqrqIClEyG2d2GKEk+dNTGy4E2qJbEnMd7IcPLoCuJEBjpg7aWVofIZM+oBxxL1MLJFXyqCBMxm9L0I7ZXarr819sTr03OYPKC10vE0Efk/HGZnJsXRFy2+yYlk4uUre4YqV55/R5iKZWkomR3mnLUQJ5t301jzIxzx27daveW/Iks1Q9jAMz4UN/1Wgwel+h8gM36QBit8ZM7gNkru9xBrs9Al+JincBBmdbQ/3NkjsyMePwluJZJh38Z6/3oKgwevqIyOueV7IYnyzRZDmUjW/dBp4mUx3sw4Hhv75KJlIyVh1EJc3F20Hjy0qetGrzbMrpYymC2zRBH8hz9nxkkQWBW3BscPlmdACymSjk9f7SVjXxA9QmFmRj7VTU2cZHceFtEdoraJz3s5CAfKw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a9516e-9407-4c12-2214-08d84f115bf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 07:25:24.7140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1jDmRTD2XeJ1WDCANZ3s9tarIUmEgrjdIo6AcCx+DZ4GZjVbbGdD5wBDIkV4JblgCahOC8m6otLDhimciYzeBWSWiKAiL8J2qvtUilvhsik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4238
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
