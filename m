Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B32E41752BB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 05:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCBEjI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 23:39:08 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40567 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgCBEjH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 23:39:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id l184so2321457pfl.7;
        Sun, 01 Mar 2020 20:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pEvSzl+X6hYVKhxERuc6e31mt38DDFow1Yrd5wm475s=;
        b=Nw5zbqolrtfOj6RJ7YurK3HwSyguNBVyKyZJKSltIJCv7wyhLkVtsTKsX/EIl0zrbz
         LbnnhALKYVHIy6ppEISChICpN9l0m59jPyo2ozTDvqUJH4eO24jSS9PALcaeLrl0eIh4
         v9+8IpGE4dPeYHNpgESK9eWKtDSK67oLTnnoRkU0bvj/oRv3VS/wXqQceJ0akL7nVP2x
         qg+mu7i0jvIthaW/7XIJpz/M8/+dt+mT81YuVZaGLUBvjzMcTmfGDPyzbnCZg/tN1LFA
         /G4KeMdM7RWj2zXmQ8GcpUt7UQdvrbh50u5MQmgOndrdtsn87HcbIC/EUVqXJphBXSJx
         SMdQ==
X-Gm-Message-State: APjAAAVr20YMh+dnfhxSJaQJjMAzCwSWvY2VlUnp06BRliSjQKqnPtMR
        MciUYKOBpUIyj1fcHxAqHVE=
X-Google-Smtp-Source: APXvYqwRuCnYEwvhl7qqY3I0FXBF6JiH71qUWNDUb5FXj5wH7F/xAtsTjroDCfLGZ7yBJsZ1+gFJNw==
X-Received: by 2002:aa7:8502:: with SMTP id v2mr15647930pfn.232.1583123946405;
        Sun, 01 Mar 2020 20:39:06 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:7869:cc6e:b1f7:9f7d? ([2601:647:4000:d7:7869:cc6e:b1f7:9f7d])
        by smtp.gmail.com with ESMTPSA id o66sm4548494pfb.93.2020.03.01.20.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2020 20:39:05 -0800 (PST)
Subject: Re: WARNING: bad unlock balance in rcu_core
To:     Dmitry Vyukov <dvyukov@google.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Cc:     syzbot <syzbot+36baa6c2180e959e19b1@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jan Kara <jack@suse.cz>,
        Miao Xie <miaoxie@huawei.com>,
        Anton Altaparmakov <aia21@cantab.net>
References: <000000000000c0bffa0586795098@google.com>
 <0000000000005edcd0059503b4aa@google.com>
 <20191016100134.GA20076@architecture4>
 <CACT4Y+bG+DyGuj__tTaVqzr3D7jxEaxL=vbtcsfhnAS2iSWvTQ@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <ac02c4c9-86c2-5c40-5add-b5e7ec0aab7d@acm.org>
