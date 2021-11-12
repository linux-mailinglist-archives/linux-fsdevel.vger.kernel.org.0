Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A086E44E2E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 09:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbhKLITS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 03:19:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45283 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230464AbhKLITR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 03:19:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636704985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yBfpCdnT6/o1jYZnAwJO5t2QWnzCoaDSNz2v/fxrTno=;
        b=FrrxB8X5NLrxIr2/jAYBWaw0sV4ietFMc+L8JoneGVAjhMAL2TjW84s92heoQrk8WA4gBy
        fG4eaQxj+gR2bUzUk96yZLpDBPi75qI4Mj5ayb4ZRmB6CEzJasNJJUna9LINhUMx7cYo5c
        taZpG45gzK+hmTovNxq5TBIKQ2vFzhE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-N94dymmqPxWe64_nQISowg-1; Fri, 12 Nov 2021 03:16:24 -0500
X-MC-Unique: N94dymmqPxWe64_nQISowg-1
Received: by mail-wm1-f72.google.com with SMTP id b133-20020a1c808b000000b0032cdd691994so5952707wmd.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Nov 2021 00:16:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=yBfpCdnT6/o1jYZnAwJO5t2QWnzCoaDSNz2v/fxrTno=;
        b=z3Ay9VQHzojTg4MrX76vGlNo5c5Cl/nrxJQcwdLloAnMLjMWWfmEUIPzKB2sNJaEFz
         wLWLSgFFhnPDgvKNCAawpsYfDCHKxM1I9EUW+ndEITsiOZj5Kn54vkzrjf2ioWqnJOmC
         Y2ppHsh35+sYRzRG1IP+Hw718dGgME4H4oECREJQqW307ILoS+dUFP+qCoM+09tssk1+
         2Ipa+99xBtvC+NhtsgapBE92/GC8g9fossc8dKz+Q/yjf9ikXtC0+ggiNE9/EBg2r0kA
         nNoiiZzPFGx01p+Iw5z9vui/+xa3KMMEKiALPnNZaYJNh3ephQxLcrnduhqFFHwhWgHb
         Pi4w==
X-Gm-Message-State: AOAM5335di/hDJIBGuhDFffPxsWXBJRUqFv3y5yiiUG3x/iFY1HvZA7i
        27xdUSLRP1MLyJElt/zUDA97VpMltKqqx9eZldBZUJszNKNjSnNs8hr97+ePjxRZXfJz3Oy7ak6
        L46dcL4oyge+2Wwcz4O1NrGy8MQ==
X-Received: by 2002:a05:600c:34d6:: with SMTP id d22mr14849711wmq.160.1636704983267;
        Fri, 12 Nov 2021 00:16:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAxwrdrwE6QJPyuo3D5SlxtJR3q4zVCOSOisdyIEIpQcJuOF8NsFoPGDMCOb3frEYFnhfQgw==
X-Received: by 2002:a05:600c:34d6:: with SMTP id d22mr14849681wmq.160.1636704983005;
        Fri, 12 Nov 2021 00:16:23 -0800 (PST)
Received: from [192.168.3.132] (p4ff23f5f.dip0.t-ipconnect.de. [79.242.63.95])
        by smtp.gmail.com with ESMTPSA id c79sm5182604wme.43.2021.11.12.00.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 00:16:22 -0800 (PST)
Message-ID: <21bdcecd-127c-f70e-0c7d-cb1b97caecb0@redhat.com>
Date:   Fri, 12 Nov 2021 09:16:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20211111191800.21281-1-david@redhat.com>
 <20211112070113.GA19016@MiWiFi-R3L-srv>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1] proc/vmcore: fix clearing user buffer by properly
 using clear_user()
