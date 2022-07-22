Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C0357E5C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 19:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbiGVRoN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 13:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbiGVRoJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:44:09 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C48182114
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jul 2022 10:44:08 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id u9so6269818oiv.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jul 2022 10:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yzH8RBlWVaD8eYC4JxGLhQXlUu0TLl1/8ifUZNgU8qs=;
        b=K6r33kZ9a7ckXXG/9yLIrDoalxku4OSJkopklXI1g3FsXv5AQtCpjlqaq4IrfwDEWp
         FBs7ALBqi3h39obbYDFdJg0DokZn3+RPPdfWIBAdSaEF+pgNcFqTJya2wPren3bnEwUk
         xtQ147GDH5gZXau/M3Tcx4mXGoW9mkXfF803z8SebShRCoHje8vqOecGIKZZTVK9BWNr
         69NujmRg6cNR0oV5mPpLvlQe0uhDHcMXpZtYxgQBRA784/B4KMJqihtPzOao+9L8h02k
         YhCOcJOXklhJtz195zdXmGpq/ufCbQQWcmYD6v98RlFoaL6a3/pDVJ39thtVsvA9D/TE
         N6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yzH8RBlWVaD8eYC4JxGLhQXlUu0TLl1/8ifUZNgU8qs=;
        b=2OEPBGIUOw5mpVpM+7iOAzykhzVPIUbPqoiqyfu4/uLIxQtQUuSClPVtIOaoDXcLQU
         RaKwpmPnKTYlQYf/cvVnnh9GjXJmYfegnV/6tdNCkvnj2NQGpTUZemJs9/jf7gmdMera
         y32PjAuYQraIeZwcPyZteh5P9RVkW/ki6C8BlTOay5MeA/Gv0QLY6wAeLmPstPXxs/VA
         fHfOP9p7Z5kCbsHSAXQo8cegArcdZkpipBoNz3VAoFyBEU8L3jt4S50swJg0EJEPXmsI
         cJeGoTfUKCO8Vvq1yYEj1VATSwMVnnAix8MM8JTu/rXV8C6oVd/PdAMQgaE3zhdozuOG
         uMjA==
X-Gm-Message-State: AJIora8XwJd1eJdhSg91Jf/kNm6B6sziULjxM7/9v2meh/96ZoPKY3kd
        rN7CYY8Pz+xU+y8ehLGXetJcrCUexZZCdw==
X-Google-Smtp-Source: AGRyM1t2Sr9gDvWw9G1dQt/ScnFv+WKKNt9oyYGuy8yM7CPHcu/l+yCRo9FElYpeIWPnRpb5T+VBAA==
X-Received: by 2002:a05:6808:171c:b0:334:9342:63ef with SMTP id bc28-20020a056808171c00b00334934263efmr419145oib.63.1658511847570;
        Fri, 22 Jul 2022 10:44:07 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:99be:940b:cb7d:ef1])
        by smtp.gmail.com with ESMTPSA id r127-20020acada85000000b0033a0ef748a8sm2011504oig.54.2022.07.22.10.44.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jul 2022 10:44:06 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH] hfsplus: Convert kmap() to kmap_local_page() in bnode.c
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20220720154324.8272-1-fmdefrancesco@gmail.com>
Date:   Fri, 22 Jul 2022 10:43:59 -0700
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DED96F4D-9320-45BE-BD22-89EFEB75001B@dubeyko.com>
References: <20220720154324.8272-1-fmdefrancesco@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Fabio,

