Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8DD294CA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 14:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440362AbgJUMdx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 08:33:53 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:25619 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411680AbgJUMdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603283632; x=1634819632;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=YyoWyxTxEs/A9ge8ezyiqXZUAF5600tbR/Tlm6JbEtw=;
  b=M30hxXdLebozwyQ++fcFud3JLiA5w9JQ9z6urr/q6Wk037ew88mhYqOs
   5bffA7oCc08LCYLVz2UHPYHvHMv+nVRAuvWszrGiQFE4HSJkvZo/zwE4E
   yICsA0bhD5WMjSGMwObRyfDNlbgAgHswqdD2QQFE7RD/Q+0VWBWtg0Mk8
   hH26KIxb8A8FpnGKKEcPwoVtxakYH57wmGaynhYkGNDlVTK2NuqNQ91o8
   Bm0Va09REf92SUbCJFky1jMXtWr1Bm9vDzxI01mgVuAvV49JQPk4OWEmo
   tT+aMvcRmfoKnAXbOwlntoM+0XfZz6JYD3Tr3N+lDzDS5KuuADT23PbCr
   Q==;
IronPort-SDR: XgCYsfGGFO+sSB5WNMabJ6RMB7M+PfFZx6EsQ64pcJSUJSw1ZY5ake6oUljpyj2E6LlsIr+MA7
 tmjWAU4GT1xy8W1GZbR534n5pamXz94xS4JJVNxiu/uK2rn5spr0s9z9FWOK6kfGRMNXiv0+ou
 P34WxeZcCHEBYD2A8DwNTLBp4xk9P+XGQr2r7oeoDkLbVWkj6BChTU2n7zBxf8FdbjDZSTDuzV
 7WBGuTDivsoAufO0lgwR9II5qSvrx580AUlSFlyL/En/rr877mVVujAw6MlmVL4YAgiCp+ByEH
 +fw=
