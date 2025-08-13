Return-Path: <linux-fsdevel+bounces-57630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6461BB24000
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 07:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67DD1B62EBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 05:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A9929A9CB;
	Wed, 13 Aug 2025 05:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K5KmI3wl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B333A1D2
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 05:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755061554; cv=none; b=OnDdCBVA8sXmwsea48ceJ70AxJ5JiPsPJIoC3Xid2aCofGGtcqkGMtPZLZMp8mF8do6BScgcnXz4OVAy1TshoiJPyJ1oWWbqMHljPz/eaF6LpZTlJBY3fTtBaUaL7G/09eq7KaE5wz46gO+duWggE3JY22pLkUdjNPaYXc7+fuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755061554; c=relaxed/simple;
	bh=FERtpqvVacMx7zhRiTKdNCJfsEaDsHDYudw8mCLif1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Voi11yqFZv9GB8RLiMoV+0dSxZRoBq7NsGqwkyIBCV4/EClL6JhMuded86bMwAMKUaBgH+bOU8r7tzf79OxNRZF44TSL9SUNGjpwvo7mTreQdQ+VlY0Tx92PPgLt6Titq6zHPTclrOULhoQIkf49kzLH58q/WMv3ECU6nC5LOjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K5KmI3wl; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCUp4zpLhQZ+eXhWczHzyeVZDq1K+ratlXhzGlKDYYEKhYjwxhmtUe7tTqwTTGNfNy/Z48VBCvap9BK06X/yIw==@vger.kernel.org, AJvYcCXzAUjKy/HzmbR3YzykkDPki3/V/SAJjADWvZpesPnydHx/jrVbFjkiTHamFzre8tCxxw0dLnzSEuzxnw==@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755061538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87bLiKw1h579sXw+ErVi2X85NzXrARI80WO5rF5C6xU=;
	b=K5KmI3wlxR5khEQ8V/MX2bXF2jmJOk4aEQBlLXWo6V0bvsySDZSpo5A3l9N+8Qv/emYoWw
	Pz5X/T6SRuFMxHcEVsN+mLZyAnMnGL7Rfw4ey9Zi9cW691W5AHaNGn6PTNDpvAtFQvzoq0
	1UhjrE+E0dUiNOi4Zk48MbTUb5JMaCc=
X-Gm-Message-State: AOJu0Yz8Yv7UcSTW+JrUp69O+6PcBr0qanybNnecLWhOaKTOVQEl2CRu
	J0KZyRTJoIt9vS8gm/T781JT4erTul4uz1Cr78YRH1Zpr+lcX7+fc4HPtjoLtyQHekHyJ7tPTE2
	I+BmVAQbaB/sIdiPVtVCbj8ebOq40fc4=
X-Google-Smtp-Source: AGHT+IGZEPRXKg3wTS4iOnxLeW0VcVJpSHw/Siwyoa1WzS8WxyYOyRd8JzJTNVHXWXH3rQ3YpjAcT1JHiZ4LgeKLzSs=
X-Received: by 2002:a05:6214:246e:b0:709:31f8:fd96 with SMTP id
 6a1803df08f44-709e8865a26mr19274996d6.20.1755061536500; Tue, 12 Aug 2025
 22:05:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811143949.1117439-1-david@redhat.com> <20250811143949.1117439-2-david@redhat.com>
In-Reply-To: <20250811143949.1117439-2-david@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
Date: Wed, 13 Aug 2025 13:05:22 +0800
X-Gmail-Original-Message-ID: <CABzRoyYU2yOuGQskCAG_gzKiQwR6uM9eAYqOOCoQj+Xv=r163A@mail.gmail.com>
X-Gm-Features: Ac12FXz5RRcASyIjWC2h4OdZEnpLc7e6olfF88c8Jo2nErMh7OQ3VSRS5jfjM-I
Message-ID: <CABzRoyYU2yOuGQskCAG_gzKiQwR6uM9eAYqOOCoQj+Xv=r163A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mm/migrate: remove MIGRATEPAGE_UNMAP
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, 
	linux-btrfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Benjamin LaHaise <bcrl@kvack.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Dave Kleikamp <shaggy@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 11, 2025 at 10:47=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
[...]
> +++ b/mm/migrate.c
> @@ -1176,16 +1176,6 @@ static int migrate_folio_unmap(new_folio_t get_new=
_folio,
>         bool locked =3D false;
>         bool dst_locked =3D false;
>
> -       if (folio_ref_count(src) =3D=3D 1) {
> -               /* Folio was freed from under us. So we are done. */
> -               folio_clear_active(src);
> -               folio_clear_unevictable(src);
> -               /* free_pages_prepare() will clear PG_isolated. */
> -               list_del(&src->lru);
> -               migrate_folio_done(src, reason);
> -               return MIGRATEPAGE_SUCCESS;
> -       }
> -
>         dst =3D get_new_folio(src, private);
>         if (!dst)
>                 return -ENOMEM;
> @@ -1275,7 +1265,7 @@ static int migrate_folio_unmap(new_folio_t get_new_=
folio,
>
>         if (unlikely(page_has_movable_ops(&src->page))) {
>                 __migrate_folio_record(dst, old_page_state, anon_vma);
> -               return MIGRATEPAGE_UNMAP;
> +               return 0;
>         }
>
>         /*
> @@ -1305,7 +1295,7 @@ static int migrate_folio_unmap(new_folio_t get_new_=
folio,
>
>         if (!folio_mapped(src)) {
>                 __migrate_folio_record(dst, old_page_state, anon_vma);
> -               return MIGRATEPAGE_UNMAP;
> +               return 0;
>         }
>
>  out:
> @@ -1848,14 +1838,28 @@ static int migrate_pages_batch(struct list_head *=
from,
>                                 continue;
>                         }
>
> +                       /*
> +                        * If we are holding the last folio reference, th=
e folio
> +                        * was freed from under us, so just drop our refe=
rence.
> +                        */
> +                       if (likely(!page_has_movable_ops(&folio->page)) &=
&
> +                           folio_ref_count(folio) =3D=3D 1) {
> +                               folio_clear_active(folio);
> +                               folio_clear_unevictable(folio);
> +                               list_del(&folio->lru);
> +                               migrate_folio_done(folio, reason);
> +                               stats->nr_succeeded +=3D nr_pages;
> +                               stats->nr_thp_succeeded +=3D is_thp;
> +                               continue;
> +                       }
> +

It seems the reason parameter is no longer used within migrate_folio_unmap(=
)
after this patch.

Perhaps it could be removed from the function's signature ;)

>                         rc =3D migrate_folio_unmap(get_new_folio, put_new=
_folio,
>                                         private, folio, &dst, mode, reaso=
n,
>                                         ret_folios);

Anyway, just a small thought. Feel free to add:
Reviewed-by: Lance Yang <lance.yang@linux.dev>

Thanks,
Lance

