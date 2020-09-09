Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8C926340F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 19:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbgIIRNz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 13:13:55 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:60918 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730268AbgIIPcL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599665532; x=1631201532;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RcgDpdCNO+jl49YrJZpHJ315bPtlc2XVSG4Vk5q3rBg=;
  b=LNVM/uJ0gT87NRuM2VA/TJMm5uXkJmyLcDuBdhBoV6TpgSjzEF7C2EbK
   XOBOc+A3aRqBmiIbDxT5eiwN3P3kU9zIvl5XeGgrrURRLy4/UrH7rczt4
   Z7izKbM0KhNyVkM0HTkhwUCEvoEfxtIceAcpWQiFJkKW4MYEA6zl2HpQP
   p6Jsnn2ncTOAFPadYaQ9elRw9ySZ3T3sIvcu4w0PorQFAFjq8uG3ap0J+
   hruuegPvXnM9bCHACMr4rcd9mS5jD5g3UhrH97zfRmByOgoxBuV0vz2FX
   wy4RH85aXfKOazhCxgm3DbhoH4uP8eKAyH/1n6SQjJiM0dexM7v58TFnt
   g==;
IronPort-SDR: LOR8yMVKQ7t5Y/6VvoIT9RCN2DILyKeJQ7mEE1NDY6yj6IMEWzGP4o1GYgn3eLRIbm+qDnXMQL
 bWEGP/8MNUWKzf+rWQivCrXg1H9KlIuLH2oL5PdzR36CYfmcNneACZss3RVkgjtNuGmHZBm2Z6
 N/s3Yvc+bqgvmyUEElk0b3G5PGfLbNlzX6OgwALIUJskFS9u5WQCVMxk4nshoawz3AtYCIw6KJ
 IZ1I5NVkhEn0E0imlXXzkC0NwPcRCPx7vgnXSN9Ul6amCUw3XW/LyZPQjw6lXCzaQeCy/29kUS
 yew=
X-IronPort-AV: E=Sophos;i="5.76,409,1592841600"; 
   d="scan'208";a="146930504"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2020 22:43:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1Z9G8i7pFnb5qb+KNwrhMnJMo4T3CDo27VA6AVh8ZBWl+zLE0egdw2HPZnt8ul3TaM7lSLJT5UyZYqjnnGHFQoz2FuZewMVGkHT2nS7287I+58M0khRQS2ZP1i+T+T3sS869vBIFNLw27BgQ8TIEzOIre74xkVEXPIxSxvN6U5m3WJffA8fq50jUxFkyc7qPoeuLS8s4Vqo0w/CdrHJlt24Rf58BWlisdzZSwjX/a56nOC+HHKGssrA6yadFmd/98TKVQcQPbRm4WxfOq2oFMID0s/0Q7JcovIDhrU2Oj5Nmn0zxLhgvOducEhKXbvOl6Nam/5ZhTxsT4COcrCpyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcgDpdCNO+jl49YrJZpHJ315bPtlc2XVSG4Vk5q3rBg=;
 b=PMmS/QvnWfzX6gbmr08ILBHsehvrjLfktoQJUDo2W0SuN6jix9+V/Uxwfoe7n+t3GdzlwHIvMvy1qJ1B67jt5HQ1JUWxh6gEVjJIDmU5JjOXHCq3PB5257ZfFvrYnsaCr81MP6LYUxytG2qIoUFK34BxWuAbOpzHK3rWsUgQzBEqCLeNQOJEuuG0N/IGxtGbAZbKo6aD0G7cwX+RbXUCvrXSob/wgoSqi38eTiEJ8XMEHydJ4L0ggTRkJruWyJ1aQaivXe7DxZXpBeAppkUZ3ZJWezJ/NAnBi0lhom9ZNamu/J0ZqWdIb8LcirOUbu7uIH/JSjw1AIpLAEt8MUB8oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcgDpdCNO+jl49YrJZpHJ315bPtlc2XVSG4Vk5q3rBg=;
 b=Oa/EdHS47i56r9vlPJ5qNlgBxkApt0YT0nG9wqWJi4MEAUCyC+fuSqB9CoXrMNK+WDPxO0MiQ5c+OvYgEbaCFAfts+Ml9Dkmr9xDVVHW1P5MNMpMrSpSMLrrQnUPmPq2eqP5dhW/cBLhUkoRj+QYxcaenF16qkR1z1xdjTleWaU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4239.namprd04.prod.outlook.com
 (2603:10b6:805:36::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 14:43:02 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 14:43:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] zonefs: introduce -o explicit-open mount option
