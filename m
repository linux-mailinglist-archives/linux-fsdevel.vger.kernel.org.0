Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66713756EE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 23:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjGQVRY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 17:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjGQVRW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:17:22 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC01810A
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 14:17:10 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 4689D3200926;
        Mon, 17 Jul 2023 17:17:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 17 Jul 2023 17:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1689628626; x=1689715026; bh=gI0+rLtTfMyMFBFX/WctPBtxgzG+M5CnRZD
        pil2+1zg=; b=wlu746LlwkApBiWpva2wjIfVi1x38mS5TwKbxycniWhkIJC5KPP
        yQlOYyeJO0W/tTxJPMrIp28Xr1Kxy1n82qC1Hoj3JCnjT2Kmjw98BAsNHYyu4IbJ
        51QtpEC73j0VRLEKMvOpYcdJFlk0DZEUdvetUoTfkC/nixaNlar2vyHQG7iYq4Bs
        1wMLiChyvc1ZhmoBJ5OK00Q7t+qlOd6QGM9onCNBzbM04CWPbmc2JbliR6VIjIBV
        +He6POy379FFkWHbKUTYqX+UuFvT7xts+pVIxXyfP7HvLUjzuA93gSDXUA3hC7uc
        S43phiXgiCFyZ3TeWypNDeAdq0dgo3uscHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1689628626; x=1689715026; bh=gI0+rLtTfMyMFBFX/WctPBtxgzG+M5CnRZD
        pil2+1zg=; b=p3bsRDrIE8UO8TD8606ALrwEeDy5/cYO8kccp2ZESD5MotRF/pm
        ITnZvuELUIH1rHmzfnRjQxk4WhEhu6/varX+hWCmVEe/z5EeirLzU63j4jyNT+f8
        DNv+R5ig5NCeD9TjfFJgTzjAgDNlzUy4/nsQ0dT/Mt1vMx4PZVbW+Jh5pn2aktPZ
        jd5WuOrImbqzCe+ZVGhCIT2uSyGsYr1vqFsIwpoxHrR7Q9hOS6WbNiXeJ0yNw5zr
        l4NhtT+OTNUd6uaqAMaGwSOSZ30v24SxDAKVvgLyiOXUpVaEDUL7zF38d2kA1yks
        bF1yyM153gvHanF0IF/eLaFgrFTRZN09KRA==
X-ME-Sender: <xms:0a-1ZGFon4MBzGhBJ6nLhJ913bQkLDYhZg6-umKk0qPHVBTbP2-0Pg>
    <xme:0a-1ZHWzCOIWK8XYOXjdSTi6B4rlDPuQ6bt-bMiRCGUwT-VZWH-IWK9vT2Qtt7VXW
    wuQ5589Ng5uqxmF>
X-ME-Received: <xmr:0a-1ZALfK-yke0AZ_N6ZUg_61t8swV3MUWPPtTJDLdJngF4Jvx6ZYZ4jDMx89mXRYnZhjvSHVKmrkuAN6J4kWajb-70CZNXRPk8UJ836YArGuarR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgedvgdduiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgfjghfkfggtgfgsehtqhhmtddtreejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepffeugeeihfffteevheevveffjeehveekudeg
    fedtfeegudevjedvhfefvdeitdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:0a-1ZAEsxY_dWWSe_kY-vmV4EQnCCjrVyqNtNpS6c65_0qkJqua0lQ>
    <xmx:0a-1ZMVmrAeiTApCyJQdITML9sPhbL8t5KyE7qZjLiDvOYBQZ9IYHQ>
    <xmx:0a-1ZDNcPz1c4_Zq_YqluiXRMFDtsXQtxzS374AVPKqMguUWICBTCg>
    <xmx:0q-1ZGetTYqghUL-fND3nKyprZOIRGNkNfpClQXoUBg91emfcOLQdw>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jul 2023 17:17:04 -0400 (EDT)
Date:   Mon, 17 Jul 2023 23:17:01 +0200
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
To:     Hao Xu <hao.xu@linux.dev>, fuse-devel@lists.sourceforge.net
CC:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>, cgxu519@mykernel.net,
        Dharmendra Singh <dsingh@ddn.com>
