Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9568A1BB0CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 23:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgD0VxL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 17:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726182AbgD0VxL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:53:11 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE280C03C1A7
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 14:53:10 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 18so8430616pfv.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ioKf5cq5JKYtIyX9nbP8HMfCUeuVRpu0VwZORigiJXo=;
        b=p8YJId6jvPEKTd0BmFdAZXWmOKjP/OdEmpKdICubqxqRjvDvWygAF+nHVpt8mIqexT
         YtNdfDyctPaE7pO/Ev1bZZcYCePVaFQ3y7s3kHIKHNIQ+bhTgK44S0OdrQQmBRQl8hIr
         Ltg4SjB+YgJwD/KMfamlIA7jwHv/wFJfTwkbU6eB9JgKHCXQ2jRKDSO4tL3oftYxpJUh
         1Hu65IoFdHd+OSXNEperw5MLk+YGqMuwvXu3P2bspFgTuNsgEWqjnLVfZbP5myQ9yN/R
         +ZQJN50xkYI9IuU50FEAwpR3pfO2tYIHDBCGzrII12ABlSC8Ya0IO2eSYwtyuON7bg+u
         dDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ioKf5cq5JKYtIyX9nbP8HMfCUeuVRpu0VwZORigiJXo=;
        b=TbrJZihbvG+DP5OCqRHgo7hPm9BXQAvNVk5n6shz6Mpu8wmk6mVl2CpNz330LzAvM+
         ZVkC0uI6NSQEf2/oEr3NDHrofmX7obLRXwNkGg7fNljKD66BKdSIL8Ky4bhSQoBXq4NY
         eUYrYlY5lenFY4ck8O8Y/fVSjxt/UXaKqK4QwICBWdro7LLg5Qo904QrpSQJNolaWMmH
         3O6HEGrt3d1Y99r5aOkojU7TKlkr6bgSk2OX696Zq1qOgfooOJ4q9yJZfabT5RLPIfww
         zt+73BmiSxVLS/+vv1jhrkfpBmR3rgHT2zEaGc+MGiqtSxJLe3jg2gypyTqVKbWIxSuB
         2dfQ==
X-Gm-Message-State: AGi0PuYpdqPGT4IEOCkmHkI7zeXfERz+qesAdjD5zziQ9VUOFNzcd/VS
        J6ZZIFFAI1bvOjV8zsKkFZRUig==
X-Google-Smtp-Source: APiQypKt+BD9UY1FQkSGaF6Pe9U0TiJ6SXYvMepsqbZ/UZdwikyRJ5HjwfTkUfVrkZbWmgkcvy/utg==
X-Received: by 2002:aa7:82d7:: with SMTP id f23mr28183300pfn.198.1588024390075;
        Mon, 27 Apr 2020 14:53:10 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id z1sm226594pjn.43.2020.04.27.14.53.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 14:53:09 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <97C10529-DFBF-47E3-9E51-A4C5A63535F3@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E9BEDFB2-86E5-45A8-84D5-EC10C19598A4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH 2/5] statsfs API: create, add and remove statsfs
 sources and values
Date:   Mon, 27 Apr 2020 15:53:07 -0600
In-Reply-To: <20200427141816.16703-3-eesposit@redhat.com>
Cc:     kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, mst@redhat.com,
        borntraeger@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>
References: <20200427141816.16703-1-eesposit@redhat.com>
 <20200427141816.16703-3-eesposit@redhat.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_E9BEDFB2-86E5-45A8-84D5-EC10C19598A4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 27, 2020, at 8:18 AM, Emanuele Giuseppe Esposito =
<eesposit@redhat.com> wrote:
>=20
> Introduction to the statsfs API, that allows to easily create, add
> and remove statsfs sources and values.

Not a huge issue, but IMHO the "statsfs" name is confusingly similar to
the existing "statfs" function name.  Could you name this interface
something more distinct?  Even "fs_stats" or "stats_fs" or similar would
at least be visibly different.

Cheers, Andreas

