Return-Path: <linux-fsdevel+bounces-4018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7034C7FB5C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 10:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0FF6B21700
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 09:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8803046546;
	Tue, 28 Nov 2023 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eq6NDLmd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5052DE
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 01:28:06 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231128092802epoutp040d162077d32be6b2da6970b772073f92~bv1svCrSe1099210992epoutp046
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 09:28:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231128092802epoutp040d162077d32be6b2da6970b772073f92~bv1svCrSe1099210992epoutp046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701163682;
	bh=yRoHDpbU8jjx7xR9vJimmAuUPgYxd1bUp+OsHtJoH7E=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=eq6NDLmddUfuQaI88q51LopkIHxiSsfNrsznUmkeilczBE7rGzeioo4moSrdeXAb1
	 xPcITBiSLkwy98jYjg+Rr987H75JIhCMP3btGxxFUFVTT+HVFmnTIwdAV969qqSMAs
	 1hVY+FeLLjmo8pA2HIgN/ctaTBaV/MmfDRyiutVk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231128092801epcas1p1c9d359fe8520e2637a7cfe053bcb1236~bv1sC1ktG0166801668epcas1p1K;
	Tue, 28 Nov 2023 09:28:01 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp3.localdomain
	(Postfix) with ESMTP id 4SfcZ95yCMz4x9Q1; Tue, 28 Nov 2023 09:28:01 +0000
	(GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231128092104epcas1p12589074af217e9b15bd4241cd0b76a2c~bvvm_k4Ns2696326963epcas1p1b;
	Tue, 28 Nov 2023 09:21:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231128092104epsmtrp24851f5725b29d9beeece51dffe14c982~bvvm96p4d1918819188epsmtrp2a;
	Tue, 28 Nov 2023 09:21:04 +0000 (GMT)
X-AuditID: b6c32a29-fa1ff70000002233-29-6565b0ff4fe4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CA.C4.08755.FF0B5656; Tue, 28 Nov 2023 18:21:04 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20231128092103epsmtip1293210fe3c9a6fe3950143b99adc654a~bvvm0cPGB2831428314epsmtip1C;
	Tue, 28 Nov 2023 09:21:03 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: <Yuezhang.Mo@sony.com>, <linkinjeon@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <Andy.Wu@sony.com>,
	<Wataru.Aoyama@sony.com>, <cpgs@samsung.com>, <sj1557.seo@samsung.com>
In-Reply-To: <PUZPR04MB631680D4803CEE2B1A7F42F381A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v4 1/2] exfat: change to get file size from DataLength
Date: Tue, 28 Nov 2023 18:21:03 +0900
Message-ID: <1296674576.21701163681829.JavaMail.epsvc@epcpadp4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIfTJ4sSqFtaLGW5XdKkwFe5OsxkQHvqZQxr/WP4HA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSnC7DxtRUgxsfmCxaj+xjtHh5SNNi
	4rSlzBZ79p5ksdjy7wirxccHuxktrr95yOrA7rFpVSebR9+WVYwe7RN2Mnt83iQXwBLFZZOS
	mpNZllqkb5fAlTG1u75goUbFjRu72RsYH8p3MXJySAiYSLS9PMYEYgsJ7GaUuDpdqouRAygu
	JXFwnyaEKSxx+HBxFyMXUMVzRol7q3aBlbMJ6Eo8ufGTGcQWETCV+HL5BBuIzSzQzijx7lss
	RMM6RokN886AFXEKxErM/X0FrFlYwEvi89npjCA2i4CqxPRpu8BsXgFLiU8nO9kgbEGJkzOf
	sEAM1ZZ4evMpnL1s4WtmiPsVJHZ/OsoKcYSVxJK985kgakQkZne2MU9gFJ6FZNQsJKNmIRk1
	C0nLAkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwdGjpbmDcfuqD3qHGJk4GA8x
	SnAwK4nw6n1MThXiTUmsrEotyo8vKs1JLT7EKM3BoiTOK/6iN0VIID2xJDU7NbUgtQgmy8TB
	KdXA1L3KRXRJV1b1otdTuWK/bHllyM/zI3qz7JQbz98+/DFpRe4GN+/pi9eoeWSqON//v0mN
	86lCZOaEzT3TfjCaXQ22N/pUYP3uywXH7ne5ey9JyC+WYXngt/fTkvMSKX8PTnY46lSxiHlD
	7z5DEVs2q8lqG9ZIp+S8nqkr+UlUP2mF/IMoa90Z4p5/lv68PXtZd3zNgZLlHnt7zF9YHZ86
	40vOzDzpuewSizU/TwyfaGGtOa2r3o9xj8IJr5xwx1blnJJOm+zInJN/jurX5qwrzsmpObsw
	TEhCJ/XixYnzDWtmOnULOnwTcHTYICuWPPnDwd6/r7sElvdnv28vqLnKtfzlo4tJk63tlO4k
	CLMfVmIpzkg01GIuKk4EAGncQo8NAwAA
