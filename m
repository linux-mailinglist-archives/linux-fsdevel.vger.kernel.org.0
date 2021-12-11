Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C994715B7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Dec 2021 20:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhLKTcV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Dec 2021 14:32:21 -0500
Received: from mail-eopbgr90070.outbound.protection.outlook.com ([40.107.9.70]:45777
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229642AbhLKTcT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Dec 2021 14:32:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJdE2UAqs5/iGX5QUsKiBma8MoCYzwBEdCr8YY1loJfBrNBZFrjDHrKaiDXS8FZSaUksfKogPPA2WMOd0IHxj24tENT5VOSzd9Xdd+DOEKAy1naVmslgEle3z+EkrzRQX1UNwjOMuvPBbWpnuCZte3B0mtZwya2CZ0qgbk+9Rvk1lQ6Ng0sSuQsxVSuy2kUabKLLg/GaaCX7FGYKA9CltxuSeOg5O5kZnbq/Oxa5Pmtfasf2dBy7MNnGVaSXtuJpxDJhR4Ug/kfCWl8d+/XLvm5A2GUUNedWW0uxgkduXSO2ubXQnorFrhE9eMmNkAlvSrJVKsYryKMS124O7MNmJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTetijeQxvWBcrtzxwuFhVt1YoOtdJBLrtAq6JFPUaw=;
 b=dLU/3X5Liikl/aFIMe/qr2hXWJ+BnQyzBxl7KrqJQXMreLW0vFxsGySFvL7S9sPJ47gt2t3oNQcpkpNhfrluvlXWED2iX4s/PSFI9YhQ2iriU5uQobjXHBsEvMbFke5Evod4Qv+dLaf38Y/zkD+iCgcPttxpEN3Azqj6VelEYebGqGmHvSpAIpKSRm4322JYVWVtIKNgrPxcrm5UwnyHDQXN0SBSiX5SWSyRaj9zr9u3WKM5UrpibtYrNvS8nba59r4aHRKY7mDLtfznL7mCbnOn52x0c+7eR9slF4JLdFlhyGZNiPm12+ug4/fsjnNpiZPQfJIJRpBSzs78jRLqXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB1798.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Sat, 11 Dec
 2021 19:32:16 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::fc67:d895:7965:663f]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::fc67:d895:7965:663f%2]) with mapi id 15.20.4778.016; Sat, 11 Dec 2021
 19:32:16 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Tiezhu Yang' <yangtiezhu@loongson.cn>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/2] kdump: simplify code
Thread-Topic: [PATCH v2 0/2] kdump: simplify code
Thread-Index: AQHX7j/lEISC3k0/GEOgnQgt9TGtpawtk5YAgAAbhIA=
Date:   Sat, 11 Dec 2021 19:32:16 +0000
Message-ID: <2dad13be-dcf7-3a96-c287-9452f0dc027e@csgroup.eu>
References: <1639193588-7027-1-git-send-email-yangtiezhu@loongson.cn>
 <0c5cb37139af4f3e85cc2c5115d7d006@AcuMS.aculab.com>
