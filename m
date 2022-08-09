Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4DD58DE19
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 20:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345258AbiHISKc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 14:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345201AbiHISJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:09:47 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A485226AE3
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Aug 2022 11:03:58 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id e28so1316888qts.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Aug 2022 11:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EzoKdjjY+Xp02PuSkTzoqQPaIAVhUJwjov/5pbB5qd0=;
        b=UdLKEDfFeT15jaOSKaZ0a7YDo6Zth3zWkhwOoqWBnIF/yRYDuLxRU08C++qrcuAWn0
         lj+6JpnOL8eOFIVnEcw6fYiADmookd1heL3lnE285h+dbAfp9LWzdOhHjG2GcsNyg5E9
         L0T5FO6n0sHD+6ANwAgnIh8bnJheKurVMNWSS9qrtHt2+k63gP674Ve5oDv42ThfRa4J
         +a2grbFOxWUDMK0cd3CARD9HzAd3l80WB8gpyHJX6L2TMs04iYFd+gwP3fN8xkv64mJR
         6t2b7l6Ze3IIo35LTU+wYetk5PRodfl2+3ze1pCfMhMDxdfFsCXdDS6NlitTFVzkuKTV
         lDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EzoKdjjY+Xp02PuSkTzoqQPaIAVhUJwjov/5pbB5qd0=;
        b=FSq1UR0FZdg8N30DjoVek25LKpd4CjPGrApaYTI7jYkjEOpvTLfg9gOGJmbu7CaOIJ
         kEwiZ8PxOE2+g2xSzgxbkCBxxOOS16WaasVRsbw1rRsMeD+1yx6MrZZ4HZzB3DtHmG39
         cV9W0DxZ16SAquAjoUUGhie27cUADoX81G4CaqhNztL7aJZm6DHP/emMv7wQ/YH/HG1A
         b0Fo0Z5ZqoQM4Y5xgtgRIMyVYTzXk/Avq8U17DRi7XftDkJn9PyB0UKMIJkMKpq0wokY
         vaT7Os23CEyjMxmy0Cr1NJOOndrHznAuCm3qfdmeHZ3wf/CUpj7atyvmySc9pwnwinUw
         a8fw==
X-Gm-Message-State: ACgBeo1T9uYk6fHU4QKHVZSJMqKCMJv1XL1F1ITnrdCxok5izl3qZ6+S
        Pv29tAQVSLlYqx9gyABbdlLNuA==
X-Google-Smtp-Source: AA6agR6v+a50EjeAZQZcHP6m9fw0sg4fAGeRdkDsI+o8plC+3rcBy2aoMX9VNkQOHFP8/lw3WAGxDQ==
X-Received: by 2002:a05:622a:170c:b0:31e:fd23:fd01 with SMTP id h12-20020a05622a170c00b0031efd23fd01mr20691726qtk.40.1660068236762;
        Tue, 09 Aug 2022 11:03:56 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:b19b:cbb5:a678:767c])
        by smtp.gmail.com with ESMTPSA id u33-20020a05622a19a100b00342e86b3bdasm8905881qtc.12.2022.08.09.11.03.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Aug 2022 11:03:53 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 3/3] hfs: Replace kmap() with kmap_local_page() in btree.c
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20220809152004.9223-4-fmdefrancesco@gmail.com>
Date:   Tue, 9 Aug 2022 11:03:49 -0700
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Layton <jlayton@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0030B523-1D3B-43B4-86E2-B9ED25FD26B7@dubeyko.com>
References: <20220809152004.9223-1-fmdefrancesco@gmail.com>
 <20220809152004.9223-4-fmdefrancesco@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 9, 2022, at 8:20 AM, Fabio M. De Francesco =
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
> Since its use in btree.c is safe everywhere, it should be preferred.
>=20
> Therefore, replace kmap() with kmap_local_page() in btree.c. Where
> possible, use the suited standard helpers (memzero_page(), =
memcpy_page())
> instead of open coding kmap_local_page() plus memset() or memcpy().
>=20
> Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
> HIGHMEM64GB enabled.
>=20
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---


Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.


