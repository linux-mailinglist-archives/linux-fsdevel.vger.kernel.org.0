Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31291226B04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389031AbgGTQie (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 12:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729699AbgGTPua (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:50:30 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E212C061794
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2020 08:50:29 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l23so7946460qkk.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2020 08:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z6kmkfuckLmpgIUpAk+5woHoAxt5Bh8WfnukzZHzOLU=;
        b=nOQD6jWhfhk8i9+Qbvf0tEp+bWLb/kOj6FA5VXdqEfaqSMLAps2aAM9Z3X6Jj3cx2t
         1nUK177q9YGVk0kyRaNoEo/xO1uFbTHNfHZv0FWlbpWvYzNWiSl7KLY6eEpBaEzQZ5Kh
         tOEJOTmhVQQuwpsvQknUBDlCfaSTYlI3lwc0aHoPkFmBLy98G0dE3Brl7mYCOyhi1o76
         S93t/1nWn3ukD73ft2WjiSNOVMCi9a88xdUcVlh4b5u/FRgVSHtYtMLqS5o7Kvef+YYF
         kWLDN0hKzYA7Gw+jjNruNwhqR/ddY4c3gsgSHzKLUCHjZ+3b7+mb5PaJGJuhLomJAB4J
         0PXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z6kmkfuckLmpgIUpAk+5woHoAxt5Bh8WfnukzZHzOLU=;
        b=mthFcofPi8CeKSSnCeSYxDyD5EjqLgt4zrMlOKisNobzL3DqjURiGfPdT3YFSqgTuU
         MEFi7xQMAKXpzvknuk3XQRzYGHlPBUguw/wvk0IsTH+wy3XJ4uSg5q+TwyAiSAEajAKz
         wE+2W3+uv4x7c1jG6TSBk26cIMA6pVZuNi3+8ONhnQ39dMb1RVPbrs6Wet17N9s+vfwJ
         /kB/IYn72WFEG8lFE/z23IGj0kzTsWsGWgwExOT1E7f5PyuCKkVm4cNVK1UYhSge9sY8
         ZBIJC7+hujdzycsxkw/KbYE6fgJE712yLm1D6/z/Rt+bcRtWLhjs/DLQtm4aJFaIT/l/
         ALNA==
X-Gm-Message-State: AOAM530hPpkDAidlR7yhoGLOuTX54yyUAMooMtQlwBh2ZGXz1izl/0QC
        3mzJ+DMmEeIVdB9U47VsHwAmdg==
X-Google-Smtp-Source: ABdhPJy3L9spODujB2gzAyuNPnrOl1KWADK+fcHPRIhSWhXRqHQSDNBFuTsS+3rMT2jsJprGZvnvXg==
X-Received: by 2002:a05:620a:5a7:: with SMTP id q7mr16051333qkq.298.1595260228229;
        Mon, 20 Jul 2020 08:50:28 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x36sm19814499qtb.78.2020.07.20.08.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 08:50:27 -0700 (PDT)
Date:   Mon, 20 Jul 2020 11:50:25 -0400
From:   Qian Cai <cai@lca.pw>
To:     syzbot <syzbot+75867c44841cb6373570@syzkaller.appspotmail.com>
Cc:     Markus.Elfring@web.de, casey@schaufler-ca.com, dancol@google.com,
        hdanton@sina.com, jmorris@namei.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stephen.smalley.work@gmail.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        yanfei.xu@windriver.com, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org
Subject: Re: KASAN: use-after-free Read in userfaultfd_release (2)
Message-ID: <20200720155024.GC7354@lca.pw>
References: <0000000000001bbb6705aa49635a@google.com>
 <000000000000cfc8ff05aa546b84@google.com>
 <20200717150540.GB31206@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717150540.GB31206@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 11:05:41AM -0400, Qian Cai wrote:
> On Mon, Jul 13, 2020 at 08:34:06AM -0700, syzbot wrote:
> > syzbot has bisected this bug to:
> > 
> > commit d08ac70b1e0dc71ac2315007bcc3efb283b2eae4
> > Author: Daniel Colascione <dancol@google.com>
> > Date:   Wed Apr 1 21:39:03 2020 +0000
> > 
> >     Wire UFFD up to SELinux
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a79d13100000
> > start commit:   89032636 Add linux-next specific files for 20200708
> > git tree:       linux-next
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=16a79d13100000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12a79d13100000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=64a250ebabc6c320
> > dashboard link: https://syzkaller.appspot.com/bug?extid=75867c44841cb6373570
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c4c8db100000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12cbb68f100000
> > 
> > Reported-by: syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
> > Fixes: d08ac70b1e0d ("Wire UFFD up to SELinux")
> > 
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> This is rather easy to reproduce here,

James, Stephen, can you drop this patch? Daniel's email was bounced, and Viro
mentioned the patch could be quite bad,

https://lore.kernel.org/lkml/20200719165746.GJ2786714@ZenIV.linux.org.uk/

> 
> # git clone https://gitlab.com/cailca/linux-mm
> # cd linux-mm; make
> # ./random -x 0-100 -f
> 
> Not sure if this is right fix (nobody reviewed it yet).
> https://lore.kernel.org/lkml/20200714161203.31879-1-yanfei.xu@windriver.com/
> 
> [  748.763634][T11960] BUG: KASAN: use-after-free in userfaultfd_release+0x537/0x6b0
> [  748.800768][T11960] Read of size 8 at addr ffff8883a0c7fa08 by task trinity-c11/11960
> [  748.838000][T11960] CPU: 2 PID: 11960 Comm: trinity-c11 Not tainted 5.8.0-rc5-next-20200717 #2
> [  748.878669][T11960] Hardware name: HP ProLiant BL660c Gen9, BIOS I38 10/17/2018
> [  748.913689][T11960] Call Trace:
> [  748.928528][T11960]  dump_stack+0x9d/0xe0
> [  748.947260][T11960]  ? userfaultfd_release+0x537/0x6b0
> [  748.972135][T11960]  print_address_description.constprop.8.cold.9+0x9/0x4fc
> [  749.005085][T11960]  ? log_store.cold.34+0x11/0x11
> [  749.027014][T11960]  ? debug_check_no_obj_freed+0x1f1/0x3d4
> [  749.052665][T11960]  ? userfaultfd_release+0x537/0x6b0
> [  749.077264][T11960]  ? userfaultfd_release+0x537/0x6b0
> [  749.102057][T11960]  kasan_report.cold.10+0x37/0x7c
> [  749.115736][T12010] sock: process `trinity-c4' is using obsolete setsockopt SO_BSDCOMPAT
> [  749.124989][T11960]  ? userfaultfd_release+0x537/0x6b0
> [  749.124998][T11960]  userfaultfd_release+0x537/0x6b0
> [  749.125005][T11960]  ? task_work_run+0xa5/0x170
> [  749.125011][T11960]  ? fsnotify_first_mark+0x140/0x140
> [  749.125019][T11960]  ? userfaultfd_event_wait_completion+0x970/0x970
> [  749.290933][T11960]  __fput+0x1f9/0x7d0
> [  749.309578][T11960]  ? trace_hardirqs_on+0x20/0x1b5
> [  749.332751][T11960]  task_work_run+0xce/0x170
> [  749.353822][T11960]  __prepare_exit_to_usermode+0x100/0x110
> [  749.380276][T11960]  do_syscall_64+0x6b/0x310
> [  749.401043][T11960]  ? trace_hardirqs_off+0x12/0x1a0
> [  749.425256][T11960]  ? asm_exc_page_fault+0x8/0x30
> [  749.448720][T11960]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  749.476365][T11960] RIP: 0033:0x7f30c9d446ed
> [  749.496247][T11960] Code: Bad RIP value.
> [  749.514434][T11960] RSP: 002b:00007ffed5eb17d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000143
> [  749.553554][T11960] RAX: ffffffffffffffe8 RBX: 0000000000000143 RCX: 00007f30c9d446ed
> [  749.589546][T11960] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000800
> [  749.626635][T11960] RBP: 0000000000000143 R08: 0000110783405b9e R09: 00a07f7843429cfc
> [  749.662279][T11960] R10: 0000000000000e92 R11: 0000000000000246 R12: 0000000000000002
> [  749.700555][T11960] R13: 00007f30ca3e4058 R14: 00007f30ca4316c0 R15: 00007f30ca3e4000
> [  749.738586][T11960] Allocated by task 11960:
> [  749.758101][T11960]  kasan_save_stack+0x19/0x40
> [  749.780502][T11960]  __kasan_kmalloc.constprop.11+0xc1/0xd0
> [  749.808176][T11960]  slab_post_alloc_hook+0x47/0x4e0
> [  749.832767][T11960]  kmem_cache_alloc+0xe5/0x2a0
> [  749.854802][T11960]  __x64_sys_userfaultfd+0x90/0x42e
> [  749.878783][T11960]  do_syscall_64+0x5f/0x310
> [  749.899304][T11960]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  749.926310][T11960] Freed by task 11960:
> [  749.945040][T11960]  kasan_save_stack+0x19/0x40
> [  749.966583][T11960]  kasan_set_track+0x1c/0x30
> [  749.987533][T11960]  kasan_set_free_info+0x1b/0x30
> [  750.010336][T11960]  __kasan_slab_free+0xf4/0x130
> [  750.032331][T11960]  slab_free_freelist_hook+0x57/0x1b0
> [  750.057157][T11960]  kmem_cache_free+0xe9/0x420
> [  750.078387][T11960]  __x64_sys_userfaultfd+0x36e/0x42e
> [  750.086326][T12643] splice read not supported for file devices/pci0000:bf/0000:bf:09.0/local_cpus (pid: 12643 comm: trinity-c28)
> [  750.103577][T11960]  do_syscall_64+0x5f/0x310
> [  750.103581][T11960]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  750.103587][T11960] The buggy address belongs to the object at ffff8883a0c7f880
> [  750.103587][T11960]  which belongs to the cache userfaultfd_ctx_cache of size 408
> [  750.103591][T11960] The buggy address is located 392 bytes inside of
> [  750.103591][T11960]  408-byte region [ffff8883a0c7f880, ffff8883a0c7fa18)
> [  750.103594][T11960] The buggy address belongs to the page:
> [  750.103600][T11960] page:000000003aed2e67 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3a0c78
> [  750.103607][T11960] head:000000003aed2e67 order:3 compound_mapcount:0 compound_pincount:0
> [  750.458247][T11960] flags: 0xbfffc000010200(slab|head)
> [  750.483010][T11960] raw: 00bfffc000010200 ffffea0010c3c008 ffff8888078f9ba8 ffff888806fcc900
> [  750.523034][T11960] raw: 0000000000000000 0000000000270027 00000001ffffffff 0000000000000000
> [  750.562783][T11960] page dumped because: kasan: bad access detected
> [  750.593243][T11960] Memory state around the buggy address:
> [  750.619628][T11960]  ffff8883a0c7f900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  750.657472][T11960]  ffff8883a0c7f980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  750.694927][T11960] >ffff8883a0c7fa00: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  750.733031][T11960]                       ^
> [  750.752984][T11960]  ffff8883a0c7fa80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  750.790776][T11960]  ffff8883a0c7fb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  750.831467][T11960] ==================================================================
> [  750.869054][T11960] Disabling lock debugging due to kernel taint
> [  750.897800][T11960] ==================================================================
> [  750.935726][T11960] BUG: KASAN: double-free or invalid-free in kmem_cache_free+0xe9/0x420
> [  750.973793][T11960] CPU: 2 PID: 11960 Comm: trinity-c11 Tainted: G    B             5.8.0-rc5-next-20200717 #2
> [  751.021533][T11960] Hardware name: HP ProLiant BL660c Gen9, BIOS I38 10/17/2018
> [  751.055710][T11960] Call Trace:
> [  751.070746][T11960]  dump_stack+0x9d/0xe0
> [  751.089519][T11960]  print_address_description.constprop.8.cold.9+0x9/0x4fc
> [  751.123128][T11960]  ? log_store.cold.34+0x11/0x11
> [  751.145650][T11960]  ? kmem_cache_free+0xe9/0x420
> [  751.167973][T11960]  kasan_report_invalid_free+0x50/0x80
> [  751.193005][T11960]  ? kmem_cache_free+0xe9/0x420
> [  751.215368][T11960]  __kasan_slab_free+0x123/0x130
> [  751.237772][T11960]  slab_free_freelist_hook+0x57/0x1b0
> [  751.262582][T11960]  ? userfaultfd_release+0x337/0x6b0
> [  751.286825][T11960]  kmem_cache_free+0xe9/0x420
> [  751.309669][T11960]  userfaultfd_release+0x337/0x6b0
> [  751.335785][T11960]  ? task_work_run+0xa5/0x170
> [  751.357946][T11960]  ? fsnotify_first_mark+0x140/0x140
> [  751.382109][T11960]  ? userfaultfd_event_wait_completion+0x970/0x970
> [  751.412642][T11960]  __fput+0x1f9/0x7d0
> [  751.430775][T11960]  ? trace_hardirqs_on+0x20/0x1b5
> [  751.453732][T11960]  task_work_run+0xce/0x170
> [  751.474992][T11960]  __prepare_exit_to_usermode+0x100/0x110
> [  751.501489][T11960]  do_syscall_64+0x6b/0x310
> [  751.521985][T11960]  ? trace_hardirqs_off+0x12/0x1a0
> [  751.545484][T11960]  ? asm_exc_page_fault+0x8/0x30
> [  751.568219][T11960]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  751.595779][T11960] RIP: 0033:0x7f30c9d446ed
> [  751.616310][T11960] Code: Bad RIP value.
> [  751.635437][T11960] RSP: 002b:00007ffed5eb17d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000143
> [  751.675839][T11960] RAX: ffffffffffffffe8 RBX: 0000000000000143 RCX: 00007f30c9d446ed
> [  751.713515][T11960] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000800
> [  751.750030][T11960] RBP: 0000000000000143 R08: 0000110783405b9e R09: 00a07f7843429cfc
> [  751.786921][T11960] R10: 0000000000000e92 R11: 0000000000000246 R12: 0000000000000002
> [  751.824777][T11960] R13: 00007f30ca3e4058 R14: 00007f30ca4316c0 R15: 00007f30ca3e4000
> [  751.864847][T11960] Allocated by task 11960:
> [  751.884987][T11960]  kasan_save_stack+0x19/0x40
> [  751.906294][T11960]  __kasan_kmalloc.constprop.11+0xc1/0xd0
> [  751.932455][T11960]  slab_post_alloc_hook+0x47/0x4e0
> [  751.955962][T11960]  kmem_cache_alloc+0xe5/0x2a0
> [  751.977979][T11960]  __x64_sys_userfaultfd+0x90/0x42e
> [  752.001413][T11960]  do_syscall_64+0x5f/0x310
> [  752.022167][T11960]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  752.049563][T11960] Freed by task 11960:
> [  752.068070][T11960]  kasan_save_stack+0x19/0x40
> [  752.089305][T11960]  kasan_set_track+0x1c/0x30
> [  752.110353][T11960]  kasan_set_free_info+0x1b/0x30
> [  752.132781][T11960]  __kasan_slab_free+0xf4/0x130
> [  752.155004][T11960]  slab_free_freelist_hook+0x57/0x1b0
> [  752.179879][T11960]  kmem_cache_free+0xe9/0x420
> [  752.202146][T11960]  __x64_sys_userfaultfd+0x36e/0x42e
> [  752.228182][T11960]  do_syscall_64+0x5f/0x310
> [  752.248714][T11960]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  752.276331][T11960] The buggy address belongs to the object at ffff8883a0c7f880
> [  752.276331][T11960]  which belongs to the cache userfaultfd_ctx_cache of size 408
> [  752.348047][T11960] The buggy address is located 0 bytes inside of
> [  752.348047][T11960]  408-byte region [ffff8883a0c7f880, ffff8883a0c7fa18)
> [  752.412451][T11960] The buggy address belongs to the page:
> [  752.438706][T11960] page:000000003aed2e67 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3a0c78
> [  752.485700][T11960] head:000000003aed2e67 order:3 compound_mapcount:0 compound_pincount:0
> [  752.524609][T11960] flags: 0xbfffc000010200(slab|head)
> [  752.549300][T11960] raw: 00bfffc000010200 ffffea0010c3c008 ffff8888078f9ba8 ffff888806fcc900
> [  752.589287][T11960] raw: 0000000000000000 0000000000270027 00000001ffffffff 0000000000000000
> [  752.629841][T11960] page dumped because: kasan: bad access detected
> [  752.659522][T11960] Memory state around the buggy address:
> [  752.685915][T11960]  ffff8883a0c7f780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  752.724590][T11960]  ffff8883a0c7f800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  752.762413][T11960] >ffff8883a0c7f880: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  752.800022][T11960]                    ^
> [  752.818732][T11960]  ffff8883a0c7f900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  752.857815][T11960]  ffff8883a0c7f980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  752.897699][T11960] ==================================================================
> [  753.255121][T11960] ------------[ cut here ]------------
> [  753.279452][T11960] WARNING: CPU: 2 PID: 11960 at kernel/fork.c:679 __mmdrop+0x1ff/0x300
> [  753.316503][T11960] Modules linked in: kvm_intel kvm irqbypass efivars nls_ascii nls_cp437 vfat fat ip_tables x_tables sd_mod bnx2x hpsa mdio scsi_transport_sas firmware_class dm_mirror dm_region_hash dm_log dm_mod efivarfs
> [  753.411968][T11960] CPU: 2 PID: 11960 Comm: trinity-c11 Tainted: G    B             5.8.0-rc5-next-20200717 #2
> [  753.458387][T11960] Hardware name: HP ProLiant BL660c Gen9, BIOS I38 10/17/2018
> [  753.491586][T11960] RIP: 0010:__mmdrop+0x1ff/0x300
> [  753.513019][T11960] Code: 00 01 00 00 49 8b 14 ef 48 89 de 48 c7 c7 80 31 a4 8a e8 cd f1 15 00 e9 4e ff ff ff 0f 0b 48 c7 c7 a0 7e 0f 8b e8 8d af bb 00 <0f> 0b e9 88 fe ff ff 0f 0b e9 49 fe ff ff 48 c7 c7 20 7e 0f 8b e8
> [  753.601968][T11960] RSP: 0018:ffffc90021fcf9e0 EFLAGS: 00010246
> [  753.629408][T11960] RAX: dffffc0000000000 RBX: ffff8897cfe00040 RCX: ffffffff89a3167e
> [  753.665107][T11960] RDX: 1ffff112f89a0070 RSI: 0000000000000004 RDI: ffff8897c4d00380
> [  753.701452][T11960] RBP: ffff8897c4d00040 R08: ffffed12f9fc0013 R09: ffffed12f9fc0013
> [  753.738794][T11960] R10: ffff8897cfe00093 R11: ffffed12f9fc0012 R12: 00000000000a0003
> [  753.775979][T11960] R13: ffff8897c7194140 R14: ffff8890860f8c60 R15: ffff88982da31fd0
> [  753.813159][T11960] FS:  0000000000000000(0000) GS:ffff88881e080000(0000) knlGS:0000000000000000
> [  753.853965][T11960] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  753.884913][T11960] CR2: 0000000000000008 CR3: 0000000a92614003 CR4: 00000000001706e0
> [  753.923791][T11960] DR0: 00007f30c7a00000 DR1: 00007f30c802a000 DR2: 0000000000000000
> [  753.959646][T11960] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> [  753.995379][T11960] Call Trace:
> [  754.009663][T11960]  ? _raw_spin_unlock_irq+0x1f/0x30
> [  754.033278][T11960]  userfaultfd_ctx_put+0x317/0x370
> [  754.056508][T11960]  userfaultfd_release+0x337/0x6b0
> [  754.080202][T11960]  ? fsnotify_first_mark+0x140/0x140
> [  754.104819][T11960]  ? debug_object_deactivate+0x3b0/0x3b0
> [  754.130879][T11960]  ? userfaultfd_event_wait_completion+0x970/0x970
> [  754.160206][T11960]  ? __dentry_kill+0x3d3/0x590
> [  754.181320][T11960]  __fput+0x1f9/0x7d0
> [  754.198800][T11960]  ? trace_hardirqs_on+0x20/0x1b5
> [  754.221003][T11960]  task_work_run+0xce/0x170
> [  754.240923][T11960]  do_exit+0x979/0x2580
> [  754.259292][T11960]  ? mm_update_next_owner+0x770/0x770
> [  754.283147][T11960]  ? lock_downgrade+0x730/0x730
> [  754.304657][T11960]  ? rcu_read_unlock+0x50/0x50
> [  754.325854][T11960]  ? do_raw_spin_lock+0x121/0x290
> [  754.348294][T11960]  ? rwlock_bug.part.1+0x90/0x90
> [  754.370156][T11960]  do_group_exit+0xe7/0x2a0
> [  754.391722][T11960]  get_signal+0x3b2/0x1f60
> [  754.413437][T11960]  ? _down_write_nest_lock+0x150/0x150
> [  754.440089][T11960]  do_signal+0x70/0x480
> [  754.458414][T11960]  ? task_numa_work+0x6b2/0x910
> [  754.479953][T11960]  ? __setup_rt_frame+0x1820/0x1820
> [  754.502552][T11960]  ? unlock_page_memcg+0x60/0x60
> [  754.524511][T11960]  ? _cond_resched+0x10/0x20
> [  754.544897][T11960]  ? task_work_run+0xe6/0x170
> [  754.565547][T11960]  ? __prepare_exit_to_usermode+0x97/0x110
> [  754.591926][T11960]  __prepare_exit_to_usermode+0xaa/0x110
> [  754.617148][T11960]  do_syscall_64+0x6b/0x310
> [  754.637097][T11960]  ? trace_hardirqs_off+0x12/0x1a0
> [  754.659743][T11960]  ? asm_exc_page_fault+0x8/0x30
> [  754.681739][T11960]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  754.708333][T11960] RIP: 0033:0x7f30c9d446ed
> [  754.728260][T11960] Code: Bad RIP value.
> [  754.746087][T11960] RSP: 002b:00007ffed5eb17d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000143
> [  754.783883][T11960] RAX: ffffffffffffffe8 RBX: 0000000000000143 RCX: 00007f30c9d446ed
> [  754.819590][T11960] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000800
> [  754.855344][T11960] RBP: 0000000000000143 R08: 0000110783405b9e R09: 00a07f7843429cfc
> [  754.890976][T11960] R10: 0000000000000e92 R11: 0000000000000246 R12: 0000000000000002
> [  754.930653][T11960] R13: 00007f30ca3e4058 R14: 00007f30ca4316c0 R15: 00007f30ca3e4000
> [  754.966737][T11960] irq event stamp: 468838
> [  754.985905][T11960] hardirqs last  enabled at (468837): [<ffffffff8a5aa3ff>] _raw_spin_unlock_irq+0x1f/0x30
> [  755.030394][T11960] hardirqs last disabled at (468838): [<ffffffff8a5aa24d>] _raw_spin_lock_irqsave+0xd/0x40
> [  755.075344][T11960] softirqs last  enabled at (464248): [<ffffffff8a80070f>] __do_softirq+0x70f/0xa9f
> [  755.117500][T11960] softirqs last disabled at (464241): [<ffffffff8a600ec2>] asm_call_on_stack+0x12/0x20
> [  755.161911][T11960] ---[ end trace 451daddf8267bf7d ]---
