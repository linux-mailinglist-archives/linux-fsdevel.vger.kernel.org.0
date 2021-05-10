Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01853790C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 16:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbhEJO3x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 10:29:53 -0400
Received: from mail-eopbgr130082.outbound.protection.outlook.com ([40.107.13.82]:47175
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233920AbhEJO1H (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 10:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3BSicYMcvoajHfDcoz80yb8xKG24sxIPFQbHFxi63k=;
 b=vEe0MOOnluJO6vBFxvPHMFeiNnIl80CDo6EahN1CaMZhOW5kEm/QYkLZT+sbP/DL/m4mY0Df9oJRXWGm9jG6CqWrLiK14XC1TParg+T3egtaSonsgF/tZwn2w2JBorY86SR1ZqcGRwvNKUZe6fuHgfRLkMqLrU2HEsHXDkPmnDI=
Received: from AM6PR10CA0055.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::32)
 by DB6PR08MB2646.eurprd08.prod.outlook.com (2603:10a6:6:20::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 14:25:59 +0000
Received: from AM5EUR03FT021.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:80:cafe::74) by AM6PR10CA0055.outlook.office365.com
 (2603:10a6:209:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 10 May 2021 14:25:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT021.mail.protection.outlook.com (10.152.16.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 14:25:58 +0000
Received: ("Tessian outbound 8ca198b738d3:v91"); Mon, 10 May 2021 14:25:57 +0000
X-CR-MTA-TID: 64aa7808
Received: from 3fb194ef07ab.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A6A19080-8AD6-4E26-98E4-776443C933BE.1;
        Mon, 10 May 2021 14:25:51 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3fb194ef07ab.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 10 May 2021 14:25:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/vtjSUmKQhx1HgKDEgihxGpZePx62BkcaLIchnailkpilFz/ogY9JjizYdYZVJs+a4CGCsm7wO3hwIk+Xgb69MSXP6YyvZb5jwColsi55y4H+rkXPmHSBIJlRfqfhkJdQhKFMyiw4JTuurEOLddsQoTVIyDkH7KQuANk/dAr2UPguitWSwm8Rb/myGCWAHSN7aeZZXfw5DX+CUaIRPPTms2rfBe/DqFSNgCff1cxiz9U0I3+eb0yU5LisVV5Ya6wETWK1+38OzZBVDWm4S5e5GOgB3jhY7iht/kweBliQnMYmrFRphfFNHrbCtqP8gFbMy+iGHKvyP16awaxOU+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3BSicYMcvoajHfDcoz80yb8xKG24sxIPFQbHFxi63k=;
 b=H1gWFwXyp0viZkJBzSA69PdEyT9qKWy+vwSE1BukjIL4AIxhQcN8KyG6zr4hnN6CuuPUJ4lSDDJ4LD2M755vW5ml3ja47aiYSH75fF8tAgqb2AvBVbVH7cWWt+if0DcbguVQKm5/I56BxNPjgzHA9YLcHUQtx4WZ9ZKtFMt2xDyapbrRor+MyH/zTpxlHWMLiH29QmRsu28VzDHFlfi3CGN+F6zMsWZwFeNvhZoFILEY6V4DAs+7y6McenM+Fs4XnKP5j9SOb3Oigl1iUwGcRV3JigHfVlZUYnYxXjoJn2g3mxZSke3gjMO6N2IlZhduXEEmLUYKzO3NR+Tafgr2qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3BSicYMcvoajHfDcoz80yb8xKG24sxIPFQbHFxi63k=;
 b=vEe0MOOnluJO6vBFxvPHMFeiNnIl80CDo6EahN1CaMZhOW5kEm/QYkLZT+sbP/DL/m4mY0Df9oJRXWGm9jG6CqWrLiK14XC1TParg+T3egtaSonsgF/tZwn2w2JBorY86SR1ZqcGRwvNKUZe6fuHgfRLkMqLrU2HEsHXDkPmnDI=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AS8PR08MB5926.eurprd08.prod.outlook.com (2603:10a6:20b:29d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Mon, 10 May
 2021 14:25:48 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::18c4:33fd:d055:fe60]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::18c4:33fd:d055:fe60%3]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 14:25:47 +0000
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
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH RFC 2/3] lib/vsprintf.c: make %pD print full path for file
Thread-Topic: [PATCH RFC 2/3] lib/vsprintf.c: make %pD print full path for
 file
Thread-Index: AQHXRAXYXXPC0EmBBEyQJGN5Io33+qrcshuAgAAUt7A=
Date:   Mon, 10 May 2021 14:25:47 +0000
Message-ID: <AM6PR08MB43765336E1FC632F2587D44BF7549@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210508122530.1971-1-justin.he@arm.com>
 <20210508122530.1971-3-justin.he@arm.com> <YJkveb46BoFbXi0q@alley>
In-Reply-To: <YJkveb46BoFbXi0q@alley>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 3DB09D195990054A9148DEE576EB618C.0
x-checkrecipientchecked: true
Authentication-Results-Original: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [223.166.32.215]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: bfa5c6d7-a481-4417-d048-08d913bf87ba
x-ms-traffictypediagnostic: AS8PR08MB5926:|DB6PR08MB2646:
X-Microsoft-Antispam-PRVS: <DB6PR08MB2646BE11A99E6111FE8DF4DDF7549@DB6PR08MB2646.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: b0AWTPUA0nAQbSsO+Xp309BLgFWly512Jy0PCU9NLoJBkeYfSCgMVXGyqndXzTbLrMq3y2OXDRpKWb7xI4n9J6k+2NI7hhMso5ye1LhcChV/4AuZEOmonGCystf8zX9uBMNhZCiNilR8GAOJ0s0kZMb3cI1GAGfHMHiAjLRPXUyOiB71eUo0HjFCT94jlIKeSGBxf0vjfsWwgbcnoK0+LejXLSF+MlwlqFFKIfWK2wgWc4WsAX5LyTW2TFFJgKUgDpOCYdLygxbIZFZBmr3qAMqg2+aqLgcOIwFt/np2htCBndPe3XQaDgcPtyks1XmcpWeSVxzzNhImNUbhPWMY12WG2El6ao2rZQZUbHA883X6gL9B4PID3iU3IowxWy+yVIUbziwvVUJaayzUUI0iOhfwYHFHIGrp0bwCSjZ73S1NcMBsxl1XEEGLAjBCeSPlpVYn/Tp4C+/u+8y71O0DYfOzIA+GfIudFxyeo3X1pnnjpnAbNLKiZMWuRAaU1irWcd6C5RSLvNK4cGKPIwFShn66ftRBBPGnJ4VR+oSr9DyNeagKxLkGnRWmzyIWOarYc2IhHyrkh63g+uo9UGDYwUaCGZaaxxmWFnyCeXsgwJE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(366004)(376002)(136003)(396003)(8936002)(52536014)(66556008)(8676002)(66446008)(66476007)(64756008)(478600001)(2906002)(5660300002)(33656002)(316002)(66946007)(186003)(6506007)(53546011)(7696005)(76116006)(26005)(86362001)(7416002)(83380400001)(9686003)(38100700002)(6916009)(122000001)(71200400001)(55016002)(54906003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MYt8eNVSQiwuf5GR/QZ/QPrz/i84BmekvmpD5suAn7zaWyk25b7jmjkA/cdy?=
 =?us-ascii?Q?Z1J9pg4/tlwF/0m09Oy/B4gzHTF23Yz6ZPc/rqsbIDnAtyEoI0DIltN2VQWG?=
 =?us-ascii?Q?9nDPJd46rJ0hQ/Be2JunmiWvTalJu7CLO7lgQ2fkk+X2vK9/icNKNM+su7S2?=
 =?us-ascii?Q?CNU7/oSygehtm6H1Cqs9jiHNWLLTYl0F0hPhOw+dCpubzcd/ex+xyDvTZBx5?=
 =?us-ascii?Q?DoYdDdd/SvfYO9tQitlLB0+9qL0XLEHoBl4X+lqHAUIo6+ylQ4OwGkreBvRx?=
 =?us-ascii?Q?pOLkwIy0AqbJ6cPhB4YEvTp1Em+hqtKhUSUxXyS+oDwmkRq/Rr4x3UlIpcm/?=
 =?us-ascii?Q?syYxyd8QAhOdhKFeWbcFb0Vl0bNkHhGP6enWa0NyuynqwuDll8TOWRoPXxGs?=
 =?us-ascii?Q?wUHPXU4mOVILy/zxebhx8LO4n9I5GiHjRYJMFUJOS64t2y1KQHpQoZbByeE6?=
 =?us-ascii?Q?OZwKPZ3fAUwGiqTSPwezdnYsZEarGVYwBvktuL8HM2gE4OkuZifUaUsaGFjr?=
 =?us-ascii?Q?yHAk6TOIH46khaoglFVVG8gEZjIGxAxbClgKhmQ26oFtnu/jBfGXBY5HJTTl?=
 =?us-ascii?Q?4XYyUJc28sZU4ti5v0RRHxhuqXkL/4GQK9/+AtA0alhSyKS2iB8pq4wxKhck?=
 =?us-ascii?Q?vib+FBp4tTrEH4vvGcWPh5lpCKdBBhmSO+x66UUmFS/pdXmtZDDL+PMH3+hO?=
 =?us-ascii?Q?KipJ9lqYEe5x8fADJMkV1J2YcpB1ZuMiQKYFkbknK7WDgsLAdGIg48HTVXDk?=
 =?us-ascii?Q?r0QpsZBPp6nQ1Dr8nl+J02nIWWHS/WUk5n+4OVtvv2KiWQDpON0lHk6l2Rz7?=
 =?us-ascii?Q?WlHVvxqWUiQnS0yDdZSYH5nIn0Mi3tskIjnMeF9IYEicIwLYf9gJKRiHfcAQ?=
 =?us-ascii?Q?maFopvlZGyQ/nc2zhJeFfgIJqf0g2jTWmwrprNSrk9LdeDGzsMF1IYmXRwF/?=
 =?us-ascii?Q?iDOR/mxEu9cshsofhU681j/+HJFjZeJGIbsadIsp9X6JPNIXoDzMhgpTbKD5?=
 =?us-ascii?Q?PSQcj4/X5yY3QuxUEiqnDd2F8YElzOdRwbtfTilkjwcPdk8FN0Wv43yNwMkG?=
 =?us-ascii?Q?DoZcvHiPyip3wdB5ghEDeEvMRYhw2sAvzL3rb12EpFmBIiGnhepagnppDvv2?=
 =?us-ascii?Q?pLLwS1WllLq6VrPsyiUDJszuxUWvg+5lenJhzlEWsiShkAuy/+ZRrhJdchQo?=
 =?us-ascii?Q?47iU3PeDvY0tEPkx1aURD1BmuVxM5ojZClysRvRJdH7h+25xg71cOtJvjmPz?=
 =?us-ascii?Q?DD6FmGPz8ovEmtEgZMal8z5BqMZPI3C+GQcr03k/F2kj9J9JddSDzcaczkbu?=
 =?us-ascii?Q?2g7ryg9V/ZkF90x8snKWuxb9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5926
Original-Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT021.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: d7d4377a-5850-4488-2fe0-08d913bf8148
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vlbiJohg1HN4r/ifjyIxsKa1gUirfEzUja9SgkzfmZS17sYaKGRaaTS0e54r8XgdcD2yW7DtCX8g0am6X8JESrAKXiri1c9cbSXkdKOFZJxF1EbxFOMwjXVtbg3YhiW4McjCgMm5KXVLvS5xj5G5mjVIVX7luyDwTK81oXVAF/RHL5WlJaLjD5QYQYTw/RGuZyMPYvjN1S0tgqUPKiCUQYta7/hnJ/sXH6SXPcuBvcUTFC5gxM9NbIzPtpJO9kJhwKELnLObKaskYpIIiuFDx2Yc5+HRP3e32XmZ0RRa3qnNSnX+nqf65HXWViPBfpNCloXil3dQadQr82U85grSyzoihJVlrIbTWDskdmQzmD+CkyClhpNRSvM8gxVLdfdwpFI+WKvbiwQ3xumGzKruMz21ZeLULou0iFeVU5y1MtbrSTHYa9sp0cLMbsFfp3KUj+wyOH/pz2O4epbq/0g6O/2pLHoIrvdBpHA3kBxfnJ6uOgqkdIT+Iw1ZoO7sm2ZM72xHzBW6Ro1bU2yvt73D/0BGrh+gcKyWjMQ5cw4guK17BDCgOr3bRcOS4n7lUp3hO22y3Y1sM0zEegnSkwXpTdJeCO8BCQimXv2olZMbUCd72+e5cGVwsVZS/rgTNloUekFY2qilqoy30jNRAkykthGpHIjlB6OHOuxeCJbv96U=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(39850400004)(46966006)(36840700001)(4326008)(33656002)(356005)(478600001)(81166007)(54906003)(316002)(8936002)(53546011)(2906002)(336012)(83380400001)(8676002)(86362001)(6862004)(82740400003)(450100002)(70206006)(70586007)(52536014)(26005)(9686003)(47076005)(5660300002)(55016002)(186003)(82310400003)(36860700001)(6506007)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 14:25:58.5414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa5c6d7-a481-4417-d048-08d913bf87ba
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT021.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2646
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
>
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
> >                     struct printf_spec spec, const char *fmt)
> >  {
> > +   const struct path *path =3D &f->f_path;
>
> This dereferences @f before it is checked by check_pointer().

Okay

>
> > +   char *p;
> > +   char tmp[128];
> > +
> >     if (check_pointer(&buf, end, f, spec))
> >             return buf;
> >
> > -   return dentry_name(buf, end, f->f_path.dentry, spec, fmt);
> > +   p =3D d_path_fast(path, (char *)tmp, 128);
> > +   buf =3D string(buf, end, p, spec);
>
> Is 128 a limit of the path or just a compromise, please?

It is just a compromise.

>
> d_path_fast() limits the size of the buffer so we could use @buf
> directly. We basically need to imitate what string_nocheck() does:
>
>      + the length is limited by min(spec.precision, end-buf);
>      + the string need to get shifted by widen_string()
>
> We already do similar thing in dentry_name(). It might look like:
>
> char *file_dentry_name(char *buf, char *end, const struct file *f,
>                       struct printf_spec spec, const char *fmt)
> {
>       const struct path *path;
>       int lim, len;
>       char *p;
>
>       if (check_pointer(&buf, end, f, spec))
>               return buf;
>
>       path =3D &f->f_path;
>       if (check_pointer(&buf, end, path, spec))
>               return buf;
>
>       lim =3D min(spec.precision, end - buf);
>       p =3D d_path_fast(path, buf, lim);
>       if (IS_ERR(p))
>               return err_ptr(buf, end, p, spec);
>
>       len =3D strlen(buf);
>       return widen_string(buf + len, len, end, spec);
> }
>
> Note that the code is _not_ even compile tested. It might include
> some ugly mistake.

Okay, let me try it together with Linus's prepend_entries().
Thanks for the suggestion.
>
> > +
> > +   return buf;
> >  }
> >  #ifdef CONFIG_BLOCK
> >  static noinline_for_stack
> > @@ -2296,7 +2304,7 @@ early_param("no_hash_pointers",
> no_hash_pointers_enable);
> >   * - 'a[pd]' For address types [p] phys_addr_t, [d] dma_addr_t and
> derivatives
> >   *           (default assumed to be phys_addr_t, passed by reference)
> >   * - 'd[234]' For a dentry name (optionally 2-4 last components)
> > - * - 'D[234]' Same as 'd' but for a struct file
> > + * - 'D' Same as 'd' but for a struct file
>
> It is not really the same. We should make it clear that it prints
> the full path:

Okay


--
Cheers,
Justin (Jia He)


IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
