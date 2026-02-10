Return-Path: <linux-fsdevel+bounces-76840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBY5Ebkti2lEQgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 14:08:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B93B11B1AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 14:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7C2E3032F68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 13:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026693246FE;
	Tue, 10 Feb 2026 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEK3uQFV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470B7201004
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770728882; cv=pass; b=oEr18p0FS0HIIUorJBsqQgNWpzL9/58gS8eHfbxFXtpnZ9LVuSGENhbOaZH48ndLCsn+6tyukqr4jss0oN18d2fh4JLTz4bHweR1PjrqWytxs/GLvle5K1wQAIaBMYxMY0dbocB0b6PdrGwpoiX3U7kmCXhR+jq0Nsv+Pmn6yco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770728882; c=relaxed/simple;
	bh=mjI6XJURTDbt5gcGmUg9mzx+hF4Z+5/zSjs7I+sVCvg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sCX/VPtpvk3EVxx29GqqZ9odLVau4gf/kFXjFWxCeMxP0dj9JrMupLYFUaomHD+j938OdrYyktxY4TXVRla4OPOzH6xvmijkskS3SCALbDpIJua9EvKzT3HYvN4bBi6PLFrcxWt4xmDuoNXNhxDcbG4M1gqZrcb5vVsc+2F1M5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEK3uQFV; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65832e566edso1063350a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 05:08:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770728880; cv=none;
        d=google.com; s=arc-20240605;
        b=ZUTx7lDGu75fcMj9Pajsn7vfUYbWX0/U6GrTX6jM6J4dFC++N2Do1UB67FxftOQDHl
         AISbQeyBCDjHJttccqAs9o1FYKIuV4czCtfs7DPKYmVV2CjZcrOSU8WoeqA1h6TklqlF
         8MjtNIh6N46kwupkzprZ+3GQeUtj7inVC9iV04+jpZKdKrAa7WWuOM5frgeq+k2eb8af
         d+pN6ox07S6jarH+XIy/F9czmNwpYDUnwA5MHYjoCDoHsfQBLs+TmdwJP3lqYbf3jQtp
         Gh5HPFTAkSEYM/5x/poLVhqQuqZ+v/yK0BgvmMglndgl1cd3vUgcEVakaXTTtEA6Y3Cc
         gTSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=awIxVJ/llTaF4sBVC4blz32yFip939uVMZ5vdNjrRpE=;
        fh=tQCq0cTZxp83ZFwdIjDTpZ09+E4Ui1Csxq5Xy5VBC+I=;
        b=hIdAyIWlZvJD7QXlHVO6Ao6OqAmeRZxUvHREA8Xu2W+pz37DUx9gZgJaZPWEXfLXB8
         pqjmMVfokk4KSeb1UEglDCXvKO4ctb3gWW+SClpkZp8IfS/Ggz1DbAy5mID3ydAbsJbZ
         7nxxFkPTQC0CkCfI/6IUq8wTvmHZsGZH4cRVFxauujLFYABuqbUscOnaWUuczzzmwR1d
         HPZbN946Hfy4YMcyPHeBV82fbPYfRhtpExwLoxpJ3a92dorIpEetbb1RUrMmOWkXIM4a
         p/+/OWdhVJOaDee+UbjeGrRHF8cveEq1z/0oBlpvC9gWp4AJpPXNoCfFKrfDdypCc6Y9
         NpIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770728880; x=1771333680; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=awIxVJ/llTaF4sBVC4blz32yFip939uVMZ5vdNjrRpE=;
        b=aEK3uQFVD2CONLmAa0V9YWOeZklFDQlatCqllSZBBSpO6podgTqrpwjmDwpPR2Qu+d
         N1sGsMaIaamWqR4c941VOpU9Xx0tPnBJ3lFC1nnY80b1LciR9EUrr9rLMYvHOG6F4ghb
         XvnbIhfJ/ujYfRsRpqqAv4MuqSZS/VNCz1xQrJmi4nRFbeJ5jek01Xn+QdC9aIeByXxj
         9p8KVtYo6Uu9aEUB7laxHLtRdpW8nk75+xw+SrCh2g9FYZ74ZwOYa95TjVRydYa/fui2
         8EW63Z8Lrwx8eXpRUjwFM2l4AGifVP6g34z41ibaeZhy9VqksqlEhh/AWbSgr/IuxZXV
         ZvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770728880; x=1771333680;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=awIxVJ/llTaF4sBVC4blz32yFip939uVMZ5vdNjrRpE=;
        b=j+c1FRpc35td7JuPZutGoNAnwVRosTObCweiM1A7vTpbpAhwzmedCnEzrs+qnBQ6ro
         AM1AGIsSvjZmjy9tISDw6+yQl+NxxIeS4WBlCQsSjw/el/4f55ypmcLprJ4iKvhf/FhB
         xTUxJQYYEwq1h2JHk3JqDxbOYBRoK+ztNVGBeHYYlYEyD5IXnMIQVX4Dmqttd2LPxPj+
         wXgXfdtvPLlP7FvAmvi2u0TBbwpCgLnK7LFWfC2mVcerQUOyvMVImdyPkdoN4GcUMxBQ
         iBw1mLyRsVRwsHK9UJ4ny94hVBa24Uk/Kuf77KfuG38bvRxcdeibDW+BOow2GW0GsGE9
         YxzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG4xOrI1aL79GMvbXZ0zcl+bUXepY17/jlRQGTbvtXTnlJMc70341tp/80eo4Ur9tNeNF/iO41QUIwUcAj@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk0rrWnJLt7X1pZb/0UonWFjWSjSlnjV71NZBgXNq0rVpIHXM7
	meLHGmBbVyns5ZmGzoNy3CMUo+iesn1EP3empLwvY5wkhPSRKoMpo+4271SbJ9Nu339bHkDZUID
	0hbh4YrGiUZKXpLXo3BkvMowuNY3vaI0=
