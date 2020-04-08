Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEA51A1FDE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 13:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgDHLbK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 07:31:10 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30448 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbgDHLbK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 07:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586345469; x=1617881469;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=s8Od6HuOqJRH2e1KQYgwS0rapvcqd+JsTqpGypOgvyk=;
  b=CUjV2UXXmAUI5o2iZkzFXIjF+nPIcDQGkbyzZScJiE4GTKgYJcE03uRq
   hDMN2cfoJ5/wGDGrw4G77LiEr0ADN/lho6Max3fDcgDQxCIPBeU6y+XXi
   ObvFNoKDi12Lflz/JEhl3pSFGBcGzRtmaLSCmFMv5yLTvJX8Zh3pDDqb4
   4dI9TdNi85yr9MnH+FxRDct76pKLOuISeknbJCH7EMKaDdfVUR6Z6UNmS
   IYORN42wAQ5sxJy4zpm9l6JLWVHrni6VQuWAS92kWygwZ5eXgzWHsOWbd
   fXUypCpCYt5IY5l4c6n8hAz8G+QsVIOSQ8Ikifl8AK8oXYMUbdQkoDE+d
   A==;
IronPort-SDR: RzHuu9U6KT1mLZ+h36mPU80+O6GTXywusHX3Js2RQuOYXAre2sXth8dKqv9+fSow0Y6UeaNO9j
 fN+FodHDy1Am/cbGlf7KbIOdHw61OAxG89qBlmsW+m6U1dhwYmF0wG8I6+rZAVBxbOIy7lcUxS
 kmNS4Tt+I0EfWCdw1JK6TN7m9xSgNQZhDkxSbOYlzrEz75XRQTlJJAhL3FmY9yrrqNPoHC/TY+
 S0L5ZvpE5SQeo9TIcNB/If0/5Xqtvp+iQsQ7SqYIdT9Vmt9VT7cj0hwNeq6PuvOGcPT+wi7Zli
 A68=
X-IronPort-AV: E=Sophos;i="5.72,358,1580745600"; 
   d="scan'208";a="134862325"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2020 19:31:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgEl7v2OLPQmlDVZ/ArBgrdxrb635D0liqrlt5CstMqy6+K0fmx8xsZdYjNEUZJSucGrhvNqZYemISatSXH+/NV+C/+e1Bff5v92ciqic060LvidwHyMdprG+reRQek2iBi/FOIQU1QEYwfAel3b5JjMDkdPiPKC/eN3TvSgGZNJD6nHYfKdT1ZBU4VJiHkkVYPvJqIijAlv6YhyOiKSVRY47XcrnbHuMJ7uTmx5BhK8mF1mJBC7KDIYopJtUNY+usuT5pLqWsWOktuRGpkAStWfQ4ypuiQciWiphgQ6avVZ27zImMR8+BuMYkxsH9fObRHlmDK1DlPbQ9c6udYPYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5GLmLALAFNl4lRFYyuEB//H2ciSGl7yuedSid0WeCQ=;
 b=W8kd8BvPBsu5cDBN2psZQ4e7UlBHh6DJxSGYEiTpDkHDsGjflR+IFS/OOjuD/A93e5LB2j7e6feUfCvWQoSChu25sucxkmLCvdm77vKqJVPh1QbrOGQzQJZLN/n25C4rUuqp+xmfFrWlQkUBP+rAL+fdkM37GHBPQOyXdhpq6ezZyU5Kfn8TeQDNk+kXTOaj+LMKF+YBNKA1/2sKR8H3rXyUxbcROSOU9BXjfw9zwcJap8EuFFEA9QRw5qyJx055FPGUDsvH8Ic7+/j8B/b9yzozAsNCNHK9rHMvRwWi6ruXvXniec8upg2yV+hX5pvQusaKnHGoN5viZjuWLwMTcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5GLmLALAFNl4lRFYyuEB//H2ciSGl7yuedSid0WeCQ=;
 b=fLR6AuzsQcFAKXLoHdSaTldi5bhXIkjqbgmqPADSmEYq0475T3seGFADFR8G+SDpAk4uIgVh1wfjhF9OQDw6MTld3zitO9RpzRgsAzRuXzBjipcUsdC2txINS9Hv7is4J5IVJlRuUAIOPny5iVy/pYFCpXBAGvLHTHUsob5uIdI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3535.namprd04.prod.outlook.com
 (2603:10b6:803:4e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Wed, 8 Apr
 2020 11:31:07 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 11:31:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 02/10] block: Introduce REQ_OP_ZONE_APPEND
