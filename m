Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB6371D2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 18:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390929AbfGWQ4K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 12:56:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34551 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390925AbfGWQ4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:56:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so13493140pgc.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2019 09:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=pEV7mnZhArKFPIbITahSPGAX55+xmG4lE46ZGNyJ0lY=;
        b=TxMcxKCpeECts244lfDDVbAGeDGIg014zp2ine+WN1EsSo1edjV/LnmO1rk2A/OGDN
         TC3KBgmrKNCIEVcb7Mbaw9VlX6k5z0e6dFNfNRPw2Fg8ndcgc8WJ9m+E5JVIZlGi1N53
         KjD1vkMlpKsqccmJxhF9Eiu5vrXXqbPDk4awbA3RD50teFhQe12IWLkRbMhAnLA4KZKr
         H2M3ECxNfeQSGzDvIVqDXx970S2g9ZCtfmh7CO/lXboRG+CEANxN9T+hFnDxiThT3rnr
         55IWQ2t0qOVbeIvyEO4XMFvn1aIHUvRMAkhgCamW2IJ/hP/6K2IEnMSMBVQEkgORt8XK
         Ws9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=pEV7mnZhArKFPIbITahSPGAX55+xmG4lE46ZGNyJ0lY=;
        b=G61jKXnhdfwah7Obg5pa6EDSkMa7fL1eQspGzE1hV+V17h1s5bAZuV8TtsauvCYHxI
         CjTR8/ZlwMTvJf+olM37bJzqX4EN/KunH4q8EpxBz0eYNflX29bc0qHFAuHQgZR6XB5i
         H3GrqzRgtgeZej3hPU6qzDDTf9A6H5+2sD4JYtaMa10osAhcJwNdzHNf8zW/kSD+MLkW
         f/7f+ZHgCBlL0hrgk84pf9pQ46VI+rapYCgk5FLEUH8wMYRJwKckjSk8jJ5X09RVYJ+L
         /fn/7zv/sg9NUOsQTDaGn7uv+NnLxSbdUPAjKWnWHRlRAdsEWY9sZLhAIp+pYdGLG+oT
         TuUA==
X-Gm-Message-State: APjAAAUs6BP3uMCY5IMUx1tSyXB9/O9j1my0DebpZ7rpOJKsnTWLMsIb
        R4rUezX/2tC02rt0q+CZGEg=
X-Google-Smtp-Source: APXvYqzYXvleT8NAJ24vpILhwdGH7h7RfhnNi9W8KY4aGGgrrlXJFpfpEcphH/abWzsm39Fb9iX1OQ==
X-Received: by 2002:a65:6497:: with SMTP id e23mr74560933pgv.89.1563900968932;
        Tue, 23 Jul 2019 09:56:08 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id f19sm58748803pfk.180.2019.07.23.09.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 09:56:08 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <5EDDA127-031C-4F16-9B9B-8DBC94C7E471@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_69013887-4392-40B7-8D1F-7621D12B4C76";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] mbcache: Speed up cache entry creation
Date:   Tue, 23 Jul 2019 10:56:05 -0600
In-Reply-To: <20190723053549.14465-1-sultan@kerneltoast.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Sultan Alsawaf <sultan@kerneltoast.com>
References: <20190723053549.14465-1-sultan@kerneltoast.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_69013887-4392-40B7-8D1F-7621D12B4C76
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 22, 2019, at 11:35 PM, Sultan Alsawaf <sultan@kerneltoast.com> =
wrote:
>=20
> From: Sultan Alsawaf <sultan@kerneltoast.com>
>=20
> In order to prevent redundant entry creation by racing against itself,
> mb_cache_entry_create scans through a hash-list of all current entries
> in order to see if another allocation for the requested new entry has
> been made. Furthermore, it allocates memory for a new entry before
> scanning through this hash-list, which results in that allocated =
memory
> being discarded when the requested new entry is already present.
>=20
> Speed up cache entry creation by keeping a small linked list of
> requested new entries in progress, and scanning through that first
> instead of the large hash-list. And don't allocate memory for a new
> entry until it's known that the allocated memory will be used.

