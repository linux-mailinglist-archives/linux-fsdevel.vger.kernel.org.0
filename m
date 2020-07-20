Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AF222566A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 06:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgGTEGH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 00:06:07 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31805 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgGTEGG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 00:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595217967; x=1626753967;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=h79+9Q7ofbczWg8SdL29z9wSn1IWeHZ/+baHaRhqp4k=;
  b=UDZSFH6OecWoQzDpTCMkZTWgpbnrS/IHYZBx5Xsvvm0+1g2M/jFNeRD/
   /y/cVxHTTwMtZKOQT62MdFqzPbgfmoPg0s6Vm3lv8/sq/R4Hw/SXTjVV6
   v/tK3N5vlZps4Zncxlz8nCbIfkHUerpYcPeSu6prdfYOOBB8WWA/Q2C4+
   0ucrp/VuSG9RUjHYIvooKCqUtV7+vrlTREPySZlBCk0KyKAMGIwkzuhIs
   X72cZ2TA/6FK539P1QPha29aUzVnCWPjCjV/cHe0ceb8j1hfttZsBjMrJ
   a7I3nxbuXvXrW6uFd0X7Z57n7y59re6c+wbzEVakEqVP0vcAW31U52s08
   w==;
IronPort-SDR: UhQB7twqGSGrTGFLv4AzOCnq5+1CRXvz42e0p6+eqn4Ezj6sfoqO4GGk2cBt/lwCuV5Fjki4t6
 dFv94gSEM+Pinsducnca7+OMXQeJ27poiOWMVrruFn5z4jEsYqY+yCPA7s+SLAmWeUJsWkznvE
 p9+qIexkX0tCB/Pp85V5WLBZcCizSzUZaJWfnQhAVp02HkTpC+WbcqAFmrnEyMKrJIkwz2ySPJ
 p6c/WJB1hlAGDSOXkeBOk6QCpIxajhSli+1iMdBmlKYlrhLrAwkfWYA4FRdG0MPqO6lV9Ac4k0
 9+c=
X-IronPort-AV: E=Sophos;i="5.75,373,1589212800"; 
   d="scan'208";a="142979173"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 12:06:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHI+wvd8buRGmkzkWjpmjBogTMJuUwllSv+ZgP1en7gki3ScvhgVEdKCQZXWbDQ8JxyNoEAs4WAMz7gk1lYXkDj6EmIdFF9UEiyYv49LSLPVDBUiZ+QmW9EuQwQQ6umb2AAIjSNDjPVu6CYfcjsnXEAqHuCFbsXL0g/iItOXwI3tBzha4eTzMzkFKt4IX9dDAiz16wR9blTGnYcxq51xwssZbd5sbtuUgxZl51xWBJbllknxHCEWtjS1LKhd97fgADQHsrq+TOpFyPf0CHhTdU+VFykvX6/SCZNwHyamYxsO10Xin0QWh88VTNUKj2VgQ4g0kbNu4TyZeFERLd2ItQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h79+9Q7ofbczWg8SdL29z9wSn1IWeHZ/+baHaRhqp4k=;
 b=K+Hri2l7QkyLBkAkdhYUMTNYTym0XLI3KZLza9aUWjkJsB2f7xK/NbYR5EorqSG04sOUX9Y7lytzRt26pt7XvlU7A7btjtyjUmK4kDUL+65VmIaGD+sDWxXXecn9LOLLE0TabUcM2bZSfgqT8ohByGV4yCDeVYpa/8afNZtLs2d4Oue8EOJFNm7UQNty201fSnYIWmN0Gq2nLbklT73LDtE/84vvFBlrEEpIWkNOzae32DHL/E9sWPDa2mmdlvSomF92E/8PgzQYfmogx0VWBFqNhtE6jHyBMnCgG7f2OFvmlygYA6FkJdLNbi2sUXbz3u9/11IbTbPpZjWAs6jKAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h79+9Q7ofbczWg8SdL29z9wSn1IWeHZ/+baHaRhqp4k=;
 b=cIBtaV7e+huBektu2PAg6fHlNWDKs2DVDlf33LEThiz4/32A4MqTBDdwx2ae7BAg1oWEBm637qtKbie3/G98M4G8ro/jLbXmNNUfJ1zgal5rur6GJSvmUBaZ+TJe36FoTG9eya4dJ6BVkHvAIC1OSjGvVW7pvlGhpIhNq+VdHGY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4967.namprd04.prod.outlook.com (2603:10b6:a03:4f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 04:06:05 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 04:06:05 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Wang Long <w@laoqinren.net>,
        "willy@infradead.org" <willy@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] xarray: update document for error space returned by
 xarray normal API
