Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BDC304C4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 23:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbhAZWgW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:36:22 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:8005 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391425AbhAZTQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 14:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611688571; x=1643224571;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=KNUDY51cFN89cFLkxV84w9yHk/E66+9qddWBN8QDq9w=;
  b=UJohECgeCRKU8Vt17zbfgeo+4zNhZ7EWwhoZHG2LNi0ijrFtRLGIPTnR
   zEL/WemUPDCCj6zcBuiv5FGhLH/xCl3UKBsBjXoOR4ma8ssqtLdgevo8m
   r5I5hIEMtKWb3OdTBOMC6nNvhw0OfmsHQZg3uooFOF8jeT7BwGxgu/MhJ
   U2HlNt1WrSwv4GflTAwSP8gQL6lNLpfMaoNtlp1rmp1JqH3xLGj8IhmzC
   T8eFao99LHGuo938KWWuUo8a8/QS8+jxVhEMjI93kQ2PdeLZ+uRd1L9z+
   AFXqv11vF6Dicnf4KM810PLsj2A3rT2uXXTRiolUSBpM+MEKkkSA+gunI
   Q==;
IronPort-SDR: 9F2eAYyHkgpATgkwLy1uhYiWsWZ5LUuQnRgygSejEf4CRXwtTGSIB+/CXjZ+orLDwIb2vr4hz8
 JWLrr9ZTteiUk4tXxaXO6ez5X4SQZqIRVo56fAxonHw4cBna5z1++vvKDZ8uaVB86eBC7ww5Mq
 5zz2samSRkv59suuw3mqY6j/cwogoIKOScSh+7+WLbAhywqZKASd2+LuCqNCUIBrhh2xyqtigO
 nezlYVMAxxnHYeMq7i/fxkvk2fmTgcalMTqHvEnWauWTZN/pLxuCv+MzlAMzO5Nvu8fy8Vmg1X
 yHw=
X-IronPort-AV: E=Sophos;i="5.79,377,1602518400"; 
   d="scan'208";a="158379142"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2021 03:15:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZf8Dbq59XAwdDgKRcje6TVORoMCHCF9wkIwm0oL/h638bHQb+OLng7GOMx76g2H0vQTXRpAxyFQy2+7yccjPa9StB2EYBzxR1cqPTCHJIR/ElVF5PU4RnMs0MhaHJHk/6u7S4MZox5efe0JfKpEinLhNk6P89cyuKZKPFlp3pT8JUprAnB9z03UKi/1meLcOkBvZcWNbW+ZI0aXnRgkPgEvyo4idN7fmMDSbNtoIkeROO6qhEJp9H6YlqYlg8IOAv8R7d/vXDZ897RLub15blQFPy0i1QG0Vs1c1hvPsF0JUQcPtTO85lFHBc636EfJCoGti/KGm3VE9CWXRRtFDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNUDY51cFN89cFLkxV84w9yHk/E66+9qddWBN8QDq9w=;
 b=QZMaxr3W/MFqDDqMoCecgeAs9eX2pibfE7gDwuAgTGAO7B41zFM7rFQ7r8Jlll+TmLAhXf2d8fcQVWReO0d0Pa7EK0QIBbFnV9462P4JnUH6gtVeue20lpiAt8vHa3UqtOCa/kg01TowbEl+GovZWAIX152UOLlgWCOOeoyas/Xnayp1g65jQVkusuPAl0NBirRS7BpxfyEwUPHPldRSy/WMfvRpKY8Zt0diSQAwjCLCnq091uO2bK+mbMj/anal6jxJS8abG+a2pyxuWt8JK4wPIsOkc+7jLV+hKMnFeb46d57fYP+ZYxxUK/Uv3GVb5I0lfT5DLGtkI+4+6DcHwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNUDY51cFN89cFLkxV84w9yHk/E66+9qddWBN8QDq9w=;
 b=FQuF/oxOCpteS65+OEJYNhD4SLodAeq84LUWNm+payTM0LKZIvCujeLwmkPO6okCD+L3w01zJjQh21wtlrSqWbj7MG72Ork3CQ0fYh7nWD4qR8uBkhWPrD0qTJqzc3ee/A66GnkicBo+jmCHpWfvFx5wEfyvhjD6QtUf8+4wVMQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5895.namprd04.prod.outlook.com (2603:10b6:a03:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Tue, 26 Jan
 2021 19:15:02 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3784.016; Tue, 26 Jan 2021
 19:15:02 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 05/17] block: use an on-stack bio in blkdev_issue_flush
Thread-Topic: [PATCH 05/17] block: use an on-stack bio in blkdev_issue_flush
Thread-Index: AQHW8/UAfT2lRjWk50ewoG8V7AspXA==
Date:   Tue, 26 Jan 2021 19:15:02 +0000
Message-ID: <BYAPR04MB4965E6615D7173005E4C634586BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210126145247.1964410-1-hch@lst.de>
 <20210126145247.1964410-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:8802:270c:4b00:b091:5edc:1473:bf45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d2ede5d2-37e8-4220-5422-08d8c22eae89
