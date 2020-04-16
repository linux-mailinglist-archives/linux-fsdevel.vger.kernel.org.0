Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD2A1ABA40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 09:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439637AbgDPHse (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 03:48:34 -0400
Received: from mx04.melco.co.jp ([192.218.140.144]:33154 "EHLO
        mx04.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439526AbgDPHs1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:48:27 -0400
Received: from mr04.melco.co.jp (mr04 [133.141.98.166])
        by mx04.melco.co.jp (Postfix) with ESMTP id F13DF3A4331;
        Thu, 16 Apr 2020 16:48:21 +0900 (JST)
Received: from mr04.melco.co.jp (unknown [127.0.0.1])
        by mr04.imss (Postfix) with ESMTP id 492rts6ThzzRkHt;
        Thu, 16 Apr 2020 16:48:21 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr04.melco.co.jp (Postfix) with ESMTP id 492rts69hFzRkD8;
        Thu, 16 Apr 2020 16:48:21 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 492rts5rN7zRkBs;
        Thu, 16 Apr 2020 16:48:21 +0900 (JST)
Received: from JPN01-OS2-obe.outbound.protection.outlook.com (unknown [104.47.92.57])
        by mf03.melco.co.jp (Postfix) with ESMTP id 492rts5RWbzRjNp;
        Thu, 16 Apr 2020 16:48:21 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2d/TAIVczd8YwFKifMTw12fw/dCk+ptvSHmJnms0mXFbV5bkOncHZaojs3Ojm5yQVWOIsmURQKrRgvmi72DX/ktN+HdjCUuge3K5UirX4TwFi2jZIxwGful3RZZoNeoq0+fN78x1SQGwW58Bc0d1Ky42DppwXtsmAojgruwaLlYknxtOQzmpvm0O6JaUz3IL7BvAcyjn+k4PjzjBNvYruUDRnFysya2saTeq34b8wIbPMQ2/gIwyqrdFPJbtWsGhcYPAQRgzcE7ic7b/rvhx20fASCD2SfyUbAJ6vMtpxxN+sxjQqn+g49u2fkdhr2mX0CamdhYz2c0kmGUBrjzyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoAN6DY5xaBiywTHT4ePfb1eWEdJeE3jfCVJpWa58J8=;
 b=cOQXdmXpLMqGmj479UwcsrCFEdI7Pqj6o4zalCjMBBLt0Y8VcAeBAmcbz16NbjpYFuWUIegCOpKJZwfrEcqeqqLkdhbLq0gBGYFHQY5TcmrEDSstKEfakEHdburqBRXJY1LQKtt6EzyaKpVLyHSdvSxOW+8cEsyAqlI332QPgXAfzs2iSJ6o6uRdz+GZspcLOeklMQoLFxgnd438f6kUqC/3SpnvOyIuSj0mezUJ+GEWS6FOrtEWblw00kLmNhrXNnsjMLwjECJ/RhDKcYmdIKupOkUxTHW52kSc3zh7Lmx3h2YJ2itJ4JlAtpGkJuGouvTIIAXqggbWXDKvMG8NDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoAN6DY5xaBiywTHT4ePfb1eWEdJeE3jfCVJpWa58J8=;
 b=cp2Ns5ttliv8yS5vuL1aUTzYDwZvvw8hKDFTTeDFTc0q1fl0Lw/rPSv0jFCl/L2lKsPrdJtFLv9YpkYz4EQ+Q5RNqtR4Hm5RpRgBLVlahEjGredQqIg3hyV1bVChzdqE6QUKisxlkqJvRFaHlbs+JUl7XeKPyPqM5ZAszIXQjrs=
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com (52.133.161.22) by
 TY1SPR01MB1.jpnprd01.prod.outlook.com (52.133.164.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15; Thu, 16 Apr 2020 07:48:21 +0000
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::c5d6:a88e:62c6:4b96]) by TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::c5d6:a88e:62c6:4b96%3]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 07:48:21 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     'Namjae Jeon' <namjae.jeon@samsung.com>
CC:     "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "Motai.Hirotaka@aj.MitsubishiElectric.co.jp" 
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        'Matthew Wilcox' <willy@infradead.org>
Subject: RE: [PATCH v2] exfat: replace 'time_ms' with 'time_10ms'
Thread-Topic: [PATCH v2] exfat: replace 'time_ms' with 'time_10ms'
Thread-Index: AQHWDXnb7kFzLdIDe0GisWVV38Nr1KhvFNoAgAenMeCABJ7GAIAADzTw
Date:   Thu, 16 Apr 2020 07:45:47 +0000
Deferred-Delivery: Thu, 16 Apr 2020 07:48:00 +0000
Message-ID: <TY1PR01MB157830C8558819413762A95D90D80@TY1PR01MB1578.jpnprd01.prod.outlook.com>
References: <20200408074610.35591-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
        <20200408112152.GP21484@bombadil.infradead.org>
        <CGME20200413094319epcas1p236a2145766a672f718030b4199b82956@epcas1p2.samsung.com>
        <TY1PR01MB157894A971A781BE900C5A7590DD0@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <006a01d613ba$e2e19e10$a8a4da30$@samsung.com>