Thread-Topic: [PATCH] xarray: update document for error space returned by
 xarray normal API
Thread-Index: AQHWXkn7BxezHRh6hEOAbDMWJCwrQw==
Date:   Mon, 20 Jul 2020 04:06:05 +0000
Message-ID: <BYAPR04MB4965B56CA2FC5FAA812EDED3867B0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1595217437-48158-1-git-send-email-w@laoqinren.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: laoqinren.net; dkim=none (message not signed)
 header.d=none;laoqinren.net; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c057fd8b-e370-4ecb-8d97-08d82c62393c
x-ms-traffictypediagnostic: BYAPR04MB4967:
x-microsoft-antispam-prvs: <BYAPR04MB49679A75FC8B152BD8AFCC93867B0@BYAPR04MB4967.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cJ2kf+pDgsgciwQE9GHpKyBokqUN1vienSy6PhiR2wI7WuCpqAZ2FtY23EmCMgtey2Zd7Cy/MOZSS+w6HpztEYo3h7uNFN/SWwxnTEKJtOrV92AiGVkdunM0N/sgtus5Nzcs/h+YSBiSTAoi0nhdklzE/bX4tULaPLDLoAp3q4GIYzJ4tMyGu7OZQDoNRBZvVTWbOlyGhHPHkVbLlWR1Y51P+za7jOXwo6pE01bHfVq/2Fi575FUyavEt/QdKyaBh1WTR7HamLVHxx2qJcVHn5umaODgTqPCmYYANi8h0OxIPGv7EDXiPqra07/92C2A3QOS5ufHcHP4mitn+M2l1zZijmDEmDAJzp3E2JaetsB+3wgL0xAv1aQo4d6TB6Xs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(66946007)(76116006)(66476007)(66556008)(66446008)(64756008)(5660300002)(86362001)(52536014)(71200400001)(54906003)(316002)(2906002)(6506007)(7696005)(186003)(8936002)(33656002)(26005)(110136005)(9686003)(55016002)(4326008)(478600001)(53546011)(558084003)(8676002)(781001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pMw+Edk9mSeN6RZ5dvIGYUh3lna7FR55OAl37lG/mdO8xlpJw5fvedf2Az/Vs8baz4YJ8H/OTggwj0VH72MEl9vFLBMNG/zxKlzqX9jv2FkA3c7ibFUb1aa98Yje7FNlxrq+j0O4i2oPxK3f/Ebjjmt+MGi3GBmb+IPiX4tcyKeVvhQRrW6iOXebm7VDmUnx3Y2V6TACE3uLlfXIV3mFcJXTOWcMJtezqrXAYROeWY/Osk27phfgrlT7ANikDCbOLZokbL2pMqAEOnxtfDZA2gRW+Ijtul/rpd4EwdNgB+StTj9wvsflz6Z1BHpZs8lC9M649nRHPZ/wQmLOWqxB1biZ6JT+S/EP0s3X5kLaBZul4fr2YNdPfU6/6Q+QTXDsVUeLNfHDQJW19Rg+VmdNmj8kr6LwTkvr94ebLEl+h06akx3Ma42dkiI8qADKu/YcX3AT591JVX4a9vVl010rqXdEA94GzEJKjeri7s4D9v4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c057fd8b-e370-4ecb-8d97-08d82c62393c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 04:06:05.0302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CkXbbrf/texO5+NcWyL/cmoFgXv1VnPbtrpXgYsRrlIICfvvGVKmKPBt1e64BBLotjFvukaWljTcA7pc8dQxdfi9TaF5r3zZ1b8nNGX4slU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4967
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/19/20 20:58, Wang Long wrote:=0A=
> xa_is_error(xa_mk_internal(-4095)) and xa_is_error(xa_mk_internal(-1))=0A=
> are all return true.=0A=
=0A=
's/xa_is_error()/xa_is_err()/` ?=0A=
=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
