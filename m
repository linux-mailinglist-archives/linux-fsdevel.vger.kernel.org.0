Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEFB26D48A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 09:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgIQHV2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 03:21:28 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38068 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgIQHVY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:21:24 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 03:21:21 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600327284; x=1631863284;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1gST2pzSftrK7866Q2LBBzqt+dSIgIdd0hu5f0H4eoo=;
  b=IijTt4k2ckwkvh9wgtkx13G821XeFUNnnqmqd1pyukSqbkSd6oR5EPnY
   BtdSwB54hN01DJOuKFVTbwfONzHvZIsakrGDx//NkJ0qQJ1Y5f2LM/LIR
   cekRD1HUVJ0JjEhPYwtF2PterBkzDuAEgNvmlp6nk+tj9Nl/Y+JYchQik
   UUCgJ+XYT8D5X9CmMRZWBRxjdfsB8UybgCQs3rXTvUiRIK9Bw68X5I2AW
   4wu/ReghEL30nBrg8lGIwZxjVY+NTbSIaBNkbBWy6OFZEfGAKr/JEfNpd
   ni481ZTnpuz5sgFQ2BPdTUmOw4J7xqqHl4XOcH0GlNl9OH44FgO8xY/UB
   g==;
IronPort-SDR: FovTyvHwjqG920dJfKFoC1t1blNqA2BG6gi58BLaZvftVuzCmw4v0GQe9tVRpeU90fWKEId7mA
 0g9wRiKIswTh0hgpVp+R2G8DYametKiBQNdO/eEXfSIuDCBOxHG44iO8Sjaulh1Zykj/7JUbDm
 /MxI4W1U09O1NdnNNEnymcTYIdVQKOmNYWmhjow880Amy+WF14BhXv5/YuwzJFNoBt9M69I5xn
 Hk4uOCb60douXw5ZZSxBj++PBpFg6sM2dqJXT11GZUaiNM8XBS4q92AYsVDZGEroSm9OkgfZQe
 g5U=
X-IronPort-AV: E=Sophos;i="5.76,436,1592841600"; 
   d="scan'208";a="147612149"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
  by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2020 15:14:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhTQzyRnj1EaEhIus87TOU2lqDtAhaY0IMG/MMvzAAmNOqG4ehZ3cfXnWS9KAo+fxgH57C/9h0DLxfeSJeK4cZkNm11ZRz0a7beyOgCphTtKUOzEy9rQnUjYavw4ZKuBQ4WjYqHaJCTugma9EPnagAytYFQoVycgVA53Jdzr8sZG9upWFDsPwJpCrtj1jgswoco/sNrVj4H0H111D7S/U1KHPPG6/sr34sYX6dsuvLbiAnZhRFU7ZLFyFA+wElVLrQemnrMoo1/47VoushLUgMU/P8RYtPouyJgxMlL78KiHu8Vmz5wnPJWwgwcc4Lszud08yL3EWngrakvi/0mVtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHUK8ZTPyHBpvI9o0uEL3T3xPFuSMWkqYLdoVt3GxuY=;
 b=WHGIUrLzwLLS7wEq6hqkVWhNsQTpgKfy3Mq9PrL3NTwYi0AJ0XWzDvoBlCKNIryFzZ2zwR1QcHCDTKH5KUBGzRcmTgnlWPfXG3ul8pyvPcwF0dX14LHA3VfSgR2U1+gU9sWIhi6PBJy2VYRNqJLGEPmk7AkotO7zwUr18fexHmS+/Dqb2SKn9IY7QWhR0Yl2afKduHcgtIG28LlSuZ1ReSo6wlG0ZhDyt9ehIeeuizkrJ15oP6pVPWnlS/QIo5pfZUShlv7iv4rMYMwPHkAdl7aqBZLljdCp9bfS8HDx68qPc+F5q7Pr7kim3II1RoM2PJ9VOgBSt0p8eh3MR8tLsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHUK8ZTPyHBpvI9o0uEL3T3xPFuSMWkqYLdoVt3GxuY=;
 b=mI5UeWg9BfrEAgdISOKMwyireodvpyRxcQP3Fut8N3DRJpNFZiEx8iGe/rT0VPAfQ99ZHiNgyLB9o22mPrsTJrdDNl0jDFoyJS1enr6XHSaOPuT/rgaaIRIaC7BObnwDO7jl7uK2EQTp4RHnS6GLWcuOMqoDzSF/2sZo8bWNuac=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5405.namprd04.prod.outlook.com
 (2603:10b6:805:103::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 17 Sep
 2020 07:14:05 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 07:14:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v7 00/39] btrfs: zoned block device support
