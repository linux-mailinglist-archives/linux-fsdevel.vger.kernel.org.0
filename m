Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C6B4164A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 19:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242528AbhIWRwV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 13:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241766AbhIWRwV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:52:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C07BC061574;
        Thu, 23 Sep 2021 10:50:49 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 203so6385960pfy.13;
        Thu, 23 Sep 2021 10:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1GIS45VNFXQZ1SjVJchS8FFumy6aY4QEfv4497UZafA=;
        b=VD9HrfzEfQBtXU8DaCP+C1zyz90umMYzm5EJ4Kntz45p6XQ7vT2Zw77GC+qmjIA1Lh
         WDgsSO7afeI2X7Qog2tOpg5EjOb3OVmiic2pdptyPs/VksQS9wmIRIEM8+sqHVohLzGj
         /ok781cztgQjuGq62a5GSHNP9Q3qQEBBSAi7WpAqYin39lktBTgRefgg5UfoOKrLnERj
         rok07ASqGvypj8CNmSqIiIGuye3FNqyMXnbm4mjpbadZTYfgL4wvTpXLFjUaYD7T2Y6s
         QsbCWbtng62Ir8jDYjH6R97LqmrNyy2U+9Y+7VO8GD81U1dl9mQkfdQW0fr9c6ZeHbbw
         Y5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1GIS45VNFXQZ1SjVJchS8FFumy6aY4QEfv4497UZafA=;
        b=DPob6VL3eipFr3d+vh4cHe4PACYl3vlqZVFkSK/UaeN+r2RJBVuqXWmk132lUomezX
         ItRSB/B7o4mVPYjC7x4sDBReyZlSYJ1zCXh74vmj75uC+e6HrTBGMGM2pXuVwvMQRkpK
         NhRnYgPSm62imd76b2b9Ykv7v6gfu4Yst+joGDm09R5VQtRCJxUM6KLgGNVO/jmX9v6a
         BCfWR/D1FtmEydS5P2n/so8aNLjUjWegCD+ReE2gueDlLTZ4Zl/9/R5R9yib1CeJwsrr
         CQ6Lfi/yZ9d2QsXR2Ya9cLjycxsGbnG1sSzuIvuRTZEbkt5oY04KyIUfvRJVb8WdbAmR
         rP8g==
X-Gm-Message-State: AOAM531b5W8BjYC/lU7ElJAumUEpHNuG5VpGaJ0qpW0RCiKp4LC/PlIX
        xZ2dacQyJru3X6u3HrzPokQ=
X-Google-Smtp-Source: ABdhPJz8NaW/vYuBNPEWsj+RJ8MKxJf3PTSs+GShiP2leg4cScph2679mLgWhtiqxiEMGz+Z4F1hGQ==
X-Received: by 2002:a63:bf4a:: with SMTP id i10mr5517254pgo.196.1632419448820;
        Thu, 23 Sep 2021 10:50:48 -0700 (PDT)
Received: from [10.46.203.121] ([154.21.216.189])
        by smtp.gmail.com with ESMTPSA id z14sm6411685pfr.154.2021.09.23.10.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 10:50:48 -0700 (PDT)
To:     djwong@kernel.org
Cc:     kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210914025843.GA638460@magnolia>
Subject: Re: kvm crash in 5.14.1?
From:   Stephen <stephenackerman16@gmail.com>
Message-ID: <2b5ca6d3-fa7b-5e2f-c353-f07dcff993c1@gmail.com>
Date:   Thu, 23 Sep 2021 10:50:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914025843.GA638460@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've noticed this as well on 5.14.1 and 5.14.3. On 5.14.1, I was using
the system (my desktop), and the VMs started to die followed by the host
system slowly grinding to a halt.

On 5.14.3, it died overnight. 5.13.x doesn't seem to be effected from
what I've seen.

The crash happens after a number of days (or a week+) with only 3 VMs
running and desktop usage.


