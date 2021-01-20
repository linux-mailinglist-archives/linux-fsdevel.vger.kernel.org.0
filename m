Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFB82FC9C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 05:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbhATEJf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 23:09:35 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:9554 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbhATEJa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 23:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611116147; x=1642652147;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NnlL+uLDYxEdI9JgteNUMarLlNZ3LgW0X1R4f7FdBHs=;
  b=Kurldsj+OLJKIEhb0NGJkRfNUGK/SCh+o+7QoId7cGj+2+EUKL35mBl+
   wF3XTcjCg3yII1xDP07hQ5RbsZrjsE+9OODdv5LS1+NTHg7J4kvciLx0G
   eIqyLUzmKrRfKpCug4+8sw4Gv09OQi5ve9vatJ8pws2CPnibi9fy0y7PX
   1qnl46d0veG6T+T3DoDCPqS9SzKXuv9cSiXNdbrCETrz2AemRcp/ZzYaX
   WzVWF+pNnjTIQj/vRwi05PRrMPYLDqL1dOBanp2/siU6yYrMq/aJdaw+0
   yFIeZ9QzPkEw2KnOAuoJ3hsMxHLdfvkYyNe12CrvrH8m+r4pLQzAKJVt0
   Q==;
IronPort-SDR: +WahpsSyZKB92SQlyVpbSVtzyV7ig1CDJ/nHpf0VQb0VJAbY/0sMbUOGyFwzdwqonoUDE1WCDj
 qDYPaAufO5y4MtIOPQ+biotvSO4ei4yqsbQdEkosOP1k6M/v9uALBzl7+Fjo+Wo9Qjv/Frdeim
 4Saocmc+5EDBJhpVtoMWFY5fu8Z+Ji7dkmAnQ4JI5KvvUZXWIERm0IS2ze3UCpL4aIsCVy6UAt
 rzl+wvB2mEa1U3+R0apK6BD28oBMaGFbc4emhXOoST1eWmeJeIaFzGxNL8Cvz2A+DbZ26rw3Kj
 O/g=
X-IronPort-AV: E=Sophos;i="5.79,360,1602518400"; 
   d="scan'208";a="261832116"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jan 2021 12:14:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlTta6aY+kc0y23svj1ZxSfi9FMEwk+W5Se9qzwYQymkV20A3yCDYmDwNmZSmJgvOdP2euvjdOPWgAnIKJhmCyr8pWc/mjxpVHKLkRTAIjP2iQ13okIN5GtGiu0D9jnbmaAYSK74FHJbpyu49eMa10T9ySf6Dw28QqBS2zyzkmT63+kqywcAoTk0hs9x6D3fTyfFx0WVdyV7q/iZVAJKC0A2+RrOLtVH7DI5/gwSpU6INhV4/L90m8b5m8YWSg6ueGpmYULaQqIQDn7SkQjK8XlK3Hz3J8YJdt7xGltISOy3pMevuCVrYI4vQUtU7rGXoQcvhJM50/ISPVoZaQpRsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnlL+uLDYxEdI9JgteNUMarLlNZ3LgW0X1R4f7FdBHs=;
 b=kJoU+HC7iNDuBmbz5tNzRNFRsQ111nsh6ytX5z+cABiRNyZTutoYiRGrlYWz0F2rjW6cjLeh/VABwNH6wMWqaATOkN07pzJyiEXAigFKHNhyo82nf09DGTV3Z0Lzym2bIErHVip4ZwXbEJDrEblRG0epUQb2IWNyG+ucJMKDbrsUexTQNQF5+bQhVbYySLmtBrtV1u4hO9C+8xZOWX1lBn4Tr65ZMe1KmdKYXG81EzpM4ScRJfEPvmLUoCqKw2mZJz5JMe2I7MjaHlqolNdsmnR8HTrnXgzcXLUBGMl09z11/Vyb2R5x/gLHLa+yLJw6kYdrlBfzUzOqA2L5Mkwjew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnlL+uLDYxEdI9JgteNUMarLlNZ3LgW0X1R4f7FdBHs=;
 b=PkUy4F6tBg0zh9AUqTOfCV9RzG5zO8xz0VX+H1gswCT0H9U4PfqrrtrCZuJK6MXG4I1YXJ2iqtHxCJPN90fGtIp2IMUGPb6u1a3o9tnl72RUPWOa7yRSEWMrBgx76NqkIwgiag8Hhm2VLw/HVsm49GmKdM1kCrHvb84uNlw6Vw0=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6584.namprd04.prod.outlook.com (2603:10b6:a03:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 20 Jan
 2021 04:08:22 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Wed, 20 Jan 2021
 04:08:22 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Gao Xiang <hsiangkao@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 31/37] eros: use bio_init_fields in data
Thread-Topic: [RFC PATCH 31/37] eros: use bio_init_fields in data
Thread-Index: AQHW7iFpFOpQfhSUPEqJsknKUWj2/g==
Date:   Wed, 20 Jan 2021 04:08:22 +0000
Message-ID: <BYAPR04MB49658C711A2DAC1DAC8CE88486A20@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
 <20210119050631.57073-32-chaitanya.kulkarni@wdc.com>
 <20210120040544.GC2601261@xiangao.remote.csb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4a3f5a2a-2c8b-44f6-e311-08d8bcf906f2
