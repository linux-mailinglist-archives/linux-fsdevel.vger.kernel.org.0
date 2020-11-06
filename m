Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D3D2A9229
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 10:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgKFJLa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 04:11:30 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:31313 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgKFJLY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604653883; x=1636189883;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=o71AHpBnfoEC+vBv3HZ6o9+DlO8YRl9khVzEE32QuTM=;
  b=dsNFiMNRZxw5aDAWqmvyysnMvcpwu5kPn9ldGxnJcsRm0k3CSgdlA5dM
   WFIn6woe8oDRCk3vqLncZ1ZG1Y6OuBDAOF1gFGy8Y387/dwK85x5vKnjO
   bWU5rKBwlAc88ge7oUkQglVZzMoa74fwj9muLz5+E95vo6oRhJLzRD7+N
   Z1QxZL51YMlQHtuw2NC2IfXt6rcRos9x8W/f5CN9hh2Xwcr1qP8BgzaDs
   tOOcKgRQyvNCzq6aLUVmrL9HuwCWsRwPc6cvWAEODNGS2DCirXJShsseY
   i94r8kz0knt/yZl3b6joYVdk4aUj8EXs/4bHEpo9EB5tJ+U9kD//vyZy/
   A==;
IronPort-SDR: Y6vCpZbJA+FBhfUda2AMx3HrWenygt1yvffO3xWBSTLSgaSwNzKoifpMqPjw/PlFXlCgg3VZA3
 iI+wthrh+salNSGs7aqcq5V6nYDu2aztMawHtDFX2kP0uNeRNjSQjFhpbx11iUbTnx5BTDJ6kt
 mtsfqMPel2K3p2CqKNdQtfggiMPPV5n89zSvfY4mTkB9fgipY/WI3Utx19OFTJoOqFa/TxexTi
 CjjOsduTxMYGCNi8xawfAo/w5F0hbQteJc3j6E9L1imIvffF54ianZhK5Sj/MhEV9YuLOjdk/z
 ns0=
X-IronPort-AV: E=Sophos;i="5.77,456,1596470400"; 
   d="scan'208";a="262009097"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2020 17:11:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoXlveNUURs0BZuVv8qjQ8y81HNvoufG3A0gq4SiBcmo9vpE75+plKUr3qHrMX5+eRKy3bYG9VJBIKom75kufNEhtHob8qrADjIkzNMKWiQdPwelYYhMdCXOQQVYuCNILGxgmx59zbbbBD1bF2JSHTlLlfbPYfWJ6ZqHNeqT68eAACvkGN//HzDwVqLjLWgXDF9szT18AUmdL/8Vnv4XiKy4UxxEsOWgCacd04q3ajsg78IYY05TI6833i21muhmjk8Q+/BZ+AybZA6JLcj8CRengkChJWl2qC1SPAQlYLuMUNLWDMXkZfl7SKieT3Pb7pAOiDzBrge/EikJikns5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amBfdx9TbpjamZTKvHKofJi60oF2Z42OkHK67BINnrI=;
 b=lhjDRZmo5ivB5vgCwF/dKL1a2js+UIv1oBY4y1KQY44HR2e1Ii3qj6rxzq2ZPWYJ2d8Bscng5fFh40wWkYhi5cJINMGY1j0ETKfCJ+F5BH0css/lBAcQ8gwMV2pIdI3gdzd7mf3vhDgx30iNrWG8OyK+EfsDtwu6iYcqtmxuKgqZ3oRvVF/LEmc8FEqXqRKALaA6Xmp72plhZSGaagnLdZqYyTCw1qzrW6mBhY0vuyKYsXJ0e6MqKYLiC9sar76mS2Xa6YryVopumnWQM5vo2jamivifaLcMGThkB2nLCaFSdrpZLX46rubl+JNhvpjmSTo4zzO3MpCSoxZKEFQdew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amBfdx9TbpjamZTKvHKofJi60oF2Z42OkHK67BINnrI=;
 b=Ry4MD7xhWaKubLG4pclz13775RiPmp9/83BeVLVTx4Bm84zzmt7l8Rsx0IhTZGRtmAjP8cgkKqyUYt2gSbY0JkjjfQzXeiE0lZ0hBPq8bCuqaE405UFsOD5DJyo6Ido3k8S2UQ1+pNaPc7TqKjtCk/kBG4ClSvqBQTQvHi4V5BM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3808.namprd04.prod.outlook.com
 (2603:10b6:805:48::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Fri, 6 Nov
 2020 09:11:22 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.021; Fri, 6 Nov 2020
 09:11:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v9 19/41] btrfs: redirty released extent buffers in ZONED
 mode
