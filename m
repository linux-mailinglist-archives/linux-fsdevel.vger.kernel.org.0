Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EDE306F31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhA1HYy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:24:54 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:8270 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbhA1HWz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818574; x=1643354574;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=9Hp1mmxIhP12exuHZUs6f4NIF64JekIbMU2y2gjowsY=;
  b=KmiMkW4ERc8uQLBvck7mIo06Arcipz/SnNoovMstKYQsL/25huj/Eoxo
   RQY0mm1mc5i1cSAkKi9LbydoKmryrqzzuzCNf2Y4DTooKcIM5UMwHy9o2
   7wWTR/L5qt3I+fJ1jjHJde/0nIsnwwrgTaP7dUGFHg6l0j8ks83NCJ86f
   amlkS/kUYpR5XWUitwRUoO9CsBDC/X74h/mO4jSEUqhAyl+ovzbKTKNwL
   aqr74gYpSq2XQbRYgyrmwcLjymehuqz/06Gkhl0/TzugBQU+j6aqTpkNz
   W2IyVuIggmdJ5g9BKU+RbUGEEquhjx2C2PXoLJuPQ8eGoqpE6eifKcxOH
   A==;
IronPort-SDR: QEF+8TGngCqTGDYAfES0k7Iq8Lj8Z1j23hWw3M3LnFhL6QZih1XM5LZxSRsfTJXgpv5E1SblKM
 Bsu7V10JhP5TnAvBjYRtRxEqUPv2HJm33T5x70FdtpKeTam8Lku0k8SIl7hluBD5ij/As5Vw9s
 nKuDQlS8VQ8KHSrpBH6erXI92dE58YUlccMAgxKbmkG5Krj4uGkirZn5TulPgUw8Qky4rfx2PQ
 aWCuLtWfwtNgNSyX+xM2wVuWWfLlJn8a8AVx4NTLiKKss4UTZKw7CG5gC5hQr1D2fM05/SrZuv
 r5A=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="158517951"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:21:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGvTFC0yVocA1hFeGOYvjQ+f/YSuD75Q/8tkuiyNxQkF23UxvMywneYGAln1lw8Xhs3qjQvWItdgd+CqdoCZOLpmuH4ptIfJkiKypbJOF8fjo6xly5kpeejMCcmb9TV+VYlceFyaNhO46nha82bqmy7/luCs/lrsoL/cArREno60UHuMizWsEmdy4Bxfq7LnJpERyi07H9ww2vM5jeFFQj0tMeAigkwO1DsWafJt0Fq839vVOSa6z1KrJTZS1iJDKKe3rPYdaA3pbji5icSyWi0MHi2Av8SuAEzbzvSxch0j+tb0kMkBwUJVhvH8tc9lyxzjLZbBWdlEFDj4KAQoSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZQ79VfW37oEjUPhbUXgVDt26btMTlh35TXahcKTIxw=;
 b=ewcyy+f5pm0Gvfuq66QLUzmljFfxV1XcSt+FlXT110bCllm3RqvEk+y6rdwmDmRsLuIdGvXsMnFhphdnjfxABcalxu6RrTkW7MnOnWh9EF/8L3nffa7eXXB95G3BRw9RE5QltDcCZ1vcJ9c2HoEAI4HaooQEfE5prpKhyIBJc+z2sT8ynyDdElAtc2TQJJC8yAuAd8n0jS7Wc+YTaNR4fwo2ziu1wBo7rB+4xYRJnj/90sIzgR+/oyqJ8hNKi14vk4mwaZnVXoctiOqF4V0CjyJ2prws95UPtxPw9I8GHkzSJXn0TdiFJJTWo1ZfduzHSE90W7Sesm7qKNrg2W5Wag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZQ79VfW37oEjUPhbUXgVDt26btMTlh35TXahcKTIxw=;
 b=hrFaGwglVnPWcvrZYYTSLmKDzWe4Ql8MYzMhE/ZNdzUUxZaQHpa0WUmIc6fKPln6CA7rT0gIe3GHUdejLdgow6Yj1ChwX6iG2QGP9vTtBq0U3ZLqwlykpawLR4D2R+Htay7VfWrlfDvS5SjOdFc1MzrgeW8k4qfHTZmC0UwhJ90=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6352.namprd04.prod.outlook.com (2603:10b6:208:1ab::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 28 Jan
 2021 07:21:42 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3784.017; Thu, 28 Jan 2021
 07:21:42 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
        "lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "roger.pau@citrix.com" <roger.pau@citrix.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "shaggy@kernel.org" <shaggy@kernel.org>,
        "konishi.ryusuke@gmail.com" <konishi.ryusuke@gmail.com>,
        "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "jth@kernel.org" <jth@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hare@suse.de" <hare@suse.de>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "alex.shi@linux.alibaba.com" <alex.shi@linux.alibaba.com>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>, "osandov@fb.com" <osandov@fb.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>
Subject: Re: [RFC PATCH 02/34] block: introduce and use bio_new
Thread-Topic: [RFC PATCH 02/34] block: introduce and use bio_new
Thread-Index: AQHW9UTnP+XqlvwCeEC+5iodtWSeNA==
Date:   Thu, 28 Jan 2021 07:21:42 +0000
Message-ID: <BL0PR04MB6514C554B4AC96866BC1B16FE7BA9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
 <20210128071133.60335-3-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:47a:7b5a:7dfa:1b1e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb871fa1-3f12-44a2-a077-08d8c35d5ca2
x-ms-traffictypediagnostic: MN2PR04MB6352:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6352DBDFAB902914B9C585EEE7BA9@MN2PR04MB6352.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M09uEpCy2sHYnN+orzp8d3r4sKwPwnS+kovdPTr+X2vGltHHUOiuwt35YiL4pwUTQFJb9lI/cctrcvMtSEsYDG11B6WuQeQ5LhCFOm8xnCx/j7IUhZfAc+BSTsEsxty8tkWMahat2Us5tDlHI9XpWnzEpUBuIiTIis6CFGcSzDbZQv+YTkDwb0pb6zKYryvjjNyuaDbfN6d7lDvAFgMe/S84pCGpf8NIYlMhpfcnANa9rtVk1fEfaQ11KXM8VaoFYslEaC8FtVVKMdMiSlVm1G6wR6EIe9QpF54CPrt28byH/cHhwj053vEXp8RFF07hlGeGEHLWbouozYb93iT1K6F5OPFCWV/ewR8z5Kn/uykKQypwrh09HC+m3KNohPQSss4YboxRFNRKIUOjUD9KDfOD2dh3DMVG9Wehar1cknnRs6eoICQxgNf9XdAqhQxkvWGbAdwofxGFVG96zdq+KiRY7l6iGEQ9lizBBRpl1Cl5YsTWF3Ebz7haDS4uRI4CUlc0EEMGTEpRabqGyepXSSCQauC0I01aeQXMPzWGYL5JlkA/UoQC4yu0QYoNvMSIgo+cZP34MN7KkNUL2U0tyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(7366002)(7406005)(64756008)(66556008)(66476007)(66946007)(5660300002)(7416002)(316002)(6506007)(186003)(66446008)(76116006)(110136005)(83380400001)(53546011)(7696005)(91956017)(54906003)(52536014)(9686003)(86362001)(55016002)(71200400001)(2906002)(478600001)(33656002)(4326008)(921005)(8676002)(8936002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ilRnIHb2W+3T2C2caNzRqpDzJ0Ea0Xivh3HFrmVjFepbjG/4fJPeoU7kjRlT?=
 =?us-ascii?Q?4cfEdoxq1pKIhTR8YC8VWpTJjQgCARNQwY+MfHwWAHyq7XzZrTJ+W5zBB4Nr?=
 =?us-ascii?Q?gbqboym+VApr7h2E6XSe0FmXOz+omKq6DFZVboi3NwQAYnWCDCcygMa0n5ZC?=
 =?us-ascii?Q?i+orw+uEOMmnA8L/tMdOkJYMmLEyVDh+G9pnjfMmYkt0blpGnFBWHNDym39U?=
 =?us-ascii?Q?dIrdmaQbh6883La06gFXbWGdjQgjXOXLEnZ3UgQdxTZ3JyxZKLQ71jVVbmhr?=
 =?us-ascii?Q?0p2pkHIwQoMPz5HKOnR6V80LYTmpcP7VgrO091zZ/4rct/lsBVwykJza+GD5?=
 =?us-ascii?Q?IHbQu1IRlEAKFeXGAtTjEb578LsnTaSvJCJYoQS2vP+axrzwvVVw8mOt+5k0?=
 =?us-ascii?Q?KL2XZSeojWALtQsww9PwXxXKo/u++tt+9E5GT2jM5O4BtWCGYIeHt1uhRADL?=
 =?us-ascii?Q?gJ0hzvvlILRjU/TqEgmmCXBE50OH3C99QT7ii97n4+QFDEjw2bGLKb5lrf6H?=
 =?us-ascii?Q?IHyTRN7gvNFJTUay5wTAkpCCUyYWXZIjEb2UFpB6lV531wPPtNPC4ZXwwrWy?=
 =?us-ascii?Q?UUwx0RViz7R7iLMJP7kZUpan/n9xAtlMTSdfuUl+LJK65X0ynOT4EUBmjZh1?=
 =?us-ascii?Q?7f2FeVb24U1zoxD5JnIuvykDuOYgmJlnvf2GvI4IfNA9RybrTxAbVd7Ev1uE?=
 =?us-ascii?Q?iYKXh1HRo38Gzl+/krexExV4e0GgKuB8ROJUM1mrrLxC0PLvUJVZZWIIKY/T?=
 =?us-ascii?Q?EtWttQJe8PPeFmAWMbSTnlaoUKPvNyDC93hjlfGSDIjTTLIFZ4iZg/v8/mfl?=
 =?us-ascii?Q?vPF743c6M4QtXnUUQcdd8jMU2Xffoi6iuon4E7e6TeLOR0e7niaTBUf3bgPv?=
 =?us-ascii?Q?W2AR7teeocTc9v/wp1bkGDqoO4PDXnCni+0tsViRKD+BHAkawcDVDIjbtPby?=
 =?us-ascii?Q?TmOiQAj1HhTITExgPZ3Am1ML0xT8XHeZOcxCj8XLjunGXY367EkeICLa7oc4?=
 =?us-ascii?Q?Hx+SgjQnG25wJn9UaUXUtvbZ+SxW0OdUJGfxAAPJaG/AhMr+s6nN+ezf5jC+?=
 =?us-ascii?Q?TnbTVjltXe3BweymPazgpv3fxkvT/+e3/ihgd/xwUglKOJv1POJWqDO9pOjp?=
 =?us-ascii?Q?vVmRwBKsvdP+eIgHWtuWTOV2jEyOlzJg4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb871fa1-3f12-44a2-a077-08d8c35d5ca2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 07:21:42.3813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HOBO+8eTXWVmpt6dgIHyBBjDN753lOgBMYt0QXNGr1qUdGHKogIJ1c3Ww3ZO4DM7PeQNbxVnSGwrctGN0hiVFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6352
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/01/28 16:12, Chaitanya Kulkarni wrote:=0A=
> Introduce bio_new() helper and use it in blk-lib.c to allocate and=0A=
> initialize various non-optional or semi-optional members of the bio=0A=
> along with bio allocation done with bio_alloc(). Here we also calmp the=
=0A=
> max_bvecs for bio with BIO_MAX_PAGES before we pass to bio_alloc().=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  block/blk-lib.c     |  6 +-----=0A=
>  include/linux/bio.h | 25 +++++++++++++++++++++++++=0A=
>  2 files changed, 26 insertions(+), 5 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-lib.c b/block/blk-lib.c=0A=
> index fb486a0bdb58..ec29415f00dd 100644=0A=
> --- a/block/blk-lib.c=0A=
> +++ b/block/blk-lib.c=0A=
> @@ -14,17 +14,13 @@ struct bio *blk_next_bio(struct bio *bio, struct bloc=
k_device *bdev,=0A=
>  			sector_t sect, unsigned op, unsigned opf,=0A=
>  			unsigned int nr_pages, gfp_t gfp)=0A=
>  {=0A=
> -	struct bio *new =3D bio_alloc(gfp, nr_pages);=0A=
> +	struct bio *new =3D bio_new(bdev, sect, op, opf, gfp, nr_pages);=0A=
>  =0A=
>  	if (bio) {=0A=
>  		bio_chain(bio, new);=0A=
>  		submit_bio(bio);=0A=
>  	}=0A=
>  =0A=
> -	new->bi_iter.bi_sector =3D sect;=0A=
> -	bio_set_dev(new, bdev);=0A=
> -	bio_set_op_attrs(new, op, opf);=0A=
> -=0A=
>  	return new;=0A=
>  }=0A=
>  =0A=
> diff --git a/include/linux/bio.h b/include/linux/bio.h=0A=
> index c74857cf1252..2a09ba100546 100644=0A=
> --- a/include/linux/bio.h=0A=
> +++ b/include/linux/bio.h=0A=
> @@ -826,5 +826,30 @@ static inline void bio_set_polled(struct bio *bio, s=
truct kiocb *kiocb)=0A=
>  	if (!is_sync_kiocb(kiocb))=0A=
>  		bio->bi_opf |=3D REQ_NOWAIT;=0A=
>  }=0A=
> +/**=0A=
> + * bio_new -	allcate and initialize new bio=0A=
> + * @bdev:	blockdev to issue discard for=0A=
> + * @sector:	start sector=0A=
> + * @op:		REQ_OP_XXX from enum req_opf=0A=
> + * @op_flags:	REQ_XXX from enum req_flag_bits=0A=
> + * @max_bvecs:	maximum bvec to be allocated for this bio=0A=
> + * @gfp_mask:	memory allocation flags (for bio_alloc)=0A=
> + *=0A=
> + * Description:=0A=
> + *    Allocates, initializes common members, and returns a new bio.=0A=
> + */=0A=
> +static inline struct bio *bio_new(struct block_device *bdev, sector_t se=
ctor,=0A=
> +				  unsigned int op, unsigned int op_flags,=0A=
> +				  unsigned int max_bvecs, gfp_t gfp_mask)=0A=
> +{=0A=
> +	unsigned nr_bvec =3D clamp_t(unsigned int, max_bvecs, 0, BIO_MAX_PAGES)=
;=0A=
> +	struct bio *bio =3D bio_alloc(gfp_mask, nr_bvec);=0A=
=0A=
I think that depending on the gfp_mask passed, bio can be NULL. So this sho=
uld=0A=
be checked.=0A=
=0A=
> +=0A=
> +	bio_set_dev(bio, bdev);=0A=
> +	bio->bi_iter.bi_sector =3D sector;=0A=
> +	bio_set_op_attrs(bio, op, op_flags);=0A=
=0A=
This function is obsolete. Open code this.=0A=
=0A=
> +=0A=
> +	return bio;=0A=
> +}=0A=
>  =0A=
>  #endif /* __LINUX_BIO_H */=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
