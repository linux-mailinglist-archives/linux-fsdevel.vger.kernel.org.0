Return-Path: <linux-fsdevel+bounces-74294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 710D4D38FEF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 18:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7B1E3009692
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 17:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7730D274B51;
	Sat, 17 Jan 2026 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOIMF3mZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3945026CE34
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jan 2026 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768669275; cv=pass; b=q47czTVIS9EBM5YGbhk3+teQxadofUO9teufgmxSpNRNxKPX7AbrbKlTnR4DL6iRr4QqerkvyIPcUwd0H8kXrV/h7tUytwnW1rIF3laclISn82OFMjNta0fFAsrCDN9NqfXkzfaZj5xKqERSxx69aMdZBviTA2tfrrq89Xeyp+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768669275; c=relaxed/simple;
	bh=LhXWAHr6tGQpF4ISqyO62s5Xs9Bz8IgyYp+4vB3OhsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NuD/FUfduQy5Cvgmb1G0Ddlxc2HgZIYCPbnyQZnqtUIUEYQMK/fQhSkisr49+PXYteNFStck0JhtvDhLmfetFyjdB3uKu5eVhYhOU1+eKTq/v4IHR2SyG5Pwa8WJ3lkl0gpzUiXYy4fsOoBBEtzvbobhspA59cT4i5q6hl/XBW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOIMF3mZ; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65063a95558so4644536a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jan 2026 09:01:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768669268; cv=none;
        d=google.com; s=arc-20240605;
        b=DIts136lqFf5qTFQq7EAFZ9XEFgf1NirhFieP8Li808HY50K9X6aHqGaGtBGAG8lIZ
         0aUntNZzdNM/1/m09OTLxN8UhMVAjNJ8CdLu9l+ufLTem70/VhyDZ+r+4uKYMMCUxTbc
         1GSZ7cGEnjAjay+nBMK7MAUVLpwtLwjHoOzypXYa6KGH8JvJckv5M62iOjKeYuhiYRnY
         oXK3tknVBwUXweY392pLBpYK82cobIX0ZlMn7bw5V0wvJwhueAyo90+Oxtf4/TogUWBK
         sD0sni+hZa3uNStkXVFDD3a/6aZ/0/uYcfcgkkID0tPUf2dDLD6m6o8OGy+hfjKslm4R
         UIsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sDeFfSiCWRb4Wi9kMkBuWPeE4sBDZHUr/RnZzUZMGaA=;
        fh=sY6ora8JbjsgpzUiLYHKEa7QYtiSZ73D4AJ1QRgoHJU=;
        b=gkXiJZRSzj1KzNhzRiNg87EIwpBZAyr+jsdk16HRPJ5CikceQdA3Da41hTOB5q7i7j
         5a4AviDqPGxxizlalmbfqajFOIiZZjUe9CkCc/QVwZDu46TEmwniCqa+2hATjkGw6u7i
         2uQcW7hKGgtxEfNKI0KDwvwRPqHmE7dpKb9GTLtKEIqQHKuJFbNXDDxOeOOiZlqQGX06
         8JaP43laWO1XoHtD4vdFaprWZzYE+PGpxZMaJaDb1ztSF2crMAA8JBBlwp7ughce6cGI
         gWZLaU3sQzyR09QNlTixoBBYSoYRa0PKpIKnhBUOSfc/6qoJ4wcsZH92xm/faRYPQnyW
         5ByA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768669268; x=1769274068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDeFfSiCWRb4Wi9kMkBuWPeE4sBDZHUr/RnZzUZMGaA=;
        b=aOIMF3mZrTZaWpdys1eybR1mcn0NXU5XJCyMCeNbhoGFOvm5v6vqr0gK39UF38B25/
         2V+tE6I6oKBZlh+MHiuEz5tqD65LPjsv78YVYGenXNdD4DB3JRhXyUVAV5kEbj13S5LO
         jjpSARfPxZse9V2BYi/jnSym3FQ0dAO3k9m1doUwmnNTYWcTXWt5oSsqonXs5suUjTmt
         KMGo3aTqA6kxOXKwpndCGILNhTXVgVAeDX4YL5inWBJSNBH3W8L/pXrDHw7N8FDHRCSv
         R+9MIA2sObcaZhShV3vRw6DNwO1CcrLT+ZvGkW561baL42GqT1SJsjOuxNsb12Edl5AC
         mDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768669268; x=1769274068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sDeFfSiCWRb4Wi9kMkBuWPeE4sBDZHUr/RnZzUZMGaA=;
        b=XYQFZKAb/yB/AOHqgmvpEzsUQnXj2hFShraiNC4bSTgN4alsc9DfBMY1gd38Nxr5tb
         gE/YFu8Wva5gVbZ9tILx14468WpHg/pqx1lwnENmMs+5JEm0sFjrPIWbwwn1QRxuAXnk
         RAvddYqYyCVSf5k3ynC/9wCZEqnbunBdG66ejCGyW0EJnfHZL9dysQyrYEQnjYm38fne
         RulrVD/HQ9kJGpaa71m6o2rKpjaG793vVjBqwhDTibGnc91OwTYcEpVNyuSZfSArS3zr
         vElQoRgPZiQCFq4Q4Ryq7NqseeQqDV29hxIuX1FNip1OrhabLVLjCIvArglUPLeyOmLh
         xW5g==
