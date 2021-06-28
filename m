Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17433B5865
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 06:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhF1Ejq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 00:39:46 -0400
Received: from mail-db8eur05on2063.outbound.protection.outlook.com ([40.107.20.63]:15457
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230203AbhF1Ejp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 00:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMUP03H9YM80GmeaIU4N9k6I0SSwOeOwsIHCw1k8eLA=;
 b=StJTNm0C9yVpqdNCwolgNbvyTbSAbBJMc99pYcpjKcnHV8DZ+nM8mqR5y5Faashuq5OO3sQtKvDWfyP1d3Qrv5VhM+YPdR0ZvPZV7Jws0sjo2lHRhIMMQNbc4BlLuQnlRN3BmpmwdFYZEb1RwD1uO2uIgYdgP+iyn08fkixcHV8=
Received: from DU2PR04CA0060.eurprd04.prod.outlook.com (2603:10a6:10:234::35)
 by AM9PR08MB5938.eurprd08.prod.outlook.com (2603:10a6:20b:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Mon, 28 Jun
 2021 04:37:18 +0000
Received: from DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:234:cafe::fc) by DU2PR04CA0060.outlook.office365.com
 (2603:10a6:10:234::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20 via Frontend
 Transport; Mon, 28 Jun 2021 04:37:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT054.mail.protection.outlook.com (10.152.20.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 04:37:18 +0000
Received: ("Tessian outbound df524a02e6bb:v97"); Mon, 28 Jun 2021 04:37:17 +0000
X-CR-MTA-TID: 64aa7808
Received: from 3e6a3db7e05d.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1102D864-3771-4903-821B-C3764228D75D.1;
        Mon, 28 Jun 2021 04:37:12 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3e6a3db7e05d.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 28 Jun 2021 04:37:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsYOJ8ax3h5niC0mkn59x6+pX+0ktrzLfkcwBNtm/cc4h4YSIAFwwkr5ykpZz3+uwVFEQ4B2B24SBEW1GTn64pP1QgRxYPT81MxhNZZVMUGLbtz9ZW1OSbXHldclIj3sTJBPaasy7an4VfpWTsLjOEjw47xbbsoiYcF7nCpmrEggJ+qAGzzb0ObTPxgVaXGkG+1Ghh3rCyW5nIY0rXQvLIKtfxMYmGL8eK0nr7Cbui5LoT+X6fn00/c5POBE7BSqf/x+JsEnKTHokjJ0Q3/il47jND1PCRwaw/5U+hbYq8Cs7wdgjhuwJc3+sCkC7ntepDnSkV2UBcD8MjA3vRy5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMUP03H9YM80GmeaIU4N9k6I0SSwOeOwsIHCw1k8eLA=;
 b=Ij2nIyujaENempNenXgVsHma/cTktMq2/253DPPXhnlEZuvaGBs1Qs/MbJR7c7cUG2DukVdM4ECZg4T2dnEUzSnj+PLkQTk8sf3KNeRHPAS9J+ZEpE3TYTHnGvzMr9/ugUiSknNxJvBBQN0OiAsItRkEEVtxBoTMl2m8PY/Eax4a+gnF5rW1OWDh8QS7g1EppME9PA6SyUpGQRBGe1xgJArtp5NXTJ5sVnSXR7cNWy7IiInn0FyjVANIEkJSnGydNPyrMgXvHdPxMta+SkhcV8VV5Na3V68kH7S1Y2VRK0ydAw9RVwT3+4FHa7cKze5smPJedtRgVXjw0I6Ej7VnNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMUP03H9YM80GmeaIU4N9k6I0SSwOeOwsIHCw1k8eLA=;
 b=StJTNm0C9yVpqdNCwolgNbvyTbSAbBJMc99pYcpjKcnHV8DZ+nM8mqR5y5Faashuq5OO3sQtKvDWfyP1d3Qrv5VhM+YPdR0ZvPZV7Jws0sjo2lHRhIMMQNbc4BlLuQnlRN3BmpmwdFYZEb1RwD1uO2uIgYdgP+iyn08fkixcHV8=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AS8PR08MB5926.eurprd08.prod.outlook.com (2603:10a6:20b:29d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 28 Jun
 2021 04:37:11 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 04:37:11 +0000
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
Subject: RE: [PATCH 13/14] d_path: prepend_path() is unlikely to return
 non-zero
Thread-Topic: [PATCH 13/14] d_path: prepend_path() is unlikely to return
 non-zero
Thread-Index: AQHXTEjX4vA9qb1/tUuDI9sxRSQuQaspFbzA
Date:   Mon, 28 Jun 2021 04:37:10 +0000
Message-ID: <AM6PR08MB43764423714CDBB0AD406D0DF7039@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-13-viro@zeniv.linux.org.uk>
In-Reply-To: <20210519004901.3829541-13-viro@zeniv.linux.org.uk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 5CFF5222E3F9A64FBA74A44E405E2AC5.0
x-checkrecipientchecked: true
Authentication-Results-Original: zeniv.linux.org.uk; dkim=none (message not
 signed) header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: aad02efe-8844-432b-f5f0-08d939ee6948
x-ms-traffictypediagnostic: AS8PR08MB5926:|AM9PR08MB5938:
X-Microsoft-Antispam-PRVS: <AM9PR08MB593847FD5044E4348376B1F2F7039@AM9PR08MB5938.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:172;OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: zhX4KWjFcereL1OG0b3ylyvf9VZZmAiHeDc5J8aNv0PUXgBdYm1iPu/aUrUqkB5VsyPJGC/zBCvHDv5/IGcDa549uMfSZoner8cVGDAo3vYXzXhcnlkSgNG6gyK+x3I8zhdAG/yNjUKqgpIdSgu1Ipz9uUed+6kB/PD9M4XRo42KtOK11bx0zq7Bx6+5wJZJvNb5RzGUmiUU9bqQQyAs2N8RPMCiHZxQ/yVQTbLTiGpzVtdEzNGBPldmwv1K22qmzE4c77z/zEjMsXkpw67Bz5Klu3gmzQaT9bePDNQXuG51hCCkKCkZhip73uhgSBJArIbA6GXMQ7QHnI449zwH16+98XijLME8JW2F5aJWwCHXf32s9vdMqCEGHZIo2eTsODLEndzqGfEdRMQQvfYorSXIrKJPiooLDBBOZJpVYc0vi9iN+L/OjGDgtv9WvJt9YeIF50saAffhl32m6D6+XTL57M6v0D1df9c3P5r1PGcdKpPv56N2HhYHckU5MMZ5s2H+HrKpwgySw9F8tDIdhQ/wvuQWoHCGE0MeXrRczBHYSbF+u8+ufB3qQJmFPBJC9j/Elzi7bVCnBkCKJWszR2pjypOaPKbkvFtOqiQqIdY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39850400004)(136003)(376002)(396003)(71200400001)(33656002)(66476007)(66446008)(64756008)(66556008)(7416002)(5660300002)(52536014)(55016002)(9686003)(4326008)(76116006)(316002)(83380400001)(53546011)(6506007)(7696005)(38100700002)(2906002)(122000001)(186003)(26005)(86362001)(66946007)(54906003)(8676002)(8936002)(478600001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GhJNmbIoopvlmSj+kWXtQp6RMm8WOlL+Mw6Wvcx3lTafoZXEGvjWRL6YrCP1?=
 =?us-ascii?Q?CliMUM5MwIwc7f21CXpy1BvCyvsKCisAj4Rzplnrg6ooI7z49ZvjG0Ea93lQ?=
 =?us-ascii?Q?WnrevLOsmCQm0ninkVOsEVbANUBG/zSOXUSdky3P3L2opdnB8OWHYyPVHqGl?=
 =?us-ascii?Q?FvINaEXQtXNQ5EaIwgRTMCQbcO+sJBczlGOw7n4cOMIWHPHSSRQp5Jw12t02?=
 =?us-ascii?Q?1T55cfx5yhS7iJoy4XhEAbnKgkwclCeAb6tFeDnWkZfxKoKrnz9uq5/Yc1UM?=
 =?us-ascii?Q?Lyvw/Vvjoa+ErzvhgtTUpqayUXQF+7D8uHOauQBBKWSdpc7NKLH0UMHMqj5e?=
 =?us-ascii?Q?eRnZVYcuY7OV+LakVajx4CLZ6vjFPOu/e+8r7mYATUM2wm6LACMwEa7ifQAI?=
 =?us-ascii?Q?AAFqrMvRE65R2IK7U4bWLmH/xkl+dWi5uawy2z27Tlni98wFjNX9X4uPJgH8?=
 =?us-ascii?Q?YQMUd/RbDtxOpHPcGfkelJIS5xhVd6qxQrZeaMzdLso7C1dzFZ3atAMWjVT5?=
 =?us-ascii?Q?dEnkQSHElbcEGdz4bfxUjBNNUK0ty+opEvKqdwgq9vGmDjgIt3W5ddZ8nKIH?=
 =?us-ascii?Q?luo4ld/JEsVao6dmE1tZ0scGn+OedBstX1xNdrmEzj9MUNDXwOAcjdSUOSxR?=
 =?us-ascii?Q?Kgwq2UpP0dFzAren8tXCgRpftWQhOwSX0jq/Ym/Q3fPojVsRkLas9EYzJYC9?=
 =?us-ascii?Q?hj6Kcpmpd/emoXd+DJmKjgUBGwFtaGwxz8fKHFVT3tg0+WN9IMRyw+FP+hBY?=
 =?us-ascii?Q?EBGLIHV/S34Numk5bd9Seu0Y+RSxsncxtaELxphwz7jIs4sARqvwllfoe4pK?=
 =?us-ascii?Q?uwi2SkLxLsT6ZNkoD+j6oZxnir9Fbqs0PWAN5tj2DO3CqfpJPkMB0C6gQQfZ?=
 =?us-ascii?Q?INa0ri5JmHY8viLnEti1kSecvFDLdireLd4NfLU7z8Sdu6dyOB5Qdl4fFkOx?=
 =?us-ascii?Q?Zn6MAuwtoXPHddlE9fwhLnf/2fLXc1s9K79guSYhxJu7d0i0Nq3ERH5oD8s5?=
 =?us-ascii?Q?aIJ3fVqeQseUWSEftfnl1bfrG0Qn6ddi2pIEKjCrjZoLfHP+GW/e+sWntoVC?=
 =?us-ascii?Q?PGClKNzL6RT5Viy8rjKiE5Bone088wj4WlN8+kvnZp9X3uCEmEswMggOlBYj?=
 =?us-ascii?Q?ZTYIViveD5I2s+KpZzWPmpmoi3GAjNhW6cMgv8chVQTpifjxIfEt3FzOM1e3?=
 =?us-ascii?Q?sdtIIDRTLsc+1pe2WbuMBulFLkbyRFg8fbMC8sGLkWsMsiWQYcAByzEVG2g4?=
 =?us-ascii?Q?kHD3r4GwygJqN+locYs5bojzEWYHaO8sqtAITbrPvVSFEvPkN4du9n5910HY?=
 =?us-ascii?Q?1iQ84rN1sQSqyBsGCj6pX/xQ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5926
Original-Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6926890f-59cd-45ec-092b-08d939ee6511
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KU77HlGZP2OARBdQADkRqol8zF3/b8+xHzhfdplY/9KRekEDaIcg/wg1oMhmblSVZD/tOAJTBbVlbUqUWuWHA6LIk9PHsyDYHP/Cb60a/Rhid1ZxkQBoiBivMzqxRQ+Gv0m8l8Ki6kycj/MDVr/sU2GCg/zV57L9ICyzwexanObcPUT0VyCL0Vp/svGOGIirGsK5THGbdAhxzMX01lXRDMdOQ8lwWFWGrEG0DRl6hDm8aAjes+5W7LuDkgLy5wief+ilexJakzJhDznxOeznvapoODO+bV7Dwpv0bD94e8oYC7KvJsfVSUHPmfsOgvTEzsFJNp1YJJiV74Sid3ATVYg4mRQVLBm7XRjuJD89S8zIRA4E3r5PnzBXAq599fSVi6dAVJd8GDvCOmDCTSaubqI34V4/E436bokftOJnr1XS2tvFsjBn7ZyCPOO6pq2f3khu3ivVd59RLc3F7AI0S8qEffRbC2Kxn/Y3QkEfNf4a89bFeAbA2AoeSvDCatgnE5kkIbJD1rpu5Vfcxd1l7Nz0kFS4Pi3fe/3zNjEXYVWY5lu5/yJtx9bze1kehCzgL2OcnI67p8Zdysis2Uz5t/aPphxyCUwCvsryr9+ZbeulZEjmzLvJKXoaywzrDR/t+z2mmOxHmHE22I20iLfH6g==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39850400004)(136003)(346002)(46966006)(36840700001)(110136005)(8936002)(54906003)(82310400003)(478600001)(2906002)(36860700001)(5660300002)(33656002)(86362001)(336012)(316002)(52536014)(47076005)(53546011)(186003)(26005)(6506007)(7696005)(9686003)(70206006)(82740400003)(70586007)(55016002)(83380400001)(81166007)(4326008)(450100002)(356005)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 04:37:18.0744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aad02efe-8844-432b-f5f0-08d939ee6948
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5938
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



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
> Subject: [PATCH 13/14] d_path: prepend_path() is unlikely to return non-
> zero
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Jia He <justin.he@arm.com>

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
