Return-Path: <linux-fsdevel+bounces-72634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4FDCFECD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 17:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C52F7300119F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 16:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015AE36CDFB;
	Wed,  7 Jan 2026 15:17:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACACF36CDE0
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767799070; cv=none; b=OEZkGzrGYmPRwh7x6a32D8bL1eCS+djTWczP8LQjqhuUz9UNxP/lFzzswPkluOLHaUJknXT0m8XVMNzjOItWyRYt3X/IATnjEB/iRcrSgtjZxMwbsxYAl8uznMrmlneeULQhCVKS20KjIW8ZEV/flm1HYKI23iQxFO0r3VuDJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767799070; c=relaxed/simple;
	bh=nmoakUsJf+I0F2kKMD/OvejZGDzavy8WZ6AiElzjA1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Su9x35e3OHDbs8rYgBf9AwM3bua455wzsgzrreIl61RV1esdTDnSdaMNHTCpD6JpBEf0rr4FWQtKizkB9iwBEmFKoJZ5OsEwg8YgcJ1UfM2gG+BLauc7fGqSNwpGJ2tWwV24raBoTbIcMRmyb5LGNSrmlTxAuAjXW1RPdFQSmPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7caf5314847so1367932a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 07:17:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767799067; x=1768403867;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7u+0KKXNZtTvL67d3telkpbb8pErCxI3zZRYQHW6Hfw=;
        b=eQKEUmT+Hbrhnf2WVw250txb5NQ26IRUOSkhnEfbOxpQOllnAmGhDN7uw154qwDsN7
         dhn9EKUufx0x7rir2HzdI8LH4CphLFKWGg5THsF0UA3ELGViPHe308il0Vxi379Eyaz9
         RlUpq99nSQ61NAbJFSvxlR8K/wbl2KjMfgCbuRzMqwVzRDJSU8lxZ/C+i3HNlWJZQT4M
         qrK/fLbaUnY6esSrc2CW0bRYD5/Gf36IuZKydQ66KcrlmQjDIeZp/W7dcqfjpdMYz3oI
         Ap9ky1YFN5Qb/ARpHkBGsGBDyJrDrF9NdlMxhx35e3G0tlce+a8zACfvnCdkrbt/oLn6
         9wPw==
X-Forwarded-Encrypted: i=1; AJvYcCU9XjyXj/IxXSdiDeQm6qZmpew52KIEd6rYiXY46TKKEoyV2YdxndUbA0HlAcQQdJvC0ycSb03vY/23m4M/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrak1cf5AUZS/CTqPkX5b5kWS4wDs+sxdFn8m7aKCbWuDU7t+y
	pGp2nsViOfkbLTssKHFAGUdJEe2CGgLxQST7pn8f5K2m0IUTqwXQ+7i/
X-Gm-Gg: AY/fxX67D+8tiZsEN5uPi6bfG7YYLk6d7MS9rX9tsIM6maQZn6SLbE6DQ+ZEB0j5BrW
	CWaY7vhCpSHEQ/eRR/XKQjLrQjgRHdDgvArf7CjNqfYsY29Yoh3LRnP7zTaDQJWQXaMdrKybP10
	7f4YKohN/f1qLgO7vRNvGIym3dAPbF5/cwSkjqpsVOGW8VeRn2Pw2OvW+Ja7xzOB08NCwSCIMYH
	G3F30UCTcGMWBl7AYfOVq53+V22Ko/FIceQ4BnLOSc/D8Tu1gGJgVlU3yRYHXM1ww/38pyDFqcK
	62iyfud0yGGC7OQB9J+ODgp/kWFvkdVbSqsWJ1GYvqaklQjA4xjTKXWfAvr1QJ5Kt6HOZuV7dwk
	856nvddlbbPFKTsroaWq7dMvGBH1EBbDQrba5UVVtZmOsZr5sKTQD56q2cktAfTUHAY2ivUEba7
	yM2phAFUlnVB1QLA==
