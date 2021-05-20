Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187BA38A0A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 11:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhETJOM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 05:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhETJOL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 05:14:11 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on062a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73E2C061574;
        Thu, 20 May 2021 02:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zv71aN0pxh05VXBJ6gHR1rtzE+SkvIn3tbe55u8MvNs=;
 b=l3u/EXYE6SEytVAYHw3BZle3xmJMDPfYogFelgp5ar84nnPZ0JbGUnCxWViXia4SlibHlae30IXY/WZg9EOnNOeXouXRJ9UC055j9S7NzeEC6ltFb2GBJc4A3h63eNSKtYKO22JEohsjj31dVFODdWSKmh/g5WDTel+XIv3biJE=
Received: from AM5PR0602CA0023.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::33) by AM8PR08MB5665.eurprd08.prod.outlook.com
 (2603:10a6:20b:1da::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 20 May
 2021 09:12:45 +0000
Received: from AM5EUR03FT029.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:a3:cafe::b5) by AM5PR0602CA0023.outlook.office365.com
 (2603:10a6:203:a3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Thu, 20 May 2021 09:12:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT029.mail.protection.outlook.com (10.152.16.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 20 May 2021 09:12:43 +0000
Received: ("Tessian outbound 6c8a2be3c2e7:v92"); Thu, 20 May 2021 09:12:43 +0000
X-CR-MTA-TID: 64aa7808
Received: from 9fab43014ac9.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F218A251-1FEE-4201-A156-AE5C554B56A3.1;
        Thu, 20 May 2021 09:12:36 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9fab43014ac9.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 20 May 2021 09:12:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9jFUMxNUbOV1Adw7DgIhL/sn084Oedw9QwVXtjayAzAdZmOp6h+woeuU6ADekBvgdMnXHFzTtie81Gk25vO+Jk5nvYFLakJYqJT2BBqdoqG4iRYSj8V16YXpDF7bcuIwFh+uzFA96ejGzrfBMqmi3ds2/3w1a2dx4Qtv7GEzwiz8dPLE9eUTxP4VNZNQDHvh4MzBSwj7E+AtD+1ddLZCOKn3hBdfdadvMPp/1TQV0lLxqdPcqaYS+yOO9g2huMiAh+v+jDyBVYALRDBgXOOuJEO09/Ri0RqQzpuy8nqTUmXl3vlbOpX2CZTyx8DBD7+X5bES3QRBCbb6NshMOsPIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zv71aN0pxh05VXBJ6gHR1rtzE+SkvIn3tbe55u8MvNs=;
 b=lWs0qGNf4FBbLnacvVaR8fysWfKzvM0cvoHD+XeAFZ0nWzyCFY90RIGAf8NwYBS91kjKjoDqMW1O4LgDzSEH0BIbL4UDBPVo2sGs42b/DNXjzEGF/3TpG+zm1Y4d1msTThRWHWwAYpdfhXFwBWJN2XfJz7DxORKyM0OnV7l8xfbduussFklFCe0XImZpqi3Y0gzvsVHzyC1VMYyjDDfgMCDbMCAu72shZeIljt6MLYHTy9rhsBXmVr0EozUsbDZc4nCSMz5oliqI+xy135MgVlTX/rQ4Rzb0A/vGlzLZ51e129Lq+gGQTBrJphIA2HJSzzIQVc+LxslZ1A/30bM/5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zv71aN0pxh05VXBJ6gHR1rtzE+SkvIn3tbe55u8MvNs=;
 b=l3u/EXYE6SEytVAYHw3BZle3xmJMDPfYogFelgp5ar84nnPZ0JbGUnCxWViXia4SlibHlae30IXY/WZg9EOnNOeXouXRJ9UC055j9S7NzeEC6ltFb2GBJc4A3h63eNSKtYKO22JEohsjj31dVFODdWSKmh/g5WDTel+XIv3biJE=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM5PR0802MB2467.eurprd08.prod.outlook.com (2603:10a6:203:a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 20 May
 2021 09:12:35 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::18c4:33fd:d055:fe60]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::18c4:33fd:d055:fe60%3]) with mapi id 15.20.4129.031; Thu, 20 May 2021
 09:12:35 +0000
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
Subject: RE: [PATCH 08/14] d_path: make prepend_name() boolean
Thread-Topic: [PATCH 08/14] d_path: make prepend_name() boolean
Thread-Index: AQHXTEjYD3Z/8KjuG0a93z38qmVRPqrsFmlw
Date:   Thu, 20 May 2021 09:12:34 +0000
Message-ID: <AM6PR08MB4376607691168C132AB2F558F72A9@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-8-viro@zeniv.linux.org.uk>
In-Reply-To: <20210519004901.3829541-8-viro@zeniv.linux.org.uk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: D6A74D5A94850941A419F6BFD306F077.0
x-checkrecipientchecked: true
Authentication-Results-Original: zeniv.linux.org.uk; dkim=none (message not
 signed) header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 5228aa2e-08db-4268-fe93-08d91b6f6d6d
