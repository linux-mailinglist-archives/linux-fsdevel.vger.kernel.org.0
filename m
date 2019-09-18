Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A647B5ECD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 10:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfIRINM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 04:13:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43501 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727357AbfIRINL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568794390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tBYmZWNzZyK028kjLPP0OXuxVtKSoC6D+SKbaDamD4I=;
        b=M38hDOGFJ3X/XRE0iWvisM7U6DqhJ/W6tk7Q26E90my1gmSnFfxcqPpuD0tANJ0yZqhiqG
        xiw6Un88BL5jjtJXgUycB68gU6yo9DQTj150byxPzNZtgPZwZs+As9RE4+fmvQMOSrLwEW
        6J7gDu8jXCfaC3RqPsZgslifGlh2H6s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-RZH9OUB4NYW-UV5D8EDLFA-1; Wed, 18 Sep 2019 04:13:09 -0400
Received: by mail-wr1-f69.google.com with SMTP id j2so2070933wre.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 01:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=J4kepTS6NkmfbnktEqYL/8vMgSj5zo0CMdID2s24SxA=;
        b=AnVZYvP/SDQBbrjU0AhCdLmbOCVwHjU0zAAZrI803CTcRfGGczLbfzHrfb5hR4Z5ah
         mb5FG37ubrERGRZ2tmGt3CYlbrkopPxY6OFjAaKevXb6GTHWMCX0sBGgCeYFPce9TE6V
         4Gy1fyubzvNNwVrCmWv/3+5kaV02EtbL2bVXAPcEARwbukos20VBJYTqcyMHb1h4IFKk
         hBRh0pepOCRVpFa9/mqgnPoJ0vol5A2FQ4epvh8HtDkVT09cCPzGS8/BJKFfaPHI/4Mb
         lFB9Gm6qUfhNx4iv4kGtvJ9KnqCu6h0wdGTLTuq+v+4TNNA3m0SI65iv+F52amJTGqad
         oY2A==
X-Gm-Message-State: APjAAAUZkA/JfKKWQcdZj4u7KWJZv9Jhuttz5bCPw5PZUvNd8lxmV+dr
        giYqJ8v0/W3wmVdAzPfI2yTQBrftrLo15yQG4ttTxzpWUlZHBvSPGcX6jy3o17M0yTX/wYbgm4H
        4bo4lB6AcFaXUmLItHNUCaNP5Tg==
X-Received: by 2002:adf:e546:: with SMTP id z6mr1900214wrm.113.1568794387954;
        Wed, 18 Sep 2019 01:13:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwfEsW540R3Q99RCfI7F4kgHXGYxgQwl2/wjeHdPZ0+/IveBc9WLaQpP6PGn/2RmGsPRiesiQ==
X-Received: by 2002:adf:e546:: with SMTP id z6mr1900186wrm.113.1568794387320;
        Wed, 18 Sep 2019 01:13:07 -0700 (PDT)
Received: from pegasus.maiolino.io (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id j22sm9873011wre.45.2019.09.18.01.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 01:13:06 -0700 (PDT)
Date:   Wed, 18 Sep 2019 10:13:04 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 9/9] xfs: Get rid of ->bmap
Message-ID: <20190918081303.zwnxr7pvtotr7cnt@pegasus.maiolino.io>
Mail-Followup-To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        linux-xfs@vger.kernel.org
References: <20190911134315.27380-1-cmaiolino@redhat.com>
 <20190911134315.27380-10-cmaiolino@redhat.com>
 <20190916175049.GD2229799@magnolia>