In-Reply-To: <20211112070113.GA19016@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12.11.21 08:01, Baoquan He wrote:
> On 11/11/21 at 08:18pm, David Hildenbrand wrote:
>> To clear a user buffer we cannot simply use memset, we have to use
>> clear_user(). Using a kernel config based on rawhide Fedora and a
>> virtio-mem device that registers a vmcore_cb, I can easily trigger:
>>
>> [   11.327580] systemd[1]: Starting Kdump Vmcore Save Service...
>> [   11.339697] kdump[420]: Kdump is using the default log level(3).
>> [   11.370964] kdump[453]: saving to /sysroot/var/crash/127.0.0.1-2021-11-11-14:59:22/
>> [   11.373997] kdump[458]: saving vmcore-dmesg.txt to /sysroot/var/crash/127.0.0.1-2021-11-11-14:59:22/
>> [   11.385357] kdump[465]: saving vmcore-dmesg.txt complete
>> [   11.386722] kdump[467]: saving vmcore
>> [   16.531275] BUG: unable to handle page fault for address: 00007f2374e01000
>> [   16.531705] #PF: supervisor write access in kernel mode
>> [   16.532037] #PF: error_code(0x0003) - permissions violation
>> [   16.532396] PGD 7a523067 P4D 7a523067 PUD 7a528067 PMD 7a525067 PTE 800000007048f867
>> [   16.532872] Oops: 0003 [#1] PREEMPT SMP NOPTI
>> [   16.533154] CPU: 0 PID: 468 Comm: cp Not tainted 5.15.0+ #6
>> [   16.533513] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-27-g64f37cc530f1-prebuilt.qemu.org 04/01/2014
>> [   16.534198] RIP: 0010:read_from_oldmem.part.0.cold+0x1d/0x86
>> [   16.534552] Code: ff ff ff e8 05 ff fe ff e9 b9 e9 7f ff 48 89 de 48 c7 c7 38 3b 60 82 e8 f1 fe fe ff 83 fd 08 72 3c 49 8d 7d 08 4c 89 e9 89 e8 <49> c7 45 00 00 00 00 00 49 c7 44 05 f8 00 00 00 00 48 83 e7 f81
>> [   16.535670] RSP: 0018:ffffc9000073be08 EFLAGS: 00010212
>> [   16.535998] RAX: 0000000000001000 RBX: 00000000002fd000 RCX: 00007f2374e01000
>> [   16.536441] RDX: 0000000000000001 RSI: 00000000ffffdfff RDI: 00007f2374e01008
>> [   16.536878] RBP: 0000000000001000 R08: 0000000000000000 R09: ffffc9000073bc50
>> [   16.537315] R10: ffffc9000073bc48 R11: ffffffff829461a8 R12: 000000000000f000
>> [   16.537755] R13: 00007f2374e01000 R14: 0000000000000000 R15: ffff88807bd421e8
>> [   16.538200] FS:  00007f2374e12140(0000) GS:ffff88807f000000(0000) knlGS:0000000000000000
>> [   16.538696] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   16.539055] CR2: 00007f2374e01000 CR3: 000000007a4aa000 CR4: 0000000000350eb0
>> [   16.539510] Call Trace:
>> [   16.539679]  <TASK>
>> [   16.539828]  read_vmcore+0x236/0x2c0
>> [   16.540063]  ? enqueue_hrtimer+0x2f/0x80
>> [   16.540323]  ? inode_security+0x22/0x60
>> [   16.540572]  proc_reg_read+0x55/0xa0
>> [   16.540807]  vfs_read+0x95/0x190
>> [   16.541022]  ksys_read+0x4f/0xc0
>> [   16.541238]  do_syscall_64+0x3b/0x90
>> [   16.541475]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> To fix, properly use clear_user() when required.
> 
> Looks a great fix to me, thanks for fixing this. 
> 
> Check the code, clear_user invokes access_ok to do check, then call
> memset(). It's unclear to me how the bug is triggered, could you
> please tell more so that I can learn? 
>
TBH, I was testing virtio-mem+vmcore before without running into this
issue, but after I retested with upstream in a different setup
(different kernel config but eventually also different CPU features), I
ran into this.


Note that you were looking at the generic __clear_user() implementation,
the x86-64 variant is different, see arch/x86/lib/usercopy_64.c

I can spot that it triggers stac()/clac() (X86_SMAP):
https://en.wikipedia.org/wiki/Supervisor_Mode_Access_Prevention

"that allows supervisor mode programs to optionally set user-space
memory mappings so that access to those mappings from supervisor mode
will cause a trap. This makes it harder for malicious programs to
"trick" the kernel into using instructions or data from a user-space
program"

Yes, that's most probably it :)

-- 
Thanks,

David / dhildenb

