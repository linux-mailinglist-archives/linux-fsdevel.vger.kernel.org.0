Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DCB7414CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjF1PWV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjF1PWU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:22:20 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B010268E
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 08:22:18 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3426f04daf8so5437935ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 08:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687965737; x=1690557737;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MvQDQrOqVmgpQjFzLOfLlunva873RcqwEO0Tt7aEIYA=;
        b=ErWqZdIY1HduXefQcC65bezs3qnpEmO67tbDgV8uJAjCtJ6Yp5sOWaQfS5QSr7yjV0
         XVJdxzcahXR8bjWVkI1Y9lOuUxo86C1aUJ47OXdFj4KnAT/Z//uoWh0BPXGIHFWnM8eN
         HprTETcjmTPGsv7DSAGu0g4BiqNgYbO8miVjtrHaUySkpPDTspDWBmS5bjKsCNemofUz
         N3UvQ7NoxaOu12nWmi9yQgWfd8y5eiFn6dic8zIdvWO1DipUqvX9p29USqXt1QvzHPA6
         dd6qeavMqzm34ahVv4T0yXaBcYsjptDdub9UvkOvx5Ib56amBf/ysujDrxFc2kqyQcHQ
         0c3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687965737; x=1690557737;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MvQDQrOqVmgpQjFzLOfLlunva873RcqwEO0Tt7aEIYA=;
        b=Nl9LbFtGIek5N4xYv/ubEgsC7+7zgBPgYu1sGbXON//vnhYA6nhKThbBV+729eoJzf
         F7K1HTk5ewIEqjy7KReUXeoj4Yo1VK0uKRYwIbyDaD3VbXDAAN+WWUKtDjcnm93ZSlAr
         N6uyQLgzNlcFBRMqVCFa3xttknzTjEDX/IlDKAMj/4c0sj9ICrJ9z/3wtAIgkEO/GFIp
         8aHQ23mVcOzkmEOXD413EhL8B9MTU0PmoCICp1A16X+vBcxM5GC7kZLhGt3tRKLsc2YG
         knSJXU8d45YffV9PsH7ZSgoagc4OMiPDIjG5KQiXxY7i2lZWfrndiEtZcIMyna0bb9Si
         Xn2g==
X-Gm-Message-State: AC+VfDzAu5t6TzfA1PLZDECbWXJeI2I1nQDJ0kUsQ7THE8PnrrDMF18K
        oeH6ZPt/9ZmJaInXcky6A/GK+A==
X-Google-Smtp-Source: ACHHUZ4DX7uqUU8CdAqlLRFd7MykWx8/9UOLnCEQFrKqkAOOZdbIXIePCAD28a24zYZXTtOewoBpAQ==
X-Received: by 2002:a6b:3b06:0:b0:780:cde6:3e22 with SMTP id i6-20020a6b3b06000000b00780cde63e22mr17460149ioa.0.1687965737367;
        Wed, 28 Jun 2023 08:22:17 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v20-20020a6b5b14000000b007836c7e8dccsm1522747ioh.17.2023.06.28.08.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 08:22:16 -0700 (PDT)
Message-ID: <03308df9-7a6f-4e55-40c8-6f57c5b67fe6@kernel.dk>
Date:   Wed, 28 Jun 2023 09:22:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [GIT PULL] bcachefs
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
 <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
 <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
 <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
 <20230627201524.ool73bps2lre2tsz@moria.home.lan>
 <c06a9e0b-8f3e-4e47-53d0-b4854a98cc44@kernel.dk>
 <20230628040114.oz46icbsjpa4egpp@moria.home.lan>
 <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
In-Reply-To: <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/23 8:58?AM, Jens Axboe wrote:
> I should have something later today, don't feel like I fully understand
> all of it just yet.

Might indeed be delayed_fput, just the flush is a bit broken in that it
races with the worker doing the flush. In any case, with testing that, I
hit this before I got an umount failure on loop 6 of generic/388:


External UUID:                              724c7f1e-fed4-46e8-888a-2d5b170365b7
Internal UUID:                              4c356134-e573-4aa4-a7b6-c22ab260e0ff
Device index:                               0
Label:                                      
Version:                                    snapshot_trees
Oldest version on disk:                     snapshot_trees
Created:                                    Wed Jun 28 09:16:47 2023
Sequence number:                            0
Superblock size:                            816
Clean:                                      0
Devices:                                    1
Sections:                                   members
Features:                                   new_siphash,new_extent_overwrite,btree_ptr_v2,extents_above_btree_updates,btree_updates_journalled,new_varint,journal_no_flush,alloc_v2,extents_across_btree_nodes
Compat features:                            

