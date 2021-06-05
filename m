Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E00739C937
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jun 2021 16:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhFEOuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Jun 2021 10:50:09 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:42498 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFEOuI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Jun 2021 10:50:08 -0400
Received: by mail-lf1-f43.google.com with SMTP id a2so18479723lfc.9;
        Sat, 05 Jun 2021 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wcvtrW5lKa338/Gad0nAXWl+Nu1ItOkpV4wMx5SbYls=;
        b=eCmRc8D6ZLbg8C1E6TDq1ZK6LVFbjiJFW37TZeSC5qmi8UG5eVRzUslI9+GVew5OiJ
         GqvidqxCHJcZrieOSifsVG5oSD//uT8ybTeMdZlLddFA0zKKp1TQo3M7FdfEEWzDX5QU
         npraqwJu70RvL3YfDl2i8qm/3LA2edTJop68vHlMGNaMA8iPkP5cBTIte6728Leum0SZ
         Zuugjv72+4/a/pOMvizWUgslsRCzve1fmLaV3+0UGHXS3niYOM+zIEAwm2aiXVGwhwtf
         Cg746iV2LKa/oRViJnGhAYtWxcB1vV5dWhK09heCFN9dW8byjNLH9+JFJfyDHRVo+cUX
         F+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wcvtrW5lKa338/Gad0nAXWl+Nu1ItOkpV4wMx5SbYls=;
        b=ZzrjNRCigpsoK0oU9gclfyGPn/ZK7l5rxIEL9IzOMpsoIMxEE/1MB+BFP3YXjHWOs+
         czUnk0kc53eBvEYdWNkRon2jS5/JkgC1TysQqnsuVGAPqh5lXfWUBSlAxaKuqPTZCqlV
         CrzlwrLWFIlZ9sJlcefVjQuAdcwKp+Tochyw0mdnVgJSqNZ3Kni76JyPIAiv+C/8We3Q
         t249dQgVw4Liz9+pxzjH90I8UX14Yf6/toPZDDxXr6bqMOHYvFMx7U4FfdLWkOrdAFEi
         zqtN6mtBqN/f3WmW9JEUi0D6DmMHQZycPZwD+A2erurf/UW2GejqrP9b7b7bQ7zlxd/5
         KHtw==
X-Gm-Message-State: AOAM530o7M1K11YSiN+XhdbBdigMtvsJh337luXvu0TnShNJw4hm7hfP
        O3r+Nky2gybr2ve1mspjkcHJb/17CRk4A4Qh+Ow=
X-Google-Smtp-Source: ABdhPJxF6LDHm5m+1SkC49jJYcji06gTtk1MoV8nzCkDrHpP1ynqMSAe9m4zSYSigkxinVfYiggyjfcAoiYR4PXp5BY=
X-Received: by 2002:ac2:548d:: with SMTP id t13mr5994474lfk.568.1622904439398;
 Sat, 05 Jun 2021 07:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210605034447.92917-1-dong.menglong@zte.com.cn>
 <20210605034447.92917-3-dong.menglong@zte.com.cn> <20210605115019.umjumoasiwrclcks@wittgenstein>
In-Reply-To: <20210605115019.umjumoasiwrclcks@wittgenstein>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Sat, 5 Jun 2021 22:47:07 +0800
Message-ID: <CADxym3bs1r_+aPk9Z_5Y7QBBV_RzUbW9PUqSLB7akbss_dJi_g@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] init/do_mounts.c: create second mount for initramfs
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, johan@kernel.org,
        ojeda@kernel.org, jeyu@kernel.org, masahiroy@kernel.org,
        joe@perches.com, Menglong Dong <dong.menglong@zte.com.cn>,
        Jan Kara <jack@suse.cz>, hare@suse.de,
        Jens Axboe <axboe@kernel.dk>, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org,
        NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Barret Rhoden <brho@google.com>, f.fainelli@gmail.com,
        palmerdabbelt@google.com, wangkefeng.wang@huawei.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, vbabka@suse.cz,
        Alexander Potapenko <glider@google.com>, pmladek@suse.com,
        johannes.berg@intel.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, jojing64@gmail.com,
        terrelln@fb.com, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>, arnd@arndb.de,
        Chris Down <chris@chrisdown.name>, mingo@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Sat, Jun 5, 2021 at 7:50 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Sat, Jun 05, 2021 at 11:44:47AM +0800, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <dong.menglong@zte.com.cn>
