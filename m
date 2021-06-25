Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8F13B4099
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 11:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhFYJfY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 05:35:24 -0400
Received: from mail-am6eur05on2067.outbound.protection.outlook.com ([40.107.22.67]:56801
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231422AbhFYJfX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaHJRIo1RtxE2PWu2WwUpw6k/RI5FuUrWwN5M/mjTKE=;
 b=pZYA2swpXWwhMaX2mC0cHBp4av5kE0V1aJa5Osxanjogy2xBWvOJUi3uF7rj82pdkpDvjmbQnmiWCvJqciXlgppB95mqfioC2l6HgV2NCsfqKfu7qe5QYPj+PlxDPhYufeUrPrZECEXmCO+n5D6nl1vxXpcHMcxqIGFiWlUorwI=
Received: from AM6P191CA0091.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8a::32)
 by VI1PR0801MB2078.eurprd08.prod.outlook.com (2603:10a6:800:83::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Fri, 25 Jun
 2021 09:32:57 +0000
Received: from VE1EUR03FT021.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8a:cafe::8d) by AM6P191CA0091.outlook.office365.com
 (2603:10a6:209:8a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Fri, 25 Jun 2021 09:32:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT021.mail.protection.outlook.com (10.152.18.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 09:32:57 +0000
Received: ("Tessian outbound 7f55dcc5b33a:v96"); Fri, 25 Jun 2021 09:32:56 +0000
X-CR-MTA-TID: 64aa7808
Received: from 1f6792ba1e3e.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C6F8910C-D0CB-40C8-B8C9-E803CCEE7FED.1;
        Fri, 25 Jun 2021 09:32:49 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1f6792ba1e3e.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 25 Jun 2021 09:32:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crtRuLuI1RG7WoeOTioDznNFGzhkCFSC0d3gZfgSVcXrSFlihMGMZfserQD6pygQmNtG+lbEVNRaOA8cW83DXfy+eLnkHfaeaARC+kg3mBMTNAsQVlTahLiy3o3W3avm5CKIdKzihN5Zjgq189+URJfw+78sWr4WjxAJPcTzq8p7IYuEEdmPyILjfnAhKmPoBNdKqtXnIz3pROJsjFirJf83nemUONzfs6v6VF7LCcXHaIWy1ZPeipTAmInRZYIPc6Z2JLyu5knlNPRK4RBiku62ixiM3H4AscTovJaxKmHfy0Ar2PvhVoXrJRZ5bGxcccfblGoCyzan747b94xrrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaHJRIo1RtxE2PWu2WwUpw6k/RI5FuUrWwN5M/mjTKE=;
 b=H3tfiJTccwyOCoqMw9+tIs54KDQOhM9rh/fmWTuV5EItp9s6xejOglBJMqLOxH6WjzA/ZMjLi4Of0tZKvGEOj/926qr/GkngcE/IOy33BNWWulxVg1PnH5wihAlevBb/HbUKkwMkEg5YyTE2ta5SenUpS7YG/YlY4F82Bexf+IrAl5U1f/W+kVYleUgxfSfkmL3Z0qo3Odqyr6f9n3IAK2Wxe7T4+u/O+2WIdXM7Ema/ibMifLGq2FA624k8CywHoUIz0QTyT9Db4GOMi3kFEPTP4tQLs5+m2A7Vrx1ApLOJLHnDWc5ML2pH+Lde+BvHzbA7g4N6ISk3XziCV21cXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaHJRIo1RtxE2PWu2WwUpw6k/RI5FuUrWwN5M/mjTKE=;
 b=pZYA2swpXWwhMaX2mC0cHBp4av5kE0V1aJa5Osxanjogy2xBWvOJUi3uF7rj82pdkpDvjmbQnmiWCvJqciXlgppB95mqfioC2l6HgV2NCsfqKfu7qe5QYPj+PlxDPhYufeUrPrZECEXmCO+n5D6nl1vxXpcHMcxqIGFiWlUorwI=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AS8PR08MB6599.eurprd08.prod.outlook.com (2603:10a6:20b:332::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.22; Fri, 25 Jun
 2021 09:32:47 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 09:32:47 +0000
From:   Justin He <Justin.He@arm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH 02/14] d_path: saner calling conventions for
 __dentry_path()
Thread-Topic: [PATCH 02/14] d_path: saner calling conventions for
 __dentry_path()
Thread-Index: AQHXTEjJBmBJOq2FXUq44gPHBJbVjKsksQ3A
Date:   Fri, 25 Jun 2021 09:32:46 +0000
Message-ID: <AM6PR08MB4376D52CD6D690C444918E00F7069@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-2-viro@zeniv.linux.org.uk>
In-Reply-To: <20210519004901.3829541-2-viro@zeniv.linux.org.uk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: FFD4E70502FE6049AA6DD5F28543B6E9.0
x-checkrecipientchecked: true
Authentication-Results-Original: zeniv.linux.org.uk; dkim=none (message not
 signed) header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 88aec2d6-dca6-427c-c8be-08d937bc378f
x-ms-traffictypediagnostic: AS8PR08MB6599:|VI1PR0801MB2078:
X-Microsoft-Antispam-PRVS: <VI1PR0801MB207860295F3D4C6A5B3D0D1DF7069@VI1PR0801MB2078.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:3968;OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 4LqD4zeeOcPqHvc85h9cvo0XIBxWfT6osLeQWgnKWEn4XiWKw43vyn7bQyVogmx+mSuUHBWnPwAlCAcDZiT+iB2k3jGrw29GMPHvdYfV/UaAUFqx9uRKWr6vhbup6vbKO90XYlC/25DD64KK5sGVTApmSdCP1DhSRxXlb2YgwigF0fxCJtuxSPXhrmztmZYPmLO4M4XDKFRiyBFsvvZ1hYw3WXbuwEIZ7OydFncnGGxGc3dXsArqJoCM6hDkrXfgl8gDmtdWIAvKNZWbqeSQhwAoTRTPHayk/vzCsx6skLRy1kwZKZNceaLEZsNhuUs4Su/tCTntApofcfULGdPQ9TaZgWJ78ErtZomXUZVxloBHeTLdQzF3hzGgzI7vu2sGmwUVfKo8pfL3SWEHtyr4zOdTD5qwQ7ClWxdjGIFjgQoSCUc0LEI6yD4+rIKrpe5g/8f/aMWYZiry/70Hr7E5PACPkgZZkmvFC5H3PERVAS0cnHuaVCquW5WIPlEA+FEglxAwsubJ7+VtvT5uHLdya8pVnU+SHeXeXbEl4geWxnl/ke40O5Nt1uFtb/cbYiPIe5YfngbwQ0moOTKp/54F7YXnlTcDk5vtRwW92XkFiKYxHkfcGAdITWGTfCHgltodW3J5yae2z/VfUgcWos+jRQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(376002)(396003)(346002)(366004)(122000001)(38100700002)(26005)(7416002)(53546011)(55016002)(6506007)(86362001)(83380400001)(9686003)(64756008)(66446008)(8936002)(2906002)(5660300002)(8676002)(76116006)(66476007)(66556008)(66946007)(7696005)(52536014)(33656002)(186003)(316002)(478600001)(54906003)(71200400001)(110136005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0dFcQRC5TM45M5cNVD8MKCL8ezPIn+okYdChxIzKD5iuID1nxcTh42yAjVhC?=
 =?us-ascii?Q?L1E9RUG45vgV1OXtCIDOvBjO846gVccEmjZj0xKwu/dD7Xe97XfFOSwHRLdr?=
 =?us-ascii?Q?ifGZ4V39tuaze6Jdy82OWMWi2lo0zqgwz49Cr8AIAn377DweQhttsxY5dcVK?=
 =?us-ascii?Q?Yqiq+oDeqjazSoa/Yr0FzFQc6KoXJ14HS6p3DpM1OpKoQfMxSHoRjWHQ4H7Z?=
 =?us-ascii?Q?UPAdpXr2YEjbIN/PDxzQJrvyWUCSFulwAtiybks50iZ/l+vqE3k6kze8+kmz?=
 =?us-ascii?Q?cU6xX9OMC1qTqrCNDkqRntN+p4n9IMsBJcHlFF0jSlkUDECYUV9EuMzFuCAv?=
 =?us-ascii?Q?pLfWxmmPtw9zD8klS6DvcW1tJaEqG953TLi7Q+COqeAGCVaR71BN5m0ZqmSi?=
 =?us-ascii?Q?iLDw9E9YSYiqevg0hBFIzjNgPwbTblpn26/rx5ZwLCegC9GEnA8+iHQ7nlpZ?=
 =?us-ascii?Q?ZCthjmd1QVZe3E5wvjUTwdhSr8rFANuYRWIz3mvmr5LCVIU2uGeaFOH4CccR?=
 =?us-ascii?Q?0RX9PITZtwt38h1wK1QKMElB/wP2HS5S8wpaaJTE7kDlLZqcaINpkzA2VHbQ?=
 =?us-ascii?Q?uJ8PCpCAd/5/M8ywLLtX66c+lbgnnagEEDwjrojiYnFb3HUgDLw0sEEKdkUO?=
 =?us-ascii?Q?dIqwmtaMaFpPROuKHqm5MeN7EiXPm1H91L/kyjRBwVyAPKEFs4cemVmRATcL?=
 =?us-ascii?Q?JgWLu1NLaDeIqHiRf4CpFBTyJRF4pFgSxavuGny77x1QE/D0cIsTCSqMWv+f?=
 =?us-ascii?Q?LVQ8Tez2uHkFL6lzLrjD24TUWKxMgJWVJGgGNGQfQeiUelUa+FwUEyjf6S4l?=
 =?us-ascii?Q?u0M4qieCxac+xrTm0hObAgvc3JMw77DXKYRaUIT8Paa1lf3+FSwa8w/QXnmZ?=
 =?us-ascii?Q?DkWaQb0JxI6n6ttQP6t6rAKO4un7Io1I+Nfa+D9oCqgcInLhsdhIAULpe3jw?=
 =?us-ascii?Q?8Ey5d1ZzIOyWv5DJlLr1RIp5yRMXwDSVNOOHwW4A3Z6Iwq8Lyr4QiPBl0v/d?=
 =?us-ascii?Q?cbCSLMCYAVvFGXEZwj02RJSVgL8BClJxD8tnOaE6DvGOR+k21ldfJgckYq/y?=
 =?us-ascii?Q?lW1LWOVsvTJLEEM4SnliYzVxMrMF626OfarBbTZhJyMRNzLB46kiQMXhqP8E?=
 =?us-ascii?Q?1Q4YRbSHKDDStHLc15d/U7pXeUriuVEpdeWrWa4TnY/yr8lDrzOfA60rC9Zq?=
 =?us-ascii?Q?77OWD5NYUh0d6u/c8AIJLD3siRdCGS47eKzHyRrYxcvdBc+Q5/IDwmJwdV/r?=
 =?us-ascii?Q?BYZOhQyLYyfOc0wGsaE60d+cHkf4E6l+fPqeSQmwDaVhFS2Rq4BgEZYsZsb5?=
 =?us-ascii?Q?flXlq3NUkVg8pU7iylr2e2fa?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6599
Original-Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT021.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7e27f214-b4ca-41ae-33d9-08d937bc316d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bOK7SglpzVLPaENDce88tgNuoAFxOIeKYvV2zokde9KyNXPkmFMiAV9C35Oq8MVKP6B1/QmYtU7OrdjVgrl/AtAxDS7aZNBe+TNWFrx0TBtScYyKYrj4Dkf0v5YZT+cBIGvwhjqkGN0XkqkeZza+nId5Q6B3C8DJla8zmE0G8QhemBpW2OZXux0h7/+iRVtikLGZ8WNgw28HfGbKeK+qSyggkqFiY1dF6FvsW5RKPBoTnGijdvyUIMvuD8xu/IBCtj+VpAB0y3AUgrK/vP4twLfyNyX9LXn2N7/nS8VBm6OJb6ZOk00b0LHvC/PJ+sRdTbVUzdn3X5DKRWmlVF0I0HDdhWrpImTBlbYeSW4OzjqL7b06IhTU+SeGn7GCm+9nQEZL/EI5BJ4v26EQDOHzL/qSf3cAEqTGIyq6tkF0hP0JK+InrH5CbczN4Cto5XjycoSo3XxYuTrANhcd9SO9hIGQXzpfHXdoQ0F5du8LRQ23sE8FBxq6XnXD5m6PFelI/ZkHO+yTkdBBISbVQyV70SdafqtW/6ZTEbw6NmRrKO2V/v/JHm2SsO/c1dNFnGSU68jbN5XAlVNPeBveLg03XE8PTB4NjC5s6a3sBZ9KARHPMX2DN1B0h3o6eRv5jQxt+DJcgBM7QiNLouOx495yvjbugO2KyOtVuliE6Z6+JCUklKRR5e/nb+qGI5MIWguXaOLFhp1JoQ9rXSMQe+n68A==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39850400004)(346002)(376002)(136003)(396003)(36840700001)(46966006)(356005)(186003)(336012)(450100002)(36860700001)(82740400003)(53546011)(7696005)(4326008)(6506007)(86362001)(47076005)(26005)(83380400001)(33656002)(81166007)(8936002)(52536014)(2906002)(110136005)(54906003)(82310400003)(70206006)(70586007)(55016002)(9686003)(8676002)(478600001)(316002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 09:32:57.2796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88aec2d6-dca6-427c-c8be-08d937bc378f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT021.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2078
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al

> -----Original Message-----
> From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
> Sent: Wednesday, May 19, 2021 8:49 AM
> To: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Justin He <Justin.He@arm.com>; Petr Mladek <pmladek@suse.com>; Steven
> Rostedt <rostedt@goodmis.org>; Sergey Senozhatsky
> <senozhatsky@chromium.org>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Rasmus Villemoes
> <linux@rasmusvillemoes.dk>; Jonathan Corbet <corbet@lwn.net>; Heiko
> Carstens <hca@linux.ibm.com>; Vasily Gorbik <gor@linux.ibm.com>; Christia=
n
> Borntraeger <borntraeger@de.ibm.com>; Eric W . Biederman
> <ebiederm@xmission.com>; Darrick J. Wong <darrick.wong@oracle.com>; Peter
> Zijlstra (Intel) <peterz@infradead.org>; Ira Weiny <ira.weiny@intel.com>;
> Eric Biggers <ebiggers@google.com>; Ahmed S. Darwish
> <a.darwish@linutronix.de>; open list:DOCUMENTATION <linux-
> doc@vger.kernel.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; linux-s390 <linux-s390@vger.kernel.org>; linux-
> fsdevel <linux-fsdevel@vger.kernel.org>
> Subject: [PATCH 02/14] d_path: saner calling conventions for __dentry_pat=
h()
>
> 1) lift NUL-termination into the callers
> 2) pass pointer to the end of buffer instead of that to beginning.
>
> (1) allows to simplify dentry_path() - we don't need to play silly
> games with restoring the leading / of "//deleted" after __dentry_path()
> would've overwritten it with NUL.
>
> We also do not need to check if (either) prepend() in there fails -
> if the buffer is not large enough, we'll end with negative buflen
> after prepend() and __dentry_path() will return the right value
> (ERR_PTR(-ENAMETOOLONG)) just fine.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/d_path.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
>
> diff --git a/fs/d_path.c b/fs/d_path.c
> index 01df5dfa1f88..1a1cf05e7780 100644
> --- a/fs/d_path.c
> +++ b/fs/d_path.c
> @@ -326,22 +326,21 @@ char *simple_dname(struct dentry *dentry, char
> *buffer, int buflen)
>  /*
>   * Write full pathname from the root of the filesystem into the buffer.
>   */
I suggest adding the comments to remind NUL terminator should be prepended
before invoking __dentry_path()


--
Cheers,
Justin (Jia He)


> -static char *__dentry_path(const struct dentry *d, char *buf, int buflen=
)
> +static char *__dentry_path(const struct dentry *d, char *p, int buflen)
>  {
>       const struct dentry *dentry;
>       char *end, *retval;
>       int len, seq =3D 0;
>       int error =3D 0;
>
> -     if (buflen < 2)
> +     if (buflen < 1)
>               goto Elong;
>
>       rcu_read_lock();
>  restart:
>       dentry =3D d;
> -     end =3D buf + buflen;
> +     end =3D p;
>       len =3D buflen;
> -     prepend(&end, &len, "", 1);
>       /* Get '/' right */
>       retval =3D end-1;
>       *retval =3D '/';
> @@ -373,27 +372,21 @@ static char *__dentry_path(const struct dentry *d,
> char *buf, int buflen)
>
>  char *dentry_path_raw(const struct dentry *dentry, char *buf, int buflen=
)
>  {
> -     return __dentry_path(dentry, buf, buflen);
> +     char *p =3D buf + buflen;
> +     prepend(&p, &buflen, "", 1);
> +     return __dentry_path(dentry, p, buflen);
>  }
>  EXPORT_SYMBOL(dentry_path_raw);
>
>  char *dentry_path(const struct dentry *dentry, char *buf, int buflen)
>  {
> -     char *p =3D NULL;
> -     char *retval;
> -
> -     if (d_unlinked(dentry)) {
> -             p =3D buf + buflen;
> -             if (prepend(&p, &buflen, "//deleted", 10) !=3D 0)
> -                     goto Elong;
> -             buflen++;
> -     }
> -     retval =3D __dentry_path(dentry, buf, buflen);
> -     if (!IS_ERR(retval) && p)
> -             *p =3D '/';       /* restore '/' overriden with '\0' */
> -     return retval;
> -Elong:
> -     return ERR_PTR(-ENAMETOOLONG);
> +     char *p =3D buf + buflen;
> +
> +     if (unlikely(d_unlinked(dentry)))
> +             prepend(&p, &buflen, "//deleted", 10);
> +     else
> +             prepend(&p, &buflen, "", 1);
> +     return __dentry_path(dentry, p, buflen);
>  }
>
>  static void get_fs_root_and_pwd_rcu(struct fs_struct *fs, struct path
> *root,
> --
> 2.11.0

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
