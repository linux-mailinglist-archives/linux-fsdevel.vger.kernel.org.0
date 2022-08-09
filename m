Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4584158E319
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 00:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiHIWSX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 18:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiHIWSE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:18:04 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C0A65579
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Aug 2022 15:17:37 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id m22so9832103qkm.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Aug 2022 15:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UmCBRGF3C2n8uq8833y/5TNpiGFctwemElE6YbHo9AQ=;
        b=aTx9UXWAC9kFhPi5ZvC9R15Oh69fUWPsvm7MufHSf1vRg41jroAgTA9EpZEqcwUdC3
         4JDNoKZ88ItTx8yR8pMqsq1iLjvKnz5mk6vJQ57sroWz4Ug9m750mMlJXioBczoK65AC
         S7JB2TMqiiVPJfuk0W/OnpUxionGfPxJkq5B5PU/+4R1MC73vk8dKa/ZlKAta90mlyJB
         O/y1nfbSVk4p67B3kUSFc6WWpdRlpoBX9VRbiTx9uvNFbIy5X/jjv8FG389uVXZWn0AF
         sqzJ2GHK9ilACd2zIiAFPiyczOO3TWw6FBF6I3yg4XCppma/NxS0C46AQgnryNrFM+ww
         BL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UmCBRGF3C2n8uq8833y/5TNpiGFctwemElE6YbHo9AQ=;
        b=7EeSzOV5Y0v3O+R8c8C0BroGipj8H45sIBl2J4moHY4LlCrqV5GiEkQnsHvcLLGQbT
         w0qRyMewjPM8cU9DOH3mTYEm0ZYlLGKQolsib8jRJQOFV7v1QNyUd7VSkxZIGl43yDrV
         usBqR6TY5riO8d8j/b3nakeDLRER34231kv2GwHrRcAfxYpOpluDYgXJL4RsZJB8MW1G
         GbY5E1CLzrAd7PqEZemvvA+iJB6RqYq/5JE9zWKP0THlAQZZefeZ1ODJyQoqdvAg7FXF
         wkSauPn4y7oaDHdbvcl9wI2AB+uh4g4QXN3R3zhjrdhR5ESg48ZpFMmz6GafWb8Y347V
         tsFw==
X-Gm-Message-State: ACgBeo23wKYPxUp2e+Pp7RMn9lDtraBsxysd6mxBtPOmoIzFnto4nrgU
        93xHhcX0cU5Zs0wydmnAwr2EeQ==
X-Google-Smtp-Source: AA6agR7auohcrvnWrjstv/cLVGoSW612Ac8mPzmL0gXmCGBAXUxL4MAcnWLKjowCtUC9VpoVYQZKMg==
X-Received: by 2002:ae9:e901:0:b0:6b6:ad9:c9c1 with SMTP id x1-20020ae9e901000000b006b60ad9c9c1mr18823579qkf.313.1660083456758;
        Tue, 09 Aug 2022 15:17:36 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:b19b:cbb5:a678:767c])
        by smtp.gmail.com with ESMTPSA id o4-20020ac841c4000000b00342fd6d6dd3sm3791677qtm.42.2022.08.09.15.17.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Aug 2022 15:17:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 2/4] hfsplus: Convert kmap() to kmap_local_page() in
 bnode.c
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20220809203105.26183-3-fmdefrancesco@gmail.com>
Date:   Tue, 9 Aug 2022 15:17:32 -0700
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Kees Cook <keescook@chromium.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AE062B97-2A87-4ADF-B143-0BC2F202A16E@dubeyko.com>
References: <20220809203105.26183-1-fmdefrancesco@gmail.com>
 <20220809203105.26183-3-fmdefrancesco@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 9, 2022, at 1:31 PM, Fabio M. De Francesco =
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
> Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
> HIGHMEM64GB enabled.
>=20
> Cc: Viacheslav Dubeyko <slava@dubeyko.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---


Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.


> fs/hfsplus/bnode.c | 105 +++++++++++++++++++++------------------------
> 1 file changed, 48 insertions(+), 57 deletions(-)
>=20
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index a5ab00e54220..87974d5e6791 100644
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
> @@ -498,14 +491,14 @@ struct hfs_bnode *hfs_bnode_find(struct =
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
> @@ -589,14 +582,12 @@ struct hfs_bnode *hfs_bnode_create(struct =
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