> >
> > If using container platforms such as Docker, upon initialization it
> > wants to use pivot_root() so that currently mounted devices do not
> > propagate to containers. An example of value in this is that
> > a USB device connected prior to the creation of a containers on the
> > host gets disconnected after a container is created; if the
> > USB device was mounted on containers, but already removed and
> > umounted on the host, the mount point will not go away until all
> > containers unmount the USB device.
> >
> > Another reason for container platforms such as Docker to use pivot_root
> > is that upon initialization the net-namspace is mounted under
> > /var/run/docker/netns/ on the host by dockerd. Without pivot_root
> > Docker must either wait to create the network namespace prior to
> > the creation of containers or simply deal with leaking this to each
> > container.
> >
> > pivot_root is supported if the rootfs is a initrd or block device, but
> > it's not supported if the rootfs uses an initramfs (tmpfs). This means
> > container platforms today must resort to using block devices if
> > they want to pivot_root from the rootfs. A workaround to use chroot()
> > is not a clean viable option given every container will have a
> > duplicate of every mount point on the host.
> >
> > In order to support using container platforms such as Docker on
> > all the supported rootfs types we must extend Linux to support
> > pivot_root on initramfs as well. This patch does the work to do
> > just that.
> >
> > pivot_root will unmount the mount of the rootfs from its parent mount
> > and mount the new root to it. However, when it comes to initramfs, it
> > donesn't work, because the root filesystem has not parent mount, which
> > makes initramfs not supported by pivot_root.
> >
> > In order to make pivot_root supported on initramfs, we create a second
> > mount with type of rootfs before unpacking cpio, and change root to
> > this mount after unpacking.
> >
> > While mounting the second rootfs, 'rootflags' is passed, and it means
> > that we can set options for the mount of rootfs in boot cmd now.
> > For example, the size of tmpfs can be set with 'rootflags=size=1024M'.
> >
> > Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
> > ---
> >  init/do_mounts.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >  init/do_mounts.h | 17 ++++++++++++++++-
> >  init/initramfs.c |  8 ++++++++
> >  usr/Kconfig      | 10 ++++++++++
> >  4 files changed, 78 insertions(+), 1 deletion(-)
> >
> > diff --git a/init/do_mounts.c b/init/do_mounts.c
> > index a78e44ee6adb..715bdaa89b81 100644
> > --- a/init/do_mounts.c
> > +++ b/init/do_mounts.c
> > @@ -618,6 +618,49 @@ void __init prepare_namespace(void)
> >  }
> >
> >  static bool is_tmpfs;
> > +#ifdef CONFIG_INITRAMFS_MOUNT
> > +
> > +/*
> > + * Give systems running from the initramfs and making use of pivot_root a
> > + * proper mount so it can be umounted during pivot_root.
> > + */
> > +int __init prepare_mount_rootfs(void)
> > +{
> > +     char *rootfs = "ramfs";
> > +
> > +     if (is_tmpfs)
> > +             rootfs = "tmpfs";
> > +
> > +     return do_mount_root(rootfs, rootfs,
> > +                          root_mountflags & ~MS_RDONLY,
> > +                          root_mount_data);
> > +}
> > +
> > +/*
> > + * Revert to previous mount by chdir to '/' and unmounting the second
> > + * mount.
> > + */
> > +void __init revert_mount_rootfs(void)
> > +{
> > +     init_chdir("/");
> > +     init_umount(".", MNT_DETACH);
> > +}
> > +
> > +/*
> > + * Change root to the new rootfs that mounted in prepare_mount_rootfs()
> > + * if cpio is unpacked successfully and 'ramdisk_execute_command' exist.
> > + */
> > +void __init finish_mount_rootfs(void)
> > +{
> > +     init_mount(".", "/", NULL, MS_MOVE, NULL);
> > +     if (likely(ramdisk_exec_exist()))
> > +             init_chroot(".");
> > +     else
> > +             revert_mount_rootfs();
> > +}
> > +
> > +#define rootfs_init_fs_context ramfs_init_fs_context
>
> Sorry, I think we're nearly there. What's the rationale for using ramfs
> when unconditionally when a separate mount for initramfs is requested?
> Meaning, why do we need this define at all?

