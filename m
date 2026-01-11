Return-Path: <linux-fsdevel+bounces-73148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4406D0E237
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 09:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97E6F300A9DC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 08:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13756242D60;
	Sun, 11 Jan 2026 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="lz2C1aWu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEC11E1A3D;
	Sun, 11 Jan 2026 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768119549; cv=none; b=UqwNiAZBVzsn8jH0Ai/R1i2muqZP4TKUuxK682u05cL/wk4+SGZuMLK4GHMPbB1VP4K99clD0QUMLG9qq3KmcpARoALz2H9M9dPtUIBY2UECD203acHce+mhOH0weGMYOMA4QCKOs6n3WWh1TLguCiGpqbwUh3YA9wfpYazi3c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768119549; c=relaxed/simple;
	bh=YGp6KLY0m1gHghmGjNzGpKDQswg8N9aBrCP277LfZM8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=kttz6WP52ZeDVqST3gJ17a8iw2j3HLyxUjEw+D7ocy1GZIO4xcoYxMr9rm/IWhviI5aTWd27rYpsK5a7Be15U61F/pQlBUiLGfTWLpMZu1hPs5weh09vacth19BMumxxky/Gkqj+nhu8lV/T5jkV+VmNqS9mnonN8VS2o2tv97U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=lz2C1aWu; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768119540; x=1768724340; i=markus.elfring@web.de;
	bh=2ShZ8H+r66c2Lf16mcAJt12JhkKDoG0seBv3ijI7pzo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lz2C1aWuSvvGSfyv9dmmVg3CP+WtfpoVVFTsSclaUgcBxglYw6pwa0VtjPpwaES7
	 sT2dkR3UfwVyev8LnZaT/7MXfsx1jpmPgGRnrpI87Y2+hGCfL4R+Sq58sMss6NcD8
	 JjWNP7h98I53EYhGPcNrvoLQCLxIozjV19uuKREz5UaLLbevpkuU8F7qlmcTgf+30
	 PhJnaftlQoZtcdbJ5J8vBh+asLpYlsSaLwcNsyNG1AJX+bHydHAxNb+HO2cEdPrSc
	 o9awPjeNAitFLd+fYiwopYxRICq/kYjCaeIAuI7yTra/frIwyJqVxHPQeH8M7Rjn3
	 M1zV6sOztC1Wi6wGyQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.218]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1My6pf-1w3MYm3EmV-00y43t; Sun, 11
 Jan 2026 09:18:59 +0100
Message-ID: <abb96eb3-49fe-42bf-aae1-a1bf5e7a3827@web.de>
Date: Sun, 11 Jan 2026 09:18:46 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jingbo Xu <jefflexu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org,
 Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260111073701.6071-1-jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v3] fuse: invalidate the page cache after direct write
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260111073701.6071-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MWqauF8qZekiFrwJkCw4AkaBCNrKFP9oL9kGDvEpBizWnMxYpL8
 oj6kokfyQd2i+6V6zUvF2/yynMGhs47HUU69BMltxG1YHRzlUUwFUXjHiwk2NhEXZgA69G6
 KnK8Yd/EJpul5oFpd7wc0lGCF/VnM45et1zKxL8ji/Rr1oSQxW7ep9iEeivBrrWA6rThn4J
 UT8w5Csw7/9Q055Msy1bw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6MBxrabpkH4=;0oda42lwmbi9xIeFwN+RDD6eeBh
 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

=E2=80=A6
> +++ b/fs/fuse/file.c
> @@ -667,6 +667,18 @@ static void fuse_aio_complete(struct fuse_io_priv *=
io, int err, ssize_t pos)
>  			struct inode *inode =3D file_inode(io->iocb->ki_filp);
>  			struct fuse_conn *fc =3D get_fuse_conn(inode);
>  			struct fuse_inode *fi =3D get_fuse_inode(inode);
> +			struct address_space *mapping =3D io->iocb->ki_filp->f_mapping;
> +
> +			/*
> +			 * As in generic_file_direct_write(), invalidate after the
> +			 * write, to invalidate read-ahead cache that may have competed
> +			 * with the write.
> +			 */
> +			if (io->write && res && mapping->nrpages) {
> +				invalidate_inode_pages2_range(mapping,
> +						io->offset >> PAGE_SHIFT,
> +						(io->offset + res - 1) >> PAGE_SHIFT);
> +			}
> =20
>  			spin_lock(&fi->lock);
=E2=80=A6
> @@ -1160,10 +1174,26 @@ static ssize_t fuse_send_write(struct fuse_io_ar=
gs *ia, loff_t pos,
=E2=80=A6
-	return err ?: ia->write.out.size;
> +	/*
> +	 * Without FOPEN_DIRECT_IO, generic_file_direct_write() does the
> +	 * invalidation for us.
> +	 */
> +	if (!err && written && mapping->nrpages &&
> +	    (ff->open_flags & FOPEN_DIRECT_IO)) {
> +		/*
> +		 * As in generic_file_direct_write(), invalidate after the
> +		 * write, to invalidate read-ahead cache that may have competed
> +		 * with the write.
> +		 */
> +		invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT,
> +					(pos + written - 1) >> PAGE_SHIFT);
> +	}
> +
> +	return err ?: written;
=E2=80=A6

You may omit curly brackets at selected source code places.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.19-rc4#n197

Regards,
Markus


