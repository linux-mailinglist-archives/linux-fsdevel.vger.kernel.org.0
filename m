Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA6F5B53C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 08:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiILGLr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 02:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiILGLp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:11:45 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E6522526;
        Sun, 11 Sep 2022 23:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662963104; x=1694499104;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sKhHLazaaTY3APwKeWry+775zkjgGpLd266ernaAGoc=;
  b=L46pCXkyA3EVQOutEzOplGPMZBbzQfiJ4xW5b9Ypv1G56qOfzRD499F4
   gxDqeZRmrhT5f7U+gpvh8RAUW5lY23paKhyjI0m1jZkvt+pR1K2tB70as
   GYDN2CQGU5tPmycjmvenn78PajoTTvOmDkWy5Zr8p57aCpXy/ThBUZzG2
   X9jsy8jSBRQWOvbmEOy59Js6GM0sTvClVpxyHiyRmGtzriIqkRU5PkS/8
   scxShnFp07E57SjazJCLupsleHjIzQXuIdrItHHP0IiDGNZDi3fEFwyeG
   zyidGSJ3KdXEFl9/2kOQLVjnZHVB094o/ejmXT2e/hutnBA0CbYPYkh7H
   w==;
X-IronPort-AV: E=Sophos;i="5.93,308,1654531200"; 
   d="scan'208";a="323204520"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2022 14:11:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5CUnfvWVznj6NupspSss586aN872qI2yFB1fGzM8G4059S30Y1PSRKIGWkE45orbiZsTfmBdzOZTqqqL5f6A8IwjGGQ73W1wtUouwX+RKotlPpzqCkLYTiNizP/TURWc0mLwZCIdhbWhi8363+hC+0xw6UEV7u/NH4kt0jJ5KSU2ALLkqwxKlv/dVpm4duMSePPzgNRaUJ6RVXJd/3DzYTHRYxYWWBVC65HEOWO2b/ajbeIKOqKJc7JDUR7wqh5KAEgYg6PUEI2PGq5Z1PaTXXWOOpvCbd9vdLHDlPOssyM0pCwb7MZUzqdPXRhkR48cVEb1ThleAyD9TZY/xfLoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6NfFsSPnkbiSGdiwAorUS0nA47nMVEDj8k6wXjh4Fg=;
 b=dJFNHKCzzh2U7TD4J2o7IYHcxI7SC2jNSaO9wk2+JG+xNDgLwlwNHKJrrtWEqTfBaqw+cjnKAphb7y2QAwqgqLa9olJ70O9NKrO/nXmxDYg/9iOdnM0+T+ga91igSr+894gO6BepJsdD2SsBqlRXPgXb7jJwmYMP4WzZfWkFUGRDxCGQheDujZ6pSRVFlFWK0vvo1hbrASvHCRXYhi9ubBHdAhCnYzazt8mk0n8Qr9hLk7jC2HODffKxqThFoTOttAZvEvEtPdiAXOMKREv2wPvgOp2p/b5KJeVuqOUqn1goj7z7GSDIsSvrg0a1vuTUbaY7eSDYeAbQgS8adgDN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6NfFsSPnkbiSGdiwAorUS0nA47nMVEDj8k6wXjh4Fg=;
 b=vOIR8lsKQcotx86m98dixvN+tWgEhi+elNplyF9SVfkdJeeFocZQcqVhIA5fiLzchKEY+EQ3ffAav1sGfNW+xxuEZpoUhQQLAGQ/OSS0ocUph2PKKvtV236NQ016voXWWJ/FFKOM4DMRL7wbnQMuAjY/W1V0XTw4YoEWVjZcdQE=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB6441.namprd04.prod.outlook.com (2603:10b6:5:1ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Mon, 12 Sep
 2022 06:11:39 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7412:af67:635c:c0a9]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7412:af67:635c:c0a9%7]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 06:11:39 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 06/17] btrfs: handle recording of zoned writes in the
 storage layer
Thread-Topic: [PATCH 06/17] btrfs: handle recording of zoned writes in the
 storage layer