Date:   Sun, 1 Mar 2020 20:39:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bG+DyGuj__tTaVqzr3D7jxEaxL=vbtcsfhnAS2iSWvTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-02-27 07:18, Dmitry Vyukov wrote:
> On Wed, Oct 16, 2019 at 11:58 AM Gao Xiang <gaoxiang25@huawei.com> wrote:
>>
>> Hi,
>>
>> On Wed, Oct 16, 2019 at 02:27:07AM -0700, syzbot wrote:
>>> syzbot has found a reproducer for the following crash on:
>>>
>>> HEAD commit:    0e9d28bc Add linux-next specific files for 20191015
>>> git tree:       linux-next
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=11745608e00000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3d84ca04228b0bf4
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=36baa6c2180e959e19b1
>>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159d297f600000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16289b30e00000
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+36baa6c2180e959e19b1@syzkaller.appspotmail.com
>>>
>>> =====================================
>>> WARNING: bad unlock balance detected!
>>> 5.4.0-rc3-next-20191015 #0 Not tainted
>>> -------------------------------------
>>> syz-executor276/8897 is trying to release lock (rcu_callback) at:
>>> [<ffffffff8160e7a4>] __write_once_size include/linux/compiler.h:226 [inline]
>>> [<ffffffff8160e7a4>] __rcu_reclaim kernel/rcu/rcu.h:221 [inline]
>>> [<ffffffff8160e7a4>] rcu_do_batch kernel/rcu/tree.c:2157 [inline]
>>> [<ffffffff8160e7a4>] rcu_core+0x574/0x1560 kernel/rcu/tree.c:2377
>>> but there are no more locks to release!
>>>
>>> other info that might help us debug this:
>>> 1 lock held by syz-executor276/8897:
>>>  #0: ffff88809a3cc0d8 (&type->s_umount_key#40/1){+.+.}, at:
>>> alloc_super+0x158/0x910 fs/super.c:229
>>>
>>> stack backtrace:
>>> CPU: 0 PID: 8897 Comm: syz-executor276 Not tainted 5.4.0-rc3-next-20191015
>>> #0
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>>> Google 01/01/2011
>>> Call Trace:
>>>  <IRQ>
>>>  __dump_stack lib/dump_stack.c:77 [inline]
>>>  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>>>  print_unlock_imbalance_bug kernel/locking/lockdep.c:4008 [inline]
>>>  print_unlock_imbalance_bug.cold+0x114/0x123 kernel/locking/lockdep.c:3984
>>>  __lock_release kernel/locking/lockdep.c:4244 [inline]
>>>  lock_release+0x5f2/0x960 kernel/locking/lockdep.c:4505
>>>  rcu_lock_release include/linux/rcupdate.h:213 [inline]
>>>  __rcu_reclaim kernel/rcu/rcu.h:223 [inline]
>>
>> I have little knowledge about this kind of stuff, but after seeing
>> the dashboard https://syzkaller.appspot.com/bug?extid=36baa6c2180e959e19b1
>>
>> I guess this is highly related with ntfs, and in ntfs_fill_super, it
>> has lockdep_off() in ntfs_fill_super...
>>
>> In detail, commit 90c1cba2b3b3 ("locking/lockdep: Zap lock classes even
>> with lock debugging disabled") [1], and free_zapped_rcu....
>>
>> static void free_zapped_rcu(struct rcu_head *ch)
>> {
>>         struct pending_free *pf;
>>         unsigned long flags;
>>
>>         if (WARN_ON_ONCE(ch != &delayed_free.rcu_head))
>>                 return;
>>
>>         raw_local_irq_save(flags);
>>         arch_spin_lock(&lockdep_lock);
>>         current->lockdep_recursion = 1;   <--- here
>>
>>         /* closed head */
>>         pf = delayed_free.pf + (delayed_free.index ^ 1);
>>         __free_zapped_classes(pf);
>>         delayed_free.scheduled = false;
>>
>>         /*
>>          * If there's anything on the open list, close and start a new callback.
>>          */
>>         call_rcu_zapped(delayed_free.pf + delayed_free.index);
>>
>>         current->lockdep_recursion = 0;
>>         arch_spin_unlock(&lockdep_lock);
>>         raw_local_irq_restore(flags);
>> }
>>
>> Completely guess and untest since I am not familar with that,
>> but in case of that, Cc related people...
>> If I'm wrong, ignore my comments and unintentional noise....
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=90c1cba2b3b3851c151229f61801919b2904d437
>>
>> Thanks,
>> Gao Xiang
> 
> 
> Still happens a lot for the past 10 months:
> https://syzkaller.appspot.com/bug?id=0d5bdaf028e4283ad7404609d17e5077f48ff26d

Unless one of the NTFS maintainers steps in, should NTFS perhaps be
excluded from testing with lockdep enabled? This is what I found in the
git log of NTFS:

commit 59345374742ee6673c2d04b0fa8c888e881b7209
Author: Ingo Molnar <mingo@elte.hu>
Date:   Mon Jul 3 00:25:18 2006 -0700

    [PATCH] lockdep: annotate NTFS locking rules

    NTFS uses lots of type-opaque objects which acquire their true
    identity runtime - so the lock validator needs to be helped in a
    couple of places to figure out object types.

    Many thanks to Anton Altaparmakov for giving lots of explanations
    about NTFS locking rules.

    Has no effect on non-lockdep kernels.

Thanks,

Bart.
