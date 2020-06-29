Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EA320DA3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 22:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388092AbgF2TzG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 15:55:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49184 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388309AbgF2Tyw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:54:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05TGwAQ2100940;
        Mon, 29 Jun 2020 17:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=hr82HcmS6QSt4l+DRJuh4r7PSJbUrC3M6QqLBWL4FBQ=;
 b=hwVm8fQAjIZOIRqKfwxOPSPER093M2hsX29ON2ovYE/oodmtfkXEA8xKdi0N0l0NTQTQ
 3UebOFTkU3YrzEgg897xEvwtZ9lp8J53u7nM6JiXzFTLir+UoZV2Mfz/mQoiZBXyL6kx
 2WKxDkKK4wmpOk9sFd1NgO8lmm1/wnSxXi2goD7uvQ7juw4QI902rHtIEtJFHePFdghT
 PolHNbqhCze1fwyuYuzbxWbmWIoJR2lR7nQ89GlibiI75+QdJ3Qfb9Zg5iCB5rDo/zRu
 NH3nENrg6aP10RkiNKYhZ/Zp7V8kb4JYYe+XCQkBDumvXoAxb5G3HqE57jXKmOhkHLyL BQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31xx1dmkda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Jun 2020 17:18:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05TGweFm145902;
        Mon, 29 Jun 2020 17:18:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31xg10vvk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jun 2020 17:18:24 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05THIMGi003971;
        Mon, 29 Jun 2020 17:18:22 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jun 2020 17:18:22 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3645.0.6.2.3\))
Subject: Re: [PATCH 1/2] XArray: Add xas_split
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20200629152033.16175-2-willy@infradead.org>
Date:   Mon, 29 Jun 2020 11:18:21 -0600
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7FEA7471-D066-4B59-BDC7-3E70798E20CE@oracle.com>
References: <20200629152033.16175-1-willy@infradead.org>
 <20200629152033.16175-2-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Mailer: Apple Mail (2.3645.0.6.2.3)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=2 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006290109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011 adultscore=0
 suspectscore=2 mlxlogscore=999 cotscore=-2147483648 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006290109
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Very nice, nit inline.

For the series: Reviewed-by: William Kucharski =
<william.kucharski@oracle.com>

