Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B26558E31A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 00:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiHIWTC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 18:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiHIWSz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:18:55 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEB056BB6
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Aug 2022 15:18:49 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id w6so9868698qkf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Aug 2022 15:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BbdhUu1iQIdNypXcUPyn1a+IYyT/io0kAeHgkl3TXu8=;
        b=Umh7VA4rNT6XgSjvM8GnX25ofE7X+NKJMMyfYC/JH0nNKGQaHBg8q7gRB0Ru5dfRsf
         wBzeHYFcW7TPwtBP9MjPOPystYVZ9cwOW90IV9otBaDzeh2CipPOiJJvgKSNnUxYqk4p
         Xa1FX31QTVjncLWdjVTXnfmWxjhBSmYN6MWHHKXZ6TlqNi7O1EpRAe41vpr4tmrPsfTL
         5+n2wJsfda2GjDlxyQPObc1/nYO4mzgz+g3236ZEy+YB/aptJo5B9dss6SuyOhDUcZ12
         frc5JCj4Ir3meVdnpb7IJbJKGB4CbnT/nky+4Wia05sz0fsnMCBntXySYRUiJXPOYFxK
         eBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BbdhUu1iQIdNypXcUPyn1a+IYyT/io0kAeHgkl3TXu8=;
        b=HjOJGUbVaZNcn+Fnrln7m4OGkT+18GQXyvWGAUhrMsyhVvBY27oARhTg+x92IvfJ0i
         RUGEugX2qaGhOc0saAZU/GpbqSCC0IV7a7KpzIaGIaf3pCVeHFFkW6wmVOMjNzm+Ewrs
         L0kkvw+ClHGHUUTBnXE+ZMgiO963TD6PcAZolGSMqQGv3+dgpwQEF/OaGlouxTpROgh/
         FIitwhMYKZdFdi7z6nLor+p47e75KPwIxvs/upGK0VkIjdczHeLWWY2uga2DV4A8euzb
         P/Mg5QzGIwCQoM4e45vdsWqFEr4nTA1R5IMFID4dl/DhH9Oa/4SBTmNdswVkKaiy6LHR
         FuJg==
X-Gm-Message-State: ACgBeo3Bo3PDcBIdDsTdcF6P64SGEID3ey4L9KvmLwGAJOWdEnQ2AJgJ
        YloCA+VUpuBPySA4cLnOWukk4g==
