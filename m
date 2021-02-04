Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9383130F581
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 15:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbhBDO4W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 09:56:22 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:29369 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236742AbhBDOzl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612451295; x=1643987295;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=SfDBBLJwpkfqyIdgjQ4q42yCFR7lFrhkG8hMi/HIGd4=;
  b=KH5cGRWbOJDwajC4E8qs7cK/pIsutdVCUOmG6aKHcr43sdshlijS6Srg
   BsquEHpLeAziFD7mQ5Qi6253kKyXtpM7QmnU681CMtz29QLsYsKiUw5Dv
   rGy0qcKVkFE7NI+nFhsPKo+Ekvy7m+Vekr0PjJBLsy35S//WGLAvvHMwM
   ALqQjQ5F0dSXMTXYhr3tl3Mw5zoAE1mjJ9K2I2HfHiWGquUqNuf8YPMiV
   bjGrjZ4JhQLSaRtzVne3KA4eiutGGwrDQGBxzTPQyMimr7znb6xx4U5ua
   6Hv1BBsBwvCp9XFx7TrwQZ5YdAUcY2sPEHQkXNnSnHW9r6gPe/PVpWsFP
   g==;
IronPort-SDR: t2oraQQnJCY/0VjkgkgtPZmpnbcQ/E3Fp72xA7iKzCtXVhDpuSyjNmhwQgg21DyrcaPIdcfVRr
 9w6wzzpS1MHUVT+n9mv5lFhuwyqRiMRIG0iAu6ynLOtWfCL6wtwTwUoBc0LFv5v21h4/KEptLz
 pNV9i/Dxz5lCTmrBcNOgMkwSoJQAryjnvj1xVmm8yYyjuQ4rBpaQNzy6cRR8Hmd0reUwzpJBJ/
 eSD0b+PzBPegglscFFmiYSgT4QElXo8gNWvc9bkpM7laHCk3RrP8bPe+/1/dHlA3xoLSJHiwf2
 TS8=
X-IronPort-AV: E=Sophos;i="5.79,401,1602518400"; 
   d="scan'208";a="263221191"
Received: from mail-bl2nam02lp2053.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.53])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 23:06:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=id/Hwt8UFa4jiFkdTBpB2+8GxKPl/ybQp4J+SCqV2P54Fjg0U12tQFhwoMaLDKFoytWAhVz8iFav3Kk5qtJJM76hsvfwPCsOewwUFK/mV01aQI5wVphT2T8CghREerZf0lbao7TQ6KD+Ib51PIom/WJYkQs3Cuo2lB3p9w1b5xpAvaurN454DwMUNRLeQKiB//zkTk0rM+iCGrsLZoVbwy44ofjHliCqO4vD1ntrNHHNkAtrNqL/37vixKV6GUhXbwojO8jdw9yHoHD1/fy7FIxaDIMfeGz7EUTimutf7Ub2YO9FmzhFr8SfjwgZAG4Ej/Iue7G1tk8ec5G5bVIM6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rKWulyWOIdKlOKMe4dEsxpNvUBQlEAog9chM8rzhOY=;
 b=YyDzinOzeBXlAz3bj5ldWN5ORrkwWwteks4oYLs1TEuKVwEhgfiymUm6eF8iZvyigmA52imsmgk0P9fEDF9XviQj+EmbSaxYQa/P0BKHvF/N6DVed+7sGguTMkCbMlQWWTEMbFAB76FF728QRV8RCUff4pCP5VAkg6kVWnC8WcKGdLReAzp36ARHNderNX/LImoH5VWOfuwVfC3BFqQs2nwR9l4OAMwLFEABrY/BP3FHYQ1ETbsFAVvDRM9TzyiKXs9RAcV8Bp4z+aN6FdamA49dB1ALJ40l7Kzg7Av/QI1zpFrHJybThPnbLM2bOUx1xm8t/2tOjmHxnQa9VYZbWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rKWulyWOIdKlOKMe4dEsxpNvUBQlEAog9chM8rzhOY=;
 b=rbn34XajXjLlzZzLFA9i8DXcoiTUipkKdDvR9GZGw7I5C5krsBsGVYNqEmYmA9uu/jskry08pgHpEh8+2FCLpRTg+iTRnfWDSKNtgZp+GFPgOU3TdABcj7FZXDxPJMa8PqI+G07tANvzTzG9PBWUS8pSxU3U5bIEInx4nkxSpVQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4045.namprd04.prod.outlook.com
 (2603:10b6:805:47::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 4 Feb
 2021 14:54:25 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 14:54:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@gmail.com" <fdmanana@gmail.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v15 41/42] btrfs: zoned: reorder log node allocation on
 zoned filesystem
Thread-Topic: [PATCH v15 41/42] btrfs: zoned: reorder log node allocation on
 zoned filesystem
Thread-Index: AQHW+t/cYJgQtdxbUky0cyLYhI9sbw==
Date:   Thu, 4 Feb 2021 14:54:25 +0000
Message-ID: <SN4PR0401MB3598B6C1AAF3CEA92E167AE89BB39@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
 <492da9326ecb5f888e76117983603bb502b7b589.1612434091.git.naohiro.aota@wdc.com>
 <CAL3q7H7mzAngA8SF13+FOgVserhF3iyA2a8tggYuO+qi+woLOw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:ece8:c906:a370:a858]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa601e37-eae8-4a3b-7426-08d8c91cc3fa
