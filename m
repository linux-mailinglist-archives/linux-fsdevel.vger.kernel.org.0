Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 755401A1AB8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 06:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgDHEBR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 00:01:17 -0400
Received: from mx04.melco.co.jp ([192.218.140.144]:53674 "EHLO
        mx04.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgDHEBR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 00:01:17 -0400
Received: from mr04.melco.co.jp (mr04 [133.141.98.166])
        by mx04.melco.co.jp (Postfix) with ESMTP id EA6183A3F22;
        Wed,  8 Apr 2020 13:01:14 +0900 (JST)
Received: from mr04.melco.co.jp (unknown [127.0.0.1])
        by mr04.imss (Postfix) with ESMTP id 48xrDV6GckzRk8X;
        Wed,  8 Apr 2020 13:01:14 +0900 (JST)
Received: from mf04_second.melco.co.jp (unknown [192.168.20.184])
        by mr04.melco.co.jp (Postfix) with ESMTP id 48xrDV5ySczRjnK;
        Wed,  8 Apr 2020 13:01:14 +0900 (JST)
Received: from mf04.melco.co.jp (unknown [133.141.98.184])
        by mf04_second.melco.co.jp (Postfix) with ESMTP id 48xrDV5wWRzRk9n;
        Wed,  8 Apr 2020 13:01:14 +0900 (JST)
Received: from JPN01-TY1-obe.outbound.protection.outlook.com (unknown [104.47.93.54])
        by mf04.melco.co.jp (Postfix) with ESMTP id 48xrDV5kXczRk5B;
        Wed,  8 Apr 2020 13:01:14 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQt5YYyG7NTdHmXyLqhr13wI+9wjbXRczUjulArvafQiedDi56PU2R85KyBtLZS9N3S2GddU0jsubk1OSo+XrTVKyp1oyrFWjyaY77cewXPqYyPUHEmxveHURx6IaVQEYfkJfjJqx/n6gA+3lnwDo/CZeIN7qzVh3+3yeqE7FnI31vfhHWug2P88xfhv/tvZN06fY637nAXADDHHF/PZpEu7ED0SJmWwKkgOcFfMZQuOZw5XbAq6LTucgG5QaBTz8CGu1CExWsOjhD1bl6VKX5R91HctWvaEmqyN6mKaPGa/G9gPv011loLjJR2cCH1m1u9aFgYiRw3CVuUeLjHpiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YQcHkqTkj5HoqtPWEnuxKX4jz5Ytg39Nn507xmaFBA=;
 b=Jlx/paScw/HpBjQV4e/Tw5p5AmJXQ90G7WKV/L9LgnW8629XhhKVg38KY9Hza2urPFf7KI6sCpxUItL15tb3HMm+0OuB4piJIHlom9hjIK+lZ1I++zo03n67/lAG0wC9wtSXWKl9ylj45pJ/P215IebyTZtpEQJhPiCk9nh4HFJ+A6P7hQQjXoxS14CaIwglm/Ski6vu/zX/+7aRKQ/CP/n9ec3GQwgXLUMBMSyKCfZsFgj5g0cSgn5JOPk9ZRhNyx6Nnwl7cLkWBuKjxU8rMAta+l6HY1271ySty3Xob+jY/5SzG2dNhLs/r/z6TnSdzPuEN4L/QPtXnQXC1qUkzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YQcHkqTkj5HoqtPWEnuxKX4jz5Ytg39Nn507xmaFBA=;
 b=N54RVh26QJroifmhgVuR+nXLmMuaQLtOME0qC+fRgpHzwj7HQ8jWLbMMio5up//lGNKAv3ZQQYJwKdEkSa5kSTBQUbAocgcr7CEkpr5A66u7igc6j+7+Nsxzdb4dTbx15KvCgEDQWzc+7DISu8bIZvgOS+jnH1Tz8vpBxK03Z1w=
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com (52.133.161.22) by
 TY1PR01MB1594.jpnprd01.prod.outlook.com (52.133.161.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Wed, 8 Apr 2020 04:01:14 +0000
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::c5d6:a88e:62c6:4b96]) by TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::c5d6:a88e:62c6:4b96%3]) with mapi id 15.20.2878.022; Wed, 8 Apr 2020
 04:01:14 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     "'pali@kernel.org'" <pali@kernel.org>
CC:     "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'namjae.jeon@samsung.com'" <namjae.jeon@samsung.com>,
        "'sj1557.seo@samsung.com'" <sj1557.seo@samsung.com>,
        "'viro@zeniv.linux.org.uk'" <viro@zeniv.linux.org.uk>
Subject: RE: [PATCH 1/4] exfat: Simplify exfat_utf8_d_hash() for code points
 above U+FFFF
Thread-Topic: [PATCH 1/4] exfat: Simplify exfat_utf8_d_hash() for code points
 above U+FFFF