X-CMS-MailID: 20231128092104epcas1p12589074af217e9b15bd4241cd0b76a2c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
X-Hop-Count: 3
X-CMS-RootMailID: 20231102095908epcas1p12f13d65d91f093b3541c7c568a7a256b
References: <CGME20231102095908epcas1p12f13d65d91f093b3541c7c568a7a256b@epcas1p1.samsung.com>
	<PUZPR04MB631680D4803CEE2B1A7F42F381A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>

> In stream extension directory entry, the ValidDataLength field describes
> how far into the data stream user data has been written, and the
> DataLength field describes the file size.
>=20
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
> ---
>  fs/exfat/exfat_fs.h |   2 +
>  fs/exfat/file.c     | 122 +++++++++++++++++++++++++++++++++++++++++++-
>  fs/exfat/inode.c    |  96 ++++++++++++++++++++++++++++------
>  fs/exfat/namei.c    |   6 +++
>  4 files changed, 207 insertions(+), 19 deletions(-)
[snip]
> +static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct
> +iov_iter *iter) {
> +=09ssize_t ret;
> +=09struct file *file =3D iocb->ki_filp;
> +=09struct inode *inode =3D file_inode(file);
> +=09struct exfat_inode_info *ei =3D EXFAT_I(inode);
> +=09loff_t pos =3D iocb->ki_pos;
> +=09loff_t valid_size;
> +
> +=09inode_lock(inode);
> +
> +=09valid_size =3D ei->valid_size;
> +
> +=09ret =3D generic_write_checks(iocb, iter);
> +=09if (ret < 0)
> +=09=09goto unlock;
> +
> +=09if (pos > valid_size) {
> +=09=09ret =3D exfat_file_zeroed_range(file, valid_size, pos);
> +=09=09if (ret < 0 && ret !=3D -ENOSPC) {
> +=09=09=09exfat_err(inode->i_sb,
> +=09=09=09=09"write: fail to zero from %llu to %llu(%ld)",
> +=09=09=09=09valid_size, pos, ret);
> +=09=09}
> +=09=09if (ret < 0)
> +=09=09=09goto unlock;
> +=09}
> +
> +=09ret =3D __generic_file_write_iter(iocb, iter);
> +=09if (ret < 0)
> +=09=09goto unlock;
> +
> +=09inode_unlock(inode);
> +
> +=09if (pos > valid_size && iocb_is_dsync(iocb)) {
> +=09=09ssize_t err =3D vfs_fsync_range(file, valid_size, pos - 1,
> +=09=09=09=09iocb->ki_flags & IOCB_SYNC);
If there is a hole between valid_size and pos, it seems to call sync twice.
Is there any reason to call separately?
Why don't you call the vfs_fsync_range only once for the merged scope [vali=
d_size:end]?

> +=09=09if (err < 0)
> +=09=09=09return err;
> +=09}
> +
> +=09if (ret)
> +=09=09ret =3D generic_write_sync(iocb, ret);
> +
> +=09return ret;
> +
> +unlock:
> +=09inode_unlock(inode);
> +
> +=09return ret;
> +}
> +
[snip]
> @@ -75,8 +75,7 @@ int __exfat_write_inode(struct inode *inode, int sync)
>  =09if (ei->start_clu =3D=3D EXFAT_EOF_CLUSTER)
>  =09=09on_disk_size =3D 0;
>=20
> -=09ep2->dentry.stream.valid_size =3D cpu_to_le64(on_disk_size);
> -=09ep2->dentry.stream.size =3D ep2->dentry.stream.valid_size;
> +=09ep2->dentry.stream.size =3D cpu_to_le64(on_disk_size);
>  =09if (on_disk_size) {
>  =09=09ep2->dentry.stream.flags =3D ei->flags;
>  =09=09ep2->dentry.stream.start_clu =3D cpu_to_le32(ei->start_clu);
> @@ -85,6 +84,8 @@ int __exfat_write_inode(struct inode *inode, int sync)
>  =09=09ep2->dentry.stream.start_clu =3D EXFAT_FREE_CLUSTER;
>  =09}
>=20
> +=09ep2->dentry.stream.valid_size =3D cpu_to_le64(ei->valid_size);
Is there any reason to not only change the value but also move the line dow=
n?

