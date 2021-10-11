Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A2E428461
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 02:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhJKAwF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Oct 2021 20:52:05 -0400
Received: from mail-eopbgr150074.outbound.protection.outlook.com ([40.107.15.74]:44451
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230188AbhJKAwF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Oct 2021 20:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1djTwV7lM5w10opHGUyxZcXDExUnArOBzf8U0OwBEg=;
 b=0oCtVeSMUdAoFqdJh47By79jYZxa1RSAYu4ho8lYPWwY5yMn2haVmXOnauwgLUYg/5bRbbCP4p86f6vqBtJ/ASRP0kLJAazvBbIKKrRkA5LpZZ53qIBxMI+mD2GKDJYXfXXjVR09Xd4nJR8b3GWhD+QVojDvxkH971GWrqXeSSU=
Received: from AM5PR0701CA0061.eurprd07.prod.outlook.com (2603:10a6:203:2::23)
 by DB6PR08MB2759.eurprd08.prod.outlook.com (2603:10a6:6:1d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Mon, 11 Oct
 2021 00:49:59 +0000
Received: from VE1EUR03FT028.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:2:cafe::b6) by AM5PR0701CA0061.outlook.office365.com
 (2603:10a6:203:2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4 via Frontend
 Transport; Mon, 11 Oct 2021 00:49:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT028.mail.protection.outlook.com (10.152.18.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 00:49:58 +0000
Received: ("Tessian outbound e27daf245730:v103"); Mon, 11 Oct 2021 00:49:58 +0000
X-CR-MTA-TID: 64aa7808
Received: from 5c13d8d903e5.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2A80A306-CB86-4BA8-8EC9-54486E6AF7FA.1;
        Mon, 11 Oct 2021 00:49:51 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5c13d8d903e5.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 11 Oct 2021 00:49:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xegn3cXwNItUy882dAQoDdYtO/kT/TVguSoWocV50rR9aXGC417Sv2n2+KeUnCC4b2RediEZRa5Avjtw9d1NV76EBGcnx97TClKoVy0Y/RB4wfaSwAbScUMCYKyvVk4spbutQYCAL/fSJzSEmjf7QEQy5UWARLZSPHSs3eUQwpVOUISsF1fhebDw2pgaqHXhVkb6MaFeLMMS5dlxpUdHFxomM+cxACgwuCtRppzyqYjTz8vBaB4AV9q6/M5lKTiYGMqS8rQRWlj6ocn9KN7k5oOoTl4z5/qdGGwdFSjrihre8OlphKxiOzVpGKMX+VhGkczV1EiPo9UekFK6T8YrHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1djTwV7lM5w10opHGUyxZcXDExUnArOBzf8U0OwBEg=;
 b=AvACpdE2BXKspIn7NtubNryb/1DzPxCTBlfrz4VAr/RpZEpsVCV2Lodynz/JC35PsthZAP5X15d3SIpGDaiQpDTNqjahBzfBDjSeYJDdOEJ9IifAFOVqvEfbXIoB2UU90egAE2NlSgZd9Lu0Bw+Cqoab/dA/1CmJQYMm5TJSUYO7P1zxa1yCe0JQT6nm4qM+1cGSx2KH9XekMg2dkOZHAoFdkXOvV6Iu1+jR51+vprsWPoSN0gYMHjG2MtI66UjEkMTeU18/7mKUOKyitvN+yS4Ih+6RRfP2GpmDjE0rWEfYVCg96S54lfJ3o7+gcMHRKy9MxMNHsMkRpy9pYgiUwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1djTwV7lM5w10opHGUyxZcXDExUnArOBzf8U0OwBEg=;
 b=0oCtVeSMUdAoFqdJh47By79jYZxa1RSAYu4ho8lYPWwY5yMn2haVmXOnauwgLUYg/5bRbbCP4p86f6vqBtJ/ASRP0kLJAazvBbIKKrRkA5LpZZ53qIBxMI+mD2GKDJYXfXXjVR09Xd4nJR8b3GWhD+QVojDvxkH971GWrqXeSSU=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Mon, 11 Oct
 2021 00:49:50 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::80e1:922c:ad90:583d]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::80e1:922c:ad90:583d%3]) with mapi id 15.20.4587.025; Mon, 11 Oct 2021
 00:49:49 +0000
From:   Justin He <Justin.He@arm.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
        Christoph Hellwig <hch@infradead.org>, nd <nd@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH v7 1/5] d_path: fix Kernel doc validator complaints
Thread-Topic: [PATCH v7 1/5] d_path: fix Kernel doc validator complaints
Thread-Index: AQHXeRbH+8qRLszHLkGAO9iLnWzOoqtD17cAgHOJ1YCAD6FJgIAGfK7g
Date:   Mon, 11 Oct 2021 00:49:49 +0000
Message-ID: <AM6PR08MB4376D2F3D2AB31C51260F1EDF7B59@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210715011407.7449-1-justin.he@arm.com>
 <20210715011407.7449-2-justin.he@arm.com>
 <YPAPIsGkom68R1WR@smile.fi.intel.com>
 <92c8b22e-613e-7e8d-8cf9-b995494cf3f3@infradead.org>
 <9bb23730-3c1e-4144-2955-99dccacf010f@infradead.org>