X-Google-Smtp-Source: AA6agR7kWR9IyYz0H9pUs9FL5gMv3QEMSuIQIAQjXrDUHYB3l7yzmudEAB2y4KC3Mkw2JMVmZP2qOQ==
X-Received: by 2002:a05:620a:24d0:b0:6b9:1117:20c0 with SMTP id m16-20020a05620a24d000b006b9111720c0mr17343048qkn.271.1660083528211;
        Tue, 09 Aug 2022 15:18:48 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:b19b:cbb5:a678:767c])
        by smtp.gmail.com with ESMTPSA id o4-20020ac841c4000000b00342fd6d6dd3sm3791677qtm.42.2022.08.09.15.18.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Aug 2022 15:18:46 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 4/4] hfsplus: Convert kmap() to kmap_local_page() in
 btree.c
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20220809203105.26183-5-fmdefrancesco@gmail.com>
Date:   Tue, 9 Aug 2022 15:18:37 -0700
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Kees Cook <keescook@chromium.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4C85926A-2FB5-418B-8F76-3055FA213D6C@dubeyko.com>
References: <20220809203105.26183-1-fmdefrancesco@gmail.com>
 <20220809203105.26183-5-fmdefrancesco@gmail.com>
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
> There are two main problems with kmap(): (1) It comes with an overhead =
as
> mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when =
the
> kmap=E2=80=99s pool wraps and it might block when the mapping space is =
fully
> utilized until a slot becomes available.
>=20
> With kmap_local_page() the mappings are per thread, CPU local, can =
take
> page faults, and can be called from any context (including =
interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, =
the
> kernel virtual addresses are restored and are still valid.
>=20
> Since its use in btree.c is safe everywhere, it should be preferred.
>=20
> Therefore, replace kmap() with kmap_local_page() in btree.c.
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


> fs/hfsplus/btree.c | 28 ++++++++++++++--------------
> 1 file changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index 3a917a9a4edd..9e1732a2b92a 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -163,7 +163,7 @@ struct hfs_btree *hfs_btree_open(struct =
super_block *sb, u32 id)
> 		goto free_inode;
>=20
> 	/* Load the header */
> -	head =3D (struct hfs_btree_header_rec *)(kmap(page) +
> +	head =3D (struct hfs_btree_header_rec *)(kmap_local_page(page) +
> 		sizeof(struct hfs_bnode_desc));
> 	tree->root =3D be32_to_cpu(head->root);
> 	tree->leaf_count =3D be32_to_cpu(head->leaf_count);
> @@ -240,12 +240,12 @@ struct hfs_btree *hfs_btree_open(struct =
super_block *sb, u32 id)
> 		(tree->node_size + PAGE_SIZE - 1) >>
> 		PAGE_SHIFT;
>=20
> -	kunmap(page);
> +	kunmap_local(head);
> 	put_page(page);
> 	return tree;
>=20
>  fail_page:
> -	kunmap(page);
> +	kunmap_local(head);
> 	put_page(page);
>  free_inode:
> 	tree->inode->i_mapping->a_ops =3D &hfsplus_aops;
> @@ -292,7 +292,7 @@ int hfs_btree_write(struct hfs_btree *tree)
> 		return -EIO;
> 	/* Load the header */
> 	page =3D node->page[0];
> -	head =3D (struct hfs_btree_header_rec *)(kmap(page) +
> +	head =3D (struct hfs_btree_header_rec *)(kmap_local_page(page) +
> 		sizeof(struct hfs_bnode_desc));
>=20
> 	head->root =3D cpu_to_be32(tree->root);
> @@ -304,7 +304,7 @@ int hfs_btree_write(struct hfs_btree *tree)
> 	head->attributes =3D cpu_to_be32(tree->attributes);
> 	head->depth =3D cpu_to_be16(tree->depth);
>=20
> -	kunmap(page);
> +	kunmap_local(head);
> 	set_page_dirty(page);
> 	hfs_bnode_put(node);
> 	return 0;
> @@ -395,7 +395,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree =
*tree)
>=20
> 	off +=3D node->page_offset;
> 	pagep =3D node->page + (off >> PAGE_SHIFT);
> -	data =3D kmap(*pagep);
> +	data =3D kmap_local_page(*pagep);
> 	off &=3D ~PAGE_MASK;
> 	idx =3D 0;
>=20
> @@ -408,7 +408,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree =
*tree)
> 						idx +=3D i;
> 						data[off] |=3D m;
> 						set_page_dirty(*pagep);
> -						kunmap(*pagep);
> +						kunmap_local(data);
> 						tree->free_nodes--;
> 						=
mark_inode_dirty(tree->inode);
> 						hfs_bnode_put(node);
> @@ -418,14 +418,14 @@ struct hfs_bnode *hfs_bmap_alloc(struct =
hfs_btree *tree)
> 				}
> 			}
> 			if (++off >=3D PAGE_SIZE) {
> -				kunmap(*pagep);
> -				data =3D kmap(*++pagep);
> +				kunmap_local(data);
> +				data =3D kmap_local_page(*++pagep);
> 				off =3D 0;
> 			}
> 			idx +=3D 8;
> 			len--;
> 		}
> -		kunmap(*pagep);
> +		kunmap_local(data);
> 		nidx =3D node->next;
> 		if (!nidx) {
> 			hfs_dbg(BNODE_MOD, "create new bmap node\n");
> @@ -441,7 +441,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree =
*tree)
> 		off =3D off16;
> 		off +=3D node->page_offset;
> 		pagep =3D node->page + (off >> PAGE_SHIFT);
> -		data =3D kmap(*pagep);
> +		data =3D kmap_local_page(*pagep);
> 		off &=3D ~PAGE_MASK;
> 	}
> }
> @@ -491,7 +491,7 @@ void hfs_bmap_free(struct hfs_bnode *node)
> 	}
> 	off +=3D node->page_offset + nidx / 8;
> 	page =3D node->page[off >> PAGE_SHIFT];
> -	data =3D kmap(page);
> +	data =3D kmap_local_page(page);
> 	off &=3D ~PAGE_MASK;
> 	m =3D 1 << (~nidx & 7);
> 	byte =3D data[off];
> @@ -499,13 +499,13 @@ void hfs_bmap_free(struct hfs_bnode *node)
> 		pr_crit("trying to free free bnode "
> 				"%u(%d)\n",
> 			node->this, node->type);
> -		kunmap(page);
> +		kunmap_local(data);
> 		hfs_bnode_put(node);
> 		return;
> 	}
> 	data[off] =3D byte & ~m;
> 	set_page_dirty(page);
> -	kunmap(page);
> +	kunmap_local(data);
> 	hfs_bnode_put(node);
> 	tree->free_nodes++;
> 	mark_inode_dirty(tree->inode);
> --=20
> 2.37.1
>=20

