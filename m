Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E9725A691
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 09:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgIBHYh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 03:24:37 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:33840 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIBHYf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599031475; x=1630567475;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=jcMPqePsqFywPxqGwbexg78RKYFYgoEg3HY/S0kRKg9YeiJUZFB4SgdD
   cQkzIv1pCyR02NgOwPoRfMwBp8EeBg8h9C72xod9X//47yGHQ8alsEviW
   XXdopUD+mhWZ0g0sSMe8zErmDreLRJxiETCC6h+T0CqXCP7DsRVDuFvTu
   lOXNSUdRXO2ONxP0dqZEfG3ozpnbvYJbmYMfMh5Nq473beMaYPSmxApzz
   lUhuuWV+LDH2l9qZI5H1k1MkUuVYNoUGEMR8K7qxgC+Ghne6/R8uZ/bQk
   m/BDajcFJi0RD0AN0Kc+hSovftwPS9542Xe5ejhbmpiBHpnddsIk/T1kQ
   Q==;
IronPort-SDR: e+2NK0Rm0H8+t7/xXqCbp5NIzKL7O1JPSAZ+enQuzI638BywQZI80hoAZ37K8Jgai+smuvel3+
 YC6Y10oS3T8y4O5HylgnrSXPHMpL5+k4hZrWa7NBgW99lMBZJW3gkIbB0zDZMVY3/sN0+0fLYF
 mSMT0CX5c2gc45MtBkOaFzt2B89kdet5mrVSr8/oV47Or52EAu1q30qEDHam0adgIPFGvxwzyY
 314f2pKMiljuQdiComLJqG7D8THr+VbWjHfDR1hLn4LjwLNK9kXY6heVb+TF263V/Y9iCN4IHH
 qpo=
X-IronPort-AV: E=Sophos;i="5.76,381,1592841600"; 
   d="scan'208";a="150728245"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 15:24:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqPhMKNs3dQTZin6FULjMOXpyYQyT1wYJbdIb0qekPcD42I5nNM6N45/COA2nJHqjpE2laANdEIykB+zMqGmcNntjsdkFNpDaUBa98xsEDq0p4SEj9mmwFZFSIl9jmea5K4+wVj7NUFmj03r7yKcW1DQY24RnK2pQl0E6gapXeFuO6FjpSva5bGXn+zOvTLIDFAq0Nrfe6QUhH3B/vo9ztu/YvgYDEtmqIvBEzkHQqRyW36d3SFKIVBJ2cV9rAPLfcsoMBLPe5vpPqeij5RhyFY0nhS9tSGBKdmwjkpoucx/Bq93iCgvFt8wpHFNSrIvBchRjA3fTeYYYh+ImqU7Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=XSWcGXdxawjgKRiW0S0B+3gfWZgqrtiCw8SQGmNA1o8e8ZS7rjpAb0Y916lYbdLyrASgoGtG8wWFOKbQR0C7JbRK4oZcMF4n9Tj1V1NOT2kJs9zJpQDB0UwTaFCSOLMNR+M3EFRDjcmylHWjNAu6RJG4CGpjDs8n4LMnYXK6dpiIxk1aWqO1iKFJhufPvcDdIeZd32GPBOTbclXntkt9eBIffEPJ3g8GEftWegP2qhk99l1OxBxuv/1vtjWG51ggwtDAFq6JIo3yN9qiuAvcVmg5rkMwrvN/0cARHOoWbKwjBETj4xHmbHEYou30OTCqPs7tSBzCBX7TKZEc1My0gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=iyPaOVGQQEHDkSC5loJyypyAazcLmXECdlt11aPNkgkt0Be7vJOcibCTSEx5iXJ0CFQJYnX6lJuahvLGNt+uKTf7oJTVvafLiwwLSMDWBdTvWmn2fUP/5Ssd6iyYuKQuKAyPI206OrZ7dTcMNdqngvFcsMhpEC+SMqCCfcrl/8Y=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4238.namprd04.prod.outlook.com
 (2603:10b6:805:2c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 2 Sep
 2020 07:24:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 07:24:30 +0000
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
Subject: Re: [PATCH 7/9] sd: open code revalidate_disk
Thread-Topic: [PATCH 7/9] sd: open code revalidate_disk
Thread-Index: AQHWgHi9+D0vRxf7MUaqbL81EAOZ+A==
Date:   Wed, 2 Sep 2020 07:24:30 +0000
Message-ID: <SN4PR0401MB3598270C537F0E7A3ED538049B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200901155748.2884-1-hch@lst.de>
 <20200901155748.2884-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:bd07:d1f9:7e6b:2014]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f12e4383-fcd1-41a8-ec18-08d84f113b95
