Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F074B36D434
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 10:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbhD1IsG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 04:48:06 -0400
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]:41214
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231635AbhD1IsF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 04:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u01j7v+Q9XgqFhucgEVtvHmhMmLrPXyi94W567JStVg=;
 b=qk9EmwLUlbUVCLLlo6+Bb30GqMZs2bYMYSKUFfSoypnVMj/YMB6opU7ruTtg6HdYXnrgDew6IEjDGp18rfNoznUdpz3ScqIo78nbJf8Zzq33pqg4IK4Oe3BgHA4KDp5g4G2dQ2a1ImccunaoP35BP1s1tnM9d37EStQdfxTwfb4=
Received: from DB3PR08CA0018.eurprd08.prod.outlook.com (2603:10a6:8::31) by
 AM6PR08MB5256.eurprd08.prod.outlook.com (2603:10a6:20b:e7::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.24; Wed, 28 Apr 2021 08:47:18 +0000
Received: from DB5EUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:8::4) by DB3PR08CA0018.outlook.office365.com (2603:10a6:8::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Wed, 28 Apr 2021 08:47:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT049.mail.protection.outlook.com (10.152.20.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21 via Frontend Transport; Wed, 28 Apr 2021 08:47:18 +0000
Received: ("Tessian outbound 9bcb3c8d6cb1:v90"); Wed, 28 Apr 2021 08:47:18 +0000
X-CR-MTA-TID: 64aa7808
Received: from ada680db2077.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E7CCC870-4844-4AF2-991C-9CDF86C37D27.1;
        Wed, 28 Apr 2021 08:47:12 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ada680db2077.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 28 Apr 2021 08:47:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaVHPIvoHRbLtJMCjmxNsYzVPUTUn16sx4Vw/m8AidpQ4X2bOzTzNIRlY5K+98R33TCDszurMamjjWKZczGt7vVYQHOV1TrBphftOoKXYT6Kui0EbIhthWkThCK2hLyeSi0IxSyUyGybVCG6boXZKPlVa5j60wqUARxj8rB0itqqk6JLhj5p/JoC7D6Te5CODNQHnxyfkIdtFbMOEF3d2sqhQz+cSA6v4vlYEFklj4RD+p9FZfYxZL6qCaYWm7U2vr3RKSs9PgbPHel0XXsqhvBQIcrTl1ej8Wlgx/k+Zi+as50SwTP0099Hr9zaD5XJqVQZ5hO6jBmy5WQdRLLxlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u01j7v+Q9XgqFhucgEVtvHmhMmLrPXyi94W567JStVg=;
 b=PJ2nZqv7eu5AoGIaAVcjPiWKKjGRUpm0BNULGRJJ6QUS4ZcXLB5lGo9T6PHnkzKqVDcYC8iza2St4xcFdo090lC+66xCU9KuGnLnuDZJfvD/zvL2OYTQyiR4jfBsWlmFV8wuf3UW6roY2vgx3xY9SD/aXbKmAZk60RspMskTjUXBCufmItxzmxiI269HsNy7t2YWn33Kjk4I3wZeT0vucHrRXqviZSBEaTofq60UmR4ymB+DctK+C/Wa7Zea2UcLHcgPUNl8wMKckHEMKzoV4VACbbs6CiuEEJ73QeEYmdik60GzKd/QdvWpN2aZo7q82uRtrrMkHsZNRNN8zcERuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u01j7v+Q9XgqFhucgEVtvHmhMmLrPXyi94W567JStVg=;
 b=qk9EmwLUlbUVCLLlo6+Bb30GqMZs2bYMYSKUFfSoypnVMj/YMB6opU7ruTtg6HdYXnrgDew6IEjDGp18rfNoznUdpz3ScqIo78nbJf8Zzq33pqg4IK4Oe3BgHA4KDp5g4G2dQ2a1ImccunaoP35BP1s1tnM9d37EStQdfxTwfb4=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB3944.eurprd08.prod.outlook.com (2603:10a6:20b:a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 08:47:11 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::18c4:33fd:d055:fe60]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::18c4:33fd:d055:fe60%3]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 08:47:10 +0000
From:   Justin He <Justin.He@arm.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
CC:     "Darrick J. Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>
Subject: RE: [GIT PULL] iomap: new code for 5.13-rc1
Thread-Topic: [GIT PULL] iomap: new code for 5.13-rc1
Thread-Index: AQHXO51Cqf1NQAhE30CBg6xQ5yY+C6rIx96AgAACK4CAAKr1AIAABfQAgAAAxgCAAAleAIAABo8AgAARdMA=
Date:   Wed, 28 Apr 2021 08:47:10 +0000
Message-ID: <AM6PR08MB4376561F967BA6A1082B4741F7409@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210427025805.GD3122264@magnolia>
 <CAHk-=wj6XUGJCgsr+hx3rz=4KvBP-kspn3dqG5v-cKMzzMktUw@mail.gmail.com>
 <20210427195727.GA9661@lst.de>
 <CAHk-=wjrpinf=8gAjxyPoXT0jbK6-U3Urawiykh-zpxeo47Vhg@mail.gmail.com>
 <20210428061706.GC5084@lst.de>
 <CAHk-=whWnFu4wztnOtySjFVYXmBR4Mb2wxrp6OayZqnpKeQw0g@mail.gmail.com>
 <20210428064110.GA5883@lst.de>
 <CAHk-=wjeUhrznxM95ni4z+ynMqhgKGsJUDU8g0vrDLc+fDtYWg@mail.gmail.com>
 <1de23de2-12a9-2b13-3b86-9fe4102fdc0c@rasmusvillemoes.dk>
In-Reply-To: <1de23de2-12a9-2b13-3b86-9fe4102fdc0c@rasmusvillemoes.dk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 319EDE7414929A4198198AEB7338D2F9.0
x-checkrecipientchecked: true
Authentication-Results-Original: rasmusvillemoes.dk; dkim=none (message not
 signed) header.d=none;rasmusvillemoes.dk; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 2584a850-5a99-4e5d-6c47-08d90a223b22
x-ms-traffictypediagnostic: AM6PR08MB3944:|AM6PR08MB5256:
X-Microsoft-Antispam-PRVS: <AM6PR08MB5256F46F669B12D6302E4989F7409@AM6PR08MB5256.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: jEv/RBmMIA+X1PaWM7Lw3oDqHiVAG6XA/hPWgib/4muZtVfKR5mC4YbWrG9CUKKTGnpA9JwPsIjGtLW248HlN8l4Dr81O5LQ9XgighhlbIAKerDMjVHMCHHgMJjXFgrOfqVbXIyRkgcTMaDutAVlU8IJaJCIfLxLfwLYCVBMwA+PBD4hd6Okm3m2yy0lGnyKzj/vq9bj/gzKA9dSiuhTsLleprBAOi+hvD7T4UyyBMY0yel4ln6Zlpd1CjJCLerIWVZrYXFg5LmNTuGd4pmTJd9yWN3I/WQK/O7K7UbAOo900odmE3nUMiS8A2UIK/J761zx5PKzVa4eKQntSYNN+eD/xj7ci2wO/nUhLVI8+onNq9WKzLDChDloqNkiNrVBGWou1PfVDtIY/JiJszZvg/sk6R8JIsk+d60ZtT2yyi+btNDke1kTNfDMKDxHGsaSetXRRzaouZNZnkBmvY35TcX655LvXO9GYgBfXmRyT5zg0qAM3oe6+kF61r63XCn/Cd5MGDXOc5mYHVoMF5JwD0BV+IeNHCWHidEAKKIfZo85XgdZwCn+E+GHVay8ctAU9Gb3NIhaQ4639hw/cGcjnxR63mT6RARqL8C7TwVjFtA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(9686003)(5660300002)(55016002)(26005)(52536014)(83380400001)(66946007)(66476007)(66556008)(66446008)(7416002)(186003)(86362001)(76116006)(478600001)(4326008)(64756008)(53546011)(7696005)(71200400001)(6506007)(316002)(8936002)(2906002)(38100700002)(122000001)(33656002)(110136005)(8676002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: JB8iuul0LfsWjw67mX3DC/wvmQf/Z5iYnQQLpRUAumgUjIrTyxQtRgnJQS29l37wztiVoRgAtV+gHJU/6O0c7tXA396zx7N1SQ0kJesedKNu0RgZPLHZP0bCy17p+BI9bWUVeCW7x51SgJ3hEFmtYQXnKQQ5v5pZUfgCF7TJRe6dqUuFE+5G/2ZMKAPLOBMe4snmdp8AiZBSbxbcMduKWMa/3fWwUlScbmeUqFc2f1FnZxwAvLrgrVYduSVsqU1FU6Jk8zlNttU6Ao72IXlwhxouf6Xgcp+nv3uoemr4g7l0v7wubhMyfqMw/MNlYxhD/mhbcKCva4TfUDHsm5OD+z5sC3DGGHpop8AYPvUw2JHzd5JZ16PiJngjk5xcRnV5sPtCsHGTr3tQ5RKB3XFSvTfi3GEXn2nUlMtiMP+evpPFXKJ9MvoOoqOTVAUIBIdjlkTmZ2B0zWQJRmcRebEjsNi+CVArqdXdN44xQHfQwFzS/njxujUlunSt2yGDj5jEB+3/zIoiZTXNE6tyXYi3TQIn7dSw48N4oxY+EROG8n/CXJmBzZb8AuJDI9EmtMKCvqvMCnXlRagcL0uGq6unRxavVmkDcZB3xlb+3pzoFTmMV6qSxUppd42jHXViSTzQLHqqRnMw3GbMgvsxKzunWmCQez7NKnk/S+OEElIvu7M+pDH/G5jD4dJAN7WU+UxXq9Sdr5UK9EVFR3a1TS6WnyAH75IjzQUySoqtKUarXA4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3944
Original-Authentication-Results: rasmusvillemoes.dk; dkim=none (message not signed)
 header.d=none;rasmusvillemoes.dk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 08782481-c33e-4eef-5a31-08d90a22367a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jesdmguJDrzF2g9Orn0Iu24rT8WyVRQDMuaEirxts3dmP4aL24QCdIRCfvRU1z4mhAzhZM/ccT0xVbOOIakPsnfVu92epVGc80R84FrYbBynQp7kJ6h3WWGe0pWjyILRbIsBIHHnM/++LK8aRVCogJR+IWA9bU9wOqQWziTHMhTgTUyqH6NifXyB/i4UtaqJghI4bomSUk8laPhHFp2t7uMTPkrlD6tsa+v+ZqDftPeI29Z8IUPQUvysI2qcXLd3miwDPNQEohhyr7TjTY+8ldRWWbBXeqZ1XsLPflPUDe0U2chT6r3mR7F/DJgmXxFwTokBy/IjWJXjmsKTa506w/lSj0Ef5h/0/tdTgYHgRJdYkuKmdRt8NIHe8mBN0vqy6ABxUZN6tjZkeReu65YuLmmpSu4vVTaTgaP6ndLc+zBF3Pd+qHxVkMvHTw1goSkCDsbNWwcj10aMbhhVTEHtWGrZ3eCNcabqydhYDe/xNCP0jMzBl7JgHsg+jUFL6bCwjT++pAQ4lNx0ym9HaysVH+dE+eqBH6Q6QtdpQuXg/AA+bMzCAlWE+O9McizOU3TRzUMMIwMFzIVN+nnIqKhAG43n0JJABdGFgKcR+R4jRPh2b+5HTtwWcofQA6SXQh105VEiCn2dgow4ZiDsb3IjNPhgshup/UkHFxMJn6KHZhAdNUKpjahjrJxEK+b04Dot
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(36840700001)(46966006)(52536014)(8936002)(7696005)(70206006)(36860700001)(55016002)(82310400003)(8676002)(336012)(34020700004)(478600001)(82740400003)(356005)(26005)(110136005)(9686003)(81166007)(53546011)(54906003)(6506007)(316002)(86362001)(2906002)(83380400001)(107886003)(47076005)(5660300002)(70586007)(4326008)(450100002)(33656002)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 08:47:18.6793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2584a850-5a99-4e5d-6c47-08d90a223b22
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5256
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYXNtdXMgVmlsbGVt
b2VzIDxsaW51eEByYXNtdXN2aWxsZW1vZXMuZGs+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwg
MjgsIDIwMjEgMzozOCBQTQ0KPiBUbzogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZv
dW5kYXRpb24ub3JnPjsgQ2hyaXN0b3BoIEhlbGx3aWcNCj4gPGhjaEBsc3QuZGU+DQo+IENjOiBE
YXJyaWNrIEouIFdvbmcgPGRqd29uZ0BrZXJuZWwub3JnPjsgSnVzdGluIEhlIDxKdXN0aW4uSGVA
YXJtLmNvbT47IEFsDQo+IFZpcm8gPHZpcm9AemVuaXYubGludXgub3JnLnVrPjsgbGludXgtZnNk
ZXZlbCA8bGludXgtDQo+IGZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPjsgbGludXgteGZzIDxsaW51
eC14ZnNAdmdlci5rZXJuZWwub3JnPjsgRGF2ZQ0KPiBDaGlubmVyIDxkYXZpZEBmcm9tb3JiaXQu
Y29tPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc+OyBFcmljIFNhbmRlZW4gPHNhbmRlZW5Ac2FuZGVlbi5uZXQ+DQo+IFN1YmplY3Q6
IFJlOiBbR0lUIFBVTExdIGlvbWFwOiBuZXcgY29kZSBmb3IgNS4xMy1yYzENCj4NCj4gT24gMjgv
MDQvMjAyMSAwOS4xNCwgTGludXMgVG9ydmFsZHMgd3JvdGU6DQo+IFNvIGxldCBtZSBqdXN0IHF1
b3RlIHRoYXQgZmlyc3QgcmVwbHkgb2YgbWluZSwgYmVjYXVzZSB5b3Ugc2VlbSB0byBub3QNCj4g
PiBoYXZlIHNlZW4gaXQ6DQo+ID4NCj4gPj4gV2UgaGF2ZSAnJXBEJyBmb3IgcHJpbnRpbmcgYSBm
aWxlbmFtZS4gSXQgbWF5IG5vdCBiZSBwZXJmZWN0IChieQ0KPiA+PiBkZWZhdWx0IGl0IG9ubHkg
cHJpbnRzIG9uZSBjb21wb25lbnQsIHlvdSBjYW4gZG8gIiVwRDQiIHRvIHNob3cgdXAgdG8NCj4g
Pj4gZm91ciBjb21wb25lbnRzKSwgYnV0IGl0IHNob3VsZCAiSnVzdFdvcmsodG0pIi4NCj4gPj4N
Cj4gPj4gQW5kIGlmIGl0IGRvZXNuJ3QsIHdlIHNob3VsZCBmaXggaXQuDQo+ID4NCj4gPiBJIHJl
YWxseSB0aGluayAlcEQ0IHNob3VsZCBiZSBtb3JlIHRoYW4gZ29vZCBlbm91Z2guIEFuZCBJIHRo
aW5rIG1heWJlDQo+ID4gd2Ugc2hvdWxkIG1ha2UgcGxhaW4gIiVwRCIgbWVhbiAiYXMgbXVjaCBv
ZiB0aGUgcGF0aCB0aGF0IGlzDQo+ID4gcmVhc29uYWJsZSIgcmF0aGVyIHRoYW4gImFzIGZldyBj
b21wb25lbnRzIGFzIHBvc3NpYmxlIiAoaWUgMSkuDQo+ID4NCj4gPiBTbyBJIGRvbid0IHRoaW5r
ICIlcEQiIChvciAiJXBENCIpIGlzIG5lY2Vzc2FyaWx5IHBlcmZlY3QsIGJ1dCBJIHRoaW5rDQo+
ID4gaXQncyBldmVuIHdvcnNlIHdoZW4gcGVvcGxlIHRoZW4gZ28gYW5kIGRvIG9kZCBhZC1ob2Mg
dGhpbmdzIGJlY2F1c2UNCj4gPiBvZiBzb21lIGluY29udmVuaWVuY2UgaW4gb3VyICVwRCBpbXBs
ZW1lbnRhdGlvbi4NCj4gPg0KPiA+IEZvciBleGFtcGxlLCBjaGFuZ2luZyB0aGUgZGVmYXVsdCB0
byBiZSAic2hvdyBtb3JlIGJ5IGRlZmF1bHQiIHNob3VsZA0KPiA+IGJlIGFzIHNpbXBsZSBhcyBz
b21ldGhpbmcgbGlrZSB0aGUgYXR0YWNoZWQuICBJIGRvIHRoaW5rIHRoYXQgd291bGQgYmUNCj4g
PiB0aGUgbW9yZSBuYXR1cmFsIGJlaGF2aW9yIGZvciAlcEQgLSBkb24ndCBsaW1pdCBpdCB1bm5l
Y2Vzc2FyaWx5IGJ5DQo+ID4gZGVmYXVsdCwgYnV0IGZvciBzb21lYm9keSB3aG8gbGl0ZXJhbGx5
IGp1c3Qgd2FudHMgdG8gc2VlIGEgbWF4aW11bSBvZg0KPiA+IDIgY29tcG9uZW50cywgdXNpbmcg
JyVwRDInIG1ha2VzIHNlbnNlLg0KPiA+DQo+ID4gKFNpbWlsYXJseSwgY2hhbmdpbmcgdGhlIGxp
bWl0IG9mIDQgIGNvbXBvbmVudHMgdG8gc29tZXRoaW5nIHNsaWdodGx5DQo+ID4gYmlnZ2VyIHdv
dWxkIGJlIHRyaXZpYWwpDQo+ID4NCj4gPiBIbW0/DQo+ID4NCj4gPiBHcmVwcGluZyBmb3IgZXhp
c3RpbmcgdXNlcnMgd2l0aA0KPiA+DQo+ID4gICAgIGdpdCBncmVwICclcERbXjEtNF0nDQo+ID4N
Cj4gPiBtb3N0IG9mIHRoZW0gd291bGQgcHJvYmFibHkgbGlrZSBhIGZ1bGwgcGF0aG5hbWUsIGFu
ZCB0aGUgb2RkIHMzOTANCj4gPiBobWNkcnZfZGV2LmMgdXNlIHNob3VsZCBqdXN0IGJlIGZpeGVk
IChpdCBoYXMgYSBoYXJkY29kZWQgIi9kZXYvJXBEIiwNCj4gPiB3aGljaCBzZWVtcyB2ZXJ5IHdy
b25nKS4NCj4NCj4gU28gdGhlIHBhdGNoIG1ha2VzIHNlbnNlIHRvIG1lLiBJZiBzb21lYm9keSBz
YXlzICclcEQ1JywgaXQgd291bGQgZ2V0DQo+IGNhcHBlZCBhdCA0IGluc3RlYWQgb2YgYmVpbmcg
Zm9yY2VkIGRvd24gdG8gMS4gQnV0IG5vdGUgdGhhdCB3aGlsZSB0aGF0DQo+IGdyZXAgb25seSBw
cm9kdWNlcyB+MzYgaGl0cywgaXQgYWxzbyBhZmZlY3RzICVwZCwgb2Ygd2hpY2ggdGhlcmUgYXJl
DQo+IH4yMDAgd2l0aG91dCBhIDItNCBmb2xsb3dpbmcgKGluY2x1ZGluZyBzb21lIHZzcHJpbnRm
IHRlc3QgY2FzZXMgdGhhdA0KPiB3b3VsZCBicmVhaykuIFNvIEkgdGhpbmsgb25lIHdvdWxkIGZp
cnN0IGhhdmUgdG8gZXhwbGljaXRseSBzdXBwb3J0ICcxJywNCj4gc3dpdGNoIG92ZXIgc29tZSB1
c2VycyBieSBhZGRpbmcgdGhhdCAxIGluIHRoZWlyIGZvcm1hdCBzdHJpbmcNCj4gKHRlc3RfdnNw
cmludGYgaW4gcGFydGljdWxhciksIHRoZW4gZmxpcCB0aGUgZGVmYXVsdCBmb3IgJ25vIGRpZ2l0
DQo+IGZvbGxvd2luZyAlcFtkRF0nLg0KDQpJIGNoZWNrZWQgYW5kIGZvdW5kIGEgZmV3IGNoYW5n
ZXMgYXMgZm9sbG93cywgaG9waW5nIEkgZGlkbid0IG1pc3MgZWxzZToNCjEuIHRlc3RfdnNwcmlu
dGYgJXBELT4lcEQxICAlcGQtPiVwZDENCjIuIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvbXZtL2RlYnVnZnMtdmlmLmMNCi4uLy4uLy4uLyVwZDMvJXBkIC0+ICVwZA0KMy4gczM5
MC9obWNkcnYgYXMgbWVudGlvbmVkIGFib3ZlDQoNCi0tDQpDaGVlcnMsDQpKdXN0aW4gKEppYSBI
ZSkNCg0KDQo+DQo+IFJhc211cw0KSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRo
aXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxz
byBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBw
bGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0
aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwg
b3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91
Lg0K