X-IronPort-AV: E=Sophos;i="5.77,401,1596470400"; 
   d="scan'208";a="260405465"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2020 20:33:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLkbXsqf9ZeeJHNNICDI/FaYWb6C70IbjnOWsMYnX+rune86EX6pmcPBzUeVIqyy5xthiuzWNIVm1oZzcxTexg+cJtLNF30Ir6l03n/JCDJAMXrRssJwAi2jrhdRN0Y3s9+5mgpVQ3ZH7OD9ZQu/9j5QjKb384OQLlIbDdjdodBgCVzegjSMitjNMBbAo4QsSwQ5Kadj5iq899nwz/hrpyfxapW8PRzT87U1CX/vc0iLcNoKIr6T1tu87EP1zQTQG60oxl0O1Uae3wb2MFVC/I4feyp9JSdYO7sYs8BQVb1xuMpAgT8ro85sZaW0AkKkQJmcN/cScHPoQ4d97aJbRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dpB+qlh5q04PzTHuhXLVlL1xae6NwnlI+NzNj2krsQ=;
 b=kA9v7qCvSZ/9TszNBLgk9zyd1Z5uZFLj1oUG5ibMJkXkj6DZu2A8PoPj4vZjFH4JC7I1DRBE2nWwsktNIwXI9OduVtKX2O/56A5va5WpojSD2lfTOAoCXcs248Ws/QJFljws8vfnjfeiq2KrSKDpdmoG3YIuSu+2AUhVixCEZssXz6B9ViZ2K5n0/4H0PP2Xl9by4ZOJ1EcRemBlg9mylNbCNBmUkHRpZevOPpi7kmjvRSrNekDkj613ObMrnS09ehvLuRyqsumi3PGgkhz1EhywB2BqGNtN2W3pCdTC2kKcVa3ewqRwtQlTNDq/bfCNqw7guqQtBy41XE1z3/wQ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dpB+qlh5q04PzTHuhXLVlL1xae6NwnlI+NzNj2krsQ=;
 b=lFEtI53QeB0emOHPLME+/cOvCtUtdUIAD13BRUxxgOuF2hpjKohtjYbORPxn5VSoFQB+/kyjidhyeIXoxI5Rd6SQCqEuieOQfshln/OTC3+vCs3CcVrTJ4NAOwjMFcswRR3LEHtxv3GUliUVd8ap+bTIpTp4BErIqWzjc93lQVA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA0PR04MB7289.namprd04.prod.outlook.com
 (2603:10b6:806:db::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 21 Oct
 2020 12:33:49 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 12:33:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: UBSAN: shift-out-of-bounds in get_init_ra_size()
Thread-Topic: UBSAN: shift-out-of-bounds in get_init_ra_size()
Thread-Index: AQHWp5jo+FBwU+0LhU2DuGQVCdRitA==
Date:   Wed, 21 Oct 2020 12:33:49 +0000
Message-ID: <SN4PR0401MB3598DD920ABF1AE876BF50609B1C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <SN4PR0401MB3598C9C5B4D7ED74E79F28A09B1C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201021112347.GI20115@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc28e5e8-5d90-4f7f-6e95-08d875bd8ff0
x-ms-traffictypediagnostic: SA0PR04MB7289:
x-microsoft-antispam-prvs: <SA0PR04MB728997ADFCC57E34973A0D6D9B1C0@SA0PR04MB7289.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lzUQACMrHxzquH5lOhHkyt5shi5J7TntprK5Mn4iPOpFfteBXiYXRTprbQskS4PC9fUEPuzrZXaK6M6iqD6NRRV5p5HMjmAz8HkZGnbVKwibX/QbXonQObmwTyRVvjGaM3BQ2NhWTqXrMKLf/L/3Wyk7PQK/NM+i9GhlxOxZBEnhdN2JkZisDnGZ1kyLa8vMpR7CbTXsAwBB+TFfC6NtoOM67Zzm+cXcurMmW9H9383h6FivvxTsHmM+TgZlvjl0bRfVrtacX18wdXpQGXcydQ74mqAhW5sTLImsx/R6mQZ+ceBZFRvQPUrpHQ6WopmEj/7Fp4IoFiU/LDPtqiPfWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(55016002)(8676002)(6916009)(7696005)(9686003)(66476007)(66556008)(64756008)(66446008)(2906002)(91956017)(4326008)(8936002)(76116006)(86362001)(66946007)(186003)(71200400001)(26005)(6506007)(53546011)(54906003)(52536014)(478600001)(5660300002)(33656002)(316002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lGjwvrKLtAOqE8wJ72xktQEJ4MI/WPJpyJUjtJ4rvu1Wl60FRE1cHk0bVaQPU+2nQgmPwGUVCSQWsc5fYzM/QWmy0AyZnFa+MYlSlPs1I1dQsqSJWSqsiXS3bOm7vOLYTtiOfOks02JzUZwX1tRJ2B953rZVuX8yDbHirCYNZaPklgKnVAAupn3ZwqWcrT4B0Ib78RFNEXoQZAMNtp8jg4YvYrcwnmirC786is09AqUXYRiwFOeh1kgEOdtWnbsVotRQYGY/9NBgiSSCbGcdKtNATPCylGZfSl/y514ORaJJ1WPcrxOEEHmreg/qxQMGHzS9VfXzrGNhGWfQDP5a/Mb+lthnDB3E1U2N+/5n0S+ZSySNi9B+xhdnoHMQgCUXFq1W5JhQDhDlEs69ciBxJ5gQus4pu4/IutUFBGgWeC1r/Zo7ETAARq093tM1ci54mn5urGdXo6IOJsZgfVd1HE8kHBHwuKUZu3bn4WOK3ixbRaF+S8QcHYXq487Ms+xTyx69y7A1ElZqDGi8fhZub052DILc558vTScloBDVI0vQzolDgqm3eipE4kFUMWkbcsKh34UCvNAjjmEzDtHbc+wcFTQEVKyQ8pR392sPNkSoXqtXbW9svc7jyNmAgkq5fZrolHT8no65bMlZ3vEjdQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc28e5e8-5d90-4f7f-6e95-08d875bd8ff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 12:33:49.6183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ia9fyPGvB/brEUhRUBkn0+3D6okxCZDIjMstl1XKreFlGKyOxfTLOkf34GlpJehpvWCmkUDJayY5pFcU7UdVoHdBiLkOCncQehWnGPQ0fFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7289
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/10/2020 13:23, Matthew Wilcox wrote:=0A=
> -	unsigned long newsize =3D roundup_pow_of_two(size);=0A=
> +	unsigned long newsize =3D size ? roundup_pow_of_two(size) : size;=0A=
> =0A=
> would fix the ubsan splat.  Or maybe you should stop passing 0 to=0A=
> get_init_ra_size()?  ;-)=0A=
=0A=
You're right. Let's do both ;-). Fix btrfs to stop passing in 0 and=0A=
get_init_ra_size() to not call roundup_pow_of_two() with 0.=0A=
=0A=