Do you have any kind of performance metrics that show this is an actual
improvement in performance?  This would be either macro-level benchmarks
(e.g. fio, but this seems unlikely to show any benefit), or micro-level
measurements (e.g. flame graph) that show a net reduction in CPU cycles,
lock contention, etc. in this part of the code.

Cheers, Andreas

> Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> ---
> fs/mbcache.c | 82 ++++++++++++++++++++++++++++++++++++----------------
> 1 file changed, 57 insertions(+), 25 deletions(-)
>=20
> diff --git a/fs/mbcache.c b/fs/mbcache.c
> index 97c54d3a2227..289f3664061e 100644
> --- a/fs/mbcache.c
> +++ b/fs/mbcache.c
> @@ -25,9 +25,14 @@
>  * size hash table is used for fast key lookups.
>  */
>=20
> +struct mb_bucket {
> +	struct hlist_bl_head hash;
> +	struct list_head req_list;
> +};
> +
> struct mb_cache {
> 	/* Hash table of entries */
> -	struct hlist_bl_head	*c_hash;
> +	struct mb_bucket	*c_bucket;
> 	/* log2 of hash table size */
> 	int			c_bucket_bits;
> 	/* Maximum entries in cache to avoid degrading hash too much */
> @@ -42,15 +47,21 @@ struct mb_cache {
> 	struct work_struct	c_shrink_work;
> };
>=20
> +struct mb_cache_req {
> +	struct list_head lnode;
> +	u32 key;
> +	u64 value;
> +};
> +
> static struct kmem_cache *mb_entry_cache;
>=20
> static unsigned long mb_cache_shrink(struct mb_cache *cache,
> 				     unsigned long nr_to_scan);
>=20
> -static inline struct hlist_bl_head *mb_cache_entry_head(struct =
mb_cache *cache,
> -							u32 key)
> +static inline struct mb_bucket *mb_cache_entry_bucket(struct mb_cache =
*cache,
> +						      u32 key)
> {
> -	return &cache->c_hash[hash_32(key, cache->c_bucket_bits)];
> +	return &cache->c_bucket[hash_32(key, cache->c_bucket_bits)];
> }
>=20
> /*
> @@ -77,6 +88,8 @@ int mb_cache_entry_create(struct mb_cache *cache, =
gfp_t mask, u32 key,
> 	struct mb_cache_entry *entry, *dup;
> 	struct hlist_bl_node *dup_node;
> 	struct hlist_bl_head *head;
> +	struct mb_cache_req *tmp_req, req;
> +	struct mb_bucket *bucket;
>=20
> 	/* Schedule background reclaim if there are too many entries */
> 	if (cache->c_entry_count >=3D cache->c_max_entries)
> @@ -85,9 +98,33 @@ int mb_cache_entry_create(struct mb_cache *cache, =
gfp_t mask, u32 key,
> 	if (cache->c_entry_count >=3D 2*cache->c_max_entries)
> 		mb_cache_shrink(cache, SYNC_SHRINK_BATCH);
>=20
> +	bucket =3D mb_cache_entry_bucket(cache, key);
> +	head =3D &bucket->hash;
> +	hlist_bl_lock(head);
> +	list_for_each_entry(tmp_req, &bucket->req_list, lnode) {
> +		if (tmp_req->key =3D=3D key && tmp_req->value =3D=3D =
value) {
> +			hlist_bl_unlock(head);
> +			return -EBUSY;
> +		}
> +	}
> +	hlist_bl_for_each_entry(dup, dup_node, head, e_hash_list) {
> +		if (dup->e_key =3D=3D key && dup->e_value =3D=3D value) =
{
> +			hlist_bl_unlock(head);
> +			return -EBUSY;
> +		}
> +	}
> +	req.key =3D key;
> +	req.value =3D value;
> +	list_add(&req.lnode, &bucket->req_list);
> +	hlist_bl_unlock(head);
> +
> 	entry =3D kmem_cache_alloc(mb_entry_cache, mask);
> -	if (!entry)
> +	if (!entry) {
> +		hlist_bl_lock(head);
> +		list_del(&req.lnode);
> +		hlist_bl_unlock(head);
> 		return -ENOMEM;
> +	}
>=20
> 	INIT_LIST_HEAD(&entry->e_list);
> 	/* One ref for hash, one ref returned */
> @@ -96,15 +133,9 @@ int mb_cache_entry_create(struct mb_cache *cache, =
gfp_t mask, u32 key,
> 	entry->e_value =3D value;
> 	entry->e_reusable =3D reusable;
> 	entry->e_referenced =3D 0;
> -	head =3D mb_cache_entry_head(cache, key);
> +
> 	hlist_bl_lock(head);
> -	hlist_bl_for_each_entry(dup, dup_node, head, e_hash_list) {
> -		if (dup->e_key =3D=3D key && dup->e_value =3D=3D value) =
{
> -			hlist_bl_unlock(head);
> -			kmem_cache_free(mb_entry_cache, entry);
> -			return -EBUSY;
> -		}
> -	}
> +	list_del(&req.lnode);
> 	hlist_bl_add_head(&entry->e_hash_list, head);
> 	hlist_bl_unlock(head);
>=20
> @@ -133,7 +164,7 @@ static struct mb_cache_entry *__entry_find(struct =
mb_cache *cache,
> 	struct hlist_bl_node *node;
> 	struct hlist_bl_head *head;
>=20
> -	head =3D mb_cache_entry_head(cache, key);
> +	head =3D &mb_cache_entry_bucket(cache, key)->hash;
> 	hlist_bl_lock(head);
> 	if (entry && !hlist_bl_unhashed(&entry->e_hash_list))
> 		node =3D entry->e_hash_list.next;
> @@ -202,7 +233,7 @@ struct mb_cache_entry *mb_cache_entry_get(struct =
mb_cache *cache, u32 key,
> 	struct hlist_bl_head *head;
> 	struct mb_cache_entry *entry;
>=20
> -	head =3D mb_cache_entry_head(cache, key);
> +	head =3D &mb_cache_entry_bucket(cache, key)->hash;
> 	hlist_bl_lock(head);
> 	hlist_bl_for_each_entry(entry, node, head, e_hash_list) {
> 		if (entry->e_key =3D=3D key && entry->e_value =3D=3D =
value) {
> @@ -230,7 +261,7 @@ void mb_cache_entry_delete(struct mb_cache *cache, =
u32 key, u64 value)
> 	struct hlist_bl_head *head;
> 	struct mb_cache_entry *entry;
>=20
> -	head =3D mb_cache_entry_head(cache, key);
> +	head =3D &mb_cache_entry_bucket(cache, key)->hash;
> 	hlist_bl_lock(head);
> 	hlist_bl_for_each_entry(entry, node, head, e_hash_list) {
> 		if (entry->e_key =3D=3D key && entry->e_value =3D=3D =
value) {
> @@ -300,7 +331,7 @@ static unsigned long mb_cache_shrink(struct =
mb_cache *cache,
> 		 * from under us.
> 		 */
> 		spin_unlock(&cache->c_list_lock);
> -		head =3D mb_cache_entry_head(cache, entry->e_key);
> +		head =3D &mb_cache_entry_bucket(cache, =
entry->e_key)->hash;
> 		hlist_bl_lock(head);
> 		if (!hlist_bl_unhashed(&entry->e_hash_list)) {
> 			hlist_bl_del_init(&entry->e_hash_list);
> @@ -354,21 +385,22 @@ struct mb_cache *mb_cache_create(int =
bucket_bits)
> 	cache->c_max_entries =3D bucket_count << 4;
> 	INIT_LIST_HEAD(&cache->c_list);
> 	spin_lock_init(&cache->c_list_lock);
> -	cache->c_hash =3D kmalloc_array(bucket_count,
> -				      sizeof(struct hlist_bl_head),
> -				      GFP_KERNEL);
> -	if (!cache->c_hash) {
> +	cache->c_bucket =3D kmalloc_array(bucket_count, =
sizeof(*cache->c_bucket),
> +					GFP_KERNEL);
> +	if (!cache->c_bucket) {
> 		kfree(cache);
> 		goto err_out;
> 	}
> -	for (i =3D 0; i < bucket_count; i++)
> -		INIT_HLIST_BL_HEAD(&cache->c_hash[i]);
> +	for (i =3D 0; i < bucket_count; i++) {
> +		INIT_HLIST_BL_HEAD(&cache->c_bucket[i].hash);
> +		INIT_LIST_HEAD(&cache->c_bucket[i].req_list);
> +	}
>=20
> 	cache->c_shrink.count_objects =3D mb_cache_count;
> 	cache->c_shrink.scan_objects =3D mb_cache_scan;
> 	cache->c_shrink.seeks =3D DEFAULT_SEEKS;
> 	if (register_shrinker(&cache->c_shrink)) {
> -		kfree(cache->c_hash);
> +		kfree(cache->c_bucket);
> 		kfree(cache);
> 		goto err_out;
> 	}
> @@ -409,7 +441,7 @@ void mb_cache_destroy(struct mb_cache *cache)
> 		WARN_ON(atomic_read(&entry->e_refcnt) !=3D 1);
> 		mb_cache_entry_put(cache, entry);
> 	}
> -	kfree(cache->c_hash);
> +	kfree(cache->c_bucket);
> 	kfree(cache);
> }
> EXPORT_SYMBOL(mb_cache_destroy);
> --
> 2.22.0
>=20


Cheers, Andreas






--Apple-Mail=_69013887-4392-40B7-8D1F-7621D12B4C76
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl03PCUACgkQcqXauRfM
H+CxCQ//bmeQp5E0OjYmuLCnuAKfnkX6ZIHGjqFz2Ti5q25WAyZ15AaAK+iJmvVA
ySAVvCRGkOPYHuYnuVJTJnsAodcndYcMYRZz1ChtwoswKrOSYAJvAZA8oS810SzT
UGuUyzRJUUiOT6c5p5RrBNC8T9lMuWY8Mj8ADF5xfeRMugBdTKQ39ASB95G+9Km6
4ouvqu8evaCRUA+gyAwuNKU1qhWZ76R5dVjNqvQQbPiSo/rRCcwkzhOfj92DozvU
3xq22t9MSPxJz+DyLpK7//MCjUG+UpT/1yrZxDWZVNYRbBRRUAaOMw+hJPIcqZtr
q0193l8LPEElI4wpW8DGL/6bz+WsrdOV+JCbEKmbs1Hit1xxfJVM0h1Pmb8yTWkK
akBVtdjVvIrvtvkgAo+KxJMnDZ1Q30bZEE0dFJt+nXCpcw1cC7OJOxjvj0oRFgpw
SbE2UiagLH8VuWJhSIB//Kxn+HcDecS42B1OISqgpqpYcu094Sf/6ZPU8QxmlH5x
XLjW/GWfpRJdMRMoritN9+1u+rtD0MA5yquXKI91woYYh8XWApenFHa/IM9N6kra
G6JUbmMYKHvmZ2RNmJqBsN6vSiuyFMGwm4RC2zqIPKGEOnl+/p5GLfGzw9cHD9zd
qoDTMiESbLueYLI3q/fwtThZQFfjGCFNgodyU4wGQ0/l/CSfpW8=
=wRpq
-----END PGP SIGNATURE-----

--Apple-Mail=_69013887-4392-40B7-8D1F-7621D12B4C76--
