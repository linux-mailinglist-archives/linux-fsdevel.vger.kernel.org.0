Return-Path: <linux-fsdevel+bounces-77395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG3KFj/BlGkwHgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 20:27:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C20F14FA48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 20:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F08A3015B44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 19:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55E8377565;
	Tue, 17 Feb 2026 19:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HvnoZR8z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42FB372B3E
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771356474; cv=pass; b=s1dpbbXr291olcTAUURjmaANzc3kMXT3HCvOzI14PnwZNseLPYr/6qwF92fLIDkewKXf1ZNK4hWB/IxHliPdUqo+PeVvIslUeoV5zXt5PzdiPs/TT2Hjs9Ho6IUjnrr22+QsKcLJhj4Z80uGZUbLcvylrAVkQzq6bC84wqzZgtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771356474; c=relaxed/simple;
	bh=2AkZD/xZt0VUvR9sJ0sGJHU4a65qrHn4YVu35A++2Jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHWcpbKTIRwcp/UMQBBFIbpK5E+ffFwZzbBOAGvnv5+nXdPxl+LVS6vyyoyD8eOaKnoMiD2QvCe24LIoFI1Ima0eT+gqB93tQqcpdcJgCVY+mWj5e2AQYlVXXV9J+pioWzvJiJKsUu7dITTAq3v3nPeZrjk/tPSuonDwyuZMWjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HvnoZR8z; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48318d08ec2so7725e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 11:27:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771356471; cv=none;
        d=google.com; s=arc-20240605;
        b=ArIEaoo4Uqpkqi0qgVtPsfkltgJGA128zyeqH+BREjjNdVQaEtHqrSXZ2hhUzIQMFZ
         8+UIuk0hIzmWYY2ASZgGEkQ/r2q2FKxwaGaocWAdbXfQiCLcIYaxJgVO7m4Oas1w45YM
         ciOS+T/aQnZNu36Qo2rvpNUWpf9A+iX7XkGZgkwL7Inci7JP4aUnJ+C4neIHo6j/rJMz
         TXWJPhU/zXVSwPtBwLICTnxLpqmCaYI05aH8KiHNoByT5GQbIqR3TfNz5qu7aPAe76dC
         hNOSBl7BcWbs0vQ/Gy+zPrnLhpAoFBUjv6gKLvGl/Fffkf2p9pAxDXIs3oRsxrtgKwI9
         L2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SbtQMFsGPA/6ldfqUOLBsftSiaWAN1XegIGnQQjLLP8=;
        fh=5Tda6Ca8Kww1YrEOgzPfAf3Vn5qOb4nApjNtmjaW/0I=;
        b=ZPvWwIFHqj/LMXdxdmiuL5gZjom5HRShNlcyKwNkgV2UBqt1GgYcEfQmQtZcsarAvy
         vRKAeaLI6Uh8cC60+BbRcwdrLGJFVJPHRlxb7rJRUSIG9NFIiUhfOhkzlRNnbrE0wWo2
         POEhCOnGinhGb8ZODlveSXtsXBzoJ1IMUi7t8Ae+D/b+rAXkuhwENbZNMCI7zYEcHjJh
         TjHRANxRLcBPnCcTPlq4oyjq74wtB52R3xqFoPBBFQnZ2Rty1zol5vjdsJd0orxvlFLb
         dHZi8iO+8wKZ2FKVWS6+IS1Q26QfJT9X06FD7w+VrSUuePA3tEISCOHkSXXxWVK9EtYW
         mrKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771356471; x=1771961271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbtQMFsGPA/6ldfqUOLBsftSiaWAN1XegIGnQQjLLP8=;
        b=HvnoZR8zfyEtT1CmYYfXEd0xZVj6smvvAGDvaTQENlihM6gnmvZajkehm3vadtH7Hp
         qg0dQLuTPri+dn9JwfsYHYW9Rmbpdxia0Sgny3asuglp0d8zRuMVLdChgN/1W2WPA9Dp
         Ty/akPoO/mprHf0Vl4gr9gxLNSIqCJT+DzOEXRDeKFET1VJ3vJ69iUKfFSCWqIISsK6r
         91m29W4YLDaBcOLbgI3SidxtX2pgsQmtjBuDauuRnNkFSWfTm0VE/KqYWHv3VvWrTt8S
         sUSTRr7pxadlKu/F/e1ud05UJ/o72NKYHWknk9YA53Dm0hhIfwHQPVD1LPS/1AHrY67c
         jJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771356471; x=1771961271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SbtQMFsGPA/6ldfqUOLBsftSiaWAN1XegIGnQQjLLP8=;
        b=uVgL0bCCR4AaJeqZnG4NCWbAT802DB4QrO8F5qFks3Sq/VjbYxMcGPuHq3BhSdevKp
         n8wtOOhr5X4DsVDM7zSqPhEWzCTKJTYs/9NItqEqnZcumjfRvmpNl1jgTF3raXJHgKrL
         Rf/WVJj2jgQF6ANmNcUFwgm/HDTBJWePnVIWke++WCi5fcbknyCBlhYX2zq8CbC5UE6l
         8yTL6MZfC2WaMIR9dMabrQCa5vaFDW/AtIv/gFJ+b8MYjcU6uDT3AMMyb3qjs3gTX7iI
         St1uxAZdbCMv2S6XKXS09JMJE1XxyNFU/XbGtEPbFzVHoqieu0UgvfWl7oXnNGly5sDt
         5Upw==
