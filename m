Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E587587E47
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 16:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbiHBOmW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 10:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiHBOmU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:42:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65463A467;
        Tue,  2 Aug 2022 07:42:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22D35B8199C;
        Tue,  2 Aug 2022 14:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24C9C43140;
        Tue,  2 Aug 2022 14:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659451336;
        bh=6B1CWeT95NQ2giPvjw5QAffoy9TyqeOJL6uU6Ph4Ejw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EC6PsSm6Y9tNBgdZXif/HIuGdiuW9ALjxm0q0U3Nzck7rCdyEbmZlTJv5QZWjg9Tn
         etK1A/vhTnMOWBNGe/D+WONr88h3GnBzagHsMDNZXFpXunDILQFC+i2DVWmmJWFCCC
         sQ4Qby3t6W/VMt3/NDeejgCa6DuDCofeLCKhXqTs0vhd1aMxGXVlbWJ6kYoBB3jU2z
         vLaDdXLCs5lSfUU55oLvbNOPokwtcTIrH1Ni1Mcsm5NOhOvpOmG24/N68cs40eenZt
         1+H3Fn0yvLktMimoA+LiCw9FubJItKHc/XE0iaEHObb/ZVS9o3zryI+NQa9Z7MhxBx
         CzSI3MInL8l0g==
Message-ID: <c05f4fc668fa97e737758ab03030d7170c0edbd9.camel@kernel.org>
Subject: Re: [RFC PATCH 0/3] Rename "cifs" module to "smbfs"
From:   Jeff Layton <jlayton@kernel.org>
To:     Enzo Matsumiya <ematsumiya@suse.de>, linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, pc@cjr.nz, ronniesahlberg@gmail.com,
        nspmangalore@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tom@talpey.com,
        samba-technical@lists.samba.org, pshilovsky@samba.org
