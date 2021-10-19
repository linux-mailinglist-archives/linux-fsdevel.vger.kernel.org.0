Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D456D433E0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 20:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhJSSIB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 14:08:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234125AbhJSSHz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 14:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634666742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W+GMY9n6Ehj8Ei399MPtIiZiGcQAYKNmoNkQoVywtTM=;
        b=Xyun3SoqmUO0tguwLQRXmzFEBnaHJQg97idYbmJT6m+/GTizs3yLPP3QidDgVWiWUKmoMA
        OhMl95iUT/lOgnOgqSmHvlEPWx3KlDhWBiw1zEmS++R/Zbae+9AIR7M1o8gaDPg7wS36ej
        Yo7MfBsVUWzbOqBvppvI2W7WdM9HCj0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-bDt51InUOXGwVdVGptSNqg-1; Tue, 19 Oct 2021 14:05:40 -0400
X-MC-Unique: bDt51InUOXGwVdVGptSNqg-1
Received: by mail-qk1-f197.google.com with SMTP id j6-20020a05620a288600b0045e5d85ca17so522552qkp.16
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 11:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=W+GMY9n6Ehj8Ei399MPtIiZiGcQAYKNmoNkQoVywtTM=;
        b=bvtMj9zczE4f+JmeNahv2aGMqNzbXsH5w62kUbV7yBqmbiftafp6Y4vQERdNMEzBmY
         DQ42APYJsIE4YulkZKOdN9mfjUNxfewCeU/UnLeK9cbz5ws0JFeMGKee2suqcrZ2YzAQ
         dVa4/rTYqBlfS6HTB7E38zQSaUWBh9BUsK/pMX82noXKqqYbZIaJ/RxOFnyaPc+3JgtR
         /3178agpXtKPAyjqnzdiG7t3zmrM3BQneO6jP4H+6w856QkLMEwl4Q7f2bDDAWPnCT1G
         yOCypvN9HJj9P5nHAV3CmTh9LHIgf2xC1yWUR9RqQ86K+jY4zGqNgtNWA3Pj+PSLYrIr
         gC5w==
X-Gm-Message-State: AOAM533RDfA3XGfjtcodDyCB4UY3ydP4uq+XybFOUo7BMxtEgG4bFUmg
        +EFq7xjNs5RTT4c6MeM1N/IIHcjaL+5BWqAW5eLDkemcgw+PLxEYnYRGYEREkGbyauyWpWXJtir
        8lqYMU+tJb+kp8EJKBXaC/d7jYg==
X-Received: by 2002:ae9:de07:: with SMTP id s7mr1273938qkf.47.1634666739579;
        Tue, 19 Oct 2021 11:05:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYzLQTI9GNKe23YcETcb0M3EeRr/1ZYjdM+0PFIqEFoptdBb8wBlfhyEzCtTCy8mxAyWsV8A==
X-Received: by 2002:ae9:de07:: with SMTP id s7mr1273486qkf.47.1634666734809;
        Tue, 19 Oct 2021 11:05:34 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id e13sm8359445qka.117.2021.10.19.11.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 11:05:34 -0700 (PDT)
Message-ID: <b6e24bfe0141699e7cc5df03942bfbb30182064f.camel@redhat.com>
Subject: Re: [PATCH 07/67] fscache: Remove the netfs data from the cookie
From:   Jeff Layton <jlayton@redhat.com>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Oct 2021 14:05:33 -0400
In-Reply-To: <163456875022.2614702.16319425026413735075.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
         <163456875022.2614702.16319425026413735075.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-10-18 at 15:52 +0100, David Howells wrote:
> Remove the netfs data pointer from the cookie so that we don't refer back
> to the netfs state and don't need accessors to manage this.  Keep the
> information we do need (of which there's not actually a lot) in the cookie
> which we can keep hold of if the netfs state goes away.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/afs/cache.c                |   39 --------
>  fs/afs/cell.c                 |    3 -
>  fs/afs/inode.c                |    3 -
>  fs/afs/volume.c               |    4 -

This patch is really "fscache+afs: ", which sort of makes it harder to
follow. It would be nice to be able to follow in the logical footsteps
of how you converted AFS when converting other filesystems. This series
makes that hard to do. Some of the AFS-specific changes are hidden in
fscache patches. It would be cleaner to separate them.

AFS+fscache is not disabled in this part of the series either. If
(hypothetically) an AFS user were to be bisecting kernel revisions and
landed somewhere in the middle of this series, what behavior should they
expect to see? Will it still work?

>  fs/cachefiles/interface.c     |  104 +++------------------
>  fs/cachefiles/internal.h      |   20 +---
>  fs/cachefiles/namei.c         |   10 +-
>  fs/cachefiles/xattr.c         |  202 +++++++----------------------------------
>  fs/fscache/cache.c            |   20 +---
>  fs/fscache/cookie.c           |   33 +++----
>  fs/fscache/fsdef.c            |   37 --------
>  fs/fscache/internal.h         |   29 ++++--
>  fs/fscache/netfs.c            |    3 -
>  fs/fscache/object.c           |   49 ----------
>  include/linux/fscache-cache.h |   32 +++++-
>  include/linux/fscache.h       |   39 +-------
>  16 files changed, 136 insertions(+), 491 deletions(-)
> 
> diff --git a/fs/afs/cache.c b/fs/afs/cache.c
> index 037af93e3aba..9b2de3014dbf 100644
> --- a/fs/afs/cache.c
> +++ b/fs/afs/cache.c
> @@ -8,11 +8,6 @@
>  #include <linux/sched.h>
>  #include "internal.h"
>  
> -static enum fscache_checkaux afs_vnode_cache_check_aux(void *cookie_netfs_data,
> -						       const void *buffer,
> -						       uint16_t buflen,
> -						       loff_t object_size);
> -
>  struct fscache_netfs afs_cache_netfs = {
>  	.name			= "afs",
>  	.version		= 2,
> @@ -31,38 +26,4 @@ struct fscache_cookie_def afs_volume_cache_index_def = {
>  struct fscache_cookie_def afs_vnode_cache_index_def = {
>  	.name		= "AFS.vnode",
>  	.type		= FSCACHE_COOKIE_TYPE_DATAFILE,
> -	.check_aux	= afs_vnode_cache_check_aux,
>  };
> -
> -/*
> - * check that the auxiliary data indicates that the entry is still valid
> - */
> -static enum fscache_checkaux afs_vnode_cache_check_aux(void *cookie_netfs_data,
> -						       const void *buffer,
> -						       uint16_t buflen,
> -						       loff_t object_size)
> -{
> -	struct afs_vnode *vnode = cookie_netfs_data;
> -	struct afs_vnode_cache_aux aux;
> -
> -	_enter("{%llx,%x,%llx},%p,%u",
> -	       vnode->fid.vnode, vnode->fid.unique, vnode->status.data_version,
> -	       buffer, buflen);
> -
> -	memcpy(&aux, buffer, sizeof(aux));
> -
> -	/* check the size of the data is what we're expecting */
> -	if (buflen != sizeof(aux)) {
> -		_leave(" = OBSOLETE [len %hx != %zx]", buflen, sizeof(aux));
> -		return FSCACHE_CHECKAUX_OBSOLETE;
> -	}
> -
> -	if (vnode->status.data_version != aux.data_version) {
> -		_leave(" = OBSOLETE [vers %llx != %llx]",
> -		       aux.data_version, vnode->status.data_version);
> -		return FSCACHE_CHECKAUX_OBSOLETE;
> -	}
> -
> -	_leave(" = SUCCESS");
> -	return FSCACHE_CHECKAUX_OKAY;
> -}
> diff --git a/fs/afs/cell.c b/fs/afs/cell.c
> index d88407fb9bc0..416f9bd638a5 100644
> --- a/fs/afs/cell.c
> +++ b/fs/afs/cell.c
> @@ -683,9 +683,10 @@ static int afs_activate_cell(struct afs_net *net, struct afs_cell *cell)
>  #ifdef CONFIG_AFS_FSCACHE
>  	cell->cache = fscache_acquire_cookie(afs_cache_netfs.primary_index,
>  					     &afs_cell_cache_index_def,
> +					     NULL,
>  					     cell->name, strlen(cell->name),
>  					     NULL, 0,
> -					     cell, 0, true);
> +					     0, true);
>  #endif
>  	ret = afs_proc_cell_setup(cell);
>  	if (ret < 0)
> diff --git a/fs/afs/inode.c b/fs/afs/inode.c
> index 8fcffea2daf5..3b696ac7c05a 100644
> --- a/fs/afs/inode.c
> +++ b/fs/afs/inode.c
> @@ -432,9 +432,10 @@ static void afs_get_inode_cache(struct afs_vnode *vnode)
>  
>  	vnode->cache = fscache_acquire_cookie(vnode->volume->cache,
>  					      &afs_vnode_cache_index_def,
> +					      NULL,
>  					      &key, sizeof(key),
>  					      &aux, sizeof(aux),
> -					      vnode, vnode->status.size, true);
> +					      vnode->status.size, true);
>  #endif
>  }
>  
> diff --git a/fs/afs/volume.c b/fs/afs/volume.c
> index f84194b791d3..9ca246ab1a86 100644
> --- a/fs/afs/volume.c
> +++ b/fs/afs/volume.c
> @@ -273,9 +273,9 @@ void afs_activate_volume(struct afs_volume *volume)
>  #ifdef CONFIG_AFS_FSCACHE
>  	volume->cache = fscache_acquire_cookie(volume->cell->cache,
>  					       &afs_volume_cache_index_def,
> +					       NULL,
>  					       &volume->vid, sizeof(volume->vid),
> -					       NULL, 0,
> -					       volume, 0, true);
> +					       NULL, 0, 0, true);
>  #endif
>  }
>  
> diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
> index 83671488a323..6c48e81deccc 100644
> --- a/fs/cachefiles/interface.c
> +++ b/fs/cachefiles/interface.c
> @@ -7,13 +7,9 @@
>  
>  #include <linux/slab.h>
>  #include <linux/mount.h>
> +#include <linux/xattr.h>
>  #include "internal.h"
>  
> -struct cachefiles_lookup_data {
> -	struct cachefiles_xattr	*auxdata;	/* auxiliary data */
> -	char			*key;		/* key path */
> -};
> -
>  static int cachefiles_attr_changed(struct fscache_object *_object);
>  
>  /*
> @@ -23,11 +19,9 @@ static struct fscache_object *cachefiles_alloc_object(
>  	struct fscache_cache *_cache,
>  	struct fscache_cookie *cookie)
>  {
> -	struct cachefiles_lookup_data *lookup_data;
>  	struct cachefiles_object *object;
>  	struct cachefiles_cache *cache;
> -	struct cachefiles_xattr *auxdata;
> -	unsigned keylen, auxlen;
> +	unsigned keylen;
>  	void *buffer, *p;
>  	char *key;
>  
> @@ -35,10 +29,6 @@ static struct fscache_object *cachefiles_alloc_object(
>  
>  	_enter("{%s},%x,", cache->cache.identifier, cookie->debug_id);
>  
> -	lookup_data = kmalloc(sizeof(*lookup_data), cachefiles_gfp);
> -	if (!lookup_data)
> -		goto nomem_lookup_data;
> -
>  	/* create a new object record and a temporary leaf image */
>  	object = kmem_cache_alloc(cachefiles_object_jar, cachefiles_gfp);
>  	if (!object)
> @@ -62,10 +52,7 @@ static struct fscache_object *cachefiles_alloc_object(
>  		goto nomem_buffer;
>  
>  	keylen = cookie->key_len;
> -	if (keylen <= sizeof(cookie->inline_key))
> -		p = cookie->inline_key;
> -	else
> -		p = cookie->key;
> +	p = fscache_get_key(cookie);
>  	memcpy(buffer + 2, p, keylen);
>  
>  	*(uint16_t *)buffer = keylen;
> @@ -75,28 +62,13 @@ static struct fscache_object *cachefiles_alloc_object(
>  
>  	/* turn the raw key into something that can work with as a filename */
>  	key = cachefiles_cook_key(buffer, keylen + 2, object->type);
> +	kfree(buffer);
>  	if (!key)
>  		goto nomem_key;
>  
> -	/* get hold of the auxiliary data and prepend the object type */
> -	auxdata = buffer;
> -	auxlen = cookie->aux_len;
> -	if (auxlen) {
> -		if (auxlen <= sizeof(cookie->inline_aux))
> -			p = cookie->inline_aux;
> -		else
> -			p = cookie->aux;
> -		memcpy(auxdata->data, p, auxlen);
> -	}
> -
> -	auxdata->len = auxlen + 1;
> -	auxdata->type = cookie->type;
> -
> -	lookup_data->auxdata = auxdata;
> -	lookup_data->key = key;
> -	object->lookup_data = lookup_data;
> +	object->lookup_key = key;
>  
> -	_leave(" = %x [%p]", object->fscache.debug_id, lookup_data);
> +	_leave(" = %x [%s]", object->fscache.debug_id, key);
>  	return &object->fscache;
>  
>  nomem_key:
> @@ -106,8 +78,6 @@ static struct fscache_object *cachefiles_alloc_object(
>  	kmem_cache_free(cachefiles_object_jar, object);
>  	fscache_object_destroyed(&cache->cache);
>  nomem_object:
> -	kfree(lookup_data);
> -nomem_lookup_data:
>  	_leave(" = -ENOMEM");
>  	return ERR_PTR(-ENOMEM);
>  }
> @@ -118,7 +88,6 @@ static struct fscache_object *cachefiles_alloc_object(
>   */
>  static int cachefiles_lookup_object(struct fscache_object *_object)
>  {
> -	struct cachefiles_lookup_data *lookup_data;
>  	struct cachefiles_object *parent, *object;
>  	struct cachefiles_cache *cache;
>  	const struct cred *saved_cred;
> @@ -130,15 +99,12 @@ static int cachefiles_lookup_object(struct fscache_object *_object)
>  	parent = container_of(_object->parent,
>  			      struct cachefiles_object, fscache);
>  	object = container_of(_object, struct cachefiles_object, fscache);
> -	lookup_data = object->lookup_data;
>  
> -	ASSERTCMP(lookup_data, !=, NULL);
> +	ASSERTCMP(object->lookup_key, !=, NULL);
>  
>  	/* look up the key, creating any missing bits */
>  	cachefiles_begin_secure(cache, &saved_cred);
> -	ret = cachefiles_walk_to_object(parent, object,
> -					lookup_data->key,
> -					lookup_data->auxdata);
> +	ret = cachefiles_walk_to_object(parent, object, object->lookup_key);
>  	cachefiles_end_secure(cache, saved_cred);
>  
>  	/* polish off by setting the attributes of non-index files */
> @@ -165,14 +131,10 @@ static void cachefiles_lookup_complete(struct fscache_object *_object)
>  
>  	object = container_of(_object, struct cachefiles_object, fscache);
>  
> -	_enter("{OBJ%x,%p}", object->fscache.debug_id, object->lookup_data);
> +	_enter("{OBJ%x}", object->fscache.debug_id);
>  
> -	if (object->lookup_data) {
> -		kfree(object->lookup_data->key);
> -		kfree(object->lookup_data->auxdata);
> -		kfree(object->lookup_data);
> -		object->lookup_data = NULL;
> -	}
> +	kfree(object->lookup_key);
> +	object->lookup_key = NULL;
>  }
>  
>  /*
> @@ -204,12 +166,8 @@ struct fscache_object *cachefiles_grab_object(struct fscache_object *_object,
>  static void cachefiles_update_object(struct fscache_object *_object)
>  {
>  	struct cachefiles_object *object;
> -	struct cachefiles_xattr *auxdata;
>  	struct cachefiles_cache *cache;
> -	struct fscache_cookie *cookie;
>  	const struct cred *saved_cred;
> -	const void *aux;
> -	unsigned auxlen;
>  
>  	_enter("{OBJ%x}", _object->debug_id);
>  
> @@ -217,40 +175,9 @@ static void cachefiles_update_object(struct fscache_object *_object)
>  	cache = container_of(object->fscache.cache, struct cachefiles_cache,
>  			     cache);
>  
> -	if (!fscache_use_cookie(_object)) {
> -		_leave(" [relinq]");
> -		return;
> -	}
> -
> -	cookie = object->fscache.cookie;
> -	auxlen = cookie->aux_len;
> -
> -	if (!auxlen) {
> -		fscache_unuse_cookie(_object);
> -		_leave(" [no aux]");
> -		return;
> -	}
> -
> -	auxdata = kmalloc(2 + auxlen + 3, cachefiles_gfp);
> -	if (!auxdata) {
> -		fscache_unuse_cookie(_object);
> -		_leave(" [nomem]");
> -		return;
> -	}
> -
> -	aux = (auxlen <= sizeof(cookie->inline_aux)) ?
> -		cookie->inline_aux : cookie->aux;
> -
> -	memcpy(auxdata->data, aux, auxlen);
> -	fscache_unuse_cookie(_object);
> -
> -	auxdata->len = auxlen + 1;
> -	auxdata->type = cookie->type;
> -
>  	cachefiles_begin_secure(cache, &saved_cred);
> -	cachefiles_update_object_xattr(object, auxdata);
> +	cachefiles_set_object_xattr(object, XATTR_REPLACE);
>  	cachefiles_end_secure(cache, saved_cred);
> -	kfree(auxdata);
>  	_leave("");
>  }
>  
> @@ -354,12 +281,7 @@ void cachefiles_put_object(struct fscache_object *_object,
>  		ASSERTCMP(object->fscache.n_ops, ==, 0);
>  		ASSERTCMP(object->fscache.n_children, ==, 0);
>  
> -		if (object->lookup_data) {
> -			kfree(object->lookup_data->key);
> -			kfree(object->lookup_data->auxdata);
> -			kfree(object->lookup_data);
> -			object->lookup_data = NULL;
> -		}
> +		kfree(object->lookup_key);
>  
>  		cache = object->fscache.cache;
>  		fscache_object_destroy(&object->fscache);
> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index de982f4f513f..f6b85c370935 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -34,7 +34,7 @@ extern unsigned cachefiles_debug;
>   */
>  struct cachefiles_object {
>  	struct fscache_object		fscache;	/* fscache handle */
> -	struct cachefiles_lookup_data	*lookup_data;	/* cached lookup data */
> +	char				*lookup_key;	/* key to look up */
>  	struct dentry			*dentry;	/* the file/dir representing this object */
>  	struct dentry			*backer;	/* backing file */
>  	loff_t				i_size;		/* object size */
> @@ -88,15 +88,6 @@ struct cachefiles_cache {
>  	char				*tag;		/* cache binding tag */
>  };
>  
> -/*
> - * auxiliary data xattr buffer
> - */
> -struct cachefiles_xattr {
> -	uint16_t			len;
> -	uint8_t				type;
> -	uint8_t				data[];
> -};
> -
>  #include <trace/events/cachefiles.h>
>  
>  /*
> @@ -145,8 +136,7 @@ extern int cachefiles_delete_object(struct cachefiles_cache *cache,
>  				    struct cachefiles_object *object);
>  extern int cachefiles_walk_to_object(struct cachefiles_object *parent,
>  				     struct cachefiles_object *object,
> -				     const char *key,
> -				     struct cachefiles_xattr *auxdata);
> +				     const char *key);
>  extern struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
>  					       struct dentry *dir,
>  					       const char *name);
> @@ -188,12 +178,8 @@ static inline void cachefiles_end_secure(struct cachefiles_cache *cache,
>   */
>  extern int cachefiles_check_object_type(struct cachefiles_object *object);
>  extern int cachefiles_set_object_xattr(struct cachefiles_object *object,
> -				       struct cachefiles_xattr *auxdata);
> -extern int cachefiles_update_object_xattr(struct cachefiles_object *object,
> -					  struct cachefiles_xattr *auxdata);
> +				       unsigned int xattr_flags);
>  extern int cachefiles_check_auxdata(struct cachefiles_object *object);
> -extern int cachefiles_check_object_xattr(struct cachefiles_object *object,
> -					 struct cachefiles_xattr *auxdata);
>  extern int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
>  					  struct dentry *dentry);
>  
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index a9aca5ab5970..dc5e1e48c0a8 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -45,11 +45,10 @@ void __cachefiles_printk_object(struct cachefiles_object *object,
>  	spin_lock(&object->fscache.lock);
>  	cookie = object->fscache.cookie;
>  	if (cookie) {
> -		pr_err("%scookie=%x [pr=%x nd=%p fl=%lx]\n",
> +		pr_err("%scookie=%x [pr=%x fl=%lx]\n",
>  		       prefix,
>  		       cookie->debug_id,
>  		       cookie->parent ? cookie->parent->debug_id : 0,
> -		       cookie->netfs_data,
>  		       cookie->flags);
>  		pr_err("%skey=[%u] '", prefix, cookie->key_len);
>  		k = (cookie->key_len <= sizeof(cookie->inline_key)) ?
> @@ -487,8 +486,7 @@ int cachefiles_delete_object(struct cachefiles_cache *cache,
>   */
>  int cachefiles_walk_to_object(struct cachefiles_object *parent,
>  			      struct cachefiles_object *object,
> -			      const char *key,
> -			      struct cachefiles_xattr *auxdata)
> +			      const char *key)
>  {
>  	struct cachefiles_cache *cache;
>  	struct dentry *dir, *next = NULL;
> @@ -636,7 +634,7 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
>  	if (!object->new) {
>  		_debug("validate '%pd'", next);
>  
> -		ret = cachefiles_check_object_xattr(object, auxdata);
> +		ret = cachefiles_check_auxdata(object);
>  		if (ret == -ESTALE) {
>  			/* delete the object (the deleter drops the directory
>  			 * mutex) */
> @@ -671,7 +669,7 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
>  
>  	if (object->new) {
>  		/* attach data to a newly constructed terminal object */
> -		ret = cachefiles_set_object_xattr(object, auxdata);
> +		ret = cachefiles_set_object_xattr(object, XATTR_CREATE);
>  		if (ret < 0)
>  			goto check_error;
>  	} else {
> diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
> index 9e82de668595..c99952404932 100644
> --- a/fs/cachefiles/xattr.c
> +++ b/fs/cachefiles/xattr.c
> @@ -15,6 +15,11 @@
>  #include <linux/slab.h>
>  #include "internal.h"
>  
> +struct cachefiles_xattr {
> +	uint8_t				type;
> +	uint8_t				data[];
> +} __packed;
> +
>  static const char cachefiles_xattr_cache[] =
>  	XATTR_USER_PREFIX "CacheFiles.cache";
>  
> @@ -98,54 +103,35 @@ int cachefiles_check_object_type(struct cachefiles_object *object)
>   * set the state xattr on a cache file
>   */
>  int cachefiles_set_object_xattr(struct cachefiles_object *object,
> -				struct cachefiles_xattr *auxdata)
> -{
> -	struct dentry *dentry = object->dentry;
> -	int ret;
> -
> -	ASSERT(dentry);
> -
> -	_enter("%p,#%d", object, auxdata->len);
> -
> -	/* attempt to install the cache metadata directly */
> -	_debug("SET #%u", auxdata->len);
> -
> -	clear_bit(FSCACHE_COOKIE_AUX_UPDATED, &object->fscache.cookie->flags);
> -	ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
> -			   &auxdata->type, auxdata->len, XATTR_CREATE);
> -	if (ret < 0 && ret != -ENOMEM)
> -		cachefiles_io_error_obj(
> -			object,
> -			"Failed to set xattr with error %d", ret);
> -
> -	_leave(" = %d", ret);
> -	return ret;
> -}
> -
> -/*
> - * update the state xattr on a cache file
> - */
> -int cachefiles_update_object_xattr(struct cachefiles_object *object,
> -				   struct cachefiles_xattr *auxdata)
> +				unsigned int xattr_flags)
>  {
> +	struct cachefiles_xattr *buf;
>  	struct dentry *dentry = object->dentry;
> +	unsigned int len = object->fscache.cookie->aux_len;
>  	int ret;
>  
>  	if (!dentry)
>  		return -ESTALE;
>  
> -	_enter("%x,#%d", object->fscache.debug_id, auxdata->len);
> +	_enter("%x,#%d", object->fscache.debug_id, len);
>  
> -	/* attempt to install the cache metadata directly */
> -	_debug("SET #%u", auxdata->len);
> +	buf = kmalloc(sizeof(struct cachefiles_xattr) + len, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	buf->type = object->fscache.cookie->def->type;
> +	if (len > 0)
> +		memcpy(buf->data, fscache_get_aux(object->fscache.cookie), len);
>  
>  	clear_bit(FSCACHE_COOKIE_AUX_UPDATED, &object->fscache.cookie->flags);
>  	ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
> -			   &auxdata->type, auxdata->len, XATTR_REPLACE);
> +			   buf, sizeof(struct cachefiles_xattr) + len,
> +			   xattr_flags);
> +	kfree(buf);
>  	if (ret < 0 && ret != -ENOMEM)
>  		cachefiles_io_error_obj(
>  			object,
> -			"Failed to update xattr with error %d", ret);
> +			"Failed to set xattr with error %d", ret);
>  
>  	_leave(" = %d", ret);
>  	return ret;
> @@ -156,148 +142,30 @@ int cachefiles_update_object_xattr(struct cachefiles_object *object,
>   */
>  int cachefiles_check_auxdata(struct cachefiles_object *object)
>  {
> -	struct cachefiles_xattr *auxbuf;
> -	enum fscache_checkaux validity;
> -	struct dentry *dentry = object->dentry;
> -	ssize_t xlen;
> -	int ret;
> -
> -	ASSERT(dentry);
> -	ASSERT(d_backing_inode(dentry));
> -	ASSERT(object->fscache.cookie->def->check_aux);
> -
> -	auxbuf = kmalloc(sizeof(struct cachefiles_xattr) + 512, GFP_KERNEL);
> -	if (!auxbuf)
> -		return -ENOMEM;
> -
> -	xlen = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
> -			    &auxbuf->type, 512 + 1);
> -	ret = -ESTALE;
> -	if (xlen < 1 ||
> -	    auxbuf->type != object->fscache.cookie->def->type)
> -		goto error;
> -
> -	xlen--;
> -	validity = fscache_check_aux(&object->fscache, &auxbuf->data, xlen,
> -				     i_size_read(d_backing_inode(dentry)));
> -	if (validity != FSCACHE_CHECKAUX_OKAY)
> -		goto error;
> -
> -	ret = 0;
> -error:
> -	kfree(auxbuf);
> -	return ret;
> -}
> -
> -/*
> - * check the state xattr on a cache file
> - * - return -ESTALE if the object should be deleted
> - */
> -int cachefiles_check_object_xattr(struct cachefiles_object *object,
> -				  struct cachefiles_xattr *auxdata)
> -{
> -	struct cachefiles_xattr *auxbuf;
> +	struct cachefiles_xattr *buf;
>  	struct dentry *dentry = object->dentry;
> -	int ret;
> -
> -	_enter("%p,#%d", object, auxdata->len);
> +	unsigned int len = object->fscache.cookie->aux_len, tlen;
> +	const void *p = fscache_get_aux(object->fscache.cookie);
> +	ssize_t ret;
>  
>  	ASSERT(dentry);
>  	ASSERT(d_backing_inode(dentry));
>  
> -	auxbuf = kmalloc(sizeof(struct cachefiles_xattr) + 512, cachefiles_gfp);
> -	if (!auxbuf) {
> -		_leave(" = -ENOMEM");
> +	tlen = sizeof(struct cachefiles_xattr) + len;
> +	buf = kmalloc(tlen, GFP_KERNEL);
> +	if (!buf)
>  		return -ENOMEM;
> -	}
> -
> -	/* read the current type label */
> -	ret = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
> -			   &auxbuf->type, 512 + 1);
> -	if (ret < 0) {
> -		if (ret == -ENODATA)
> -			goto stale; /* no attribute - power went off
> -				     * mid-cull? */
> -
> -		if (ret == -ERANGE)
> -			goto bad_type_length;
>  
> -		cachefiles_io_error_obj(object,
> -					"Can't read xattr on %lu (err %d)",
> -					d_backing_inode(dentry)->i_ino, -ret);
> -		goto error;
> -	}
> -
> -	/* check the on-disk object */
> -	if (ret < 1)
> -		goto bad_type_length;
> -
> -	if (auxbuf->type != auxdata->type)
> -		goto stale;
> -
> -	auxbuf->len = ret;
> -
> -	/* consult the netfs */
> -	if (object->fscache.cookie->def->check_aux) {
> -		enum fscache_checkaux result;
> -		unsigned int dlen;
> -
> -		dlen = auxbuf->len - 1;
> -
> -		_debug("checkaux %s #%u",
> -		       object->fscache.cookie->def->name, dlen);
> -
> -		result = fscache_check_aux(&object->fscache,
> -					   &auxbuf->data, dlen,
> -					   i_size_read(d_backing_inode(dentry)));
> -
> -		switch (result) {
> -			/* entry okay as is */
> -		case FSCACHE_CHECKAUX_OKAY:
> -			goto okay;
> -
> -			/* entry requires update */
> -		case FSCACHE_CHECKAUX_NEEDS_UPDATE:
> -			break;
> -
> -			/* entry requires deletion */
> -		case FSCACHE_CHECKAUX_OBSOLETE:
> -			goto stale;
> -
> -		default:
> -			BUG();
> -		}
> -
> -		/* update the current label */
> -		ret = vfs_setxattr(&init_user_ns, dentry,
> -				   cachefiles_xattr_cache, &auxdata->type,
> -				   auxdata->len, XATTR_REPLACE);
> -		if (ret < 0) {
> -			cachefiles_io_error_obj(object,
> -						"Can't update xattr on %lu"
> -						" (error %d)",
> -						d_backing_inode(dentry)->i_ino, -ret);
> -			goto error;
> -		}
> -	}
> -
> -okay:
> -	ret = 0;
> +	ret = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache, buf, tlen);
> +	if (ret == tlen &&
> +	    buf->type == object->fscache.cookie->def->type &&
> +	    memcmp(buf->data, p, len) == 0)
> +		ret = 0;
> +	else
> +		ret = -ESTALE;
>  
> -error:
> -	kfree(auxbuf);
> -	_leave(" = %d", ret);
> +	kfree(buf);
>  	return ret;
> -
> -bad_type_length:
> -	pr_err("Cache object %lu xattr length incorrect\n",
> -	       d_backing_inode(dentry)->i_ino);
> -	ret = -EIO;
> -	goto error;
> -
> -stale:
> -	ret = -ESTALE;
> -	goto error;
>  }
>  
>  /*
> diff --git a/fs/fscache/cache.c b/fs/fscache/cache.c
> index cfa60c2faf68..efcdb40267d6 100644
> --- a/fs/fscache/cache.c
> +++ b/fs/fscache/cache.c
> @@ -30,6 +30,7 @@ struct fscache_cache_tag *__fscache_lookup_cache_tag(const char *name)
>  	list_for_each_entry(tag, &fscache_cache_tag_list, link) {
>  		if (strcmp(tag->name, name) == 0) {
>  			atomic_inc(&tag->usage);
> +			refcount_inc(&tag->ref);
>  			up_read(&fscache_addremove_sem);
>  			return tag;
>  		}
> @@ -44,6 +45,7 @@ struct fscache_cache_tag *__fscache_lookup_cache_tag(const char *name)
>  		return ERR_PTR(-ENOMEM);
>  
>  	atomic_set(&xtag->usage, 1);
> +	refcount_set(&xtag->ref, 1);
>  	strcpy(xtag->name, name);
>  
>  	/* write lock, search again and add if still not present */
> @@ -52,6 +54,7 @@ struct fscache_cache_tag *__fscache_lookup_cache_tag(const char *name)
>  	list_for_each_entry(tag, &fscache_cache_tag_list, link) {
>  		if (strcmp(tag->name, name) == 0) {
>  			atomic_inc(&tag->usage);
> +			refcount_inc(&tag->ref);
>  			up_write(&fscache_addremove_sem);
>  			kfree(xtag);
>  			return tag;
> @@ -64,7 +67,7 @@ struct fscache_cache_tag *__fscache_lookup_cache_tag(const char *name)
>  }
>  
>  /*
> - * release a reference to a cache tag
> + * Unuse a cache tag
>   */
>  void __fscache_release_cache_tag(struct fscache_cache_tag *tag)
>  {
> @@ -77,8 +80,7 @@ void __fscache_release_cache_tag(struct fscache_cache_tag *tag)
>  			tag = NULL;
>  
>  		up_write(&fscache_addremove_sem);
> -
> -		kfree(tag);
> +		fscache_put_cache_tag(tag);
>  	}
>  }
>  
> @@ -130,20 +132,10 @@ struct fscache_cache *fscache_select_cache_for_object(
>  
>  	spin_unlock(&cookie->lock);
>  
> -	if (!cookie->def->select_cache)
> -		goto no_preference;
> -
> -	/* ask the netfs for its preference */
> -	tag = cookie->def->select_cache(cookie->parent->netfs_data,
> -					cookie->netfs_data);
> +	tag = cookie->preferred_cache;
>  	if (!tag)
>  		goto no_preference;
>  
> -	if (tag == ERR_PTR(-ENOMEM)) {
> -		_leave(" = NULL [nomem tag]");
> -		return NULL;
> -	}
> -
>  	if (!tag->cache) {
>  		_leave(" = NULL [unbacked tag]");
>  		return NULL;
> diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
> index 8a850c3d0775..a772d4b6cacd 100644
> --- a/fs/fscache/cookie.c
> +++ b/fs/fscache/cookie.c
> @@ -43,11 +43,10 @@ static void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
>  	       cookie->flags,
>  	       atomic_read(&cookie->n_children),
>  	       atomic_read(&cookie->n_active));
> -	pr_err("%c-cookie d=%p{%s} n=%p\n",
> +	pr_err("%c-cookie d=%p{%s}\n",
>  	       prefix,
>  	       cookie->def,
> -	       cookie->def ? cookie->def->name : "?",
> -	       cookie->netfs_data);
> +	       cookie->def ? cookie->def->name : "?");
>  
>  	o = READ_ONCE(cookie->backing_objects.first);
>  	if (o) {
> @@ -74,6 +73,7 @@ void fscache_free_cookie(struct fscache_cookie *cookie)
>  			kfree(cookie->aux);
>  		if (cookie->key_len > sizeof(cookie->inline_key))
>  			kfree(cookie->key);
> +		fscache_put_cache_tag(cookie->preferred_cache);
>  		kmem_cache_free(fscache_cookie_jar, cookie);
>  	}
>  }
> @@ -138,9 +138,9 @@ static atomic_t fscache_cookie_debug_id = ATOMIC_INIT(1);
>  struct fscache_cookie *fscache_alloc_cookie(
>  	struct fscache_cookie *parent,
>  	const struct fscache_cookie_def *def,
> +	struct fscache_cache_tag *preferred_cache,
>  	const void *index_key, size_t index_key_len,
>  	const void *aux_data, size_t aux_data_len,
> -	void *netfs_data,
>  	loff_t object_size)
>  {
>  	struct fscache_cookie *cookie;
> @@ -175,7 +175,9 @@ struct fscache_cookie *fscache_alloc_cookie(
>  
>  	cookie->def		= def;
>  	cookie->parent		= parent;
> -	cookie->netfs_data	= netfs_data;
> +
> +	cookie->preferred_cache	= fscache_get_cache_tag(preferred_cache);
> +
>  	cookie->flags		= (1 << FSCACHE_COOKIE_NO_DATA_YET);
>  	cookie->type		= def->type;
>  	spin_lock_init(&cookie->lock);
> @@ -240,7 +242,6 @@ struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *candidate)
>   *   - the top level index cookie for each netfs is stored in the fscache_netfs
>   *     struct upon registration
>   * - def points to the definition
> - * - the netfs_data will be passed to the functions pointed to in *def
>   * - all attached caches will be searched to see if they contain this object
>   * - index objects aren't stored on disk until there's a dependent file that
>   *   needs storing
> @@ -252,9 +253,9 @@ struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *candidate)
>  struct fscache_cookie *__fscache_acquire_cookie(
>  	struct fscache_cookie *parent,
>  	const struct fscache_cookie_def *def,
> +	struct fscache_cache_tag *preferred_cache,
>  	const void *index_key, size_t index_key_len,
>  	const void *aux_data, size_t aux_data_len,
> -	void *netfs_data,
>  	loff_t object_size,
>  	bool enable)
>  {
> @@ -262,9 +263,9 @@ struct fscache_cookie *__fscache_acquire_cookie(
>  
>  	BUG_ON(!def);
>  
> -	_enter("{%s},{%s},%p,%u",
> +	_enter("{%s},{%s},%u",
>  	       parent ? (char *) parent->def->name : "<no-parent>",
> -	       def->name, netfs_data, enable);
> +	       def->name, enable);
>  
>  	if (!index_key || !index_key_len || index_key_len > 255 || aux_data_len > 255)
>  		return NULL;
> @@ -288,10 +289,10 @@ struct fscache_cookie *__fscache_acquire_cookie(
>  	BUG_ON(def->type == FSCACHE_COOKIE_TYPE_INDEX &&
>  	       parent->type != FSCACHE_COOKIE_TYPE_INDEX);
>  
> -	candidate = fscache_alloc_cookie(parent, def,
> +	candidate = fscache_alloc_cookie(parent, def, preferred_cache,
>  					 index_key, index_key_len,
>  					 aux_data, aux_data_len,
> -					 netfs_data, object_size);
> +					 object_size);
>  	if (!candidate) {
>  		fscache_stat(&fscache_n_acquires_oom);
>  		_leave(" [ENOMEM]");
> @@ -812,7 +813,6 @@ void __fscache_relinquish_cookie(struct fscache_cookie *cookie,
>  	__fscache_disable_cookie(cookie, aux_data, retire);
>  
>  	/* Clear pointers back to the netfs */
> -	cookie->netfs_data	= NULL;
>  	cookie->def		= NULL;
>  
>  	if (cookie->parent) {
> @@ -978,8 +978,8 @@ static int fscache_cookies_seq_show(struct seq_file *m, void *v)
>  
>  	if (v == &fscache_cookies) {
>  		seq_puts(m,
> -			 "COOKIE   PARENT   USAGE CHILD ACT TY FL  DEF              NETFS_DATA\n"
> -			 "======== ======== ===== ===== === == === ================ ==========\n"
> +			 "COOKIE   PARENT   USAGE CHILD ACT TY FL  DEF             \n"
> +			 "======== ======== ===== ===== === == === ================\n"
>  			 );
>  		return 0;
>  	}
> @@ -1001,7 +1001,7 @@ static int fscache_cookies_seq_show(struct seq_file *m, void *v)
>  	}
>  
>  	seq_printf(m,
> -		   "%08x %08x %5u %5u %3u %s %03lx %-16s %px",
> +		   "%08x %08x %5u %5u %3u %s %03lx %-16s",
>  		   cookie->debug_id,
>  		   cookie->parent ? cookie->parent->debug_id : 0,
>  		   refcount_read(&cookie->ref),
> @@ -1009,8 +1009,7 @@ static int fscache_cookies_seq_show(struct seq_file *m, void *v)
>  		   atomic_read(&cookie->n_active),
>  		   type,
>  		   cookie->flags,
> -		   cookie->def->name,
> -		   cookie->netfs_data);
> +		   cookie->def->name);
>  
>  	keylen = cookie->key_len;
>  	auxlen = cookie->aux_len;
> diff --git a/fs/fscache/fsdef.c b/fs/fscache/fsdef.c
> index 0402673c680e..111946ba9ce1 100644
> --- a/fs/fscache/fsdef.c
> +++ b/fs/fscache/fsdef.c
> @@ -9,12 +9,6 @@
>  #include <linux/module.h>
>  #include "internal.h"
>  
> -static
> -enum fscache_checkaux fscache_fsdef_netfs_check_aux(void *cookie_netfs_data,
> -						    const void *data,
> -						    uint16_t datalen,
> -						    loff_t object_size);
> -
>  /*
>   * The root index is owned by FS-Cache itself.
>   *
> @@ -64,35 +58,4 @@ EXPORT_SYMBOL(fscache_fsdef_index);
>  struct fscache_cookie_def fscache_fsdef_netfs_def = {
>  	.name		= "FSDEF.netfs",
>  	.type		= FSCACHE_COOKIE_TYPE_INDEX,
> -	.check_aux	= fscache_fsdef_netfs_check_aux,
>  };
> -
> -/*
> - * check that the index structure version number stored in the auxiliary data
> - * matches the one the netfs gave us
> - */
> -static enum fscache_checkaux fscache_fsdef_netfs_check_aux(
> -	void *cookie_netfs_data,
> -	const void *data,
> -	uint16_t datalen,
> -	loff_t object_size)
> -{
> -	struct fscache_netfs *netfs = cookie_netfs_data;
> -	uint32_t version;
> -
> -	_enter("{%s},,%hu", netfs->name, datalen);
> -
> -	if (datalen != sizeof(version)) {
> -		_leave(" = OBSOLETE [dl=%d v=%zu]", datalen, sizeof(version));
> -		return FSCACHE_CHECKAUX_OBSOLETE;
> -	}
> -
> -	memcpy(&version, data, sizeof(version));
> -	if (version != netfs->version) {
> -		_leave(" = OBSOLETE [ver=%x net=%x]", version, netfs->version);
> -		return FSCACHE_CHECKAUX_OBSOLETE;
> -	}
> -
> -	_leave(" = OKAY");
> -	return FSCACHE_CHECKAUX_OKAY;
> -}
> diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
> index 6eb3f51d7275..29f21fbd5b5d 100644
> --- a/fs/fscache/internal.h
> +++ b/fs/fscache/internal.h
> @@ -24,6 +24,7 @@
>  
>  #define pr_fmt(fmt) "FS-Cache: " fmt
>  
> +#include <linux/slab.h>
>  #include <linux/fscache-cache.h>
>  #include <trace/events/fscache.h>
>  #include <linux/sched.h>
> @@ -41,6 +42,20 @@ extern struct rw_semaphore fscache_addremove_sem;
>  extern struct fscache_cache *fscache_select_cache_for_object(
>  	struct fscache_cookie *);
>  
> +static inline
> +struct fscache_cache_tag *fscache_get_cache_tag(struct fscache_cache_tag *tag)
> +{
> +	if (tag)
> +		refcount_inc(&tag->ref);
> +	return tag;
> +}
> +
> +static inline void fscache_put_cache_tag(struct fscache_cache_tag *tag)
> +{
> +	if (tag && refcount_dec_and_test(&tag->ref))
> +		kfree(tag);
> +}
> +
>  /*
>   * cookie.c
>   */
> @@ -50,9 +65,10 @@ extern const struct seq_operations fscache_cookies_seq_ops;
>  extern void fscache_free_cookie(struct fscache_cookie *);
>  extern struct fscache_cookie *fscache_alloc_cookie(struct fscache_cookie *,
>  						   const struct fscache_cookie_def *,
> +						   struct fscache_cache_tag *,
>  						   const void *, size_t,
>  						   const void *, size_t,
> -						   void *, loff_t);
> +						   loff_t);
>  extern struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *);
>  extern struct fscache_cookie *fscache_cookie_get(struct fscache_cookie *,
>  						 enum fscache_cookie_trace);
> @@ -270,16 +286,9 @@ static inline void fscache_raise_event(struct fscache_object *object,
>  static inline
>  void fscache_update_aux(struct fscache_cookie *cookie, const void *aux_data)
>  {
> -	void *p;
> -
> -	if (!aux_data)
> -		return;
> -	if (cookie->aux_len <= sizeof(cookie->inline_aux))
> -		p = cookie->inline_aux;
> -	else
> -		p = cookie->aux;
> +	void *p = fscache_get_aux(cookie);
>  
> -	if (memcmp(p, aux_data, cookie->aux_len) != 0) {
> +	if (p && memcmp(p, aux_data, cookie->aux_len) != 0) {
>  		memcpy(p, aux_data, cookie->aux_len);
>  		set_bit(FSCACHE_COOKIE_AUX_UPDATED, &cookie->flags);
>  	}
> diff --git a/fs/fscache/netfs.c b/fs/fscache/netfs.c
> index d6bdb7b5e723..b8db06804876 100644
> --- a/fs/fscache/netfs.c
> +++ b/fs/fscache/netfs.c
> @@ -22,9 +22,10 @@ int __fscache_register_netfs(struct fscache_netfs *netfs)
>  	/* allocate a cookie for the primary index */
>  	candidate = fscache_alloc_cookie(&fscache_fsdef_index,
>  					 &fscache_fsdef_netfs_def,
> +					 NULL,
>  					 netfs->name, strlen(netfs->name),
>  					 &netfs->version, sizeof(netfs->version),
> -					 netfs, 0);
> +					 0);
>  	if (!candidate) {
>  		_leave(" = -ENOMEM");
>  		return -ENOMEM;
> diff --git a/fs/fscache/object.c b/fs/fscache/object.c
> index 86ad941726f7..cdcf6720d748 100644
> --- a/fs/fscache/object.c
> +++ b/fs/fscache/object.c
> @@ -901,55 +901,6 @@ static void fscache_dequeue_object(struct fscache_object *object)
>  	_leave("");
>  }
>  
> -/**
> - * fscache_check_aux - Ask the netfs whether an object on disk is still valid
> - * @object: The object to ask about
> - * @data: The auxiliary data for the object
> - * @datalen: The size of the auxiliary data
> - * @object_size: The size of the object according to the server.
> - *
> - * This function consults the netfs about the coherency state of an object.
> - * The caller must be holding a ref on cookie->n_active (held by
> - * fscache_look_up_object() on behalf of the cache backend during object lookup
> - * and creation).
> - */
> -enum fscache_checkaux fscache_check_aux(struct fscache_object *object,
> -					const void *data, uint16_t datalen,
> -					loff_t object_size)
> -{
> -	enum fscache_checkaux result;
> -
> -	if (!object->cookie->def->check_aux) {
> -		fscache_stat(&fscache_n_checkaux_none);
> -		return FSCACHE_CHECKAUX_OKAY;
> -	}
> -
> -	result = object->cookie->def->check_aux(object->cookie->netfs_data,
> -						data, datalen, object_size);
> -	switch (result) {
> -		/* entry okay as is */
> -	case FSCACHE_CHECKAUX_OKAY:
> -		fscache_stat(&fscache_n_checkaux_okay);
> -		break;
> -
> -		/* entry requires update */
> -	case FSCACHE_CHECKAUX_NEEDS_UPDATE:
> -		fscache_stat(&fscache_n_checkaux_update);
> -		break;
> -
> -		/* entry requires deletion */
> -	case FSCACHE_CHECKAUX_OBSOLETE:
> -		fscache_stat(&fscache_n_checkaux_obsolete);
> -		break;
> -
> -	default:
> -		BUG();
> -	}
> -
> -	return result;
> -}
> -EXPORT_SYMBOL(fscache_check_aux);
> -
>  /*
>   * Asynchronously invalidate an object.
>   */
> diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
> index 5e610f9a524c..264b94dad5be 100644
> --- a/include/linux/fscache-cache.h
> +++ b/include/linux/fscache-cache.h
> @@ -45,8 +45,9 @@ struct fscache_cache_tag {
>  	struct fscache_cache	*cache;		/* cache referred to by this tag */
>  	unsigned long		flags;
>  #define FSCACHE_TAG_RESERVED	0		/* T if tag is reserved for a cache */
> -	atomic_t		usage;
> -	char			name[];	/* tag name */
> +	atomic_t		usage;		/* Number of using netfs's */
> +	refcount_t		ref;		/* Reference count on structure */
> +	char			name[];		/* tag name */
>  };
>  
>  /*
> @@ -415,11 +416,6 @@ extern void fscache_io_error(struct fscache_cache *cache);
>  
>  extern bool fscache_object_sleep_till_congested(signed long *timeoutp);
>  
> -extern enum fscache_checkaux fscache_check_aux(struct fscache_object *object,
> -					       const void *data,
> -					       uint16_t datalen,
> -					       loff_t object_size);
> -
>  extern void fscache_object_retrying_stale(struct fscache_object *object);
>  
>  enum fscache_why_object_killed {
> @@ -431,4 +427,26 @@ enum fscache_why_object_killed {
>  extern void fscache_object_mark_killed(struct fscache_object *object,
>  				       enum fscache_why_object_killed why);
>  
> +/*
> + * Find the key on a cookie.
> + */
> +static inline void *fscache_get_key(struct fscache_cookie *cookie)
> +{
> +	if (cookie->key_len <= sizeof(cookie->inline_key))
> +		return cookie->inline_key;
> +	else
> +		return cookie->key;
> +}
> +
> +/*
> + * Find the auxiliary data on a cookie.
> + */
> +static inline void *fscache_get_aux(struct fscache_cookie *cookie)
> +{
> +	if (cookie->aux_len <= sizeof(cookie->inline_aux))
> +		return cookie->inline_aux;
> +	else
> +		return cookie->aux;
> +}
> +
>  #endif /* _LINUX_FSCACHE_CACHE_H */
> diff --git a/include/linux/fscache.h b/include/linux/fscache.h
> index ba4878b56717..cedab654dc79 100644
> --- a/include/linux/fscache.h
> +++ b/include/linux/fscache.h
> @@ -38,13 +38,6 @@ struct fscache_cookie;
>  struct fscache_netfs;
>  struct netfs_read_request;
>  
> -/* result of index entry consultation */
> -enum fscache_checkaux {
> -	FSCACHE_CHECKAUX_OKAY,		/* entry okay as is */
> -	FSCACHE_CHECKAUX_NEEDS_UPDATE,	/* entry requires update */
> -	FSCACHE_CHECKAUX_OBSOLETE,	/* entry requires deletion */
> -};
> -
>  /*
>   * fscache cookie definition
>   */
> @@ -56,26 +49,6 @@ struct fscache_cookie_def {
>  	uint8_t type;
>  #define FSCACHE_COOKIE_TYPE_INDEX	0
>  #define FSCACHE_COOKIE_TYPE_DATAFILE	1
> -
> -	/* select the cache into which to insert an entry in this index
> -	 * - optional
> -	 * - should return a cache identifier or NULL to cause the cache to be
> -	 *   inherited from the parent if possible or the first cache picked
> -	 *   for a non-index file if not
> -	 */
> -	struct fscache_cache_tag *(*select_cache)(
> -		const void *parent_netfs_data,
> -		const void *cookie_netfs_data);
> -
> -	/* consult the netfs about the state of an object
> -	 * - this function can be absent if the index carries no state data
> -	 * - the netfs data from the cookie being used as the target is
> -	 *   presented, as is the auxiliary data and the object size
> -	 */
> -	enum fscache_checkaux (*check_aux)(void *cookie_netfs_data,
> -					   const void *data,
> -					   uint16_t datalen,
> -					   loff_t object_size);
>  };
>  
>  /*
> @@ -105,9 +78,9 @@ struct fscache_cookie {
>  	struct hlist_head		backing_objects; /* object(s) backing this file/index */
>  	const struct fscache_cookie_def	*def;		/* definition */
>  	struct fscache_cookie		*parent;	/* parent of this entry */
> +	struct fscache_cache_tag	*preferred_cache; /* The preferred cache or NULL */
>  	struct hlist_bl_node		hash_link;	/* Link in hash table */
>  	struct list_head		proc_link;	/* Link in proc list */
> -	void				*netfs_data;	/* back pointer to netfs */
>  
>  	unsigned long			flags;
>  #define FSCACHE_COOKIE_LOOKING_UP	0	/* T if non-index cookie being looked up still */
> @@ -156,9 +129,10 @@ extern void __fscache_release_cache_tag(struct fscache_cache_tag *);
>  extern struct fscache_cookie *__fscache_acquire_cookie(
>  	struct fscache_cookie *,
>  	const struct fscache_cookie_def *,
> +	struct fscache_cache_tag *,
>  	const void *, size_t,
>  	const void *, size_t,
> -	void *, loff_t, bool);
> +	loff_t, bool);
>  extern void __fscache_relinquish_cookie(struct fscache_cookie *, const void *, bool);
>  extern int __fscache_check_consistency(struct fscache_cookie *, const void *);
>  extern void __fscache_update_cookie(struct fscache_cookie *, const void *);
> @@ -252,6 +226,7 @@ void fscache_release_cache_tag(struct fscache_cache_tag *tag)
>   * fscache_acquire_cookie - Acquire a cookie to represent a cache object
>   * @parent: The cookie that's to be the parent of this one
>   * @def: A description of the cache object, including callback operations
> + * @preferred_cache: The cache to use (or NULL)
>   * @index_key: The index key for this cookie
>   * @index_key_len: Size of the index key
>   * @aux_data: The auxiliary data for the cookie (may be NULL)
> @@ -272,19 +247,19 @@ static inline
>  struct fscache_cookie *fscache_acquire_cookie(
>  	struct fscache_cookie *parent,
>  	const struct fscache_cookie_def *def,
> +	struct fscache_cache_tag *preferred_cache,
>  	const void *index_key,
>  	size_t index_key_len,
>  	const void *aux_data,
>  	size_t aux_data_len,
> -	void *netfs_data,
>  	loff_t object_size,
>  	bool enable)
>  {
>  	if (fscache_cookie_valid(parent) && fscache_cookie_enabled(parent))
> -		return __fscache_acquire_cookie(parent, def,
> +		return __fscache_acquire_cookie(parent, def, preferred_cache,
>  						index_key, index_key_len,
>  						aux_data, aux_data_len,
> -						netfs_data, object_size, enable);
> +						object_size, enable);
>  	else
>  		return NULL;
>  }
> 
> 


-- 
Jeff Layton <jlayton@redhat.com>