MIME-Version: 1.0
In-Reply-To: <20190916175049.GD2229799@magnolia>
User-Agent: NeoMutt/20180716
X-MC-Unique: RZH9OUB4NYW-UV5D8EDLFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 16, 2019 at 10:50:49AM -0700, Darrick J. Wong wrote:
> On Wed, Sep 11, 2019 at 03:43:15PM +0200, Carlos Maiolino wrote:
> > We don't need ->bmap anymore, only usage for it was FIBMAP, which is no=
w
> > gone.
> >=20
> > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> > ---
> >=20
> > Changelog:
> > =09V5:
> > =09=09- Properly rebase against 5.3
> > =09=09- iomap_{bmap(),bmap_actor()} are now used also by GFS2, so
> > =09=09  don't remove them anymore
> > =09V2:
> > =09=09- Kill iomap_bmap() and iomap_bmap_actor()
> >=20
> >  fs/xfs/xfs_aops.c  | 24 ------------------------
> >  fs/xfs/xfs_trace.h |  1 -
> >  2 files changed, 25 deletions(-)
> >=20
> > diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> > index 4e4a4d7df5ac..a2884537d2c2 100644
> > --- a/fs/xfs/xfs_aops.c
> > +++ b/fs/xfs/xfs_aops.c
> > @@ -1138,29 +1138,6 @@ xfs_vm_releasepage(
> >  =09return iomap_releasepage(page, gfp_mask);
> >  }
> > =20
> > -STATIC sector_t
> > -xfs_vm_bmap(
> > -=09struct address_space=09*mapping,
> > -=09sector_t=09=09block)
> > -{
> > -=09struct xfs_inode=09*ip =3D XFS_I(mapping->host);
> > -
> > -=09trace_xfs_vm_bmap(ip);
> > -
> > -=09/*
> > -=09 * The swap code (ab-)uses ->bmap to get a block mapping and then
> > -=09 * bypasses the file system for actual I/O.  We really can't allow
> > -=09 * that on reflinks inodes, so we have to skip out here.  And yes,
> > -=09 * 0 is the magic code for a bmap error.
> > -=09 *
> > -=09 * Since we don't pass back blockdev info, we can't return bmap
> > -=09 * information for rt files either.
> > -=09 */
> > -=09if (xfs_is_cow_inode(ip) || XFS_IS_REALTIME_INODE(ip))
>=20
> Uhhhh where does this check happen now?

All checks are now made in the caller, bmap_fiemap() based on the filesyste=
m's
returned flags in the fiemap structure. So, it will decide to pass the resu=
lt
back, or just return -EINVAL.

Well, there is no way for iomap (or bmap_fiemap now) detect the block is in=
 a
realtime device, since we have no flags for that.

Following Christoph's line of thought here, maybe we can add a new IOMAP_F_=
* so
the filesystem can notify iomap the extent is in a different device? I don'=
t
know, just a thought.

This would still keep the consistency of leaving bmap_fiemap() with the dec=
ision
of passing or not.

Cheers.

>=20
> --D
>=20
> > -=09=09return 0;
> > -=09return iomap_bmap(mapping, block, &xfs_iomap_ops);
> > -}
> > -
> >  STATIC int
> >  xfs_vm_readpage(
> >  =09struct file=09=09*unused,
> > @@ -1199,7 +1176,6 @@ const struct address_space_operations xfs_address=
_space_operations =3D {
> >  =09.set_page_dirty=09=09=3D iomap_set_page_dirty,
> >  =09.releasepage=09=09=3D xfs_vm_releasepage,
> >  =09.invalidatepage=09=09=3D xfs_vm_invalidatepage,
> > -=09.bmap=09=09=09=3D xfs_vm_bmap,
> >  =09.direct_IO=09=09=3D noop_direct_IO,
> >  =09.migratepage=09=09=3D iomap_migrate_page,
> >  =09.is_partially_uptodate  =3D iomap_is_partially_uptodate,
> > diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> > index eaae275ed430..c226b562f5da 100644
> > --- a/fs/xfs/xfs_trace.h
> > +++ b/fs/xfs/xfs_trace.h
> > @@ -626,7 +626,6 @@ DEFINE_INODE_EVENT(xfs_readdir);
> >  #ifdef CONFIG_XFS_POSIX_ACL
> >  DEFINE_INODE_EVENT(xfs_get_acl);
> >  #endif
> > -DEFINE_INODE_EVENT(xfs_vm_bmap);
> >  DEFINE_INODE_EVENT(xfs_file_ioctl);
> >  DEFINE_INODE_EVENT(xfs_file_compat_ioctl);
> >  DEFINE_INODE_EVENT(xfs_ioctl_setattr);
> > --=20
> > 2.20.1
> >=20

--=20
Carlos

