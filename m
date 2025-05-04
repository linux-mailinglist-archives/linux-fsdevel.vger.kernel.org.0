Return-Path: <linux-fsdevel+bounces-48009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5753AA88DE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 20:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338D93B71F6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 18:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972FA24678A;
	Sun,  4 May 2025 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="K09RiOCS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DiDCXVU1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D396DCE1
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 May 2025 18:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746382099; cv=none; b=jbhXTROmyUxKvqJVAejKyOCP1w/9J6ZGCSlXPHSaNIYHaBxjrJwRuwJcy61Abm6c0Ml6x59xYjpG3YK6wIDxbkd978ERXfwG+USYB+RxON2MW8FZgDKvEPL6/lz5sWWyY64j2BqDWuw+Yhn9gkIfwcgNqkOclx35PGsQiDq9lig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746382099; c=relaxed/simple;
	bh=KXwTiyTzhsWJQs863Tft5na1CMk+LTLO5j7MPUgVwUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qAe3ynIYOEa/9iGdhJkTo0GfJEgedsaUE8fGZM+wAxT7LZ6fOWejYBf+yRuovv4U0oMdKYf8InrxGA+yyAdlq726yHmQR03gW2BpeXcaSboIy/aa2eS0MA0G9jaCm7bugISSqdi4/vKCG5osi3ON9DXfi8pNl5zJS0mGRnmQH0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=K09RiOCS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DiDCXVU1; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1FE8F13801A0;
	Sun,  4 May 2025 14:08:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 04 May 2025 14:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746382097;
	 x=1746468497; bh=G3vRynudm4zvxfIPuYciiDOvcc/yh7Fp1JhPt3Qf8/Q=; b=
	K09RiOCS9gOA1ZLN/dlzZ3zj0a/r5RiJej+qTKJW5xhN53dsrjbfYjeERpWW/6h9
	g1BPW3pdpI1qxEjIn8+MQA/XZDmin41yoV6C+xgQuArJ6Tu4QMiyauaLvFJyjubG
	GampO2rwt/QTHg91blixGIMOvoBZxtgcVGrBbVbjCbQfPgt0yer+8gUGgPSK1x+b
	r5hKARRK+0QlN8w98Kus/FcOGiuruU/f4PQ34PPWjKGj7DmE8I54CA7N6CMRjXES
	SOYHGrYc/rOkfG4pul9COoKYcDJj2YFcr4WL7Abqbo9OhytpIqQcvsOweki8zksw
	SDMwhFXvN7THTGQ1oKIcUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746382097; x=
	1746468497; bh=G3vRynudm4zvxfIPuYciiDOvcc/yh7Fp1JhPt3Qf8/Q=; b=D
	iDCXVU1B+yYaTScE+pxs52j5nWk2TLEntra1dHSU35en4d1VwEo1qdnUK1O2ZEvQ
	KusBD2JF5h9BpxqO2lmnEW9STZdTJf8/GWCd0kn3wY+tBcCMZ0qC0orysWNU38YM
	TBrRSOJyDNo76MLRHjnqeDbioUYZIMFuUF7hRiTfw4NrKqnsvMl22Dsq+IoMq2G4
	SFjAF++N22lzoi62wBYC8wMkEiWpNDys3c658ElB5qCG1TXZ5xh6tFlbMcLqdID2
	QFxMItD7zQGlcvMP8rBVNVSx3d3DgSGUVuNwfDSyBmO2X+vnIUhll/pWiyLuqc1e
	mcPbVIcCYM5vHJMPsywYA==
X-ME-Sender: <xms:EK0XaLR_HDij4JV8vMfL268vUspMMJQRfyUzQHpVjJnf6zUmDCe8gQ>
    <xme:EK0XaMwzxJjijIL7rIWJnQl3wjGtRQbZW_qF-5RG5BHMpQflDWXUzIQONELHGbuyf
    HtUIKhQTH84yhQQ>
