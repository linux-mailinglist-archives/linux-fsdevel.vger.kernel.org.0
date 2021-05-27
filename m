Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDB9392867
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 09:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhE0HWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 03:22:44 -0400
Received: from mail-eopbgr60044.outbound.protection.outlook.com ([40.107.6.44]:5699
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229909AbhE0HWn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 03:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJuNE2H6vnD5ufvgoG30VxV+PHglVtOiUeUWisNPdyk=;
 b=3RiN7Sc33aj5s8OeWmGzLDIHo/aL/CNE1cEvRFvcxZ7VXvo38vaTwa4QwlWrDtIvcQARpM/cuhClLU4ZvEtT5GKzL+QYb6dLYzVhZ00VWLM/JWHBRNjOA1UOHcAOaKYWyqcIfRK4pIY8sqGGHSThjOJYboeD/UVAzC4/V5Occno=
Received: from AM6PR04CA0064.eurprd04.prod.outlook.com (2603:10a6:20b:f0::41)
 by HE1PR0802MB2553.eurprd08.prod.outlook.com (2603:10a6:3:df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 27 May
 2021 07:21:05 +0000
Received: from AM5EUR03FT038.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:f0:cafe::5b) by AM6PR04CA0064.outlook.office365.com
 (2603:10a6:20b:f0::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Thu, 27 May 2021 07:21:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT038.mail.protection.outlook.com (10.152.17.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 27 May 2021 07:21:05 +0000
Received: ("Tessian outbound 2cd7db0b285f:v92"); Thu, 27 May 2021 07:21:04 +0000
X-CR-MTA-TID: 64aa7808
Received: from bed29a8ebd35.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 14DAB6F6-9325-4846-9F0E-CD71AE4D029F.1;
        Thu, 27 May 2021 07:20:58 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bed29a8ebd35.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 27 May 2021 07:20:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceUEZtY84H0qOvXTDv7te3oEN1/Akc5hHQb3upPZfN4ekyB8Msva5X94K/rJ7sWMVX3qbWP7quvDITjfv2mm3XYM0U20xVTpCXvtjYfSy2RIdoXvRXC2so/sp4r1+fURrqmPNmJPzbJrv7Qo2WWHHtHguJHwgOImudHZYwPknoAm3gpvIsvm0W+5yso+Rl8u48Y4UaxQfaKcP76gAwkiCh0Eo9MhY8qUaZTDCi71o8GwLp+X+BX/U9waD9ZIMCndjz6cpaRLFYqVFrGn8EeRGg0HU7osPw4i1vyPuYMRaWGVk6JIZ/z09JqPffKcyFxq68ryQ9SQCQTK5cbeO5/2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJuNE2H6vnD5ufvgoG30VxV+PHglVtOiUeUWisNPdyk=;
 b=B+CgY+v6P7zMLVXSxNFTaFczSBWcu8VmWDbgYW9SYXwi0JN/1GPfl86KrgPTVuT/d3xEJ+d2t7mf7vE5ucDmes97V9m1t6Wd9b6M1zOftGxm4UT2U00lpRuzQahkZmOL4wIzoOmO77X8P9pnZWgoxZDFXw+HxVRovCT4jwx9kbaLTM8SV+7n+vff2nuvZk/lGEy1iByhz87EN5KUQlYjwFPW7bO1mxg6BDumAEE+DdtsUdhoeAkTvMUFs0r+PQh1muZScHuWOKwPYYGWlwvU1l6yHeh6Fpa8Odu3XxBs3wtrVXXW85r6X/4uRmdKmqXj7ZwLJApexhrFZ4uyIIuJQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJuNE2H6vnD5ufvgoG30VxV+PHglVtOiUeUWisNPdyk=;
 b=3RiN7Sc33aj5s8OeWmGzLDIHo/aL/CNE1cEvRFvcxZ7VXvo38vaTwa4QwlWrDtIvcQARpM/cuhClLU4ZvEtT5GKzL+QYb6dLYzVhZ00VWLM/JWHBRNjOA1UOHcAOaKYWyqcIfRK4pIY8sqGGHSThjOJYboeD/UVAzC4/V5Occno=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB3701.eurprd08.prod.outlook.com (2603:10a6:20b:8b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 27 May
 2021 07:20:55 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::18c4:33fd:d055:fe60]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::18c4:33fd:d055:fe60%3]) with mapi id 15.20.4173.021; Thu, 27 May 2021
 07:20:55 +0000
From:   Justin He <Justin.He@arm.com>
To:     Petr Mladek <pmladek@suse.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@ftp.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>, nd <nd@arm.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH RFC 2/3] lib/vsprintf.c: make %pD print full path for file
Thread-Topic: [PATCH RFC 2/3] lib/vsprintf.c: make %pD print full path for
 file
