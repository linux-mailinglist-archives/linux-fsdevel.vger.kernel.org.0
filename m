Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22089306F79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhA1Haq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:30:46 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19176 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbhA1H2d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:28:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818913; x=1643354913;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=T2M8NUVLME4aRV2htfsE34grqMKC5BmKNz4/COkl3ZQ=;
  b=cPoir2rK2RMpy8YBQOu/ITYYuhLlb7JjKYIFa/Ygn9afaddFKqG4Xd4Y
   cdi2R3UefuItK9/f0kj2yC3hWq94l9Oz8iyyb29gvJ8T2owpMxj7zoD/l
   e1PBvoODTBD/nHH/3tnVTJD5O6zSQD5kLBqJk5wmOjbESNvmU3e3tzHWI
   EBjIOzMBRj4wI1cH0sZ8aNpLR44x39UJiOJfxAZNewGoWJohOU+eDqAdZ
   Pw/5mgTFiYYS3Rg1fmxBgCmeal/RYfCJKJHQtTffMUefrXvC5KYieHLh3
   shsVti+hvhjjjQ665kQ5ZDcjTSQ4MIXHhSBRKL/xakWUWjQlZ61EJdzNw
   A==;
IronPort-SDR: 5meZAAXbPsZyMOd9RQOAURE7ue4N8I0GylPazNiN4F+IkU2Nf7CrEdUTmPOyFzJi7zfeggOiiu
 Gt5Od7xhy+yHk7m31eLzfrafTPyIE2+841Tdhjt9RuKfy1UwsAhsaJEc7TrPpyeonTG5OoNRbW
 jYwfp8qY1//btPd2uEMJY+wlNQ6hUZhFAaCgz+oVCXV8JG1R++3gaALgNG32rpHLVCAPpUvSm5
 ZnyqhIjEF7MhfKsrin8SIf9C2tCW+9kugysfCU7OmxJSUh1jT50kH6wLdq3lVUWVW9JSAnaEIT
 sQI=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="268893462"
