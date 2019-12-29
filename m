Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B600D12C2AA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2019 15:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfL2OXq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Dec 2019 09:23:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41620 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfL2OXq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Dec 2019 09:23:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so30560823wrw.8;
        Sun, 29 Dec 2019 06:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bj/J9P1iJdIXwAGXkzHeKD11e8YZ+5BjC8WtOsMhzT4=;
        b=fF5NfOQkRUYu9fS/4m+c645CvdTnbCI6Ye1k9k1IAOtP4OrrlirdyuXnBGmCyvVLTe
         LoxJFna6Z0sqwDCg+QV7z2K41kssBKHJIy7z7WafNqfhlnPhTiw8GZhDhxUNTr8Cfm36
         +M0vVlvSsblQJuvDP5KQZMfHIxJDxW86tEKZ3QDT8CJQxN1ZkWhj6gcV5m+5N+j+jCN0
         B1twWsYIV3PAcoK2pMtXFT6vtV+2BgfHrv3qQOPEIu/J9VcmYYlw7pWlR6NIeNHH3/M2
         10Ag7Rx5JZwpvroigHy4guP9+U6pWAqV/AdAcQ/qjc3FDH9J913QLYqnryK2icskZv8s
         8QoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bj/J9P1iJdIXwAGXkzHeKD11e8YZ+5BjC8WtOsMhzT4=;
        b=KlgE0VLg596pJ6kLO8gkSsOkpve67jcFoDga9HjLJjR41Ov5dyYgHUg8fNeKZEE9l0
         rS0HXKCaniMbkI5YiAXYOLwKbT98DthZwCua66VXGhBT5I5uXAHt7zO/hMqx3Cy+8IzH
         toUr6ep1O1BvSrIdJiHJrGTuwFgpEOMJ0s6iDTzYlmOMks4L0zd+6xLsirydqge8U2Is
         UvKW8ducIuUOz5UQO+78oDiVjHApUp43GYk5WxxKTPjuYA5GpsmDNPB0IhrsS/1pGApl
         zmfUqPqUxdsga2noUmPsuPGQiZNumM6GmqRO/xC/EpPTH964w8mz/xIcpF1tnS7XUFKt
         knQg==
X-Gm-Message-State: APjAAAXvKKhA9KvEQUDXXIUn8koYE4wOyEtGkfyCuPCQrMNPm2vyTZJy
        FG0D5NVKD1rMxIgpUgr8hTQ=
X-Google-Smtp-Source: APXvYqzW6756p5ZqVOCm/dfkUH//itMOLKqIGdv/scXTVrG+Zrg8ZpxHu5SQfZ/vxMW6UPqTsgHQfQ==
X-Received: by 2002:adf:814c:: with SMTP id 70mr59092629wrm.157.1577629422572;
        Sun, 29 Dec 2019 06:23:42 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id y20sm17339399wmi.25.2019.12.29.06.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 06:23:41 -0800 (PST)
Date:   Sun, 29 Dec 2019 15:23:40 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com
Subject: Re: [PATCH v8 08/13] exfat: add exfat cache
Message-ID: <20191229142340.sr2xbmwlczb2ytjj@pali>
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
 <CGME20191220062736epcas1p3c58bf86018ba9caef90b3a6476b4b925@epcas1p3.samsung.com>
 <20191220062419.23516-9-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oz3thgrwz46oq5d4"
Content-Disposition: inline
In-Reply-To: <20191220062419.23516-9-namjae.jeon@samsung.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--oz3thgrwz46oq5d4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello! This patch looks like a copy-pase of fat cache implementation.
It is possible to avoid duplicating code?

