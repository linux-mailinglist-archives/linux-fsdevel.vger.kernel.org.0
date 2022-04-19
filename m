Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1737650687F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 12:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350595AbiDSKRE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 06:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348636AbiDSKQt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:16:49 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C3122517
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 03:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650363245; x=1681899245;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=FjaoQ3lI+ebdcEO6lfX9DW74GXslC4grz4uRNLS13vMO6Stl/Qk05lRi
   NSROoGexyf5Hg27vHCnpXN1BaXqp1QlCHrvM0Ns3bwkCJsh/WHC07pdny
   ecTgVL/2br4jDVSmOlCE2jvQ15KLauxqFYWhj3FssOFcFAMNaqW8U+Sya
   dFx8u6h7diLsvUrpAZxgO24H0jyr8aAyf9UUMWmIe+APIK4y/CWAqqoff
   VXGH4wh6NtJ5alOmLKuBs8FJCW7e7eMAC5/qDC5fg4WXYeSTBiXWPC98g
   0j4MtwON+zmLcpfLZJ+j0BM/YmLk6XKIHqEDVTSL3/xaAenEInodV3uez
   w==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643644800"; 
   d="scan'208";a="302444537"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2022 18:14:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQb1TUAvgP1t2BGFIYDeNcCUaPOtl/nl9QlxLTI7fXiQCwI5fEV6gZzZ91F+bY4LdywQODKKk6KoNj2iHZL4/q3w4HG5lycLARpcCZPb/qQ1h7+b39McECQmLwdxCFyoHm9cgKTcj0hnvJSX/gjzqb9uUX0W17LTnBxOH0VEL8JIl8jexKVwh3gddvJ+FC7GjbF0crUqyrr++k6LwPvo4yiXIl6FOHqg+6qDJuEHGtsUZDFSmIvppvcl2VWimrzq4S2YjZQ4mgr+ML2SgHf0qXm8tqGml8SepAt3J0Y6LTR4a1ju3CtR9Ksy+I8jNHkhJSyC/Bpfr1gj0em5NfFP3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=BBkpEbBwFAAKZGvQL3vnGSBCSKplz6v4AuukQM69LZ76LC2pSnQUShBqjDfXHkDpLYia+sGsYkSlBxRufRHwU5YA0MvrGy0zrlVqLSiuEs7KCpjbA8gVC2gYIFgRgktszqQEpQt2zbwLN62STUlt0hgtHiSZbUz7X08zL4TZ6dCqqZnuJoAapxGdBSs/hEjYssEc8ctjnRmzScrdJcJBeX/T8OXCvo4qvocfz6bRW/WCitpG13/nnicFdTgSmah2a3v6cbL5z23VmR1jVs534LySpoSqfJcCmGNsWWEGwg1frSj+8hymWBHoJwBHfi0MrrPsDkK5LRbNMkgFPSIsaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=l+zDC+OEROsWGLspwSphqGntGqy1LjnaCatWd9OQViDdUW77J2nxeRVbf5ZmClmzTOmRgMUTSF9wleLbAQETeM2+T8P/DFb7Aig7E7pbM5FXgwTxyJHundVSL53uBXt+klmdWghGJGnlEEAcjPP+9LiW2hEmeBJ8h/PtFFkWMxY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8030.namprd04.prod.outlook.com (2603:10b6:408:159::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 19 Apr
 2022 10:14:01 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5164.026; Tue, 19 Apr 2022
 10:14:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 7/8] documentation: zonefs: Cleanup the mount options
 section
Thread-Topic: [PATCH 7/8] documentation: zonefs: Cleanup the mount options
 section
Thread-Index: AQHYUsFZJiaiK+VVskexcFmMHOLjNQ==
Date:   Tue, 19 Apr 2022 10:14:00 +0000
Message-ID: <PH0PR04MB741600F2A1E5FD7A0D10810E9BF29@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220418011207.2385416-1-damien.lemoal@opensource.wdc.com>
 <20220418011207.2385416-8-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 783fff55-a35a-4b7c-140b-08da21ed52e4