In-Reply-To: <9bb23730-3c1e-4144-2955-99dccacf010f@infradead.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: BBFE44EDB1F7594E8E4B71655B6ED0F5.0
x-checkrecipientchecked: true
Authentication-Results-Original: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: d5611bf6-4ccd-4346-b049-08d98c510d1c
x-ms-traffictypediagnostic: AM7PR08MB5478:|DB6PR08MB2759:
X-Microsoft-Antispam-PRVS: <DB6PR08MB2759BB2C8CC302D1C7F2BF12F7B59@DB6PR08MB2759.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:4502;OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: y3z6m6+NDrJ3EWyl5yx/KivMAO+uQ7jryC4/aV5ADdSj2DA+UaDDQeCI8459nlrHeGQLMGOPFKf0pkcuxkOt86XLmCvUwXm2pN7ZY0amwuDVpfxYBtOn/I8bk714TWVQroBcBymKpkM8nmIITzGRUA5DwJvqBJgKphBxO/w8M1r6pwIiRmyjN77VaU2wBf1G2uhEZcA8CzhnoABGxUPxyE0ZotlR8injYgrncQ13ykrVXhivhSeyQLYYM/BPE84IEdL4tTCnYQH4EH1X0i0tEzDQEM2Kj59k57TTePl3/VSMPabIpl0/wGlV61F6JIFasbR4oN42zFFrsg9No+CT1pbGFflQsXOn8L7nKGlJXAAHrQPKdyJyJGEnu2bhi3V9pv6ia21WHW5qyrm/fPFxpV7CDHN8OjljMLPZ9iP3co/UzDGp1vjcNRu0jj8mWg5gRoXLNscs574PbJRkL4F9IFoB9XBJDcSSnJ0umBwyhU+61E/cC2YKPz2mLc9bqM1R70pj0IaZ8XWX+hLxe44DIK0dKCl0vpWXzqCFU0TvFyRiuAsMIX7XQn9Xcj67u7NpB5X0GrtDxmlHrhbxLuJwP0m8NN9LO9AmmPFu4vjCQc08MHUHQXIWueyfMkA6PNFZ6cT6Fsivlburh6F44FDwkzcQN0HC3CrYmrJO+vqfqRmFp0cCxaExKwbtiyNMkf11iVAkLwa3JTAhS2PXn3EWAg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(5660300002)(122000001)(52536014)(33656002)(26005)(6506007)(7416002)(4326008)(2906002)(7696005)(71200400001)(8936002)(53546011)(66556008)(9686003)(86362001)(83380400001)(38070700005)(186003)(76116006)(66946007)(8676002)(54906003)(66476007)(55016002)(508600001)(64756008)(66446008)(110136005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
Original-Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT028.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: bf5acd51-93c0-455c-dd2a-08d98c510763
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XmOfuPq64Vqs7VwKrPV5QfNDYC7DIizU6/Wipxec1hO3Ie/kGwOdhChBPL/D44getLQNQKDrLVQOrAi2y/RNSX3fCrnQIQ71G88+b88ZBtqOzAaiwTvtvesa6hsFEDu5qEdSfZ7WPa1gHF6u07gBQI9sJfBFnlPD19cXRWFLExVbfDD5GJ2jLXX2OsIJu7lImm8bJ75Ds+TEyvZeCBZhEZZd8TbJADkpr7o9TjmjakGkq1x5+XoIMfmEQmmO3q+qyT226yOsmShrXt877J6S1IumoO/kuBvU+BE3bkNfG+XKNeI5abCQsZFnduqpjfcB1yzJE0N4lMzLhL8UF/ocgFP/TPB4CxFkDa9UpYWKI5+EOzTao6t0cenGcsYEQuYAYkKZrnjLscM0TDuHPqY8IyA4EdJcfD6ERXi35PkV+2DlDD/+UJL5/KSsChwhZ3KJYHVvrpawhievYQYM4RyQZ0WURYmJ3mM4A8a6faYNTRXKOnYmKhVv/MgcuOf0UALPav+HVvcUDC+6sA5nqXQhf2d4eUGfudt9a66b8XUMP4vzoplRexxMC/7pGbD0cmEf/Ht8h27ea/w0ifC77UhsjpsVKkm6V3fvdb0n8u5Hx7YGCH7mTpgjn1h7oJ2djDelkfRMOBuLECk6FN/8j/ERypOu4t5qG1HESIT9G3BY7TxvtOErHJOksPH6Aw9wwt+tlIqRwb+iqmAeq3QkHUBlTg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(4326008)(6506007)(83380400001)(82310400003)(107886003)(9686003)(53546011)(47076005)(450100002)(5660300002)(336012)(55016002)(52536014)(70586007)(186003)(316002)(8676002)(54906003)(110136005)(8936002)(36860700001)(86362001)(26005)(508600001)(7696005)(2906002)(70206006)(33656002)(356005)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 00:49:58.8040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5611bf6-4ccd-4346-b049-08d98c510d1c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT028.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2759
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgUmFuZHkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYW5keSBE
dW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIg
NywgMjAyMSA1OjM5IEFNDQo+IFRvOiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtv
QGxpbnV4LmludGVsLmNvbT47IEp1c3RpbiBIZQ0KPiA8SnVzdGluLkhlQGFybS5jb20+DQo+IENj
OiBQZXRyIE1sYWRlayA8cG1sYWRla0BzdXNlLmNvbT47IFN0ZXZlbiBSb3N0ZWR0IDxyb3N0ZWR0
QGdvb2RtaXMub3JnPjsNCj4gU2VyZ2V5IFNlbm96aGF0c2t5IDxzZW5vemhhdHNreUBjaHJvbWl1
bS5vcmc+OyBSYXNtdXMgVmlsbGVtb2VzDQo+IDxsaW51eEByYXNtdXN2aWxsZW1vZXMuZGs+OyBK
b25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0PjsgQWxleGFuZGVyDQo+IFZpcm8gPHZpcm9A
emVuaXYubGludXgub3JnLnVrPjsgTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LQ0KPiBm
b3VuZGF0aW9uLm9yZz47IFBldGVyIFppamxzdHJhIChJbnRlbCkgPHBldGVyekBpbmZyYWRlYWQu
b3JnPjsgRXJpYw0KPiBCaWdnZXJzIDxlYmlnZ2Vyc0Bnb29nbGUuY29tPjsgQWhtZWQgUy4gRGFy
d2lzaCA8YS5kYXJ3aXNoQGxpbnV0cm9uaXguZGU+Ow0KPiBsaW51eC1kb2NAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gZnNkZXZlbEB2Z2Vy
Lmtlcm5lbC5vcmc7IE1hdHRoZXcgV2lsY294IDx3aWxseUBpbmZyYWRlYWQub3JnPjsgQ2hyaXN0
b3BoDQo+IEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPjsgbmQgPG5kQGFybS5jb20+OyBBbmRy
ZXcgTW9ydG9uIDxha3BtQGxpbnV4LQ0KPiBmb3VuZGF0aW9uLm9yZz4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2NyAxLzVdIGRfcGF0aDogZml4IEtlcm5lbCBkb2MgdmFsaWRhdG9yIGNvbXBsYWlu
dHMNCj4gDQo+IE9uIDkvMjYvMjEgMzo1NyBQTSwgUmFuZHkgRHVubGFwIHdyb3RlOg0KPiA+IE9u
IDcvMTUvMjEgMzozNCBBTSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiA+PiBPbiBUaHUsIEp1
bCAxNSwgMjAyMSBhdCAwOToxNDowM0FNICswODAwLCBKaWEgSGUgd3JvdGU6DQo+ID4+PiBLZXJu
ZWwgZG9jIHZhbGlkYXRvciBjb21wbGFpbnM6DQo+ID4+PiDCoMKgIEZ1bmN0aW9uIHBhcmFtZXRl
ciBvciBtZW1iZXIgJ3AnIG5vdCBkZXNjcmliZWQgaW4gJ3ByZXBlbmRfbmFtZScNCj4gPj4+IMKg
wqAgRXhjZXNzIGZ1bmN0aW9uIHBhcmFtZXRlciAnYnVmZmVyJyBkZXNjcmlwdGlvbiBpbiAncHJl
cGVuZF9uYW1lJw0KPiA+Pg0KPiA+PiBZdXAhDQo+ID4+IFJldmlld2VkLWJ5OiBBbmR5IFNoZXZj
aGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4gPj4NCj4gPg0KPiA+
IEFja2VkLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4gPg0KPiA+
IENhbiB3ZSBnZXQgc29tZW9uZSB0byBtZXJnZSB0aGlzLCBwbGVhc2U/DQo+IA0KPiBIbyBodW0u
ICBKdXN0aW4sIHBsZWFzZSByZXN1Ym1pdCB5b3VyIHBhdGNoIHdpdGggQW5keSdzIFJldmlld2Vk
LWJ5Og0KPiBhbmQgbXkgQWNrZWQtYnk6LiAgU2VuZCBpdCB0byBBbmRyZXcgTW9ydG9uIGFuZCBh
c2sgaGltIHRvIG1lcmdlIGl0Lg0KPiANCj4gVGhhbmtzLg0KDQpPa2F5LCBJIHdpbGwgc2VuZCB0
aGlzIFtwYXRjaCAxLzVdIHNlcGFyYXRlbHkuDQoNCg0KLS0NCkNoZWVycywNCkp1c3RpbiAoSmlh
IEhlKQ0KDQoNCg==
