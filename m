Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F9750693F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 13:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350823AbiDSLCr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 07:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350464AbiDSLCp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:02:45 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD37A13D33
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 04:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650366002; x=1681902002;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=EdRxrhvC1BQwvfZqyQkwZzQ52C+04Gfa9v3HfaC1hOw=;
  b=ermYXcN61SXtWGDA/nr7iYIHv9D2x9d5e8dj3FHrOCLl+IcVJd+WEOI7
   cIuksZkwRFr94t8VJ8yprRmifWAU4HpY4r2AumwLpP4HZPpdE6QjHkcO5
   TP7sS19Oc9oCWzT1rT3wGrRz+AoDYevkv35Z3qu4RKyxwJeJwbowgtlZ/
   90YptBViLVn3xrhRtFmqVZS5MF2Rwkx/GPRxfOX7u12kSmMLTwDWiMt9y
   AJ+/rb8DbTedEEFmdSQeWHU9cKTzdIOmlqt/U0YLJS81DcLvl2nBLGNHl
   SDvUVJPZ82NEfj+PqQUB+SMWgT9etj/odTZl0lQuynB4tL9yTNy3wr9LM
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643644800"; 
   d="scan'208";a="199150206"
Received: from mail-dm6nam08lp2046.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.46])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2022 19:00:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcXzOtmwn+GBJMh18r9oeklXVzlQc92KIBtGUaPp8F0h5xtaJI/Y/PBynwbeF1MpNXmZ7HnaGcuUuFQDvY6uUuHnFD29u7Gt5aBxU17zu5Z3VWhjsd64MBjt75ec4ewnpGTTHX9SyqONfonltie71ulueA7OlB08NavF2TZTlatooj/4fZHPfRKh6N5TBqQsEkI6oiBNII4e54It8/uw13Qe/BGwc+E9cQtgLXsLOEEgmXNiEDzlQcY2xgS/K+QM+wt2PrE5gj+I95z4p6cyrqezSeMOiwHqhOmFBwbvE9j7d4a1fy6yJ5xNu6pOttWe3QUs30LPZbkWHSVdGououg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbQJb8vMQ0/p7JA83zWolB33zMa11Cs7TtUJtNFxKm8=;
 b=PNKoge7yBpWlRFLQiDwGL72YCihHAZC4erUqQe0iPgRTtgcdTaCiH8VnWRNc7egakGlpdveKB3T6lsIC/jVjAGzeo41/zepbXQrNZmwfUnrpM8jsTsxXlmYSD4qtTUJz1/F3rwboL9gf5tWIn+lBetVc6lVnjPRElar4qOHHvl1hY4Gpb2epFfA2ziYYDBKqHtnt2gxTuN4Aea5sDPpnKxYslRzcHomBzg30pmEDys4GtRiuJgW3nASP1zR+ylyrxoGkJi1EZa1kwAjIVEjRoPn2W78Yd9bnQuftXLQqZyz4WhbL7IQnEKpJ2aGsqyh1bpcgGJ3QEtTdiOMxmCaSOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbQJb8vMQ0/p7JA83zWolB33zMa11Cs7TtUJtNFxKm8=;
 b=CUCnHnKg/15D3sS+InKfNeVvO20sdvpRrK8wZ0MubHAsm6vJ92Cv5FvkOZv6ToH/EE4P54gpAAKFva6A562o3e8ASEepr5mvryc6LgbJsuZK07/3SGNjJRaX39q9QC/zsO3kEQC9d331G7v5XSpiHrjCWNSvDh2dVd59cZ0Kf3U=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN6PR04MB4397.namprd04.prod.outlook.com (2603:10b6:805:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Tue, 19 Apr
 2022 10:59:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5164.026; Tue, 19 Apr 2022
 10:59:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 6/8] zonefs: Add active seq file accounting
Thread-Topic: [PATCH 6/8] zonefs: Add active seq file accounting
Thread-Index: AQHYUsFZQrzjk8mVp0OZnpV4y0KkLA==
Date:   Tue, 19 Apr 2022 10:59:57 +0000
Message-ID: <PH0PR04MB741681FE45A964154D2C4F359BF29@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220418011207.2385416-1-damien.lemoal@opensource.wdc.com>
 <20220418011207.2385416-7-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e51aa17f-e45b-42de-2408-08da21f3be50