Thread-Index: AQHXRAXYXXPC0EmBBEyQJGN5Io33+qrcshuAgBpUD6A=
Date:   Thu, 27 May 2021 07:20:55 +0000
Message-ID: <AM6PR08MB43764A5026A92DEF45EF8DBFF7239@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210508122530.1971-1-justin.he@arm.com>
 <20210508122530.1971-3-justin.he@arm.com> <YJkveb46BoFbXi0q@alley>
In-Reply-To: <YJkveb46BoFbXi0q@alley>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: B9E40A74B42A2E4F9A7CEA25BEFD3D52.0
x-checkrecipientchecked: true
Authentication-Results-Original: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 1dec4e46-7e97-4a7d-5381-08d920dffddd
x-ms-traffictypediagnostic: AM6PR08MB3701:|HE1PR0802MB2553:
X-Microsoft-Antispam-PRVS: <HE1PR0802MB25534905C2E5DFAC16B4BB7EF7239@HE1PR0802MB2553.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: wv8ODY2ZHv4XM6sbE9Ef7eewRYyBTsMfO1jqHhgy/aJla8vCpgYic18G4porW0fY3EJye2w3pdeIeglnDPG4DP6AzEVTaesvhlLeNc81UbeDRqzzeoDBeb2V4gePuJVbDiqPNfk0b9seVM3xWtbte9Wef1BxwDChcTqR/vWonQS2mKk3b9yGPn2n4AC2BJDGqsWc4hjXEZePB3VXt6y0R8EtyRwHtFtQdn0vH3o2jDGl5X5z2JWbe+cZlWZQ3+UPnHcmAeWlDFelZIMLEfeVFqyv8vVxGeFDyXbsHWRWBYIzLJlqPiAVCFRSz4Uh/CFI5En6j2QEJ0VwyjXp38cmcSZPPiLnIOE+ZxumJpbMHDtyHs4ivnSlNkMbPNoJyq6o18xbx3eFCLIOguCRCIEHOjuubxqQlCt2LCFHuhMzJCftMUi4i+8fwUE/gI01qcwP+YUidOqsiPoNg8cEN187YtFRM5QluEM7yde6komPmsMawrTDxPemr3RoWenN+At21o4sBoCrN8jt66UUtP6MuChvI7mnydHfM8lkKM0HW9o/sjzfZdwCpZQQyxkI+UGtt3ZnLId/U/2AeicVNt7q8/Gs+lrYsFZFh7itfuatDmA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(376002)(39850400004)(136003)(66556008)(71200400001)(55016002)(2906002)(83380400001)(33656002)(64756008)(316002)(54906003)(4326008)(53546011)(66476007)(76116006)(66946007)(6916009)(52536014)(6506007)(186003)(66446008)(5660300002)(38100700002)(122000001)(8936002)(26005)(8676002)(7696005)(9686003)(86362001)(478600001)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rneY5Kb6Mw3jschI6BdeTnUR2BzLypMjGb85EPxe2GcS5Bz/myAdMlim/cUg?=
 =?us-ascii?Q?1FHmR2ycrKgkbZRUbmFQqeKuyi8+o4iB1Ww6KQHCA+74pSt+5NwfZ3OAkF9l?=
 =?us-ascii?Q?n2PffjzRlUrqysfOj+DWawKRpD+DytCBQKO7BCocFTQ/OTYq5v3RWcLk6tem?=
 =?us-ascii?Q?+bhPS4kfJ42iLQUZMrFDp1y0wTlHBObgFNe5cQyNLfEs6sdPXpyr+90C563X?=
 =?us-ascii?Q?DXFAsLAcIPixeQ9KcB+m8vJY43XTIhphTJlygEzH8q2oy4owTSK0GhhKo7qX?=
 =?us-ascii?Q?I7nD7vJN0TDZmrmmZfQD9RODl+TpTnjKVX9aLZU9UhWCzTaEf7JljCqjL3PI?=
 =?us-ascii?Q?O1KCCrKt/tf/yI0PABeOCLDQqOi5Jp9U7UFCuy9ENxxR6xZ/f1kevh/xyku2?=
 =?us-ascii?Q?l37BeJEuGSwdkgUnyx5SkyVB/4TYj4cvQttSMEeUyKRst7IaS/TiPKe1Q0s3?=
 =?us-ascii?Q?ohDmscc2dX7A7GMRZJ1hmiHKgcKGroUKRwE3aDD/vpU+o/IJ2UUus73Ev99Q?=
 =?us-ascii?Q?+LGmG/K/yEygTULrxMoNB330aKdNHK+mKw5CC8v8MzRZouMapYw5dlwP0Pi+?=
 =?us-ascii?Q?orn6s6NLoYuDXSCff4c3WPLzZSi/XNCi2agE3VhkXXVuZ8K1AHlEuerO0cr1?=
 =?us-ascii?Q?UoMQpb6+lk88RiM1bwVv7ZmVU8Bad0aYxKQvcAWk9c83l0Gx4ejOuN+JURBC?=
 =?us-ascii?Q?d0RNbCyH9WZv4Cd/1oRSmJXQMzcrxdEburItZ0Fkl7DQtK9lFf5DWd2nc1nL?=
 =?us-ascii?Q?hISTCrWi9VfXnwCWSpKyEtYsaVNRfAYFtBRvuqEdGcnKqOjRg5sdXboGk7cB?=
 =?us-ascii?Q?viPK14Uuon18z4fyCjAZ4mPXuPFHZQGAdLXRvqhf6RtdTHWi+FPnxt1I+deQ?=
 =?us-ascii?Q?6qIgXu6esE02FeR8An4DFTl1C7laejsHOL9uRqvSiZoa1B0X4TMOFL6zRBua?=
 =?us-ascii?Q?ke6Prra9AeY745PsiZ5SM6TkK+X+a41RUlMcsPgji1rHVJ2uaDEYFRglUnMQ?=
 =?us-ascii?Q?igPysMyzYfiLkQ4CTGBfQAlwHFCYVHk1lwS+caACAgW7yVRS0ElkCFJ78VFB?=
 =?us-ascii?Q?l4i1fAQjiXYElHdURb+ikDB9s4PqcRo250JxBnQUhyA18aH7JlxL0za1i2gZ?=
 =?us-ascii?Q?StQPPypBgRcO8INeLnn0jdEqYXn7dPmg+c9cw9sxxmYCn0OV6/ElhUlvli5N?=
 =?us-ascii?Q?JSj7/RnHvrB4C9uVjhWk7fGI5nZ4p46o+KtCivu6pPboWIesLikPrMDg+oql?=
 =?us-ascii?Q?nsqC70ZW97g6RiOte8c2+kd6EHu3BRMeU9jdMbrvn2DMik6FqPtIytrccxAn?=
 =?us-ascii?Q?FuXnLcxfiJfgTVzWjvAspgms?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3701