In-Reply-To: <0c5cb37139af4f3e85cc2c5115d7d006@AcuMS.aculab.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 243e5ee6-941f-4526-a241-08d9bcdcf0c7
x-ms-traffictypediagnostic: MRZP264MB1798:EE_
x-microsoft-antispam-prvs: <MRZP264MB17985C26E0E7C14221CA2123ED729@MRZP264MB1798.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KHIjdBO53e1GYN19+ZAQ7eMWAc7SeTVJg65zL4IJ6pGaTYGGtDZpKEQ1TyrgmUyNWL8AvUIRs3iF/i7kp8xLSnqliJqGJHD1vUBy1Sc86/SOVp01wgjmbrSsdSJ2bhjbG7V64R/CmKbKgMlvjggb9oyovHwRcDlaxMw5SIsXqDBHQ6EkJDM+BP3MYoB52eXCGy3olHTpNvnM27g/i/qsZiDQSn7zTCs6MD0Wb5bEIYOpw30vHU4TlNue8lHAIw5i+jbZwvhLwI6R/tUjOyXLMHT0eTImjB04VcpykIIw8BMMv9vM+iZUKD8YH6LfqaexTs+oCfCChM5lxxu1A6p89Gt1NNJyKSIWnQmczjLHE4/WcAom147r6qoELeP9nFnkGEdXAgXU84gR1MAObLD1IS+l86RWuBXj4yTS1hjzddr3VOLoa7Ett8JQLmA+a4HRW2nowWLG9ox7NkwUpsXUhRCuh1kgxPWT/CT87KRcEmiHyFrgNyAA1lBnilaUAnX4hbpA1mH7S8BJ4CnhBhe5oH0hncJcoa5S3Xq/6WrBBqgKe9c8UE5BpirDiHmXTQkp16BFbaHltzo61kHX69yeIjL8g4Zg17isNytJJ1eMw2+JnQhhIYW9QENE/gyRSJ1vtr8Ckrx4XHe6dEeDsN45A0yrMiRjUGfvpQyzNySSsVBmVZ6/MPJepvf0Zw8C5FXsBU1odWiSFLdLWRhsrxCVeGG9zuJq91qwK1jGn3mx3CRqJQMRcHJbzt2U2WJZ0Tg8fuZc2f2rQfypADVxyonw0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(7416002)(122000001)(4744005)(4326008)(31686004)(2906002)(8676002)(6512007)(8936002)(76116006)(6486002)(316002)(91956017)(110136005)(64756008)(71200400001)(66946007)(6506007)(36756003)(66446008)(66476007)(31696002)(508600001)(44832011)(26005)(38070700005)(66574015)(66556008)(2616005)(86362001)(54906003)(5660300002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVFDYWhkKzJiNjFMd3NSY081L3pVVU5jZmhTd2JKRWYyblEwdkJMRFRqbjl4?=
 =?utf-8?B?c2U3YVpHWlp4dEtvNDlLT1d2ZGZNNExHLzZURFlNSWxwMmVFdDIzUXJxRjVY?=
 =?utf-8?B?K0EyaUdMMHEyVmZKckZrZ0EvTnVwN2t1Q0JMY3I0cjRvbWVEeTd2elNqVzAz?=
 =?utf-8?B?SWNXSHN5MjIzZWxxUU9rMHUvd1lJL056TzNsZXYrY0pSQU5GcjhxZGFkaWgz?=
 =?utf-8?B?cCtpQjZkeWRUbGVLMEpGNVhsTTVmdHppRDlZcVN4akJybkU3WS8yWG11cUpa?=
 =?utf-8?B?WHdKN0poMmlWWDZGZ09Db1dnZE5PNUpvS0NxSDl3ejVjOEx5RDNMdjROaWdi?=
 =?utf-8?B?VHh2YkVLZ3dKZktKVGlLY0NXam85dWFUV05CVm9OOE5mQVdEYXNoeDNXM1A4?=
 =?utf-8?B?M0gvRVdPTklJcU41dGRuYWdIRWJmMjlGSzVlU0Z1OXlCN3ZjSlQ5Zk5ZOTZC?=
 =?utf-8?B?Mk5RMWZCZk04R2U4Z2JuZDdUYUJTeWE3SFhENzBoQW5oVDNmL0ZVSmw3OVV2?=
 =?utf-8?B?U0NFaE9Ma0t3d3FTYmIxcTVQazFTbHhuUDVXZzBoUzY1a04vRmtkbS9CSFJw?=
 =?utf-8?B?TUtzMkZNWEI2K0dUNHA3NjRnTDBBbkVxN0hSK1phRkpLVXRhRnhFQXlNUnoz?=
 =?utf-8?B?K2I0c0wzS2J2VHYxalh0UHh3L0hFZDFBbktBcHZUeHVza3FGVXlPQWxnQU80?=
 =?utf-8?B?TlpYbFlBWUpMbDF2MDIwdktWNHo5TmxhajFncHVjK3pkRHlWeHhQckpPRDFF?=
 =?utf-8?B?NFZ1MC9sQlZDUG9oUkI4K2lnd1BzMDVDVkdZdVNGR1E0Y09XTWpUeGZSL0J1?=
 =?utf-8?B?RmlReXVNQ3BIVUNKUXlsUWlCYWcvTS80VXhmckFOQnQ2cEdQak0zd2lsR2Zi?=
 =?utf-8?B?WmNHa2Fma2xadnl3UHF4MlNZYVJaeGttRUtmbXdtMVplMldsUFc3OUJoSjJw?=
 =?utf-8?B?U0dqdGlFUnNJV1BPNzZHQThhUFllVHQ0bHZ5aEtGbExTK1JIODdrN290cmNH?=
 =?utf-8?B?ZmpCbEU5TnV2a2h3Ukd2V3dLN2RoaWtUcXY4aWVMcHZXbFdlSVU2VnVQLzho?=
 =?utf-8?B?cVFtdE1qamdOS2RmYmE1dytVUDF4L0RQbjV6M1JnS0pkaUU2M2I2NitPMWZ3?=
 =?utf-8?B?bHhxem1xR2FWZUdGcm1Pcm5NZ0oyanRHMXEveVhZeU1IWFZ5YnVHUWYrYUlZ?=
 =?utf-8?B?VFZMcVNEU0hyZjNxSnBIY0xwM2I4TVdaN21VSmtTMjFQUTBMbVljMEpjNWZB?=
 =?utf-8?B?QnJZLy80Zks0RldaZG8wSG9nUHIxR0ZOZzhtRGNHbDBHTlJLS21WdHkwakUx?=
 =?utf-8?B?eEpUMEtBaDlGS2VNTFhaYzM4ckthcTAzUHVjZE9TOFRtdVNXTzZZOFFHYXhi?=
 =?utf-8?B?S3RRanJuM1U4dVpPS0VscDFzV0YrRllDWjZmRm1tRVZ6RUNmWmhKaG5FeGts?=
 =?utf-8?B?VGxCTjYyQ0xxTjI2dEdhcGlJeWRNQWJvSGZ4YVhZRXk1RWZkM1RxQVhVbVV2?=
 =?utf-8?B?ZkZHUzFtVHJnVEVJNDN2MEtreDlWaDRpWm9yNEZ3Z2xBL0FDZnh3TFpUOFFt?=
 =?utf-8?B?YlBDVWtVWGN3bFdaSmV4RWpqOFUxS3ZBTkpRdlJEQlRocVVPa3BsR2RVMkwv?=
 =?utf-8?B?eVQ1WVg1QWRsS0h0MHZhTEVmSUNvQWlMWXJGeTNQZjY4a0ZwMU9QVEpGVStW?=
 =?utf-8?B?QlVDWk1MUlh6L2dxQy8vZk0yNDJvNUZMZXh1R1laYzIwREVCcFJFQ0o4NElR?=
 =?utf-8?B?RlRjeVI2S1h1UEVUalF5eXRnODh4QnBJVlA2OWhPSkt4OVhXajFlWGFvc3Bw?=
 =?utf-8?B?TDFkZlZiazdqSHQwclVDNnFiMEY1cXlwR3RhQWNRUHk2R0UydklXRWdVMkNh?=
 =?utf-8?B?NER2K1FvUEcxUS84alVkM2xLampQMzVicjlUVWlIRFhSOWROWURBRExrd3M2?=
 =?utf-8?B?dE1FKys4dWlNTU9jMHZkeW9KTUZNMlFyQW8xb0cwYm1BdDNGQnc4MEtWM1Fr?=
 =?utf-8?B?OVZIRlJBUG5rTDFRYytTblpGR2psTjM5dTJhRy90RmlNVHN2dk4xSUx0a2tX?=
 =?utf-8?B?azZhUGN3RjlpNHZFZTlvNWZSR0VqbDNySWpxMGVkUjk2eG5lN1owemw0TTlD?=
 =?utf-8?B?SWN4Q2dVbjU3RWI4RlJ5VHBrS2kzV28za05ldTBOcTVtUDZMMUs0RlZ2VlFo?=
 =?utf-8?B?TEZScmZhb1Nra3ZZdXc2V1dwYVplWm9IVUVwZ2NXNktaaHJhR3RPQmJ3VjVp?=
 =?utf-8?Q?RAFp9PEiuB8fVEp/7OOhAF85A8n0h/9avlWfEQ6Wow=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C87DC5B0CA5964499922F1A3114944DC@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 243e5ee6-941f-4526-a241-08d9bcdcf0c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2021 19:32:16.7570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Nxh8VujqM3VOVtmVx7i4TaGxPzq+wkc5XfWvT4rDHXFzuhScdEMjTsNR7NcOzMygCKmaT3+60cNBSJDz+Gn04/RQzdI9IgOZXGzkblffJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1798
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCkxlIDExLzEyLzIwMjEgw6AgMTg6NTMsIERhdmlkIExhaWdodCBhIMOpY3JpdMKgOg0KPiBG
cm9tOiBUaWV6aHUgWWFuZw0KPj4gU2VudDogMTEgRGVjZW1iZXIgMjAyMSAwMzozMw0KPj4NCj4+
IHYyOg0KPj4gICAgLS0gYWRkIGNvcHlfdG9fdXNlcl9vcl9rZXJuZWwoKSBpbiBsaWIvdXNlcmNv
cHkuYw0KPj4gICAgLS0gZGVmaW5lIHVzZXJidWYgYXMgYm9vbCB0eXBlDQo+IA0KPiBJbnN0ZWFk
IG9mIGhhdmluZyBhIGZsYWcgdG8gaW5kaWNhdGUgd2hldGhlciB0aGUgYnVmZmVyIGlzIHVzZXIg
b3Iga2VybmVsLA0KPiB3b3VsZCBpdCBiZSBiZXR0ZXIgdG8gaGF2ZSB0d28gc2VwYXJhdGUgYnVm
ZmVyIHBvaW50ZXJzLg0KPiBPbmUgZm9yIGEgdXNlciBzcGFjZSBidWZmZXIsIHRoZSBvdGhlciBm
b3IgYSBrZXJuZWwgc3BhY2UgYnVmZmVyLg0KPiBFeGFjdGx5IG9uZSBvZiB0aGUgYnVmZmVycyBz
aG91bGQgYWx3YXlzIGJlIE5VTEwuDQo+IA0KPiBUaGF0IHdheSB0aGUgZmxhZyBpcyBuZXZlciBp
bmNvcnJlY3RseSBzZXQuDQo+IA0KDQpJdCdzIGEgdmVyeSBnb29kIGlkZWEuDQoNCkkgd2FzIHdv
cnJpZWQgYWJvdXQgdGhlIGNhc3RzIGZvcmNpbmcgdGhlIF9fdXNlciBwcm9wZXJ0eSBhd2F5IGFu
ZCBiYWNrLiANCldpdGggdGhhdCBhcHByb2FjaCB3ZSB3aWxsIHByZXNlcnZlIHRoZSBfX3VzZXIg
dGFncyBvbiB1c2VyIGJ1ZmZlcnMgYW5kIA0KZW5hYmxlIHNwYXJzZSBjaGVja2luZy4NCg0KVGhl
IG9ubHkgbGl0dGxlIGRyYXdiYWNrIEkgc2VlIGlzIHRoYXQgYXBwYXJlbnRseSBHQ0MgZG9lc24n
dCBjb25zaWRlciANCnRoZSBOVUxMIHZhbHVlIGFzIGEgY29uc3RhbnQgYW5kIHRoZXJlZm9yZSBk
b2Vzbid0IHBlcmZvcm0gY29uc3RhbnQgDQpmb2xkaW5nIG9uIHBvaW50ZXJzLiBOb3Qgc3VyZSBp
ZiB0aGlzIGlzIGEgcHJvYmxlbSBoZXJlLg0KDQpDaHJpc3RvcGhl
