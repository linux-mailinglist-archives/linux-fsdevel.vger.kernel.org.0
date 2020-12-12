Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F0F2D85D4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 11:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438599AbgLLKXT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Dec 2020 05:23:19 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59955 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgLLKXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Dec 2020 05:23:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607768598; x=1639304598;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=9FzKq1yVTKHHzHkY1W7hraTn0XXT6UluJWOCsB8INLQ=;
  b=IxrNfsXnKOsnnHcM3GgRcDx92jKvgZLsfb8UtaHtQGYFLkVXnU+rnIkh
   oohYV5w/vs8qNZioAUbrTAYzih/4pueeCRrhoJaplyk5i22806FBQ1EaK
   TpaLNFkIkN9aHO+w1GYVDXogZMUwnl2857CjrMwXZCnMgSeg8WmWJtMUN
   UyTpCz2yEQLRsjAYATPf+jsT6fTnCbZxbnEuXxMstPkydgfFPaPSt99sG
   hg0NWJfxTyCLt/nuDy0fRFv2FBhV7lXGXW3nwMYeVBb2v1v8RYU7EcJJj
   E5nj3fvlPK1b5vBnApLwq3w9ZzP5Ge3I8M5480AQoGvvfXdkabIkKRcdB
   g==;
IronPort-SDR: X+8i22Fn45E7Knuz+WUaI9dUBiiM4Mtu2Voe8PTVdESBTcBLJJU7JuqWQjCY1xLwiws1A87YcW
 H8jpFJvguGGpd/GsHhfVzfyC6Du6VVzWG/8xQjGoeS2Fa5F26a25mPozUL2jfblHKPcuOIvFaA
 agE+9cSB7JYLDJVue2z6lsC2NCFY06037QUJ+uNb3RwZC6+KKBLLESU88tEcE9QuEGdRtoVQ6i
 H9Lc5dI8OIZm5pHy60qWSnM0SV3KWhK+KZcGOZeIfCD1qRl4BKhzqLVLlsAPCZxhLoMS7xMD9e
 f0A=
X-IronPort-AV: E=Sophos;i="5.78,414,1599494400"; 
   d="scan'208";a="154983581"
Received: from mail-bn8nam08lp2048.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.48])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2020 18:22:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUO3HSugwD4M3DZHjkbiIxzxZsU7u6iiTPgqxgNY/d6vQEzaikfitfuSynuKbprBbRSb4Mz/KGFZn1YgEJ6PcoOVBB+AYHHts3kabADBIl+teRlqP1x3XUh+gh18NIROi6akIuC3PRtN0sYeJuuaQTJY08P9CbnP2VqFLiHZ3IJ1LAcFmzpA+VKn6UWJknOR2Xr76Ys/C6/hevONGIXKbCbODKe8onLLjw4qgkjVJfE4K0g1wHAFXrBvAIPkwQ4D/IiM2Mg3EmEXYkgNRjpq36pqfaf+gSWcf8xUsKDb3sadM8j1u4GKQHzn1GlWhSY7OoRKomNeo3FpIxAsZ/QiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4s4jg3azI0DENPQM2fueDctxkWqTAiQNxN4IrQC7mw=;
 b=b/sFTg55itnKO8fRC0T3mbLjsZgSpKA6TPiUwp+8XGqWbo0+G/WY4jOgo6BnIbRxGfjvL6gNh/W5bpi1xF1eseDQOkbDVz+vwVD6PmnvtIm4+2os4witb8YGmK0NUqnt8W8OK1UWAooeIMKy8AZPI1MTtIG8JZU4Jkt6mWzc9sAIGU/lFd/LRVtrDqcnwPGXZhSr/fazcIeoWL7uNHafMpZFSDttLdLd3R9AUEKhe1zeXTt9wjG1JA8qzq64OGNcOvzNlYrtYtgiXOuJFPVfIeN9vJz59TPT4YI7Zx1h7d6qSjSOnTApu+vnXK+R5v6MOfcn1rkG5J7eZyVzRVF2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4s4jg3azI0DENPQM2fueDctxkWqTAiQNxN4IrQC7mw=;
 b=XQQZwNelV6xniVg2a85WHW7pUj0pg/hxqEkD5PjbLyWBpbh/cJ1U076FPFaz6ndlyNdEJEj9WAusyDpFK07D6KBHFjA3R6EYVa9zBYgP+9ZPi6lFbYs7qPvT/VjG1mRtAKfgbZHGRa/5k6s6PTgAXqlRpc3PpiNsGWrBh9TJGQw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA0PR04MB7386.namprd04.prod.outlook.com
 (2603:10b6:806:e4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Sat, 12 Dec
 2020 10:22:09 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%6]) with mapi id 15.20.3589.038; Sat, 12 Dec 2020
 10:22:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v10 02/41] iomap: support REQ_OP_ZONE_APPEND
