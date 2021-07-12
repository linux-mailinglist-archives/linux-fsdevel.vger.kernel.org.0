Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572DE3C63A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 21:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbhGLT0P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 15:26:15 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:36200 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236218AbhGLT0O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:26:14 -0400
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16CJIFfS018324;
        Mon, 12 Jul 2021 19:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=zPGE9fiBWWjEEJV67TuDiahqh4wHMUNx5TwWlqz3vjA=;
 b=ofeGD6FvPp/P/4Ua/is2qFME5NkAa0iNk2KNQqNflOP+9pWwmc9qLEo6NV5fNmATKGxz
 kcdkmJLVUebuP6f07IIgVtsIVEzIkM3mt3FtaxyvZJCkDT0PsiaC8wbe9vP70hGX002b
 bNQIgXryBQTzecRDb3ticrK5ejkw+kuaFimVAPBlkhiGGXsJW3l6mJzH2MM7LiMi/Hna
 G/K7jJXJpBxwKZIlXofm8P35/7CS78gJSEvZT9wK25tmpipxuGn2l41y0fhXEeFEaWcA
 Hivlj7VOkRvCpL4ryxu4saJaGAUUp9U5HRF1mgAG0DLnF6x/2+zPkxhTe0Wfy4uyFh/0 1A== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 39rmk2480h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 19:22:47 +0000
Received: from G9W8454.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.216.161.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id BE5D463;
        Mon, 12 Jul 2021 19:22:45 +0000 (UTC)
Received: from G2W6310.americas.hpqcorp.net (2002:10c5:4034::10c5:4034) by
 G9W8454.americas.hpqcorp.net (2002:10d8:a104::10d8:a104) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Mon, 12 Jul 2021 19:22:45 +0000
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (15.241.52.10) by
 G2W6310.americas.hpqcorp.net (16.197.64.52) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18 via Frontend Transport; Mon, 12 Jul 2021 19:22:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llFoathc0NLDZZSoRIbFMzyz+zYPhAGDVeGtQ83HC0Y5FRok4mKkM2XmunSt0tfskUoQa2vTGWYQPKsSO1emRZ3z7qFP2WsgCzmfWNLs7icMAPVcgrtvm0NjbBcQp6GmLzKv89H2ejwaqZf8RIW4azzTx1dTtoqUKSx0OasxLpnPgWEVb5kIyotEM1wPGD7l59zU8vQmi9eEPqdMJ7IPe4jmFVvUMtVbOCmlbsgEsNl7zto0UKmt5UOWGIl+Jy6a5oyPN9hxv48SaCtz1jzwlYRBADhRJJRjSNccEbZzBltzFmv3rim2LonAQ/S321bbk5v7WkAK3JhkWGh7W4ilgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPGE9fiBWWjEEJV67TuDiahqh4wHMUNx5TwWlqz3vjA=;
 b=bhf5ISWFLyoQaPp42q81VxbLcTuroC9opTVvyQq0c+2GEnzonD38m7rsh2FzEtMGFNbmKe4K+BUpvSjSLbE3VvBsi4qNA0Mb9KW9lb2wLfBrBCfGGxvMEKDwcBLAYPjIuAUaSUyH+iOTdaZomuJ4zy11F301wxnTN+o04SxWObveONrQKOKZmxBjdHdyvDZQkhuNo5KxdTvKtJ6zFA8E1J/cVLdyVcIc5QppifPyEYw3xS78iSsCSi4RvxICqexNJu5jfJNVrk/KJktSuIQbqjj9jfSN5VGrby4CNYRyliHhlsodC0/25q4GpgMd+4B8vZ/a0Lm4OfHIZ2FXQL5nRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7712::15) by TU4PR8401MB0494.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7709::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Mon, 12 Jul
 2021 19:22:44 +0000
Received: from TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4cea:35d2:c051:e737]) by TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4cea:35d2:c051:e737%12]) with mapi id 15.20.4308.026; Mon, 12 Jul
 2021 19:22:43 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     'Matteo Croce' <mcroce@linux.microsoft.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lennart Poettering" <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: RE: [PATCH v4 3/5] block: add ioctl to read the disk sequence number
