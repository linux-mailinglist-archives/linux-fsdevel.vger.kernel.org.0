Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A624958E315
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 00:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiHIWSX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 18:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiHIWSM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:18:12 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F30E26AE0
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Aug 2022 15:18:11 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id m7so9841737qkk.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Aug 2022 15:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3EJhff9VTHzfniLlXSqHGtz5Fl+rtZw2O6BTVWrxTb4=;
        b=zf6oNIpFSPmpq23CMj0vnxs5CoxbVdH/us/fHBcH9Z+sldQ7NGfDn2DVCyFSwt6s52
         KmixXpV5nktrJT1izeCozuOuz9hVQZDp9R9MC3DQfAnfScvJwkiudoV/EzbDnXHSqDzb
         NCY58gdfn8xxupB6qq/qAhXblETgUZNia7dGwaa37//GCoUsbnl0gU9KcvkShmwVYM6M
         A1gt5B+MXaiHSmwYRNR2IDS2eabMDptwUPfxVHQLqnkXDx3I4DiKA4K7ULt8o4NVwEPC
         oCeCjoxZdjGTzyqMwMqXzjYe9Y5P2/GVocLRERh5KuGKaH/vpcxsNoztps4LE1OtuIsO
         AP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3EJhff9VTHzfniLlXSqHGtz5Fl+rtZw2O6BTVWrxTb4=;
        b=LzVYKldfxN3wPGXT33yriCkjJGU1tqFcumP1fQ3++gvmUYdcCTQrktc/dzjhXWPG9F
         slSxU9ypxbxc/8SoRW/GZk08QbKKmph5nf0Fe+kKIRVrTQVxjIU7RLVACpIARvbBjfPy
         PAOwvqzqrZFselpO6Ipge3da615KDixHtRZFkhg41gfWLZwFl9IfT0iZvRgnyueHuOFf
         E82sIb7LePK7TySdeN0c4lUGsZf3inRnWrK+yepLUdyRlTlb6e2UvMfOUfr0zJ8oKAnZ
         CKLYGMjqFoi+0dnktWa5gzro32H9KmgzM3u6C9tqfo1PbM1ZoqZggqxDG+WV1uHmA0GY
         alVA==
X-Gm-Message-State: ACgBeo1pISaKrkhHSjI0c/+OSH3tUK7LdjSWn7Xo0kMdi9b9Dltd/VuQ
        QXSPZY033rrKE1yv/TLlXgwAtIkogNXbx5gw
X-Google-Smtp-Source: AA6agR6NKB3stPQs39LXsbzixkXSgIiuM1SfDSc6zwiwFJ6c4r5Ig+Ws6HmYRAyiGNuhxXdxHIlcuA==
X-Received: by 2002:a05:620a:74e:b0:6b5:f0ec:edbe with SMTP id i14-20020a05620a074e00b006b5f0ecedbemr19241026qki.436.1660083490530;
        Tue, 09 Aug 2022 15:18:10 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:b19b:cbb5:a678:767c])
        by smtp.gmail.com with ESMTPSA id o4-20020ac841c4000000b00342fd6d6dd3sm3791677qtm.42.2022.08.09.15.18.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Aug 2022 15:18:09 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 3/4] hfsplus: Convert kmap() to kmap_local_page() in
 bitmap.c
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20220809203105.26183-4-fmdefrancesco@gmail.com>
Date:   Tue, 9 Aug 2022 15:18:05 -0700
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Kees Cook <keescook@chromium.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <55002DA9-757F-47C0-B1C7-F808002E6B34@dubeyko.com>
References: <20220809203105.26183-1-fmdefrancesco@gmail.com>
 <20220809203105.26183-4-fmdefrancesco@gmail.com>
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
> Since its use in bitmap.c is safe everywhere, it should be preferred.
>=20
> Therefore, replace kmap() with kmap_local_page() in bitmap.c.
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


