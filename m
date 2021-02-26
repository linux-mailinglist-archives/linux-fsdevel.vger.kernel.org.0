Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501A3325CB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 05:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhBZEuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 23:50:09 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:13871 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhBZEuF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 23:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614315005; x=1645851005;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mWPR3BLRGtyxWOSWCCpWhmGHZY88r8tGJq/RQhKcqeA=;
  b=fYCZyrBFJQJplnSXw9u5EzBiWgj1dqqDImQKlpJ9eA4gB12lRY/i7uCI
   ez8nfQJ81Fuy5zsw8CVhlmFX5++sDf5WQ3Gf+bfdMK9td7RLSLXnzkJU6
   w617w5M3B5eDyQNZ7S4EDNVsKfAjm27SGrDKSC6p+xB0ZlVIdDbhEoNgG
   pE6mzpczEMdBTmHPNzyLkiAC8IYevOXZ4wwA9by1Mc63C4eVvpDwil8GQ
   0O/1mPV0ERlaoZJ11UM+rL0KR6vtcSXr2icOKZW+5GQ/5qTg+m4YqH7CS
   ZFNNA7XADa/SDvAwf9EhZfgwyQeWksNncSbWqyIOIPw2fqp+UEbZqKB3n
   Q==;
IronPort-SDR: hT0zH6yCY9CH9DZQglbcFYbyYOGkF5hc7Rp53qOC+9nC2Vh9rUfFcnQ/S5co6sW1YdoB2Ihp4K
 MImVKmsehAaWs7rnsHxO7xR+HTHnIq9FM6r9huL+9Hj7s9Gat0QXWOyHzGwPvfu9v5+g3OoHSP
 XcrXPU1Vbufe1K3BH+6tsuI9ND0UeeStXiUj+l9jJrbFknt6GWYzKjyAUvuC8KQ85h79wHmqd9
 +PQ/zXpzPBhi0hezatxtDxUUJ2LjjNEbjfzGDTLX6VHuECkouh7Fu8SRZeLbQlO+XqdnZOjSfV
 b1Q=
X-IronPort-AV: E=Sophos;i="5.81,207,1610380800"; 
   d="scan'208";a="162024929"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2021 12:48:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZQdLyGKbopjQO/L4ceUtVU/8UQY31kE5nrM89bMk8JLhtcZWYNzKS6Rqcf6NPeHff/dPuz75OXc/LdfZZFf6ofSLk95izd7DcZEIvnKSMZ8jXrUrBylekykbeu/m7y5Lonurqs32f1lDfu85/gRttOBK2e7h1k3bzrR59RuAL9v1D/fwFq3YLQy6sc5mUtfZW3sP2kPQnDCae6N06pV9rcycZr85uCzD6mV+0fwt2zU6ybyDX2vymCRG9E7OjSF+dmFZ8lN2zLDoOdXYGeaRWQkyM2dv1WQGfvQ6SyfQR7AfazRmsVqP8OgFfTPsi7tjWJHBlqOsYvDcZerbnlgRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpGDQPoHDJpH0MVYHgsbm9dDJtkRkfllCYwF7CrDQNQ=;
 b=A0nnXwn67Pt5njAsWUU0D9d/184i453ntszIL2gZvXHQ+0eBfTPOQSg/HgQSvXlqJl+Ti9KGA0laazatZwGCzULJlP6PC0eCYDy4E1DNPFQZxV29KkD4X95MZk6A35x+3C27N2r3MqhMXQOs3GbWNUB4PPLvQiGPHi9xH9R7kMwTJwop1GmBG0ztdPBzxIkhB1/0bg7yVS5s02ejxUIVjUuH4yA91NjN/+sX2f+CB4y78/wXHjHA2a425PRBNj66vUjSjuLqOmIjzh6EM5/cWo6KQc2Vr3jXuazcl8bNhaCNIgNTUtTbX5En80hvHeDwP1Nr3179KpFEwpfDuQtpdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpGDQPoHDJpH0MVYHgsbm9dDJtkRkfllCYwF7CrDQNQ=;
 b=vmbA4IjHdMfuq+qkYYn/vCLzchUuB9mdB24SM3at++WXsxI9zimbnMcRfx/AOmYujIBscnj0Y5r8pdOHFo9GPAFGPaFiNwg/M07ufcgdwZpJ4+lq/+vSpnrIBljKdR6oVwlkSarvjTPsrneAWLjPMpo6qCby96x6tsRzIoS8mHQ=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4452.namprd04.prod.outlook.com (2603:10b6:208:41::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Fri, 26 Feb
 2021 04:48:56 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 04:48:56 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "hch@lst.de" <hch@lst.de>, "osandov@fb.com" <osandov@fb.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 12/39] blktrace: update blk_add_trace_rq_complete()
