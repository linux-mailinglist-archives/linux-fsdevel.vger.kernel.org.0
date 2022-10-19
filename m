Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C745C60395A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 07:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJSFtK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 01:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJSFtJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:49:09 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98D94E1BB;
        Tue, 18 Oct 2022 22:49:07 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b1so26330410lfs.7;
        Tue, 18 Oct 2022 22:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vNPqK162kgqaPz6V+s7e/jdWmhKxKvv/hKpuPFVppac=;
        b=B6qjDyGBm/aKVQr0poidauzQKsHGvfnmXQDokXWtIQVgrZHQ1T3Erw4Nygpkmefjed
         ubXpeYboLUlxAKFwLC5v02JInWbMBlk/zbnwnjoihioJ4KbXdNpi6de3Fb9r1SrK8E/O
         8A/jb/5bg0g+rm5VRuvenW44FRx30uvRGAHpsoOTYWpA3G/gswQyqkxpkTE8X7DKo+j8
         0TvYDB0DpGz3ZBEgazvIQWYK/bFdwWcxif6CVDEFWO+1oQ3m4om2PgLkPlYaDIgg3FQP
         WvcFBPv5sjkZxlhvN7HAWXFkQTPvNuDgWNUYY3XXHF/SY2e08BYqTTdq84VW7Z1ukVJf
         sudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vNPqK162kgqaPz6V+s7e/jdWmhKxKvv/hKpuPFVppac=;
        b=PfObBUNg/NB8QmNJgpYsPhPsspFvU++Jzq8MGTU5c1CExvbD9Xg43QbUmod4owXArS
         xf/Dbp/f+LeXcb1PXyKBzDgyJwzL9/zB1Vw4/bgTRJtEcNS2F/S6WQyPGHOvRfRPNkYX
         jLlEcbUryq4qkRsbfFiQJFrnxBgY30XgE/ue33DShnDVW9wstTGpgi+EGUr75QJR92U0
         zHpPpIzrBgqBdh+UplQtsp5ciFu21dAZH5q/emsYu90Ih8VPp3CoB4LCzXpOxsobpU+/
         44E7pJ5lsRSUzx7D/A16rCnTQ+agbU/2iWHi5wRZkPTM/xDjqwQ0Kmz/wQ4Y2XmIbC8A
         ua9A==
X-Gm-Message-State: ACrzQf0rTf/ORHK51zmvkGE6nh51c1Hr8OyNV1U4+mRmW5yJnpofPyGB
        wDG0fMFlCiiaWt/pVN6EV6DkmLwplgLfsfDv3JQ=
X-Google-Smtp-Source: AMsMyM6ZrZsopl5vtDdZTrR2QjxvZjDBdP1lnO5DmjKSqIRkFTS5xmOUv5Wwo/XD9eSEZio7Ytcv+uSheZX03RYSchw=
X-Received: by 2002:ac2:5f51:0:b0:4a4:5e1f:fce1 with SMTP id
 17-20020ac25f51000000b004a45e1ffce1mr2405597lfz.130.1666158545890; Tue, 18
 Oct 2022 22:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <1665725448-31439-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Y0lSChlclGPkwTeA@casper.infradead.org> <CAGWkznG=_A-3A8JCJEoWXVcx+LUNH=gvXjLpZZs0cRX4dhUJfQ@mail.gmail.com>
 <Y017BeC64GDb3Kg7@casper.infradead.org> <CAGWkznEdtGPPZkHrq6Y_+XLL37w12aC8XN8R_Q-vhq48rFhkSA@mail.gmail.com>
 <Y04Y3RNq6D2T9rVw@casper.infradead.org> <20221018223042.GJ2703033@dread.disaster.area>
 <20221019011636.GM2703033@dread.disaster.area> <20221019044734.GN2703033@dread.disaster.area>
