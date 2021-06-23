Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976803B120B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 05:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFWDRV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 23:17:21 -0400
Received: from mail-am6eur05on2050.outbound.protection.outlook.com ([40.107.22.50]:36704
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229774AbhFWDRU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 23:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXj3HRepuBvpPxJ9JVeRXf/V+Eox9fYeMN4/jciIjtg=;
 b=PolQv0K0Z1b/i0IkJ19Gg9E5c+5rJ3BvOifMx0mtxJbbzHxhzVy5EEC4CuHVZlf9tB+07j6qK8V8DnZ65FUXlNdyx73+e5wtxrPqCgImxlGrUn7TXSw1+azqN7qMREdZ3x8c7L7j0/2OUtuh4HntkripDCyf4YGRq3b9yiQ5Ze0=
Received: from PR0P264CA0260.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::32) by
 DB9PR08MB7177.eurprd08.prod.outlook.com (2603:10a6:10:2ca::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18; Wed, 23 Jun 2021 03:14:43 +0000
Received: from VE1EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:100:0:cafe::82) by PR0P264CA0260.outlook.office365.com
 (2603:10a6:100::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Wed, 23 Jun 2021 03:14:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT055.mail.protection.outlook.com (10.152.19.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Wed, 23 Jun 2021 03:14:42 +0000
Received: ("Tessian outbound 7f55dcc5b33a:v96"); Wed, 23 Jun 2021 03:14:42 +0000
X-CR-MTA-TID: 64aa7808
Received: from aab1e4650b3f.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8B94616B-C674-4ED2-B8E2-943CFFA7795F.1;
        Wed, 23 Jun 2021 03:14:35 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id aab1e4650b3f.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 23 Jun 2021 03:14:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrjANgWT0fhduajq5jPSMEISVLUhOsVIrKyZfsvs6g2EbC77bf+1ja/7L0ACCCIXroAer4mpa9Xn0QA3gVjH9W8CuaDKppXlDBXCSOAQXrop+Rq+J8uVj+Mx5xAZP32ja9EX0RItWsXP9kC5Qh6Pgjbdj1TEF2sTvPoHKF8THVfLZdlkoA667tI+GEPf1wZXWdQvcR0xtZRMII31852IIMXgP9ar/Mj7vL/HPBfhECxsrPQSdx10nd5J77oVLIUx7r+yG9m76PD5CrH+JbU1r3wZuoYPmu+H9IvMG4X3lSuLQ+MoVVPZ2cWBa/1E+7E10PHMHJfq8vGoGRAqwQzL3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXj3HRepuBvpPxJ9JVeRXf/V+Eox9fYeMN4/jciIjtg=;
 b=mOgpTH4vaqQpuaEFrePhHUKFBuBVRe6lmfQ4SphkjUJxFExct5nx8WtXiGFDjVA7sEe3KZORMtzyhEdPxFNUf4ThxuSQeK4PTQsYiF0dTEF7T5wS5ecTVTISf2d9QtMgThKjM3QJxUqV0lf8s7+0gY530de652no92EoJIuW7gnbiLJDGnP0ccvVj7MSSJbXMxO0zAgZZT3283zHM462Sa15H4wQCV2HAx+/xdPMSJ+IEn7Uvg8Tlzm34Tk1nwmzpnKvDitMA2pjE3fsNzutRPeis3RKQe5UtShzGbTV4c9n07tXiHgW0a+PkYWjrmC3WlDgR3RPLWw+iUUg61v/mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXj3HRepuBvpPxJ9JVeRXf/V+Eox9fYeMN4/jciIjtg=;
 b=PolQv0K0Z1b/i0IkJ19Gg9E5c+5rJ3BvOifMx0mtxJbbzHxhzVy5EEC4CuHVZlf9tB+07j6qK8V8DnZ65FUXlNdyx73+e5wtxrPqCgImxlGrUn7TXSw1+azqN7qMREdZ3x8c7L7j0/2OUtuh4HntkripDCyf4YGRq3b9yiQ5Ze0=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB4008.eurprd08.prod.outlook.com (2603:10a6:20b:ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Wed, 23 Jun
 2021 03:14:34 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4242.023; Wed, 23 Jun 2021
 03:14:34 +0000
From:   Justin He <Justin.He@arm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, nd <nd@arm.com>
Subject: RE: [PATCH v5 2/4] lib/vsprintf.c: make '%pD' print the full path of
 file
Thread-Topic: [PATCH v5 2/4] lib/vsprintf.c: make '%pD' print the full path of
 file
Thread-Index: AQHXZ3ANHoFkUZUtCEuxzhYeDZbv9KsgGg0AgADSkdA=
Date:   Wed, 23 Jun 2021 03:14:33 +0000
Message-ID: <AM6PR08MB4376D0AFBC0A4505280822FFF7089@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210622140634.2436-1-justin.he@arm.com>
 <20210622140634.2436-3-justin.he@arm.com>
 <YNH2OsDTokjY1vaa@smile.fi.intel.com>
In-Reply-To: <YNH2OsDTokjY1vaa@smile.fi.intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 2C01AFCA601C7845B6F3DBE87A3D294B.0
x-checkrecipientchecked: true
Authentication-Results-Original: linux.intel.com; dkim=none (message not
 signed) header.d=none;linux.intel.com; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.113]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: bb65d7cc-5a08-4fd3-f2c9-08d935f50bb8
x-ms-traffictypediagnostic: AM6PR08MB4008:|DB9PR08MB7177:
X-Microsoft-Antispam-PRVS: <DB9PR08MB7177C0AF2685A5F84807E4BBF7089@DB9PR08MB7177.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: V9GBHc1og2x8LTzqDR58ilOH/6orN982hYjCljgekSRYEMPB8qHrz1SZ0gIy0Y5M3IZnI+HE1LBg2e0tgpsFiBGiJ9VOw/2fbs7nUsYIsL+h8sBkWdrSQ2Rkt+q+X1s5jYJqKyYFOY5BPnbQu1NSgRtYbGCgEl9X6NRBf0LDq8z2XmwAkzNkU8gT4+57DibBR442+gy7tnPLM+rEQjwisuk7VSVwk/C6JlnxFhTsOSRZP/vnZjdTe/D0Cf+96Bd/Q64UIQ30G8vCu39IrED5+1l95c0AQex9PxpP4LrzBa3B7ezEJnTGmR+Fq7NFJT3RfIUMSylqMfx9JBqkz0M9SfmT+J1o0nag0SLNKzhLXs6XmM9URbJrFQ7J2zzAP4z4ivmDWtXnj1gspdKjXNEYeoC7lhropvNO/6U9Ny8FbG/it4PacgpAL/j3+FExABuTMPoz7g0ehSzbM1+pWs1KghBolL/5mTXudcluKCV0V82W5SK+7GS2+KcZgbn1aHyDMoHc/YxF4067VnsNbf/V+y7C5/JGzSP3bwCRfBZQKi+pYCeZfrAAMfsgprp3rsQW9PvU6/SCcwtxuG0hKmKZrN4Ld9YLcCCTZP2ZuDuo0HCcpLT/HTZNksTYbnClJ8e6W6ll5omMwKa5ux1+6dMJ/0O27Qmh6jxg+hzY3lAWLJgS1buTR9d5afhcE5qTjdM77eS3szxxfNtvwPx9XJJ89sOg7l98ajrYj5iDjTu0oAk=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(376002)(39850400004)(346002)(76116006)(6506007)(53546011)(55016002)(54906003)(7696005)(83380400001)(186003)(8676002)(38100700002)(64756008)(52536014)(316002)(66476007)(26005)(122000001)(33656002)(9686003)(8936002)(5660300002)(66946007)(966005)(4326008)(86362001)(71200400001)(2906002)(6916009)(66446008)(66556008)(7416002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iC2myN0SwvU/ZIXj6I6JbEq6cQ3SuHK4KAqJqAjMIAUtkJACMqGZSczwnbQZ?=
 =?us-ascii?Q?gWTSa7/mKyoCgAcreJYh4YCnPI5oFYnfJkTsKaq+xgS7UzleDFlzIbqDsj7/?=
 =?us-ascii?Q?xzdp15KWrBMTUic7+Bwy5D8qJNPloEF2Vv65zPF+fZYwDVjsT/qnngfUwTSt?=
 =?us-ascii?Q?tFTpv8VjDQPU1XwSlt82r/LKpKcbXUbwhopUb7nEVTWXVZy+LrrNvg8K4Hsd?=
 =?us-ascii?Q?Sd7mYC/wHu53eycJdcoTGFUrcvkVw2ZfGunE/yGMxDjYZgJP90JOPmwUlhC9?=
 =?us-ascii?Q?SN+wa8D7L/Mwm4fHQueEwV5eN24r3xNwP36gil2SVbaE1FRfb/ifqrSACmtx?=
 =?us-ascii?Q?2rD9i9oHIL3A90vVa4OiSqbhDJD88XZNRHKXZgGKpfvXB43zr0rBnDD4oIuF?=
 =?us-ascii?Q?BGY8TeblvvC2/WLi2105S+IMwhaD9welMkMyIQDwIC4+3Iv4QH7ufmrK9KrL?=
 =?us-ascii?Q?Lv33yfBrBOu3dhgy3LMO9SQULdfSm4mXftoPBQxoeT2Ovxf4tjMmBM84WxKu?=
 =?us-ascii?Q?R52PDUcFFWe4ByceXrj5IxMg6p7eMvKEx+cmbgHT+g3Gz9GRlGoBXoOkns0x?=
 =?us-ascii?Q?16VEGnQhW3EPWpvPeCHpa5+/h2YTQ8Ya8rKijxNo7dlYtTJBU/rzoF5oENPO?=
 =?us-ascii?Q?2sFua3f4RVXoI2KIrJhSZMLycrMoUcyQ+SX1IJsng3zR20mAyR2ENz++fj+p?=
 =?us-ascii?Q?wBEZn3rQlmVCEFboIm3iddtNMbj+ApaFEB7NaV94/5XLlsRSRj1Z1SLYikDi?=
 =?us-ascii?Q?ftiRtEO/TZ8t7y0gYLL8pp+30dmrLlI/S1bMgG2vEF3DMJ4MfHrtWXQtL37z?=
 =?us-ascii?Q?BxbVLh5/ipfawRN8EUoAYNJ+vjtfhMySTI9p3UXXzYUMXomaRytthaR3uRyz?=
 =?us-ascii?Q?wJ8Nmoc6BFrk6hOcqDDd6+uisHiTfMtt+ybRr1X/Owtg5INj9PUCQWPg00qd?=
 =?us-ascii?Q?YMXNFHXarZyDQCnaXlKiSfzrwISrQY5OYoL9IT3NBT76tMNVt2BC/yNHV2lh?=
 =?us-ascii?Q?OvSaasRNVM3XLkScRw+lkZdehK2Tx8lvv0UHjvXEwGyUFIRdqgGxlk/urphg?=
 =?us-ascii?Q?IGnjk6hcEyzrjZE7cGDwyhvOrzw7FNv/bXBS7fnUFHdh2LcYFDcftOFd6rW2?=
 =?us-ascii?Q?iEX3wml79iTvvrqoap3HzazM8ci0uiLrCEfiE0kulHj7Ke3s0ZXmetayHz0n?=
 =?us-ascii?Q?/mG+utk7c49a1WBlMyspka501G1ty+jO9yQ9n0t/rzea8nKAWWXMYfumRbAt?=
 =?us-ascii?Q?mSfG2KPP643Rx2DEJusd5kEnmiRtgaT+BPJ1WYWNK0MOMYXbxdl/pDW3CAVi?=
 =?us-ascii?Q?PEAylIvL2sXjAfXD/fUv0GiT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4008
Original-Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9ec26ace-68f5-469e-625b-08d935f5066e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JwJnnXeGEDvs6vu1NC27Bo/3TAayJoJh7jotTb6RS8qzvgl2yF2eaYYZ/LuE8XAraSBrSTmC33yEipMmy3DbO1rgoI4WU4+k9pSSFRVnF4vFkHxVU4A7Km2KLQcBPAMoDV3kiSJYJzGBtRQE7QCVtq4BXnxaubsFfMNWkK+SZhv2bxYodz3OBpO5pfQ+WcviwPaST3gNWu5lFHrBLxYM5DRIxWYs3JVl5+6gjMfQeu8d1G2mRiSfHzukLA5mip2/TPWfc1BG/SigAZopSU8EmdqHeMDAIDHnIEaU2s4/f+LnXPm9l8K89BaxmLm9IdAeJBOAdlvLxATa5oyzZdyDCt7x2ypYV5p2K12usEsiNWjFfXMrweF0KKdX5912yDZ3YyxTHoFERFDoktnCfMZmTRiys6mhB2CwSZPWqrN2E7e3BEW96OVqtZK71i+M27KPgp8kiZXqaa/GMnbtCZHcB0vCydZpuvomW++GYvEZRfEBmSWfBhREiyQXs52egMdNukSaSas8c+laAx2lm7GPYIwpBtRn0ejBPVdl9whgCS0OIzcqUJW1U1VEH33xoAjJ/DrLZgN9Porltme4sIcVdCikS9ODedvKqVyKE0toz32lLLyhNkJ+OGNf2wytAxAsDOhqv+0vrOJ5NI+DQd7FPDK6KWaZ1L1Ylc2Llb97KVWGeuCcYsNUKgCvREL1htCc1tjhYn4IXf7cN1obe6Z+AjZ8lt7ZaUFRiwqP358kgTVhJTq4h3jnQUcD0ZvSK9bUrTtr2EhP+m42D3p8HFZvwHJ4UbdeYFP7RMZNaoFxdG7g55Szd+JYBS7bTBWkX5u4FYbJj1ZYy/fmi+B3NS43rQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39850400004)(376002)(136003)(346002)(396003)(46966006)(36840700001)(81166007)(26005)(966005)(316002)(83380400001)(55016002)(8676002)(186003)(8936002)(7696005)(6862004)(36860700001)(356005)(336012)(33656002)(82740400003)(5660300002)(6506007)(478600001)(70206006)(4326008)(47076005)(86362001)(9686003)(52536014)(2906002)(54906003)(450100002)(53546011)(70586007)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 03:14:42.7116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb65d7cc-5a08-4fd3-f2c9-08d935f50bb8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7177
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andy

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Tuesday, June 22, 2021 10:40 PM
> To: Justin He <Justin.He@arm.com>
> Cc: Petr Mladek <pmladek@suse.com>; Steven Rostedt <rostedt@goodmis.org>;
> Sergey Senozhatsky <senozhatsky@chromium.org>; Rasmus Villemoes
> <linux@rasmusvillemoes.dk>; Jonathan Corbet <corbet@lwn.net>; Alexander
> Viro <viro@zeniv.linux.org.uk>; Linus Torvalds <torvalds@linux-
> foundation.org>; Peter Zijlstra (Intel) <peterz@infradead.org>; Eric
> Biggers <ebiggers@google.com>; Ahmed S. Darwish <a.darwish@linutronix.de>=
;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> fsdevel@vger.kernel.org; Matthew Wilcox <willy@infradead.org>; Christoph
> Hellwig <hch@infradead.org>; nd <nd@arm.com>
> Subject: Re: [PATCH v5 2/4] lib/vsprintf.c: make '%pD' print the full pat=
h
> of file
>=20
> On Tue, Jun 22, 2021 at 10:06:32PM +0800, Jia He wrote:
> > Previously, the specifier '%pD' is for printing dentry name of struct
> > file. It may not be perfect (by default it only prints one component.)
> >
> > As suggested by Linus [1]:
>=20
> Citing is better looked when you shift right it by two white spaces.

Okay, I plan to cite it with "> "
>=20
> > A dentry has a parent, but at the same time, a dentry really does
> > inherently have "one name" (and given just the dentry pointers, you
> > can't show mount-related parenthood, so in many ways the "show just
> > one name" makes sense for "%pd" in ways it doesn't necessarily for
> > "%pD"). But while a dentry arguably has that "one primary component",
> > a _file_ is certainly not exclusively about that last component.
> >
> > Hence change the behavior of '%pD' to print the full path of that file.
> >
> > Precision is never going to be used with %p (or any of its kernel
> > extensions) if -Wformat is turned on.
>=20
> > Link: https://lore.kernel.org/lkml/CAHk-=3DwimsMqGdzik187YWLb-
> ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com/ [1]
>=20
>=20
> >
>=20
> Shouldn't be blank lines in the tag block. I have an impression that I ha=
ve
> commented on this already...

Okay
>=20
> ...
>=20
> > -last components.  %pD does the same thing for struct file.
> > +last components.  %pD prints full file path together with mount-relate=
d
>=20
> I guess you may also convert double space to a single one.
>=20

Okay

--
Cheers,
Justin (Jia He)