BUG: kernel NULL pointer dereference, address: 0000000000000068
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP NOPTI
CPU: 3 PID: 1185197 Comm: CPU 7/KVM Tainted: G            E     5.14.3 #26
Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE WIFI/X570
AORUS ELITE WIFI, BIOS F35 07/08/2021
RIP: 0010:internal_get_user_pages_fast+0x738/0xda0
Code: 84 24 a0 00 00 00 65 48 2b 04 25 28 00 00 00 0f 85 54 06 00 00 48
81 c4 a8 00 00 00 44 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <48> 81 78
68 a0 a3 63 82 0f 85 14 fe ff ff 44 89 f2 be 01 00 00 00
RSP: 0018:ffffa701c4d5bb40 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffcc156c899980 RCX: ffffcc156c8999b4
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffcc156c899980
RBP: 00007f1e2aec1000 R08: 0000000000000000 R09: ffffcc156c899980
R10: 0000000000000000 R11: 000000000000000c R12: ffff9176c47bd600
R13: 000000ffffffffff R14: 0000000000080005 R15: 8000000b22666867
FS:  00007f1d4a5fc700(0000) GS:ffff91817eac0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000068 CR3: 000000074f36a000 CR4: 0000000000350ee0
Call Trace:
 get_user_pages_fast_only+0x13/0x20
 __direct_pte_prefetch+0x12d/0x240 [kvm]
 ? mmu_set_spte+0x335/0x4d0 [kvm]
 ? kvm_mmu_max_mapping_level+0xda/0xf0 [kvm]
 direct_page_fault+0x850/0xab0 [kvm]
 ? kvm_mtrr_check_gfn_range_consistency+0x61/0x120 [kvm]
 kvm_check_async_pf_completion+0x9a/0x110 [kvm]
 kvm_arch_vcpu_ioctl_run+0x1667/0x16a0 [kvm]
 kvm_vcpu_ioctl+0x267/0x650 [kvm]
 __x64_sys_ioctl+0x83/0xb0
 do_syscall_64+0x3b/0xc0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f1e5a033cc7
Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff
ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 99 91 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007f1d4a5fb5c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007f1e5a033cc7
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000000000000001c
RBP: 0000564ae48beaa0 R08: 0000564ae30405b8 R09: 00000000000000ff
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 0000564ae348b020 R14: 0000000000000001 R15: 0000000000000000
Modules linked in: md4(E) nls_utf8(E) cifs(E) dns_resolver(E) fscache(E)
netfs(E) libdes(E) ufs(E) qnx4(E) hfsplus(E) hfs(E) minix(E) msdos(E)
jfs(E) xfs(E) cpuid(E) ses(E) enclosure(E) scsi_transport_sas(E)
udp_diag(E) tcp_diag(E) inet_diag(E) dm_mod(E) vhost_net(E) tun(E)
vhost(E) vhost_iotlb(E) macvtap(E) macvlan(E) tap(E) xt_addrtype(E)
xt_nat(E) wireguard(E) libchacha20poly1305(E) chacha_x86_64(E)
poly1305_x86_64(E) libblake2s(E) blake2s_x86_64(E) curve25519_x86_64(E)
libcurve25519_generic(E) libchacha(E) libblake2s_generic(E)
ip6_udp_tunnel(E) udp_tunnel(E) rfcomm(E) snd_seq_dummy(E)
snd_hrtimer(E) snd_seq(E) ip6t_REJECT(E) nf_reject_ipv6(E)
xt_multiport(E) xt_cgroup(E) xt_mark(E) xt_owner(E) xt_CHECKSUM(E)
cdc_acm(E) xt_MASQUERADE(E) xt_conntrack(E) ipt_REJECT(E)
nf_reject_ipv4(E) xt_tcpudp(E) nft_compat(E) nft_chain_nat(E) nf_nat(E)
nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) cmac(E)
algif_hash(E) algif_skcipher(E) af_alg(E) nft_counter(E) nf_tables(E)
 bridge(E) stp(E) llc(E) nfnetlink(E) bnep(E) binfmt_misc(E)
