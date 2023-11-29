Return-Path: <linux-fsdevel+bounces-4256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 404377FE363
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99EA3B207CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A66A47A54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqlUqPgp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70AC8F;
	Wed, 29 Nov 2023 13:37:42 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50bc2e7f1e4so422657e87.1;
        Wed, 29 Nov 2023 13:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701293861; x=1701898661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6iDu2i/opAV7vxgDJpFdxC85eK3u1f4pMUMuRKAlTE=;
        b=BqlUqPgpfAvruMDKwohWEwoCL3qx5L+dm6zPWXRz8gSDuguAYoHFWR923vipBFn6it
         HbzWs5049r84ErBLhW7WbTNjHGxEZ2mgd2d+WeIPgufvapv2wMcXIg4F4PEnynTGiHK5
         JVDm4znCUbPQCXJi6CGzrdsGKfpkKfaN3psv8cDohmNMu5IDLVD7/wUEkSWakpA2fP/I
         Tf1aYHZI9EojkyrkGImuQepNrsDLyUH0oyu2aWN7VsvebBriMtqz0Emeas92Aas0jqQ2
         WW0bVcvohO3teihzqaR2ctARbm+qk9jM2WSVU/c7yZxZ3YyHr6SjOK3ThrooIjAaXBFN
         7iFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293861; x=1701898661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6iDu2i/opAV7vxgDJpFdxC85eK3u1f4pMUMuRKAlTE=;
        b=KMunmCHFQ/qKOo1kvzFqy0d9r54Fm4mdmJg23CG4RbX0rBWhifVSXWc81Z9IK2qVVZ
         9zt+pbubAuP31FahT44IugDPoaywOYuOVujud6AHABSUTjmk0lrnujCB8Imge7dS+j4P
         sr5gUimfh62aX/g5IMgQFTXZx3oS++b8YQ8tzZiepb1Pcfp8q/RtvdVEtLFXKW3p2ojw
         6kGfy9pPJjuLp4I28M0evo2FOYegX0lzPkmWuKre2gORc2fJdqUNI//r8IlboJb9gdBH
         Ah1RAGc3umUuhxADVvwpkDYZR62B1mMNV2YD4YCWJJN7Gc8HDYB1gNMu5suNDJ17WofC
         jang==
X-Gm-Message-State: AOJu0YxosL2GkvJWTVi5j2Oj/uIe/n0W5tnavjhb+1RsCDMGJ62li/vU
	GwNgtSYfea1ndRpOd/Rj5UC5hpsL3ZhFmlDCKfE=
X-Google-Smtp-Source: AGHT+IG9gufZvE3jDqZ8qWDTq84pWk1Wg5aunbT+pxf5lF2ZvF617lVdwCFbfNpFc2UmAlV+h5jUfInWDoEdy/xggR4=
X-Received: by 2002:a05:6512:3e24:b0:50b:c9b8:36b with SMTP id
 i36-20020a0565123e2400b0050bc9b8036bmr730049lfv.69.1701293860737; Wed, 29 Nov
 2023 13:37:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129165619.2339490-1-dhowells@redhat.com> <20231129165619.2339490-4-dhowells@redhat.com>
In-Reply-To: <20231129165619.2339490-4-dhowells@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 29 Nov 2023 15:37:29 -0600
Message-ID: <CAH2r5msHrKhH-Yvd9XLPS1uahwwNacwtNP8n5T1b+0-OsHf7zA@mail.gmail.com>
Subject: Re: [PATCH 3/3] cifs: Fix flushing, invalidation and file size with copy_file_range()
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
	Shyam Prasad N <nspmangalore@gmail.com>, Rohith Surabattula <rohiths.msft@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Fixed a minor whitespace issue, and tentatively added to cifs-2.6.git
for-next (all three) pending additional testing

