Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6B13EF25F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 21:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhHQTBE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 15:01:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229821AbhHQTBE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629226830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Iol1jsgRv0ziz0DpHk2d1tnxir1N5aalgKy4jW+5WM=;
        b=dNxhra94TFq09xxaLKsHjOzIvuOVWltF3RYnjRkHFwnGGUTUYk63MXK/OM5TKCu0lUDr6X
        hhHHgfLHFDBOhhJ24sXS+fh847qbgIX27LsZWITEtz6J/+dm30GabVYRk0Ll18uICftLeu
        M36E29xk7ql/wlGXECIISzaoygPQhxs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-L4OrXaZuP-CRWD1DO56EOA-1; Tue, 17 Aug 2021 15:00:26 -0400
X-MC-Unique: L4OrXaZuP-CRWD1DO56EOA-1
Received: by mail-wm1-f72.google.com with SMTP id u15-20020a05600c210fb02902e6a5231792so63787wml.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 12:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Iol1jsgRv0ziz0DpHk2d1tnxir1N5aalgKy4jW+5WM=;
        b=NlTBUT+jwlpXozOEOUnGf6aWezdaJIihkV6CskKEqZbLs20o9yr+iWx+7e6KlKVQnM
         WRMM26mgNVebXNfZiZLmA/YNKMyLDndSB+OlJEvPHSa2ZN8lJHoPkRo5NOlOUzo6HOHG
         R0eBt2EiehBd0x6AUpdfHfXiU9m1tYivsPOB52kBQSf6K8HEN16aJUlw2o7RNgFfaG0C
         qh6nC9mFlc/NhSMiW64vo3JUiyoJKYXaeAtToJ8l5l2ExYdnytk+edePAhgBJdwimYJ4
         pLFWQMCEn9P3ulTVhD0a6WrBn4bCIQTUCB7jry+yEUnIkUUn7j7gPcMLl+9nkn2oLqC5
         sWVQ==
X-Gm-Message-State: AOAM533mrYmsvOxC4P+Prcrs34gwKGsezpeK0e/BaSAj9KKsSL3rJp+F
        9wGHA+44uTbbAw6tV35g52YPpbmswfmJuOxYdceaqMulmKizoO7miL4ne6j7xbOdjKOsYJ38o/q
        au/JlXX4ruD2hPSLP++xVEhrGpA==
X-Received: by 2002:a05:600c:2150:: with SMTP id v16mr1685665wml.143.1629226825467;
        Tue, 17 Aug 2021 12:00:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxusOQ+cZFh3y+xg/zSlKlSeE6vAgPMd91vC/vS1jIhfmj0ZcVTZCPWMnEslMdG8fY06LwZ+w==
X-Received: by 2002:a05:600c:2150:: with SMTP id v16mr1685648wml.143.1629226825276;
        Tue, 17 Aug 2021 12:00:25 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net. [82.29.237.198])
        by smtp.gmail.com with ESMTPSA id z7sm2887942wmi.4.2021.08.17.12.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 12:00:24 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:00:22 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [Virtio-fs] [virtiofsd PATCH v4 4/4] virtiofsd: support per-file
 DAX in FUSE_LOOKUP
Message-ID: <YRwHRmL/jUSqgkIU@work-vm>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-5-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817022347.18098-5-jefflexu@linux.alibaba.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Jeffle Xu (jefflexu@linux.alibaba.com) wrote:
> For passthrough, when the corresponding virtiofs in guest is mounted
> with '-o dax=inode', advertise that the file is capable of per-file
> DAX if the inode in the backend fs is marked with FS_DAX_FL flag.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 43 ++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 5b6228210f..4cbd904248 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -171,6 +171,7 @@ struct lo_data {
>      int allow_direct_io;
>      int announce_submounts;
>      int perfile_dax_cap; /* capability of backend fs */
> +    bool perfile_dax; /* enable per-file DAX or not */
>      bool use_statx;
>      struct lo_inode root;
>      GHashTable *inodes; /* protected by lo->mutex */
> @@ -716,6 +717,10 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)
>  
>      if (conn->capable & FUSE_CAP_PERFILE_DAX && lo->perfile_dax_cap ) {
>          conn->want |= FUSE_CAP_PERFILE_DAX;
> +	lo->perfile_dax = 1;
> +    }
> +    else {
> +	lo->perfile_dax = 0;
>      }
>  }
>  
> @@ -983,6 +988,41 @@ static int do_statx(struct lo_data *lo, int dirfd, const char *pathname,
>      return 0;
>  }
>  
> +/*
> + * If the file is marked with FS_DAX_FL or FS_XFLAG_DAX, then DAX should be
> + * enabled for this file.
> + */
> +static bool lo_should_enable_dax(struct lo_data *lo, struct lo_inode *dir,
> +				 const char *name)
> +{
> +    int res, fd;
> +    int ret = false;;
> +    unsigned int attr;
> +    struct fsxattr xattr;
> +
> +    if (!lo->perfile_dax)
> +	return false;
> +
> +    /* Open file without O_PATH, so that ioctl can be called. */
> +    fd = openat(dir->fd, name, O_NOFOLLOW);
> +    if (fd == -1)
> +        return false;

Doesn't that defeat the whole benefit of using O_PATH - i.e. that we
might stumble into a /dev node or something else we're not allowed to
open?

> +    if (lo->perfile_dax_cap == DAX_CAP_FLAGS) {
> +        res = ioctl(fd, FS_IOC_GETFLAGS, &attr);
> +        if (!res && (attr & FS_DAX_FL))
> +	    ret = true;
> +    }
> +    else if (lo->perfile_dax_cap == DAX_CAP_XATTR) {
> +	res = ioctl(fd, FS_IOC_FSGETXATTR, &xattr);
> +	if (!res && (xattr.fsx_xflags & FS_XFLAG_DAX))
> +	    ret = true;
> +    }

This all looks pretty expensive for each lookup.

Dave


> +    close(fd);
> +    return ret;
> +}
> +
>  /*
>   * Increments nlookup on the inode on success. unref_inode_lolocked() must be
>   * called eventually to decrement nlookup again. If inodep is non-NULL, the
> @@ -1038,6 +1078,9 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *name,
>          e->attr_flags |= FUSE_ATTR_SUBMOUNT;
>      }
>  
> +    if (lo_should_enable_dax(lo, dir, name))
> +	e->attr_flags |= FUSE_ATTR_DAX;
> +
>      inode = lo_find(lo, &e->attr, mnt_id);
>      if (inode) {
>          close(newfd);
> -- 
> 2.27.0
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://listman.redhat.com/mailman/listinfo/virtio-fs
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