> fs/hfsplus/bitmap.c | 20 ++++++++++----------
> 1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/hfsplus/bitmap.c b/fs/hfsplus/bitmap.c
> index cebce0cfe340..bd8dcea85588 100644
> --- a/fs/hfsplus/bitmap.c
> +++ b/fs/hfsplus/bitmap.c
> @@ -39,7 +39,7 @@ int hfsplus_block_allocate(struct super_block *sb, =
u32 size,
> 		start =3D size;
> 		goto out;
> 	}
> -	pptr =3D kmap(page);
> +	pptr =3D kmap_local_page(page);
> 	curr =3D pptr + (offset & (PAGE_CACHE_BITS - 1)) / 32;
> 	i =3D offset % 32;
> 	offset &=3D ~(PAGE_CACHE_BITS - 1);
> @@ -74,7 +74,7 @@ int hfsplus_block_allocate(struct super_block *sb, =
u32 size,
> 			}
> 			curr++;
> 		}
> -		kunmap(page);
> +		kunmap_local(pptr);
> 		offset +=3D PAGE_CACHE_BITS;
> 		if (offset >=3D size)
> 			break;
> @@ -84,7 +84,7 @@ int hfsplus_block_allocate(struct super_block *sb, =
u32 size,
> 			start =3D size;
> 			goto out;
> 		}
> -		curr =3D pptr =3D kmap(page);
> +		curr =3D pptr =3D kmap_local_page(page);
> 		if ((size ^ offset) / PAGE_CACHE_BITS)
> 			end =3D pptr + PAGE_CACHE_BITS / 32;
> 		else
> @@ -127,7 +127,7 @@ int hfsplus_block_allocate(struct super_block *sb, =
u32 size,
> 			len -=3D 32;
> 		}
> 		set_page_dirty(page);
> -		kunmap(page);
> +		kunmap_local(pptr);
> 		offset +=3D PAGE_CACHE_BITS;
> 		page =3D read_mapping_page(mapping, offset / =
PAGE_CACHE_BITS,
> 					 NULL);
> @@ -135,7 +135,7 @@ int hfsplus_block_allocate(struct super_block *sb, =
u32 size,
> 			start =3D size;
> 			goto out;
> 		}
> -		pptr =3D kmap(page);
> +		pptr =3D kmap_local_page(page);
> 		curr =3D pptr;
> 		end =3D pptr + PAGE_CACHE_BITS / 32;
> 	}
> @@ -151,7 +151,7 @@ int hfsplus_block_allocate(struct super_block *sb, =
u32 size,
> done:
> 	*curr =3D cpu_to_be32(n);
> 	set_page_dirty(page);
> -	kunmap(page);
> +	kunmap_local(pptr);
> 	*max =3D offset + (curr - pptr) * 32 + i - start;
> 	sbi->free_blocks -=3D *max;
> 	hfsplus_mark_mdb_dirty(sb);
> @@ -185,7 +185,7 @@ int hfsplus_block_free(struct super_block *sb, u32 =
offset, u32 count)
> 	page =3D read_mapping_page(mapping, pnr, NULL);
> 	if (IS_ERR(page))
> 		goto kaboom;
> -	pptr =3D kmap(page);
> +	pptr =3D kmap_local_page(page);
> 	curr =3D pptr + (offset & (PAGE_CACHE_BITS - 1)) / 32;
> 	end =3D pptr + PAGE_CACHE_BITS / 32;
> 	len =3D count;
> @@ -215,11 +215,11 @@ int hfsplus_block_free(struct super_block *sb, =
u32 offset, u32 count)
> 		if (!count)
> 			break;
> 		set_page_dirty(page);
> -		kunmap(page);
> +		kunmap_local(pptr);
> 		page =3D read_mapping_page(mapping, ++pnr, NULL);
> 		if (IS_ERR(page))
> 			goto kaboom;
> -		pptr =3D kmap(page);
> +		pptr =3D kmap_local_page(page);
> 		curr =3D pptr;
> 		end =3D pptr + PAGE_CACHE_BITS / 32;
> 	}
> @@ -231,7 +231,7 @@ int hfsplus_block_free(struct super_block *sb, u32 =
offset, u32 count)
> 	}
> out:
> 	set_page_dirty(page);
> -	kunmap(page);
> +	kunmap_local(pptr);
> 	sbi->free_blocks +=3D len;
> 	hfsplus_mark_mdb_dirty(sb);
> 	mutex_unlock(&sbi->alloc_mutex);
> --=20
> 2.37.1
>=20

