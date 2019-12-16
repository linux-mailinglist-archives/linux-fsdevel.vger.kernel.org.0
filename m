Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFAF512018C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 10:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfLPJyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 04:54:03 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:52663 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfLPJyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:54:03 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MD9Ox-1iXkew36Cv-009CBO; Mon, 16 Dec 2019 10:53:32 +0100
Subject: Re: [PATCH v8 0/1] ns: introduce binfmt_misc namespace
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, Greg Kurz <groug@kaod.org>,
        Jann Horn <jannh@google.com>, Andrei Vagin <avagin@gmail.com>,
        linux-api@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Henning Schild <henning.schild@siemens.com>,
        =?UTF-8?Q?C=c3=a9dric_Le_Goate?= =?UTF-8?Q?r?= <clg@kaod.org>,
        keescook@chromium.org
References: <20191216091220.465626-1-laurent@vivier.eu>
 <20191216094615.xlhxoze3umjn2tzy@wittgenstein>
From:   Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4225d0e8-a907-941f-69ae-c2a9150e6a98@vivier.eu>
Date:   Mon, 16 Dec 2019 10:53:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216094615.xlhxoze3umjn2tzy@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FFFoybimB6XVIlsujiQo2NcFWKKYMunC74lXSAW62F39Nf/djKR
 svJJHjNCLnvV2zuN55zBS4jQWZLi0WGtfMNeq4x4ie6S9q4hN3cZTvS5Rd0reb5LspLYsjG
 1Vxnieyin0tdHddySNU7cmpVe29eKBwPj2IDVmp2fFKhuxMODam+VPUDZs6uZTzfFfdrlh1
 PQJUIEwOArvqm9t5F1m+w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gJLtl58NCaI=:3g+Aygy4VcO07qgiyavroV
 nEwVnx7t6hMPzi/SuA5c04AqcAQOoXrrZJwzA3NRUMhr3FyNsHMkCzQv4tPQx8i6vyrwCz4H/
 Nk88qc54fkXatCPDKwuBuqrguGKR3x2Pt1WBb2UDS4cURP9knRd4hzIDqswqMrmrZlfJN+uTi
 i03iDmcQGtMYTiIB7/aQz7mDvR/4ykNDGnVnePXPMrYKjcmqoARhV7l2lg4DgWDWKcQQaspBr
 5le6dyrRfps9BYjZsVVU5NyOWiNw6AxiGk1wTrQU3G1hziFHvKkxKMXWmtTJXVU16JvAetCzr
 5pUcRSOQaJy/zjN5DOkXagf2zbSQx+J8liV5Tc+4yo3Kp3GWjE96tidlYKiXGFmDIAkMGaibB
 tEs8A8pD+Ja1LuXroaf/jcg1AKFlFOsRWIvNHqx6uO7kP+q1FHQQyK4IMcSRP6oRMQ0uW+YPW
 i5iP8r/AS+JxmuV2jBzLZL1wnzryaoHdI5xokzvaJyhlAXLCTZ1UOYDBw0HmA44YKV9fDISaH
 lCDgrMZFD1Vr2mq2Ie5eXhM6CX7jZgQccXaoPx4DIcYKbWFlV0VbaJFQheus7vQzONThtVVIV
 muQgdSeBI+IeEePDSRm6Nw56hkJEFsbv8if18JF+mhDE7Kc6jS8L6adL3AfJ21PP1W4aEe7T0
 mNDCvX4wmfMeZjLDzB0Tvgxa6kATBfvTeosq/Dy75mbQJ0k5zaAEXfRDpwQ2mA/vFhN1r1Nji
 U0LyaVonkNSd4Iij6+2cg3INgbrFgpkRl5snz+c4mJQku7GzIcEhJvosa+FvEpwV/joTS9oL1
 8kLcD752Sgm4VnihbPk1g3d1fwlvDw/d7HYQeAGMdQEGUs/HKis7j6Tf+idgNApMaKDZkFggP
 M/UHXXi5Rqrprtul+nA+ewlu3oHqeL7PEIv0R3i5c=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Le 16/12/2019 à 10:46, Christian Brauner a écrit :