> On Jun 29, 2020, at 9:20 AM, Matthew Wilcox (Oracle) =
<willy@infradead.org> wrote:
>=20
> In order to use multi-index entries for huge pages in the page cache,
> we need to be able to split a multi-index entry (eg if a file is
> truncated in the middle of a huge page entry).  This version does not
> support splitting more than one level of the tree at a time.  This is =
an
> acceptable limitation for the page cache as we do not expect to =
support
> order-12 pages in the near future.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> Documentation/core-api/xarray.rst |  16 ++--
> include/linux/xarray.h            |   2 +
> lib/test_xarray.c                 |  41 ++++++++
> lib/xarray.c                      | 153 ++++++++++++++++++++++++++++--
> 4 files changed, 196 insertions(+), 16 deletions(-)
>=20
> diff --git a/Documentation/core-api/xarray.rst =
b/Documentation/core-api/xarray.rst
> index 640934b6f7b4..a137a0e6d068 100644
> --- a/Documentation/core-api/xarray.rst
> +++ b/Documentation/core-api/xarray.rst
> @@ -475,13 +475,15 @@ or iterations will move the index to the first =
index in the range.
> Each entry will only be returned once, no matter how many indices it
> occupies.
>=20
> -Using xas_next() or xas_prev() with a multi-index xa_state
> -is not supported.  Using either of these functions on a multi-index =
entry
> -will reveal sibling entries; these should be skipped over by the =
caller.
> -
> -Storing ``NULL`` into any index of a multi-index entry will set the =
entry
> -at every index to ``NULL`` and dissolve the tie.  Splitting a =
multi-index
> -entry into entries occupying smaller ranges is not yet supported.
> +Using xas_next() or xas_prev() with a multi-index xa_state is not
> +supported.  Using either of these functions on a multi-index entry =
will
> +reveal sibling entries; these should be skipped over by the caller.
> +
> +Storing ``NULL`` into any index of a multi-index entry will set the
> +entry at every index to ``NULL`` and dissolve the tie.  A multi-index
> +entry can be split into entries occupying smaller ranges by calling
> +xas_split_alloc() without the xa_lock held, followed by taking the =
lock
> +and calling xas_split().
>=20
> Functions and structures
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> index b4d70e7568b2..fd4364e17632 100644
> --- a/include/linux/xarray.h
> +++ b/include/linux/xarray.h
> @@ -1491,6 +1491,8 @@ static inline bool xas_retry(struct xa_state =
*xas, const void *entry)
>=20
> void *xas_load(struct xa_state *);
> void *xas_store(struct xa_state *, void *entry);
> +void xas_split(struct xa_state *, void *entry, unsigned int order);
> +void xas_split_alloc(struct xa_state *, void *entry, unsigned int =
order, gfp_t);
> void *xas_find(struct xa_state *, unsigned long max);
> void *xas_find_conflict(struct xa_state *);
>=20
> diff --git a/lib/test_xarray.c b/lib/test_xarray.c
> index acf5ccba58b0..282cce959aba 100644
> --- a/lib/test_xarray.c
> +++ b/lib/test_xarray.c
> @@ -1525,6 +1525,46 @@ static noinline void check_store_range(struct =
xarray *xa)
> 	}
> }
>=20
> +#ifdef CONFIG_XARRAY_MULTI
> +static void check_split_1(struct xarray *xa, unsigned long index,
> +							unsigned int =
order)
> +{
> +	XA_STATE_ORDER(xas, xa, index, order);
> +	void *entry;
> +	unsigned int i =3D 0;
> +
> +	xa_store_order(xa, index, order, xa, GFP_KERNEL);
> +
> +	xas_split_alloc(&xas, xa, 0, GFP_KERNEL);
> +	xas_lock(&xas);
> +	xas_split(&xas, xa, 0);
> +	xas_unlock(&xas);
> +
> +	xa_for_each(xa, index, entry) {
> +		XA_BUG_ON(xa, entry !=3D xa);
> +		i++;
> +	}
> +	XA_BUG_ON(xa, i !=3D 1 << order);
> +
> +	xa_destroy(xa);
> +}
> +
> +static noinline void check_split(struct xarray *xa)
> +{
> +	unsigned int order;
> +
> +	XA_BUG_ON(xa, !xa_empty(xa));
> +
> +	for (order =3D 1; order < 2 * XA_CHUNK_SHIFT; order++) {

It would be nice to have a comment here as to why you are checking
these particular size thresholds.

> +		check_split_1(xa, 0, order);
> +		check_split_1(xa, 1UL << order, order);
> +		check_split_1(xa, 3UL << order, order);
> +	}
> +}
> +#else
> +static void check_split(struct xarray *xa) { }
> +#endif
> +
> static void check_align_1(struct xarray *xa, char *name)
> {
> 	int i;
> @@ -1730,6 +1770,7 @@ static int xarray_checks(void)
> 	check_store_range(&array);
> 	check_store_iter(&array);
> 	check_align(&xa0);
> +	check_split(&array);
>=20
> 	check_workingset(&array, 0);
> 	check_workingset(&array, 64);
> diff --git a/lib/xarray.c b/lib/xarray.c
> index e9e641d3c0c3..faca1ac95b0e 100644
> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -266,13 +266,15 @@ static void xa_node_free(struct xa_node *node)
>  */
> static void xas_destroy(struct xa_state *xas)
> {
> -	struct xa_node *node =3D xas->xa_alloc;
> +	struct xa_node *next, *node =3D xas->xa_alloc;
>=20
> -	if (!node)
> -		return;
> -	XA_NODE_BUG_ON(node, !list_empty(&node->private_list));
> -	kmem_cache_free(radix_tree_node_cachep, node);
> -	xas->xa_alloc =3D NULL;
> +	while (node) {
> +		XA_NODE_BUG_ON(node, !list_empty(&node->private_list));
> +		next =3D rcu_dereference_raw(node->parent);
> +		/* XXX: need to free children */
> +		kmem_cache_free(radix_tree_node_cachep, node);
> +		xas->xa_alloc =3D node =3D next;
> +	}
> }
>=20
> /**
> @@ -304,6 +306,7 @@ bool xas_nomem(struct xa_state *xas, gfp_t gfp)
> 	xas->xa_alloc =3D kmem_cache_alloc(radix_tree_node_cachep, gfp);
> 	if (!xas->xa_alloc)
> 		return false;
> +	xas->xa_alloc->parent =3D NULL;
> 	XA_NODE_BUG_ON(xas->xa_alloc, =
!list_empty(&xas->xa_alloc->private_list));
> 	xas->xa_node =3D XAS_RESTART;
> 	return true;
> @@ -339,6 +342,7 @@ static bool __xas_nomem(struct xa_state *xas, =
gfp_t gfp)
> 	}
> 	if (!xas->xa_alloc)
> 		return false;
> +	xas->xa_alloc->parent =3D NULL;
> 	XA_NODE_BUG_ON(xas->xa_alloc, =
!list_empty(&xas->xa_alloc->private_list));
> 	xas->xa_node =3D XAS_RESTART;
> 	return true;
> @@ -403,7 +407,7 @@ static unsigned long xas_size(const struct =
xa_state *xas)
> /*
>  * Use this to calculate the maximum index that will need to be =
created
>  * in order to add the entry described by @xas.  Because we cannot =
store a
> - * multiple-index entry at index 0, the calculation is a little more =
complex
> + * multi-index entry at index 0, the calculation is a little more =
complex
>  * than you might expect.
>  */
> static unsigned long xas_max(struct xa_state *xas)
> @@ -946,6 +950,137 @@ void xas_init_marks(const struct xa_state *xas)
> }
> EXPORT_SYMBOL_GPL(xas_init_marks);
>=20
> +#ifdef CONFIG_XARRAY_MULTI
> +static unsigned int node_get_marks(struct xa_node *node, unsigned int =
offset)
> +{
> +	unsigned int marks =3D 0;
> +	xa_mark_t mark =3D XA_MARK_0;
> +
> +	for (;;) {
> +		if (node_get_mark(node, offset, mark))
> +			marks |=3D 1 << (__force unsigned int)mark;
> +		if (mark =3D=3D XA_MARK_MAX)
> +			break;
> +		mark_inc(mark);
> +	}
> +
> +	return marks;
> +}
> +
> +static void node_set_marks(struct xa_node *node, unsigned int offset,
> +			struct xa_node *child, unsigned int marks)
> +{
> +	xa_mark_t mark =3D XA_MARK_0;
> +
> +	for (;;) {
> +		if (marks & (1 << (__force unsigned int)mark))
> +			node_set_mark(node, offset, mark);
> +		if (child)
> +			node_mark_all(child, mark);
> +		if (mark =3D=3D XA_MARK_MAX)
> +			break;
> +		mark_inc(mark);
> +	}
> +}
> +
> +void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int =
order,
> +		gfp_t gfp)
> +{
> +	unsigned int sibs =3D xas->xa_sibs;
> +	unsigned int mask =3D (1 << (order % XA_CHUNK_SHIFT)) - 1;
> +
> +	/* XXX: no support for splitting really large entries yet */
> +	if (WARN_ON(order + XA_CHUNK_SHIFT < xas->xa_shift))
> +		goto nomem;
> +	if (xas->xa_shift <=3D order)
> +		return;
> +
> +	do {
> +		unsigned int i;
> +		void *sibling;
> +		struct xa_node *node;
> +
> +		node =3D kmem_cache_alloc(radix_tree_node_cachep, gfp);
> +		if (!node)
> +			goto nomem;
> +		node->array =3D xas->xa;
> +		for (i =3D 0; i < XA_CHUNK_SIZE; i++) {
> +			if ((i & mask) =3D=3D 0) {
> +				RCU_INIT_POINTER(node->slots[i], entry);
> +				sibling =3D xa_mk_sibling(0);
> +			} else {
> +				RCU_INIT_POINTER(node->slots[i], =
sibling);
> +			}
> +		}
> +		RCU_INIT_POINTER(node->parent, xas->xa_alloc);
> +		xas->xa_alloc =3D node;
> +	} while (sibs-- > 0);
> +
> +	return;
> +nomem:
> +	xas_destroy(xas);
> +	xas_set_err(xas, -ENOMEM);
> +}
> +
> +/**
> + * xas_split() - Split a multi-index entry into smaller entries.
> + * @xas: XArray operation state.
> + * @entry: New entry to store in the array.
> + * @order: New entry order.
> + *
> + * The value in the entry is copied to all the replacement entries.
> + *
> + * Context: Any context.  The caller should hold the xa_lock.
> + */
> +void xas_split(struct xa_state *xas, void *entry, unsigned int order)
> +{
> +	unsigned int offset, marks;
> +	struct xa_node *node;
> +	void *curr =3D xas_load(xas);
> +	int values =3D 0;
> +
> +	node =3D xas->xa_node;
> +	if (xas_top(node))
> +		return;
> +
> +	marks =3D node_get_marks(node, xas->xa_offset);
> +
> +	offset =3D xas->xa_offset + xas->xa_sibs;
> +	do {
> +		if (order < node->shift) {
> +			struct xa_node *child =3D xas->xa_alloc;
> +
> +			xas->xa_alloc =3D =
rcu_dereference_raw(child->parent);
> +			child->shift =3D node->shift - XA_CHUNK_SHIFT;
> +			child->offset =3D offset;
> +			child->count =3D XA_CHUNK_SIZE;
> +			child->nr_values =3D xa_is_value(entry) ?
> +					XA_CHUNK_SIZE : 0;
> +			RCU_INIT_POINTER(child->parent, node);
> +			node_set_marks(node, offset, child, marks);
> +			rcu_assign_pointer(node->slots[offset],
> +					xa_mk_node(child));
> +			if (xa_is_value(curr))
> +				values--;
> +		} else {
> +			unsigned int canon =3D offset -
> +					(1 << (order % XA_CHUNK_SHIFT)) =
+ 1;
> +
> +			node_set_marks(node, canon, NULL, marks);
> +			rcu_assign_pointer(node->slots[canon], entry);
> +			while (offset > canon)
> +				=
rcu_assign_pointer(node->slots[offset--],
> +						xa_mk_sibling(canon));
> +			values +=3D (xa_is_value(entry) - =
xa_is_value(curr)) *
> +					(1 << (order % XA_CHUNK_SHIFT));
> +		}
> +	} while (offset-- > xas->xa_offset);
> +
> +	node->nr_values +=3D values;
> +}
> +EXPORT_SYMBOL_GPL(xas_split);
> +#endif
> +
> /**
>  * xas_pause() - Pause a walk to drop a lock.
>  * @xas: XArray operation state.
> @@ -1407,7 +1542,7 @@ EXPORT_SYMBOL(__xa_store);
>  * @gfp: Memory allocation flags.
>  *
>  * After this function returns, loads from this index will return =
@entry.
> - * Storing into an existing multislot entry updates the entry of =
every index.
> + * Storing into an existing multi-index entry updates the entry of =
every index.
>  * The marks associated with @index are unaffected unless @entry is =
%NULL.
>  *
>  * Context: Any context.  Takes and releases the xa_lock.
> @@ -1549,7 +1684,7 @@ static void xas_set_range(struct xa_state *xas, =
unsigned long first,
>  *
>  * After this function returns, loads from any index between @first =
and @last,
>  * inclusive will return @entry.
> - * Storing into an existing multislot entry updates the entry of =
every index.
> + * Storing into an existing multi-index entry updates the entry of =
every index.
>  * The marks associated with @index are unaffected unless @entry is =
%NULL.
>  *
>  * Context: Process context.  Takes and releases the xa_lock.  May =
sleep
> --=20
> 2.27.0
>=20
>=20

