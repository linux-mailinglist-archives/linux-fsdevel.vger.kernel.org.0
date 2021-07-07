Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6113BE3F9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 09:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhGGHzR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 03:55:17 -0400
Received: from mail-eopbgr40069.outbound.protection.outlook.com ([40.107.4.69]:16353
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230376AbhGGHzR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 03:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoIdu1Ryuegrc3VqrWaJQuEbA+dHMOpSWZgcBRtIS/k=;
 b=jXV1nslgGR5Dy03UxqkWsb4MnFNaQ1hwR68cLmZKuL4D5q4phfHAovb0wVt9Z34wyEGeWZGhhshJtsFa+O26evL4zc/tGu+zw8gVYJOZK4Uss2DQaCoxCBoP2abfYfUu8IN1WqmBA4XxEBdTg5I9Receko16/gDAPAdef3MYsJo=
Received: from AM6PR02CA0019.eurprd02.prod.outlook.com (2603:10a6:20b:6e::32)
 by DB7PR08MB3708.eurprd08.prod.outlook.com (2603:10a6:10:7a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Wed, 7 Jul
 2021 07:52:35 +0000
Received: from VE1EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:6e:cafe::c6) by AM6PR02CA0019.outlook.office365.com
 (2603:10a6:20b:6e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend
 Transport; Wed, 7 Jul 2021 07:52:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT025.mail.protection.outlook.com (10.152.18.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 07:52:33 +0000
Received: ("Tessian outbound 5d90d3e3ebc7:v97"); Wed, 07 Jul 2021 07:52:32 +0000
X-CR-MTA-TID: 64aa7808
Received: from 0e4eec86f856.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A115334E-A0C4-4272-8091-80E12A2B13D8.1;
        Wed, 07 Jul 2021 07:52:26 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0e4eec86f856.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 07 Jul 2021 07:52:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9dK4rx7cqwJIvTsQSfOGlmDQPftt/WsYwdoPlg/qgaGzqaIa2fPxK9CcTrgPEfjqOE7jMYR+Es0FG/qp/fJaEiNXrsrzRRKUaty6fUqsoqEBH2aw4k/7M1+haSF2RmljZK98T9r+2yk/ozzbDFz+xztpxpWr1BTxmwEX6AeFiyJghh7gWoo+6wIRJne5V3K+vWHj1//t0LYlRZMKLnzj7c8t53SaVO+nxwGbuJUjh/vr9HHxZhLj04z5xEjtC8mKRR/TyCDPLezkC23CIwuqfwK7tmSj7g7RIKM4hHIWFu74zbROqNzPE/LBprHgy9YZpc3IyMP7cPcB4ufKW0+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoIdu1Ryuegrc3VqrWaJQuEbA+dHMOpSWZgcBRtIS/k=;
 b=EXiykzZ24AIODr5prvQPA7aC/xz1XjO/nWZ/lzZkwvT3wt96DKlm8pELb3+oQxpYJahVHk7pPber51PIjr1XsiAhDo8bSvha+uGfxhidt+wuhItS0Y3p1V8CFhMmQZxbq7GSZEKINv8Qyju/yTF80ubAzvnZxeGOe00qDJzTjGpsy2Ylsi6vCrjVUAseKcsknbSG/T46Stuz3jPnpD9t6Gp/bJFKZnP6n/ObClSTtU0P3qM0XlisrNiqg5nva/NKIOhFrlVrgSsw45Sz3PigNb1NVE4F0o3h4tEPtEsc223KeWScqAonQ3XvZBc7jaNAYnkrca+u+7VKQsVzR3Ld7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoIdu1Ryuegrc3VqrWaJQuEbA+dHMOpSWZgcBRtIS/k=;
 b=jXV1nslgGR5Dy03UxqkWsb4MnFNaQ1hwR68cLmZKuL4D5q4phfHAovb0wVt9Z34wyEGeWZGhhshJtsFa+O26evL4zc/tGu+zw8gVYJOZK4Uss2DQaCoxCBoP2abfYfUu8IN1WqmBA4XxEBdTg5I9Receko16/gDAPAdef3MYsJo=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM5PR0801MB1668.eurprd08.prod.outlook.com (2603:10a6:203:3c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Wed, 7 Jul
 2021 07:52:23 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 07:52:23 +0000
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
        nd <nd@arm.com>, "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH 12/14] d_path: prepend_path(): lift the inner loop into a
 new helper
Thread-Topic: [PATCH 12/14] d_path: prepend_path(): lift the inner loop into a
 new helper
Thread-Index: AQHXTEjKtvVhNgjlTUaUZ1wNHwu+YKs3cT8g
Date:   Wed, 7 Jul 2021 07:52:23 +0000
Message-ID: <AM6PR08MB437619B9A8CE98E4EFC34CCEF71A9@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-12-viro@zeniv.linux.org.uk>
In-Reply-To: <20210519004901.3829541-12-viro@zeniv.linux.org.uk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 14E28FB7E0B78F4BB58E949D6763CE17.0
x-checkrecipientchecked: true
Authentication-Results-Original: zeniv.linux.org.uk; dkim=none (message not
 signed) header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 2fb8592d-e09b-4477-249f-08d9411c2e10
x-ms-traffictypediagnostic: AM5PR0801MB1668:|DB7PR08MB3708:
X-Microsoft-Antispam-PRVS: <DB7PR08MB37083288A2650AB3775CF72FF71A9@DB7PR08MB3708.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:962;OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: N5nhb0vOyQjICzMQKjdekHokOmWTBRUi4nznpnvSVWZMFSvrcEr2r5iS+nWREtUGBBYZnfqjxIqiy8ri4MK/rXQsOluiCdCOCkR/n+3fkddUi7a+XoKIr2oD/ZKY5PhPGENilb5mHgKDcNO6nN9yhF8YFfO1CERyPTXRDHDgRCzQf2pB39eG8tUtONBxrkVCnIprmn6ywdWkSjbySv5PKciZBdQc+OrY0hHOmuOjtK+fanZd9hH3OGUSVbF2JPbo8LfNQBCHOaqCHg3gP1z3M/0PCXAXtdd8Yu3hKv0Wv8h5elj7VfrpmgkXZd7S7U0u6Xh2JEbE/eUDevMhOWPONBzZ9nf2PokGx6sK2tRp1etGTTxX3k8wCUaMvZukQadNtHIC4rDdBIqNp8UPNKU8pk+m2wNPklT0d0pc8jG2w9GkXgCNjFkK8/OXiL0KUc6jXjp2qavlmuZJuiHay5nOcISkUoNyAemr+Ud5qrFAdvOabmAfUsWhRDlBYDLO5UrZe/ge9QKxgshFXdj2f4c974VjvV2X98l7ph9Y8hH8vB0CBXg1BgQ73WkgpgUxvA2XZ2RUK0BIlrSBI1Rgohw7fEPJaWo2RDSx2kF5XaF/CbzEdHRN6Ypcy5a73+YKgZCO2qMmxXvOmwV7MZRCEBybWg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(2906002)(4326008)(478600001)(122000001)(66556008)(33656002)(9686003)(52536014)(26005)(64756008)(38100700002)(7416002)(71200400001)(66476007)(86362001)(8936002)(53546011)(76116006)(186003)(110136005)(5660300002)(83380400001)(316002)(54906003)(55016002)(66946007)(6506007)(4744005)(7696005)(66446008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?34cnWvwVdgoAjZlso9dpN0VdM8idz+sQ3n9OeRNj2nt+5KR7RXcyE9SVd74j?=
 =?us-ascii?Q?XE2VnDl4DPW8TqOC3E3fQYinuWJnZXBmH6XIb8lvLK3bnCc3lRGjSdTShpeH?=
 =?us-ascii?Q?J1MTWPaEvGI7xP4qk/B0CssmKUEtZXW9pCRth9nlwI5rwo8G7BW8Rd+RcKrZ?=
 =?us-ascii?Q?HzEKVoUzwhqaoZZ7twQO0kZaWbuRU3Alz4i/wKjRWUVbluzEIlxMgZWE0xzm?=
 =?us-ascii?Q?Ro+/bLX6cmarUjQBFpXR8yYcu45uc9EhJjAiQyogSI67V9SfIPjb5Mxf3kbA?=
 =?us-ascii?Q?yYHeQy//mrq+9xlbjodsHCKJM4dQS1vvCiC52GxlIRXDRQU1VbSxaercxlqj?=
 =?us-ascii?Q?Dt2yuai0TtU0bdQD/Pe1XbTIUVuG8+3uM50wKB8t0s9fMl7TMRs09GIt2pGT?=
 =?us-ascii?Q?FPrxismtfRsmZa5H8y8S9uTnCWJuYkYRolI69CMs124FowQMp6I1SlhU6dgR?=
 =?us-ascii?Q?5YEWhUfsX8muzq11PCT7ptjkZ8MbLIZGkycyVXCocgybkmKmKbO0mxpfqeXv?=
 =?us-ascii?Q?H5KMlwdnmEGWyHLDn/fN7MGAlGEozzPc79jPJqVneVQMgrC2sE+Aty+knmXy?=
 =?us-ascii?Q?a1yhiSNna4SEHLAaaGA2HA7fWilmDbDXJQ+0CiXtxilF8qRboSt0TSnb1U7M?=
 =?us-ascii?Q?n7GxkKj7PyUl9xMvoa6eg9fcoiGkrFv1GbStq6yZvC1lG6DU1fy0Vwy7t5PT?=
 =?us-ascii?Q?SORAIg7XKV8u/iobZLhVpN1i+rcLWKbEcp0lkaQyRxvpVeUnR8lkKQYBwM9f?=
 =?us-ascii?Q?SnuEFnBovnupYkxhWwOG2F/Jo9FEJJ3+LdmORrm2P/zNDuoDtCpDl69zu7Kl?=
 =?us-ascii?Q?OstUTpiLHi35vcq+pxxL9q0c1EbSsUTgRNGzh5m2hP/WIH4yM9DEX5xTJzf0?=
 =?us-ascii?Q?8F1Y+OTlOin8xMGFb2dwJUQn26GeBMddbTko5rrf0YRN6Mm151RlGBaYIbuB?=
 =?us-ascii?Q?C73M9YV38beSjoKiLdib8DFJEkYi3xLVhSI19JkejNJ6xLzZp92GQXr32Gfr?=
 =?us-ascii?Q?6RxpetyWnMj8JhX+mTdvHoObE3bldNK06rwavCYG+1AxuI/LTYpqSoCm4atl?=
 =?us-ascii?Q?x5uJX1PLruQ/6RnA2jtA4a5/dI0htqglezo8HafE/QUYN63gmZopR/dYDH52?=
 =?us-ascii?Q?P775BVi7R1MFgoLhy2fSq7F9SiXXYFYXmO0LzyrOObYppp1lTGQOPqjal8hX?=
 =?us-ascii?Q?xAJ0OBmB+C1OCZa207ev1eRlCkfun/zdzzWv52JOAFwk1nbQoIYpLV67momT?=
 =?us-ascii?Q?cKYzWOxgt6BYBCPPZH9Kq06JzP5Wd4AkVKiw6E7czQUehCdiyrGV0Y3DNwxk?=
 =?us-ascii?Q?urpSEUHoifBeaDw5px/HMJSk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1668
Original-Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 78f637ff-73f6-475a-5374-08d9411c283b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mvkQUZuJrssEYOP6W/vfNcSsDA/v1Z2lio/mycVTQQ/vhBU+ZQnd1E1gdGbb+0/M2KtlNFNJl2fbShvcq+9ioAfcLgaap/R9edrIij40Gd3uFms7oy8p0N/ZXh8SL+pv2gnTWItUBHLzg9Nh/tfjisG86Eov7QaFQlFFYtR5hMVbPHMysgGeijGkYNRAMGOOAjq3wIrQsKcaQiZsPnda0gGqEiIRogITGTBdZPK9hNX2mQ6Ry9k5DiGxbu5RwjvsVsQ1fpP+Rc/dVrEFcLryaHhQyYsuwkWA6K1AzWFy9j5cU89pBDfWJdPVc50VDpgqxfUhCClkLGwwoZTcaxv22inGRTNTB7hQaddEOdqqhjnZav9/6zVACR8sMSdo4sOBMe0N8QmFP1UUhDzeGfBYg6N4udSKHxkpyKBPvohg8YRH8ZbbyDHo4a2URhqNItCQtYwzia72hz7sXp1ad1rjFugtpuRenDsv6wRrzYejunoaSAqq5RcsYpscsQWGQOgkcVzuEBlJ1uEntue48IfCkfB7XLjX6zObzpsw+W5C/vfbbsc8SVuV6+qOC5Pvk5sdXZaQwbqWvl82nRpoeDv1WXgGwFblFSvaIaWrSFHc7uVbtDktfmXPlzz+50mc5R+P9W5Gpo9yayMBKFyoOSFRiwvYUycRh2Y6OACWPCZK9K8KOWn6E6uHjYXNMqgEtRrEAnS1ZyjhlSeu8+hPI+EbwA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(46966006)(36840700001)(9686003)(450100002)(5660300002)(52536014)(478600001)(186003)(7696005)(8936002)(70586007)(8676002)(26005)(33656002)(53546011)(36860700001)(70206006)(55016002)(54906003)(316002)(110136005)(82740400003)(86362001)(47076005)(336012)(356005)(6506007)(81166007)(83380400001)(4326008)(2906002)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 07:52:33.4916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb8592d-e09b-4477-249f-08d9411c2e10
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3708
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
> Subject: [PATCH 12/14] d_path: prepend_path(): lift the inner loop into a
> new helper
>=20
> ... and leave the rename_lock/mount_lock handling in prepend_path()
> itself
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Jia He <justin.he@arm.com>

--
Cheers,
Justin (Jia He)
