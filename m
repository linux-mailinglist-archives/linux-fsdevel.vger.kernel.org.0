Return-Path: <linux-fsdevel+bounces-4467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70407FF9CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFD5281633
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C805A0F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyLl9s6l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D0E10E5;
	Thu, 30 Nov 2023 09:30:07 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b4a8db314so10610425e9.3;
        Thu, 30 Nov 2023 09:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701365406; x=1701970206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SicxnPAtP6HNpzxxsxCGJVDSWVb1qgmi8jAyrMaP4xE=;
        b=KyLl9s6lpdf627cBhCo7Gn9rVeivDYgIggT0JnbCJm7t7gZQZ2uMN82tGZUjKFroBb
         h1J6YDMnipMLm0XHNsSyX5WCcqcMqrDLAiuG0zM0mgS2n1+Q5ylREh2KkuqMhdtYbsK+
         g+rAiGaaz50KHd4YeMA3Vwyt0DNBQPCNi6cyz53zDwkmNELmMuKIr19kvzs/KvTrYzDr
         /A8Dk6zxJ05uieM94umn5QxTTInJ3ReXPu07M6zDyE6GkDTzac0MpaDklycDvE5fmC5H
         XcAmpfyjG+i5zVjrRp1XBW4wHu3Z+l7qVQf1Rm4cF4ETw/EPuLf4bp7mcMGaUhHl4mGL
         ZgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701365406; x=1701970206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SicxnPAtP6HNpzxxsxCGJVDSWVb1qgmi8jAyrMaP4xE=;
        b=RMf03T7nWKrqR+qMi38REoeAhUB2B4gTZYxrzicAA/w+Sh1MyHLjtYzhf7rW5uTSeH
         FlVv2VQgqYzR/gGHO7XH3M9JVIsbNJ1AqBkPv8zFnS6VqzGrXL/cAd+DlyFERFFLJocp
         +WantUuNRLecrhlLN2yXP2jOjw8/6+C7EDWmrlUl9tcLh+jF5KzPFpJWvgzlIfpVp9L9
         6s/RK4DeqFa5PAJRZSPMpSaGpB7WNXwJi0QsyIGcyCk+yObjFVFX95Na+wsg0BOi0ULl
         rcxAhgfIbWjWYxnKdwZ2eJUMVM4fpqVPs41SXKpbq9DlD8FwWZ6xuWYcfpWKogRhmmW3
         mLrQ==
X-Gm-Message-State: AOJu0Yyusmc7puT/mZ2WYW7AWzKHoTmKN73OYxUh37zULoA/QOwuApPw
	Mv2L1JgwdDjz68oaUuwTVEPsqbShqcDnMnQfTfQx10kMgwh6MQ==
X-Google-Smtp-Source: AGHT+IF9AHPVeHOj80hoFrSbN5SdYfcMUZU7DK/ecVQVaMFPsYhqgizG5kwDo0XFHsh2y8ifJJzaYiTEJNS+paYjrpc=
X-Received: by 2002:ac2:5e75:0:b0:500:b2f6:592 with SMTP id
 a21-20020ac25e75000000b00500b2f60592mr8755lfr.50.1701364154839; Thu, 30 Nov
 2023 09:09:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129165619.2339490-1-dhowells@redhat.com> <20231129165619.2339490-4-dhowells@redhat.com>
 <CAH2r5msHrKhH-Yvd9XLPS1uahwwNacwtNP8n5T1b+0-OsHf7zA@mail.gmail.com>
In-Reply-To: <CAH2r5msHrKhH-Yvd9XLPS1uahwwNacwtNP8n5T1b+0-OsHf7zA@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Thu, 30 Nov 2023 11:08:43 -0600
Message-ID: <CAH2r5mvp0wsfSY_+dUv0i15jPYKiXBKo4U+M-WJTC2r-TK9ffQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] cifs: Fix flushing, invalidation and file size with copy_file_range()
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.com>, Shyam Prasad N <nspmangalore@gmail.com>, 
	Rohith Surabattula <rohiths.msft@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There is a minor problem with the patch in the change to
