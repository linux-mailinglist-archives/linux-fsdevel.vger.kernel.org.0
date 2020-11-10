Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEFA2AD71E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 14:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbgKJNJH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 08:09:07 -0500
Received: from de-smtp-delivery-52.mimecast.com ([62.140.7.52]:30535 "EHLO
        de-smtp-delivery-52.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729898AbgKJNJG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:09:06 -0500
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Nov 2020 08:09:04 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1605013743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yWFyQcgBmNB7VV5BQ8hRVRrGVhbcsHj2PXcOtG2njH0=;
        b=d9+iTufCP+7kyEx2Rci6mhep68Mx9WOGrqdSeAUIW0B3Mym++XzNkszE2v0yyjzOH6UAja
        JLTqNE7uGaYlCnPR+XFMG/xJR3JaYC4DskR7QLYdDryXUMldy+s6H2jQZeD1NazCoITp36
        nZFAOoCGik8UUFOF3CXI8e4MsDpx6LM=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2058.outbound.protection.outlook.com [104.47.12.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-34-yWAFRdVQPt-scngmFbTDVg-1; Tue, 10 Nov 2020 14:02:48 +0100
X-MC-Unique: yWAFRdVQPt-scngmFbTDVg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoUmCrODP0pTFV98ifNDvU9rBaDfJlIS09FK4qleJ/4W3XxTyNJK4nHeWNIysjs0rvjNkw6Loqva3iNQdZ1YThzIGr7COUQRAfbjq5GU1GsuejNnDMx2jm/VcjjgPsBSF4o8rU3fsYDAE+6GT1E5LEVtoojj2Mx3c2pqFo6VM1cY3AGBadjSziqkS+RRrGMIj5d0BKuaTeBEsDSCp5EhJBbUh1hQU7QOLRpudq26s9tkNxQ3DcVHv/qR0u6sdQ2+OAW51Jyi/SdoP9gz5E/wTEcXKPxaLEjRYZDpOTr2k1UCevW3lUXmANwiJ6lag0fYsSPRK0dNP0maCjuRybhtKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWFyQcgBmNB7VV5BQ8hRVRrGVhbcsHj2PXcOtG2njH0=;
 b=C0auRt0GSbYQAdH9O0lMzZyAm/8CG3gsL7POMealzs7QADX+cuy6B7bU23lzdjvtfu3U2EqC2NH1SCqhC9Nv+h39r4TqXfjebJlz2H4geraviD9MH3aniE/aC8G+HjgexUuzqmfaTjiafyxIdg00+RAW8C4iykQUw7JZO96LPaDozVkdu3VtljxIbaXE9AsTpQJsSPaazAabU3DAEctD9qTIcagNTBL2ZmHyKzGDGAD91teddYJG3AJifoaw/IfffyM19V5i1eoPFyhoo1vpMJnRgdKcPGRU9BTZLZ674i4b7mif7W4+FlAQwlmrEWfoMZtSd173Ht1E9tEBMWfYUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: paragon-software.com; dkim=none (message not signed)
 header.d=none;paragon-software.com; dmarc=none action=none
 header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR04MB7071.eurprd04.prod.outlook.com (2603:10a6:800:128::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 13:02:46 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::4dad:a2d3:5076:54f0]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::4dad:a2d3:5076:54f0%5]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 13:02:46 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        pali@kernel.org, dsterba@suse.cz, willy@infradead.org,
        rdunlap@infradead.org, joe@perches.com, mark@harmstone.com,
        nborisov@suse.com, linux-ntfs-dev@lists.sourceforge.net,
        anton@tuxera.com, dan.carpenter@oracle.com, hch@lst.de,
        ebiggers@kernel.org,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: Re: [PATCH v12 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
In-Reply-To: <20201106150909.1779040-1-almaz.alexandrovich@paragon-software.com>
References: <20201106150909.1779040-1-almaz.alexandrovich@paragon-software.com>
Date:   Tue, 10 Nov 2020 14:02:43 +0100
Message-ID: <87mtzptle4.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:705:6869:548c:4bf5:a395:2d47]
X-ClientProxiedBy: ZR0P278CA0019.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::6) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:705:6869:548c:4bf5:a395:2d47) by ZR0P278CA0019.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 13:02:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7aaf5b0-c89f-43b9-0e25-08d88578eaf1
X-MS-TrafficTypeDiagnostic: VI1PR04MB7071:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB70715E67D51D55E71D6946FDA8E90@VI1PR04MB7071.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9FbWWZKEmbsSb01a4w1IJVvkiQkLucZK9hAtLqWyC+IDpZZp6oYieUFkFyZ2rP8sxbfysSxPnUa6QhhBlr9O380ho4BXKnfMMfYIe3FVknuJ0VKAwxbyr1ujA5poUl7W5Fb+2UoCyd5MNYxAm2LufWunslkFcmW1QFPf7Gpc8ZQfx7PKJmLvva3DRco6TKIUh/zNvOt7dBE3K+Ua7rgrriEZw5zul5bfKMeCbIPC6wiRnxjuFMlVF0noMkwWLb7/uIdnf8UbSxFLt4o3XGU+u6pTSsnMrxGAsI/hb3R3ZD+nZTkFVdzSiGkg/G3Z8bEHhtFh/nnXnYN3rQrcyfJRAWfDJq6WpwPn4Y4KMU8B7gnY98dcrFQ+u4i+52y0hQIV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(39860400002)(366004)(136003)(7416002)(2906002)(16526019)(52116002)(6496006)(66946007)(83380400001)(66574015)(8676002)(186003)(36756003)(66476007)(66556008)(2616005)(5660300002)(8936002)(478600001)(316002)(86362001)(4326008)(6486002)(505234006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Gau6l73NDGfGOdhD+4Fiu/cJ4I28C2HqihYQefAI98gUYB49cso6rl3VxBHVII+OoSfYT2aIo+VyKKqms4oP9Ruk9+3bNpc2t2urI7FsSwXuRGJ5uIaupMSSJbeZEbQ95oxk1U1tHKC68shRNB/UnBK0022reaSozeCTg9bHBV4QCoJZyn5mwiIRXWsesxHKbYDGQ0v6RlQPNeYArb9AlQt30wcqNgOK7kV2oB41fPYbrK5zGawTGeGJdsAG8dP9uajahg0sRhpF0JyFwFYmANamZ7VwDqE8ACIvcnId29s12RImM76iv4AUWMLeZ5egCS4L68xSq96jP8aKERIi8nPhCh//BgzznY6HafFrdFRBX6nsZRlzJLhyoPy0Hlv2SbjhZISADe/XSUAAZzntwUT506GnbREL7/+RoZuaYhdCNmJPcUabMaY5UGrAzY8rttK4pe8Lcwr66DGTFq5OaO9mwFmi1wS3l/RbacNACTBC9uR7VLQqtt/P//yXEeoFcgPEehUUA7ii81OtSfU/D7OnDFKqPwIt5ly8b3CIsmqafKOVaVrZUz4wsmqE6KJgaJ9H9hkUAOaN2VhmCkltCOXeV0v5MTKyTiI31diUxfrT3f85vqW2U6aI9xpGe2JEjIdWR9ZX7aIzrValHQEVfDxLCgb+CvELx+2xwShMTPXwUQivhBJ8PKhWwQhEnolVxZX/vq0aERiNRJ7lOb4v2Q==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7aaf5b0-c89f-43b9-0e25-08d88578eaf1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 13:02:45.8760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5FEwwdeueOoT0uHlGcbKtA+NsqDCWnM5CKcv301Ewr814zayYJQli8T732upG+N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7071
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Konstantin,

Have you looked at Eric Biggers last comments regarding KASAN and
lockdep? You can enable KASAN in menuconfig in Kernel hacking > Memory
debugging > KASAN.

With v12 I'm still seeing the out-of-bound read and potential deadlock.


The bad read:

[   69.496132] BUG: KASAN: stack-out-of-bounds in hdr_insert_de+0x130/0x1b0
[   69.496137] Read of size 32 at addr ffff88800b4ffb48 by task ln/1246

[   69.496146] CPU: 0 PID: 1246 Comm: ln Not tainted 5.10.0-rc3+ #8
[   69.496150] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.13.0-48-gd9c812d-rebuilt.opensuse.org 04/01/2014
[   69.496154] Call Trace:
[   69.496161]  dump_stack+0x9a/0xcc
[   69.496168]  ? hdr_insert_de+0x130/0x1b0
[   69.496173]  print_address_description.constprop.0+0x1c/0x210
[   69.496179]  ? memcmp+0x38/0x60
[   69.496193]  ? hdr_insert_de+0x130/0x1b0
[   69.496198]  ? hdr_insert_de+0x130/0x1b0
[   69.496203]  kasan_report.cold+0x37/0x7c
[   69.496211]  ? mark_lock+0x13d0/0x1450
[   69.496216]  ? hdr_insert_de+0x130/0x1b0
[   69.496224]  check_memory_region+0xf9/0x1e0
[   69.496231]  memcpy+0x20/0x60
[   69.496238]  hdr_insert_de+0x130/0x1b0
[   69.496247]  ? hdr_find_e+0x3b0/0x3b0
[   69.496251]  ? lockdep_hardirqs_on_prepare+0x13d/0x200
[   69.496256]  ? quarantine_put+0x7d/0x190
[   69.496261]  ? trace_hardirqs_on+0x1c/0x100
[   69.496274]  indx_insert_into_root+0x398/0xdb0
[   69.496295]  ? indx_insert_entry+0x300/0x300
[   69.496299]  ? get_order+0x20/0x20
[   69.496305]  ? fnd_clear+0x133/0x190
[   69.496316]  ? indx_find+0x1ac/0x470
[   69.496329]  ? indx_free_children.isra.0+0x300/0x300
[   69.496335]  ? indx_init+0x210/0x210
[   69.496342]  ? kasan_unpoison_shadow+0x33/0x40
[   69.496354]  indx_insert_entry+0x1ab/0x300
[   69.496364]  ? indx_find_raw+0x880/0x880
[   69.496371]  ? down_write+0xd7/0x130
[   69.496381]  ? ktime_get_coarse_real_ts64+0xf6/0x120
[   69.496385]  ? trace_hardirqs_on+0x1c/0x100
[   69.496395]  ntfs_insert_reparse+0xf7/0x160
[   69.496401]  ? ntfs_objid_remove+0x90/0x90
[   69.496412]  ? kasan_unpoison_shadow+0x33/0x40
[   69.496418]  ? __kasan_kmalloc.constprop.0+0xc2/0xd0
[   69.496428]  ntfs_create_inode+0x177d/0x1af0
[   69.496454]  ? inode_write_data+0x280/0x280
[   69.496459]  ? inode_security+0x6b/0x90
[   69.496472]  ? may_create+0x203/0x210
[   69.496484]  ? ntfs_symlink+0xa7/0xf0
[   69.496488]  ntfs_symlink+0xa7/0xf0
[   69.496497]  ? ntfs_unlink+0x40/0x40
[   69.496513]  vfs_symlink+0x175/0x280
[   69.496522]  do_symlinkat+0xe1/0x190
[   69.496530]  ? __ia32_sys_mknod+0xa0/0xa0
[   69.496538]  ? lockdep_hardirqs_on_prepare+0x13d/0x200
[   69.496544]  ? syscall_enter_from_user_mode+0x1d/0x50
[   69.496553]  do_syscall_64+0x33/0x40
[   69.496559]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   69.496564] RIP: 0033:0x7f1436b4ed07
[   69.496569] Code: 73 01 c3 48 8b 0d 91 51 2c 00 f7 d8 64 89 01 48 83 c8 =
ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 0a 01 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 61 51 2c 00 f7 d8 64 89 01 48
[   69.496573] RSP: 002b:00007ffc280c9af8 EFLAGS: 00000202 ORIG_RAX: 000000=
000000010a
[   69.496581] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1436b=
4ed07
[   69.496585] RDX: 00007ffc280cb7b2 RSI: 00000000ffffff9c RDI: 00007ffc280=
cb7ab
[   69.496589] RBP: 00000000ffffff9c R08: 0000000000000001 R09: 00000000000=
00000
[   69.496593] R10: 0000000000000496 R11: 0000000000000202 R12: 00007ffc280=
cb7b2
[   69.496597] R13: 00007ffc280cb7ab R14: 0000000000000000 R15: 00000000000=
00000

