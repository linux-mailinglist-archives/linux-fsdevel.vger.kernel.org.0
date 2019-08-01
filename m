Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D02C7D241
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 02:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfHAA2H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 20:28:07 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35822 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfHAA2H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 20:28:07 -0400
Received: by mail-lf1-f65.google.com with SMTP id p197so48766399lfa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2019 17:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Qo57YVgQ/jqVaTJY+4qvKgXudMAE+6INmZnvwnczwQ=;
        b=IdgS7cdcTnOnIWJj3ZQPqlOMt0spHV9UhxisLETZiv/4LyNwPaXXDYtydLscG4zjIT
         xKP7IcDA38yPj8guQFOON0d77h/8M8witMEIRQxbT3P7lpdpywBZ8rAeLg3o2+WnEnIk
         HBv6v82Syznq+6VKNmx4xLsC5VbDxHbfXG7LpKTgxr1yEdvDHr3GZTAazNlIVeWt4Al9
         QiTG8Ohgczrk/sFED4tJtmDMjWNY6QFz3ts7u1TLXsLjWLRZFy3lRzirDys/XrmtH0Sw
         5nY3Gg2qRd2MgUKCcuzIsqHbETT37G1fv7lKUpku67csf6zJnfQ+d5Ad44PNo+m5R9RT
         wpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Qo57YVgQ/jqVaTJY+4qvKgXudMAE+6INmZnvwnczwQ=;
        b=Z/8FZ38pjjvlPFTFbjoXB+ClqMchNxWff3TIm2xMv7YL5R6SrcMNGS77s71BtJyfPX
         MUWsUVHr2asNVS0omYa6EcLN2qzAwO+lMQrqE+0oabZy8O6fhCbBKELgSDR5JUri6o8p
         Y8Ubh1uodaDQXw59QYwhnF6F3NJlQqP3iaTczpZ0NXOfQEeacnIGD5x4fEPL4cy5Ajp6
         cs7R2JwfosMW3qcH3k5H9ogXuWfk7bjX6H8CQhvtuw6JLUCIAx+HiNsabExwQLuWrK+9
         SAOpIKphJjZkcEuu/jKdG1eo0EzkPKlAlcQtc2gVNvZN1ldRrNxpSbD1lvEREn5yh+9Q
         poJQ==
X-Gm-Message-State: APjAAAU/rXw5tSaasrIeV/v3yRknW6Baaw3SU1V1ICDwpDubpIUIpjXP
        zrzmTgC5UwO1CX3RavzYcmDob2NY/tIa4cr+tQ==
X-Google-Smtp-Source: APXvYqx+bZ/SeGJIjDvBw92XUDDBl6YPemrbXccDXvsW5Atp4C9sU0hyEjEYX3B4gPa+3DgI5NFAc0l9N+0IdrZlcVg=
X-Received: by 2002:ac2:4c37:: with SMTP id u23mr45044586lfq.119.1564619284203;
 Wed, 31 Jul 2019 17:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190731153443.4984-1-acgoide@tycho.nsa.gov> <1c62c931-9441-4264-c119-d038b2d0c9b9@schaufler-ca.com>
In-Reply-To: <1c62c931-9441-4264-c119-d038b2d0c9b9@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 31 Jul 2019 20:27:53 -0400
Message-ID: <CAHC9VhS6cfMw5ZUkOSov6hexh9QpnpKwipP7L7ZYGCVLCHGfFQ@mail.gmail.com>
Subject: Re: [PATCH] fanotify, inotify, dnotify, security: add security hook
 for fs notifications
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Aaron Goidel <acgoide@tycho.nsa.gov>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com, jack@suse.cz,
        amir73il@gmail.com, James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 31, 2019 at 1:26 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 7/31/2019 8:34 AM, Aaron Goidel wrote:
> > As of now, setting watches on filesystem objects has, at most, applied a
> > check for read access to the inode, and in the case of fanotify, requires
> > CAP_SYS_ADMIN. No specific security hook or permission check has been
> > provided to control the setting of watches. Using any of inotify, dnotify,
> > or fanotify, it is possible to observe, not only write-like operations, but
> > even read access to a file. Modeling the watch as being merely a read from
> > the file is insufficient for the needs of SELinux. This is due to the fact
> > that read access should not necessarily imply access to information about
> > when another process reads from a file. Furthermore, fanotify watches grant
> > more power to an application in the form of permission events. While
> > notification events are solely, unidirectional (i.e. they only pass
> > information to the receiving application), permission events are blocking.
> > Permission events make a request to the receiving application which will
> > then reply with a decision as to whether or not that action may be
> > completed. This causes the issue of the watching application having the
> > ability to exercise control over the triggering process. Without drawing a
> > distinction within the permission check, the ability to read would imply
> > the greater ability to control an application. Additionally, mount and
> > superblock watches apply to all files within the same mount or superblock.
> > Read access to one file should not necessarily imply the ability to watch
> > all files accessed within a given mount or superblock.
> >
> > In order to solve these issues, a new LSM hook is implemented and has been
> > placed within the system calls for marking filesystem objects with inotify,
> > fanotify, and dnotify watches. These calls to the hook are placed at the
> > point at which the target path has been resolved and are provided with the
> > path struct, the mask of requested notification events, and the type of
> > object on which the mark is being set (inode, superblock, or mount). The
> > mask and obj_type have already been translated into common FS_* values
> > shared by the entirety of the fs notification infrastructure. The path
> > struct is passed rather than just the inode so that the mount is available,
> > particularly for mount watches. This also allows for use of the hook by
> > pathname-based security modules. However, since the hook is intended for
> > use even by inode based security modules, it is not placed under the
> > CONFIG_SECURITY_PATH conditional. Otherwise, the inode-based security
> > modules would need to enable all of the path hooks, even though they do not
> > use any of them.
> >
> > This only provides a hook at the point of setting a watch, and presumes
> > that permission to set a particular watch implies the ability to receive
> > all notification about that object which match the mask. This is all that
> > is required for SELinux. If other security modules require additional hooks
> > or infrastructure to control delivery of notification, these can be added
> > by them. It does not make sense for us to propose hooks for which we have
> > no implementation. The understanding that all notifications received by the
> > requesting application are all strictly of a type for which the application
> > has been granted permission shows that this implementation is sufficient in
> > its coverage.
> >
> > Security modules wishing to provide complete control over fanotify must
> > also implement a security_file_open hook that validates that the access
> > requested by the watching application is authorized. Fanotify has the issue
> > that it returns a file descriptor with the file mode specified during
> > fanotify_init() to the watching process on event. This is already covered
> > by the LSM security_file_open hook if the security module implements
> > checking of the requested file mode there. Otherwise, a watching process
> > can obtain escalated access to a file for which it has not been authorized.
> >
> > The selinux_path_notify hook implementation works by adding five new file
> > permissions: watch, watch_mount, watch_sb, watch_reads, and watch_with_perm
> > (descriptions about which will follow), and one new filesystem permission:
> > watch (which is applied to superblock checks). The hook then decides which
> > subset of these permissions must be held by the requesting application
> > based on the contents of the provided mask and the obj_type. The
> > selinux_file_open hook already checks the requested file mode and therefore
> > ensures that a watching process cannot escalate its access through
> > fanotify.
> >
> > The watch, watch_mount, and watch_sb permissions are the baseline
> > permissions for setting a watch on an object and each are a requirement for
> > any watch to be set on a file, mount, or superblock respectively. It should
> > be noted that having either of the other two permissions (watch_reads and
> > watch_with_perm) does not imply the watch, watch_mount, or watch_sb
> > permission. Superblock watches further require the filesystem watch
> > permission to the superblock. As there is no labeled object in view for
> > mounts, there is no specific check for mount watches beyond watch_mount to
> > the inode. Such a check could be added in the future, if a suitable labeled
> > object existed representing the mount.
> >
> > The watch_reads permission is required to receive notifications from
> > read-exclusive events on filesystem objects. These events include accessing
> > a file for the purpose of reading and closing a file which has been opened
> > read-only. This distinction has been drawn in order to provide a direct
> > indication in the policy for this otherwise not obvious capability. Read
> > access to a file should not necessarily imply the ability to observe read
> > events on a file.
> >
> > Finally, watch_with_perm only applies to fanotify masks since it is the
> > only way to set a mask which allows for the blocking, permission event.
> > This permission is needed for any watch which is of this type. Though
> > fanotify requires CAP_SYS_ADMIN, this is insufficient as it gives implicit
> > trust to root, which we do not do, and does not support least privilege.
> >
> > Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
>
> I can't say that I accept your arguments that this is sufficient,
> but as you point out, the SELinux team does, and if I want more
> for Smack that's my fish to fry.
>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Thanks Aaron.  Thanks Casey.

I think we also want an ACK from the other LSMs, what say all of you?
Can you live with the new security_path_notify() hook?

Aaron, you'll also need to put together a test for the
selinux-testsuite to exercise this code.  If you already sent it to
the list, my apologies but I don't see it anywhere.  If you get stuck
on the test, let me know and I'll try to help out.

Oh, one more thing ...

> > +static int selinux_path_notify(const struct path *path, u64 mask,
> > +                                             unsigned int obj_type)
> > +{
> > +     int ret;
> > +     u32 perm;
> > +
> > +     struct common_audit_data ad;
> > +
> > +     ad.type = LSM_AUDIT_DATA_PATH;
> > +     ad.u.path = *path;
> > +
> > +     /*
> > +      * Set permission needed based on the type of mark being set.
> > +      * Performs an additional check for sb watches.
> > +      */
> > +     switch (obj_type) {
> > +     case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
> > +             perm = FILE__WATCH_MOUNT;
> > +             break;
> > +     case FSNOTIFY_OBJ_TYPE_SB:
> > +             perm = FILE__WATCH_SB;
> > +             ret = superblock_has_perm(current_cred(), path->dentry->d_sb,
> > +                                             FILESYSTEM__WATCH, &ad);
> > +             if (ret)
> > +                     return ret;
> > +             break;
> > +     case FSNOTIFY_OBJ_TYPE_INODE:
> > +             perm = FILE__WATCH;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     // check if the mask is requesting ability to set a blocking watch

... in the future please don't use "// XXX", use "/* XXX */" instead :)

Don't respin the patch just for this, but if you have to do it for
some other reason please fix the C++ style comments.  Thanks.

> > +     if (mask & (ALL_FSNOTIFY_PERM_EVENTS))
> > +             perm |= FILE__WATCH_WITH_PERM; // if so, check that permission
> > +
> > +     // is the mask asking to watch file reads?
> > +     if (mask & (FS_ACCESS | FS_ACCESS_PERM | FS_CLOSE_NOWRITE))
> > +             perm |= FILE__WATCH_READS; // check that permission as well
> > +
> > +     return path_has_perm(current_cred(), path, perm);
> > +}

-- 
paul moore
www.paul-moore.com
