Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA3A56FA9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 11:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiGKJUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 05:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbiGKJTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 05:19:15 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281E051408;
        Mon, 11 Jul 2022 02:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657530732; x=1689066732;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=O/Fyt+7fbqcf1JgTVGJ6msuOtiUinM11vgqDHZD8sbtKMc67Lp+1pRaL
   XxvBrfDYdT+jfalBQsUoWC7hfd2Bx7KZAfGz964UZ/6u4RjwozrUFz5nG
   PHM7xW7gRraZNgKaqRE5IMKBRUznwvlkf4xqI9zYKIrI6ybecnolHrbKv
   KrlwCuIOynBwk/xf896P2qI+JzVmoNn9KRWKs2JnUXfDWZwTtOLYTHH9z
   nmfhDNZZLQMAatUk2wL38d+T91m0BUkSTZYEs8ZZF9vd3gHAzikCh+wk5
   3QQWpOjxdFzBWx1KPcQLYjj6aMHfz4MYtV4Gn+mLsbpcm5GiUggn3lCIX
   g==;
X-IronPort-AV: E=Sophos;i="5.92,262,1650902400"; 
   d="scan'208";a="317489907"
Received: from mail-dm3nam02lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2022 17:12:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIz+t5yHgjMs1mvvcMVYZJw/sJCzMhpekDZ13BDp+ijlPU58u8EFSJxblJg7kHcqdzLfTn2Bypoia5s9khHWRK8FabVaN8kYM6Zv7h7w0vwhDpr8wGcelVLpjlq4DKmeF1J+xFn+CdzgfSOjlVYn/uEDdJXdI8TRLhSiB6WX4aohYzOrgzxruXLf46W3yeJnWbRv14OZ39WHMUCIojYmM4eVmk4VTfpa/3UuE1PqgRaSU1dZhhMIcMBXyt7O9myaA/6spXhb9a2rwr+3QDU4e2p3AegHD7PGwn/3gfv6CyatiDU5UbrWSt+Q0QgOqmuMoiZ0Wb6wUbnBdlKKf+4hxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=gZBTlynfjhrYJIDZ6Bz2B4FFL50wQO9Sjk1/QW6Kez3zqoBdldIz0zi6NKDYSUI8chyYBNf1Q9l3eETE6kIXOVSP37Tsbhg2nLewNvEvp7hpJwrXnsgYTw5q8sQn2J1tk28V5aDui7aSQ9Uf/EMAD7hycuBY5rOkgaeCc+uskFiS/Esd1ACRhCWGgKOgnNkLVjSWPK8lSxuwsXF8zmCQtyd7aUUs/XXpp1weMJzV+MAEZUIJ2nL3HwdbMpiOa7HKl/iymqpikaHMHM5gaCUlnuI75wHyUq0Ka4N5b8Asvg6ZFQDTmHSO0yA3AwCRK/iD8Z9Bs16G49r/EPGZ+BmXGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=zRiLdAShFXVhBc/aowlk7s+3DaM76QR43poAtPPMqSaVEjLWz9low+3LrvWhS+PGIkdJyXrH1dJysZ1u333TmR8l8dgkYHp/gMCs3jErLYLY63PqzQw6ttFVyTnKoqauWT5rauT3hUzJO5saeDr+qQQumQUG/3SFHz1/qIIpZmM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB5297.namprd04.prod.outlook.com (2603:10b6:408:d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 09:12:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%9]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 09:12:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     Johannes Thumshirn <jth@kernel.org>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/4] zonefs: remove ->writepage
Thread-Topic: [PATCH 3/4] zonefs: remove ->writepage
Thread-Index: AQHYlQZMqTk3YdLteEyk3FxBUYosFw==
Date:   Mon, 11 Jul 2022 09:12:10 +0000
Message-ID: <PH0PR04MB741619B1FC12748A889EA8189B879@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220711041459.1062583-1-hch@lst.de>
 <20220711041459.1062583-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f44b253-97c3-4c8b-4687-08da631d6fa7
