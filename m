Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69043A775C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 08:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhFOGuu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 02:50:50 -0400
Received: from mail-eopbgr20041.outbound.protection.outlook.com ([40.107.2.41]:4846
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229488AbhFOGut (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 02:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79hpWBAUzSdopc3kjxYA0tcOFGNzTNxbvtk8asodXxw=;
 b=hc3kF86FteA/g6DyH9nrCNtybzBrz/ovkKK0ryt/isQ/F+dmh5lj5QR5NMoM/zC6AQONkZp4dZzXpffjvVMnqaBBfLyAD91VQG2EjHRu6ajDTQF+eHTBJtULHRJBIFSjAi/j3OK4K7yZV7gAGkXxfU0HrY5Kkgs52gVzBYjAvTQ=
Received: from DB6PR0501CA0039.eurprd05.prod.outlook.com (2603:10a6:4:67::25)
 by VI1PR0802MB2237.eurprd08.prod.outlook.com (2603:10a6:800:9c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Tue, 15 Jun
 2021 06:48:33 +0000
Received: from DB5EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:67:cafe::b9) by DB6PR0501CA0039.outlook.office365.com
 (2603:10a6:4:67::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Tue, 15 Jun 2021 06:48:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT046.mail.protection.outlook.com (10.152.21.230) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 06:48:32 +0000
Received: ("Tessian outbound d5fe3fdc5a40:v93"); Tue, 15 Jun 2021 06:48:32 +0000
X-CR-MTA-TID: 64aa7808
Received: from e9cfe43171a0.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3C02F9D0-431C-48BF-B815-EC651D6082AB.1;
        Tue, 15 Jun 2021 06:48:27 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e9cfe43171a0.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 15 Jun 2021 06:48:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPr5aA1NeFKrPTlo9uITlcNJghseo/IsS1qW6X2OyNlguEhG+fYP7SaFSOAk3TYXksGk6TJ4LsiPNdGAgGkxzai4vI3jw5mziWP4ve5CIeV1TX6p1CM9WCdUtg/VjVwQveY4BKWSDLs7FMU4rZgiEE+FJjjYC3kM39xB2hOATN75iMTR5JDB13XFDlk6ToGk0g29lJd6GIjYgz4yJSDddmhUx+W4zrYgscGzyqFmrCVEOqCBS03lLdbRH5gOj2J7xrgXGJRVeW71PTFBDIuudlRPNbsU8/n8XCbIkLQDYwFnUdWnqbA6TqTxWqZ5k0ptdAgbhiPJbZ3QzWpNdkJu1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79hpWBAUzSdopc3kjxYA0tcOFGNzTNxbvtk8asodXxw=;
 b=RkrRymrG6fT732DJnYvs7wGfHaQa3z36ElrXg5WAniHnDgYdo2BQRExyX7oyL5T9fe0Bs4SbYWb7X7cidQRRkXrrwxAuWeYLPNn6k+RSHWoPbnJ2wsA3rWw/Prw8rLcVPknJXquHBieqxg2tz4BPi+8OoRLL0nuc19nQLFtTHhwODA5RiNzgP09d5s9YApNbqwYcL3jzqZ/a0LBM3zEWXQOLmjxlp5R15N4X9CWr5G7rOABTVqHJ2hfZ+xMf74aN9rP3dnf53SlR2hrzgk6m6J8blTXFSLCH5JZCSc+mk8T39P8P7VfY848hq1iFRXH+TUCwXNb4eflu2MULFPx0xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79hpWBAUzSdopc3kjxYA0tcOFGNzTNxbvtk8asodXxw=;
 b=hc3kF86FteA/g6DyH9nrCNtybzBrz/ovkKK0ryt/isQ/F+dmh5lj5QR5NMoM/zC6AQONkZp4dZzXpffjvVMnqaBBfLyAD91VQG2EjHRu6ajDTQF+eHTBJtULHRJBIFSjAi/j3OK4K7yZV7gAGkXxfU0HrY5Kkgs52gVzBYjAvTQ=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM5PR0801MB1921.eurprd08.prod.outlook.com (2603:10a6:203:44::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Tue, 15 Jun
 2021 06:48:24 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 06:48:24 +0000
From:   Justin He <Justin.He@arm.com>
To:     Petr Mladek <pmladek@suse.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH RFCv3 2/3] lib/vsprintf.c: make %pD print full path for
 file
Thread-Topic: [PATCH RFCv3 2/3] lib/vsprintf.c: make %pD print full path for
 file
Thread-Index: AQHXXtruU5AIb64vzESDK9b2+VqurKsTqaKAgAD8LoA=
Date:   Tue, 15 Jun 2021 06:48:24 +0000
Message-ID: <AM6PR08MB4376D26EFD5886B7CF21EFCFF7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210611155953.3010-1-justin.he@arm.com>
 <20210611155953.3010-3-justin.he@arm.com> <YMd4ixry8ztzlG/e@alley>
In-Reply-To: <YMd4ixry8ztzlG/e@alley>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 8D3C38739F093345AAF90A83900F29E1.0
x-checkrecipientchecked: true
Authentication-Results-Original: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: f2665e43-57b0-4561-88c7-08d92fc997a6
x-ms-traffictypediagnostic: AM5PR0801MB1921:|VI1PR0802MB2237:
X-Microsoft-Antispam-PRVS: <VI1PR0802MB223731184C85FD7EB3EEB817F7309@VI1PR0802MB2237.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:5797;OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: PT/zaRwvMaEmpFJXI7zZS+XbSG5nChcqRZRHttt5ySppk3irJz8L0lsgJvrh9pokAUQgrCTqQr6xZpvUZUOAHE/3qVCnmY15DvzB36SNk9l25bBgE7hH1vT9BX27yF5bdFz7BdF8gKSnBz9i9gCkQxxUAACCj3Ce7IwYqmwZkMDWIC5gT6/5mscwRdqguO0eTcHsMnLTtgyUzcfiAih/OZhQA/WWS8v6BLp4CXcIDTQPem7gl8ljggTcfUmgp+wKLfHMdU61WnoMZZqB8gJ+rb7VKyRa3fWJol7UpviSo+Lo9UIZF2tIvc3K+XnXSDlyqDXzPnHP7TFedFlX+lBq45CTh7g58TiXgzK3YpgaGLf66NEbVmjyNk2eZZAJgH40Nt30ZhZvDTDfl+/dYifAcGze8YA+qU3lOJ1uk7mxxu9IQzKoWKeCoIoXARgjAd87EUBeQrxWmQR7nam2TcHCtvPCu1dyXy2hp7NFPJtrpGYHCeutX6dA/ZPcYhKLT3iA1o16ONIK+qxMpbgN9r69hI87Q4muXh9FR7wt7u44NgvXvbp/91vrV3TTzF9RzYbbKJ66qzBW6PKMvO9UwMTfYluooLNLGOMMVk8/aXrO2e2zCthj2SIx3PePG0TM0YMUuGvKrtgTalnUJ9XPVki1mybcPDrwVWYH1t+mdWl+WoMf8Jdh+eyD3rpYtNez32Z1OUgfXL0OM/6rhwk+Ytpd6d/LuLAs6PnEelhsFDS++JU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(346002)(366004)(396003)(136003)(316002)(54906003)(71200400001)(86362001)(186003)(6506007)(5660300002)(7696005)(52536014)(53546011)(122000001)(64756008)(66476007)(38100700002)(76116006)(66946007)(66446008)(66556008)(26005)(33656002)(55016002)(9686003)(966005)(4326008)(478600001)(7416002)(6916009)(8676002)(2906002)(8936002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?whErfcnmDah+eX73ITFQ/OtTbbG9NU8NJEspibD5ybVOdssjHh+3kXtUhymt?=
 =?us-ascii?Q?47MIFOodZzbr0MFJfEPKYOtv/GZprPQVelU5sCkjbu6CsRY4Hn6acDSUcdD9?=
 =?us-ascii?Q?Ax8TM3ABEmnTW2x9C6GSEAAuu0VoV2eIsP/H4chNKKWvW59vAVS/V8bXw4xu?=
 =?us-ascii?Q?chV42hNQyq/bxm4bVCH7Yms88lSXAcVIymdYG57AhPeeKm80pHbl4Xu8chlP?=
 =?us-ascii?Q?3psi4/W8j9d7HdF/atDc7ivLJ+81CpA+ZiaP3DE+dHpIwSGvtYq7QV3Muxi4?=
 =?us-ascii?Q?rbnfAowc98bOj0UAuUyvRG3O7noW46zFuCPF3PH4q++jEc09dN7XlgbSOCEv?=
 =?us-ascii?Q?14U/ilVTnFSKMUNqODym7PFe/fd61xKrPSwpRRDa622Nw+KqRAhgi9bqFOu7?=
 =?us-ascii?Q?BCST0WjekpOH6UzY3ns/4XWB+dVfUeyLqn7Biow7ELTZQ+QWgIuLn8ZBikRu?=
 =?us-ascii?Q?oup2Wlwdb067Rjag235YsaRPUTPIrRsMgWbSnwdXjXv1MEX2fHDR7uAV0fE1?=
 =?us-ascii?Q?p745cNI7DVUiLhk5qwPgE+Ztdvt+doo7bYDXYqsN3tndoiw5BtQUskyw/YYq?=
 =?us-ascii?Q?R97LmK4HwWn9IBd2YAdnZ8jd47Uact8sr/QpQ3GubjXMDeA08Rw3JSrC38/x?=
 =?us-ascii?Q?yonmw2GKY9FHXjAVIZovcIYvnd/ZCxcnweExHSjWVW+5qRWRa2hj6iE+fC8u?=
 =?us-ascii?Q?djqC3sJPQTt2YhD6Y4D2oUc5JB/+ZkKnisW1XBFexQBpvavaL6XjzAiRfU7x?=
 =?us-ascii?Q?7CL/7UCgY2y3c3qG37zLMTeeQSImyFgFPgX3uFWxsBWTMxOH5PVNRkUonfPZ?=
 =?us-ascii?Q?TPHhNllgKQcnH+aMeS9reHy4toYfGr0u9IehjNuAIWA3EyCFmuNq7jYdAUlP?=
 =?us-ascii?Q?yi709yTFrf/6LTnpQbGuD5h+dxGkb+IW2eAwRgE0EMuGjfqZ3XWz0C7+YxNt?=
 =?us-ascii?Q?wEfdbz3ELDLIPoxhWDqJpGGBr+MHeQElQhKo02sZrGQdK0R8L6sFWDsrZc7n?=
 =?us-ascii?Q?GL3TCWa7RTN2nu8AQxSIPJF9aiWkc5DwFKjTcB8t+qaAa4sxP6E1VD0ZWrr9?=
 =?us-ascii?Q?5T4REITx6Fl7rJkiWQREICQR2OAIEaa6I+3L1WLBkaF5FfbRjXPnIcDe0uof?=
 =?us-ascii?Q?kty0ehoDbau6Vxb/wM7cvxMofSPMN1+IwigUprLUFrOTYal+U3+sUZ+MjCvZ?=
 =?us-ascii?Q?WegAgJFFmvxZR7dV9IqghRWYh+Vg9kh0rjFoe+Oe7TezyNY7OoaDuhXDv4NF?=
 =?us-ascii?Q?BEsMmo4kq9s6dAOM45o2XS5d26JkJIawFDLsooCRnwWmfs3AcOXPa7hftuVu?=
 =?us-ascii?Q?zESXBtRkCcW9rHB9zbCKNoLT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1921
Original-Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: a56b8c9c-ed5a-452c-9e8b-08d92fc992c9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Owd/ngbvmQmxgQqbp4tBeYpdEd4/6Bzp1CY70DuL8IHRjISeriUWxAM/xtEukyXmB9Kt2Wft7CngVkr6gc15T6c7s8JTgQV61/o0R8VnF71J82dtJy/zV1BjH0MMKZ2QKTlyFQh2to46Pa5pJz2BMcPY5fsHVtYFRdb24FfQE8f7XhvakonhrrUPV/3hryO0Rr7FOcr/nYQ9z34kQBWXCDxP0IXXkT1hSLmHp6Qa63jDHLDfY0yUFT5lzphnXxo9BC9MijfjyMS9Hb/wX7hfbP6pnIYKOsY0TlZPg9KQ254E99CbpVs0IxQ8IDdNWqRax+/sqFss3fTBTD3qOPG7ijFUPPOHDubK2/q5KEYsPICuPqpPtyTqoe4W7AgCF9Ft+qbMRQCXQQFa0eihe9tN2kBMrQoQl662ywS33KvCaMOCrm3OJzVjFtS34YYKaJSEM1YfC7LNjQWlD+vru4A0nw4E5xV/MYv2ijuXHaPM0H/fTV4ITviGRHrbUcLewrw9HgzOK6YxKkC/sKs5BJPbT+zd7GL0earfizC3J9tSdvFt1uoXaKfOePyLq2MQFukE0QFJLovx+HHJN6/kQP/C+rxBPa8Xg1u0eC+yj/ESym4srmfgmA23oESPZGW+oXNrM3FKHGT/zjo7+wqAPlQTIY12N4fG7WU0HTW34gHYRZ9ZIzc7rAnhWmGb5g2EkyDqg7dT/gaJgKhynI/Cvz1TD2M3dcB7q0Ueu0rxhob4ctq4S68qOhZeB+rB+0KELkS/0013QaLCNCxRDDSB9Aakxw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(376002)(346002)(46966006)(36840700001)(450100002)(316002)(54906003)(81166007)(33656002)(82740400003)(2906002)(4326008)(55016002)(9686003)(26005)(6862004)(186003)(6506007)(70206006)(53546011)(47076005)(336012)(5660300002)(8936002)(7696005)(86362001)(966005)(478600001)(8676002)(36860700001)(52536014)(83380400001)(82310400003)(356005)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 06:48:32.8711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2665e43-57b0-4561-88c7-08d92fc997a6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2237
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Petr

> -----Original Message-----
> From: Petr Mladek <pmladek@suse.com>
> Sent: Monday, June 14, 2021 11:41 PM
> To: Justin He <Justin.He@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>; Sergey Senozhatsky
> <senozhatsky@chromium.org>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Rasmus Villemoes
> <linux@rasmusvillemoes.dk>; Jonathan Corbet <corbet@lwn.net>; Alexander
> Viro <viro@zeniv.linux.org.uk>; Linus Torvalds <torvalds@linux-
> foundation.org>; Peter Zijlstra (Intel) <peterz@infradead.org>; Eric
> Biggers <ebiggers@google.com>; Ahmed S. Darwish <a.darwish@linutronix.de>=
;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> fsdevel@vger.kernel.org
> Subject: Re: [PATCH RFCv3 2/3] lib/vsprintf.c: make %pD print full path f=
or
> file
>
> On Fri 2021-06-11 23:59:52, Jia He wrote:
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
> > Hence change the behavior of '%pD' to print full path of that file.
> >
> > Things become more complicated when spec.precision and spec.field_width
> > is added in. string_truncate() is to handle the small space case for
> > '%pD' precision and field_width.
> >
> > [1] https://lore.kernel.org/lkml/CAHk-=3DwimsMqGdzik187YWLb-
> ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com/
> >
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Jia He <justin.he@arm.com>
> > ---
> >  Documentation/core-api/printk-formats.rst |  5 ++-
> >  lib/vsprintf.c                            | 47 +++++++++++++++++++++--
> >  2 files changed, 46 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/core-api/printk-formats.rst
> b/Documentation/core-api/printk-formats.rst
> > index f063a384c7c8..95ba14dc529b 100644
> > --- a/Documentation/core-api/printk-formats.rst
> > +++ b/Documentation/core-api/printk-formats.rst
> > @@ -408,12 +408,13 @@ dentry names
> >  ::
> >
> >     %pd{,2,3,4}
> > -   %pD{,2,3,4}
> > +   %pD
> >
> >  For printing dentry name; if we race with :c:func:`d_move`, the name
> might
> >  be a mix of old and new ones, but it won't oops.  %pd dentry is a safe=
r
> >  equivalent of %s dentry->d_name.name we used to use, %pd<n> prints ``n=
``
> > -last components.  %pD does the same thing for struct file.
> > +last components.  %pD prints full file path together with mount-relate=
d
> > +parenthood.
> >
> >  Passed by reference.
> >
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index f0c35d9b65bf..317b65280252 100644
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
> > @@ -601,6 +602,20 @@ char *widen_string(char *buf, int n, char *end,
> struct printf_spec spec)
> >  }
> >
> >  /* Handle string from a well known address. */
>
> This comment is for widen_string().
>
> string_truncate() functionality is far from obvious. It would deserve
> it's own description, including description of each parammeter.
>
> Well, do we really need it? See below.
>
> > +static char *string_truncate(char *buf, char *end, const char *s,
> > +                        u32 full_len, struct printf_spec spec)
> > +{
> > +   int lim =3D 0;
> > +
> > +   if (buf < end) {
> > +           if (spec.precision >=3D 0)
> > +                   lim =3D strlen(s) - min_t(int, spec.precision, strl=
en(s));
> > +
> > +           return widen_string(buf + full_len, full_len, end - lim, sp=
ec);
> > +   }
> > +
> > +   return buf;
> > +}
> >  static char *string_nocheck(char *buf, char *end, const char *s,
> >                         struct printf_spec spec)
> >  {
> > @@ -920,13 +935,37 @@ char *dentry_name(char *buf, char *end, const
> struct dentry *d, struct printf_sp
> >  }
> >
> >  static noinline_for_stack
> > -char *file_dentry_name(char *buf, char *end, const struct file *f,
> > +char *file_d_path_name(char *buf, char *end, const struct file *f,
> >                     struct printf_spec spec, const char *fmt)
> >  {
> > +   const struct path *path;
> > +   char *p;
> > +   int prepend_len, reserved_size, dpath_len;
> > +
> >     if (check_pointer(&buf, end, f, spec))
> >             return buf;
> >
> > -   return dentry_name(buf, end, f->f_path.dentry, spec, fmt);
> > +   path =3D &f->f_path;
> > +   if (check_pointer(&buf, end, path, spec))
> > +           return buf;
> > +
> > +   p =3D d_path_unsafe(path, buf, end - buf, &prepend_len);
> > +
> > +   /* Minus 1 byte for '\0' */
> > +   dpath_len =3D end - buf - prepend_len - 1;
> > +
> > +   reserved_size =3D max_t(int, dpath_len, spec.field_width);
> > +
> > +   /* no filling space at all */
> > +   if (buf >=3D end || !buf)
> > +           return buf + reserved_size;
> > +
> > +   /* small space for long name */
> > +   if (buf < end && prepend_len < 0)
> > +           return string_truncate(buf, end, p, dpath_len, spec);
>
> We need this only because we allowed to write the path behind
> spec.field_width. Do I get it right?

Both of field_width and precision:
"%.14pD" or "%8.14pD"

>
> > +
> > +   /* space is enough */
> > +   return string_nocheck(buf, end, p, spec);
> >  }
>
> It easy to get lost in all the computations, including the one
> in string_truncate():
>
>       dpath_len =3D end - buf - prepend_len - 1;
>       reserved_size =3D max_t(int, dpath_len, spec.field_width);
> and
>       lim =3D strlen(s) - min_t(int, spec.precision, strlen(s));
>       return widen_string(buf + full_len, full_len, end - lim, spec);
>
> Please, add comments explaining the meaning of the variables a bit.
> They should help to understand why it is done this way.
>
Sure, sorry about that
>
> I tried another approach below. The main trick is that
> max_len is limited by spec.field_width and spec.precision before calling
> d_path_unsave():
>
>
>       if (check_pointer(&buf, end, f, spec))
>               return buf;
>
>       path =3D &f->f_path;
>       if (check_pointer(&buf, end, path, spec))
>               return buf;
>
>       max_len =3D end - buf;
>       if (spec.field_width >=3D 0 && spec.field_width < max_len)
>               max_len =3D spec.filed_width;
>       if (spec.precision >=3D 0 && spec.precision < max_len)
>               max_len =3D spec.precision;
>
>       p =3D d_path_unsafe(path, buf, max_len, &prepend_len);
>
>       /*
>        * The path has been printed from the end of the buffer.
>        * Process it like a normal string to handle "precission"
>        * and "width" effects. In the "worst" case, the string
>        * will stay as is.
>        */
>       if (buf < end) {
>               buf =3D string_nocheck(buf, end, p, spec);
>               /* Return buf when output was limited or did fit in. */
>               if (spec.field_width >=3D 0 || spec.precision >=3D 0 ||
>                   prepend_len >=3D 0) {
>                       return buf;
>               }
>               /* Otherwise, add what was missing. Ignore tail '\0' */
>               return buf - prepend_len - 1;
>       }
>
>       /*
>        * Nothing has been written to the buffer. Just count the length.
>        * I is fixed when field_with is defined. */
>       if (spec.field_width >=3D 0)
>               return buf + spec.field_width;
>
>       /* Otherwise, use the length of the path. */
>       dpath_len =3D max_len - prepend_len - 1;
>
>       /* The path might still get limited by precision number. */
>       if (spec.precision >=3D 0 && spec.precision < dpath_len)
>               return buf + spec.precision;
>
>       return buf + dpath_len;
>

Let me check it carefully, thanks for your suggestion.


--
Cheers,
Justin (Jia He)


>
> Note that the above code is not even compile tested. There might be
> off by one mistakes. Also, it is possible that I missed something.
>
> Best Regards,
> Petr
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