Date:   Tue, 02 Aug 2022 10:42:14 -0400
In-Reply-To: <20220801190933.27197-1-ematsumiya@suse.de>
References: <20220801190933.27197-1-ematsumiya@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-08-01 at 16:09 -0300, Enzo Matsumiya wrote:
> Hi,
>=20
> As part of the ongoing effort to remove the "cifs" nomenclature from the
> Linux SMB client, I'm proposing the rename of the module to "smbfs".
>=20
> As it's widely known, CIFS is associated to SMB1.0, which, in turn, is
> associated with the security issues it presented in the past. Using
> "SMBFS" makes clear what's the protocol in use for outsiders, but also
> unties it from any particular protocol version. It also fits in the
> already existing "fs/smbfs_common" and "fs/ksmbd" naming scheme.
>=20
> This short patch series only changes directory names and includes/ifdefs =
in
> headers and source code, and updates docs to reflect the rename. Other
> than that, no source code/functionality is modified (WIP though).
>=20
> Patch 1/3: effectively changes the module name to "smbfs" and create a
> 	   "cifs" module alias to maintain compatibility (a warning
> 	   should be added to indicate the complete removal/isolation of
> 	   CIFS/SMB1.0 code).
> Patch 2/3: rename the source-code directory to align with the new module
> 	   name
> Patch 3/3: update documentation references to "fs/cifs" or "cifs.ko" or
> 	   "cifs module" to use the new name
>=20
> Enzo Matsumiya (3):
>   cifs: change module name to "smbfs.ko"
>   smbfs: rename directory "fs/cifs" -> "fs/smbfs"
>   smbfs: update doc references
>=20
>  Documentation/admin-guide/index.rst           |   2 +-
>  .../admin-guide/{cifs =3D> smbfs}/authors.rst   |   0
>  .../admin-guide/{cifs =3D> smbfs}/changes.rst   |   4 +-
>  .../admin-guide/{cifs =3D> smbfs}/index.rst     |   0
>  .../{cifs =3D> smbfs}/introduction.rst          |   0
>  .../admin-guide/{cifs =3D> smbfs}/todo.rst      |  12 +-
>  .../admin-guide/{cifs =3D> smbfs}/usage.rst     | 168 +++++++++---------
>  .../{cifs =3D> smbfs}/winucase_convert.pl       |   0
>  Documentation/filesystems/index.rst           |   2 +-
>  .../filesystems/{cifs =3D> smbfs}/cifsroot.rst  |  14 +-
>  .../filesystems/{cifs =3D> smbfs}/index.rst     |   0
>  .../filesystems/{cifs =3D> smbfs}/ksmbd.rst     |   2 +-
>  Documentation/networking/dns_resolver.rst     |   2 +-
>  .../translations/zh_CN/admin-guide/index.rst  |   2 +-
>  .../translations/zh_TW/admin-guide/index.rst  |   2 +-
>  fs/Kconfig                                    |   6 +-
>  fs/Makefile                                   |   2 +-
>  fs/cifs/Makefile                              |  34 ----
>  fs/{cifs =3D> smbfs}/Kconfig                    | 108 +++++------
>  fs/smbfs/Makefile                             |  34 ++++
>  fs/{cifs =3D> smbfs}/asn1.c                     |   0
>  fs/{cifs =3D> smbfs}/cifs_debug.c               |  72 ++++----
>  fs/{cifs =3D> smbfs}/cifs_debug.h               |   4 +-
>  fs/{cifs =3D> smbfs}/cifs_dfs_ref.c             |   2 +-
>  fs/{cifs =3D> smbfs}/cifs_fs_sb.h               |   0
>  fs/{cifs =3D> smbfs}/cifs_ioctl.h               |   0
>  fs/{cifs =3D> smbfs}/cifs_spnego.c              |   4 +-
>  fs/{cifs =3D> smbfs}/cifs_spnego.h              |   0
>  .../cifs_spnego_negtokeninit.asn1             |   0
>  fs/{cifs =3D> smbfs}/cifs_swn.c                 |   0
>  fs/{cifs =3D> smbfs}/cifs_swn.h                 |   4 +-
>  fs/{cifs =3D> smbfs}/cifs_unicode.c             |   0
>  fs/{cifs =3D> smbfs}/cifs_unicode.h             |   0
>  fs/{cifs =3D> smbfs}/cifs_uniupr.h              |   0
>  fs/{cifs =3D> smbfs}/cifsacl.c                  |   6 +-
>  fs/{cifs =3D> smbfs}/cifsacl.h                  |   0
>  fs/{cifs =3D> smbfs}/cifsencrypt.c              |   0
>  fs/{cifs =3D> smbfs}/cifsglob.h                 |  26 +--
>  fs/{cifs =3D> smbfs}/cifspdu.h                  |   6 +-
>  fs/{cifs =3D> smbfs}/cifsproto.h                |  10 +-
>  fs/{cifs =3D> smbfs}/cifsroot.c                 |   0
>  fs/{cifs =3D> smbfs}/cifssmb.c                  |  14 +-
>  fs/{cifs =3D> smbfs}/connect.c                  |  36 ++--
>  fs/{cifs/cifsfs.c =3D> smbfs/core.c}            |  49 ++---
>  fs/{cifs =3D> smbfs}/dfs_cache.c                |   2 +-
>  fs/{cifs =3D> smbfs}/dfs_cache.h                |   0
>  fs/{cifs =3D> smbfs}/dir.c                      |   2 +-
>  fs/{cifs =3D> smbfs}/dns_resolve.c              |   0
>  fs/{cifs =3D> smbfs}/dns_resolve.h              |   0
>  fs/{cifs =3D> smbfs}/export.c                   |   8 +-
>  fs/{cifs =3D> smbfs}/file.c                     |  16 +-
>  fs/{cifs =3D> smbfs}/fs_context.c               |  20 +--
>  fs/{cifs =3D> smbfs}/fs_context.h               |   0
>  fs/{cifs =3D> smbfs}/fscache.c                  |   0
>  fs/{cifs =3D> smbfs}/fscache.h                  |   6 +-
>  fs/{cifs =3D> smbfs}/inode.c                    |  10 +-
>  fs/{cifs =3D> smbfs}/ioctl.c                    |   6 +-
>  fs/{cifs =3D> smbfs}/link.c                     |   2 +-
>  fs/{cifs =3D> smbfs}/misc.c                     |  14 +-
>  fs/{cifs =3D> smbfs}/netlink.c                  |   0
>  fs/{cifs =3D> smbfs}/netlink.h                  |   0
>  fs/{cifs =3D> smbfs}/netmisc.c                  |   2 +-
>  fs/{cifs =3D> smbfs}/nterr.c                    |   0
>  fs/{cifs =3D> smbfs}/nterr.h                    |   0
>  fs/{cifs =3D> smbfs}/ntlmssp.h                  |   2 +-
>  fs/{cifs =3D> smbfs}/readdir.c                  |   4 +-
>  fs/{cifs =3D> smbfs}/rfc1002pdu.h               |   0
>  fs/{cifs =3D> smbfs}/sess.c                     |  10 +-
>  fs/{cifs =3D> smbfs}/smb1ops.c                  |   4 +-
>  fs/{cifs =3D> smbfs}/smb2file.c                 |   2 +-
>  fs/{cifs =3D> smbfs}/smb2glob.h                 |   0
>  fs/{cifs =3D> smbfs}/smb2inode.c                |   2 +-
>  fs/{cifs =3D> smbfs}/smb2maperror.c             |   0
>  fs/{cifs =3D> smbfs}/smb2misc.c                 |   0
>  fs/{cifs =3D> smbfs}/smb2ops.c                  |  32 ++--
>  fs/{cifs =3D> smbfs}/smb2pdu.c                  |  22 +--
>  fs/{cifs =3D> smbfs}/smb2pdu.h                  |   0
>  fs/{cifs =3D> smbfs}/smb2proto.h                |   0
>  fs/{cifs =3D> smbfs}/smb2status.h               |   0
>  fs/{cifs =3D> smbfs}/smb2transport.c            |   2 +-
>  fs/{cifs =3D> smbfs}/smbdirect.c                |   0
>  fs/{cifs =3D> smbfs}/smbdirect.h                |   2 +-
>  fs/{cifs =3D> smbfs}/smbencrypt.c               |   0
>  fs/{cifs =3D> smbfs}/smberr.h                   |   0
>  fs/{cifs/cifsfs.h =3D> smbfs/smbfs.h}           |  12 +-
>  fs/{cifs =3D> smbfs}/trace.c                    |   0
>  fs/{cifs =3D> smbfs}/trace.h                    |   0
>  fs/{cifs =3D> smbfs}/transport.c                |   4 +-
>  fs/{cifs =3D> smbfs}/unc.c                      |   0
>  fs/{cifs =3D> smbfs}/winucase.c                 |   0
>  fs/{cifs =3D> smbfs}/xattr.c                    |  18 +-
>  91 files changed, 414 insertions(+), 417 deletions(-)
>  rename Documentation/admin-guide/{cifs =3D> smbfs}/authors.rst (100%)
>  rename Documentation/admin-guide/{cifs =3D> smbfs}/changes.rst (73%)
>  rename Documentation/admin-guide/{cifs =3D> smbfs}/index.rst (100%)
>  rename Documentation/admin-guide/{cifs =3D> smbfs}/introduction.rst (100=
%)
>  rename Documentation/admin-guide/{cifs =3D> smbfs}/todo.rst (95%)
>  rename Documentation/admin-guide/{cifs =3D> smbfs}/usage.rst (87%)
>  rename Documentation/admin-guide/{cifs =3D> smbfs}/winucase_convert.pl (=
100%)
>  rename Documentation/filesystems/{cifs =3D> smbfs}/cifsroot.rst (85%)
>  rename Documentation/filesystems/{cifs =3D> smbfs}/index.rst (100%)
>  rename Documentation/filesystems/{cifs =3D> smbfs}/ksmbd.rst (99%)
>  delete mode 100644 fs/cifs/Makefile
>  rename fs/{cifs =3D> smbfs}/Kconfig (72%)
>  create mode 100644 fs/smbfs/Makefile
>  rename fs/{cifs =3D> smbfs}/asn1.c (100%)
>  rename fs/{cifs =3D> smbfs}/cifs_debug.c (96%)
>  rename fs/{cifs =3D> smbfs}/cifs_debug.h (98%)
>  rename fs/{cifs =3D> smbfs}/cifs_dfs_ref.c (99%)
>  rename fs/{cifs =3D> smbfs}/cifs_fs_sb.h (100%)
>  rename fs/{cifs =3D> smbfs}/cifs_ioctl.h (100%)
>  rename fs/{cifs =3D> smbfs}/cifs_spnego.c (98%)
>  rename fs/{cifs =3D> smbfs}/cifs_spnego.h (100%)
>  rename fs/{cifs =3D> smbfs}/cifs_spnego_negtokeninit.asn1 (100%)
>  rename fs/{cifs =3D> smbfs}/cifs_swn.c (100%)
>  rename fs/{cifs =3D> smbfs}/cifs_swn.h (95%)
>  rename fs/{cifs =3D> smbfs}/cifs_unicode.c (100%)
>  rename fs/{cifs =3D> smbfs}/cifs_unicode.h (100%)
>  rename fs/{cifs =3D> smbfs}/cifs_uniupr.h (100%)
>  rename fs/{cifs =3D> smbfs}/cifsacl.c (99%)
>  rename fs/{cifs =3D> smbfs}/cifsacl.h (100%)
>  rename fs/{cifs =3D> smbfs}/cifsencrypt.c (100%)
>  rename fs/{cifs =3D> smbfs}/cifsglob.h (99%)
>  rename fs/{cifs =3D> smbfs}/cifspdu.h (99%)
>  rename fs/{cifs =3D> smbfs}/cifsproto.h (99%)
>  rename fs/{cifs =3D> smbfs}/cifsroot.c (100%)
>  rename fs/{cifs =3D> smbfs}/cifssmb.c (99%)
>  rename fs/{cifs =3D> smbfs}/connect.c (99%)
>  rename fs/{cifs/cifsfs.c =3D> smbfs/core.c} (98%)
>  rename fs/{cifs =3D> smbfs}/dfs_cache.c (99%)
>  rename fs/{cifs =3D> smbfs}/dfs_cache.h (100%)
>  rename fs/{cifs =3D> smbfs}/dir.c (99%)
>  rename fs/{cifs =3D> smbfs}/dns_resolve.c (100%)
>  rename fs/{cifs =3D> smbfs}/dns_resolve.h (100%)
>  rename fs/{cifs =3D> smbfs}/export.c (91%)
>  rename fs/{cifs =3D> smbfs}/file.c (99%)
>  rename fs/{cifs =3D> smbfs}/fs_context.c (99%)
>  rename fs/{cifs =3D> smbfs}/fs_context.h (100%)
>  rename fs/{cifs =3D> smbfs}/fscache.c (100%)
>  rename fs/{cifs =3D> smbfs}/fscache.h (98%)
>  rename fs/{cifs =3D> smbfs}/inode.c (99%)
>  rename fs/{cifs =3D> smbfs}/ioctl.c (99%)
>  rename fs/{cifs =3D> smbfs}/link.c (99%)
>  rename fs/{cifs =3D> smbfs}/misc.c (99%)
>  rename fs/{cifs =3D> smbfs}/netlink.c (100%)
>  rename fs/{cifs =3D> smbfs}/netlink.h (100%)
>  rename fs/{cifs =3D> smbfs}/netmisc.c (99%)
>  rename fs/{cifs =3D> smbfs}/nterr.c (100%)
>  rename fs/{cifs =3D> smbfs}/nterr.h (100%)
>  rename fs/{cifs =3D> smbfs}/ntlmssp.h (98%)
>  rename fs/{cifs =3D> smbfs}/readdir.c (99%)
>  rename fs/{cifs =3D> smbfs}/rfc1002pdu.h (100%)
>  rename fs/{cifs =3D> smbfs}/sess.c (99%)
>  rename fs/{cifs =3D> smbfs}/smb1ops.c (99%)
>  rename fs/{cifs =3D> smbfs}/smb2file.c (99%)
>  rename fs/{cifs =3D> smbfs}/smb2glob.h (100%)
>  rename fs/{cifs =3D> smbfs}/smb2inode.c (99%)
>  rename fs/{cifs =3D> smbfs}/smb2maperror.c (100%)
>  rename fs/{cifs =3D> smbfs}/smb2misc.c (100%)
>  rename fs/{cifs =3D> smbfs}/smb2ops.c (99%)
>  rename fs/{cifs =3D> smbfs}/smb2pdu.c (99%)
>  rename fs/{cifs =3D> smbfs}/smb2pdu.h (100%)
>  rename fs/{cifs =3D> smbfs}/smb2proto.h (100%)
>  rename fs/{cifs =3D> smbfs}/smb2status.h (100%)
>  rename fs/{cifs =3D> smbfs}/smb2transport.c (99%)
>  rename fs/{cifs =3D> smbfs}/smbdirect.c (100%)
>  rename fs/{cifs =3D> smbfs}/smbdirect.h (99%)
>  rename fs/{cifs =3D> smbfs}/smbencrypt.c (100%)
>  rename fs/{cifs =3D> smbfs}/smberr.h (100%)
>  rename fs/{cifs/cifsfs.h =3D> smbfs/smbfs.h} (97%)
>  rename fs/{cifs =3D> smbfs}/trace.c (100%)
>  rename fs/{cifs =3D> smbfs}/trace.h (100%)
>  rename fs/{cifs =3D> smbfs}/transport.c (99%)
>  rename fs/{cifs =3D> smbfs}/unc.c (100%)
>  rename fs/{cifs =3D> smbfs}/winucase.c (100%)
>  rename fs/{cifs =3D> smbfs}/xattr.c (98%)
>=20


Why do this? My inclination is to say NAK here.

This seems like a lot of change for not a lot of benefit. Renaming the
directory like this pretty much guarantees that backporting patches
after this change to kernels that existed before it will be very
difficult.

Also, bear in mind that there used to be an smbfs in the kernel that
predated cifs.ko. That was removed ~2010 though, which is long enough
ago that it shouldn't produce conflicts in currently shipping releases.=A0
--=20
Jeff Layton <jlayton@kernel.org>
