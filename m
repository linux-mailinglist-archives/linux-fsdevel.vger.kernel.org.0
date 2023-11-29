Return-Path: <linux-fsdevel+bounces-4161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7817FD108
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 09:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F491C2092F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 08:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EAF125A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="WS0m9G0n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rQPYt4rH"
X-Original-To: linux-fsdevel@vger.kernel.org
X-Greylist: delayed 356 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Nov 2023 23:55:47 PST
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEF91710;
	Tue, 28 Nov 2023 23:55:47 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailnew.nyi.internal (Postfix) with ESMTP id 9064C580A2F;
	Wed, 29 Nov 2023 02:49:50 -0500 (EST)
Received: from imap53 ([10.202.2.103])
  by compute1.internal (MEProxy); Wed, 29 Nov 2023 02:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701244190; x=1701251390; bh=ww
	kE8lsdD1lmCvJ6vHeRL3ETi3+Yj2miubjiEiAIJqc=; b=WS0m9G0nx6dD9iEji/
	fBqlaAFY/rMIvdHqXU7tZxzaCT6/WaZqN24lhBSrCWbph5RWVn8OG0wIE3vLDiA7
	dOWPtjwm4K1LXbVSgViqbhQnGAqsI7zVo/p5C5Cc2lkcP6BvkMMbJJPRLlk6Obqn
	AHfiWue+I4lT9KO4M5IqOwcDkJ9k3rIoOQzzkgfdeVW+FPwIkWR8otEXHsC4vN5M
	YRFUR7qjaXjm+/zVf+gwWpzm9l6TfNicjYV48mg69Jf51d7lmUwmWy0QDMagwX+h
	my8WMJddQ84zOCl6wx49JlxbWBkrLfSX8dsYvVyefTTM6PDNHjgdqGvgdPI98pTh
	CeVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701244190; x=1701251390; bh=wwkE8lsdD1lmC
	vJ6vHeRL3ETi3+Yj2miubjiEiAIJqc=; b=rQPYt4rH1AA0LiTAAnJGE//YvqNCw
	0qwLht7gsUZGiRgP8vOuUojrK3gXdkIqqQy8kh1RU6M48Z+Q1F0tnQhr+VVyl2w5
	NmyzspDEFgY404mNlejNyplFYnmca/DQjbd3xvYN1Ln64vKHdITrMssLqBon8Ujn
	P7Qb4qPDUzh92GrFKk6+AzOXk04amTS8z6iqjc442y/87PjOdgE3r4Ts0YSlpbOW
	dquGLaB3VxWfcHpWrswAQY2/Rw9xn8Jq2WVIEzpZjj1/JtoUjjzbJm94BlKfxFeu
	aDZFAe2s9qDxCwDO/RDxvPYqUWrMro5Rq5vNlH5XTTV2LcBscKUpE50kw==
X-ME-Sender: <xms:HO1mZWwi-0PHwgZ7UGdDg2Nfu1cPQBmbtYZcjowlgAyQ0BQky2hXjA>
    <xme:HO1mZSTMYD4qqQdTonZ8IGVDTRfv30PWEOnWS8uEzYlouq8tMUIbuyDbZitdKhK-h
    lPnAf3-fMz25n81ToA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeigedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedflfgr
    nhhnvgcuifhruhhnrghufdcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepteeugeeltdelffetleetudejgfejieegudekleekleeifffffefgfefgfeeukeef
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjh
    grnhhnrghurdhnvght
X-ME-Proxy: <xmx:HO1mZYWbL-dzWpMIvCrcF_hkcPxVblMr6At8rrdkDOd5QKecybyP8A>
    <xmx:HO1mZcghfi5RLWq0pFjhso2VXNF7V40Fof9Xj8XlOYXvC_owwh5wlQ>
    <xmx:HO1mZYDWse66_RKIUSsZ-t0CzxR6dHcZEVv_0jTO_L-qPjoGwVzSYQ>
    <xmx:Hu1mZerEKP658mX4LK_6tKFnkmAWe_WKTSc7PfS_s-S-h8Msb1Q_lw>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5DF0E3640069; Wed, 29 Nov 2023 02:49:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ca7a025d-8154-4509-b8ab-2a17e53ccbef@app.fastmail.com>
In-Reply-To: <20231128204938.1453583-5-pasha.tatashin@soleen.com>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-5-pasha.tatashin@soleen.com>
Date: Wed, 29 Nov 2023 08:49:18 +0100
From: "Janne Grunau" <j@jannau.net>
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
 alex.williamson@redhat.com, alim.akhtar@samsung.com,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
 "Lu Baolu" <baolu.lu@linux.intel.com>, bhelgaas@google.com,
 cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com,
 "David Woodhouse" <dwmw2@infradead.org>, hannes@cmpxchg.org,
 heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com,
 jernej.skrabec@gmail.com, jgg@ziepe.ca, jonathanh@nvidia.com,
 "Joerg Roedel" <joro@8bytes.org>, "Kevin Tian" <kevin.tian@intel.com>,
 krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
 "Hector Martin" <marcan@marcan.st>, mhiramat@kernel.org, mst@redhat.com,
 m.szyprowski@samsung.com, netdev@vger.kernel.org, paulmck@kernel.org,
 rdunlap@infradead.org, "Robin Murphy" <robin.murphy@arm.com>,
 samuel@sholland.org, suravee.suthikulpanit@amd.com,
 "Sven Peter" <sven@svenpeter.dev>, thierry.reding@gmail.com,
 tj@kernel.org, tomas.mudrunka@gmail.com, vdumpa@nvidia.com,
 virtualization@lists.linux.dev, wens@csie.org,
 "Will Deacon" <will@kernel.org>, yu-cheng.yu@intel.com