X-Forwarded-Encrypted: i=1; AJvYcCUt5ZBmBbon8DmTuVa4DpFSkY3Yu9eMZW8Lu/R6sjfq7RLCBE1owhNzlQUjyizZdrmjUP2a2rewMovz6So7@vger.kernel.org
X-Gm-Message-State: AOJu0YweB+e1gT8CucUPMVpUUvZ/ig8Y4AhNCQYZw4K9NuU78ezejdn6
	M1gDKm23jmLtgUm9NnXQL+l+7MiMRIjQUYWi3F+BKp9k9SFCZy4wWgafH7nV1Wf7WqWIoUODfxi
	g/1Ja/4bIxoc/QOiWEZTelhLYbyQxeo0+I03w5F8J
X-Gm-Gg: AZuq6aIXcsOudsYy52C4+/ZAsQP4WdSLgn0VuRL1oEPnt5DjN7dSP4jpQb6C2uRVxP8
	KLvuWEOv/Jf7uOBbzmZnzVaNBy4pvB4ZDceOtygM+7l81koMLGahxb+qkHfNaU2AxUvW7QKFZ14
	NxadEsggiJ4o8wedDHQjmroy09/fDKlzG4TGrdsWwcI/kJ1P6ksbr7PO4oy6rp1F3VY+3fmI7VF
	g9JVSDQJ5yJnFCrGD2J/bxQvr4n5+oBEKqd5nDoL9mPzubkFfdJ/YhBByilrthF+B2w179M4oCT
	EMvnaWa5oPbOykELaV7fL4P53F1S0v//mxEisxo0loYSVRtqByXPGN2oAbIxge/fmOeddQ==
X-Received: by 2002:a05:600c:6a0f:b0:477:86fd:fb49 with SMTP id
 5b1f17b1804b1-48388809dd1mr1315515e9.10.1771356470995; Tue, 17 Feb 2026
 11:27:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212215814.629709-1-tjmercier@google.com> <20260212215814.629709-2-tjmercier@google.com>
 <aZNFTR_gc6j116rw@amir-ThinkPad-T480>
