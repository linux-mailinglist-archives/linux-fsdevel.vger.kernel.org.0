Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71413E47C2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 16:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbhHIOis (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 10:38:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54018 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbhHIOgR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628519755; x=1660055755;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=BRMYlI9m1tfzQ20/njsrGJq+u5Krv1bxbma2/fdZYQWGaJ6LOrhgp89g
   PJhoJVORDTmXNFjQF61d7RT6AZkmRUP0JI/sgukXDcdA7fdpW3kRhcicd
   FGzDVtv/8gQMOyVdm+AK3hBHRbXbw4KLnDSOiwFOqTTnK6Vf6/rrd0e2B
   bAQsjpN+k1CuLDbxpleG7LhR3WfZkWR8xdZ0msOQwlE0z3N59uMDHBRmg
   2YjhnFPnvtmPR1SR92W4HLGZpdw/d0RrI3mJhj0dOjJwSmjBcZVJCkCp+
   MT8voivdp3fulq6jUo1NqxIZcsriAAJ2r16uF7RAQSUL75sgHBKtyMmHv
   w==;
X-IronPort-AV: E=Sophos;i="5.84,307,1620662400"; 
   d="scan'208";a="176691105"
Received: from mail-mw2nam08lp2168.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.168])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2021 22:35:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Byjs5LbNvDo81zJ03gFZ0b1XXOGLxNXzXba7Swf3bwJW8QOt2yKZuVEHs37wja3cfjrLZEgyVLPwUQ9354vw6Y8KIepkRlqJfw1lk/uWYt8zQr3rUTfsHIkZsiRh+25sNk60RS7tSNUqA699LCn730qC+0xq1wHGYQTrHAjPUowSqdavYq8QmN44syGT6fpjpiA5yjSUIAhqKFqPcKg5oA+/NpUNCVyu5t6vUrX0/S1iMGCOE1j9y97pzmgOXO3gIseIXp6zZ94VdMgx8URNMCJD/rK+fwJFmc/ONH7DwsuDP/1VuOoaeMXnsRO3DBA08ir+u2Lomdb6RiGlqTXY2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=lKwoAl5L9ESKh2BLrQXlllKQvAHwOfBUvopC/CrzPZnV9qRUbSoH/LQkPb+rVwCN8F1/WseJ4upKf1eWOOzZIPKCQlM5u9SFsDihufU/Lzra+SXEmbqiyTHir/FtpuiOBlK58uCBt/0HQj7Gl5hBtdUZjDCH27fLynNWOqY+yc12EdpP3r8Coq4jAfc9RkrZW4zSRcP9Ut5jF2QFy9/u7IZlw7CPWhk870CgIHzMikt/DjBhs9h0kxwljlmXuvm1zyaW6i7/k/mEKs1MTsiVKGBaLv8QfqDYRn6YvHhveulZXkoCNnFj+pAXLm9+rJoFcEn39n1iJgH+7uUs1P5ZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=vUZK4k0Q6Y52VxJ72rg+espbxmwThyVD5bG7FyfrzKR/DrngogL695MMgEg/64ybkIaApLp6aJrMYBKDZTFJAVVlyd5YkTNzjKr3gTg0MQH/7z1ns+aWkRQQUDi1KS4Aa4QmVm9692GVMDjTEAFHNJ7w3WRTo/FyDCySxJ3rL1A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7574.namprd04.prod.outlook.com (2603:10b6:510:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Mon, 9 Aug
 2021 14:35:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351%5]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 14:35:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 2/5] block: pass a gendisk to blk_queue_update_readahead
Thread-Topic: [PATCH 2/5] block: pass a gendisk to blk_queue_update_readahead
Thread-Index: AQHXjSmwyxOkabqL2EmQpEfzjylU5Q==
Date:   Mon, 9 Aug 2021 14:35:12 +0000
Message-ID: <PH0PR04MB741611133411D89D85F101029BF69@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210809141744.1203023-1-hch@lst.de>
 <20210809141744.1203023-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a978b694-240f-484a-233f-08d95b42e5c1