> On Mon, Dec 16, 2019 at 10:12:19AM +0100, Laurent Vivier wrote:
>> v8: s/file->f_path.dentry/file_dentry(file)/
>>
>> v7: Use the new mount API
>>
>>     Replace
>>
>>       static struct dentry *bm_mount(struct file_system_type *fs_type,
>>                             int flags, const char *dev_name, void *data)
>>       {
>>                struct user_namespace *ns = current_user_ns();
>>
>>                return mount_ns(fs_type, flags, data, ns, ns,
>>                                bm_fill_super);
>>       }
>>
>>     by
>>
>>       static void bm_free(struct fs_context *fc)
>>       {
>>              if (fc->s_fs_info)
>>                      put_user_ns(fc->s_fs_info);
>>       }
>>
>>       static int bm_get_tree(struct fs_context *fc)
>>       {
>>               return get_tree_keyed(fc, bm_fill_super, get_user_ns(fc->user_ns));
>>       }
>>
>>       static const struct fs_context_operations bm_context_ops = {
>>               .free           = bm_free,
>>               .get_tree       = bm_get_tree,
>>       };
>>
>>       static int bm_init_fs_context(struct fs_context *fc)
>>       {
>>               fc->ops = &bm_context_ops;
>>               return 0;
>>       }
>>
>> v6: Return &init_binfmt_ns instead of NULL in binfmt_ns()
>>     This should never happen, but to stay safe return a
>>     value we can use.
>>     change subject from "RFC" to "PATCH"
>>
>> v5: Use READ_ONCE()/WRITE_ONCE()
>>     move mount pointer struct init to bm_fill_super() and add smp_wmb()
>>     remove useless NULL value init
>>     add WARN_ON_ONCE()
>>
>> v4: first user namespace is initialized with &init_binfmt_ns,
>>     all new user namespaces are initialized with a NULL and use
>>     the one of the first parent that is not NULL. The pointer
>>     is initialized to a valid value the first time the binfmt_misc
>>     fs is mounted in the current user namespace.
>>     This allows to not change the way it was working before:
>>     new ns inherits values from its parent, and if parent value is modified
>>     (or parent creates its own binfmt entry by mounting the fs) child
>>     inherits it (unless it has itself mounted the fs).
>>
>> v3: create a structure to store binfmt_misc data,
>>     add a pointer to this structure in the user_namespace structure,
>>     in init_user_ns structure this pointer points to an init_binfmt_ns
>>     structure. And all new user namespaces point to this init structure.
>>     A new binfmt namespace structure is allocated if the binfmt_misc
>>     filesystem is mounted in a user namespace that is not the initial
>>     one but its binfmt namespace pointer points to the initial one.
>>     add override_creds()/revert_creds() around open_exec() in
>>     bm_register_write()
>>
>> v2: no new namespace, binfmt_misc data are now part of
>>     the mount namespace
>>     I put this in mount namespace instead of user namespace
>>     because the mount namespace is already needed and
>>     I don't want to force to have the user namespace for that.
>>     As this is a filesystem, it seems logic to have it here.
>>
>> This allows to define a new interpreter for each new container.
>>
>> But the main goal is to be able to chroot to a directory
>> using a binfmt_misc interpreter without being root.
>>
>> I have a modified version of unshare at:
>>
>>   https://github.com/vivier/util-linux.git branch unshare-chroot
>>
>> with some new options to unshare binfmt_misc namespace and to chroot
>> to a directory.
>>
>> If you have a directory /chroot/powerpc/jessie containing debian for powerpc
>> binaries and a qemu-ppc interpreter, you can do for instance:
>>
>>  $ uname -a
>>  Linux fedora28-wor-2 4.19.0-rc5+ #18 SMP Mon Oct 1 00:32:34 CEST 2018 x86_64 x86_64 x86_64 GNU/Linux
>>  $ ./unshare --map-root-user --fork --pid \
>>    --load-interp ":qemu-ppc:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff:/qemu-ppc:OC" \
>>    --root=/chroot/powerpc/jessie /bin/bash -l
>>  # uname -a
>>  Linux fedora28-wor-2 4.19.0-rc5+ #18 SMP Mon Oct 1 00:32:34 CEST 2018 ppc GNU/Linux
>>  # id
>> uid=0(root) gid=0(root) groups=0(root),65534(nogroup)
>>  # ls -l
>> total 5940
>> drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:58 bin
>> drwxr-xr-x.   2 nobody nogroup    4096 Jun 17 20:26 boot
>> drwxr-xr-x.   4 nobody nogroup    4096 Aug 12 00:08 dev
>> drwxr-xr-x.  42 nobody nogroup    4096 Sep 28 07:25 etc
>> drwxr-xr-x.   3 nobody nogroup    4096 Sep 28 07:25 home
>> drwxr-xr-x.   9 nobody nogroup    4096 Aug 12 00:58 lib
>> drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:08 media
>> drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:08 mnt
>> drwxr-xr-x.   3 nobody nogroup    4096 Aug 12 13:09 opt
>> dr-xr-xr-x. 143 nobody nogroup       0 Sep 30 23:02 proc
>> -rwxr-xr-x.   1 nobody nogroup 6009712 Sep 28 07:22 qemu-ppc
>> drwx------.   3 nobody nogroup    4096 Aug 12 12:54 root
>> drwxr-xr-x.   3 nobody nogroup    4096 Aug 12 00:08 run
>> drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:58 sbin
>> drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:08 srv
>> drwxr-xr-x.   2 nobody nogroup    4096 Apr  6  2015 sys
>> drwxrwxrwt.   2 nobody nogroup    4096 Sep 28 10:31 tmp
>> drwxr-xr-x.  10 nobody nogroup    4096 Aug 12 00:08 usr
>> drwxr-xr-x.  11 nobody nogroup    4096 Aug 12 00:08 var
>>
>> If you want to use the qemu binary provided by your distro, you can use
>>
>>     --load-interp ":qemu-ppc:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff:/bin/qemu-ppc-static:OCF"
>>
>> With the 'F' flag, qemu-ppc-static will be then loaded from the main root
>> filesystem before switching to the chroot.
>>
>> Another example is to use the 'P' flag in one chroot and not in another one (useful in a test
>> environment to test different configurations of the same interpreter):
>>
>> ./unshare --fork --pid --mount-proc --map-root-user --load-interp ":qemu-ppc:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff://usr/bin/qemu-ppc-noargv0:OCF" --root=/chroot/powerpc/jessie /bin/bash -l
>> root@localhost:/# sh -c 'echo $0'
>> /bin/sh
>>
>> ./unshare --fork --pid --mount-proc --map-root-user --load-interp ":qemu-ppc:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff://usr/bin/qemu-ppc-argv0:OCFP" --root=/chroot/powerpc/jessie /bin/bash -l
>> root@localhost:/# sh -c 'echo $0'
>> sh
> 
> Hey Laurent,
> 
> We have quite some time before the v5.6 merge window opens. So I would
> really like for this new feature to come with proper testing!

Are there some already existing tests for binfmt_misc or namespace I can
update to test the new feature?

Thanks,
Laurent