On Wed, Nov 29, 2023 at 10:56=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> Fix a number of issues in the cifs filesystem implementation of the
> copy_file_range() syscall in cifs_file_copychunk_range().
>
> Firstly, the invalidation of the destination range is handled incorrectly=
:
> We shouldn't just invalidate the whole file as dirty data in the file may
> get lost and we can't just call truncate_inode_pages_range() to invalidat=
e
> the destination range as that will erase parts of a partial folio at each
> end whilst invalidating and discarding all the folios in the middle.  We
> need to force all the folios covering the range to be reloaded, but we
> mustn't lose dirty data in them that's not in the destination range.
>
> Further, we shouldn't simply round out the range to PAGE_SIZE at each end
> as cifs should move to support multipage folios.
>
> Secondly, there's an issue whereby a write may have extended the file
> locally, but not have been written back yet.  This can leaves the local
> idea of the EOF at a later point than the server's EOF.  If a copy reques=
t
> is issued, this will fail on the server with STATUS_INVALID_VIEW_SIZE
> (which gets translated to -EIO locally) if the copy source extends past t=
he
> server's EOF.
>
> Fix this by:
>
>  (0) Flush the source region (already done).  The flush does nothing and
>      the EOF isn't moved if the source region has no dirty data.
>
>  (1) Move the EOF to the end of the source region if it isn't already at
>      least at this point.
>
>      [!] Rather than moving the EOF, it might be better to split the copy
>      range into a part to be copied and a part to be cleared with
>      FSCTL_SET_ZERO_DATA.
>
>  (2) Find the folio (if present) at each end of the range, flushing it an=
d
>      increasing the region-to-be-invalidated to cover those in their
>      entirety.
>
>  (3) Fully discard all the folios covering the range as we want them to b=
e
>      reloaded.
>
>  (4) Then perform the copy.
>
> Thirdly, set i_size after doing the copychunk_range operation as this val=
ue
> may be used by various things internally.  stat() hides the issue because
> setting ->time to 0 causes cifs_getatr() to revalidate the attributes.
>
> These were causing the generic/075 xfstest to fail.
>
> Fixes: 620d8745b35d ("Introduce cifs_copy_file_range()")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/smb/client/cifsfs.c | 80 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 77 insertions(+), 3 deletions(-)
>
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index ea3a7a668b45..6db88422f314 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -1256,6 +1256,45 @@ static loff_t cifs_remap_file_range(struct file *s=
rc_file, loff_t off,
>         return rc < 0 ? rc : len;
>  }
>
> +/*
> + * Flush out either the folio that overlaps the beginning of a range in =
which
> + * pos resides (if _fstart is given) or the folio that overlaps the end =
of a
> + * range (if _fstart is NULL) unless that folio is entirely within the r=
ange
> + * we're going to invalidate.
> + */
> +static int cifs_flush_folio(struct inode *inode, loff_t pos, loff_t *_fs=
tart, loff_t *_fend)
> +{
> +       struct folio *folio;
> +       unsigned long long fpos, fend;
> +       pgoff_t index =3D pos / PAGE_SIZE;
> +       size_t size;
> +       int rc =3D 0;
> +
> +       folio =3D filemap_get_folio(inode->i_mapping, index);
> +       if (IS_ERR(folio)) {
> +               if (_fstart)
> +                       *_fstart =3D pos;
> +               *_fend =3D pos;
> +               return 0;
> +       }
> +
> +       size =3D folio_size(folio);
> +       fpos =3D folio_pos(folio);
> +       fend =3D fpos + size - 1;
> +       if (_fstart)
> +               *_fstart =3D fpos;
> +       *_fend =3D fend;
> +       if (_fstart && pos =3D=3D fpos)
> +               goto out;
> +       if (!_fstart && pos =3D=3D fend)
> +               goto out;
> +
> +       rc =3D filemap_write_and_wait_range(inode->i_mapping, fpos, fend)=
;
> +out:
> +       folio_put(folio);
> +       return rc;
> +}
> +
>  ssize_t cifs_file_copychunk_range(unsigned int xid,
>                                 struct file *src_file, loff_t off,
>                                 struct file *dst_file, loff_t destoff,
> @@ -1263,10 +1302,12 @@ ssize_t cifs_file_copychunk_range(unsigned int xi=
d,
>  {
>         struct inode *src_inode =3D file_inode(src_file);
>         struct inode *target_inode =3D file_inode(dst_file);
> +       struct cifsInodeInfo *src_cifsi =3D CIFS_I(src_inode);
>         struct cifsFileInfo *smb_file_src;
>         struct cifsFileInfo *smb_file_target;
>         struct cifs_tcon *src_tcon;
>         struct cifs_tcon *target_tcon;
> +       unsigned long long destend, fstart, fend;
>         ssize_t rc;
>
>         cifs_dbg(FYI, "copychunk range\n");
> @@ -1306,13 +1347,46 @@ ssize_t cifs_file_copychunk_range(unsigned int xi=
d,
>         if (rc)
>                 goto unlock;
>
> -       /* should we flush first and last page first */
> -       truncate_inode_pages(&target_inode->i_data, 0);
> +       /* The server-side copy will fail if the source crosses the EOF m=
arker.
> +        * Advance the EOF marker after the flush above to the end of the=
 range
> +        * if it's short of that.
> +        */
> +       if (src_cifsi->server_eof < off + len) {
> +               rc =3D src_tcon->ses->server->ops->set_file_size(
> +                       xid, src_tcon, smb_file_src, off + len, false);
> +               if (rc < 0)
> +                       goto unlock;
> +
> +               fscache_resize_cookie(cifs_inode_cookie(src_inode),
> +                                     i_size_read(src_inode));
> +       }
> +
> +       destend =3D destoff + len - 1;
> +
> +       /* Flush the folios at either end of the destination range to pre=
vent
> +        * accidental loss of dirty data outside of the range.
> +        */
> +       fstart =3D destoff;
> +
> +       rc =3D cifs_flush_folio(target_inode, destoff, &fstart, &fend);
> +       if (rc)
> +               goto unlock;
> +       if (destend > fend) {
> +               rc =3D cifs_flush_folio(target_inode, destend, NULL, &fen=
d);
> +               if (rc)
> +                       goto unlock;
> +       }
> +
> +       /* Discard all the folios that overlap the destination region. */
> +       truncate_inode_pages_range(&target_inode->i_data, fstart, fend);
>
>         rc =3D file_modified(dst_file);
> -       if (!rc)
> +       if (!rc) {
>                 rc =3D target_tcon->ses->server->ops->copychunk_range(xid=
,
>                         smb_file_src, smb_file_target, off, len, destoff)=
;
> +               if (rc > 0 && destoff + rc > i_size_read(target_inode))
> +                       truncate_setsize(target_inode, destoff + rc);
> +       }
>
>         file_accessed(src_file);
>
>
>


--=20
Thanks,

Steve

