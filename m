Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1B411856
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 13:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfEBLqh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 07:46:37 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34594 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfEBLqh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 07:46:37 -0400
Received: by mail-yw1-f67.google.com with SMTP id u14so1319038ywe.1;
        Thu, 02 May 2019 04:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jcBWOdKL4HM/5gs4c1naDvVj+y0UvTNyJvldP+RZuLU=;
        b=YPwIGZG6R8/FHkEfbb10H6h7MXPFJKKCpFppbkLgu5/NkiWY8lGn+CxuKnRkBVGi1u
         1xIDiL+Gx5Umn1JV92T06sf774OfUTapy6s1B/pUZDqChAJ5AaaTCDJBo6KNoyD00E4e
         lA/XkmZPvx1bqInfL5AxUx4VXqLk+IuDV/CGWNoobAxf/3uz7IhF9JaGWpBc3Ds+dcWI
         BvRvm4YUgspx+ry95hkF+743T1RIf4ICA5bJwMHE9QUUCtct60lMX+Tbic9Q3y0e8csu
         /Fu9f2dcGM6+DXDB+SH9kXRJ2cW5e46Hv3UfXBOM0SAQfqm1kHoi76eHC6jiW5bL8LRq
         XVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcBWOdKL4HM/5gs4c1naDvVj+y0UvTNyJvldP+RZuLU=;
        b=iKXy23aqfNYSukgBM3xWBi99+Rc+GQJFyGJq1b00+Xiawb+PBtT9Fc55EKiUBYtbnS
         kzvoRixI8R4eEuS8mRlyzhaLxklxqXcbup3GDsotU1gJ1SjaSppbvhrLvv/CjbQRiEcg
         mXY/un6zfEzX2xwy8y3n99jNBXZF5ORMDYyyihZQKbL3zNta+I+DEVHYvGvqHV6cvpQ2
         Z+GV0Dy1gwEgXYTIav8aFQU5IpQwMF2dNA1dj0QOOD2Boh5b1trdgK2c2r+V+AfHEKul
         7IyFAlOe9j9ab9E9JkZhwYtGYyNyp0sYl1e1hcT/at5JafM2Xy9kq0b1rrYp76ZXh5An
         Boeg==
X-Gm-Message-State: APjAAAWADWHgmEr6LgMlgEGbCBNqE0PSO6V1MxuS58dA/eA9Zj5Xtq7+
        F0Vkqg+Al146kguvKtCU6x5ZXKyWcQNG89DImsU=
X-Google-Smtp-Source: APXvYqxOfXWXJ7hpacnqd3cjaM2qO/7GdpaVENgE1LUX5ufb85Rr1U9YIHTn6PAb1kXavD+KmYtxpL26e+lE3X6MhyY=
X-Received: by 2002:a25:b883:: with SMTP id w3mr2641606ybj.337.1556797595677;
 Thu, 02 May 2019 04:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpeguwUtRWRGmNmimNp-FXzWqMCCQMb24iWPu0w_J0_rOnnw@mail.gmail.com>
 <20161205151933.GA17517@fieldses.org> <CAJfpegtpkavseTFLspaC7svbvHRq-0-7jvyh63+DK5iWHTGnaQ@mail.gmail.com>
 <20161205162559.GB17517@fieldses.org> <CAHpGcMKHjic6L+J0qvMYNG9hVCcDO1hEpx4BiEk0ZCKDV39BmA@mail.gmail.com>
 <266c571f-e4e2-7c61-5ee2-8ece0c2d06e9@web.de> <CAHpGcMKmtppfn7PVrGKEEtVphuLV=YQ2GDYKOqje4ZANhzSgDw@mail.gmail.com>
 <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com>
 <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com>
 <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com>
 <20161206185806.GC31197@fieldses.org> <87bm0l4nra.fsf@notabene.neil.brown.name>
 <8736lx4goa.fsf@notabene.neil.brown.name>
In-Reply-To: <8736lx4goa.fsf@notabene.neil.brown.name>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 2 May 2019 07:46:24 -0400
Message-ID: <CAOQ4uxgREaBznnr-jNy-g1oX2gH6dXx9zj8wrs5JBJuVMv_9Pw@mail.gmail.com>
Subject: Re: [PATCH] OVL: add honoracl=off mount option.
To:     NeilBrown <neilb@suse.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        Patrick Plagwitz <Patrick_Plagwitz@web.de>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 2, 2019 at 12:35 AM NeilBrown <neilb@suse.com> wrote:
>
>
> If the upper and lower layers use incompatible ACL formats, it is not
> possible to copy the ACL xttr from one to the other, so overlayfs
> cannot work with them.
> This happens particularly with NFSv4 which uses system.nfs4_acl, and
> ext4 which uses system.posix_acl_access.
>
> If all ACLs actually make to Unix permissions, then there is no need
> to copy up the ACLs, but overlayfs cannot determine this.
>
> So allow the sysadmin it assert that ACLs are not needed with a mount
> option
>   honoracl=off
> This causes the ACLs to not be copied, so filesystems with different
> ACL formats can be overlaid together.
>
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  Documentation/filesystems/overlayfs.txt | 24 ++++++++++++++++++++++++
>  fs/overlayfs/copy_up.c                  |  9 +++++++--
>  fs/overlayfs/dir.c                      |  2 +-
>  fs/overlayfs/overlayfs.h                |  2 +-
>  fs/overlayfs/ovl_entry.h                |  1 +
>  fs/overlayfs/super.c                    | 15 +++++++++++++++
>  6 files changed, 49 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/filesystems/overlayfs.txt b/Documentation/filesystems/overlayfs.txt
> index eef7d9d259e8..7ad675940c93 100644
> --- a/Documentation/filesystems/overlayfs.txt
> +++ b/Documentation/filesystems/overlayfs.txt
> @@ -245,6 +245,30 @@ filesystem - future operations on the file are barely noticed by the
>  overlay filesystem (though an operation on the name of the file such as
>  rename or unlink will of course be noticed and handled).
>
> +ACL copy-up
> +-----------
> +
> +When a file that only exists on the lower layer is modified it needs
> +to be copied up to the upper layer.  This means copying the metadata
> +and (usually) the data (though see "Metadata only copy up" below).
> +One part of the metadata can be problematic: the ACLs.
> +
> +Now all filesystems support ACLs, and when they do they don't all use
> +the same format.  A significant conflict appears between POSIX acls
> +used on many local filesystems, and NFSv4 ACLs used with NFSv4.  There
> +two formats are, in general, not inter-convertible.
> +
> +If a site only uses regular Unix permissions (Read, Write, eXecute by
> +User, Group and Other), then as these permissions are compatible with
> +all ACLs, there is no need to copy ACLs.  overlayfs cannot determine
> +if this is the case itself.
> +
> +For this reason, overlayfs supports a mount option "honoracl=off"
> +which causes ACLs, any "system." extended attribute, on the lower
> +layer to be ignored and, particularly, not copied to the upper later.
> +This allows NFSv4 to be overlaid with a local filesystem, but should
> +only be used if the only access controls used on the filesystem are
> +Unix permission bits.
>

I don't know. On the one hand "system." is not only ACLs.
On the other hand, "honoracl=off" is not the same as -o noacl,
but it sure sounds the same.

I'd be a lot more comfortable with "ignore_xattrs=system.nfs4_acl"
argument takes a comma separated list of xattr prefixes to ignore.

ovl_is_private_xattr() can be generalized to ovl_is_ignored_xattr(),
going over a blacklist of N>=1 which will also be called from
ovl_can_list(), because there is no point in listing the ACLs that
are ignored. right?

Thanks,
Amir.
