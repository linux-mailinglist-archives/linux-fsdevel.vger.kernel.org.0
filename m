Return-Path: <linux-fsdevel+bounces-75891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPlxEfi4e2k0IAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 20:46:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F604B4136
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 20:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 882A33014137
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 19:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D575A3128AE;
	Thu, 29 Jan 2026 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBGfcpUv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100CF2C327D
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769715957; cv=pass; b=N2ZkS00YaAJbmFeTliTKxXfpp3pgfIBkwzKYQB0DdY9iqZhDyTt+BiiBFBjRHZ4g3xTtN1YSjIBqoiHuF0bQtnkrO4Xsz1DwRMkGrHFtTqPvccTjf9LdTXhvK0ZcoNX9cgigeMu94yLIJ+1ILuN2tvvR9FMnWwie4i/5wzZq198=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769715957; c=relaxed/simple;
	bh=B/5j4PzkJlrj0w/vrdeg49z6Qvog/M+IxOd/iStNZ88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPAkbvPa/FHhPmqpyBps7jXKx+w53oBfO7o0RmchNsJbJj2AzsJ5eBreXfqauUI7dDtwrQJNh7LPVWOHmApBwZQ4EzMFWWLSZXGOhcNf8m3lXcnffZpj/7Udg6NfSeZahXpZks6ndh/2UFrxPmTc+EUhHh2uxAKOeEpEdaVShBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBGfcpUv; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5014f383df6so9732841cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 11:45:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769715955; cv=none;
        d=google.com; s=arc-20240605;
        b=DNuSVe6Uu6Z7Cs7DKnZZfqjk0UZGrKPmGfrMyeovasRZbMpHp/l9ECiqUFKOBj/U03
         BdLVDZxa2pClGExmNuE6MdJkkIFGRZ7wdekuzq+43Fn+OxrNY/SFOYHA67dX6AG515Yt
         szWkjtnN+g8oIkjqj9QPoyR8r92U2jHciNFBuMzk+BMD3vZeger/odhv/n2gohS/Kzbh
         cqGGUVq75HzAZI/nYiDYGYYJ/OLzl27QX3TAYhPBv5dVbMdiskFG3uClovIaV9mUVFuS
         ythQoRk+Y1+QVgADRfqSkEcn46d7w++/yIDtZa+Xm4v5NR7f8oV1G6W1AiayHe1BL9JU
         Uycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PJp5op5O87rlBlpEECYO8TNxjCcSIg3DISm9KRAyNaQ=;
        fh=NpsyGfBWDS7sU1TXOumdVz5h2FZp7djPwdnc2qxMGCs=;
        b=TT0JaJs9TxdV2+zwwBdQui28QnDqPSInOsV44C5RdyRSspTDxP9mdC4jm6LORbfeug
         aADS7ZkRYCQevbcY2MFkJNmX3tkshA4rfsYogL0obY6EIWP88APOOF1pZZ4NMFVH5FmC
         sQ1mVt0SyLlR5D4Fsq+SL47ukxfItWxPyhJx/W9MCNSc8FK8QeNq1adPJPeOzPoWo2hj
         9/Mpm/zAJr2o7lHePNFcwK4a1bGrqFP/F74bAOttPw6AV/FAFoGvk7BDwyqd+BbpGUo7
         lScWu0fu0aa/DZO/nwGw/qCwBTpBQoJftfdxKk38ooSeE082mb8ruATVoU1UyTLv4w0C
         mxJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769715955; x=1770320755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJp5op5O87rlBlpEECYO8TNxjCcSIg3DISm9KRAyNaQ=;
        b=WBGfcpUvngEHlkzgWcinzA1KENrNviyjRwfOtoLJ0vwI4ZIOEpbr2z2V02f1D8N1DM
         NrxyIIkCkoE8we4ICqGmNWIxdWQ6Qwa4yuU1BbsCg+q5VJqXap+8JyB0ebuD4ZE4/9dU
         BRi1QRkr1ghMOKskcJovKfozzvFHuyZDFyM1h0xTKx12i5wqgvNWcCGwLrM9vW8rZBmK
         BqrB/J023d/kXveAaraB5c7EcuyacAE/O0yS5CaQtBhspc4kwr8vhKUfwWV1Jijyjlnl
         rI15TEJ5IX//mg6o2otK2TEm6nL+xUN+6/oLvVgvEwnGc0DgjpiCXSZZkbNb+4pUOPnF
         +XwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769715955; x=1770320755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PJp5op5O87rlBlpEECYO8TNxjCcSIg3DISm9KRAyNaQ=;
        b=WD85P8Dk7WUxplnZwYrKPx9yTlTzMl1nZdB45jGkttQmJHAG1LHa8l5Gc8PbNlzlXt
         bwJe/yHwali//GKbU8RM9VQRPez/fZDZl8TLeumMY4mcACHBNttO9OQWy4aatBbZP6ft
         2BBy4gynalz+mYSwGJzAUazLvrdml5vzON8iQpO1TTa7wQfoQcjF1w7Ei9MGaomzldpy
         B1LZKTm/MYSChBy59fv1YZ4r9dA6GzhCRPRldLhR2G/9RyQzeGwnqu0Tsag0DpB6CnIv
         acjZAOVr8oxcj1a610T0vIkLcW1e20I6nhhSjSA5J6bJ6B3Sjiune/Y2N/li/bpwxxnN
         VaUw==