x-ms-traffictypediagnostic: AM5PR0802MB2467:|AM8PR08MB5665:
X-Microsoft-Antispam-PRVS: <AM8PR08MB56655586E14258DB86EB9847F72A9@AM8PR08MB5665.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:4502;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: F9HS9NM1dGGxxGUoUNrHrb11efvJDbaS6pIZirh5msmge5VOtiWCDT3vcjm39y0FLBYOpwqTQpzO5qYVvth25NqCcoIaL1B5Plr0YifJ0nOQo6E/BlYmik4ry8bci6T4XRom0yEtB7uQPvfiA7Z+Ys94hCCodsu4W1wC+B5p/g0VLAKYEFtXdw542K/q/25iOeI0eybVi+S/iZmXhgSsg2GGdDAGQ1VQQlVaHc+bhql0ANM8Whntxjs1fUYEYAu+SxCTtNN8UyeXCmwv42Xo1OMmkcRBF0IGBSy/CahSy7CeX11bLXEHLoMGbGHHhOW+kqZvgTJfBQJspcUh7HmHz0RXLEGbqs3tsm9v+2G/IcdKBs23gAi0rzg/m6B1f+EUQ2gpKlUSRER/VKyH25xMqVUefLdy0c/3ySKIMPEe3hBTZOi4WbePxQyVtUoOUG1J25gA2hh1taRQboArZjJ4JuxH8rAUmB06q5NDb2m1qGpDCrK4r2uJVRarw/v69vQj09oIidhVL94+1y14loqQxefVWngGs0s/FrRRj6LuU83tq0+76KQRLdRUsRbaOslw+ixXFMEtQ565G2FgE8pHZ0BWJohinkRQtlxcDdkSmeNVXdZQYUXsZS3Kn1E1KX15DEnjsSEiyGjzdTFiD8VAM281alqfAGxOkapUrzYOrtXOzIl90B26rAK9xLjesE5jc90vO/jprc+RC88JCC7qTeP8YIfYtquxpEy+vgo8AvQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(33656002)(2906002)(66946007)(6506007)(71200400001)(5660300002)(76116006)(66556008)(66476007)(4326008)(7696005)(66446008)(64756008)(86362001)(83380400001)(186003)(9686003)(8676002)(7416002)(122000001)(38100700002)(54906003)(26005)(8936002)(316002)(52536014)(966005)(55016002)(110136005)(53546011)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nW4X+ULy+CdIyjXii4sH2/QG0hFqE4txjyme5txsVbyKn20ZvLZiEf2CifVF?=
 =?us-ascii?Q?rwDBVEWHzyFaiyoxBIAbYdSUhmjAKRTttnch2ss9AGCLdz3ip+1RfF9Whkn/?=
 =?us-ascii?Q?nJQUglq1MIwQbvfGxtUefYtQqfZdw/ljphHjC42fcbnYhx4REbWUWdBRfw3F?=
 =?us-ascii?Q?bhlMcqGORe4rfvRAHE5o2fd4hbUCQSN1mKoQHXMggmR7mvvEuAV7qHIEuYl7?=
 =?us-ascii?Q?9Yu+d6aZtAgm0A4lbzYblHp3YvPP0VsK7NLfBJOrrgxevjJlfASl41BaBFQC?=
 =?us-ascii?Q?igCcM25wnRdOWd3kYH7AQKDKDGxl9Lxz6UtNy3l1Yb5mZif93ZPlnLsuS+h2?=
 =?us-ascii?Q?fQPmqvl1hYpEq39rZ4l+/VabRMG1nUzcnEGWAqjV5vTlXTBVsN7G85XLnBrF?=
 =?us-ascii?Q?FFgnZZjkHzCiOWq/BLgXeovejEj8eiZXptc3La5zFleQYLt7u51QUtZLDET2?=
 =?us-ascii?Q?MfH5h8ehWtb3eRN1fZ3TTLYbp14HllqLvJ83kd03B0KmS8Fgi/zo4UilQR/s?=
 =?us-ascii?Q?wGt91UJPd1mUk/SCvX2FhR5M59Jt2MDi/Pwomg7N/3se/ZPC6boXjxym1mQE?=
 =?us-ascii?Q?0ygT9nd0/ZnQnAj+gOFQI8PBp1sEgq2giGIBhe6Bv7h51Ql/ZQ0xbgyxndeK?=
 =?us-ascii?Q?3nTlgARPUnuORHIOp3Ih4ADbAklndY+Q6hINXPDYoZ20+cNxiPYx275+cEdG?=
 =?us-ascii?Q?2nKXgvuIgfpXa/1YebMf5Ci91OLhm2TU0XkV7R03zCHIcWIjzmRgb7O+nGpx?=
 =?us-ascii?Q?MUDJvYNYadonJJRl8dwB2yTGGREYOCMZfB8+V6ERU/wEXDYEGL8bxcsepR+5?=
 =?us-ascii?Q?5SqKAG2WQngQTOj58huh9RmFj0cmHbpjDKL91FdO4Ux5w/61HKHH7GJ1ZeEU?=
 =?us-ascii?Q?1m29COVAZIAkpWws++FF3D6IB9LZ83z9ZXO6dfzr8kWh7YsqhuIG294Bo70Q?=
 =?us-ascii?Q?aMLDQoqvHlsoyMVt3U+4vYJLH/lfgIw3YlQF6bme05x6AJOUS4aunusg3qEi?=
 =?us-ascii?Q?HwR0vMikMb97HT+fZZ/yQOeKGlLW9iWxU8jGEcTU/x9TPVoFqrMqqTPJWpv1?=
 =?us-ascii?Q?0Bo8vEC5jYAplZ8X83ZOzH+KspJQfgGZZPsOtvC7xgGMScOnZCFGiRkHZVMN?=
 =?us-ascii?Q?RGCigZlHJLG9mdwpBu92+AC8Qo+UMbvwd8KlrXMG1gWXjKjxyi7RuKP02dCG?=
 =?us-ascii?Q?HkHfJySKfjuHN+WT5nDiM2m9IxVm7rmWx/jOpgWT/Bo4DP7NiQr8seEFThIy?=
 =?us-ascii?Q?mKzBci6Pz3KNHWpEmtSLn/kzdS/jPZ2AXPENwFFYe2122G0Id8VN0VGWCUkX?=
 =?us-ascii?Q?QgWlnxRUIIez9p/AOFQOO7Kf?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2467