x-ms-traffictypediagnostic: SN6PR04MB4397:EE_
x-microsoft-antispam-prvs: <SN6PR04MB4397C6E5FC8309F57C8DCB989BF29@SN6PR04MB4397.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wa9P0mO9ca4eNrFCwCpGkWXNhIf1OGIhnJpDD1goENCfZJ1D7r8OsRfdMq2UnXsoZIJwtCJQpgMHcqW7VSGSEIdwnJ25Xv/2tQ7W09EYI5RrT5sRNyzpUfj0cNQtcg+pBJToFutNntGh6Hoe+Y6LCNK/UuPPCNH/KX7nirK6xfbbNCYh3E+N7bJrddymtQyEcpTkF5p4uqV/AZqvnuce3eAlnTyOJvk0Mj7CjR2enae0RpQtYER+NF2JFUE1huOz9zNRTt7nvXKCpgsxhKzuRZzdCUUXh7ugFEFeDqyV/qH5rE88AyYwUsNy/AMfm05lByC/4otXcYG97YjqYD+rPg1Ez8i3ahvIAA6yxxOorKGsXG1aXhHVZcTR5EMFejYP7fizqYzTyLyAK/atmxzKZ/kGrQjYtvBChbjNd5LQjWBySExsJSiMoLmRNw5Vx0kpSujWmKfUsVVRHavB6T/97awPVhiPA74aDHcIijrErYdNmuFMTBd8pkd8RtmtzFnP0EBQZhqQ0a/Xa+t5LJ/3Gu8fHaKhffksjftuT6UrqYSPTOsPmlra+FO6NX1C0g2g/3tv78jakYWLmzXdYuzTGkTzgAt9DdJ60dv6CBA7nLmN8KGNj5szYg8JOnk8rd22vUilzS57LMgedd3SyWg31Aczr6cVarvpxwKBOtHfPhsALv1orhO5059cbZn7UnKZMHYLGwSjk+/y8K3nyBFkgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(110136005)(8676002)(64756008)(76116006)(66946007)(66476007)(6506007)(91956017)(66556008)(4744005)(33656002)(55016003)(5660300002)(8936002)(122000001)(316002)(38070700005)(38100700002)(52536014)(186003)(71200400001)(83380400001)(53546011)(86362001)(7696005)(66446008)(82960400001)(2906002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kfoQ0F6DECuaHUrGI8fR7Q9y3R038/if8zxcIcyfJZ6LvPWDUXeEteL9Ofl/?=
 =?us-ascii?Q?aNQ/1DKlRfjWg6N1LnqqWS7/J1sPsDoxcMfxMSU2uHXSg5Nue4ripxGpxomo?=
 =?us-ascii?Q?sWM2fC3GmW8MSKuPy5OmjEpYLMKYMysUbu8zv+hu6MiLls7tt74+cBW58NSm?=
 =?us-ascii?Q?68fEBOf6KV178GMatQwO89g6OxyQV73WPW4IgAaQGZJzhaBb7Vwtost2lTSK?=
 =?us-ascii?Q?qdFQDv4ieJ9auFU9xCO6/F91mni5V6HGunl3aNKe9eLN4wRIIpxNiMYHnh+a?=
 =?us-ascii?Q?ayONOWuCcL/2msHyfefGqMqB4wz3hKpNylXOxA30Ilba40SOxGzmgSy9ogrg?=
 =?us-ascii?Q?7azYGo7lBjJx1XcZwmV1Mm5QpryQXqRapujgAvK0xR2WPuM1xbWJPvJAtK59?=
 =?us-ascii?Q?wZdOvQrlKetT1WTtOX1jhzQZoYbBjLSazostyvlrxZu5ZYRuni3TL04mSBUF?=
 =?us-ascii?Q?shYB/Z0e0W/tH14Qdsp+txbVX6eyQPvi2AzrfLh6m4HIeFL+1A2ZRn3AcOcR?=
 =?us-ascii?Q?0RFwkOM7dOHVe9k2F9AqO4Zx84X6ObPUyLt4D0itnuyI7T04ANWVesFFxrM4?=
 =?us-ascii?Q?HUuouaP08UeSXuUUd9eKB7eiJ7f3lS+wGYs9vKyrDliWbMeoGvusU7jZ2gnb?=
 =?us-ascii?Q?TG9b9sv5Oga6AbCw7RqhGFWcgjYN67qWR80348TmeIm0kxFEJyXVJWRMKn8E?=
 =?us-ascii?Q?hNqTfkrniuoYQ/eFnZqH1LR62xw5/q1ygbH4HlN9Lg/bgEOS7UeKviPC9Y5s?=
 =?us-ascii?Q?7wrFM4Wi8Wids5bxC7BXY5vaJU+XEIybhjLJtktRFMaj9wjIMQ4dVHfIdyb6?=
 =?us-ascii?Q?EKGIvzAk2PK1Vj5XYcEmzV6BmTd4LIHFVJwS67fZI7tuBjVJseiaeNA2Li45?=
 =?us-ascii?Q?fdRy4adLquplJkJUzRETOxMYoWXY/K5h7NS2SF9warzUeVTzdJagq4XKYDsk?=
 =?us-ascii?Q?lXnkjZhiBkH5weLCk5xgRRSrr8bEcDm8ssovfD1vEanKDQYPVwE2qomUomvh?=
 =?us-ascii?Q?w//2npxY+gtkWEtGsGsupfaGIWSQkShGgGwOua/J5dRZUk+ZV1Ou55AsZuFi?=
 =?us-ascii?Q?89OvYKYW+aVNf7E+JBkdRxLtI9GK0/qZ7nq8UrbT0BUrP+NsY6qeiAg3MylM?=
 =?us-ascii?Q?OaZ37tBEnIqosclswq0Hod4UjZ+Q+JLpYeelMQEWTncmOKmbw7cNAqXE1VRW?=
 =?us-ascii?Q?SiOQc+Uo7qNo+qfpVJ5g357Ke3Bw64UhYuhCVKNfyojjf1lhWn6SeMIhr8Pa?=
 =?us-ascii?Q?yf15UjYzEqxvmAw7DrSK2gtN9e9aIiNa1xCmNj0HUmiGhZKB4rV2TAqfdMzU?=
 =?us-ascii?Q?qKb+OPZrOyVzxyihXLN6FW7JEzkL3oXrHTW5nVFH3XpA/0lAvI2swp5VcDUM?=
 =?us-ascii?Q?x6o/NgiYjG99pB83XY3uvx/PXFRm3CTZ7vjtXnh3rYRMZZLz4kPaklhFKNfT?=
 =?us-ascii?Q?Z4uqlZerCNm2KA+sMCMmT3gPGCGU+ke1iuu+tsy5IOUKNZM5PAj4mXF+F5OT?=
 =?us-ascii?Q?BDkEVJ32OWORIkNPdGxmaDVpvHPr30BVi2fU0K6fO0Ja+ftq3B9N2pjXItcV?=
 =?us-ascii?Q?G868rGqNLEnBYvheRlpEkdNejBm5aPxeMsNhjIoJQN5hHztEutktV/KPwedj?=
 =?us-ascii?Q?jO+Pr2DAbM1pW/uOEGAvxAhSgzgrj+CJFQB13uHBBuqnJXsKmXwNQRyXogJn?=
 =?us-ascii?Q?GEoJkQQH08FzDjR4C+N9QOXbmycRjKLv32t9n7wg44UtwRTCcaW2jT0BMdtX?=
 =?us-ascii?Q?qhC//cxB5h69LNErmjg02HBkNd5rKGciVGOoptEAhagQJnuWAJzskO3c8jd0?=
x-ms-exchange-antispam-messagedata-1: XMRlxgtu8vsukASMgVGJ3sooLG6FVC0UXhQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51aa17f-e45b-42de-2408-08da21f3be50
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 10:59:57.8476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j6qNIf9inEaDQjDqpTXKSmZhlZWG6TliE/Zxzs9sIOswjLrxKimfmgO+6cI0J0dom7gPrsd2q1c/m1TR0KCmbPga5YtmQIX5CQ0P3G73xB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4397
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18/04/2022 03:12, Damien Le Moal wrote:=0A=
> +/*=0A=
> + * Manage the active zone count. Called with zi->i_truncate_mutex held.=
=0A=
> + */=0A=
> +static void zonefs_account_active(struct inode *inode)=0A=
> +{=0A=
> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);=0A=
> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
> +=0A=
=0A=
Nit:	lockdep_assert_held(&zi->i_truncate_mutex);=0A=
=0A=
> +	if (zi->i_ztype !=3D ZONEFS_ZTYPE_SEQ)=0A=
> +		return;=0A=
> +=0A=
=0A=
Otherwise,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
