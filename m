Return-Path: <linux-fsdevel+bounces-4531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32584800196
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 03:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D9E1C20AD3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 02:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EDE4426
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 02:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="desUbD1p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D907E10D0;
	Thu, 30 Nov 2023 16:50:01 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bc8b7d8ffso2332662e87.0;
        Thu, 30 Nov 2023 16:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701391800; x=1701996600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqzRhhGrZoC77SS6CL7pdFs8CHWp/wWWuAFxkrL+mk4=;
        b=desUbD1phZdDlM/KDCekwDVj880QStk63dP6k6hYPs950RQ5JLFQK2T13YNlqtUjh9
         cQYhLZY9clfP8hPtBifjEXedR3UwzSVvm1Xy7augAQ+oCCrfYIkGqrF5Ny4h5Tr9lFOh
         vX5eXHcSyg5ZVFVacSnSsrjPzrTe3MCMe/vuU2zJ/9Pc4CB1ftDACz/qQMbrC8Lm/+7J
         nTmmgap+q1h9nLzFACfDFLWKMyO78GSmItpIQEh1vzNI5IlFbVIgfbdWH5V4OOtB+4jr
         KZBTVKZAukiRbiO5Y1HpCtjVW/kgO+OjGlKCZcTTnTdvSrjtclPkOi7M5x83NE8kLK58
         nPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701391800; x=1701996600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqzRhhGrZoC77SS6CL7pdFs8CHWp/wWWuAFxkrL+mk4=;
        b=jdPcmQfTQM5KJhJbp/D/AmRE75tTwSGSmubLnM4KzpSha13bGe1gnAvmSQkuUcpP+L
         kHsARUACNt06GOfEldkl5XM+plDqoImDj5qmZEjImNubqmecFzvPnHgMkjthquA1EbM7
         SUpllw7xH0ifagh7X6qVqAp0iOnIubHPGs6Hf87ba8QoGNNeB7obS0RH1YwWG0h2VQPl
         ISRQ7PkNSC34BzhcQWXYTbXAfuBC3CJBCcGKBPNOkDwPwAmP5N/Xh0617UWi/86HKjJ8
         tQIe+B6Fwd+Kd7tksnEdOi7ItvhLevihehT4WRHgS/ICU4ZWviwF7cza/TLkMLJ0lKBp
         DwDg==
X-Gm-Message-State: AOJu0YzmZytB0mkUmV6hMccv0Ca0cr57DKk9mrjIsd+nG72PIA3WqYxS
	Hf/ltSCy+Ak0NWYwe1O9wgx7YLsbQyYp6hZjRtU=
X-Google-Smtp-Source: AGHT+IGkaaqQCCGExitNdERhjSlPmkgnOyZ+fu0oCv4R1hJOoipxICR+Px6hgYy1FF10R3vkHk4hg9Czpa2BWVBmTeE=
X-Received: by 2002:ac2:59dc:0:b0:50b:d764:2919 with SMTP id
 x28-20020ac259dc000000b0050bd7642919mr133143lfn.177.1701391799795; Thu, 30
 Nov 2023 16:49:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201002201.2981258-1-dhowells@redhat.com> <20231201002201.2981258-3-dhowells@redhat.com>
In-Reply-To: <20231201002201.2981258-3-dhowells@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Thu, 30 Nov 2023 18:49:48 -0600
Message-ID: <CAH2r5mu7e5-ORZbUyutteWVx2Nk6FPHfx7mMGCWSCEBAO6tdqg@mail.gmail.com>
Subject: Re: [PATCH 2/2] cifs: Fix flushing, invalidation and file size with FICLONE
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
	Shyam Prasad N <nspmangalore@gmail.com>, Rohith Surabattula <rohiths.msft@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged the two into cifs-2.6.git for-next pending additional testing
and review (added Cc: stable as well)