X-Forwarded-Encrypted: i=1; AJvYcCVHpib9hf+iTevaTtGLa5o4gdroZecfdtarGzAOro/zUjRRj4ZEN9ewilu4rJHW0xuKCLw/jaI34/ATlpyN@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+arPqCcT+3L9Ouijq6pAvgkM8GPNT641iGoFOa+GJhBZN6f43
	UzkQ3gfJ7TnmlvAhtOicttifYqj60Yb8EQDguLEKYOEJgKkXE/P3XKTOHXtNl93XAL+n2BBiy7D
	+orJTP7afm9KkCeSPVtQXN4TGU717bD0=
X-Gm-Gg: AY/fxX5OgEjfd5VJtqFPAPf4f4DDfYfZfHasUItmKEzHaO65PYOcQ2RK2BWtQEwnNW6
	uzCeNzFZBjq6hm24NWFLQENDAgq7JcmH5NY0k0nntWOwhz6ipir2nnZmAZaAJJYI6MmUwcotWW6
	wsEgymFU77kHIwIHkJZCzKnXLBerfFrzoS0mLIemRlqq+PIcx50fgH6pilW8OfHktDo08a8WRIW
	zZ0jgld6d2wCONqNR8ibvNFA8L3bQog0LIwFtd8yeJNawgtWyeILlv32Fo6cgKlVHDNjXvJ2g01
	8Cs29YqJBBKmumU67YlKCrsJ3vAFv42qRcaHiNR0
X-Received: by 2002:a05:6402:27cf:b0:650:f4dd:182c with SMTP id
 4fb4d7f45d1cf-65452bd5374mr4702137a12.23.1768669267868; Sat, 17 Jan 2026
 09:01:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116142845.422-1-luochunsheng@ustc.edu> <20260116142845.422-2-luochunsheng@ustc.edu>
 <CAOQ4uxg13jAJyG8b3CpjKE8FXn3ce=yUCzw+Qc=k29si=FtXaQ@mail.gmail.com> <428db714-5ec8-4259-b808-b8784153d4f2@ustc.edu>