Thread-Topic: [PATCH v4 3/5] block: add ioctl to read the disk sequence number
Thread-Index: AQHXdn3YesUJw94QbkmEhR2/eed3Hqs/txkg
Date:   Mon, 12 Jul 2021 19:22:43 +0000
Message-ID: <TU4PR8401MB10558BB52D2F37CFC96FB8B8AB159@TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM>
References: <20210711175415.80173-1-mcroce@linux.microsoft.com>
 <20210711175415.80173-4-mcroce@linux.microsoft.com>
In-Reply-To: <20210711175415.80173-4-mcroce@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=hpe.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b852b725-4055-41b0-c015-08d9456a6c8e
x-ms-traffictypediagnostic: TU4PR8401MB0494:
x-microsoft-antispam-prvs: <TU4PR8401MB04943645435AD8AAF0BD17BBAB159@TU4PR8401MB0494.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +TleEY1o+nYXQjYVigSvT7t9DqpMHyFCbK/YHiuJu2V3VmYg6Z7jh9sX+vwUBE1rOt2Mc2unSCBcJHkKB9ckKK8MAz4i23fXEFbiltFL+En307kWtPQld4TBTRuXq4QroJVo9mxDh/9SG6R7Y2AvIJtogoGO2B+jarTsa2jUpTEPDIpKVBm0DYrXDMK+Yh9Y5qPQLHCmThCYNA+RQkUB6lx8UAfIwq996NQTkODPlFMT+43HVrxZa5RgJF8GbIZ6NLO+yichFxIVmVGwqgdfEhetO0/XwZTuAaHG9W9aRPgP5ol53PmxOo9Yc5aoAmh4C1pBk8PBcARRpTSXQeH/YLlav/6ySzpsHlg6pmuG1pzIiFMEyYi2X6hgnOV5nWMDHBqo5SHTjk2goA0JKDxqWQCgnDdubm8GAmnKjYch4QuPpdjme720Y1xL0/bGFzRnSE5ETD45AKxM9qMKhSnPYBnlFLVeECzgxSHlVHSyKUIQawbyD7KMUyHmljS0qlH4PXn03d/MBXt8CK2Gn79ozFJxnxlpkOImxIwnh5bdJl6dHaq5R/zYt6Uocd9o5rl/wE61hhb5GH1zL8tX1tmcK9ibgLOR1DrWSTHSid7Z6eJkZE+Y43jdg8xdLiPNvsHPffc4O1cU4mph7NhSMJzdPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(376002)(366004)(396003)(83380400001)(7416002)(478600001)(2906002)(71200400001)(110136005)(54906003)(52536014)(76116006)(64756008)(66946007)(66446008)(66476007)(66556008)(38100700002)(4326008)(4744005)(122000001)(26005)(53546011)(6506007)(9686003)(186003)(8936002)(55236004)(8676002)(7696005)(316002)(55016002)(5660300002)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ePHkzP5cAte0fh/ydosJRI0OIsNF1XzgtUTebMejbWhrBNq5wk89KIfW00?=
 =?iso-8859-1?Q?OfGMMKy8SnvJMdT6SABi5DtwDidlxlTeh+a1tapNZKxw7vjH8pw3QL6+gg?=
 =?iso-8859-1?Q?5d+NAoGr0D58zfD4mHhmw1srQCCMSH0+LUgcNNKkr1UeV9v1apTI+FZBDL?=
 =?iso-8859-1?Q?V3TmKXHPf9LZMWimN+PurKBz82k0rCdMBdGs4cR93BUkb8QW4ZuQW1Z66P?=
 =?iso-8859-1?Q?8OoW5ZJUIho0D1/WRUhrlGQUMY0ZiGeKwf4uBSMhuCMlVMu8nD6HZ1Rap8?=
 =?iso-8859-1?Q?t+FpswwhoSHEAhE0KNTn7+/7WbRBUDAHog8foLYThOiYmhyx6vh30Y7DP7?=
 =?iso-8859-1?Q?mC9ezKU+bO092FryUBHtAH5aEz4DKMtJ24/3NImIeU4n1/oGQ8h6LANAcd?=
 =?iso-8859-1?Q?iw8n8ydicow6W7a0HQjCATGBappdqk4GE5rL3lIgEJeFh3R2gSZF24NnnQ?=
 =?iso-8859-1?Q?BlqafY4s4HEpHpYdo2gbWVj7vJhxPNa1u0Pv7/F3TGKkak7giwbEUwiLs6?=
 =?iso-8859-1?Q?+EDOR+QKP6JyJj/i9AoKxB63h0ynMX2B9V+LM3YnjZ6W7ohJZz6ZIZ0GJn?=
 =?iso-8859-1?Q?jzljgxL9w7NWbcZ0Y8WE7q597vZMT8g0vEuxraZbqymOYH/iAWIxVYnEpm?=
 =?iso-8859-1?Q?pf8wlobeZfAOnlBdY9XleHK1mTcdo3qig7Qv6BuJXz9r0KlGD0GfcZnOnO?=
 =?iso-8859-1?Q?p9rRrIugqzAinGgc+MpKKdKozO/WS3fmxH/SZnNg1lEaZfVpLU3aJkQron?=
 =?iso-8859-1?Q?NSHstOArYOnsuSGpJoSwBsHM398DCblaCFnKNAg86kDmAm2Q+WRR4QIwID?=
 =?iso-8859-1?Q?+gcqEkIHU75Cy8hY4rj7c9V6gXGqd5c5NC6OUBvZQ04Ta72g+Dvw3rzYiE?=
 =?iso-8859-1?Q?ZfJWVU2GKRG+/ZhjkZPkzpZ8V3LUSdxhHX9P/rZIglXKX4yIplaKaFFufK?=
 =?iso-8859-1?Q?BvuoqLbh+8j8vUgfdKILMT8tGHv35zzOpcLTSats4XJZr4dUmkKuv+3WTG?=
 =?iso-8859-1?Q?8owwfx/WokXLNDZGie/BHRPhdooqNn9/wgM547ZC9HArb22wUuv+ZPmpRb?=
 =?iso-8859-1?Q?GeBK68grMN66clFB1Hrh0Aso1/mm/DMmoC//0h9DpceAM6RJ1d3w7LUARW?=
 =?iso-8859-1?Q?PxgXAm2mbVf9U8CT1J8FINSBJE1FkWG9Q+rMiP9PN7SqBZf+CA41nHw1qj?=
 =?iso-8859-1?Q?Lw1RghsJuNjdhvuqK8sJaTSHONna2q7QxUYvCkwB0cQyia7/oE9YXAMrZZ?=
 =?iso-8859-1?Q?hlsynTAJz6Miy0hNCxBmF6s+nxvSUaActMriHapAz1AbFIM4E3eu5b8dY9?=
 =?iso-8859-1?Q?+6tzBlN1FAQ8L7ARL2P6A3YUYw6LwbX63VWOKwgMujlxRTFn7uOTXC9aKR?=
 =?iso-8859-1?Q?kvTrmYd8Hg?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b852b725-4055-41b0-c015-08d9456a6c8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 19:22:43.8660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TWWzbxEk9CWEVeXmMAaDQ/WWX/XLGZ2JPx/llKsfzoh90Vkmv6FkBuDbny3rPx9G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0494
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: JEEgrDJXp45stfeLewoTMQ2aB1A2wT8C
X-Proofpoint-GUID: JEEgrDJXp45stfeLewoTMQ2aB1A2wT8C
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-12_11:2021-07-12,2021-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=937 priorityscore=1501 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1011 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107120137
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: Matteo Croce <mcroce@linux.microsoft.com>
> Sent: Sunday, July 11, 2021 12:54 PM
...
> Subject: [PATCH v4 3/5] block: add ioctl to read the disk sequence number
>=20
> From: Matteo Croce <mcroce@microsoft.com>
>=20
> Add a new BLKGETDISKSEQ ioctl which retrieves the disk sequence number
> from the genhd structure.
...


Given:
    static int put_u64(u64 __user *argp, u64 val)
    {
        return put_user(val, argp);
    }

> diff --git a/block/ioctl.c b/block/ioctl.c
> index 24beec9ca9c9..0c3a4a53fa11 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -469,6 +469,8 @@ static int blkdev_common_ioctl(struct block_device
> *bdev, fmode_t mode,
>  				BLKDEV_DISCARD_SECURE);
...

> +	case BLKGETDISKSEQ:
> +		return put_u64(argp, bdev->bd_disk->diskseq);

How does that work on a system in which int is 32 bits?


