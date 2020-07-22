Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1DC229868
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 14:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbgGVMn3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 08:43:29 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:22690 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgGVMn3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595421807; x=1626957807;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=58CiqSEcFvFC5DLoblDD3vb4XsC6970YnRDn802sn8g=;
  b=EhkAr+p+eTxfUxj0J3QyWajVjWJvht9D0+P8leXewS944zv/zXEZiB5n
   nze+LGL9jsDrVrqKWzisgr7lj6f0eYUuQNoXwy2b7U0fFm1T7+5an7QFp
   mrIG4M0/L28RVvUsohNuPCTVUePBDSkKOUpZylxZMjRYzTPa1RLn4oRvJ
   Qo7S6D0hLwznLL/uFECcazeoV8RQ74OIOj5pBF1RaPCroJvkYckc6GzDQ
   eR5rcIhYIN4xic582UiXCuDxHvjBK++FhCyW+OM5zhqGJNwHBoiFNbzx/
   AhlqD1UnC1DMauWSEpAPb7pGzV1+74FmCzTX0JdvBpaKvYayGwRUMAcEO
   Q==;
IronPort-SDR: xLjB5DJN4LEFiQXBdRryWVjcxFu6XAECYaG8l48hUdGxVkfoToC+dlmNFu5IZCA5YEwuazP8dP
 qv8UxqJqAhK5/8/8i0fKpFx6bBjGlrRhB44uL71u3F3n5x0cCNas0XPKQ4ZJm2HKyqZsPqHZ+J
 JG+CyQdbtXe4NZbrmeMtdL3w6wUr7ExeLvBRMZMQwU44LUFmI+xOmmIa4gV2kjvVMqfpvadJmx
 r4hGi+fdghlsb323skyEVQVr7c4Up+gdA5yi2HcRCDOGbYQlf4ZteWnncU5HglrTjGwuLM9J4N
 4Lg=
X-IronPort-AV: E=Sophos;i="5.75,381,1589212800"; 
   d="scan'208";a="143109550"
Received: from mail-cys01nam02lp2054.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.54])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2020 20:43:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTpxGmmKZprCfumrHYs/gsm1djQt1ofzAMEQro2tUe+1yXHYNokkRPCqIKfEK+5LnRx+JTzV77MfgXVtJCE1sFJID/Vts8biE56mdVhz0B7DjubXWlTm5x9ajpV41sfFKZm/OwV070/JEq4dzG6dgnU/JgEXDTkTcEj/9pPeTU0YQ6M1M1m9zZVo3SBm4vVVwuFkl5Ok2DjiKEavO3Uqqd0dr+io45SvGVuQqKDdDxmTm20c0eGqWezz0Izs2ay/nH3fUEq95UJvU9YKa8R6ZICC2rGK0JcHaO7UDQoIk72DLoSEO/scVAicikQ9baQVN9raxyOyIDMOamWb4EMVKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wuWavdtDxFw6WSx9weOkg9V+eKPvlyZAt3gk608fe8=;
 b=Eg63ZTALk1L6g8vsfDyfes5B7TJ6RNluUPbH18iHW2QEUqLWIVlRBr4H+a/98PWKFEKs1jJ/bnXm+GMY44xGLnx0MJ4Vph3FY/k9XExzI8raKFhRKKR50cZAdaHQ8KZvxCzyRW0J9GQMiPOWQvgmEyM/uiMPD+Djds9OX7r37rzSkVQI6sUXeu2Chf4C7+sWwmDL7yw6nfBHU8kICVc2kU+Em9SwdvivUWlpI2Iw1fNND8PhRf04bSgETmYG9ZsDnvDTdQfKursV0+rCxVvCXNGI1I7fi0e6WJSHU52MN0LAedoqDclrlDpwK7F1ZFsQJRQZewrCrvW/dJKlQKhMKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wuWavdtDxFw6WSx9weOkg9V+eKPvlyZAt3gk608fe8=;
 b=i6/lGU1F+7jb1nHUDtkIG4QtHKQ/i6BTZguRD5RxwAk12rCrPjaq4ryyli1pnunm0CZ/tEYNmkU0N94rAXAJ/TxgBr2EzpDg+Ea8d1AmQuiJ/TkcH2f65FAeVuxeoAA0C8rOi/3HqEXPH3MHTkWBFNNo1EseZ8tCyNKWcN0mC6I=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2141.namprd04.prod.outlook.com
 (2603:10b6:804:10::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Wed, 22 Jul
 2020 12:43:21 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 12:43:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] zonefs: use zone-append for AIO as well
Thread-Topic: [PATCH 2/2] zonefs: use zone-append for AIO as well
Thread-Index: AQHWXpitifll0c+NqUqXemZ9Ae0oAA==
Date:   Wed, 22 Jul 2020 12:43:21 +0000
Message-ID: <SN4PR0401MB3598536959BFAE08AA8DA8AD9B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200720132118.10934-1-johannes.thumshirn@wdc.com>
 <20200720132118.10934-3-johannes.thumshirn@wdc.com>
 <20200720134549.GB3342@lst.de>
 <SN4PR0401MB3598A542AA5BC8218C2A78D19B7B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200721055410.GA18032@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4a5e17d2-fa10-4147-8c9c-08d82e3cd15a
