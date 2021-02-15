Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F88231B9C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 13:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhBOMuk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 07:50:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52998 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230474AbhBOMtx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613393295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o0gxwj2+g3c7UHTxk8t1iz6Y9lODvwtRrJuA4yHHYtQ=;
        b=Q29BJEspf7xzJwewHJFYnf+K3ArRaeg+h2PPf0Y48/LAlz57DRc/Tu66NBxlYVvqt0XjrH
        8PLWMaQHiXcs5C/5126Rbf8KRXzzaOucH17J5aooE5oRF4GbBivJ/7nB4tD9VE1vZsrzFp
        1wnnMFsI7l6NiO8TixTJtYKC+tK3Uo4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-SoBvPlAjP1WT7pFVZDmtJA-1; Mon, 15 Feb 2021 07:48:12 -0500
X-MC-Unique: SoBvPlAjP1WT7pFVZDmtJA-1
Received: by mail-qv1-f71.google.com with SMTP id bx8so184102qvb.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Feb 2021 04:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o0gxwj2+g3c7UHTxk8t1iz6Y9lODvwtRrJuA4yHHYtQ=;
        b=snqzKDxJ5BvNF8v6SpMdP5accjEv/aItu3l7+L6JfwdtDb7htD8AAZUYVIAKE6EzCn
         8/Wo28xqmuU1QZsdm774/Md/j40mIGBL7+FD701VtQMetdfbtv08duM1Dgq4+HLXC5TA
         3oIsqwSOllfAEDFs/uVQApAJsYhplDy9fR1u0EIgnfY4v9p9xqPjnDRTc4q0UtjaLWTr
         YYjp+sraFKtkK4MIDJjhRchc+UXMcE3OISQYgMUGX0/MHL7abp0ImMn49m5N/PELBS/f
         mYFYsOkLQM7UCKUGwqPxqnxE0Gxs90ruTI7W/YRFjsZrgjvhI0ol7TJx6RqjY8z5wwY5
         J6hw==
X-Gm-Message-State: AOAM5316Is1wjVvW5b0jtJQ0pm40zbqnDieSItyNK1q3i0wmPkM4UWeT
        0jk7cna1s+1XQtclo88mGxQnCZgZ5KD8hYsjBc4XIzXcG761ygp0lg/yUp7dlM7xTJqj+maWQeX
        dslptnsG4L3td/FRVW5Y+VCa8lZQ8GAD/KXA4+EVa1Q==
X-Received: by 2002:a05:622a:201:: with SMTP id b1mr13884590qtx.237.1613393291962;
        Mon, 15 Feb 2021 04:48:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgfzgHnMRSu9edLZDtSXWRE6hsbRpj+i+v7wJ+PHw5+h9rZoOrWLLEM6uynGPLrduioKa0W8BSa+dTKt/ElkY=
X-Received: by 2002:a05:622a:201:: with SMTP id b1mr13884578qtx.237.1613393291712;
 Mon, 15 Feb 2021 04:48:11 -0800 (PST)
MIME-Version: 1.0
References: <20210215113051.GD2087@kadam>
In-Reply-To: <20210215113051.GD2087@kadam>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 15 Feb 2021 13:48:00 +0100
Message-ID: <CAOssrKdWgEfSMRmHtNnK3H7jtVt1ovTeCkh2AmkDAS3FdRHpkw@mail.gmail.com>
Subject: Re: [fuse:fs_fuse_split 5/5] fs/fuse/virtio_fs.c:1458
 virtio_fs_get_tree() error: uninitialized symbol 'fc'.
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dan,

Thanks for the report.

Note that the mailing list for fuse kernel development is
<linux-fsdevel@vger.kernel.org> as indicated in MAINTAINERS, while
<fuse-devel@lists.sourceforge.net> is for userspace development.

