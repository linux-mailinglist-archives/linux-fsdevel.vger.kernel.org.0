Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E0A2AD479
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgKJLMr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:12:47 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:8427 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgKJLMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007834; x=1636543834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rR+kcJYzTBtFGVj9hMlcIX6GTSlMSmu/cBpeQQw9ukQ=;
  b=O8sA4YLZZq69x4dcZtWjfUs55NUA52STxpDwlGroX+aXyUkC+9YC6CQe
   NR3vOSeQmPCGmCXYTev+0XiCpaV0IFfiMwHdfVOZsOWVc+OEyrYLvBD5W
   GnXjkmjr7MfJg6ty4+5tYHdqQuDzC7HHaT77SgqtC8o0vP3XNLZxtmBaP
   TW/gI6SV9akKg6y+XhtE1Rizr2Bf9ckctSm7T2CpwwXWmEEwsXsGt5LHN
   599ayob48xMD23JZy5aZjJm6Bw6qCMtBBdvREHp/58h55n+YNl8eMGXKE
   UIonwVnhD+vT+oFanUUAd7HgwkKCLnFn3su99GaqIEHERfRsLge2HsGJJ
   Q==;
IronPort-SDR: z975krHeJOroL+EdquJygzAqAtAZoZivKJkTNIwUWFWOeU9Db23uofn/WMJLfP5Do4xQ46yxrk
 baDR79vRnKCgc7gwLtlUXku+ujIq+omvdyp1OGinxBPFQb62rUCny7MfEhuJsb7uGpi7DBcsX+
 XUjfxu2IRes+2RRgh89IcA176S3fHFXgKWnxaTBLlAoSyUL6t76KrohmvrbweLDHS5YjFRId0m
 1jLdCvj5MjM5S47bHwwOUbssbSLQEPDsif9HHzix9aYDLwjRenzsESiqulZI/3xOukCYehIRzt
 GOo=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="255832460"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:30:34 +0800
IronPort-SDR: WzKfOcTLDZVeKezc1+CUlgctfUsXFiicdFfgnYoKN/EeUQOgkEwN16Icz0M+hzVO/B621ffo06
 fHF/4LnXNnqHqySDnS5/fOaHjycMfOPtCHkpPEnNKjV3fX2vjzS/hc5tMX3Wg0uY1sG3/cLbtm
 +i+6exy1TdWhVc2/OBu3Lg8dT4/jJIWpKT7s+lPp41c3Yv92I7L7RyAsjKtZGJF2Hqbg0rfhwl
 19yeFBX4QBmprik3aVo5Ie3lWXU1fVU9n3SMacgZrcE6DBKhZ5y4F8M058m7AVBkvJ1vSClXT3
 73FaUVj/2CKwf05m8uggI/Fk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 02:57:33 -0800
IronPort-SDR: nujxuMADzIKS8GDEONamK68YhgVoGQZcOecgyprgYedv1x9uEHsRpwoS0L+v1Ioj+6Wdf6I2v3
 CrAivy9Q8Bs8ON9xio9SFVippAH5LGQyYD8vlr4Hn/Tovz3bAoOwVhNV5UJyTpRR01kpJ14gOb
 YNqybJiDF9W6J9gGpy3e9z08fqidXnmYN9mJjRbSy3/w5yiXamqiAv6nG4B6F29ENZB4Kg+73t
 5UfXyhbUWuDxsfwqGp149jzLHiNJPa2UVpKYqKkMofx/TwRyHBKUXrBPSWsOIqvb5XFOv/X6NO
 07o=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 10 Nov 2020 03:12:45 -0800
Received: (nullmailer pid 1965970 invoked by uid 1000);
        Tue, 10 Nov 2020 11:12:44 -0000