[   69.496619] The buggy address belongs to the page:
[   69.496624] page:00000000167d0d9a refcount:0 mapcount:0 mapping:00000000=
00000000 index:0x0 pfn:0xb4ff
[   69.496628] flags: 0x100000000000000()
[   69.496634] raw: 0100000000000000 0000000000000000 ffffea00002d3fc8 0000=
000000000000
[   69.496639] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000=
000000000000
[   69.496643] page dumped because: kasan: bad access detected

[   69.496650] addr ffff88800b4ffb48 is located in stack of task ln/1246 at=
 offset 32 in frame:
[   69.496654]  ntfs_insert_reparse+0x0/0x160

[   69.496662] this frame has 1 object:
[   69.496666]  [32, 60) 're'

[   69.496672] Memory state around the buggy address:
[   69.496677]  ffff88800b4ffa00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 f1 f1
[   69.496681]  ffff88800b4ffa80: f1 f1 f1 f1 04 f2 00 f3 f3 f3 00 00 00 00=
 00 00
[   69.496685] >ffff88800b4ffb00: 00 00 00 00 00 f1 f1 f1 f1 00 00 00 04 f3=
 f3 f3
[   69.496689]                                                        ^
[   69.496693]  ffff88800b4ffb80: f3 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00
[   69.496697]  ffff88800b4ffc00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00
[   69.496701] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


