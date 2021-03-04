Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0517F32D4B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 14:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhCDN4f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 08:56:35 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22798 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhCDN4G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 08:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614866957; x=1646402957;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Pw8kLyJepDziRUji5sJdp38By9yYAIU7irGMyl0svto=;
  b=L5tvDFXy/qgo/JLZGGwSE9oZS25DIMDacK6zipzRWFSuEC5kBH4fSv//
   kIUVp3f30CtuzWdjK7059huwEThSUpdCPLYdQDh4HvKgpuUxJu0ONQxfo
   PiL6K968s3HshGX4U1DPsBT+XoMR2lJFTVKdU7XQJnGEDQuCy2/qX8eaQ
   vUDPX66pIahM3wSttsf8qPQ9GgG6p46JUegMhugDAupPpTc3NgJZSylLx
   017/SUvUIruaGALhJ89l+jAcsDPTL+1OIKMlREpA8lRL0+2pWFThNbKC0
   R2LxpmTMoOPp+ZvJzhMTpd8m/1+kCMM3X2yQJN2HR4NU930lr15HGOibW
   g==;
IronPort-SDR: PUKypOSx9biD79CSpYSNpguz7ItPXOdm16UZmLyr4vfPzT3tU+V2CjU4ppARBoHDtKVFQbYme1
 GW4iRoAuo8QYwJh19S+RXvZ9gJvlaSF5HymZS65Mlj9aMJ+hbYK4oKsdPPRD5wAyrpnVIrQoMp
 ubr+Q8C2ai+PqNrRMIipWyFyrYt83yGNT7wnLdpoH2UyHL5ZXUjLGJer/bu/V/ZrAn/qJ1nPyb
 WV9aYEimHWGyCs2PNLfm8wVfdKOWp2IchuYJTAJu4m3f/ldio913vsNWUN8MMbG40J7vWZNHyj
 d7g=