Thread-Topic: [PATCH v2 0/3] zonefs: introduce -o explicit-open mount option
Thread-Index: AQHWhpOx/juxiq8DBUuupDxjZd1dvQ==
Date:   Wed, 9 Sep 2020 14:43:02 +0000
Message-ID: <SN4PR0401MB3598C5530AD6A8F41572D5FC9B260@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200909102614.40585-1-johannes.thumshirn@wdc.com>
 <CY4PR04MB3751FDE476A7EB5A59C8352DE7260@CY4PR04MB3751.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:142d:5701:2cf6:d0e8:5d46:4118]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a85e8479-31f5-4bc3-409b-08d854cea783
x-ms-traffictypediagnostic: SN6PR04MB4239:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB42398DB00061582125B3961E9B260@SN6PR04MB4239.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IkjRHeStbq7TZIE2uVtEg9rCnKWFdwkEbTVRbqhXtP2YmnCTSB4BkElqRsYqPf5JCqJGWtEFSSOZ2zdDKKhGIF4MoBkyYPJWknKzXJwThbgenVpANnV3eLJHzsrZvbt5krClJJ+j+MvzWiPz5dMqCJsnatYLxbzQB8t0/xDP/3HtJeUNrJV3BuBxYtqddHZTPvgUBvQ5FvN4MruAX9NkJS+lqRjmes2PFAo29pA9gVIHJNMl5JLSLEH8iIdEcDH5jKlvPD0AZA6UwRO5p6C+uxy1aDFA4FKYA0iBTUle67SFWdYUzinKA5W8jXyKPTxWf6cJhnkhV1ErpgWxOwkVXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(33656002)(8936002)(55016002)(478600001)(316002)(8676002)(83380400001)(5660300002)(4326008)(186003)(7696005)(9686003)(6862004)(6636002)(76116006)(6506007)(66476007)(64756008)(91956017)(71200400001)(52536014)(66946007)(2906002)(4744005)(53546011)(86362001)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 1w+Z7g//xbySe8c7FDOpaAqRGXf1u1HFtNtw007j95nvoYKVUSMJLw9xPDWh/OSRn/4S+VwrYe1KvvA8LEDG3waN12RJh6FNYXJOi4Xr9kvI2CrLHAupC/x+Ku5TsPwwLkledpLzstvFM2KCMuU6jzZEGFJt/UEgpuuCY903CH48TJ3sa36DKkudlnHQCC4Tp5wv/5nZPwfJxRAS+S/pbvgMNfhOmq+TQK1u20ko39HBmjM4P8hfgJgWj+C08BbV8G0bU7rYrs+tQU5fp8aOrbOe9tO92lrg0lrssYVYsRDq//yUvPNjakfI24ImtAkosU93woxQ0S34ztIgL+1iZx/vn/4pmTbUiAcRwOCczY9X2kw0ZRU4RBA6VPUjtC0WEYkmfofv8HU5nZ/jVyC00lt/jWnhm6LykLkeKz91Inf/xUwUw4P3hWlwHbgg49DfoMcn0G8naEBNT8Sei2lUVU03NKnKnmsk2XaEWdoqdryfYclGjPFWWJWXA2RZXDSmt1wupMHFmswFgknACC0I5u6qLm8w+h0b5MKBZEJWYOK7WEisIgHEM8J3ibbnHmw9Od9QVocBrmUfQr7nFUd5ep7lxkaKJ29RhA1dW3zkyGLc1y2tU8QBLc4/fWWxbfIGHNp/jDrkus94JODLQrvLEoZ3xD1fQxAKs1eeP92HESVNs0/FlVDdz/A87NORsRyMYFHtf8G8S7n1MjZGZDplGw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85e8479-31f5-4bc3-409b-08d854cea783
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 14:43:02.2428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VBJwcxmP9d6xcRLUq37XwV+MA+Y3zA3uTln05tz0QIHFvrccrV0/OKRp1B2/OZBwpueUS0uh75HZZxHzhzR8mY/wt1vx3QUsIAcgK0x/Tiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4239
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09/09/2020 14:52, Damien Le Moal wrote:=0A=
> On 2020/09/09 19:26, Johannes Thumshirn wrote:=0A=
>> Introduce a mount option for explicitly opening a device's zones when op=
ening=0A=
>> the seq zone file for writing. This way we prevent resource exhaustion o=
n=0A=
>> devices that export a maximum open zones limit. =0A=
> =0A=
> Missing the changelog :)=0A=
=0A=
There's a changelog in each patch :)=0A=
