Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0278D3BE3CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 09:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhGGHob (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 03:44:31 -0400
Received: from mail-eopbgr50048.outbound.protection.outlook.com ([40.107.5.48]:30087
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230409AbhGGHoa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 03:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdC+DUZU992O3RLAS+kVKgeu0zU6S6UxajR3hRgrCNo=;
 b=jverIGN+T6e1WWNuZuX7C71XlopArIdc533hYFKJ1V/PgmAU+h+j6iD2FPH9YsQT79SpI8AMD/vOghWkznIQLiu8XIcHeRABQv9zboa/bXg+CoXXCK3tYFC6un2upxDEUD+RhoKkPPqqKgaN7yGP20Sy3/S35ubSobLugbTILIU=
Received: from AM6PR05CA0004.eurprd05.prod.outlook.com (2603:10a6:20b:2e::17)
 by PR3PR08MB5596.eurprd08.prod.outlook.com (2603:10a6:102:88::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Wed, 7 Jul
 2021 07:41:47 +0000
Received: from AM5EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:2e:cafe::7a) by AM6PR05CA0004.outlook.office365.com
 (2603:10a6:20b:2e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Wed, 7 Jul 2021 07:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT045.mail.protection.outlook.com (10.152.17.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 07:41:47 +0000
Received: ("Tessian outbound 1763b1d84bc3:v97"); Wed, 07 Jul 2021 07:41:46 +0000
X-CR-MTA-TID: 64aa7808
Received: from 657c8e98de47.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 613EA46D-B7D9-41C1-8382-1FD3AECC1C57.1;
        Wed, 07 Jul 2021 07:41:40 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 657c8e98de47.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 07 Jul 2021 07:41:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYeS4R2K1tlKse8F6M+m0O1i6CbI+QSgUgCxu51YW90VKn+ZtGx/0GE2h6lW8ec7gsBRbsxx4uNqUfOnP2iAvMPztyNLXFiztfdialvIj7PcWVCylyem3Jatsb9KjhZvbhkxLcz5ZgDIzSXT9uWhGh5fIn0SHWk57X5pCIWH2XbKtIxAfiNy0Ux4RqxGYYR0PHF1UgaYZRsKtRIOVC+E/6XfrYX7sa7JtmydVtEH5lvZWVnd4sJdyxRL15hXTwbQoAwm8RdNM8JpIkVCJ1TIAaMkHyPvSWwr5XMLiLzFYACjPyGsbU/W9aMpx82gJUly0GkVuiHY7Is+JYuBKLXPxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdC+DUZU992O3RLAS+kVKgeu0zU6S6UxajR3hRgrCNo=;
 b=esIJ5AcIissZoCNTu2dyUpgsrsphDTzIN1yVbMGkcBLeOPMES5KU/IBeEyvLfqb8D8Q5SVpJWPeIJCWrCkKwIql95+oqgp+0afeCbEh6IzX/9eh9fqGHpaGKQO4diJHXvVYPGsmk8ufKbo5R8FL0nmVIyofubqDIpR77ntcgqcsg6Iwr7Ymm3PAa2bo71DBXJshGVw5idDPmJaYRst79XnqBYAmYVF7axtE6LTh6dDsLJ9z9lFPloOcLSi1sXLcVcHcf8E4zVweXFpGqb1zZfuuw0s1mGFEiZeFMHAzr68oAMjqrbCmUVPGQFQKssYEMQAZ4I0Vn60/EPr8pxm5lsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdC+DUZU992O3RLAS+kVKgeu0zU6S6UxajR3hRgrCNo=;
 b=jverIGN+T6e1WWNuZuX7C71XlopArIdc533hYFKJ1V/PgmAU+h+j6iD2FPH9YsQT79SpI8AMD/vOghWkznIQLiu8XIcHeRABQv9zboa/bXg+CoXXCK3tYFC6un2upxDEUD+RhoKkPPqqKgaN7yGP20Sy3/S35ubSobLugbTILIU=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AS8PR08MB6757.eurprd08.prod.outlook.com (2603:10a6:20b:39e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 7 Jul
 2021 07:41:37 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 07:41:37 +0000
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
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, nd <nd@arm.com>
Subject: RE: [PATCH 05/14] getcwd(2): saner logics around prepend_path() call
Thread-Topic: [PATCH 05/14] getcwd(2): saner logics around prepend_path() call
Thread-Index: AQHXTEjJ1/5Mu4j0MECdM08kd9hFA6s3ZUrQ
Date:   Wed, 7 Jul 2021 07:41:37 +0000
Message-ID: <AM6PR08MB4376B429E12283758A372F20F71A9@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-5-viro@zeniv.linux.org.uk>
In-Reply-To: <20210519004901.3829541-5-viro@zeniv.linux.org.uk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: EAB941A0EF841C4DBE2CB402405559D4.0
x-checkrecipientchecked: true
Authentication-Results-Original: zeniv.linux.org.uk; dkim=none (message not
 signed) header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 01101ee5-dd59-425a-41db-08d9411aaca8
x-ms-traffictypediagnostic: AS8PR08MB6757:|PR3PR08MB5596:
X-Microsoft-Antispam-PRVS: <PR3PR08MB55962F43A35FFC8A05FFF054F71A9@PR3PR08MB5596.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:1443;OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 2wZecWBg8tt2fZn8o/iUSyYn+kCnX1db/b9mb0JrCQd6RXGMmC0vJx6oeLgR1aRaNU05SQfa0qLkKPGOaS6VrffvLVeV/VAllSxnomNoUds6fSyQOqOjufAXXLSGqqgqLaSycO3p3H9z8l3arRrhLDoZ+625CrvRirUrAP/EvThUZlZ8rQTTmpYllqa8jxx+QawbsbfbtuDyJUZkPqEeI+qr371wA/8kgdfz6cFLGvljU9mPH3UD7jLt37WdT6Tkn+nzI8PjAchDg9VuDJBr9gTPcOdIbCKNA8dfOKuOT6EPhDD0XiD1nGh3eaIwX1+YPFRbub+szrSNzGe9XT33C3WRXTIvvY5gvJs4AWZa9oBVm+yJ2CWLNAOmCaqU6GhljQRya3eocdGKw6+1JCLfrzBjfWW8a1QSvBCsGvGQ5gl2Uuf9GcV1SAYkeWO7tC1xmUxTnScezXOQIk5KUOATuBm2cbExQES866OcvTcs3+pgFP+1K9rEjupmz15uTokuOhQxYNy4zERUYP4VMgWJy3IUNbNVK/xh+wH4iN9aEcdA0SVU9TYCMBugKiDTRek9DnlG/HyejGQ/mS49mKFPEt3ctxH0+FDKZvkGxB7NA+5HTbAxn17bEQZzQfv9fWpKaISqTOr9HQry9cNaBU04yw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(66476007)(76116006)(33656002)(66556008)(8936002)(4326008)(2906002)(186003)(66446008)(66946007)(64756008)(26005)(7416002)(7696005)(55016002)(53546011)(5660300002)(9686003)(52536014)(71200400001)(110136005)(6506007)(316002)(54906003)(86362001)(8676002)(38100700002)(122000001)(83380400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ViI8JFqgZyFb6euYN7FeOLRcamakQ3fX8r/fL/nkPNjVA4kW8vszQpxvoTRE?=
 =?us-ascii?Q?fjeeBapR4ZZfpw71s3EgdUgwxGxkZwCrohopXOGc7t8SR7+q7+P3TPQpEHcZ?=
 =?us-ascii?Q?0tZqVtBRLQVeutL2Xoe097ufrL4s7+33RCBLKPSM/OgSUizGLtixEKx/LheZ?=
 =?us-ascii?Q?APCzYzwO62Ural6qPugbR8xVsWC7iJC1Kct6ENgm+kBOOud4bwZTEQJVTE0G?=
 =?us-ascii?Q?OTIRT5ZkEE0ZQuL1T0ho2SJjEeIfblwUnN6q/i9yRw0RcSSs2Ca2mDOZHYAv?=
 =?us-ascii?Q?AFkP4/2ZoGGjIBnZ7jGwqKX0TPr4lfI5NsUo3Tw8P87TTkgBotKIv9HY027g?=
 =?us-ascii?Q?+l/t5hqQZ2QwujsS/TPpZfvrLBnD3DsPIj1D5iQ4IXFSWw6r6cAhpd0sAMfk?=
 =?us-ascii?Q?fp1ZOeAUroAvTFMyyJNlCNr/jtpqc0KB1MnXkk82MUjTRxND1NIbKDq6Hg3l?=
 =?us-ascii?Q?wlGvuWmDAgxQT1mrfiO8WeyQJn0DZRER2cEySYBVdfN8aRUy1QO2mn5WXxv/?=
 =?us-ascii?Q?jJVD36hIXaKRLxcskT+IdwQF0xBQoM+M1Drazfhb0fV2N3sjz8X14BPw4yBl?=
 =?us-ascii?Q?mrDiQAkNJ6/BJqnAquaEhnGXYnC968u0+OxubOSlUO0w35YaolkZW5vi3Hru?=
 =?us-ascii?Q?RBhBk2CnTRNbsWJA4jQDhYhvOu68FyUjQUApZ9YBamjFml45l9SzOIXR8qh4?=
 =?us-ascii?Q?nYADCdV1IosMJZ8j+ccMKL0IfFzEeWz8cWWXfJpDb6Uj/vGL8enBN/TSJTd8?=
 =?us-ascii?Q?ha7XUHEXp18xUfdxvbWHY8BOGGKSog1n3dP7MRStnb22VRA2nntqLaq3c+6y?=
 =?us-ascii?Q?mtmVKYfLqC08uWZo2pNqIuwHV+e2J6M7sCvf8m56ovmZ8nbndZSn5sHShztZ?=
 =?us-ascii?Q?qxFWfPrARYo+t4+LaoWciYpt2MUDoPzR1kpYqGBTSSKaEiPCiJsFKxkGTX1B?=
 =?us-ascii?Q?3mliRpkHkREOsRUaVYG8iBXrL/ZRzXi+PWHvXC1odIuxL7uVDKxdzqjCi0yr?=
 =?us-ascii?Q?FF39yxlSELHusB01Z3ajfVaMs4CK9f9SJTo7wmAGvRzv1Q07HKQU7QkmceVg?=
 =?us-ascii?Q?ja2zPFxLQ0DKkQvQa2vbdEKxsQb1c9V3vLZ+mAJ7MNnc8xvBrRSRiqqUKxKQ?=
 =?us-ascii?Q?y4ymyt6Ql3Ex3BfA++PrH7uzeV9Q2JMTRdJhE2sPj9PDJmyLDSQsQqF4+pw+?=
 =?us-ascii?Q?kSGemeh0DkM6SSfclvHlL4bC0lZo172BmOBQP2GVGW5g0u4xOSAeNnhlOrvI?=
 =?us-ascii?Q?p1iotdrse6nRIEf3qHAj/9ZgHHV1CcAw1Zw6vc2A4/gNarjOziy8+mmLMObq?=
 =?us-ascii?Q?SQuOMHx3RIiLmGqlr7T39P7S?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6757
Original-Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 76e12e9e-db57-4c39-2c06-08d9411aa6d9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Bu/LDsliVlyxMaOupS+oyNNolRvoJ763HhQS3Kcti+DUlpQWWCcrJlwsfdtRKN/+uVnKQ9zY19wuq8RXy/jz5hDUbTALPQNjPDkC1GVkaxOmao+J78NACgFhYrHEGKwKbH0NbxI/UfygAoC5i1gVuBzBg7q9/be6vIGZRGKxBvOG/JBeNeGirb4KEHZ6P31MyKzdTF6g8ARAnRJ8bnFT+s43Kjsq5hFcbYRuTyv3pRmVmweSRp1LWut8NesDZINnyDuOtYrm4WjKc88KyJ890QL4ndEWMULIgJB9HAKeS+3pSTLu2jUcsLp61cam0gwjuBhoblsgYZa4F/RHPCdTwGf3u1GYp8TIyaDcNKcPUo8spx9WKqaanjZ84q+8DFFzNjo+o7k6h8CLgeQtbW05nr8qn8jtg8xLzzPnbLPvYy03JmX1hacBfxffzSGKbRQg2hQU7zdjiWHbgIJnQgJ5VuUzf0xoah8lfWPnlyXUaEOPXrMtJX6M/MXLAglpECozzZazGPjjftjc3StsbfSgnFykMUaziJp99FnJCLxxoT9pEzM1tg+hkoVSsq8DFF189ebJhZ2QUMr9pYkqfMNOGvBUSNqgrC652PoWAKWUfjVXkFRhuxajME5QrQMUKcMn9+kJhe1C067X6dVf+Z5NbpPOdhDKHkrW1HRHhYry5qbVWHNnTXpBIrbT/e+pC2cctl/yR2k1E2JCZjqBOWakQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(39850400004)(46966006)(36840700001)(478600001)(81166007)(316002)(53546011)(8676002)(33656002)(54906003)(7696005)(52536014)(70586007)(5660300002)(83380400001)(82740400003)(70206006)(110136005)(8936002)(55016002)(336012)(2906002)(86362001)(47076005)(4326008)(26005)(186003)(6506007)(36860700001)(82310400003)(9686003)(356005)(450100002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 07:41:47.0190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01101ee5-dd59-425a-41db-08d9411aaca8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5596
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
> Subject: [PATCH 05/14] getcwd(2): saner logics around prepend_path() call
>=20
> The only negative value that might get returned by prepend_path() is
> -ENAMETOOLONG, and that happens only on overflow.  The same goes for
> prepend_unreachable().  Overflow is detectable by observing negative
> buflen, so we can simplify the control flow around the prepend_path()
> call.  Expand prepend_unreachable(), while we are at it - that's the
> only caller.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Jia He <justin.he@arm.com>

--
Cheers,
Justin (Jia He)


