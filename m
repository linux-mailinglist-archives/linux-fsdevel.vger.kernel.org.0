Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C2E26C96F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 21:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgIPTJ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 15:09:28 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:33487 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbgIPRo1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600278285; x=1631814285;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=H0W0ii2feKN2C2y4j783iMLW+nZWA/dZX6ZQ/SpWLow=;
  b=TWYb4Lhe6bnnn+TZK4CqxQ6/wNYFq6gyAn9BrRhi5gtRWqnjMdjDBjED
   JU8A/AAl2FWXtQ+NtND3cUKfcCAeWDaFRMUdZW2MFFLakrjOSHAp7t/Mj
   enOoAgXjHNSAfE3BoRMU2zICsg0wJkaLCARFze5ehxCZN1bptabuBvk6s
   /hGECiYMD1IgIBh4r4SuDXNB3tdzTRVDqMeIpgYR12HZhMVKyqvpHeH1F
   G3PlvlGWqvv/JLIhFjScbCTknfdswXj862b9n5lsxyYZsikR86UGx11MG
   EZAcYVywjX58pIf05Qy9YMFoScOn7cQMwuK3LoGOYLLIEtxK5KpA5iWBa
   Q==;
IronPort-SDR: zQlLNyWBMIw7wX7/rKnuAKX8jkNxLoBEfU+YYNnxLyROvym5vQKZsGdN5dWHMBWnIzz1+VpCEE
 QHozAcftdniuv5pFJLL+TlP7OF6Z+dK+Q6evr0aurSdrT4A8bSUf4hFUn4EWDmHOlp4Ffz6L8Z
 tsLrLoNxM2VfdS8SJ/D7VyHffeUM0O2VlZ4hHxVaQaI0iBXb2iXu2Y0cZBGqDG4VhwxTmK6wb1
 mZoUKOwkKJPmGqQS7jc+zQvlyV1ZfSDlBM8jAuRbWoWbE0jWz/s8SvkRTWAsYDPqUJGknZsXw3
 63s=
X-IronPort-AV: E=Sophos;i="5.76,433,1592841600"; 
   d="scan'208";a="250879023"
Received: from mail-bn3nam04lp2057.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.57])
  by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2020 01:43:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HViobU1krw2YrKpalgVAkEENCia8AyARBbzyff4YzjkaWnp8HkSBRyKjJSCyWMkI39SEyN87RE/6eKmP0JhvMxMh7ribGU/qTFCFUNjsnec4FiIzg8I2Ay51Qg60xpQowckVaUsK3JHgXKwHoj109F0L65AnewzkudT1n2UAwOlkhvd686EUh923cIHmJwNBxn6MwqtqI4XoSK0jUcDSOcQ+hbRuUItGuoRBd/PKSlG0uw5lAvQDg0jVeyzND67jU233bzMhp3WTlmrocVa32NWjY6obmeCkkgQmU1tH4CywYhX9mJgMtQ9YTJ/DNTEXpapXxjtg2LvQ2H/LbC5Gcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kkBrrA9VCZyjECobqjG2co7ErYIBbU9BjYfuptoinA=;
 b=VZVUaAPjkRyrz445k0bsCoCESa1K+s89ArZzmZleIcbC++Kc2k2LBfzWacWHu2nRGiuNtJt/2+s1gju0ZaN/3DnRwcWQbsvJPNV5LsiOlIJk+6D1sY+oby/1OfI7oh15/PyWgVRHGJR+lvrU7QMh4C2krSX6OJNSd49I4mH/XAj6dH14cUh1tt+svAQA3dOxObsaNYmBWuaHIXHnmWJmyT38TY5F4DQUiya19/IrMF5YkSgB4hB63KVThd5PrOz7dEKn9j5xs6Gq1TD1ccS7K33SR/7xoMDHGSd6OriphWySHTX40QtGrJCkXlROATic6UnYncSI1hoJaJoZhJp97A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kkBrrA9VCZyjECobqjG2co7ErYIBbU9BjYfuptoinA=;
 b=QUlPW4KOAArpQV0gBKvqGOgsWDe+ZM/kMvxSwyIWaTa2pQ8n8+Q30mZRQLEeEmDxTMpyFtOJPgUPmUVjY290oTZ8VHqnMi+Qe7Pq2miHgc4ljcexp3yqyW3Hx/nnEkus5UwJ/R4wGfrn7uIWkVrZIm259m/yfKuip5oszRCsotM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4928.namprd04.prod.outlook.com
 (2603:10b6:805:9d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 16 Sep
 2020 17:42:50 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 17:42:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v7 00/39] btrfs: zoned block device support