cifs_file_copychunk_range() in cifsfs.c.  With this change it can
attempt to set the file size using a file handle without write
permission  (in this path it is common for the source file to be
opened for read when doing a copy).  Fortunately I can't reproduce
that in any of my tests (because the file size is up to date and data
from source file was already flushed) but safer to fix it.

        /* The server-side copy will fail if the source crosses the EOF mar=
ker.
         * Advance the EOF marker after the flush above to the end of the r=
ange
         * if it's short of that.
         */
        if (src_cifsi->server_eof < off + len) {
                rc =3D src_tcon->ses->server->ops->set_file_size(
                        xid, src_tcon, smb_file_src, off + len, false);

This should be calling the path based equivalent to set the file size
so it can find a writeable file.

On Wed, Nov 29, 2023 at 3:37=E2=80=AFPM Steve French <smfrench@gmail.com> w=
rote:
>
> Fixed a minor whitespace issue, and tentatively added to cifs-2.6.git
> for-next (all three) pending additional testing
>
> On Wed, Nov 29, 2023 at 10:56=E2=80=AFAM David Howells <dhowells@redhat.c=
om> wrote:
> >
> > Fix a number of issues in the cifs filesystem implementation of the
> > copy_file_range() syscall in cifs_file_copychunk_range().
> >
> > Firstly, the invalidation of the destination range is handled incorrect=
ly:
> > We shouldn't just invalidate the whole file as dirty data in the file m=
ay
> > get lost and we can't just call truncate_inode_pages_range() to invalid=
ate
> > the destination range as that will erase parts of a partial folio at ea=
ch
> > end whilst invalidating and discarding all the folios in the middle.  W=
e
> > need to force all the folios covering the range to be reloaded, but we
> > mustn't lose dirty data in them that's not in the destination range.
> >
> > Further, we shouldn't simply round out the range to PAGE_SIZE at each e=
nd
> > as cifs should move to support multipage folios.
> >
> > Secondly, there's an issue whereby a write may have extended the file
> > locally, but not have been written back yet.  This can leaves the local
> > idea of the EOF at a later point than the server's EOF.  If a copy requ=
est
> > is issued, this will fail on the server with STATUS_INVALID_VIEW_SIZE
> > (which gets translated to -EIO locally) if the copy source extends past=
 the
> > server's EOF.
> >
> > Fix this by:
> >
> >  (0) Flush the source region (already done).  The flush does nothing an=
d
> >      the EOF isn't moved if the source region has no dirty data.
> >
> >  (1) Move the EOF to the end of the source region if it isn't already a=
t
> >      least at this point.
> >
> >      [!] Rather than moving the EOF, it might be better to split the co=
py
> >      range into a part to be copied and a part to be cleared with
> >      FSCTL_SET_ZERO_DATA.
> >
> >  (2) Find the folio (if present) at each end of the range, flushing it =
and
> >      increasing the region-to-be-invalidated to cover those in their
> >      entirety.
> >
> >  (3) Fully discard all the folios covering the range as we want them to=
 be
> >      reloaded.
> >
> >  (4) Then perform the copy.
> >
> > Thirdly, set i_size after doing the copychunk_range operation as this v=
alue
> > may be used by various things internally.  stat() hides the issue becau=
se
> > setting ->time to 0 causes cifs_getatr() to revalidate the attributes.
> >
> > These were causing the generic/075 xfstest to fail.
> >
> > Fixes: 620d8745b35d ("Introduce cifs_copy_file_range()")
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Steve French <sfrench@samba.org>
> > cc: Paulo Alcantara <pc@manguebit.com>
> > cc: Shyam Prasad N <nspmangalore@gmail.com>
> > cc: Rohith Surabattula <rohiths.msft@gmail.com>
> > cc: Matthew Wilcox <willy@infradead.org>
> > cc: Jeff Layton <jlayton@kernel.org>
> > cc: linux-cifs@vger.kernel.org
> > cc: linux-mm@kvack.org
> > ---
> >  fs/smb/client/cifsfs.c | 80 ++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 77 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> > index ea3a7a668b45..6db88422f314 100644
> > --- a/fs/smb/client/cifsfs.c
> > +++ b/fs/smb/client/cifsfs.c
> > @@ -1256,6 +1256,45 @@ static loff_t cifs_remap_file_range(struct file =
*src_file, loff_t off,
> >         return rc < 0 ? rc : len;
> >  }
> >
> > +/*
> > + * Flush out either the folio that overlaps the beginning of a range i=
n which
> > + * pos resides (if _fstart is given) or the folio that overlaps the en=
d of a
> > + * range (if _fstart is NULL) unless that folio is entirely within the=
 range
> > + * we're going to invalidate.
> > + */
> > +static int cifs_flush_folio(struct inode *inode, loff_t pos, loff_t *_=
fstart, loff_t *_fend)
> > +{
> > +       struct folio *folio;
> > +       unsigned long long fpos, fend;
> > +       pgoff_t index =3D pos / PAGE_SIZE;
> > +       size_t size;
> > +       int rc =3D 0;
> > +
> > +       folio =3D filemap_get_folio(inode->i_mapping, index);
> > +       if (IS_ERR(folio)) {
> > +               if (_fstart)
> > +                       *_fstart =3D pos;
> > +               *_fend =3D pos;
> > +               return 0;
> > +       }
> > +
> > +       size =3D folio_size(folio);
> > +       fpos =3D folio_pos(folio);
> > +       fend =3D fpos + size - 1;
> > +       if (_fstart)
> > +               *_fstart =3D fpos;
> > +       *_fend =3D fend;
> > +       if (_fstart && pos =3D=3D fpos)
> > +               goto out;
> > +       if (!_fstart && pos =3D=3D fend)
> > +               goto out;
> > +
> > +       rc =3D filemap_write_and_wait_range(inode->i_mapping, fpos, fen=
d);
> > +out:
> > +       folio_put(folio);
> > +       return rc;
> > +}
> > +
> >  ssize_t cifs_file_copychunk_range(unsigned int xid,
> >                                 struct file *src_file, loff_t off,
> >                                 struct file *dst_file, loff_t destoff,
> > @@ -1263,10 +1302,12 @@ ssize_t cifs_file_copychunk_range(unsigned int =
xid,
> >  {
> >         struct inode *src_inode =3D file_inode(src_file);
> >         struct inode *target_inode =3D file_inode(dst_file);
> > +       struct cifsInodeInfo *src_cifsi =3D CIFS_I(src_inode);
> >         struct cifsFileInfo *smb_file_src;
> >         struct cifsFileInfo *smb_file_target;
> >         struct cifs_tcon *src_tcon;
> >         struct cifs_tcon *target_tcon;
> > +       unsigned long long destend, fstart, fend;
> >         ssize_t rc;
> >
> >         cifs_dbg(FYI, "copychunk range\n");
> > @@ -1306,13 +1347,46 @@ ssize_t cifs_file_copychunk_range(unsigned int =
xid,
> >         if (rc)
> >                 goto unlock;
> >
> > -       /* should we flush first and last page first */
> > -       truncate_inode_pages(&target_inode->i_data, 0);
> > +       /* The server-side copy will fail if the source crosses the EOF=
 marker.
> > +        * Advance the EOF marker after the flush above to the end of t=
he range
> > +        * if it's short of that.
> > +        */
> > +       if (src_cifsi->server_eof < off + len) {
> > +               rc =3D src_tcon->ses->server->ops->set_file_size(
> > +                       xid, src_tcon, smb_file_src, off + len, false);
> > +               if (rc < 0)
> > +                       goto unlock;
> > +
> > +               fscache_resize_cookie(cifs_inode_cookie(src_inode),
> > +                                     i_size_read(src_inode));
> > +       }
> > +
> > +       destend =3D destoff + len - 1;
> > +
> > +       /* Flush the folios at either end of the destination range to p=
revent
> > +        * accidental loss of dirty data outside of the range.
> > +        */
> > +       fstart =3D destoff;
> > +
> > +       rc =3D cifs_flush_folio(target_inode, destoff, &fstart, &fend);
> > +       if (rc)
> > +               goto unlock;
> > +       if (destend > fend) {
> > +               rc =3D cifs_flush_folio(target_inode, destend, NULL, &f=
end);
> > +               if (rc)
> > +                       goto unlock;
> > +       }
> > +
> > +       /* Discard all the folios that overlap the destination region. =
*/
> > +       truncate_inode_pages_range(&target_inode->i_data, fstart, fend)=
;
> >
> >         rc =3D file_modified(dst_file);
> > -       if (!rc)
> > +       if (!rc) {
> >                 rc =3D target_tcon->ses->server->ops->copychunk_range(x=
id,
> >                         smb_file_src, smb_file_target, off, len, destof=
f);
> > +               if (rc > 0 && destoff + rc > i_size_read(target_inode))
> > +                       truncate_setsize(target_inode, destoff + rc);
> > +       }
> >
> >         file_accessed(src_file);
> >
> >
> >
>
>
> --
> Thanks,
>
> Steve



--=20
Thanks,

Steve