Thread-Topic: [RFC PATCH 12/39] blktrace: update blk_add_trace_rq_complete()
Thread-Index: AQHXC0R5yFQmgTaba0m3BcTZefncAw==
Date:   Fri, 26 Feb 2021 04:48:56 +0000
Message-ID: <BL0PR04MB6514D532C49CF019870D2045E79D9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
 <20210225070231.21136-13-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f9e3:2590:6709:ee46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ca4d6a1-6110-4c84-50d8-08d8da11d357
x-ms-traffictypediagnostic: BL0PR04MB4452:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB44529985317E614599FA53BCE79D9@BL0PR04MB4452.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lWX/yGQGhU1T13Ya68+G0Slqn5QrJ1x8NdpKGZ70NYRHVe6wl2qJmxxO2JRhFa2SRshvpc7aS3tQpZnEZxXyFXrsjwMZ5/tcYn9+BfQT2PnnzUFd+rqk3FlAF4sOJ3bRTAq1A/hxQ5BW0qerxX7DcqEcrnhxHTXLiCgKYeszVuGqQhd1FBdKBBD8jOOdpvDonznY5ETeBqxoM99Uaf4guouY2v9wmo/kzcHTU/oUCMAEtXG40G+jxkrOjYpFGolbn+RGcgTwUMir/I1hTr8CKQBbkbZGmoEaaNx9p+5ID+9P6Im5F+blE8Dlj92QPSFvZxGxzQk96hRFIMkZIWQ7LDhG/xQNbvwscDVcSUo6WbG0+AnsKYTHPLmsIhbECJh8lPG8hHr4Dn+kvX5qGfqztDmueBjurKfJyKA8CB9gjpDb3Q0PaBW5Iw9jitien3VdWvKWORUt8X+gs6+07FlOzLfxYdk8ExX+4n+SxLW6iwj474hAuo79y7daIHuQPEuBHEINWfXAXABlEcklUehfWybPTjL5bVKKTpU7aWwWXaUDzbsfq9XYCDIA9vCPu8Tm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(86362001)(33656002)(4326008)(921005)(110136005)(7696005)(71200400001)(8936002)(54906003)(53546011)(186003)(478600001)(76116006)(52536014)(6506007)(9686003)(64756008)(8676002)(66476007)(66946007)(83380400001)(55016002)(91956017)(66556008)(5660300002)(2906002)(66446008)(7416002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MT/cxqtVLTTBY9C3Th7+3DZ9iZFxFc/hLcSxaxkmWA/KsM865o3ykRrjmA63?=
 =?us-ascii?Q?/To3obz2DltyXI+6QBRMhPuCS5iE95wFnb/HvBFmnGCOu9oQh5zPYm2GjvL0?=
 =?us-ascii?Q?Tn7MC+EejzKuk9MRl+BlmjSMaJckCzi6xg1Dw7lYTUdwpJrO/TTRV38d0LHO?=
 =?us-ascii?Q?UVbsuFxVme4INEIj0Dw6TYHhfXM1HiiRV8RRrgnXSpqQ5NPF62HfrG98kfTU?=
 =?us-ascii?Q?b3bXZHEyYduatHmO8+Xje2Zu/ZtHAHdL0Scz4OZfvEJiCPPoQpVQrjz1Jj4D?=
 =?us-ascii?Q?vRGmFcA0Qaz2iaOuvODrJ6Y50vZgklJbcY5nT6K0jmQCIgwPr6n3o6gu3FDs?=
 =?us-ascii?Q?pL9LqT2ZRrDd2hA9Taqw+faTeillWXo023fiVkVtGPx5ry/S1cO3CHHQjGN6?=
 =?us-ascii?Q?bIeWgw/EPHZdjeLvSqBmhleM7yYL2E7PK5XsnCGXCotaDy8OsvvjbnvRuSF5?=
 =?us-ascii?Q?9RSlDkKkUNH+s5E0MbgqxVpEWNjWKP/NYcg2G8pP7ZLhFkSuyEXwcuEBRk6Z?=
 =?us-ascii?Q?jwJp7anxCYpxDT5jN3vPTW8EqmxaQbsV1hrWg+mxOcp6my9ZWXBgr82rtBKJ?=
 =?us-ascii?Q?EWkPceerf5OnoLPt2mLGISWjU+1nPK5kYwgrUcnrGi1USMhWlFRUl0haqZU+?=
 =?us-ascii?Q?VzoEmdOjkj098jNOYEiuxxu9mhpqfM9qKm7NH32BJoDKG4tPu/MvsvRl3rWn?=
 =?us-ascii?Q?M8jxGS2mjuPTte04xjipTL2RTOg7JGsCpE6x6e88o896eR4adIGy6YqMu5SZ?=
 =?us-ascii?Q?DvPafEmrEROO1mGfolw0vuFflShtl7o7ZT9MpmiNYTY6eiHu0tsL3QRpgMuU?=
 =?us-ascii?Q?jygM0BM4mEr8/Za6JwQReN3hJ8wtWM8TyLsLXrMsPHEHipcVHE6q/ccJjUpr?=
 =?us-ascii?Q?edpIyZ40PvXwksebQ0VinkujsdYugWUUlPtfbX7028b0LobjYlqMxi3KrpBh?=
 =?us-ascii?Q?/OOfFol2qQ/QGcYyD5rcKbD2UgOg6pC55iqK6vOZEt2RbAAl2U6nvz2CQr/r?=
 =?us-ascii?Q?bfpPDfhh6ge3pOFCMjUBo+Fwuk4qMbo9pvXCR8hNJter08l9aAZ8QKWKZ/Bv?=
 =?us-ascii?Q?d4Ic3iSzyYO2djOJCDCv9d0di4b1c2kosiuPnUU+1uaxK3uIcV5LG16bEEbj?=
 =?us-ascii?Q?Jrsmdw8TseofC7tPbY7OlcZjmyV6GwqYrD6Z7u1QWLFhJ22yNlJwaG04gHSi?=
 =?us-ascii?Q?gn5Zf8PmOqKynhqFyhVHBqayZpVqF1yOIKhSpkge93bLMX3phRNVtJ45KQnD?=
 =?us-ascii?Q?JXFDlwU8E3DEVk1CSDhPlTVq+UO9DDKFK/nwOcQomaDUyn3uhIfP8GUEWkZV?=
 =?us-ascii?Q?6I+jTlLNaiKboENDCT5arbxNgtD9HAwm3pbRSTgiprC+ZDRMs8tGcabRrMh0?=
 =?us-ascii?Q?JV2hldAVcT2mjvbMxOoTaRFItXRg98A/+MmTH/01p1fzs26nlA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca4d6a1-6110-4c84-50d8-08d8da11d357
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 04:48:56.6615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2vRqf8SDynvpZ98HfEmUCm1sT7gfGkXMUck+PgoBkZ4cSy5gekBg08mn/1unrAu1rzb9Huc5j0u09ta1sA9F3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4452
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/02/25 16:04, Chaitanya Kulkarni wrote:=0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  kernel/trace/blktrace.c | 20 +++++++++++++++++++-=0A=
>  1 file changed, 19 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c=0A=
> index 8a7fedfac6b3..07f71a052a0d 100644=0A=
> --- a/kernel/trace/blktrace.c=0A=
> +++ b/kernel/trace/blktrace.c=0A=
> @@ -1213,7 +1213,25 @@ static void blk_add_trace_rq_requeue(void *ignore,=
 struct request *rq)=0A=
>  static void blk_add_trace_rq_complete(void *ignore, struct request *rq,=
=0A=
>  			int error, unsigned int nr_bytes)=0A=
>  {=0A=
> -	blk_add_trace_rq(rq, error, nr_bytes, BLK_TA_COMPLETE,=0A=
> +	u64 ta;=0A=
> +	struct blk_trace *bt;=0A=
> +	struct blk_trace_ext *bte;=0A=
> +=0A=
> +	rcu_read_lock();=0A=
> +	bt =3D rcu_dereference(rq->q->blk_trace);=0A=
> +	bte =3D rcu_dereference(rq->q->blk_trace_ext);=0A=
> +	if (likely(!bt) && likely(!bte)) {=0A=
> +		rcu_read_unlock();=0A=
> +		return;=0A=
> +	}=0A=
> +=0A=
> +	if (bt) {=0A=
> +		ta =3D BLK_TA_COMPLETE;=0A=
> +	} else if (bte) {=0A=
> +		ta =3D BLK_TA_COMPLETE_EXT;=0A=
> +	}=0A=
> +	rcu_read_unlock();=0A=
> +	blk_add_trace_rq(rq, error, nr_bytes, ta,=0A=
>  			 blk_trace_request_get_cgid(rq));=0A=
>  }=0A=
>  =0A=
> =0A=
=0A=
Same comment as for patch 9.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
