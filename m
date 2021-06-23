Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50403B1298
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 06:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhFWEPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 00:15:52 -0400
Received: from mail-am6eur05on2068.outbound.protection.outlook.com ([40.107.22.68]:14112
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229544AbhFWEPv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 00:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXQTScGH5w8hy+luGGlg0YOMJA9Q3UfC7x5V8FRdYZM=;
 b=GMa3f2bFySbzJW32aVXCKupFHxF8A2UEaTvm2vIGWHKoBCRstLhiElQkEtGATtjvTM+YQ78qkd06u1imBEbMaT3xxU5elgh+M5Jbdn5rXNUkSp0CnP4MxoW922LARQ1/mUrii02qwGofa+LZf0du0wAPKZHzBzg2xRAvJWh9j7c=
Received: from DB6PR07CA0105.eurprd07.prod.outlook.com (2603:10a6:6:2c::19) by
 AM0PR08MB5076.eurprd08.prod.outlook.com (2603:10a6:208:15e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 04:13:19 +0000
Received: from DB5EUR03FT052.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:2c:cafe::a8) by DB6PR07CA0105.outlook.office365.com
 (2603:10a6:6:2c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend
 Transport; Wed, 23 Jun 2021 04:13:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT052.mail.protection.outlook.com (10.152.21.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 04:13:18 +0000
Received: ("Tessian outbound 7f55dcc5b33a:v96"); Wed, 23 Jun 2021 04:13:18 +0000
X-CR-MTA-TID: 64aa7808
Received: from bd30e5650d75.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4C862C4A-5157-45FA-9DF4-67F25279EA6B.1;
        Wed, 23 Jun 2021 04:13:12 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bd30e5650d75.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 23 Jun 2021 04:13:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuLcSYMtpAs1G9+DC4MRy4on44SZIYnz3pYpEigjaN1rENyRv9ZfElB/a0kRaKKiID8NAL6VCpR17hXDkpmDUghCjsSlEnNWHzIU7quRYM40nMlHgGJTIZZO1JwKNH/pYi17wCvZML+GXscI/KU4NJBQnzH3A5DjPbB3AzMQRjEOT1ZHkcQaEkQrXRTJ6hn/+F9sQGp2RvBsR8CmdXimYdrwwsJ7L4iIIxaSSpRDQTx9gVUNl2WASFyF7YTftc7avczdtsfo3J2fUAIUg+kvd0aQK/tOi8RC04WKbxjDupTtZ1evwnbpL3TNsCbvfZ+k4Zkxi8vv0lpiooJ7k1uPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXQTScGH5w8hy+luGGlg0YOMJA9Q3UfC7x5V8FRdYZM=;
 b=Iti/qrsB4iC0ltFAOTjLdJvLw2G1DE60oRHU6PXsDw19Hm9dFVM3bdZ4ac839Oi/eoSAfZnWTGGR9t1nncAdWN/o6bBG9Wyy2ShY4LbBLnw1TE5bi2lqVdqviWx1mUuy9+3DfQ5ktTe+vIhFzYYbp45Gi5ZFMI/gNDld8bcE49jfP2MasAFAxaOogwQxJyNra4D9qhEgMnUt9MOhYWqMFjnogyutatP5v9bGmiczJt4RSZXfWBjjfbjRGMXeK66NQKLabtV/TvmEzitpmAeSpMcNWgK6NDv8/UUhy+ucXkxVTAw7XnS3USlmRiphEBoWNI8e2fzAG7Mp90/IQZppAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXQTScGH5w8hy+luGGlg0YOMJA9Q3UfC7x5V8FRdYZM=;
 b=GMa3f2bFySbzJW32aVXCKupFHxF8A2UEaTvm2vIGWHKoBCRstLhiElQkEtGATtjvTM+YQ78qkd06u1imBEbMaT3xxU5elgh+M5Jbdn5rXNUkSp0CnP4MxoW922LARQ1/mUrii02qwGofa+LZf0du0wAPKZHzBzg2xRAvJWh9j7c=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB4755.eurprd08.prod.outlook.com (2603:10a6:20b:c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 04:13:09 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4242.023; Wed, 23 Jun 2021
 04:13:03 +0000
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
Subject: RE: [PATCH v5 0/4] make '%pD' print the full path of file
Thread-Topic: [PATCH v5 0/4] make '%pD' print the full path of file
Thread-Index: AQHXZ3AHJWiBG9+7r0+rcVfArOVycasgGwaAgADhnLA=
Date:   Wed, 23 Jun 2021 04:13:03 +0000
Message-ID: <AM6PR08MB437633FB7FDF81D8F1A96DCAF7089@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210622140634.2436-1-justin.he@arm.com>
 <YNH3C6P9i7xvapav@smile.fi.intel.com>
In-Reply-To: <YNH3C6P9i7xvapav@smile.fi.intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 8FB17C82DBF7D847B02F6574414DC202.0
x-checkrecipientchecked: true
Authentication-Results-Original: linux.intel.com; dkim=none (message not
 signed) header.d=none;linux.intel.com; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.113]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: bed0d970-715e-4cab-c86a-08d935fd3b70
x-ms-traffictypediagnostic: AM6PR08MB4755:|AM0PR08MB5076:
X-Microsoft-Antispam-PRVS: <AM0PR08MB5076CF6617F85D718C7900FDF7089@AM0PR08MB5076.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: gSBaVeXjZFl7oRheTl2gqJfFp0fRHmmLRzLItu6MqfwenlZy35Zh2KQCx3bdcfn5eJvoI3jjQZMGbr+/zY3njlGmv0+Z7+pjVrlFg4TMIZ9K5hTj5kuZORN0Y84fpZjDcARDJ0cWw9M0Rz1575TZUww4VGY+wVIFHzzq6DWBs+BS0muEdqZzCtMW4GVyRHJZJ3EYGjWapr/IAsEESpH89VwudBRuhwFXtc3Csxn/TJtFy80n+v174AWHVYwHY/FHCxp/8jRKXa44HI8/WrZu0rHwvwYkOdHzLakhmAfee3zn0INxYwULfUCY34Rf7r4tH36XFVscRDxNp9rx+LUFRy8gRiLXMv5VjoLtc9qpZ+LhgLoiFsjzlHOdPtTJoVba5x4VEktKxtgLwlrsUk5WYI76yUmefmj2ijKQ3L2vSkKJCiVQft+NaDnlymTmLvjfdW2YJlZIZ7ui9LujUQi6rR6wnNwBnQV8DIalXSAZouevur3bG5B30ueWZNzb9g3AKDD/E1C2wX1JvzDDJzkmmOhYzVSHsWQzKg+l0/FD8mE/y9SZ0pfKC0hft+gXctdPppGhaElUpPabummN994QaqaPx6C2+nhCtYVFvFo2xdxpSqvdaAx0Fw7TEFYCAo42FeOyERtApJTBSBKhQ7JyWEHDquF7434GDpeZEfzWFqJlcaIfFN9Aj3KF8CVRSpeTQYlFYZuzXprqS2Vi59L+AR3bcKH/PFCJFDRwX3fFCTA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(76116006)(64756008)(66556008)(38100700002)(966005)(186003)(66446008)(122000001)(71200400001)(6506007)(66476007)(66946007)(6916009)(2906002)(8936002)(83380400001)(7696005)(8676002)(54906003)(26005)(55016002)(86362001)(52536014)(9686003)(33656002)(53546011)(316002)(7416002)(5660300002)(4326008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2O20J1vwcuVWY/ULdKRPoo4TDe7dJSMlRSw1IL5WbQtue2Wdq+e3YLuTAEYa?=
 =?us-ascii?Q?b7wiBPwdcYfkcryhpI8iqhxHMNSZh7hnED6K33BDUCP/pqtRoy/88O47Za+p?=
 =?us-ascii?Q?OXbrML6Nn9ISOEzTCTdA23W6DBFZcckpeNvToHwAu41XMMkWMa+71Nw7PUXB?=
 =?us-ascii?Q?gHJvyhihiTm7gGjTjz8Q88Ix0DoQFWyRVo4u79ozG5D5Q3kihASAaFuZ7BQ4?=
 =?us-ascii?Q?oiwl813fkpGPki/iaX/fwgXOpTVNgSq0xl9Nj9mwmt+axMUv2/KriclXM8UZ?=
 =?us-ascii?Q?GLw4r+7rhynCRnADx//v+I0bpGxVZBkoq2iy1eVltA/QC0Xw4/tb1Hw7xjdk?=
 =?us-ascii?Q?JiW6goIrvF8SDF3yuSq6WfcO7Q941oV4B3MhewQkM+BLwq4pqojdIwem+vZ4?=
 =?us-ascii?Q?hUXoH/zFdYKtwq6sB9t4f8rj1FHs+NQaqmdeUUS9i47Y4FC2tNO9s23GdC3F?=
 =?us-ascii?Q?zFkffHLS7TXGEmiQ8A7VMXFn00Q2mhFO1n0g2v6wcWIhkvgCJWW+gZheZsmL?=
 =?us-ascii?Q?EfmwpcNHUypEBizjBQOLk5EcqygCeX8Dwo13DtbFv7duKbJMccqNYiBIWHzs?=
 =?us-ascii?Q?U/pBd/fxJnrN3Af11IwV5AQsYD5IysPHp0QV6S+aRPkz6y4RBDR/cZOxQPtX?=
 =?us-ascii?Q?tHhMlgJOy3yh1SuqQTh4KLsFtAQNXUSKduHb1j3+axYg4NfEq8+ov7XgC6/k?=
 =?us-ascii?Q?0lGgFUvgyJ8MAK15Iqdqi7yzmZTVPA55+I9m+f/Ri5b5Vx3G8ufS0TOFFSTm?=
 =?us-ascii?Q?ql5S8L0fj55Sf1ozqpH9BIpHw9frSe03oJ2RB66kp9Y1C3901zcOZQ5Iou4G?=
 =?us-ascii?Q?EZj4/vClh8VdocNDHijPttuGTnx6D2OLRk3LuZP9y0V5SC14mW7a44UoQ9JN?=
 =?us-ascii?Q?4uuqn9Qpuh5l2TYmmXYZPoZfVCrws/3OEKuEn6yR2Fwyed5NeDsh7/jqz7rI?=
 =?us-ascii?Q?4I9H4FPM38z90goEBqdCVMkCn1OYGn1kS87Ufa2pDINzK2diRNV0iCTvWbXe?=
 =?us-ascii?Q?DWFNEy2qZL9VeMlXSYR83ybZivfXToD+zgOBySH+2RMfchk2+/Yl+NzXmTyz?=
 =?us-ascii?Q?Ru5TwKuNZiMs/rCzlRS4J4kVqCyHQgPyVPKxdb8DxSJkoYZYNBbOmisOjEuT?=
 =?us-ascii?Q?0jbb/y0wSCuhAXePrrOzSDvO6S5m/O3exyGjdLNuYOkoOEVPjmUT+t6BKIGn?=
 =?us-ascii?Q?i6BlEimOmyvTHSp57um/i9+3hCULUH4q/AJlVvqDrWwBBvB5Exmw7n/E/P+K?=
 =?us-ascii?Q?vc6M7ol7zUrZehM6tFCNsuz7WOglS8YVhZO7HS9jTsGXm1EKPJEtoN7viFsH?=
 =?us-ascii?Q?/VR0KxlnkRbl8VqYSmCGZJvH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4755
Original-Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT052.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4689b3ae-77fb-4e82-1ece-08d935fd325e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KtO6cVtiOP2X1ElhVQygYNMxH2ejb5SN5oV9EgUXPSFfAn5t+wCFKbc2/eX8m/zIvOY+T+iq6Vog735Azh1vBxVAF3ADrgkmRgZVhRp5EkMRye1PRoLZftbtpKrSxZUv+x2VtyXMZaRyLza0lsW6nf3BWwkk5HTUZjLEbMTmy0Jc7JwS1ddUuFGSnCbzxJxu+/vSjdyTT2FmKUmTqp1W6DOI8r3Awb05raV/uAyqqSTfvvQ6AhmC831xAFCiFSsVsItis3qGmeOccGL5b81tMbzuK0wNfzgJEcliCjIHO8+/6ONPJqKhg7NdQESUdrK10oFP+AH7TAiDTKrcmsdsyY0Ag8goCu8eNe52lVGMZD9FxTYe8v+14jzK5Uzz/okABxLY87SpQ6fYXHkwIANLTZ4rQl8f3OvZqc0JtrUDltcruuut4NNDcOotAIEireRP/qDf6eeBC4hBAa3pI3Mc5VlOPxnZeLkHgGntZzkm4QaY0pE9pJ+hoFCQmaqeYA0MteRErLeBV8Rp6GJsnb3GuznHmMOfblZaBf9Rn7Nu00iFwZK0NF5bJ2ZKL0yhWzef51qB09Jrtty97HRvj2JlUkNkHXIGz9Btzsup32GGs842eIl6+VOx0zpZOSl3JoyTIFObIJoqrujMI0QNQfxMikfKtKfkgYWsaZdI1G/fhWeKWfKyIqSfff+hpcXCobaT8G0/KE1HGDz8CT8Qmg+y0ZaEc1Bt7SRJQD0un21GvXoI8Q0rOz2eHpLnaJz0ofmqyZ2ErYdKngwTK8V2rvWEBg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966006)(36840700001)(70206006)(70586007)(8676002)(316002)(54906003)(8936002)(86362001)(47076005)(336012)(5660300002)(2906002)(52536014)(36860700001)(81166007)(33656002)(9686003)(82310400003)(55016002)(53546011)(26005)(82740400003)(356005)(83380400001)(6506007)(7696005)(186003)(966005)(478600001)(6862004)(450100002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 04:13:18.9760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bed0d970-715e-4cab-c86a-08d935fd3b70
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT052.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5076
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andy

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Tuesday, June 22, 2021 10:43 PM
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
> Subject: Re: [PATCH v5 0/4] make '%pD' print the full path of file
>=20
> On Tue, Jun 22, 2021 at 10:06:30PM +0800, Jia He wrote:
> > Background
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Linus suggested printing the full path of file instead of printing
> > the components as '%pd'.
> >
> > Typically, there is no need for printk specifiers to take any real lock=
s
> > (ie mount_lock or rename_lock). So I introduce a new helper d_path_fast
> > which is similar to d_path except it doesn't take any seqlock/spinlock.
> >
> > This series is based on Al Viro's d_path cleanup patches [1] which
> > lifted the inner lockless loop into a new helper.
> >
> > Link: https://lkml.org/lkml/2021/5/18/1260 [1]
> >
> > Test
> > =3D=3D=3D=3D
> > The cases I tested:
> > 1. print '%pD' with full path of ext4 file
> > 2. mount a ext4 filesystem upon a ext4 filesystem, and print the file
> >    with '%pD'
> > 3. all test_print selftests, including the new '%14pD' '%-14pD'
>=20
> > 4. kasnprintf
>=20
> I believe you are talking about kasprintf().
>=20
>=20
> > Changelog
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > v5:
> > - remove the RFC tag
>=20
> JFYI, when we drop RFC we usually start the series from v1.
>=20
> > - refine the commit msg/comments(by Petr, Andy)
> > - make using_scratch_space a new parameter of the test case
>=20
> Thanks for the update, I have found few minor things, please address them
> and
> feel free to add
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20

I assume I can add your R-b to patch 4/4 "add test cases for '%pD'" instead=
 of
whole series, right?

--
Cheers,
Justin (Jia He)

=20