x-ms-traffictypediagnostic: BN7PR04MB5297:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V1S6NqbV2x6B8j1HWImGPCTj/zpVsw6Bt7i3IgiAjylYQQp2TV0zRj5QwIT69pVZZJ7XfCmQGjSNAP7BSVm09hYS67HidKTsU+vPIiHGm70qDQsokT3eo9YVhgKDPgIPMhVromej02JhK1XwSNwvlBVEyILeylZnkdl8D+eGZzp+pdL27HazFQHlkxk3a2f6uYpWoDmqEqHRJbUa7L4ZM1SKSF4MJz3HTyUZ6QwbAdIIwP3vc0sjZjtiJvWWdNqrHjEyqL5uPk67E9/x8aHgjcZx0BJNAuGVoOQn5e+qTPgSaG1WbKwswLVEt4JEsGXD5zEjR/N521TSeoRMa23FNLfQfkfezyh/Q/KThN2f18ijSbZudJ+TP3gYsu9ALwNrp+guA/yPsOmWPM5EIqrdBYYdUyXLkP8NWWG+Xm2x2CxhHYUWQ01fsbxGg9xkWQ8eW+kpLJpiTZ2CXPYC31xG4h02k3x5PrWRc/+pxLogvO7nZFdm+9fFQBmzH02Jv4N1Y+rDKdObc1Guejg+MPD7vm9PT8p1VuJuArcZfTXMBqS7nBUtVLnHh4HZ6KAvrWl05DuSc9fGPWWcYAYyqqtx5+Ogqg9oHDzEOk14D9CKLDAvC+BXyvV1BEANAiQuY1F8TsdRwZ5o7Sft9qkZtYOLDYIXGmuUu2wXSM0rYhMEFC/E9bULRj+DuKPKD/SpyT2BdbcdI9wI7HqhU74Sej/UIEUNoVn1+59pi/Pdo+Fzx3NO9u7kt+xGhSyAGSYYBOnEUvRCar7fY/PEWmXKOrtYzqdKP0WT9EsuaK7XAy8OD6kwMGAwLd1L7JI5ODrsMVFH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(186003)(9686003)(4270600006)(86362001)(33656002)(55016003)(38100700002)(6506007)(19618925003)(7696005)(558084003)(122000001)(38070700005)(82960400001)(478600001)(2906002)(6636002)(8936002)(52536014)(76116006)(110136005)(54906003)(8676002)(66946007)(71200400001)(64756008)(91956017)(66556008)(5660300002)(4326008)(316002)(66476007)(41300700001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?li/p1wDx4F/MC4snqPX1XsgB9HzWf1nz9a/Qygqb1lRQ5wEejtPAVoYaSRhm?=
 =?us-ascii?Q?tQ3OjCGu5dDWIK3i9ICVshs5Xu0jG0o5HR7wY0mRLbGiDcrtTk+0ytg7kOOZ?=
 =?us-ascii?Q?AC3MTuTSTNcdHy1A41rCvAeT5F1i8ODjCIx0w7rd0KOKdR1X8m7ug2yz41tm?=
 =?us-ascii?Q?C+uFDpPfum22SRwhxznSfCsJtNKUk4Sl+l862+ch8dJzQ+x/NX+wG93Z90LB?=
 =?us-ascii?Q?rbuiUyUgpnnP2A0EmBWAPURpK9zkhPYhssGjLcll23Flv1O7zl6ZQ3vkpeHt?=
 =?us-ascii?Q?OC5fAw1wcKVweFtBLI9z20s6DlDGjKZ+puaaUyhOfMIxXNId3R08DOtt9Xx5?=
 =?us-ascii?Q?+0UrqJepwK937PtVsT9WJOqkzbtRf8H/CPGwUhnO9w5MpczQPGiSiSWktnua?=
 =?us-ascii?Q?OZe7pnwauvP6gl0rtMRV34Iak9+XyVF0xFUFItkHGWbgPuPHPuWDslb7LQ/Q?=
 =?us-ascii?Q?2m0zv+yJRuPuPACRw5NS2GFwngCP4CvAiz/gv/sW+P2Tu3au1Ka/hjwBAbx2?=
 =?us-ascii?Q?4wz5N5kj59eVeSWO/1l1288VqbH8dG0TzHm7YS53Yj4VxCJcGiF6T0lcodRa?=
 =?us-ascii?Q?ReSH2/aTzECTbbwMpqHUfz53Da7t2YvOJvI9/TxNp7Mr/1wLkHr33e+mVyOP?=
 =?us-ascii?Q?zD+WEWk/cUZCk1KJc3m6uC23SC8oxo+LZ2WdV2khZnO9YESIUGOzDH5sNMBx?=
 =?us-ascii?Q?5h5hmAO/NRNNalmGtQpOHb/QnM9crFMyNa4/89+8Jzo/c3Ba9/wyuZZZdarM?=
 =?us-ascii?Q?hEaPq9sQhyhFivoo1csg2Q5AdzevQXVJjuU/yPXF7+yxjmArCA65gPsN/2BM?=
 =?us-ascii?Q?Y6Q+IdlS+nloe0PpGKaCL1VtBxEHf0Dyeyl6DEl6Ru+/AIGP37fzhtAeIgIW?=
 =?us-ascii?Q?669tPdXlOJNJ0HG0JjAHcr2xZN1lrxCjHEVRdH1k95UH0nlaEIqS3d44KuQm?=
 =?us-ascii?Q?2lVaBxyA/jwisMb58CVtlbo8URFKer7ZRXVtQgn64GKgvFbiim7BcISed9Vw?=
 =?us-ascii?Q?zYlJ9CWmBEZXKTBWyjKT6hSiHBhApMHnm+H0XTkih2EU5pXzXsIZ+n5FwjOZ?=
 =?us-ascii?Q?rHNYbpfDdTM1v+QKQ2h50HJ9W4K8i4uv8HSAXdM1CfnYqOG6fQLRrztTCSvL?=
 =?us-ascii?Q?bIHfO1sxbhBHLGDZbGWWoO5dJsGA6Oq549BUyFdsi/jfnN0da2xoh7m/XmLj?=
 =?us-ascii?Q?hp5//f+cbIvPWhakTOsEwGtfi9oU0Nw3PsdJZmHYVALWoehE2tmz/ZR8icTc?=
 =?us-ascii?Q?U0En5IegjlpTUYdXRqmEcufDS7X5P5Rf/SJ/9EAPkJ553xpCCG+b8nyAXOCw?=
 =?us-ascii?Q?Map8GoS9be61MPFWsE9XRnrM3uwhCyem8Gq/N/lu9HBdDsFWN+DrwVDo1g9q?=
 =?us-ascii?Q?AlsTtKet6S5hawCzQItVkPpN5zqYrRy5WvKRn5SHbn5qiXkNwy8xjCvcrQ2Y?=
 =?us-ascii?Q?DBuuwLAbLSBjyr98cWtR8sGCVqM45/YWJn5Pn71VRyDdJKGFDw1bnl0Rk9X3?=
 =?us-ascii?Q?hpNp8KEpgbJUzQChaj4CopdQwzkY2xdqLPnyq53zspS3LpIcrJKFVOfzApAq?=
 =?us-ascii?Q?7xjyGiQLih27mCxUqnl07VHQiZCs4adWp1uAOkHjTEX4mI0ZaItuVK1k6mJd?=
 =?us-ascii?Q?nQfcdM7viqxiRE0Jm3jSpienrZMAuMPxUmaIrsx6wDhCnsIkTmOET1vGfUzC?=
 =?us-ascii?Q?A462QVl9LZxctXgNWqmKJsoICsE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f44b253-97c3-4c8b-4687-08da631d6fa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 09:12:10.4469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AiGNdUHPpXkQE+mLWZtqfJVhUkNPSZY5Y+ooaC/5iPodkgTcv5BmTuJJ9FL6qgqnyWI6g2DUH9hmq1UgyGV4YWaQW+FYgjfvVtc3NYGa+rE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB5297
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