> fs/hfs/btree.c | 30 ++++++++++++++++--------------
> 1 file changed, 16 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index 56c6782436e9..2fa4b1f8cc7f 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -80,7 +80,8 @@ struct hfs_btree *hfs_btree_open(struct super_block =
*sb, u32 id, btree_keycmp ke
> 		goto free_inode;
>=20
> 	/* Load the header */
> -	head =3D (struct hfs_btree_header_rec *)(kmap(page) + =
sizeof(struct hfs_bnode_desc));
> +	head =3D (struct hfs_btree_header_rec *)(kmap_local_page(page) +
> +					       sizeof(struct =
hfs_bnode_desc));
> 	tree->root =3D be32_to_cpu(head->root);
> 	tree->leaf_count =3D be32_to_cpu(head->leaf_count);
> 	tree->leaf_head =3D be32_to_cpu(head->leaf_head);
> @@ -119,12 +120,12 @@ struct hfs_btree *hfs_btree_open(struct =
super_block *sb, u32 id, btree_keycmp ke
> 	tree->node_size_shift =3D ffs(size) - 1;
> 	tree->pages_per_bnode =3D (tree->node_size + PAGE_SIZE - 1) >> =
PAGE_SHIFT;
>=20
> -	kunmap(page);
> +	kunmap_local(head);
> 	put_page(page);
> 	return tree;
>=20
> fail_page:
> -	kunmap(page);
> +	kunmap_local(head);
> 	put_page(page);
> free_inode:
> 	tree->inode->i_mapping->a_ops =3D &hfs_aops;
> @@ -170,7 +171,8 @@ void hfs_btree_write(struct hfs_btree *tree)
> 		return;
> 	/* Load the header */
> 	page =3D node->page[0];
> -	head =3D (struct hfs_btree_header_rec *)(kmap(page) + =
sizeof(struct hfs_bnode_desc));
> +	head =3D (struct hfs_btree_header_rec *)(kmap_local_page(page) +
> +					       sizeof(struct =
hfs_bnode_desc));
>=20
> 	head->root =3D cpu_to_be32(tree->root);
> 	head->leaf_count =3D cpu_to_be32(tree->leaf_count);
> @@ -181,7 +183,7 @@ void hfs_btree_write(struct hfs_btree *tree)
> 	head->attributes =3D cpu_to_be32(tree->attributes);
> 	head->depth =3D cpu_to_be16(tree->depth);
>=20
> -	kunmap(page);
> +	kunmap_local(head);
> 	set_page_dirty(page);
> 	hfs_bnode_put(node);
> }
> @@ -269,7 +271,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree =
*tree)
>=20
> 	off +=3D node->page_offset;
> 	pagep =3D node->page + (off >> PAGE_SHIFT);
> -	data =3D kmap(*pagep);
> +	data =3D kmap_local_page(*pagep);
> 	off &=3D ~PAGE_MASK;
> 	idx =3D 0;
>=20
> @@ -282,7 +284,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree =
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
> @@ -291,14 +293,14 @@ struct hfs_bnode *hfs_bmap_alloc(struct =
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
> 			printk(KERN_DEBUG "create new bmap node...\n");
> @@ -314,7 +316,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree =
*tree)
> 		off =3D off16;
> 		off +=3D node->page_offset;
> 		pagep =3D node->page + (off >> PAGE_SHIFT);
> -		data =3D kmap(*pagep);
> +		data =3D kmap_local_page(*pagep);
> 		off &=3D ~PAGE_MASK;
> 	}
> }
> @@ -361,20 +363,20 @@ void hfs_bmap_free(struct hfs_bnode *node)
> 	}
> 	off +=3D node->page_offset + nidx / 8;
> 	page =3D node->page[off >> PAGE_SHIFT];
> -	data =3D kmap(page);
> +	data =3D kmap_local_page(page);
> 	off &=3D ~PAGE_MASK;
> 	m =3D 1 << (~nidx & 7);
> 	byte =3D data[off];
> 	if (!(byte & m)) {
> 		pr_crit("trying to free free bnode %u(%d)\n",
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

