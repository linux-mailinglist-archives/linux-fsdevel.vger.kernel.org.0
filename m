Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F383A6DA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 19:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhFNRxY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 13:53:24 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:37672 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbhFNRxY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 13:53:24 -0400
Received: by mail-qt1-f180.google.com with SMTP id z4so9215766qts.4;
        Mon, 14 Jun 2021 10:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=lyHOw33Sn2cbMJsbXSNZBVrNlVbDI+30YHAWZSJi4lI=;
        b=ooJnYMlOrOMb2S15ujasQIg7jJnt2OYRoq0OUId3o9BAF6ACQZQcjBiOq44eYvz/Bp
         JM9KPKsMSHhTwUKkG9AVeaHGeOge1PpCOoa9BQKSYhHs/f+y/wnDhGKSBItF2rPr8yb6
         Gr4UKCyCUXtIY0aDLsQ9lR/dv9v4vknX+2T8SA/kMq3w+A359SKMFa/qLqzoIYhvMrEJ
         ckMZPZaAMZNtT4fX0k93AuNlN2zUUR4XYYLcpefPU1OoDtV70oAhzzsyDz7dzIwUxPb9
         fEeCKG1MzMP+vXYx0JrTk0bAKPXSO0fI84cbR2jUWFQLKGRD2UNsSURROecBvKd4j1MJ
         erhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=lyHOw33Sn2cbMJsbXSNZBVrNlVbDI+30YHAWZSJi4lI=;
        b=eQ17I/+LG7Z8VHTSlfiOGuOe6v0JSK347wxR6H6t4Yrg/u6qnO0vKZmHdMFXcW8zRb
         NN1VfgDT2UhIRc2yCbP8yb78RNjqZHRschFVASuW4Oe0f1x/dzE21c/TPrJFdHZQjG9t
         kI2NCw9eZXrpiat8Lby+1QxoZtJWUyH+JpO9g2W+87OW1+V/fcvlWz7FlMqOp+MVrff8
         Uaq87Zb/erVUKrkDX+4kmeexPcLVq/54VA3jSnpELucmdyw8dxDU8jelub1MkVQg3oV9
         QVKT6EVu1LgCBsc2vWSa+ak/uwh+XBMjg/85Cfo54+TwffYwMdWwUucN09OSjow93ORw
         PdMQ==
X-Gm-Message-State: AOAM532Yy7CKBpU3dajG4HUJTwVT4CeCULotUXoVOPiREerIimOLDSkO
        ENbl0oXdENSj5xsHCBNZv6XYqpjNa+y5a2nIQEk=
X-Google-Smtp-Source: ABdhPJwTfHyq/SD+if4NS59b4wzT7pY+EW34d7Ru4cEe/KufDXD+r8OZ8gat3GtifNRwshyy+p4+zr0hs6doECIH7zw=
X-Received: by 2002:a05:622a:1c2:: with SMTP id t2mr17746433qtw.213.1623693020752;
 Mon, 14 Jun 2021 10:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRQ57=qXo3kygwpwEBOU_CA_eKvdmjP52sU=eFvuVOEGw@mail.gmail.com>
