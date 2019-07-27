Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3EE07757F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2019 02:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfG0Auv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 20:50:51 -0400
Received: from mail-eopbgr670118.outbound.protection.outlook.com ([40.107.67.118]:15561
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbfG0Auv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 20:50:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDL0GPGoAt5jwBcS5qhFLIXPx1iuoO81vFNH7sqIHO7I3PpQfja4HE8eeIol1jNuK3EHm9KCFz4VQ4EnffYx4KrygyJ97HQ8QjoaGr2sJhnPsXJpFo5mz4d1UUVa8g8HawZ5gUaYFNEnok/Iv1yfN2M0XiPQBToSArCDbQ6rdWSbehXa7wLB+HCn5Sl4TX67XHyRYvtysL+xX0BtmcYlqH8MomcrHTYNzaqJ2TWdrT1uyMzxapZFrcITLl37Si0guZ4kdok2ibdq+I5ARf32zYbpjV26nWQpPgf8siChGP9zah9UTADgObHS7sWKUfGNcIlWDXpLiEugz6tjm5Ka3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBL/cfZU67UAjyjQf19QLEXMeq5tpyg9CtAdvVo7uRY=;
 b=OOrznP/zEaRDkz73UCVRCDIVoJlAC3b3MKw/Tiixaxp/81VUdxHU4rCGvUcuqR39+sOHn9kvaOXPlLEh4rkuPn4OlWT/zjwkQQckFL6kJMIGhdLaImOaeeLuNZ3IcEyHUaDIlHz5oDsJvxO0qz8bdEcGy+zWsKkpu25RE4lO63FLH7xqr9U/blXH1KQpPhLCoVV27Jndk3NBncXzsic3R9eTDnp15mIxssDe01Q6b3ZVlBhA7JgKgG4gydmyIJS6vaxF9fUg33u4MATQUv3HT9I9lZwKzmpDpfdjvKDNB9l4+BcjqpzFQ+hu7aXmHN93shjverD/l36hDUtPfObPSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=raithlin.com;dmarc=pass action=none
 header.from=raithlin.com;dkim=pass header.d=raithlin.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raithlin.onmicrosoft.com; s=selector1-raithlin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBL/cfZU67UAjyjQf19QLEXMeq5tpyg9CtAdvVo7uRY=;
 b=mUG2Meu8I68UTq3PRH8mUyI1fY7UMDXxCloxNYsvLyFY/hiIdnFcDeVdXe/ESYb0JAa8jVKcyXpSTI+DYiQEcaYSfiGFSfcifbpEOhNyNzd4aNiw1QSVgf853gJ4832AtR0wyTXxpfGIRLArH4l3FqtpmTd3BjrltWKdwYnlLKE=
Received: from QB1PR01MB3937.CANPRD01.PROD.OUTLOOK.COM (52.132.85.210) by
 QB1PR01MB2820.CANPRD01.PROD.OUTLOOK.COM (52.132.88.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Sat, 27 Jul 2019 00:50:48 +0000
Received: from QB1PR01MB3937.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d844:70e8:aae4:ca85]) by QB1PR01MB3937.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d844:70e8:aae4:ca85%7]) with mapi id 15.20.2115.005; Sat, 27 Jul 2019
 00:50:48 +0000
From:   "Stephen  Bates" <sbates@raithlin.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v6 00/16] nvmet: add target passthru commands support
Thread-Topic: [PATCH v6 00/16] nvmet: add target passthru commands support
Thread-Index: AQHVQw3IQVh0BKtYjkypaXMSRrkqHabcbz+AgACz7QCAAFeXAIAABIIAgAAKKoCAAA+UAP//ljCA
Date:   Sat, 27 Jul 2019 00:50:47 +0000
Message-ID: <6DF00EEF-5A9D-49C9-A27C-BE34E594D9A9@raithlin.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <1f202de3-1122-f4a3-debd-0d169f545047@suse.de>
 <8fd8813f-f8e1-2139-13bf-b0635a03bc30@deltatee.com>
 <175fa142-4815-ee48-82a4-18eb411db1ae@grimberg.me>
 <76f617b9-1137-48b6-f10d-bfb1be2301df@deltatee.com>
 <e166c392-1548-f0bb-02bc-ced3dd85f301@grimberg.me>
 <1260e01c-6731-52f7-ae83-0b90e0345c68@deltatee.com>
