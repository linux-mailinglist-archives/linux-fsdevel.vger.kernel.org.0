Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C87722927A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 09:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGVHpa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 03:45:30 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:60082 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgGVHp3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595403929; x=1626939929;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=2dYsmetetAQjGFOstq75gNTdBHAVPGPd6z19LIgcbAs=;
  b=AX+FqyFP42cvLdAwluqAh6NJ4NC9KumH6E5bwT2Do6gs35PIRX44z/fp
   rHFo2N6mcQ1c9TpzbPJnMdS+/vIJPdezH9ELCuoQbWM294ewrU8AOjrP8
   srit02Vsv9yJozycvqVfww6wx3N7vg96O8YIpaZFpmwUhas0cCikpzLPl
   vnWUkEHDsIkE2QkALziB/UmqluvTEmFinO0589aqYSgjB3I8CtrBASTJd
   NvmFfHrauXPZYvKdzj46zQj1yhGETqXX/v1O6JtW3FAqPnoHkRTA3DD+j
   M6Jjx36GZHmQq2ICEBhny7PJiCjdazGU/sefV3bD6u/70D8ASJ3W4dsBc
   Q==;
IronPort-SDR: SDjlXVEhUp0fAxb7HA0iZl2lppjVGzgppUkGG+WGLW49GubZShj2qUNUK5fNy4VXMQ7uM5NF6g
 MarhJ3NvqMvRPN/606pU/xuhmhczi+lE91rLKYEKA+oV6uoB5H0IdBUqdnKqU36BIXI5+/DVgT
 wgx9aceZ/vD9Eop0RBjUf+MudWDzMAGwbQcjD0PFQ5hzZ1q/QUjE19+Vql9NhvSaR8W98oqvMz
 qjibeh+XqSl2YoU50c12tPKRtuhHIbtFEukHVOoXJJV86GB5DD7DPM0Lpj5gzLvU6/YwO3x6Y6
 Q4U=
X-IronPort-AV: E=Sophos;i="5.75,381,1589212800"; 
   d="scan'208";a="144357296"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2020 15:45:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drU+PObeyP3UdTqV790WO7C7ywL2JUxTmqUeMUz5Stk/lb7uW1UesRnhM8Bghke9cpVbX1l+A0ghUYsD6uONEDPIfm/z73C0GptuwOLdoSOStVdRiK4ErYwGSMmTB8GIKxQcRNNzTxjcOPVWnXyT5Vx5KQURD3ibXiCeDKmWVmck++vNxZvfTwuK2LakYaiYqUVJY/uwDcNQEi0NOKYQyB9Ko0LK6xTwgHSA3zUUtmswN1NC7eaVqD/KQYJqitLhRooZBMUUzLJ2Q3ofLymn/bHO4FNyx94dLVizecb6ggSo72Ipoxfsan24IL40+mn2OdzVTf88LZL4EvK9AbABeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0K5mJznmfxjwY39VW0JeYpFKeILGV3n8VhABZp5fF0=;
 b=QHi8m12gXJAZFvDfFS+/9Ds0HLkoapN9cfjcRy0VvFYZTBR6NyuCx+otChUHAnb3qlIROeJaR8ji5RPiKRDI0L4/ARXAgOPzY/GfSRmtn4NuPG+79LUDpHZg53LN3S93p7x+FMV2P1bymnvylbv3SQvnD83FciBm2Bq6pct4/uFcyQ5NDK4VeqvN/5Vfoxsieogb7of8PRjCCfyHpS+mzpNFkWxHZ1PjyLYPjaNKJ4REhYDQb5bH3YH0rSJ+bLlCZlMxy+T95pW4MnG2MSILwebfSbMXDaYktgpq+5z9aDJ5CSNKM7zDdl29OErlCFRXEoLdsAgKHMXV4eNdyRh2LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0K5mJznmfxjwY39VW0JeYpFKeILGV3n8VhABZp5fF0=;
 b=a/9R+n5BrdGnFvHmK72vVSTNqZyTcUh2/W/H5HRXaBYZJJFj6fag2W8sUdt+D1wg8YbLPwkfmtSwkPd6qAfXsxozzx/9GJcww1xDIA9SHpfliZe3w2opM2huZfYgSW77aFyzYlj43Q6qS1FVjdu8ZM81iim5HkVQKJqFQRyTIDc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5166.namprd04.prod.outlook.com
 (2603:10b6:805:94::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 22 Jul
 2020 07:45:25 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 07:45:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH 09/14] bdi: remove BDI_CAP_CGROUP_WRITEBACK