Thread-Topic: [PATCH v9 19/41] btrfs: redirty released extent buffers in ZONED
 mode
Thread-Index: AQHWrsQGTcdwmf6InE+GDNyCimz0DQ==
Date:   Fri, 6 Nov 2020 09:11:21 +0000
Message-ID: <SN4PR0401MB35981D8500BE7FAF931F1AEE9BED0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <b2c1ee9a3c4067b9f8823604e4c4c5c96d3abc61.1604065695.git.naohiro.aota@wdc.com>
 <6d61ed1d-1801-5710-beac-03d363871ec8@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ba8c8e6e-9360-45b3-b2a3-08d88233edfd
x-ms-traffictypediagnostic: SN6PR04MB3808:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB3808C9D29E7828756957EB919BED0@SN6PR04MB3808.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:350;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pP2uNxnGBrCIJ7kFVjAcqSLE2zLmx38Km+IIOHIboVmQETZee8t0Tb6c2FXZvsNWYpH7k7UJCAmqXfopAtA/Br6J3hytWqHNdO1imqptI2iscM826/PJa/EO4TdX/75ZXJcoA3E4piKX+XhXYHAqnSzYkhWK/UzNgBk7ykAPHu8J+VJRyJaHx0dn6Tt0PK7p27TqDEQneEua0Mka1pWDympoR5KXCkX0WnlmnG/j/0PmXseD2BtOvlA8OfkobhS7nd6g1ufk2VyMLeAXbCIEwmW1zgeJypu/UIKt0tji3NwDEXVaDmJigtZ2eHOO6PqMb8MnSWHRj7n0pr929n9QPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(26005)(52536014)(54906003)(86362001)(7696005)(8676002)(110136005)(316002)(2906002)(91956017)(8936002)(478600001)(64756008)(76116006)(33656002)(53546011)(4326008)(6506007)(55016002)(66446008)(66476007)(186003)(66946007)(66556008)(71200400001)(9686003)(5660300002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: tTBz5LoVON7HKuEfmL11BraNH/TlaU4BAZo1PeP/NbOvFc+RwRjjF+SkaU3M03Y690rQ3uch35mUnaujhnjMTsh/cUgyjK3+X8/2pxD3AMjTu4YPEvy9oWuEDQyU/grZVMekMfAP7TruJeBAFjAwOomyMnPeK/j2W51TiW3j9uGePCoOZ7CVV3jUXRxUETjuTiHj+ynVD0DntmMX4/c4Gr29a0oMtxv6D+kPh09z7/8AM8SC0ZvcTV/LX32VOIi1SCU6ETxYrhNuTgmas0iFNkkfr6pLSWx8KOx5uBrvJnstPdEmFvU6VjtnvlhRBdyBmFiBzGhgIEhI6pl86NSZc6xiF6osDFQVgLvz3AzQ3R3dDlA8FZqdM+9FYEGydJ4eiiHVTVC3688q7JcIBJAT8xx8U0tWV4Ra4664x06MG9Vthqxzmc2nwFvQifJLO/9uWlA/+jd7jJWmLPlDUgIAa1HVPcQITUE40//ixTgguF0GJHOXz0yrXuLg4KAP3LacMuLX/v9sgfYkSyTXMn3eZVPY5Cyv3ub7TOAcTJm/o99b2aq3uD00E0VibqOXepcIiszBjCpCYB1T7EZWhRbvTVAtr0HyOuH3Gm/Fb3giUhe15TKU2tUY5zsXXYYN3bGZFNoo+ZGn4UjhXGymL5yCpw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8c8e6e-9360-45b3-b2a3-08d88233edfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 09:11:21.9791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WqXIQLWkrMTcwljZ6EsU76XcVVCk/ub8rcGyaYaVlpoDdU56RIUHXRs7Ozno4UdKSCptMNCnVuxpJS2Pzuj7d6lVwyodHJPjF3ptC4MmhSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3808
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/11/2020 15:43, Josef Bacik wrote:=0A=
> This is a lot of work when you could just add=0A=
> =0A=
> if (btrfs_is_zoned(fs_info))=0A=
> 	return;=0A=
> =0A=
> to btrfs_clean_tree_block().  The dirty secret is we don't actually unset=
 the =0A=
> bits in the transaction io tree because it would require memory allocatio=
n =0A=
> sometimes, so you don't even need to mess with ->dirty_pages in the first=
 place. =0A=
>   The only thing you need is to keep from clearing the EB dirty.  In fact=
 you =0A=
> could just do=0A=
> =0A=
> if (btrfs_is_zoned(fs_info)) {=0A=
> 	memzero_extent_buffer(eb, 0, eb->len);=0A=
> 	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);=0A=
> }=0A=
> =0A=
> to btrfs_clean_tree_block() and then in btrfs_free_tree_block() make sure=
 we =0A=