Original-Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT029.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5b6da15e-df89-4ba1-d887-08d91b6f6812
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I31MjpCGhhCek46rxam4k8POnGMdptkidQlRisQZ6LL/0Ur7ncUEgeHlKNf4LjmhT7UME4cCtT7aAFzSXhq33io7PV8KtdcvIHr1+gV+yhTV7veF6PUoc6kxdrJ8NtpQ99QQqEmCI1jaK46wknbR1QbyGPNy+mxHWhNhP/sHFxfPgubwMslhYEwOCU0g+E2OXwqCMKceVgpI50ogqBFWu7jfOmfYEmWIMzgQPXleSKmBwzrUQfupml1Atbyufa7IYExzDzZo7UchfoG33xp0p3UagIKb23V/+UdkOx47b9GnlN8iKo98iC9V1lQaVboUTjGMzdnXQa0sc90KRg/77CQfMmWefwcf2sJl2AvFplAbqV4H2vscBjxKjUjEe6LUOoCGGLTian8s2pu0OUrj2HTWqhB9gfPXRYvRc5hwLLcsxQUtQE9QvQfIb3hHHkM5cPPRWCKRLItyTwkPemUWDWseErfET7pq5Gs5SmHw6Dn4TGsNy/79cU0KQEzQDmmScd+n+SvcV/qIVZp7up3qpqR+JQXndaB3hBD1vcGrz0a9gaiLjmakN7bnsXSIIc39zG2Zy0297Llh6Zqk/ofIQt4i57EuKMlDqnpTlRVs0P4k1CplHGkSUZrdgBtc9YDoOuVUapownDqfoWGnLdQ7gBA4zDo48e33yytFbDJmG4mB5u/gsusMksvJeDRT82CLNK+hYgl4OzLFAdBJzzA1JEEsxtGPyDuou3Z8wz+IQJh4RZJLXS1DFCxJnFA4BEe324AfRmbEVas+4MpIkIbXpw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(46966006)(36840700001)(81166007)(33656002)(52536014)(336012)(5660300002)(83380400001)(6506007)(8936002)(82740400003)(356005)(53546011)(8676002)(36860700001)(82310400003)(7696005)(26005)(54906003)(186003)(450100002)(478600001)(966005)(70206006)(9686003)(2906002)(70586007)(47076005)(55016002)(110136005)(86362001)(4326008)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 09:12:43.8441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5228aa2e-08db-4268-fe93-08d91b6f6d6d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT029.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5665
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
> Subject: [PATCH 08/14] d_path: make prepend_name() boolean
>
> It returns only 0 or -ENAMETOOLONG and both callers only check if
> the result is negative.  Might as well return true on success and
> false on failure...
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/d_path.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/fs/d_path.c b/fs/d_path.c
> index 327cc3744554..83db83446afd 100644
> --- a/fs/d_path.c
> +++ b/fs/d_path.c
> @@ -34,15 +34,15 @@ static void prepend(char **buffer, int *buflen, const
> char *str, int namelen)
>   *
>   * Load acquire is needed to make sure that we see that terminating NUL.
>   */
> -static int prepend_name(char **buffer, int *buflen, const struct qstr
> *name)
> +static bool prepend_name(char **buffer, int *buflen, const struct qstr
> *name)
>  {
>       const char *dname =3D smp_load_acquire(&name->name); /* ^^^ */
>       u32 dlen =3D READ_ONCE(name->len);
>       char *p;
>
>       *buflen -=3D dlen + 1;
> -     if (*buflen < 0)
> -             return -ENAMETOOLONG;
> +     if (unlikely(*buflen < 0))
> +             return false;

I don't object to this patch itself.
Just wonder whether we need to relax the check condition of "*buflen < 0" ?

Given that in vsnprintf code path, sometimes the *buflen is < 0.

Please see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it/tree/lib/vsprintf.c#n2698

--
Cheers,

Justin (Jia He)
>       p =3D *buffer -=3D dlen + 1;
>       *p++ =3D '/';
>       while (dlen--) {
> @@ -51,7 +51,7 @@ static int prepend_name(char **buffer, int *buflen, con=
st
> struct qstr *name)
>                       break;
>               *p++ =3D c;
>       }
> -     return 0;
> +     return true;
>  }
>
>  /**
> @@ -127,7 +127,7 @@ static int prepend_path(const struct path *path,
>               }
>               parent =3D dentry->d_parent;
>               prefetch(parent);
> -             if (unlikely(prepend_name(&bptr, &blen, &dentry->d_name) < =
0))
> +             if (!prepend_name(&bptr, &blen, &dentry->d_name))
>                       break;
>
>               dentry =3D parent;
> @@ -305,7 +305,7 @@ static char *__dentry_path(const struct dentry *d, ch=
ar
> *p, int buflen)
>               const struct dentry *parent =3D dentry->d_parent;
>
>               prefetch(parent);
> -             if (unlikely(prepend_name(&end, &len, &dentry->d_name) < 0)=
)
> +             if (!prepend_name(&end, &len, &dentry->d_name))
>                       break;
>
>               dentry =3D parent;
> --
> 2.11.0

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