In-Reply-To: <CAJCQCtRQ57=qXo3kygwpwEBOU_CA_eKvdmjP52sU=eFvuVOEGw@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 14 Jun 2021 18:50:09 +0100
Message-ID: <CAL3q7H7iOfFFq_vh80Zwb4jJY8NLq-DFBA4yvj7=EbG0AadOzg@mail.gmail.com>
Subject: Re: WARNING at asm/kfence.h:44 kfence_protect_page
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: multipart/mixed; boundary="000000000000ba1aef05c4bd7d21"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000ba1aef05c4bd7d21
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 14, 2021 at 6:05 PM Chris Murphy <lists@colorremedies.com> wrot=
e:
>
> 5.12.9-300.fc34.x86_64
>
> File system is btrfs, 16G RAM, 8G /dev/zram0 is used for swap, and the
> workload is:
> * bees doing dedup
> * btrfs send
> * digikam scanning files and writing image metadata to a sqlite database
> * chrome doing some webby things
>
> And then kaboom.
>
> Call trace (easy to read, expires in 7 days):
> https://pastebin.com/x5KRU23V
>
> Same call trace (MUA mangled, for the archive):
> [60015.902283] kernel: WARNING: CPU: 3 PID: 58159 at
> arch/x86/include/asm/kfence.h:44 kfence_protect_page+0x21/0x80
> [60015.902292] kernel: Modules linked in: uinput rfcomm snd_seq_dummy
> snd_hrtimer xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT
> nf_nat_tftp nf_conntrack_tftp nft_objref nf_conntrack_netbios_ns
> nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
> 8021q garp mrp nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
> nft_reject bridge stp llc nft_ct nft_chain_nat ip6table_nat
> ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw
> iptable_security ip_set nf_tables nfnetlink ip6table_filter ip6_tables
> iptable_filter cmac bnep sunrpc vfat fat iwldvm mac80211 btusb btrtl
> edac_mce_amd libarc4 btbcm snd_hda_codec_realtek iwlwifi
> snd_hda_codec_generic ledtrig_audio btintel snd_hda_codec_hdmi
> snd_hda_intel bluetooth kvm_amd snd_intel_dspcfg cfg80211
> snd_intel_sdw_acpi ccp snd_hda_codec snd_hda_core kvm snd_hwdep
> snd_seq joydev irqbypass snd_seq_device snd_pcm ecdh_generic ecc
> k10temp rfkill i2c_piix4 fam15h_power
> [60015.902361] kernel:  pcspkr snd_timer snd r8169 soundcore
> acpi_cpufreq zram ip_tables amdgpu iommu_v2 gpu_sched crct10dif_pclmul
> crc32_pclmul crc32c_intel radeon ghash_clmulni_intel sp5100_tco
> i2c_algo_bit drm_ttm_helper ttm drm_kms_helper cec drm video fuse
> [60015.902384] kernel: CPU: 3 PID: 58159 Comm: btrfs Not tainted
> 5.12.9-300.fc34.x86_64 #1
> [60015.902387] kernel: Hardware name: Gigabyte Technology Co., Ltd. To
> be filled by O.E.M./F2A88XN-WIFI, BIOS F6 12/24/2015
> [60015.902389] kernel: RIP: 0010:kfence_protect_page+0x21/0x80
> [60015.902393] kernel: Code: ff 0f 1f 84 00 00 00 00 00 55 48 89 fd 53
> 89 f3 48 83 ec 08 48 8d 74 24 04 e8 cb e0 d7 ff 48 85 c0 74 07 83 7c
> 24 04 01 74 0b <0f> 0b 48 83 c4 08 31 c0 5b 5d c3 48 8b 38 48 89 c2 84
> db 75 36 48
> [60015.902396] kernel: RSP: 0018:ffff9fb583453220 EFLAGS: 00010246
> [60015.902399] kernel: RAX: 0000000000000000 RBX: 0000000000000000
> RCX: ffff9fb583453224
> [60015.902401] kernel: RDX: ffff9fb583453224 RSI: 0000000000000000
> RDI: 0000000000000000
> [60015.902402] kernel: RBP: 0000000000000000 R08: 0000000000000000
> R09: 0000000000000000
> [60015.902404] kernel: R10: 0000000000000000 R11: 0000000000000000
> R12: 0000000000000002
> [60015.902406] kernel: R13: ffff9fb583453348 R14: 0000000000000000
> R15: 0000000000000001
> [60015.902408] kernel: FS:  00007f158e62d8c0(0000)
> GS:ffff93bd37580000(0000) knlGS:0000000000000000
> [60015.902410] kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [60015.902412] kernel: CR2: 0000000000000039 CR3: 00000001256d2000
> CR4: 00000000000506e0
> [60015.902414] kernel: Call Trace:
> [60015.902419] kernel:  kfence_unprotect+0x13/0x30
> [60015.902423] kernel:  page_fault_oops+0x89/0x270
> [60015.902427] kernel:  ? search_module_extables+0xf/0x40
> [60015.902431] kernel:  ? search_bpf_extables+0x57/0x70
> [60015.902435] kernel:  kernelmode_fixup_or_oops+0xd6/0xf0
> [60015.902437] kernel:  __bad_area_nosemaphore+0x142/0x180
> [60015.902440] kernel:  exc_page_fault+0x67/0x150
> [60015.902445] kernel:  asm_exc_page_fault+0x1e/0x30
> [60015.902450] kernel: RIP: 0010:start_transaction+0x71/0x580
> [60015.902454] kernel: Code: d3 0f 84 92 00 00 00 80 e7 06 0f 85 63 04
> 00 00 65 48 8b 04 25 c0 7b 01 00 4c 8b a0 70 0c 00 00 b8 01 00 00 00
> 49 8d 7c 24 38 <f0> 41 0f c1 44 24 38 85 c0 0f 84 41 04 00 00 8d 50 01
> 09 c2 0f 88
> [60015.902456] kernel: RSP: 0018:ffff9fb5834533f8 EFLAGS: 00010246
> [60015.902458] kernel: RAX: 0000000000000001 RBX: 0000000000000001
> RCX: 0000000000000000
> [60015.902460] kernel: RDX: 0000000000000801 RSI: 0000000000000000
> RDI: 0000000000000039
> [60015.902462] kernel: RBP: ffff93bc0a7eb800 R08: 0000000000000001
> R09: 0000000000000000
> [60015.902463] kernel: R10: 0000000000098a00 R11: 0000000000000001
> R12: 0000000000000001
> [60015.902464] kernel: R13: 0000000000000000 R14: ffff93bc0c92b000
> R15: ffff93bc0c92b000
> [60015.902468] kernel:  btrfs_commit_inode_delayed_inode+0x5d/0x120
> [60015.902473] kernel:  btrfs_evict_inode+0x2c5/0x3f0
> [60015.902476] kernel:  evict+0xd1/0x180
> [60015.902480] kernel:  inode_lru_isolate+0xe7/0x180
> [60015.902483] kernel:  __list_lru_walk_one+0x77/0x150
> [60015.902487] kernel:  ? iput+0x1a0/0x1a0
> [60015.902489] kernel:  ? iput+0x1a0/0x1a0
> [60015.902491] kernel:  list_lru_walk_one+0x47/0x70
> [60015.902495] kernel:  prune_icache_sb+0x39/0x50
> [60015.902497] kernel:  super_cache_scan+0x161/0x1f0
> [60015.902501] kernel:  do_shrink_slab+0x142/0x240
> [60015.902505] kernel:  shrink_slab+0x164/0x280
> [60015.902509] kernel:  shrink_node+0x2c8/0x6e0
> [60015.902512] kernel:  do_try_to_free_pages+0xcb/0x4b0
> [60015.902514] kernel:  try_to_free_pages+0xda/0x190
> [60015.902516] kernel:  __alloc_pages_slowpath.constprop.0+0x373/0xcc0
> [60015.902521] kernel:  ? __memcg_kmem_charge_page+0xc2/0x1e0
> [60015.902525] kernel:  __alloc_pages_nodemask+0x30a/0x340
> [60015.902528] kernel:  pipe_write+0x30b/0x5c0
> [60015.902531] kernel:  ? set_next_entity+0xad/0x1e0
> [60015.902534] kernel:  ? switch_mm_irqs_off+0x58/0x440
> [60015.902538] kernel:  __kernel_write+0x13a/0x2b0
> [60015.902541] kernel:  kernel_write+0x73/0x150
> [60015.902543] kernel:  send_cmd+0x7b/0xd0
> [60015.902545] kernel:  send_extent_data+0x5a3/0x6b0
> [60015.902549] kernel:  process_extent+0x19b/0xed0
> [60015.902551] kernel:  btrfs_ioctl_send+0x1434/0x17e0
> [60015.902554] kernel:  ? _btrfs_ioctl_send+0xe1/0x100
> [60015.902557] kernel:  _btrfs_ioctl_send+0xbf/0x100
> [60015.902559] kernel:  ? enqueue_entity+0x18c/0x7b0
> [60015.902562] kernel:  btrfs_ioctl+0x185f/0x2f80
> [60015.902564] kernel:  ? psi_task_change+0x84/0xc0
> [60015.902569] kernel:  ? _flat_send_IPI_mask+0x21/0x40
> [60015.902572] kernel:  ? check_preempt_curr+0x2f/0x70
> [60015.902576] kernel:  ? selinux_file_ioctl+0x137/0x1e0
> [60015.902579] kernel:  ? expand_files+0x1cb/0x1d0
> [60015.902582] kernel:  ? __x64_sys_ioctl+0x82/0xb0
> [60015.902585] kernel:  __x64_sys_ioctl+0x82/0xb0
> [60015.902588] kernel:  do_syscall_64+0x33/0x40
> [60015.902591] kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [60015.902595] kernel: RIP: 0033:0x7f158e38f0ab