In-Reply-To: <428db714-5ec8-4259-b808-b8784153d4f2@ustc.edu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 17 Jan 2026 18:00:56 +0100
X-Gm-Features: AZwV_QgXINRxiH4g16t9yt5pfJJdX4UvJA3jwVR7b5D7T8QF9rDbgk8ltjT08rI
Message-ID: <CAOQ4uxhgOk2Ati81vqEkgWFODkW_gkB7Z7wj0x1A8RX38wLSRA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: add ioctl to cleanup all backing files
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 17, 2026 at 5:14=E2=80=AFPM Chunsheng Luo <luochunsheng@ustc.ed=
u> wrote:
>
>
>
> On 1/16/26 11:39 PM, Amir Goldstein wrote:
> > On Fri, Jan 16, 2026 at 3:28=E2=80=AFPM Chunsheng Luo <luochunsheng@ust=
c.edu> wrote:
> >>
> >> To simplify crash recovery and reduce performance impact, backing_ids
> >> are not persisted across daemon restarts. After crash recovery, this
> >> may lead to resource leaks if backing file resources are not properly
> >> cleaned up.
> >>
> >> Add FUSE_DEV_IOC_BACKING_CLOSE_ALL ioctl to release all backing_ids
> >> and put backing files. When the FUSE daemon restarts, it can use this
> >> ioctl to cleanup all backing file resources.
> >>
> >> Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
> >> ---
> >>   fs/fuse/backing.c         | 19 +++++++++++++++++++
> >>   fs/fuse/dev.c             | 16 ++++++++++++++++
> >>   fs/fuse/fuse_i.h          |  1 +
> >>   include/uapi/linux/fuse.h |  1 +
> >>   4 files changed, 37 insertions(+)
> >>
> >> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> >> index 4afda419dd14..e93d797a2cde 100644
> >> --- a/fs/fuse/backing.c
> >> +++ b/fs/fuse/backing.c
> >> @@ -166,6 +166,25 @@ int fuse_backing_close(struct fuse_conn *fc, int =
backing_id)
> >>          return err;
> >>   }
> >>
> >> +static int fuse_backing_close_one(int id, void *p, void *data)
> >> +{
> >> +       struct fuse_conn *fc =3D data;
> >> +
> >> +       fuse_backing_close(fc, id);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +int fuse_backing_close_all(struct fuse_conn *fc)
> >> +{
> >> +       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> >> +               return -EPERM;
> >> +
> >> +       idr_for_each(&fc->backing_files_map, fuse_backing_close_one, f=
c);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >
> > This is not safe and not efficient.
> > For safety from racing with _open/_close, iteration needs at least
> > rcu_read_lock(),
>
> Yes, you're absolutely right. Additionally, calling idr_remove within
> idr_for_each maybe presents safety risks.
>
> > but I think it will be much more efficient to zap the entire map with
> > fuse_backing_files_free()/fuse_backing_files_init().
> >
> > This of course needs to be synchronized with concurrent _open/_close/_l=
ookup.
> > This could be done by making c->backing_files_map a struct idr __rcu *
> > and replace the old and new backing_files_map under spin_lock(&fc->lock=
);
> >
> > Then you can call fuse_backing_files_free() on the old backing_files_ma=
p
> > without a lock.
> >
> > As a side note, fuse_backing_files_free() iteration looks like it may n=
eed
> > cond_resched() if there are a LOT of backing ids, but I am not sure and
> > this is orthogonal to your change.
> >
> > Thanks,
> > Amir.
> >
> >
>
> Thank you for your helpful suggestions. However, it cannot use
> fuse_backing_files_free() in the close_all implementation because it
> directly frees backing files without respecting reference counts. This
> function requires that no one is actively using the backing file (it
> even has WARN_ON_ONCE(refcount_read(&fb->count) !=3D 1)), which cannot be
> guaranteed after a crash recovery scenario where backing files may still
> be in use.

Right.

>
> Instead, the implementation uses fuse_backing_put() to safely decrement
> the reference count and allow the backing file to be freed when no
> longer in use.

OK.

>
> Additionally, the implementation addresses two race conditions:
>
> - Race between idr_for_each and lookup: Uses synchronize_rcu() to ensure
> all concurrent RCU readers (i.e., in-flight fuse_backing_lookup() calls)
> complete before releasing backing files, preventing use-after-free issues=
.

Almost. See below.

>
> - Race with open/close operations: Uses fc->lock to atomically swap the
> old and new IDR maps, ensuring consistency with concurrent
> fuse_backing_open() and fuse_backing_close() operations.
>
> This approach provides the same as the RCU pointer suggestion, but with
> less code and no changes to the struct fuse_conn data structures.
>
> I've updated it and verified the implementation. Could you please review =
it?
>
>
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index 4afda419dd14..047d373684f9 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -166,6 +166,45 @@ int fuse_backing_close(struct fuse_conn *fc, int
> backing_id)
>          return err;
>   }
>
> +static int fuse_backing_release_one(int id, void *p, void *data)
> +{
> +       struct fuse_backing *fb =3D p;
> +
> +       fuse_backing_put(fb);
> +
> +       return 0;
> +}
> +
> +int fuse_backing_close_all(struct fuse_conn *fc)
> +{
> +       struct idr old_map;
> +
> +       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> +               return -EPERM;
> +
> +       /*
> +        * Swap out the old backing_files_map with a new empty one under
> lock,
> +        * then release all backing files outside the lock. This avoids l=
ong
> +        * lock hold times and potential races with concurrent open/close
> +        * operations.
> +        */
> +       idr_init(&old_map);
> +       spin_lock(&fc->lock);
> +       swap(fc->backing_files_map, old_map);
> +       spin_unlock(&fc->lock);
> +
> +       /*
> +        * Ensure all concurrent RCU readers complete before releasing
> backing
> +        * files, so any in-flight lookups can safely take references.
> +        */
> +       synchronize_rcu();
> +
> +       idr_for_each(&old_map, fuse_backing_release_one, NULL);
> +       idr_destroy(&old_map);
> +
> +       return 0;
> +}
> +

That's almost safe but not enough.
This lookup code is not safe against the swap():

  rcu_read_lock();
  fb =3D idr_find(&fc->backing_files_map, backing_id);

That is the reason you need to make fc->backing_files_map
an rcu referenced ptr.

Instead of swap() you use xchg() to atomically exchange the
old and new struct idr pointers and for lookup:

  rcu_read_lock();
  fb =3D idr_find(rcu_dereference(fc->backing_files_map), backing_id);

Thanks,
Amir.

