Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B522F30CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 15:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389061AbfKGOFE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 09:05:04 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:52169 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731026AbfKGOFD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:05:03 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mm9NA-1i2Q7I1kGG-00iFxf; Thu, 07 Nov 2019 15:03:08 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        Henning Schild <henning.schild@siemens.com>,
        linux-fsdevel@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-api@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Greg Kurz <groug@kaod.org>, Jann Horn <jannh@google.com>,
        containers@lists.linux-foundation.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v7 0/1] ns: introduce binfmt_misc namespace
Date:   Thu,  7 Nov 2019 15:03:03 +0100
Message-Id: <20191107140304.8426-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0IwXS9kWgl1NDLJnpYU5E4zYGksXQUFaoNqObTDgVP9i2eJp0zU
 WqOBiib9Sq5I1nUr+awL7KR6l2r6voh+hZFKeGTcjC5xyG81OA1swTYDDK7ROPw5DsZpCXM
 LqAB5hq27/lM9QACO0m2TVKjLhfBaAg5KbZlflHpu7MRgruiqYt73IIDwvKTM3r1LQ6eoIh
 oTeNAvQIanFLWVbsuRdDA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TPwyDjY6Xrg=:UMk3rylYd9788c9inykdop
 oHAasjgwholgOJgMPeRCsQPYWfiEhq++ZKAXuvYbasncJVPlY6h2Ibi/l3RiZb32Vnj+93dMd
 p/LyuAmnwnvIKGkLpWoJNA2ryVAMFucJcANHi/ewaGIlEaqxsa8I4AaVanoCQkhUlmUBElRhJ
 dYhRC0Nq9p1z0gk/Ypa6zVhLlILdsTJdG5RVQmM/AbZct3gsGnzHVSwWKIPTUqq6tG1k5tw7j
 OLZD35eJpEu6Rsdon2zOEP82fZvF/YoSG+D7EVn+OnwLtRGnN7AzyRPw2M5zUIDM/R9xgYWJE
 clJmQ0BI/BA56QX8kkaVcHzwK9rlybvA6EC1AkyhL4Ph1H7tw6F/kyHBuSaJbjTdSJqv2N0ax
 dZnEn2y4OCyQ3/eOK36RVXpqIr+DpIVzfRwRy5boifWn2Hs4h51yZA7bCB4Uqg1IIHAdfMbGp
 3W0L7OAlJngtEM+CbKRla30s8wNHiLL6kF4D8GweWJQmJQrzfdY7fFZLwD9tOlhlpdiP516bZ
 C+pELMnREzMcMscVVHG79SW5yM/kikqDt/tiyihMjq3qSbaWxyXqHthpPKMGd8bdV05iXoeIx
 +CYYY4uPREk0BnVle1QCk59N0Ud37CTfV3oir0iGOcRh+CVYCxu6Jf+Z1GCYNtDyEtmvJbIx7
 38c774PF3C0OzA5vbWJAWkdU4Tc5ITtbu5jz+7c7ZJPUTJHcy+ZMlpM7Lkeoq1XYU0oX6K3HD
 1SkS0y/ktv4/vCUu8EvDGuVSCFxTXioQe+6ziGw3P/+/w3iMBx2eAa9lK7MIG39jEuwTWGsT2
 wnmLrZIm++SQ/yCUrOa3yN8o3hpnoOYeZj/cwhAzvhlqiG/9ff6YGWfaz6umHyhpsDmDlFFgb
 pU7Wi85Viy/JHMnqIlumyzRSMA2TDvUuh1nwu7vPQOSLuDXFnK/IXy6voMF6Gxo7zV2C8s0x7
 o7M6s9AOzqfAwD5XNS7Lel6JyMszhKvdUpGp0Lmjv4TV7N8ftuUDqLi+1iR7e7V4TvvoMK47y
 oEjSpoV++NdDMg8peJAB6t+/z/qk7APOCMwgcIWOVVbwPZQ7qKP+P6/W1jIbROeq4umMNC1lF
 J7d2owV8aDQ9lI=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v7: Use the new mount API

    Replace

      static struct dentry *bm_mount(struct file_system_type *fs_type,
                            int flags, const char *dev_name, void *data)
      {
               struct user_namespace *ns = current_user_ns();

               return mount_ns(fs_type, flags, data, ns, ns,
                               bm_fill_super);
      }

    by

      static void bm_free(struct fs_context *fc)
      {
             if (fc->s_fs_info)
                     put_user_ns(fc->s_fs_info);
      }

      static int bm_get_tree(struct fs_context *fc)
      {
              return get_tree_keyed(fc, bm_fill_super, get_user_ns(fc->user_ns));
      }

      static const struct fs_context_operations bm_context_ops = {
              .free           = bm_free,
              .get_tree       = bm_get_tree,
      };

      static int bm_init_fs_context(struct fs_context *fc)
      {
              fc->ops = &bm_context_ops;
              return 0;
      }

v6: Return &init_binfmt_ns instead of NULL in binfmt_ns()
    This should never happen, but to stay safe return a
    value we can use.
    change subject from "RFC" to "PATCH"

v5: Use READ_ONCE()/WRITE_ONCE()
    move mount pointer struct init to bm_fill_super() and add smp_wmb()
    remove useless NULL value init
    add WARN_ON_ONCE()

