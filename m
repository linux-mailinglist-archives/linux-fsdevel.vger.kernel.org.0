Return-Path: <linux-fsdevel+bounces-75923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBv0AfYifGnJKgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 04:18:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4280B6C5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 04:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F3EB302A6E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 03:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002162FF661;
	Fri, 30 Jan 2026 03:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="oKxnrj79"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E8F365A12;
	Fri, 30 Jan 2026 03:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769743041; cv=none; b=bBJ/RLotXn8JtU5+OyGvBV+7tgJDwjjOgw67xwbVZKVGPmdaXo52+SJsw4YWELHvkZFK/dzbCvB2h9HtAsESBVwcLZJPJyfBL5a59FSOfK+kgxAuh2coKpXVH4HEfuKy3D2T7rX1wuPSB9PwFjz1hNT0pPTv0+E8M6qGpaAv40E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769743041; c=relaxed/simple;
	bh=0LQc66MRs1NAhyZ72udcDqF0xEsw1BP7+JFYTm/vtIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7mA8BPBO91hhjA/O49FNJiPWfXVq7yZQTArmaYb5Q8Oc1+ktJbUgMZnm9nIZdCz4WUXlFAd5g2czAT99jZGUWQM6LYUPB1I4a+7/cwVO/CPI51jq5ALU5OFIY7x2fV5ovR5LwOGDvkBlgGg3HN1XVV2kHxwgVqKJKPq03ruSng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=oKxnrj79; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1769743024; x=1770347824; i=quwenruo.btrfs@gmx.com;
	bh=xwuPGPi1LRnQMVQ+TbO9DImwX4qciZFsxG7tDYa2qFc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oKxnrj79KseUKR5HWNpq+uLmqyOA6nPIFGFAhN0lPf2JPcRXEYwsfV9N2QwUqm7K
	 MURaolGgW/rYrECrvzflnqvf9drkxa30hVaiLXr5CIb8Vbp53NZDtbpfB4XxmeIqS
	 g65pSGDIevem2mk2Lmt3wDpICN2O68CoUAbYhCoZmUtFeQnuVGJu7/aH6iktRtAJI
	 rfcWUEjmp62iX16OMaYZR6w/5XzCe0VEYeanQLmB+HjHoclNJb0V6dJcVqT+kyB1B
	 5bJ5Qk3Xqb8dDiGD9BHhc8Y9+IGA3Ka/qNIsabgI0vS3Tio1qfHU205b3LNvplAuD
	 Q5FFPoChWvb8HXi96g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBUm7-1vaMb1064V-00HQcO; Fri, 30
 Jan 2026 04:17:04 +0100
Message-ID: <776e54f6-c9b7-4b22-bde5-561dc65c9be7@gmx.com>
Date: Fri, 30 Jan 2026 13:46:59 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] btrfs: defer freeing of subpage private state to
 free_folio