> The API allows to easily building
> the statistics directory tree to automatically gather them for the =
linux
> kernel. The main functionalities are: create a source, add child
> sources/values/aggregates, register it to the root source (that on
> the virtual fs would be /sys/kernel/statsfs), ad perform a search for
> a value/aggregate.
>=20
> This allows creating any kind of source tree, making it more flexible
> also to future readjustments.
>=20
> The API representation is only logical and will be backed up
> by a virtual file system in patch 4.
> Its usage will be shared between the statsfs file system
> and the end-users like kvm, the former calling it when it needs to
> display and clear statistics, the latter to add values and sources.
>=20
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> ---
> fs/Kconfig              |   7 +
> fs/Makefile             |   1 +
> fs/statsfs/Makefile     |   4 +
> fs/statsfs/internal.h   |  20 ++
> fs/statsfs/statsfs.c    | 618 ++++++++++++++++++++++++++++++++++++++++
> include/linux/statsfs.h | 222 +++++++++++++++
> 6 files changed, 872 insertions(+)
> create mode 100644 fs/statsfs/Makefile
> create mode 100644 fs/statsfs/internal.h
> create mode 100644 fs/statsfs/statsfs.c
> create mode 100644 include/linux/statsfs.h
>=20
> diff --git a/fs/Kconfig b/fs/Kconfig
> index f08fbbfafd9a..824fcf86d12b 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -328,4 +328,11 @@ source "fs/unicode/Kconfig"
> config IO_WQ
> 	bool
>=20
> +config STATS_FS
> +	bool "Statistics Filesystem"
> +	default y
> +	help
> +	  statsfs is a virtual file system that provides counters and =
other
> +	  statistics about the running kernel.
> +
> endmenu
> diff --git a/fs/Makefile b/fs/Makefile
> index 2ce5112b02c8..6942070f54b2 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -125,6 +125,7 @@ obj-$(CONFIG_BEFS_FS)		+=3D befs/
> obj-$(CONFIG_HOSTFS)		+=3D hostfs/
> obj-$(CONFIG_CACHEFILES)	+=3D cachefiles/
> obj-$(CONFIG_DEBUG_FS)		+=3D debugfs/
> +obj-$(CONFIG_STATS_FS)		+=3D statsfs/
> obj-$(CONFIG_TRACING)		+=3D tracefs/
> obj-$(CONFIG_OCFS2_FS)		+=3D ocfs2/
> obj-$(CONFIG_BTRFS_FS)		+=3D btrfs/
> diff --git a/fs/statsfs/Makefile b/fs/statsfs/Makefile
> new file mode 100644
> index 000000000000..d494a3f30ba5
> --- /dev/null
> +++ b/fs/statsfs/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +statsfs-objs	:=3D statsfs.o
> +
> +obj-$(CONFIG_STATS_FS)	+=3D statsfs.o
> diff --git a/fs/statsfs/internal.h b/fs/statsfs/internal.h
> new file mode 100644
> index 000000000000..f124683a2ded
> --- /dev/null
> +++ b/fs/statsfs/internal.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _STATSFS_INTERNAL_H_
> +#define _STATSFS_INTERNAL_H_
> +
> +#include <linux/list.h>
> +#include <linux/kref.h>
> +#include <linux/rwsem.h>
> +#include <linux/statsfs.h>
> +
> +/* values, grouped by base */
> +struct statsfs_value_source {
> +	void *base_addr;
> +	bool files_created;
> +	struct statsfs_value *values;
> +	struct list_head list_element;
> +};
> +
> +int statsfs_val_get_mode(struct statsfs_value *val);
> +
> +#endif /* _STATSFS_INTERNAL_H_ */
> diff --git a/fs/statsfs/statsfs.c b/fs/statsfs/statsfs.c
> new file mode 100644
> index 000000000000..0ad1d985be46
> --- /dev/null
> +++ b/fs/statsfs/statsfs.c
> @@ -0,0 +1,618 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/module.h>
> +#include <linux/errno.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/slab.h>
> +#include <linux/rwsem.h>
> +#include <linux/list.h>
> +#include <linux/kref.h>
> +#include <linux/limits.h>
> +#include <linux/statsfs.h>
> +
> +#include "internal.h"
> +
> +struct statsfs_aggregate_value {
> +	uint64_t sum, min, max;
> +	uint32_t count, count_zero;
> +};
> +
> +static int is_val_signed(struct statsfs_value *val)
> +{
> +	return val->type & STATSFS_SIGN;
> +}
> +
> +int statsfs_val_get_mode(struct statsfs_value *val)
> +{
> +	return val->mode ? val->mode : 0644;
> +}
> +
> +static struct statsfs_value *find_value(struct statsfs_value_source =
*src,
> +					struct statsfs_value *val)
> +{
> +	struct statsfs_value *entry;
> +
> +	for (entry =3D src->values; entry->name; entry++) {
> +		if (entry =3D=3D val) {
> +			WARN_ON(strcmp(entry->name, val->name) !=3D 0);
> +			return entry;
> +		}
> +	}
> +	return NULL;
> +}
> +
> +static struct statsfs_value *
> +search_value_in_source(struct statsfs_source *src, struct =
statsfs_value *arg,
> +		       struct statsfs_value_source **val_src)
> +{
> +	struct statsfs_value *entry;
> +	struct statsfs_value_source *src_entry;
> +
> +	list_for_each_entry(src_entry, &src->values_head, list_element) =
{
> +		entry =3D find_value(src_entry, arg);
> +		if (entry) {
> +			*val_src =3D src_entry;
> +			return entry;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +/* Called with rwsem held for writing */
> +static struct statsfs_value_source *create_value_source(void *base)
> +{
> +	struct statsfs_value_source *val_src;
> +
> +	val_src =3D kzalloc(sizeof(struct statsfs_value_source), =
GFP_KERNEL);
> +	if (!val_src)
> +		return ERR_PTR(-ENOMEM);
> +
> +	val_src->base_addr =3D base;
> +	val_src->list_element =3D
> +		(struct list_head)LIST_HEAD_INIT(val_src->list_element);
> +
> +	return val_src;
> +}
> +
> +int statsfs_source_add_values(struct statsfs_source *source,
> +			      struct statsfs_value *stat, void *ptr)
> +{
> +	struct statsfs_value_source *val_src;
> +	struct statsfs_value_source *entry;
> +
> +	down_write(&source->rwsem);
> +
> +	list_for_each_entry(entry, &source->values_head, list_element) {
> +		if (entry->base_addr =3D=3D ptr && entry->values =3D=3D =
stat) {
> +			up_write(&source->rwsem);
> +			return -EEXIST;
> +		}
> +	}
> +
> +	val_src =3D create_value_source(ptr);
> +	val_src->values =3D (struct statsfs_value *)stat;
> +
> +	/* add the val_src to the source list */
> +	list_add(&val_src->list_element, &source->values_head);
> +
> +	up_write(&source->rwsem);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(statsfs_source_add_values);
> +
> +void statsfs_source_add_subordinate(struct statsfs_source *source,
> +				    struct statsfs_source *sub)
> +{
> +	down_write(&source->rwsem);
> +
> +	statsfs_source_get(sub);
> +	list_add(&sub->list_element, &source->subordinates_head);
> +
> +	up_write(&source->rwsem);
> +}
> +EXPORT_SYMBOL_GPL(statsfs_source_add_subordinate);
> +
> +/* Called with rwsem held for writing */
> +static void
> +statsfs_source_remove_subordinate_locked(struct statsfs_source =
*source,
> +					 struct statsfs_source *sub)
> +{
> +	struct list_head *it, *safe;
> +	struct statsfs_source *src_entry;
> +
> +	list_for_each_safe(it, safe, &source->subordinates_head) {
> +		src_entry =3D list_entry(it, struct statsfs_source, =
list_element);
> +		if (src_entry =3D=3D sub) {
> +			WARN_ON(strcmp(src_entry->name, sub->name) !=3D =
0);
> +			list_del_init(&src_entry->list_element);
> +			statsfs_source_put(src_entry);
> +			return;
> +		}
> +	}
> +}
> +
> +void statsfs_source_remove_subordinate(struct statsfs_source *source,
> +				       struct statsfs_source *sub)
> +{
> +	down_write(&source->rwsem);
> +	statsfs_source_remove_subordinate_locked(source, sub);
> +	up_write(&source->rwsem);
> +}
> +EXPORT_SYMBOL_GPL(statsfs_source_remove_subordinate);
> +
> +/* Called with rwsem held for reading */
> +static uint64_t get_simple_value(struct statsfs_value_source *src,
> +				 struct statsfs_value *val)
> +{
> +	uint64_t value_found;
> +	void *address;
> +
> +	address =3D src->base_addr + val->offset;
> +
> +	switch (val->type) {
> +	case STATSFS_U8:
> +		value_found =3D *((uint8_t *)address);
> +		break;
> +	case STATSFS_U8 | STATSFS_SIGN:
> +		value_found =3D *((int8_t *)address);
> +		break;
> +	case STATSFS_U16:
> +		value_found =3D *((uint16_t *)address);
> +		break;
> +	case STATSFS_U16 | STATSFS_SIGN:
> +		value_found =3D *((int16_t *)address);
> +		break;
> +	case STATSFS_U32:
> +		value_found =3D *((uint32_t *)address);
> +		break;
> +	case STATSFS_U32 | STATSFS_SIGN:
> +		value_found =3D *((int32_t *)address);
> +		break;
> +	case STATSFS_U64:
> +		value_found =3D *((uint64_t *)address);
> +		break;
> +	case STATSFS_U64 | STATSFS_SIGN:
> +		value_found =3D *((int64_t *)address);
> +		break;
> +	case STATSFS_BOOL:
> +		value_found =3D *((uint8_t *)address);
> +		break;
> +	default:
> +		value_found =3D 0;
> +		break;
> +	}
> +
> +	return value_found;
> +}
> +
> +/* Called with rwsem held for reading */
> +static void clear_simple_value(struct statsfs_value_source *src,
> +			       struct statsfs_value *val)
> +{
> +	void *address;
> +
> +	address =3D src->base_addr + val->offset;
> +
> +	switch (val->type) {
> +	case STATSFS_U8:
> +		*((uint8_t *)address) =3D 0;
> +		break;
> +	case STATSFS_U8 | STATSFS_SIGN:
> +		*((int8_t *)address) =3D 0;
> +		break;
> +	case STATSFS_U16:
> +		*((uint16_t *)address) =3D 0;
> +		break;
> +	case STATSFS_U16 | STATSFS_SIGN:
> +		*((int16_t *)address) =3D 0;
> +		break;
> +	case STATSFS_U32:
> +		*((uint32_t *)address) =3D 0;
> +		break;
> +	case STATSFS_U32 | STATSFS_SIGN:
> +		*((int32_t *)address) =3D 0;
> +		break;
> +	case STATSFS_U64:
> +		*((uint64_t *)address) =3D 0;
> +		break;
> +	case STATSFS_U64 | STATSFS_SIGN:
> +		*((int64_t *)address) =3D 0;
> +		break;
> +	case STATSFS_BOOL:
> +		*((uint8_t *)address) =3D 0;
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +/* Called with rwsem held for reading */
> +static void search_all_simple_values(struct statsfs_source *src,
> +				     struct statsfs_value_source =
*ref_src_entry,
> +				     struct statsfs_value *val,
> +				     struct statsfs_aggregate_value =
*agg)
> +{
> +	struct statsfs_value_source *src_entry;
> +	uint64_t value_found;
> +
> +	list_for_each_entry(src_entry, &src->values_head, list_element) =
{
> +		/* skip aggregates */
> +		if (src_entry->base_addr =3D=3D NULL)
> +			continue;
> +
> +		/* useless to search here */
> +		if (src_entry->values !=3D ref_src_entry->values)
> +			continue;
> +
> +		/* must be here */
> +		value_found =3D get_simple_value(src_entry, val);
> +		agg->sum +=3D value_found;
> +		agg->count++;
> +		agg->count_zero +=3D (value_found =3D=3D 0);
> +
> +		if (is_val_signed(val)) {
> +			agg->max =3D (((int64_t)value_found) >=3D
> +				    ((int64_t)agg->max)) ?
> +					   value_found :
> +					   agg->max;
> +			agg->min =3D (((int64_t)value_found) <=3D
> +				    ((int64_t)agg->min)) ?
> +					   value_found :
> +					   agg->min;
> +		} else {
> +			agg->max =3D (value_found >=3D agg->max) ? =
value_found :
> +							       agg->max;
> +			agg->min =3D (value_found <=3D agg->min) ? =
value_found :
> +							       agg->min;
> +		}
> +	}
> +}
> +
> +/* Called with rwsem held for reading */
> +static void do_recursive_aggregation(struct statsfs_source *root,
> +				     struct statsfs_value_source =
*ref_src_entry,
> +				     struct statsfs_value *val,
> +				     struct statsfs_aggregate_value =
*agg)
> +{
> +	struct statsfs_source *subordinate;
> +
> +	/* search all simple values in this folder */
> +	search_all_simple_values(root, ref_src_entry, val, agg);
> +
> +	/* recursively search in all subfolders */
> +	list_for_each_entry(subordinate, &root->subordinates_head,
> +			     list_element) {
> +		down_read(&subordinate->rwsem);
> +		do_recursive_aggregation(subordinate, ref_src_entry, =
val, agg);
> +		up_read(&subordinate->rwsem);
> +	}
> +}
> +
> +/* Called with rwsem held for reading */
> +static void init_aggregate_value(struct statsfs_aggregate_value *agg,
> +				 struct statsfs_value *val)
> +{
> +	agg->count =3D agg->count_zero =3D agg->sum =3D 0;
> +	if (is_val_signed(val)) {
> +		agg->max =3D S64_MIN;
> +		agg->min =3D S64_MAX;
> +	} else {
> +		agg->max =3D 0;
> +		agg->min =3D U64_MAX;
> +	}
> +}
> +
> +/* Called with rwsem held for reading */
> +static void store_final_value(struct statsfs_aggregate_value *agg,
> +			    struct statsfs_value *val, uint64_t *ret)
> +{
> +	int operation;
> +
> +	operation =3D val->aggr_kind | is_val_signed(val);
> +
> +	switch (operation) {
> +	case STATSFS_AVG:
> +		*ret =3D agg->count ? agg->sum / agg->count : 0;
> +		break;
> +	case STATSFS_AVG | STATSFS_SIGN:
> +		*ret =3D agg->count ? ((int64_t)agg->sum) / agg->count : =
0;
> +		break;
> +	case STATSFS_SUM:
> +	case STATSFS_SUM | STATSFS_SIGN:
> +		*ret =3D agg->sum;
> +		break;
> +	case STATSFS_MIN:
> +	case STATSFS_MIN | STATSFS_SIGN:
> +		*ret =3D agg->min;
> +		break;
> +	case STATSFS_MAX:
> +	case STATSFS_MAX | STATSFS_SIGN:
> +		*ret =3D agg->max;
> +		break;
> +	case STATSFS_COUNT_ZERO:
> +	case STATSFS_COUNT_ZERO | STATSFS_SIGN:
> +		*ret =3D agg->count_zero;
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +/* Called with rwsem held for reading */
> +static int statsfs_source_get_value_locked(struct statsfs_source =
*source,
> +					   struct statsfs_value *arg,
> +					   uint64_t *ret)
> +{
> +	struct statsfs_value_source *src_entry;
> +	struct statsfs_value *found;
> +	struct statsfs_aggregate_value aggr;
> +
> +	*ret =3D 0;
> +
> +	if (!arg)
> +		return -ENOENT;
> +
> +	/* look in simple values */
> +	found =3D search_value_in_source(source, arg, &src_entry);
> +
> +	if (!found) {
> +		printk(KERN_ERR "Statsfs: Value in source \"%s\" not =
found!\n",
> +		       source->name);
> +		return -ENOENT;
> +	}
> +
> +	if (src_entry->base_addr !=3D NULL) {
> +		*ret =3D get_simple_value(src_entry, found);
> +		return 0;
> +	}
> +
> +	/* look in aggregates */
> +	init_aggregate_value(&aggr, found);
> +	do_recursive_aggregation(source, src_entry, found, &aggr);
> +	store_final_value(&aggr, found, ret);
> +
> +	return 0;
> +}
> +
> +int statsfs_source_get_value(struct statsfs_source *source,
> +			     struct statsfs_value *arg, uint64_t *ret)
> +{
> +	int retval;
> +
> +	down_read(&source->rwsem);
> +	retval =3D statsfs_source_get_value_locked(source, arg, ret);
> +	up_read(&source->rwsem);
> +
> +	return retval;
> +}
> +EXPORT_SYMBOL_GPL(statsfs_source_get_value);
> +
> +/* Called with rwsem held for reading */
> +static void set_all_simple_values(struct statsfs_source *src,
> +				  struct statsfs_value_source =
*ref_src_entry,
> +				  struct statsfs_value *val)
> +{
> +	struct statsfs_value_source *src_entry;
> +
> +	list_for_each_entry(src_entry, &src->values_head, list_element) =
{
> +		/* skip aggregates */
> +		if (src_entry->base_addr =3D=3D NULL)
> +			continue;
> +
> +		/* wrong to search here */
> +		if (src_entry->values !=3D ref_src_entry->values)
> +			continue;
> +
> +		if (src_entry->base_addr &&
> +			src_entry->values =3D=3D ref_src_entry->values)
> +			clear_simple_value(src_entry, val);
> +	}
> +}
> +
> +/* Called with rwsem held for reading */
> +static void do_recursive_clean(struct statsfs_source *root,
> +			       struct statsfs_value_source =
*ref_src_entry,
> +			       struct statsfs_value *val)
> +{
> +	struct statsfs_source *subordinate;
> +
> +	/* search all simple values in this folder */
> +	set_all_simple_values(root, ref_src_entry, val);
> +
> +	/* recursively search in all subfolders */
> +	list_for_each_entry(subordinate, &root->subordinates_head,
> +			     list_element) {
> +		down_read(&subordinate->rwsem);
> +		do_recursive_clean(subordinate, ref_src_entry, val);
> +		up_read(&subordinate->rwsem);
> +	}
> +}
> +
> +/* Called with rwsem held for reading */
> +static int statsfs_source_clear_locked(struct statsfs_source *source,
> +				       struct statsfs_value *val)
> +{
> +	struct statsfs_value_source *src_entry;
> +	struct statsfs_value *found;
> +
> +	if (!val)
> +		return -ENOENT;
> +
> +	/* look in simple values */
> +	found =3D search_value_in_source(source, val, &src_entry);
> +
> +	if (!found) {
> +		printk(KERN_ERR "Statsfs: Value in source \"%s\" not =
found!\n",
> +		       source->name);
> +		return -ENOENT;
> +	}
> +
> +	if (src_entry->base_addr !=3D NULL) {
> +		clear_simple_value(src_entry, found);
> +		return 0;
> +	}
> +
> +	/* look in aggregates */
> +	do_recursive_clean(source, src_entry, found);
> +
> +	return 0;
> +}
> +
> +int statsfs_source_clear(struct statsfs_source *source,
> +			 struct statsfs_value *val)
> +{
> +	int retval;
> +
> +	down_read(&source->rwsem);
> +	retval =3D statsfs_source_clear_locked(source, val);
> +	up_read(&source->rwsem);
> +
> +	return retval;
> +}
> +
> +/* Called with rwsem held for reading */
> +static struct statsfs_value *
> +find_value_by_name(struct statsfs_value_source *src, char *val)
> +{
> +	struct statsfs_value *entry;
> +
> +	for (entry =3D src->values; entry->name; entry++)
> +		if (!strcmp(entry->name, val))
> +			return entry;
> +
> +	return NULL;
> +}
> +
> +/* Called with rwsem held for reading */
> +static struct statsfs_value *
> +search_in_source_by_name(struct statsfs_source *src, char *name)
> +{
> +	struct statsfs_value *entry;
> +	struct statsfs_value_source *src_entry;
> +
> +	list_for_each_entry(src_entry, &src->values_head, list_element) =
{
> +		entry =3D find_value_by_name(src_entry, name);
> +		if (entry)
> +			return entry;
> +	}
> +
> +	return NULL;
> +}
> +
> +int statsfs_source_get_value_by_name(struct statsfs_source *source, =
char *name,
> +				     uint64_t *ret)
> +{
> +	struct statsfs_value *val;
> +	int retval;
> +
> +	down_read(&source->rwsem);
> +	val =3D search_in_source_by_name(source, name);
> +
> +	if (!val) {
> +		*ret =3D 0;
> +		up_read(&source->rwsem);
> +		return -ENOENT;
> +	}
> +
> +	retval =3D statsfs_source_get_value_locked(source, val, ret);
> +	up_read(&source->rwsem);
> +
> +	return retval;
> +}
> +EXPORT_SYMBOL_GPL(statsfs_source_get_value_by_name);
> +
> +void statsfs_source_get(struct statsfs_source *source)
> +{
> +	kref_get(&source->refcount);
> +}
> +EXPORT_SYMBOL_GPL(statsfs_source_get);
> +
> +void statsfs_source_revoke(struct statsfs_source *source)
> +{
> +	struct list_head *it, *safe;
> +	struct statsfs_value_source *val_src_entry;
> +
> +	down_write(&source->rwsem);
> +
> +	list_for_each_safe(it, safe, &source->values_head) {
> +		val_src_entry =3D list_entry(it, struct =
statsfs_value_source,
> +					   list_element);
> +		val_src_entry->base_addr =3D NULL;
> +	}
> +
> +	up_write(&source->rwsem);
> +}
> +EXPORT_SYMBOL_GPL(statsfs_source_revoke);
> +
> +/* Called with rwsem held for writing
> + *
> + * The refcount is 0 and the lock was taken before refcount
> + * went from 1 to 0
> + */
> +static void statsfs_source_destroy(struct kref *kref_source)
> +{
> +	struct statsfs_value_source *val_src_entry;
> +	struct list_head *it, *safe;
> +	struct statsfs_source *child, *source;
> +
> +	source =3D container_of(kref_source, struct statsfs_source, =
refcount);
> +
> +	/* iterate through the values and delete them */
> +	list_for_each_safe(it, safe, &source->values_head) {
> +		val_src_entry =3D list_entry(it, struct =
statsfs_value_source,
> +					   list_element);
> +		kfree(val_src_entry);
> +	}
> +
> +	/* iterate through the subordinates and delete them */
> +	list_for_each_safe(it, safe, &source->subordinates_head) {
> +		child =3D list_entry(it, struct statsfs_source, =
list_element);
> +		statsfs_source_remove_subordinate_locked(source, child);
> +	}
> +
> +
> +	up_write(&source->rwsem);
> +	kfree(source->name);
> +	kfree(source);
> +}
> +
> +void statsfs_source_put(struct statsfs_source *source)
> +{
> +	kref_put_rwsem(&source->refcount, statsfs_source_destroy,
> +		       &source->rwsem);
> +}
> +EXPORT_SYMBOL_GPL(statsfs_source_put);
> +
> +struct statsfs_source *statsfs_source_create(const char *fmt, ...)
> +{
> +	va_list ap;
> +	char buf[100];
> +	struct statsfs_source *ret;
> +	int char_needed;
> +
> +	va_start(ap, fmt);
> +	char_needed =3D vsnprintf(buf, 100, fmt, ap);
> +	va_end(ap);
> +
> +	ret =3D kzalloc(sizeof(struct statsfs_source), GFP_KERNEL);
> +	if (!ret)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret->name =3D kstrdup(buf, GFP_KERNEL);
> +	if (!ret->name) {
> +		kfree(ret);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	kref_init(&ret->refcount);
> +	init_rwsem(&ret->rwsem);
> +
> +	INIT_LIST_HEAD(&ret->values_head);
> +	INIT_LIST_HEAD(&ret->subordinates_head);
> +	INIT_LIST_HEAD(&ret->list_element);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(statsfs_source_create);
> diff --git a/include/linux/statsfs.h b/include/linux/statsfs.h
> new file mode 100644
> index 000000000000..3f01f094946d
> --- /dev/null
> +++ b/include/linux/statsfs.h
> @@ -0,0 +1,222 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + *  statsfs.h - a tiny little statistics file system
> + *
> + *  Copyright (C) 2020 Emanuele Giuseppe Esposito
> + *  Copyright (C) 2020 Redhat.
> + *
> + */
> +
> +#ifndef _STATSFS_H_
> +#define _STATSFS_H_
> +
> +#include <linux/list.h>
> +
> +/* Used to distinguish signed types */
> +#define STATSFS_SIGN 0x8000
> +
> +struct statsfs_source;
> +
> +enum stat_type {
> +	STATSFS_U8 =3D 0,
> +	STATSFS_U16 =3D 1,
> +	STATSFS_U32 =3D 2,
> +	STATSFS_U64 =3D 3,
> +	STATSFS_BOOL =3D 4,
> +	STATSFS_S8 =3D STATSFS_U8 | STATSFS_SIGN,
> +	STATSFS_S16 =3D STATSFS_U16 | STATSFS_SIGN,
> +	STATSFS_S32 =3D STATSFS_U32 | STATSFS_SIGN,
> +	STATSFS_S64 =3D STATSFS_U64 | STATSFS_SIGN,
> +};
> +
> +enum stat_aggr {
> +	STATSFS_NONE =3D 0,
> +	STATSFS_SUM,
> +	STATSFS_MIN,
> +	STATSFS_MAX,
> +	STATSFS_COUNT_ZERO,
> +	STATSFS_AVG,
> +};
> +
> +struct statsfs_value {
> +	/* Name of the stat */
> +	char *name;
> +
> +	/* Offset from base address to field containing the value */
> +	int offset;
> +
> +	/* Type of the stat BOOL,U64,... */
> +	enum stat_type type;
> +
> +	/* Aggregate type: MIN, MAX, SUM,... */
> +	enum stat_aggr aggr_kind;
> +
> +	/* File mode */
> +	uint16_t mode;
> +};
> +
> +struct statsfs_source {
> +	struct kref refcount;
> +
> +	char *name;
> +
> +	/* list of source statsfs_value_source*/
> +	struct list_head values_head;
> +
> +	/* list of struct statsfs_source for subordinate sources */
> +	struct list_head subordinates_head;
> +
> +	struct list_head list_element;
> +
> +	struct rw_semaphore rwsem;
> +
> +	struct dentry *source_dentry;
> +};
> +
> +/**
> + * statsfs_source_create - create a statsfs_source
> + * Creates a statsfs_source with the given name. This
> + * does not mean it will be backed by the filesystem yet, it will =
only
> + * be visible to the user once one of its parents (or itself) are
> + * registered in statsfs.
> + *
> + * Returns a pointer to a statsfs_source if it succeeds.
> + * This or one of the parents' pointer must be passed to the =
statsfs_put()
> + * function when the file is to be removed.  If an error occurs,
> + * ERR_PTR(-ERROR) will be returned.
> + */
> +struct statsfs_source *statsfs_source_create(const char *fmt, ...);
> +
> +/**
> + * statsfs_source_add_values - adds values to the given source
> + * @source: a pointer to the source that will receive the values
> + * @val: a pointer to the NULL terminated statsfs_value array to add
> + * @base_ptr: a pointer to the base pointer used by these values
> + *
> + * In addition to adding values to the source, also create the
> + * files in the filesystem if the source already is backed up by a =
directory.
> + *
> + * Returns 0 it succeeds. If the value are already in the
> + * source and have the same base_ptr, -EEXIST is returned.
> + */
> +int statsfs_source_add_values(struct statsfs_source *source,
> +			      struct statsfs_value *val, void =
*base_ptr);
> +
> +/**
> + * statsfs_source_add_subordinate - adds a child to the given source
> + * @parent: a pointer to the parent source
> + * @child: a pointer to child source to add
> + *
> + * Recursively create all files in the statsfs filesystem
> + * only if the parent has already a dentry (created with
> + * statsfs_source_register).
> + * This avoids the case where this function is called before =
register.
> + */
> +void statsfs_source_add_subordinate(struct statsfs_source *parent,
> +				    struct statsfs_source *child);
> +
> +/**
> + * statsfs_source_remove_subordinate - removes a child from the given =
source
> + * @parent: a pointer to the parent source
> + * @child: a pointer to child source to remove
> + *
> + * Look if there is such child in the parent. If so,
> + * it will remove all its files and call statsfs_put on the child.
> + */
> +void statsfs_source_remove_subordinate(struct statsfs_source *parent,
> +				       struct statsfs_source *child);
> +
> +/**
> + * statsfs_source_get_value - search a value in the source (and
> + * subordinates)
> + * @source: a pointer to the source that will be searched
> + * @val: a pointer to the statsfs_value to search
> + * @ret: a pointer to the uint64_t that will hold the found value
> + *
> + * Look up in the source if a value with same value pointer
> + * exists.
> + * If not, it will return -ENOENT. If it exists and it's a simple =
value
> + * (not an aggregate), the value that it points to will be returned.
> + * If it exists and it's an aggregate (aggr_type !=3D STATSFS_NONE), =
all
> + * subordinates will be recursively searched and every simple value =
match
> + * will be used to aggregate the final result. For example if it's a =
sum,
> + * all suboordinates having the same value will be sum together.
> + *
> + * This function will return 0 it succeeds.
> + */
> +int statsfs_source_get_value(struct statsfs_source *source,
> +			     struct statsfs_value *val, uint64_t *ret);
> +
> +/**
> + * statsfs_source_get_value_by_name - search a value in the source =
(and
> + * subordinates)
> + * @source: a pointer to the source that will be searched
> + * @name: a pointer to the string representing the value to search
> + *        (for example "exits")
> + * @ret: a pointer to the uint64_t that will hold the found value
> + *
> + * Same as statsfs_source_get_value, but initially the name is used
> + * to search in the given source if there is a value with a matching
> + * name. If so, statsfs_source_get_value will be called with the =
found
> + * value, otherwise -ENOENT will be returned.
> + */
> +int statsfs_source_get_value_by_name(struct statsfs_source *source, =
char *name,
> +				     uint64_t *ret);
> +
> +/**
> + * statsfs_source_clear - search and clears a value in the source =
(and
> + * subordinates)
> + * @source: a pointer to the source that will be searched
> + * @val: a pointer to the statsfs_value to search
> + *
> + * Look up in the source if a value with same value pointer
> + * exists.
> + * If not, it will return -ENOENT. If it exists and it's a simple =
value
> + * (not an aggregate), the value that it points to will be set to 0.
> + * If it exists and it's an aggregate (aggr_type !=3D STATSFS_NONE), =
all
> + * subordinates will be recursively searched and every simple value =
match
> + * will be set to 0.
> + *
> + * This function will return 0 it succeeds.
> + */
> +int statsfs_source_clear(struct statsfs_source *source,
> +			 struct statsfs_value *val);
> +
> +/**
> + * statsfs_source_revoke - disconnect the source from its backing =
data
> + * @source: a pointer to the source that will be revoked
> + *
> + * Ensure that statsfs will not access the data that were passed to
> + * statsfs_source_add_value for this source.
> + *
> + * Because open files increase the reference count for a =
statsfs_source,
> + * the source can end up living longer than the data that provides =
the
> + * values for the source.  Calling statsfs_source_revoke just before =
the
> + * backing data is freed avoids accesses to freed data structures.  =
The
> + * sources will return 0.
> + */
> +void statsfs_source_revoke(struct statsfs_source *source);
> +
> +/**
> + * statsfs_source_get - increases refcount of source
> + * @source: a pointer to the source whose refcount will be increased
> + */
> +void statsfs_source_get(struct statsfs_source *source);
> +
> +/**
> + * statsfs_source_put - decreases refcount of source and deletes if =
needed
> + * @source: a pointer to the source whose refcount will be decreased
> + *
> + * If refcount arrives to zero, take care of deleting
> + * and free the source resources and files, by firstly recursively =
calling
> + * statsfs_source_remove_subordinate to the child and then deleting
> + * its own files and allocations.
> + */
> +void statsfs_source_put(struct statsfs_source *source);
> +
> +/**
> + * statsfs_initialized - returns true if statsfs fs has been =
registered
> + */
> +bool statsfs_initialized(void);
> +
> +#endif
> --
> 2.25.2
>=20


Cheers, Andreas






--Apple-Mail=_E9BEDFB2-86E5-45A8-84D5-EC10C19598A4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl6nVEMACgkQcqXauRfM
H+DKHw/+MBY480kSNL9522wMEQHxchUi1DnoWLuROrM4DS4e6BCmQj+G/54UresX
ShIO4nD0NnwztkM/NXINrKN1pUVy/sVM4o+HywZV4zBNgsEvRj2BAAua7nCR9hMj
K9DEKF7dsQ9JknaLcn5t/PVw770XXV24icX0AdSw7iyvqw0WXC0LrbG/agici8a8
llNAfD1ECTbCZk9TI2XQPly32tQ6e3DZud4cjlcSN3WCT85bEjd/AOlMNIH2o/KL
emxa59mBgeMf6SbPDfdsbF1pBu2yFt3Jk23XIeN1aZndef4aHPC40fPXg/JWDgOm
HKfMc0wqPt8fBA0eWkbTz8Cv8FHsBVhEsgPGPMCMHnyu8RKa2lHPlNqH1iSQvZas
RtqAmg7NIFVlj+aHT6ys6DO28Y/GXURbZM8BpTMXpnc6tgfnKTa7YiL7ugmbyOO1
httapdE/2WWh0hBJbamhdKeubA2FJe2KPgZQATJ6S6VQ2y+50U9yLp5gIKmS1540
FNxQOdc+LV1jNQ9c0bevZrwrB0M19XzgbG3XM6ogAwjWJS7tcLS3Yk4ZG/fEfo82
PtcnDtRY2y/faAKO3bBJTcA6/uXcxsqSgdIfOnJhlomWg4MuZaruM1M1gEKPhCzO
A4o/TztqftL8FmEaAwtsDbNdJGskAWgsTNSCXDE+aaPFfocvIwI=
=/ydq
-----END PGP SIGNATURE-----

--Apple-Mail=_E9BEDFB2-86E5-45A8-84D5-EC10C19598A4--