Original-Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT038.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0732b47f-b32d-46d3-8d42-08d920dff7e6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9zjH96raFFhDJsvR0NXsywKFhfegR/DPOvTSFox1uGQJHj7v2KAQ+zcus7PY5nStkUF1trZF6zVTuyMslDbqG/t5cChKTxwzxss+31HVIQZBKTHlLEm5R9qeYvJ83ogv7ndGWT+KEeT3o6zt7FRAB+NIxgvuW8sw8jSATQ/nRuq9vIUqBwqh4yh3S86jbz0GNJnaXdTxAIm45lLKc9L7pPb+apSTM2+BtGZuA+r0Z8m1k16mO3rH9+iRNzaD2tFIcfP6tnkGGDx/YS7+dxyVRdEedLWKyNIhNwxGPmoSQoTXsxDVQoOkLYHPYYfZefqJ/c7MoHvR0B66vRhQ2piBjDtPi6zL4O+o0Z+uySK2JBtWlI45Mi/3Qf7dcnLqwSVC8saJQw73ytqfugLkH08FY7xcDBM7qVax8ao3PVEkKs8c9FgMgRk2sih4Yq4s2LD73ZupYOgdM/FBctqdatsnkrSFeHrHopU+6/0Aut+45lkB4L1NlfijDOCFL2zgJq5UNicGpLHQ+pkDVKY+1coIBo8XIhTuBo3C5ql91BQmVTCDZ1rgeAO7pIM264piU2lV8pOYpZdf/GlFTfb65w/6m3pnBdwiiIkE1Y9oS61GLyX1CcvppQ0LnfGPJjAP6XjY6iTevafa8gyyppMh3i6fJPUnwUkCdrSAgz1V5QkAlQ=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39850400004)(136003)(396003)(346002)(376002)(46966006)(36840700001)(53546011)(26005)(6506007)(7696005)(478600001)(86362001)(36860700001)(6862004)(8936002)(450100002)(5660300002)(4326008)(54906003)(2906002)(316002)(47076005)(52536014)(186003)(83380400001)(82310400003)(8676002)(55016002)(9686003)(70586007)(70206006)(82740400003)(33656002)(336012)(81166007)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 07:21:05.7182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dec4e46-7e97-4a7d-5381-08d920dffddd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT038.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2553
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Petr