In-Reply-To: <1260e01c-6731-52f7-ae83-0b90e0345c68@deltatee.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1b.0.190715
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com; 
x-originating-ip: [70.65.228.192]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6d6e56c-6d2b-4a61-e552-08d7122c770c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:QB1PR01MB2820;
x-ms-traffictypediagnostic: QB1PR01MB2820:
x-microsoft-antispam-prvs: <QB1PR01MB282002FBBE5ED18932BACF31AAC30@QB1PR01MB2820.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01110342A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(39830400003)(376002)(346002)(189003)(199004)(7416002)(71200400001)(66066001)(486006)(476003)(14444005)(256004)(36756003)(71190400001)(68736007)(6116002)(3846002)(2906002)(5660300002)(6486002)(6246003)(4326008)(8676002)(8936002)(6512007)(33656002)(81166006)(81156014)(86362001)(229853002)(66556008)(66446008)(64756008)(186003)(6436002)(25786009)(53936002)(76176011)(54906003)(99286004)(110136005)(2201001)(26005)(58126008)(508600001)(66476007)(316002)(305945005)(6506007)(446003)(102836004)(11346002)(91956017)(2616005)(14454004)(2501003)(76116006)(7736002)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:QB1PR01MB2820;H:QB1PR01MB3937.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: raithlin.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e302ioJzCrvCYDXPNJWM8jHBDGGEUk6XCuoNHAUt8wuHFaJ4p0ztVUR8u632yjxTOL+XRqeE3QtWp8Kh2pKXA1UJcU0lIeRp9c8u0sulonhpaMbnpUdBYv1TOFeb7hMcpD0bZ5K53rZasTHELsyCO7eY516S1mVlooc/n9PAp4Tm5mOvIqwzzsJK6sFl2XFB6TZZ5Td+65876MG8hFpx8/+7zk02MC3/IkAmQKevOZiwEK2NoD+N0nQxce4MMImSjGKEcl+vvWhtj3ZU5Wg2VhjVsckbKnS0y25lZTCTJMhu1lN9/pFITJVWoq9o8MMeXbTLUZr9oAoA4cNNNl5O7mw3bCcsodjd77IqKRjJyWPPZweAk6cXRGowhjfoswSNxwtqDxpLJAH9IMhM/dhrmvprIUdh/+AjzauIkvxpdx0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CF894C0CB972D469006E91CBAAD11BF@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d6e56c-6d2b-4a61-e552-08d7122c770c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2019 00:50:48.0170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbates@raithlin.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PR01MB2820
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBUaGlzIGlzIGRpZmZlcmVudCBmcm9tIG11bHRpcGF0aCBvbiBzYXkgYSBtdWx0aS1jb250cm9s
bGVyIFBDSSBkZXZpY2UNCj4gYW5kIHRyeWluZyB0byBleHBvc2UgYm90aCB0aG9zZSBjb250cm9s
bGVycyB0aHJvdWdoIHBhc3N0aHJ1LiB0aGlzIGlzDQo+IHdoZXJlIHRoZSBwcm9ibGVtcyB3ZSBh
cmUgZGlzY3Vzc2luZyBjb21lIHVwLg0KDQpJICp0aGluayogdGhlcmUgaXMgc29tZSBjb25mdXNp
b24uIEkgKnRoaW5rKiBTYWdpIGlzIHRhbGtpbmcgYWJvdXQgbmV0d29yayBtdWx0aS1wYXRoIChp
LmUuIHRoZSBhYmlsaXR5IGZvciB0aGUgaG9zdCB0byBjb25uZWN0IHRvIGEgY29udHJvbGxlciBv
biB0aGUgdGFyZ2V0IHZpYSB0d28gZGlmZmVyZW50IG5ldHdvcmsgcGF0aHMgdGhhdCBmYWlsLW92
ZXIgYXMgbmVlZGVkKS4gSSAqdGhpbmsqIExvZ2FuIGlzIHRhbGtpbmcgYWJvdXQgbXVsdGktcG9y
dCBQQ0llIE5WTWUgZGV2aWNlcyB0aGF0IGFsbG93IG5hbWVzcGFjZXMgdG8gYmUgYWNjZXNzZWQg
dmlhIG1vcmUgdGhhbiBvbmUgY29udHJvbGxlciBvdmVyIFBDSWUgKGR1YWwtcG9ydCBOVk1lIFNT
RHMgYmVpbmcgdGhlIG1vc3Qgb2J2aW91cyBleGFtcGxlIG9mIHRoaXMgdG9kYXkpLg0KDQo+IEJ1
dCBpdCdzIHRoZSBtdWx0aXBhdGggdGhyb3VnaCBkaWZmZXJlbnQgcG9ydHMgdGhhdA0KPiAgc2Vl
bXMgaW1wb3J0YW50IGZvciBmYWJyaWNzLiBpZS4gSWYgSSBoYXZlIGEgaG9zdCB3aXRoIGEgcGF0
aCB0aHJvdWdoDQo+ICBSRE1BIGFuZCBhIHBhdGggdGhyb3VnaCBUQ1AgdGhleSBzaG91bGQgYm90
aCB3b3JrIGFuZCBhbGxvdyBmYWlsIG92ZXIuDQoNClllcywgb3IgZXZlbiB0d28gcGF0aHMgdGhh
dCBhcmUgYm90aCBSRE1BIG9yIGJvdGggVENQIGJ1dCB3aGljaCB0YWtlIGEgZGlmZmVyZW50IHBh
dGggdGhyb3VnaCB0aGUgbmV0d29yayBmcm9tIGhvc3QgdG8gdGFyZ2V0Lg0KDQo+IE91ciByZWFs
LXdvcmxkIHVzZSBjYXNlIGlzIHRvIHN1cHBvcnQgb3VyIFBDSSBkZXZpY2Ugd2hpY2ggaGFzIGEg
YnVuY2gNCj4gb2YgdmVuZG9yIHVuaXF1ZSBjb21tYW5kcyBhbmQgaXNuJ3QgbGlrZWx5IHRvIHN1
cHBvcnQgbXVsdGlwbGUNCj4gY29udHJvbGxlcnMgaW4gdGhlIGZvcmVzZWVhYmxlIGZ1dHVyZS4N
Cg0KSSB0aGluayBzb2x2aW5nIHBhc3N0aHJ1IGZvciBzaW5nbGUtcG9ydCBQQ0llIGNvbnRyb2xs
ZXJzIHdvdWxkIGJlIGEgZ29vZCBzdGFydC4NCg0KU3RlcGhlbg0KDQo=
