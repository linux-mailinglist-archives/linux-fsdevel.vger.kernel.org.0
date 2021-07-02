Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE3F3B9C38
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 08:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhGBGjf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 02:39:35 -0400
Received: from mail-am6eur05on2075.outbound.protection.outlook.com ([40.107.22.75]:49505
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229809AbhGBGjf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 02:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLkokt2zBnObO5nA6uSdrEzMHAyt4MUJ+VfQ4cfhm48=;
 b=T7ykW7ZxkIz6dl8vHQ9w7aJYr/mFaCwa2KGzQo1URxneaDSm8/Sno53rErp6ncRCG3hAHmCsTXvoAqEybQCnFxeM3c3PhNjp9ADFEhPF9lUiq1aHloyEXgNc+zZ/KNlI3XCp9tLsDLpqQSiROqF/H37IxVLzF3HNY7vt5trwiLM=
Received: from AM6PR08CA0025.eurprd08.prod.outlook.com (2603:10a6:20b:c0::13)
 by VI1PR08MB4205.eurprd08.prod.outlook.com (2603:10a6:803:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Fri, 2 Jul
 2021 06:37:01 +0000
Received: from AM5EUR03FT008.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:c0:cafe::3e) by AM6PR08CA0025.outlook.office365.com
 (2603:10a6:20b:c0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21 via Frontend
 Transport; Fri, 2 Jul 2021 06:37:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT008.mail.protection.outlook.com (10.152.16.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Fri, 2 Jul 2021 06:37:00 +0000
Received: ("Tessian outbound 71a9bd19c2b9:v97"); Fri, 02 Jul 2021 06:37:00 +0000
X-CR-MTA-TID: 64aa7808
Received: from 6c9116ac9e1b.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 40050398-7883-4C1F-864B-0A92A5E4C121.1;
        Fri, 02 Jul 2021 06:36:54 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6c9116ac9e1b.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 02 Jul 2021 06:36:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjsf4G8fERyAMjRMWGvhBuCGW4xgSRxz4MgkBz/zbAavXVg/N3KbmF15OUZrGCG6rbOOuG0K3kZMAAYl+tqFew81tA0QtX/Nd5tHKmNcVYuGGZjElixedaqA9UHJiFsd/rGxQeCNx/OpiPtZdZb/gASSqdVZFmNMUyyRBtJZw09wQYMYiYu6iQEu7FSbPYVld0Mdu42s6Mmbqg2qVa9w8BPQBT3rRXuRmPWiOWiX5Wv5GkEDkQDBwzCzhbCD97ABRbWOaUrReEArc5BoGECbAMxKzNnBGZ1fKtY36dbNmsXW2zWMWECwtqcjmelgK9ptXMwNpL1pHXIxZAVeKiPQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLkokt2zBnObO5nA6uSdrEzMHAyt4MUJ+VfQ4cfhm48=;
 b=aWBDlkGIjTxafi3r3+Ln6d9I0HvSDYURvTA9q/QsEM88sRJCoN423H5/HtuTHIhgF36Yth9DKtA1A2ybzeWCb7ygz09W3aKbeifPj/Ju0O6vqfGxoLI/k+orRzHaQMsLF8LonzyXbVtV0OpCjemArwwdsKZBI/dtrbPa7oQZ4rklKqAktxtlDXg1twbPCzY34MppUFV7GNSVhQcjdlcqZ1H7szlYLcfFXgNJargz6I8ZV5lOlWknPcmWXxNEJcI+udTA6gLU7vP5QLQkVeyadd65c2gQl+pPqW8JKUte9I5yDRtWKJmHoecp9KQA6dUIkPyO+LdFMQ7dnXoKay7S2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLkokt2zBnObO5nA6uSdrEzMHAyt4MUJ+VfQ4cfhm48=;
 b=T7ykW7ZxkIz6dl8vHQ9w7aJYr/mFaCwa2KGzQo1URxneaDSm8/Sno53rErp6ncRCG3hAHmCsTXvoAqEybQCnFxeM3c3PhNjp9ADFEhPF9lUiq1aHloyEXgNc+zZ/KNlI3XCp9tLsDLpqQSiROqF/H37IxVLzF3HNY7vt5trwiLM=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB4566.eurprd08.prod.outlook.com (2603:10a6:20b:a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.26; Fri, 2 Jul
 2021 06:36:52 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4287.027; Fri, 2 Jul 2021
 06:36:51 +0000
From:   Justin He <Justin.He@arm.com>
To:     Petr Mladek <pmladek@suse.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, nd <nd@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: [PATCH v2 1/4] fs: introduce helper d_path_unsafe()
Thread-Topic: [PATCH v2 1/4] fs: introduce helper d_path_unsafe()
Thread-Index: AQHXZ/O2Q2C8pppNxUmz5hfVzQksAKskxYzggARkW4CAAYpcsA==
Date:   Fri, 2 Jul 2021 06:36:51 +0000
Message-ID: <AM6PR08MB437667C6304BB9A99932EAF4F71F9@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210623055011.22916-1-justin.he@arm.com>
 <20210623055011.22916-2-justin.he@arm.com>
 <AM6PR08MB43762FF7E76E4C7A0CD36314F7039@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <YNmRH3K4j+ZadHVw@alley>
In-Reply-To: <YNmRH3K4j+ZadHVw@alley>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 0E6CE3D2E7A72642B79902E9BC8DA5A1.0
x-checkrecipientchecked: true
Authentication-Results-Original: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.113]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: d7c054bc-990a-4d4b-0b68-08d93d23cc40
x-ms-traffictypediagnostic: AM6PR08MB4566:|VI1PR08MB4205:
X-Microsoft-Antispam-PRVS: <VI1PR08MB42058261BE8E310C0337FA66F71F9@VI1PR08MB4205.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: b0hevZV9fBMSXw3Fv3URC0iSp26oyD11ErhPGI6oX8bLuRkI/tvuLoxrQy3fjuymeWgsQIcDDqxzWjR7YI3yrFXuEkqtPecgAtPSWx9/PGVRUZB0ebhPUdbTDjfCoSeuX7BBvDtjXYJRR0ECioeToD+bWJ4geJoqSyxocyYxPgf7blcAYS3ncK1XEL8/Vxd6PIskrQIEtHG/nu4xB4UOGuzHCYaJHAWiGNWqmyLRJDv8wA5sASvFjhGH1gzMnH/TCu6/jqxnxE1WRadz34tfq7i0ePPDKm6Wgbxe4Q4d8uIPGFr4xir4Q/Qz2qCl6EAAgSsvMxVocdhXxFqbh3ZxJmY45sRyg0pO81k66BN52K70ilythgEesutPgT2ZduKfebqzJvspqOjjQnY/3/99H59HGwhAz2D7DGZ/CLWd1NDQ8sJMD/1HmRg3/sIp8nQjWveHvilcJ0+bAcM4+piX5sEaqvG9Co97Hnqz8VmapS8yUsHTMoOYoN01hXMNAMK9yRFR/GoosNnPneWlTrFC1fZeRu6eaY+MNQ/StzxxJs4PA4gCj+PzL2GCDRXp5A52fHqo/E/OjzG5feSMwijVab97ie4dN7zgBOWxjujwVNKm/Nkj1flzfWb9lHFwyHFNAao3PnWOUyvfIEkNYStWtA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(26005)(86362001)(8936002)(55016002)(9686003)(6506007)(53546011)(7416002)(4326008)(52536014)(8676002)(83380400001)(186003)(2906002)(33656002)(122000001)(71200400001)(38100700002)(6916009)(66446008)(66946007)(478600001)(64756008)(5660300002)(76116006)(54906003)(7696005)(66556008)(66476007)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PCY9/if0R2A6G5+/+kbxuzzE44iuTiV8T0DrLZ2cOxrce00YDnLshfAGE7RC?=
 =?us-ascii?Q?+YeD90b174Ysw7FbEOxsdC3nHMuZwoHEBsHdKyIEkwTHDNX4zsyzOzD6btHW?=
 =?us-ascii?Q?lKkoqwtRj1s8W7qI4MZWvHfIsVbz8tTp4D235UCJXSrZSN+PZjWy0CdDBpxw?=
 =?us-ascii?Q?1npRRDV08sfOD70QQmA544N51GhU0OZzeTGVuhyM5EwfbH6iGjySOUoBu4di?=
 =?us-ascii?Q?Mu73BYBZ9bVEe34cJyWthkcq8Piq+0BNAFW3UArfbpJL9snCS0dW/QZM9rbz?=
 =?us-ascii?Q?8dqudRRKrwXb9FVifYN+DSk4JXHxKmpZaj1Sz890C/egr3gy0mmDYKltjilE?=
 =?us-ascii?Q?Qt+fakQv+7BDnNjccroR4EsIN+VvlXs98blnt2wk5MBO7VquMB89jkxjX90J?=
 =?us-ascii?Q?nY8w8JP717I7IBeu7bzdZaKEFg9ORSnZ+Ypm3oHttTmPY26HqwcpUh4h36kt?=
 =?us-ascii?Q?dF84DDIFGWSJoyI83361h4uacruhKTJWGEcFUCCaaxTpy9PRRSDrjEOHwXrl?=
 =?us-ascii?Q?F+P+8sqShJN8QsHSba/vMJnmPidqUWVTDvxeKZYKtvc8MdluW1AFV46UNLHA?=
 =?us-ascii?Q?ZnHlZwErmytZok5RsM8NTnW8l7cLEEqEukJ7p8XkKURgc8cbHA6/HlyZYjS7?=
 =?us-ascii?Q?W87+NmFAVc6QvNjWZWiIF8kyx9SGoY9SpfBuBWiEyK5kzohw6lSHXBxz3NPu?=
 =?us-ascii?Q?CAyS+yzO72Qmqpbshlo+pxZQn1qX9c5699WjSmdVUDcLiDP3AyHnuv3KKWuO?=
 =?us-ascii?Q?Hgm1DEH1n7IktiIkvuAY0URifuef/ajthDP80olHzOtU9c5TXmO4NCZPNaIS?=
 =?us-ascii?Q?v0IY1EYQ2W+bcVpf4XdcfNEtbskywBDDAsOBbEuNpJwLkgxHI7KCDYXPkw2U?=
 =?us-ascii?Q?WeJgTnF2ig0jDbK91Y1iNqrUBTnQK/J7bUO6ih+71x8E3cETbx1M0+Zdfoq2?=
 =?us-ascii?Q?Cse9PDZv3FWpxZ0MMkqGzochkZNEWxpMB+56IfmMC8dePk7fa4ARF5Ck/aOl?=
 =?us-ascii?Q?nZWOw0VA/+DdRrkwz4DpEEUP/HE1xY9bnhDyZnV4lXTmzeWZfvkuNFXjtVEj?=
 =?us-ascii?Q?YxHJvpdGU/PDSPH5xJIh49GBOKO44bTIElFTX6DKsoHEBDn7lL7bAO0IxK6g?=
 =?us-ascii?Q?EuCN/jSgCqtSBMshaoywEEnRrVh/CvlEUjKfznpCNcVx+Tiic9nUwLY4HQQg?=
 =?us-ascii?Q?GXnPRBomK9e/C03hVTasrClXRztd2J9q4f4K+Ok9DCHl6Hy3u0ganGUWoQU1?=
 =?us-ascii?Q?BsS1HWq1pMcyI6iTRqbCiWyQpnFTlTTjBsGX8aAllT9GTHPsQrwHdMahiwyL?=
 =?us-ascii?Q?EkkAHMXd8w67zkfm+XPyEovc?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4566
Original-Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT008.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: c72b0ed0-7a51-4f4d-9303-08d93d23c6e0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QEpF7AYXciSp2DDOfa0UOXa9wd52wYAe9u86eDsax4vtdnr5sEEeSTubjoZyiO0G1Vz83Z1iyUg/XBeqTPztkj3W0QZ//iO2FTVrPhKQzR/RRu2vrTlyUf/44FeS65UW5zUF+knvM5JgLX5Rp1C2JlMQSXDNNfS11HGW43r73UlgzWDwgugz6Cwz8i69fSUtD7b9M3dRWJoDqg5Vb/314USz4PdRjSueCioio2XM/FEJuX55+2W33HeIJqRN/9pZJrcxZTktKlcUhnDRv5GGu8glYgFgVZkT8bikvJu7gsFhHEKkN6Y03Njhr/ludbddGXXjkpXvMBEQ/7rCDFNX+LBdk1v4JtrVV4J6akdCL0eifCICqxrF2akxf+hwidp0DIY76Dus1JQd9PjEwY/sb7M77n1iKKt4mEcAPW0e6E/jOd6gFiRx/SpVRLB3JlhvCO+RVsifi1MQMSIZ1w/h6UsF1AMFsBnUUC0t0is6fRyHFN2jFNN46IkL9GIg51y+5JfubJQmpY1uczbK61F4iLm/iaSym4P4+nhSd+N8q80yp2vuQVms5lqtIrLeL63LwPGwb9qwQosg8A9vYctoAJhCNoUZ6CD7Sp+Ms/JSiA5TlDuwsZPolzZoB/sHIN78885JDPE7E6tJQa4VZiPjPNO1DMHhh3cIHWXznLHPI/jZbSkxGRMJ2lQN5s+9EsHf4LBVZLNvKNtqTUVnMdZ8JA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(396003)(39850400004)(346002)(136003)(36840700001)(46966006)(316002)(7696005)(2906002)(82310400003)(8936002)(47076005)(5660300002)(54906003)(36860700001)(83380400001)(336012)(6506007)(478600001)(52536014)(26005)(70206006)(81166007)(82740400003)(9686003)(70586007)(33656002)(450100002)(86362001)(53546011)(356005)(8676002)(4326008)(107886003)(6862004)(55016002)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2021 06:37:00.8335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c054bc-990a-4d4b-0b68-08d93d23cc40
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT008.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4205
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Petr

> -----Original Message-----
> From: Petr Mladek <pmladek@suse.com>
> Sent: Monday, June 28, 2021 5:07 PM
> To: Justin He <Justin.He@arm.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Peter Zijlstra
> (Intel) <peterz@infradead.org>; Eric Biggers <ebiggers@google.com>; Ahmed=
 S.
> Darwish <a.darwish@linutronix.de>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org; Matthew Wilcox
> <willy@infradead.org>; Christoph Hellwig <hch@infradead.org>; nd
> <nd@arm.com>; Steven Rostedt <rostedt@goodmis.org>; Sergey Senozhatsky
> <senozhatsky@chromium.org>; Rasmus Villemoes <linux@rasmusvillemoes.dk>;
> Jonathan Corbet <corbet@lwn.net>; Alexander Viro <viro@zeniv.linux.org.uk=
>;
> Linus Torvalds <torvalds@linux-foundation.org>
> Subject: Re: [PATCH v2 1/4] fs: introduce helper d_path_unsafe()
>=20
> On Mon 2021-06-28 05:13:51, Justin He wrote:
> > Hi Andy, Petr
> >
> > > -----Original Message-----
> > > From: Jia He <justin.he@arm.com>
> > > Sent: Wednesday, June 23, 2021 1:50 PM
> > > To: Petr Mladek <pmladek@suse.com>; Steven Rostedt
> <rostedt@goodmis.org>;
> > > Sergey Senozhatsky <senozhatsky@chromium.org>; Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com>; Rasmus Villemoes
> > > <linux@rasmusvillemoes.dk>; Jonathan Corbet <corbet@lwn.net>; Alexand=
er
> > > Viro <viro@zeniv.linux.org.uk>; Linus Torvalds <torvalds@linux-
> > > foundation.org>
> > > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>; Eric Biggers
> > > <ebiggers@google.com>; Ahmed S. Darwish <a.darwish@linutronix.de>;
> linux-
> > > doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > > fsdevel@vger.kernel.org; Matthew Wilcox <willy@infradead.org>;
> Christoph
> > > Hellwig <hch@infradead.org>; nd <nd@arm.com>; Justin He
> <Justin.He@arm.com>
> > > Subject: [PATCH v2 1/4] fs: introduce helper d_path_unsafe()
> > >
> > > This helper is similar to d_path() except that it doesn't take any
> > > seqlock/spinlock. It is typical for debugging purposes. Besides,
> > > an additional return value *prenpend_len* is used to get the full
> > > path length of the dentry, ingoring the tail '\0'.
> > > the full path length =3D end - buf - prepend_length - 1.
> > >
> > > Previously it will skip the prepend_name() loop at once in
> > > __prepen_path() when the buffer length is not enough or even negative=
.
> > > prepend_name_with_len() will get the full length of dentry name
> > > together with the parent recursively regardless of the buffer length.
> > >
> > > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > > Signed-off-by: Jia He <justin.he@arm.com>
> > > ---
> > >  fs/d_path.c            | 122 ++++++++++++++++++++++++++++++++++++++-=
--
> > >  include/linux/dcache.h |   1 +
> > >  2 files changed, 116 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/fs/d_path.c b/fs/d_path.c
> > > index 23a53f7b5c71..7a3ea88f8c5c 100644
> > > --- a/fs/d_path.c
> > > +++ b/fs/d_path.c
> > > @@ -33,9 +33,8 @@ static void prepend(struct prepend_buffer *p, const
> char
> > > *str, int namelen)
> > >
> > >  /**
> > >   * prepend_name - prepend a pathname in front of current buffer
> pointer
> > > - * @buffer: buffer pointer
> > > - * @buflen: allocated length of the buffer
> > > - * @name:   name string and length qstr structure
> > > + * @p: prepend buffer which contains buffer pointer and allocated
> length
> > > + * @name: name string and length qstr structure
> > >   *
> > >   * With RCU path tracing, it may race with d_move(). Use READ_ONCE()
> to
> > >   * make sure that either the old or the new name pointer and length
> are
> > > @@ -68,9 +67,84 @@ static bool prepend_name(struct prepend_buffer *p,
> > > const struct qstr *name)
> > >  	return true;
> > >  }
> > >
> > > +/**
> > > + * prepend_name_with_len - prepend a pathname in front of current
> buffer
> > > + * pointer with limited orig_buflen.
> > > + * @p: prepend buffer which contains buffer pointer and allocated
> length
> > > + * @name: name string and length qstr structure
> > > + * @orig_buflen: original length of the buffer
> > > + *
> > > + * p.ptr is updated each time when prepends dentry name and its pare=
nt.
> > > + * Given the orginal buffer length might be less than name string, t=
he
> > > + * dentry name can be moved or truncated. Returns at once if !buf or
> > > + * original length is not positive to avoid memory copy.
> > > + *
> > > + * Load acquire is needed to make sure that we see that terminating
> NUL,
> > > + * which is similar to prepend_name().
> > > + */
> > > +static bool prepend_name_with_len(struct prepend_buffer *p,
> > > +				  const struct qstr *name, int orig_buflen)
> > > +{
> > > +	const char *dname =3D smp_load_acquire(&name->name); /* ^^^ */
> > > +	int dlen =3D READ_ONCE(name->len);
> > > +	char *s;
> > > +	int last_len =3D p->len;
> > > +
> > > +	p->len -=3D dlen + 1;
> > > +
> > > +	if (unlikely(!p->buf))
> > > +		return false;
> > > +
> > > +	if (orig_buflen <=3D 0)
> > > +		return false;
> > > +
> > > +	/*
> > > +	 * The first time we overflow the buffer. Then fill the string
> > > +	 * partially from the beginning
> > > +	 */
> > > +	if (unlikely(p->len < 0)) {
> > > +		int buflen =3D strlen(p->buf);
> > > +
> > > +		/* memcpy src */
> > > +		s =3D p->buf;
> > > +
> > > +		/* Still have small space to fill partially */
> > > +		if (last_len > 0) {
> > > +			p->buf -=3D last_len;
> > > +			buflen +=3D last_len;
> > > +		}
> > > +
> > > +		if (buflen > dlen + 1) {
> > > +			/* Dentry name can be fully filled */
> > > +			memmove(p->buf + dlen + 1, s, buflen - dlen - 1);
> > > +			p->buf[0] =3D '/';
> > > +			memcpy(p->buf + 1, dname, dlen);
> > > +		} else if (buflen > 0) {
> > > +			/* Can be partially filled, and drop last dentry */
> > > +			p->buf[0] =3D '/';
> > > +			memcpy(p->buf + 1, dname, buflen - 1);
> > > +		}
> > > +
> > > +		return false;
> > > +	}
> > > +
> > > +	s =3D p->buf -=3D dlen + 1;
> > > +	*s++ =3D '/';
> > > +	while (dlen--) {
> > > +		char c =3D *dname++;
> > > +
> > > +		if (!c)
> > > +			break;
> > > +		*s++ =3D c;
> > > +	}
> > > +	return true;
> > > +}
> > > +
> > >  static int __prepend_path(const struct dentry *dentry, const struct
> mount
> > > *mnt,
> > >  			  const struct path *root, struct prepend_buffer *p)
> > >  {
> > > +	int orig_buflen =3D p->len;
> > > +
> > >  	while (dentry !=3D root->dentry || &mnt->mnt !=3D root->mnt) {
> > >  		const struct dentry *parent =3D READ_ONCE(dentry->d_parent);
> > >
> > > @@ -97,8 +171,7 @@ static int __prepend_path(const struct dentry
> *dentry,
> > > const struct mount *mnt,
> > >  			return 3;
> > >
> > >  		prefetch(parent);
> > > -		if (!prepend_name(p, &dentry->d_name))
> > > -			break;
> > > +		prepend_name_with_len(p, &dentry->d_name, orig_buflen);
> >
> > I have new concern here.
> > Previously,  __prepend_path() would break the loop at once when p.len<0=
.
> > And the return value of __prepend_path() was 0.
> > The caller of prepend_path() would typically check as follows:
> >   if (prepend_path(...) > 0)
> >   	do_sth();
> >
> > After I replaced prepend_name() with prepend_name_with_len(),
> > the return value of prepend_path() is possibly positive
> > together with p.len<0. The behavior is different from previous.
>=20
> I do not feel qualified to make decision here.I do not have enough
> experience with this code.
>=20
> Anyway, the new behavior looks correct to me. The return values
> 1, 2, 3 mean that there was something wrong with the path. The
> new code checks the entire path which looks correct to me.

Okay, got it. Thanks for the explanation.
Seems my concern is not necessary. I once compared the old and new
prepend_path return value, they are always the same in my test scenarios.

--
Cheers,
Justin (Jia He)


