Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 691C6139AA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 21:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgAMURk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 15:17:40 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37698 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgAMURk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 15:17:40 -0500
Received: by mail-ot1-f67.google.com with SMTP id k14so10243734otn.4;
        Mon, 13 Jan 2020 12:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sftnhTNUgteiudGo3EY83eCRQMz4mKQQjM6tzj0p+uc=;
        b=OFZeDPkUVykG6Ni5oA3zTuft8MoYp3bIjee8rc6UQyds5GSK5pxOy2IkIOX10tawDD
         IP4pXcoKLNrf41ZzhRGynHrf+2X5FDNWO3G5hB6leNGq0rWQBHbg0ncigb9ro5cccNhL
         yvyYEsKg/BppPsAiUEBm5KK32uokPrkxaBvJdiDbtKg/wGeJkSJ/1HjRC7ZgVOOd7v7P
         uRrArfHAb+qciI8CeKJCu2zB1IfqkGFWP0dObEGTXCvUigOd7SKFetPzfAU81ChtkywH
         Y37TD1Q5bbHRVtY7/+LuMP7lHszaZcJLnnbir+BzjozDXwf9x5Kz4TwSSTWTR04W8TH+
         uofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sftnhTNUgteiudGo3EY83eCRQMz4mKQQjM6tzj0p+uc=;
        b=WB/WKiNUTelWwMt2aiZdE4GsvUk/6oaCqBgj6plsrhDXRiiQs/HlcCEhwcV/AwQzo1
         ZEn2lPb16WPcHs1MBmQ30ttArlRDZ0JGdYOJcce/NFw6mnWdLKUdbDm+bzjy5zS04kNl
         kHxS+Auead2Mtqu0Ow02cQj6kkLWbW2BjrwMozIa4FuGo6iFaJZtelGkxgecuz6xPuQE
         co+kQsLoYdx3PBYDD6p4PvbrJzAKrfNbl9LA6Ig5MjANNX2baGfYTF2f4iT10+wCM86s
         RJ5E9LoxK9jaWbZgVgkJCwRW0vxrJLoI7S5hu4W0fjeJJty0YliiXYjn/uQPZVEZK0vA
         XFvg==
X-Gm-Message-State: APjAAAWVLZDzD7qBd87NIpah7v80QXXKhREpkESRm2S703uNaKuOIraH
        0EfOGZk32e1pMiTRLLGawCLctD3xNY57bmZ5BcU=
X-Google-Smtp-Source: APXvYqxaB99BEdR7r/ckCnxDoMpqS8/lwLxzhjA3n1NCfEvXWFCRB0xsHlBiasJTJLdCI4eMHladkU/zNBcpWaF19Bw=
X-Received: by 2002:a05:6830:155a:: with SMTP id l26mr14515089otp.339.1578946658974;
 Mon, 13 Jan 2020 12:17:38 -0800 (PST)
MIME-Version: 1.0
References: <20191219165250.2875-1-bprotopopov@hotmail.com> <CAH2r5mu0Jd=MACMn6_KPvNWoAPVu+V_3FOnoEZxDWoy0x2qEzA@mail.gmail.com>
In-Reply-To: <CAH2r5mu0Jd=MACMn6_KPvNWoAPVu+V_3FOnoEZxDWoy0x2qEzA@mail.gmail.com>
From:   Boris Protopopov <boris.v.protopopov@gmail.com>
Date:   Mon, 13 Jan 2020 15:17:28 -0500
Message-ID: <CAHhKpQ6+XPwS8G61N7ankg8tNHzeTiJx2SfxV0r+KXZddiy+QQ@mail.gmail.com>
Subject: Re: [PATCH] Add support for setting owner info, dos attributes, and
 create time
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Pavel Shilovsky <piastryyy@gmail.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I have not looked into that, but seems like a good idea. Would this be
done via a well-known extended attributes as well ?

