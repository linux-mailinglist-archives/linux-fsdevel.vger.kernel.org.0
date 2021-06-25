Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BE23B4029
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 11:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhFYJVC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 05:21:02 -0400
Received: from mail-eopbgr130042.outbound.protection.outlook.com ([40.107.13.42]:33547
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229956AbhFYJVA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SF5xR9aHTovVvObF3Jy8ZmXAgoD5efhkCYTImJwslUY=;
 b=e4FCHraC922AI+0X/Itrptg943nZMuGs98ty4yL0moXn75s/x4S+UrvXhjlV+tJ7FLHJj2lhQ2UYEjOC3fDE6OhVlMUhIJganpreG5yAVa/Pmj1L7F9uUq3pbrn/YhvN8Prvhi2QWmFx4WU55EDOb4E+jYr09zAH+0BuTVdkPtw=
Received: from AM6PR10CA0040.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::17)
 by DB6PR0802MB2360.eurprd08.prod.outlook.com (2603:10a6:4:8a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 25 Jun
 2021 09:18:34 +0000
Received: from AM5EUR03FT016.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:80:cafe::fa) by AM6PR10CA0040.outlook.office365.com
 (2603:10a6:209:80::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Fri, 25 Jun 2021 09:18:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT016.mail.protection.outlook.com (10.152.16.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 09:18:33 +0000
Received: ("Tessian outbound 41e46b2c3cec:v96"); Fri, 25 Jun 2021 09:18:32 +0000
X-CR-MTA-TID: 64aa7808
Received: from 85edfa64ca2a.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8B4FAD45-958E-4606-ACBA-51500A3A4926.1;
        Fri, 25 Jun 2021 09:18:25 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 85edfa64ca2a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 25 Jun 2021 09:18:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDLNL16MOho9s75Xi04wY+gvCPSH36B4tWCShLSZ1HxX/wpTE20fKnLU6ylmIhZT7tB8dufnzi5u6hs1Paw2MckgcNxOvUOpnV7yinZ5n4kc0fVXGXOK+V2yEuVD7wA5q6+8HC0HHKMHVD+ciLYQaPgNH+r3rrf068MofpgBp5zOjqc/qNB4RP4H0jFk2LTeo40OlW56kOePCIbyWIC7MRdTzRX0qD98QaqvilrHKKH4R3COk6kEE925bKTnhCQa8E42h29xZ/zJ2xWFhaVLjw4kWYjtnjGUx0B98S6ozxgU0GaJ2LuVU7p0icqZo+9wDr1CV13hgEqF3fsYcVx2qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SF5xR9aHTovVvObF3Jy8ZmXAgoD5efhkCYTImJwslUY=;
 b=byY4qlaDE8Uw8qGrU0A3m1YedCcjrPsvdFfgj+ts+afeHdV4eyjvjcOfwFCaAuwZFLaXZCHEznT1KAY0vCRfTqTz3W95zjwugixizS+pppNLLXcqfOxrZP6HRICEFDapfoquyPe98BTHzUQmQpel6EXn1oZD4wT+tMVlbFVmap2sF6+AKW3h0FGvB76egzfeE1DevOiqO2p+zkF8Ri7dl1YByd0p5k9hOvoUOcwYBOrvndtB9i+RvPxPSlLHObSN3/fyPK4k90kZGJQO5YYY7Fv0slcvqPwg1ZsnYGqwtHLMI5TjOF7SP+R0pNz/cIiyA0WHUv0TDNx9Vt4AN6jCFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SF5xR9aHTovVvObF3Jy8ZmXAgoD5efhkCYTImJwslUY=;
 b=e4FCHraC922AI+0X/Itrptg943nZMuGs98ty4yL0moXn75s/x4S+UrvXhjlV+tJ7FLHJj2lhQ2UYEjOC3fDE6OhVlMUhIJganpreG5yAVa/Pmj1L7F9uUq3pbrn/YhvN8Prvhi2QWmFx4WU55EDOb4E+jYr09zAH+0BuTVdkPtw=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB4565.eurprd08.prod.outlook.com (2603:10a6:20b:af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Fri, 25 Jun
 2021 09:18:21 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 09:18:21 +0000
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
Subject: RE: [PATCH 07/14] d_path: lift -ENAMETOOLONG handling into callers of
 prepend_path()
Thread-Topic: [PATCH 07/14] d_path: lift -ENAMETOOLONG handling into callers
 of prepend_path()
Thread-Index: AQHXTEjITB/V0362t0GPPyDCrpGmgKskqplg
Date:   Fri, 25 Jun 2021 09:18:19 +0000
Message-ID: <AM6PR08MB4376E091A9A84BE1240F3989F7069@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-7-viro@zeniv.linux.org.uk>
In-Reply-To: <20210519004901.3829541-7-viro@zeniv.linux.org.uk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: B8E9C54692663047B629971C6F77CAEB.0
x-checkrecipientchecked: true
Authentication-Results-Original: zeniv.linux.org.uk; dkim=none (message not
 signed) header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 5d9ca08e-9239-449f-5e47-08d937ba34b0
x-ms-traffictypediagnostic: AM6PR08MB4565:|DB6PR0802MB2360:
X-Microsoft-Antispam-PRVS: <DB6PR0802MB2360BC94BA129378B7443339F7069@DB6PR0802MB2360.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:4941;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: LwfaO0dUzWO6oJLmEqECiTPvgWkrBHkCdYsbivycsAWbK7eaJwRuo0ehrbJeJZUQyfaVE20ReIJ+/rOOkOrPhc8A3vu0NVYKh/uUWjD8I1NU/XaRVVCHXlk0RwYx2hPzZk+nnlBL9Eq/aLLIqEIBClwQUlklXbvogkNzl0u7MQucOpS8kyhQ/+Gb/LirwKwet1o97JrbbvS2IZ5NB7ueyXdGrkFcU+kGIR4EUMhM3Aq6N9SwxH56f8cVJ1sQ+i5t8hLTHoq4OSxbAZcAoI/CO01oPFBumAzQMy1+/CGYLBcHhLSLUIVGmJzxo/LLL7MabNusyYm77YfNgzRGyJvlG/ORtBs1IzMfVMk8TN/NFwS5UdaNrOl1SganT0QNLzDHQAv/9ysUoRLiqRtx8Gv5KAac+kGEzxAOENpEFMW625ihFMJQCXmWpS8vvqUUYs0ojkU0Tny+k41Vd+5VKU2qkrszSUBa+yPaucGRt5MOXEYQ4XOTASwrfBQEBSUzHFaA1bQSMwQGF0zI1qjhleMHkfIsQS/W7O5mctLnoW6ZJPDcfz9eo2vDvl3BNdWZTi0KYKYfFvTILocmWQAlOXUJ8HLGXMKBtLgvcBn5dCpuEPWR2YaaoSMppmwjdtHzxjy324HUcMQp5NP9DMVofigy9Q==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(396003)(39850400004)(346002)(55016002)(33656002)(76116006)(86362001)(66946007)(186003)(6506007)(5660300002)(53546011)(26005)(66476007)(8936002)(66556008)(478600001)(64756008)(66446008)(122000001)(7696005)(7416002)(38100700002)(2906002)(8676002)(71200400001)(52536014)(83380400001)(4326008)(316002)(9686003)(54906003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4H8xJCuoYC5qBKbJb5+p7x7Bq21ZWLlvgLP9/ROQh0ASmzgN4jqe9WLrBuOm?=
 =?us-ascii?Q?x3t+tSy76Qf1DpJuPv3E0MIbOlG+3DKqANujiJNIRBVZTQZtJI8/xvLLDWV/?=
 =?us-ascii?Q?2/2FhUy+BVb86qWvPPD5CVzVFjHdfWmleU0zYD6UX6/3iONF7PqmC8OtNe6e?=
 =?us-ascii?Q?XZgHvldIw3udVyX4K1sTdriFiSOgsVloy4iWbCzktpCA3EvZEr4VkmP6bkNC?=
 =?us-ascii?Q?hxgoSG1EdS8qPoq1ad1rkemxo4fuWtwhs2sWzYKwccXTUJT7aPHCgGea5zaI?=
 =?us-ascii?Q?LWuCQ5K0p0KPfFBSg2ol9uPuNwFhgxchHyylC5R2lQ+g44fDZuFAfMEYBo2c?=
 =?us-ascii?Q?D4o5M+//WAQDaM02/6U3CbDvB6d90tnBnDnPpN/0vYq6qZltX3MRugPQefrw?=
 =?us-ascii?Q?bzeMjbAOksUdS+fqtLEHxGXK0/TLYaPaJ+7Phfs/P6PErnZL/7n2YdvMch2A?=
 =?us-ascii?Q?C0wu/vKkZ77dA0Ykkv3Ujld+9PqQUDSTCjLSH+x1g9QmnCX+iejUJn8SHPJw?=
 =?us-ascii?Q?M+16/bGs9+BWwIXZ3CTdZ38i6AqH7IHuKMFxKUjvlEfkge6o/LWOQwQkJzTZ?=
 =?us-ascii?Q?LEpKpzTWYdjQYXOjfCHRfY0H4WEkDbaxcNCG+OpFAHyhORrYoTGrwptsc74A?=
 =?us-ascii?Q?wgQ3XRZpePHVOvLz7gLtTBsQ6Occz8MMDS1Fi7oS5+dz+bt+pUdUcNR36jUT?=
 =?us-ascii?Q?oFhRVPXNIZwqdcBCTYg226SgaF7Jqo+gTf3InrcSSxn2XwLOrBm0V+cMi7Mb?=
 =?us-ascii?Q?ma2YW6oGffAK91WraRro1hlabiLs78K9QQRg71WhPl6MJyfZrXdToW22oawo?=
 =?us-ascii?Q?pM8zk+NlRJsGRLBHqociYoB3Tp8tdnu63sqD2iMna+bNUbMgcvletz70KdyK?=
 =?us-ascii?Q?a1+F6PH0hIGCWjrfVqpEccHL5jpEPJ2AmVTiV9ntvx9Ibg5QNfKNzOUDyAcg?=
 =?us-ascii?Q?qV160OE9f50knvBcTLkHM6ZxOD9wGsjGBOaHhrelM7EDn+PDwjji/9c/BgID?=
 =?us-ascii?Q?SCw4Xybvv5KZyGdotqlSLAmW0zP/yARXoRbs01Mq4ARs05PyE3HQIvz6lhNH?=
 =?us-ascii?Q?lEupWQzFmzY8yyzB9/9E5ays/0GhC88777Kur3oo9eSTNSCRR9BJgnIwJbeb?=
 =?us-ascii?Q?wWKws5xiLbfvqKvxwjTxHi9QQoRonWf76bn7niQvSAoJjjTep91/RP1DT6JL?=
 =?us-ascii?Q?f61LwB+XbCpn10Qffn/ahYPpMiWc6y9MRU9mDKMx05Gkf0s7/YbjQ/P0/DNs?=
 =?us-ascii?Q?v8ZKDCZQ5VUaTkl0YQk+DDX2O8zWs3v9USzGca1qPh5sAFDR+qHkz7P0Mvvw?=
 =?us-ascii?Q?TBT6lVFw5sYN51UOO8Xj941M?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4565
Original-Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT016.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: a83cc13e-6f8b-4295-ca92-08d937ba2d23
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYXV/pZlDE3w0kdoay6vQMRwzOPWKi2TLdxx9EnVriK1sFSBqmamknqR0fI3ooOkK0s9kVXYYC8WJB9wOLiXGHDxT3taLb8AEqDjQLYgjpvheQOXA30JDTG8xQdBvdpw0H6vtq0uqJvy+RYhsqjipTBENJV8XUu6C81R264yuOymEzwzeL+NbQmMygsUcy+b24AoEbKaNPO9EEc1mzBYQMawPWhHxfgJslz1gixgquZUTTQ+/zD96CN/jYXUi6Gik7ApUuoHfBBwSZmCYTU9N0ikwO82f4FyfZf+R17NguSkNw/P+Pe6zeKuza74tfofHScI04xtt/4TMTmGDvdguwgbsS5jw43rQ0VMw215L9aXj15OtJy5W6nbbtVWg7PvMHRoo1syCII6UCAZLET1RhAjagbImmwQAPY+eoPtvsZO6vDd8Zmg/qe6Uc6TESLUKNf4j1boGx+t+m6BL1xvWTjOsMkXHCycRkdLHCDXjLL1WwsNkbVevolJzjggLPW1ZggBNUA3mfE1jdD2x20h/gpwdlWrtJYSDyTAvr501iblwrKDApojdrm4swK6eTNBJHcnwh8hnfn/HD46C/hQREd8csdgo4Lr0EQ/Qiqj4Fam6zrvFxcDhMq1wGEbMW7eRVs3VOgBmFYArXsElzEPOORGKyJo2dtkr2xXAMTeiScHtGzu6cqPLpCDzZwbGpqqeHnF4LhZ/YsljPY+NDzkwg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39850400004)(36840700001)(46966006)(2906002)(70206006)(70586007)(186003)(26005)(316002)(47076005)(54906003)(8676002)(53546011)(110136005)(5660300002)(478600001)(36860700001)(6506007)(7696005)(33656002)(82740400003)(450100002)(8936002)(83380400001)(82310400003)(81166007)(55016002)(86362001)(336012)(52536014)(356005)(4326008)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 09:18:33.5674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9ca08e-9239-449f-5e47-08d937ba34b0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT016.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2360
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
> Subject: [PATCH 07/14] d_path: lift -ENAMETOOLONG handling into callers o=
f
> prepend_path()
>
> The only negative value ever returned by prepend_path() is -ENAMETOOLONG
> and callers can recognize that situation (overflow) by looking at the
> sign of buflen.  Lift that into the callers; we already have the
> same logics (buf if buflen is non-negative, ERR_PTR(-ENAMETOOLONG)
> otherwise)
> in several places and that'll become a new primitive several commits down
> the road.
>
> Make prepend_path() return 0 instead of -ENAMETOOLONG.  That makes for
> saner calling conventions (0/1/2/3/-ENAMETOOLONG is obnoxious) and
> callers actually get simpler, especially once the aforementioned
> primitive gets added.
>
> In prepend_path() itself we switch prepending the / (in case of
> empty path) to use of prepend() - no need to open-code that, compiler
> will do the right thing.  It's exactly the same logics as in
> __dentry_path().
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/d_path.c | 39 +++++++++++----------------------------
>  1 file changed, 11 insertions(+), 28 deletions(-)
>
> diff --git a/fs/d_path.c b/fs/d_path.c
> index 72b8087aaf9c..327cc3744554 100644
> --- a/fs/d_path.c
> +++ b/fs/d_path.c
> @@ -127,8 +127,7 @@ static int prepend_path(const struct path *path,
>               }
>               parent =3D dentry->d_parent;
>               prefetch(parent);
> -             error =3D prepend_name(&bptr, &blen, &dentry->d_name);
> -             if (error)
> +             if (unlikely(prepend_name(&bptr, &blen, &dentry->d_name) < =
0))
>                       break;
>
>               dentry =3D parent;
> @@ -149,12 +148,9 @@ static int prepend_path(const struct path *path,
>       }
>       done_seqretry(&mount_lock, m_seq);
>
> -     if (error >=3D 0 && bptr =3D=3D *buffer) {
> -             if (--blen < 0)
> -                     error =3D -ENAMETOOLONG;
> -             else
> -                     *--bptr =3D '/';
> -     }
> +     if (blen =3D=3D *buflen)
> +             prepend(&bptr, &blen, "/", 1);
> +
>       *buffer =3D bptr;
>       *buflen =3D blen;
>       return error;
> @@ -181,16 +177,11 @@ char *__d_path(const struct path *path,
>              char *buf, int buflen)
>  {
>       char *res =3D buf + buflen;
> -     int error;
>
>       prepend(&res, &buflen, "", 1);
> -     error =3D prepend_path(path, root, &res, &buflen);
> -
> -     if (error < 0)
> -             return ERR_PTR(error);
> -     if (error > 0)
> +     if (prepend_path(path, root, &res, &buflen) > 0)
>               return NULL;
> -     return res;
> +     return buflen >=3D 0 ? res : ERR_PTR(-ENAMETOOLONG);
>  }
>
>  char *d_absolute_path(const struct path *path,
> @@ -198,16 +189,11 @@ char *d_absolute_path(const struct path *path,
>  {
>       struct path root =3D {};
>       char *res =3D buf + buflen;
> -     int error;
>
>       prepend(&res, &buflen, "", 1);
> -     error =3D prepend_path(path, &root, &res, &buflen);
> -
> -     if (error > 1)
> -             error =3D -EINVAL;
> -     if (error < 0)
> -             return ERR_PTR(error);
> -     return res;
> +     if (prepend_path(path, &root, &res, &buflen) > 1)
> +             return ERR_PTR(-EINVAL);
> +     return buflen >=3D 0 ? res : ERR_PTR(-ENAMETOOLONG);

This patch is *correct*.
But do you mind changing like:
if (buflen >=3D 0 || error =3D=3D 1)
        return res;
else
        return ERR_PTR(-ENAMETOOLONG);

The reason why I comment here is that I will change the
prepend_name in __prepend_path to prepend_name_with_len.
The latter will go through all the dentries recursively instead
of returning false if p.len<0.
So (error =3D=3D 1 && buflen < 0) is possible.

If you disagree, I will change it later in another single patch.


--
Cheers,
Justin (Jia He)


>  }
>
>  static void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
> @@ -240,7 +226,6 @@ char *d_path(const struct path *path, char *buf, int
> buflen)
>  {
>       char *res =3D buf + buflen;
>       struct path root;
> -     int error;
>
>       /*
>        * We have various synthetic filesystems that never get mounted.  O=
n
> @@ -263,12 +248,10 @@ char *d_path(const struct path *path, char *buf, in=
t
> buflen)
>               prepend(&res, &buflen, " (deleted)", 11);
>       else
>               prepend(&res, &buflen, "", 1);
> -     error =3D prepend_path(path, &root, &res, &buflen);
> +     prepend_path(path, &root, &res, &buflen);
>       rcu_read_unlock();
>
> -     if (error < 0)
> -             res =3D ERR_PTR(error);
> -     return res;
> +     return buflen >=3D 0 ? res : ERR_PTR(-ENAMETOOLONG);
>  }
>  EXPORT_SYMBOL(d_path);
>
> --
> 2.11.0

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
