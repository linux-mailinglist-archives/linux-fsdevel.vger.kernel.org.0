Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FDB50681D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 11:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241894AbiDSJ6F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 05:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239579AbiDSJ6E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:58:04 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1FB21250
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 02:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650362121; x=1681898121;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=aoBI8IaHcqEdW/+lzvIQQeU3KqetT8eeGsaJNadZCCs4DrCvRlZnI3dZ
   fqazzjyF+Z6qEra6l6uGFgom8OzixhmESmS0+4Bt0q0XgpMzLcVORoJUr
   4qX9jITHMqCy+mzHUIPczV+OHtYgNABXfMjAOpNMagV2ShintAf49h0Qk
   Ev7ySYu4fTTRL+8N3pGS9Bl/3gYKWzR/k3433XYCDbsJ8OCY20f0oU80g
   eQiya+mpKSaynKbycikjwDsTV1ff/a/tagBN4VfB9Oi91f3HHOOIq895W
   EdsCikVy2YUKHDg0ctmPv3M2cWLFjkqaQ1xlUnKbee34F0xlospwzUO6t
   A==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643644800"; 
   d="scan'208";a="203113978"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2022 17:55:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wg7Zb8pRzB+30qXR6Y9KPtrEbkv6jWoM9YR3UFBq02z2aIpMhdRRBANeZKKxTDNEwcrO7mug+J3ovo77EQCJoDv+BFDVBG4BZ5l5vybURdGYlQowMANLjs/etwIfUjcJV0pe0LPptgGcqFm/oGjGc4IhXUUcs4AMoFWevMIDAxhTWn/Ao7S703jrUdUo0mmsGeephFGCkjDPttQt/mw6D8u+r2+1/7GBgh9zmfmvrIC3DpcVmE0DEtU0TZ8ZnGCsEHKiOoUj47RAXE1nIPNBT8ny998jm76q05ZZR4/iUIgbEVP+VhkRtpyALxUe9OgY/mbFxhkMHUUA8L9OC27Qhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=C6EKbUgKEB7zgSSI6qzKBXWGQnm1aRIAts3V72fayCN4LuJJg3GyHph/PvRPBIDEy1gVj5H4Btdrn+dZLqKtuESeggz0QrLH64bPzeLpEt1LYGUDIgtmGzjtSpNAxArUeGSa/Apd85OYEBW0rW/3EsG3L3v+4LtC03iMxdAQHrf0mGveCk9etbA0ZcJG3rVwmxGmNTWLW3XLKaO5zX/7s/lHCD/rydBfyJbMGBAMMfYoooRGtblZw5m4F75WmpPYffgKKhkQikALeNyLIop8LgyJYDxlX89Tn6Iq3pp0P3mdhmcfqn8pm7NbIh4C+CCmXkBqySmsiBNXto1GZEEcKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Tt3B+1m4opQgxHvpkbDax4EhbPew1VdcCc2lzq8Yc4lAqI8YxSqf7WXZ9puFpwaZ3Nx38lwCDddbHZvCJdCWD6NK/oV9ZTSADjpUMdtkxjxBrm5AJj9thhthFeyzE6frqzlLcIWcNuezhdMGfIKL/ZGFancqXY6RCal1/2T32Oo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB4645.namprd04.prod.outlook.com (2603:10b6:a03:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 09:55:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5164.026; Tue, 19 Apr 2022
 09:55:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 4/8] zonefs: Always do seq file write open accounting
Thread-Topic: [PATCH 4/8] zonefs: Always do seq file write open accounting
Thread-Index: AQHYUsFarQ7QbFaVrUiltY5ewAfcvA==
Date:   Tue, 19 Apr 2022 09:55:20 +0000
Message-ID: <PH0PR04MB74164D0A5E5068C5463AB5579BF29@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220418011207.2385416-1-damien.lemoal@opensource.wdc.com>
 <20220418011207.2385416-5-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a73a02c-7e96-481d-51d8-08da21eab76e
