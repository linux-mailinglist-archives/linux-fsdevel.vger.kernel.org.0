Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F01B9C876
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 06:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfHZEjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 00:39:37 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:47241 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729100AbfHZEjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 00:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566794377; x=1598330377;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xJjqFcsR8vYMZBXNfORqW6HHhuJ85c9HAqRVtwNFXXs=;
  b=Qm9omyy9nCkXksOGe8a9X4zoA0rzBOsSeDlC6q2FfxEdWibQHaAq2nau
   hNSjOJDFDJTAJuK/VNcu2COoBO/wbPDG8u0KOfpf/HspRuq4swQmM6GfQ
   MwdsiHdxAlC04e7fXjB6bnJohjoY3a+zRqPdYFo/+OFJ7Xc6YfG2JUcN8
   FrRi6eH8DHFIYkcvOz4I4eOL8WfPczLKYtOAfXzT0BBsNl7RKThtRpV5Z
   nHonvpjIrslQ9tBjVT7XJwzfqg55Hj+hIrHu3+Tf24LRTTPj08KKX4RVO
   HlC0hNroHtHrJYAq+sPXzWXizyp8L13gsoad4JO7+VjV+baRhPVKr81Bs
   A==;
IronPort-SDR: QJDzR2vrW0KyoH40ksJHnUhkqCQ3u/bpVNJ2eEN7rO1vlUwlxQ7mD4kNbAeS+OTLsXMeKopNXo
 mrdVoBoj1IcQFb86ixYlW69BABzR4ILibsqhjXeCQ6IvHz/SAHlZn7WLhs1rmO/YUdXK7C2uDk
 /7+f3arXZJjJbCwMOkCQZ1HCCslOQF7saQvkH+ilZi9oDwUu7JCEvjYtfdnsxhV//9DjM3wJp7
 CyGS83AE31G/uz/z3Faf1MGJ7Ky+GIyzCtaC97juZ/doF6xSNYkVfQjzoFat/p4SYAR00Mw3VY
 YJc=
X-IronPort-AV: E=Sophos;i="5.64,431,1559491200"; 
   d="scan'208";a="118237847"
Received: from mail-bl2nam02lp2050.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.50])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2019 12:39:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6VpeFUIB6KUdLYN/4q833raJZ4gcn8csNKc0pPg6bFazR/e4aWxv+Gs0L6NEIrD+wgH6JSNoRujOyCnB7YTdwLWFWGY/q/9AmxzmyqsoT1XhzHo32RWtuZuA4q8upWy6qIpJpwdiUL9i6byAppL61ZpPq8cZgA4mI0ZYUXNx1P48zc2n2iBLUJhJb7hyCQjxygxOvGibw/FMdg+E7inp50mM4ZbmJhqN47LAm4KsxPqR6sRjaEK+ei9fUp6T/P9VEHG4c2c9SKr7uQeIU5lpQnsuq7dazhsKB35Bgf3o3N8w9cb1MIr4a4HjLuHVX3dxrvDXIOMb9DDYc2vSt83yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4gdoEBS+l1vtTuy5mzIX7VvxBpG50mZ3OQL31myG80=;
 b=P7tzWboaiR3Ds7PdyUVXs2gzMdpQo1XgMi8ihRQsgk+Jlf5khJk75JBDRW5E3s4Vj5LTSDMgWhr9PM1mXlkcLlmr++TVDbje2WdnljyjlzfPamiGJdqJa4OvFwo3X2JggHd2M5VU/rytNZTBtukOPxNR1om6s4yOWVMAmKS5E7Dy+Q/k9V7FdNWf8SLktCiTLg+p1zbRSePBZzHGh+dQWjh6am/8jfCtMa8gdIAZKwnuK49HQecPy1WsnrcWKoNIpXJ26FtaD9/KdPYp5iJiE7FOKiJ/d3NgxWrWgjqBniky3swpc/wp5oTaAHFJL25nxgvGOoGvkV5q7JJfcyCKmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4gdoEBS+l1vtTuy5mzIX7VvxBpG50mZ3OQL31myG80=;
 b=IxKKT3kX6FUORKpxtuwwr0SbHkdPx72Zc2jomAb9JjQk3/whXcS/a01+b8jhAnSJd25cSwb6ma/fIs3ZlVBvVkNuUd9BmRD6d5Tny5HeY5Tls87whJbIHSqACpd0YaKNL3cgHir9V/jLDa89rkQG+orBcg/iVYBRg5w4/7eXlUU=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5062.namprd04.prod.outlook.com (52.135.235.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Mon, 26 Aug 2019 04:39:34 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::a538:afd0:d62a:55bc]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::a538:afd0:d62a:55bc%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 04:39:34 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH V2] fs: New zonefs file system
