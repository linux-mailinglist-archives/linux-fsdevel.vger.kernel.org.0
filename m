Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9459F6055D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 05:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiJTDM6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 23:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiJTDM4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 23:12:56 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290BC16F418;
        Wed, 19 Oct 2022 20:12:55 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b18so24577791ljr.13;
        Wed, 19 Oct 2022 20:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TAAaUPqDsSPzfLx61IZ8TOAPBXFdQdRUkaWX9o1g5sY=;
        b=kvgFzeHsjyjFVBhVWML7u2dUwfBldCZsk5SmVRovZwUIYMXEbRfv7TZU35NqQq4Gg7
         C5KhN1/6MZCDQhE/vojGLVdrJIsAHq6fgUjYeDs4sQ69f0rLLlvAKoJx8PPZNS6hWICm
         mgvsvRBoV5nxxfFnD7kDayvh5fnJOPLb6sQfGfibSVXPiJtqibnH6VWi122qY/07F26v
         xUrJ/ReuGU284m+8D660oERh2u/eU0j82IiffL+mv8ImZvahO0NMwqK8qzWouMqs/71p
         iaPzcW/7vABL/RHYTgDr9ebaVDtIlQl8wfklmrY2jHMyutFWFOrrQYJMUrkef5l16G9d
         5npA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TAAaUPqDsSPzfLx61IZ8TOAPBXFdQdRUkaWX9o1g5sY=;
        b=5meiejyTicUvcjUDwlhiu/sYg/vlZyT1k8DGqhYX+JiZjLHtbcxeQefhJAXZqjZZp0
         6DPWIP2iIpzv/wpMut4MYZckWZkPbJLzr412oc78Y6yaw9V2ZJvt6XVWcRnSnZY56/KI
         kosKbmBW4nWkIMaVEGsDDwDdIf132Ju3hpyYmZAkKg5+YpV7D2UbsXzpdzz24ORcAj1k
         E5FffcwBKBOPqYuTaApWFoPHP6YdYUARZ6OXZNRlzYB73trx9F758KM14oAkDb9JiKgM
         AbfIyPa6LyNWElJqis15pbaJDVLfLIZoKQ6Fn3tVzdFLTldx6EO4cNSsOnuTBJHhlUAi
         K/rQ==
X-Gm-Message-State: ACrzQf0lSc6UO82nam4w9qLRDOBfmJlq3hTvumEBLQDJoP+KEWVODS+K
        HPI+1nZIVvKoEH+NmQUm5N/F+LiXG43fD1L7IuY=
X-Google-Smtp-Source: AMsMyM5tU4ck4aYXLX0LYGFEE9J2fcTvSMA+tclGw8ITikyTh2ARgmzG+OaznbJrQ3o307Udj3tO0ynoS/KMEj/picM=
X-Received: by 2002:a2e:beaa:0:b0:25e:34d0:4d57 with SMTP id
 a42-20020a2ebeaa000000b0025e34d04d57mr4099509ljr.329.1666235573028; Wed, 19
 Oct 2022 20:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <1665725448-31439-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Y0lSChlclGPkwTeA@casper.infradead.org> <CAGWkznG=_A-3A8JCJEoWXVcx+LUNH=gvXjLpZZs0cRX4dhUJfQ@mail.gmail.com>
 <Y017BeC64GDb3Kg7@casper.infradead.org> <CAGWkznEdtGPPZkHrq6Y_+XLL37w12aC8XN8R_Q-vhq48rFhkSA@mail.gmail.com>
 <Y04Y3RNq6D2T9rVw@casper.infradead.org> <20221018223042.GJ2703033@dread.disaster.area>
 <Y0/kZbIvMgkNhWpM@bfoster> <20221020020451.GS2703033@dread.disaster.area>
In-Reply-To: <20221020020451.GS2703033@dread.disaster.area>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Thu, 20 Oct 2022 11:12:24 +0800
Message-ID: <CAGWkznGkLB2zg8ref51YZWq=bso6wBnTg--MguQORno-yQd3nQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
To:     Dave Chinner <david@fromorbit.com>
Cc:     Brian Foster <bfoster@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
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

On Thu, Oct 20, 2022 at 10:04 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Wed, Oct 19, 2022 at 07:49:57AM -0400, Brian Foster wrote:
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
> >
> > I somewhat recently tracked down a hugepage/swap problem that could
> > manifest as a softlockup in the folio lookup path (due to indefinite
> > folio_try_get_rcu() failure):
> >
> > https://lore.kernel.org/linux-mm/20220906190602.1626037-1-bfoster@redhat.com/
> >
> > It could easily be something different leading to the same side effect,
> > particularly since I believe the issue I saw was introduced in v5.19,
> > but might be worth a test if you have a reliable reproducer.
>
> Tests run and, unfortunately, that patch doesn't prevent/fix the
> problem either.
Could you please help to test the following change which breaks the
livelock by surpassing the zero-refcount page directly without reset
iterate to ROOT.

      if (!folio_try_get_rcu(folio)) {
               goto retry;
      }
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
