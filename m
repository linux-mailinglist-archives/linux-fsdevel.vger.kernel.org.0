Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8E92D0924
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 03:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgLGCMz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 21:12:55 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26291 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbgLGCMy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 21:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607307174; x=1638843174;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=akFaetfzQgV54mGiXI410CThk6dQk/qaJX8gp5dBPRM=;
  b=SCJ5CR/SmzNZcT1quTfj3PcWEjv6Eo+Ozptv6o5pqsXSyL6V6s3Y3rV4
   8DN9avmWf/2ohJYY1l1QATgRI5kSOGFgDPc0xMDqpaGEjT2NVIHxzX6P2
   4cRLfpcTT4PiK0768pffL9n3khgEZIIQJScyxYcMx6s2eYoWUaTR+SWFT
   /lqHXNdWsMJX3wLydN8s/l2xGuoUEBmR5OhozHo24R5GG6dk7SJVCGbYV
   7jBCflXketUliXvukcS3HuCWVSOwTvgmZpL7kx0ikunA915p12Wrot0xd
   /ewzYwvwTTjJfXf0PmMILtCPnw9hxaSvIiJAtgpSMSe3prJahcuAZDRmj
   Q==;
IronPort-SDR: CNd6K2UMHq+zc8rGepITNmvvJDK7R0XWwbbcGmLJ5Zas/znjZzkFOqTX/wLBUdTH9eCsxTn64F
 Zxdi9xToxFXy19yUaaqC0+Bw3UFBFwuE95yDwrW00peva6dg7xgyAZJh+PDsRbwKMqvP/Zdvhy
 LfCdfV3ek9R+pMhNHmoF4E2vv2pmL7X4AMS5dqG8Jq+O4R3744EHFYARqWFXFWCghhcf0bnX16
 YZ2pfctjF+w0Eblq3bDaLzVI0gl0Q6kLAa3fjNfyGG4/XXzFGsXM8kmjMwd1AAcsLaW8q0DYMD
 xTI=
X-IronPort-AV: E=Sophos;i="5.78,398,1599494400"; 
   d="scan'208";a="154527765"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2020 10:11:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUq7isVoh0DPZI8pcoGO8FtD1WJvA6UDjLijMUUu6t/0RMDYTbX61yuUQ7CwNxEg1yB4mWe5i+UXd01rIZepdqhaRLCpK+0CRgMnCzPokeIqjhBcP29EQXCKTiLuoxvO0fxVj3glQakdricgzoc8c6Tw8R/lY7GHUFNDuTmU7E+3pc6PDuFLAdcuVhn9p6vdyqAucAIdlsk2KEFWyLlbdoQj1JH5n8FqoogHYotAwJshomgpjGhDQeU/nsCOpJBydooP7NDJ0FYBZvnWDMtcSuMFI+lh238hfPUs1wrPUqLZ0ZyIc0z/2iCMhOm65xabsIeoMRhiT03lxxkwX8YqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akFaetfzQgV54mGiXI410CThk6dQk/qaJX8gp5dBPRM=;
 b=Zrl1EeAqGTSvmgKWa4QD+dGcFXBM5/SN+PKsDsFcs0R6XSaOo8LQ9eZGd6gZorxHs5QkZ81fTIojg098fJr4yl00WIk5yFpSZvqPz3kRisVuAA/gS1pnfexz9fmeNIwVIbenyjwKYQTSrxCZ4/OIgU4SySsI2H4Xior1Q1nRHs/WY1RvVtajEt9tS5rSXIhSroDJyvEjnML5Mg/ftvM2xNpiyM+VMG9VDvef7368xdBdzIUqPJJgxzaQknZy6F/7owGx5l3VH8rkwV2S41PcC0Y0y15bNReczHoI6d4Okhpt5wPoNfbjqX/5rEVCkyW34rT9waVP8NFQrDLlvSAlug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akFaetfzQgV54mGiXI410CThk6dQk/qaJX8gp5dBPRM=;
 b=ztPqunOAvkat303ukNo6xRE3Fb8WzOf9jj4fO9Jp/L7Hw3qg4GD19lRRvOUTxGmsvX3dBnpG6E498lBVqod3Qcxi+2+71NjTGcaIcKzU8fF/y0WHsBWZv8bt/36+qgb/Wc3hbpZJBiCc8mpfeEznrk274Z9XnMM0Oozu4XOMuDo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6024.namprd04.prod.outlook.com (2603:10b6:a03:e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 02:11:45 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3632.021; Mon, 7 Dec 2020
 02:11:45 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jack Qiu <jack.qiu@huawei.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] direct-io: fix typo