X-Forwarded-Encrypted: i=1; AJvYcCUD2vsSYjonK9fd5gTV65yuGQiIs5xovs55dH03rOjJumDuHkPOrMZfUayD43Y+DKdovSc7TC4JEsrmh1Eh@vger.kernel.org
X-Gm-Message-State: AOJu0YyAl/VcZ+FrFgwmU1WX6VrH4drSgiYfeQt9vujXDJSRfkGeejlC
	SUsVwb2kv6qELEczIy3kTFwqvtJGBw86ejA8y8fLRUlb7+y3u8niwLKQznpOVTdtWXHhypeM8+X
	K3/9n7SEPY+pBIHCXOAtv4usQN7rY1Is=
X-Gm-Gg: AZuq6aL7+iG1IC2M+ivsN/PgqdCajYzp6TTn4qGYg4UyLh8QqfObHLqVfxAUFNKHJBO
	2CbEg4o7l5jVHm0hI6Rn/fLFHQl90IrbQefFYLV3ZnmCjFNn7fZSiCisiKRuAnuu9PMJKg1slZN
	ehvIpYzw2AIi19kQRka6Sikc8yjiIIaA8utfDDBbf2EXBSkrU2e55JLk/Q+XG8eCYB+fK35hzYk
	8p2Fj+wFXwY0fvRJesR+3dxsW5g4od5NNgztPriajJ/QzrdSRIUe5M7x7fhM92yuQl/2w==
X-Received: by 2002:ac8:5d52:0:b0:503:2f41:aba2 with SMTP id
 d75a77b69052e-505d225f5d1mr6660371cf.54.1769715954944; Thu, 29 Jan 2026
 11:45:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120224449.1847176-1-joannelkoong@gmail.com>
 <20260120224449.1847176-2-joannelkoong@gmail.com> <20260121000310.GF15532@frogsfrogsfrogs>
 <20260121000654.GG15532@frogsfrogsfrogs>
