Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BA1583F40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jul 2022 14:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237340AbiG1MwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 08:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiG1MwP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:52:15 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B63F26564;
        Thu, 28 Jul 2022 05:52:14 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 6so1446299pgb.13;
        Thu, 28 Jul 2022 05:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=t/RQyF2ePMmWjM10FjGiU/ahdr8PZhdQwEwVbrVirH0=;
        b=gnHIqjJggnosM0ImImy9aPDjqOZ7BRXzRvohjgmWsFjQh4DTCFox8XWXCFWmP7VWWO
         UZLDwNWNGaqJF5wIwo7TlhBcD10jygLtCEamNsUKxo9bRUMbtHiPq16kka8/gdorUyst
         dt9Xtbv2rJFSisnCoNVBkI+qB1cRJZLnjRncZoObBGNXHKvD2VmE0y+gwCr2HQfYPa6B
         66YZXaWo0tXXfV7mpz7ICNXiYkFaByr7dMzssSQEW8eL1L8UI887eF1U2B50h2VIfo7l
         DQeBcL+5lBEclVmCXDWKMayo9OpgjX05bN0C5cYzZeYHR6EY4Zc7eXrnZyMhhtHOy9pV
         lA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=t/RQyF2ePMmWjM10FjGiU/ahdr8PZhdQwEwVbrVirH0=;
        b=JvH5pv/e84oGMbC66Zo1WDv6k6xQQhI9lxEqImsL6IpjYtoSg4hvZdxGgr9ggmhX0P
         1bZVfgusx8Mn2F8nPVkYPMKq376avpxUFjSZEv/fquHcz+yLUYAkKOVzVVgnyMapAMVs
         +1YLdzPcz6zMVEOrN+ki/LKPpWew62Faz8nDyW0UU7vsW4miCNo+d5g8s+DPtcHaM5ru
         UAL/T69l3EJNrV5h6Y35JaiMsnVtz2YQRFED9k2ds9n/cKsdBFIzHpobHg2Vb6YBKVi5
         mhd5ODP6a3mb4KzEY3mPzvRUuOFGUoZwhKiOMdw80LHDQdh5IcMqziZGy6+8rgApDoz/
         SVBw==
X-Gm-Message-State: AJIora/WVsT7uzScxOKkpm4KLCuIzutJvYsjwcqO9sO3tpzSXWcGrDC+
        SOM6HcPja8pCw7b0De50OVtHBFRZyd8=
X-Google-Smtp-Source: AGRyM1t20AcZlD9di22yUysGPUEfqxn75WXVrzXElb0fjq5FZz2BuHqtdFceaQrZnUKENvNeOZem+g==
X-Received: by 2002:a63:db09:0:b0:41b:6744:a255 with SMTP id e9-20020a63db09000000b0041b6744a255mr2339470pgg.556.1659012733587;
        Thu, 28 Jul 2022 05:52:13 -0700 (PDT)
Received: from [192.168.88.254] ([125.160.106.238])
        by smtp.gmail.com with ESMTPSA id u18-20020a17090ae01200b001f2fc3828e4sm965283pjy.24.2022.07.28.05.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 05:52:13 -0700 (PDT)
Message-ID: <6ea35895-7dd7-29e9-b7a0-bdc25307dfb0@gmail.com>
Date:   Thu, 28 Jul 2022 19:52:10 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <YtR8tPTkL/L1kFkY@yury-laptop> <Yt7jfiSlNOeeookP@yury-laptop>
 <CAHk-=wjroqb0Hr9-1BCATjSuBdfdkWS6qqFaLXrwFCsHvgGH_g@mail.gmail.com>
From:   Ammar Faizi <ammarfaizi2@gmail.com>
Subject: Re: x86_64/kvm: kernel hangs on poweroff
In-Reply-To: <CAHk-=wjroqb0Hr9-1BCATjSuBdfdkWS6qqFaLXrwFCsHvgGH_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/26/22 2:02 AM, Linus Torvalds wrote:
> On Mon, Jul 25, 2022 at 11:40 AM Yury Norov <yury.norov@gmail.com> wrote:
>>> [   22.162259] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000
>>> [   22.163539] CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 5.19.0-rc6 #198
>>> [   22.164327] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
>>> [   22.164327] Call Trace:
>>> [   22.164327]  <TASK>
>>> [   22.164327]  dump_stack_lvl+0x34/0x44
>>> [   22.164327]  panic+0x107/0x28a
>>> [   22.164327]  do_exit.cold+0x15/0x15
>>> [   22.164327]  ? sys_off_notify+0x3e/0x60
>>> [   22.164327]  __do_sys_reboot+0x1df/0x220
>>> [   22.164327]  ? vfs_writev+0xc7/0x190
>>> [   22.164327]  ? virtio_crypto_ctrl_vq_request+0xd0/0xd0
>>> [   22.164327]  ? fpregs_assert_state_consistent+0x1e/0x40
>>> [   22.164327]  do_syscall_64+0x3b/0x90
>>> [   22.164327]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>> [   22.164327] RIP: 0033:0x7f42b4118443
>>> [   22.164327] Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 f9 c9 0d 00 f7 d8
> 
> That's literally the "exit()" system call.

I took a look and it turned out it's not the "exit()" system call.

The disassembly is:

    0:    64 89 01                 mov    %eax,%fs:(%rcx)
    3:    48 83 c8 ff              or     $0xffffffffffffffff,%rax
    7:    c3                       ret
    8:    66 2e 0f 1f 84 00 00     cs nopw 0x0(%rax,%rax,1)
    f:    00 00 00
   12:    0f 1f 44 00 00           nopl   0x0(%rax,%rax,1)
   17:    89 fa                    mov    %edi,%edx
   19:    be 69 19 12 28           mov    $0x28121969,%esi
   1e:    bf ad de e1 fe           mov    $0xfee1dead,%edi
   23:    b8 a9 00 00 00           mov    $0xa9,%eax
   28:    0f 05                    syscall
   2a:*   48 3d 00 f0 ff ff        cmp    $0xfffffffffffff000,%rax        <-- trapping instruction

The syscall is with orig %rax being 0xa9 (169 in dec). That is
the reboot system call. The problem here is that the reboot
system call calls do_exit(0) with @current being the init.

So I think the way to investigate it is take a look at kernel/reboot.c,
understand why did you end up in do_exit(0) path. Hope that helps.

-- 
Ammar Faizi

