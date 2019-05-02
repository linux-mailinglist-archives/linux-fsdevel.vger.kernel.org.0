Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9591127C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 07:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbfEBFI2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 01:08:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50718 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfEBFI1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 01:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Fudg6aBxe0TkPNIqYA88Y89agb4T2MW29SCxmEQ3FDg=; b=QtiQDJhMITB8z86q7y2rFHLizw
        A0n7Ay+W13jFlrAu5jmXGN4yKvKjZQkip/Al1Dj2gLr1dMSxDf6ckHScQ3SFxcYdmxVmCUu0yywtu
        C6oru7DSuxU41Q6vaaEvQKdWQ4Z5WI4LiMKKeU/N/4Xqdguq1hvSNjl7pXg6QTqq/NIW4zIkxKjWJ
        xdDrHL1MdmTrauH/fAxyax92MpcYlnZrjmYaEXrV0PVn39KohTnHNl3c0IHSDVBJkwX43bqMYdi1Q
        WiyyznShpO4/IGLm/RXiUaspQ7bwkO35wthrNfb+Cr4qtlg9+PNy18wDkkC8Xm+SgjRUqx9BNqm3h
        M5pbJwzg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hM3xG-0004oT-En; Thu, 02 May 2019 05:08:22 +0000
Subject: Re: [PATCH] OVL: add honoracl=off mount option.
To:     NeilBrown <neilb@suse.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        =?UTF-8?Q?Andreas_Gr=c3=bcnbacher?= <andreas.gruenbacher@gmail.com>,
        Patrick Plagwitz <Patrick_Plagwitz@web.de>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAJfpeguwUtRWRGmNmimNp-FXzWqMCCQMb24iWPu0w_J0_rOnnw@mail.gmail.com>
 <20161205151933.GA17517@fieldses.org>
 <CAJfpegtpkavseTFLspaC7svbvHRq-0-7jvyh63+DK5iWHTGnaQ@mail.gmail.com>
 <20161205162559.GB17517@fieldses.org>
 <CAHpGcMKHjic6L+J0qvMYNG9hVCcDO1hEpx4BiEk0ZCKDV39BmA@mail.gmail.com>
 <266c571f-e4e2-7c61-5ee2-8ece0c2d06e9@web.de>
 <CAHpGcMKmtppfn7PVrGKEEtVphuLV=YQ2GDYKOqje4ZANhzSgDw@mail.gmail.com>
 <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com>
 <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com>
 <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com>
 <20161206185806.GC31197@fieldses.org>
 <87bm0l4nra.fsf@notabene.neil.brown.name>
 <8736lx4goa.fsf@notabene.neil.brown.name>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9ada42cb-8783-49bb-fd0d-31e7fb7dacf4@infradead.org>
Date:   Wed, 1 May 2019 22:08:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8736lx4goa.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Neil,

On 5/1/19 9:35 PM, NeilBrown wrote:
> 
> If the upper and lower layers use incompatible ACL formats, it is not
> possible to copy the ACL xttr from one to the other, so overlayfs

                           attr (?)

> cannot work with them.
> This happens particularly with NFSv4 which uses system.nfs4_acl, and
> ext4 which uses system.posix_acl_access.
> 
> If all ACLs actually make to Unix permissions, then there is no need

                       map (?)

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

   Not

> +the same format.  A significant conflict appears between POSIX acls

                                                                  ACLs

> +used on many local filesystems, and NFSv4 ACLs used with NFSv4.  There

                                                                    These (or the)

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
>  Multiple lower layers
>  ---------------------



-- 
~Randy
