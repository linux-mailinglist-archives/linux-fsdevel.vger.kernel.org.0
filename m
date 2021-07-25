Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938313D4EDF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jul 2021 19:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhGYQV6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jul 2021 12:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhGYQVv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jul 2021 12:21:51 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B618FC061764;
        Sun, 25 Jul 2021 10:02:21 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a7so8219257ljq.11;
        Sun, 25 Jul 2021 10:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=U6ZDW1rdpW4Ju714iWVKDGQ1s3sxUf5am9BR8X9bDW0=;
        b=bzhZ5+Xj3YmSevmDTeZu++ync7DGr9v03Nk6+Q1i7z+g1dAX5xnkuva9YNrWr9YhRB
         ntnjbE1/Tet/jcsJGa73cOsolUo+xsfpXQDF/Fr8EDVbjz1aXJgh8xH1dZ0aive7opoN
         Kk3IxWLqlTQLC47WQSvF6lMVz38IejJRpvQ6ZX4aAr5QKJ3jdrlWTFjdKG/I96gF8nFO
         TTIXVLDMLZ3cdVPLkyPz30cIcyC3CAkxIzfIY4bXolYSDbT/DXnuNRFH4QGtdcNbET91
         5D1u0w4X52elcWXDqT7BAc8zHhl/Zjln2Z4oAdBC1vI9d/FfAMCCePo1YK6mikk588zT
         O5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=U6ZDW1rdpW4Ju714iWVKDGQ1s3sxUf5am9BR8X9bDW0=;
        b=gLXQB4WSDRTGQ9FHfsOF0rYYrPWD9EDvO1jMGqv8TVJGA/iinOfego3cL4OA5/pQLe
         Qm2qmmLjv/ZJyFpDm8CWEgVKsxHaWfFKSRGK5sLcnCGypI2Oo8Ax1ZPoXnP/K/OEY1Fd
         wx7EZ7ntoF33b5FucWHvo2xRejt5VsAuchOvYxfW7OuTEN4yr541yNnw1wT5MyBWVf5A
         87acO/PB1p4TUxtkxdFqka/bEuthzAF6AKoy6IbyUbq9h5Ztt3yWd9BQpR8K/7dhSyXu
         hGBVaixwSsDPt812++iLD9MXHkWn1DyraeJ6hgmexP4txk+AqwdFoq+I98Fumw7iiRR1
         T2Mw==
X-Gm-Message-State: AOAM530z/y8vlBURT6b9IdF25toXFDKvpU3P576Qe8Pr3HxgykMXm3mv
        WbATsqmI7KVFmr40nJqrKsw=
X-Google-Smtp-Source: ABdhPJyBmhRcivncse1lvq/Bd/JD1ipEzEQC0EnemKCubbFX/En43DEYtZQTl5yc/mWBlhQfmHZ/qg==
X-Received: by 2002:a2e:5353:: with SMTP id t19mr9900009ljd.169.1627232540171;
        Sun, 25 Jul 2021 10:02:20 -0700 (PDT)
Received: from [192.168.0.14] (broadband-46-242-116-145.ip.moscow.rt.ru. [46.242.116.145])
        by smtp.gmail.com with ESMTPSA id k11sm2795263lfu.27.2021.07.25.10.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jul 2021 10:02:19 -0700 (PDT)
Subject: Re: [PATCH v26 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        pali@kernel.org, dsterba@suse.cz, aaptel@suse.com,
        willy@infradead.org, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, kari.argillander@gmail.com,
        oleksandr@natalenko.name
References: <20210402155347.64594-1-almaz.alexandrovich@paragon-software.com>
From:   Yan Pas <yanp.bugz@gmail.com>
Message-ID: <cc64ac69-f4e5-3fc4-1362-ced7cf68119a@gmail.com>
Date:   Sun, 25 Jul 2021 20:02:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210402155347.64594-1-almaz.alexandrovich@paragon-software.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi everyone!

I'm regular Arch-linux user and have been using your driver for a while
(https://aur.archlinux.org/packages/ntfs3-dkms/). There are a lot of
users who tested this patch and some of them, like me, have complaints.

I faced stalling of a kthread with some ntfs functions in a stacktrace
while rsyncing one NTFS partition (SATA) to another (USB HDD)
(https://aur.archlinux.org/packages/ntfs3-dkms/#comment-818819):

[ 5529.507567] INFO: task kworker/0:1:18 blocked for more than 1105 seconds.
[ 5529.507580]       Tainted: P           OE     5.13.4-arch1-1 #1
[ 5529.507584] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 5529.507586] task:kworker/0:1     state:D stack:    0 pid:   18
ppid:     2 flags:0x00004000
[ 5529.507598] Workqueue: usb_hub_wq hub_event
[ 5529.507612] Call Trace:
[ 5529.507615]  ? out_of_line_wait_on_bit_lock+0xb0/0xb0
[ 5529.507631]  __schedule+0x310/0x930
[ 5529.507641]  ? out_of_line_wait_on_bit_lock+0xb0/0xb0
[ 5529.507648]  schedule+0x5b/0xc0
[ 5529.507654]  bit_wait+0xd/0x60
[ 5529.507661]  __wait_on_bit+0x2a/0x90
[ 5529.507669]  __inode_wait_for_writeback+0xb0/0xe0
[ 5529.507680]  ? var_wake_function+0x20/0x20
[ 5529.507689]  writeback_single_inode+0x64/0x140
[ 5529.507699]  sync_inode_metadata+0x3d/0x60
[ 5529.507712]  ntfs_set_state+0x126/0x1a0 [ntfs3]
[ 5529.507738]  ni_write_inode+0x244/0xef0 [ntfs3]
[ 5529.507764]  ? pagevec_lookup_range_tag+0x24/0x30
[ 5529.507772]  ? __filemap_fdatawait_range+0x6f/0xf0
[ 5529.507785]  __writeback_single_inode+0x260/0x310
[ 5529.507795]  writeback_single_inode+0xa7/0x140
[ 5529.507803]  sync_inode_metadata+0x3d/0x60
[ 5529.507814]  ntfs_set_state+0x126/0x1a0 [ntfs3]
[ 5529.507834]  ntfs_sync_fs+0xf9/0x100 [ntfs3]
[ 5529.507857]  sync_filesystem+0x40/0x90
[ 5529.507868]  fsync_bdev+0x21/0x60
[ 5529.507874]  delete_partition+0x13/0x80
[ 5529.507882]  blk_drop_partitions+0x5b/0xa0
[ 5529.507889]  del_gendisk+0xa5/0x220

...


Also adding ntfs3 partition (1.4TB) to fstab makes booting much slower:
I see two lines in console (systemd version and some other line) and HDD
led constantly flickering (seems like ntfs3 is traversing entire
partition)
(https://aur.archlinux.org/pkgbase/ntfs3-dkms/edit-comment/?comment_id=818673).

Regards, Yan.