In-Reply-To: <20260121000654.GG15532@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 29 Jan 2026 11:45:44 -0800
X-Gm-Features: AZwV_QjO3FXd0QRKTiIB3STNcemlQWPZsgHA_TcN74vKXGi0bk7a6lrpOmmwXjk
Message-ID: <CAJnrk1Yf4mBZwX-6RBQgc-C+Duk_dUi1185YfSAJ26xn-hZK5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] fuse: validate outarg offset and size in notify store/retrieve
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, jefflexu@linux.alibaba.com, luochunsheng@ustc.edu, 
	horst@birthelmer.de, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75891-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8F604B4136
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 4:06=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Tue, Jan 20, 2026 at 04:03:10PM -0800, Darrick J. Wong wrote:
> > On Tue, Jan 20, 2026 at 02:44:46PM -0800, Joanne Koong wrote:
> > > Add validation checking for outarg offset and outarg size values pass=
ed
> > > in by the server. MAX_LFS_FILESIZE is the maximum file size supported=
.
> > > The fuse_notify_store_out and fuse_notify_retrieve_out structs take i=
n
> > > a uint64_t offset.
> > >
> > > Add logic to ensure:
> > > * outarg.offset is less than MAX_LFS_FILESIZE
> > > * outarg.offset + outarg.size cannot exceed MAX_LFS_FILESIZE
> > > * potential uint64_t overflow is fixed when adding outarg.offset and
> > >   outarg.size.
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >  fs/fuse/dev.c | 14 ++++++++++----
> > >  1 file changed, 10 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > index 6d59cbc877c6..7558ff337413 100644
> > > --- a/fs/fuse/dev.c
> > > +++ b/fs/fuse/dev.c
> > > @@ -1781,7 +1781,11 @@ static int fuse_notify_store(struct fuse_conn =
*fc, unsigned int size,
> > >     if (size - sizeof(outarg) !=3D outarg.size)
> > >             return -EINVAL;
> > >
> > > +   if (outarg.offset >=3D MAX_LFS_FILESIZE)
> >
> > Hrmm.  Normally I'd recommend generic_write_check_limits, but you don't
> > actually have a struct file.
> >
> > Being pedantic, you might want to check this against
> > super_block::s_maxbytes, though the current fuse codebase doesn't
> > support any value other than MAX_LFS_FILESIZE.
> >
> > (fuse-iomap will allow servers to lower s_maxbytes)

Hmm... that's a good point about fuse-iomap. I'll change this to
compare against inode->i_sb->s_maxbytes.

> >
> > > +           return -EINVAL;
> > > +
> > >     nodeid =3D outarg.nodeid;
> > > +   num =3D min(outarg.size, MAX_LFS_FILESIZE - outarg.offset);
> > >
> > >     down_read(&fc->killsb);
> > >
> > > @@ -1794,13 +1798,12 @@ static int fuse_notify_store(struct fuse_conn=
 *fc, unsigned int size,
> > >     index =3D outarg.offset >> PAGE_SHIFT;
> > >     offset =3D outarg.offset & ~PAGE_MASK;
> > >     file_size =3D i_size_read(inode);
> > > -   end =3D outarg.offset + outarg.size;
> > > +   end =3D outarg.offset + num;
> > >     if (end > file_size) {
> > >             file_size =3D end;
> > > -           fuse_write_update_attr(inode, file_size, outarg.size);
> > > +           fuse_write_update_attr(inode, file_size, num);
> > >     }
> > >
> > > -   num =3D outarg.size;
> > >     while (num) {
> > >             struct folio *folio;
> > >             unsigned int folio_offset;
> > > @@ -1880,7 +1883,7 @@ static int fuse_retrieve(struct fuse_mount *fm,=
 struct inode *inode,
> > >     num =3D min(outarg->size, fc->max_write);
> > >     if (outarg->offset > file_size)
> > >             num =3D 0;
> > > -   else if (outarg->offset + num > file_size)
> > > +   else if (num > file_size - outarg->offset)
> > >             num =3D file_size - outarg->offset;
> > >
> > >     num_pages =3D (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > > @@ -1962,6 +1965,9 @@ static int fuse_notify_retrieve(struct fuse_con=
n *fc, unsigned int size,
> > >
> > >     fuse_copy_finish(cs);
> > >
> > > +   if (outarg.offset >=3D MAX_LFS_FILESIZE)
> >
> > Can this actually happen?  It's strange to succeed at injecting data
> > into the pagecache but then fail anyway.
>
> Oh silly me, this is a different function.  I think the above hunk
> prevents this scenario from happening, doesn't it?

outarg.offset is set by the server and could be any uint64_t value.

Thanks,
Joanne


>
> --D
>
> > --D
> >
> > > +           return -EINVAL;
> > > +
> > >     down_read(&fc->killsb);
> > >     err =3D -ENOENT;
> > >     nodeid =3D outarg.nodeid;
> > > --
> > > 2.47.3
> > >
> > >
> >

