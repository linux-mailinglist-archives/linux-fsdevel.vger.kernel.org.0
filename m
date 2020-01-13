Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14A73139AAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 21:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgAMU0n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 15:26:43 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36933 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgAMU0n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 15:26:43 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so5255245pga.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2020 12:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=kDgxwjf5QG72LM5uDF6JUocNtox4AOc+jgGNAjSU6Yg=;
        b=uDc4+MyfaybiB8IPNsfdI9jIlPUNBo/9De2/SkJv9chuK0qD44DBosMqavYMbenaR9
         56PKRbHlBt58muccF6NbeUcc/yGotybpTQ/sob0cJYl1ae8ANkHCImgDbG2tTI5C5iZE
         2pDwdP+0gXIXTU8uFh2ijKQPeiryV2nJ3u4o06jYQFKDyUntFls8pdw17hfUGgW2/xH+
         6dLGXbK4jk5SObxdRe/vr/6jKAOp5pAUFp2hoZMiXZPMSK780DOx8NjnaNvXQ7XTdbmX
         vTvqqsrh2+023auVjUEMRVvMgOFbrqR2qEd+CaK/Hc/FytRO9ai54kiczZcZdoyUrbCU
         JiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=kDgxwjf5QG72LM5uDF6JUocNtox4AOc+jgGNAjSU6Yg=;
        b=jBJlQB0ZNuLOxss2+e78p6JlXQZeC3+po90tD98ImIUD3MZsRHbEcJu97nJGxTY3Yt
         g+MlsAmv4Xatb9AArjhzKWrAvkJwGGu2JDUeup8o9fX2zg/FC3YoaeRYXWNruF9rY4Vq
         ecRjOUWBYboYsE1VQhaE10dJM3P/KkRtSlcVXYSXmpQl3GYiBJcqWtTka7FqOWGcA7kC
         ScmkV1uSAPxWfKzLyEa0veSRIz2D4BQHdKxnzU4y3C54aCyDHY6SQ/+nkNaqqMcXJPhP
         y/7fr70W+MtPyFW5jgvhiktYuMHvK/7VZZWJx3/PnE9zn1pIliJ3TKFEDHn2tdRLdiFh
         X1Ig==
X-Gm-Message-State: APjAAAW1HXvWdr94R9QDKEPOvvQ8cUqtcRk+Y86NP7vUz/Z6GMNcZzjT
        FNb/s2ALEWjH9aTPJMInwCAVbA==
X-Google-Smtp-Source: APXvYqxqWdQERRcdV15HojVDOWi2uhvivIGV1DcnZ9PF42xu1IGJAD/3118/X2/acJFzrDSizOJZ1w==
X-Received: by 2002:a65:5809:: with SMTP id g9mr23098357pgr.146.1578947202186;
        Mon, 13 Jan 2020 12:26:42 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id r8sm13811218pjo.22.2020.01.13.12.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jan 2020 12:26:41 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <780DD595-1F92-4C34-A323-BB32748E5D07@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_AC13100A-3B43-4272-BAC9-050284FBD29F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Add support for setting owner info, dos attributes, and
 create time
Date:   Mon, 13 Jan 2020 13:26:39 -0700
In-Reply-To: <CAH2r5mu0Jd=MACMn6_KPvNWoAPVu+V_3FOnoEZxDWoy0x2qEzA@mail.gmail.com>
Cc:     Boris Protopopov <boris.v.protopopov@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Pavel Shilovsky <piastryyy@gmail.com>,
        David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
References: <20191219165250.2875-1-bprotopopov@hotmail.com>
 <CAH2r5mu0Jd=MACMn6_KPvNWoAPVu+V_3FOnoEZxDWoy0x2qEzA@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_AC13100A-3B43-4272-BAC9-050284FBD29F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 9, 2020, at 12:10 PM, Steve French <smfrench@gmail.com> wrote:
>=20
> One loosely related question ...
>=20
> Your patch adds the ability to set creation time (birth time) which
> can be useful for backup/restore cases, but doesn't address the other
> hole in Linux (the inability to restore a files ctime).
>=20
> In Linux the ability to set timestamps seems quite limited (utimes
> only allows setting mtime and atime).

The whole point of not being able to change ctime and btime as a regular
user is so that it is possible to determine when a file was actually
created on the filesystem and last modified.  That is often useful for
debugging or forensics reasons.

I think if this is something that SMB/CIFS wants to do, it should save
these attributes into an xattr of its own (e.g. user.dos or whatever),
rather than using the ctime and btime(crtime) fields in the filesystem.

Cheers, Andreas