Thread-Index: AQHYvdZyGkrG9VvbMkuHCwuoSrrTDK3bYVwA
Date:   Mon, 12 Sep 2022 06:11:39 +0000
Message-ID: <20220912061138.z7rk6szb34owupin@naota-xeon>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-7-hch@lst.de>
In-Reply-To: <20220901074216.1849941-7-hch@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM6PR04MB6441:EE_
x-ms-office365-filtering-correlation-id: e35e70eb-3e07-491f-8bc5-08da9485a7bf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wqRlU8d8tNlVLMMjjOBpzN87cw5YIULoXJvA+nv2GsPIqf9gomiO6CNGqw5u4hh3ii4y2EaJA1HLwNhx+Tsek5R/aan2j6RzV1fikoBV1D3N2xmgg6xxFL4CBQr/6zNVN83QeaxcieSkxY/gpIuB7Q29tFEA1/Yr5hvo223WlR3/rlqpsaKY17lCRXy9/0eF+oUdZMW8iHNRdJhr20x17BTJXLV0jnV3JpR9hCnjrXy7i/P3h+4zXhUG+iOpL2oLopZUgHoHrimYVkrfzer8bkfF8UsEgkZ5b9XLmnVAqe0MfSg3E5zhxFocADfhQVIedoaZhkPEww6TafcI/iPwxLWIdr7e8sJzlzjZIsK3SSbW3rCakAogDX4cGiJulWXy1wAFo/Yd+Rt6J+/8HWkbDQhRLxelRANojJq3PpnoH70t5B5PasrEejXJ3OQVejqD0zxTn/hzUfaBcPxSadz+iOgX0+4z5blcPtjndF4Hhip6yIJysPGan/t+hZyc0IGWssDNqzpnxQfuS2fTjumB5RnsREJBGYpoSta4qQPdQnRLfqf1lurIQabgVdudq5G+T0QBTn7JBTdlzo/pJ5nxtElEr1/Jiyzzty4xRXaasDZBeEgEWDFTaCBgVQH5qJ/XBz2w7t+AE5dXq0nMo27yDccEqKxNEhCQiQtDnIBi1UZOL6cL1V2puNjX4cVWh7vbIUe9Jlr2dBII9XJNtb4e2OBWPSwoyMQIwczweFWd9fZYx6k5sYhQg/H5K2V9D3dDBtEwT0zM1L62WfU8pZb9/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(396003)(376002)(366004)(346002)(136003)(76116006)(64756008)(66446008)(66946007)(91956017)(66556008)(4326008)(66476007)(8676002)(6486002)(71200400001)(41300700001)(6916009)(316002)(54906003)(33716001)(478600001)(86362001)(8936002)(2906002)(7416002)(5660300002)(4744005)(122000001)(38100700002)(26005)(6512007)(186003)(82960400001)(6506007)(9686003)(83380400001)(38070700005)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vXMO3VanrPaTOy5dgMD141tE2KatGaRwgvHqqtdxPIxGZHj6vleySTYbIu21?=
 =?us-ascii?Q?Du0y6RSeuqeddSD2VE9GcO79ia32MCZ4qMxqVwV2PldgmXezEVpBFV2HNrc7?=
 =?us-ascii?Q?RkbzOyZHW/0h1NWTH1qXXWf1YXVVIhH2IjAJbET8iPWFh7AKpWKgm926QIf2?=
 =?us-ascii?Q?9KQ/Obq7AlJK1Ue0pay6kSGQT16+e8oogUyZ+D9w5O11w5FN/0jcux3MYZ+A?=
 =?us-ascii?Q?+BQoKlC6iGSqGfyCONq8tFVfnIWplMbmGI/XpFWcsS8h03GkWobbKHHqdWlB?=
 =?us-ascii?Q?JdqcIjZ7xTND3QoOebNjLQrnt87BuuID22SKJJ6Q3qJruO5FTpQSFbUhwYDU?=
 =?us-ascii?Q?J1oqaepFr/gjCIXeQ0L4Q+gz9vbDOsPdrECLZul/NMfEJ1ngznCSpG2Prw/8?=
 =?us-ascii?Q?3lhO7eIobsVKkuRcOyJxtBiF3JVwTfhGCYmOKU4WTrllf/ZAW0Z9MJ4tQV6O?=
 =?us-ascii?Q?AlP4ZJl/LKajwl0Z9n3avWoVVmuzfrfH0AuoPQNfM57z99YhebDu4Rh4Pxmk?=
 =?us-ascii?Q?gTK3tIDq+4oHRqzjN6X0BS7mLrnBDuPvFnkEhkjSEsGdW6q4JNj1GCXGXLHt?=
 =?us-ascii?Q?pB1/jHqlzcr4JIzcq3ZekUkOsmEW0wxetdORyIyVFzvs40EBLSX2esdolyDi?=
 =?us-ascii?Q?mDvFLgpQBSC8RRf7x6FZn6vD3MqNWtMjfaXCyXxnE81GDsViH4rZppA4A1QT?=
 =?us-ascii?Q?/YCUrQIOCeClI4/9Hl19Ke2ktzp0dyYuz+7ijSLS9Zd3A9lc8Cg0z6NIvDfE?=
 =?us-ascii?Q?WM0g9vEDNF1UbWKwh9harQc6zxUbngnN7bRFt9WGqUlkMVNHSFnhPYFKspUd?=
 =?us-ascii?Q?op17BX0cqMjyJmM+AymITNDYxYpcl3TZO3aEc0dcfzROU0DITOp+qeN86k55?=
 =?us-ascii?Q?zkMf1Lv5m3hB/8JrhuDj/v69Cl2ei632APhi2YjvRGlCEsTnqZf7cb6dl9d3?=
 =?us-ascii?Q?vJFrJMaac/bLKFwCqzWht9SHvAL5HF4q/JDuNCCuoFJN9w8+8hAbyTyqJork?=
 =?us-ascii?Q?5hvmC1FO174f8la6foRLQyT1PWXp9uWbVkaya0bYD1ZW9d0Nk+L4jpol7yEV?=
 =?us-ascii?Q?2cfWL34DnasC211FJZ0W3DKV66WtYKyUC+8a0pvnEQtJCdpbgzGQLB6EiVt6?=
 =?us-ascii?Q?Z1KbQdeSW3MX5N/2uEbZfg7wcnKEVkwlbQ9zct3SIqvlqfZu1CYZy8RmMP6Q?=
 =?us-ascii?Q?XZAjeF0sEKeMht8raa/0yJoGMuE1Zed6vYdKARlnT7a/inKbDUzubixMJgXd?=
 =?us-ascii?Q?SOIP5kGWjOS6p2s9VjBr/IYN3ke7I/sLmvo3FnAGpfy89yte753EAYqYvWic?=
 =?us-ascii?Q?4U/2J99bZh8ER4Fgv5T/cgg/cCX6ugISZNb996wBiJKJkBh7OgSHv6mRLZqh?=
 =?us-ascii?Q?0qRx7mUJBYZWZ9o9tY5ljvnV6zViq1WvxZEcKOHsfl0Zb21U8KHlt8FJYf9G?=
 =?us-ascii?Q?w++JnymAXYibMiEw77NBQVHs/GALXMOoPUiXSwy2Q4F+I6hF3JWUDsYo6LSc?=
 =?us-ascii?Q?hPGD24hqhFWu4OQJD0o8Knlx51zHGoE91pNeyu9cKq8yPw01gb4MToYPIr0m?=
 =?us-ascii?Q?IYSwGavIWkq8mhwam3Sob8NQT+we/im+yZ21X5lQjQVFv/HEU4uMlbeZAw2F?=
 =?us-ascii?Q?og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7CD98DEF1A61154BB48BF397EA0AE0B2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35e70eb-3e07-491f-8bc5-08da9485a7bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 06:11:39.1630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a74fHDh9855Gtzm1FZ6b9Cmq35N0JgAs9OmyST330fHxyv9LfOLuEotQ27TZrc37iM3QIhJQDK6pUtb3nYd9Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6441
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:05AM +0300, Christoph Hellwig wrote:
> Move the code that splits the ordered extents and records the physical
> location for them to the storage layer so that the higher level consumers
> don't have to care about physical block numbers at all.  This will also
> allow to eventually remove accounting for the zone append write sizes in
> the upper layer with a little bit more block layer work.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=
