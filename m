Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F024DDB38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 15:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbiCROIa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 10:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236138AbiCROI3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:08:29 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04DD222B3
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 07:07:09 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id q6-20020a056e0215c600b002c2c4091914so4865689ilu.14
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 07:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=H7P16It0d2lJsNuqMlwgZtzNJRQgvv2F748cwcANgrk=;
        b=251rAKIRkQbOCdOUZhInxLwGwk5ShLNNfZccx2L+Ru0vc3ZC3tC0tlWxtlBfQ2N61i
         5JmwED6iVK8F3vcRpshIS5ElM/qHYB1H1bX15kfyyBt91KF4XSOK3HxWRmkfao94CO/q
         SaTsWQjZzEop9wlafX1WfUZqrEYzvAv0mjfeJVzzIQuzmSRX7hoBeGS+v5PdCD3VCSgV
         feegH+/BtFbkdK8YKbRtJ4YM9xIWnCyij+3NPGEAUei1YJeAtKBvtLjBKPs8fJizTQWx
         +bkl1AtK67pbnCjflQ6Q69DZwSlGXMjt4pltKS6nK9/YZZY7UBdjJNmUZbm2ifGGy7V+
         s+aw==
X-Gm-Message-State: AOAM533zCz2P9UQ8W1yxV72UNjTeDOAvt+Se8cLSfCSxkTVSWh48pRET
        7NfegNov4LtBcNPF9OSxOu2mizVFeie8mZnowH5+/WHMiPBg
X-Google-Smtp-Source: ABdhPJyg2B+qtNQe3V+JgH36PHvfmonc1dvJRXOw7zqJU/VLfUp7lHWUnYCXDFlRS2viYRqfcaXZT2VLz3XUf8bZytRTGTvZL7Kw
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4811:b0:317:cef6:5aef with SMTP id
 cp17-20020a056638481100b00317cef65aefmr4632970jab.220.1647612429167; Fri, 18
 Mar 2022 07:07:09 -0700 (PDT)
Date:   Fri, 18 Mar 2022 07:07:09 -0700
In-Reply-To: <20220318134336.2332-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009171df05da7ea95e@google.com>
Subject: Re: [syzbot] WARNING in inc_nlink (3)
From:   syzbot <syzbot+2b3af42c0644df1e4da9@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

  T40]  __wait_for_common+0x2af/0x360