In-Reply-To: <006a01d613ba$e2e19e10$a8a4da30$@samsung.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-melpop: 1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp; 
x-originating-ip: [121.80.0.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f3b3a77-2475-401c-03d2-08d7e1da8905
x-ms-traffictypediagnostic: TY1SPR01MB1:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY1SPR01MB1821A6D0880D8D71CC98990D80@TY1SPR01MB1.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1578.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(366004)(396003)(346002)(136003)(39860400002)(316002)(54906003)(2906002)(71200400001)(478600001)(6916009)(6666004)(8936002)(558084003)(8676002)(7696005)(52536014)(66446008)(86362001)(9686003)(81156014)(66946007)(6506007)(64756008)(76116006)(66556008)(33656002)(66476007)(26005)(55016002)(5660300002)(4326008)(186003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: dc.MitsubishiElectric.co.jp does
 not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MyiyuEbXHK7pM4OChmCQ9JtGLahqEfQR9P0gu3XqMNHSil2TsKmqrIUJImgP1xwjJcno0/Y2ZGpakdEz++TWmiT7i/sPp6b2SeYDpXYh7z4gfJyqWrax7FTG8v6Nq3pdp6Axwyq4Yp5adxP1aI3YOq4xk69bpF2f1BHXNo3lNMM2kIESlfFtROe+rZH8PWdzgi4tZLSmKGUJDQacsvMms2cYH0kiUoaBC7hFadGvkpoMm9bI0K20tTfiLQQOghNXyrdlBq5bivW8uCl8TpkerM7EaoYsfK/e0kgbHFi4HpeuKI7e50CyQJmJO/JdqUwAcYY1nR/4BF6i+Xf86OwyLEM54HUU9tl8XLequ3ZGAE/0vMNnBXlTZ6wLkq153mUcwUhef8HE+e9NpOyvZObTxWsxDTVQVMvGI5Bcn4fJ9o3ZI/MCzy89eAW+8NGyrRDm
x-ms-exchange-antispam-messagedata: UylaPUySsdktcP0feYJIrbSODiuHstlQRwc1QrwCRAbCvWS2gVcx3sf6bBJXxoB3dKgtbo6zTDF8YCY7VBOIqwUYstO4jkLAJ1q3YnRNeXn2LcBtvJ0O6qVPSgmgsaKqvWrRvn53FCpNuxdv1q1N3Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3b3a77-2475-401c-03d2-08d7e1da8905
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 07:48:21.2842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7v9yU8abVxVJXQ/FjuVXYVjcilTqo4NJ+m35ZjiqzqNEjJDHkVoYaLBndYyslwdPNCUgTZuqtfTcuB/oaChoPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1SPR01MB1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiA+IFdoZW4gdXNpbmcgJzEwMCcgZm9yIHRoZSBkaXZpc29yLCBJIHRoaW5rIGNzIChjZW50aS1z
ZWMpIGlzIGVhc2llciB0bw0KPiA+IHVuZGVyc3RhbmQgdGhhbiAxMG1zLg0KPiA+IFdoaWNoIGRv
IHlvdSBwcmVmZXIsIHRpbWVfMTBtcyBvciB0aW1lX2NzPw0KPiBDYW4geW91IHJlc2VuZCB0aGUg
cGF0Y2ggYWdhaW4gYWZ0ZXIgY2hhbmdpbmcgdG8gdGltZV9jcyA/DQoNCk9mIGNvdXJzZS4NCkFu
ZCwgcmViYXNlIHRvIHlvdXIgZm9yLW5leHQuDQoNCg0KQlINCi0tLQ0KS29oYWRhIFRldHN1aGly
byA8S29oYWRhLlRldHN1aGlyb0BkYy5NaXRzdWJpc2hpRWxlY3RyaWMuY28uanA+DQo=