On Friday 20 December 2019 01:24:14 Namjae Jeon wrote:
> This adds the implementation of exfat cache.
>=20
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> ---
>  fs/exfat/cache.c | 325 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 325 insertions(+)
>  create mode 100644 fs/exfat/cache.c
>=20
> diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
> new file mode 100644
> index 000000000000..03d0824fc368
> --- /dev/null
> +++ b/fs/exfat/cache.c
> @@ -0,0 +1,325 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  linux/fs/fat/cache.c
> + *
> + *  Written 1992,1993 by Werner Almesberger
> + *
> + *  Mar 1999. AV. Changed cache, so that it uses the starting cluster in=
stead
> + *	of inode number.
> + *  May 1999. AV. Fixed the bogosity with FAT32 (read "FAT28"). Fscking =
lusers.
> + *  Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
> + */
> +
> +#include <linux/slab.h>
> +#include <asm/unaligned.h>
> +#include <linux/buffer_head.h>
> +
> +#include "exfat_raw.h"
> +#include "exfat_fs.h"
> +
> +#define EXFAT_CACHE_VALID	0
> +#define EXFAT_MAX_CACHE		16
> +
> +struct exfat_cache {
> +	struct list_head cache_list;
> +	unsigned int nr_contig;	/* number of contiguous clusters */
> +	unsigned int fcluster;	/* cluster number in the file. */
> +	unsigned int dcluster;	/* cluster number on disk. */
> +};
> +
> +struct exfat_cache_id {
> +	unsigned int id;
> +	unsigned int nr_contig;
> +	unsigned int fcluster;
> +	unsigned int dcluster;
> +};
> +
> +static struct kmem_cache *exfat_cachep;
> +
> +static void exfat_cache_init_once(void *c)
> +{
> +	struct exfat_cache *cache =3D (struct exfat_cache *)c;
> +
> +	INIT_LIST_HEAD(&cache->cache_list);
> +}
> +
> +int exfat_cache_init(void)
> +{
> +	exfat_cachep =3D kmem_cache_create("exfat_cache",
> +				sizeof(struct exfat_cache),
> +				0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
> +				exfat_cache_init_once);
> +	if (!exfat_cachep)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +void exfat_cache_shutdown(void)
> +{
> +	if (!exfat_cachep)
> +		return;
> +	kmem_cache_destroy(exfat_cachep);
> +}
> +
> +void exfat_cache_init_inode(struct inode *inode)
> +{
> +	struct exfat_inode_info *ei =3D EXFAT_I(inode);
> +
> +	spin_lock_init(&ei->cache_lru_lock);
> +	ei->nr_caches =3D 0;
> +	ei->cache_valid_id =3D EXFAT_CACHE_VALID + 1;
> +	INIT_LIST_HEAD(&ei->cache_lru);
> +}
> +
> +static inline struct exfat_cache *exfat_cache_alloc(void)
> +{
> +	return kmem_cache_alloc(exfat_cachep, GFP_NOFS);
> +}
> +
> +static inline void exfat_cache_free(struct exfat_cache *cache)
> +{
> +	WARN_ON(!list_empty(&cache->cache_list));
> +	kmem_cache_free(exfat_cachep, cache);
> +}
> +
> +static inline void exfat_cache_update_lru(struct inode *inode,
> +		struct exfat_cache *cache)
> +{
> +	struct exfat_inode_info *ei =3D EXFAT_I(inode);
> +
> +	if (ei->cache_lru.next !=3D &cache->cache_list)
> +		list_move(&cache->cache_list, &ei->cache_lru);
> +}
> +
> +static unsigned int exfat_cache_lookup(struct inode *inode,
> +		unsigned int fclus, struct exfat_cache_id *cid,
> +		unsigned int *cached_fclus, unsigned int *cached_dclus)
> +{
> +	struct exfat_inode_info *ei =3D EXFAT_I(inode);
> +	static struct exfat_cache nohit =3D { .fcluster =3D 0, };
> +	struct exfat_cache *hit =3D &nohit, *p;
> +	unsigned int offset =3D EXFAT_EOF_CLUSTER;
> +
> +	spin_lock(&ei->cache_lru_lock);
> +	list_for_each_entry(p, &ei->cache_lru, cache_list) {
> +		/* Find the cache of "fclus" or nearest cache. */
> +		if (p->fcluster <=3D fclus && hit->fcluster < p->fcluster) {
> +			hit =3D p;
> +			if (hit->fcluster + hit->nr_contig < fclus) {
> +				offset =3D hit->nr_contig;
> +			} else {
> +				offset =3D fclus - hit->fcluster;
> +				break;
> +			}
> +		}
> +	}
> +	if (hit !=3D &nohit) {
> +		exfat_cache_update_lru(inode, hit);
> +
> +		cid->id =3D ei->cache_valid_id;
> +		cid->nr_contig =3D hit->nr_contig;
> +		cid->fcluster =3D hit->fcluster;
> +		cid->dcluster =3D hit->dcluster;
> +		*cached_fclus =3D cid->fcluster + offset;
> +		*cached_dclus =3D cid->dcluster + offset;
> +	}
> +	spin_unlock(&ei->cache_lru_lock);
> +
> +	return offset;
> +}
> +
> +static struct exfat_cache *exfat_cache_merge(struct inode *inode,
> +		struct exfat_cache_id *new)
> +{
> +	struct exfat_inode_info *ei =3D EXFAT_I(inode);
> +	struct exfat_cache *p;
> +
> +	list_for_each_entry(p, &ei->cache_lru, cache_list) {
> +		/* Find the same part as "new" in cluster-chain. */
> +		if (p->fcluster =3D=3D new->fcluster) {
> +			if (new->nr_contig > p->nr_contig)
> +				p->nr_contig =3D new->nr_contig;
> +			return p;
> +		}
> +	}
> +	return NULL;
> +}
> +
> +static void exfat_cache_add(struct inode *inode,
> +		struct exfat_cache_id *new)
> +{
> +	struct exfat_inode_info *ei =3D EXFAT_I(inode);
> +	struct exfat_cache *cache, *tmp;
> +
> +	if (new->fcluster =3D=3D EXFAT_EOF_CLUSTER) /* dummy cache */
> +		return;
> +
> +	spin_lock(&ei->cache_lru_lock);
> +	if (new->id !=3D EXFAT_CACHE_VALID &&
> +	    new->id !=3D ei->cache_valid_id)
> +		goto unlock;	/* this cache was invalidated */
> +
> +	cache =3D exfat_cache_merge(inode, new);
> +	if (cache =3D=3D NULL) {
> +		if (ei->nr_caches < EXFAT_MAX_CACHE) {
> +			ei->nr_caches++;
> +			spin_unlock(&ei->cache_lru_lock);
> +
> +			tmp =3D exfat_cache_alloc();
> +			if (!tmp) {
> +				spin_lock(&ei->cache_lru_lock);
> +				ei->nr_caches--;
> +				spin_unlock(&ei->cache_lru_lock);
> +				return;
> +			}
> +
> +			spin_lock(&ei->cache_lru_lock);
> +			cache =3D exfat_cache_merge(inode, new);
> +			if (cache !=3D NULL) {
> +				ei->nr_caches--;
> +				exfat_cache_free(tmp);
> +				goto out_update_lru;
> +			}
> +			cache =3D tmp;
> +		} else {
> +			struct list_head *p =3D ei->cache_lru.prev;
> +
> +			cache =3D list_entry(p,
> +					struct exfat_cache, cache_list);
> +		}
> +		cache->fcluster =3D new->fcluster;
> +		cache->dcluster =3D new->dcluster;
> +		cache->nr_contig =3D new->nr_contig;
> +	}
> +out_update_lru:
> +	exfat_cache_update_lru(inode, cache);
> +unlock:
> +	spin_unlock(&ei->cache_lru_lock);
> +}
> +
> +/*
> + * Cache invalidation occurs rarely, thus the LRU chain is not updated. =
It
> + * fixes itself after a while.
> + */
> +static void __exfat_cache_inval_inode(struct inode *inode)
> +{
> +	struct exfat_inode_info *ei =3D EXFAT_I(inode);
> +	struct exfat_cache *cache;
> +
> +	while (!list_empty(&ei->cache_lru)) {
> +		cache =3D list_entry(ei->cache_lru.next,
> +				   struct exfat_cache, cache_list);
> +		list_del_init(&cache->cache_list);
> +		ei->nr_caches--;
> +		exfat_cache_free(cache);
> +	}
> +	/* Update. The copy of caches before this id is discarded. */
> +	ei->cache_valid_id++;
> +	if (ei->cache_valid_id =3D=3D EXFAT_CACHE_VALID)
> +		ei->cache_valid_id++;
> +}
> +
> +void exfat_cache_inval_inode(struct inode *inode)
> +{
> +	struct exfat_inode_info *ei =3D EXFAT_I(inode);
> +
> +	spin_lock(&ei->cache_lru_lock);
> +	__exfat_cache_inval_inode(inode);
> +	spin_unlock(&ei->cache_lru_lock);
> +}
> +
> +static inline int cache_contiguous(struct exfat_cache_id *cid,
> +		unsigned int dclus)
> +{
> +	cid->nr_contig++;
> +	return cid->dcluster + cid->nr_contig =3D=3D dclus;
> +}
> +
> +static inline void cache_init(struct exfat_cache_id *cid,
> +		unsigned int fclus, unsigned int dclus)
> +{
> +	cid->id =3D EXFAT_CACHE_VALID;
> +	cid->fcluster =3D fclus;
> +	cid->dcluster =3D dclus;
> +	cid->nr_contig =3D 0;
> +}
> +
> +int exfat_get_cluster(struct inode *inode, unsigned int cluster,
> +		unsigned int *fclus, unsigned int *dclus,
> +		unsigned int *last_dclus, int allow_eof)
> +{
> +	struct super_block *sb =3D inode->i_sb;
> +	struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> +	unsigned int limit =3D sbi->num_clusters;
> +	struct exfat_inode_info *ei =3D EXFAT_I(inode);
> +	struct exfat_cache_id cid;
> +	unsigned int content;
> +
> +	if (ei->start_clu =3D=3D EXFAT_FREE_CLUSTER) {
> +		exfat_fs_error(sb,
> +			"invalid access to exfat cache (entry 0x%08x)",
> +			ei->start_clu);
> +		return -EIO;
> +	}
> +
> +	*fclus =3D 0;
> +	*dclus =3D ei->start_clu;
> +	*last_dclus =3D *dclus;
> +
> +	/*
> +	 * Don`t use exfat_cache if zero offset or non-cluster allocation
> +	 */
> +	if (cluster =3D=3D 0 || *dclus =3D=3D EXFAT_EOF_CLUSTER)
> +		return 0;
> +
> +	cache_init(&cid, EXFAT_EOF_CLUSTER, EXFAT_EOF_CLUSTER);
> +
> +	if (exfat_cache_lookup(inode, cluster, &cid, fclus, dclus) =3D=3D
> +			EXFAT_EOF_CLUSTER) {
> +		/*
> +		 * dummy, always not contiguous
> +		 * This is reinitialized by cache_init(), later.
> +		 */
> +		WARN_ON(cid.id !=3D EXFAT_CACHE_VALID ||
> +			cid.fcluster !=3D EXFAT_EOF_CLUSTER ||
> +			cid.dcluster !=3D EXFAT_EOF_CLUSTER ||
> +			cid.nr_contig !=3D 0);
> +	}
> +
> +	if (*fclus =3D=3D cluster)
> +		return 0;
> +
> +	while (*fclus < cluster) {
> +		/* prevent the infinite loop of cluster chain */
> +		if (*fclus > limit) {
> +			exfat_fs_error(sb,
> +				"detected the cluster chain loop (i_pos %u)",
> +				(*fclus));
> +			return -EIO;
> +		}
> +
> +		if (exfat_ent_get(sb, *dclus, &content))
> +			return -EIO;
> +
> +		*last_dclus =3D *dclus;
> +		*dclus =3D content;
> +		(*fclus)++;
> +
> +		if (content =3D=3D EXFAT_EOF_CLUSTER) {
> +			if (!allow_eof) {
> +				exfat_fs_error(sb,
> +				       "invalid cluster chain (i_pos %u, last_clus 0x%08x is EOF)",
> +				       *fclus, (*last_dclus));
> +				return -EIO;
> +			}
> +
> +			break;
> +		}
> +
> +		if (!cache_contiguous(&cid, *dclus))
> +			cache_init(&cid, *fclus, *dclus);
> +	}
> +
> +	exfat_cache_add(inode, &cid);
> +	return 0;
> +}

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--oz3thgrwz46oq5d4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXgi26gAKCRCL8Mk9A+RD
UmBiAJ0TZEPiG5ILPdHWbRKz40OWYyN6KgCgwrpmMgDi5wOhqTDc9tqlJYR2YpA=
=Socp
-----END PGP SIGNATURE-----

--oz3thgrwz46oq5d4--