In-Reply-To: <20221019044734.GN2703033@dread.disaster.area>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 19 Oct 2022 13:48:37 +0800
Message-ID: <CAGWkznEGMg293S7jOmZ7G-UhEBg6rQZhTd6ffhjoDgoFGvhFNw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, baocong.liu@unisoc.com,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 19, 2022 at 12:47 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Wed, Oct 19, 2022 at 12:16:36PM +1100, Dave Chinner wrote:
> > On Wed, Oct 19, 2022 at 09:30:42AM +1100, Dave Chinner wrote:
> > > On Tue, Oct 18, 2022 at 04:09:17AM +0100, Matthew Wilcox wrote:
> > > > On Tue, Oct 18, 2022 at 10:52:19AM +0800, Zhaoyang Huang wrote:
> > > > > On Mon, Oct 17, 2022 at 11:55 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > >
> > > > > > On Mon, Oct 17, 2022 at 01:34:13PM +0800, Zhaoyang Huang wrote:
> > > > > > > On Fri, Oct 14, 2022 at 8:12 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, Oct 14, 2022 at 01:30:48PM +0800, zhaoyang.huang wrote:
> > > > > > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > > > > > >
> > > > > > > > > Bellowing RCU stall is reported where kswapd traps in a live lock when shrink
> > > > > > > > > superblock's inode list. The direct reason is zombie page keeps staying on the
> > > > > > > > > xarray's slot and make the check and retry loop permanently. The root cause is unknown yet
> > > > > > > > > and supposed could be an xa update without synchronize_rcu etc. I would like to
> > > > > > > > > suggest skip this page to break the live lock as a workaround.
> > > > > > > >
> > > > > > > > No, the underlying bug should be fixed.
> > > > > >
> > > > > >     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > > Understand. IMHO, find_get_entry actruely works as an open API dealing
> > > > > with different kinds of address_spaces page cache, which requires high
> > > > > robustness to deal with any corner cases. Take the current problem as
> > > > > example, the inode with fault page(refcount=0) could remain on the
> > > > > sb's list without live lock problem.
> > > >
> > > > But it's a corner case that shouldn't happen!  What else is going on
> > > > at the time?  Can you reproduce this problem easily?  If so, how?
> > >
> > > I've been seeing this livelock, too. The reproducer is,
> > > unfortunately, something I can't share - it's a massive program that
> > > triggers a data corruption I'm working on solving.
> > >
> > > Now that I've
> > > mostly fixed the data corruption, long duration test runs end up
> > > livelocking in page cache lookup after several hours.
> > >
> > > The test is effectively writing a 100MB file with multiple threads
> > > doing reverse adjacent racing 1MB unaligned writes. Once the file is
> > > written, it is then mmap()d and read back from the filesystem for
> > > verification.
> > >
> > > THis is then run with tens of processes concurrently, and then under
> > > a massively confined memcg (e.g. 32 processes/files are run in a
> > > memcg with only 200MB of memory allowed). This causes writeback,
> > > readahead and memory reclaim to race with incoming mmap read faults
> > > and writes.  The livelock occurs on file verification and it appears
> > > to be an interaction with readahead thrashing.
> > >
> > > On my test rig, the physical read to write ratio is at least 20:1 -
> > > with 32 processes running, the 5s IO rates are:
> > >
> > > Device             tps    MB_read/s    MB_wrtn/s    MB_dscd/s    MB_read    MB_wrtn    MB_dscd
> > > dm-0          52187.20      3677.42      1345.92         0.00      18387       6729          0
> > > dm-0          62865.60      5947.29         0.08         0.00      29736          0          0
> > > dm-0          62972.80      5911.20         0.00         0.00      29556          0          0
> > > dm-0          59803.00      5516.72       133.47         0.00      27583        667          0
> > > dm-0          63068.20      5292.34       511.52         0.00      26461       2557          0
> > > dm-0          56775.60      4184.52      1248.38         0.00      20922       6241          0
> > > dm-0          63087.40      5901.26        43.77         0.00      29506        218          0
> > > dm-0          62769.00      5833.97        60.54         0.00      29169        302          0
> > > dm-0          64810.20      5636.13       305.63         0.00      28180       1528          0
> > > dm-0          65222.60      5598.99       349.48         0.00      27994       1747          0
> > > dm-0          62444.00      4887.05       926.67         0.00      24435       4633          0
> > > dm-0          63812.00      5622.68       294.66         0.00      28113       1473          0
> > > dm-0          63482.00      5728.43       195.74         0.00      28642        978          0
> > >
> > > This is reading and writing the same amount of file data at the
> > > application level, but once the data has been written and kicked out
> > > of the page cache it seems to require an awful lot more read IO to
> > > get it back to the application. i.e. this looks like mmap() is
> > > readahead thrashing severely, and eventually it livelocks with this
> > > sort of report:
> > >
> > > [175901.982484] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > [175901.985095] rcu:    Tasks blocked on level-1 rcu_node (CPUs 0-15): P25728
> > > [175901.987996]         (detected by 0, t=97399871 jiffies, g=15891025, q=1972622 ncpus=32)
> > > [175901.991698] task:test_write      state:R  running task     stack:12784 pid:25728 ppid: 25696 flags:0x00004002
> > > [175901.995614] Call Trace:
> > > [175901.996090]  <TASK>
> > > [175901.996594]  ? __schedule+0x301/0xa30
> > > [175901.997411]  ? sysvec_apic_timer_interrupt+0xb/0x90
> > > [175901.998513]  ? sysvec_apic_timer_interrupt+0xb/0x90
> > > [175901.999578]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> > > [175902.000714]  ? xas_start+0x53/0xc0
> > > [175902.001484]  ? xas_load+0x24/0xa0
> > > [175902.002208]  ? xas_load+0x5/0xa0
> > > [175902.002878]  ? __filemap_get_folio+0x87/0x340
> > > [175902.003823]  ? filemap_fault+0x139/0x8d0
> > > [175902.004693]  ? __do_fault+0x31/0x1d0
> > > [175902.005372]  ? __handle_mm_fault+0xda9/0x17d0
> > > [175902.006213]  ? handle_mm_fault+0xd0/0x2a0
> > > [175902.006998]  ? exc_page_fault+0x1d9/0x810
> > > [175902.007789]  ? asm_exc_page_fault+0x22/0x30
> > > [175902.008613]  </TASK>
> > >
> > > Given that filemap_fault on XFS is probably trying to map large
> > > folios, I do wonder if this is a result of some kind of race with
> > > teardown of a large folio...
> > >
> > > There is a very simple corruption reproducer script that has been
> > > written, but I haven't been using it. I don't know if long term
> > > running of the script here:
> > >
> > > https://lore.kernel.org/linux-xfs/d00aff43-2bdc-0724-1996-4e58e061ecfd@redhat.com/
> > >
> > > will trigger the livelock as the verification step is
> > > significantly different, but it will give you insight into the
> > > setup of the environment that leads to the livelock. Maybe you could
> > > replace the md5sum verification with a mmap read with xfs_io to
> > > simulate the fault load that seems to lead to this issue...
> >
> > FWIW, just tested this on a current Linus kernel. While there is
> > massive read-ahead thrashing on v6.0, the thrashing is largely gone
> > in v6.1-rc1+ and the iteration rate of the test is much, much
> > better. The livelock remains, however.
>
> Evidence is starting to point to an interaction with the multi-page
> folio support in the page cache.
>
> I removed the mapping_set_large_folios() calls in the XFS inode
> instantiation and the test code has now run over 55,000 iterations
> without failing.  The most iterations I'd seen with large folios
> enabled was about 7,000 - typically it would fail within 2-3,000
> iterations.
hint from my side. The original problem I raised is under v5.15 where
there is no folio yet.
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