X-ME-Received: <xmr:EK0XaA2ug_Em5R6KKyca8sH3G0QieFCzHJ5VU03mkLZXPbevG1EJuwvg6U3hCUV3PlCrR3aocle3ZNmSnbatY0FS-Xx53dcLtSvECVUCiPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeekkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledt
    udfgtdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggv
    rhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    lhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjvghffhhlvgiguheslh
    hinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehjohhsvghfsehtohigihgt
    phgrnhgurgdrtghomhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:EK0XaLA1UCIUWEzztu4VM_9M-0P2191-o3I1L2gpfqs1bADzCNk0GA>
    <xmx:EK0XaEjA5gaEP7VUGyn0CjYd_8wiWZDfMJFDUgd37F_HjI3_DxZN8w>
    <xmx:EK0XaPoqR3QgZSOKcgfRV5kk0gXK0GWlMYk6lda2zS_WLovIGOuv5w>
    <xmx:EK0XaPh5_0__2rUMvL6rYt7IkACKEYgdv7IEk2gjzqMhqGh2UEF7OQ>
    <xmx:Ea0XaLmr6k56ZHsoUgpELOM3UOlifydlsVFwBcocVPlJVN-bhzUojcz_>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 May 2025 14:08:15 -0400 (EDT)
Message-ID: <352ba650-7e81-4adc-a477-e4a865825e65@fastmail.fm>
Date: Sun, 4 May 2025 20:08:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/11] fuse: refactor fuse_fill_write_pages()
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, jlayton@kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, willy@infradead.org,
 kernel-team@meta.com
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
 <20250426000828.3216220-4-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250426000828.3216220-4-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/26/25 02:08, Joanne Koong wrote:
> Refactor the logic in fuse_fill_write_pages() for copying out write
> data. This will make the future change for supporting large folios for
> writes easier. No functional changes.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Josef Bacik <josef@toxicpandewa.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Bernd Schubert <bschubert@ddn.com>

> ---
>  fs/fuse/file.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index e203dd4fcc0f..edc86485065e 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1132,21 +1132,21 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  	struct fuse_args_pages *ap = &ia->ap;
>  	struct fuse_conn *fc = get_fuse_conn(mapping->host);
>  	unsigned offset = pos & (PAGE_SIZE - 1);
> -	unsigned int nr_pages = 0;
>  	size_t count = 0;
> +	unsigned int num;
>  	int err;
>  
> +	num = min(iov_iter_count(ii), fc->max_write);
> +	num = min(num, max_pages << PAGE_SHIFT);
> +
>  	ap->args.in_pages = true;
>  	ap->descs[0].offset = offset;
>  
> -	do {
> +	while (num) {
>  		size_t tmp;
>  		struct folio *folio;
>  		pgoff_t index = pos >> PAGE_SHIFT;
> -		size_t bytes = min_t(size_t, PAGE_SIZE - offset,
> -				     iov_iter_count(ii));
> -
> -		bytes = min_t(size_t, bytes, fc->max_write - count);
> +		unsigned bytes = min(PAGE_SIZE - offset, num);
>  
>   again:
>  		folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
> @@ -1182,10 +1182,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  		ap->folios[ap->num_folios] = folio;
>  		ap->descs[ap->num_folios].length = tmp;
>  		ap->num_folios++;
> -		nr_pages++;
>  
>  		count += tmp;
>  		pos += tmp;
> +		num -= tmp;
>  		offset += tmp;
>  		if (offset == PAGE_SIZE)
>  			offset = 0;
> @@ -1200,10 +1200,9 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  			ia->write.folio_locked = true;
>  			break;
>  		}
> -		if (!fc->big_writes)
> +		if (!fc->big_writes || offset != 0)
>  			break;
> -	} while (iov_iter_count(ii) && count < fc->max_write &&
> -		 nr_pages < max_pages && offset == 0);
> +	}
>  
>  	return count > 0 ? count : err;
>  }


