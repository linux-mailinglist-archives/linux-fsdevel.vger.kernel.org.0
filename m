Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F727A34EB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Sep 2023 11:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbjIQJ1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Sep 2023 05:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbjIQJ0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Sep 2023 05:26:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732C1ED;
        Sun, 17 Sep 2023 02:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Z+aC0zXdHCc6uureUTWFgaVoTUf6RgPh+KhdB5J8JSU=; b=QiguzArwDK2Mepi9M/SthfKtU2
        c/aITr3FwwU9zTdPgTXcDeL2lrddAQ956siCu+/HWWrHBnuNgq/8C6iNqsQj0kFKCl8Durr4Xjo3i
        vEBDqKZGxk0QT0/0AN801cxvPDR7EzrniGjwS0DLnHOG26GB/xOyC6d2Yd25f/TasW13Fkkx6bh1B
        //tRaV6onVPjGN8W6o9nuPHvsDTlJ4dNbKotqGKljyNrM62Gw+NjH2GL+t1WzJhjXFKyfyLD/Tmtb
        8HlU5jFF7htOhX56Hom1fNFF5XON/9u6it+0M9ttMC8qWfhNiWCIe0AJbIxGiSwI/WpEpiaRcVJFz
        o1mY2qbQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qho2h-00BZlC-24;
        Sun, 17 Sep 2023 09:26:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB0B2300388; Sun, 17 Sep 2023 11:26:16 +0200 (CEST)
Date:   Sun, 17 Sep 2023 11:26:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        mark.rutland@arm.com, Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Changhui Zhong <czhong@redhat.com>,
        yangerkun <yangerkun@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        chengzhihao <chengzhihao1@huawei.com>
Subject: Re: [czhong@redhat.com: [bug report] WARNING: CPU: 121 PID: 93233 at
 fs/dcache.c:365 __dentry_kill+0x214/0x278]
Message-ID: <20230917092616.GA8409@noisy.programming.kicks-ass.net>
References: <ZOWFtqA2om0w5Vmz@fedora>
 <20230823-kuppe-lassen-bc81a20dd831@brauner>
 <CAFj5m9KiBDzNHCsTjwUevZh3E3RRda2ypj9+QcRrqEsJnf9rXQ@mail.gmail.com>
 <CAHj4cs_MqqWYy+pKrNrLqTb=eoSOXcZdjPXy44x-aA1WvdVv0w@mail.gmail.com>
 <89d049ed-6bbf-bba7-80d4-06c060e65e5b@huawei.com>
 <20230917091031.GA1543@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230917091031.GA1543@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 17, 2023 at 11:10:32AM +0200, Peter Zijlstra wrote:
> On Sat, Sep 16, 2023 at 02:55:47PM +0800, Baokun Li wrote:
> > On 2023/9/13 16:59, Yi Zhang wrote:
> > > The issue still can be reproduced on the latest linux tree[2].
> > > To reproduce I need to run about 1000 times blktests block/001, and
> > > bisect shows it was introduced with commit[1], as it was not 100%
> > > reproduced, not sure if it's the culprit?
> > > 
> > > 
> > > [1] 9257959a6e5b locking/atomic: scripts: restructure fallback ifdeffery
> > Hello, everyone！
> > 
> > We have confirmed that the merge-in of this patch caused hlist_bl_lock
> > (aka, bit_spin_lock) to fail, which in turn triggered the issue above.
> 
> > [root@localhost ~]# insmod mymod.ko
> > [   37.994787][  T621] >>> a = 725, b = 724
> > [   37.995313][  T621] ------------[ cut here ]------------
> > [   37.995951][  T621] kernel BUG at fs/mymod/mymod.c:42!
> > [r[  oo 3t7@.l996o4c61al]h[o s T6t21] ~ ]#Int ernal error: Oops - BUG:
> > 00000000f2000800 [#1] SMP
> > [   37.997420][  T621] Modules linked in: mymod(E)
> > [   37.997891][  T621] CPU: 9 PID: 621 Comm: bl_lock_thread2 Tainted:
> > G            E      6.4.0-rc2-00034-g9257959a6e5b-dirty #117
> > [   37.999038][  T621] Hardware name: linux,dummy-virt (DT)
> > [   37.999571][  T621] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
> > BTYPE=--)
> > [   38.000344][  T621] pc : increase_ab+0xcc/0xe70 [mymod]
> > [   38.000882][  T621] lr : increase_ab+0xcc/0xe70 [mymod]
> > [   38.001416][  T621] sp : ffff800008b4be40
> > [   38.001822][  T621] x29: ffff800008b4be40 x28: 0000000000000000 x27:
> > 0000000000000000
> > [   38.002605][  T621] x26: 0000000000000000 x25: 0000000000000000 x24:
> > 0000000000000000
> > [   38.003385][  T621] x23: ffffd9930c698190 x22: ffff800008a0ba38 x21:
> > 0000000000000001
> > [   38.004174][  T621] x20: ffffffffffffefff x19: ffffd9930c69a580 x18:
> > 0000000000000000
> > [   38.004955][  T621] x17: 0000000000000000 x16: ffffd9933011bd38 x15:
> > ffffffffffffffff
> > [   38.005754][  T621] x14: 0000000000000000 x13: 205d313236542020 x12:
> > ffffd99332175b80
> > [   38.006538][  T621] x11: 0000000000000003 x10: 0000000000000001 x9 :
> > ffffd9933022a9d8
> > [   38.007325][  T621] x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 :
> > ffffd993320b5b40
> > [   38.008124][  T621] x5 : ffff0001f7d1c708 x4 : 0000000000000000 x3 :
> > 0000000000000000
> > [   38.008912][  T621] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
> > 0000000000000015
> > [   38.009709][  T621] Call trace:
> > [   38.010035][  T621]  increase_ab+0xcc/0xe70 [mymod]
> > [   38.010539][  T621]  kthread+0xdc/0xf0
> > [   38.010927][  T621]  ret_from_fork+0x10/0x20
> > [   38.011370][  T621] Code: 17ffffe0 90000020 91044000 9400000d (d4210000)
> > [   38.012067][  T621] ---[ end trace 0000000000000000 ]---
> 
> Is this arm64 or something? You seem to have forgotten to mention what
> platform you're using.

Is that an LSE or LLSC arm64 ?

Anyway, it seems that ARM64 shouldn't be using the fallback as it does
everything itself.

Mark, can you have a look please? At first glance the
atomic64_fetch_or_acquire() that's being used by generic bitops/lock.h
seems in order..
