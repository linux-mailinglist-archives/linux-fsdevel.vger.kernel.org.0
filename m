Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6022E8F25
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 02:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbhADBDX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jan 2021 20:03:23 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:37363 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbhADBDW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jan 2021 20:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1609722201; x=1641258201;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=65KAgby0RQj0nZrGAxNKyGQ2CA3hkTGh3a6LDgyTw8w=;
  b=oBEiu1veKTsj+9odRiIAwO0UR4kCeJJFdvz9wNaz9hEFpLi6ytV7WMu1
   NvQwOZUBEs8+1ZpWafgmglq06FsUknAqZR225pbdZfDBRwHa9A71xzOBR
   25n61W6TP6OKMjF4E6rGX6XdFIbsv38iviQcNFqZwceq6ikVZ4OWe6EKD
   Nu6IPcPpiOfxv0EOr1gra+AVMdvVu2FncuCbEe5o0Vvi1TNBlgf+JyPcI
   aMt9fx7HPQ+2j7DLt7baoNOFOHXDOkmmgbN8ll7svAP3ahULNcWD8B0Ev
   ffOOdJq8t2B40tM9PHilt28zoQ/a9IJef+922/Sa5XJSyyoNrTDccJ3R4
   Q==;
IronPort-SDR: cuBVYjV8Wn3otuVpHAqSrRUjysADjC58NyYFuN9iuWmSRgHYk1tQOYhRrq2D9SMvDxffci0JLP
 zaAhltQ3+Nq6mX89AYxcn9zXXKdVQNVzgYO1UNv7om9Zvzpi2cY1MF8aKIUT+xKWMPKjHlAxua
 +BHRVHVSMLWoiukum3o5wdqJv1Yn4DQahOSXEQ35eQ3oYR57PeKjaxoDTnJfdPan0hFE+924j5
 WkmZ2R22BqVIM6y/oXouDxuyWTX8Nynfv0GiigQX5SZk0QDHDQDf6gDA3KH7hAIdhXAHZToMkv
 wMc=
X-IronPort-AV: E=Sophos;i="5.78,472,1599494400"; 
   d="scan'208";a="156468935"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jan 2021 09:02:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRH2aU7R7LFujP8xYo9l3oa6WLUpJr1Qyb7GRnk9mp1/N8Wd4zEB4jEwzw9LQX/tJrlOzhV2+4JhjjimT0aTiGpwIeXNlTuRx+cfyoQ0IgloZ10GqDCxqjtxtJY1F0ZDW3UNQtcyxRDP79+TK7w2G7CnQW9v81pqdnf0TSwNqra/oxczEjbMaCxkS9pCy8P8kANs6WM+536OgtsJ2QGi+t5L7RZmRqABNgsQI37P6F1/BEyDLot1l03Hu2hFNnr7Brm+axyn3dFOJIi84pzGeVRcePo5LvqCJa48a289YZuECjSTLOfEjlVwxV0dFYojB9GJ13mcS0psZOuJ3Kg9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuJ5JgMJwn2FshfsGC4Q7qdZichJ+v/Gb1m0xDEshzo=;
 b=dvSGiT5J5saHxE0CX5tFh5sB/S8ewHdjidevLWUnUuXK3Ce8k0MwCIFYHY7rygYez1PsMrf41OAWoKWvSiA30L8TjjxK/uuTLXCQxglru7fsB+yh5/+Zpr72T+c0RS8Mjmu0BLXpJYueuXJDqINhmXU3LrH+sFWxGVtaq+7Z4bx1L0UXu0KOl+BW+5HLSKa6Z91rucE51WQnoIoMf1doEbWrswa7CzUGgm3ADOfpP7FnbBpaYN+yUWQv2gSKzcuaWCqPDKEILGOn+DZEgz6EQAGKemvl1w01eV+5qoMpB1xLh6vLjhIKfRGoDRaZu7eCiR2icOOOjsQNoKfM5Ezp7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuJ5JgMJwn2FshfsGC4Q7qdZichJ+v/Gb1m0xDEshzo=;
 b=Sjweh5upK67p6NmzIS65Onlb6n9CEncgxma78qiSeuDSriVWM7TADv4w4r6+7WvQMvCty6iJ0gKcaJwdz/lWO48BTTczmuKheXelCaPStRdXurdAb/np1B6AILRofeZK7gA+MyUDPnDjMO1Mc6tHDq4if3eM+GNa1GpWiUekDXQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7438.namprd04.prod.outlook.com (2603:10b6:a03:2a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Mon, 4 Jan
 2021 01:02:14 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 01:02:14 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Minwoo Im <minwoo.im.dev@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC V2] block: reject I/O for same fd if block size changed
