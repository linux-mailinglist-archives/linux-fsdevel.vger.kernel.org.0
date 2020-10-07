Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D85285F2C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 14:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgJGM2L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 08:28:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:42197 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgJGM2K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602073690; x=1633609690;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=AopDRhhA8uSlReSUK2COXthy2omYjpqJKHszrKlMduM=;
  b=h0qJn3xxYEESJIHvzfOtutCaTD1HlOmE+60UK4BMcknMvmQn/rJNVaaV
   B97/r9HF6f9A+4x2jLopWAyCmMc32ufVNAqWuCVoS0ud/rAY2g7YNZ6i1
   NEDL3jQx4BU2BUqaDC+t5YJE23Eru1wARAQqWe7xoJXK0wejoifMPkLU+
   SAZ4XhHWex2hg8EDeZion5qXyTnk3XtfWGJoNkF0DpmPlLNuFW9F9B0yx
   nkbDSlXR9i/ZmVhgzX8DvcyHBcr1PI462eLWQU93aG+XXeiF9BGVtpicK
   iMW6rF1mx52MGE0W0w6lP8C6sB56rC/+tHM0vn7HjnG0CSRHF6ewK9OkN
   g==;
IronPort-SDR: iL/Qn2fDEjzkFi5lz1PR4MgjGng4i3+3d11oYcNxwinKpWL3OKeBIZV8gFJq/OE+X9octSlVyZ
 ZrbRgmM8xcJ9uwLVbRtb+c3g1gCibTHcwTqQCAOwhbh3LIeR6gbYi1dOnf1kwo2P+rjSjKb+8Q
 qdL34x5yrYmlepdAw9n7CKxDY39Mmzeld6/Vmf1LlAG2FHacS+/0OZ8DMyWOHH3O9+LJXRMC5F
 5nbqYKvqUW6xaPTxi35gWgFu6vQFGHTB257QOat7E4jbcLe15MIYz4KGHY+4vmj03BJR/wTKdw
 8Ck=
X-IronPort-AV: E=Sophos;i="5.77,346,1596470400"; 
   d="scan'208";a="149170895"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 20:28:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4DHIEJy6zPUcdwQMJ4dSHvbwtVvPSKDg+xF1zGaauiGY39+IhEEQHJuF4rdVXdpIT5zGpPSRyeg3RXuEQSSQla2I1sBcTJWz+SV6UCVn4XBJEt/CgtkjVwhEzCkORJTc6XbyizBMoBd5OARnoL6AV8COKLNUN5sp0HuHk3o2Qjcc9cZ9a9lEimkEoaMWAYNiBOwHtsTv5+M5/l2X5s2SeVqZ/opc+36VpVfG31AHa44ybVeHl+MlviS8QTvgjdaV66OJJ6iKGDXZ1LTzcwNxykel1jw1Jzm9wdlAhFMzoTPltKCh6IsXQZm0wH/EOUS1F/hEFy2N0PHiS0mQbdaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AopDRhhA8uSlReSUK2COXthy2omYjpqJKHszrKlMduM=;
 b=hghPJsYB7sn2rFEY5E0igqetZdKqOlLyPygatQ9PDHC8Tnrb6j9KMzCv7atFhsy9UZNU9XLTgxqBzAuu2LCLbizUJnmeARtf2asovKxTlLmSz/ACo1xv2k+IJ7vyPS19IL5hyfDpZfK8vSmCxwDR782gAthRPCKMk6CGGhN6w5eKEv51KU59tC+mxq7qZaZj1kSdt3YrbuQmrsjNqlJb0iKeTLnKOuwTWuUSOBjnory0BhYEzvHzPoHoYN/V6gp/LqNs0rur0JPZnGduaWoW7X0d+2aihQAMz9kiGZjCFlCTxQiAA3V65Ge+GTINW7ctvIXA/g5mK3/xINEtZx/DBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AopDRhhA8uSlReSUK2COXthy2omYjpqJKHszrKlMduM=;
 b=or28vS0Y3sf/nny7fA0Su8c0/WQQXl1idb6p+yLAK7jW8X3o6i4AymihS8lecaKi0qE4E+Vrl9LmL10+lM2Xk0XhoeiyD4A0ZL+K5QUfuCt9+grmg68pMMl52DiKLJj3RSirX3OnFGDTKJDWkmhFAcQNcPH/UNzJC7RUzom6s7M=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4045.namprd04.prod.outlook.com
 (2603:10b6:805:47::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Wed, 7 Oct
 2020 12:28:06 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 12:28:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: soft limit zone-append sectors as well
Thread-Topic: [PATCH] block: soft limit zone-append sectors as well
Thread-Index: AQHWnIsT4YZR0LScLUiFnh8wH9QslA==
Date:   Wed, 7 Oct 2020 12:28:06 +0000
Message-ID: <SN4PR0401MB3598A39679E6989E82A305D49B0A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <2358a1f93c2c2f9f7564eb77334a7ea679453deb.1602062387.git.johannes.thumshirn@wdc.com>
 <yq1y2ki4431.fsf@ca-mkp.ca.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:1cac:4ece:b859:f686]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 64dddc38-08c9-4380-d318-08d86abc719c