> On Jul 20, 2022, at 8:43 AM, Fabio M. De Francesco =
<fmdefrancesco@gmail.com> wrote:
>=20
> kmap() is being deprecated in favor of kmap_local_page().
>=20
> Two main problems with kmap(): (1) It comes with an overhead as =
mapping
> space is restricted and protected by a global lock for synchronization =
and
> (2) it also requires global TLB invalidation when the kmap=E2=80=99s =
pool wraps
> and it might block when the mapping space is fully utilized until a =
slot
> becomes available.
>=20
> With kmap_local_page() the mappings are per thread, CPU local, can =
take
> page faults, and can be called from any context (including =
interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, =
the
> kernel virtual addresses are restored and still valid.
>=20
> Since its use in bnode.c is safe everywhere, it should be preferred.
>=20
> Therefore, replace kmap() with kmap_local_page() in bnode.c. Where
> possible, use the suited standard helpers (memzero_page(), =
memcpy_page())
> instead of open coding kmap_local_page() plus memset() or memcpy().
>=20


Looks reasonable. Makes sense from my point of view.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.



> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> fs/hfsplus/bnode.c | 105 +++++++++++++++++++++------------------------
> 1 file changed, 48 insertions(+), 57 deletions(-)
>=20
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index 177fae4e6581..3a1c77d0df48 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -29,14 +29,12 @@ void hfs_bnode_read(struct hfs_bnode *node, void =
*buf, int off, int len)
> 	off &=3D ~PAGE_MASK;
>=20
> 	l =3D min_t(int, len, PAGE_SIZE - off);
> -	memcpy(buf, kmap(*pagep) + off, l);
> -	kunmap(*pagep);
> +	memcpy_from_page(buf, *pagep, off, l);
>=20
> 	while ((len -=3D l) !=3D 0) {
> 		buf +=3D l;
> 		l =3D min_t(int, len, PAGE_SIZE);
> -		memcpy(buf, kmap(*++pagep), l);
> -		kunmap(*pagep);
> +		memcpy_from_page(buf, *++pagep, 0, l);
> 	}
> }
>=20
> @@ -82,16 +80,14 @@ void hfs_bnode_write(struct hfs_bnode *node, void =
*buf, int off, int len)
> 	off &=3D ~PAGE_MASK;
>=20
> 	l =3D min_t(int, len, PAGE_SIZE - off);
> -	memcpy(kmap(*pagep) + off, buf, l);
> +	memcpy_to_page(*pagep, off, buf, l);
> 	set_page_dirty(*pagep);
> -	kunmap(*pagep);
>=20
> 	while ((len -=3D l) !=3D 0) {
> 		buf +=3D l;
> 		l =3D min_t(int, len, PAGE_SIZE);
> -		memcpy(kmap(*++pagep), buf, l);
> +		memcpy_to_page(*++pagep, 0, buf, l);
> 		set_page_dirty(*pagep);
> -		kunmap(*pagep);
> 	}
> }
>=20
> @@ -112,15 +108,13 @@ void hfs_bnode_clear(struct hfs_bnode *node, int =
off, int len)
> 	off &=3D ~PAGE_MASK;
>=20
> 	l =3D min_t(int, len, PAGE_SIZE - off);
> -	memset(kmap(*pagep) + off, 0, l);
> +	memzero_page(*pagep, off, l);
> 	set_page_dirty(*pagep);
> -	kunmap(*pagep);
>=20
> 	while ((len -=3D l) !=3D 0) {
> 		l =3D min_t(int, len, PAGE_SIZE);
> -		memset(kmap(*++pagep), 0, l);
> +		memzero_page(*++pagep, 0, l);
> 		set_page_dirty(*pagep);
> -		kunmap(*pagep);
> 	}
> }
>=20
> @@ -142,24 +136,20 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, =
int dst,
>=20
> 	if (src =3D=3D dst) {
> 		l =3D min_t(int, len, PAGE_SIZE - src);
> -		memcpy(kmap(*dst_page) + src, kmap(*src_page) + src, l);
> -		kunmap(*src_page);
> +		memcpy_page(*dst_page, src, *src_page, src, l);
> 		set_page_dirty(*dst_page);
> -		kunmap(*dst_page);
>=20
> 		while ((len -=3D l) !=3D 0) {
> 			l =3D min_t(int, len, PAGE_SIZE);
> -			memcpy(kmap(*++dst_page), kmap(*++src_page), l);
> -			kunmap(*src_page);
> +			memcpy_page(*++dst_page, 0, *++src_page, 0, l);
> 			set_page_dirty(*dst_page);
> -			kunmap(*dst_page);
> 		}
> 	} else {
> 		void *src_ptr, *dst_ptr;
>=20
> 		do {
> -			src_ptr =3D kmap(*src_page) + src;
> -			dst_ptr =3D kmap(*dst_page) + dst;
> +			dst_ptr =3D kmap_local_page(*dst_page) + dst;
> +			src_ptr =3D kmap_local_page(*src_page) + src;
> 			if (PAGE_SIZE - src < PAGE_SIZE - dst) {
> 				l =3D PAGE_SIZE - src;
> 				src =3D 0;
> @@ -171,9 +161,9 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, =
int dst,
> 			}
> 			l =3D min(len, l);
> 			memcpy(dst_ptr, src_ptr, l);
> -			kunmap(*src_page);
> +			kunmap_local(src_ptr);
> 			set_page_dirty(*dst_page);
> -			kunmap(*dst_page);
> +			kunmap_local(dst_ptr);
> 			if (!dst)
> 				dst_page++;
> 			else
> @@ -185,6 +175,7 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, =
int dst,
> void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
> {
> 	struct page **src_page, **dst_page;
> +	void *src_ptr, *dst_ptr;
> 	int l;
>=20
> 	hfs_dbg(BNODE_MOD, "movebytes: %u,%u,%u\n", dst, src, len);
> @@ -202,27 +193,28 @@ void hfs_bnode_move(struct hfs_bnode *node, int =
dst, int src, int len)
>=20
> 		if (src =3D=3D dst) {
> 			while (src < len) {
> -				memmove(kmap(*dst_page), =
kmap(*src_page), src);
> -				kunmap(*src_page);
> +				dst_ptr =3D kmap_local_page(*dst_page);
> +				src_ptr =3D kmap_local_page(*src_page);
> +				memmove(dst_ptr, src_ptr, src);
> +				kunmap_local(src_ptr);
> 				set_page_dirty(*dst_page);
> -				kunmap(*dst_page);
> +				kunmap_local(dst_ptr);
> 				len -=3D src;
> 				src =3D PAGE_SIZE;
> 				src_page--;
> 				dst_page--;
> 			}
> 			src -=3D len;
> -			memmove(kmap(*dst_page) + src,
> -				kmap(*src_page) + src, len);
> -			kunmap(*src_page);
> +			dst_ptr =3D kmap_local_page(*dst_page);
> +			src_ptr =3D kmap_local_page(*src_page);
> +			memmove(dst_ptr + src, src_ptr + src, len);
> +			kunmap_local(src_ptr);
> 			set_page_dirty(*dst_page);
> -			kunmap(*dst_page);
> +			kunmap_local(dst_ptr);
> 		} else {
> -			void *src_ptr, *dst_ptr;
> -
> 			do {
> -				src_ptr =3D kmap(*src_page) + src;
> -				dst_ptr =3D kmap(*dst_page) + dst;
> +				dst_ptr =3D kmap_local_page(*dst_page) + =
dst;
> +				src_ptr =3D kmap_local_page(*src_page) + =
src;
> 				if (src < dst) {
> 					l =3D src;
> 					src =3D PAGE_SIZE;
> @@ -234,9 +226,9 @@ void hfs_bnode_move(struct hfs_bnode *node, int =
dst, int src, int len)
> 				}
> 				l =3D min(len, l);
> 				memmove(dst_ptr - l, src_ptr - l, l);
> -				kunmap(*src_page);
> +				kunmap_local(src_ptr);
> 				set_page_dirty(*dst_page);
> -				kunmap(*dst_page);
> +				kunmap_local(dst_ptr);
> 				if (dst =3D=3D PAGE_SIZE)
> 					dst_page--;
> 				else
> @@ -251,26 +243,27 @@ void hfs_bnode_move(struct hfs_bnode *node, int =
dst, int src, int len)
>=20
> 		if (src =3D=3D dst) {
> 			l =3D min_t(int, len, PAGE_SIZE - src);
> -			memmove(kmap(*dst_page) + src,
> -				kmap(*src_page) + src, l);
> -			kunmap(*src_page);
> +
> +			dst_ptr =3D kmap_local_page(*dst_page) + src;
> +			src_ptr =3D kmap_local_page(*src_page) + src;
> +			memmove(dst_ptr, src_ptr, l);
> +			kunmap_local(src_ptr);
> 			set_page_dirty(*dst_page);
> -			kunmap(*dst_page);
> +			kunmap_local(dst_ptr);
>=20
> 			while ((len -=3D l) !=3D 0) {
> 				l =3D min_t(int, len, PAGE_SIZE);
> -				memmove(kmap(*++dst_page),
> -					kmap(*++src_page), l);
> -				kunmap(*src_page);
> +				dst_ptr =3D =
kmap_local_page(*++dst_page);
> +				src_ptr =3D =
kmap_local_page(*++src_page);
> +				memmove(dst_ptr, src_ptr, l);
> +				kunmap_local(src_ptr);
> 				set_page_dirty(*dst_page);
> -				kunmap(*dst_page);
> +				kunmap_local(dst_ptr);
> 			}
> 		} else {
> -			void *src_ptr, *dst_ptr;
> -
> 			do {
> -				src_ptr =3D kmap(*src_page) + src;
> -				dst_ptr =3D kmap(*dst_page) + dst;
> +				dst_ptr =3D kmap_local_page(*dst_page) + =
dst;
> +				src_ptr =3D kmap_local_page(*src_page) + =
src;
> 				if (PAGE_SIZE - src <
> 						PAGE_SIZE - dst) {
> 					l =3D PAGE_SIZE - src;
> @@ -283,9 +276,9 @@ void hfs_bnode_move(struct hfs_bnode *node, int =
dst, int src, int len)
> 				}
> 				l =3D min(len, l);
> 				memmove(dst_ptr, src_ptr, l);
> -				kunmap(*src_page);
> +				kunmap_local(src_ptr);
> 				set_page_dirty(*dst_page);
> -				kunmap(*dst_page);
> +				kunmap_local(dst_ptr);
> 				if (!dst)
> 					dst_page++;
> 				else
> @@ -502,14 +495,14 @@ struct hfs_bnode *hfs_bnode_find(struct =
hfs_btree *tree, u32 num)
> 	if (!test_bit(HFS_BNODE_NEW, &node->flags))
> 		return node;
>=20
> -	desc =3D (struct hfs_bnode_desc *)(kmap(node->page[0]) +
> -			node->page_offset);
> +	desc =3D (struct hfs_bnode_desc =
*)(kmap_local_page(node->page[0]) +
> +							 =
node->page_offset);
> 	node->prev =3D be32_to_cpu(desc->prev);
> 	node->next =3D be32_to_cpu(desc->next);
> 	node->num_recs =3D be16_to_cpu(desc->num_recs);
> 	node->type =3D desc->type;
> 	node->height =3D desc->height;
> -	kunmap(node->page[0]);
> +	kunmap_local(desc);
>=20
> 	switch (node->type) {
> 	case HFS_NODE_HEADER:
> @@ -593,14 +586,12 @@ struct hfs_bnode *hfs_bnode_create(struct =
hfs_btree *tree, u32 num)
> 	}
>=20
> 	pagep =3D node->page;
> -	memset(kmap(*pagep) + node->page_offset, 0,
> -	       min_t(int, PAGE_SIZE, tree->node_size));
> +	memzero_page(*pagep, node->page_offset,
> +		     min_t(int, PAGE_SIZE, tree->node_size));
> 	set_page_dirty(*pagep);
> -	kunmap(*pagep);
> 	for (i =3D 1; i < tree->pages_per_bnode; i++) {
> -		memset(kmap(*++pagep), 0, PAGE_SIZE);
> +		memzero_page(*++pagep, 0, PAGE_SIZE);
> 		set_page_dirty(*pagep);
> -		kunmap(*pagep);
> 	}
> 	clear_bit(HFS_BNODE_NEW, &node->flags);
> 	wake_up(&node->lock_wq);
> --=20
> 2.37.1
>=20