Thread-Topic: [PATCH] direct-io: fix typo
Thread-Index: AQHWzD3UcVmQ8SCfIEewdlbRAc8+vg==
Date:   Mon, 7 Dec 2020 02:11:44 +0000
Message-ID: <BYAPR04MB4965CC0BC18C63EC91B34E3786CE0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201207030634.23035-1-jack.qiu@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a1561d1-d711-49c1-1463-08d89a557224
x-ms-traffictypediagnostic: BYAPR04MB6024:
x-microsoft-antispam-prvs: <BYAPR04MB6024B833DBC677C374D0CF3F86CE0@BYAPR04MB6024.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:288;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lMnLChSvjUQhGT0Qtz9Rq3pyS9IAD8Lg0CNSFTyw2hOMDypIus7GHFr0rlWPoIspHPR5cqGK5sWezhOjmH3p2C053WDR1qIwxX8DeQIDD35OVnAh09T9jOzp1HYqa2c3MBdf169ZLIGP/vkYvp6Q2+aoQ2GuEyAMVJbebseydjSwMrKeRaWsSMIOV8u7KPXkV2F+9Nj2Xk2I6wLBs7SUtvpMX0c8NOGDRcAhA8j871q+0t67JtNSm20ocsez/G+ebxqiU4Wq3vRUmNAL1akDgtRsdzX4qE4tXs6ZIj/TD+UzhQHWvCC2qeVCSj3Ud4QBtliDh9J/35gQp+WLOi4miw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(6506007)(52536014)(478600001)(9686003)(2906002)(316002)(4326008)(55016002)(5660300002)(83380400001)(53546011)(7696005)(71200400001)(64756008)(66946007)(186003)(66476007)(558084003)(110136005)(8676002)(33656002)(26005)(66446008)(86362001)(8936002)(76116006)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gGptQySCYGdqI0WhaPvNWr7bCFAchgnEaeZNFkO55lcDyTWsvfcQ36he8C42?=
 =?us-ascii?Q?Y2gQCEwU1NXGccPt+JLLjQl3B0ajhcMAC2x6Nx6/866fm1d6H5RhFJ/Zge7Q?=
 =?us-ascii?Q?xoPOsBxz0SLz3zxXO7d+sOzwnLS2B7NbQwx4Td5RilJoXRn6oNo6ZwR0atWn?=
 =?us-ascii?Q?0wT3RzfL2Guxt68t570jfo23d4lGukQHo/e0AgnuEfwZpx3g1tBQwc0AXSum?=
 =?us-ascii?Q?DjepwC2vBnqZcRcpBioPD2vRgNRV2qHSZAmXdZrXYRdjJ8vCrEFK9FvmtJOn?=
 =?us-ascii?Q?nBn0E4KIL4Zl+B8fszLLNNWUx4Vga0haT620WlE9G/hrC4rMS6mHrOVrZn7b?=
 =?us-ascii?Q?rrZoX+kXYYTrJlsWVnZYnm7Mrrh4X2jvslix4safXs/oJfTgD30RSm1aCgRc?=
 =?us-ascii?Q?g+a5yWA6K5oNxcJnQ/PoPAyaWkwdH4CQmitBhHHqUymkFlt42rH92FpHrZoK?=
 =?us-ascii?Q?p5xwGT2wWPCtaL3nxSYamSzzIL8QIfI4p/BdnNilscV54I7b8fDiLgSqghRf?=
 =?us-ascii?Q?38ZC1LlBVwSfgJrDHYG/xh/6kjibZM9rVeUwG0nz/aSkJfAVKKtquWclNlEn?=
 =?us-ascii?Q?ayk+rpoczk68+E5BPtH7D+RzJsiwWlks6IqKxsHzb6yaQgwvmEX2sjyIyxEH?=
 =?us-ascii?Q?hA2MCGzJzicJFAO27kme5vXjXPyE+UdiqDBnTrciWmfxn4fH/ZMcJxFCdHCQ?=
 =?us-ascii?Q?dLIFJJDn3TCTr3SVOe7pqViimIswoRbnMjValthF9FmRRgvdDgqitEJnPcoF?=
 =?us-ascii?Q?xzAk2fWXwp+FZlBHm5vTFewyCttlroLc1A3MPV/UkGjG2Y+0JIMRXqD/bkU1?=
 =?us-ascii?Q?gC7lHnxsyj2ciEiadkF97qThpudgNMlLevnJDNGs3ivtJVz3lErOCHnWQrKM?=
 =?us-ascii?Q?ELrVk0P4C1mS+8kOccZKi4ZD1/ko4p5UmP0pMXXwdP4PNppl0PgdwSuM+OU4?=
 =?us-ascii?Q?UQmf0G2lApsvffRbGdUa0p38n8PUTLOqBI6qfbzEEEK/VRVQaQQz0l3ZB9QF?=
 =?us-ascii?Q?8TUA?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1561d1-d711-49c1-1463-08d89a557224
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 02:11:44.9410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LCHqJMN4OOdbmhTnxlWf3cOn5vOua3YueSuwoZhlNTV2RJefNG6XGlnddgpjoSWmn8k2iGdQiqugHpAHBdzPlXzkTEqYu6xOT2quDRGRSMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6024
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/6/20 18:08, Jack Qiu wrote:=0A=
> Remove redundant 'be' in do_blockdev_direct_IO=0A=
>=0A=
> Signed-off-by: Jack Qiu <jack.qiu@huawei.com>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