x-ms-traffictypediagnostic: BYAPR04MB5895:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5895A39F23DE21E70646371186BC9@BYAPR04MB5895.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:386;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B8pXtJljlJUm8z0H7m1rZqP9q65K0txR3xo2jzgTdMO8IpwJK4tbl55zQ1Gz6V0LWIWP05GbRponlmrdcGoIdLdcWCip0TeXI2GrvxYQ94STZrdpBgZziAZuv+ZbEe/qhr+HwvadvtRu3pke6urep5gzdaJ35Sf3Ai21eF1qGK/h1OVy+c94aNp0jUw3o1x+MB3+BwC4HxsliyLAKcueLdH3UAn0qN+Nyi2m7UrxXbSqInuj+phQ3bhadAmrOo7uAVv9g+l8BYb4Iqv8maRA9N5w6eHAJ2jSAxqsPqNGqffVZAF5UbjjG06biyORjZQDMbrG+NplYPxU7lfxIz9/vG4Vjzbm/hce3H3c3xz2SX8tAMs30ImA5Lmg7wx9kvVNihK074egXy22CZ5ipeEPEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(5660300002)(52536014)(71200400001)(186003)(76116006)(66476007)(66446008)(64756008)(86362001)(91956017)(66946007)(33656002)(66556008)(4326008)(7696005)(316002)(478600001)(53546011)(6506007)(2906002)(54906003)(8676002)(110136005)(8936002)(9686003)(55016002)(7416002)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TpsFeAAzWrQgdE0UidxLtnQ32uznoO0hmJsUfSNGT9zgal/lfYu47Cul/45I?=
 =?us-ascii?Q?vCKegYrsoA+ssWzargnWvnCezjOUEfrOkjkpOU9F4q8EQOqfi25ly0+P66EK?=
 =?us-ascii?Q?z691ZoVK3ZV3giHIe7HMsZIwgk7td8bdlVKCJs+/GscHRujHmDgPV7XdnCc4?=
 =?us-ascii?Q?PzWcpdaPxb9ajMoRh0KHdaLMi9lzjm22y08Pi6LlJYewNi/6pQRUS6whFx9b?=
 =?us-ascii?Q?MU4IenfDhog/hhqO7BVZuRtk1aiLG6hbkfBpkSye1bnJcfCMdZRjB2ofuer4?=
 =?us-ascii?Q?BCJRTGzKJ6cIaQZGCaBF94Rxx/SS1rQjatli38YGli1rD0taC4ayYwiJHhDf?=
 =?us-ascii?Q?X4viWkWObid1joxl4DvBCQ0ziE5WaFY0PcSP+2i2UNkTe4s5b/So1svc/QzD?=
 =?us-ascii?Q?WusDcqUFrSsv9Y+vXuOrNUNzdArSSa0xvwN96Uh6PAf0UBclFRScJ7uTKHEl?=
 =?us-ascii?Q?NMtexDZvpdTpBcrBtKCx04MREzn/gCnPX17GFeOfAT628X19IqRYYzqKUdBG?=
 =?us-ascii?Q?aVTYbR9l2y8KdGjdUbncClWBHnrSJCWXdYJ4QAdp08g2AhwKrLr2yMOEfug3?=
 =?us-ascii?Q?AvKftmgKlbW0bLjlwg0XfU0UDYWXNPhS0A8H6HU0TkX4uQvJrAW9Wp/y0svT?=
 =?us-ascii?Q?Q4pZ2gu42pobxJUGMOnhX6LkQpOd9KiGpGUqgxAdNbyfgtsd+6xQ1Xh/ASXX?=
 =?us-ascii?Q?iuaComdzh/88YH2h7eJ5KwgiGK1Oxpf7IDPLmvzq+st7p8XKGLdJHvLgdK29?=
 =?us-ascii?Q?LbKsOVYgVMO34HxFqXCY8LQU8iIBy2CCNdnQa7/snnD6RsH3JlYI487QmKtD?=
 =?us-ascii?Q?XMgShcqBpF9Ui7CwzR7FOaDDdRQyyLiqIxwBXYEH3HqpUYqJgCWxzjzLUN+b?=
 =?us-ascii?Q?uZQos8Xj91geXaSufUiMTSS2heocGw1gC8C3xWLR7HdJVFosNPZ6QdFt3vmv?=
 =?us-ascii?Q?EJNMPCYYJMHffsvv98uY9xUYvDTE31rhZkdvwUiqgjkjkGpPG1NVliyLIQar?=
 =?us-ascii?Q?F0WA5ETH8QbRmG8YkQxp8elUDMLVA1zESuBfOqt9h8aNvRMrWmn07dlQL8m/?=
 =?us-ascii?Q?RUTkjvVliKeMPXBkCtaoQzxX2OsmbmQ6eHLXMKsfIU11NkXvOaq5jxi8cK83?=
 =?us-ascii?Q?SLsZNmtHnYiU9UgrbQWOehctY6lEFOP9Kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ede5d2-37e8-4220-5422-08d8c22eae89
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 19:15:02.4505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dxvRsepTtCj9PG3nalZYrQcf9Sqpza4sLAKGGnrIYBqSvvucUqdPzSs2+gXn3BnHpPHMzNSlB4ofzI99FgiaBWc2+sjVTxALlgSeM8N0fa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5895
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/26/21 7:07 AM, Christoph Hellwig wrote:=0A=
> There is no point in allocating memory for a synchronous flush.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
=0A=
True, looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