On Thu, Nov 30, 2023 at 6:22=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Fix a number of issues in the cifs filesystem implementation of the FICLO=
NE
> ioctl in cifs_remap_file_range().  This is analogous to the previously
> fixed bug in cifs_file_copychunk_range() and can share the helper
> functions.
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
> idea of the EOF at a later point than the server's EOF.  If a clone reque=
st
> is issued, this will fail on the server with STATUS_INVALID_VIEW_SIZE
> (which gets translated to -EIO locally) if the clone source extends past
> the server's EOF.
>
> Fix this by:
>
>  (0) Flush the source region (already done).  The flush does nothing and
>      the EOF isn't moved if the source region has no dirty data.
>
>  (1) Move the EOF to the end of the source region if it isn't already at
>      least at this point.  If we can't do this, for instance if the serve=
r
>      doesn't support it, just flush the entire source file.
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
>  (4) Then perform the extent duplication.
>
> Thirdly, set i_size after doing the duplicate_extents operation as this
> value may be used by various things internally.  stat() hides the issue
> because setting ->time to 0 causes cifs_getatr() to revalidate the
> attributes.
>
> These were causing the cifs/001 xfstest to fail.
>
> Fixes: 04b38d601239 ("vfs: pull btrfs clone API to vfs layer")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/smb/client/cifsfs.c | 68 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 57 insertions(+), 11 deletions(-)
>
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index 8097a9b3e98c..c5fc0a35bb19 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -1268,9 +1268,12 @@ static loff_t cifs_remap_file_range(struct file *s=
rc_file, loff_t off,
>  {
>         struct inode *src_inode =3D file_inode(src_file);
>         struct inode *target_inode =3D file_inode(dst_file);
> +       struct cifsInodeInfo *src_cifsi =3D CIFS_I(src_inode);
> +       struct cifsInodeInfo *target_cifsi =3D CIFS_I(target_inode);
>         struct cifsFileInfo *smb_file_src =3D src_file->private_data;
> -       struct cifsFileInfo *smb_file_target;
> -       struct cifs_tcon *target_tcon;
> +       struct cifsFileInfo *smb_file_target =3D dst_file->private_data;
> +       struct cifs_tcon *target_tcon, *src_tcon;
> +       unsigned long long destend, fstart, fend, new_size;
>         unsigned int xid;
>         int rc;
>
> @@ -1281,13 +1284,13 @@ static loff_t cifs_remap_file_range(struct file *=
src_file, loff_t off,
>
>         xid =3D get_xid();
>
> -       if (!src_file->private_data || !dst_file->private_data) {
> +       if (!smb_file_src || !smb_file_target) {
>                 rc =3D -EBADF;
>                 cifs_dbg(VFS, "missing cifsFileInfo on copy range src fil=
e\n");
>                 goto out;
>         }
>
> -       smb_file_target =3D dst_file->private_data;
> +       src_tcon =3D tlink_tcon(smb_file_src->tlink);
>         target_tcon =3D tlink_tcon(smb_file_target->tlink);
>
>         /*
> @@ -1300,20 +1303,63 @@ static loff_t cifs_remap_file_range(struct file *=
src_file, loff_t off,
>         if (len =3D=3D 0)
>                 len =3D src_inode->i_size - off;
>
> -       cifs_dbg(FYI, "about to flush pages\n");
> -       /* should we flush first and last page first */
> -       truncate_inode_pages_range(&target_inode->i_data, destoff,
> -                                  PAGE_ALIGN(destoff + len)-1);
> +       cifs_dbg(FYI, "clone range\n");
> +
> +       /* Flush the source buffer */
> +       rc =3D filemap_write_and_wait_range(src_inode->i_mapping, off,
> +                                         off + len - 1);
> +       if (rc)
> +               goto unlock;
> +
> +       /* The server-side copy will fail if the source crosses the EOF m=
arker.
> +        * Advance the EOF marker after the flush above to the end of the=
 range
> +        * if it's short of that.
> +        */
> +       if (src_cifsi->netfs.remote_i_size < off + len) {
> +               rc =3D cifs_precopy_set_eof(src_inode, src_cifsi, src_tco=
n, xid, off + len);
> +               if (rc < 0)
> +                       goto unlock;
> +       }
> +
> +       new_size =3D destoff + len;
> +       destend =3D destoff + len - 1;
>
> -       if (target_tcon->ses->server->ops->duplicate_extents)
> +       /* Flush the folios at either end of the destination range to pre=
vent
> +        * accidental loss of dirty data outside of the range.
> +        */
> +       fstart =3D destoff;
> +       fend =3D destend;
> +
> +       rc =3D cifs_flush_folio(target_inode, destoff, &fstart, &fend, tr=
ue);
> +       if (rc)
> +               goto unlock;
> +       rc =3D cifs_flush_folio(target_inode, destend, &fstart, &fend, fa=
lse);
> +       if (rc)
> +               goto unlock;
> +
> +       /* Discard all the folios that overlap the destination region. */
> +       cifs_dbg(FYI, "about to discard pages %llx-%llx\n", fstart, fend)=
;
> +       truncate_inode_pages_range(&target_inode->i_data, fstart, fend);
> +
> +       fscache_invalidate(cifs_inode_cookie(target_inode), NULL,
> +                          i_size_read(target_inode), 0);
> +
> +       rc =3D -EOPNOTSUPP;
> +       if (target_tcon->ses->server->ops->duplicate_extents) {
>                 rc =3D target_tcon->ses->server->ops->duplicate_extents(x=
id,
>                         smb_file_src, smb_file_target, off, len, destoff)=
;
> -       else
> -               rc =3D -EOPNOTSUPP;
> +               if (rc =3D=3D 0 && new_size > i_size_read(target_inode)) =
{
> +                       truncate_setsize(target_inode, new_size);
> +                       netfs_resize_file(&target_cifsi->netfs, new_size)=
;
> +                       fscache_resize_cookie(cifs_inode_cookie(target_in=
ode),
> +                                             new_size);
> +               }
> +       }
>
>         /* force revalidate of size and timestamps of target file now
>            that target is updated on the server */
>         CIFS_I(target_inode)->time =3D 0;
> +unlock:
>         /* although unlocking in the reverse order from locking is not
>            strictly necessary here it is a little cleaner to be consisten=
t */
>         unlock_two_nondirectories(src_inode, target_inode);
>
>


--=20
Thanks,

Steve