X-Gm-Gg: AZuq6aICA41o1O0cFBkNN0r7ulyIBOTOLcUw/sq7hTYhGCZkNU1pZquk2RkjjvPefO0
	tl9yQzZm9KUHhp5NRc8qrlf/ne2VHh70RkSdEcqiHwYiiXxCnCcasrrvutRSdhWYNvko2imiR3b
	yhbSF9006rBqOQs4dDzqmzFGE9hV1zuKB4qOVZC89NsdN5YdZHpIrPMKwHemUn0FF4ctYcKpX00
	yQYSgwqjzjOD6UqZLHrAir80l2hNxwHDn8XuFC000iSi2R2fAPtDFmqL1YpymJXTqKR01lV4Es4
	PfCKsaySGFJbUUzlrUToAmoxzMvxXps5q1T+5grA
X-Received: by 2002:a17:906:9f8a:b0:b87:4bdb:1061 with SMTP id
 a640c23a62f3a-b8edf17463emr646517266b.1.1770728879033; Tue, 10 Feb 2026
 05:07:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jiaming Zhang <r772577952@gmail.com>
Date: Tue, 10 Feb 2026 21:07:13 +0800
X-Gm-Features: AZwV_QiNfb1mVTcr99vSSsn47mpa3GBc2Dj79Sgm_glAGdkc_hx0MfQBSkSAht8
Message-ID: <CANypQFYQSxyaNEUeOKq4dvNe+jhcw3mna2ho0ZARth5cXj6YxA@mail.gmail.com>
Subject: [Linux Kernel Bug] WARNING in exc_debug_kernel
To: linux-kernel@vger.kernel.org
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76840-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[r772577952@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B93B11B1AD
X-Rspamd-Action: no action

Dear Linux kernel developers and maintainers,

We are writing to report a WARNING discovered in the system with our
generated syzkaller specifications. This issue is reproducible on the
latest version of linux (v6.19, commit
05f7e89ab9731565d8a62e3b5d1ec206485eeb0b).

We are trying to analyze the root cause. Currently, we found that the
WARNING can be triggered when the following conditions are satisfied:

!cpu_feature_enabled(X86_FEATURE_FRED)=true
dr6=16385 (0x4001), i.e. dr6=(DT_STEP|DR_TRAP0)
is_sysenter_singlestep(regs)=false

Intuitively, the results of is_sysenter_singlestep(regs) and !!(dr6 &
DR_STEP) should be consistent, but this is not the case. We suspect
that some previously executed syscalls may have corrupted the
consistency.

We have attached the kernel console output, kernel config, and
reproducers to assist with the analysis:

.config file:
https://drive.google.com/file/d/1Ybz9U1r0sJQ83PPzFcLn5vIaKBFyvehI/view?usp=drive_link
kernel console output:
https://drive.google.com/file/d/1cNWDnkNrSeGXLvi2E9a3FfJ-LsfFVl2b/view?usp=drive_link
symbolized report:
https://drive.google.com/file/d/1yHP847poR1PIPzc-0Xvt2x-PWWHz0CVC/view?usp=drive_link
C reproducer:
https://drive.google.com/file/d/13mJobL3WVKZL31ZzvY0o8WXa_HZZescr/view?usp=drive_link
syz reproducer:
https://drive.google.com/file/d/1UVuNeYMhOQuQD-p1u90xy3DopzPtBVJG/view?usp=drive_link

The issue report is also listed below (symbolized by syz-symbolize):

---

------------[ cut here ]------------
WARNING: arch/x86/kernel/traps.c:1284 at exc_debug_kernel+0x108/0x150
vol/linux/v6.19/arch/x86/kernel/traps.c:1284, CPU#0: repro.out/9697
Modules linked in:
CPU: 0 UID: 0 PID: 9697 Comm: repro.out Not tainted 6.19.0 #1 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:exc_debug_kernel+0x108/0x150
vol/linux/v6.19/arch/x86/kernel/traps.c:1284
Code: ff 65 48 8b 05 d9 ef 1d 07 48 3b 44 24 08 75 26 48 83 c4 10 5b
41 5e 41 5f 5d e9 ae 60 da f5 cc 90 0f 0b 90 e9 71 ff ff ff 90 <0f> 0b
90 80 a3 91 00 00 00 fe eb b5 e8 87 3f 00 00 f3 0f 1e fa 41
RSP: 0018:fffffe0000016f20 EFLAGS: 00010002
RAX: ffffffff815bfe00 RBX: fffffe0000016f58 RCX: 0000000000110000
RDX: ffff8880219ebd80 RSI: 0000000000000000 RDI: 0000000000008001
RBP: 0000000000000001 R08: ffffffff8f5d9377 R09: 1ffffffff1ebb26e
R10: dffffc0000000000 R11: ffffffff8169a7c0 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000004001 R15: 0000000000050202
FS:  0000000029677300(0000) GS:ffff8880994e3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000004c4c7000 CR4: 0000000000750ef0
DR0: 0000000000000006 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <#DB>
 asm_exc_debug+0x1e/0x40 vol/linux/v6.19/arch/x86/include/asm/idtentry.h:654
RIP: 0010:copy_user_generic
vol/linux/v6.19/arch/x86/include/asm/uaccess_64.h:126 [inline]
RIP: 0010:raw_copy_to_user
vol/linux/v6.19/arch/x86/include/asm/uaccess_64.h:147 [inline]
RIP: 0010:_inline_copy_to_user
vol/linux/v6.19/include/linux/uaccess.h:206 [inline]
RIP: 0010:_copy_to_user+0x85/0xb0 vol/linux/v6.19/lib/usercopy.c:26
Code: e8 70 3f 3e fd 4d 39 fc 72 3d 4d 39 ec 77 38 e8 01 3d 3e fd 4c
89 f7 89 de e8 c7 15 a6 fd 0f 01 cb 4c 89 ff 48 89 d9 4c 89 f6 <f3> a4
0f 1f 00 48 89 cb 0f 01 ca 48 89 d8 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc9000bbbfdd0 EFLAGS: 00050256
RAX: ffffffff84788d01 RBX: 0000000000000008 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffc9000bbbfe27 RDI: 0000000000000007
RBP: ffffc9000bbbfec0 R08: ffffc9000bbbfe27 R09: 1ffff92001777fc4
R10: dffffc0000000000 R11: fffff52001777fc5 R12: 0000000000000008
R13: 00007ffffffff000 R14: ffffc9000bbbfe20 R15: 0000000000000000
 </#DB>
 <TASK>
 copy_to_user vol/linux/v6.19/include/linux/uaccess.h:236 [inline]
 do_pipe2+0xc2/0x170 vol/linux/v6.19/fs/pipe.c:1040
 __do_sys_pipe2 vol/linux/v6.19/fs/pipe.c:1056 [inline]
 __se_sys_pipe2 vol/linux/v6.19/fs/pipe.c:1054 [inline]
 __x64_sys_pipe2+0x5a/0x70 vol/linux/v6.19/fs/pipe.c:1054
 do_syscall_x64 vol/linux/v6.19/arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe8/0xf80 vol/linux/v6.19/arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x44d989
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe605f93e8 EFLAGS: 00000206 ORIG_RAX: 0000000000000125
RAX: ffffffffffffffda RBX: 0000000000400488 RCX: 000000000044d989
RDX: 000000000044d989 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffe605f9400 R08: 0000000000000000 R09: 00007ffe605f9400
R10: ffffffffffffffff R11: 0000000000000206 R12: 000000000040bf20
R13: 0000000000000000 R14: 00000000004ba018 R15: 0000000000400488
 </TASK>
----------------
Code disassembly (best guess):
   0:   e8 70 3f 3e fd          call   0xfd3e3f75
   5:   4d 39 fc                cmp    %r15,%r12
   8:   72 3d                   jb     0x47
   a:   4d 39 ec                cmp    %r13,%r12
   d:   77 38                   ja     0x47
   f:   e8 01 3d 3e fd          call   0xfd3e3d15
  14:   4c 89 f7                mov    %r14,%rdi
  17:   89 de                   mov    %ebx,%esi
  19:   e8 c7 15 a6 fd          call   0xfda615e5
  1e:   0f 01 cb                stac
  21:   4c 89 ff                mov    %r15,%rdi
  24:   48 89 d9                mov    %rbx,%rcx
  27:   4c 89 f6                mov    %r14,%rsi
* 2a:   f3 a4                   rep movsb %ds:(%rsi),%es:(%rdi) <--
trapping instruction
  2c:   0f 1f 00                nopl   (%rax)
  2f:   48 89 cb                mov    %rcx,%rbx
  32:   0f 01 ca                clac
  35:   48 89 d8                mov    %rbx,%rax
  38:   5b                      pop    %rbx
  39:   41 5c                   pop    %r12
  3b:   41 5d                   pop    %r13
  3d:   41 5e                   pop    %r14
  3f:   41                      rex.B

---

Please let me know if any further information is required.

Best Regards,
Jiaming Zhang