Subject: Re: [RFC] [PATCH] fuse: DIO writes always use the same code path
User-Agent: K-9 Mail for Android
In-Reply-To: <7e172b70-807c-c879-6d1c-b11f4c39d144@linux.dev>
References: <20230630094602.230573-1-hao.xu@linux.dev> <a77b34fe-dbe7-388f-c559-932b1cd44583@fastmail.fm> <7e172b70-807c-c879-6d1c-b11f4c39d144@linux.dev>
Message-ID: <9C4096B6-4D02-49F4-B38A-AB1407853F24@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On July 17, 2023 10:03:11 AM GMT+02:00, Hao Xu <hao=2Exu@linux=2Edev> wrote=
:
>Hi Bernd,
>
>On 7/5/23 18:23, Bernd Schubert wrote:
>> From: Bernd Schubert <bschubert@ddn=2Ecom>
>>=20
>> In commit 153524053bbb0d27bb2e0be36d1b46862e9ce74c DIO
>> writes can be handled in parallel, as long as the file
>> is not extended=2E So far this only works when daemon/server
>> side set FOPEN_DIRECT_IO and FOPEN_PARALLEL_DIRECT_WRITES,
>> but O_DIRECT (iocb->ki_flags & IOCB_DIRECT) went another
>> code path that doesn't have the parallel DIO write
>> optimization=2E
>> Given that fuse_direct_write_iter has to handle page writes
>> and invalidation anyway (for mmap), the DIO handler in
>> fuse_cache_write_iter() is removed and DIO writes are now
>> only handled by fuse_direct_write_iter()=2E
>>=20
>> Note: Correctness of this patch depends on a non-merged
>> series from Hao Xu <hao=2Exu@linux=2Edev>
>> ( fuse: add a new fuse init flag to relax restrictions in no cache mode=
)
>> ---
>>  =C2=A0fs/fuse/file=2Ec |=C2=A0=C2=A0 38 +++++-------------------------=
--------
>>  =C2=A01 file changed, 5 insertions(+), 33 deletions(-)
>>=20
>> diff --git a/fs/fuse/file=2Ec b/fs/fuse/file=2Ec
>> index 89d97f6188e0=2E=2E1490329b536c 100644
>> --- a/fs/fuse/file=2Ec
>> +++ b/fs/fuse/file=2Ec
>> @@ -1337,11 +1337,9 @@ static ssize_t fuse_cache_write_iter(struct kioc=
b *iocb, struct iov_iter *from)
>>  =C2=A0=C2=A0=C2=A0=C2=A0 struct file *file =3D iocb->ki_filp;
>>  =C2=A0=C2=A0=C2=A0=C2=A0 struct address_space *mapping =3D file->f_map=
ping;
>>  =C2=A0=C2=A0=C2=A0=C2=A0 ssize_t written =3D 0;
>> -=C2=A0=C2=A0=C2=A0 ssize_t written_buffered =3D 0;
>>  =C2=A0=C2=A0=C2=A0=C2=A0 struct inode *inode =3D mapping->host;
>>  =C2=A0=C2=A0=C2=A0=C2=A0 ssize_t err;
>>  =C2=A0=C2=A0=C2=A0=C2=A0 struct fuse_conn *fc =3D get_fuse_conn(inode)=
;
>> -=C2=A0=C2=A0=C2=A0 loff_t endbyte =3D 0;
>>=20
>>  =C2=A0=C2=A0=C2=A0=C2=A0 if (fc->writeback_cache) {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Update size (EOF o=
ptimization) and mode (SUID clearing) */
>> @@ -1377,37 +1375,10 @@ static ssize_t fuse_cache_write_iter(struct kio=
cb *iocb, struct iov_iter *from)
>>  =C2=A0=C2=A0=C2=A0=C2=A0 if (err)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>=20
>> -=C2=A0=C2=A0=C2=A0 if (iocb->ki_flags & IOCB_DIRECT) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loff_t pos =3D iocb->ki_pos=
;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 written =3D generic_file_di=
rect_write(iocb, from);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (written < 0 || !iov_ite=
r_count(from))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o out;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pos +=3D written;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 written_buffered =3D fuse_p=
erform_write(iocb, mapping, from, pos);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (written_buffered < 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err=
 =3D written_buffered;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o out;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 endbyte =3D pos + written_b=
uffered - 1;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D filemap_write_and_w=
ait_range(file->f_mapping, pos,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 endbyte);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o out;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 invalidate_mapping_pages(fi=
le->f_mapping,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pos >> PAGE_SHIFT,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 endbyte >> PAGE_SHIFT);
>> +=C2=A0=C2=A0=C2=A0 written =3D fuse_perform_write(iocb, mapping, from,=
 iocb->ki_pos);
>> +=C2=A0=C2=A0=C2=A0 if (written >=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iocb->ki_pos +=3D written;
>>=20
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 written +=3D written_buffer=
ed;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iocb->ki_pos =3D pos + writ=
ten_buffered;
>> -=C2=A0=C2=A0=C2=A0 } else {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 written =3D fuse_perform_wr=
ite(iocb, mapping, from, iocb->ki_pos);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (written >=3D 0)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ioc=
b->ki_pos +=3D written;
>> -=C2=A0=C2=A0=C2=A0 }
>>  =C2=A0out:
>>  =C2=A0=C2=A0=C2=A0=C2=A0 current->backing_dev_info =3D NULL;
>>  =C2=A0=C2=A0=C2=A0=C2=A0 inode_unlock(inode);
>> @@ -1691,7 +1662,8 @@ static ssize_t fuse_file_write_iter(struct kiocb =
*iocb, struct iov_iter *from)
>>  =C2=A0=C2=A0=C2=A0=C2=A0 if (FUSE_IS_DAX(inode))
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return fuse_dax_write=
_iter(iocb, from);
>>=20
>> -=C2=A0=C2=A0=C2=A0 if (!(ff->open_flags & FOPEN_DIRECT_IO))
>> +=C2=A0=C2=A0=C2=A0 if (!(ff->open_flags & FOPEN_DIRECT_IO) &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !(iocb->ki_flags & IOCB_DIR=
ECT))
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return fuse_cache_wri=
te_iter(iocb, from);
>>  =C2=A0=C2=A0=C2=A0=C2=A0 else
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return fuse_direct_wr=
ite_iter(iocb, from);
>>=20
>
>For normal direct io(IOCB_DIRECT set, FOPEN_DIRECT_IO not set), it now
>goes to fuse_direct_write_iter() but the thing is the previous patchset
>I sent adds page flush and invalidation in FOPEN_DIRECT_IO
>and/or fc->direct_io_relax, so I guess this part(flush and invalidation)
>is not included in the normal direct io code path=2E
>
>Regards,
>Hao
>

Hi Hao,

I'm going to rebase to for-next and create a single patch set that should =
handle that, but only next week=2E

Thanks,
Bernd
