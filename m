Return-Path: <linux-fsdevel+bounces-63195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1117BB14D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 18:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6E81925BA1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 16:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A84B2BDC0A;
	Wed,  1 Oct 2025 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e1gkShnm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF511373;
	Wed,  1 Oct 2025 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759337629; cv=none; b=L76d/ARHyVolESwcKeof5MVSwtsQO6+sPwjiOHLgcT+Wm0x0AWO9DyrA+81Psa+Ys7yWjSJmkw01UVnOi0ECA/UFWHS+/x3QPCGS+8WanDrOsFRwSkAk1QutnRZ4M1YfAzOAKPdPftYepYt5dVFCIW6ed4WVof5F6ysnAfD/4ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759337629; c=relaxed/simple;
	bh=P32gxchqra0nGyRnN6ybBTNOyNQvXQZ4xfdZWywRGCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UU6Yigz7qxaRQ8TDCagCZtmTBj+9DTPUy71YchlhvE3q8l8bdrYgfitoxLudln/kAs9uHkmE47bOyOKsBSXoL23NI0SAz2fKinaEOUtimyI+GuA4v8XS0zf7dex06Lm/tMPOlOyMXymyB9IL1mwLqb3Ps0us1oyWf4HL/pSXpD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e1gkShnm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ibzNKx/gRXGnc4tiiG6OxYzIZRUZZP1ZY3ujHEfJkWU=; b=e1gkShnmJaB0Supwo7SgLY7Eqd
	Zvgl2nXKG4JUnkaZJc//qyDKXaWuJoCn05Aezxnvig+xiDZ+kfYoBw6DrShItI4vAskZJxu3/4Bne
	5GiDJzqBotIt9VSbsMZ0MtLDzCqWyjxAh8Pu3L1sbUrXBPbeE091wMJzDGT80NWOhpls0BhJHb1Ot
	px5/Pphug1qdZU7BZikFatZc/WXlq3ySBl4TiYGDvsTdTsnhAgauS92IcIz+drWFQqN4hv7i4C/nv
	xGfDTAUtzLnhIHxN27C2zNDAASIM9dPcLwk4bfLbX8wbZgkr3u58oreBHdvuSNFdVziyV8IN0jWO4
	ZFeetP0g==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v405F-00000008aUQ-1ba1;
	Wed, 01 Oct 2025 16:53:41 +0000
Message-ID: <81c03cb3-5c97-4a6d-bf20-53c5afde2b42@infradead.org>
Date: Wed, 1 Oct 2025 09:53:40 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: doc: Fix typos
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Jonathan Corbet
 <corbet@lwn.net>, Carlos Maiolino <cem@kernel.org>,
 David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-bcachefs@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com
References: <20251001083931.44528-1-bhanuseshukumar@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251001083931.44528-1-bhanuseshukumar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/1/25 1:39 AM, Bhanu Seshu Kumar Valluri wrote:
> Fix typos in doc comments
> 
> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>


Thanks.

> ---
>  Note: No change in functionality intended.
> 
>  Documentation/filesystems/bcachefs/future/idle_work.rst  | 6 +++---
>  Documentation/filesystems/xfs/xfs-online-fsck-design.rst | 2 +-
>  fs/netfs/buffered_read.c                                 | 2 +-
>  fs/xfs/xfs_linux.h                                       | 2 +-
>  include/linux/fs.h                                       | 4 ++--
>  5 files changed, 8 insertions(+), 8 deletions(-)

-- 
~Randy


