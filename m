Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDAC2FAF4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 05:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbhASEFc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 23:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbhASEDw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 23:03:52 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5698C061573;
        Mon, 18 Jan 2021 20:03:11 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id j3so664710ljb.9;
        Mon, 18 Jan 2021 20:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QZbf/tHbkOzK8ODkUs/F8ksdfv4bYbCZtEAyN+1lVFc=;
        b=iVnWB8g7Mb83HtkOHXTgAAGhI+6AjJvG/pcT/37eoLcFloQ7bshMYzCdKzuXiYtu9C
         2pT94OxVUO01ZH2VUgNxYfjxZ1Z9m0boIi1t9Ttgv431AtXwDNCTY8fgQjJliVoJTTiw
         1tmdP6DmaB8Q8+tlN4a+xX3Z9hRlIf5bfrGZAJxh5ZPhkxBp073OAVhMoH/7XBXXQeA7
         6k3ey+t4CzFZV4h/zUZDMHasukBWA6mFJKNzMzQUI5xbDdf+XiwawcVUxOXWixZExl2s
         MGffl9DJj/piFYXmXLU0+Bax31gph70GjwcXn5GxoRdgUg20zIjrjGGSQ6aVARJMTyji
         FODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QZbf/tHbkOzK8ODkUs/F8ksdfv4bYbCZtEAyN+1lVFc=;
        b=lw9jnxMwCtLnGU7FLIvPDnDd5MgRPSsWa08RzBLJsLSPajV7KLhB/pp1GJo/YjFUdD
         0S/vkPB+7rG0cQsbbnBCJAAv+CI+U3s3LQKdr22i7sn5E6LbJV95GjSGE6NV1CfIGChT
         bWQ09TNxKCOjO/O9yfylFBFEwfgHoV3LxDMkCVhFYttXG3FXRRfIYWtuM86EXjIqp4H/
         hRWtG94WIIcWd/htLmXl2uyh2DhGO2vvjfMfzyVK3YPY7EwHsvLqBqq616uWb3RgorKz
         rMPv9sbQ52A5TdILvkviHYD6JDPnnehLOyziSNmPg2/oyS5/KclbALSSvgNSogL7zINd
         reLg==
X-Gm-Message-State: AOAM533tI/PiHltUuhVhxDCVxHaATOgh4K0hIZxBXiXo/aM7jVs6aU/s
        xRXHKhDu852VXUUW+wWoqqU=
X-Google-Smtp-Source: ABdhPJztuSTxXLHjG6KJRw+QmajmQ+obnrUe+m87VL+zG528ca+DEStlj15L6rJRijL33pXbavz1gA==
X-Received: by 2002:a2e:b80d:: with SMTP id u13mr1025962ljo.143.1611028990209;
        Mon, 18 Jan 2021 20:03:10 -0800 (PST)
Received: from kari-VirtualBox (87-95-193-210.bb.dnainternet.fi. [87.95.193.210])
        by smtp.gmail.com with ESMTPSA id r201sm2135071lff.268.2021.01.18.20.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 20:03:09 -0800 (PST)
Date:   Tue, 19 Jan 2021 06:03:06 +0200
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com
Subject: Re: [PATCH v17 02/10] fs/ntfs3: Add initialization of super block
Message-ID: <20210119040306.54lm6oyeiarjrb2w@kari-VirtualBox>
References: <20201231152401.3162425-1-almaz.alexandrovich@paragon-software.com>
 <20201231152401.3162425-3-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201231152401.3162425-3-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 31, 2020 at 06:23:53PM +0300, Konstantin Komarov wrote:
> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c

> +void fnd_clear(struct ntfs_fnd *fnd)
> +{
> +	int i;
> +
> +	for (i = 0; i < fnd->level; i++) {
> +		struct indx_node *n = fnd->nodes[i];
> +
> +		if (!n)
> +			continue;
> +
> +		put_indx_node(n);
> +		fnd->nodes[i] = NULL;
> +	}
> +	fnd->level = 0;
> +	fnd->root_de = NULL;
> +}
> +
> +static int fnd_push(struct ntfs_fnd *fnd, struct indx_node *n,
> +		    struct NTFS_DE *e)
> +{
> +	int i;
> +
> +	i = fnd->level;
> +	if (i < 0 || i >= ARRAY_SIZE(fnd->nodes))
> +		return -EINVAL;
> +	fnd->nodes[i] = n;
> +	fnd->de[i] = e;
> +	fnd->level += 1;
> +	return 0;
> +}
> +
> +static struct indx_node *fnd_pop(struct ntfs_fnd *fnd)
> +{
> +	struct indx_node *n;
> +	int i = fnd->level;
> +
> +	i -= 1;
> +	n = fnd->nodes[i];
> +	fnd->nodes[i] = NULL;
> +	fnd->level = i;
> +
> +	return n;
> +}
> +
> +static bool fnd_is_empty(struct ntfs_fnd *fnd)
> +{
> +	if (!fnd->level)
> +		return !fnd->root_de;
> +
> +	return !fnd->de[fnd->level - 1];
> +}
> +
> +struct ntfs_fnd *fnd_get(struct ntfs_index *indx)
> +{
> +	struct ntfs_fnd *fnd = ntfs_alloc(sizeof(struct ntfs_fnd), 1);
> +
> +	if (!fnd)
> +		return NULL;
> +
> +	return fnd;
> +}

This should be initilized. What about that indx. Is that neccasarry?
Also no need to check NULL because if it is NULL we can just return it. 

> +
> +void fnd_put(struct ntfs_fnd *fnd)
> +{
> +	if (!fnd)
> +		return;
> +	fnd_clear(fnd);
> +	ntfs_free(fnd);
> +}

> +/*
> + * indx_insert_entry
> + *
> + * inserts new entry into index
> + */
> +int indx_insert_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
> +		      const struct NTFS_DE *new_de, const void *ctx,
> +		      struct ntfs_fnd *fnd)
> +{
> +	int err;
> +	int diff;
> +	struct NTFS_DE *e;
> +	struct ntfs_fnd *fnd_a = NULL;
> +	struct INDEX_ROOT *root;
> +
> +	if (!fnd) {
> +		fnd_a = fnd_get(indx);

Here we get uninitilized fnd.

> +		if (!fnd_a) {
> +			err = -ENOMEM;
> +			goto out1;
> +		}
> +		fnd = fnd_a;
> +	}
> +
> +	root = indx_get_root(indx, ni, NULL, NULL);
> +	if (!root) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (fnd_is_empty(fnd)) {

And example here we try to touch it.

> +		/* Find the spot the tree where we want to insert the new entry. */
> +		err = indx_find(indx, ni, root, new_de + 1,
> +				le16_to_cpu(new_de->key_size), ctx, &diff, &e,
> +				fnd);
> +		if (err)
> +			goto out;
> +
> +		if (!diff) {
> +			err = -EEXIST;
> +			goto out;
> +		}
> +	}
> +
> +	if (!fnd->level) {
> +		/* The root is also a leaf, so we'll insert the new entry into it. */
> +		err = indx_insert_into_root(indx, ni, new_de, fnd->root_de, ctx,
> +					    fnd);
> +		if (err)
> +			goto out;
> +	} else {
> +		/* found a leaf buffer, so we'll insert the new entry into it.*/
> +		err = indx_insert_into_buffer(indx, ni, root, new_de, ctx,
> +					      fnd->level - 1, fnd);
> +		if (err)
> +			goto out;
> +	}
> +
> +out:
> +	fnd_put(fnd_a);
> +out1:
> +	return err;
> +}
