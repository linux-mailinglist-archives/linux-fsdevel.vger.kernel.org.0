Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C342FE4FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 09:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbhAUI0G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 03:26:06 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:11106 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbhAUIZC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:25:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611217519; x=1642753519;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5xDViCNWTWpt74+S63VrlNc8LWu+dxnOf+RyPFe7hss=;
  b=HhFVAA+E4+S3it4ImT8VrG7pgo76LoNpf/ueeRpCKVdFUK+XoSBoy2Ce
   1+Bjl/3HIobrEoA/8pYuIfhSnc2KfTWNcKnq1cys+FwgP/HuaHLrauCoC
   NKO7nws9Zs2Vgak87sS77bOJTxYrnTvu4sxgqp4g+GTRCdCo7Rg17foG6
   YqVYRy2CmP7fvpEFFy7Pb0Q+lhj0p2yLTM1K//+nQ33LZRSl1GNqZz+dJ
   KDEf8qXIdLtY5vKU2bVimiT86cwn79kYQh+PPmkG6e0EyaQcXM8YeS1c8
   6U1V/F+AxGUv1rCrCJNjOdC9nMy8Ysg/SP7ZhQ+xjHzK2KbY3yj5gjvgs
   g==;
IronPort-SDR: nopY/1/vZtTbFd6l0+IpzksjZWV827taoYGdI6nTCvXcD+NT6atg+8pFyCQqv+c16JkaXOoL0D
 KZ4ZA1yIKpkpX5wZeHBX/9xKxHqY0oEbQqAoXtVeOlDWitYpkamuITHncU/F4of0v0+vfTCvA1
 8qvStsDmXY9OCQe7EPLXrsBBarKmqoRU5iWs00KcZ6PkYEsEa49IMfyV+qwhw4SkboXxG08Km6
 tzg8JeOoO/gZkor8VHecJdk53+ftE6lSIRjTitLfOZZNK7atzziYHzHo7RWXAh9orbProOBDgX
 qkU=
X-IronPort-AV: E=Sophos;i="5.79,363,1602518400"; 
   d="scan'208";a="261948044"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2021 16:43:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lw68XCNKrU/qui9r1XSPq6hnWUBUdN/CfDi270C7BJeOnIzrp6qBQlCcjU+S9EGPNdg/DQ8OYphkmMhy7CVeybh82BxKsz4MwvpLcFqZIiOBiSQjpDQ2Bqol9TSWenr6xXXpcqa3xNnfKtOclaOqXDe9MnJy6nuBYdY6xn3P2cH223ZYGc4Yc8qw1KxiWmgpftekj+FIBNuNiz7iUfzVH04NZ+jD1ozB3trYByAOZMz6ZU+c3NCyxa8JoMF/m62PWe0Md2WN9/pUQtGLkUgsHuk6lut1C/P6B3ex214voxw3DMPYPzPhMXbM++tqT3pYdhe93xkdY8lAPQY+rboeag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0PH6GNao/klmOr5IzzIaOMg/PvFVYJ+pZQvveYwX64=;
 b=bOjNMUdbSeuUnFo9IrVW/LqAa07ep3nTQcmI2FgbBgtSEiGlbP9fxaIAWn2bLwbR0qxEwbpdToLb5qVWFFxaJfPspEcT6gxgUWyGagD3htFPcBoSUJobCMw95Ta5QLNipzaiy85bcNYkfnVc84J/ZnGPEkGjqpuM8TjJ28AgBENd0TJ28lmYt1CoJ/MssPzIgsbkg10pF6WAWCw5BgNsH3D9dOpKfeZ9EPW2PXfg4ZRHc/yakrCdIFQj9gu6QfyLcuag8hD2+fj0xanIYMuBDpIhztQAzTX6m6QXhR+FTzbm6JliOr6eDJ5KFR0uLV90E75pq3cV/uBINjreOzEzqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0PH6GNao/klmOr5IzzIaOMg/PvFVYJ+pZQvveYwX64=;
 b=tgQ731nUeMOhgE+X8aJokO/3/gyG/vVOcs6a2e/emcs4H/n2HmGEuaZba4xmEtuF7WrO9aQ4Anb5zLf+0Gh/62xUtq6RSHNCkq8+v/D73mis01yDlsTmWrqZaqc9MCJ4Vvx5Fzn5ynIqnpCID+L0WCfk+HJopSJseRjrC1PJxRk=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM5PR04MB1035.namprd04.prod.outlook.com (2603:10b6:4:3e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11; Thu, 21 Jan 2021 08:23:20 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::9a1:f2ba:2679:8188]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::9a1:f2ba:2679:8188%7]) with mapi id 15.20.3763.010; Thu, 21 Jan 2021
 08:23:20 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Julian Calaby <julian.calaby@gmail.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [RFC PATCH 00/37] block: introduce bio_init_fields()