I think it's necessary, as I explained in the third patch. When the rootfs
is a block device, ramfs is used in init_mount_tree() unconditionally,
which can be seen from the enable of is_tmpfs.

That makes sense, because rootfs will not become the root if a block
device is specified by 'root' in boot cmd, so it makes no sense to use
tmpfs, because ramfs is more simple.

Here, I make rootfs as ramfs for the same reason: the first mount is not
used as the root, so make it ramfs which is more simple.

Thanks!
Menglong Dong

>
> > +#else
> >  static int rootfs_init_fs_context(struct fs_context *fc)
> >  {
> >       if (IS_ENABLED(CONFIG_TMPFS) && is_tmpfs)
> > @@ -625,6 +668,7 @@ static int rootfs_init_fs_context(struct fs_context *fc)
> >
> >       return ramfs_init_fs_context(fc);
> >  }
> > +#endif
> >
> >  struct file_system_type rootfs_fs_type = {
> >       .name           = "rootfs",
> > diff --git a/init/do_mounts.h b/init/do_mounts.h
> > index 7a29ac3e427b..ae4ab306caa9 100644
> > --- a/init/do_mounts.h
> > +++ b/init/do_mounts.h
> > @@ -10,9 +10,24 @@
> >  #include <linux/root_dev.h>
> >  #include <linux/init_syscalls.h>
> >
> > +extern int root_mountflags;
> > +
> >  void  mount_block_root(char *name, int flags);
> >  void  mount_root(void);
> > -extern int root_mountflags;
> > +
> > +#ifdef CONFIG_INITRAMFS_MOUNT
> > +
> > +int  prepare_mount_rootfs(void);
> > +void finish_mount_rootfs(void);
> > +void revert_mount_rootfs(void);
> > +
> > +#else
> > +
> > +static inline int  prepare_mount_rootfs(void) { return 0; }
> > +static inline void finish_mount_rootfs(void) { }
> > +static inline void revert_mount_rootfs(void) { }
> > +
> > +#endif
> >
> >  static inline __init int create_dev(char *name, dev_t dev)
> >  {
> > diff --git a/init/initramfs.c b/init/initramfs.c
> > index af27abc59643..1833de3cf04e 100644
> > --- a/init/initramfs.c
> > +++ b/init/initramfs.c
> > @@ -16,6 +16,8 @@
> >  #include <linux/namei.h>
> >  #include <linux/init_syscalls.h>
> >
> > +#include "do_mounts.h"
> > +
> >  static ssize_t __init xwrite(struct file *file, const char *p, size_t count,
> >               loff_t *pos)
> >  {
> > @@ -682,13 +684,19 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
> >       else
> >               printk(KERN_INFO "Unpacking initramfs...\n");
> >
> > +     if (prepare_mount_rootfs())
> > +             panic("Failed to mount rootfs");
> > +
> >       err = unpack_to_rootfs((char *)initrd_start, initrd_end - initrd_start);
> >       if (err) {
> > +             revert_mount_rootfs();
> >  #ifdef CONFIG_BLK_DEV_RAM
> >               populate_initrd_image(err);
> >  #else
> >               printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
> >  #endif
> > +     } else {
> > +             finish_mount_rootfs();
> >       }
> >
> >  done:
> > diff --git a/usr/Kconfig b/usr/Kconfig
> > index 8bbcf699fe3b..4f6ac12eafe9 100644
> > --- a/usr/Kconfig
> > +++ b/usr/Kconfig
> > @@ -52,6 +52,16 @@ config INITRAMFS_ROOT_GID
> >
> >         If you are not sure, leave it set to "0".
> >
> > +config INITRAMFS_MOUNT
> > +     bool "Create second mount to make pivot_root() supported"
> > +     default y
> > +     help
> > +       Before unpacking cpio, create a second mount and make it become
> > +       the root filesystem. Therefore, initramfs will be supported by
> > +       pivot_root().
> > +
> > +       If container platforms is used with initramfs, say Y.
> > +
> >  config RD_GZIP
> >       bool "Support initial ramdisk/ramfs compressed using gzip"
> >       default y
> > --
> > 2.32.0.rc0
> >