Received: from mail-sn1nam02lp2053.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.53])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:27:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B83E+AQw1n8nLaPpws6ZVk2Dvv0JowLzEH6tW4QBIZHQO5bOyKoRkl9zce6LAfAcYeKNBnUqMBuqWKPapazajsM6mugFl46pUPnH27w2MyNgzfB2U64tU7/YQtksU04S+GWbxUwv7ua6jeuaCXw0Q2a/INcuYW1pZmbpSmGcHX0jgHrsfKIziwmv/KoIW40wdsUPJfmkSsIjxMNkqU8mSH3CYfS72OI5u+QFvQXzGlRrot81kEsbS6zPF3R+md3jI0xbLOthW81i6HkUhnZFc7n6i76TjivEJep1dTrNSJmAcZacixJJoHL5R1ayC6mgKhmUp43MFeS2JhA8RHsWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dHgs/1VLBXJ5Fid/0F/6cbHkJ0A+oW1xrqX9+A0GgQ=;
 b=WpVsW1S/kKhHgGTEzveH/WBQWziddYzWdBCW+5peeK2CMYzuM35ikhiL93qQisaU2sh5XUUpBGRi/TFqqx3OmGIe24yyfIzJAQbSDPUcgJl828BlV9USdpsDOoEeDZtHgttMYKmGI1gJsSt+V6kxWrCrBRnN8lSCWDpfiroaO+QmE16osB2eevjAkuP0qNTfCZo6bo3ZQRwiDwhweVFwoM8Ww9mA8MT5yPoo5QtVqHYpRPAG0NbaJNanr+SI0Duz8hOTcNB65u4JLwKXGhuJHAalGmP1VOd5oTVjmseyILk+5VEQB5HpwincSvcGZkpYEkN24oBog5tfK+cn6HqdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dHgs/1VLBXJ5Fid/0F/6cbHkJ0A+oW1xrqX9+A0GgQ=;
 b=OmolSAczHKzAAi3bPwvoWo7TGzLvqangGQWi2c5Sh9RFfgjNOdOyzcv9+C8k3UIZaJ+51zzrFKlVtvr1qzTutNDoolRqW7KTSNHEs80Rs9hbYszveqvR3GqoW8LPT57NDFR+VyDiYnlpkJdSihza+fjBRoOc8go2CbQlrPtUGhw=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4852.namprd04.prod.outlook.com (2603:10b6:208:59::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Thu, 28 Jan
 2021 07:27:21 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3784.017; Thu, 28 Jan 2021
 07:27:21 +0000
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
Date:   Thu, 28 Jan 2021 07:27:21 +0000
Message-ID: <BL0PR04MB6514DBA7EDB8EC87A1C20871E7BA9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
 <20210128071133.60335-3-chaitanya.kulkarni@wdc.com>
 <BL0PR04MB6514C554B4AC96866BC1B16FE7BA9@BL0PR04MB6514.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:47a:7b5a:7dfa:1b1e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 98283964-c91e-431c-9fb9-08d8c35e268c
x-ms-traffictypediagnostic: BL0PR04MB4852:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB485290861AB8AD7380809BB0E7BA9@BL0PR04MB4852.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hxj4fa4GkcBNNCunfMw7J9/b9iCM3fJznMuhOWkCQfvwJ0NrAIluFKg3+jXWfl1tLzPUJCh7B78dGsB53Gqk1Z2m7MWGTazT/q4pi5bAn+XOAilmmSdZvZ9sqjmQNXhEiTj4kt72t+S3/drX6amXX9FT+FK55adEN2vnuJcgUNqzT4TxQrX+LcNNGQZnWc1Tlo1+uTv04dXECuuh7Tu9LBWclBuE7jek77LbLzIUJdaPhgbGq6L/Pdx0JqnyYF+FEQPM8881yuui+kueEXVoqlzgBqK5vaKAqGJTqa0aBFevZqZNENtO6og/LDPr5d9E1UWTTP7/Da2oTdLL+35iaIOLalRmCHBRvUY6cEGhYxURyVSG+g4j64QtJxsEF71Nji99U+trtgurQXiLlnDTDGxf+MDnSLAb7nLKVPD/4Kml1pvdzPIUKukEtZD2GxrzabB/3418cwibWgs+12obfmiGrBfi16NV2BeC0p+Se0p+BmqHDY/WZr2ITJIpH7HBw28kQg7FWHu0BZbkFGLyZ1vhLckxE+yPI8cR0tXHr+nJtxvmCqxf3bBjfbGb7Q3/k4D1vq2cQ3zlnKpMfEgb0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(186003)(66476007)(83380400001)(53546011)(5660300002)(66446008)(316002)(8676002)(71200400001)(66556008)(91956017)(86362001)(64756008)(6506007)(2906002)(66946007)(52536014)(7366002)(7406005)(9686003)(33656002)(110136005)(7416002)(55016002)(54906003)(4326008)(76116006)(7696005)(921005)(8936002)(478600001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sgomRkWS3uJS/HM3uKXHylAhoSZM+lVQWdt2dHx9bjA8NQXvXFM6Dfv8MW1A?=
 =?us-ascii?Q?iCsEXvQot8m+wWe1prFL3N6W4X/zd4E4zBQMqtLQEJA5H+WTWLCNwdvng6U5?=
 =?us-ascii?Q?SkD6CC9MBeyZGtVMnjn2C+bStrwfe/6T4Mh4yY7H804uejWxG1MgZhnXTjqp?=
 =?us-ascii?Q?f36HcMhJa8fqBRYTB616pNnmAuoeQyPrXZYwSIUFh1bkSg5h3DWdvFdnge8/?=
 =?us-ascii?Q?O9MCM+eECuYQXcaVSUcc0tBlY9mVO1xLxaHa+pFR3r6GyIUZVhAFKPD8DMJf?=
 =?us-ascii?Q?WqsPp+KkYw2miQ2VWu7CKnb5XE/WZZK8NjFYrO+UvBi0zDKD7ZerGy3ioMo0?=
 =?us-ascii?Q?d5CGojo5bVlNDYR39iusEWUd7T18JfU4UoWDmqvKw9astFDt7GxuiNAHMcX0?=
 =?us-ascii?Q?yyVIMk2hKHQYRROUDYWJXFKFYeCK5lmmjxBt04cM+t3AhLH2tTJ8jpap65/Y?=
 =?us-ascii?Q?8A/ijV/T2IbajTQmqxd38MsAkL8lLy0sB7zTUHpkXikXfHmE6OhpRLxglctK?=
 =?us-ascii?Q?/aViM41m44269sQxLJudPSQx/yzA7+nPRic11ihTWQ2xQYSelMI6oY07tQjC?=
 =?us-ascii?Q?hVnAD1Qaet3As9B+ynly4BGIECf/ZcPbSzc+Oocke/rsdoUZIRCx9A5o9NPg?=
 =?us-ascii?Q?7g0qYPFGa112F08uWlKr8jI4vxPqF3DcPOVvoayIcVqK9XZoqxF6lkGygG5v?=
 =?us-ascii?Q?YJDU5PuEe/Bm7FrQH0EsVCPz9aYpSofnlInNuhSpB7hk8gf+GLuZQe8ZAkA7?=
 =?us-ascii?Q?lLd1unSvvMeP5ssLoUJow6t03g2CrTllNyQmec0sH/jgAMA2cCCp8r8xmKu0?=
 =?us-ascii?Q?Gg+Dly15s3nODQmsmpsV0f+GypiBJPNVpzMiB5Rnrtqy507XVwyx/YdLVrRR?=
 =?us-ascii?Q?7DSFyDH/Gxm1k2D/VzvvIJvHY1LnFzctkrr2UgpR99aD9dEGB6hzTFgdaIQZ?=
 =?us-ascii?Q?nCCmPvdeJum19k9qpYis5Ika8c3StyujyDXHLcdbNXrwFYeKpNzciRcoJEUu?=
 =?us-ascii?Q?eP4u0Tzg0LWQzv92vuaJ8NPyfWg9Lh2zkr0bUa/54WZ0wuoaMHYXuXRE9cLO?=
 =?us-ascii?Q?raOcqCp92WeqiaDleK2EmL+MyhJdBYKk0193myzV8+3E9alBggQTIB9lKXUE?=
 =?us-ascii?Q?7KMBpTg7b29BlR2LscuWM6WzgIjSyYfNWQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98283964-c91e-431c-9fb9-08d8c35e268c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 07:27:21.2324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /2IrgMXm3pcAMmUWJ3iRNrQ3DcnbFiB1YBVtQXVgzQ2J9zyuh/I6YXHgjhJr8lFi69x2/0yQ3ft/PTFeop9ktQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4852
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/01/28 16:21, Damien Le Moal wrote:=0A=
> On 2021/01/28 16:12, Chaitanya Kulkarni wrote:=0A=
>> Introduce bio_new() helper and use it in blk-lib.c to allocate and=0A=
>> initialize various non-optional or semi-optional members of the bio=0A=
>> along with bio allocation done with bio_alloc(). Here we also calmp the=
=0A=
>> max_bvecs for bio with BIO_MAX_PAGES before we pass to bio_alloc().=0A=
>>=0A=
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
>> ---=0A=
>>  block/blk-lib.c     |  6 +-----=0A=
>>  include/linux/bio.h | 25 +++++++++++++++++++++++++=0A=
>>  2 files changed, 26 insertions(+), 5 deletions(-)=0A=
>>=0A=
>> diff --git a/block/blk-lib.c b/block/blk-lib.c=0A=
>> index fb486a0bdb58..ec29415f00dd 100644=0A=
>> --- a/block/blk-lib.c=0A=
>> +++ b/block/blk-lib.c=0A=
>> @@ -14,17 +14,13 @@ struct bio *blk_next_bio(struct bio *bio, struct blo=
ck_device *bdev,=0A=
>>  			sector_t sect, unsigned op, unsigned opf,=0A=
>>  			unsigned int nr_pages, gfp_t gfp)=0A=
>>  {=0A=
>> -	struct bio *new =3D bio_alloc(gfp, nr_pages);=0A=
>> +	struct bio *new =3D bio_new(bdev, sect, op, opf, gfp, nr_pages);=0A=
>>  =0A=
>>  	if (bio) {=0A=
>>  		bio_chain(bio, new);=0A=
>>  		submit_bio(bio);=0A=
>>  	}=0A=
>>  =0A=
>> -	new->bi_iter.bi_sector =3D sect;=0A=
>> -	bio_set_dev(new, bdev);=0A=
>> -	bio_set_op_attrs(new, op, opf);=0A=
>> -=0A=
>>  	return new;=0A=
>>  }=0A=
>>  =0A=
>> diff --git a/include/linux/bio.h b/include/linux/bio.h=0A=
>> index c74857cf1252..2a09ba100546 100644=0A=
>> --- a/include/linux/bio.h=0A=
>> +++ b/include/linux/bio.h=0A=
>> @@ -826,5 +826,30 @@ static inline void bio_set_polled(struct bio *bio, =
struct kiocb *kiocb)=0A=
>>  	if (!is_sync_kiocb(kiocb))=0A=
>>  		bio->bi_opf |=3D REQ_NOWAIT;=0A=
>>  }=0A=
>> +/**=0A=
>> + * bio_new -	allcate and initialize new bio=0A=
>> + * @bdev:	blockdev to issue discard for=0A=
>> + * @sector:	start sector=0A=
>> + * @op:		REQ_OP_XXX from enum req_opf=0A=
>> + * @op_flags:	REQ_XXX from enum req_flag_bits=0A=
>> + * @max_bvecs:	maximum bvec to be allocated for this bio=0A=
>> + * @gfp_mask:	memory allocation flags (for bio_alloc)=0A=
>> + *=0A=
>> + * Description:=0A=
>> + *    Allocates, initializes common members, and returns a new bio.=0A=
>> + */=0A=
>> +static inline struct bio *bio_new(struct block_device *bdev, sector_t s=
ector,=0A=
>> +				  unsigned int op, unsigned int op_flags,=0A=
>> +				  unsigned int max_bvecs, gfp_t gfp_mask)=0A=
>> +{=0A=
>> +	unsigned nr_bvec =3D clamp_t(unsigned int, max_bvecs, 0, BIO_MAX_PAGES=
);=0A=
>> +	struct bio *bio =3D bio_alloc(gfp_mask, nr_bvec);=0A=
> =0A=
> I think that depending on the gfp_mask passed, bio can be NULL. So this s=
hould=0A=
> be checked.=0A=
> =0A=
>> +=0A=
>> +	bio_set_dev(bio, bdev);=0A=
>> +	bio->bi_iter.bi_sector =3D sector;=0A=
>> +	bio_set_op_attrs(bio, op, op_flags);=0A=
> =0A=
> This function is obsolete. Open code this.=0A=
=0A=
And that also mean that you could remove one argument to bio_new(): combine=
 op=0A=
and op_flags into "unsigned int opf"=0A=
=0A=
> =0A=
>> +=0A=
>> +	return bio;=0A=
>> +}=0A=
>>  =0A=
>>  #endif /* __LINUX_BIO_H */=0A=
>>=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
