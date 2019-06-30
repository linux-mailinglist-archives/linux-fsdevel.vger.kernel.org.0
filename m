Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6455B107
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 19:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfF3RmQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 13:42:16 -0400
Received: from mail-qb1can01hn2083.outbound.protection.outlook.com ([52.100.145.83]:14799
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726641AbfF3RmP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 13:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uwoca.onmicrosoft.com;
 s=selector1-uwoca-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JyuDFUmOpzgKH6dgh5LdWzoUOc/E37EGuvvgxjAQ2g=;
 b=3acH5FWp6cHHoDz9UgPn0W1/mimEjzA/wuAQzVRpLnk4+5qQ2Gjlf3XUdx8zFq8lrOkBdPOMLRr5GCrIDpwisWKi7UpokKO8/67yT0uC3b0vVj1xAx0QcMPSTag0K4eZ6IEghsQbSAspEMwjBQQZwv03E9w7synGdz25l4B92Yo=
Received: from YQBPR0101MB1378.CANPRD01.PROD.OUTLOOK.COM (52.132.69.19) by
 YQBPR0101MB1203.CANPRD01.PROD.OUTLOOK.COM (52.132.70.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Sun, 30 Jun 2019 17:42:13 +0000
Received: from YQBPR0101MB1378.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::810f:1394:be78:11a4]) by YQBPR0101MB1378.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::810f:1394:be78:11a4%7]) with mapi id 15.20.2032.019; Sun, 30 Jun 2019
 17:42:13 +0000
From:   Sandra Anne Hamilton <shamil32@uwo.ca>
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Project Analysis
Thread-Topic: Project Analysis
Thread-Index: AQHVL2XZNGRaFfr6Y02Vu5uSvdc5Ng==
Importance: high
X-Priority: 1
Sensitivity: company-confidential
Date:   Sun, 30 Jun 2019 17:04:16 +0000
Message-ID: <YQBPR0101MB137831BE561D4AAE35EA1009A8FE0@YQBPR0101MB1378.CANPRD01.PROD.OUTLOOK.COM>
Reply-To: "mrfuhuangfu101@mufgbank-jp.com" <mrfuhuangfu101@mufgbank-jp.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR16CA0010.namprd16.prod.outlook.com
 (2603:10b6:208:134::23) To YQBPR0101MB1378.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:a::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shamil32@uwo.ca; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [102.165.49.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36d1d2a9-4dc0-4978-ce3e-08d6fd7cfbe7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:YQBPR0101MB1203;
x-ms-traffictypediagnostic: YQBPR0101MB1203:
x-microsoft-antispam-prvs: <YQBPR0101MB120304C8F5F2F3F9717908BEA8FE0@YQBPR0101MB1203.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 008421A8FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(376002)(39860400002)(199004)(189003)(102836004)(558084003)(3480700005)(14454004)(71190400001)(71200400001)(52116002)(7696005)(43066004)(81686011)(6436002)(386003)(53936002)(2501003)(6506007)(55016002)(9686003)(2351001)(99286004)(186003)(229853002)(26005)(5003540100004)(5640700003)(305945005)(66806009)(5660300002)(221733001)(8796002)(81156014)(478600001)(6246003)(86362001)(7736002)(6916009)(316002)(786003)(66066001)(2906002)(486006)(3846002)(6116002)(476003)(8936002)(66556008)(74482002)(25786009)(8676002)(256004)(66446008)(64756008)(66476007)(33656002)(68736007)(66946007)(74316002)(52536014)(73956011)(7116003)(81166006)(130330200001);DIR:OUT;SFP:1501;SCL:1;SRVR:YQBPR0101MB1203;H:YQBPR0101MB1378.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: uwo.ca does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4geemCoa9DelGEpejj+QZXnnaFuD0YFX2yQgeTk1tdng8xeKuWWpoMO8fKZmWZJ3GfYUjhwehk4ZGHro+mEkzHAHoTGQLifcDyeuEa+ftNMrO58ob5hTWDhFF/KYwILC9tMHQF/nbg8uRp57/WTSubet20O6q1PuBsp+k8PZN+rTp1HrndGwh9aABQn5fE1oDwXszE1MQq48kCP27VLeiccO4bsLsFXGmh/Xh+vtEmayfB/HsbW6kvAe+j0h/cAxrU0sGhBNPSZKcvDW1xOjZbyJ7XX/poX7vZUJwFOmyGzmM+5oF/QOZTTiKj3TtzAK9dIb5YULbGb/34VAE9udD9G0EraZFfmD0wgC+YE2fpyB/cl+kXEqkUSdJvmMHacPsTG3LZ+62aNUaT5Jr1Xily5/0r1bVCxEYBmKMZ2R8fs=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <7088C5168939F74AB525D13450ACA9B8@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uwo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d1d2a9-4dc0-4978-ce3e-08d6fd7cfbe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2019 17:04:16.5357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ad93a64d-ad0d-4ecd-b2fd-e53ce15965be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shamil32@uwo.ca
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB1203
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Did you receive my earlier email as  regards the project with Mr Fu huang C=
EO. PLEASE REPLY immediately. Regards.