Thread-Topic: [PATCH V2] fs: New zonefs file system
Thread-Index: AQHVVy8UVAVGvwSe4Um+ID5oFBsG3w==
Date:   Mon, 26 Aug 2019 04:39:33 +0000
Message-ID: <BYAPR04MB5816B9DAA7DACD2DF62A0B3FE7A10@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190820081249.27353-1-damien.lemoal@wdc.com>
 <20190822224355.GX30113@42.do-not-panic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e1e556c-fb3e-48c6-0007-08d729df64b5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5062;
x-ms-traffictypediagnostic: BYAPR04MB5062:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB50625801F83D68E2218BFD77E7A10@BYAPR04MB5062.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(52536014)(486006)(33656002)(2906002)(25786009)(81156014)(478600001)(9686003)(14454004)(53936002)(86362001)(316002)(6436002)(54906003)(55016002)(229853002)(91956017)(76116006)(53546011)(8936002)(102836004)(6506007)(26005)(66066001)(186003)(446003)(3846002)(71200400001)(71190400001)(5660300002)(6916009)(6116002)(66556008)(64756008)(74316002)(7736002)(305945005)(256004)(4326008)(99286004)(7696005)(66446008)(8676002)(66476007)(6246003)(81166006)(76176011)(66946007)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5062;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nS19F4qRB5ysQAFMbhuaRE8MjBTIdXHCfN+0llC4A4OEHjkJKxlx2TefNTioTovCifQiTvcKPmy5tqAKCfjl5t1Rq+4CEN82kflS1Zl4pn7b8TtoIVTXhFau+CSGX5WP5QF/4L4S3bESzCtLQuaUJ36hn6yUp8KSUNgtJFClmRAmTE12NczQjd+x2Pjy522Xk+E90SW7XkD90uemPJUtLI3iKYDh7/JXwSybGjnN8BcZp9mBUY22ou754c5wV9LY1cvcIY+2c+Hf4mGVESOK5DqRjAEEb5/185PUXGe+kH/69ATIINdqcW6JPjgz0Kf++BN08AZDaKXjcNfDSeU3/QKP4QtVeogDn5TIgZkhUlba2Mqk+QH7EtpllPt49386F9SvxImBcQ+2kKO0J7payNefx7c55JWMnhqAWjhu5Kg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1e556c-fb3e-48c6-0007-08d729df64b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 04:39:33.8974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EUwEpRdUwocWWzbF69Qfqdd4QyLfha3oEnqTMVCJwQICoL7zRPl0CAPv0Jb3bRrkBU/y3oH4QBunh49qMdSNwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5062
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Luis,=0A=
=0A=
On 2019/08/23 7:44, Luis Chamberlain wrote:=0A=
> On Tue, Aug 20, 2019 at 05:12:49PM +0900, Damien Le Moal wrote:=0A=
>> The aggregated conventional zone file can be used as a regular file.=0A=
>> Operations such as the following work.=0A=
>>=0A=
>> mkfs.ext4 /mnt/cnv/0=0A=
>> mount -o loop /mnt/cnv/0 /data=0A=
> =0A=
> Should BLK_DEV_LOOP_MIN_COUNT be increased if this is enabled to=0A=
> a mich higher sensible default? Right now the default is 8. Also,=0A=
> can we infer this later dynamically so so this can grow at proper=0A=
> scale without having to have user interaction?=0A=
=0A=
I am not sure if this is really necessary, though I am not against it. I ad=
ded=0A=
this in the commit message as as an example, simply because it is a very ea=
sy=0A=
way to test that the aggregated conventional zone file is working correctly=
. The=0A=
tendency these days it for drives to have very little, if any at all,=0A=
conventional zones. Even if they do, using dm-linear to chunk conventional =
and=0A=
sequential spaces into different block devices is probably a much better wa=
y to=0A=
separate the 2 zone types into different usage patterns.=0A=
=0A=
> =0A=
> For now, I mean something like:=0A=
> =0A=
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig=0A=
> index 1bb8ec575352..22ba4803b075 100644=0A=
> --- a/drivers/block/Kconfig=0A=
> +++ b/drivers/block/Kconfig=0A=
> @@ -217,7 +217,8 @@ config BLK_DEV_LOOP=0A=
>  config BLK_DEV_LOOP_MIN_COUNT=0A=
>  	int "Number of loop devices to pre-create at init time"=0A=
>  	depends on BLK_DEV_LOOP=0A=
> -	default 8=0A=
> +	default 8 if !ZONEFS FILESYSTEM=0A=
> +	default 32 if ZONEFS FILESYSTEM=0A=
>  	help=0A=
>  	  Static number of loop devices to be unconditionally pre-created=0A=
>  	  at init time.=0A=
=0A=
Since this is a simple fix, I think we could reserve it for later if the ne=
ed=0A=
for this change increases due to zonefs ? The default value can also be=0A=
automatically inferred by counting the number of zoned disk in the system a=
nd=0A=
assuming one extra loop device for each zoned drive.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