x-ms-traffictypediagnostic: SN6PR04MB4045:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB404538BCF0E5B6048E96D0C89BB39@SN6PR04MB4045.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DjyyENimrsqW+dopPKUnvoTMv8VvT42tfJbDKUCB+oI2eOxJuTxtGdCmvZqRuhhlJXv9h8wzlWLuoAr0+/ATJjaE9ItAfWOX8sHM2tTKqgMI3RmlX1TD+IIOVV/dbGIWNgi3Mqs1SSPy1BG942aRrUwZCw4YLOo37yZ8Zud9L/XB98+Ygp5pC/S0yRhuhFmfOH0vwtUlePwtWKj0M61Ofoo2dkWyb/LhodW+dvVakiyPKeXoW8bDAt3QfiFktoKSYKA9Q49DYHjWLWA77CggH6nxoE+0IwZtefte5sya/q1fQzVbX6t3qiHuCu8cNwGCnBdtqXQ0SPK9h3HOlMEoO9R33wkiJCtDUqy/sSUK+7T7z7T9CFlV2CKh0xsJ+Kab+pz+KLQNNSF9GM2/CRu6sN/8YUz2VwzUob+ZLDho8JQ4UkBgYONdqEARVKjPZcLhTS2JxB2aMlyY0PJj5B5UidddC7KhaYdIlFGPzpW5v7U/RKAn/M9e2PPqQ8wZhW+HnLOFlQjixrG65H4MmFSCeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(5660300002)(4326008)(186003)(83380400001)(316002)(8676002)(52536014)(71200400001)(110136005)(6506007)(53546011)(2906002)(91956017)(54906003)(86362001)(66446008)(6636002)(7696005)(55016002)(66946007)(33656002)(478600001)(8936002)(9686003)(66476007)(76116006)(64756008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IH/SomQyeOyM0xLeKw3cUAXhw9LFd/PNVFaug9pAoVBiZsRTv+FLjNKq3IYN?=
 =?us-ascii?Q?Btm9tmJ6dWMm28dWWMUdc4Qwt2zlL9qee2+9/xpYaubJkjCKfE5RLn0q4Zmk?=
 =?us-ascii?Q?NDGcughfEKNqNSQG54cUPo+beEIfLk8qMigpKSAa4djrTgo/k6yJ5e5CfTct?=
 =?us-ascii?Q?o0V+Cdvt3GF3IqkHcPlaiQ6H7W8dWrrhyCQHdZlDgBGIHQbewmYzCIMFOEpx?=
 =?us-ascii?Q?ZvlFXX+lmWbWQls31bZWSONHybCKSvU5jjDmUb7Nfi3m7jwK9cOnq37Tbc/0?=
 =?us-ascii?Q?EDU0YjWGBuseTKlF/fmKHb/LT2rHzvpA7/ucuzhSs41CDjG7ikCvZKfZ0xp5?=
 =?us-ascii?Q?LPh7Qd++WIzLKm6jekLU1IXZ2+jD75b3hxEf4WZtvPOZKYt8e3n7dNyHtwqI?=
 =?us-ascii?Q?hAFVwMmyU1U5EtW3KAkTn4EZ8PqLRFhy7pKGfk9Cl0c2FtKF6VL3VttkFvtg?=
 =?us-ascii?Q?A3QbRwoYUQMYw+ub3JiF/vwEscbz2dUllD64AljZ2GibC61Hpmi3M7NdMaHj?=
 =?us-ascii?Q?4b+Vnjh7WXP7hwaZdZJdof7bLjppJlGCm5029Wv4qd/05R3yfdHGahaMQT+E?=
 =?us-ascii?Q?no/dbW3f/c313PVywMEt9WvjwfrogT1VqZtgR9Pp25/wKXt0zdhe02o8msVo?=
 =?us-ascii?Q?CgBv02CAzPT6lnMXvL7lKVcE+ZyAqBruSiojJwRlxpPfiHL6nnZrVOY3nr9i?=
 =?us-ascii?Q?Xae9BRFNaxOhxhx4aYkfAzP4Elc8aReyjIdLCKOKzja0iX1v88j1VOzY8dPO?=
 =?us-ascii?Q?/3iIEWYqaF76Zq3kVNeSBkPArrjOEyQwhIc0wfZY2WAK8emBMcV26HNX3Ia3?=
 =?us-ascii?Q?lb0wOTMlay2ptPSNCT3iCkYP2ekS4d4XR0XiEIHxnTwpLiGqgbbH6rf79Bet?=
 =?us-ascii?Q?c5G7kBsjwnROOj9rSmPPYQxv4uJkP3879+zRZl4n0ZjOOVnXSQ04JakhasO7?=
 =?us-ascii?Q?Xb5AiDxJzugUmP5EtetiueAwIos3WJbmFrBiTgUfLKr+Zwzbuc6vlZGbvRm6?=
 =?us-ascii?Q?6ZhyPb6GnBXJWF1pfOnUawbxjSXUkE7CdYGSDuAdT34V+pPOM93/kOVcjtfd?=
 =?us-ascii?Q?DDbxHECkiwg+3ghG8dKkMFgJmuBY91is838bAKjLLS6guVE11iLLS1NPJkld?=
 =?us-ascii?Q?66/d+f+pCZ07IZ62ZMlmfaFECQYzuyo0sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa601e37-eae8-4a3b-7426-08d8c91cc3fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 14:54:25.6013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WFmplkvD8sQMaiq/lYC2HK09LKCfSalwAqdt1DYMmzyeyHW29wg2P64AP4ZyotMtYytEfSZdIVXULSzWWflk1dXVyuXbYcRKhAexm9wTjG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4045
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/02/2021 12:57, Filipe Manana wrote:=0A=
> On Thu, Feb 4, 2021 at 10:23 AM Naohiro Aota <naohiro.aota@wdc.com> wrote=
:=0A=
>>=0A=
>> This is the 3/3 patch to enable tree-log on zoned filesystems.=0A=
>>=0A=
>> The allocation order of nodes of "fs_info->log_root_tree" and nodes of=
=0A=
>> "root->log_root" is not the same as the writing order of them. So, the=
=0A=
>> writing causes unaligned write errors.=0A=
>>=0A=
>> Reorder the allocation of them by delaying allocation of the root node o=
f=0A=
>> "fs_info->log_root_tree," so that the node buffers can go out sequential=
ly=0A=
>> to devices.=0A=
>>=0A=
>> Cc: Filipe Manana <fdmanana@gmail.com>=0A=
>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>> ---=0A=
>>  fs/btrfs/disk-io.c  | 12 +++++++-----=0A=
>>  fs/btrfs/tree-log.c | 27 +++++++++++++++++++++------=0A=
>>  2 files changed, 28 insertions(+), 11 deletions(-)=0A=
>>=0A=
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c=0A=
>> index 84c6650d5ef7..c2576c5fe62e 100644=0A=
>> --- a/fs/btrfs/disk-io.c=0A=
>> +++ b/fs/btrfs/disk-io.c=0A=
>> @@ -1298,16 +1298,18 @@ int btrfs_init_log_root_tree(struct btrfs_trans_=
handle *trans,=0A=
>>                              struct btrfs_fs_info *fs_info)=0A=
>>  {=0A=
>>         struct btrfs_root *log_root;=0A=
>> -       int ret;=0A=
>>=0A=
>>         log_root =3D alloc_log_tree(trans, fs_info);=0A=
>>         if (IS_ERR(log_root))=0A=
>>                 return PTR_ERR(log_root);=0A=
>>=0A=
>> -       ret =3D btrfs_alloc_log_tree_node(trans, log_root);=0A=
>> -       if (ret) {=0A=
>> -               btrfs_put_root(log_root);=0A=
>> -               return ret;=0A=
>> +       if (!btrfs_is_zoned(fs_info)) {=0A=
>> +               int ret =3D btrfs_alloc_log_tree_node(trans, log_root);=
=0A=
>> +=0A=
>> +               if (ret) {=0A=
>> +                       btrfs_put_root(log_root);=0A=
>> +                       return ret;=0A=
>> +               }=0A=
>>         }=0A=
>>=0A=
>>         WARN_ON(fs_info->log_root_tree);=0A=
>> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c=0A=
>> index 8be3164d4c5d..7ba044bfa9b1 100644=0A=
>> --- a/fs/btrfs/tree-log.c=0A=
>> +++ b/fs/btrfs/tree-log.c=0A=
>> @@ -3159,6 +3159,19 @@ int btrfs_sync_log(struct btrfs_trans_handle *tra=
ns,=0A=
>>         list_add_tail(&root_log_ctx.list, &log_root_tree->log_ctxs[index=
2]);=0A=
>>         root_log_ctx.log_transid =3D log_root_tree->log_transid;=0A=
>>=0A=
>> +       if (btrfs_is_zoned(fs_info)) {=0A=
>> +               mutex_lock(&fs_info->tree_log_mutex);=0A=
>> +               if (!log_root_tree->node) {=0A=
> =0A=
> As commented in v14, the log root tree is not protected by=0A=
> fs_info->tree_log_mutex anymore.=0A=
> It is fs_info->tree_root->log_mutex as of 5.10.=0A=
> =0A=
> Everything else was addressed and looks good.=0A=
> Thanks.=0A=
=0A=
David, can you add this or should we send an incremental patch?=0A=
This survived fstests -g quick run with lockdep enabled.=0A=
=0A=
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c=0A=
index 7ba044bfa9b1..36c4a60d20dc 100644=0A=
--- a/fs/btrfs/tree-log.c=0A=
+++ b/fs/btrfs/tree-log.c=0A=
@@ -3160,7 +3160,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,=
=0A=
        root_log_ctx.log_transid =3D log_root_tree->log_transid;=0A=
        if (btrfs_is_zoned(fs_info)) {=0A=
-               mutex_lock(&fs_info->tree_log_mutex);=0A=
+               mutex_lock(&fs_info->tree_root->log_mutex);=0A=
                if (!log_root_tree->node) {=0A=
                        ret =3D btrfs_alloc_log_tree_node(trans, log_root_t=
ree);=0A=
                        if (ret) {=0A=
@@ -3169,7 +3169,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,=
=0A=
                                goto out;=0A=
                        }=0A=
                }=0A=
-               mutex_unlock(&fs_info->tree_log_mutex);=0A=
+               mutex_unlock(&fs_info->tree_root->log_mutex);=0A=
        }=0A=
        /*=0A=
