Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252E13B1182
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 04:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFWCFW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 22:05:22 -0400
Received: from mail-vi1eur05on2053.outbound.protection.outlook.com ([40.107.21.53]:19456
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229774AbhFWCFW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 22:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eohiQaP6zeTtBpCp/Ar5aORanFC5tFbxYXYwEUGybJ0=;
 b=jURaZz7WDkjHb+AfD7JN+JwhdEh/qDxF9dRvUzpUzmPfAsLlv9FUSxAdS4ce/tfLlmBtaUSc2D6C1FmRDNLbEhYSfkba7NDOjZXU884W7FwTi/3db5YaywmxwLXT8NX2jgRIK/BStLn3eXL31LjnH98nAwr2Rb5IdnThGceQZrk=
Received: from DU2PR04CA0202.eurprd04.prod.outlook.com (2603:10a6:10:28d::27)
 by AM9PR08MB6882.eurprd08.prod.outlook.com (2603:10a6:20b:302::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Wed, 23 Jun
 2021 02:03:03 +0000
Received: from DB5EUR03FT044.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:28d:cafe::26) by DU2PR04CA0202.outlook.office365.com
 (2603:10a6:10:28d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend
 Transport; Wed, 23 Jun 2021 02:03:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT044.mail.protection.outlook.com (10.152.21.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Wed, 23 Jun 2021 02:03:02 +0000
Received: ("Tessian outbound 7799c3c2ab28:v96"); Wed, 23 Jun 2021 02:03:02 +0000
X-CR-MTA-TID: 64aa7808
Received: from 0ce0f6aa3013.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 32B8B845-1AED-4583-B33B-E3DF37126AC3.1;
        Wed, 23 Jun 2021 02:02:57 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0ce0f6aa3013.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 23 Jun 2021 02:02:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIzGG0JOEVdHQZmu/omczAVzuLjcBaZwb/1qaFTNR7K7+NHLvm1TZqLXpLOdTMHwzSTHgJ2iwBVpAOkmxrYuDYNhQZbu+r2RDHJQOhvVCdeezcrKVTk2XUqc8rYucBM4XKjXQmDQqiPJEKIm7hG52sJQV4drbTJguEgt2/0t4EQQf5oSZCrnPTisu6RQI+NzXpbKyPCfSwbTxibq20YJZ3+sqyLTThOQbzQxHI/B2IGXpz1Y7a5bJptV4InuWrpb0wr6JvTTV/18aHkEYZbdhXpyIGYEPtMK1U/xiiWuPkb5+O60Rhy7EBSX4s2fcafK1Baf4IG3FzT3U98r75vr/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eohiQaP6zeTtBpCp/Ar5aORanFC5tFbxYXYwEUGybJ0=;
 b=Oghx62Z9T1mC73UOpQG5EdpJluxO8wI1BAcLHbBokTAMdg0+1zkG5xwezioO+Qge/iDLOaL7YttZTCFcYCJpB87DA8XdOkFKuM/QkIOxrV3cHA7xcSv3DqN9kDEqkD+jCiO+Avi6zFJGwBXEGz748499HaiAP6Vw3PhbMySYERNzfftDZEIuin06GpeAZVf2X2mcoTRgdgxQbm2sqyO0sSEJdPisZ6WU8fRoxDzhMtiwUfCOr1VYmcTc9tqYl3qShRw2VXY3R+tlI1p9EpuBW7JL/orpT8dGPO/XQ/IObLmTQzvGdc/C8LqBnT3iqZiwL1EgqLXDS8xjnaoWWkwRZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eohiQaP6zeTtBpCp/Ar5aORanFC5tFbxYXYwEUGybJ0=;
 b=jURaZz7WDkjHb+AfD7JN+JwhdEh/qDxF9dRvUzpUzmPfAsLlv9FUSxAdS4ce/tfLlmBtaUSc2D6C1FmRDNLbEhYSfkba7NDOjZXU884W7FwTi/3db5YaywmxwLXT8NX2jgRIK/BStLn3eXL31LjnH98nAwr2Rb5IdnThGceQZrk=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB5192.eurprd08.prod.outlook.com (2603:10a6:20b:d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 02:02:50 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4242.023; Wed, 23 Jun 2021
 02:02:45 +0000
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
Subject: RE: [PATCH v5 1/4] fs: introduce helper d_path_unsafe()
Thread-Topic: [PATCH v5 1/4] fs: introduce helper d_path_unsafe()
Thread-Index: AQHXZ3APPvTGE0Nw2U+XBRBhCUmYhKsgGSWAgAC+lNA=
Date:   Wed, 23 Jun 2021 02:02:45 +0000
Message-ID: <AM6PR08MB43761598697E6DC08A5E71ADF7089@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210622140634.2436-1-justin.he@arm.com>
 <20210622140634.2436-2-justin.he@arm.com>
 <YNH1d0aAu1WRiua1@smile.fi.intel.com>
In-Reply-To: <YNH1d0aAu1WRiua1@smile.fi.intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 0DCDA65DA8EADD45B04FE7831E661F31.0
x-checkrecipientchecked: true
Authentication-Results-Original: linux.intel.com; dkim=none (message not
 signed) header.d=none;linux.intel.com; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.113]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 8363e872-1429-4272-40ef-08d935eb08ae
x-ms-traffictypediagnostic: AM6PR08MB5192:|AM9PR08MB6882:
X-Microsoft-Antispam-PRVS: <AM9PR08MB6882AD7563D854595669B70BF7089@AM9PR08MB6882.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: U4OwRnmC9a8NuZZxEBhh1rEFgSIhJl5WQZs56/Id6KVzMooSnAaUe2i42cJf7eju8qgVdfrEMZPWjBCYC7d8J/NbgOJg1izixwzdIJxPZvFe39MIR0F+X+a+X5nJRRfrUpMpo4akrs1n68Rh5Qz2rvh4qhepx2dvJ6E/TI5kGl4LQuiaBgHfz8OFKjGRNb+bPE95zLuhtZy9h3NDol+/a+Yd+GiOiawdYsEVL1kodgj/WkQKhKbvL5NAgWzi6kwzzxqkqwxylSZnyt4J+SsSLHwC5BSVSGMvJicdsfmT1MdhBOc/7zL9LDoFObsR5gkcnUtINSkviokfi1pR9Qp1m833X1zdbcDlER8QTvfLjm4f2JAvZhbV2vRGlVOxrN1zsEiCfHYUu54Dotbc9oUqwx0jMoCPhAK8stQ8EXVTZOI0W11Hrrej977SFT0b+05UW3R0E2WcveXcoZbjuoDcoMB/eh67C99nyUoJv3YFAuePPJJY8MshAFmKFWs/t1rF0KrxBVVrFS4+/Z3DESemrsT0+mRa0WM8GrxG8JfgPjwZPGDits+TeVENuj+DBzz7ckCYTYtPqE9n44DJJH68VXPXMRduhszWwTfA2kZKhmw=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(366004)(376002)(346002)(396003)(66946007)(83380400001)(76116006)(2906002)(71200400001)(66446008)(7416002)(4326008)(66476007)(66556008)(64756008)(316002)(38100700002)(86362001)(8676002)(8936002)(122000001)(54906003)(6916009)(478600001)(26005)(55016002)(9686003)(52536014)(7696005)(5660300002)(186003)(6506007)(33656002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGJWbHBaa2dZZ042R1lFRTZiTEtJL1oxcVRzK09leTJ4c05LRjVtYkJlMUpp?=
 =?utf-8?B?ejJ4NEd1NFJ0RFo5REF3bENFQklrOXhIN3lZNVhUcEgzUFJqM0dTa1QxZUsw?=
 =?utf-8?B?M21lWFl5ZGRzZ0UvTHFLempmU2pYZStBUExHY2RwYm92dXIwdnJyZ3h2TTQ4?=
 =?utf-8?B?bk1Yc3F0c2dSRENvVnpXaGRFU1pGaXZleVVYOUtjMjg1TklGa2ltTlg3QXFn?=
 =?utf-8?B?YkdnZWdVd1dXK09FK2Vidm0wdDl3QWU5Z0E0ZEhCR09Lb2RLTElnZndvT0Qw?=
 =?utf-8?B?OVRpUDF0WXNPbE80UWl5YWZxbExTYTM0T0luL3RjVTZqWlM1NVQ2TzBEZHln?=
 =?utf-8?B?MEYrRTkzbWNIS29DM1Vadk1MWC9zb3YzVTBMWUcyRkdZZWo4d080NDR1QVc2?=
 =?utf-8?B?MzNwQ2VXbXRhZGlxdGphWUdMSjQ2U25uTUtaL0F0cXRONG9IT2NMSkZ0NmR5?=
 =?utf-8?B?NHkrZGN0Y2FoZkFpZnRxMnJRenFMK0dCTVA2MHpwSzAvemF5YWlIM3ZpQ3Mz?=
 =?utf-8?B?dEtMYmhPOHJnRmlJTHU1cXFtS09PMHBpWlY3ZHZBRk85a2QrYldneVZ1UGNy?=
 =?utf-8?B?MWVaQVZYWmlFQ0xZY1U4cjVocWRzQ3lsYkJ3N1RRcit0MXA5WUlvOCt1Snla?=
 =?utf-8?B?UVdQQzRMWWtQWHZJZ3JjMzZIVldEelpPTVpRWXRhSXNVVS92YU1nL2NLbzZT?=
 =?utf-8?B?OXBxMFdIdG9sOXp5cFpkcVNSVk9jejZJdDBFUjdvb3R6UUpEUGg3Ym04UDJJ?=
 =?utf-8?B?QURDNEF5U0hrdENhRnpkbVRvMDIwdDE2UEJielF0MzczMjNnTCt1dW44S1pT?=
 =?utf-8?B?NUZMLytMejNEUDR3UXZoZUY3V3dqSXJySFlHNk1GWDF5ZkI1TFVjTWtaZkhx?=
 =?utf-8?B?YlN6RVAxZE9MTkdpeUtmL0tSek9CcHpVaG01UmYxQjZwdXZFeURtQ1c0N3Nu?=
 =?utf-8?B?b09TeTZoYTYvQmo0bjlLRVVkMS9VUTdiSXUxcFFTdHJNK1JjMkhCTmRwanVj?=
 =?utf-8?B?QXg4L1VoVmF0dWROKzA5WVpUNlpwVC9nL0pIbkJQeWYrTmVzM0xwOTRuZWw0?=
 =?utf-8?B?R1VEaGdUSkd4ckh1SzBwUC9nVU85ckp3dDVNZEw5d3d4ZGsrWGgyVGo5ekRi?=
 =?utf-8?B?cFV0ODk2Vk54U09sZFZKSUxCc3JIYWE0Mk00Q0ZOa0VpNEkxR21HV1k2cVdp?=
 =?utf-8?B?dnJ3QXdzK0hUV0hVZjN5TVo1dklucy83MmRSNjQ5WFZKaFBtdEZZQUlHUXZw?=
 =?utf-8?B?V0hyTFAxbkliWHFMOHBvVis0ekU3TEJrdmQ5UGhxeGxpYWlyb2RuU2p5UjA4?=
 =?utf-8?B?ekVmVTVlTVBlVVdCNHJncGFvWXlIWm1ZSUpyOVI1ekNoLzJzSTRvWkJzLzQv?=
 =?utf-8?B?bzdZSzVYR0hPbE5yN3FMQndCQXFUVXF4T2ZUeVRSTHpRZGVGRjM4WU9BOGs5?=
 =?utf-8?B?ZXpRMVBTSGM5YWg0RWtZU0dSaGV2VEFHWTF0bWZDaG5mVUVFNDEwRWtyOGZs?=
 =?utf-8?B?TVlWN3NVM21HSTUyS3V6VVUxUjJIUjd2VEsvQ2djSUFDU2NuNlQ3RGtNVVg1?=
 =?utf-8?B?V3pUYW9TMzhmZXVqVzRvZWNzeGFhRURzeS83bW9nZkh1MFZJQ1ptaTNMNE5z?=
 =?utf-8?B?cHNGVVRmdGVFeVJ2NUV2RUx0TFR5TFNxSVRKeUN5K3l1dE5rZ083Z09MZ0hO?=
 =?utf-8?B?TC9sZ3FEbDdMSm55anFyc3dON2VQL2V2SG9LSzBrTllmSVBvQ215bUM0U3l3?=
 =?utf-8?Q?ybtGrUPK3wzGVLP278OhU2C0k2Ft9QTBQRHtmM2?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5192
Original-Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 67232ab0-dcf2-479e-f2e6-08d935eafe46
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +uux+fbFxjpqRnUtq3sv7TPEUzmh8aWWYW9G26VXi24VqzNwEYV7X9KvNHa1mGeixxuWIstW3qIVMxFAv8WcNSk1EILWFsz/rtNQ6hNAAnJfbDr7+nrYoqZ3ddTqYNIBj0rh0MySbtBuLLvmDGmmANrKoN3grgdVgnc/crwCmcFNtLwXpzBO387YS8udCZpXhqg7UCRKvu+jF3WjRTs+MnEygs6yeOLxcbDRoGUuG2SHq+rH6eGHlAMYUG5l5SylfaVtELtSe+hqkfJvnuq/c1/nQxOfdPZ6wYQD7TKwjMezpEPpv4KhYJ1fBsSQ2ca3CjTlKFezNtb3LtKChsvE3kDbWbYhIMnDdslfUczoK40lZQ+aaaK7pOxbPbo1i9ILvV1XP71OrAV+8TOzDm3u1NcVwZsB4VUu7Fqnt+GLHyrt/mXNZTzVi2kj5boBIpq1sc2f93fAho4rAnDBvus5LLg6tzgmpkFKhcUkGbYxW9kJb6Zbg7TP9X/T5MMJPZVetyJ3XgY5QfLPnOAHnW0LWeMA56w34YvfXtswQsdY7xyeBqUKEEtNzpX4RITnyNPNTwLoupDMJF4LTa6dvAOswiVrr2tnxHTw1i/5v+JZqG1l6N2WBV0MSoUEGq8fP7g1Hlxrx9kkGDSlnrZGdWK0YwpHfF0V6LbmUfSwdhTM5pE=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39850400004)(396003)(36840700001)(46966006)(8936002)(450100002)(53546011)(6506007)(9686003)(47076005)(54906003)(4326008)(478600001)(336012)(82740400003)(70586007)(316002)(8676002)(55016002)(36860700001)(86362001)(83380400001)(70206006)(33656002)(52536014)(186003)(26005)(356005)(7696005)(6862004)(82310400003)(5660300002)(2906002)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 02:03:02.8680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8363e872-1429-4272-40ef-08d935eb08ae
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6882
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgQW5keQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHkgU2hl
dmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBKdW5lIDIyLCAyMDIxIDEwOjM3IFBNDQo+IFRvOiBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBh
cm0uY29tPg0KPiBDYzogUGV0ciBNbGFkZWsgPHBtbGFkZWtAc3VzZS5jb20+OyBTdGV2ZW4gUm9z
dGVkdCA8cm9zdGVkdEBnb29kbWlzLm9yZz47DQo+IFNlcmdleSBTZW5vemhhdHNreSA8c2Vub3po
YXRza3lAY2hyb21pdW0ub3JnPjsgUmFzbXVzIFZpbGxlbW9lcw0KPiA8bGludXhAcmFzbXVzdmls
bGVtb2VzLmRrPjsgSm9uYXRoYW4gQ29yYmV0IDxjb3JiZXRAbHduLm5ldD47IEFsZXhhbmRlcg0K
PiBWaXJvIDx2aXJvQHplbml2LmxpbnV4Lm9yZy51az47IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxk
c0BsaW51eC0NCj4gZm91bmRhdGlvbi5vcmc+OyBQZXRlciBaaWpsc3RyYSAoSW50ZWwpIDxwZXRl
cnpAaW5mcmFkZWFkLm9yZz47IEVyaWMNCj4gQmlnZ2VycyA8ZWJpZ2dlcnNAZ29vZ2xlLmNvbT47
IEFobWVkIFMuIERhcndpc2ggPGEuZGFyd2lzaEBsaW51dHJvbml4LmRlPjsNCj4gbGludXgtZG9j
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+
IGZzZGV2ZWxAdmdlci5rZXJuZWwub3JnOyBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFkZWFk
Lm9yZz47IENocmlzdG9waA0KPiBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz47IG5kIDxuZEBh
cm0uY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDEvNF0gZnM6IGludHJvZHVjZSBoZWxw
ZXIgZF9wYXRoX3Vuc2FmZSgpDQo+IA0KPiBPbiBUdWUsIEp1biAyMiwgMjAyMSBhdCAxMDowNjoz
MVBNICswODAwLCBKaWEgSGUgd3JvdGU6DQo+ID4gVGhpcyBoZWxwZXIgaXMgc2ltaWxhciB0byBk
X3BhdGgoKSBleGNlcHQgdGhhdCBpdCBkb2Vzbid0IHRha2UgYW55DQo+ID4gc2VxbG9jay9zcGlu
bG9jay4gSXQgaXMgdHlwaWNhbCBmb3IgZGVidWdnaW5nIHB1cnBvc2VzLiBCZXNpZGVzLA0KPiA+
IGFuIGFkZGl0aW9uYWwgcmV0dXJuIHZhbHVlICpwcmVucGVuZF9sZW4qIGlzIHVzZWQgdG8gZ2V0
IHRoZSBmdWxsDQo+ID4gcGF0aCBsZW5ndGggb2YgdGhlIGRlbnRyeSwgaW5nb3JpbmcgdGhlIHRh
aWwgJ1wwJy4NCj4gPiB0aGUgZnVsbCBwYXRoIGxlbmd0aCA9IGVuZCAtIGJ1ZiAtIHByZXBlbmRf
bGVuZ3RoIC0gMQ0KPiANCj4gTWlzc2VkIHBlcmlvZCBhdCB0aGUgZW5kIG9mIHNlbnRlbmNlLg0K
PiANCg0KT2theQ0KPiA+IFByZXZpb3VzbHkgaXQgd2lsbCBza2lwIHRoZSBwcmVwZW5kX25hbWUo
KSBsb29wIGF0IG9uY2UgaW4NCj4gPiBfX3ByZXBlbl9wYXRoKCkgd2hlbiB0aGUgYnVmZmVyIGxl
bmd0aCBpcyBub3QgZW5vdWdoIG9yIGV2ZW4gbmVnYXRpdmUuDQo+ID4gcHJlcGVuZF9uYW1lX3dp
dGhfbGVuKCkgd2lsbCBnZXQgdGhlIGZ1bGwgbGVuZ3RoIG9mIGRlbnRyeSBuYW1lDQo+ID4gdG9n
ZXRoZXIgd2l0aCB0aGUgcGFyZW50IHJlY3Vyc2l2ZWx5IHJlZ2FyZGxlc3Mgb2YgdGhlIGJ1ZmZl
ciBsZW5ndGguDQo+IA0KPiA+IElmIHNvbWVvbmUgaW52b2tlcyBzbnByaW50ZigpIHdpdGggc21h
bGwgYnV0IHBvc2l0aXZlIHNwYWNlLA0KPiA+IHByZXBlbmRfbmFtZV93aXRoX2xlbigpIG1vdmVz
IGFuZCBjb3BpZXMgdGhlIHN0cmluZyBwYXJ0aWFsbHkuDQo+ID4NCj4gPiBNb3JlIHRoYW4gdGhh
dCwga2FzcHJpbnRmKCkgd2lsbCBwYXNzIE5VTEwgX2J1Zl8gYW5kIF9lbmRfIGFzIHRoZQ0KPiA+
IHBhcmFtZXRlcnMuIEhlbmNlIHJldHVybiBhdCB0aGUgdmVyeSBiZWdpbm5pbmcgd2l0aCBmYWxz
ZSBpbiB0aGlzIGNhc2UuDQo+IA0KPiBUaGVzZSB0d28gcGFyYWdyYXBocyBhcmUgdGFsa2luZyBh
Ym91dCBwcmludGYoKSBpbnRlcmZhY2UsIHdoaWxlIHBhdGNoIGhhcw0KPiBub3RoaW5nIHRvIGRv
IHdpdGggaXQuIFBsZWFzZSwgcmVwaHJhc2UgaW4gYSB3YXkgdGhhdCBpdCBkb2Vzbid0IHJlZmVy
IHRvDQo+IHRoZQ0KPiBwYXJ0aWN1bGFyIGNhbGxlcnMuIEJldHRlciB0byBtZW50aW9uIHRoZW0g
aW4gdGhlIGNvcnJlc3BvbmRpbmcgcHJpbnRmKCkNCj4gcGF0Y2goZXMpLg0KPiANCg0KT2theQ0K
PiAuLi4NCj4gDQo+ID4gICAqIHByZXBlbmRfbmFtZSAtIHByZXBlbmQgYSBwYXRobmFtZSBpbiBm
cm9udCBvZiBjdXJyZW50IGJ1ZmZlciBwb2ludGVyDQo+ID4gLSAqIEBidWZmZXI6IGJ1ZmZlciBw
b2ludGVyDQo+ID4gLSAqIEBidWZsZW46IGFsbG9jYXRlZCBsZW5ndGggb2YgdGhlIGJ1ZmZlcg0K
PiA+ICsgKiBAcDogcHJlcGVuZCBidWZmZXIgd2hpY2ggY29udGFpbnMgYnVmZmVyIHBvaW50ZXIg
YW5kIGFsbG9jYXRlZCBsZW5ndGgNCj4gDQo+ID4gICAqIEBuYW1lOiAgIG5hbWUgc3RyaW5nIGFu
ZCBsZW5ndGggcXN0ciBzdHJ1Y3R1cmUNCj4gDQo+IEluZGVudGF0aW9uIGlzc3VlIGJ0dywgY2Fu
IGJlIGZpeGVkIGluIHRoZSBzYW1lIHBhdGNoLg0KDQpPa2F5DQo+IA0KPiA+ICAgKg0KPiA+ICAg
KiBXaXRoIFJDVSBwYXRoIHRyYWNpbmcsIGl0IG1heSByYWNlIHdpdGggZF9tb3ZlKCkuIFVzZSBS
RUFEX09OQ0UoKSB0bw0KPiANCj4gU2hvdWxkbid0IHRoaXMgYmUgYSBzZXBhcmF0ZSBjaGFuZ2Ug
d2l0aCBjb3JyZXNwb25kaW5nIEZpeGVzIHRhZz8NCg0KU29ycnksIEkgZG9uJ3QgcXVpdGUgdW5k
ZXJzdGFuZCBoZXJlLg0KV2hhdCBkbyB5b3Ugd2FudCB0byBmaXg/DQoNCj4gDQo+IC4uLg0KPiAN
Cj4gPiArLyoqDQo+ID4gKyAqIGRfcGF0aF91bnNhZmUgLSByZXR1cm4gdGhlIGZ1bGwgcGF0aCBv
ZiBhIGRlbnRyeSB3aXRob3V0IHRha2luZw0KPiA+ICsgKiBhbnkgc2VxbG9jay9zcGlubG9jay4g
VGhpcyBoZWxwZXIgaXMgdHlwaWNhbCBmb3IgZGVidWdnaW5nIHB1cnBvc2VzLg0KPiANCj4gU2Vl
bXMgeW91IGlnbm9yZWQgbXkgY29tbWVudCwgb3IgZm9yZ2V0IHRvIHRlc3QsIG9yIGNvbXBpbGUg
dGVzdCB3aXRoDQo+IGtlcm5lbA0KPiBkb2MgdmFsaWRhdG9yIGVuYWJsZWQgZG9lc24ndCBzaG93
IGFueSBpc3N1ZXMuIElmIGl0J3MgdGhlIGxhdHRlciwgd2UgaGF2ZQ0KPiB0bw0KPiBmaXgga2Vy
bmVsIGRvYyB2YWxpZGF0b3IuDQo+IA0KPiBUTDtEUjogZGVzY3JpYmUgcGFyYW1ldGVycyBhcyB3
ZWxsLg0KPiANCg0KTXkgYmFkLiBBcG9sb2dpemUgZm9yIHRoYXQuDQo+ID4gKyAqLw0KPiANCj4g
Li4uDQo+IA0KPiA+ICsJc3RydWN0IHBhdGggcm9vdDsNCj4gPiArCXN0cnVjdCBtb3VudCAqbW50
ID0gcmVhbF9tb3VudChwYXRoLT5tbnQpOw0KPiA+ICsJREVDTEFSRV9CVUZGRVIoYiwgYnVmLCBi
dWZsZW4pOw0KPiANCj4gQ2FuIHdlZSBrZWVwIHRoaXMgaW4gcmV2ZXJzZWQgeG1hcyB0cmVlIG9y
ZGVyPw0KDQpTdXJlIPCfmIoNCg0KDQotLQ0KQ2hlZXJzLA0KSnVzdGluIChKaWEgSGUpDQoNCg0K