Thread-Topic: [PATCH 09/14] bdi: remove BDI_CAP_CGROUP_WRITEBACK
Thread-Index: AQHWX/E7tn9lZZ9OhUyy9G9ALxYa2w==
Date:   Wed, 22 Jul 2020 07:45:24 +0000
Message-ID: <SN4PR0401MB35988BC2003CCDFC7CE8258F9B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200722062552.212200-1-hch@lst.de>
 <20200722062552.212200-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c408b401-570b-44b8-cdf6-08d82e133232
x-ms-traffictypediagnostic: SN6PR04MB5166:
x-microsoft-antispam-prvs: <SN6PR04MB51661888992ABF6700F326FB9B790@SN6PR04MB5166.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EfDnxd+GPm0gZxTebfIFv6FzPlTSO1L25VMdJjFqeTLDSm95+2EeoCncor1Ikx12NOs4A+eQLtb91OotgtTkwkMqjEjcLDYer1UXXwFK88XlDNn1VcC789J1XI+YCfboC4NQONkv1aqjH2CGDULcJvndJokgksu+OyxWeUJ7sui9iztfLHfi4h58+IcNHU9petmCnmts7XzJ8feEu8J7MzCOPz/+O66g51FfXLHwDFfuo/FKIH9r0/+Cg4GR4g+BJTTeRFfkvlUyiQGc9z/ZjV+LrFhQKJD7JCd+oqdQXKCqCMn/aQUmhjRqjxZN7XcLPYMVWY6tgZGNDWXbz1Uqpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(9686003)(55016002)(86362001)(26005)(558084003)(7416002)(52536014)(5660300002)(83380400001)(186003)(76116006)(66946007)(66446008)(64756008)(66476007)(66556008)(8936002)(478600001)(54906003)(8676002)(7696005)(110136005)(316002)(2906002)(91956017)(4326008)(53546011)(6506007)(71200400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 4Vf7Bw2L2SMhl3Jt3ilKs7ZxghqXd79kKvSP0ct+ChAlqLmLNj25NXPhAalKXCu+YIG48i068OUEUN4KbDcYD0Hs/4j3WJUCFvzLlt53HJvY/ue9U+1J4qJGyiIFHnJbqZkwfh5gcTysF4pp0RekCJ9GpLa/gL7pxT5vh35fxY/ONSjnEm1YFiihH0NflWOi62TZ4iUOtvcqy8kPeRgvhsMxNHAD+c3NVTilVhm32WxzcUWmG8IEJS+97EFA3iCNiQr3EbnB8sozmmMHjVZH0QG7Vp1YT2z2PL0ZR9pM5MyFMTN/unviq9YFquqWSSmDfyEu+VQ8XJYnvqHzkqTkEZ1ZiQ0x9U2ydIA5/YGw/KT8m+pA2hWsxgBhkidG5ZrFUqkSkUSwJ5jhWEusaX4QaW+vL6YHK4QyZrHGmLc9W5hvA0iDXzx+//rVN6Q5xL0DCjkkAO59PGD5+es9JShbbi+JPLfiXOeIrnzflaWg4qgWIqs51Z6d8CAdXS8f0wwv
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c408b401-570b-44b8-cdf6-08d82e133232
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 07:45:24.9244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SirNX0bUajLMGXRH0iKCjWPNXUs9Ukmcwo5ehc24DNrjMj6KWKusnbx4pI2xSrXuVT41q2axOQJFRyDnqTFudULMSRzXqqnqTrUhVIuh+2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5166
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/07/2020 08:27, Christoph Hellwig wrote:=0A=
> it is know to support cgroup writeback, or the bdi comes from the block=
=0A=
knwon  ~^=0A=
=0A=
Apart from that,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