[  293.773463][   T40]  ? usleep_range_state+0x1b0/0x1b0
[  293.779742][   T40]  ? bit_wait_io_timeout+0x160/0x160
[  293.785607][   T40]  ? mutex_lock_io_nested+0x1150/0x1150
[  293.791601][   T40]  cpuhp_issue_call+0x4c0/0x900
[  293.796921][   T40]  __cpuhp_setup_state_cpuslocked+0x362/0x8a0
[  293.805189][   T40]  ? nmi_panic_self_stop+0x13/0x20
[  293.810867][   T40]  ? nmi_panic_self_stop+0x20/0x20
[  293.816546][   T40]  ? msr_devnode+0x60/0x60
[  293.821286][   T40]  ? nmi_panic_self_stop+0x20/0x20
[  293.826805][   T40]  __cpuhp_setup_state+0x102/0x2e0
[  293.832648][   T40]  ? set_kbd_reboot+0x85/0x85
[  293.838219][   T40]  msr_init+0xba/0xf8
[  293.842603][   T40]  do_one_initcall+0x103/0x650
[  293.847647][   T40]  ? trace_event_raw_event_initcall_level+0x1f0/0x1f0
[  293.854724][   T40]  ? parameq+0xa0/0x170
[  293.859103][   T40]  kernel_init_freeable+0x6b1/0x73a
[  293.864814][   T40]  ? rest_init+0x3e0/0x3e0
[  293.869732][   T40]  kernel_init+0x1a/0x1d0
[  293.874300][   T40]  ? rest_init+0x3e0/0x3e0
[  293.878927][   T40]  ret_from_fork+0x1f/0x30
[  293.883729][   T40]  </TASK>
[  293.887649][   T40] INFO: task kworker/u17:1:14 blocked for more than 143 seconds.
[  293.898601][   T40]       Not tainted 5.17.0-rc7-syzkaller-00235-gaad611a868d1-dirty #0
[  293.913284][   T40] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  293.924199][   T40] task:kworker/u17:1   state:D stack:25864 pid:   14 ppid:     2 flags:0x00004000
[  293.938171][   T40] Workqueue: events_unbound async_run_entry_fn
[  293.946835][   T40] Call Trace:
[  293.951616][   T40]  <TASK>
[  293.955924][   T40]  __schedule+0xa94/0x4910
[  293.962011][   T40]  ? rwsem_down_write_slowpath+0x4f0/0x1110
[  293.969574][   T40]  ? io_schedule_timeout+0x180/0x180
[  293.978333][   T40]  ? mark_held_locks+0x9f/0xe0
[  293.985859][   T40]  ? rwlock_bug.part.0+0x90/0x90
[  293.994578][   T40]  ? __sanitizer_cov_trace_const_cmp4+0x1c/0x70
[  294.003631][   T40]  schedule+0xd2/0x260
[  294.008912][   T40]  rwsem_down_write_slowpath+0x634/0x1110
[  294.016333][   T40]  ? rwsem_mark_wake+0x960/0x960
[  294.023246][   T40]  ? lock_release+0x720/0x720
[  294.031124][   T40]  down_write+0x135/0x150
[  294.037929][   T40]  ? down_write_killable_nested+0x180/0x180
[  294.046559][   T40]  ? __sanitizer_cov_trace_const_cmp4+0x1c/0x70
[  294.055336][   T40]  ? security_inode_mkdir+0xd6/0x100
[  294.062636][   T40]  vfs_mkdir+0x14e/0x480
[  294.068561][   T40]  ? security_path_mkdir+0x11b/0x160
[  294.076470][   T40]  init_mkdir+0x1cb/0x21d
[  294.083086][   T40]  ? init_unlink+0x1f/0x1f
[  294.089376][   T40]  ? eat+0x8/0x21
[  294.093573][   T40]  do_name+0x223/0x4e5
[  294.099942][   T40]  write_buffer+0x69/0x8c
[  294.106118][   T40]  unpack_to_rootfs+0x228/0x5ce
[  294.112290][   T40]  ? do_utime.isra.0+0xb1/0xb1
[  294.117526][   T40]  ? reserve_initrd_mem+0x31c/0x31c
[  294.122933][   T40]  do_populate_rootfs+0x8c/0x59b
[  294.127669][   T40]  ? reserve_initrd_mem+0x31c/0x31c
[  294.132963][   T40]  ? __sanitizer_cov_trace_cmp4+0x1c/0x70
[  294.138730][   T40]  ? ktime_get+0x30b/0x470
[  294.143235][   T40]  async_run_entry_fn+0x9d/0x550
[  294.148261][   T40]  process_one_work+0x9ac/0x1650
[  294.153403][   T40]  ? pwq_dec_nr_in_flight+0x2a0/0x2a0
[  294.158974][   T40]  ? rwlock_bug.part.0+0x90/0x90
[  294.163988][   T40]  ? _raw_spin_lock_irq+0x41/0x50
[  294.169102][   T40]  worker_thread+0x657/0x1110
[  294.174037][   T40]  ? process_one_work+0x1650/0x1650
[  294.179217][   T40]  kthread+0x2e9/0x3a0
[  294.183411][   T40]  ? kthread_complete_and_exit+0x40/0x40
[  294.189044][   T40]  ret_from_fork+0x1f/0x30
[  294.193523][   T40]  </TASK>
[  294.196714][   T40] INFO: task cpuhp/0:18 blocked for more than 143 seconds.
[  294.203827][   T40]       Not tainted 5.17.0-rc7-syzkaller-00235-gaad611a868d1-dirty #0
[  294.212126][   T40] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  294.220975][   T40] task:cpuhp/0         state:D stack:28392 pid:   18 ppid:     2 flags:0x00004000
[  294.230370][   T40] Call Trace:
[  294.233816][   T40]  <TASK>
[  294.237042][   T40]  __schedule+0xa94/0x4910
[  294.242345][   T40]  ? io_schedule_timeout+0x180/0x180
[  294.248784][   T40]  ? lock_chain_count+0x20/0x20
[  294.254897][   T40]  ? update_load_avg+0x1361/0x1c80
[  294.261329][   T40]  schedule+0xd2/0x260
[  294.266092][   T40]  schedule_timeout+0x1db/0x2a0
[  294.271547][   T40]  ? usleep_range_state+0x1b0/0x1b0
[  294.277306][   T40]  ? __wait_for_common+0x2a6/0x360
[  294.284078][   T40]  ? mark_held_locks+0x9f/0xe0
[  294.289477][   T40]  ? rwlock_bug.part.0+0x90/0x90
[  294.295280][   T40]  ? _raw_spin_unlock_irq+0x1f/0x40
[  294.300495][   T40]  __wait_for_common+0x2af/0x360
[  294.305629][   T40]  ? usleep_range_state+0x1b0/0x1b0
[  294.310921][   T40]  ? bit_wait_io_timeout+0x160/0x160
[  294.316375][   T40]  ? do_raw_spin_lock+0x120/0x2b0
[  294.321595][   T40]  ? rwlock_bug.part.0+0x90/0x90
[  294.326517][   T40]  devtmpfs_submit_req+0xa8/0x100
[  294.331962][   T40]  devtmpfs_create_node+0x175/0x210
[  294.337434][   T40]  ? public_dev_mount+0xf0/0xf0
[  294.343540][   T40]  ? up_write+0x148/0x470
[  294.349334][   T40]  ? kernfs_activate+0x1c4/0x240
[  294.356054][   T40]  ? __sanitizer_cov_trace_const_cmp1+0x22/0x80
[  294.364067][   T40]  ? kernfs_put+0x31/0x50
[  294.369611][   T40]  ? __sanitizer_cov_trace_const_cmp8+0x1d/0x70
[  294.377377][   T40]  ? sysfs_do_create_link_sd+0xbb/0x140
[  294.383203][   T40]  ? sysfs_create_link+0x67/0xc0
[  294.388686][   T40]  device_add+0x1887/0x1e20
[  294.393846][   T40]  ? __fw_devlink_link_to_suppliers+0x2d0/0x2d0
[  294.400571][   T40]  ? rcu_read_lock_sched_held+0x3a/0x70
[  294.406387][   T40]  ? kfree+0x19e/0x2b0
[  294.410641][   T40]  device_create_groups_vargs+0x203/0x280
[  294.417000][   T40]  device_create+0xdf/0x120
[  294.421769][   T40]  ? device_create_groups_vargs+0x280/0x280
[  294.427907][   T40]  ? msr_devnode+0x60/0x60
[  294.432595][   T40]  ? trace_cpuhp_enter+0x1a0/0x240
[  294.438127][   T40]  ? msr_devnode+0x60/0x60
[  294.443645][   T40]  msr_device_create+0x22/0x40
[  294.448754][   T40]  cpuhp_invoke_callback+0x3b5/0x9a0
[  294.454362][   T40]  ? _raw_spin_unlock_irqrestore+0x50/0x70
[  294.460401][   T40]  cpuhp_thread_fun+0x477/0x6f0
[  294.465363][   T40]  ? cpuhp_invoke_callback+0x9a0/0x9a0
[  294.470781][   T40]  ? cpuhp_invoke_callback+0x9a0/0x9a0
[  294.476300][   T40]  smpboot_thread_fn+0x645/0x9c0
[  294.482127][   T40]  ? smpboot_register_percpu_thread+0x370/0x370
[  294.488774][   T40]  kthread+0x2e9/0x3a0
[  294.492910][   T40]  ? kthread_complete_and_exit+0x40/0x40
[  294.498827][   T40]  ret_from_fork+0x1f/0x30
[  294.503371][   T40]  </TASK>
[  294.506551][   T40] INFO: task kdevtmpfs:34 blocked for more than 144 seconds.
[  294.513994][   T40]       Not tainted 5.17.0-rc7-syzkaller-00235-gaad611a868d1-dirty #0
[  294.522452][   T40] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  294.531256][   T40] task:kdevtmpfs       state:D stack:27864 pid:   34 ppid:     2 flags:0x00004000
[  294.540541][   T40] Call Trace:
[  294.543865][   T40]  <TASK>
[  294.546801][   T40]  __schedule+0xa94/0x4910
[  294.551370][   T40]  ? rwsem_down_write_slowpath+0x4f0/0x1110
[  294.557485][   T40]  ? io_schedule_timeout+0x180/0x180
[  294.564113][   T40]  ? mark_held_locks+0x9f/0xe0
[  294.569111][   T40]  ? rwlock_bug.part.0+0x90/0x90
[  294.574299][   T40]  schedule+0xd2/0x260
[  294.578540][   T40]  rwsem_down_write_slowpath+0x634/0x1110
[  294.585525][   T40]  ? rwsem_mark_wake+0x960/0x960
[  294.591953][   T40]  ? lock_release+0x720/0x720
[  294.597261][   T40]  down_write+0x135/0x150
[  294.602723][   T40]  ? down_write_killable_nested+0x180/0x180
[  294.609897][   T40]  ? __sanitizer_cov_trace_const_cmp4+0x1c/0x70
[  294.617453][   T40]  ? security_inode_mkdir+0xd6/0x100
[  294.624180][   T40]  vfs_mkdir+0x14e/0x480
[  294.628766][   T40]  handle_create+0x198/0x4b3
[  294.633669][   T40]  ? handle_remove+0x5fe/0x5fe
[  294.638746][   T40]  ? find_held_lock+0x2d/0x110
[  294.644918][   T40]  ? devtmpfsd+0xaa/0x2a3
[  294.650442][   T40]  ? lock_downgrade+0x6e0/0x6e0
[  294.656642][   T40]  ? do_raw_spin_lock+0x120/0x2b0
[  294.662888][   T40]  ? rwlock_bug.part.0+0x90/0x90
[  294.667815][   T40]  devtmpfsd+0x1a4/0x2a3
[  294.672413][   T40]  ? dmar_validate_one_drhd+0x24d/0x24d
[  294.678087][   T40]  kthread+0x2e9/0x3a0
[  294.682289][   T40]  ? kthread_complete_and_exit+0x40/0x40
[  294.688394][   T40]  ret_from_fork+0x1f/0x30
[  294.694162][   T40]  </TASK>
[  294.698633][   T40] INFO: task kworker/u17:2:72 blocked for more than 144 seconds.
[  294.707590][   T40]       Not tainted 5.17.0-rc7-syzkaller-00235-gaad611a868d1-dirty #0
[  294.717373][   T40] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  294.728402][   T40] task:kworker/u17:2   state:D stack:30064 pid:   72 ppid:     2 flags:0x00004000
[  294.739692][   T40] Call Trace:
[  294.743823][   T40]  <TASK>
[  294.747163][   T40]  __schedule+0xa94/0x4910
[  294.751403][   T40]  ? io_schedule_timeout+0x180/0x180
[  294.756615][   T40]  ? _raw_spin_unlock_irqrestore+0x50/0x70
[  294.763671][   T40]  schedule+0xd2/0x260
[  294.768621][   T40]  async_synchronize_cookie_domain+0x1f9/0x270
[  294.776319][   T40]  ? lowest_in_progress+0xf0/0xf0
[  294.782484][   T40]  ? __put_cred+0x1ca/0x250
[  294.787920][   T40]  ? finish_wait+0x270/0x270
[  294.793531][   T40]  wait_for_initramfs+0x54/0x70
[  294.799402][   T40]  call_usermodehelper_exec_async+0x26f/0x580
[  294.805433][   T40]  ? umh_complete+0x90/0x90
[  294.811421][   T40]  ret_from_fork+0x1f/0x30
[  294.815924][   T40]  </TASK>
[  294.818784][   T40] INFO: task kworker/u17:2:73 blocked for more than 144 seconds.
[  294.828170][   T40]       Not tainted 5.17.0-rc7-syzkaller-00235-gaad611a868d1-dirty #0
[  294.836590][   T40] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  294.847531][   T40] task:kworker/u17:2   state:D stack:30568 pid:   73 ppid:     2 flags:0x00004000
[  294.858846][   T40] Call Trace:
[  294.862986][   T40]  <TASK>
[  294.867040][   T40]  __schedule+0xa94/0x4910
[  294.872483][   T40]  ? io_schedule_timeout+0x180/0x180
[  294.878112][   T40]  ? _raw_spin_unlock_irqrestore+0x50/0x70
[  294.886377][   T40]  schedule+0xd2/0x260
[  294.891591][   T40]  async_synchronize_cookie_domain+0x1f9/0x270
[  294.898880][   T40]  ? lowest_in_progress+0xf0/0xf0
[  294.904378][   T40]  ? __put_cred+0x1ca/0x250
[  294.909096][   T40]  ? finish_wait+0x270/0x270
[  294.913629][   T40]  wait_for_initramfs+0x54/0x70
[  294.919093][   T40]  call_usermodehelper_exec_async+0x26f/0x580
[  294.925513][   T40]  ? umh_complete+0x90/0x90
[  294.929924][   T40]  ret_from_fork+0x1f/0x30
[  294.934401][   T40]  </TASK>
[  294.937561][   T40] INFO: task kworker/u17:3:74 blocked for more than 144 seconds.
[  294.945887][   T40]       Not tainted 5.17.0-rc7-syzkaller-00235-gaad611a868d1-dirty #0
[  294.954060][   T40] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  294.963310][   T40] task:kworker/u17:3   state:D stack:30568 pid:   74 ppid:     2 flags:0x00004000
[  294.972248][   T40] Call Trace:
[  294.975488][   T40]  <TASK>
[  294.978265][   T40]  __schedule+0xa94/0x4910
[  294.983603][   T40]  ? io_schedule_timeout+0x180/0x180
[  294.989790][   T40]  ? _raw_spin_unlock_irqrestore+0x50/0x70
[  294.995642][   T40]  schedule+0xd2/0x260
[  294.999416][   T40]  async_synchronize_cookie_domain+0x1f9/0x270
[  295.005448][   T40]  ? lowest_in_progress+0xf0/0xf0
[  295.010336][   T40]  ? __put_cred+0x1ca/0x250
[  295.014764][   T40]  ? finish_wait+0x270/0x270
[  295.019451][   T40]  wait_for_initramfs+0x54/0x70
[  295.024262][   T40]  call_usermodehelper_exec_async+0x26f/0x580
[  295.030181][   T40]  ? umh_complete+0x90/0x90
[  295.034685][   T40]  ret_from_fork+0x1f/0x30
[  295.038963][   T40]  </TASK>
[  295.042042][   T40] INFO: task kworker/u17:3:75 blocked for more than 144 seconds.
[  295.049634][   T40]       Not tainted 5.17.0-rc7-syzkaller-00235-gaad611a868d1-dirty #0
[  295.057755][   T40] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  295.068019][   T40] task:kworker/u17:3   state:D stack:30568 pid:   75 ppid:     2 flags:0x00004000
[  295.077460][   T40] Call Trace:
[  295.080693][   T40]  <TASK>
[  295.083643][   T40]  __schedule+0xa94/0x4910
[  295.087978][   T40]  ? io_schedule_timeout+0x180/0x180
[  295.094151][   T40]  ? _raw_spin_unlock_irqrestore+0x50/0x70
[  295.101291][   T40]  schedule+0xd2/0x260
[  295.106289][   T40]  async_synchronize_cookie_domain+0x1f9/0x270
[  295.113479][   T40]  ? lowest_in_progress+0xf0/0xf0
[  295.118558][   T40]  ? __put_cred+0x1ca/0x250
[  295.123338][   T40]  ? finish_wait+0x270/0x270
[  295.128015][   T40]  wait_for_initramfs+0x54/0x70
[  295.132899][   T40]  call_usermodehelper_exec_async+0x26f/0x580
[  295.139455][   T40]  ? umh_complete+0x90/0x90
[  295.144352][   T40]  ret_from_fork+0x1f/0x30
[  295.149168][   T40]  </TASK>
[  295.152281][   T40] 
[  295.152281][   T40] Showing all locks held in the system:
[  295.160764][   T40] 2 locks held by swapper/0/1:
[  295.165758][   T40]  #0: ffffffff8ba2dbd0 (cpu_hotplug_lock){++++}-{0:0}, at: msr_init+0xba/0xf8
[  295.174911][   T40]  #1: ffffffff8ba30168 (cpuhp_state_mutex){+.+.}-{3:3}, at: __cpuhp_setup_state_cpuslocked+0xfb/0x8a0
[  295.187105][   T40] 5 locks held by kworker/u17:1/14:
[  295.192488][   T40]  #0: ffff888010c75138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x890/0x1650
[  295.204173][   T40]  #1: ffffc9000061fdb8 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work+0x8c4/0x1650
[  295.216602][   T40]  #2: ffff888011650460 (sb_writers#2){.+.+}-{0:0}, at: filename_create+0xf3/0x480
[  295.226100][   T40]  #3: ffff888011004bb0 (&sb->s_type->i_mutex_key/1){+.+.}-{3:3}, at: filename_create+0x158/0x480
[  295.237689][   T40]  #4: ffff888011004bb0 (&sb->s_type->i_mutex_key){++++}-{3:3}, at: vfs_mkdir+0x14e/0x480
[  295.248214][   T40] 2 locks held by cpuhp/0/18:
[  295.253178][   T40]  #0: ffffffff8ba2dbd0 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x113/0x6f0
[  295.263845][   T40]  #1: ffffffff8ba30220 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x113/0x6f0
[  295.273729][   T40] 3 locks held by kdevtmpfs/34:
[  295.278876][   T40]  #0: ffff888011c2a460 (sb_writers){.+.+}-{0:0}, at: filename_create+0xf3/0x480
[  295.288685][   T40]  #1: ffff8880402fe2b8 (&type->i_mutex_dir_key/1){+.+.}-{3:3}, at: filename_create+0x158/0x480
[  295.299519][   T40]  #2: ffff8880402fe2b8 (&type->i_mutex_dir_key#2){++++}-{3:3}, at: vfs_mkdir+0x14e/0x480
[  295.309472][   T40] 1 lock held by khungtaskd/40:
[  295.314423][   T40]  #0: ffffffff8bb820a0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260
[  295.324434][   T40] 2 locks held by kworker/u17:3/71:
[  295.329391][   T40]  #0: ffff888010c75138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x890/0x1650
[  295.341345][   T40]  #1: ffffc90000c87db8 ((kfence_timer).work){+.+.}-{0:0}, at: process_one_work+0x8c4/0x1650
[  295.351499][   T40] 
[  295.353647][   T40] =============================================
[  295.353647][   T40] 
[  295.361947][   T40] Kernel panic - not syncing: hung_task: blocked tasks
[  295.368642][   T40] CPU: 0 PID: 40 Comm: khungtaskd Not tainted 5.17.0-rc7-syzkaller-00235-gaad611a868d1-dirty #0
[  295.371822][   T40] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
[  295.371822][   T40] Call Trace:
[  295.371822][   T40]  <TASK>
[  295.371822][   T40]  dump_stack_lvl+0xcd/0x134
[  295.371822][   T40]  panic+0x2b0/0x6dd
[  295.371822][   T40]  ? __warn_printk+0xf3/0xf3
[  295.371822][   T40]  ? watchdog.cold+0x130/0x158
[  295.371822][   T40]  watchdog.cold+0x141/0x158
[  295.371822][   T40]  ? proc_dohung_task_timeout_secs+0x80/0x80
[  295.371822][   T40]  kthread+0x2e9/0x3a0
[  295.371822][   T40]  ? kthread_complete_and_exit+0x40/0x40
[  295.371822][   T40]  ret_from_fork+0x1f/0x30
[  295.371822][   T40]  </TASK>
[  295.371822][   T40] Kernel Offset: disabled
[  295.371822][   T40] Rebooting in 86400 seconds..


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=10b74233700000


Tested on:

commit:         aad611a8 Merge tag 'perf-tools-fixes-for-v5.17-2022-03..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=aba0ab2928a512c2
dashboard link: https://syzkaller.appspot.com/bug?extid=2b3af42c0644df1e4da9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1223085d700000