That's in hdr_insert_de() when doing

    memcpy(before, de, de_size);

* * *

Then the lockdep splat:

[  166.670709] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  166.671122] WARNING: possible circular locking dependency detected
[  166.671509] 5.10.0-rc3+ #7 Not tainted
[  166.671509] ------------------------------------------------------
[  166.671509] bash/1134 is trying to acquire lock:
[  166.671509] ffff96854bd78108 (&ni->ni_lock){+.+.}-{3:3}, at: ntfs_set_si=
ze+0x53/0xd0
[  166.671509]=20
               but task is already holding lock:
[  166.671509] ffff96854bd78378 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, =
at: ntfs_file_write_iter+0x8a/0xb40
[  166.671509]=20
               which lock already depends on the new lock.

[  166.671509]=20
               the existing dependency chain (in reverse order) is:
[  166.671509]=20
               -> #1 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}:
[  166.671509]        down_write+0x2a/0x60
[  166.671509]        ntfs_set_state+0x8c/0x1a0
[  166.671509]        ntfs_create_inode+0x19e/0x1040
[  166.671509]        ntfs_atomic_open+0x1a3/0x210
[  166.671509]        lookup_open+0x383/0x600
[  166.671509]        path_openat+0x2b3/0xa20
[  166.671509]        do_filp_open+0x88/0x130
[  166.671509]        do_sys_openat2+0x97/0x150
[  166.671509]        __x64_sys_openat+0x54/0x90
[  166.671509]        do_syscall_64+0x33/0x40
[  166.671509]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  166.671509]=20
               -> #0 (&ni->ni_lock){+.+.}-{3:3}:
