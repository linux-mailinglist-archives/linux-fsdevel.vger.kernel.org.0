Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF203B1B16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 15:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhFWNba (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 09:31:30 -0400
Received: from mail-eopbgr140048.outbound.protection.outlook.com ([40.107.14.48]:61702
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230163AbhFWNb3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqBwlS3DhzAK7/RavRKAtzVjUj4Y0INBd8ZZl30LAXc=;
 b=7EppqqdU3Sxmd23Xp7vWrRUNYkhydncOGEuUu0p5MRidgH8hqldPEwFst5WS2CaNCSmALC6/S1Wfddht/FGUQMNdRkxn22zYv3zHaUysqvRhVSSJep9UrLNu+vlxhd40jrm+oreFt4Ewbym5J+bS1mKWBtXqFdgRevL08nxpypQ=
Received: from AS8PR04CA0116.eurprd04.prod.outlook.com (2603:10a6:20b:31e::31)
 by DBBPR08MB5963.eurprd08.prod.outlook.com (2603:10a6:10:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 13:28:52 +0000
Received: from AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:31e:cafe::f8) by AS8PR04CA0116.outlook.office365.com
 (2603:10a6:20b:31e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Wed, 23 Jun 2021 13:28:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT020.mail.protection.outlook.com (10.152.16.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 13:28:52 +0000
Received: ("Tessian outbound f945d55369ce:v96"); Wed, 23 Jun 2021 13:28:51 +0000
X-CR-MTA-TID: 64aa7808
Received: from ef14993e90fd.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4D176DDB-E13C-4952-84D0-12E24F9CEB7C.1;
        Wed, 23 Jun 2021 13:28:46 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ef14993e90fd.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 23 Jun 2021 13:28:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLzZgkiA0VhM5D0ZhJPtU6pWpinzOy++txntjgGvzc1amZLx+NGRGxJMGa96zsX5Eh8dLVv0IF/W/SYDVIMCq6BV+H/kC07lGqCv68PbT6SdXYVUjFPmUcSgIn33+tlBF9FeWVvDRSKXvsQX4sc28/yhZuefGHvg41ncyVBnEYkTWfkiny9vkMHQOePNsmSB1EhwT2ZfPEhytdsft9WQ3KhKtn0qVQbgig+b9+yAn7bw58NBemuSYQ7iVwIAVrV77zFwQCQw+QKn/9koADXCQlM0oktELkTTJ9+hYkcRY65ixoS+x3KYO95CcYGWvecGSFgx8X4eImU6/lI+rSAQaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqBwlS3DhzAK7/RavRKAtzVjUj4Y0INBd8ZZl30LAXc=;
 b=Tj777wUouWtjucbQaRL4C2s1cO1lN0MqW+eyGuM4GxIk0vMhrlZ9z6Mz036ek6VtqB0qyOn6v89HubSunnGarc4A0Q+kkQ0hymvs6gwqOrhy4OlXGA5j/cjrXfwlgZm8jRTOY9HDk4toYzk+8dmGeDeGDrr0vJz+Sns19gBIJmRluQt3ao7zmYtY/LKeXszmVBCujB0N+XZ/GfvX4/EFcnKZmKqs7vYAUJffh6XAQRc4SfvbimUEgnc2S2J4UjcGJcuYUKdVuTSA1yWCZHGgJOrVnSXUt0nWUjJuwRbowCRQNK3890advUtFQ8v6LvaoZc3k3QSlMuKeI0F6cvhETg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqBwlS3DhzAK7/RavRKAtzVjUj4Y0INBd8ZZl30LAXc=;
 b=7EppqqdU3Sxmd23Xp7vWrRUNYkhydncOGEuUu0p5MRidgH8hqldPEwFst5WS2CaNCSmALC6/S1Wfddht/FGUQMNdRkxn22zYv3zHaUysqvRhVSSJep9UrLNu+vlxhd40jrm+oreFt4Ewbym5J+bS1mKWBtXqFdgRevL08nxpypQ=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AS8PR08MB6262.eurprd08.prod.outlook.com (2603:10a6:20b:23e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Wed, 23 Jun
 2021 13:28:44 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4242.023; Wed, 23 Jun 2021
 13:28:44 +0000
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
Subject: RE: [PATCH 09/14] d_path: introduce struct prepend_buffer
Thread-Topic: [PATCH 09/14] d_path: introduce struct prepend_buffer
Thread-Index: AQHXTEjYkwczPOUyUkWE0gldq/uCLqshzh/g
Date:   Wed, 23 Jun 2021 13:28:44 +0000
Message-ID: <AM6PR08MB4376D92F354CD17445DC4EC1F7089@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-9-viro@zeniv.linux.org.uk>
In-Reply-To: <20210519004901.3829541-9-viro@zeniv.linux.org.uk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: E5873D195DB62449AEB862E22677EB11.0
x-checkrecipientchecked: true
Authentication-Results-Original: zeniv.linux.org.uk; dkim=none (message not
 signed) header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [223.167.32.100]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: fa77d3ad-ed67-4660-8957-08d9364ad7b4
x-ms-traffictypediagnostic: AS8PR08MB6262:|DBBPR08MB5963:
X-Microsoft-Antispam-PRVS: <DBBPR08MB5963351B5ED8BCEB1AB3AF35F7089@DBBPR08MB5963.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:1201;OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 2dMWByn4T0pbJAWGZVQ26GqAL811fHaheZ0Qubd+/njhL0lfy2qjVfLknWCelEVqyLZxiUT3706yzwctZX6j6MChCozsufHKAkzYEgHfPnLVnRs8DX3BR4aDH4D9VEplekI5QKABrg+ehrYpb8qJ2UMCkVbfzosQ3Ke+3agbiRA5TMzGpVkIb71kfPc6DWGe35oJdgYArszszvR5AdOy/QXn//pIPVUuA6/KoIJkBauxHMN9tZU64GQnaEJcbFlgiEZf9UzaGmmq/84H5YcpIEaug3S1QIilQ3z9AXtM2DG7JzBnt63rIjL2q19qFKIDlfK/FxxnLxz5f09ocWLVBHKihg1xof/EVupIK6ORo79CVCDdZx3T0NUKbluZ86q0fivYEZvWREt1w5xo/VFYJkJDIiEejNVlAQ/JvjNwQF7ahlgtFcEKNdqchciO1vpnXshsdygsfZDM8c/uSVgsuAQODJotR+srmAK6JqYfpyBwlEmSV0I80/oW0NrDwC+/cnf9yEr123c11tcvqaFCYI2P9NzjjZOvzw3J/9oD5JbZJb+/6RCGIq7GPaLYL9dvlG9WWafJfSoKoMq2ZgLGMwi+XagyAkN+h0EH0Kv3K6Y=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(86362001)(71200400001)(30864003)(54906003)(122000001)(55016002)(110136005)(9686003)(316002)(8676002)(7696005)(4326008)(5660300002)(2906002)(186003)(76116006)(6506007)(478600001)(53546011)(8936002)(26005)(64756008)(33656002)(66446008)(66556008)(66476007)(52536014)(66946007)(7416002)(83380400001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ddBkx+sa9f9HxFpJS3Y3JvtctMR7oY1Dee3Qonexr0KTcn2Cr7l9o6iY7NM4?=
 =?us-ascii?Q?utq6m0lY+avizK4r31uR+Sx3jMWrX7NyXnE18/d5yh1wlXql4N+KNVQEMbNI?=
 =?us-ascii?Q?4HWwgEh3JS0S4TfPyl2GH3nZJHjgxWpakhcK0arrZ5Dfx5vjQn0ONE21NZfk?=
 =?us-ascii?Q?Hy30Z5gzI2reYUrTJ90P3zIJzioKTdPD19QPp5pUNCA6n75Qd2zxo/GT3+RF?=
 =?us-ascii?Q?2NVOraFK4YCq2gk43hwjnuOp0IArTOrBkBSlOU70Z0WgFZy03aikRyDQzbip?=
 =?us-ascii?Q?p20E6wO7n1gMEfteGag3QB4BI9kVpN84rBxEP39YNywRlwKzWKg8a5Z7+kuZ?=
 =?us-ascii?Q?6nGPTu3/lnVoZ6TDEeTnXblBd0U3BDQpL3OGeit4lRIrWehFV8gAn4oPhRBJ?=
 =?us-ascii?Q?M/5U502vQzT6k5hn/AHTKYPG9Wo2lZUYnToaRHZx9HUQz3Z816u8HXQyXuBd?=
 =?us-ascii?Q?9N+FsoUm9erjrgk/XFQuCihSAgbPsMCeXcyQzxnqj407ZFpu4yGERBnuYrGz?=
 =?us-ascii?Q?Jm7VZ9V85c0lzubMwea1wjYH4d8b/dTkd6t7AXuzjLC5b/WYkK564eljV0Co?=
 =?us-ascii?Q?c1kvaV3d8bgTJrElKplyse0QAVuZDVlT4dKVDtJWh7gjL1orl48yN2gR3cx1?=
 =?us-ascii?Q?GRHBIWIrx5ka42+G4bzEzhiUZns+z52HZ5ha3tIVfjbmhTYwfVCMs04T6MAj?=
 =?us-ascii?Q?UwLG4Gd0yMFyUr1zdoy65f871TnONPOEeleoetbj98VIQ7nU123hekAh8oIP?=
 =?us-ascii?Q?a2jH11O8z9uxzg8yZv7BtPFazaiPsz65RlpMljxqZ6FLPhUxbYX5aGEMoPMJ?=
 =?us-ascii?Q?iDrz6C3c/VSvy4Sn6iPHOPvkS/12iWRC1cE6qu1pmONSxmDIPL65yMV5o/7R?=
 =?us-ascii?Q?aCpiSYTqc3qFnYe1J46ailW6dMuELrr2v1/gcvDsLuJRm2jTi5GWl6hYa72O?=
 =?us-ascii?Q?/cJ9VxFp1yFLjsNnwx4Ih0VFqIAbHwCrJqr5+KaSgPOGedpAWHiXk5JZybfh?=
 =?us-ascii?Q?T30pG6ekqhHtmgGQvHh1G37Ez/k9+D/LDH+WxlsMa48z8HL/08WbcOvtw/Xe?=
 =?us-ascii?Q?Ogvp0sG05fKJMUl4L6vBsnxT3TKXW7GqAiz88NdkDOnBz8tTASqGVub5Vxqm?=
 =?us-ascii?Q?1MvkdVHpKdGkELT/MNfqRLDNVscsWK6rxKG2/lErJ27/e1OumRCRX0CYRPX2?=
 =?us-ascii?Q?ppsqVkbmi5mD17PSTl0PydlgrVbF8n6j/2j8gIkW7dNLe2hoXF97COW8siPZ?=
 =?us-ascii?Q?HBGYjvvSXzrgaf9LR1OY+nWaeXxoaOwLK9Kl/o9IaZ2NftWaujLWhyeFyaMK?=
 =?us-ascii?Q?V+HQ4OdD4AbXvfd419djlPe5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6262
Original-Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 04b22182-46cb-483e-3920-08d9364ad327
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +RKcn9+65B3kdYVhUFT5rh0TaOoufQ8rHIQasCPrh4rawBNnUZbrC2/YM9XGg6SQWLzClBbjeXHLg2TXoGAcD1LY3R1DvQ7VX+QJwhLPSjgqxx0BDFVZJwgxXng+pTBCGI7/KoknMwVFF3FvlwrOjH5buKrwZek8DkqDSGUv4LAPc/QTrUTdyPrdsswJOzAdreQ1p9sKke/JGl5wqOYFBlnbz3JnpMY+U7WMNdbM39HSD8nsEoiHZZMWRu1oVEMhH68ezoBwqc44yFMlchXvMaf4bW3xPQjN+t/tYDUr0uZ8WUZnYra/JUVPlPjghuWf6clDJLCdl7fT6OWBNYIVWNpI59HKAnl9k45KF50TWH3Geg8kgchrJkLo+0kAnNrOxp//4Uh70SsWtXLvfG23fs43evV6ftbSjSWP8AOg35oFz0yZrHahWZRYy0yiLsfoIDEPTFBC3CpY6IvUq1ZCxCQohngfBd5yzdqUHQQ+XH1zardDxPuRpmI4vtHsYbBk9smad82yUMIlSlv3STrl2DoxSYgjZnvvd62zULJYu0KWEUwwTnNNGihEIO73QlK1rbbt56bwXSQ6ec6S3WBRfWR9trotaDwziYYn5IPTI4UpP0Fikvyw+v8AwqPhBvueyDlsorl9CxUzOfS/RHKHzVmtxRAHCM5ovhv9sLC3toc=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966006)(36840700001)(26005)(47076005)(55016002)(356005)(86362001)(33656002)(53546011)(478600001)(81166007)(6506007)(110136005)(7696005)(186003)(82740400003)(4326008)(83380400001)(9686003)(54906003)(450100002)(316002)(36860700001)(82310400003)(52536014)(8936002)(8676002)(336012)(70206006)(70586007)(2906002)(5660300002)(30864003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 13:28:52.2849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa77d3ad-ed67-4660-8957-08d9364ad7b4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5963
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
> Subject: [PATCH 09/14] d_path: introduce struct prepend_buffer
>
>         We've a lot of places where we have pairs of form (pointer to end
> of buffer, amount of space left in front of that).  These sit in pairs of
> variables located next to each other and usually passed by reference.
> Turn those into instances of new type (struct prepend_buffer) and pass
> reference to the pair instead of pairs of references to its fields.
>
> Declared and initialized by DECLARE_BUFFER(name, buf, buflen).
>
> extract_string(prepend_buffer) returns the buffer contents if
> no overflow has happened, ERR_PTR(ENAMETOOLONG) otherwise.
> All places where we used to have that boilerplate converted to use
> of that helper.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/d_path.c | 142 ++++++++++++++++++++++++++++++++----------------------=
-
> -----
>  1 file changed, 75 insertions(+), 67 deletions(-)
>
> diff --git a/fs/d_path.c b/fs/d_path.c
> index 83db83446afd..06e93dd031bf 100644
> --- a/fs/d_path.c
> +++ b/fs/d_path.c
> @@ -8,12 +8,26 @@
>  #include <linux/prefetch.h>
>  #include "mount.h"
>
> -static void prepend(char **buffer, int *buflen, const char *str, int
> namelen)
> +struct prepend_buffer {
> +     char *buf;
> +     int len;
> +};
> +#define DECLARE_BUFFER(__name, __buf, __len) \
> +     struct prepend_buffer __name =3D {.buf =3D __buf + __len, .len =3D =
__len}
> +
> +static char *extract_string(struct prepend_buffer *p)
>  {
> -     *buflen -=3D namelen;
> -     if (likely(*buflen >=3D 0)) {
> -             *buffer -=3D namelen;
> -             memcpy(*buffer, str, namelen);
> +     if (likely(p->len >=3D 0))
> +             return p->buf;
> +     return ERR_PTR(-ENAMETOOLONG);
> +}
> +
> +static void prepend(struct prepend_buffer *p, const char *str, int
> namelen)
> +{
> +     p->len -=3D namelen;
> +     if (likely(p->len >=3D 0)) {
> +             p->buf -=3D namelen;
> +             memcpy(p->buf, str, namelen);
>       }
>  }
>
> @@ -34,22 +48,22 @@ static void prepend(char **buffer, int *buflen, const
> char *str, int namelen)
>   *
>   * Load acquire is needed to make sure that we see that terminating NUL.
>   */
> -static bool prepend_name(char **buffer, int *buflen, const struct qstr
> *name)
> +static bool prepend_name(struct prepend_buffer *p, const struct qstr
> *name)

Please also change the parameter description in the comments of
prepend_name(), otherwise "make C=3D1 W=3D1" will report warnings.


--
Cheers,
Justin (Jia He)


>  {
>       const char *dname =3D smp_load_acquire(&name->name); /* ^^^ */
>       u32 dlen =3D READ_ONCE(name->len);
> -     char *p;
> +     char *s;
>
> -     *buflen -=3D dlen + 1;
> -     if (unlikely(*buflen < 0))
> +     p->len -=3D dlen + 1;
> +     if (unlikely(p->len < 0))
>               return false;
> -     p =3D *buffer -=3D dlen + 1;
> -     *p++ =3D '/';
> +     s =3D p->buf -=3D dlen + 1;
> +     *s++ =3D '/';
>       while (dlen--) {
>               char c =3D *dname++;
>               if (!c)
>                       break;
> -             *p++ =3D c;
> +             *s++ =3D c;
>       }
>       return true;
>  }
> @@ -73,15 +87,14 @@ static bool prepend_name(char **buffer, int *buflen,
> const struct qstr *name)
>   */
>  static int prepend_path(const struct path *path,
>                       const struct path *root,
> -                     char **buffer, int *buflen)
> +                     struct prepend_buffer *p)
>  {
>       struct dentry *dentry;
>       struct vfsmount *vfsmnt;
>       struct mount *mnt;
>       int error =3D 0;
>       unsigned seq, m_seq =3D 0;
> -     char *bptr;
> -     int blen;
> +     struct prepend_buffer b;
>
>       rcu_read_lock();
>  restart_mnt:
> @@ -89,8 +102,7 @@ static int prepend_path(const struct path *path,
>       seq =3D 0;
>       rcu_read_lock();
>  restart:
> -     bptr =3D *buffer;
> -     blen =3D *buflen;
> +     b =3D *p;
>       error =3D 0;
>       dentry =3D path->dentry;
>       vfsmnt =3D path->mnt;
> @@ -105,8 +117,7 @@ static int prepend_path(const struct path *path,
>
>                       /* Escaped? */
>                       if (dentry !=3D vfsmnt->mnt_root) {
> -                             bptr =3D *buffer;
> -                             blen =3D *buflen;
> +                             b =3D *p;
>                               error =3D 3;
>                               break;
>                       }
> @@ -127,7 +138,7 @@ static int prepend_path(const struct path *path,
>               }
>               parent =3D dentry->d_parent;
>               prefetch(parent);
> -             if (!prepend_name(&bptr, &blen, &dentry->d_name))
> +             if (!prepend_name(&b, &dentry->d_name))
>                       break;
>
>               dentry =3D parent;
> @@ -148,11 +159,10 @@ static int prepend_path(const struct path *path,
>       }
>       done_seqretry(&mount_lock, m_seq);
>
> -     if (blen =3D=3D *buflen)
> -             prepend(&bptr, &blen, "/", 1);
> +     if (b.len =3D=3D p->len)
> +             prepend(&b, "/", 1);
>
> -     *buffer =3D bptr;
> -     *buflen =3D blen;
> +     *p =3D b;
>       return error;
>  }
>
> @@ -176,24 +186,24 @@ char *__d_path(const struct path *path,
>              const struct path *root,
>              char *buf, int buflen)
>  {
> -     char *res =3D buf + buflen;
> +     DECLARE_BUFFER(b, buf, buflen);
>
> -     prepend(&res, &buflen, "", 1);
> -     if (prepend_path(path, root, &res, &buflen) > 0)
> +     prepend(&b, "", 1);
> +     if (prepend_path(path, root, &b) > 0)
>               return NULL;
> -     return buflen >=3D 0 ? res : ERR_PTR(-ENAMETOOLONG);
> +     return extract_string(&b);
>  }
>
>  char *d_absolute_path(const struct path *path,
>              char *buf, int buflen)
>  {
>       struct path root =3D {};
> -     char *res =3D buf + buflen;
> +     DECLARE_BUFFER(b, buf, buflen);
>
> -     prepend(&res, &buflen, "", 1);
> -     if (prepend_path(path, &root, &res, &buflen) > 1)
> +     prepend(&b, "", 1);
> +     if (prepend_path(path, &root, &b) > 1)
>               return ERR_PTR(-EINVAL);
> -     return buflen >=3D 0 ? res : ERR_PTR(-ENAMETOOLONG);
> +     return extract_string(&b);
>  }
>
>  static void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
> @@ -224,7 +234,7 @@ static void get_fs_root_rcu(struct fs_struct *fs,
> struct path *root)
>   */
>  char *d_path(const struct path *path, char *buf, int buflen)
>  {
> -     char *res =3D buf + buflen;
> +     DECLARE_BUFFER(b, buf, buflen);
>       struct path root;
>
>       /*
> @@ -245,13 +255,13 @@ char *d_path(const struct path *path, char *buf, in=
t
> buflen)
>       rcu_read_lock();
>       get_fs_root_rcu(current->fs, &root);
>       if (unlikely(d_unlinked(path->dentry)))
> -             prepend(&res, &buflen, " (deleted)", 11);
> +             prepend(&b, " (deleted)", 11);
>       else
> -             prepend(&res, &buflen, "", 1);
> -     prepend_path(path, &root, &res, &buflen);
> +             prepend(&b, "", 1);
> +     prepend_path(path, &root, &b);
>       rcu_read_unlock();
>
> -     return buflen >=3D 0 ? res : ERR_PTR(-ENAMETOOLONG);
> +     return extract_string(&b);
>  }
>  EXPORT_SYMBOL(d_path);
>
> @@ -278,36 +288,34 @@ char *dynamic_dname(struct dentry *dentry, char
> *buffer, int buflen,
>
>  char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
>  {
> -     char *end =3D buffer + buflen;
> +     DECLARE_BUFFER(b, buffer, buflen);
>       /* these dentries are never renamed, so d_lock is not needed */
> -     prepend(&end, &buflen, " (deleted)", 11);
> -     prepend(&end, &buflen, dentry->d_name.name, dentry->d_name.len);
> -     prepend(&end, &buflen, "/", 1);
> -     return buflen >=3D 0 ? end : ERR_PTR(-ENAMETOOLONG);
> +     prepend(&b, " (deleted)", 11);
> +     prepend(&b, dentry->d_name.name, dentry->d_name.len);
> +     prepend(&b, "/", 1);
> +     return extract_string(&b);
>  }
>
>  /*
>   * Write full pathname from the root of the filesystem into the buffer.
>   */
> -static char *__dentry_path(const struct dentry *d, char *p, int buflen)
> +static char *__dentry_path(const struct dentry *d, struct prepend_buffer
> *p)
>  {
>       const struct dentry *dentry;
> -     char *end;
> -     int len, seq =3D 0;
> +     struct prepend_buffer b;
> +     int seq =3D 0;
>
>       rcu_read_lock();
>  restart:
>       dentry =3D d;
> -     end =3D p;
> -     len =3D buflen;
> +     b =3D *p;
>       read_seqbegin_or_lock(&rename_lock, &seq);
>       while (!IS_ROOT(dentry)) {
>               const struct dentry *parent =3D dentry->d_parent;
>
>               prefetch(parent);
> -             if (!prepend_name(&end, &len, &dentry->d_name))
> +             if (!prepend_name(&b, &dentry->d_name))
>                       break;
> -
>               dentry =3D parent;
>       }
>       if (!(seq & 1))
> @@ -317,28 +325,29 @@ static char *__dentry_path(const struct dentry *d,
> char *p, int buflen)
>               goto restart;
>       }
>       done_seqretry(&rename_lock, seq);
> -     if (len =3D=3D buflen)
> -             prepend(&end, &len, "/", 1);
> -     return len >=3D 0 ? end : ERR_PTR(-ENAMETOOLONG);
> +     if (b.len =3D=3D p->len)
> +             prepend(&b, "/", 1);
> +     return extract_string(&b);
>  }
>
>  char *dentry_path_raw(const struct dentry *dentry, char *buf, int buflen=
)
>  {
> -     char *p =3D buf + buflen;
> -     prepend(&p, &buflen, "", 1);
> -     return __dentry_path(dentry, p, buflen);
> +     DECLARE_BUFFER(b, buf, buflen);
> +
> +     prepend(&b, "", 1);
> +     return __dentry_path(dentry, &b);
>  }
>  EXPORT_SYMBOL(dentry_path_raw);
>
>  char *dentry_path(const struct dentry *dentry, char *buf, int buflen)
>  {
> -     char *p =3D buf + buflen;
> +     DECLARE_BUFFER(b, buf, buflen);
>
>       if (unlikely(d_unlinked(dentry)))
> -             prepend(&p, &buflen, "//deleted", 10);
> +             prepend(&b, "//deleted", 10);
>       else
> -             prepend(&p, &buflen, "", 1);
> -     return __dentry_path(dentry, p, buflen);
> +             prepend(&b, "", 1);
> +     return __dentry_path(dentry, &b);
>  }
>
>  static void get_fs_root_and_pwd_rcu(struct fs_struct *fs, struct path
> *root,
> @@ -386,24 +395,23 @@ SYSCALL_DEFINE2(getcwd, char __user *, buf, unsigne=
d
> long, size)
>       error =3D -ENOENT;
>       if (!d_unlinked(pwd.dentry)) {
>               unsigned long len;
> -             char *cwd =3D page + PATH_MAX;
> -             int buflen =3D PATH_MAX;
> +             DECLARE_BUFFER(b, page, PATH_MAX);
>
> -             prepend(&cwd, &buflen, "", 1);
> -             if (prepend_path(&pwd, &root, &cwd, &buflen) > 0)
> -                     prepend(&cwd, &buflen, "(unreachable)", 13);
> +             prepend(&b, "", 1);
> +             if (prepend_path(&pwd, &root, &b) > 0)
> +                     prepend(&b, "(unreachable)", 13);
>               rcu_read_unlock();
>
> -             if (buflen < 0) {
> +             if (b.len < 0) {
>                       error =3D -ENAMETOOLONG;
>                       goto out;
>               }
>
>               error =3D -ERANGE;
> -             len =3D PATH_MAX + page - cwd;
> +             len =3D PATH_MAX - b.len;
>               if (len <=3D size) {
>                       error =3D len;
> -                     if (copy_to_user(buf, cwd, len))
> +                     if (copy_to_user(buf, b.buf, len))
>                               error =3D -EFAULT;
>               }
>       } else {
> --
> 2.11.0

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
