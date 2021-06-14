Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F98D3A70A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 22:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbhFNUpa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 16:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbhFNUp3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:45:29 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF77CC061574;
        Mon, 14 Jun 2021 13:43:09 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id u30so39811180qke.7;
        Mon, 14 Jun 2021 13:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=yfG0k8KLCNzh6A8hvITkBWMs0gwCgKVQF37fj7MAqZk=;
        b=KU9pThbbYacKC80yHjEYahoqXJ5WEoq9P9QMBYE1O+JnX/lCjnyXrTvhb52fGuVP+K
         yc/uSq+2sK7O0rED73ZAQ27B+iVO50QilYBUXWwDqsZj1v6sFw2s2E/sIPHg5LaDvwxc
         2bIss+vCg7l6ylsxymJwJKfiXRzKrpisOqg4yy1tCKULzhxFV4cQEXI23qK6MMS9XFpn
         nS4Rwdoz8R8cQspqATf1TaU9MOw2+GQAUHycgZl5s2ZWDBYi1SDyoQljlWbGAiIQq3NP
         FUPyNdUR+ajiWxFCjdzSGLId94j80qPfFv1IkRpHYTG0ab8MwwuQ966LM1aidqdPUHsi
         FJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=yfG0k8KLCNzh6A8hvITkBWMs0gwCgKVQF37fj7MAqZk=;
        b=jvXW/+GYRO4OkflOYJ/OMu5t84xmuOeN9wDfv/VwAODT0s7dCLQI3Q/mC1a9kpk/Jh
         h5Tqp3mOCvybaWm9ZPwX7MQpzr2fHoUIyj27vkBHrDHo3I7+7JDucUTzmQ4UMovQedmd
         kOLu2Rf0ITD5DV8PIVweRsyqixRisOWTJPPafIx8nwT8Yqz5t++pc3MRlGCXqlQVustW
         DKy6cRGNf0bOVnrH1qV0cXW/Zz7alW70C1Y8tsrGOLcES+nN3NhUAz/iZIx8FoTuKmWj
         iw+cCztYa4v/4SeYUUoYtlBl2g/XxuELOm4XVxaZJvymyFUcsad+z8ndt24LxPvM4en6
         cc5A==
X-Gm-Message-State: AOAM532WAsEvL/knzuE+F/poloxY+BcD+n7XfxdSHKMLnyzVpUGTo3lm
        gf+RtNq8fpL/hHwU99jqtdoExjfjBuLUqiQkwvg=
X-Google-Smtp-Source: ABdhPJyHpRt1Otn9yUlETYabX0dTPgeXqbjVW5Y4lYOW0d3d0z8jkj6aPOaNBeys4LHMtAbCONnaiCEej6hANscOdCs=
X-Received: by 2002:a05:620a:2f9:: with SMTP id a25mr17851189qko.479.1623703387259;
 Mon, 14 Jun 2021 13:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRQ57=qXo3kygwpwEBOU_CA_eKvdmjP52sU=eFvuVOEGw@mail.gmail.com>
 <CAL3q7H7iOfFFq_vh80Zwb4jJY8NLq-DFBA4yvj7=EbG0AadOzg@mail.gmail.com> <CAJCQCtSDYJKq7rrjMLyaHVz3ELgM7g8DBGJrFMOkrw7aBQW+kA@mail.gmail.com>