[  166.671509]        __lock_acquire+0x1452/0x2a20
[  166.671509]        lock_acquire+0x132/0x420
[  166.671509]        __mutex_lock+0x85/0x9e0
[  166.671509]        ntfs_set_size+0x53/0xd0
[  166.671509]        ntfs_extend_ex+0x176/0x1c0
[  166.671509]        ntfs_file_write_iter+0xc9/0xb40
[  166.671509]        new_sync_write+0x11f/0x1c0
[  166.671509]        vfs_write+0x1b2/0x230
[  166.671509]        ksys_write+0x68/0xe0
[  166.671509]        do_syscall_64+0x33/0x40
[  166.671509]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  166.671509]=20
               other info that might help us debug this:

[  166.671509]  Possible unsafe locking scenario:

[  166.671509]        CPU0                    CPU1
[  166.671509]        ----                    ----
[  166.671509]   lock(&sb->s_type->i_mutex_key#12);
[  166.671509]                                lock(&ni->ni_lock);
[  166.671509]                                lock(&sb->s_type->i_mutex_key=
#12);
[  166.671509]   lock(&ni->ni_lock);
[  166.671509]=20
                *** DEADLOCK ***

[  166.671509] 2 locks held by bash/1134:
[  166.671509]  #0: ffff968547b54438 (sb_writers#10){.+.+}-{0:0}, at: vfs_w=
rite+0x17e/0x230
[  166.671509]  #1: ffff96854bd78378 (&sb->s_type->i_mutex_key#12){+.+.}-{3=
:3}, at: ntfs_file_write_iter+0x8a/0xb40
[  166.671509]=20
               stack backtrace:
[  166.671509] CPU: 1 PID: 1134 Comm: bash Not tainted 5.10.0-rc3+ #7
[  166.671509] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.13.0-48-gd9c812d-rebuilt.opensuse.org 04/01/2014
[  166.671509] Call Trace:
[  166.671509]  dump_stack+0x77/0x97
[  166.671509]  check_noncircular+0xf2/0x110
[  166.671509]  __lock_acquire+0x1452/0x2a20
[  166.671509]  lock_acquire+0x132/0x420
[  166.671509]  ? ntfs_set_size+0x53/0xd0
[  166.671509]  ? __lock_acquire+0x39d/0x2a20
[  166.671509]  __mutex_lock+0x85/0x9e0
[  166.671509]  ? ntfs_set_size+0x53/0xd0
[  166.671509]  ? ntfs_set_size+0x53/0xd0
[  166.671509]  ? lock_acquire+0x132/0x420
[  166.671509]  ntfs_set_size+0x53/0xd0
[  166.671509]  ntfs_extend_ex+0x176/0x1c0
[  166.671509]  ntfs_file_write_iter+0xc9/0xb40
[  166.671509]  ? lock_acquire+0x132/0x420
[  166.671509]  new_sync_write+0x11f/0x1c0
[  166.671509]  vfs_write+0x1b2/0x230
[  166.671509]  ksys_write+0x68/0xe0
[  166.671509]  do_syscall_64+0x33/0x40
[  166.671509]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  166.671509] RIP: 0033:0x7fe486a68204
[  166.671509] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 80 =
00 00 00 00 8b 05 aa d1 2c 00 48 63 ff 85 c0 75 13 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 54 f3 c3 66 90 55 53 48 89 d5 48 89 f3 48 83
[  166.671509] RSP: 002b:00007ffd4b76fee8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[  166.671509] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fe486a=
68204
[  166.671509] RDX: 0000000000000004 RSI: 000055b1dd9bb7a0 RDI: 00000000000=
00001
[  166.671509] RBP: 000055b1dd9bb7a0 R08: 000000000000000a R09: 00000000000=
00000
[  166.671509] R10: 000000000000000a R11: 0000000000000246 R12: 00000000000=
00004

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