> always pin the extent if we're zoned.  Thanks,=0A=
=0A=
As much as I'd love the simple solution you described it unfortunately didn=
't work=0A=
in our testing [1]. So unless I did something completely stupid [2] (which =
always=0A=
is an option) I don't think we can go with the easy solution here, unfortun=
ately.=0A=
=0A=
[1]=0A=
btrfs/001       [   16.212869] BTRFS error (device nullb1): unable to find =
ref byte nr 805388288 parent 805388288 root 5  owner 0 offset 0=0A=
[   16.214314] BTRFS: error (device nullb1) in __btrfs_free_extent:3196: er=
rno=3D-2 No such entry=0A=
[   16.215270] BTRFS: error (device nullb1) in btrfs_run_delayed_refs:2215:=
 errno=3D-2 No such entry                                                  =
                                  =0A=
[   16.266987] BTRFS error (device nullb1): unable to find ref byte nr 8053=
88288 parent 805388288 root 5  owner 0 offset 0                            =
    =0A=
[   16.268788] BTRFS: error (device nullb1) in __btrfs_free_extent:3196: er=
rno=3D-2 No such entry                                           =0A=
[   16.269973] BTRFS: error (device nullb1) in btrfs_run_delayed_refs:2215:=
 errno=3D-2 No such entry=0A=
[   16.271210] BTRFS: error (device nullb1) in cleanup_transaction:1904: er=
rno=3D-2 No such entry                                                  =0A=
[   16.297358] BTRFS error (device nullb1): unable to find ref byte nr 8055=
02976 parent 805502976 root 1  owner 0 offset 0                       =0A=
[   16.299128] BTRFS: error (device nullb1) in __btrfs_free_extent:3196: er=
rno=3D-2 No such entry   =0A=
[   16.300324] BTRFS: error (device nullb1) in btrfs_run_delayed_refs:2215:=
 errno=3D-2 No such entry=0A=
[   16.335600] BTRFS error (device nullb1): unable to find ref byte nr 8053=
88288 parent 805388288 root 5  owner 0 offset 0=0A=
[   16.337600] BTRFS: error (device nullb1) in __btrfs_free_extent:3196: er=
rno=3D-2 No such entry=0A=
[   16.338785] BTRFS: error (device nullb1) in btrfs_run_delayed_refs:2215:=
 errno=3D-2 No such entry                                                  =
                                  =0A=
[   16.340026] BTRFS: error (device nullb1) in cleanup_transaction:1904: er=
rno=3D-2 No such entry            =0A=
[   16.366461] BTRFS error (device nullb0): unable to find ref byte nr 8055=
02976 parent 805502976 root 1  owner 0 offset 0=0A=
[   16.368304] BTRFS: error (device nullb0) in __btrfs_free_extent:3196: er=
rno=3D-2 No such entry=0A=
[   16.369480] BTRFS: error (device nullb0) in btrfs_run_delayed_refs:2215:=
 errno=3D-2 No such entry=0A=
[   16.370689] BTRFS: error (device nullb0) in cleanup_transaction:1904: er=
rno=3D-2 No such entry=0A=
[   16.392890] BTRFS error (device nullb1): unable to find ref byte nr 8053=
88288 parent 805388288 root 5  owner 0 offset 0=0A=
[   16.394531] BTRFS: error (device nullb1) in __btrfs_free_extent:3196: er=
rno=3D-2 No such entry=0A=
[   16.395612] BTRFS: error (device nullb1) in btrfs_run_delayed_refs:2215:=
 errno=3D-2 No such entry                                                  =
      =0A=
[   16.396648] BTRFS: error (device nullb1) in cleanup_transaction:1904: er=
rno=3D-2 No such entry=0A=
[   16.422315] BTRFS error (device nullb1): unable to find ref byte nr 8055=
02976 parent 805502976 root 1  owner 0 offset 0                =0A=
[   16.424147] BTRFS: error (device nullb1) in __btrfs_free_extent:3196: er=
rno=3D-2 No such entry=0A=
[   16.425320] BTRFS: error (device nullb1) in btrfs_run_delayed_refs:2215:=
 errno=3D-2 No such entry=0A=