intel_rapl_msr(E) intel_rapl_common(E) edac_mce_amd(E) btusb(E) btrtl(E)
snd_hda_codec_realtek(E) btbcm(E) btintel(E) snd_hda_codec_generic(E)
ledtrig_audio(E) bluetooth(E) snd_hda_codec_hdmi(E) snd_hda_intel(E)
snd_intel_dspcfg(E) snd_intel_sdw_acpi(E) uvcvideo(E)
jitterentropy_rng(E) snd_hda_codec(E) snd_usb_audio(E)
videobuf2_vmalloc(E) videobuf2_memops(E) snd_usbmidi_lib(E)
snd_hda_core(E) iwlmvm(E) snd_rawmidi(E) sha512_ssse3(E) kvm_amd(E)
videobuf2_v4l2(E) snd_hwdep(E) snd_seq_device(E) sha512_generic(E)
nls_ascii(E) mac80211(E) videobuf2_common(E) snd_pcm(E) nls_cp437(E)
libarc4(E) drbg(E) snd_timer(E) ansi_cprng(E) kvm(E) videodev(E) vfat(E)
irqbypass(E) iwlwifi(E) sp5100_tco(E) ecdh_generic(E) ccp(E) fat(E)
mc(E) joydev(E) rapl(E) watchdog(E) ecc(E) k10temp(E) wmi_bmof(E)
efi_pstore(E) pcspkr(E) snd(E) rng_core(E) soundcore(E) sg(E)
cfg80211(E) rfkill(E) evdev(E) acpi_cpufreq(E) msr(E) parport_pc(E)
 ppdev(E) lp(E) parport(E) fuse(E) configfs(E) sunrpc(E) efivarfs(E)
ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc16(E) mbcache(E) jbd2(E)
btrfs(E) blake2b_generic(E) zstd_compress(E) raid10(E) raid1(E) raid0(E)
multipath(E) linear(E) raid456(E) async_raid6_recov(E) async_memcpy(E)
async_pq(E) async_xor(E) async_tx(E) xor(E) hid_logitech_hidpp(E)
raid6_pq(E) libcrc32c(E) crc32c_generic(E) md_mod(E) sr_mod(E) cdrom(E)
sd_mod(E) hid_logitech_dj(E) hid_generic(E) usbhid(E) hid(E) uas(E)
usb_storage(E) crc32_pclmul(E) crc32c_intel(E) ghash_clmulni_intel(E)
amdgpu(E) gpu_sched(E) drm_ttm_helper(E) nvme(E) ttm(E) nvme_core(E)
aesni_intel(E) t10_pi(E) igb(E) ahci(E) libaes(E) drm_kms_helper(E)
libahci(E) crc_t10dif(E) xhci_pci(E) dca(E) crypto_simd(E) cec(E) ptp(E)
crct10dif_generic(E) cryptd(E) libata(E) xhci_hcd(E) pps_core(E)
crct10dif_pclmul(E) i2c_piix4(E) drm(E) scsi_mod(E) usbcore(E)
i2c_algo_bit(E) crct10dif_common(E) wmi(E) button(E)
CR2: 0000000000000068
---[ end trace 1b0e733016be1d2c ]---
RIP: 0010:internal_get_user_pages_fast+0x738/0xda0
Code: 84 24 a0 00 00 00 65 48 2b 04 25 28 00 00 00 0f 85 54 06 00 00 48
81 c4 a8 00 00 00 44 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <48> 81 78
68 a0 a3 63 82 0f 85 14 fe ff ff 44 89 f2 be 01 00 00 00
RSP: 0018:ffffa701c4d5bb40 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffcc156c899980 RCX: ffffcc156c8999b4
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffcc156c899980
RBP: 00007f1e2aec1000 R08: 0000000000000000 R09: ffffcc156c899980
R10: 0000000000000000 R11: 000000000000000c R12: ffff9176c47bd600
R13: 000000ffffffffff R14: 0000000000080005 R15: 8000000b22666867
FS:  00007f1d4a5fc700(0000) GS:ffff91817eac0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000068 CR3: 000000074f36a000 CR4: 0000000000350ee0
watchdog: BUG: soft lockup - CPU#22 stuck for 22s! [CPU 0/KVM:1185190]


These messages were retrieved via `journalctl --boot=-1`.

After this error, there are fairly continuous "soft lockup" messages and
stacks in journalctl, and the system had to be hard-booted to get an
interactive environment back. Screens would not wake, and SSH was not
accessible. Even REISUB didn't seem to work.

Just in case it's useful: I'm running a Ryzen 9 3900X, 64GB of RAM, 970
Evo Plus for / (ext4), RAID6 (4x8TB SATA drives) for /home (ext4), and
reference AMD Radeon 6700XT. The VMs are running off of the 970 Evo Plus.

I'm now running 5.14.6 after the latest boot; if I run into this again,
I'll follow up.