x-ms-traffictypediagnostic: PH0PR04MB7574:
x-microsoft-antispam-prvs: <PH0PR04MB7574C6F58E1D6F547BD05BA39BF69@PH0PR04MB7574.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oqG27c9ESPUD6fxZ0xvWuYrpBlsz0hGUecVZ+TDnJG+qFS8J4BVvBbehuu/nu8E+kaNtN39v8fWy1nHscRZFhFQ2ndVkjq100L8cdTn/2/mZNKpeJmv9KMaahWmVo392NKlIi4xr7iJoGLCmkbPgGmvLdyf79FR/Fcqa4iv4UuToL/bQnzWxq+lupkr9uYV8g0h971zIYtncFHVTlq9rYpeRK0rMLjgqWT3zoL5/njhu8f8xvZL40sfCws+NIzWa1iK8qZaXsbA3YhxX71lVfGUAw7Zts22SzFLc/+uiQ3D6QxTeIaKfV8x1kKwfAZ4+6PNAU3bvolS+ypODph44GU8yRspQA8sUtFBNPUhAylNlnQHIwy57ncReaOFO6NKRkpIygbunqFXexZQCkqjCey0l4qitP/4LAZ80l+Q++WqNV0b4X2JSihoFsSkH5jRxEuVK2QCXpvgahF23OI2GWCsyF6GiHv1P64bOwdKW9Hrv+/oh4EgkQvsV3IzWpSBfYC0jpuKdgniYJhGRhvi6M6AVnopbgsRvZ0cT4oICyzdSXvHYsmQNW7KupDZL76YczuC7JuO7qaXpiiBVIQUKLZq9MOVjLHNanhPsdqnKUWutLT/aCS1McrZZAULdvKCT9aJ1p7XWCyy77rxP1lx2HGVK1xoXo+zkiF6A9xqqlxvm4370rGNZIT6/0KMl8pd8srK75vmvjgMexsjdEvL0bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(478600001)(8676002)(55016002)(38070700005)(8936002)(558084003)(19618925003)(5660300002)(52536014)(4326008)(6506007)(9686003)(76116006)(64756008)(66446008)(66476007)(66556008)(186003)(33656002)(4270600006)(66946007)(122000001)(86362001)(71200400001)(7696005)(2906002)(110136005)(54906003)(316002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cNaJM9J9M8G76mxOwkMWEbHejFIYwLb/qHNnYb0vlMY04o1JtFHLBqCipCcc?=
 =?us-ascii?Q?AAojDM0yxBKZJR1NcRxZ4rrxRpXUM+i88HXed2J2uXhlKwsIVLe8ka6OZ/5Y?=
 =?us-ascii?Q?iksen1Jf+2PjmrXJeMHNRhUHXxv+k4LemDbMJa5YOnxaQ2tlvzucoMLmLI4m?=
 =?us-ascii?Q?nw0cquXn14aqVkzSzSwNJFMVTpzMPx4rAP4KHL7s1Lh/0eTs6+m3zw8F2SCg?=
 =?us-ascii?Q?bKE1j06DUZKl6OUlNCYmN7oTVrnAJH8g3zSTEEkb/KsTZWPMBcKBogAhsEZM?=
 =?us-ascii?Q?175XsEoQONLdvgH814vhQCYsKqaG2O37asv0yEAgKKYwRRKtkYeNfrlwPDvJ?=
 =?us-ascii?Q?D4akR6nfdg69pZrg8J4vW10VEjJ0OxKN82qKiGkniUx2eQJTYvrnI2Jhg89q?=
 =?us-ascii?Q?zpylbPkFFhdn061ruAO/X23yh3SOpEHJXrOwhKxqFdg68oCcC1zgLJ0q+JHg?=
 =?us-ascii?Q?SFc4xZ5y8beLl4HF2mDVHfxfAx+Qenzb+mxmpJumnMxS3Ctl44Ic9R9ksEm2?=
 =?us-ascii?Q?FUGNhSh+AZ1bT/5RFsTH3RwRre8Nb51XPDQWuhIrIq+KcGN3KpEDZBKQppCI?=
 =?us-ascii?Q?zOmmtgli1hP/Bj3spT4eK9N/jZzVJLBxcMm/adPACxSZCLG5VP5RTKORpTSq?=
 =?us-ascii?Q?lV1Z/hjSvlizLZ657KERzwapTKcdJcbKxzvC9MonXBFVoutnbA2GUwZi1U2c?=
 =?us-ascii?Q?ir76Dm3TtBfxOTNPrixcso2MJsHGwwnnNTUZLaP5BE52jfFfSevRlwjx/kHL?=
 =?us-ascii?Q?uzpCHlSyMNajrFzhgMpN7CJLSXdQ/F60Xq/fopu229odGz52kEmbiUww6ORj?=
 =?us-ascii?Q?lDL3vZLE+i1S5i6DfUhO0OeUPNUDMkOsK6VPx0oYRB4Tt9YbXmZApgA8NfT8?=
 =?us-ascii?Q?BPMkwGUImE8WxaNhIpk+nwkuo+jD+dpD7lK3CEJ61GyRtm5xrjsqfs4FUBvV?=
 =?us-ascii?Q?0oN17jwdwo3oAxQjRjofg4HuLxyAtPcw0n1CI+JzIT/rIuaIiYiyk0ZjcrkQ?=
 =?us-ascii?Q?fdDttaDn5FT7ESPrxdAUOaTJUh9Ht6WP9QNY/cN4WtM+0BIAyIKhuSEeRAv/?=
 =?us-ascii?Q?I7KTj/7mptSckf72iVS4k/H6WmoGUrnNPXEcoOfWE66OGeaPY16hh8KwdANk?=
 =?us-ascii?Q?I0gGQpIl9/jmHaqcrZQqvKMxrIUurU2DiuKd3URzPxU4IDYNmFJS/LwTTsR4?=
 =?us-ascii?Q?bYr9Dd4MrqtH5SpPDZi72w8SMoKrkSZs/0c4VeD5U4mZPBldVIuHh2mJVHj1?=
 =?us-ascii?Q?T/QRgIDJPGfRdBUfJf8RxSEjWFCMwvosSHH5o1m4Mgq4/8qrHGkhsHKCM34W?=
 =?us-ascii?Q?L82bQea7IaHQNQNW69UHdxoDlYsJLpxavDQG5TkMzZBPeRvpwOWzWll/xVwG?=
 =?us-ascii?Q?83NzFu7tOfUvsLyUeFXdDiDqj53rmH1Em38/diAs3dZMpH8WAQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a978b694-240f-484a-233f-08d95b42e5c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 14:35:12.8781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 56JO2qsHuMQiVlLpoiHz2ygb68MMTCNdz8TI+PmsLT2NZBVvI8xyO4U8UCkulvKG4jmZ25QWHQCy1RCj8z4UCejHSxoOILgvng3NDPM6/4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7574
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