X-Google-Smtp-Source: AGHT+IGkmDuCwJu+uSu6rAzBPHO54XmhQK6otSN94LngUy16IievGvqaxUCb78Zxiv63Iv1VRRCEXw==
X-Received: by 2002:a05:6830:8103:b0:7cc:4d72:5870 with SMTP id 46e09a7af769-7ce50a73d92mr1021324a34.15.1767799067492;
        Wed, 07 Jan 2026 07:17:47 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce47801d4dsm3496983a34.5.2026.01.07.07.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 07:17:47 -0800 (PST)
Date: Wed, 7 Jan 2026 07:17:45 -0800
From: Breno Leitao <leitao@debian.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, rostedt@goodmis.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH] device_cgroup: remove branch hint after code refactor
Message-ID: <thjezcdhtxod63uu3zh35a6a3d4vimvdx5cieehaqynzqixwhl@qod7sgkrmkl4>
References: <20260107-likely_device-v1-1-0c55f83a7e47@debian.org>
 <CAGudoHESsM03W+Qo3sHP5FEXZOxF_bHBYFErYx81wZwWdq5ANg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHESsM03W+Qo3sHP5FEXZOxF_bHBYFErYx81wZwWdq5ANg@mail.gmail.com>

Hello Mateusz,

On Wed, Jan 07, 2026 at 03:17:40PM +0100, Mateusz Guzik wrote:
> On Wed, Jan 7, 2026 at 3:06 PM Breno Leitao <leitao@debian.org> wrote:
> > diff --git a/include/linux/device_cgroup.h b/include/linux/device_cgroup.h
> > index 0864773a57e8..822085bc2d20 100644
> > --- a/include/linux/device_cgroup.h
> > +++ b/include/linux/device_cgroup.h
> > @@ -21,7 +21,7 @@ static inline int devcgroup_inode_permission(struct inode *inode, int mask)
> >         if (likely(!S_ISBLK(inode->i_mode) && !S_ISCHR(inode->i_mode)))
> >                 return 0;
> >
> > -       if (likely(!inode->i_rdev))
> > +       if (!inode->i_rdev)
> >                 return 0;
> >
> 
> The branch was left there because I could not be bothered to analyze
> whether it can be straight up eleminated with the new checks in place.
> 
> A quick look at init_special_inode suggests it is an invariant rdev is
> there in this case.
> 
> So for the time being I would replace likely with WARN_ON_ONCE . Might
> be even a good candidate for the pending release.

