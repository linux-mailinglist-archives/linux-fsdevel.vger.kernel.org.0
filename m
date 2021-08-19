Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E2F3F1B05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 15:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240321AbhHSN6c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 09:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240170AbhHSN6N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 09:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629381452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FeQUTOQZFedjwKHUiIdbPnfehFdeVRFseWj/JjhYKq0=;
        b=JmWxT7YhtCO75/aOFP0y3fWdp2Ec65mWTeaWxI14YTP1gzq7wBT5VRRMJlUlMs8yxBUazs
        2hSJnZ5B9mr7BD0ur7uIZePFrDixD+Y8YbUmHuRAt6hCyjRAKTVvirrCG2eHf8FMvikzVl
        SBotARnxBp2KTZ9OweezBFAArmLLz60=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-m-lWQ13-N0qUjwA2FfQJCg-1; Thu, 19 Aug 2021 09:57:31 -0400
X-MC-Unique: m-lWQ13-N0qUjwA2FfQJCg-1
Received: by mail-wr1-f72.google.com with SMTP id x18-20020a5d49120000b0290154e9dcf3dbso1722171wrq.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Aug 2021 06:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FeQUTOQZFedjwKHUiIdbPnfehFdeVRFseWj/JjhYKq0=;
        b=k5Cfo7EFDq0DJB//sNvWDhdkmyRLXjdkvlYVufVyH0jnGNg7Y0VGHsGJziTY8QJuCa
         acHvLzhCjOLAChJrO7xNzDjqrM3qiirl6474cmS1PlB3QuMc8csuoGEItgLfLa8Gk09P
         eWjeqXCQClPPlQSyD2ypPDu3LInhYfX6G36bHNv8+gmL13gpdk3iEcNhoxr5bY7GfO+J
         S7ewkoRrQbGtNevX8HWZNBb0gCfxnlQtTNigIX01Yjn6ZHKP8WmrxsqGoofiwRl8NXUJ
         FLInWGuVSBMgLgzmr9brN/OGp036wg+4ihVo2lZB69TD8N+Ux0yYTIGbfF+/3JQS0Rup
         9cTg==
X-Gm-Message-State: AOAM530EPe3SkZKLoX97ZpD8tsBslCPfriCLutrIpGOgIAI3FDmmWc6h
        sIna6QumXH6D9Bp02yPmP3hM//OM7NntXyTNQD776l298A6ua3Ti4xUrBlPw9uqE9tvnzoTarmE
        3PcXFmKdo7FOiPmDgADkqsTcu4g==
X-Received: by 2002:adf:e746:: with SMTP id c6mr3970182wrn.276.1629381450024;
        Thu, 19 Aug 2021 06:57:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPnPPiuPzwm8tAhF9mEQ0DkA/msxGcayzoUv7cKBC+BcIMzN4u6pCJ7sEyf0pjKKrp3rXIVw==
X-Received: by 2002:adf:e746:: with SMTP id c6mr3970164wrn.276.1629381449837;
        Thu, 19 Aug 2021 06:57:29 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net. [82.29.237.198])
        by smtp.gmail.com with ESMTPSA id j7sm7793993wmi.37.2021.08.19.06.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 06:57:29 -0700 (PDT)
Date:   Thu, 19 Aug 2021 14:57:27 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [Virtio-fs] [virtiofsd PATCH v4 3/4] virtiofsd: support per-file
 DAX negotiation in FUSE_INIT
Message-ID: <YR5jRwVNeZfZVLh3@work-vm>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-4-jefflexu@linux.alibaba.com>
 <YRvuzrRo2t2SyQk/@work-vm>
 <e6426e51-7a2c-57a1-8d7b-3cb0cff89fb9@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6426e51-7a2c-57a1-8d7b-3cb0cff89fb9@linux.alibaba.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* JeffleXu (jefflexu@linux.alibaba.com) wrote:
> 
> 
> On 8/18/21 1:15 AM, Dr. David Alan Gilbert wrote:
> > * Jeffle Xu (jefflexu@linux.alibaba.com) wrote:
> >> In FUSE_INIT negotiating phase, server/client should advertise if it
> >> supports per-file DAX.
> >>
> >> Once advertising support for per-file DAX feature, virtiofsd should
> >> support storing FS_DAX_FL flag persistently passed by
> >> FS_IOC_SETFLAGS/FS_IOC_FSSETXATTR ioctl, and set FUSE_ATTR_DAX in
> >> FUSE_LOOKUP accordingly if the file is capable of per-file DAX.
> >>
> >> Currently only ext4/xfs since linux kernel v5.8 support storing
> >> FS_DAX_FL flag persistently, and thus advertise support for per-file
> >> DAX feature only when the backend fs type is ext4 and xfs.
> > 
> > I'm a little worried about the meaning of the flags we're storing and
> > the fact we're storing them in the normal host DAX flags.
> > 
> > Doesn't this mean that we're using a single host flag to mean:
> >   a) It can be mapped as DAX on the host if it was a real DAX device
> >   b) We can map it as DAX inside the guest with virtiofs?
> 
> Yes the side effect is that the host file is also dax enabled if the
> backend fs is built upon real nvdimm device.
> 
> The rationale here is that, fuse daemon shall be capable of *marking*
> the file as dax capable *persistently*, so that it can be informed that
> this file is capable of dax later.

Right, so my worry here is that the untrusted guest changes both it's
own behaviour (fine) and also the behaviour of the host (less fine).

> I'm not sure if xattr (extent attribute) is a better option for this?

Well, if you used an xattr for it, it wouldn't clash with whatever the
host did (especially if it used the xattr mapping).

Dave