To: JP Kobryn <inwardvessel@gmail.com>, boris@bur.io, clm@fb.com,
 dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20260129230822.168034-1-inwardvessel@gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20260129230822.168034-1-inwardvessel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CT1mJi5Mp4N8sr1uGPRd67ZJIaVnUvbrXZqJaaOrwJgYNIPHjcI
 KqkZnnIm1ZgMdWTDrtccafHqATcYtcQmk/hliV0CqW57I9L4SYifmUx7Wu02OZP+Q6gWC4P
 vSDA4mWq6ABYFZfsbQgcsdT7FHS0UbfthdAnm0PAaoeD26KVEP0WxV1UZ6ATw4lDjyEgmPT
 Hh6hlTrFLBU96glBTbhkw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3kyrjrVFRtk=;GHHkR60B6m8728Z1tAcsbG8T08D
 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
 PUoAfLOD7vspiNq29VOEXbyVJPQwQ
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-75923-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.com];
	FREEMAIL_TO(0.00)[gmail.com,bur.io,fb.com,suse.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: A4280B6C5F
X-Rspamd-Action: no action



=E5=9C=A8 2026/1/30 09:38, JP Kobryn =E5=86=99=E9=81=93:
[...]
> The patch also might have the advantage of being easy to backport to the
> LTS trees. On that note, it's worth mentioning that we encountered a ker=
nel
> panic as a result of this sequence on a 6.16-based arm64 host (configure=
d
> with 64k pages so btrfs is in subpage mode). On our 6.16 kernel, the rac=
e
> window is shown below between points A and B:
>=20
> [mm] page cache reclaim path        [fs] relocation in subpage mode
> shrink_folio_list()
>    folio_trylock() /* lock acquired */
>    filemap_release_folio()
>      mapping->a_ops->release_folio()
>        btrfs_release_folio()
>          __btrfs_release_folio()
>            clear_folio_extent_mapped()
>              btrfs_detach_folio_state()
>                bfs =3D folio_detach_private(folio)
>                btrfs_free_folio_state(folio)
>                  kfree(bfs) /* point A */
>=20
>                                     prealloc_file_extent_cluster()
>                                       filemap_lock_folio()

Mind to explain which function is calling filemap_lock_folio()?

I guess it's filemap_invalidate_inode() -> filemap_fdatawrite_range() ->=
=20
filemap_writeback() -> btrfs_writepages() -> extent_write_cache_pages().

>                                         folio_try_get() /* inc refcount =
*/
>                                         folio_lock() /* wait for lock */


Another question here is, since the folio is already released in the mm=20
path, the folio should not have dirty flag set.

That means inside extent_write_cache_pages(), the folio_test_dirty()=20
should return false, and we should just unlock the folio without=20
touching it anymore.

Mind to explain why we still continue the writeback of a non-dirty folio?

>=20
>    __remove_mapping()
>      if (!folio_ref_freeze(folio, refcount)) /* point B */
>        goto cannot_free /* folio remains in cache */
>=20
>    folio_unlock(folio) /* lock released */
>=20
>                                     /* lock acquired */
>                                     btrfs_subpage_clear_updodate()

Mind to provide more context of where the btrfs_subpage_clear_uptodate()=
=20
call is from?

>                                       bfs =3D folio->priv /* use-after-f=
ree */
>=20
> This exact race during relocation should not occur in the latest upstrea=
m
> code, but it's an example of a backport opportunity for this patch.

And mind to explain what is missing in 6.16 kernel that causes the above=
=20
use-after-free?

>=20
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>   fs/btrfs/extent_io.c |  6 ++++--
>   fs/btrfs/inode.c     | 18 ++++++++++++++++++
>   2 files changed, 22 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 3df399dc8856..d83d3f9ae3af 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -928,8 +928,10 @@ void clear_folio_extent_mapped(struct folio *folio)
>   		return;
>  =20
>   	fs_info =3D folio_to_fs_info(folio);
> -	if (btrfs_is_subpage(fs_info, folio))
> -		return btrfs_detach_folio_state(fs_info, folio, BTRFS_SUBPAGE_DATA);
> +	if (btrfs_is_subpage(fs_info, folio)) {
> +		/* freeing of private subpage data is deferred to btrfs_free_folio */
> +		return;
> +	}

Another question is, why only two fses (nfs for dir inode, and orangefs)=
=20
are utilizing the free_folio() callback.

Iomap is doing the same as btrfs and only calls ifs_free() in=20
release_folio() and invalidate_folio().

Thus it looks like free_folio() callback is not the recommended way to=20
free folio->private pointer.

Cc fsdevel list on whether the free_folio() callback should have new=20
callers.

>  =20
>   	folio_detach_private(folio);

This means for regular folio cases, we still remove the private flag of=20
such folio.

It may be fine for most cases as we will not touch folio->private=20
anyway, but this still looks like a inconsistent behavior, especially=20
the free_folio() callback has handling for both cases.

Thanks,
Qu

>   }
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index b8abfe7439a3..7a832ee3b591 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7565,6 +7565,23 @@ static bool btrfs_release_folio(struct folio *fol=
io, gfp_t gfp_flags)
>   	return __btrfs_release_folio(folio, gfp_flags);
>   }
>  =20
> +/* frees subpage private data if present */
> +static void btrfs_free_folio(struct folio *folio)
> +{
> +	struct btrfs_folio_state *bfs;
> +
> +	if (!folio_test_private(folio))
> +		return;
> +
> +	bfs =3D folio_detach_private(folio);
> +	if (bfs =3D=3D (void *)EXTENT_FOLIO_PRIVATE) {
> +		/* extent map flag is detached in btrfs_folio_release */
> +		return;
> +	}
> +
> +	btrfs_free_folio_state(bfs);
> +}
> +
>   #ifdef CONFIG_MIGRATION
>   static int btrfs_migrate_folio(struct address_space *mapping,
>   			     struct folio *dst, struct folio *src,
> @@ -10651,6 +10668,7 @@ static const struct address_space_operations btr=
fs_aops =3D {
>   	.invalidate_folio =3D btrfs_invalidate_folio,
>   	.launder_folio	=3D btrfs_launder_folio,
>   	.release_folio	=3D btrfs_release_folio,
> +	.free_folio =3D btrfs_free_folio,
>   	.migrate_folio	=3D btrfs_migrate_folio,
>   	.dirty_folio	=3D filemap_dirty_folio,
>   	.error_remove_folio =3D generic_error_remove_folio,