Oh, in fact that was my first try, but, when I tested it, I found that
it warns in some cases.

	[  126.951410] WARNING: ./include/linux/device_cgroup.h:24 at inode_permission+0x181/0x190, CPU#4: networkd)/1212
	[  126.971659] Modules linked in: intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E) skx_edac_common(E) nfit(E) libnvdimm(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) kvm(E) iTCO_wdt(E) iTCO_vendor_support(E) irqbypass(E) acpi_cpufreq(E) i2c_i801(E) i2c_smbus(E) wmi(E) ipmi_si(E) ipmi_devintf(E) ipmi_msghandler(E) evdev(E) button(E) bpf_preload(E) sch_fq_codel(E) xhci_pci(E) xhci_hcd(E) vhost_net(E) tap(E) tun(E) vhost(E) vhost_iotlb(E) mpls_gso(E) mpls_iptunnel(E) mpls_router(E) fou(E) loop(E) efivarfs(E) autofs4(E)
	[  127.097485] Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE
	[  127.109038] Hardware name: Quanta Delta Lake MP 29F0EMA01D0/Delta Lake-Class1, BIOS F0E_3A21 06/27/2024
	[  127.127889] RIP: 0010:inode_permission (./include/linux/device_cgroup.h:24 fs/namei.c:600)
	[  127.137542] Code: 14 81 e2 ff ff 0f 00 31 ff 3d 00 60 00 00 41 8d 0c 48 40 0f 95 c7 ff c7 e8 5c 68 35 00 85 c0 0f 85 6d ff ff ff e9 29 ff ff ff <0f> 0b e9 22 ff ff ff 0f 1f 84 00 00 00 00 00 41 56 53 49 89 f6 48
	All code
	========
	0:    14 81                    adc    $0x81,%al
	2:    e2 ff                    loop   0x3
	4:    ff 0f                    decl   (%rdi)
	6:    00 31                    add    %dh,(%rcx)
	8:    ff                       (bad)
	9:    3d 00 60 00 00           cmp    $0x6000,%eax
	e:    41 8d 0c 48              lea    (%r8,%rcx,2),%ecx
	12:    40 0f 95 c7              setne  %dil
	16:    ff c7                    inc    %edi
	18:    e8 5c 68 35 00           call   0x356879
	1d:    85 c0                    test   %eax,%eax
	1f:    0f 85 6d ff ff ff        jne    0xffffffffffffff92
	25:    e9 29 ff ff ff           jmp    0xffffffffffffff53
	2a:*    0f 0b                    ud2            <-- trapping instruction
	2c:    e9 22 ff ff ff           jmp    0xffffffffffffff53
	31:    0f 1f 84 00 00 00 00     nopl   0x0(%rax,%rax,1)
	38:    00
	39:    41 56                    push   %r14
	3b:    53                       push   %rbx
	3c:    49 89 f6                 mov    %rsi,%r14
	3f:    48                       rex.W

	Code starting with the faulting instruction
	===========================================
	0:    0f 0b                    ud2
	2:    e9 22 ff ff ff           jmp    0xffffffffffffff29
	7:    0f 1f 84 00 00 00 00     nopl   0x0(%rax,%rax,1)
	e:    00
	f:    41 56                    push   %r14
	11:    53                       push   %rbx
	12:    49 89 f6                 mov    %rsi,%r14
	15:    48                       rex.W
	[  127.175161] RSP: 0018:ffffc9000438fe60 EFLAGS: 00010246
	[  127.185667] RAX: 0000000000002000 RBX: 0000000000000010 RCX: 0000000000006000
	[  127.199992] RDX: 0000000000000000 RSI: ffff88842a9b5418 RDI: ffffffff83e31178
	[  127.214320] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
	[  127.228667] R10: 0000000000000000 R11: ffff88842a9b54b0 R12: ffffffff83e31178
	[  127.243017] R13: ffff88842a9b5418 R14: ffff88842a9b5418 R15: ffff88842a9b5498
	[  127.257360] FS:  00007f86e4bc3900(0000) GS:ffff8890b23fa000(0000) knlGS:0000000000000000
	[  127.273624] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[  127.285172] CR2: 000055990443e068 CR3: 00000004183b2001 CR4: 00000000007726f0
	[  127.299500] PKRU: 55555554
	[  127.304961] Call Trace:
	[  127.309885]  <TASK>
	[  127.314121]  do_faccessat (fs/open.c:508)
	[  127.321488]  ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:131)
	[  127.331973]  __x64_sys_access (fs/open.c:549 fs/open.c:547 fs/open.c:547)
	[  127.339677]  do_syscall_64 (arch/x86/entry/syscall_64.c:?)
	[  127.347038]  ? rcu_is_watching (./include/linux/context_tracking.h:128 kernel/rcu/tree.c:751)
	[  127.354775]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:131)
	[  127.364914] RIP: 0033:0x7f86e42ff21b


Lines against commit f0b9d8eb98df  ("Merge tag 'nfsd-6.19-3' of
git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux"), plus something like:


diff --git a/include/linux/device_cgroup.h b/include/linux/device_cgroup.h
index 822085bc2d20..c2b933a318f8 100644
--- a/include/linux/device_cgroup.h
+++ b/include/linux/device_cgroup.h
@@ -21,7 +21,7 @@ static inline int devcgroup_inode_permission(struct inode *inode, int mask)
        if (likely(!S_ISBLK(inode->i_mode) && !S_ISCHR(inode->i_mode)))
                return 0;

-       if (likely(!inode->i_rdev))
+       if (WARN_ON_ONCE(!inode->i_rdev))
                return 0;

        if (S_ISBLK(inode->i_mode))



