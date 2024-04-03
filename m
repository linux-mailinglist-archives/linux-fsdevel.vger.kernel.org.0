Return-Path: <linux-fsdevel+bounces-16042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B028973A9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 17:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C2C287EA5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 15:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8D514AD1A;
	Wed,  3 Apr 2024 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="Teetk3dJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83314149C68;
	Wed,  3 Apr 2024 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712157077; cv=none; b=uRDL6zYqYytWimYypl8GkZACEtP+lqlWPRdCb8Cn9RYxKCBTWA6wIa2H1oxi1s/FVIYQQdNQQyTzQG64610quSlBv7Nj8NKzSpyAybgs+PGwDa/d7ovX8xqHWBe80/7YyPw+zpAqywIwBdAhKeq0u5X4Vm16ClWi9urxxPU5zBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712157077; c=relaxed/simple;
	bh=Odp4+WIqG+c5wEGAPagzT5gQT9nbqeYbXQ72Yo9uYoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jZJr+0ZqewlybuZ4QE5pZl1pu1aqbZoZUgRZaYKOBvHi4gwMzLT3kTCB0qoJpABC35I/7cG29pGw9OcK+a582/SmzZDH2FnZJgeJDXCIJbwA25esOViIYa53uzTVYdNy/rc09cA76F9f9qlGn+OLfvU6IoSePwZHstU7qQxWHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=Teetk3dJ; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 9E9A98068F;
	Wed,  3 Apr 2024 11:11:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1712157074; bh=Odp4+WIqG+c5wEGAPagzT5gQT9nbqeYbXQ72Yo9uYoU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Teetk3dJDqxv6IZpDiiE1yqMyVo5lpVBmpgKIoGsMvJlhe8wzCtov+FNZhHMh+u0n
	 C/T7oYMSweYLdhjMkxpI6SH5+rA2lve24BIZK0OhqRuRHxjfIvhNWBDTPznhBLdSzL
	 fc0Pdt0ULyDDbIMhpRN1H8L96QO+2HsyNsInfp/Pa5rIHZkOmjDSiW5LoEO/kyVYQ/
	 H7wKdTnealHMtxs/uFpdatUzptr69ZSg1HxBKob5KrqVXE6plX3QCQ7bfA03wD1u5V
	 FjDjF6goAehukPPNrJKmem+Xbg74zfrABmSH2VfH/I7WhoioqV3Xn2EhaWzKg7uaz5
	 KXmaIVLa4y0ew==
Message-ID: <2896ee5a-b381-45eb-abc0-54e914605e46@dorminy.me>
Date: Wed, 3 Apr 2024 11:11:10 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 00/13] fiemap extension for more physical information
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Jonathan Corbet
 <corbet@lwn.net>, Kent Overstreet <kent.overstreet@linux.dev>,
 Brian Foster <bfoster@redhat.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 kernel-team@meta.com
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
 <dce83785-af96-4ff8-9552-56d73b5daf98@linux.alibaba.com>
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <dce83785-af96-4ff8-9552-56d73b5daf98@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> 
> I'm not sure why here iomap was excluded technically or I'm missing some
> previous comments?
> 
> 
> Could you also make iomap support new FIEMAP physical extent information?
> since compressed EROFS uses iomap FIEMAP interface to report compressed
> extents ("z_erofs_iomap_report_ops") but there is no way to return
> correct compressed lengths, that is unexpected.
> 

I'll add iomap support in v4, I'd skipped it since I was worried it'd be 
an expansive additional part not necessary initially. Thank you for 
noting it!

Sweet Tea