The problem is we end up trying to start a transaction while in a send
context, which is unexpected. But it does happen if memory allocation
triggers inode eviction due to memory pressure.

You don't have CONFIG_BTRFS_ASSERT=3Dy in your kernel config right?
That would trigger an assertion right away:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/fs/bt=
rfs/transaction.c?h=3Dv5.12.10#n584

With assertions disabled, we just cast current->journal_info into a
transaction handle and dereference it, which is obviously wrong since
->jornal_info has a value that is not a pointer to a transaction
handle, resulting in the crash.

How easy is it to reproduce for you?

Can you try the following patch and see if everything works as expected?

https://pastebin.com/raw/F4giWLVt
(also attached)

Thanks.

> [60015.902599] kernel: Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff
> 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10
> 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 95 bd 0c 00 f7 d8
> 64 89 01 48
> [60015.902602] kernel: RSP: 002b:00007ffcb2519bf8 EFLAGS: 00000246
> ORIG_RAX: 0000000000000010
> [60015.902605] kernel: RAX: ffffffffffffffda RBX: 00007ffcb251ae00
> RCX: 00007f158e38f0ab
> [60015.902607] kernel: RDX: 00007ffcb2519cf0 RSI: 0000000040489426
> RDI: 0000000000000004
> [60015.902608] kernel: RBP: 0000000000000004 R08: 00007f158e297640
> R09: 00007f158e297640
> [60015.902610] kernel: R10: 0000000000000008 R11: 0000000000000246
> R12: 0000000000000000
> [60015.902612] kernel: R13: 0000000000000002 R14: 00007ffcb251aee0
> R15: 0000558c1a83e2a0
> [60015.902615] kernel: ---[ end trace 7bbc33e23bb887ae ]---
>
>
> The full dmesg is attached to this downstream bug as "
> journal-nobees.log (4.12 MB, text/plain)" which has all the beesd
> entries removed (over 300M).
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1971327
>
> The time between this oops and systemd-oomd starting to kill things
> due to both swap and memory pressure is 81 minutes. I'm not sure the
> two events are related. Or what the above stack trace is saying. Or
> the consequences of it. But the system got wedged in totally
> unresponsive and had to be forced off with the power button.
>
> Thanks,
>
>
> --
> Chris Murphy



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

