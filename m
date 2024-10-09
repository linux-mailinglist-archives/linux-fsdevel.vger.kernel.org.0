Return-Path: <linux-fsdevel+bounces-31486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589F69976D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 22:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1EB1C232FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 20:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0308D1E3DCE;
	Wed,  9 Oct 2024 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6VEf0D5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABB01E22F9;
	Wed,  9 Oct 2024 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728506675; cv=none; b=IM8r8Yg1sw1c2lRzm12OTxarhxfgOtup3IrRbAA9PbhifZgk8IqZZ910iAO3Jm7a/6yqvY5oyRTKPEN1NHkHXY/X4klflj7+BNdsGoLk87yqQ+eU8jDeG0gYpr1TDaXx6YFFDDyEjD81/4cLdhmtk4quQTuPxMn6y/bBYFLxAOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728506675; c=relaxed/simple;
	bh=e2Klj4bGTEVjFtcQkmQ0u6yLGsKG8aqb/oFcy/bWooY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQxO4ddzThxnWCoo0hUG9Ji7nLUzXeKYKFxqePa7yarJk8ni1+1bm1nZ4xMmYRXhbylS+FgoUQtjpJEGuLsAtnS6Ho+N88S8Tcd6Ge2YK/4VAsvBgyLJbZAWcZZfjfIKP4fVCOCysPbZoDy1vOgWp64BVGCvgbKif0p85ItZB2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6VEf0D5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A1AC4CEC3;
	Wed,  9 Oct 2024 20:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728506674;
	bh=e2Klj4bGTEVjFtcQkmQ0u6yLGsKG8aqb/oFcy/bWooY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n6VEf0D5E1iEZ6Vm1yPJ3HvCPzh6MYooc367wdgAomq4HFVbttKvWep4UrUi2s3ss
	 yZN+SZES5yaJrwVDvAWDnX9wjXP22RAJw5JQ75HBOpG8uPYgHCqWSm8Nx4pQmce9ql
	 PsEc9aGGFl7v9i/P/SkHxpujQYg1udXbk8YT61EbgH3Iy6rnVpadPUd0k/NeAPV7Xf
	 UM7qY3MH5IPGvA0nZe0trabyOsMv1CG7cSi5ioAKwOrzkaNIUlNTk9pbgCTXmRy1kN
	 5EWT3xxki2qxN6bBivkip8wNBYNDQ17xcvTqzam70n5rsC0kMIfMzkqdv/vGNKMr5M
	 ZR0972FP6ehYA==
Date: Wed, 9 Oct 2024 13:44:33 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] XArray: minor documentation improvements
Message-ID: <20241009204433.GF21836@frogsfrogsfrogs>
References: <20241009193602.41797-2-tamird@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009193602.41797-2-tamird@gmail.com>

On Wed, Oct 09, 2024 at 03:36:03PM -0400, Tamir Duberstein wrote:
> - Replace "they" with "you" where "you" is used in the preceding
>   sentence fragment.
> - Use "erasing" rather than "storing `NULL`" when describing multi-index
>   entries. Split this into a separate sentence.
> - Add "call" parentheses on "xa_store" for consistency and
>   linkification.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  Documentation/core-api/xarray.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
> index 77e0ece2b1d6..d79d4e4ceff6 100644
> --- a/Documentation/core-api/xarray.rst
> +++ b/Documentation/core-api/xarray.rst
> @@ -42,8 +42,8 @@ call xa_tag_pointer() to create an entry with a tag, xa_untag_pointer()
>  to turn a tagged entry back into an untagged pointer and xa_pointer_tag()
>  to retrieve the tag of an entry.  Tagged pointers use the same bits that
>  are used to distinguish value entries from normal pointers, so you must
> -decide whether they want to store value entries or tagged pointers in
> -any particular XArray.
> +decide whether use want to store value entries or tagged pointers in any

"...so you must decide if *you* want to store value entries or..."

> +particular XArray.
>  
>  The XArray does not support storing IS_ERR() pointers as some
>  conflict with value entries or internal entries.
> @@ -52,8 +52,8 @@ An unusual feature of the XArray is the ability to create entries which
>  occupy a range of indices.  Once stored to, looking up any index in
>  the range will return the same entry as looking up any other index in
>  the range.  Storing to any index will store to all of them.  Multi-index
> -entries can be explicitly split into smaller entries, or storing ``NULL``
> -into any entry will cause the XArray to forget about the range.
> +entries can be explicitly split into smaller entries. Erasing any entry
> +will cause the XArray to forget about the range.

n00b question: is xa_store(..., NULL) the same as xa_erase?

If it is, then should the documentation mention that xa_store(NULL) is
the same as xa_erase, and that both of these operations will cause the
xarray to forget about that range?

--D

>  Normal API
>  ==========
> @@ -64,7 +64,7 @@ allocated ones.  A freshly-initialised XArray contains a ``NULL``
>  pointer at every index.
>  
>  You can then set entries using xa_store() and get entries
> -using xa_load().  xa_store will overwrite any entry with the
> +using xa_load().  xa_store() will overwrite any entry with the
>  new entry and return the previous entry stored at that index.  You can
>  use xa_erase() instead of calling xa_store() with a
>  ``NULL`` entry.  There is no difference between an entry that has never
> -- 
> 2.47.0
> 
> 