x-ms-traffictypediagnostic: SN2PR04MB2141:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN2PR04MB2141F096AE64E724A5C847BE9B790@SN2PR04MB2141.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vahb/tiV2mGyMMsSeqUGrXo8bIE3yEWoNH8qCk229TgMhkjH4k2tZLtf74wKVjExji3pzMK2/V7mRmyX1O+9whWNY1xjPl6cxPNDUeXsf9uPkYtoIAaEDkOBKRhqwVWixduc/nurDEVzjtDsGTwOMq31UcBRkJbbRIffVY+yAfG2trTqYqi96Tg89tAHvl9uDGeJGWISUKsuZxDyaO3vRmhIQOIhRR5SThRvZQWun35IIAn7dxmo/6QPnLIaJRvHHOHXXzvaHNOS9GTlT3edF1s4jimbmlQu2ykvuwHvlOLDceTRMuB+eiRKDbF+yorRLZo3mu7dF4AUzoZC0/UxHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(76116006)(91956017)(7696005)(66476007)(66946007)(64756008)(66446008)(54906003)(66556008)(71200400001)(186003)(6916009)(86362001)(5660300002)(55016002)(478600001)(4326008)(53546011)(6506007)(2906002)(8676002)(52536014)(26005)(316002)(8936002)(33656002)(9686003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: gPnsyMcV919hZvk5uWZTXliQq9VSEfUFNxePHqSrUq0F93GiOPqgGrdHVChhTv4zUR1fEGkg6hAlqfaLXEgJEIJtIGuGO0kuPWyvg7jxm7/xPC9WygZ3r95Pa1vf3OfEk9bZsnLVDH0Ui06zjpNkjjkNqOjm8hR0NLCHVXLt2px+qXSIN4JLwy0Rek84/+I/swPI/u1NinSeMJZOjaQcFBQMRG1JTr5eqW1O4ODzchLCSTCSXBAXdWxRFbG039O0izMeRb6mJoiJ2cA+iJZ0XKAMv3xrqeg18AxJoePzU1Sc/srN+QvMChlROXxBYUPMzE4+MJr1HZfuIXnz/jCeiASOi7AEfEZe4EH6WzyN63V/xejrqlkkUkShSLzCKReUA014/lqs2PhJKBMo3qpysQ8u182a0qjTdZ68Z8j/VJNlpFWzQ9jGOlqWZxOH5gf6wD5l/IyZwgSOImyU4P12atVXVdUg6Ezo+kEqZRcm+1lRTG41fXBU+LhqO5DSVdKc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5e17d2-fa10-4147-8c9c-08d82e3cd15a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 12:43:21.6454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W8+Nf3ITxO96ECDzI2pcUMkM2FWmgjoeoufZEI+F2eTsTKPiqZz3cpL4zB0sMJobu4TzgDwfO6sFuZal7VktnHrd4V+C2plSK1zokkW43jI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2141
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/07/2020 07:54, Christoph Hellwig wrote:=0A=
> On Mon, Jul 20, 2020 at 04:48:50PM +0000, Johannes Thumshirn wrote:=0A=
>> On 20/07/2020 15:45, Christoph Hellwig wrote:=0A=
>>> On Mon, Jul 20, 2020 at 10:21:18PM +0900, Johannes Thumshirn wrote:=0A=
>>>> On a successful completion, the position the data is written to is=0A=
>>>> returned via AIO's res2 field to the calling application.=0A=
>>>=0A=
>>> That is a major, and except for this changelog, undocumented ABI=0A=
>>> change.  We had the whole discussion about reporting append results=0A=
>>> in a few threads and the issues with that in io_uring.  So let's=0A=
>>> have that discussion there and don't mix it up with how zonefs=0A=
>>> writes data.  Without that a lot of the boilerplate code should=0A=
>>> also go away.=0A=
>>>=0A=
>>=0A=
>> OK maybe I didn't remember correctly, but wasn't this all around =0A=
>> io_uring and how we'd report the location back for raw block device=0A=
>> access?=0A=
> =0A=
> Report the write offset.  The author seems to be hell bent on making=0A=
> it block device specific, but that is a horrible idea as it is just=0A=
> as useful for normal file systems (or zonefs).=0A=
=0A=
After having looked into io_uring I don't this there is anything that=0A=
prevents io_uring from picking up the write offset from ki_complete's=0A=
res2 argument. As of now io_uring ignores the filed but that can be =0A=
changed.=0A=
=0A=
The reporting of the write offset to user-space still needs to be =0A=
decided on from an io_uring PoV.=0A=
=0A=
So the only thing that needs to be done from a zonefs perspective is =0A=
documenting the use of res2 and CC linux-aio and linux-abi (including=0A=
an update of the io_getevents man page).=0A=
=0A=
Or am I completely off track now?=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
