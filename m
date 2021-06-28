Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21E93B5892
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 07:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhF1FXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 01:23:02 -0400
Received: from mail-eopbgr130048.outbound.protection.outlook.com ([40.107.13.48]:65092
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229692AbhF1FXA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 01:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yV0lhEASvoYL2rZ7bI6BzRodqewn/SgYJUPPNmQqUcs=;
 b=nGNR5a4oJfMz5NwIWaY578R6XuimfbQ+eFfYpO2u9XWoMqqok2hSymFurdboSJvlJxevWeLQ/5wF0388+fC15uwQGXTII6ISeqMB4yT/xK3ctQdQ/WbI7UKg7IgeiJ/bR5FI/r+Slux4KHUaLtM0GRLlbjCcmB4oC6okm5wpKqo=
Received: from DB6PR0201CA0011.eurprd02.prod.outlook.com (2603:10a6:4:3f::21)
 by PA4PR08MB6222.eurprd08.prod.outlook.com (2603:10a6:102:e9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Mon, 28 Jun
 2021 05:20:31 +0000
Received: from DB5EUR03FT016.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:3f:cafe::6d) by DB6PR0201CA0011.outlook.office365.com
 (2603:10a6:4:3f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Mon, 28 Jun 2021 05:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT016.mail.protection.outlook.com (10.152.20.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 05:20:31 +0000
Received: ("Tessian outbound 507383c3c879:v97"); Mon, 28 Jun 2021 05:20:30 +0000
X-CR-MTA-TID: 64aa7808
Received: from 59ecb98be47b.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 10978956-3180-406F-A9ED-169CA2533FCF.1;
        Mon, 28 Jun 2021 05:20:25 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 59ecb98be47b.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 28 Jun 2021 05:20:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZp/o8YhyilcOA6iyvqbdjVEIxkT7ac1SYocN9PeM2sLyJ2XAAHB3RJnlkf1VP+lhu5HCh0Q0hJXrD1F4lMMmH/PDP6LkpXLsoCF/8mkqk6EQevg6IBPSDOSKoEJwNuQ4qtvTCGKfoVlNFtBDPZPgopOmUicGTPgC11YaainMjRVxb0bFpxq0rgF/NU8tk66Jj7Ad61NStmSPBB37b/hUfXkRCwHAvv8dLSUFDUGQMggpTUwtAiBemBHECFouzSTtiRunkWK3xtiU24+q4kA9bMxr/eG73jST5j8UvJB/i1qGYJupkJ1xXCnv3je6A1s8EmYuLKwZZPhrbLWpe3iqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yV0lhEASvoYL2rZ7bI6BzRodqewn/SgYJUPPNmQqUcs=;
 b=K6oK4qW2c+OBlg/RMiwtDCksMLKe/H+JDHI7laPKWsA/3fnONHysqpyD2LqUPFpf8ALLYebVpZMB737vkH8ZfdNzDJfAFt2ZGw4f/vL8HT/77drUQaODNeFXizmVr9sVPJ/JVm4gEO7uM5BSO3W3sPdepHHRfKUqXkGj5fJgvHMjYg1p1MZig/hbXfMsOFsWW/AM7fMQgolMncT+AGHE7Jd7HDGi4BgV/qzLFtc+pSQL/P2uKsS8/a6Hv1P4P47DeA/Zgh6I+X6r5gKRUejfL7YwY9HO0V+JAd3Gn5x9gaz4hs4KvY4DHmojcnHXW/Jqidb9gesS7zJjXiZFZjoCvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yV0lhEASvoYL2rZ7bI6BzRodqewn/SgYJUPPNmQqUcs=;
 b=nGNR5a4oJfMz5NwIWaY578R6XuimfbQ+eFfYpO2u9XWoMqqok2hSymFurdboSJvlJxevWeLQ/5wF0388+fC15uwQGXTII6ISeqMB4yT/xK3ctQdQ/WbI7UKg7IgeiJ/bR5FI/r+Slux4KHUaLtM0GRLlbjCcmB4oC6okm5wpKqo=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AS8PR08MB5941.eurprd08.prod.outlook.com (2603:10a6:20b:296::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 05:20:16 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 05:20:16 +0000
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
Subject: RE: [PATCH 07/14] d_path: lift -ENAMETOOLONG handling into callers of
 prepend_path()
Thread-Topic: [PATCH 07/14] d_path: lift -ENAMETOOLONG handling into callers
 of prepend_path()
Thread-Index: AQHXTEjITB/V0362t0GPPyDCrpGmgKskqplggAR2vqA=
Date:   Mon, 28 Jun 2021 05:20:16 +0000
Message-ID: <AM6PR08MB4376C948F728D815CA984349F7039@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-7-viro@zeniv.linux.org.uk>
 <AM6PR08MB4376E091A9A84BE1240F3989F7069@AM6PR08MB4376.eurprd08.prod.outlook.com>
In-Reply-To: <AM6PR08MB4376E091A9A84BE1240F3989F7069@AM6PR08MB4376.eurprd08.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 71590C80C8710745B540261F85D47A2C.0
x-checkrecipientchecked: true
Authentication-Results-Original: zeniv.linux.org.uk; dkim=none (message not
 signed) header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 9d0f6ca4-d3fa-48a4-c70a-08d939f47307
x-ms-traffictypediagnostic: AS8PR08MB5941:|PA4PR08MB6222:
X-Microsoft-Antispam-PRVS: <PA4PR08MB6222D3AA20CFF38C03DF4C8AF7039@PA4PR08MB6222.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:6430;OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 7Vw4+zIC9z4Ee7bCCa1CX0fpWeGTlCnYACzhKbb2X6Now90Ytn8M7AXMjZQwS5cRfb1SUpuGfI2nIXIXVRT1gvgmqVAakzCpO0jvqw41PugBLztdoXwtGBhKKSRs5Vl9nqGFLgSxpY+0DGx2PWYQzsQVQIacfUL02r0aDhncd/eZiNuFS11Wwq+aCq7Y51yAQjAoQOgFWqkZdFLuQRv3BCvd2+AKdDisIaCdLb00nFPr11tSPLuG6heI9wgPibFisyhaQAzAio00tfgJgaJcvVpKLtYVp5DJMhi5eNbknubc/wtbIZUUCP5E6rq5JYvpgV/Vb/6+ledPPp8cj00fww5cVZ8CzxbDfakZm5ft8mOm0Xfrtt9NdyXIn+RJAykZ87JrnmJ8XDPPg+uNanjnuzq3w1mtdu+lS7YuwWt1Xpca5Hf8SrG5S2I3O097/qFZX2+DqY7WHNQSz1xtOf3LXg/mFjS1IhRufdA5zf7/hPjGwTx9+7/ujl1EIXs4AGhuQmiLzJDBom3nId8b39UhNY5UjkxxEl2l6XpqhAXua7hf7Rn+c+QfOErztHnNFzp5GXMkausKuK/lW7Kn6n5HJ9UenI3s7dGduE2yLs0r7KbsKutcPsuuuirI2zue6atDwzzmkex5SQmF+rn6Y6wSxA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(39850400004)(396003)(52536014)(9686003)(55016002)(8676002)(71200400001)(186003)(6506007)(53546011)(5660300002)(2906002)(478600001)(86362001)(26005)(7416002)(316002)(33656002)(8936002)(122000001)(64756008)(54906003)(66446008)(110136005)(83380400001)(66476007)(66556008)(76116006)(7696005)(4326008)(66946007)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e9kMkj0bXE6wrCumPlPIyDw7FyRHmLsreaDGJuTpTZJeE53FY6OpEjoAqq1Z?=
 =?us-ascii?Q?OWfmQC8q3ipZXEkRlst9BYxsC9zHyzQrlfc5vuIjJ0mWwFRe0A58sWfR3Wf4?=
 =?us-ascii?Q?7Nzix9UiJmD/E8LCaJmL5B3T9Amz0AfPaAf4Ls8StemYxKg6f86I3hQWxUdk?=
 =?us-ascii?Q?rUZKQDy4baANRrYPU63rx8+bNzOUXubw05NWiixbUkPfnSgVqEQ0OmUCWpmH?=
 =?us-ascii?Q?6G5dd6qJMynQF3b1FcQm9smbIvor/4qMBq8qwf160torCLckB9hyVYdScufr?=
 =?us-ascii?Q?Kd3GxGQ+ryWAJz3CELsroz4fLHHdmbsLGRv0CFs9cca1C3J2y/RV9PohkVxx?=
 =?us-ascii?Q?y4PLbvM0WmszIsda2lLNxjpZFo+OL/leTOBPIBFQkwMJuVg1LljiCCt53ZzK?=
 =?us-ascii?Q?UOhybzoc/ir36MYJh+gYkoyNWVHvxvxJyztjuNN5NIrOgBWtCoZa3OoT/3rP?=
 =?us-ascii?Q?9YapzrGVE7kPT+nuM+xc5gEMRrwkgIfAoAjHdyUBGYMCLxZ7JUV0SDabeT2d?=
 =?us-ascii?Q?qDQWvTYQDBYjFKu/noYeh9Yo5c6u3CmcXR0qsu+n4M5DAWOFKTjq+zk8vJ75?=
 =?us-ascii?Q?BE9AU+dthQDa3af5xx0Vo5ktLn7YGIZB/KI2m6rKB1/bNwHvuGuIl7R3SkHm?=
 =?us-ascii?Q?uscHswAnr1gySs7HJ1Q/pT2fK4uOIC0I7S4VHOrlRRohWGsKSTnSVLUOgQGt?=
 =?us-ascii?Q?f3GGIxl6rhuLagNyCg67/jFuV+IF4X+6g+vEIeAlaQ/uAd5Tmo4Aoessu+tF?=
 =?us-ascii?Q?oo2ABGR/EQasLvSTYD+kRa2vaVWqVm8d+r/n7c4e40ShBi5gtlk7XmlNhxPI?=
 =?us-ascii?Q?1SFY6W4RmAkgdtTi9GN5DP2QUnMUTz3yELrMb4a+tRDlqv8XCLqqTd+fNOui?=
 =?us-ascii?Q?RAqNLnOThdoDSeeyu6OTBuyWRpqyJ3uEZo3RJmVklRe5gGaspaer82nt32hb?=
 =?us-ascii?Q?Rw14mAWOIaUCMjSbgRpnydxHhPDFHxYA263Sy9BU/j+ykMdAAYYCDKof/WxJ?=
 =?us-ascii?Q?mIYm+FwRHcdRJ/EIVIfE1XOlJq2v9GMJsnD0FdjlfoYEnAGiZNVC9SzBtDWy?=
 =?us-ascii?Q?+Tc0CFyIwpWScKaurB9fwJtYb7o3QR4zzPrVke5F9NXNCcdgd10u7tiWwTuO?=
 =?us-ascii?Q?Z3hSlsaKQPBJlIWgengKA9346f5DZgGGpRV8RKCa8LMHMNBOBUtXUn6AHASi?=
 =?us-ascii?Q?v/+TDzR3Lpu6uxklkCUexNb6c4HL4Elemc6VCcGlHn04pFO7RVimmJxgIL6E?=
 =?us-ascii?Q?nxI1/CTRlZfgzL7ifZAVZgSdVbx8M8D5ZndJuJpne7YIQ1SPV6htuo2qEV/w?=
 =?us-ascii?Q?5L6+JR1wSYxOzvrkhkwTstLK?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5941
Original-Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT016.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9589beb8-1012-4093-967a-08d939f46a2c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BgszhnrcS3nDDwr+GW32LAwU3Kt0uIsjMof8Xa/4yyn5eElRBrizrrG8y2ECJ+8F9q8sdlGmcq4R4Fzp+56/idkJXjE6Jku90ctqSYKYSeVaflZK5ff925bHlYlhr+iSxHh6Q7O5Qi4UK/LCCKbhSSuGbLJ+zzr+uazxcWtMcaD2g//gsLiMyE/i/fCMssllWH5GDAd8m490U7NvZ15NNZjRnVcJBNG2jZb5axhJ3FkbRDd83UW4klGWoec1qYC7pVPgOIRFxMHDIpGji/JB08Cr9ctKvTXL7LWnp9++FygHSdm1EbgwQph6pQ3l3Xg5jL2FLFNetfkLkIi2aXQm5tsnrpS4PPtWdu0YHH6HHA5SQNUu0iI3unSg+x28IoIHi/zt+r2kgqhKXC1WjJ4VN4ZQSS53M58SZ3uiF+s62pEhl/lBtvwUX8oAlGvVg39RFsSoyPkTIiw3fUK5rTTtPjgWSt/gzF9a7QBQyrH30A+FVyK1wc+CeKp51g/YW1J3vnYeOjIsLuDOjbTDsWFeJAatTnhzHcVC5NmGNyW+b6LS93VbqKB00JFSkWRbORPshahsnMR8zpm26Gf6idNrFp7X/V5eh1vyYrm1uCBzWqbTUEzC3cbxDGNunuJHcztO6/Q0WmO4iOhrphBRsb3k6ElHusZyOvSGKDyC/YoLS49lnjK6h2UlRsi3uw4l220qL8efLd5OL/xoFhxLM51lvQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(376002)(346002)(36840700001)(46966006)(8676002)(8936002)(110136005)(316002)(55016002)(9686003)(53546011)(7696005)(186003)(26005)(52536014)(6506007)(54906003)(478600001)(5660300002)(4326008)(450100002)(2906002)(82310400003)(83380400001)(356005)(81166007)(82740400003)(86362001)(336012)(33656002)(36860700001)(70206006)(70586007)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 05:20:31.4178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0f6ca4-d3fa-48a4-c70a-08d939f47307
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT016.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6222
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: Justin He
> Sent: Friday, June 25, 2021 5:18 PM
> To: Al Viro <viro@zeniv.linux.org.uk>; Linus Torvalds <torvalds@linux-
> foundation.org>
> Cc: Petr Mladek <pmladek@suse.com>; Steven Rostedt <rostedt@goodmis.org>;
> Sergey Senozhatsky <senozhatsky@chromium.org>; Andy Shevchenko
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
> Subject: RE: [PATCH 07/14] d_path: lift -ENAMETOOLONG handling into calle=
rs
> of prepend_path()
>=20
> Hi Al
>=20
> > -----Original Message-----
> > From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
> > Sent: Wednesday, May 19, 2021 8:49 AM
> > To: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Justin He <Justin.He@arm.com>; Petr Mladek <pmladek@suse.com>; Stev=
en
> > Rostedt <rostedt@goodmis.org>; Sergey Senozhatsky
> > <senozhatsky@chromium.org>; Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>; Rasmus Villemoes
> > <linux@rasmusvillemoes.dk>; Jonathan Corbet <corbet@lwn.net>; Heiko
> > Carstens <hca@linux.ibm.com>; Vasily Gorbik <gor@linux.ibm.com>;
> Christian
> > Borntraeger <borntraeger@de.ibm.com>; Eric W . Biederman
> > <ebiederm@xmission.com>; Darrick J. Wong <darrick.wong@oracle.com>; Pet=
er
> > Zijlstra (Intel) <peterz@infradead.org>; Ira Weiny <ira.weiny@intel.com=
>;
> > Eric Biggers <ebiggers@google.com>; Ahmed S. Darwish
> > <a.darwish@linutronix.de>; open list:DOCUMENTATION <linux-
> > doc@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; linux-s390 <linux-s390@vger.kernel.org>; linux=
-
> > fsdevel <linux-fsdevel@vger.kernel.org>
> > Subject: [PATCH 07/14] d_path: lift -ENAMETOOLONG handling into callers
> of
> > prepend_path()
> >
> > The only negative value ever returned by prepend_path() is -ENAMETOOLON=
G
> > and callers can recognize that situation (overflow) by looking at the
> > sign of buflen.  Lift that into the callers; we already have the
> > same logics (buf if buflen is non-negative, ERR_PTR(-ENAMETOOLONG)
> > otherwise)
> > in several places and that'll become a new primitive several commits do=
wn
> > the road.
> >
> > Make prepend_path() return 0 instead of -ENAMETOOLONG.  That makes for
> > saner calling conventions (0/1/2/3/-ENAMETOOLONG is obnoxious) and
> > callers actually get simpler, especially once the aforementioned
> > primitive gets added.
> >
> > In prepend_path() itself we switch prepending the / (in case of
> > empty path) to use of prepend() - no need to open-code that, compiler
> > will do the right thing.  It's exactly the same logics as in
> > __dentry_path().
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  fs/d_path.c | 39 +++++++++++----------------------------
> >  1 file changed, 11 insertions(+), 28 deletions(-)
> >
> > diff --git a/fs/d_path.c b/fs/d_path.c
> > index 72b8087aaf9c..327cc3744554 100644
> > --- a/fs/d_path.c
> > +++ b/fs/d_path.c
> > @@ -127,8 +127,7 @@ static int prepend_path(const struct path *path,
> >  		}
> >  		parent =3D dentry->d_parent;
> >  		prefetch(parent);
> > -		error =3D prepend_name(&bptr, &blen, &dentry->d_name);
> > -		if (error)
> > +		if (unlikely(prepend_name(&bptr, &blen, &dentry->d_name) < 0))
> >  			break;
> >
> >  		dentry =3D parent;
> > @@ -149,12 +148,9 @@ static int prepend_path(const struct path *path,
> >  	}
> >  	done_seqretry(&mount_lock, m_seq);
> >
> > -	if (error >=3D 0 && bptr =3D=3D *buffer) {
> > -		if (--blen < 0)
> > -			error =3D -ENAMETOOLONG;
> > -		else
> > -			*--bptr =3D '/';
> > -	}
> > +	if (blen =3D=3D *buflen)
> > +		prepend(&bptr, &blen, "/", 1);
> > +
> >  	*buffer =3D bptr;
> >  	*buflen =3D blen;
> >  	return error;
> > @@ -181,16 +177,11 @@ char *__d_path(const struct path *path,
> >  	       char *buf, int buflen)
> >  {
> >  	char *res =3D buf + buflen;
> > -	int error;
> >
> >  	prepend(&res, &buflen, "", 1);
> > -	error =3D prepend_path(path, root, &res, &buflen);
> > -
> > -	if (error < 0)
> > -		return ERR_PTR(error);
> > -	if (error > 0)
> > +	if (prepend_path(path, root, &res, &buflen) > 0)
> >  		return NULL;
> > -	return res;
> > +	return buflen >=3D 0 ? res : ERR_PTR(-ENAMETOOLONG);
> >  }
> >
> >  char *d_absolute_path(const struct path *path,
> > @@ -198,16 +189,11 @@ char *d_absolute_path(const struct path *path,
> >  {
> >  	struct path root =3D {};
> >  	char *res =3D buf + buflen;
> > -	int error;
> >
> >  	prepend(&res, &buflen, "", 1);
> > -	error =3D prepend_path(path, &root, &res, &buflen);
> > -
> > -	if (error > 1)
> > -		error =3D -EINVAL;
> > -	if (error < 0)
> > -		return ERR_PTR(error);
> > -	return res;
> > +	if (prepend_path(path, &root, &res, &buflen) > 1)
> > +		return ERR_PTR(-EINVAL);
> > +	return buflen >=3D 0 ? res : ERR_PTR(-ENAMETOOLONG);
>=20
> This patch is *correct*.
> But do you mind changing like:
> if (buflen >=3D 0 || error =3D=3D 1)
> 	return res;
> else
> 	return ERR_PTR(-ENAMETOOLONG);
>=20
> The reason why I comment here is that I will change the
> prepend_name in __prepend_path to prepend_name_with_len.
> The latter will go through all the dentries recursively instead
> of returning false if p.len<0.
> So (error =3D=3D 1 && buflen < 0) is possible.
Please ignore it, this is not relevant to this patch itself, I can
draft a new patch if it is needed.

Hence:
Reviewed-by: Jia He <justin.he@arm.com>
