Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F2820688A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 01:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387973AbgFWXin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 19:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387532AbgFWXim (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 19:38:42 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4724DC061573
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2020 16:38:42 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b15so87118edy.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2020 16:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n+5DEpU8MPUbZ6qwtbZiaceci+Pn8MEakpjQ5eTQOsI=;
        b=BwUqHklfO/CutrJi4sSum+0Oq/aYqJfREtlUlYvFqbg7C2o95ZsY+aAXTx7fNIqRlM
         Om074BwZAmcoci+DUnxoZzH3aUY868XxJQ3e+6JDyQEeC5iWZeGHiE70uuI/atB1cNom
         xCXyVRlG/BG+Rk5xaw7GbqzulJ1j6coo4t2CZwbOL2cZm9+rBLrxB8B9p4DdnTG5jBOR
         QOAJ0t25Rb7Yshr94RCpaZRQfmpGRLjm10NrzcoQauH2bK0ogXDlXycuJivzDLWf2kpl
         Gn4kSiTKiGrLyb2dt9L3qvS4RYk5JmJUO1YPrBkKVpK/5pye8XDZdSTLgh373wVJZ+jb
         d8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+5DEpU8MPUbZ6qwtbZiaceci+Pn8MEakpjQ5eTQOsI=;
        b=Bj2Xt1AvYWKq5Y261J38/j/OdnQMBHKffu4icPAg579Qrem/AVaIE74kaXlmpm3P6Z
         7Zs/LJ6fQc8fzg1LT+MheikUpIwBSlXCY0QB5TBsGoS1fZDieb3+I8iCmCuXIfgUhWTB
         97ix3asqb1zC0ts/XDNpyilQ0Ml03col1yRxuQgVauWnJ5IyELU6NyXTJWl3aS8B6855
         I/1+6Dn+rqaIIBQmqkVj5aVaZCaeaZnvkpcq5pDUx7iy1DahhUdVrS5GQITuYdFwN9JH
         G6Qxy8pKx/LJqrGCkcJMisdh6r3R9r9I4QjvxEysWKQluzYxjq75fTtp+2qQcwqHGzgI
         tIdw==
X-Gm-Message-State: AOAM532MxAnhzuiCF2aYwB9ONpTmEf81dHPEROF3sS1YF+IZuS3jqECN
        1lYSevygOw0AC0eKPu8gdwcU3fiw0tZWMUuNOhkKlw==
X-Google-Smtp-Source: ABdhPJwasF7vLiirxOKWGUzsRqmUk8WOnFuNI5R6Wx/5Z8Z+01/3A8rY2PQo2WH9IbTfWRuQy6ZyR4TfT8v3+uoVWY4=
X-Received: by 2002:a05:6402:459:: with SMTP id p25mr23770678edw.383.1592955520956;
 Tue, 23 Jun 2020 16:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <1503686.1591113304@warthog.procyon.org.uk> <23219b787ed1c20a63017ab53839a0d1c794ec53.camel@intel.com>
In-Reply-To: <23219b787ed1c20a63017ab53839a0d1c794ec53.camel@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Jun 2020 16:38:29 -0700
Message-ID: <CAPcyv4g+T+GK4yVJs8bTT1q90SFDpFYUSL9Pk_u8WZROhREPkw@mail.gmail.com>
Subject: Re: [GIT PULL] General notification queue and key notifications
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Cc:     "raven@themaw.net" <raven@themaw.net>,
        "kzak@redhat.com" <kzak@redhat.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "dray@redhat.com" <dray@redhat.com>,
        "swhiteho@redhat.com" <swhiteho@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "mszeredi@redhat.com" <mszeredi@redhat.com>,
        "jlayton@redhat.com" <jlayton@redhat.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "andres@anarazel.de" <andres@anarazel.de>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 16, 2020 at 6:15 PM Williams, Dan J
<dan.j.williams@intel.com> wrote:
>
> Hi David,
>
> On Tue, 2020-06-02 at 16:55 +0100, David Howells wrote:
> > Date: Tue, 02 Jun 2020 16:51:44 +0100
> >
> > Hi Linus,
> >
> > Can you pull this, please?  It adds a general notification queue
> > concept
> > and adds an event source for keys/keyrings, such as linking and
> > unlinking
> > keys and changing their attributes.
> [..]
>
> This commit:
>
> >       keys: Make the KEY_NEED_* perms an enum rather than a mask
>
> ...upstream as:
>
>     8c0637e950d6 keys: Make the KEY_NEED_* perms an enum rather than a mask
>
> ...triggers a regression in the libnvdimm unit test that exercises the
> encrypted keys used to store nvdimm passphrases. It results in the
> below warning.

This regression is still present in tip of tree. David, have you had a
chance to take a look?



>
> ---
>
> WARNING: CPU: 15 PID: 6276 at security/keys/permission.c:35 key_task_permission+0xd3/0x140
> Modules linked in: nd_blk(OE) nfit_test(OE) device_dax(OE) ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E) kvm_intel(E) kvm(E) irqbypass(E) nd_pmem(OE) dax_pmem(OE) nd_btt(OE) dax_p
> ct10dif_pclmul(E) nd_e820(OE) nfit(OE) crc32_pclmul(E) libnvdimm(OE) crc32c_intel(E) ghash_clmulni_intel(E) serio_raw(E) encrypted_keys(E) trusted(E) nfit_test_iomap(OE) tpm(E) drm(E)
> CPU: 15 PID: 6276 Comm: lt-ndctl Tainted: G           OE     5.7.0-rc6+ #155
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> RIP: 0010:key_task_permission+0xd3/0x140
> Code: c8 21 d9 39 d9 75 25 48 83 c4 08 4c 89 e6 48 89 ef 5b 5d 41 5c 41 5d e9 1b a7 00 00 bb 01 00 00 00 83 fa 01 0f 84 68 ff ff ff <0f> 0b 48 83 c4 08 b8 f3 ff ff ff 5b 5d 41 5c 41 5d c3 83 fa 06
>
> RSP: 0018:ffffaddc42db7c90 EFLAGS: 00010297
> RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffaddc42db7c7c
> RDX: 0000000000000000 RSI: ffff985e1c46e840 RDI: ffff985e3a03de01
> RBP: ffff985e3a03de01 R08: 0000000000000000 R09: 5461e7bc000002a0
> R10: 0000000000000004 R11: 0000000066666666 R12: ffff985e1c46e840
> R13: 0000000000000000 R14: ffffaddc42db7cd8 R15: ffff985e248c6540
> FS:  00007f863c18a780(0000) GS:ffff985e3bbc0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000006d3708 CR3: 0000000125a1e006 CR4: 0000000000160ee0
> Call Trace:
>  lookup_user_key+0xeb/0x6b0
>  ? vsscanf+0x3df/0x840
>  ? key_validate+0x50/0x50
>  ? key_default_cmp+0x20/0x20
>  nvdimm_get_user_key_payload.part.0+0x21/0x110 [libnvdimm]
>  nvdimm_security_store+0x67d/0xb20 [libnvdimm]
>  security_store+0x67/0x1a0 [libnvdimm]
>  kernfs_fop_write+0xcf/0x1c0
>  vfs_write+0xde/0x1d0
>  ksys_write+0x68/0xe0
>  do_syscall_64+0x5c/0xa0
>  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> RIP: 0033:0x7f863c624547
> Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> RSP: 002b:00007ffd61d8f5e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007ffd61d8f640 RCX: 00007f863c624547
> RDX: 0000000000000014 RSI: 00007ffd61d8f640 RDI: 0000000000000005
> RBP: 0000000000000005 R08: 0000000000000014 R09: 00007ffd61d8f4a0
> R10: fffffffffffff455 R11: 0000000000000246 R12: 00000000006dbbf0
> R13: 00000000006cd710 R14: 00007f863c18a6a8 R15: 00007ffd61d8fae0
> irq event stamp: 36976
> hardirqs last  enabled at (36975): [<ffffffff9131fa40>] __slab_alloc+0x70/0x90
> hardirqs last disabled at (36976): [<ffffffff910049c7>] trace_hardirqs_off_thunk+0x1a/0x1c
> softirqs last  enabled at (35474): [<ffffffff91e00357>] __do_softirq+0x357/0x466
> softirqs last disabled at (35467): [<ffffffff910eae96>] irq_exit+0xe6/0xf0
>