Thread-Topic: [PATCH v10 02/41] iomap: support REQ_OP_ZONE_APPEND
Thread-Index: AQHWt1Sb3HZRbzGDlk6Pnuh0g860vw==
Date:   Sat, 12 Dec 2020 10:22:08 +0000
Message-ID: <SN4PR0401MB359887F3500438D05F55C4D59BC90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <72734501cc1d9e08117c215ed60f7b38e3665f14.1605007036.git.naohiro.aota@wdc.com>
 <20201209093138.GA3970@infradead.org>
 <SN4PR0401MB3598A4DA5A6E8F67DFB070859BCC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201209101030.GA14302@infradead.org>
 <SN4PR0401MB35980273F346A1B2685D1D0F9BCC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <SN4PR0401MB35987F45DC6237FC6680CCB49BCC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <SN4PR0401MB35982E109738ABE8A093315C9BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <BYAPR04MB496530C502E8EF5A2B538A4286CA0@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f469e060-82f7-47c0-337e-08d89e87c810
x-ms-traffictypediagnostic: SA0PR04MB7386:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR04MB7386F77E1796E4CFBAA237DF9BC90@SA0PR04MB7386.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l3HxmcrLgyMcHsJ9Lyru5LvYv14YefYLu4O218AIQcQ6xOzjCSFHSqRmT8vibMG0/CURGPEClydFzJbBDIBUcheUqK9U9N/Q+MpUVO9LD2c3qSQp2zAxTVtum5/dxv1UiOwTj1l+ypPNCsBSvq0lem9Q8xMFnoAx5ifGacVONaFdi6c43kfrMl78aJj471mxOwGgrPbl6c6ZqcgLmk93WgApAe4Lbbil+RCkjx8WSrn/Rh1GaX0Xhisfv4mClvcDPw7r955dMRqiPZ/tXufOFdkaXhbCgwLHZlW+eTJaVKfy/4ldUP8fzSoNtxNnriKO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(76116006)(64756008)(66556008)(66946007)(5660300002)(33656002)(26005)(66446008)(91956017)(52536014)(55016002)(66476007)(186003)(9686003)(71200400001)(508600001)(53546011)(6506007)(8676002)(86362001)(8936002)(83380400001)(4326008)(2906002)(110136005)(54906003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yfPS1gCT2VLfyqO8kqUdnJ4R2rJ2UgzLiLi+HDXvyaAj+sDZuQV/kvJmuqeQ?=
 =?us-ascii?Q?0r5QfsBzInPXjRZPhCM5AuKnUS4uy4kwSc+j570LR8u6yjplcMUIOOBowPsh?=
 =?us-ascii?Q?b42Vur+xvDtWLC+JmZ08WfFLLe97sbjCFFggU6uNrU0jJkf+xt/O9lj5dV5M?=
 =?us-ascii?Q?6P+/HODPR3mO5xfbuUgx3Dw63makn3Hq3L1F9UDae6PouVO0Fi77fKN0vbGr?=
 =?us-ascii?Q?0F9nayHZszfGfmODN8FSbs42rQ17F7sdPuHrExVctQr3bp9Ngw5D5093Kfnc?=
 =?us-ascii?Q?wG30rwjpb7y9BKnX+x9bEi2GXIIb4VcWN8xaDfo3VngcxyKncNn3TRN0ntzl?=
 =?us-ascii?Q?3cPGC1ydAkf6NEW8PfNXmPsOgmGEeKc6ov5uAySmBe8YAsyU+lZ+YUEJ0qS/?=
 =?us-ascii?Q?OB+ACMwK+Zoz0e4CVfOXfzkBLzEMWwiE/0k7owjFk42EPHu07H+EsHk7Fk+O?=
 =?us-ascii?Q?47VBD4VpXUV6Dn6aB5wClR1+AVt7/wn0MB3mDqhPmuq65pzVjdRH7UigLZtm?=
 =?us-ascii?Q?9w32z3H7FgNLsANxY23ITl4Iz1z+3vGTOLSY7fHKRMrkghJKJSwzBYn7eLQ7?=
 =?us-ascii?Q?tR19yTrXVwtjUsy7wuCxgjG0jofiB9tYvo1+8ORMUvyyRcE27s7/EzgAmAMb?=
 =?us-ascii?Q?2QyCSGBKya4VAGgiViv/4RJHgowTCr/O6sIougE5TrGYo6vKZoNQ/I/WFV0q?=
 =?us-ascii?Q?lbNG8vSrvMLvVuuhwRMQ+F1UhIzvhYkn1Je3ei8sDuHWaMoVVdOSkfwtAnRx?=
 =?us-ascii?Q?EjVEk2QN4onmXuJfck5whw3QQ39eq0eCah30+S+HO968DbZkhGb0Mkpz8E+s?=
 =?us-ascii?Q?S8l274fzVnbu8adiCBwleToH8OSFXmjQ4Nz0W4VeI0wyPdpBzEOq54toupIS?=
 =?us-ascii?Q?S5E0L9tr8+54h0qKcEv2Id80ZHRNvbcHJEPKWuPGnZNW1+IKJrlLA5XiFSMv?=
 =?us-ascii?Q?gdhqT44XcdCHK1cAg4FRlsxRkzlErwVYQC5UHXzsuea5NLvY/MlwJM8SJd3m?=
 =?us-ascii?Q?wrko?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f469e060-82f7-47c0-337e-08d89e87c810
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2020 10:22:08.5534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Fj/88lq+NVS5R4yS47rU+6+57yerwyiyc1WWrEN80g70kZJnyNZYDO/aEhvZ4RzMVzxN16XrOt51ocMwhaALJPcbpYjZ1cSuNlgQSSdkp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7386
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/12/2020 22:24, Chaitanya Kulkarni wrote:=0A=
> Johhanes/Christoph,=0A=
> =0A=
> On 12/10/20 23:30, Johannes Thumshirn wrote:=0A=
>> On 09/12/2020 14:41, Johannes Thumshirn wrote:=0A=
>>> On 09/12/2020 11:18, Johannes Thumshirn wrote:=0A=
>>>> On 09/12/2020 11:10, hch@infradead.org wrote:=0A=
>>>>> On Wed, Dec 09, 2020 at 10:08:53AM +0000, Johannes Thumshirn wrote:=
=0A=
>>>>>> On 09/12/2020 10:34, Christoph Hellwig wrote:=0A=
>>>>>>> Btw, another thing I noticed:=0A=
>>>>>>>=0A=
>>>>>>> when using io_uring to submit a write to btrfs that ends up using Z=
one=0A=
>>>>>>> Append we'll hit the=0A=
>>>>>>>=0A=
>>>>>>> 	if (WARN_ON_ONCE(is_bvec))=0A=
>>>>>>> 		return -EINVAL;=0A=
>>>>>>>=0A=
>>>>>>> case in bio_iov_iter_get_pages with the changes in this series.=0A=
>>>>>> Yes this warning is totally bogus. It was in there from the beginnin=
g of the=0A=
>>>>>> zone-append series and I have no idea why I didn't kill it.=0A=
>>>>>>=0A=
>>>>>> IIRC Chaitanya had a patch in his nvmet zoned series removing it.=0A=
> =0A=
> Even though that patch is not needed I've tested that with the NVMeOF=0A=
> backend to build bios from bvecs with bio_iov_iter_get_pages(), I can sti=
ll=0A=
> send that patch, please confirm.=0A=
>=0A=
=0A=
I have the following locally, but I fail to call it in my tests:=0A=
=0A=
commit ea93c91a70204a23ebf9e22b19fbf8add644e12e=0A=
Author: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
Date:   Wed Dec 9 23:26:38 2020 +0900=0A=
=0A=
    block: provide __bio_iov_bvec_add_append_pages=0A=
    =0A=
    Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
diff --git a/block/bio.c b/block/bio.c=0A=
index 5c6982902330..dc8178ca796f 100644=0A=
--- a/block/bio.c=0A=
+++ b/block/bio.c=0A=
@@ -992,6 +992,31 @@ void bio_release_pages(struct bio *bio, bool mark_dirt=
y)=0A=
 }=0A=
 EXPORT_SYMBOL_GPL(bio_release_pages);=0A=
 =0A=