x-ms-traffictypediagnostic: BN0PR04MB8030:EE_
x-microsoft-antispam-prvs: <BN0PR04MB8030A504852D45D794C297139BF29@BN0PR04MB8030.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q/S95q5DxqYGymzJ9saaYWqIlMKA68e77z8bVD60krEFZCkzYFHew7Nnvoui1vl+2YAM+odisNgtdflEeDwEe5eWDlHx92wolyZDyE5NgLxy0n4aWHH972krabCG2isqNGuDitk3zB84x/RaHDtIMa9z9/jJNHoP0X6cwlS2eYpSlbtKQpeLppexhDJ6LHf1Qb+qPuuGGHgGP6BxEJzBfqAhz2Py14xy+mBT9eIHUkaPfGdxFwm4ejGSmfdnL7gmTHZ4WysCm8GyrR9vK3NwfTCkS0YcXNLrXAqd9tAsv4ztmo6YZmhgAbc8mXYDlMXbpovcREUs+JTNvRrNu4CS/XZ6EPqfw0WE5izMncEHT5s/KyEVZ8mCIIzwt2qvRGdTY8PzJC2QbenErGnOO/Xv6CQ8xhEtMkrXmTVh4+bVTOB38AKymVLRswv6GOoZtUfSMrf/Tesb1oAgNahfSJD69n9rgjyrCWKw3uQbTOdpl4Vb1yhSt+LPEcybPoTzSs6BPcZAjAPdZNgMhkymqsTVP+ts0ZNMoimolMtK+E8v4VuPfLwuvERQpVwxYNGTCbKhnBSSUt2gInW5ypMz+3jvA1G23ANsdoAAVxTdFNulGb9sl+xUvt50YiUiOxje1nHUc2Z+58lCZm/N00wkAIp5W3PRL8J9IZ6OcMSRo+Yh7JKrvC0t8UArtKVrDipwVTR1qtbyDVlEPBl2L91V0e7aRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(9686003)(558084003)(5660300002)(4270600006)(52536014)(8936002)(508600001)(316002)(91956017)(110136005)(71200400001)(76116006)(82960400001)(7696005)(122000001)(66946007)(86362001)(8676002)(66476007)(38070700005)(66556008)(64756008)(38100700002)(66446008)(186003)(55016003)(19618925003)(33656002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2yNDexjPV8jeAcMVjK0OFnm4+ATyWT6TkB5OvJhksVbykCV/f1WytJxnQQgT?=
 =?us-ascii?Q?BzxzjuadnWp1peeWe7QuNFMYX9hKCXSj0VEu+rpvYXVvrSz3/ns+GMMX4uRQ?=
 =?us-ascii?Q?btA9osog5Pc83w4ow/9eA7DEBH9k2pmIqPqWYbm6TeDY2XIUoJM9YROhHjzG?=
 =?us-ascii?Q?MnEz+LNGn7L8VZCDwYaoQvPviwnRhqD3kBp8fEt0hmCGyTIAt0R2izTHKHMu?=
 =?us-ascii?Q?qqH35s4WY09MIs1Z4lyoesdFYo8B+Nxx7XUq7YtBNLvC3dOFEPc+R9MFMZSZ?=
 =?us-ascii?Q?g5dTNdhSWgJ2mWWYQq64V4zm81+4imPZ4GdpnIY4vj7hqWiGVsu9fOaOSFvz?=
 =?us-ascii?Q?QmKD+dtUK/f3XNx5gVg8BEqgCvjl1ofzPYoCV+5qDbt8PE/wfltjN+ZKXAEI?=
 =?us-ascii?Q?Hv5HNavx1YeZ2OFph4ikG3KcFvCc7M+mpw+Mgr8neOY7hOSf3AQGXeCtOFq3?=
 =?us-ascii?Q?gVlrpDBqdw2OcjqdqiVqaHycPfSsc9sa+eT4Q9HJcgbxSM0JL+IBGPVk3898?=
 =?us-ascii?Q?PlX2Sve4bO6BwCQPOsPGIAOj4yZ3fvhvMLfQHy1irxFLWbZVyVX1VVwx1bLa?=
 =?us-ascii?Q?iMWHg6k71IYJopoIqc8rtKki/QQdoUFgObX3J4oubzqqf8tY2k/z/pKT9PJ2?=
 =?us-ascii?Q?kB3SPz1+4rLPIorbepLvoCn+YX0dJQOWKpww7Kjw0c7RPtdnDMDhkObResYp?=
 =?us-ascii?Q?EJ5+mEvrw7S9NUZvs4XrGvxZnOdeSlyjaiHEP+RZH+cen641/CRr/b1nKl+V?=
 =?us-ascii?Q?yTmFrtw59FBApahr0vF200pLXc6pxZYWTCMknm+ESH4m6zDraL2MtMy5gsgv?=
 =?us-ascii?Q?3oQM2RK5d2X5jyhR80DXS2fXjgOIh2fG4UFJda+NdkioZSWSpZ6do4E0nAoF?=
 =?us-ascii?Q?H33WAnuD6ljVkkJRynkcLkYmpX35GC+q/jgq35ZFIiqYX9rUSohE4MlJCi5t?=
 =?us-ascii?Q?xHt7wdUEMkiKt6GTPSXjlr3DRKVmVRmCtG/YAHAvpgnuhBQdY5yEibtH3Axd?=
 =?us-ascii?Q?WTkrBLD02ph6sO/7ji603FGDKfwaDsiDNZBMql5KDuAlYaNUc0pi9XrnkhjJ?=
 =?us-ascii?Q?Z7PSk/FSAniDf7TBI32MZyCmt3T4BIoGuqav5DN7FRiBzUumH7GKB/YN9Cl5?=
 =?us-ascii?Q?DpW+kKN8Sj4Nsx55SyV7mHSnumvHFi8TnpGu55F+oquE8N3lOX/yKT8MirZa?=
 =?us-ascii?Q?B0nDPqEmfxu2FbY8c2/SVNC3Kj4lfcYx1PwJ4OMjW8uojYg8elbGEAk1BcEK?=
 =?us-ascii?Q?qkbkx7GQ19oVYeHsqoJMIwWjYOW0DvpNr65v7s5v+YjwiQyP0KePYS/HM7Bk?=
 =?us-ascii?Q?XpPs02AN/6LPj2Azu41lcc7smnv5E5K6yZT7jMxSQ5b76dcQUt66ZtCCmlAc?=
 =?us-ascii?Q?f7f39uyQyO0yUPB3Vgm9B7d3DwR4ukXoptuW5hO2lBkq51TY8hfF/lrmVccw?=
 =?us-ascii?Q?XR3jd8Pvz7GhsbiDKlPcaVhnJ90e6O7ARSnQjN2sjUoUwiOmKV8keKpWDXqc?=
 =?us-ascii?Q?ebv4y5dqI5DMZwN1YbLuEuyHZKqrCImNV6jEusa4dykBeeBGnPoKGyy11DKB?=
 =?us-ascii?Q?Aj+Q5MhTmySo1lqU9D1WGnhizGxP9SWlFR9dIaDiJnnW6jE/DVqEkur+xfnC?=
 =?us-ascii?Q?JydmsGYMizrkEhNAxb5ZPMaddR7+F/tgkE7Djxda48Z6qSd7R6gCZj6qvXHr?=
 =?us-ascii?Q?P+3pMCSB+Kf1lC/Px8AibnAYYrU7ZN6EOHynO7TPLuKR4+2AJrPTZjNxM7pl?=
 =?us-ascii?Q?M8bHDb1TA4PY16S0C/PQ27SlP8rZtYw0btWPyG2CRjU/OZj5CI3d80ThW8jg?=
x-ms-exchange-antispam-messagedata-1: rBalaRYwtT5YnwY/pP2qVU6ZaIAzeephMFE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783fff55-a35a-4b7c-140b-08da21ed52e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 10:14:00.6428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w8x8UGLNTv7i1i/7EnyHXOlOBeElCu5hL2tJ2BhJf90LXzoKdRCRSq1cI4CuXnK0CqvKJ/1mdx2ah/XG1GTlwP7SUjkAE17wjfJwOTJAtlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8030
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