Thread-Topic: [PATCH v4 02/10] block: Introduce REQ_OP_ZONE_APPEND
Thread-Index: AQHWCaB3XVR5tZX3y0yqP4hTKj1cDg==
Date:   Wed, 8 Apr 2020 11:31:07 +0000
Message-ID: <SN4PR0401MB3598C36B5B5720892032E0519BC00@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
 <20200403101250.33245-3-johannes.thumshirn@wdc.com>
 <20200407164817.GA13893@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63391ed0-703a-4dd2-6330-08d7dbb0549b
x-ms-traffictypediagnostic: SN4PR0401MB3535:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3535058F255BE0AD46D2B61D9BC00@SN4PR0401MB3535.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(2906002)(186003)(81156014)(86362001)(76116006)(66556008)(5660300002)(7696005)(8676002)(316002)(66476007)(91956017)(66446008)(81166007)(53546011)(64756008)(8936002)(33656002)(6506007)(55016002)(26005)(4326008)(66946007)(4744005)(54906003)(6916009)(9686003)(478600001)(52536014)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N6J0FPdW1t/PdERnxWGF+cYPm036K1dxB7X2m2BCn3RKzUfnsYtJt9opxPjxAbUmwODKcy8NJyoNwFeXK0wvVXETfLjC2Y7X1xQ0kN0WMfDiFlZBpEEtwMNWzeqseQNCeVlOr9aTVIFMj92iGaM7PcEWCdRKO9U3+RoyqMgihxtDt57hXzF23UNbS2+8/S5g3glB1sLjyulno1he7P99I52FrGpZ1pLlUTluh+jwbQ8rkjBbdoertqOgRkMgZRBDtyaSnPnThAYp2ef1PQ4VVWmEQa6e+c4OqBBWpXgE6SsorSIaEQ79lHXpgreA3IcxWwRUYjyrjcQMbLwa99UaSnxeQ4VEWqYWe/ST3xrrKR7NuAZqYF7re8httJcYy/1IBscndVym0rOVZDlGLbWWD+ea8mb9Oc1+9tZNeHkquVb4doI5pYnsqNazOIPFX2bt
x-ms-exchange-antispam-messagedata: PfWMAPhN0QrsLc2FeNkGEhRjWtUjJj/qCU5RGm8IcFNUBuThG0p1kT+wsdEDT/6MaOdN31KK7eeXFKH+lmhWLfkShcG7ZzEh/Qk8epMUdC+DcRIQWz5wyzqcnxG7Vdjs4BCHsW+J9gXmxv681ROfaQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63391ed0-703a-4dd2-6330-08d7dbb0549b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 11:31:07.5081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1QTWxXczqg86WQHm4KiQ4EB5+TOHWk35KDa2uxz9g79exTBPZG1iX4LdNUeTpBPi7tAY0LpIbgXuRtcZ4R4zeJEGGGml/iRai0gCQxRgYV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3535
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/04/2020 18:48, Christoph Hellwig wrote:=0A=
>> @@ -927,6 +970,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio,=
 struct iov_iter *iter)=0A=
>>   	ssize_t size, left;=0A=
>>   	unsigned len, i;=0A=
>>   	size_t offset;=0A=
>> +	unsigned op =3D bio_op(bio);=0A=
>>   =0A=
>>   	/*=0A=
>>   	 * Move page array up in the allocated memory for the bio vecs as far=
 as=0A=
>> @@ -944,13 +988,20 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter)=0A=
>>   		struct page *page =3D pages[i];=0A=
>>   =0A=
>>   		len =3D min_t(size_t, PAGE_SIZE - offset, left);=0A=
>> +		if (op =3D=3D REQ_OP_ZONE_APPEND) {=0A=
>> +			int ret;=0A=
>>   =0A=
>> +			ret =3D bio_add_append_page(bio, page, len, offset);=0A=
>> +			if (ret !=3D len)=0A=
>> +				return -EINVAL;=0A=
> =0A=
> I think zone append needs the same try to merge logic to deal with=0A=
> page refcounts doesn't it?=0A=
> =0A=
=0A=
Sure, no big deal=0A=