Thread-Topic: [PATCH v7 00/39] btrfs: zoned block device support
Thread-Index: AQHWiGNae5boCJrRrkuIphWp+J5npw==
Date:   Thu, 17 Sep 2020 07:14:05 +0000
Message-ID: <SN4PR0401MB3598C5D858920149B4BA13249B3E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
 <20200915080927.GF1791@twin.jikos.cz>
 <SN4PR0401MB359839054A125BF64641B4E89B210@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200917054033.homtvyj3iffrjile@naota.dhcp.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:fc97:afa7:f5ee:f696]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c800c78-c1b1-4292-46fb-08d85ad94329
x-ms-traffictypediagnostic: SN6PR04MB5405:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB54056D40B559FD27A3504BD99B3E0@SN6PR04MB5405.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oaCLMiyZruArIxsCZSvMj2CAP7oFaMXiVzcpqTxClH8IG3+oAEDrkC/A/o8zVoI9T4dncy/wWDJi+3so44QsOpu5g83wpUhXIBVMXGkKol2Olq7DciYDTS6ky5TkI1zSI+1FjkDEJ2jeOIiWhvrnQr0goQxLBY+1jluJQ4uNifsjmRzsuB6hEo3CVc7O1NpUYjt8PngP1iP8diF4xIXt0iNN+0NYZOeFgzQdK+pyD5PIz19NwRZuiKAEbrzT4DokrzLv22jCh6ZgCXgZtzdruVSidOkYgZq0rG1sEGaSDSyJY0I9HwxdFz+kfqpbp4KKmCjlJ2q0un/+pYo+H5HIew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(54906003)(53546011)(6506007)(478600001)(186003)(316002)(71200400001)(5660300002)(52536014)(55016002)(9686003)(33656002)(6862004)(2906002)(6636002)(4326008)(8676002)(66556008)(66476007)(66446008)(64756008)(86362001)(76116006)(83380400001)(8936002)(7696005)(66946007)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: oTau2kww1h78Vvn+USleRiiVxHZbs5yWKsJzbm8H3LKAtm3fmhRWICVLIHG4KbQK6KzjLNXQgWKnU0hhZ9GhriEVQqxqR5I8lHKd1kKQAv+LmmYRiYZl9JKWBiDl3TUrzTiO8hDOrYwTMlLRxI640dwcX/UZCz63W35Ck0hHf6qDmae+j/jRJKEMy5TSgZWCx0NpFWlHKfqVxRDJwAZSWP6FyI894b+zZ4xV5wWGqqtg//8nXDL9nLl2btKgOeLUxUk2AGnfmHfwGbexibgP59jqesPyWGk9uIUSttE1t5sA+UF1XD/Qj+8O5SUDiyTlQ22YZafHNhxKuI8m07NMEG8mKUZCeleQ1sNh+5TwkLEPOMAK5l4IpK4B5+8UjuiXY7ZyIHFAjtCerfpAAxS/VhnheIPEsVUTXwCMqges1kGrfEx4JVEdldX0jzWQEz8YLlhmwkF8S4oBbfNB+4bfLRpaR+IyyJWDUpICftyt2Ry2OKy74cFV1uBaU2LZxErOX//6mdSaJ3B0MPhJP9JeysDTYlQ6+3I3eKDtgJTW0ED5wSCiuTZmYVVHazE5VGJDfgX+5iJrSM9zkPI2fR7s9qbzGYVZGNjHs1Khwxnlb4470HW2qQCmrE5239sughTET6nlaP6bS9jJ0i16GUvfy5Y+1XpDGXWokOeLNxM1hB2tDDlDsa3CTsNeJrW64VTiqJnK7tJjY+37jXvekUp21w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c800c78-c1b1-4292-46fb-08d85ad94329
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 07:14:05.2317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /j8X8ya3WQP288z7kouZt1DajNFBqiZlIvnGgyLNLj6s2gnfcQeWoDWSPjQO8caojbAf/VKek139S06Oj7J/JWjzl0EfFyEOD7t8zRdc36g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5405
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17/09/2020 07:40, Naohiro Aota wrote:=0A=
> Thank you for fixing this.=0A=
=0A=
Well it was you who had the idea, I just sent it.=0A=
=0A=
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c=0A=
>> index bda4e02b5eab..311956697682 100644=0A=
>> --- a/fs/btrfs/extent_io.c=0A=
>> +++ b/fs/btrfs/extent_io.c=0A=
>> @@ -2753,10 +2753,6 @@ static void end_bio_extent_writepage(struct bio *=
bio)=0A=
>>        u64 end;=0A=
>>        struct bvec_iter_all iter_all;=0A=
>>=0A=
>> -       btrfs_record_physical_zoned(bio_iovec(bio).bv_page->mapping->hos=
t,=0A=
>> -                                   page_offset(bio_iovec(bio).bv_page) =
+ bio_iovec(bio).bv_offset,=0A=
>> -                                   bio);=0A=
>> -=0A=
>>        ASSERT(!bio_flagged(bio, BIO_CLONED));=0A=
>>        bio_for_each_segment_all(bvec, bio, iter_all) {=0A=
>>                struct page *page =3D bvec->bv_page;=0A=
>> @@ -2782,6 +2778,7 @@ static void end_bio_extent_writepage(struct bio *b=
io)=0A=
>>                start =3D page_offset(page);=0A=
>>                end =3D start + bvec->bv_offset + bvec->bv_len - 1;=0A=
>>=0A=
>> +               btrfs_record_physical_zoned(inode, start, bio);=0A=
> We need to record the physical address only once per an ordered extent.=
=0A=
> So, this should be like:=0A=
> =0A=
=0A=
Right, this would save us a lot of unneeded function calls for the non-zone=
d=0A=
version of btrfs as well.=0A=
=0A=
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c=0A=
> index c21d1dbe314e..0bbe6e52ea0d 100644=0A=
> --- a/fs/btrfs/extent_io.c=0A=
> +++ b/fs/btrfs/extent_io.c=0A=
> @@ -2748,6 +2748,7 @@ static void end_bio_extent_writepage(struct bio *bi=
o)=0A=
>          u64 start;=0A=
>          u64 end;=0A=
>          struct bvec_iter_all iter_all;=0A=
> +       bool first_bvec =3D true;=0A=
> =0A=
>          ASSERT(!bio_flagged(bio, BIO_CLONED));=0A=
>          bio_for_each_segment_all(bvec, bio, iter_all) {=0A=
> @@ -2774,6 +2775,11 @@ static void end_bio_extent_writepage(struct bio *b=
io)=0A=
>                  start =3D page_offset(page);=0A=
>                  end =3D start + bvec->bv_offset + bvec->bv_len - 1;=0A=
> =0A=
> +               if (first_bvec) {=0A=
> +                       btrfs_record_physical_zoned(inode, start, bio);=
=0A=
> +                       first_bvec =3D false;=0A=
> +               }=0A=
> +=0A=
>                  end_extent_writepage(page, error, start, end);=0A=
>                  end_page_writeback(page);=0A=
>          }=0A=
> =0A=
> =0A=
>>                end_extent_writepage(page, error, start, end);=0A=
>>                end_page_writeback(page);=0A=
>>        }=0A=
>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c=0A=
>> index 576f8e333f16..6fdb21029ea9 100644=0A=
>> --- a/fs/btrfs/zoned.c=0A=
>> +++ b/fs/btrfs/zoned.c=0A=
>> @@ -1086,8 +1086,7 @@ void btrfs_record_physical_zoned(struct inode *ino=
de, u64 file_offset,=0A=
>> {=0A=
>>        struct btrfs_ordered_extent *ordered;=0A=
>>        struct bio_vec bvec =3D bio_iovec(bio);=0A=
>> -       u64 physical =3D ((u64)bio->bi_iter.bi_sector << SECTOR_SHIFT) +=
=0A=
>> -               bvec.bv_offset;=0A=
>> +       u64 physical =3D (u64)bio->bi_iter.bi_sector << SECTOR_SHIFT;=0A=
>>=0A=
>>        if (bio_op(bio) !=3D REQ_OP_ZONE_APPEND)=0A=
>>                return;=0A=
>>=0A=
=0A=
