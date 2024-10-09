Return-Path: <linux-fsdevel+bounces-31495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 690C0997775
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 23:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146991F232A2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 21:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E861E2841;
	Wed,  9 Oct 2024 21:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5/KnvYN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78811885BF;
	Wed,  9 Oct 2024 21:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728509140; cv=none; b=gy1k77N5P/xDZV7xz+Uk9WHSVgxwS8dgYz2I384i1rJH475zLvQqtWqq4BzlNxAlwGr6BNZUOQPnDL+WPvGKs1w+UXGq+eQV//dr9zoGsGkfi3F6eM7TzFIrpFRGexOiJ8cJtaeRx4xyp40sKzU+YmGK06uhZSDPnGRtK6iZiPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728509140; c=relaxed/simple;
	bh=oq7it/tBoxVfX5zXymvTWS15B74hVD8eo/0w703epQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lToTXTM5kNypv7/3EbfTsQ0y3/YwDKPKITiF2c4Dxsr4bjBpcoeY5WUlNXDJT2wQm4XQf8pp4UBV2za2ZsPp3UI3tcW1+Lo/rR/809KN3v4j41bv7MYqSxOqQ/oj8DVU/M3BlTeSJz2sWvqi6taPyVXe4y2gDcLP88hl85hdrRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5/KnvYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5730C4CECC;
	Wed,  9 Oct 2024 21:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728509140;
	bh=oq7it/tBoxVfX5zXymvTWS15B74hVD8eo/0w703epQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S5/KnvYNrLg++QlWKethzkwCyccAWlQVNBj+8WIaUQHIwX3JiHVxkkxLe64Svu4Kh
	 RtIdGDx7Qc6tc9ghtltaN9/kBHk777DBWlxiwIEhzWC9JjLtwWo4+Bbass3N4KbPwv
	 LSPM+3roeeNF6KYP/bUfzJYAAxWgH1BHYNzZff7iuNqsg/GV5atFDQ+iQ9gWWRYxq3
	 Z6VWhsDqvDR/6QI6Yf9CnfEwcdMtMEA4SfrtVBmkVnfKs9XL8Xhvp+5C97p5P+fO/B
	 6xOKkb8XEaM4hgkhNP/kL+6FfKhtVYEZI4AnQOXVGjvJM0MHB1rKMQE0+zDP4KiT5Z
	 mqGCvgFRLyzqQ==
Date: Wed, 9 Oct 2024 14:25:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] XArray: minor documentation improvements
Message-ID: <20241009212540.GG21836@frogsfrogsfrogs>
References: <CAJ-ks9kiAH5MYmMvHxwH9JfBdhLGA_mP+ezmZ8wJOzDY1p7o5w@mail.gmail.com>
 <20241009205237.48881-2-tamird@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009205237.48881-2-tamird@gmail.com>

On Wed, Oct 09, 2024 at 04:52:38PM -0400, Tamir Duberstein wrote:
> - Replace "they" with "you" where "you" is used in the preceding
>   sentence fragment.
> - Use "erasing" rather than "storing `NULL`" when describing multi-index
>   entries. Split this into a separate sentence.
> - Add "call" parentheses on "xa_store" for consistency and
>   linkification.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

/me reads about XA_FLAGS_ALLOC and is ok with this now.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
> V1 -> V2: s/use/you/ (Darrick J. Wong)
> 
>  Documentation/core-api/xarray.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
> index 77e0ece2b1d6..75c83b37e88f 100644
> --- a/Documentation/core-api/xarray.rst
> +++ b/Documentation/core-api/xarray.rst
> @@ -42,8 +42,8 @@ call xa_tag_pointer() to create an entry with a tag, xa_untag_pointer()
>  to turn a tagged entry back into an untagged pointer and xa_pointer_tag()
>  to retrieve the tag of an entry.  Tagged pointers use the same bits that
>  are used to distinguish value entries from normal pointers, so you must
> -decide whether they want to store value entries or tagged pointers in
> -any particular XArray.
> +decide whether you want to store value entries or tagged pointers in any
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
>  
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