> Since setting all 4 timestamps is allowed over SMB3 (and all older
> dialects as well), should we extend this to allow setting ctime not
> just creation time over SMB3/CIFS mounts?
>=20
> On Thu, Dec 19, 2019 at 10:53 AM Boris Protopopov
> <boris.v.protopopov@gmail.com> wrote:
>>=20
>> Add extended attribute "system.cifs_ntsd" (and alias =
"system.smb3_ntsd")
>> to allow for setting owner and DACL in the security descriptor. This =
is in
>> addition to the existing "system.cifs_acl" and "system.smb3_acl" =
attributes
>> that allow for setting DACL only. Add support for setting creation =
time and
>> dos attributes using set_file_info() calls to complement the existing
>> support for getting these attributes via query_path_info() calls.
>>=20
>> Signed-off-by: Boris Protopopov <bprotopopov@hotmail.com>
>> ---
>> fs/cifs/xattr.c | 128 =
+++++++++++++++++++++++++++++++++++++++++++++++++++-----
>> 1 file changed, 117 insertions(+), 11 deletions(-)
>>=20
>> diff --git a/fs/cifs/xattr.c b/fs/cifs/xattr.c
>> index 9076150758d8..c41856e6fa22 100644
>> --- a/fs/cifs/xattr.c
>> +++ b/fs/cifs/xattr.c
>> @@ -32,7 +32,8 @@
>> #include "cifs_unicode.h"
>>=20
>> #define MAX_EA_VALUE_SIZE CIFSMaxBufSize
>> -#define CIFS_XATTR_CIFS_ACL "system.cifs_acl"
>> +#define CIFS_XATTR_CIFS_ACL "system.cifs_acl" /* DACL only */
>> +#define CIFS_XATTR_CIFS_NTSD "system.cifs_ntsd" /* owner plus DACL =
*/
>> #define CIFS_XATTR_ATTRIB "cifs.dosattrib"  /* full name: =
user.cifs.dosattrib */
>> #define CIFS_XATTR_CREATETIME "cifs.creationtime"  /* =
user.cifs.creationtime */
>> /*
>> @@ -40,12 +41,62 @@
>>  * confusing users and using the 20+ year old term 'cifs' when it is =
no longer
>>  * secure, replaced by SMB2 (then even more highly secure SMB3) many =
years ago
>>  */
>> -#define SMB3_XATTR_CIFS_ACL "system.smb3_acl"
>> +#define SMB3_XATTR_CIFS_ACL "system.smb3_acl" /* DACL only */
>> +#define SMB3_XATTR_CIFS_NTSD "system.smb3_ntsd" /* owner plus DACL =
*/
>> #define SMB3_XATTR_ATTRIB "smb3.dosattrib"  /* full name: =
user.smb3.dosattrib */
>> #define SMB3_XATTR_CREATETIME "smb3.creationtime"  /* =
user.smb3.creationtime */
>> /* BB need to add server (Samba e.g) support for security and trusted =
prefix */
>>=20
>> -enum { XATTR_USER, XATTR_CIFS_ACL, XATTR_ACL_ACCESS, =
XATTR_ACL_DEFAULT };
>> +enum { XATTR_USER, XATTR_CIFS_ACL, XATTR_ACL_ACCESS, =
XATTR_ACL_DEFAULT,
>> +       XATTR_CIFS_NTSD };
>> +
>> +static int cifs_attrib_set(unsigned int xid, struct cifs_tcon =
*pTcon,
>> +                          struct inode *inode, char *full_path,
>> +                          const void *value, size_t size)
>> +{
>> +       ssize_t rc =3D -EOPNOTSUPP;
>> +       __u32 *pattrib =3D (__u32 *)value;
>> +       __u32 attrib;
>> +       FILE_BASIC_INFO info_buf;
>> +
>> +       if ((value =3D=3D NULL) || (size !=3D sizeof(__u32)))
>> +               return -ERANGE;
>> +
>> +       memset(&info_buf, 0, sizeof(info_buf));
>> +       info_buf.Attributes =3D attrib =3D cpu_to_le32(*pattrib);
>> +
>> +       if (pTcon->ses->server->ops->set_file_info)
>> +               rc =3D pTcon->ses->server->ops->set_file_info(inode, =
full_path,
>> +                               &info_buf, xid);
>> +       if (rc =3D=3D 0)
>> +               CIFS_I(inode)->cifsAttrs =3D attrib;
>> +
>> +       return rc;
>> +}
>> +
>> +static int cifs_creation_time_set(unsigned int xid, struct cifs_tcon =
*pTcon,
>> +                                 struct inode *inode, char =
*full_path,
>> +                                 const void *value, size_t size)
>> +{
>> +       ssize_t rc =3D -EOPNOTSUPP;
>> +       __u64 *pcreation_time =3D (__u64 *)value;
>> +       __u64 creation_time;
>> +       FILE_BASIC_INFO info_buf;
>> +
>> +       if ((value =3D=3D NULL) || (size !=3D sizeof(__u64)))
>> +               return -ERANGE;
>> +
>> +       memset(&info_buf, 0, sizeof(info_buf));
>> +       info_buf.CreationTime =3D creation_time =3D =
cpu_to_le64(*pcreation_time);
>> +
>> +       if (pTcon->ses->server->ops->set_file_info)
>> +               rc =3D pTcon->ses->server->ops->set_file_info(inode, =
full_path,
>> +                               &info_buf, xid);
>> +       if (rc =3D=3D 0)
>> +               CIFS_I(inode)->createtime =3D creation_time;
>> +
>> +       return rc;
>> +}
>>=20
>> static int cifs_xattr_set(const struct xattr_handler *handler,
>>                          struct dentry *dentry, struct inode *inode,
>> @@ -86,6 +137,23 @@ static int cifs_xattr_set(const struct =
xattr_handler *handler,
>>=20
>>        switch (handler->flags) {
>>        case XATTR_USER:
>> +               cifs_dbg(FYI, "%s:setting user xattr %s\n", __func__, =
name);
>> +               if ((strcmp(name, CIFS_XATTR_ATTRIB) =3D=3D 0) ||
>> +                   (strcmp(name, SMB3_XATTR_ATTRIB) =3D=3D 0)) {
>> +                       rc =3D cifs_attrib_set(xid, pTcon, inode, =
full_path,
>> +                                       value, size);
>> +                       if (rc =3D=3D 0) /* force revalidate of the =
inode */
>> +                               CIFS_I(inode)->time =3D 0;
>> +                       break;
>> +               } else if ((strcmp(name, CIFS_XATTR_CREATETIME) =3D=3D =
0) ||
>> +                          (strcmp(name, SMB3_XATTR_CREATETIME) =3D=3D =
0)) {
>> +                       rc =3D cifs_creation_time_set(xid, pTcon, =
inode,
>> +                                       full_path, value, size);
>> +                       if (rc =3D=3D 0) /* force revalidate of the =
inode */
>> +                               CIFS_I(inode)->time =3D 0;
>> +                       break;
>> +               }
>> +
>>                if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_XATTR)
>>                        goto out;
>>=20
>> @@ -95,7 +163,8 @@ static int cifs_xattr_set(const struct =
xattr_handler *handler,
>>                                cifs_sb->local_nls, cifs_sb);
>>                break;
>>=20
>> -       case XATTR_CIFS_ACL: {
>> +       case XATTR_CIFS_ACL:
>> +       case XATTR_CIFS_NTSD: {
>>                struct cifs_ntsd *pacl;
>>=20
>>                if (!value)
>> @@ -106,12 +175,25 @@ static int cifs_xattr_set(const struct =
xattr_handler *handler,
>>                } else {
>>                        memcpy(pacl, value, size);
>>                        if (value &&
>> -                           pTcon->ses->server->ops->set_acl)
>> -                               rc =3D =
pTcon->ses->server->ops->set_acl(pacl,
>> -                                               size, inode,
>> -                                               full_path, =
CIFS_ACL_DACL);
>> -                       else
>> +                           pTcon->ses->server->ops->set_acl) {
>> +                               rc =3D 0;
>> +                               if (handler->flags =3D=3D =
XATTR_CIFS_NTSD) {
>> +                                       /* set owner and DACL */
>> +                                       rc =3D =
pTcon->ses->server->ops->set_acl(
>> +                                                       pacl, size, =
inode,
>> +                                                       full_path,
>> +                                                       =
CIFS_ACL_OWNER);
>> +                               }
>> +                               if (rc =3D=3D 0) {
>> +                                       /* set DACL */
>> +                                       rc =3D =
pTcon->ses->server->ops->set_acl(
>> +                                                       pacl, size, =
inode,
>> +                                                       full_path,
>> +                                                       =
CIFS_ACL_DACL);
>> +                               }
>> +                       } else {
>>                                rc =3D -EOPNOTSUPP;
>> +                       }
>>                        if (rc =3D=3D 0) /* force revalidate of the =
inode */
>>                                CIFS_I(inode)->time =3D 0;
>>                        kfree(pacl);
>> @@ -179,7 +261,7 @@ static int cifs_creation_time_get(struct dentry =
*dentry, struct inode *inode,
>>                                  void *value, size_t size)
>> {
>>        ssize_t rc;
>> -       __u64 * pcreatetime;
>> +       __u64 *pcreatetime;
>>=20
>>        rc =3D cifs_revalidate_dentry_attr(dentry);
>>        if (rc)
>> @@ -244,7 +326,9 @@ static int cifs_xattr_get(const struct =
xattr_handler *handler,
>>                                full_path, name, value, size, =
cifs_sb);
>>                break;
>>=20
>> -       case XATTR_CIFS_ACL: {
>> +       case XATTR_CIFS_ACL:
>> +       case XATTR_CIFS_NTSD: {
>> +               /* the whole ntsd is fetched regardless */
>>                u32 acllen;
>>                struct cifs_ntsd *pacl;
>>=20
>> @@ -382,6 +466,26 @@ static const struct xattr_handler =
smb3_acl_xattr_handler =3D {
>>        .set =3D cifs_xattr_set,
>> };
>>=20
>> +static const struct xattr_handler cifs_cifs_ntsd_xattr_handler =3D {
>> +       .name =3D CIFS_XATTR_CIFS_NTSD,
>> +       .flags =3D XATTR_CIFS_NTSD,
>> +       .get =3D cifs_xattr_get,
>> +       .set =3D cifs_xattr_set,
>> +};
>> +
>> +/*
>> + * Although this is just an alias for the above, need to move away =
from
>> + * confusing users and using the 20 year old term 'cifs' when it is =
no
>> + * longer secure and was replaced by SMB2/SMB3 a long time ago, and
>> + * SMB3 and later are highly secure.
>> + */
>> +static const struct xattr_handler smb3_ntsd_xattr_handler =3D {
>> +       .name =3D SMB3_XATTR_CIFS_NTSD,
>> +       .flags =3D XATTR_CIFS_NTSD,
>> +       .get =3D cifs_xattr_get,
>> +       .set =3D cifs_xattr_set,
>> +};
>> +
>> static const struct xattr_handler cifs_posix_acl_access_xattr_handler =
=3D {
>>        .name =3D XATTR_NAME_POSIX_ACL_ACCESS,
>>        .flags =3D XATTR_ACL_ACCESS,
>> @@ -401,6 +505,8 @@ const struct xattr_handler *cifs_xattr_handlers[] =
=3D {
>>        &cifs_os2_xattr_handler,
>>        &cifs_cifs_acl_xattr_handler,
>>        &smb3_acl_xattr_handler, /* alias for above since avoiding =
"cifs" */
>> +       &cifs_cifs_ntsd_xattr_handler,
>> +       &smb3_ntsd_xattr_handler, /* alias for above since avoiding =
"cifs" */
>>        &cifs_posix_acl_access_xattr_handler,
>>        &cifs_posix_acl_default_xattr_handler,
>>        NULL
>> --
>> 2.14.5
>>=20
>=20
>=20
> --
> Thanks,
>=20
> Steve


Cheers, Andreas






--Apple-Mail=_AC13100A-3B43-4272-BAC9-050284FBD29F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl4c0n8ACgkQcqXauRfM
H+Co6Q//VJq2o0jyGN7qvjwSXarsRrCvm+E71eEKGbKl6vuUO5Aka4EbZmPcJ/39
WqUV/a5gT7zFWj2w769dTSepIi/HJAffv+IQ/FmKe1K6Qc3SaOWOLP17VOJZOznB
USdqXyPBgZ/8Ismyfh+D6zPgbzD518ORNz5gGCErCXkD064exbCKBcdP88eEK2ro
+cksLA9YWiYUQ6tUyyEL99W2llaYJLbCR3xQYWa5ASeNsHEFeeiGgKf/vzJed1Cg
mZTGUneT/8RExdpeXnNm2VKbj7kYexIUgya2xSgcB4c5Z+/HHDvyumNh4bVrdwfA
7pYSDtXX60n2EsxUq7Yobv9Y+SO6eNHzNeprbpo/4i1u3QcLgp69+fn/WoGjVFlG
PJsek9six1zazX4pHRrz8ysiMC5uM/gEsAVvc/TUhdUltCKNWafbpymsbMjLcWQl
toz6vr8nfWqQZVk6jNFTMLARvwei2qsfnDiSCWR1FLyyRf5OrsLtiao+hY0+7UpR
9R1YEACeZiOwX961KvM3bB5OL0k9vP+jsffH+1qA1A9GGixSWGIPo7do4k11kJi/
OnZxWXTzR9S1Nkl6LKUqug879fND5ajhZqcjsMo8C+AgUr6ItNb6Lw+WPbc+jclg
rrC5tSrV6oEKXkJluukSSJYaBgD9d95qs+g79JWrCC5ekfvPe/0=
=wvsJ
-----END PGP SIGNATURE-----

--Apple-Mail=_AC13100A-3B43-4272-BAC9-050284FBD29F--