Thread-Topic: [RFC V2] block: reject I/O for same fd if block size changed
Thread-Index: AQHW3sVYE0D3BnsJEkakKhpEGYvfNw==
Date:   Mon, 4 Jan 2021 01:02:14 +0000
Message-ID: <BYAPR04MB496588684CD8517829DE541286D20@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201230160129.23731-1-minwoo.im.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18e304b5-21cf-4bdf-84a3-08d8b04c5fe4
x-ms-traffictypediagnostic: SJ0PR04MB7438:
x-microsoft-antispam-prvs: <SJ0PR04MB74388E0778475E3FE8044FE086D20@SJ0PR04MB7438.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hgvasGyI3Zu7n7n9OPxm93Do7HDLZCOqwOSjzqMHs4p2sKba8YIE+PTmlwEQUDslUD7Rc9aiU9qkB9HBU4pipF9DfX/+ZRQcfEldn+SIUCr0+w+C0sUeA0vhOOO4q2HXshBcgLvcHt/6VhYOjg8QcgEDBIFvxBsqaS1PBtRAnnJs9egPeM+Z6HI68yE8wWCNQr2iwkpHnDah/Gr0Rw6aJ5zwJkYrU3z3KYbYMIGjEBqNPda7WjI0jygwQlosRngIEw36XX2PxyC56pUJ0c3FdnZf1ONTaPvXFrNRM8IgAK56VTzpXOTogeh8y7tOX/JcwCnzMBPTS026pi+tjBbZ70UVEmKLil4S3oPgNf/+MliWiO9umEX0cijZR3kmjT4HRK99OpE8DXdHFc/YzqmRuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(376002)(396003)(346002)(366004)(7696005)(110136005)(26005)(5660300002)(54906003)(478600001)(4744005)(8676002)(71200400001)(186003)(86362001)(4326008)(9686003)(76116006)(66946007)(55016002)(33656002)(8936002)(2906002)(53546011)(6506007)(83380400001)(316002)(66476007)(52536014)(66556008)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1AV4OGN7I0ScJPd2urX1KEqOvLvOb1ZkoR+zZyFJcZyySKobuEb+tz7ydeH9?=
 =?us-ascii?Q?PSiDZNiMK8a7XC1tkm53QPGwConP1aVG3m6G1qvKQHNEyRMOuJbwMz1YPEv8?=
 =?us-ascii?Q?jHf0ApCFJwzTwj4pTPDw9WllpxOqbMHI4nuUFuiuiSKLEFW2/P05U8Bl5zpD?=
 =?us-ascii?Q?OYOdW/Od56N3A0SUAnx9pIExbIon4htpNGJ6Z4+chxIsH4Vemx28BJ08Rbq7?=
 =?us-ascii?Q?QAIYpN0x9VFjubgzBkYj5txkT9CP0iIa/k0jb6KP0S8xZkCu8a2UZAQjTOUe?=
 =?us-ascii?Q?yzvq/+viDJgfNREgwnIjy/ztqkBj6odeZT2FSzBHYpPagGrZPo9PK+Qnx0H8?=
 =?us-ascii?Q?RceyUT0J2siXzsYkLQbvZPShV9WNf+rN8gj9phjQmmTpUhaBSxf0Ca57JlZQ?=
 =?us-ascii?Q?KEB8TxY94mi5Kwb8Bl0e1QiLjAhQZGGRJ7aoehxXPtRw5Qd/0DroIHtMDbLJ?=
 =?us-ascii?Q?J0E+pKSSN8ZmjfQMscDXjW0uNWzwHxMB5MQrlM6JC6bMl5veLaW6GSEjhTp2?=
 =?us-ascii?Q?/2SNxKpd2rDCL9BeYZOKXva1dUui1mSKO/NC6LMsuRx3Qopsrea5i5jef8pF?=
 =?us-ascii?Q?fU7bl6bxqc1CS4NDkmjyOPKqYK9s1giID/V7h0NOjoZ+76JqjC4lIkCi8gD2?=
 =?us-ascii?Q?G+btaJu4eOfkpUxRAulWPMDp7eKmaXo5seaa4DBVMDAETFRxYO2yw3oxJ58E?=
 =?us-ascii?Q?USf9jcLJ7GUpEhTVMcS6yrGyN5yXm0ZW33pD+bvxb5hjrFnI27PfmY2dGFmE?=
 =?us-ascii?Q?hS2z5wjYxOVw7XRKG0w3Xp0c03QX+5+SAuyGHNWdpTZA6oRuQ1dEiTVGbCZk?=
 =?us-ascii?Q?4Tts9BH+vcEBo8RLjCssm1gP762L1LpEbBQ+84LFCNCLfxNmYnW1/aFuIvnc?=
 =?us-ascii?Q?mpF280ZutgFoC2tS60SL+Tg2yF+ppN3WddDBgI0HDpuYtacvuynFmf18iTuF?=
 =?us-ascii?Q?iQ0qcuNIUZPMS8/YYnSheg8/biXndgXG8RIuuUsgXfZDgFjF7pKJ+cq8f4+Y?=
 =?us-ascii?Q?h9xJ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e304b5-21cf-4bdf-84a3-08d8b04c5fe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 01:02:14.5120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JTtS8wxXi2B1Vbmk7sMOH77IZffiQh/Ltg+rjIY+nSQLZtlGBD6Xh1qqUgRWGh/nUNEV+KVa8UTknWJp61m9zF1JYKfv/wU6NzCfcn88eWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7438
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/30/20 08:03, Minwoo Im wrote:=0A=
>  =0A=
> diff --git a/block/genhd.c b/block/genhd.c=0A=
> index 73faec438e49..c3a73cba7c88 100644=0A=
> --- a/block/genhd.c=0A=
> +++ b/block/genhd.c=0A=
> @@ -81,6 +81,7 @@ bool set_capacity_and_notify(struct gendisk *disk, sect=
or_t size)=0A=
>  	 */=0A=
>  	if (!capacity || !size)=0A=
>  		return false;=0A=
> +=0A=
>  	kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);=0A=
>  	return true;=0A=
>  }=0A=
Avoid adding extra newlines in the patch, remove above extra line in v3.=0A=