> -----Original Message-----
> From: Petr Mladek <pmladek@suse.com>
> Sent: Monday, May 10, 2021 9:05 PM
> To: Justin He <Justin.He@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>; Sergey Senozhatsky
> <senozhatsky@chromium.org>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Rasmus Villemoes
> <linux@rasmusvillemoes.dk>; Jonathan Corbet <corbet@lwn.net>; Alexander
> Viro <viro@zeniv.linux.org.uk>; Linus Torvalds <torvalds@linux-
> foundation.org>; Al Viro <viro@ftp.linux.org.uk>; Heiko Carstens
> <hca@linux.ibm.com>; Vasily Gorbik <gor@linux.ibm.com>; Christian
> Borntraeger <borntraeger@de.ibm.com>; Eric W . Biederman
> <ebiederm@xmission.com>; Darrick J. Wong <darrick.wong@oracle.com>; Peter
> Zijlstra (Intel) <peterz@infradead.org>; Ira Weiny <ira.weiny@intel.com>;
> Eric Biggers <ebiggers@google.com>; Ahmed S. Darwish
> <a.darwish@linutronix.de>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-s390@vger.kernel.org; linux-
> fsdevel@vger.kernel.org
> Subject: Re: [PATCH RFC 2/3] lib/vsprintf.c: make %pD print full path for
> file
>=20
> On Sat 2021-05-08 20:25:29, Jia He wrote:
> > We have '%pD' for printing a filename. It may not be perfect (by
> > default it only prints one component.)
> >
> > As suggested by Linus at [1]:
> > A dentry has a parent, but at the same time, a dentry really does
> > inherently have "one name" (and given just the dentry pointers, you
> > can't show mount-related parenthood, so in many ways the "show just
> > one name" makes sense for "%pd" in ways it doesn't necessarily for
> > "%pD"). But while a dentry arguably has that "one primary component",
> > a _file_ is certainly not exclusively about that last component.
> >
> > Hence "file_dentry_name()" simply shouldn't use "dentry_name()" at all.
> > Despite that shared code origin, and despite that similar letter
> > choice (lower-vs-upper case), a dentry and a file really are very
> > different from a name standpoint.
> >
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index f0c35d9b65bf..8220ab1411c5 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/string.h>
> >  #include <linux/ctype.h>
> >  #include <linux/kernel.h>
> > +#include <linux/dcache.h>
> >  #include <linux/kallsyms.h>
> >  #include <linux/math64.h>
> >  #include <linux/uaccess.h>
> > @@ -923,10 +924,17 @@ static noinline_for_stack
> >  char *file_dentry_name(char *buf, char *end, const struct file *f,
> >  			struct printf_spec spec, const char *fmt)
> >  {
> > +	const struct path *path =3D &f->f_path;
>=20
> This dereferences @f before it is checked by check_pointer().
>=20
> > +	char *p;
> > +	char tmp[128];
> > +
> >  	if (check_pointer(&buf, end, f, spec))
> >  		return buf;
> >
> > -	return dentry_name(buf, end, f->f_path.dentry, spec, fmt);
> > +	p =3D d_path_fast(path, (char *)tmp, 128);
> > +	buf =3D string(buf, end, p, spec);
>=20
> Is 128 a limit of the path or just a compromise, please?
>=20
> d_path_fast() limits the size of the buffer so we could use @buf
> directly. We basically need to imitate what string_nocheck() does:
>=20
>      + the length is limited by min(spec.precision, end-buf);
>      + the string need to get shifted by widen_string()
>=20
> We already do similar thing in dentry_name(). It might look like:
>=20
> char *file_dentry_name(char *buf, char *end, const struct file *f,
> 			struct printf_spec spec, const char *fmt)
> {
> 	const struct path *path;
> 	int lim, len;
> 	char *p;
>=20
> 	if (check_pointer(&buf, end, f, spec))
> 		return buf;
>=20
> 	path =3D &f->f_path;
> 	if (check_pointer(&buf, end, path, spec))
> 		return buf;
>=20
> 	lim =3D min(spec.precision, end - buf);
> 	p =3D d_path_fast(path, buf, lim);

After further think about it, I prefer to choose pass stack space instead o=
f _buf_.

vsnprintf() should return the size it requires after formatting the string.
vprintk_store() will invoke 1st vsnprintf() will 8 bytes to get the reserve=
_size.
Then invoke 2nd printk_sprint()->vscnprintf()->vsnprintf() to fill the spac=
e.

Hence end-buf is <0 in the 1st vsnprintf case.

If I call d_path_fast(path, buf, lim) with _buf_ instead of stack space, th=
e
logic in prepend_name should be changed a lot.=20

What do you think of it?

---
Cheers,
Justin (Jia He)