+static int __bio_iov_bvec_add_append_pages(struct bio *bio,=0A=
+                                          struct iov_iter *iter)=0A=
+{=0A=
+       const struct bio_vec *bv =3D iter->bvec;=0A=
+       struct request_queue *q =3D bio->bi_disk->queue;=0A=
+       unsigned int max_append_sectors =3D queue_max_zone_append_sectors(q=
);=0A=
+       unsigned int len;=0A=
+       size_t size;=0A=
+=0A=
+       if (WARN_ON_ONCE(!max_append_sectors))=0A=
+               return -EINVAL;=0A=
+=0A=
+       if (WARN_ON_ONCE(iter->iov_offset > bv->bv_len))=0A=
+               return -EINVAL;=0A=
+=0A=
+       len =3D min_t(size_t, bv->bv_len - iter->iov_offset, iter->count);=
=0A=
+       size =3D bio_add_hw_page(q, bio, bv->bv_page, len,=0A=
+                              bv->bv_offset + iter->iov_offset,=0A=
+                              max_append_sectors, false);=0A=
+       if (unlikely(size !=3D len))=0A=
+               return -EINVAL;=0A=
+       iov_iter_advance(iter, size);=0A=
+       return 0;=0A=
+}=0A=
+=0A=
 static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter=
)=0A=
 {=0A=
        const struct bio_vec *bv =3D iter->bvec;=0A=
@@ -1142,9 +1167,10 @@ int bio_iov_iter_get_pages(struct bio *bio, struct i=
ov_iter *iter)=0A=
 =0A=
        do {=0A=
                if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {=0A=
-                       if (WARN_ON_ONCE(is_bvec))=0A=
-                               return -EINVAL;=0A=
-                       ret =3D __bio_iov_append_get_pages(bio, iter);=0A=
+                       if (is_bvec)=0A=
+                               ret =3D __bio_iov_bvec_add_append_pages(bio=
, iter);=0A=
+                       else=0A=
+                               ret =3D __bio_iov_append_get_pages(bio, ite=
r);=0A=
                } else {=0A=
                        if (is_bvec)=0A=
                                ret =3D __bio_iov_bvec_add_pages(bio, iter)=
;=0A=
=0A=
=0A=
=0A=
It's basically __bio_iov_bvec_add_pages() respecting the max_zone_sectors q=
ueue limit.=0A=