Thread-Topic: [RFC PATCH 00/37] block: introduce bio_init_fields()
Thread-Index: AQHW7iDfXiv5iuHOl0mGSxMcJ7OwhA==
Date:   Thu, 21 Jan 2021 08:23:20 +0000
Message-ID: <DM6PR04MB4972029B58F81B22033E31F386A10@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
 <CAGRGNgWLspr6M1COgX9cuDDgYdiXvQQjWQb7XYLsmFpfMYt0sA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:1700:31ee:290:6c3f:2942:f9ba:e594]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b399c6d-302c-405d-7f89-08d8bde5cfd2
x-ms-traffictypediagnostic: DM5PR04MB1035:
x-microsoft-antispam-prvs: <DM5PR04MB103558D7CAA67BC277FBE0E586A19@DM5PR04MB1035.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: luBm2A9fQFDbAs+wwf5UQLQqGI+U9qrY9qOoLl278vLFEhZYF8PCPE1mzg6Tt00oqorUoJZeH6SroLCiDqfwK9XrIA5LmEasW9gV2WFpREOKVrf0vl5YIGT/uz5MOZLMc95bMXi+Hw5BHRva63Z5/1PuoE1WocRTm129bzScDkldj9CvFwvFGhDH9Et4QKMXUX+IciSSEzf5XTQnwBQ4Ce56JAClngNy5hTRHQCC5L4OmkCPDAyuCVPr/ljXo1Jgx+wBya1uqegcbpFR6wk99WVD4J4hLzl4XOz2eSJuA7hIeWxB1OEAXp8WrdWox86N/lXoRtgzme1lqsuaDmQHfwv/fCM9Q/yzofM2yqu2Jy068UIlRYCsj/6zdaLjN0gxaku4C3m0vY9X1srG/ZD+9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB4972.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(316002)(52536014)(6916009)(186003)(54906003)(5660300002)(76116006)(9686003)(55016002)(8936002)(71200400001)(83380400001)(4326008)(53546011)(7416002)(7696005)(8676002)(66476007)(91956017)(478600001)(33656002)(66946007)(64756008)(66556008)(86362001)(2906002)(66446008)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iASZoPJYzsgBoHOG0e4uj4eYwMJzI7AYx9ibXkU8WlIY/45eI5Lozn9IMLqg?=
 =?us-ascii?Q?K1fUjrE61rIj9pVmoTN18nQMr+gvGY4G6wJ+Ny4pZYARx/NQUcSJcxlwZktO?=
 =?us-ascii?Q?bHqvL2+WTuwKfq2jk97rHh4iKZQYlGKj9o5IFGIIiC6E0WKGXNOAogExeiH7?=
 =?us-ascii?Q?tO53jk+LmhpLuLYm0OVz3gHZc25lTvqogVwbwvUqG3rX45XT/251vlSLhLDN?=
 =?us-ascii?Q?BiAaGVE7uBNDX6Lo7JJvKKpz+6vrvuvatx4hhONQ7MN7a+Zn8FxjYQrE2SUa?=
 =?us-ascii?Q?uH7RyUQL1jRl4VoRuKHUwCaNA0ebTkVOQKvC2VmJ6rJqt2gYMsgZjF2sAvYF?=
 =?us-ascii?Q?ZwtuZCJhEJsAawETHIlGBaxry0pr7057QSOs8vA7S+uAfyiqeL3YEqc6ejxT?=
 =?us-ascii?Q?RixON+06jvKRSioN7m1wLJ0XqsMUTEiwAu81zEEefyjFa/50E45jN0Pifbq2?=
 =?us-ascii?Q?YQIZxBpt2Hqxx1KKyTlN2pXg4IQbafIQchs+7TVmwY/vsp9tQR7uEafp0BDS?=
 =?us-ascii?Q?bu5T812yyckpVYAeXogWT4zDgQOCOO47FhLaIz3EFn6kvRW51FFMDKyBoiir?=
 =?us-ascii?Q?wXwhkX75FSf1Qw4pnCXK4hYvl2cDv1YYOEYl1WdmIjJ5O2HNpEWKeTvOxwCX?=
 =?us-ascii?Q?6grVS6+rBLLWAffAcMo7a016G35j79LX7hwn96/LgR3wCcwVNSh6y48Rw/g5?=
 =?us-ascii?Q?buriD3gNHqhP6WETZHEu3zlHI7zs9yJmY9x9tAS7fU8E1W8RjXRnFv3rsLTV?=
 =?us-ascii?Q?mGTcmEpB3F0x56xPLqIzECmw12+8LqLQ8UDlGJuGXusb8MbbIGileZPhB+uM?=
 =?us-ascii?Q?eYZwo7QTxj15lHNkB6nFsDURRPPebs3b77L/3uwexEDpxECQDVj7jI8ssHcj?=
 =?us-ascii?Q?+WRw7u4eTJ3rUDPixBZPxm7sdD54H8NacygfAoLOu7DQVosWaIjmoJMeqwei?=
 =?us-ascii?Q?UQpipq7k3iuDVr8GZd3RD+7YB2iiiLLxt9SAooJrWAExIIw2daPBw3LpDI2I?=
 =?us-ascii?Q?v+AxiMYRd5DaVrZHEoGe1XFXE53nsSzE545xeS/B8kIzqSQ6QWmjCxUgzTIz?=
 =?us-ascii?Q?RlRAUztqVUa3QAZZjmDwWD85Sb5txeijXEhtYjBST9cPs9YLaZg6pekySFU5?=
 =?us-ascii?Q?eMN2lhUlrZ6V1wO6BG46/XYS7R06vKBnUA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4972.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b399c6d-302c-405d-7f89-08d8bde5cfd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 08:23:20.3555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q/0OYkC/ek5ytB2UVtDM2si2ySo1pVi+WyQqr0ClrR0sMEWiGpRaV17E+ClET0fPiMj8qHuKJIGPJIy3pAz1DySUTHtG+BdCm5OrLj07ghM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1035
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/20/21 7:01 PM, Julian Calaby wrote:=0A=
> Hi Chaitanya,=0A=
>=0A=
> On Tue, Jan 19, 2021 at 5:01 PM Chaitanya Kulkarni=0A=
> <chaitanya.kulkarni@wdc.com> wrote:=0A=
>> Hi,=0A=
>>=0A=
>> This is a *compile only RFC* which adds a generic helper to initialize=
=0A=
>> the various fields of the bio that is repeated all the places in=0A=
>> file-systems, block layer, and drivers.=0A=
>>=0A=
>> The new helper allows callers to initialize various members such as=0A=
>> bdev, sector, private, end io callback, io priority, and write hints.=0A=
>>=0A=
>> The objective of this RFC is to only start a discussion, this it not=0A=
>> completely tested at all.=0A=
>> Following diff shows code level benefits of this helper :-=0A=
>>  38 files changed, 124 insertions(+), 236 deletions(-)=0A=
> On a more abstract note, I don't think this diffstat is actually=0A=
> illustrating the benefits of this as much as you think it is.=0A=
>=0A=
> Yeah, we've reduced the code by 112 lines, but that's barely half the=0A=
> curn here. It looks, from the diffstat, that you've effectively=0A=
> reduced 2 lines into 1. That isn't much of a saving.=0A=
>=0A=
> Thanks,=0A=
The diff stat is not the only measure since every component fs/driver=0A=
has a different style and nested call it just to show the effect.=0A=
Thanks for your comment, we have decided to go with the bio_new approach.=
=0A=
=0A=
=0A=