On Mon, Feb 15, 2021 at 12:31 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git fs_fuse_split
> head:   674d5faded4c40245ea02240e731aa82c7ab4c9e
> commit: 674d5faded4c40245ea02240e731aa82c7ab4c9e [5/5] fuse: alloc initial fuse_conn and fuse_mount
> config: i386-randconfig-m021-20210209 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> New smatch warnings:
> fs/fuse/virtio_fs.c:1458 virtio_fs_get_tree() error: uninitialized symbol 'fc'.
>
> Old smatch warnings:
> fs/fuse/virtio_fs.c:1444 virtio_fs_get_tree() error: double free of 'fm'
>
> vim +/fc +1458 fs/fuse/virtio_fs.c
>
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1405  static int virtio_fs_get_tree(struct fs_context *fsc)
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1406  {
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1407         struct virtio_fs *fs;
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1408         struct super_block *sb;
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1409         struct fuse_conn *fc;
> fcee216beb9c15 Max Reitz       2020-05-06  1410         struct fuse_mount *fm;
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1411         int err;
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1412
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1413         /* This gets a reference on virtio_fs object. This ptr gets installed
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1414          * in fc->iq->priv. Once fuse_conn is going away, it calls ->put()
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1415          * to drop the reference to this object.
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1416          */
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1417         fs = virtio_fs_find_instance(fsc->source);
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1418         if (!fs) {
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1419                 pr_info("virtio-fs: tag <%s> not found\n", fsc->source);
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1420                 return -EINVAL;
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1421         }
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1422
> 833c5a42e28bee Miklos Szeredi  2020-11-11  1423         err = -ENOMEM;
> 674d5faded4c40 Miklos Szeredi  2021-02-11  1424         fm = fuse_conn_new(get_user_ns(current_user_ns()), &virtio_fs_fiq_ops, fs, NULL, NULL);
> 833c5a42e28bee Miklos Szeredi  2020-11-11  1425         if (!fm)
> 833c5a42e28bee Miklos Szeredi  2020-11-11  1426                 goto out_err;
>
> "fc" not initialized on this path.

Yep, thanks.

>
> 674d5faded4c40 Miklos Szeredi  2021-02-11  1427         fc = fm->fc;
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1428         fc->delete_stale = true;
> bf109c64040f5b Max Reitz       2020-04-21  1429         fc->auto_submounts = true;
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1430
> fcee216beb9c15 Max Reitz       2020-05-06  1431         fsc->s_fs_info = fm;
> b19d3d00d662cf Miklos Szeredi  2020-11-11  1432         sb = sget_fc(fsc, virtio_fs_test_super, set_anon_super_fc);
> 514b5e3ff45e6c Miklos Szeredi  2020-11-11  1433         if (fsc->s_fs_info) {
> 514b5e3ff45e6c Miklos Szeredi  2020-11-11  1434                 fuse_conn_put(fc);
> 514b5e3ff45e6c Miklos Szeredi  2020-11-11  1435                 kfree(fm);
>
> The error handling in this function is very confusing...

fsc->s_fs_info is non-NULL if sget_fc() didn't take ownership of the
object.  Which can be an error, or it can be the case of an existing
sb being reused.

Needs a comment.  Will do in a separate patch.

> 514b5e3ff45e6c Miklos Szeredi  2020-11-11  1436         }
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1437         if (IS_ERR(sb))
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1438                 return PTR_ERR(sb);
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1439
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1440         if (!sb->s_root) {
> 1dd539577c42b6 Vivek Goyal     2020-08-19  1441                 err = virtio_fs_fill_super(sb, fsc);
> a62a8ef9d97da2 Stefan Hajnoczi 2018-06-12  1442                 if (err) {
> 514b5e3ff45e6c Miklos Szeredi  2020-11-11  1443                         fuse_conn_put(fc);
> 514b5e3ff45e6c Miklos Szeredi  2020-11-11  1444                         kfree(fm);
>
> Smatch doesn't complain about a double free so presumably the earlier
> kfree(fm) is done IFF sb is an error pointer.

Correct, !sb->s_root implies that this is a new sb, not a reused one
(in which case the earlier kfree() would trigger).

Thanks,
Miklos

