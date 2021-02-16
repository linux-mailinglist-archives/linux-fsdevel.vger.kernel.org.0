Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9B631D333
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 01:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhBPX5y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 18:57:54 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:37441 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhBPX5w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 18:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613520483; x=1645056483;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dRfPikWj5eTaEeRbwmeH4cP/5PSMQNYAvVWNg0kVymU=;
  b=H+7pf6OMv5xDAgB8UwE8BLjK+69N1R9YKUf765y4oNX3htvt1gDZLUnT
   f1RK35fTRGrzWS+DO692ifB+J+eqYw81VKbQuk07hXvPcWmzkswdyYQYI
   Rfrj0EyofAAJm2kNX856zU3as/jaZnrG81x06/J685katE6OfcsD2GtC7
   fvMIvfigZAskE4ZGcHXuTFkEyepCRx/tpyKGGsKmuL8pgvBnQnDDs4NQU
   Kq6WKOwEPBzh4EtSRGA9HtYjSGKo12Guw1erj4pzUW2KjrIUAPuwxLkak
   zlxK9AqXstISduSKe8EQ0EPEaVgi8HnMSoARbT+Rr/+MWQaJb4Fpxtdar
   g==;
IronPort-SDR: BBnpzRSOCzmJKgLZzchUSuQ/tsaLcUUMmwkSQDtPPtt/5yL8vPiMVticv/x+Mt3wmz5yFFjU9T
 nmlOMo2ZRP5ztp/f0tx2IP5LpXzJRPB6pejMELn1qN+jfrlioKk4k2qKnD8so5x2zTBH49ZvfM
 eaRBebLmeYAoyxraklAZKAKDczvLysnXuUxWQ4L+nr5TO5tObEIvJ2380hV19aAxLW/20W5/Oe
 AVibZ8xYn8oR5fg8CZwIcgHT6HlhA1j7PkGey3RACv+6K5exlXzopdLDhKc5c2uuItqnVzGmNO
 bSU=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; 
   d="scan'208";a="264273066"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 08:06:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfJ1IryuSRbLQnYrPmRp4JkHk2sqLM7dg5EFjES956cRdnq1hr7LFvIonfRusewASlg5ryfKbXULuEeQbsrod0PrIinMWKeG0eJcUbGTm4FE67WjpUpPbaxeOL/TCtCblLFfr7R/LZxpVET7kmklySXxHfoPKINblMAFBTv7IIgalHqu8M6uoUib/8Bm8sqRWnll1bUiFs4iN49eLxqOXpIYvv/z0NPzz53zI4+6y/wEtz1J1BYmv5h1iaiCoqtcj+PjgNPj/iVaitz4i0tEz4xc6pr81yW2jeiCgexsB04TXf0JlKbAyaN/VPt19cpVruv0VXqdLnt0A0Zbur2XaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzDapXoZXYFHUDn/DfQOhecw6n0hQixwNxMncQphqgw=;
 b=FJTCoUa6hA/DOzxaWaoGSnV0yNnQL51eI7tOHiWYBOBloZAl2ebhLrofJPlVJUKG00zoIOkVh8o3LZwC3hwCAuH9Mlq39wVUdIVSGm6Kwlu7YBYgEzDHZWhqnEe6LUiOrsW5w05BwF1X8NiP6Vkdgfq8hOiRRyyDWqSvK7OGbHS0ffFcoqVZHIHR4w6k0+FkZrAbk1WsVGl96DyV1ofVuWi79XC0IhjHdoHT5mNsfmT5Jbp4/8EUgOHy4457onAclaJ6fGIMM1yk6isroBsrhAqDaNKmkxBcowAX/7Bg0e9/N/ytmMucGiXdsg9mVXJaAyr0sv6nm3cKAvj23+cypA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzDapXoZXYFHUDn/DfQOhecw6n0hQixwNxMncQphqgw=;
 b=GjDWBR4ogKh8eBR10G2sg+NBQDjgWHt1ZrG5+NZfQTqVPnDeIKk+XF9CkJz5ld48d9QDoSzy8O8w1SOFkDTZnDQbW8NK3PLthJXHXuSNEkW0rE9vrfCT98UOvBFOd9A9pOSkycBDqsGFFox8hfNKN4t30mOdHnYkEkC8k6EtBTo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5526.namprd04.prod.outlook.com (2603:10b6:a03:e9::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.31; Tue, 16 Feb
 2021 23:56:44 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3846.041; Tue, 16 Feb 2021
 23:56:44 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Hyeongseok Kim <hyeongseok@gmail.com>,
        "namjae.jeon@samsung.com" <namjae.jeon@samsung.com>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] exfat: add support FITRIM ioctl