x-ms-traffictypediagnostic: SN6PR04MB4045:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB40455B089461B7FD95D739AE9B0A0@SN6PR04MB4045.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:214;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: APaD5WpPduUpa1M8Vo8auu6k66Hba5t9OqJcFY1IqkQVxmgob+ayWLVktY2nBWVWRlhKI67Td+CLg2X2XkV68yWBNeW0cKL2WxNyVWwR0nWfA3S2bMnkFaGl7jXENjMyRXnIMTmn+48KZxQXvLSckf2D4UsT76desMCURIBn1q7WBuT84c7c7A7FUKcfjVYk/ClUsa7HWYKhg0ONu1TnSwveS4vCItA5nNZadxl2Chd+OHFP1l6O9N0qKSLelobabSZHSrdgrBJ5A5BbD97AzKOVEPV7FXU8pMai+U+F1KgvEUNMuC/4c3QX6ii5DETpXu81R1Ze3rWsu2cLyi4d6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(86362001)(7696005)(558084003)(8936002)(33656002)(186003)(55016002)(2906002)(6506007)(53546011)(316002)(478600001)(71200400001)(8676002)(54906003)(64756008)(4326008)(66446008)(6916009)(66556008)(76116006)(66946007)(9686003)(91956017)(52536014)(66476007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: T3vGOd1AEaekStzT4TMlTB2/rUSLQwSW4bGYgrmqOxFg4mjCQ9aQ8d9vVsSEpmXE2adO9A2annV3AlrAOwkuz76Z6ioQvOph76mIItoOG5CTrtncdCbPhSMYmUSE1SeLIJJVB9Lwf+4KoAZtT2+qooW5jQpdQfr4gLv73tgef3mhdSY/6i4/ru3qQZMlnWW2/8iOmfw2h4sJxQiUBcOf5NbX+/s/rR3zl2tqEnK7ZxDpx3tFLLFEA321H0kQHRuonRMNtc+bDoM+xh2T9Q38GdjbJNlJ1y0x2iy/V1uimi7yiWQ/XXCMCijOaM3WV7AOEQghwCweguEyx7RVyIe9k42/WdScmfK40EjD1GCuYkOBTTDQV+rKTc06qV8qE2YfuDmsbwjpsoy1OgmCR5K2zvQZFelg08GdV4TrCIB5OGM3twQO3RJ67TcWui3Ztuhlq8XU7f/bM1iJnTl8dU5ZeBGA25TYAsDbJ0sbV/P9s9avUUlYEKdmQF3FpBxPiSyiCrez1dOJCbQe73nDMeEX3ULu2+PyG2OpwKdD8zlTt8anjPZ89FK4LzW6Tx+iwNe9ludT+9tp122bmpcGxmcvrAUXmLZdRILQ0giDTJvbEiiF5aj2AxY+2zvOxFm8yWZNaVYbrHCHYDU58YFIvqoYV7wn3+10SUzl4PpnxEhJmn1OIzcO53v/xDH9Gr/aghr+s5g8X5v6ttk5ACxEEJK46w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dddc38-08c9-4380-d318-08d86abc719c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 12:28:06.3994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TUA1psH2b7LFnl/Hx+WNUdFRdXyMqH20DEyNwgNQZwzQc9+5zERp/jyOUG5taCl1iNe+z0gvX+J7xA8urEAXzJ1AMRFbrrOlrPvd4ibrSLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4045
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/10/2020 14:25, Martin K. Petersen wrote:=0A=
> Yep, that's good. Nice and simple.=0A=
=0A=
Yeah no, forgot to git commit --amend, sorry :(=0A=
