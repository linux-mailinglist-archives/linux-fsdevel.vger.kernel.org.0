Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8683445E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 18:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbfFMQr0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 12:47:26 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:49286 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbfFME72 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 00:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560401968; x=1591937968;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=froBIPifBYx27SwWUHteL9+TGrAfb3ZLthb2Y1Mh82o=;
  b=rCSjt4H5kktAq50t8QH521mHCrks511nJpZL6GJAS/EuM81pYYjtgnfK
   SEWx5D5U4Ht4Idia6QPfigSskSTLgmkbbPBgy/iktVm4yoQ7/Wo+dmFp4
   v+0XBduJuj+R1ArnYmgePmYmXxm+QRMmKAr2lU2ddLgpl1I0yuolxdAy6
   fMJHfhWkkebUUMpzqmo3CYsMCgins6iLZNJb8cNWuFKtN2RDvkIm31pnf
   HxoyZlzftNX5Oruq3xOgpPIs9kauwG4AqBdeSGfTmucN/szZUDhHvhkGc
   4xtEl0Qja6mI2T4YvtQOGBEJXnYt+aJm2rX6wB6qlh1ozoJYP3RDlPY33
   A==;
X-IronPort-AV: E=Sophos;i="5.63,368,1557158400"; 
   d="scan'208";a="112089076"
Received: from mail-bl2nam02lp2058.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.58])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2019 12:59:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=froBIPifBYx27SwWUHteL9+TGrAfb3ZLthb2Y1Mh82o=;
 b=i59vNMQpTaO9sHtd1VnWzw6WxcFG0TZohAYd8IT1tPtQ8nf4FQGH4Ea8AF70ID4x9Y8xtrFNmloTqWDsQejUeVv4xpVzNDjhDfc2eOpNfcxSG4CG50UGHdpGL0Ds7LtwxNrfkyExT6KjXuF8cQWrC5rgxkskfuUDz0UPHs1GlXc=
Received: from SN6PR04MB5231.namprd04.prod.outlook.com (20.177.254.85) by
 SN6PR04MB5469.namprd04.prod.outlook.com (20.177.254.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Thu, 13 Jun 2019 04:59:23 +0000
Received: from SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088]) by SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 04:59:23 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 00/19] btrfs zoned block device support
Thread-Topic: [PATCH v2 00/19] btrfs zoned block device support
Thread-Index: AQHVHTKAMt+QxADp/024sRBo1BQ8yw==
Date:   Thu, 13 Jun 2019 04:59:23 +0000
Message-ID: <SN6PR04MB5231E2F482B8D794950058FF8CEF0@SN6PR04MB5231.namprd04.prod.outlook.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190612175138.GT3563@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Naohiro.Aota@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88ee645f-50c3-4ca4-d0d8-08d6efbbe721
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB5469;
x-ms-traffictypediagnostic: SN6PR04MB5469:
x-ms-exchange-purlcount: 2
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB5469E8F89BB32AA3CBAEC9978CEF0@SN6PR04MB5469.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(229853002)(53546011)(6506007)(256004)(33656002)(2906002)(71190400001)(71200400001)(6916009)(1730700003)(8936002)(81166006)(81156014)(8676002)(7696005)(102836004)(66476007)(7736002)(66556008)(25786009)(91956017)(76116006)(73956011)(64756008)(2351001)(3846002)(74316002)(66946007)(66446008)(76176011)(7416002)(99286004)(305945005)(68736007)(6436002)(6246003)(186003)(54906003)(5660300002)(476003)(72206003)(446003)(26005)(966005)(316002)(478600001)(6116002)(9686003)(52536014)(53936002)(14454004)(55016002)(4326008)(53376002)(66066001)(2501003)(6306002)(86362001)(5640700003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5469;H:SN6PR04MB5231.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R/Kt3jxwG1IpmP2qaeH9kAG9bzyO/MLbAqxdV/V9lh6Rynp06J4PwbN69qOJCEq5qOibH3GYly5SitPBy2szgMqLZL69XjTB1+OrzyK+q4libGsUK8vV7VJ9vwPZp90OhM/B8Rh3TKoL/cy6/KrQIK65UHC0kuRhT4s2cBWkeVnsUQUAgjPb8y5VXtMdXdnxxEIXB/N8jvH9bYRtOPhXOxJwNTTjNV1+8Zna3REeiLbCSS4l82Hb+WHQA95+D2JA3TOhAEQ+ksAm6+2ww1KpVJkLcGeYGl2Pu5x0ht4Grzpzov9fUeMrYHzX/Efoz8vAF5lbCHbxnLVjQCJwiuCNSZ2DvIxGn0EkF5NZcmm3Zv3UU9Ca7N87LcIYgoD1dc7tw5n2joIpJBSHHGBaSYFuh1zeM9f6diKbg75UAYSN2kE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ee645f-50c3-4ca4-d0d8-08d6efbbe721
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 04:59:23.3460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Naohiro.Aota1@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5469
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/06/13 2:50, David Sterba wrote:=0A=
> On Fri, Jun 07, 2019 at 10:10:06PM +0900, Naohiro Aota wrote:=0A=
>> btrfs zoned block device support=0A=
>>=0A=
>> This series adds zoned block device support to btrfs.=0A=
> =0A=
> The overall design sounds ok.=0A=
> =0A=
> I skimmed through the patches and the biggest task I see is how to make=
=0A=
> the hmzoned adjustments and branches less visible, ie. there are too=0A=
> many if (hmzoned) { do something } standing out. But that's merely a=0A=
> matter of wrappers and maybe an abstraction here and there.=0A=
=0A=
Sure. I'll add some more abstractions in the next version.=0A=
=0A=
> How can I test the zoned devices backed by files (or regular disks)? I=0A=
> searched for some concrete example eg. for qemu or dm-zoned, but closest=
=0A=
> match was a text description in libzbc README that it's possible to=0A=
> implement. All other howtos expect a real zoned device.=0A=
=0A=
You can use tcmu-runer [1] to create an emulated zoned device backed by =0A=
a regular file. Here is a setup how-to:=0A=
http://zonedstorage.io/projects/tcmu-runner/#compilation-and-installation=
=0A=
=0A=
[1] https://github.com/open-iscsi/tcmu-runner=0A=
=0A=
> Merge target is 5.3 or later, we'll see how things will go. I'm=0A=
> expecting that we might need some time to get feedback about the=0A=
> usability as there's no previous work widely used that we can build on=0A=
> top of.=0A=
> =0A=