X-IronPort-AV: E=Sophos;i="5.81,222,1610380800"; 
   d="scan'208";a="265656835"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2021 22:07:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAZav+IGwdHwvSUgQdLizSjhIVGZBabH4DNuZXZFPz33bgaaYn1fuC5J3d/SGhbgzSZdY5wOnk9npbdwjPj63YoM0HYGk7YitpH9k9yqA2E3c8xrZJnKJbp0q62T7+d1ahX4C8jw3EwMtoJncbkelOWFHrIW7q2MjWkqMytd4WAZ8Uc3AaW3/WJWQRZKIsVoPxIGY66y1YT40RVM22yWWuJqVlVth2cDNxsR5OAsEoR1RzDEm3IYMRYWDO1RXJpX2hIMk/qy1pb+WhM3pFQYtfruU6GcpR/ohw7abJvF+Rep0r06uGH4YBpC+t9FfGeY9pG7mbEzP8DN9yAJu7lxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAz3LmsjRQT0T7uAitbs61cND1xIDAe7sWNG03TKVPg=;
 b=lwyHXyDPWH6g7Aw2fECJgpQ7Vy/f5Pgme0Que1YBAJl4ZuCy6HiLZY1OdA+xuKja/fKtQR9uenPBIAdZ/5EGP5ZxzQFnqkOMYlAjUcnSiKmU9NaKevwO45nisZ+cx0EsYsNwPx2/gZTlzPjMbDhYABgDLPwzgD1Vt1vd3erCdVS08XoUeaeDjrg+wz6vK/dDEkm0UypBqRi6S9tsmO1kS0P1Kiwnb0B6fAfhAH7/1+zl7gol/EN764eZbT6fMvcIxq9PC5kZwSX1AlXa1a0fzIQlHXpTVq+ecYev/B6BZoT2VLSMLbpzx6w2SRLtC2QbOtQDYSf4tHk4YqOyH4gi2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAz3LmsjRQT0T7uAitbs61cND1xIDAe7sWNG03TKVPg=;
 b=MPn7SwYuOxJlJy9WYoxmWrwo5HauLxX3VfcI36Lrp06h9jG2VtDSMTkDm45Ri1yVYwzNKIWv6jD2zV9RyA72+EY0qctJg+/Ku04eqiCSVorfuGVmxEIiCsEucrfcKthjMIMNOgXFQKtmIjfCGLIbcDLMCHPfrqMXq5eMGARZdPk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7511.namprd04.prod.outlook.com (2603:10b6:510:4d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Thu, 4 Mar
 2021 13:54:59 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3912.021; Thu, 4 Mar 2021
 13:54:59 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Fixes for zoned mode
Thread-Topic: [PATCH v2 0/3] Fixes for zoned mode
Thread-Index: AQHXEJixdEBqCZDA7UCYHteLStR1lA==
Date:   Thu, 4 Mar 2021 13:54:59 +0000
Message-ID: <PH0PR04MB7416588309F7A1A4A9E55AB49B979@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1614760899.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:ccec:1858:7740:59e7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f4aca87a-b992-44ca-33ae-08d8df1519ec
x-ms-traffictypediagnostic: PH0PR04MB7511:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7511A5C748329A405C5A60A29B979@PH0PR04MB7511.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3gYzVca6X/2RiIkTC5mnpHQI8w/O6p9ejEH/NlJP3xVVjIvIoqQvYdlr+CxS6sx0/N9+7h1qrFxt+XUfz4W8uAvKEfzd4m/p20droOGYiFThvMbsEwDNkrHx63Kzmig0gqg6QLavCo7nkt08pselpunWBAruiKUAidYNxq6WL3iKOvDUu0vv8dzTOBENcFbdKL4xUWUOYYSrBSa7n5mQ/JMdYocqvXN7n5LcadOlYCArDpTx35Ar/wbIm1673gye2TaGhwAHnCNr34wU6G0FtggtuEDTDW3sGXeUA4TccsDeVydzdFU6nEPPWCUhw8VnyeVWnASQeiFb3Wot0o+V4RXSPAx3dicg1W35YwM4F2xQhjmsgqhzKaqiliSg1TQI+GLIRsPg5sAXBRqgunjyiTcB3CaYzDfRO0qYeqjRkpDu8mJqkkeXpvfhS++7Ol5t/08b1P4OC3F+bMh3JuOo0BLTOB4yF0hHHh05ak+qkdl7sTs1Qy09rb/S/2R/i1XbcW0ykHX2hZAuxOXI3Ywl/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(4326008)(71200400001)(83380400001)(110136005)(8676002)(8936002)(86362001)(52536014)(186003)(2906002)(55016002)(33656002)(64756008)(66476007)(66556008)(4744005)(53546011)(316002)(5660300002)(7696005)(66946007)(76116006)(66446008)(478600001)(9686003)(6506007)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pkQnG/wtQbaCn/u5m06szHFMgkYSJ5hZV1tsgLlnKBLuWmSNZRjZpELCfDT4?=
 =?us-ascii?Q?F+WLcWEgJm4/QhlxWd7PuzfH2TfK6OAcN1UX+uEk7sNAptiqzVVaqh39s4HU?=
 =?us-ascii?Q?MYi7JvSfCYHnt7jOB4FXMU8FmeF2dlpt8In3HyGyWAHizQ1ueVTLoJkSqyxX?=
 =?us-ascii?Q?Q6/hBxI/rRwQYwdRQiFB9QyOkDzZdYVP8qa9EDS76nd9LSopqckSMNvZdFV6?=
 =?us-ascii?Q?7WpJiwsZMK3i8nCThUVKMAsyTeEetniwYdx7u27IqQ1+HWxaZxIhSjJ6vns2?=
 =?us-ascii?Q?jvlacoRIRdTZEWyIlTQVlXWjjMnMvvMNx5qA7iD/gPhzUV5jXoPrdxTYBEhO?=
 =?us-ascii?Q?k3LAk6YK7eVsjZFPbfuSB2bj9NeAP2QXbhbTSRhIMvXZ1X7coqbZOVWznuWZ?=
 =?us-ascii?Q?sjjs/wWF+p82yXfBfYzpVl+TaIBce6wBM29iMgpLy1wv5j9yPouDXwBd8NXg?=
 =?us-ascii?Q?+CjmdWsqgrvgP95dXKiJUNfu2785GQUFRE1hLemMnkDv3ZvrgLFCgJXzxW7k?=
 =?us-ascii?Q?RGUxBso6zgGDoksS0y6otACO3Piz2mvDvOYlfT1BywQsLlboaRWmoE6jR+tO?=
 =?us-ascii?Q?Z95pFSA4aFAjXQltZAHpnWk+ZcUmnUywaz2ZsW3EchAfZHnCLemHsiaLh/CZ?=
 =?us-ascii?Q?4eO44WKYHn1dCPSZyASQsPayyAdvus1UH3QpQgFRoPgk5StHhf8eA2MNN++X?=
 =?us-ascii?Q?fFj6fOtnGDdOl4It0+f8ZWUF72iBiHKQz6ISy+xZGbaxDIFZVY67xWPEnjWB?=
 =?us-ascii?Q?CfhxiZ+6jyHTVKAwrhqsLV670LAKOSgf2Ekm0cEKQ57BAIaDANgIbaH4VzhC?=
 =?us-ascii?Q?ynJf48E0JNU4Jt4U3ZEYfY+u/pSdMQfft0T1QEpn2iIFAXPh7dp+9acyskVi?=
 =?us-ascii?Q?r5kW2TuZk49NQyp+h5L9Mfox6ySW55xTRO07Ub1R3TLkgYXcYQmqpLCHOqfh?=
 =?us-ascii?Q?iiJeFt/qeGHDJPmMZ+I6+iUyJKV/0eoU4Supa71Fe/+eXrAyyyGNpX/tCIZC?=
 =?us-ascii?Q?5Ie57EGosDOTzR08n8NSzqmsaKYTaqk/d6dKHp84r5TZOp7o1awlHdi7PtLT?=
 =?us-ascii?Q?o1rDbTgMZC3lWSmuSuPn0zwBn6TPBAqD1NU/ZxYNqDVo4n+4yaVgjbUzVlbc?=
 =?us-ascii?Q?DDc/DNlNpR2nYgd20eGfl+SvRbkoe1lKA1T+xC7Ao1HnAQdQmRJBa0/IRBT6?=
 =?us-ascii?Q?tjtIcLGSohNTkdP/1hnjBS8nE0jfrj0RHwdYC9dYsRiG80BcLx+U2phTYY7z?=
 =?us-ascii?Q?2OVRJ1VyjHGJJJSelT8yEiHOqPablTPLLQdv+UsCR+JjblnLxOBg+fXM9no3?=
 =?us-ascii?Q?vfUwRDNqxGv6Rap+TGnJwyHnEDzZV36UKQIZxUdSmqHbYloL7zuS5sDtBZn3?=
 =?us-ascii?Q?Luz0J6+yBdKPCLcTYMXJoCZHC3wO9kVUVpuwSW1BepeP3mjoDA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4aca87a-b992-44ca-33ae-08d8df1519ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 13:54:59.3738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sDZ8C0bW5MT8UMaQO1t40YnMccPtaURaVBNEN2IkUMYS+4UpzcgHr30QmFgmwdgtq+WsAejmWRIQ5SfwHNL+1DE/IqiXnBfsEO//1HyhWWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7511
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/03/2021 02:50, Naohiro Aota wrote:=0A=
> These are fixes for zoned btrfs.=0A=
> =0A=
> Patch 01 fixes the type of a zone sector variable.  =0A=
> =0A=
> Patch 02 moves the superblock location to address based.=0A=
> =0A=
> Patch 03 fixes zone_unusable acconting when a block group is read-only.=
=0A=
> =0A=
> v1 -> v2:=0A=
>  - Move the type fix patch to be the first one=0A=
>  - Fix the type of variable instead of casting=0A=
>  - Introduce #define's for the superblock zone locations and maximum zone=
=0A=
>    size=0A=
> =0A=
> Naohiro Aota (3):=0A=
>   btrfs: zoned: use sector_t to get zone sectors=0A=
>   btrfs: zoned: move superblock logging zone location=0A=
>   btrfs: zoned: do not account freed region of read-only block group as=
=0A=
>     zone_unusable=0A=
> =0A=
>  fs/btrfs/free-space-cache.c |  7 ++++++-=0A=
>  fs/btrfs/zoned.c            | 39 +++++++++++++++++++++++++++++--------=
=0A=
>  2 files changed, 37 insertions(+), 9 deletions(-)=0A=
> =0A=
=0A=
For the whole series:=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
