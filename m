Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8CB3B3E25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 10:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhFYIDk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 04:03:40 -0400
Received: from mail-eopbgr00072.outbound.protection.outlook.com ([40.107.0.72]:35557
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229878AbhFYIDj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDOYX2ZynLPd7xEXNdDeKJGXM52LPXhej5n/B5a4elQ=;
 b=Iv64HqJPe0xMtCjglYDC3iNgQkzmFrC72RmeazRj+YM6FmfbGhCK9MbshWO0p94WugrvTntXgH54vFClkPY81LNTVSmRuBy/85iexO5KInAjTN29bJnOCIWInFklDFaPPEqBY+aWfNJf2fXLvZRECl5wLRgiBRgw8xjcjOJUbQc=
Received: from DB9PR06CA0011.eurprd06.prod.outlook.com (2603:10a6:10:1db::16)
 by AM6PR08MB4294.eurprd08.prod.outlook.com (2603:10a6:20b:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 25 Jun
 2021 08:00:59 +0000
Received: from DB5EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:1db:cafe::6) by DB9PR06CA0011.outlook.office365.com
 (2603:10a6:10:1db::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend
 Transport; Fri, 25 Jun 2021 08:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT010.mail.protection.outlook.com (10.152.20.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 08:00:59 +0000
Received: ("Tessian outbound d6f95fd272ef:v96"); Fri, 25 Jun 2021 08:00:58 +0000
X-CR-MTA-TID: 64aa7808
Received: from e9c1d64ff3a4.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7063BBFF-0B67-4BCA-BFA4-0A1412193F6E.1;
        Fri, 25 Jun 2021 08:00:52 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e9c1d64ff3a4.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 25 Jun 2021 08:00:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bm/v9YrY/8ilWPSF/Sz/Io7TO/HWwHzdFzA8Upf9hhiaQ7xlrcfJyaJeAU7UR77YFo1selMF6VWlVGcmlAXmQXFfWaURuV8dkcXMA47xOetZIz/bbVH2TA/ywkxy4ZRJuNa2TfvKIyqIzssK91YQmTzmxPH5i6d0Vp9AzHyr7ZhdT6eamLLMVpRn3pF3kyoo5AmjZhoLlKY0a1zotSZ9UEQMt7wre2eph8OD+BfC41pJ8+ANBYm6/QtjOjVWQn1UNIS4i+/GDMEue0Z2Du/f3WJfA9Ptvhqn0TY7tqeczyNJk5IGDYytPmgyt9nQqxgQBPvxt2SlOUqFLcE07GclOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDOYX2ZynLPd7xEXNdDeKJGXM52LPXhej5n/B5a4elQ=;
 b=luYbNIkgWJenA+9uu2Vn8vO10muTdClEHeBQ4Ficl1s2cSKB1t84YODbvj26W5gCn2hdnFjlC26h+7bZ2O0jaeyRSUvionYH+wxQ0GOZcU2Yszhqx9LkqWhYRs3hwNHSFi8X0YB2fmbEPzTfdNTn2NfqPIbSMJbwt4Z9+3D1JLbIksJnvJLuz9onsFSkelz3Y+Yf6PgSQyjQSAwA9OA3BK9I5x+qPTSUtKznwSVxcmTsbu5bStyusYHFeSChVqWCOrcK7sUcSvoQx9kjLw3YiKTj3KkjAoCmlLFKTXso/5QYby/dUrxjNsLBmNvRVuTqEYpeANZ1sSVoJpEtei1WgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDOYX2ZynLPd7xEXNdDeKJGXM52LPXhej5n/B5a4elQ=;
 b=Iv64HqJPe0xMtCjglYDC3iNgQkzmFrC72RmeazRj+YM6FmfbGhCK9MbshWO0p94WugrvTntXgH54vFClkPY81LNTVSmRuBy/85iexO5KInAjTN29bJnOCIWInFklDFaPPEqBY+aWfNJf2fXLvZRECl5wLRgiBRgw8xjcjOJUbQc=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB5286.eurprd08.prod.outlook.com (2603:10a6:20b:aa::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Fri, 25 Jun
 2021 08:00:50 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 08:00:49 +0000
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
Thread-Index: AQHXTEjX4vA9qb1/tUuDI9sxRSQuQasklodQ
Date:   Fri, 25 Jun 2021 08:00:49 +0000
Message-ID: <AM6PR08MB43762B63D11A43FE84849748F7069@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-13-viro@zeniv.linux.org.uk>
In-Reply-To: <20210519004901.3829541-13-viro@zeniv.linux.org.uk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 886D45C504F6C44FB8C7700BE3801E47.0
x-checkrecipientchecked: true
Authentication-Results-Original: zeniv.linux.org.uk; dkim=none (message not
 signed) header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 78929175-ddca-4543-101f-08d937af5e6f
x-ms-traffictypediagnostic: AM6PR08MB5286:|AM6PR08MB4294:
X-Microsoft-Antispam-PRVS: <AM6PR08MB42944AA262E788C6D23ED46CF7069@AM6PR08MB4294.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:660;OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: GzlRZmVAeXFNGUzZJJoXVrYol9iG02rxDUb9GLxmp/2chtm80WmMGqaa0g66Z92PQ172XSaC0E6eqhoPLsz/SK1bnry3zIpzugllqFYuHzKGXxTm/IbdmrmYXxcv/JmdSjmrp/9yrQkMPHCKcnVlzjrUkTV3IXGprRYHogmNhPUK0xD5YbCJPTdBPM8EC4KhVH5VFKpX8OnV+EEOiccQNKsr4YfJs3vfX69h7K0/jT+KbvTlbF73LSsWoANhBQ3RqcKE8Hl5eZJ1N6rZGjE40cXi6O37w42brudHqZ1D23AxcvfBdJn/oTtujJjsPkNNl5285Cr4PFDC7J1YxBJIhNArworb23xRmdE10aiYdLkaya5g+fRjYDdW/iwdXZIYnFqbHhlgTtDTKyxFDSAwsYWYIZ6yabL2gWlCEkbVofxB2cPW6aSH/ntS5Qkb9BT2CYz5Ju5IOLSOju/bzzQXeCNzTEpHgZf7ZTQfd3kd/CLmjOqkmpLFhcfgPt2SFvCW97gfpMV4dlcF926IAkh5g1vii5zGxrmFeZkVAjxQ3fUrtetIA7u/qAe42QanX3bmQZaq6YrYBhyUsZTq0tDMisk0UBYmXL0Kc3efpyO1LCk=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(136003)(376002)(396003)(366004)(4326008)(2906002)(86362001)(8676002)(316002)(8936002)(110136005)(54906003)(71200400001)(66446008)(76116006)(7696005)(26005)(186003)(66946007)(83380400001)(64756008)(66476007)(66556008)(6506007)(478600001)(53546011)(33656002)(52536014)(7416002)(55016002)(9686003)(38100700002)(122000001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XcoyyuYqrxBARMRe1xEpn/u1odlCLi+mhjHKsyDlPF1W3XeVJYxJiH8UztFn?=
 =?us-ascii?Q?rozOhzwtgIRuYJweWo5fQRx37ki7hR8QN7ZJ1xdp4RnvTvBNhYjEBy9NQShH?=
 =?us-ascii?Q?fAU/S5r98ZbwNHt9WRezTgsx7w+Wu5r+Njl7BO0ROWd3+DzDOvFcyhrr4Ja5?=
 =?us-ascii?Q?exeiDoNREWrQsjDzjzzeWHEsVdJTwFeyonhJf53nzXiYCqzU+OpwUwSz62Wi?=
 =?us-ascii?Q?/NlGOqkGpjhj6qfdbWwYGRiNPE+XT+lExbSCp/4b/x6qF77MrpcnvTOg50ji?=
 =?us-ascii?Q?Jv1eSG7skoPExN7lr46UEgmV2mrpE4OWK5ieml+s+UN8niGgHzfDNmAJhchN?=
 =?us-ascii?Q?qOkd4nNqvYNE+fmcHPOjoxOFWto8fQlW4ngMqd0+jlazZCDHur5DyEcwt1p8?=
 =?us-ascii?Q?8wXelZQmPlJY3ePlmx81U+lGSo84uv9qraVlRpa6ZRq5trZHBYCtzHLay2Cj?=
 =?us-ascii?Q?2Xu0kOZwNqWNmMg5beViN3ISzakIZLTgrrNS87/byqn+H1VueT3jDvpZTVM0?=
 =?us-ascii?Q?2r2BZPsGlC4q3J67IhDqGy0WKg/lUumfvyuLqwtvXBc08EfTCJP4TPzxtGTY?=
 =?us-ascii?Q?YosQYa8rCtvWtff4BIoPAfsJjECUyceFOCjyL3RviZdF/DZkwlDSbasnsbVi?=
 =?us-ascii?Q?1pfPsLI9NPkU7rGp971Tjwt2JJMM0ajOGsC95wxMjxQje+VYa5XgQsr372fE?=
 =?us-ascii?Q?EXTgOtLxKmLwDh0lrdgfgykRYqjglrH1z/3K9PQGycfpw7frr2y5z7ER4K11?=
 =?us-ascii?Q?NtMCVvf7Pp7J6jQuEXK0dPpNXFC5d/jSofzEKXedcz5o9MBxUoBkwuoC3y+3?=
 =?us-ascii?Q?Fic8MHmeiKl2eQPUc8j0JY3OsL3yiHTJc2OS+qh0jMd+s+v5iqDY2IwlTEbt?=
 =?us-ascii?Q?q6eSoSajnT/U0ZzW58hSUlascKoWS2KOYbsqAH7xAZEaoRDwELqwZmb3qkim?=
 =?us-ascii?Q?l0H7OjyZwwFzzrlrPdMgF1+zuegmrl1bqiEOYfBPYCrnzhKUWcUxETXmra18?=
 =?us-ascii?Q?HhiMZM/iyRwZ8Kljl9aqLJt44zYUEf/I3g7NFtYDnnuZ3tSeYfmyYxe+sqM1?=
 =?us-ascii?Q?8QtWTAb09XLrkbhUuqs97AAfGERo4zYgB0mJYPToLpf0ReLySL0Z0NMBvela?=
 =?us-ascii?Q?pKsrvGKMbxhR0FmeC6FLcUbu5S4c2YlmHatfIqpZsfTkPRRgGgpsdQ+AHtjX?=
 =?us-ascii?Q?ZMxt/PiIylBnBGWUtJQY3m4Uj3TZUmoEltoMdfs5Z5rfuVyB5xAvW67Edz44?=
 =?us-ascii?Q?uu59SlG6A1SvUjQI2k2PAwKniDQQaWycyYVvGIc0FoD0Y4eVZvLFIhlFNCPH?=
 =?us-ascii?Q?TjruNXtCd02VonvUrlI0f+u1?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5286
Original-Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: a4922bab-4f78-4708-23ab-08d937af58e7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q0g3a0EwM1IZAfTeDrntFSm9cDFsr5PMiacd5lrC6WvmqiqVCrW5byqllF04tmyXDq8l0JfjonZ2mggc+34QE7xNavh3f4qFC7sPJ2x+mRRYpMPKTAa9qSGKN9pMTB+Vm/4qNBtJBG/kYoAY4VTgykiqV9VHzLKIJzETjGob/R/SCajZtcsVHHXUY5UE0Wbpy76yAhef26W3I+8Z6U+MRJ8QX6Owef51VfGoDXALwJg5wxHdbQM4JLUew8G9w4JcZ54mOxuDrGdK6EtRk5v6/EOvHWZ9QY5xU9fSZzrWbhrFB2eQZbu320H7RIbddPyLEflbsBE3E3WOwlgFBipXcO2o2R6fw82PHyDbDid0Fp+gxpFLme7hrtGD0XvwnfjEuHVdRwW8MmbI3Uy2DB5i4orfENDRp/aV8Eab6eNPLroOuVN6mBPOLrBKe95uKSaJGMRRvUmFqWUISXZhQYlk+uZg/0SoEA0c6U7shW65fIgexZfc4KG52iO4+okg6q0W6nfr8o08fpdXzwjTt9LyOd+17LMtB8gPqrqX88l3yaGDvN+d/wzNjVcJQMMLbtAm0GUcF0clAj9KDA+XIX92HULCYIX5io3weW0zYZH4q98S1FRPD81HwRsikTpENZXMH4HRTHLtI4W3eU3HXHQWOw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(396003)(39850400004)(346002)(136003)(36840700001)(46966006)(5660300002)(55016002)(70586007)(450100002)(336012)(2906002)(70206006)(33656002)(36860700001)(4326008)(8676002)(316002)(8936002)(82740400003)(53546011)(356005)(6506007)(110136005)(7696005)(52536014)(81166007)(83380400001)(54906003)(478600001)(26005)(82310400003)(9686003)(186003)(47076005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 08:00:59.2627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78929175-ddca-4543-101f-08d937af5e6f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4294
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
> Subject: [PATCH 13/14] d_path: prepend_path() is unlikely to return non-
> zero
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/d_path.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/d_path.c b/fs/d_path.c
> index ba629879a4bf..8a9cd44f6689 100644
> --- a/fs/d_path.c
> +++ b/fs/d_path.c
> @@ -187,7 +187,7 @@ char *__d_path(const struct path *path,
>       DECLARE_BUFFER(b, buf, buflen);
>
>       prepend(&b, "", 1);
> -     if (prepend_path(path, root, &b) > 0)
> +     if (unlikely(prepend_path(path, root, &b) > 0))
>               return NULL;
>       return extract_string(&b);
>  }
> @@ -199,7 +199,7 @@ char *d_absolute_path(const struct path *path,
>       DECLARE_BUFFER(b, buf, buflen);
>
>       prepend(&b, "", 1);
> -     if (prepend_path(path, &root, &b) > 1)
> +     if (unlikely(prepend_path(path, &root, &b) > 1))
>               return ERR_PTR(-EINVAL);
>       return extract_string(&b);
>  }
> @@ -396,7 +396,7 @@ SYSCALL_DEFINE2(getcwd, char __user *, buf, unsigned
> long, size)
>               DECLARE_BUFFER(b, page, PATH_MAX);
>
>               prepend(&b, "", 1);
> -             if (prepend_path(&pwd, &root, &b) > 0)
> +             if (unlikely(prepend_path(&pwd, &root, &b) > 0))
>                       prepend(&b, "(unreachable)", 13);
>               rcu_read_unlock();
>
> --
> 2.11.0
I tested it with a debugging patch as follows:
diff --git a/fs/d_path.c b/fs/d_path.c
index aea254ac9e1f..8eecd04be7bb 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -210,6 +210,7 @@ static int prepend_path(const struct path *path,
        b =3D *p;
        read_seqbegin_or_lock(&rename_lock, &seq);
        error =3D __prepend_path(path->dentry, real_mount(path->mnt), root,=
 &b);
+       printk("prepend=3D%d",error);
        if (!(seq & 1))
                rcu_read_unlock();
        if (need_seqretry(&rename_lock, seq)) {

Then the result seems a little different:
root@entos-ampere-02:~# dmesg |grep prepend=3D1 |wc -l
7417
root@entos-ampere-02:~# dmesg |grep prepend=3D0 |wc -l
772

The kernel is 5.13.0-rc2+ + this series + my '%pD' series

Any thoughts?

---
Cheers,
Jia He (Justin)


IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