x-ms-traffictypediagnostic: SN6PR04MB4238:
x-microsoft-antispam-prvs: <SN6PR04MB4238C6E35A3E8051FB5A3C5A9B2F0@SN6PR04MB4238.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bMjGwrvH49VG+SFumlAzF3c4O31aq6r0kIkCIOkw6SFfhFSnzrDt01M2WOR+Ek/f1JURBf5dlcJBqUxLuovzqS3Uc+BonFqSC094i2UpFonDCFaWi+TvgIqvc8VpM5wrtra5xWM1vzdGMkFLcPpzHCfkKK0BlyWblj4peSxPyVMc7gZtv3r+jum4RM5z4pIr95h1zNGlACxlZ5AG67OyGNbd4ADWi+vefuqz0qnVCKGk/grP4GvcdJ5fHVoRjDo3EIlOEBIIJG1JJinxgalfMzHs55RsYenkduPUoAVhBps5YE456bMOzcoH2uyLYnv8WkZJoo8p15iFkLWBufd0lQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(7416002)(2906002)(19618925003)(76116006)(8936002)(5660300002)(558084003)(66946007)(33656002)(91956017)(86362001)(66556008)(7696005)(64756008)(66446008)(66476007)(316002)(52536014)(8676002)(9686003)(71200400001)(186003)(6506007)(54906003)(478600001)(4270600006)(4326008)(55016002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ngkVHmW3/Bt+G5u+vylrG+VmQWBrwJdyMKVQ6lc7NsWLaz34Wky7qCz4D+3YBInqlWVwEtDiPb3fLXIwkFzvrPAa9j+N5y1BrwHvK5XeCSzCi0KeaaIOcIu5fbWTvPLfN/eHsaw7soQCL2pxUA/+YmuKFgbiT671ff+2SlQptf7Sa2/PschaqWGElfPuCYYz9iucV1V6ZiM6IEYAUU4fdjQnldVWApVOyoSQORvnAXdXS7mm48wFeBSR+w2qPZAnZ2OtZVBtFCGP82AySy06LCtAXSrdP18fiTq7UKG5ZWfj7tA5snniLmp/GKlvkn7GJGgSp6gFmna5clwcbRXAvO2RQdFHZhAdhkU3KseXOW6PKXl4zCMpO3QGTb64BD6kidLAWkWdX5VRAJYidQGqI1btlc8aiR6aeKh+DLHlEjPd8ekISZe1FySLjN025nhVn+v+NkR61SyDx4k7utXDrMlugXPpGPNavOomIX+noV8/mJw0f1DhkW2jpnd2fCBflToEO6PrRWTEstzYoqrGOxPOo109IeSopbemWPZ0AhuDrNLzzUzFRcoAy4cInX8JDP8VolFu1gHdRu78grWtjqoqDGMP42F7aSvE+8f6HRyoJw/cWSTBckfWokesve6Jshvi3Lt52g4KCAwwI8p3AoO58aHzH7Xo/rjjwAGGfIx21owcdNyx2LW94gEZCbPz97U5gbswioOcZ7G4BhrtlQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f12e4383-fcd1-41a8-ec18-08d84f113b95
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 07:24:30.4715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hod2R3pvj6h3UjZbl9iEN/uDfqHDePJ6WU4fywwecOvUVJ9vFBEPV7QuGvYcjiZFqcxIf3o1RrzCzjPbkOVIU+3/vIZ9wRscUvOVOwlMoRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4238
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