On Thu, Jan 9, 2020 at 2:10 PM Steve French <smfrench@gmail.com> wrote:
>
> One loosely related question ...
>
> Your patch adds the ability to set creation time (birth time) which
> can be useful for backup/restore cases, but doesn't address the other
> hole in Linux (the inability to restore a files ctime).
>
> In Linux the ability to set timestamps seems quite limited (utimes
> only allows setting mtime and atime).
>
> Since setting all 4 timestamps is allowed over SMB3 (and all older
> dialects as well), should we extend this to allow setting ctime not
> just creation time over SMB3/CIFS mounts?
>
> On Thu, Dec 19, 2019 at 10:53 AM Boris Protopopov
> <boris.v.protopopov@gmail.com> wrote:
> >
> > Add extended attribute "system.cifs_ntsd" (and alias "system.smb3_ntsd")
> > to allow for setting owner and DACL in the security descriptor. This is in
> > addition to the existing "system.cifs_acl" and "system.smb3_acl" attributes
> > that allow for setting DACL only. Add support for setting creation time and
> > dos attributes using set_file_info() calls to complement the existing
> > support for getting these attributes via query_path_info() calls.
> >
> > Signed-off-by: Boris Protopopov <bprotopopov@hotmail.com>
> > ---
> >  fs/cifs/xattr.c | 128 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 117 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/cifs/xattr.c b/fs/cifs/xattr.c
> > index 9076150758d8..c41856e6fa22 100644
> > --- a/fs/cifs/xattr.c
> > +++ b/fs/cifs/xattr.c
> > @@ -32,7 +32,8 @@
> >  #include "cifs_unicode.h"
> >
> >  #define MAX_EA_VALUE_SIZE CIFSMaxBufSize
> > -#define CIFS_XATTR_CIFS_ACL "system.cifs_acl"
> > +#define CIFS_XATTR_CIFS_ACL "system.cifs_acl" /* DACL only */
> > +#define CIFS_XATTR_CIFS_NTSD "system.cifs_ntsd" /* owner plus DACL */
> >  #define CIFS_XATTR_ATTRIB "cifs.dosattrib"  /* full name: user.cifs.dosattrib */
> >  #define CIFS_XATTR_CREATETIME "cifs.creationtime"  /* user.cifs.creationtime */
> >  /*
> > @@ -40,12 +41,62 @@
> >   * confusing users and using the 20+ year old term 'cifs' when it is no longer
> >   * secure, replaced by SMB2 (then even more highly secure SMB3) many years ago
> >   */
> > -#define SMB3_XATTR_CIFS_ACL "system.smb3_acl"
> > +#define SMB3_XATTR_CIFS_ACL "system.smb3_acl" /* DACL only */
> > +#define SMB3_XATTR_CIFS_NTSD "system.smb3_ntsd" /* owner plus DACL */
> >  #define SMB3_XATTR_ATTRIB "smb3.dosattrib"  /* full name: user.smb3.dosattrib */
> >  #define SMB3_XATTR_CREATETIME "smb3.creationtime"  /* user.smb3.creationtime */
> >  /* BB need to add server (Samba e.g) support for security and trusted prefix */
> >
> > -enum { XATTR_USER, XATTR_CIFS_ACL, XATTR_ACL_ACCESS, XATTR_ACL_DEFAULT };
> > +enum { XATTR_USER, XATTR_CIFS_ACL, XATTR_ACL_ACCESS, XATTR_ACL_DEFAULT,
> > +       XATTR_CIFS_NTSD };
> > +
> > +static int cifs_attrib_set(unsigned int xid, struct cifs_tcon *pTcon,
> > +                          struct inode *inode, char *full_path,
> > +                          const void *value, size_t size)
> > +{
> > +       ssize_t rc = -EOPNOTSUPP;
> > +       __u32 *pattrib = (__u32 *)value;
> > +       __u32 attrib;
> > +       FILE_BASIC_INFO info_buf;
> > +
> > +       if ((value == NULL) || (size != sizeof(__u32)))
> > +               return -ERANGE;
> > +
> > +       memset(&info_buf, 0, sizeof(info_buf));
> > +       info_buf.Attributes = attrib = cpu_to_le32(*pattrib);
> > +
> > +       if (pTcon->ses->server->ops->set_file_info)
> > +               rc = pTcon->ses->server->ops->set_file_info(inode, full_path,
> > +                               &info_buf, xid);
> > +       if (rc == 0)
> > +               CIFS_I(inode)->cifsAttrs = attrib;
> > +
> > +       return rc;
> > +}
> > +
> > +static int cifs_creation_time_set(unsigned int xid, struct cifs_tcon *pTcon,
> > +                                 struct inode *inode, char *full_path,
> > +                                 const void *value, size_t size)
> > +{
> > +       ssize_t rc = -EOPNOTSUPP;
> > +       __u64 *pcreation_time = (__u64 *)value;
> > +       __u64 creation_time;
> > +       FILE_BASIC_INFO info_buf;
> > +
> > +       if ((value == NULL) || (size != sizeof(__u64)))
> > +               return -ERANGE;
> > +
> > +       memset(&info_buf, 0, sizeof(info_buf));
> > +       info_buf.CreationTime = creation_time = cpu_to_le64(*pcreation_time);
> > +
> > +       if (pTcon->ses->server->ops->set_file_info)
> > +               rc = pTcon->ses->server->ops->set_file_info(inode, full_path,
> > +                               &info_buf, xid);
> > +       if (rc == 0)
> > +               CIFS_I(inode)->createtime = creation_time;
> > +
> > +       return rc;
> > +}
> >
> >  static int cifs_xattr_set(const struct xattr_handler *handler,
> >                           struct dentry *dentry, struct inode *inode,
> > @@ -86,6 +137,23 @@ static int cifs_xattr_set(const struct xattr_handler *handler,
> >
> >         switch (handler->flags) {
> >         case XATTR_USER:
> > +               cifs_dbg(FYI, "%s:setting user xattr %s\n", __func__, name);
> > +               if ((strcmp(name, CIFS_XATTR_ATTRIB) == 0) ||
> > +                   (strcmp(name, SMB3_XATTR_ATTRIB) == 0)) {
> > +                       rc = cifs_attrib_set(xid, pTcon, inode, full_path,
> > +                                       value, size);
> > +                       if (rc == 0) /* force revalidate of the inode */
> > +                               CIFS_I(inode)->time = 0;
> > +                       break;
> > +               } else if ((strcmp(name, CIFS_XATTR_CREATETIME) == 0) ||
> > +                          (strcmp(name, SMB3_XATTR_CREATETIME) == 0)) {
> > +                       rc = cifs_creation_time_set(xid, pTcon, inode,
> > +                                       full_path, value, size);
> > +                       if (rc == 0) /* force revalidate of the inode */
> > +                               CIFS_I(inode)->time = 0;
> > +                       break;
> > +               }
> > +
> >                 if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_XATTR)
> >                         goto out;
> >
> > @@ -95,7 +163,8 @@ static int cifs_xattr_set(const struct xattr_handler *handler,
> >                                 cifs_sb->local_nls, cifs_sb);
> >                 break;
> >
> > -       case XATTR_CIFS_ACL: {
> > +       case XATTR_CIFS_ACL:
> > +       case XATTR_CIFS_NTSD: {
> >                 struct cifs_ntsd *pacl;
> >
> >                 if (!value)
> > @@ -106,12 +175,25 @@ static int cifs_xattr_set(const struct xattr_handler *handler,
> >                 } else {
> >                         memcpy(pacl, value, size);
> >                         if (value &&
> > -                           pTcon->ses->server->ops->set_acl)
> > -                               rc = pTcon->ses->server->ops->set_acl(pacl,
> > -                                               size, inode,
> > -                                               full_path, CIFS_ACL_DACL);
> > -                       else
> > +                           pTcon->ses->server->ops->set_acl) {
> > +                               rc = 0;
> > +                               if (handler->flags == XATTR_CIFS_NTSD) {
> > +                                       /* set owner and DACL */
> > +                                       rc = pTcon->ses->server->ops->set_acl(
> > +                                                       pacl, size, inode,
> > +                                                       full_path,
> > +                                                       CIFS_ACL_OWNER);
> > +                               }
> > +                               if (rc == 0) {
> > +                                       /* set DACL */
> > +                                       rc = pTcon->ses->server->ops->set_acl(
> > +                                                       pacl, size, inode,
> > +                                                       full_path,
> > +                                                       CIFS_ACL_DACL);
> > +                               }
> > +                       } else {
> >                                 rc = -EOPNOTSUPP;
> > +                       }
> >                         if (rc == 0) /* force revalidate of the inode */
> >                                 CIFS_I(inode)->time = 0;
> >                         kfree(pacl);
> > @@ -179,7 +261,7 @@ static int cifs_creation_time_get(struct dentry *dentry, struct inode *inode,
> >                                   void *value, size_t size)
> >  {
> >         ssize_t rc;
> > -       __u64 * pcreatetime;
> > +       __u64 *pcreatetime;
> >
> >         rc = cifs_revalidate_dentry_attr(dentry);
> >         if (rc)
> > @@ -244,7 +326,9 @@ static int cifs_xattr_get(const struct xattr_handler *handler,
> >                                 full_path, name, value, size, cifs_sb);
> >                 break;
> >
> > -       case XATTR_CIFS_ACL: {
> > +       case XATTR_CIFS_ACL:
> > +       case XATTR_CIFS_NTSD: {
> > +               /* the whole ntsd is fetched regardless */
> >                 u32 acllen;
> >                 struct cifs_ntsd *pacl;
> >
> > @@ -382,6 +466,26 @@ static const struct xattr_handler smb3_acl_xattr_handler = {
> >         .set = cifs_xattr_set,
> >  };
> >
> > +static const struct xattr_handler cifs_cifs_ntsd_xattr_handler = {
> > +       .name = CIFS_XATTR_CIFS_NTSD,
> > +       .flags = XATTR_CIFS_NTSD,
> > +       .get = cifs_xattr_get,
> > +       .set = cifs_xattr_set,
> > +};
> > +
> > +/*
> > + * Although this is just an alias for the above, need to move away from
> > + * confusing users and using the 20 year old term 'cifs' when it is no
> > + * longer secure and was replaced by SMB2/SMB3 a long time ago, and
> > + * SMB3 and later are highly secure.
> > + */
> > +static const struct xattr_handler smb3_ntsd_xattr_handler = {
> > +       .name = SMB3_XATTR_CIFS_NTSD,
> > +       .flags = XATTR_CIFS_NTSD,
> > +       .get = cifs_xattr_get,
> > +       .set = cifs_xattr_set,
> > +};
> > +
> >  static const struct xattr_handler cifs_posix_acl_access_xattr_handler = {
> >         .name = XATTR_NAME_POSIX_ACL_ACCESS,
> >         .flags = XATTR_ACL_ACCESS,
> > @@ -401,6 +505,8 @@ const struct xattr_handler *cifs_xattr_handlers[] = {
> >         &cifs_os2_xattr_handler,
> >         &cifs_cifs_acl_xattr_handler,
> >         &smb3_acl_xattr_handler, /* alias for above since avoiding "cifs" */
> > +       &cifs_cifs_ntsd_xattr_handler,
> > +       &smb3_ntsd_xattr_handler, /* alias for above since avoiding "cifs" */
> >         &cifs_posix_acl_access_xattr_handler,
> >         &cifs_posix_acl_default_xattr_handler,
> >         NULL
> > --
> > 2.14.5
> >
>
>
> --
> Thanks,
>
> Steve