Options:
  block_size:                               512 B
  btree_node_size:                          256 KiB
  errors:                                   continue [ro] panic 
  metadata_replicas:                        1
  data_replicas:                            1
  metadata_replicas_required:               1
  data_replicas_required:                   1
  encoded_extent_max:                       64.0 KiB
  metadata_checksum:                        none [crc32c] crc64 xxhash 
  data_checksum:                            none [crc32c] crc64 xxhash 
  compression:                              [none] lz4 gzip zstd 
  background_compression:                   [none] lz4 gzip zstd 
  str_hash:                                 crc32c crc64 [siphash] 
  metadata_target:                          none
  foreground_target:                        none
  background_target:                        none
  promote_target:                           none
  erasure_code:                             0
  inodes_32bit:                             1
  shard_inode_numbers:                      1
  inodes_use_key_cache:                     1
  gc_reserve_percent:                       8
  gc_reserve_bytes:                         0 B
  root_reserve_percent:                     0
  wide_macs:                                0
  acl:                                      1
  usrquota:                                 0
  grpquota:                                 0
  prjquota:                                 0
  journal_flush_delay:                      1000
  journal_flush_disabled:                   0
  journal_reclaim_delay:                    100
  journal_transaction_names:                1
  nocow:                                    0

members (size 64):
  Device:                                   0
    UUID:                                   dea79b51-ed22-4f11-9cb9-2117240419df
    Size:                                   20.0 GiB
    Bucket size:                            256 KiB
    First bucket:                           0
    Buckets:                                81920
    Last mount:                             (never)
    State:                                  rw
    Label:                                  (none)
    Data allowed:                           journal,btree,user
    Has data:                               (none)
    Discard:                                0
    Freespace initialized:                  0
initializing new filesystem
going read-write
initializing freespace
mounted version=snapshot_trees
seed = 1687442369
seed = 1687347478
seed = 1687934778
seed = 1687706987
seed = 1687173946
seed = 1687488122
seed = 1687828133
seed = 1687316163
seed = 1687511704
seed = 1687772088
seed = 1688057713
seed = 1687321139
seed = 1687166901
seed = 1687602318
seed = 1687659981
seed = 1687457702
seed = 1688000542
seed = 1687221947
seed = 1687740111
seed = 1688083754
seed = 1687314115
seed = 1687189436
seed = 1687664679
seed = 1687631074
seed = 1687691080
seed = 1688089920
seed = 1687962494
seed = 1687646206
seed = 1687636790
seed = 1687442248
seed = 1687532669
seed = 1687436103
seed = 1687626640
seed = 1687594091
seed = 1687235023
seed = 1687525509
seed = 1687766818
seed = 1688040782
seed = 1687293628
seed = 1687468804
seed = 1688129968
seed = 1687176698
seed = 1687603782
seed = 1687642709
seed = 1687844382
seed = 1687696290
seed = 1688169221
_check_generic_filesystem: filesystem on /dev/nvme0n1 is inconsistent
*** fsck.bcachefs output ***
fsck from util-linux 2.38.1
recovering from clean shutdown, journal seq 14642
journal read done, replaying entries 14642-14642
checking allocations
starting journal replay, 0 keys
checking need_discard and freespace btrees
checking lrus
checking backpointers to alloc keys
checking backpointers to extents
backpointer for missing extent
  u64s 9 type backpointer 0:7950303232:0 len 0 ver 0: bucket=0:15164:0 btree=extents l=0 offset=0:0 len=88 pos=1342182431:5745:U32_MAX, not fixing
checking extents to backpointers
checking alloc to lru refs
starting fsck
going read-write
mounted version=snapshot_trees opts=degraded,fsck,fix_errors,nochanges
0xaaaafeb6b580g: still has errors
*** end fsck.bcachefs output
*** mount output ***
/dev/vda2 on / type ext4 (rw,relatime,errors=remount-ro)
devtmpfs on /dev type devtmpfs (rw,relatime,size=8174296k,nr_inodes=2043574,mode=755)
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
securityfs on /sys/kernel/security type securityfs (rw,nosuid,nodev,noexec,relatime)
tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev)
devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000)
tmpfs on /run type tmpfs (rw,nosuid,nodev,size=3276876k,nr_inodes=819200,mode=755)
tmpfs on /run/lock type tmpfs (rw,nosuid,nodev,noexec,relatime,size=5120k)
cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot)
pstore on /sys/fs/pstore type pstore (rw,nosuid,nodev,noexec,relatime)
hugetlbfs on /dev/hugepages type hugetlbfs (rw,relatime,pagesize=2M)
mqueue on /dev/mqueue type mqueue (rw,nosuid,nodev,noexec,relatime)
debugfs on /sys/kernel/debug type debugfs (rw,nosuid,nodev,noexec,relatime)
tracefs on /sys/kernel/tracing type tracefs (rw,nosuid,nodev,noexec,relatime)
configfs on /sys/kernel/config type configfs (rw,nosuid,nodev,noexec,relatime)
fusectl on /sys/fs/fuse/connections type fusectl (rw,nosuid,nodev,noexec,relatime)
ramfs on /run/credentials/systemd-sysctl.service type ramfs (ro,nosuid,nodev,noexec,relatime,mode=700)
ramfs on /run/credentials/systemd-sysusers.service type ramfs (ro,nosuid,nodev,noexec,relatime,mode=700)
ramfs on /run/credentials/systemd-tmpfiles-setup-dev.service type ramfs (ro,nosuid,nodev,noexec,relatime,mode=700)
/dev/vda1 on /boot/efi type vfat (rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)
ramfs on /run/credentials/systemd-tmpfiles-setup.service type ramfs (ro,nosuid,nodev,noexec,relatime,mode=700)
*** end mount output

-- 
Jens Axboe