> 
> > 
> > what happens when we're using usernamespaces for the guest?
> > 
> > Dave
> > 
> > 
> >> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> >> ---
> >>  tools/virtiofsd/fuse_common.h    |  5 +++++
> >>  tools/virtiofsd/fuse_lowlevel.c  |  6 ++++++
> >>  tools/virtiofsd/passthrough_ll.c | 29 +++++++++++++++++++++++++++++
> >>  3 files changed, 40 insertions(+)
> >>
> >> diff --git a/tools/virtiofsd/fuse_common.h b/tools/virtiofsd/fuse_common.h
> >> index 8a75729be9..ee6fc64c23 100644
> >> --- a/tools/virtiofsd/fuse_common.h
> >> +++ b/tools/virtiofsd/fuse_common.h
> >> @@ -372,6 +372,11 @@ struct fuse_file_info {
> >>   */
> >>  #define FUSE_CAP_HANDLE_KILLPRIV_V2 (1 << 28)
> >>  
> >> +/**
> >> + * Indicates support for per-file DAX.
> >> + */
> >> +#define FUSE_CAP_PERFILE_DAX (1 << 29)
> >> +
> >>  /**
> >>   * Ioctl flags
> >>   *
> >> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
> >> index 50fc5c8d5a..04a4f17423 100644
> >> --- a/tools/virtiofsd/fuse_lowlevel.c
> >> +++ b/tools/virtiofsd/fuse_lowlevel.c
> >> @@ -2065,6 +2065,9 @@ static void do_init(fuse_req_t req, fuse_ino_t nodeid,
> >>      if (arg->flags & FUSE_HANDLE_KILLPRIV_V2) {
> >>          se->conn.capable |= FUSE_CAP_HANDLE_KILLPRIV_V2;
> >>      }
> >> +    if (arg->flags & FUSE_PERFILE_DAX) {
> >> +        se->conn.capable |= FUSE_CAP_PERFILE_DAX;
> >> +    }
> >>  #ifdef HAVE_SPLICE
> >>  #ifdef HAVE_VMSPLICE
> >>      se->conn.capable |= FUSE_CAP_SPLICE_WRITE | FUSE_CAP_SPLICE_MOVE;
> >> @@ -2180,6 +2183,9 @@ static void do_init(fuse_req_t req, fuse_ino_t nodeid,
> >>      if (se->conn.want & FUSE_CAP_POSIX_ACL) {
> >>          outarg.flags |= FUSE_POSIX_ACL;
> >>      }
> >> +    if (se->op.ioctl && (se->conn.want & FUSE_CAP_PERFILE_DAX)) {
> >> +        outarg.flags |= FUSE_PERFILE_DAX;
> >> +    }
> >>      outarg.max_readahead = se->conn.max_readahead;
> >>      outarg.max_write = se->conn.max_write;
> >>      if (se->conn.max_background >= (1 << 16)) {
> >> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> >> index e170b17adb..5b6228210f 100644
> >> --- a/tools/virtiofsd/passthrough_ll.c
> >> +++ b/tools/virtiofsd/passthrough_ll.c
> >> @@ -53,8 +53,10 @@
> >>  #include <sys/syscall.h>
> >>  #include <sys/wait.h>
> >>  #include <sys/xattr.h>
> >> +#include <sys/vfs.h>
> >>  #include <syslog.h>
> >>  #include <linux/fs.h>
> >> +#include <linux/magic.h>
> >>  
> >>  #include "qemu/cutils.h"
> >>  #include "passthrough_helpers.h"
> >> @@ -136,6 +138,13 @@ enum {
> >>      SANDBOX_CHROOT,
> >>  };
> >>  
> >> +/* capability of storing DAX flag persistently */
> >> +enum {
> >> +    DAX_CAP_NONE,  /* not supported */
> >> +    DAX_CAP_FLAGS, /* stored in flags (FS_IOC_GETFLAGS/FS_IOC_SETFLAGS) */
> >> +    DAX_CAP_XATTR, /* stored in xflags (FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR) */
> >> +};
> >> +
> >>  typedef struct xattr_map_entry {
> >>      char *key;
> >>      char *prepend;
> >> @@ -161,6 +170,7 @@ struct lo_data {
> >>      int readdirplus_clear;
> >>      int allow_direct_io;
> >>      int announce_submounts;
> >> +    int perfile_dax_cap; /* capability of backend fs */
> >>      bool use_statx;
> >>      struct lo_inode root;
> >>      GHashTable *inodes; /* protected by lo->mutex */
> >> @@ -703,6 +713,10 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)
> >>          conn->want &= ~FUSE_CAP_HANDLE_KILLPRIV_V2;
> >>          lo->killpriv_v2 = 0;
> >>      }
> >> +
> >> +    if (conn->capable & FUSE_CAP_PERFILE_DAX && lo->perfile_dax_cap ) {
> >> +        conn->want |= FUSE_CAP_PERFILE_DAX;
> >> +    }
> >>  }
> >>  
> >>  static void lo_getattr(fuse_req_t req, fuse_ino_t ino,
> >> @@ -3800,6 +3814,7 @@ static void setup_root(struct lo_data *lo, struct lo_inode *root)
> >>      int fd, res;
> >>      struct stat stat;
> >>      uint64_t mnt_id;
> >> +    struct statfs statfs;
> >>  
> >>      fd = open("/", O_PATH);
> >>      if (fd == -1) {
> >> @@ -3826,6 +3841,20 @@ static void setup_root(struct lo_data *lo, struct lo_inode *root)
> >>          root->posix_locks = g_hash_table_new_full(
> >>              g_direct_hash, g_direct_equal, NULL, posix_locks_value_destroy);
> >>      }
> >> +
> >> +    /*
> >> +     * Currently only ext4/xfs since linux kernel v5.8 support storing
> >> +     * FS_DAX_FL flag persistently. Ext4 accesses this flag through
> >> +     * FS_IOC_G[S]ETFLAGS ioctl, while xfs accesses this flag through
> >> +     * FS_IOC_FSG[S]ETXATTR ioctl.
> >> +     */
> >> +    res = fstatfs(fd, &statfs);
> >> +    if (!res) {
> >> +	if (statfs.f_type == EXT4_SUPER_MAGIC)
> >> +	    lo->perfile_dax_cap = DAX_CAP_FLAGS;
> >> +	else if (statfs.f_type == XFS_SUPER_MAGIC)
> >> +	    lo->perfile_dax_cap = DAX_CAP_XATTR;
> >> +    }
> >>  }
> >>  
> >>  static guint lo_key_hash(gconstpointer key)
> >> -- 
> >> 2.27.0
> >>
> >> _______________________________________________
> >> Virtio-fs mailing list
> >> Virtio-fs@redhat.com
> >> https://listman.redhat.com/mailman/listinfo/virtio-fs
> >>
> 
> -- 
> Thanks,
> Jeffle
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