Thread-Index: AQHWCfgm33iC4HYp6U6hpobeaScABqhrVdFggAIevgCAARtD4A==
Date:   Wed, 8 Apr 2020 03:59:06 +0000
Deferred-Delivery: Wed, 8 Apr 2020 04:01:00 +0000
Message-ID: <TY1PR01MB1578892F886C62868F87663B90C00@TY1PR01MB1578.jpnprd01.prod.outlook.com>
References: <TY1PR01MB15782019FA3094015950830590C70@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200403204037.hs4ae6cl3osogrso@pali>
 <TY1PR01MB1578D63C6F303DE805D75DAA90C20@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200407100648.phkvxbmv2kootyt7@pali>
In-Reply-To: <20200407100648.phkvxbmv2kootyt7@pali>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-melpop: 1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp; 
x-originating-ip: [121.80.0.163]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16449eaa-8bb6-46cf-e1be-08d7db717b30
x-ms-traffictypediagnostic: TY1PR01MB1594:
x-microsoft-antispam-prvs: <TY1PR01MB159470A326D76195848EC20F90C00@TY1PR01MB1594.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1578.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(396003)(346002)(136003)(376002)(366004)(64756008)(76116006)(66946007)(6666004)(55016002)(186003)(478600001)(66476007)(66556008)(26005)(9686003)(81156014)(33656002)(52536014)(8936002)(54906003)(4744005)(86362001)(7696005)(5660300002)(316002)(66446008)(8676002)(6506007)(71200400001)(2906002)(4326008)(6916009)(81166007)(491001);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: dc.MitsubishiElectric.co.jp does
 not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jUqY/4ml88tkiaMZ8qMFm3bfCuZgtx1u2y6p+ODyesNmjKLeUy7aN1btLqvEAavhqnqXqORn7ed2kYwzuMOPB9RdeuJ1qk4PkZMCAoXF2hldTe45gdBWe85MznfDjI9D6fbUXqhHwWFT0oRYbaklFB94K2xRFn5Igz4hC1coWI229AwsJjYwD4xQx34vgwoJXwMzGXHeZNmDQMrihGTwYOEbrCaFKyq4Ec0oQ+8ntTlMKgj8Je+h5z9tlJHj9aEsiC5jTFATiWW3cgHQCRcU6zAWtw0DFYW6oUC9KhXG2JIZ4TPO3gASJRdhB8myG1bWt+TlPMXIJ76HdppzYvbr4v7WNDMvHX8y1SYXuY/g0GkS51CmLSFu8JHiik23C6UdCT9E8IAHqUzL+FIyVr81htRxaQWiGaRddnzJf+nUeVo/FB9Ss/7/Jb5MHdcN3pB2r1Ss7EfaTeaJqHTOFE3dhdfkxeGFtyB77uTS66MVy0Q=
x-ms-exchange-antispam-messagedata: PdneWJLrMTA8AXBdYcZ9GFLVt+4DmO8ELCbuBHLjCeJg4gkzBODmAX/R+FPm3xcAMM9ypGvkM7NKwGIdCHrdw3fUi4LfC+8pdSpBrFuws4w+ilwuJW2fefZ6Nz62LWR2O3sPTAcIJk1NtG3MfpGINw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 16449eaa-8bb6-46cf-e1be-08d7db717b30
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 04:01:13.9813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L5ZWcUP8GCvdvUycg6qBP+sB96iHjhgl3ZfxVJArKGnW+k8gho2LG/BpmxeurEb7ew7DeXdTy9v8zowO8uHwjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1594
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBTbyBwYXJ0aWFsX25hbWVfaGFzaCgpIGxpa2UgSSB1c2VkIGl0IGluIHRoaXMgcGF0Y2ggc2Vy
aWVzIGlzIGVub3VnaD8NCg0KSSB0aGluayBwYXJ0aWFsX25hbWVfaGFzaCgpIGlzIGVub3VnaCBm
b3IgOC8xNi8yMWJpdCBjaGFyYWN0ZXJzLg0KDQpBbm90aGVyIHBvaW50IGFib3V0IHRoZSBkaXNj
cmltaW5hdGlvbiBvZiAyMWJpdCBjaGFyYWN0ZXJzOg0KSSB0aGluayB0aGF0IGNoZWNraW5nIGlu
IGV4ZmF0X3RvdXBwZXIgKCkgY2FuIGJlIG1vcmUgc2ltcGxpZmllZC4NCg0KIGV4OiByZXR1cm4g
YSA8IFBMQU5FX1NJWkUgJiYgc2JpLT52b2xfdXRibFthXSA/IHNiaS0+dm9sX3V0YmxbYV0gOiBh
Ow0KDQotLS0NCktvaGFkYSBUZXRzdWhpcm8gPEtvaGFkYS5UZXRzdWhpcm9AZGMuTWl0c3ViaXNo
aUVsZWN0cmljLmNvLmpwPg0KDQo=