Date:   Tue, 10 Nov 2020 20:12:44 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Amy Parker <enbyamy@gmail.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>, hare@suse.com,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v9 37/41] btrfs: split alloc_log_tree()
Message-ID: <20201110111244.jzp2qnqkw2nkzvtx@naota.dhcp.fujisawa.hgst.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <71b8f94034f04da6f69f1ea0720825aabc852a54.1604065695.git.naohiro.aota@wdc.com>
 <502ce12d-1ba6-5e3c-9aab-3b1b42a16bcf@toxicpanda.com>
 <CAE1WUT7r5EKbRUqQWZ_u3Jb49FapCSdUDEOT2OgFmJM9+=j+Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAE1WUT7r5EKbRUqQWZ_u3Jb49FapCSdUDEOT2OgFmJM9+=j+Jw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 02:10:47PM -0800, Amy Parker wrote:
>On Tue, Nov 3, 2020 at 2:06 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> On 10/30/20 9:51 AM, Naohiro Aota wrote:
>> > This is a preparation for the next patch. This commit split
>> > alloc_log_tree() to allocating tree structure part (remains in
>> > alloc_log_tree()) and allocating tree node part (moved in
>> > btrfs_alloc_log_tree_node()). The latter part is also exported to be used
>> > in the next patch.
>> >
>> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>> > ---
>> >   fs/btrfs/disk-io.c | 31 +++++++++++++++++++++++++------
>> >   fs/btrfs/disk-io.h |  2 ++
>> >   2 files changed, 27 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> > index 2b30ef8a7034..70885f3d3321 100644
>> > --- a/fs/btrfs/disk-io.c
>> > +++ b/fs/btrfs/disk-io.c
>> > @@ -1211,7 +1211,6 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
>> >                                        struct btrfs_fs_info *fs_info)
>> >   {
>> >       struct btrfs_root *root;
>> > -     struct extent_buffer *leaf;
>> >
>> >       root = btrfs_alloc_root(fs_info, BTRFS_TREE_LOG_OBJECTID, GFP_NOFS);
>> >       if (!root)
>> > @@ -1221,6 +1220,14 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
>> >       root->root_key.type = BTRFS_ROOT_ITEM_KEY;
>> >       root->root_key.offset = BTRFS_TREE_LOG_OBJECTID;
>> >
>> > +     return root;
>> > +}
>> > +
>> > +int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
>> > +                           struct btrfs_root *root)
>> > +{
>> > +     struct extent_buffer *leaf;
>> > +
>> >       /*
>> >        * DON'T set SHAREABLE bit for log trees.
>> >        *
>> > @@ -1233,26 +1240,31 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
>> >
>> >       leaf = btrfs_alloc_tree_block(trans, root, 0, BTRFS_TREE_LOG_OBJECTID,
>> >                       NULL, 0, 0, 0, BTRFS_NESTING_NORMAL);
>> > -     if (IS_ERR(leaf)) {
>> > -             btrfs_put_root(root);
>> > -             return ERR_CAST(leaf);
>> > -     }
>> > +     if (IS_ERR(leaf))
>> > +             return PTR_ERR(leaf);
>> >
>> >       root->node = leaf;
>> >
>> >       btrfs_mark_buffer_dirty(root->node);
>> >       btrfs_tree_unlock(root->node);
>> > -     return root;
>> > +
>> > +     return 0;
>> >   }
>> >
>> >   int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
>> >                            struct btrfs_fs_info *fs_info)
>> >   {
>> >       struct btrfs_root *log_root;
>> > +     int ret;
>> >
>> >       log_root = alloc_log_tree(trans, fs_info);
>> >       if (IS_ERR(log_root))
>>
>> newline.
>>
>> >               return PTR_ERR(log_root);
>> > +     ret = btrfs_alloc_log_tree_node(trans, log_root);
>> > +     if (ret) {
>> > +             kfree(log_root);
>>
>> btrfs_put_root(log_root);
>>
>> > +             return ret;
>> > +     }
>>
>> newline.  Thanks,
>>
>> Josef
>
>These should've shown up on the patch formatter... was it simply not run,
>or did the patch formatter not catch it?

Unfotunately, it was not caught by checkpatch.pl...
>
>Best regards,
>Amy Parker
>(they/them)