x-ms-traffictypediagnostic: BY5PR04MB6584:
x-microsoft-antispam-prvs: <BY5PR04MB65840C34B12A9ED5D2DC86F286A20@BY5PR04MB6584.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nC4mn9NwOtVksEWBiEAZOB4/HII6eS4fnTEwLiHmPDzzoyivVf6w8A0CWZFq1gcxHkr3zoD+0jGp8fjgo/2lPxZ9NcdNbGUfMB3YAywjxI70KdmWls8sPd1p8o7ZtcqDZv724Rzzen1eKHVSYESB+N5IUYuFTlplESYtm0bvDZxln6Xx1exm7mNhFXEtYJqppwCo37ibhqPAO8ILy2SdNDkuoxJe3AEXS4uAKKRL9P2F1mq8F0ekzBIaudelzNb+fqigVUrOU7vY74NUQ/VHusCv1QMFLRKvH/3C55Nti5q6cQz6my6Gs56Z4ultXOU/RiRdipF4jr3sE/s1We5bYmseN/B3fMjP4HLbpDIHvlI2dzMxJLSYHj7+DqDyZD8gbtt0eGRfuEyIwTCQx/VAGFLIZjEGNSBB03NmV+NZXEDGWbXG0Pphx1zcRAvfDSoozXTkntcwSyOXOZGIBAkY65nyZUr2AdcICPH4ZqmQMdxhMP/7+rINBvu4X5InL/BOwuRzLirRNHRgMA0iS8FLFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(9686003)(4744005)(66476007)(55016002)(71200400001)(66946007)(4326008)(7696005)(26005)(6916009)(83380400001)(54906003)(64756008)(53546011)(6506007)(76116006)(33656002)(8936002)(86362001)(316002)(52536014)(478600001)(66556008)(8676002)(186003)(5660300002)(66446008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?7LccbywZtuy9agZaiAG3CVZcYhCAsaGlpZWlx5nXO6H6DcmMiswQPpz8aTyM?=
 =?us-ascii?Q?EbLKYo0RryNH0EwcIaZhgFQBlMeLrVbUFqsflYLi7GJA810EXaqA31RTuCn7?=
 =?us-ascii?Q?ynmYdNSrmC0bB/RZahMFoqMp6IOB/UcwJ4ohMdkfURSHow/5Ap1iBtOj1yIk?=
 =?us-ascii?Q?Hc9jTiuaeT/dGZ0rGbaqQVxq0FzC4tPP6GJeQbDCmAsblfe+UB0l7lSzPuiW?=
 =?us-ascii?Q?4qAF5YIzI7UQ0x8rTVIScyoUPN0+ILHwBezomM+wnr5uXgJSttthhGZBn7sU?=
 =?us-ascii?Q?e0aEEkfNZgDvptSSI/nPW30nWvu1otJiZWm8VXMjRGpIiALNGPUb19dv2bpT?=
 =?us-ascii?Q?E1pKw9MFhvfQLPQIsknKSIN6iPph4/zaApdwqeUYsGHSGw8jiuiA/bBqwpfr?=
 =?us-ascii?Q?JUa0StQRfal9V5xNxUN3HyAXr+FQv522HAxmwMwXIEPhw3jma1VZfkxI1mX5?=
 =?us-ascii?Q?+NLqGfmerv2xLcA37Qd0oBhpQyh1JAOg23HmBf28cV9npe0Tv0bqDJz21aCQ?=
 =?us-ascii?Q?I+n8viHhxkyVIIzFS3H6pnADX3NNDskfV0nUzMFLYEek3IJ1mizP1Ztnazqz?=
 =?us-ascii?Q?PHDvXZH7z6Ntblo1/9dsgpmB27w3dFGMC1mIj5bLF1XN6swi1hlClHpyYvmg?=
 =?us-ascii?Q?sq+Kg6wEhukpOuoHEmBgt7wypCY+CLjU8r/heLcT5Sf0vvJngFW/GU1FApQM?=
 =?us-ascii?Q?3g9KS+F+Y0XU29gYUm/cZAxV/Vm3Tj7QopISZhZK/+3o24Rs1CQ5UqjLFxh6?=
 =?us-ascii?Q?aHnKhIgkR5Rx//2hbYinsoTd613wA65qAdlCw+6yIJKacET7jV3OPjcwfEFI?=
 =?us-ascii?Q?7SZrGERjMLepJNpeIxCEJOcGVM/r9eJpxnaFDBpGxFEDeixfJ5HDFRoMg0sr?=
 =?us-ascii?Q?hEgqbHwc/nKHOdCPpi50ppSCLJZz8lSR6oM+tIKkxFv76Mf5PN6YBolIgNot?=
 =?us-ascii?Q?aK+OH5xBOfDSViR99A/t596o96nXEs7b6i6qdlGDcNG9lH0JsnD7cEZEW1MO?=
 =?us-ascii?Q?0JU2?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3f5a2a-2c8b-44f6-e311-08d8bcf906f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 04:08:22.0328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rVzNGSLf3BFhGf/l+o3YV3fvijvpnPkjJFmlkXuRLTWE3oNx6h8kTsKyMcM5YB3Lx9iD0NkbJ+AdaYwAdLpGBc6RVTY/knuDaeQ1roqx7fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6584
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/19/21 20:06, Gao Xiang wrote:=0A=
> Hi Chaitanya,=0A=
>=0A=
> (drop in-person Cc..)=0A=
>=0A=
> On Mon, Jan 18, 2021 at 09:06:25PM -0800, Chaitanya Kulkarni wrote:=0A=
>=0A=
> ...it would be nice if you could update the subject line to=0A=
> "erofs: use bio_init_fields xxxx"=0A=
Sure, if new helper is accepted and can be used in erosfs=0A=
then I'll make that change. Thanks for pointing out.=0A=
> The same to the following patch [RFC PATCH 32/37]... Also, IMHO,=0A=
> these two patches could be merged as one patch if possible,=0A=
> although just my own thoughts.=0A=
>=0A=
> Thanks,=0A=
> Gao Xiang=0A=
=0A=
