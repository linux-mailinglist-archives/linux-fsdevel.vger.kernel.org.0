Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16DAE4B8E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 14:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbfFSMm1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 08:42:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37173 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfFSMm0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:42:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so1688633wme.2;
        Wed, 19 Jun 2019 05:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=rY+nUUabnDZVxT05KLR38g7getJ6swPhpa94gw5gUZU=;
        b=lbhV5ibXM+in6453oxcaHWnWZBARWCHOcOmFvVLxOQ1BozBhzPZDs4SkxNoykbSQWk
         mxSzkHj6GH07K97BhGAMdGXF/MEMjd30+7udZDBP0++qgC7xARnZCJuH9ImhC5Rc+3Tm
         t1qCQNZk7e8094O90sWFcX8XEhl7Tm6Wgj/thFRD4ulEkQyqyu3KN9tV6IUQp1mCBROk
         PvbKJnytwyw5F1z4RN+j1ChVy2p6/oEt4+6tLihrE+cAIL8dJncKOeFEVcC8l9aNG+MH
         xSJ/n3MLZQoWrva89HgH4VAVPchw8dblRUK/dCTKAS4wq/ei7PytystIy8L058I0MLeZ
         nf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=rY+nUUabnDZVxT05KLR38g7getJ6swPhpa94gw5gUZU=;
        b=UeOHIcG6BWgvYQ9DtZ2Vh+drRnZlMEzEVs+Va4kJ64kbh/79dZODabmwVvJarGI5wx
         nmxzToZsJKKfxQwCLgmqXFUTAma7ZpNjRC6rU6Fux39e/3I2CdZZIOt3HOXPA2K8vBtL
         0UjG8Eu5uMfqvlFgOHhuW27ee6LQ99lfN3O8wZT/ozSL+VWdDJZi03gQtHlC3LDwoB8L
         BGDoyb7Ck/DuSD3R5KRcrSxaLEeLG3hwhdGA+Q4u3s8AXqMeffHuGuoHn56ORnDK0Dp2
         Tu2Vb0L2WbJ0718v2SQAeFYddxML3zyQXBSnVru0QeaA9uJeA2qfg9lqQUoHNEwDQIMJ
         RHHw==
X-Gm-Message-State: APjAAAU0qDVYEpKCf8BL3LGXwaCLMKZIOf9AvcPa3a77TqbJ/FTbXgNS
        MnHnmWYKrmeoudHsH7XpL4Jf1DlGutg=
X-Google-Smtp-Source: APXvYqzYWzHrj76h3tUUFPzoM/sI2IhERT7VVtYm5DZm5mrIp2U9UhZNd+c1dB15b15CirKttXflPw==
X-Received: by 2002:a1c:a019:: with SMTP id j25mr5742147wme.95.1560948138927;
        Wed, 19 Jun 2019 05:42:18 -0700 (PDT)
Received: from localhost ([92.59.185.54])
        by smtp.gmail.com with ESMTPSA id u2sm5071231wmc.3.2019.06.19.05.42.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:42:17 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: =?iso-8859-1?Q?d=5Flookup:_Unable_to_handle_kernel_paging_request?=
Date:   Wed, 19 Jun 2019 14:42:16 +0200
MIME-Version: 1.0
Message-ID: <bf2b3aa6-bda1-43f1-9a01-e4ad3df81c0b@gmail.com>
In-Reply-To: <20190618183548.GB17978@ZenIV.linux.org.uk>
References: <23950bcb-81b0-4e07-8dc8-8740eb53d7fd@gmail.com>
 <20190522135331.GM17978@ZenIV.linux.org.uk>
 <bdc8b245-afca-4662-99e2-a082f25fc927@gmail.com>
 <20190522162945.GN17978@ZenIV.linux.org.uk>
 <10192e43-c21d-44e4-915d-bf77a50c22c4@gmail.com>
 <20190618183548.GB17978@ZenIV.linux.org.uk>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tuesday, June 18, 2019 8:35:48 PM CEST, Al Viro wrote:
> On Tue, May 28, 2019 at 11:38:43AM +0200, Vicente Bergas wrote:
>> On Wednesday, May 22, 2019 6:29:46 PM CEST, Al Viro wrote: ...
>
> __d_lookup() running into &dentry->d_hash =3D=3D 0x01000000 at some=20
> point in hash chain
> and trying to look at ->d_name.hash:
>
>> pc : __d_lookup+0x58/0x198
>> lr : d_lookup+0x38/0x68
>> sp : ffff000012663b90
>> x29: ffff000012663b90 x28: ffff000012663d58 x27: 0000000000000000 x26:
>> ffff8000ae7cc900 x25: 0000000000000001 x24: ffffffffffffffff x23: ...
>
> __d_lookup_rcu() running into &dentry->d_hash =3D=3D 0x01000000 at=20
> some point in hash
> chain and trying to look at ->d_seq:
>
>> pc : __d_lookup_rcu+0x68/0x198
>> lr : lookup_fast+0x44/0x2e8
>> sp : ffff0000130b3b60
>> x29: ffff0000130b3b60 x28: 00000000ce99d070 x27: ffffffffffffffff x26:
>> 0000000000000026 x25: ffff8000ecec6030 x24: ffff0000130b3c2c x23: ...
>
> __d_lookup_rcu() running into &dentry->d_hash =3D=3D=20
> 0x0000880001000000 at some point
> in hash chain and trying to look at ->d_seq:
>
>> pc : __d_lookup_rcu+0x68/0x198
>> lr : lookup_fast+0x44/0x2e8
>> sp : ffff00001325ba90
>> x29: ffff00001325ba90 x28: 00000000ce99f075 x27: ffffffffffffffff x26:
>> 0000000000000007 x25: ffff8000ecec402a x24: ffff00001325bb5c x23: ...
>
> ditto
>
>> pc : __d_lookup_rcu+0x68/0x198
>> lr : lookup_fast+0x44/0x2e8
>> sp : ffff000012a3ba90
>> x29: ffff000012a3ba90 x28: 00000000ce99f075 x27: ffffffffffffffff x26:
>> 0000000000000007 x25: ffff8000ecec702a x24: ffff000012a3bb5c x23: ...
>
> ditto
>
>> pc : __d_lookup_rcu+0x68/0x198
>> lr : lookup_fast+0x44/0x2e8
>> sp : ffff0000132bba90
>> x29: ffff0000132bba90 x28: 00000000ce99e1a6 x27: ffffffffffffffff x26:
>> 000000000000000c x25: ffff8000f21dd036 x24: ffff0000132bbb5c x23: ...
>
> ... and ditto:
>
>> pc : __d_lookup_rcu+0x68/0x198
>> lr : lookup_fast+0x44/0x2e8
>> sp : ffff000013263a90
>> x29: ffff000013263a90 x28: 00000000ce99e1a6 x27: ffffffffffffffff x26:
>> 000000000000000c x25: ffff8000f0a6f036 x24: ffff000013263b5c x23: ...
>
>
> All of those run under rcu_read_lock() and no dentry with DCACHE_NORCU has
> ever been inserted into a hash chain, so it doesn't look like a plain
> use-after-free.  Could you try something like the following to see a bit
> more about where it comes from? =20
>
> So far it looks like something is buggering a forward reference
> in hash chain in a fairly specific way - the values seen had been
> 00000000010000000 and
> 00008800010000000.  Does that smell like anything from arm64-specific
> data structures (PTE, etc.)?
>
> Alternatively, we might've gone off rails a step (or more) before,
> with the previous iteration going through bogus, but at least mapped
> address - the one that has never been a dentry in the first place.
>
>
> diff --git a/fs/dcache.c b/fs/dcache.c
> index c435398f2c81..cb555edb5b55 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2114,6 +2114,22 @@ static inline bool d_same_name(const=20
> struct dentry *dentry,
>  =09=09=09=09       name) =3D=3D 0;
>  }
> =20
> +static void dump(struct dentry *dentry)
> +{
> +=09int i;
> +=09if (!dentry) {
> +=09=09printk(KERN_ERR "list fucked in head");
> +=09=09return;
> +=09}
> +=09printk(KERN_ERR "fucked dentry[%p]: d_hash.next =3D %p, flags =3D=20
> %x, count =3D %d",
> +=09=09=09dentry, dentry->d_hash.next, dentry->d_flags,
> +=09=09=09dentry->d_lockref.count
> +=09=09=09);
> +=09for (i =3D 0; i < sizeof(struct dentry); i++)
> +=09=09printk(KERN_CONT "%c%02x", i & 31 ? ' ' : '\n',
> +=09=09=09((unsigned char *)dentry)[i]);
> +}
> +
>  /**
>   * __d_lookup_rcu - search for a dentry (racy, store-free)
>   * @parent: parent dentry
> @@ -2151,7 +2167,7 @@ struct dentry *__d_lookup_rcu(const=20
> struct dentry *parent,
>  =09const unsigned char *str =3D name->name;
>  =09struct hlist_bl_head *b =3D d_hash(hashlen_hash(hashlen));
>  =09struct hlist_bl_node *node;
> -=09struct dentry *dentry;
> +=09struct dentry *dentry, *last =3D NULL;
> =20
>  =09/*
>  =09 * Note: There is significant duplication with __d_lookup_rcu which is
> @@ -2176,6 +2192,10 @@ struct dentry *__d_lookup_rcu(const=20
> struct dentry *parent,
>  =09hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
>  =09=09unsigned seq;
> =20
> +=09=09if (unlikely((u32)(unsigned long)&dentry->d_hash =3D=3D 0x01000000))=

> +=09=09=09dump(last);
> +=09=09last =3D dentry;
> +
>  seqretry:
>  =09=09/*
>  =09=09 * The dentry sequence count protects us from concurrent
> @@ -2274,7 +2294,7 @@ struct dentry *__d_lookup(const struct=20
> dentry *parent, const struct qstr *name)
>  =09struct hlist_bl_head *b =3D d_hash(hash);
>  =09struct hlist_bl_node *node;
>  =09struct dentry *found =3D NULL;
> -=09struct dentry *dentry;
> +=09struct dentry *dentry, *last =3D NULL;
> =20
>  =09/*
>  =09 * Note: There is significant duplication with __d_lookup_rcu which is
> @@ -2300,6 +2320,10 @@ struct dentry *__d_lookup(const struct=20
> dentry *parent, const struct qstr *name)
>  =09
>  =09hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
> =20
> +=09=09if (unlikely((u32)(unsigned long)&dentry->d_hash =3D=3D 0x01000000))=

> +=09=09=09dump(last);
> +=09=09last =3D dentry;
> +
>  =09=09if (dentry->d_name.hash !=3D hash)
>  =09=09=09continue;

Hi Al,
i have been running the distro-provided kernel the last few weeks
and had no issues at all.
https://archlinuxarm.org/packages/aarch64/linux-aarch64
It is from the v5.1 branch and is compiled with gcc 8.3.

IIRC, i also tested
https://archlinuxarm.org/packages/aarch64/linux-aarch64-rc
v5.2-rc1 and v5.2-rc2 (which at that time where compiled with
gcc 8.2) with no issues.

This week tested v5.2-rc4 and v5.2-rc5 from archlinuxarm but
there are regressions unrelated to d_lookup.

At this point i was convinced it was a gcc 9.1 issue and had
nothing to do with the kernel, but anyways i gave your patch a try.
The tested kernel is v5.2-rc5-224-gbed3c0d84e7e and
it has been compiled with gcc 8.3.
The sentinel you put there has triggered!
So, it is not a gcc 9.1 issue.

In any case, i have no idea if those addresses are arm64-specific
in any way.

Regards,
  Vicen=C3=A7.

list fucked in head
Unable to handle kernel paging request at virtual address 0000000000fffffc
Mem abort info:
  ESR =3D 0x96000004
  Exception class =3D DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
Data abort info:
  ISV =3D 0, ISS =3D 0x00000004
  CM =3D 0, WnR =3D 0
user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000005c989000
[0000000000fffffc] pgd=3D0000000000000000
Internal error: Oops: 96000004 [#1] SMP
CPU: 4 PID: 2427 Comm: git Not tainted 5.2.0-rc5 #1
Hardware name: Sapphire-RK3399 Board (DT)
pstate: 60000005 (nZCv daif -PAN -UAO)
pc : __d_lookup_rcu+0x90/0x1e8
lr : __d_lookup_rcu+0x84/0x1e8
sp : ffff000013413a90
x29: ffff000013413a90 x28: ffff000013413b5c=20
x27: 0000000000000002 x26: ffff000013413c78=20
x25: 0000001ac1084259 x24: 0000000000fffff8=20
x23: 0000000001000000 x22: ffff8000586ed9c0=20
x21: ffff8000586ed9c0 x20: 0000000000fffff8=20
x19: 0000000001000000 x18: 0000000000000000=20
x17: 0000000000000000 x16: 0000000000000000=20
x15: 0000000000000000 x14: 0000000000000000=20
x13: 0000000000000000 x12: 0000000000000000=20
x11: 0000000000000000 x10: ffffffffffffffff=20
x9 : 00000000c1084259 x8 : ffff800054f31032=20
x7 : 000000000000001a x6 : ffff00001090454b=20
x5 : 0000000000000013 x4 : 0000000000000000=20
x3 : 0000000000000000 x2 : 00000000ffffffff=20
x1 : 00008000e6f46000 x0 : 0000000000000013=20
Call trace:
 __d_lookup_rcu+0x90/0x1e8
 lookup_fast+0x44/0x300
 walk_component+0x34/0x2e0
 path_lookupat.isra.13+0x5c/0x1e0
 filename_lookup.part.19+0x6c/0xe8
 user_path_at_empty+0x4c/0x60
 vfs_statx+0x78/0xd8
 __se_sys_newfstatat+0x24/0x48
 __arm64_sys_newfstatat+0x18/0x20
 el0_svc_handler+0x94/0x138
 el0_svc+0x8/0xc
Code: 94000753 294c1fe9 9280000a f94037e8 (b85fc263)=20
---[ end trace 93a444e9b6bc67e8 ]---
list fucked in head
Unable to handle kernel paging request at virtual address 0000000000fffffc
Mem abort info:
  ESR =3D 0x96000004
  Exception class =3D DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
Data abort info:
  ISV =3D 0, ISS =3D 0x00000004
  CM =3D 0, WnR =3D 0
user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000005c989000
[0000000000fffffc] pgd=3D0000000000000000
Internal error: Oops: 96000004 [#2] SMP
CPU: 5 PID: 2424 Comm: git Tainted: G      D           5.2.0-rc5 #1
Hardware name: Sapphire-RK3399 Board (DT)
pstate: 60000005 (nZCv daif -PAN -UAO)
pc : __d_lookup_rcu+0x90/0x1e8
lr : __d_lookup_rcu+0x84/0x1e8
sp : ffff0000133fba90
x29: ffff0000133fba90 x28: ffff0000133fbb5c=20
x27: 0000000000000002 x26: ffff0000133fbc78=20
x25: 0000001ac1084259 x24: 0000000000fffff8=20
x23: 0000000001000000 x22: ffff8000586ed9c0=20
x21: ffff8000586ed9c0 x20: 0000000000fffff8=20
x19: 0000000001000000 x18: 0000000000000000=20
x17: 0000000000000000 x16: 0000000000000000=20
x15: 0000000000000000 x14: 0000000000000000=20
x13: 0000000000000000 x12: 0000000000000000=20
x11: 0000000000000000 x10: ffffffffffffffff=20
x9 : 00000000c1084259 x8 : ffff800079d7b032=20
x7 : 000000000000001a x6 : ffff00001090454b=20
x5 : 0000000000000013 x4 : 0000000000000000=20
x3 : 0000000000000000 x2 : 00000000ffffffff=20
x1 : 00008000e6f5a000 x0 : 0000000000000013=20
Call trace:
 __d_lookup_rcu+0x90/0x1e8
 lookup_fast+0x44/0x300
 walk_component+0x34/0x2e0
 path_lookupat.isra.13+0x5c/0x1e0
 filename_lookup.part.19+0x6c/0xe8
 user_path_at_empty+0x4c/0x60
 vfs_statx+0x78/0xd8
 __se_sys_newfstatat+0x24/0x48
 __arm64_sys_newfstatat+0x18/0x20
 el0_svc_handler+0x94/0x138
 el0_svc+0x8/0xc
Code: 94000753 294c1fe9 9280000a f94037e8 (b85fc263)=20
---[ end trace 93a444e9b6bc67e9 ]---
list fucked in head
Unable to handle kernel paging request at virtual address 0000880000fffffc
Mem abort info:
  ESR =3D 0x96000004
  Exception class =3D DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
Data abort info:
  ISV =3D 0, ISS =3D 0x00000004
  CM =3D 0, WnR =3D 0
user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000003ba5d000
[0000880000fffffc] pgd=3D0000000000000000
Internal error: Oops: 96000004 [#3] SMP
CPU: 2 PID: 2659 Comm: git Tainted: G      D           5.2.0-rc5 #1
Hardware name: Sapphire-RK3399 Board (DT)
pstate: 60000005 (nZCv daif -PAN -UAO)
pc : __d_lookup_rcu+0x90/0x1e8
lr : __d_lookup_rcu+0x84/0x1e8
sp : ffff0000135cba90
x29: ffff0000135cba90 x28: ffff0000135cbb5c=20
x27: 0000000000000000 x26: ffff0000135cbc78=20
x25: 00000010cb63a9bb x24: 0000880000fffff8=20
x23: 0000000001000000 x22: ffff80003be53180=20
x21: ffff80003be53180 x20: 0000880000fffff8=20
x19: 0000880001000000 x18: 0000000000000000=20
x17: 0000000000000000 x16: 0000000000000000=20
x15: 0000000000000000 x14: 0000000000000000=20
x13: 0000000000000000 x12: 0000000000000000=20
x11: 0000000000000000 x10: ffffffffffffffff=20
x9 : 00000000cb63a9bb x8 : ffff8000f094102e=20
x7 : 0000000000000010 x6 : ffff00001090454b=20
x5 : 0000000000000013 x4 : 0000000000000000=20
x3 : 0000000000000000 x2 : 00000000ffffffff=20
x1 : 00008000e6f1e000 x0 : 0000000000000013=20
Call trace:
 __d_lookup_rcu+0x90/0x1e8
 lookup_fast+0x44/0x300
 walk_component+0x34/0x2e0
 path_lookupat.isra.13+0x5c/0x1e0
 filename_lookup.part.19+0x6c/0xe8
 user_path_at_empty+0x4c/0x60
 vfs_statx+0x78/0xd8
 __se_sys_newfstatat+0x24/0x48
 __arm64_sys_newfstatat+0x18/0x20
 el0_svc_handler+0x94/0x138
 el0_svc+0x8/0xc
Code: 94000753 294c1fe9 9280000a f94037e8 (b85fc263)=20
---[ end trace 93a444e9b6bc67ea ]---
list fucked in head
Unable to handle kernel paging request at virtual address 0000880000fffffc
Mem abort info:
  ESR =3D 0x96000004
  Exception class =3D DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
Data abort info:
  ISV =3D 0, ISS =3D 0x00000004
  CM =3D 0, WnR =3D 0
user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000003ba5d000
[0000880000fffffc] pgd=3D0000000000000000
Internal error: Oops: 96000004 [#4] SMP
CPU: 4 PID: 2658 Comm: git Tainted: G      D           5.2.0-rc5 #1
Hardware name: Sapphire-RK3399 Board (DT)
pstate: 60000005 (nZCv daif -PAN -UAO)
pc : __d_lookup_rcu+0x90/0x1e8
lr : __d_lookup_rcu+0x84/0x1e8
sp : ffff00001363ba90
x29: ffff00001363ba90 x28: ffff00001363bb5c=20
x27: 0000000000000000 x26: ffff00001363bc78=20
x25: 00000010cb63a9bb x24: 0000880000fffff8=20
x23: 0000000001000000 x22: ffff80003be53180=20
x21: ffff80003be53180 x20: 0000880000fffff8=20
x19: 0000880001000000 x18: 0000000000000000=20
x17: 0000000000000000 x16: 0000000000000000=20
x15: 0000000000000000 x14: 0000000000000000=20
x13: 0000000000000000 x12: 0000000000000000=20
x11: 0000000000000000 x10: ffffffffffffffff=20
x9 : 00000000cb63a9bb x8 : ffff80004b94d02e=20
x7 : 0000000000000010 x6 : ffff00001090454b=20
x5 : 0000000000000013 x4 : 0000000000000000=20
x3 : 0000000000000000 x2 : 00000000ffffffff=20
x1 : 00008000e6f46000 x0 : 0000000000000013=20
Call trace:
 __d_lookup_rcu+0x90/0x1e8
 lookup_fast+0x44/0x300
 walk_component+0x34/0x2e0
 path_lookupat.isra.13+0x5c/0x1e0
 filename_lookup.part.19+0x6c/0xe8
 user_path_at_empty+0x4c/0x60
 vfs_statx+0x78/0xd8
 __se_sys_newfstatat+0x24/0x48
 __arm64_sys_newfstatat+0x18/0x20
 el0_svc_handler+0x94/0x138
 el0_svc+0x8/0xc
Code: 94000753 294c1fe9 9280000a f94037e8 (b85fc263)=20
---[ end trace 93a444e9b6bc67eb ]---
list fucked in head
Unable to handle kernel paging request at virtual address 0000000001000018
Mem abort info:
  ESR =3D 0x96000004
  Exception class =3D DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
Data abort info:
  ISV =3D 0, ISS =3D 0x00000004
  CM =3D 0, WnR =3D 0
user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000002091a000
[0000000001000018] pgd=3D0000000000000000
Internal error: Oops: 96000004 [#5] SMP
CPU: 4 PID: 3205 Comm: update_all_gits Tainted: G      D          =20
5.2.0-rc5 #1
Hardware name: Sapphire-RK3399 Board (DT)
pstate: 60000005 (nZCv daif -PAN -UAO)
pc : __d_lookup+0x88/0x1d8
lr : __d_lookup+0x7c/0x1d8
sp : ffff000013dabaa0
x29: ffff000013dabaa0 x28: ffff000013dabbd8=20
x27: ffff00001076f0f8 x26: ffff8000f2808780=20
x25: 0000000000fffff8 x24: 0000000001000000=20
x23: 00000000cb639d51 x22: 0000000000000000=20
x21: 0000000000000001 x20: 0000000000fffff8=20
x19: 0000000001000000 x18: 0000000000000000=20
x17: 0000000000000000 x16: 0000000000000000=20
x15: ffffffffffffffff x14: ffff000010898508=20
x13: ffff000013dabbf8 x12: ffff000013dabbed=20
x11: 0000000000000001 x10: ffff000013daba60=20
x9 : ffff000013daba60 x8 : ffff000013daba60=20
x7 : ffff000013daba60 x6 : ffffffffffffffff=20
x5 : 0000000000000000 x4 : 0000000000000000=20
x3 : 0000000000000000 x2 : 00000000ffffffff=20
x1 : 00008000e6f46000 x0 : 0000000000000013=20
Call trace:
 __d_lookup+0x88/0x1d8
 d_lookup+0x34/0x68
 d_hash_and_lookup+0x50/0x68
 proc_flush_task+0x9c/0x198
 release_task.part.3+0x68/0x4b8
 wait_consider_task+0x91c/0x9b0
 do_wait+0x120/0x1e0
 kernel_wait4+0x7c/0x140
 __se_sys_wait4+0x68/0xa8
 __arm64_sys_wait4+0x18/0x20
 el0_svc_handler+0x94/0x138
 el0_svc+0x8/0xc
Code: 940006db b9406fe5 92800006 d503201f (b9402282)=20
---[ end trace 93a444e9b6bc67ec ]---
list fucked in head
Unable to handle kernel paging request at virtual address 0000880101000018
Mem abort info:
  ESR =3D 0x96000004
  Exception class =3D DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
Data abort info:
  ISV =3D 0, ISS =3D 0x00000004
  CM =3D 0, WnR =3D 0
user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000009bddd000
[0000880101000018] pgd=3D0000000000000000
Internal error: Oops: 96000004 [#6] SMP
CPU: 5 PID: 3978 Comm: tar Tainted: G      D           5.2.0-rc5 #1
Hardware name: Sapphire-RK3399 Board (DT)
pstate: 60000005 (nZCv daif -PAN -UAO)
pc : __d_lookup+0x88/0x1d8
lr : __d_lookup+0x7c/0x1d8
sp : ffff000014dc3b90
x29: ffff000014dc3b90 x28: ffff000014dc3d58=20
x27: ffff000014dc3d48 x26: ffff8000a77becc0=20
x25: 0000880100fffff8 x24: 0000000001000000=20
x23: 00000000c1086fd8 x22: 0000000000000000=20
x21: 0000000000000001 x20: 0000880100fffff8=20
x19: 0000880101000000 x18: 0000000000000000=20
x17: 0000000000000000 x16: 0000000000000000=20
x15: 0000000000000000 x14: 0000000000000000=20
x13: 0000000000000000 x12: 0000000000000000=20
x11: 0000000000000000 x10: ffff000014dc3b50=20
x9 : ffff000014dc3b50 x8 : ffff000014dc3b50=20
x7 : ffff000014dc3b50 x6 : ffffffffffffffff=20
x5 : 0000000000000000 x4 : 0000000000000000=20
x3 : 0000000000000000 x2 : 00000000ffffffff=20
x1 : 00008000e6f5a000 x0 : 0000000000000013=20
Call trace:
 __d_lookup+0x88/0x1d8
 d_lookup+0x34/0x68
 path_openat+0x528/0xfd0
 do_filp_open+0x60/0xc0
 do_sys_open+0x164/0x200
 __arm64_sys_openat+0x20/0x28
 el0_svc_handler+0x94/0x138
 el0_svc+0x8/0xc
Code: 940006db b9406fe5 92800006 d503201f (b9402282)=20
---[ end trace 93a444e9b6bc67ed ]---

0000000000002d10 <__d_lookup_rcu>:
{
    2d10:=09a9b97bfd =09stp=09x29, x30, [sp, #-112]!
=09return dentry_hashtable + (hash >> d_hash_shift);
    2d14:=0990000003 =09adrp=09x3, 0 <d_shrink_del>
    2d18:=0991000065 =09add=09x5, x3, #0x0
{
    2d1c:=09910003fd =09mov=09x29, sp
    2d20:=09a90153f3 =09stp=09x19, x20, [sp, #16]
    2d24:=09a90363f7 =09stp=09x23, x24, [sp, #48]
    2d28:=09a9046bf9 =09stp=09x25, x26, [sp, #64]
=09const unsigned char *str =3D name->name;
    2d2c:=09a9402039 =09ldp=09x25, x8, [x1]
=09return dentry_hashtable + (hash >> d_hash_shift);
    2d30:=09f9400064 =09ldr=09x4, [x3]
    2d34:=09b94008a3 =09ldr=09w3, [x5, #8]
    2d38:=091ac32723 =09lsr=09w3, w25, w3
=09__READ_ONCE_SIZE;
    2d3c:=09f8637893 =09ldr=09x19, [x4, x3, lsl #3]
=09hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
    2d40:=09f27ffa73 =09ands=09x19, x19, #0xfffffffffffffffe
    2d44:=0954000420 =09b.eq=092dc8 <__d_lookup_rcu+0xb8>  // b.none
=09=09=09if (dentry_cmp(dentry, str, hashlen_len(hashlen)) !=3D 0)
    2d48:=09d360ff27 =09lsr=09x7, x25, #32
    2d4c:=092a1903e9 =09mov=09w9, w25
    2d50:=09aa0103fa =09mov=09x26, x1
    2d54:=09a90573fb =09stp=09x27, x28, [sp, #80]
    2d58:=09aa0203fc =09mov=09x28, x2
    2d5c:=09120008fb =09and=09w27, w7, #0x7
=09=09if (unlikely((u32)(unsigned long)&dentry->d_hash =3D=3D 0x01000000))
    2d60:=0952a02017 =09mov=09w23, #0x1000000             =09// #16777216
=09mask =3D bytemask_from_count(tcount);
    2d64:=099280000a =09mov=09x10, #0xffffffffffffffff    =09// #-1
    2d68:=09a9025bf5 =09stp=09x21, x22, [sp, #32]
    2d6c:=09aa0003f5 =09mov=09x21, x0
=09struct dentry *dentry, *last =3D NULL;
    2d70:=09d2800000 =09mov=09x0, #0x0                   =09// #0
    2d74:=09d503201f =09nop
=09hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
    2d78:=09d1002274 =09sub=09x20, x19, #0x8
=09=09if (unlikely((u32)(unsigned long)&dentry->d_hash =3D=3D 0x01000000))
    2d7c:=096b17027f =09cmp=09w19, w23
=09hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
    2d80:=09aa1403f8 =09mov=09x24, x20
=09=09if (unlikely((u32)(unsigned long)&dentry->d_hash =3D=3D 0x01000000))
    2d84:=09540000e1 =09b.ne=092da0 <__d_lookup_rcu+0x90>  // b.any
    2d88:=09290c1fe9 =09stp=09w9, w7, [sp, #96]
    2d8c:=09f90037e8 =09str=09x8, [sp, #104]
=09=09=09dump(last);
    2d90:=0994000000 =09bl=090 <d_shrink_del>
    2d94:=09294c1fe9 =09ldp=09w9, w7, [sp, #96]
    2d98:=099280000a =09mov=09x10, #0xffffffffffffffff    =09// #-1
    2d9c:=09f94037e8 =09ldr=09x8, [sp, #104]
    2da0:=09b85fc263 =09ldur=09w3, [x19, #-4]
=09smp_rmb();
    2da4:=09d50339bf =09dmb=09ishld
=09=09if (dentry->d_parent !=3D parent)
    2da8:=09f9400e80 =09ldr=09x0, [x20, #24]
    2dac:=09eb15001f =09cmp=09x0, x21
    2db0:=09540001a0 =09b.eq=092de4 <__d_lookup_rcu+0xd4>  // b.none
    2db4:=09f9400273 =09ldr=09x19, [x19]
=09hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
    2db8:=09aa1403e0 =09mov=09x0, x20
    2dbc:=09b5fffdf3 =09cbnz=09x19, 2d78 <__d_lookup_rcu+0x68>
    2dc0:=09a9425bf5 =09ldp=09x21, x22, [sp, #32]
    2dc4:=09a94573fb =09ldp=09x27, x28, [sp, #80]
=09return NULL;
    2dc8:=09d2800018 =09mov=09x24, #0x0                   =09// #0
}
    2dcc:=09aa1803e0 =09mov=09x0, x24
    2dd0:=09a94153f3 =09ldp=09x19, x20, [sp, #16]
    2dd4:=09a94363f7 =09ldp=09x23, x24, [sp, #48]
    2dd8:=09a9446bf9 =09ldp=09x25, x26, [sp, #64]
    2ddc:=09a8c77bfd =09ldp=09x29, x30, [sp], #112
    2de0:=09d65f03c0 =09ret
=09=09if (d_unhashed(dentry))
    2de4:=09f9400660 =09ldr=09x0, [x19, #8]
    2de8:=09b4fffe60 =09cbz=09x0, 2db4 <__d_lookup_rcu+0xa4>
=09=09if (unlikely(parent->d_flags & DCACHE_OP_COMPARE)) {
    2dec:=09b94002a0 =09ldr=09w0, [x21]
=09return ret & ~1;
    2df0:=09121f7876 =09and=09w22, w3, #0xfffffffe
    2df4:=09370804a0 =09tbnz=09w0, #1, 2e88 <__d_lookup_rcu+0x178>
=09=09=09if (dentry->d_name.hash_len !=3D hashlen)
    2df8:=09f9401280 =09ldr=09x0, [x20, #32]
    2dfc:=09eb19001f =09cmp=09x0, x25
    2e00:=0954fffda1 =09b.ne=092db4 <__d_lookup_rcu+0xa4>  // b.any
    2e04:=09f9401264 =09ldr=09x4, [x19, #32]
=09const unsigned char *cs =3D READ_ONCE(dentry->d_name.name);
    2e08:=092a0703e5 =09mov=09w5, w7
    2e0c:=09cb040101 =09sub=09x1, x8, x4
    2e10:=0914000006 =09b=092e28 <__d_lookup_rcu+0x118>
=09=09cs +=3D sizeof(unsigned long);
    2e14:=0991002084 =09add=09x4, x4, #0x8
=09=09if (unlikely(a !=3D b))
    2e18:=09eb06001f =09cmp=09x0, x6
    2e1c:=0954fffcc1 =09b.ne=092db4 <__d_lookup_rcu+0xa4>  // b.any
=09=09if (!tcount)
    2e20:=09710020a5 =09subs=09w5, w5, #0x8
    2e24:=0954000160 =09b.eq=092e50 <__d_lookup_rcu+0x140>  // b.none
=09=09cs +=3D sizeof(unsigned long);
    2e28:=098b010083 =09add=09x3, x4, x1
=09=09if (tcount < sizeof(unsigned long))
    2e2c:=096b1b00bf =09cmp=09w5, w27
static inline unsigned long load_unaligned_zeropad(const void *addr)
{
=09unsigned long ret, offset;

=09/* Load word from unaligned pointer addr */
=09asm(
    2e30:=09f9400066 =09ldr=09x6, [x3]

static __no_kasan_or_inline
unsigned long read_word_at_a_time(const void *addr)
{
=09kasan_check_read(addr, 1);
=09return *(unsigned long *)addr;
    2e34:=09f9400080 =09ldr=09x0, [x4]
    2e38:=0954fffee1 =09b.ne=092e14 <__d_lookup_rcu+0x104>  // b.any
=09mask =3D bytemask_from_count(tcount);
    2e3c:=09531d7361 =09lsl=09w1, w27, #3
=09return unlikely(!!((a ^ b) & mask));
    2e40:=09ca060000 =09eor=09x0, x0, x6
=09mask =3D bytemask_from_count(tcount);
    2e44:=099ac12141 =09lsl=09x1, x10, x1
=09=09=09if (dentry_cmp(dentry, str, hashlen_len(hashlen)) !=3D 0)
    2e48:=09ea21001f =09bics=09xzr, x0, x1
    2e4c:=0954fffb41 =09b.ne=092db4 <__d_lookup_rcu+0xa4>  // b.any
=09=09*seqp =3D seq;
    2e50:=09b9000396 =09str=09w22, [x28]
}
    2e54:=09aa1803e0 =09mov=09x0, x24
    2e58:=09a94153f3 =09ldp=09x19, x20, [sp, #16]
=09=09return dentry;
    2e5c:=09a9425bf5 =09ldp=09x21, x22, [sp, #32]
}
    2e60:=09a94363f7 =09ldp=09x23, x24, [sp, #48]
    2e64:=09a9446bf9 =09ldp=09x25, x26, [sp, #64]
=09=09return dentry;
    2e68:=09a94573fb =09ldp=09x27, x28, [sp, #80]
}
    2e6c:=09a8c77bfd =09ldp=09x29, x30, [sp], #112
    2e70:=09d65f03c0 =09ret
=09=09if (d_unhashed(dentry))
    2e74:=09f9400660 =09ldr=09x0, [x19, #8]
    2e78:=09121f7876 =09and=09w22, w3, #0xfffffffe
    2e7c:=09b4fff9c0 =09cbz=09x0, 2db4 <__d_lookup_rcu+0xa4>
=09=09if (unlikely(parent->d_flags & DCACHE_OP_COMPARE)) {
    2e80:=09b94002a0 =09ldr=09w0, [x21]
    2e84:=09360ffba0 =09tbz=09w0, #1, 2df8 <__d_lookup_rcu+0xe8>
=09=09=09if (dentry->d_name.hash !=3D hashlen_hash(hashlen))
    2e88:=09b9402280 =09ldr=09w0, [x20, #32]
    2e8c:=096b00013f =09cmp=09w9, w0
    2e90:=0954fff921 =09b.ne=092db4 <__d_lookup_rcu+0xa4>  // b.any
=09=09=09tlen =3D dentry->d_name.len;
    2e94:=09b9402681 =09ldr=09w1, [x20, #36]
=09=09=09tname =3D dentry->d_name.name;
    2e98:=09f9401682 =09ldr=09x2, [x20, #40]
=09smp_rmb();
    2e9c:=09d50339bf =09dmb=09ishld
=09return unlikely(s->sequence !=3D start);
    2ea0:=09b85fc260 =09ldur=09w0, [x19, #-4]
=09=09=09if (read_seqcount_retry(&dentry->d_seq, seq)) {
    2ea4:=096b0002df =09cmp=09w22, w0
    2ea8:=0954000100 =09b.eq=092ec8 <__d_lookup_rcu+0x1b8>  // b.none
    2eac:=09d503203f =09yield
=09__READ_ONCE_SIZE;
    2eb0:=09b85fc263 =09ldur=09w3, [x19, #-4]
=09smp_rmb();
    2eb4:=09d50339bf =09dmb=09ishld
=09=09if (dentry->d_parent !=3D parent)
    2eb8:=09f9400e80 =09ldr=09x0, [x20, #24]
    2ebc:=09eb15001f =09cmp=09x0, x21
    2ec0:=0954fff7a1 =09b.ne=092db4 <__d_lookup_rcu+0xa4>  // b.any
    2ec4:=0917ffffec =09b=092e74 <__d_lookup_rcu+0x164>
=09=09=09if (parent->d_op->d_compare(dentry,
    2ec8:=09f94032a4 =09ldr=09x4, [x21, #96]
    2ecc:=09aa1a03e3 =09mov=09x3, x26
    2ed0:=09aa1403e0 =09mov=09x0, x20
    2ed4:=09290c1fe9 =09stp=09w9, w7, [sp, #96]
    2ed8:=09f90037e8 =09str=09x8, [sp, #104]
    2edc:=09f9400c84 =09ldr=09x4, [x4, #24]
    2ee0:=09d63f0080 =09blr=09x4
    2ee4:=099280000a =09mov=09x10, #0xffffffffffffffff    =09// #-1
    2ee8:=09294c1fe9 =09ldp=09w9, w7, [sp, #96]
    2eec:=09f94037e8 =09ldr=09x8, [sp, #104]
    2ef0:=0934fffb00 =09cbz=09w0, 2e50 <__d_lookup_rcu+0x140>
    2ef4:=0917ffffb0 =09b=092db4 <__d_lookup_rcu+0xa4>

0000000000002ef8 <__d_lookup>:
{
    2ef8:=09a9b97bfd =09stp=09x29, x30, [sp, #-112]!
=09return dentry_hashtable + (hash >> d_hash_shift);
    2efc:=0990000002 =09adrp=09x2, 0 <d_shrink_del>
    2f00:=0991000044 =09add=09x4, x2, #0x0
{
    2f04:=09910003fd =09mov=09x29, sp
    2f08:=09a90153f3 =09stp=09x19, x20, [sp, #16]
    2f0c:=09a90363f7 =09stp=09x23, x24, [sp, #48]
    2f10:=09a9046bf9 =09stp=09x25, x26, [sp, #64]
=09return dentry_hashtable + (hash >> d_hash_shift);
    2f14:=09f9400043 =09ldr=09x3, [x2]
=09unsigned int hash =3D name->hash;
    2f18:=09b9400037 =09ldr=09w23, [x1]
=09return dentry_hashtable + (hash >> d_hash_shift);
    2f1c:=09b9400882 =09ldr=09w2, [x4, #8]
    2f20:=091ac226e2 =09lsr=09w2, w23, w2
    2f24:=09f8627873 =09ldr=09x19, [x3, x2, lsl #3]
=09hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
    2f28:=09f27ffa73 =09ands=09x19, x19, #0xfffffffffffffffe
    2f2c:=0954000520 =09b.eq=092fd0 <__d_lookup+0xd8>  // b.none
    2f30:=09aa0003fa =09mov=09x26, x0
    2f34:=09a90573fb =09stp=09x27, x28, [sp, #80]
    2f38:=09aa0103fc =09mov=09x28, x1
    2f3c:=09d2800002 =09mov=09x2, #0x0                   =09// #0
=09=09if (unlikely((u32)(unsigned long)&dentry->d_hash =3D=3D 0x01000000))
    2f40:=0952a02018 =09mov=09w24, #0x1000000             =09// #16777216
=09smp_store_release(&lock->locked, 0);
    2f44:=0952800005 =09mov=09w5, #0x0                   =09// #0
=09mask =3D bytemask_from_count(tcount);
    2f48:=0992800006 =09mov=09x6, #0xffffffffffffffff    =09// #-1
    2f4c:=09a9025bf5 =09stp=09x21, x22, [sp, #32]
    2f50:=09d2800016 =09mov=09x22, #0x0                   =09// #0
    2f54:=0952800035 =09mov=09w21, #0x1                   =09// #1
=09hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
    2f58:=09d1002274 =09sub=09x20, x19, #0x8
=09=09if (unlikely((u32)(unsigned long)&dentry->d_hash =3D=3D 0x01000000))
    2f5c:=096b18027f =09cmp=09w19, w24
=09hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
    2f60:=09aa1403f9 =09mov=09x25, x20
=09=09if (unlikely((u32)(unsigned long)&dentry->d_hash =3D=3D 0x01000000))
    2f64:=09540000e1 =09b.ne=092f80 <__d_lookup+0x88>  // b.any
=09=09=09dump(last);
    2f68:=09aa0203e0 =09mov=09x0, x2
    2f6c:=09b9006fe5 =09str=09w5, [sp, #108]
    2f70:=0994000000 =09bl=090 <d_shrink_del>
    2f74:=09b9406fe5 =09ldr=09w5, [sp, #108]
    2f78:=0992800006 =09mov=09x6, #0xffffffffffffffff    =09// #-1
    2f7c:=09d503201f =09nop
=09=09if (dentry->d_name.hash !=3D hash)
    2f80:=09b9402282 =09ldr=09w2, [x20, #32]
    2f84:=096b17005f =09cmp=09w2, w23
    2f88:=09540001a1 =09b.ne=092fbc <__d_lookup+0xc4>  // b.any
    2f8c:=099101427b =09add=09x27, x19, #0x50
    2f90:=09f9800371 =09prfm=09pstl1strm, [x27]
    2f94:=09885fff61 =09ldaxr=09w1, [x27]
    2f98:=094a160020 =09eor=09w0, w1, w22
    2f9c:=0935000060 =09cbnz=09w0, 2fa8 <__d_lookup+0xb0>
    2fa0:=0988007f75 =09stxr=09w0, w21, [x27]
    2fa4:=0935ffff80 =09cbnz=09w0, 2f94 <__d_lookup+0x9c>
    2fa8:=0935000521 =09cbnz=09w1, 304c <__d_lookup+0x154>
=09=09if (dentry->d_parent !=3D parent)
    2fac:=09f9400e80 =09ldr=09x0, [x20, #24]
    2fb0:=09eb1a001f =09cmp=09x0, x26
    2fb4:=09540001c0 =09b.eq=092fec <__d_lookup+0xf4>  // b.none
    2fb8:=09089fff65 =09stlrb=09w5, [x27]
    2fbc:=09f9400273 =09ldr=09x19, [x19]
=09hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
    2fc0:=09aa1403e2 =09mov=09x2, x20
    2fc4:=09b5fffcb3 =09cbnz=09x19, 2f58 <__d_lookup+0x60>
    2fc8:=09a9425bf5 =09ldp=09x21, x22, [sp, #32]
    2fcc:=09a94573fb =09ldp=09x27, x28, [sp, #80]
=09struct dentry *found =3D NULL;
    2fd0:=09d2800019 =09mov=09x25, #0x0                   =09// #0
}
    2fd4:=09aa1903e0 =09mov=09x0, x25
    2fd8:=09a94153f3 =09ldp=09x19, x20, [sp, #16]
    2fdc:=09a94363f7 =09ldp=09x23, x24, [sp, #48]
    2fe0:=09a9446bf9 =09ldp=09x25, x26, [sp, #64]
    2fe4:=09a8c77bfd =09ldp=09x29, x30, [sp], #112
    2fe8:=09d65f03c0 =09ret
=09=09if (d_unhashed(dentry))
    2fec:=09f9400660 =09ldr=09x0, [x19, #8]
    2ff0:=09b4fffe40 =09cbz=09x0, 2fb8 <__d_lookup+0xc0>
=09if (likely(!(parent->d_flags & DCACHE_OP_COMPARE))) {
    2ff4:=09b9400340 =09ldr=09w0, [x26]
    2ff8:=09b9402681 =09ldr=09w1, [x20, #36]
    2ffc:=0937080340 =09tbnz=09w0, #1, 3064 <__d_lookup+0x16c>
=09=09if (dentry->d_name.len !=3D name->len)
    3000:=09b9400783 =09ldr=09w3, [x28, #4]
    3004:=096b01007f =09cmp=09w3, w1
    3008:=0954fffd81 =09b.ne=092fb8 <__d_lookup+0xc0>  // b.any
=09=09return dentry_cmp(dentry, name->name, name->len) =3D=3D 0;
    300c:=09f9400787 =09ldr=09x7, [x28, #8]
static inline int dentry_string_cmp(const unsigned char *cs, const unsigned=20=

char *ct, unsigned tcount)
    3010:=0912000868 =09and=09w8, w3, #0x7
    3014:=09f9401264 =09ldr=09x4, [x19, #32]
    3018:=09cb0400e7 =09sub=09x7, x7, x4
    301c:=0914000003 =09b=093028 <__d_lookup+0x130>
=09=09if (!tcount)
    3020:=0971002063 =09subs=09w3, w3, #0x8
    3024:=0954000380 =09b.eq=093094 <__d_lookup+0x19c>  // b.none
=09=09cs +=3D sizeof(unsigned long);
    3028:=098b070082 =09add=09x2, x4, x7
=09=09if (tcount < sizeof(unsigned long))
    302c:=096b08007f =09cmp=09w3, w8
    3030:=09f9400041 =09ldr=09x1, [x2]
=09return *(unsigned long *)addr;
    3034:=09f9400080 =09ldr=09x0, [x4]
    3038:=09540003e0 =09b.eq=0930b4 <__d_lookup+0x1bc>  // b.none
=09=09cs +=3D sizeof(unsigned long);
    303c:=0991002084 =09add=09x4, x4, #0x8
=09=09if (unlikely(a !=3D b))
    3040:=09eb01001f =09cmp=09x0, x1
    3044:=0954fffee0 =09b.eq=093020 <__d_lookup+0x128>  // b.none
    3048:=0917ffffdc =09b=092fb8 <__d_lookup+0xc0>
=09queued_spin_lock_slowpath(lock, val);
    304c:=09aa1b03e0 =09mov=09x0, x27
    3050:=09b9006fe5 =09str=09w5, [sp, #108]
    3054:=0994000000 =09bl=090 <queued_spin_lock_slowpath>
    3058:=09b9406fe5 =09ldr=09w5, [sp, #108]
    305c:=0992800006 =09mov=09x6, #0xffffffffffffffff    =09// #-1
    3060:=0917ffffd3 =09b=092fac <__d_lookup+0xb4>
=09return parent->d_op->d_compare(dentry,
    3064:=09f9403340 =09ldr=09x0, [x26, #96]
    3068:=09aa1c03e3 =09mov=09x3, x28
    306c:=09f9401682 =09ldr=09x2, [x20, #40]
    3070:=09b9006fe5 =09str=09w5, [sp, #108]
    3074:=09f9400c04 =09ldr=09x4, [x0, #24]
    3078:=09aa1403e0 =09mov=09x0, x20
    307c:=09d63f0080 =09blr=09x4
=09=09=09=09       name) =3D=3D 0;
    3080:=097100001f =09cmp=09w0, #0x0
    3084:=091a9f17e0 =09cset=09w0, eq  // eq =3D none
    3088:=0992800006 =09mov=09x6, #0xffffffffffffffff    =09// #-1
    308c:=09b9406fe5 =09ldr=09w5, [sp, #108]
=09=09if (!d_same_name(dentry, parent, name))
    3090:=0934fff940 =09cbz=09w0, 2fb8 <__d_lookup+0xc0>
=09=09dentry->d_lockref.count++;
    3094:=09b9405e80 =09ldr=09w0, [x20, #92]
=09smp_store_release(&lock->locked, 0);
    3098:=0952800001 =09mov=09w1, #0x0                   =09// #0
    309c:=0911000400 =09add=09w0, w0, #0x1
    30a0:=09b9005e80 =09str=09w0, [x20, #92]
    30a4:=09089fff61 =09stlrb=09w1, [x27]
=09preempt_enable();
    30a8:=09a9425bf5 =09ldp=09x21, x22, [sp, #32]
    30ac:=09a94573fb =09ldp=09x27, x28, [sp, #80]
    30b0:=0917ffffc9 =09b=092fd4 <__d_lookup+0xdc>
=09mask =3D bytemask_from_count(tcount);
    30b4:=09531d7062 =09lsl=09w2, w3, #3
=09return unlikely(!!((a ^ b) & mask));
    30b8:=09ca010000 =09eor=09x0, x0, x1
=09mask =3D bytemask_from_count(tcount);
    30bc:=099ac220c2 =09lsl=09x2, x6, x2
    30c0:=09ea22001f =09bics=09xzr, x0, x2
    30c4:=091a9f17e0 =09cset=09w0, eq  // eq =3D none
=09=09if (!d_same_name(dentry, parent, name))
    30c8:=0934fff780 =09cbz=09w0, 2fb8 <__d_lookup+0xc0>
    30cc:=0917fffff2 =09b=093094 <__d_lookup+0x19c>

00000000000030d0 <d_lookup>:
{
    30d0:=09a9bd7bfd =09stp=09x29, x30, [sp, #-48]!
    30d4:=09910003fd =09mov=09x29, sp
    30d8:=09a90153f3 =09stp=09x19, x20, [sp, #16]
    30dc:=0990000014 =09adrp=09x20, 0 <d_shrink_del>
    30e0:=0991000294 =09add=09x20, x20, #0x0
    30e4:=09a9025bf5 =09stp=09x21, x22, [sp, #32]
    30e8:=09aa0003f6 =09mov=09x22, x0
    30ec:=09aa0103f5 =09mov=09x21, x1
    30f0:=091400000a =09b=093118 <d_lookup+0x48>
=09smp_rmb();
    30f4:=09d50339bf =09dmb=09ishld
=09=09dentry =3D __d_lookup(parent, name);
    30f8:=09aa1503e1 =09mov=09x1, x21
    30fc:=09aa1603e0 =09mov=09x0, x22
    3100:=0994000000 =09bl=092ef8 <__d_lookup>
=09=09if (dentry)
    3104:=09b5000120 =09cbnz=09x0, 3128 <d_lookup+0x58>
=09smp_rmb();
    3108:=09d50339bf =09dmb=09ishld
=09} while (read_seqretry(&rename_lock, seq));
    310c:=09b9400281 =09ldr=09w1, [x20]
    3110:=096b13003f =09cmp=09w1, w19
    3114:=09540000a0 =09b.eq=093128 <d_lookup+0x58>  // b.none
=09__READ_ONCE_SIZE;
    3118:=09b9400293 =09ldr=09w19, [x20]
=09if (unlikely(ret & 1)) {
    311c:=093607fed3 =09tbz=09w19, #0, 30f4 <d_lookup+0x24>
    3120:=09d503203f =09yield
    3124:=0917fffffd =09b=093118 <d_lookup+0x48>
}
    3128:=09a94153f3 =09ldp=09x19, x20, [sp, #16]
    312c:=09a9425bf5 =09ldp=09x21, x22, [sp, #32]
    3130:=09a8c37bfd =09ldp=09x29, x30, [sp], #48
    3134:=09d65f03c0 =09ret

0000000000003138 <d_hash_and_lookup>:
{
    3138:=09a9be7bfd =09stp=09x29, x30, [sp, #-32]!
    313c:=09910003fd =09mov=09x29, sp
    3140:=09a90153f3 =09stp=09x19, x20, [sp, #16]
    3144:=09aa0103f3 =09mov=09x19, x1
    3148:=09aa0003f4 =09mov=09x20, x0
=09name->hash =3D full_name_hash(dir, name->name, name->len);
    314c:=09b9400422 =09ldr=09w2, [x1, #4]
    3150:=09f9400421 =09ldr=09x1, [x1, #8]
    3154:=0994000000 =09bl=090 <full_name_hash>
    3158:=09b9000260 =09str=09w0, [x19]
=09if (dir->d_flags & DCACHE_OP_HASH) {
    315c:=09b9400280 =09ldr=09w0, [x20]
    3160:=09360000e0 =09tbz=09w0, #0, 317c <d_hash_and_lookup+0x44>
=09=09int err =3D dir->d_op->d_hash(dir, name);
    3164:=09f9403282 =09ldr=09x2, [x20, #96]
    3168:=09aa1303e1 =09mov=09x1, x19
    316c:=09aa1403e0 =09mov=09x0, x20
    3170:=09f9400842 =09ldr=09x2, [x2, #16]
    3174:=09d63f0040 =09blr=09x2
=09=09if (unlikely(err < 0))
    3178:=0937f800e0 =09tbnz=09w0, #31, 3194 <d_hash_and_lookup+0x5c>
=09return d_lookup(dir, name);
    317c:=09aa1303e1 =09mov=09x1, x19
    3180:=09aa1403e0 =09mov=09x0, x20
    3184:=0994000000 =09bl=0930d0 <d_lookup>
}
    3188:=09a94153f3 =09ldp=09x19, x20, [sp, #16]
    318c:=09a8c27bfd =09ldp=09x29, x30, [sp], #32
    3190:=09d65f03c0 =09ret
=09=09=09return ERR_PTR(err);
    3194:=0993407c00 =09sxtw=09x0, w0
    3198:=0917fffffc =09b=093188 <d_hash_and_lookup+0x50>
    319c:=09d503201f =09nop

Disassembly of section .text.unlikely:

0000000000000000 <dump>:
{
   0:=09a9bc7bfd =09stp=09x29, x30, [sp, #-64]!
   4:=09910003fd =09mov=09x29, sp
   8:=09a90153f3 =09stp=09x19, x20, [sp, #16]
   c:=09a9025bf5 =09stp=09x21, x22, [sp, #32]
  10:=09f9001bf7 =09str=09x23, [sp, #48]
=09if (!dentry) {
  14:=09b50000a0 =09cbnz=09x0, 28 <dump+0x28>
=09=09printk(KERN_ERR "list fucked in head");
  18:=0990000000 =09adrp=09x0, 0 <dump>
  1c:=0991000000 =09add=09x0, x0, #0x0
  20:=0994000000 =09bl=090 <printk>
=09=09return;
  24:=0914000016 =09b=097c <dump+0x7c>
=09printk(KERN_ERR "fucked dentry[%p]: d_hash.next =3D %p, flags =3D %x, coun=
t =3D=20
%d",
  28:=09aa0003f3 =09mov=09x19, x0
=09=09printk(KERN_CONT "%c%02x", i & 31 ? ' ' : '\n',
  2c:=0990000015 =09adrp=09x21, 0 <dump>
=09printk(KERN_ERR "fucked dentry[%p]: d_hash.next =3D %p, flags =3D %x, coun=
t =3D=20
%d",
  30:=0990000000 =09adrp=09x0, 0 <dump>
  34:=09aa1303e1 =09mov=09x1, x19
  38:=0991000000 =09add=09x0, x0, #0x0
  3c:=09d2800014 =09mov=09x20, #0x0                   =09// #0
  40:=09b9400263 =09ldr=09w3, [x19]
=09=09printk(KERN_CONT "%c%02x", i & 31 ? ' ' : '\n',
  44:=0952800157 =09mov=09w23, #0xa                   =09// #10
=09printk(KERN_ERR "fucked dentry[%p]: d_hash.next =3D %p, flags =3D %x, coun=
t =3D=20
%d",
  48:=09b9405e64 =09ldr=09w4, [x19, #92]
=09=09printk(KERN_CONT "%c%02x", i & 31 ? ' ' : '\n',
  4c:=0952800416 =09mov=09w22, #0x20                  =09// #32
=09printk(KERN_ERR "fucked dentry[%p]: d_hash.next =3D %p, flags =3D %x, coun=
t =3D=20
%d",
  50:=09f9400662 =09ldr=09x2, [x19, #8]
=09=09printk(KERN_CONT "%c%02x", i & 31 ? ' ' : '\n',
  54:=09910002b5 =09add=09x21, x21, #0x0
=09printk(KERN_ERR "fucked dentry[%p]: d_hash.next =3D %p, flags =3D %x, coun=
t =3D=20
%d",
  58:=0994000000 =09bl=090 <printk>
=09=09printk(KERN_CONT "%c%02x", i & 31 ? ' ' : '\n',
  5c:=0938746a62 =09ldrb=09w2, [x19, x20]
  60:=09f240129f =09tst=09x20, #0x1f
  64:=091a9602e1 =09csel=09w1, w23, w22, eq  // eq =3D none
  68:=0991000694 =09add=09x20, x20, #0x1
  6c:=09aa1503e0 =09mov=09x0, x21
  70:=0994000000 =09bl=090 <printk>
=09for (i =3D 0; i < sizeof(struct dentry); i++)
  74:=09f103029f =09cmp=09x20, #0xc0
  78:=0954ffff21 =09b.ne=095c <dump+0x5c>  // b.any
}
  7c:=09a94153f3 =09ldp=09x19, x20, [sp, #16]
  80:=09a9425bf5 =09ldp=09x21, x22, [sp, #32]
  84:=09f9401bf7 =09ldr=09x23, [sp, #48]
  88:=09a8c47bfd =09ldp=09x29, x30, [sp], #64
  8c:=09d65f03c0 =09ret