[   16.426532] BTRFS: error (device nullb1) in cleanup_transaction:1904: er=
rno=3D-2 No such entry=0A=
_check_dmesg: something found in dmesg (see /home/johannes/src/xfstests-dev=
/results//btrfs/001.dmesg)=0A=
- output mismatch (see /home/johannes/src/xfstests-dev/results//btrfs/001.o=
ut.bad)=0A=
    --- tests/btrfs/001.out     2020-01-07 15:49:53.000000000 +0000=0A=
    +++ /home/johannes/src/xfstests-dev/results//btrfs/001.out.bad      202=
0-11-05 16:17:37.266632915 +0000=0A=
    @@ -3,38 +3,29 @@=0A=
     List root dir=0A=
     foo=0A=
     Creating snapshot of root dir=0A=
    +ERROR: cannot snapshot '/mnt/scratch': No such file or directory=0A=
     Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'=0A=
     List root dir after snapshot=0A=
    -foo=0A=
    ...=0A=
    (Run 'diff -u /home/johannes/src/xfstests-dev/tests/btrfs/001.out /home=
/johannes/src/xfstests-dev/results//btrfs/001.out.bad'  to see the entire d=
iff)=0A=
=0A=
[2]=0A=
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c=0A=
index e896dd564434..e1bf3b561b45 100644=0A=
--- a/fs/btrfs/disk-io.c=0A=
+++ b/fs/btrfs/disk-io.c=0A=
@@ -1013,7 +1013,11 @@ struct extent_buffer *read_tree_block(struct btrfs_f=
s_info *fs_info, u64 bytenr,=0A=
 void btrfs_clean_tree_block(struct extent_buffer *buf)=0A=
 {=0A=
        struct btrfs_fs_info *fs_info =3D buf->fs_info;=0A=
-       if (btrfs_header_generation(buf) =3D=3D=0A=
+=0A=
+       if (btrfs_is_zoned(fs_info)) {=0A=
+               memzero_extent_buffer(buf, 0, buf->len);=0A=
+               set_bit(EXTENT_BUFFER_NO_CHECK, &buf->bflags);=0A=
+       } else if (btrfs_header_generation(buf) =3D=3D=0A=
            fs_info->running_transaction->transid) {=0A=
                btrfs_assert_tree_locked(buf);=0A=
 =0A=
@@ -4639,8 +4643,6 @@ void btrfs_cleanup_one_transaction(struct btrfs_trans=
action *cur_trans,=0A=
                                     EXTENT_DIRTY);=0A=
        btrfs_destroy_pinned_extent(fs_info, &cur_trans->pinned_extents);=
=0A=
 =0A=
-       btrfs_free_redirty_list(cur_trans);=0A=
-=0A=
        cur_trans->state =3DTRANS_STATE_COMPLETED;=0A=
        wake_up(&cur_trans->commit_wait);=0A=
 }=0A=
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c=0A=
index bfd7f3082037..f9f9c329fa69 100644=0A=
--- a/fs/btrfs/extent-tree.c=0A=
+++ b/fs/btrfs/extent-tree.c=0A=
@@ -3432,15 +3432,23 @@ void btrfs_free_tree_block(struct btrfs_trans_handl=
e *trans,=0A=
                pin =3D old_ref_mod >=3D 0 && new_ref_mod < 0;=0A=
        }=0A=
 =0A=
+       if (btrfs_is_zoned(fs_info)) {=0A=
+               struct btrfs_block_group *cache;=0A=
+=0A=
+               cache =3D btrfs_lookup_block_group(fs_info, buf->start);=0A=
+               pin_down_extent(trans, cache, buf->start, buf->len, 1);=0A=
+               btrfs_put_block_group(cache);=0A=
+               pin =3D 0;=0A=
+               goto out;=0A=
+       }=0A=
+=0A=
        if (last_ref && btrfs_header_generation(buf) =3D=3D trans->transid)=
 {=0A=
                struct btrfs_block_group *cache;=0A=
 =0A=
                if (root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID) {=
=0A=
                        ret =3D check_ref_cleanup(trans, buf->start);=0A=
-                       if (!ret) {=0A=
-                               btrfs_redirty_list_add(trans->transaction, =
buf);=0A=
+                       if (!ret)=0A=
                                goto out;=0A=
-                       }=0A=
                }=0A=
 =0A=
                pin =3D 0;=0A=
@@ -3452,13 +3460,6 @@ void btrfs_free_tree_block(struct btrfs_trans_handle=
 *trans,=0A=
                        goto out;=0A=
                }=0A=
 =0A=
-               if (btrfs_is_zoned(fs_info)) {=0A=
-                       btrfs_redirty_list_add(trans->transaction, buf);=0A=
-                       pin_down_extent(trans, cache, buf->start, buf->len,=
 1);=0A=
-                       btrfs_put_block_group(cache);=0A=
-                       goto out;=0A=
-               }=0A=
-=0A=
                WARN_ON(test_bit(EXTENT_BUFFER_DIRTY, &buf->bflags));=0A=
 =0A=
                btrfs_add_free_space(cache, buf->start, buf->len);=0A=
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c=0A=
index a8561536cd0d..4acc96969959 100644=0A=
--- a/fs/btrfs/transaction.c=0A=
+++ b/fs/btrfs/transaction.c=0A=
@@ -2348,13 +2348,6 @@ int btrfs_commit_transaction(struct btrfs_trans_hand=
le *trans)=0A=
                goto scrub_continue;=0A=
        }=0A=
 =0A=
-       /*=0A=
-        * At this point, we should have written all the tree blocks=0A=
-        * allocated in this transaction. So it's now safe to free the=0A=
-        * redirtyied extent buffers.=0A=
-        */=0A=
-       btrfs_free_redirty_list(cur_trans);=0A=
-=0A=
        ret =3D write_all_supers(fs_info, 0);=0A=
        /*=0A=
         * the super is written, we can safely allow the tree-loggers=0A=
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c=0A=
index 15f9e8a461ee..e91bdfbb03da 100644=0A=
--- a/fs/btrfs/tree-log.c=0A=
+++ b/fs/btrfs/tree-log.c=0A=
@@ -2763,8 +2763,6 @@ static noinline int walk_down_log_tree(struct btrfs_t=
rans_handle *trans,=0A=
                                                free_extent_buffer(next);=
=0A=
                                                return ret;=0A=
                                        }=0A=
-                                       btrfs_redirty_list_add(=0A=
-                                               trans->transaction, next);=
=0A=
                                } else {=0A=
                                        if (test_and_clear_bit(EXTENT_BUFFE=
R_DIRTY, &next->bflags))=0A=
                                                clear_extent_buffer_dirty(n=
ext);=0A=
@@ -3313,8 +3311,6 @@ static void free_log_tree(struct btrfs_trans_handle *=
trans,=0A=
                          EXTENT_DIRTY | EXTENT_NEW | EXTENT_NEED_WAIT);=0A=
        extent_io_tree_release(&log->log_csum_range);=0A=
 =0A=
-       if (trans && log->node)=0A=
-               btrfs_redirty_list_add(trans->transaction, log->node);=0A=
        btrfs_put_root(log);=0A=
 }=0A=
 =0A=
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h=0A=
index 5b61500a0aa9..3140c39d3728 100644=0A=
--- a/fs/btrfs/zoned.h=0A=
+++ b/fs/btrfs/zoned.h=0A=
@@ -42,9 +42,6 @@ int btrfs_reset_device_zone(struct btrfs_device *device, =
u64 physical,=0A=
 int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 s=
ize);=0A=
 int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache);=0A=
 void btrfs_calc_zone_unusable(struct btrfs_block_group *cache);=0A=
-void btrfs_redirty_list_add(struct btrfs_transaction *trans,=0A=
-                           struct extent_buffer *eb);=0A=
-void btrfs_free_redirty_list(struct btrfs_transaction *trans);=0A=
 void btrfs_record_physical_zoned(struct inode *inode, u64 file_offset,=0A=
                                 struct bio *bio);=0A=
 void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered);=0A=
@@ -137,10 +134,6 @@ static inline int btrfs_load_block_group_zone_info(=0A=
 =0A=
 static inline void btrfs_calc_zone_unusable(struct btrfs_block_group *cach=
e) { }=0A=
 =0A=
-static inline void btrfs_redirty_list_add(struct btrfs_transaction *trans,=
=0A=
-                                         struct extent_buffer *eb) { }=0A=
-static inline void btrfs_free_redirty_list(struct btrfs_transaction *trans=
) { }=0A=
-=0A=
 static inline void btrfs_record_physical_zoned(struct inode *inode,=0A=
                                               u64 file_offset, struct bio =
*bio)=0A=
 {=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