v4: first user namespace is initialized with &init_binfmt_ns,
    all new user namespaces are initialized with a NULL and use
    the one of the first parent that is not NULL. The pointer
    is initialized to a valid value the first time the binfmt_misc
    fs is mounted in the current user namespace.
    This allows to not change the way it was working before:
    new ns inherits values from its parent, and if parent value is modified
    (or parent creates its own binfmt entry by mounting the fs) child
    inherits it (unless it has itself mounted the fs).

v3: create a structure to store binfmt_misc data,
    add a pointer to this structure in the user_namespace structure,
    in init_user_ns structure this pointer points to an init_binfmt_ns
    structure. And all new user namespaces point to this init structure.
    A new binfmt namespace structure is allocated if the binfmt_misc
    filesystem is mounted in a user namespace that is not the initial
    one but its binfmt namespace pointer points to the initial one.
    add override_creds()/revert_creds() around open_exec() in
    bm_register_write()

v2: no new namespace, binfmt_misc data are now part of
    the mount namespace
    I put this in mount namespace instead of user namespace
    because the mount namespace is already needed and
    I don't want to force to have the user namespace for that.
    As this is a filesystem, it seems logic to have it here.

This allows to define a new interpreter for each new container.

But the main goal is to be able to chroot to a directory
using a binfmt_misc interpreter without being root.

I have a modified version of unshare at:

  https://github.com/vivier/util-linux.git branch unshare-chroot

with some new options to unshare binfmt_misc namespace and to chroot
to a directory.

If you have a directory /chroot/powerpc/jessie containing debian for powerpc
binaries and a qemu-ppc interpreter, you can do for instance:

 $ uname -a
 Linux fedora28-wor-2 4.19.0-rc5+ #18 SMP Mon Oct 1 00:32:34 CEST 2018 x86_64 x86_64 x86_64 GNU/Linux
 $ ./unshare --map-root-user --fork --pid \
   --load-interp ":qemu-ppc:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff:/qemu-ppc:OC" \
   --root=/chroot/powerpc/jessie /bin/bash -l
 # uname -a
 Linux fedora28-wor-2 4.19.0-rc5+ #18 SMP Mon Oct 1 00:32:34 CEST 2018 ppc GNU/Linux
 # id
uid=0(root) gid=0(root) groups=0(root),65534(nogroup)
 # ls -l
total 5940
drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:58 bin
drwxr-xr-x.   2 nobody nogroup    4096 Jun 17 20:26 boot
drwxr-xr-x.   4 nobody nogroup    4096 Aug 12 00:08 dev
drwxr-xr-x.  42 nobody nogroup    4096 Sep 28 07:25 etc
drwxr-xr-x.   3 nobody nogroup    4096 Sep 28 07:25 home
drwxr-xr-x.   9 nobody nogroup    4096 Aug 12 00:58 lib
drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:08 media
drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:08 mnt
drwxr-xr-x.   3 nobody nogroup    4096 Aug 12 13:09 opt
dr-xr-xr-x. 143 nobody nogroup       0 Sep 30 23:02 proc
-rwxr-xr-x.   1 nobody nogroup 6009712 Sep 28 07:22 qemu-ppc
drwx------.   3 nobody nogroup    4096 Aug 12 12:54 root
drwxr-xr-x.   3 nobody nogroup    4096 Aug 12 00:08 run
drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:58 sbin
drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:08 srv
drwxr-xr-x.   2 nobody nogroup    4096 Apr  6  2015 sys
drwxrwxrwt.   2 nobody nogroup    4096 Sep 28 10:31 tmp
drwxr-xr-x.  10 nobody nogroup    4096 Aug 12 00:08 usr
drwxr-xr-x.  11 nobody nogroup    4096 Aug 12 00:08 var

If you want to use the qemu binary provided by your distro, you can use

    --load-interp ":qemu-ppc:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff:/bin/qemu-ppc-static:OCF"

With the 'F' flag, qemu-ppc-static will be then loaded from the main root
filesystem before switching to the chroot.

Another example is to use the 'P' flag in one chroot and not in another one (useful in a test
environment to test different configurations of the same interpreter):

./unshare --fork --pid --mount-proc --map-root-user --load-interp ":qemu-ppc:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff://usr/bin/qemu-ppc-noargv0:OCF" --root=/chroot/powerpc/jessie /bin/bash -l
root@localhost:/# sh -c 'echo $0'
/bin/sh

./unshare --fork --pid --mount-proc --map-root-user --load-interp ":qemu-ppc:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff://usr/bin/qemu-ppc-argv0:OCFP" --root=/chroot/powerpc/jessie /bin/bash -l
root@localhost:/# sh -c 'echo $0'
sh

Laurent Vivier (1):
  ns: add binfmt_misc to the user namespace

 fs/binfmt_misc.c               | 115 +++++++++++++++++++++++++--------
 include/linux/user_namespace.h |  15 +++++
 kernel/user.c                  |  14 ++++
 kernel/user_namespace.c        |   3 +
 4 files changed, 119 insertions(+), 28 deletions(-)

-- 
2.21.0