Subject: Re: [PATCH 04/16] iommu/io-pgtable-dart: use page allocation function provided
 by iommu-pages.h
Content-Type: text/plain

Hej,

On Tue, Nov 28, 2023, at 21:49, Pasha Tatashin wrote:
> Convert iommu/io-pgtable-dart.c to use the new page allocation functions
> provided in iommu-pages.h.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  drivers/iommu/io-pgtable-dart.c | 37 +++++++++++++--------------------
>  1 file changed, 14 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/iommu/io-pgtable-dart.c b/drivers/iommu/io-pgtable-dart.c
> index 74b1ef2b96be..ad28031e1e93 100644
> --- a/drivers/iommu/io-pgtable-dart.c
> +++ b/drivers/iommu/io-pgtable-dart.c
> @@ -23,6 +23,7 @@
>  #include <linux/types.h>
> 
>  #include <asm/barrier.h>
> +#include "iommu-pages.h"
> 
>  #define DART1_MAX_ADDR_BITS	36
> 
> @@ -106,18 +107,12 @@ static phys_addr_t iopte_to_paddr(dart_iopte pte,
>  	return paddr;
>  }
> 
> -static void *__dart_alloc_pages(size_t size, gfp_t gfp,
> -				    struct io_pgtable_cfg *cfg)
> +static void *__dart_alloc_pages(size_t size, gfp_t gfp)
>  {
>  	int order = get_order(size);
> -	struct page *p;
> 
>  	VM_BUG_ON((gfp & __GFP_HIGHMEM));
> -	p = alloc_pages(gfp | __GFP_ZERO, order);
> -	if (!p)
> -		return NULL;
> -
> -	return page_address(p);
> +	return iommu_alloc_pages(gfp, order);
>  }
> 
>  static int dart_init_pte(struct dart_io_pgtable *data,
> @@ -262,13 +257,13 @@ static int dart_map_pages(struct io_pgtable_ops 
> *ops, unsigned long iova,
> 
>  	/* no L2 table present */
>  	if (!pte) {
> -		cptep = __dart_alloc_pages(tblsz, gfp, cfg);
> +		cptep = __dart_alloc_pages(tblsz, gfp);
>  		if (!cptep)
>  			return -ENOMEM;
> 
>  		pte = dart_install_table(cptep, ptep, 0, data);
>  		if (pte)
> -			free_pages((unsigned long)cptep, get_order(tblsz));
> +			iommu_free_pages(cptep, get_order(tblsz));
> 
>  		/* L2 table is present (now) */
>  		pte = READ_ONCE(*ptep);
> @@ -419,8 +414,7 @@ apple_dart_alloc_pgtable(struct io_pgtable_cfg 
> *cfg, void *cookie)
>  	cfg->apple_dart_cfg.n_ttbrs = 1 << data->tbl_bits;
> 
>  	for (i = 0; i < cfg->apple_dart_cfg.n_ttbrs; ++i) {
> -		data->pgd[i] = __dart_alloc_pages(DART_GRANULE(data), GFP_KERNEL,
> -					   cfg);
> +		data->pgd[i] = __dart_alloc_pages(DART_GRANULE(data), GFP_KERNEL);
>  		if (!data->pgd[i])
>  			goto out_free_data;
>  		cfg->apple_dart_cfg.ttbr[i] = virt_to_phys(data->pgd[i]);
> @@ -429,9 +423,10 @@ apple_dart_alloc_pgtable(struct io_pgtable_cfg 
> *cfg, void *cookie)
>  	return &data->iop;
> 
>  out_free_data:
> -	while (--i >= 0)
> -		free_pages((unsigned long)data->pgd[i],
> -			   get_order(DART_GRANULE(data)));
> +	while (--i >= 0) {
> +		iommu_free_pages(data->pgd[i],
> +				 get_order(DART_GRANULE(data)));
> +	}
>  	kfree(data);
>  	return NULL;
>  }
> @@ -439,6 +434,7 @@ apple_dart_alloc_pgtable(struct io_pgtable_cfg 
> *cfg, void *cookie)
>  static void apple_dart_free_pgtable(struct io_pgtable *iop)
>  {
>  	struct dart_io_pgtable *data = io_pgtable_to_data(iop);
> +	int order = get_order(DART_GRANULE(data));
>  	dart_iopte *ptep, *end;
>  	int i;
> 
> @@ -449,15 +445,10 @@ static void apple_dart_free_pgtable(struct 
> io_pgtable *iop)
>  		while (ptep != end) {
>  			dart_iopte pte = *ptep++;
> 
> -			if (pte) {
> -				unsigned long page =
> -					(unsigned long)iopte_deref(pte, data);
> -
> -				free_pages(page, get_order(DART_GRANULE(data)));
> -			}
> +			if (pte)
> +				iommu_free_pages(iopte_deref(pte, data), order);
>  		}
> -		free_pages((unsigned long)data->pgd[i],
> -			   get_order(DART_GRANULE(data)));
> +		iommu_free_pages(data->pgd[i], order);
>  	}
> 
>  	kfree(data);

Reviewed-by: Janne Grunau <j@jannau.net>

Janne