In-Reply-To: <CAJCQCtSDYJKq7rrjMLyaHVz3ELgM7g8DBGJrFMOkrw7aBQW+kA@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 14 Jun 2021 21:42:56 +0100
Message-ID: <CAL3q7H7kCNs+fbqyHqwpuJvUudeMKOSWewEfCSdTKc1qFkSiJg@mail.gmail.com>
Subject: Re: WARNING at asm/kfence.h:44 kfence_protect_page
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: multipart/mixed; boundary="0000000000009e68ca05c4bfe774"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000009e68ca05c4bfe774
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 14, 2021 at 9:07 PM Chris Murphy <lists@colorremedies.com> wrot=
e:
>
> On Mon, Jun 14, 2021 at 11:50 AM Filipe Manana <fdmanana@gmail.com> wrote=
:
> >
> > On Mon, Jun 14, 2021 at 6:05 PM Chris Murphy <lists@colorremedies.com> =
wrote:
> > >
> > > 5.12.9-300.fc34.x86_64
> > >
> > > File system is btrfs, 16G RAM, 8G /dev/zram0 is used for swap, and th=
e
> > > workload is:
> > > * bees doing dedup
> > > * btrfs send
> > > * digikam scanning files and writing image metadata to a sqlite datab=
ase
> > > * chrome doing some webby things
> > >
> > > And then kaboom.
> > >
> > > Call trace (easy to read, expires in 7 days):
> > > https://pastebin.com/x5KRU23V
> > >
> > > Same call trace (MUA mangled, for the archive):
> > > [60015.902283] kernel: WARNING: CPU: 3 PID: 58159 at
> > > arch/x86/include/asm/kfence.h:44 kfence_protect_page+0x21/0x80
> > > [60015.902292] kernel: Modules linked in: uinput rfcomm snd_seq_dummy
> > > snd_hrtimer xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT
> > > nf_nat_tftp nf_conntrack_tftp nft_objref nf_conntrack_netbios_ns
> > > nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
> > > 8021q garp mrp nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
> > > nft_reject bridge stp llc nft_ct nft_chain_nat ip6table_nat
> > > ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
> > > nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw
> > > iptable_security ip_set nf_tables nfnetlink ip6table_filter ip6_table=
s
> > > iptable_filter cmac bnep sunrpc vfat fat iwldvm mac80211 btusb btrtl
> > > edac_mce_amd libarc4 btbcm snd_hda_codec_realtek iwlwifi
> > > snd_hda_codec_generic ledtrig_audio btintel snd_hda_codec_hdmi
> > > snd_hda_intel bluetooth kvm_amd snd_intel_dspcfg cfg80211
> > > snd_intel_sdw_acpi ccp snd_hda_codec snd_hda_core kvm snd_hwdep
> > > snd_seq joydev irqbypass snd_seq_device snd_pcm ecdh_generic ecc
> > > k10temp rfkill i2c_piix4 fam15h_power
> > > [60015.902361] kernel:  pcspkr snd_timer snd r8169 soundcore
> > > acpi_cpufreq zram ip_tables amdgpu iommu_v2 gpu_sched crct10dif_pclmu=
l
> > > crc32_pclmul crc32c_intel radeon ghash_clmulni_intel sp5100_tco
> > > i2c_algo_bit drm_ttm_helper ttm drm_kms_helper cec drm video fuse
> > > [60015.902384] kernel: CPU: 3 PID: 58159 Comm: btrfs Not tainted
> > > 5.12.9-300.fc34.x86_64 #1
> > > [60015.902387] kernel: Hardware name: Gigabyte Technology Co., Ltd. T=
o
> > > be filled by O.E.M./F2A88XN-WIFI, BIOS F6 12/24/2015
> > > [60015.902389] kernel: RIP: 0010:kfence_protect_page+0x21/0x80
> > > [60015.902393] kernel: Code: ff 0f 1f 84 00 00 00 00 00 55 48 89 fd 5=
3
> > > 89 f3 48 83 ec 08 48 8d 74 24 04 e8 cb e0 d7 ff 48 85 c0 74 07 83 7c
> > > 24 04 01 74 0b <0f> 0b 48 83 c4 08 31 c0 5b 5d c3 48 8b 38 48 89 c2 8=
4
> > > db 75 36 48
> > > [60015.902396] kernel: RSP: 0018:ffff9fb583453220 EFLAGS: 00010246
> > > [60015.902399] kernel: RAX: 0000000000000000 RBX: 0000000000000000
> > > RCX: ffff9fb583453224
> > > [60015.902401] kernel: RDX: ffff9fb583453224 RSI: 0000000000000000
> > > RDI: 0000000000000000
> > > [60015.902402] kernel: RBP: 0000000000000000 R08: 0000000000000000
> > > R09: 0000000000000000
> > > [60015.902404] kernel: R10: 0000000000000000 R11: 0000000000000000
> > > R12: 0000000000000002
> > > [60015.902406] kernel: R13: ffff9fb583453348 R14: 0000000000000000
> > > R15: 0000000000000001
> > > [60015.902408] kernel: FS:  00007f158e62d8c0(0000)
> > > GS:ffff93bd37580000(0000) knlGS:0000000000000000
> > > [60015.902410] kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
> > > [60015.902412] kernel: CR2: 0000000000000039 CR3: 00000001256d2000
> > > CR4: 00000000000506e0
> > > [60015.902414] kernel: Call Trace:
> > > [60015.902419] kernel:  kfence_unprotect+0x13/0x30
> > > [60015.902423] kernel:  page_fault_oops+0x89/0x270
> > > [60015.902427] kernel:  ? search_module_extables+0xf/0x40
> > > [60015.902431] kernel:  ? search_bpf_extables+0x57/0x70
> > > [60015.902435] kernel:  kernelmode_fixup_or_oops+0xd6/0xf0
> > > [60015.902437] kernel:  __bad_area_nosemaphore+0x142/0x180
> > > [60015.902440] kernel:  exc_page_fault+0x67/0x150
> > > [60015.902445] kernel:  asm_exc_page_fault+0x1e/0x30
> > > [60015.902450] kernel: RIP: 0010:start_transaction+0x71/0x580
> > > [60015.902454] kernel: Code: d3 0f 84 92 00 00 00 80 e7 06 0f 85 63 0=
4
> > > 00 00 65 48 8b 04 25 c0 7b 01 00 4c 8b a0 70 0c 00 00 b8 01 00 00 00
> > > 49 8d 7c 24 38 <f0> 41 0f c1 44 24 38 85 c0 0f 84 41 04 00 00 8d 50 0=
1
> > > 09 c2 0f 88
> > > [60015.902456] kernel: RSP: 0018:ffff9fb5834533f8 EFLAGS: 00010246
> > > [60015.902458] kernel: RAX: 0000000000000001 RBX: 0000000000000001
> > > RCX: 0000000000000000
> > > [60015.902460] kernel: RDX: 0000000000000801 RSI: 0000000000000000
> > > RDI: 0000000000000039
> > > [60015.902462] kernel: RBP: ffff93bc0a7eb800 R08: 0000000000000001
> > > R09: 0000000000000000
> > > [60015.902463] kernel: R10: 0000000000098a00 R11: 0000000000000001
> > > R12: 0000000000000001
> > > [60015.902464] kernel: R13: 0000000000000000 R14: ffff93bc0c92b000
> > > R15: ffff93bc0c92b000
> > > [60015.902468] kernel:  btrfs_commit_inode_delayed_inode+0x5d/0x120
> > > [60015.902473] kernel:  btrfs_evict_inode+0x2c5/0x3f0
> > > [60015.902476] kernel:  evict+0xd1/0x180
> > > [60015.902480] kernel:  inode_lru_isolate+0xe7/0x180
> > > [60015.902483] kernel:  __list_lru_walk_one+0x77/0x150
> > > [60015.902487] kernel:  ? iput+0x1a0/0x1a0
> > > [60015.902489] kernel:  ? iput+0x1a0/0x1a0
> > > [60015.902491] kernel:  list_lru_walk_one+0x47/0x70
> > > [60015.902495] kernel:  prune_icache_sb+0x39/0x50
> > > [60015.902497] kernel:  super_cache_scan+0x161/0x1f0
> > > [60015.902501] kernel:  do_shrink_slab+0x142/0x240
> > > [60015.902505] kernel:  shrink_slab+0x164/0x280
> > > [60015.902509] kernel:  shrink_node+0x2c8/0x6e0
> > > [60015.902512] kernel:  do_try_to_free_pages+0xcb/0x4b0
> > > [60015.902514] kernel:  try_to_free_pages+0xda/0x190
> > > [60015.902516] kernel:  __alloc_pages_slowpath.constprop.0+0x373/0xcc=
0
> > > [60015.902521] kernel:  ? __memcg_kmem_charge_page+0xc2/0x1e0
> > > [60015.902525] kernel:  __alloc_pages_nodemask+0x30a/0x340
> > > [60015.902528] kernel:  pipe_write+0x30b/0x5c0
> > > [60015.902531] kernel:  ? set_next_entity+0xad/0x1e0
> > > [60015.902534] kernel:  ? switch_mm_irqs_off+0x58/0x440
> > > [60015.902538] kernel:  __kernel_write+0x13a/0x2b0
> > > [60015.902541] kernel:  kernel_write+0x73/0x150
> > > [60015.902543] kernel:  send_cmd+0x7b/0xd0
> > > [60015.902545] kernel:  send_extent_data+0x5a3/0x6b0
> > > [60015.902549] kernel:  process_extent+0x19b/0xed0
> > > [60015.902551] kernel:  btrfs_ioctl_send+0x1434/0x17e0
> > > [60015.902554] kernel:  ? _btrfs_ioctl_send+0xe1/0x100
> > > [60015.902557] kernel:  _btrfs_ioctl_send+0xbf/0x100
> > > [60015.902559] kernel:  ? enqueue_entity+0x18c/0x7b0
> > > [60015.902562] kernel:  btrfs_ioctl+0x185f/0x2f80
> > > [60015.902564] kernel:  ? psi_task_change+0x84/0xc0
> > > [60015.902569] kernel:  ? _flat_send_IPI_mask+0x21/0x40
> > > [60015.902572] kernel:  ? check_preempt_curr+0x2f/0x70
> > > [60015.902576] kernel:  ? selinux_file_ioctl+0x137/0x1e0
> > > [60015.902579] kernel:  ? expand_files+0x1cb/0x1d0
> > > [60015.902582] kernel:  ? __x64_sys_ioctl+0x82/0xb0
> > > [60015.902585] kernel:  __x64_sys_ioctl+0x82/0xb0
> > > [60015.902588] kernel:  do_syscall_64+0x33/0x40
> > > [60015.902591] kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > [60015.902595] kernel: RIP: 0033:0x7f158e38f0ab
> >
> > The problem is we end up trying to start a transaction while in a send
> > context, which is unexpected. But it does happen if memory allocation
> > triggers inode eviction due to memory pressure.
> >
> > You don't have CONFIG_BTRFS_ASSERT=3Dy in your kernel config right?
>
> No, but Fedora debug kernels do have it enabled so I can ask the
> reporter to use 5.12.10-debug or 5.13-rc6. Any preference?