--000000000000ba1aef05c4bd7d21
Content-Type: text/x-patch; charset="US-ASCII"; name="send_evict_fix.patch"
Content-Disposition: attachment; filename="send_evict_fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kpwwvghy0>
X-Attachment-Id: f_kpwwvghy0

ZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2lub2RlLmMgYi9mcy9idHJmcy9pbm9kZS5jCmluZGV4IDNj
ZDUyODY1NzJkNC4uMDJiZjJmYmUzZTg0IDEwMDY0NAotLS0gYS9mcy9idHJmcy9pbm9kZS5jCisr
KyBiL2ZzL2J0cmZzL2lub2RlLmMKQEAgLTU0MjcsMTggKzU0MjcsMjAgQEAgc3RhdGljIHN0cnVj
dCBidHJmc190cmFuc19oYW5kbGUgKmV2aWN0X3JlZmlsbF9hbmRfam9pbihzdHJ1Y3QgYnRyZnNf
cm9vdCAqcm9vdCwKIAogdm9pZCBidHJmc19ldmljdF9pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2Rl
KQogeworCWNvbnN0IGJvb2wgaW5fc2VuZCA9IChjdXJyZW50LT5qb3VybmFsX2luZm8gPT0gQlRS
RlNfU0VORF9UUkFOU19TVFVCKTsKIAlzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbyA9IGJ0
cmZzX3NiKGlub2RlLT5pX3NiKTsKIAlzdHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFuczsK
IAlzdHJ1Y3QgYnRyZnNfcm9vdCAqcm9vdCA9IEJUUkZTX0koaW5vZGUpLT5yb290OwogCXN0cnVj
dCBidHJmc19ibG9ja19yc3YgKnJzdjsKIAlpbnQgcmV0OwogCisJaWYgKGluX3NlbmQpCisJCWN1
cnJlbnQtPmpvdXJuYWxfaW5mbyA9IE5VTEw7CisKIAl0cmFjZV9idHJmc19pbm9kZV9ldmljdChp
bm9kZSk7CiAKLQlpZiAoIXJvb3QpIHsKLQkJY2xlYXJfaW5vZGUoaW5vZGUpOwotCQlyZXR1cm47
Ci0JfQorCWlmICghcm9vdCkKKwkJZ290byBvdXQ7CiAKIAlldmljdF9pbm9kZV90cnVuY2F0ZV9w
YWdlcyhpbm9kZSk7CiAKQEAgLTU1MTgsNyArNTUyMCwxMSBAQCB2b2lkIGJ0cmZzX2V2aWN0X2lu
b2RlKHN0cnVjdCBpbm9kZSAqaW5vZGUpCiAJICogdG8gcmV0cnkgdGhlc2UgcGVyaW9kaWNhbGx5
IGluIHRoZSBmdXR1cmUuCiAJICovCiAJYnRyZnNfcmVtb3ZlX2RlbGF5ZWRfbm9kZShCVFJGU19J
KGlub2RlKSk7CitvdXQ6CiAJY2xlYXJfaW5vZGUoaW5vZGUpOworCWlmIChpbl9zZW5kKQorCQlj
dXJyZW50LT5qb3VybmFsX2luZm8gPSBCVFJGU19TRU5EX1RSQU5TX1NUVUI7CisKIH0KIAogLyoK
--000000000000ba1aef05c4bd7d21--