Thread-Topic: [PATCH v7 00/39] btrfs: zoned block device support
Thread-Index: AQHWiGNae5boCJrRrkuIphWp+J5npw==
Date:   Wed, 16 Sep 2020 17:42:50 +0000
Message-ID: <SN4PR0401MB359839054A125BF64641B4E89B210@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
 <20200915080927.GF1791@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:38cf:f1ce:e1ec:d261]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d80fd632-7b90-47c1-cd19-08d85a67ee7d
x-ms-traffictypediagnostic: SN6PR04MB4928:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB492898C90C78509478AA75C69B210@SN6PR04MB4928.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GQ6bYSdzSOSpHzTjHu1cxSg08hH2XMiQj0EG15bKudWbeoagvEVpGMfIQ4/rAuM9KD/LHPPTxdn8OW5TBCXDZkfK8X3Qp5kACbnjLQ+8d0e9E3BE/uL4InOTYdLfFFwEVkWQzc/MkkrcErclm2z1JuDQJVsPTulbHWKhcUVXx9Nuq36QplMMiqVWzAt4g+b9W0PQyD+DmzWzhHzTIp9HVNTGwWbnYDOZlS1o7sbI6IbpPXVqVt+6XZ9BthwVb+7M74F21Ks1ih5pF7m8t/DIP/ZTwYZEzjjHqvouAUgzL2BQHdk5FO0n+Aka7ugzvj2ei2ybU9HRQaPlDF4MnyJtww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(54906003)(8936002)(316002)(86362001)(6636002)(33656002)(8676002)(83380400001)(7696005)(186003)(52536014)(55016002)(2906002)(91956017)(76116006)(9686003)(5660300002)(66946007)(110136005)(64756008)(6506007)(66446008)(4326008)(478600001)(71200400001)(66476007)(53546011)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CHP387MSQpLcWciERUul8g9kEDKyv41DVLTNJsxjVuPj8LxZJx97NPPrWfdNUWCGKA90Q16qcJWjo7lUA1nA8forZvuToIlnQ5R1aRAaTV5mOnXWNNBUGV5M3SX1auGaqU/tnqNQ7gFoxwgro+ISgqSQ2ecz19xoPScKugO66QYVjh49JAMVF9oR80pFLVF4QwVG4yg599GYl9uuA9IGm8SBMfD1rZqvX/dZSekbIf+Z6W9Oc02RxS5LhSQPLDeNepvdaxCnhwWFCThkitE820xBE3nJuvgs2I9YqkEw1M/X6oBDzSF5pHHCADDFVbqsV/YF43x/HVOhfm+wcd//StNvo+THKDeLc1fcs6PZUS62kaVnmKyVWNd9lIoCycaVXYmZAKQHwTqtgfohubx8fJeWu/YOkGfAw+kWYVGXAoDKxlhCKSIf3LpAv5s3rwSD/h8/f5fOxLGyKIOpULGSZHJOVYQqaIdl0rVAURoa2sZmi/ieCyKpxX/LZRtsDjZWmVuFdFz6KQRnBL2Khk2tkDkK35I3BEpZVtystWx8uXyINzjLu9PWvkhnMY+XFg/Qar5cu8Lt40vPOhKZHnf4hlaRywmmhInawXjEc4jUb8twRnwu5OXfJ31oEtQ7GyOTvIw0L22wSDU2wIDHLI5zapmG0lzoQBR0RycqLwUqZ8qRXzthy/N1Bu4nZ7kZcWgjqJrLGzWNCy4q9oJhOAQD7Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d80fd632-7b90-47c1-cd19-08d85a67ee7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 17:42:50.1139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A/s/GHUvqbi4gOGraHNzE3CKJVubYmuvFjLJlGYM/jz0yClwyaR2T2EuBHnE62c2jIrnBlMQLWTiUErR8bjUczg6PQa5vH8tngnoQylbI8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4928
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15/09/2020 10:25, David Sterba wrote:=0A=
> On Fri, Sep 11, 2020 at 09:32:20PM +0900, Naohiro Aota wrote:=0A=
>> Changelog=0A=
>> v6:=0A=
>>  - Use bitmap helpers (Johannes)=0A=
>>  - Code cleanup (Johannes)=0A=
>>  - Rebased on kdave/for-5.5=0A=
>>  - Enable the tree-log feature.=0A=
>>  - Treat conventional zones as sequential zones, so we can now allow=0A=
>>    mixed allocation of conventional zone and sequential write required=
=0A=
>>    zone to construct a block group.=0A=
>>  - Implement log-structured superblock=0A=
>>    - No need for one conventional zone at the beginning of a device.=0A=
>>  - Fix deadlock of direct IO writing=0A=
>>  - Fix building with !CONFIG_BLK_DEV_ZONED (Johannes)=0A=
>>  - Fix leak of zone_info (Johannes)=0A=
> =0A=
> I did a quick check to see if the patchset passes the default VM tests=0A=
> and there's use after free short after the fstests start. No zoned=0A=
> devices or such. I had to fix some conflicts when rebasing on misc-next=
=0A=
> but I tried to base it on the last iomap-dio patch ("btrfs: switch to=0A=
> iomap for direct IO"), same result so it's something in the zoned=0A=
> patches.=0A=
> =0A=
> The reported pointer 0x6b6b6b6b6d1918eb contains the use-after-free=0A=
> poison (0x6b) (CONFIG_PAGE_POISONING=3Dy).=0A=
> =0A=
> MKFS_OPTIONS  -- -f -K --csum xxhash /dev/vdb=0A=
> MOUNT_OPTIONS -- -o discard /dev/vdb /tmp/scratch=0A=
=0A=
Hi David,=0A=
=0A=
Can you check if this on top of the series fixes the issue? According=0A=
to Keith we can't call bio_iovec() from endio() as the iterator is already=
=0A=
advanced (see req_bio_endio()).=0A=
=0A=
=0A=
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c=0A=
index bda4e02b5eab..311956697682 100644=0A=
--- a/fs/btrfs/extent_io.c=0A=
+++ b/fs/btrfs/extent_io.c=0A=
@@ -2753,10 +2753,6 @@ static void end_bio_extent_writepage(struct bio *bio=
)=0A=
        u64 end;=0A=
        struct bvec_iter_all iter_all;=0A=
 =0A=
-       btrfs_record_physical_zoned(bio_iovec(bio).bv_page->mapping->host,=
=0A=
-                                   page_offset(bio_iovec(bio).bv_page) + b=
io_iovec(bio).bv_offset,=0A=
-                                   bio);=0A=
-=0A=
        ASSERT(!bio_flagged(bio, BIO_CLONED));=0A=
        bio_for_each_segment_all(bvec, bio, iter_all) {=0A=
                struct page *page =3D bvec->bv_page;=0A=
@@ -2782,6 +2778,7 @@ static void end_bio_extent_writepage(struct bio *bio)=
=0A=
                start =3D page_offset(page);=0A=
                end =3D start + bvec->bv_offset + bvec->bv_len - 1;=0A=
 =0A=
+               btrfs_record_physical_zoned(inode, start, bio);=0A=
                end_extent_writepage(page, error, start, end);=0A=
                end_page_writeback(page);=0A=
        }=0A=
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c=0A=
index 576f8e333f16..6fdb21029ea9 100644=0A=
--- a/fs/btrfs/zoned.c=0A=
+++ b/fs/btrfs/zoned.c=0A=
@@ -1086,8 +1086,7 @@ void btrfs_record_physical_zoned(struct inode *inode,=
 u64 file_offset,=0A=
 {=0A=
        struct btrfs_ordered_extent *ordered;=0A=
        struct bio_vec bvec =3D bio_iovec(bio);=0A=
-       u64 physical =3D ((u64)bio->bi_iter.bi_sector << SECTOR_SHIFT) +=0A=
-               bvec.bv_offset;=0A=
+       u64 physical =3D (u64)bio->bi_iter.bi_sector << SECTOR_SHIFT;=0A=
 =0A=
        if (bio_op(bio) !=3D REQ_OP_ZONE_APPEND)=0A=
                return;=0A=