No preference.
It's a problem that has been around for several years now, and not
something recent.

Ok, so it was reported before. Anywhere public, or was it something private=
?

>
>
> > That would trigger an assertion right away:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/f=
s/btrfs/transaction.c?h=3Dv5.12.10#n584
> >
> > With assertions disabled, we just cast current->journal_info into a
> > transaction handle and dereference it, which is obviously wrong since
> > ->jornal_info has a value that is not a pointer to a transaction
> > handle, resulting in the crash.
> >
> > How easy is it to reproduce for you?
>
> I'm not sure.
>
> Do you think following this splat we could have somehow been IO
> limited or stalled without any other kernel messages appearing? That
> would then cause reclaim activity, and high memory and swap usage? I'm
> wondering if it's likely or unlikely, because at the moment I think
> it's unlikely since /var/log/journal was successfully recording
> systemd-journald journals for the 81 minutes between this call trace
> and when systemd-oomd started killing things. I'm trying to separate
> out what's causing what.

Don't know about that. And honestly I don't think that it matters.
The send task writes to a pipe and writing to a pipe allocates pages
without GFP_NOFS (with GFP_HIGHUSER | __GFP_ACCOUNT to be precise),
meaning we can end up evicting an inode, which in turn needs to start
a transaction.

That patch would be my preferred way to fix it.
If it doesn't work for any reason, then we can simply set up a NOFS
context surrounding the calls in send to write to the pipe, like this:

https://pastebin.com/raw/tTrfAw0m
(also attached)

I would have to test the first patch in a scenario under heavy memory
pressure to see if there isn't anything I might have missed, but I
think it should work just fine.
I'll test it tomorrow too.

Thanks.

>
> > Can you try the following patch and see if everything works as expected=
?
>
> I'll ask the reporter. I don't have a setup even remotely approximate
> to this one for testing.
>
> Thanks!
>
> --
> Chris Murphy



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

--0000000000009e68ca05c4bfe774
Content-Type: text/x-patch; charset="US-ASCII"; name="send_nofs_pipe_write.patch"
Content-Disposition: attachment; filename="send_nofs_pipe_write.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kpx2wim10>
X-Attachment-Id: f_kpx2wim10

ZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3NlbmQuYyBiL2ZzL2J0cmZzL3NlbmQuYwppbmRleCBhMmIz
YzU5NDM3OWQuLmQ4NjY3YzA3YzRlYiAxMDA2NDQKLS0tIGEvZnMvYnRyZnMvc2VuZC5jCisrKyBi
L2ZzL2J0cmZzL3NlbmQuYwpAQCAtNTQ4LDI0ICs1NDgsMzIgQEAgc3RhdGljIHN0cnVjdCBidHJm
c19wYXRoICphbGxvY19wYXRoX2Zvcl9zZW5kKHZvaWQpCiAKIHN0YXRpYyBpbnQgd3JpdGVfYnVm
KHN0cnVjdCBmaWxlICpmaWxwLCBjb25zdCB2b2lkICpidWYsIHUzMiBsZW4sIGxvZmZfdCAqb2Zm
KQogewotCWludCByZXQ7CisJaW50IHJldCA9IDA7CiAJdTMyIHBvcyA9IDA7CisJdW5zaWduZWQg
bm9mc19mbGFnOwogCisJLyoKKwkgKiBQaXBlIHdyaXRlcyBjYW4gYWxsb2NhdGUgcGFnZXMgd2hp
Y2ggY2FuIHRyaWdnZXIgcmVjbGFpbSBhbmQgY2F1c2UKKwkgKiBhIGNyYXNoIGlmIHJlY2xhaW0g
dHJpZ2dlcnMgaW5vZGUgZXZpY3Rpb24gYW5kIHRoYXQgbmVlZHMgdG8gc3RhcnQgYQorCSAqIHRy
YW5zYWN0aW9uLiBTbyB1c2UgYSBOT0ZTIGNvbnRleHQuCisJICovCisJbm9mc19mbGFnID0gbWVt
YWxsb2Nfbm9mc19zYXZlKCk7CiAJd2hpbGUgKHBvcyA8IGxlbikgewogCQlyZXQgPSBrZXJuZWxf
d3JpdGUoZmlscCwgYnVmICsgcG9zLCBsZW4gLSBwb3MsIG9mZik7CiAJCS8qIFRPRE8gaGFuZGxl
IHRoYXQgY29ycmVjdGx5ICovCiAJCS8qaWYgKHJldCA9PSAtRVJFU1RBUlRTWVMpIHsKIAkJCWNv
bnRpbnVlOwogCQl9Ki8KKwkJaWYgKHJldCA9PSAwKQorCQkJcmV0ID0gLUVJTzsKIAkJaWYgKHJl
dCA8IDApCi0JCQlyZXR1cm4gcmV0OwotCQlpZiAocmV0ID09IDApIHsKLQkJCXJldHVybiAtRUlP
OwotCQl9CisJCQlicmVhazsKIAkJcG9zICs9IHJldDsKKwkJcmV0ID0gMDsKIAl9CisJbWVtYWxs
b2Nfbm9mc19yZXN0b3JlKG5vZnNfZmxhZyk7CiAKLQlyZXR1cm4gMDsKKwlyZXR1cm4gcmV0Owog
fQogCiBzdGF0aWMgaW50IHRsdl9wdXQoc3RydWN0IHNlbmRfY3R4ICpzY3R4LCB1MTYgYXR0ciwg
Y29uc3Qgdm9pZCAqZGF0YSwgaW50IGxlbikK
--0000000000009e68ca05c4bfe774--