Thread-Topic: [PATCH v2 2/2] exfat: add support FITRIM ioctl
Thread-Index: AQHXBLQ4TfEdCXpxX0WTlBkibKV56Q==
Date:   Tue, 16 Feb 2021 23:56:44 +0000
Message-ID: <BYAPR04MB4965F5734BC7A2363D4C3BCD86879@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210216223306.47693-1-hyeongseok@gmail.com>
 <20210216223306.47693-3-hyeongseok@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a354a51d-a905-439b-e666-08d8d2d683b5
x-ms-traffictypediagnostic: BYAPR04MB5526:
x-microsoft-antispam-prvs: <BYAPR04MB5526BB4BAEEF8FE8B9D4975986879@BYAPR04MB5526.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jOyGt92bwAF+0aJnMomGVmx4xr9TvMnfPpfjYeipFBVfRkLxWA3T0D4qSj65UNeLD9NOHXX97TAAfrVYKaW+NwytjSAwF/LlU/gXdRZKK5EkFFbqHkbLFKL0grTncJbggMMXtOAVaWrB8TIKZtgsc6HAEBhcOQoXzvE4G+Cps5ZHVHHcrzYRtuQEZ4SzXuB7yitAV2ssMeCU9P6Sllaloq4xuobEJTQTBSkfoPyWiP1JL6b3QUbB37RYQhT5N4X8atmnGhBE6NpAg58ajX/ZS8Fbgo11THjnplqNH03CkIHF/KA0yM1zQ4BNuBhY7NouEfb2Hp2FKo0Go2Z0IiYTxbPPsGlF/ReCDBz5+WfCucaTSH6aL0RTN+ML4fXlUZLjzCJpS1Jtsw76fuwR0e83nuNjqbu9om8sc+bQCT7ehkoh51+iI7Z1eEl8Pyj+uE3rouXazwwlwgcd/QMWhNZBvw9ob3YbZtFhMoRarCP56E5+wYfPyKaJTo+NlgZYy2tEJm+NasUnyhlah7fuLL7PmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(478600001)(33656002)(4326008)(53546011)(86362001)(7696005)(26005)(8936002)(71200400001)(83380400001)(8676002)(5660300002)(110136005)(54906003)(6506007)(66556008)(66476007)(76116006)(186003)(66946007)(66446008)(64756008)(9686003)(4744005)(316002)(55016002)(52536014)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kdxTjYr3dmvlTnGVoVjEym/FwT4mMC8BxOFq+Q04kNuCWIkAq77eMU4If5Jb?=
 =?us-ascii?Q?hDhxUTAr4wQ27cAu+6Ao65v1EZwxiKbhbj0mxrs1ruWWunsvaE3OhMkzEkUG?=
 =?us-ascii?Q?/SSV0xp5hyK2d8LGw/G1VHgOurzguuvdznAymxwt27uLyispr5EcJmfjm1Hw?=
 =?us-ascii?Q?hpV84g3LxNEMfPbkniUYmRUZOG/6uonsM2ovM4DmYW6kGn5sqe816bSTZRfK?=
 =?us-ascii?Q?RRkkS1DN0tf+W36p/NSPIQdiZSioS4QCoDBifImLnkjRPDzYXJ891cENF3Y+?=
 =?us-ascii?Q?o+wdoXjjCCg65bTYOwHJi8TmLo7hsgbDjwEImqSd6H/nKzDK4M6HZetatWJm?=
 =?us-ascii?Q?kUsMdSWxDsMobAcgOtbklEYj4qmxZyupUQGdZ6mAMJ9/3RzenYpbh6wTRw77?=
 =?us-ascii?Q?tlux7UmabtDIP8SBcVYroxm1Hs2PaLzDGWcrbbq1/btotEFbZaFKfAn19n3y?=
 =?us-ascii?Q?8JLb/cEo5WoaWO5Gr0vnXysXwjA3hI1vm7ob/mEU3FCo4rYtZsNWGrnKyIRM?=
 =?us-ascii?Q?562+m+332pnrsYculUm/2Qc+MtUGNdUkUpXxGVjrhT+dsT0bbU886jm8vb1q?=
 =?us-ascii?Q?SZXgobkjHZKyLuhySxBOO1FdeL7DzDO9q3zYNVKQB2TBilwDiBdyfhPeRlJI?=
 =?us-ascii?Q?kMuQ00vwA5uFXSul4l3YiZcM4KSNsPZmpMwOHpkmvuZMo1HxrtMa1rnnZr2C?=
 =?us-ascii?Q?v1bg+MK9BsPUHQOPLhPPGLh2kGgUv3MsVB1qqB0Vho0dNvag8PEnOGQywab/?=
 =?us-ascii?Q?n5O6aAB/hq3YvUw1rflZUtbA6erkVbiEFGPCZkW8edmIbi2iDgMr77SZjkfM?=
 =?us-ascii?Q?LK0dGE+ihHe2vlKBRj6S1DGg3WkVgwGGw8VHE6RpjBI9zkNkcx3HKbEAcose?=
 =?us-ascii?Q?qBqbaPqiyYyqvly5EN2ACM3XNjvsoT/g0vTbtSCzOQy9TejqBW5LCKQ+X8KV?=
 =?us-ascii?Q?5qrY8l+U9WYIUi604cHswgW5JK3mxmwuCQDVxIZ+c0wcm0gKg/YL3wD1P2WE?=
 =?us-ascii?Q?MwQsCzr79pqx3aMTI2ZQTtNmXl27hBSEp9o/EB54Wgb2Pr6H2jJShoJfcko2?=
 =?us-ascii?Q?StxSrl7h/bqk8rodnwcJYk23OK0oIpd04TTf1pQSMVpxt/nBc/CzPi3cRxTx?=
 =?us-ascii?Q?JZb1eigt9f6y+ZwpudnQMLRistkA0ubpdLCIJh3G29l6SjRXr+oI2vv7i4EE?=
 =?us-ascii?Q?G1npEzqH1eOMZoJ+drqQxRmiUe+Ck+s1ajp4aqr7NvqAM3UNGVQIF4IKneoN?=
 =?us-ascii?Q?DEDOEsSIgDYGG58rm+NFQUG9ukh3iHqa0ZdzGvIUR4yfuZ5rPVpNIWsIRwC2?=
 =?us-ascii?Q?i15vqcaei9BHpP5JV+F4mcir?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a354a51d-a905-439b-e666-08d8d2d683b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2021 23:56:44.6516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wfuN3PHhnUY+c4F0LA6IzRyfu5NEOzV+lVr9wh8A9dOOeXZAIRn/Z57KnSsh27eQ28Pc6XlZgKgL75qIu/wUowGO2XlRhmwPR79X44bTMZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5526
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/16/21 14:36, Hyeongseok Kim wrote:=0A=
> +static int exfat_ioctl_fitrim(struct inode *inode, unsigned long arg)=0A=
> +{=0A=
> +	struct super_block *sb =3D inode->i_sb;=0A=
Do you really need sb variable ? it is only used once if I'm not wrong.=0A=
> +	struct request_queue *q =3D bdev_get_queue(sb->s_bdev);=0A=
> +	struct fstrim_range range;=0A=
> +	int ret =3D 0;=0A=
=0A=
