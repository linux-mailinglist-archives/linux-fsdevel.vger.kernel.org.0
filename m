Return-Path: <linux-fsdevel+bounces-7036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F13D8205DC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 13:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB4D281FFD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 12:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8169463;
	Sat, 30 Dec 2023 12:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw4u4Y4T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0888F69
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Dec 2023 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78102c516a7so694494985a.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Dec 2023 04:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703938952; x=1704543752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zG7XZ2cFmX6RWvWyWeA4DZWu6jBWUYLWuLC506HUhO4=;
        b=Gw4u4Y4TorotzJku4SLmaGM+0VUiF1V1t0is6+CuCKLGHhgkUJsEKCndbiTEAnFQMt
         Sxm9+ublfx88WyhMOZZE/OZMWAty1/hNHrdrb7Bbv0bPhfzq+EcUPI3Q2mkQaUQcucV7
         J7i3Be5fZZyRDJ8CT53r9zeabrxWKskUfokurnX4d4RB3zY+lWFJUz2mKDlQ83qMIVm6
         KITTQ6vz2A2nV5HlwH+6oBEKLBTBdQEmn+nKxejkp17sZ5Si5MZK4MZpCdfz5U9+G15G
         LXqxr1fuGdJp19pS94yRPcZ8iJyhH7LG2tFOOVIItaU4erqF2Tx/lu8QafqdpadW4CCw
         +B4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703938952; x=1704543752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zG7XZ2cFmX6RWvWyWeA4DZWu6jBWUYLWuLC506HUhO4=;
        b=Fv1T36IN23cyu7WeEILveYHRT5ebJxF345Zswh0st764+rVNI0oBl+c7yzG48uacC0
         N2obLf4A6KFZDOFT99L1Xj2JjBeONK+E7EjmFYzfQ4SUtDI1jRm/q798SRs0374VpCF5
         R0XxPcXFL0dpFwJ5sPc8B7CNu2pY9rRgoyaG4nxx8Yrrg6CLzwWEvJzwL11wA5OhykS5
         zvhFofmn/PXwJx3FTOySkutQWIQu6nw5U/F1WFcu/yNBFtrU43kxsgzOH38TRw4QeV7e
         IeQ/tYPUyLWwXtSTSv/Mrci7EMQgmVF3UMs1ZdsJzMHp+y6hDOZoTW3Kn7vza49ofuKw
         T3Xw==
X-Gm-Message-State: AOJu0Yx40OkRnGC/6gb7H/yxPEXB4jWqgRkclUOeNwKwIaz0AQfk8axp
	5GRLkJuOL5wqEeZWdM7HUOzFLPxVz0HGbBled5A=
X-Google-Smtp-Source: AGHT+IH64HS6XQUpr0LG7+Dv7K1rltPRjgqp44UviNVRPSRJ99HJLt4g/Ex6Btl5x3IKXgH8gQY5WWvQpFcO6Im3p4E=
X-Received: by 2002:a05:620a:558a:b0:781:5e6a:355d with SMTP id
 vq10-20020a05620a558a00b007815e6a355dmr7465316qkn.141.1703938951963; Sat, 30
 Dec 2023 04:22:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109210608.2252323-1-willy@infradead.org> <20231109210608.2252323-2-willy@infradead.org>
 <CAKFNMo=1yLxL9RR4XBY6=SkWej7tstTEiFQjUFWjxMs+5=YPFw@mail.gmail.com> <ZY/hdUqeKMi0IVp6@casper.infradead.org>
In-Reply-To: <ZY/hdUqeKMi0IVp6@casper.infradead.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Sat, 30 Dec 2023 21:22:15 +0900
Message-ID: <CAKFNMomPry8Xqf5GkK3U09GLcwsaV1j_Q1U0xST-6S8Y4QKgPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] buffer: Return bool from grow_dev_folio()
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hannes Reinecke <hare@suse.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 30, 2023 at 6:23=E2=80=AFPM Matthew Wilcox wrote:
>
> On Fri, Nov 10, 2023 at 12:43:43PM +0900, Ryusuke Konishi wrote:
> > On Fri, Nov 10, 2023 at 6:07=E2=80=AFAM Matthew Wilcox (Oracle) wrote:
> > > +               /* Caller should retry if this call fails */
> > > +               end_block =3D ~0ULL;
> > >                 if (!try_to_free_buffers(folio))
> > > -                       goto failed;
> > > +                       goto unlock;
> > >         }
> > >
> >
> > > -       ret =3D -ENOMEM;
> > >         bh =3D folio_alloc_buffers(folio, size, gfp | __GFP_ACCOUNT);
> > >         if (!bh)
> > > -               goto failed;
> > > +               goto unlock;
> >
> > Regarding this folio_alloc_buffers() error path,
> > If folio_buffers() was NULL, here end_block is 0, so this function
> > returns false (which means "have a permanent failure").
> >
> > But, if folio_buffers() existed and they were freed with
> > try_to_free_buffers() because of bh->b_size !=3D size, here end_block
> > has been set to ~0ULL, so it seems to return true ("succeeded").
> >
> > Does this semantic change match your intent?
> >
> > Otherwise, I think end_block should be set to 0 just before calling
> > folio_alloc_buffers().
>
> Thanks for the review, and sorry for taking so long to get back to you.
> The change was unintentional (but memory allocation failure wth GFP_KERNE=
L
> happens so rarely that our testing was never going to catch it)
>
> I think I should just move the assignment to end_block inside the 'if'.
> It's just more obvious what's going on.

Agree.  I also think this fix is better.

Regards,
Ryusuke Konishi

>  Andrew prodded me to be more
> explicit about why memory allocation is a "permanent" failure, but
> failing to free buffers is not.
>
> I'll turn this into a proper patch submission later.
>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index d5ce6b29c893..d3bcf601d3e5 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1028,8 +1028,8 @@ static sector_t folio_init_buffers(struct folio *fo=
lio,
>   *
>   * This is used purely for blockdev mappings.
>   *
> - * Returns false if we have a 'permanent' failure.  Returns true if
> - * we succeeded, or the caller should retry.
> + * Returns false if we have a failure which cannot be cured by retrying
> + * without sleeping.  Returns true if we succeeded, or the caller should=
 retry.
>   */
>  static bool grow_dev_folio(struct block_device *bdev, sector_t block,
>                 pgoff_t index, unsigned size, gfp_t gfp)
> @@ -1051,10 +1051,17 @@ static bool grow_dev_folio(struct block_device *b=
dev, sector_t block,
>                         goto unlock;
>                 }
>
> -               /* Caller should retry if this call fails */
> -               end_block =3D ~0ULL;
> -               if (!try_to_free_buffers(folio))
> +               /*
> +                * Retrying may succeed; for example the folio may finish
> +                * writeback, or buffers may be cleaned.  This should not
> +                * happen very often; maybe we have old buffers attached =
to
> +                * this blockdev's page cache and we're trying to change
> +                * the block size?
> +                */
> +               if (!try_to_free_buffers(folio)) {
> +                       end_block =3D ~0ULL;
>                         goto unlock;
> +               }
>         }
>
>         bh =3D folio_alloc_buffers(folio, size, gfp | __GFP_ACCOUNT);

