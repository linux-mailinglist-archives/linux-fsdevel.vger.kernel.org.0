Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB89526718
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 17:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbfEVPog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 11:44:36 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:41723 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbfEVPog (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 11:44:36 -0400
Received: by mail-wr1-f44.google.com with SMTP id g12so2842652wro.8;
        Wed, 22 May 2019 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=6jjL0znXnwSuURgJ8fuD35oqpjPwIp3saZIRbM6CfaU=;
        b=ZYVBQZw/0mDjsZmSCOLnZaohVXKUp9Wr1F3BPkuJDbdPGu4EDLRKtEuaNuagEDSfqB
         pHa5eR+gALHMFj1pEsRrffl8+QbqRjtf5mxKa8Xgq79J8oHCJB2moZK3/cGEklOCKkRj
         F+UPpoMdsIn05K547s7V/fWxnQLI8sSY6WlKpLCiqrd9VVq5wvsuyc0qt9sLzmRz7Ewo
         Ro7xyZJp23kN8zrZzxE4PTP5Nbwn3L60vW9AjiZgjc6PBVqWSlLs2OhPyyEMA2dEY+Pm
         w9G67lz370ZGLiKRZistJpY76f33lSzCoK3YU5EZj8rbaXsZzQlb3RuJhvoRjLymfxpu
         1ibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=6jjL0znXnwSuURgJ8fuD35oqpjPwIp3saZIRbM6CfaU=;
        b=qHsQaCrufc2ILx83cQ7zjIVjeJxFu3CQJ1UD0b8TNg7WSk1bTjRW1lHEs272dvaOMU
         uAiMCjmfNsidWL81lRBi4faiNwn5Vy+BiI80PdYYREFQws64a5/3ZCm5mEF37MLJTGE8
         s4M3Aq6IcEv1mEsbSkMLD2lNMPzsP0PCemaGa8X2R/mfbkciHqfZEPQqBkjLE2/DcjAp
         xrtYerDS0WpRAzhgVf32WETSgcBaYrZwWCwrbRELRCYx9a4uvBfuQJ4U2hCo5AcHSmKg
         0cwV81B59LGW5KDYWsinOF3zyzg75khK8/s86yc7YghHrLK+Thr3MbdNR0yKF/k4uDg6
         zs9g==
X-Gm-Message-State: APjAAAVm/cR9tLwJDEBUz8AnvzlAB7HwV6C0pZrgaKC+ajbQHTHmYYBK
        bXPIcJqu1HKv09MZYPDtAoUb21Zhnds=
X-Google-Smtp-Source: APXvYqzFUhrO6go0z47HrTYcUO4D5Vvss67KExFatNELqpi2y6A+63eoV0QnsrXFMXhtD54xYECYCA==
X-Received: by 2002:a5d:4002:: with SMTP id n2mr340944wrp.187.1558539873323;
        Wed, 22 May 2019 08:44:33 -0700 (PDT)
Received: from localhost ([92.59.185.54])
        by smtp.gmail.com with ESMTPSA id s127sm7755333wmf.48.2019.05.22.08.44.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 08:44:32 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: =?iso-8859-1?Q?d=5Flookup:_Unable_to_handle_kernel_paging_request?=
Date:   Wed, 22 May 2019 17:44:30 +0200
MIME-Version: 1.0
Message-ID: <bdc8b245-afca-4662-99e2-a082f25fc927@gmail.com>
In-Reply-To: <20190522135331.GM17978@ZenIV.linux.org.uk>
References: <23950bcb-81b0-4e07-8dc8-8740eb53d7fd@gmail.com>
 <20190522135331.GM17978@ZenIV.linux.org.uk>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

On Wednesday, May 22, 2019 3:53:31 PM CEST, Al Viro wrote:
> On Wed, May 22, 2019 at 12:40:55PM +0200, Vicente Bergas wrote:
>> Hi,
>> since a recent update the kernel is reporting d_lookup errors.
>> They appear randomly and after each error the affected file or directory
>> is no longer accessible.
>> The kernel is built with GCC 9.1.0 on ARM64.
>> Four traces from different workloads follow.
>
> Interesting...  bisection would be useful.

Agreed, but that would be difficult because of the randomness.
I have been running days with no issues with a known-bad kernel.
The issue could also be related to the upgrade to GCC 9.

>> This trace is from v5.1-12511-g72cf0b07418a while untaring into a tmpfs
>> filesystem:
>>=20
>> Unable to handle kernel paging request at virtual address 0000880001000018=

>> user pgtable: 4k pages, 48-bit VAs, pgdp =3D 000000007ccc6c7d
>> [0000880001000018] pgd=3D0000000000000000
>
> Attempt to dereference 0x0000880001000018, which is not mapped at all?
>
>> pc : __d_lookup+0x58/0x198
>
> ... and so would objdump of the function in question.

Here is the dump from another build of the exact
same version (the build is reproducible).

objdump -x -S fs/dcache.o

...
0000000000002d00 <__d_lookup_rcu>:
    2d00:=09a9b97bfd =09stp=09x29, x30, [sp, #-112]!
    2d04:=09aa0103e3 =09mov=09x3, x1
    2d08:=0990000004 =09adrp=09x4, 0 <find_submount>
=09=09=092d08: R_AARCH64_ADR_PREL_PG_HI21=09.data..read_mostly
    2d0c:=09910003fd =09mov=09x29, sp
    2d10:=09a90153f3 =09stp=09x19, x20, [sp, #16]
    2d14:=0991000081 =09add=09x1, x4, #0x0
=09=09=092d14: R_AARCH64_ADD_ABS_LO12_NC=09.data..read_mostly
    2d18:=09a9025bf5 =09stp=09x21, x22, [sp, #32]
    2d1c:=09a9046bf9 =09stp=09x25, x26, [sp, #64]
    2d20:=09a9406476 =09ldp=09x22, x25, [x3]
    2d24:=09b9400821 =09ldr=09w1, [x1, #8]
    2d28:=09f9400084 =09ldr=09x4, [x4]
=09=09=092d28: R_AARCH64_LDST64_ABS_LO12_NC=09.data..read_mostly
    2d2c:=091ac126c1 =09lsr=09w1, w22, w1
    2d30:=09f8617893 =09ldr=09x19, [x4, x1, lsl #3]
    2d34:=09f27ffa73 =09ands=09x19, x19, #0xfffffffffffffffe
    2d38:=0954000920 =09b.eq=092e5c <__d_lookup_rcu+0x15c>  // b.none
    2d3c:=09aa0003f5 =09mov=09x21, x0
    2d40:=09d360feda =09lsr=09x26, x22, #32
    2d44:=09a90363f7 =09stp=09x23, x24, [sp, #48]
    2d48:=09aa0203f8 =09mov=09x24, x2
    2d4c:=09d3608ad7 =09ubfx=09x23, x22, #32, #3
    2d50:=09a90573fb =09stp=09x27, x28, [sp, #80]
    2d54:=092a1603fc =09mov=09w28, w22
    2d58:=099280001b =09mov=09x27, #0xffffffffffffffff    =09// #-1
    2d5c:=0914000003 =09b=092d68 <__d_lookup_rcu+0x68>
    2d60:=09f9400273 =09ldr=09x19, [x19]
    2d64:=09b4000793 =09cbz=09x19, 2e54 <__d_lookup_rcu+0x154>
    2d68:=09b85fc265 =09ldur=09w5, [x19, #-4]
    2d6c:=09d50339bf =09dmb=09ishld
    2d70:=09f9400a64 =09ldr=09x4, [x19, #16]
    2d74:=09d1002260 =09sub=09x0, x19, #0x8
    2d78:=09eb0402bf =09cmp=09x21, x4
    2d7c:=0954ffff21 =09b.ne=092d60 <__d_lookup_rcu+0x60>  // b.any
    2d80:=09121f78b4 =09and=09w20, w5, #0xfffffffe
    2d84:=09aa0003e9 =09mov=09x9, x0
    2d88:=09f9400664 =09ldr=09x4, [x19, #8]
    2d8c:=09b4fffea4 =09cbz=09x4, 2d60 <__d_lookup_rcu+0x60>
    2d90:=09b94002a4 =09ldr=09w4, [x21]
    2d94:=0937080404 =09tbnz=09w4, #1, 2e14 <__d_lookup_rcu+0x114>
    2d98:=09f9401000 =09ldr=09x0, [x0, #32]
    2d9c:=09eb16001f =09cmp=09x0, x22
    2da0:=0954fffe01 =09b.ne=092d60 <__d_lookup_rcu+0x60>  // b.any
    2da4:=09f9401265 =09ldr=09x5, [x19, #32]
    2da8:=092a1a03e6 =09mov=09w6, w26
    2dac:=09cb050328 =09sub=09x8, x25, x5
    2db0:=0914000006 =09b=092dc8 <__d_lookup_rcu+0xc8>
    2db4:=09910020a5 =09add=09x5, x5, #0x8
    2db8:=09eb07001f =09cmp=09x0, x7
    2dbc:=0954fffd21 =09b.ne=092d60 <__d_lookup_rcu+0x60>  // b.any
    2dc0:=09710020c6 =09subs=09w6, w6, #0x8
    2dc4:=0954000160 =09b.eq=092df0 <__d_lookup_rcu+0xf0>  // b.none
    2dc8:=098b0800a4 =09add=09x4, x5, x8
    2dcc:=096b1700df =09cmp=09w6, w23
    2dd0:=09f9400087 =09ldr=09x7, [x4]
    2dd4:=09f94000a0 =09ldr=09x0, [x5]
    2dd8:=0954fffee1 =09b.ne=092db4 <__d_lookup_rcu+0xb4>  // b.any
    2ddc:=09531d72e1 =09lsl=09w1, w23, #3
    2de0:=09ca070000 =09eor=09x0, x0, x7
    2de4:=099ac12361 =09lsl=09x1, x27, x1
    2de8:=09ea21001f =09bics=09xzr, x0, x1
    2dec:=0954fffba1 =09b.ne=092d60 <__d_lookup_rcu+0x60>  // b.any
    2df0:=09b9000314 =09str=09w20, [x24]
    2df4:=09aa0903e0 =09mov=09x0, x9
    2df8:=09a94153f3 =09ldp=09x19, x20, [sp, #16]
    2dfc:=09a9425bf5 =09ldp=09x21, x22, [sp, #32]
    2e00:=09a94363f7 =09ldp=09x23, x24, [sp, #48]
    2e04:=09a9446bf9 =09ldp=09x25, x26, [sp, #64]
    2e08:=09a94573fb =09ldp=09x27, x28, [sp, #80]
    2e0c:=09a8c77bfd =09ldp=09x29, x30, [sp], #112
    2e10:=09d65f03c0 =09ret
    2e14:=09b9402001 =09ldr=09w1, [x0, #32]
    2e18:=096b01039f =09cmp=09w28, w1
    2e1c:=0954fffa21 =09b.ne=092d60 <__d_lookup_rcu+0x60>  // b.any
    2e20:=09b9402401 =09ldr=09w1, [x0, #36]
    2e24:=09f9401402 =09ldr=09x2, [x0, #40]
    2e28:=09d50339bf =09dmb=09ishld
    2e2c:=09b85fc264 =09ldur=09w4, [x19, #-4]
    2e30:=096b04029f =09cmp=09w20, w4
    2e34:=0954000221 =09b.ne=092e78 <__d_lookup_rcu+0x178>  // b.any
    2e38:=09f94032a4 =09ldr=09x4, [x21, #96]
    2e3c:=09a90627e3 =09stp=09x3, x9, [sp, #96]
    2e40:=09f9400c84 =09ldr=09x4, [x4, #24]
    2e44:=09d63f0080 =09blr=09x4
    2e48:=09a94627e3 =09ldp=09x3, x9, [sp, #96]
    2e4c:=0934fffd20 =09cbz=09w0, 2df0 <__d_lookup_rcu+0xf0>
    2e50:=0917ffffc4 =09b=092d60 <__d_lookup_rcu+0x60>
    2e54:=09a94363f7 =09ldp=09x23, x24, [sp, #48]
    2e58:=09a94573fb =09ldp=09x27, x28, [sp, #80]
    2e5c:=09d2800009 =09mov=09x9, #0x0                   =09// #0
    2e60:=09aa0903e0 =09mov=09x0, x9
    2e64:=09a94153f3 =09ldp=09x19, x20, [sp, #16]
    2e68:=09a9425bf5 =09ldp=09x21, x22, [sp, #32]
    2e6c:=09a9446bf9 =09ldp=09x25, x26, [sp, #64]
    2e70:=09a8c77bfd =09ldp=09x29, x30, [sp], #112
    2e74:=09d65f03c0 =09ret
    2e78:=09d503203f =09yield
    2e7c:=09b85fc265 =09ldur=09w5, [x19, #-4]
    2e80:=09d50339bf =09dmb=09ishld
    2e84:=09f9400c01 =09ldr=09x1, [x0, #24]
    2e88:=09121f78b4 =09and=09w20, w5, #0xfffffffe
    2e8c:=09eb15003f =09cmp=09x1, x21
    2e90:=0954fff681 =09b.ne=092d60 <__d_lookup_rcu+0x60>  // b.any
    2e94:=0917ffffbd =09b=092d88 <__d_lookup_rcu+0x88>

0000000000002e98 <__d_lookup>:
    2e98:=09a9b97bfd =09stp=09x29, x30, [sp, #-112]!
    2e9c:=0990000002 =09adrp=09x2, 0 <find_submount>
=09=09=092e9c: R_AARCH64_ADR_PREL_PG_HI21=09.data..read_mostly
    2ea0:=0991000043 =09add=09x3, x2, #0x0
=09=09=092ea0: R_AARCH64_ADD_ABS_LO12_NC=09.data..read_mostly
    2ea4:=09910003fd =09mov=09x29, sp
    2ea8:=09a90573fb =09stp=09x27, x28, [sp, #80]
    2eac:=09aa0103fc =09mov=09x28, x1
    2eb0:=09a90153f3 =09stp=09x19, x20, [sp, #16]
    2eb4:=09a90363f7 =09stp=09x23, x24, [sp, #48]
    2eb8:=09a9046bf9 =09stp=09x25, x26, [sp, #64]
    2ebc:=09aa0003fa =09mov=09x26, x0
    2ec0:=09b9400397 =09ldr=09w23, [x28]
    2ec4:=09b9400860 =09ldr=09w0, [x3, #8]
    2ec8:=09f9400041 =09ldr=09x1, [x2]
=09=09=092ec8: R_AARCH64_LDST64_ABS_LO12_NC=09.data..read_mostly
    2ecc:=091ac026e0 =09lsr=09w0, w23, w0
    2ed0:=09f8607833 =09ldr=09x19, [x1, x0, lsl #3]
    2ed4:=09f27ffa73 =09ands=09x19, x19, #0xfffffffffffffffe
    2ed8:=0954000320 =09b.eq=092f3c <__d_lookup+0xa4>  // b.none
    2edc:=095280001b =09mov=09w27, #0x0                   =09// #0
    2ee0:=0992800018 =09mov=09x24, #0xffffffffffffffff    =09// #-1
    2ee4:=09a9025bf5 =09stp=09x21, x22, [sp, #32]
    2ee8:=09d2800016 =09mov=09x22, #0x0                   =09// #0
    2eec:=0952800035 =09mov=09w21, #0x1                   =09// #1
    2ef0:=09b9401a62 =09ldr=09w2, [x19, #24]
    2ef4:=09d1002274 =09sub=09x20, x19, #0x8
    2ef8:=096b17005f =09cmp=09w2, w23
    2efc:=09540001a1 =09b.ne=092f30 <__d_lookup+0x98>  // b.any
    2f00:=0991014279 =09add=09x25, x19, #0x50
    2f04:=09f9800331 =09prfm=09pstl1strm, [x25]
    2f08:=09885fff21 =09ldaxr=09w1, [x25]
    2f0c:=094a160020 =09eor=09w0, w1, w22
    2f10:=0935000060 =09cbnz=09w0, 2f1c <__d_lookup+0x84>
    2f14:=0988007f35 =09stxr=09w0, w21, [x25]
    2f18:=0935ffff80 =09cbnz=09w0, 2f08 <__d_lookup+0x70>
    2f1c:=0935000521 =09cbnz=09w1, 2fc0 <__d_lookup+0x128>
    2f20:=09f9400e82 =09ldr=09x2, [x20, #24]
    2f24:=09eb1a005f =09cmp=09x2, x26
    2f28:=09540001a0 =09b.eq=092f5c <__d_lookup+0xc4>  // b.none
    2f2c:=09089fff3b =09stlrb=09w27, [x25]
    2f30:=09f9400273 =09ldr=09x19, [x19]
    2f34:=09b5fffdf3 =09cbnz=09x19, 2ef0 <__d_lookup+0x58>
    2f38:=09a9425bf5 =09ldp=09x21, x22, [sp, #32]
    2f3c:=09d2800008 =09mov=09x8, #0x0                   =09// #0
    2f40:=09aa0803e0 =09mov=09x0, x8
    2f44:=09a94153f3 =09ldp=09x19, x20, [sp, #16]
    2f48:=09a94363f7 =09ldp=09x23, x24, [sp, #48]
    2f4c:=09a9446bf9 =09ldp=09x25, x26, [sp, #64]
    2f50:=09a94573fb =09ldp=09x27, x28, [sp, #80]
    2f54:=09a8c77bfd =09ldp=09x29, x30, [sp], #112
    2f58:=09d65f03c0 =09ret
    2f5c:=09f9400660 =09ldr=09x0, [x19, #8]
    2f60:=09b4fffe60 =09cbz=09x0, 2f2c <__d_lookup+0x94>
    2f64:=09b9400340 =09ldr=09w0, [x26]
    2f68:=09aa1403e8 =09mov=09x8, x20
    2f6c:=09b9402681 =09ldr=09w1, [x20, #36]
    2f70:=09370802e0 =09tbnz=09w0, #1, 2fcc <__d_lookup+0x134>
    2f74:=09b9400784 =09ldr=09w4, [x28, #4]
    2f78:=096b04003f =09cmp=09w1, w4
    2f7c:=0954fffd81 =09b.ne=092f2c <__d_lookup+0x94>  // b.any
    2f80:=09f9400787 =09ldr=09x7, [x28, #8]
    2f84:=0912000881 =09and=09w1, w4, #0x7
    2f88:=09f9401265 =09ldr=09x5, [x19, #32]
    2f8c:=09cb0500e7 =09sub=09x7, x7, x5
    2f90:=0914000003 =09b=092f9c <__d_lookup+0x104>
    2f94:=0971002084 =09subs=09w4, w4, #0x8
    2f98:=0954000300 =09b.eq=092ff8 <__d_lookup+0x160>  // b.none
    2f9c:=098b0700a2 =09add=09x2, x5, x7
    2fa0:=096b04003f =09cmp=09w1, w4
    2fa4:=09f9400046 =09ldr=09x6, [x2]
    2fa8:=09f94000a0 =09ldr=09x0, [x5]
    2fac:=0954000340 =09b.eq=093014 <__d_lookup+0x17c>  // b.none
    2fb0:=09910020a5 =09add=09x5, x5, #0x8
    2fb4:=09eb06001f =09cmp=09x0, x6
    2fb8:=0954fffee0 =09b.eq=092f94 <__d_lookup+0xfc>  // b.none
    2fbc:=0917ffffdc =09b=092f2c <__d_lookup+0x94>
    2fc0:=09aa1903e0 =09mov=09x0, x25
    2fc4:=0994000000 =09bl=090 <queued_spin_lock_slowpath>
=09=09=092fc4: R_AARCH64_CALL26=09queued_spin_lock_slowpath
    2fc8:=0917ffffd6 =09b=092f20 <__d_lookup+0x88>
    2fcc:=09f9403340 =09ldr=09x0, [x26, #96]
    2fd0:=09aa1c03e3 =09mov=09x3, x28
    2fd4:=09f9401682 =09ldr=09x2, [x20, #40]
    2fd8:=09f90037f4 =09str=09x20, [sp, #104]
    2fdc:=09f9400c04 =09ldr=09x4, [x0, #24]
    2fe0:=09aa1403e0 =09mov=09x0, x20
    2fe4:=09d63f0080 =09blr=09x4
    2fe8:=097100001f =09cmp=09w0, #0x0
    2fec:=091a9f17e0 =09cset=09w0, eq  // eq =3D none
    2ff0:=09f94037e8 =09ldr=09x8, [sp, #104]
    2ff4:=0934fff9c0 =09cbz=09w0, 2f2c <__d_lookup+0x94>
    2ff8:=09b9405e80 =09ldr=09w0, [x20, #92]
    2ffc:=0952800001 =09mov=09w1, #0x0                   =09// #0
    3000:=0911000400 =09add=09w0, w0, #0x1
    3004:=09b9005e80 =09str=09w0, [x20, #92]
    3008:=09089fff21 =09stlrb=09w1, [x25]
    300c:=09a9425bf5 =09ldp=09x21, x22, [sp, #32]
    3010:=0917ffffcc =09b=092f40 <__d_lookup+0xa8>
    3014:=09531d7021 =09lsl=09w1, w1, #3
    3018:=09ca060000 =09eor=09x0, x0, x6
    301c:=099ac12301 =09lsl=09x1, x24, x1
    3020:=09ea21001f =09bics=09xzr, x0, x1
    3024:=091a9f17e0 =09cset=09w0, eq  // eq =3D none
    3028:=0934fff820 =09cbz=09w0, 2f2c <__d_lookup+0x94>
    302c:=0917fffff3 =09b=092ff8 <__d_lookup+0x160>

0000000000003030 <d_lookup>:
    3030:=09a9bd7bfd =09stp=09x29, x30, [sp, #-48]!
    3034:=09910003fd =09mov=09x29, sp
    3038:=09a90153f3 =09stp=09x19, x20, [sp, #16]
    303c:=0990000013 =09adrp=09x19, 0 <find_submount>
=09=09=09303c: R_AARCH64_ADR_PREL_PG_HI21=09.data..cacheline_aligned
    3040:=09aa0103f4 =09mov=09x20, x1
    3044:=0991000273 =09add=09x19, x19, #0x0
=09=09=093044: R_AARCH64_ADD_ABS_LO12_NC=09.data..cacheline_aligned
    3048:=09a9025bf5 =09stp=09x21, x22, [sp, #32]
    304c:=09aa0003f5 =09mov=09x21, x0
    3050:=09b9400276 =09ldr=09w22, [x19]
    3054:=09370001d6 =09tbnz=09w22, #0, 308c <d_lookup+0x5c>
    3058:=09d50339bf =09dmb=09ishld
    305c:=09aa1403e1 =09mov=09x1, x20
    3060:=09aa1503e0 =09mov=09x0, x21
    3064:=0994000000 =09bl=092e98 <__d_lookup>
=09=09=093064: R_AARCH64_CALL26=09__d_lookup
    3068:=09b50000a0 =09cbnz=09x0, 307c <d_lookup+0x4c>
    306c:=09d50339bf =09dmb=09ishld
    3070:=09b9400261 =09ldr=09w1, [x19]
    3074:=096b16003f =09cmp=09w1, w22
    3078:=0954fffec1 =09b.ne=093050 <d_lookup+0x20>  // b.any
    307c:=09a94153f3 =09ldp=09x19, x20, [sp, #16]
    3080:=09a9425bf5 =09ldp=09x21, x22, [sp, #32]
    3084:=09a8c37bfd =09ldp=09x29, x30, [sp], #48
    3088:=09d65f03c0 =09ret
    308c:=09d503203f =09yield
    3090:=0917fffff0 =09b=093050 <d_lookup+0x20>
    3094:=09d503201f =09nop
...

>> This trace is from v5.2.0-rc1:
>> Unable to handle kernel paging request at virtual address 0000880001000018=

> [apparently identical oops, modulo the call chain to=20
> d_lookup(); since that's
> almost certainly buggered data structures encountered during=20
> the hash lookup,
> exact callchain doesn't matter all that much; procfs is the=20
> filesystem involved]
>
>> This trace is from v5.2.0-rc1 while executing 'git pull -r' from f2fs. It
>> got repeated several times:
>>=20
>> Unable to handle kernel paging request at virtual address 0000000000fffffc=

>> user pgtable: 4k pages, 48-bit VAs, pgdp =3D 0000000092bdb9cd
>> [0000000000fffffc] pgd=3D0000000000000000
>> pc : __d_lookup_rcu+0x68/0x198
>
>> This trace is from v5.2.0-rc1 while executing 'rm -rf' the directory
>> affected from the previous trace:
>>=20
>> Unable to handle kernel paging request at virtual address 0000000001000018=

>
> ... and addresses involved are
>
> 0000880001000018
> 0000000000fffffc
> 0000000001000018
>
> AFAICS, the only registers with the value in the vicinity of those addresse=
s
> had been (in all cases so far) x19 - 0000880001000000 in the=20
> first two traces,
> 0000000001000000 in the last two...
>
> I'd really like to see the disassembly of the functions involved (as well a=
s
> .config in question).

Here is the .config: https://paste.debian.net/1082689

Regards,
  Vicen=C3=A7.