In-Reply-To: <aZNFTR_gc6j116rw@amir-ThinkPad-T480>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 17 Feb 2026 11:27:38 -0800
X-Gm-Features: AaiRm50lkIkI0vTw0pKWrhRFJ18Z83k0MjgydYcYSeBtbsOtDjpOH99UjI76ZFk
Message-ID: <CABdmKX2DD4iapAGtdjJyb7CAHiS9RaD3pbuAnd=1tvudxfJkKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kernfs: allow passing fsnotify event types
To: Amir Goldstein <amir73il@gmail.com>
Cc: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, jack@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-77395-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2C20F14FA48
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 8:27=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, Feb 12, 2026 at 01:58:12PM -0800, T.J. Mercier wrote:
> > The kernfs_notify function is hardcoded to only issue FS_MODIFY events
> > since that is the only current use case. Allow for supporting other
> > events by adding a notify_event field to kernfs_elem_attr. The
> > limitation of only one queued event per kernfs_node continues to exist
> > as a consequence of the design of the kernfs_notify_list. The new
> > notify_event field is protected by the same kernfs_notify_lock as the
> > existing notify_next field.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
>
> Looks fine
> Feel free to add
> Acked-by: Amir Goldstein <amir73il@gmail.com>

Thanks Amir.

>
> > ---
> >  fs/kernfs/file.c       | 8 ++++++--
> >  include/linux/kernfs.h | 1 +
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> > index 9adf36e6364b..e978284ff983 100644
> > --- a/fs/kernfs/file.c
> > +++ b/fs/kernfs/file.c
> > @@ -914,6 +914,7 @@ static void kernfs_notify_workfn(struct work_struct=
 *work)
> >       struct kernfs_node *kn;
> >       struct kernfs_super_info *info;
> >       struct kernfs_root *root;
> > +     u32 notify_event;
> >  repeat:
> >       /* pop one off the notify_list */
> >       spin_lock_irq(&kernfs_notify_lock);
> > @@ -924,6 +925,8 @@ static void kernfs_notify_workfn(struct work_struct=
 *work)
> >       }
> >       kernfs_notify_list =3D kn->attr.notify_next;
> >       kn->attr.notify_next =3D NULL;
> > +     notify_event =3D kn->attr.notify_event;
> > +     kn->attr.notify_event =3D 0;
> >       spin_unlock_irq(&kernfs_notify_lock);
> >
> >       root =3D kernfs_root(kn);
> > @@ -954,7 +957,7 @@ static void kernfs_notify_workfn(struct work_struct=
 *work)
> >               if (parent) {
> >                       p_inode =3D ilookup(info->sb, kernfs_ino(parent))=
;
> >                       if (p_inode) {
> > -                             fsnotify(FS_MODIFY | FS_EVENT_ON_CHILD,
> > +                             fsnotify(notify_event | FS_EVENT_ON_CHILD=
,
> >                                        inode, FSNOTIFY_EVENT_INODE,
> >                                        p_inode, &name, inode, 0);
> >                               iput(p_inode);
> > @@ -964,7 +967,7 @@ static void kernfs_notify_workfn(struct work_struct=
 *work)
> >               }
> >
> >               if (!p_inode)
> > -                     fsnotify_inode(inode, FS_MODIFY);
> > +                     fsnotify_inode(inode, notify_event);
> >
> >               iput(inode);
> >       }
> > @@ -1005,6 +1008,7 @@ void kernfs_notify(struct kernfs_node *kn)
> >       if (!kn->attr.notify_next) {
> >               kernfs_get(kn);
> >               kn->attr.notify_next =3D kernfs_notify_list;
> > +             kn->attr.notify_event =3D FS_MODIFY;
> >               kernfs_notify_list =3D kn;
> >               schedule_work(&kernfs_notify_work);
> >       }
> > diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> > index b5a5f32fdfd1..1762b32c1a8e 100644
> > --- a/include/linux/kernfs.h
> > +++ b/include/linux/kernfs.h
> > @@ -181,6 +181,7 @@ struct kernfs_elem_attr {
> >       struct kernfs_open_node __rcu   *open;
> >       loff_t                  size;
> >       struct kernfs_node      *notify_next;   /* for kernfs_notify() */
> > +     u32                     notify_event;   /* for kernfs_notify() */
> >  };
> >
> >  /*
> > --
> > 2.53.0.273.g2a3d683680-goog
> >

