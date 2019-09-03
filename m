Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7517A768C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 23:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfICVw3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 17:52:29 -0400
Received: from mail.thelounge.net ([91.118.73.15]:26785 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfICVw2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 17:52:28 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 46NLK42364zXMk;
        Tue,  3 Sep 2019 23:52:19 +0200 (CEST)
Subject: Re: "beyond 2038" warnings from loopback mount is noisy
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Qian Cai <cai@lca.pw>, Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Arnd Bergmann <arnd@arndb.de>
References: <1567523922.5576.57.camel@lca.pw>
 <CABeXuvoPdAbDr-ELxNqUPg5n84fubZJZKiryERrXdHeuLhBQjQ@mail.gmail.com>
 <20190903211747.GD2899@mit.edu>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <31a671ea-a00b-37da-5f30-558c3ab6d690@thelounge.net>
Date:   Tue, 3 Sep 2019 23:52:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903211747.GD2899@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Am 03.09.19 um 23:17 schrieb Theodore Y. Ts'o:
> I know of a truly vast number of servers in production all over the
> world which are using 128 byte inodes, and spamming the inodes at the
> maximum rate limit is a really bad idea.  This includes at some major
> cloud data centers where the life of individual servers in their data
> centers is well understood (they're not going to last until 2038)

well, i didn't ask the Fedora installer for 128 byte indoes in 2008 on
the 500 MB small /boot while the 6 GB rootfs has 256 byte while this
setups are surely targeted to last longer than 2038 until someone kills
Fedora with all the shiny new stuff nobody needs

but yes, don't start to spam me about it

[root@arrakis:~]$ tune2fs -l /dev/sda1
tune2fs 1.44.6 (5-Mar-2019)
Filesystem volume name:   boot
Last mounted on:          /boot
Filesystem UUID:          b834776d-69d1-49c6-97c1-d6d758a438f0
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index
filetype needs_recovery extent sparse_super uninit_bg
Filesystem flags:         signed_directory_hash
Default mount options:    (none)
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              130560
Block count:              521215
Reserved block count:     2
Free blocks:              455376
Free inodes:              130216
First block:              1
Block size:               1024
Fragment size:            1024
Reserved GDT blocks:      256
Blocks per group:         8192
Fragments per group:      8192
Inodes per group:         2040
Inode blocks per group:   255
Filesystem created:       Mon Aug 18 06:48:14 2008
Last mount time:          Sat Aug 17 02:49:03 2019
Last write time:          Tue Sep  3 02:03:44 2019
Mount count:              19
Maximum mount count:      30
Last checked:             Sat Dec 15 04:36:27 2018
Check interval:           31104000 (12 months)
Next check after:         Tue Dec 10 04:36:27 2019
Lifetime writes:          64 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               128
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      2cc862b9-dc3e-4707-b6ed-9a7fe724dd2e
Journal backup:           inode blocks