x-ms-traffictypediagnostic: BYAPR04MB4645:EE_
x-microsoft-antispam-prvs: <BYAPR04MB46458B7B580150038AB02ADC9BF29@BYAPR04MB4645.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GlJjLLbnijzU8N3VWH1poYJLqc/WxuLGhvtp+R+XhXi2fw1CKVlc7cTMrSpoI1jalt4K0BoXOTuS2eouUA50vX0RwK+axPi7SvNgZBG1tCl9OiZDzeoRkST2tjaTkIaYBPmWR7uMpENqqmMqt1JkfmnCbIThn1lyB0BwHYHONu3xObvwKk2rh9woqOWxXw8xiocCXSQxH+7uAqQb7PoVWthZizwNwfWeKcZ8jU3jUSh7/8InAsrpeKhI74AHSqyN1Z1N3rcUpcAFEh0JBRDS4Y73gIbnP3ugvkD1iwbLrD69UJNo9w/CFPCnuTBWSFrbMCFr8cV9g9D2wTpiibKFSh/fAgBMEHrODX0ruL5A1sWeikkvQE2IoTnMvISk4T3H7swvTI2AtlhHZ3nwjpK/fM1+LWJmBVSOPWod7/VAphW202o3ohP6tqas5bGTEQpNsJukftXLQCmHC4VqnQTs4RMIqYrNti49BSdqUVxnLGpNxxayWpHdPK6x3a0HYliuK8M6UYkk5+L6uTXkAbUpuxl0XsBUFFoCZnHbBrN0w3Loss6FIIjJVnkzQ9cSXEO+HBcijCZmob2BbwdFx+A+9dUy1izQfmSAEA6D8z0jEOhZ0SeHJq8RUEw/578xkaSpuQ7GWBcuWqp5jvX3J1+4jIEpescTpDkgxfsEaw4ujuEPa+x3/YnM82t1qgknSJenJ4E0UC4cuVKehk5QXNLcyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(7696005)(86362001)(316002)(52536014)(122000001)(4270600006)(33656002)(66556008)(38100700002)(8936002)(82960400001)(9686003)(2906002)(110136005)(186003)(19618925003)(91956017)(38070700005)(64756008)(66476007)(66946007)(66446008)(8676002)(55016003)(76116006)(508600001)(71200400001)(558084003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i4P1+3sgrw7mfJY3xXKhc1nlDvtn7J4W8JVBSv3vQSocyTPvH5H6UhSnklTs?=
 =?us-ascii?Q?KjGZMSTTvST4cgJbp9/d6LyNFG7MGBLARiptvvFpeN0uE1CU8MZ/1QFX6d6I?=
 =?us-ascii?Q?lAJ4ldJr5sGz1+YcnAXDY7xiBOfaAeVLfhrWl0GmR4QD6M1x5QDXEdipiNlN?=
 =?us-ascii?Q?DCUjRqL1uTVM1V1JzoM9V5wghdkuChfPh5Q1o3oqaaX6J5nBS7q3mQu/G7iA?=
 =?us-ascii?Q?4GAxA+fvCLCKlR66PhJwMgnxolF1lmqhGBd9aWSZvri+ICnDxemxIMvQDBex?=
 =?us-ascii?Q?HscuKixJiH5JNazS/o0thLyrfnIgT0rpYGkIVlKixXsNMLuEaKL14bhdhHXZ?=
 =?us-ascii?Q?XqZnzZmA6/4AuvXbdgQRz2rNJgIL3Bkh8nPan9h1lBVVTrDCxqa+3LpKzXZn?=
 =?us-ascii?Q?3Z0jZNsLiU5odWwvFny0cBBcTcbY3DtJZxpWADTMubsLl9h9HNidQeQtTBD0?=
 =?us-ascii?Q?M0vbkTutQSh5uh3O1Ynpv5ZcR1IK7VtkgyxYpL6L+MjSMj8lyna9YcdJmLzu?=
 =?us-ascii?Q?S4oB06YRLgcbMdqrJm3//n8F+njmpQYsa70pQUsxj0d6QUJ++VnErO0+LOqi?=
 =?us-ascii?Q?g0UMluoveJquirZgoIFszB1R4QMXB1L64jXNSPfgcLFYdAoFm4dikZ7mMGyo?=
 =?us-ascii?Q?7ToGcMJtWH3Crb9dP5Z/+LKCC0Oe8Zhx1pyL9UxpY5cbeMl5FOduE1nSZT4L?=
 =?us-ascii?Q?CiXx8N3pRNrDY62aCu3ZkPnTSqW/Kk+/u6wKL8ltiD5FZNo4e7GLvPf24RSW?=
 =?us-ascii?Q?uWbnUVoa+ikn2UYQUxXLyzBo/xZHpkcYRyPPmfFo938/zKWCbKSATja1mVXw?=
 =?us-ascii?Q?JF4xs59OsC5DVfbHGd2FB2qxoJIaK9lHx+XHY+cUo/wqQmOCq7Ya1ZT1HWKb?=
 =?us-ascii?Q?asCR1sG1nxvGWze1Uk+VyHyqQphNK/5ItpcD2hlksmcImtz8U39SLZCCMT39?=
 =?us-ascii?Q?gdZWJCCWI7IRdqexLr+Sj5yzun2/XDV5edp/7PAFM2VspTUO7Rb71nB80y51?=
 =?us-ascii?Q?fcaMfe5JUWxR73a6an9EKe/hp48opO+9VVeskSst4OkAd9MY3Z+54CNO9OvS?=
 =?us-ascii?Q?cLGhdK6YmuPzSLpZ5pm/yYCHjUlU8HZYvNCKA7Gawf8Wa+Zvxw93FvYIgqMh?=
 =?us-ascii?Q?4Yx0YT6W8GdjZxZkH9415btg7HssBKtbHWlbKssNritMtRzz6AKxjRM7A03r?=
 =?us-ascii?Q?VEhtHLk9vFju2+PMDApb+1vlmIKqdIBewaS0li2lFmIDEq8lSmQJZigx2XPH?=
 =?us-ascii?Q?CsINq+6z2tMGLCZ5LGHZZHSSgv+GYgWM+omTB7zuwnx2mEtqIt/WrK5whCMZ?=
 =?us-ascii?Q?j+l1dXn9CtKbmpfq9Tr5fue6+z4W0bW0SjcpspPqYlfBuVgpX/8r4/q8NeVG?=
 =?us-ascii?Q?hy3l1WNlo64D/Xt0G3S/rMdT8zIRw83ZtQBchUPywitLu6WUN00+D8PY2dbR?=
 =?us-ascii?Q?VMKeB7ocTma42VYwaxId+ABNWOvAnd10vjno7HUhPY4hDklPV3WOe4k8kJoG?=
 =?us-ascii?Q?4WSyTTknoa1LRxCvUTJnUr95GrZXhMXcAVegXXpTOId4ZoXpSpUsZepKcBQe?=
 =?us-ascii?Q?RJyJJ3RqM/OhupwbaAK9MNriNTzn51Ez+6byxj5VLw7Xm8bUbT3+jgr38wb3?=
 =?us-ascii?Q?qU2H+51/CFKBlWRWihPbvS7Ux7pbo4J5Y5EF6xL4eEShsjxMCsm7DgFHSypS?=
 =?us-ascii?Q?Nk3Ub3rf1UymjoZ4Ik5J0sum67/eB9Tnz/wRC69Yg72ydWXUstewOC1MV3Em?=
 =?us-ascii?Q?3G0zsiDRqOSGCTuMAUx5sJ4Y4Gt1ptD9H1STjoAQbcoR9VARZoTGE44XudRV?=
x-ms-exchange-antispam-messagedata-1: 8GZTgVBVuxcvEKXsQ+vFg2TYuNcrf5aaBak=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a73a02c-7e96-481d-51d8-08da21eab76e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 09:55:20.8763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jqabbc6dYbhQp5ro02GCGldy8tdr0i0BUIxgd9tukxu596eb5FX2TYrbuk1lqIHsAsHq0q0XseMv5CyoqiTJycADHRew7OhNSJGLCJ9m2As=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4645
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