> +
>  =09exfat_update_dir_chksum_with_entry_set(&es);
>  =09return exfat_put_dentry_set(&es, sync);  } @@ -306,17 +307,25 @@
> static int exfat_get_block(struct inode *inode, sector_t iblock,
>  =09mapped_blocks =3D sbi->sect_per_clus - sec_offset;
>  =09max_blocks =3D min(mapped_blocks, max_blocks);
>=20
> -=09/* Treat newly added block / cluster */
> -=09if (iblock < last_block)
> -=09=09create =3D 0;
> -
> -=09if (create || buffer_delay(bh_result)) {
> -=09=09pos =3D EXFAT_BLK_TO_B((iblock + 1), sb);
> +=09pos =3D EXFAT_BLK_TO_B((iblock + 1), sb);
> +=09if ((create && iblock >=3D last_block) || buffer_delay(bh_result)) {
>  =09=09if (ei->i_size_ondisk < pos)
>  =09=09=09ei->i_size_ondisk =3D pos;
>  =09}
>=20
> +=09map_bh(bh_result, sb, phys);
> +=09if (buffer_delay(bh_result))
> +=09=09clear_buffer_delay(bh_result);
> +
>  =09if (create) {
> +=09=09sector_t valid_blks;
> +
> +=09=09valid_blks =3D EXFAT_B_TO_BLK_ROUND_UP(ei->valid_size, sb);
> +=09=09if (iblock < valid_blks && iblock + max_blocks >=3D valid_blks)
> {
> +=09=09=09max_blocks =3D valid_blks - iblock;
> +=09=09=09goto done;
> +=09=09}
> +
You removed the code for handling the case for (iblock < last_block).
So, under all write call-flows, it could be buffer_new abnormally.
It seems wrong. right?

>  =09=09err =3D exfat_map_new_buffer(ei, bh_result, pos);
>  =09=09if (err) {
>  =09=09=09exfat_fs_error(sb,
[snip]
> @@ -436,8 +485,20 @@ static ssize_t exfat_direct_IO(struct kiocb *iocb,
> struct iov_iter *iter)
>  =09 * condition of exfat_get_block() and ->truncate().
>  =09 */
>  =09ret =3D blockdev_direct_IO(iocb, inode, iter, exfat_get_block);
> -=09if (ret < 0 && (rw & WRITE))
> -=09=09exfat_write_failed(mapping, size);
> +=09if (ret < 0) {
> +=09=09if (rw & WRITE)
> +=09=09=09exfat_write_failed(mapping, size);
> +
> +=09=09if (ret !=3D -EIOCBQUEUED)
> +=09=09=09return ret;
> +=09} else
> +=09=09size =3D pos + ret;
> +
> +=09if ((rw & READ) && pos < ei->valid_size && ei->valid_size < size) {
> +=09=09iov_iter_revert(iter, size - ei->valid_size);
> +=09=09iov_iter_zero(size - ei->valid_size, iter);
> +=09}

This approach causes unnecessary reads to the range after valid_size, right=
?
But it looks very simple and clear.

Hum...
Do you have any plan to handle the before and after of valid_size separatel=
y?



