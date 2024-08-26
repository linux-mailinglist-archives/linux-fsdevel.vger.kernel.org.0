Return-Path: <linux-fsdevel+bounces-27230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1037295FA61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 22:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC251C21F6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 20:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28A2199E9F;
	Mon, 26 Aug 2024 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gchhyvNc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D039824BB;
	Mon, 26 Aug 2024 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702886; cv=none; b=Y3YvxCNa/Oq4iZQPFZ/oGsRkbNdPg/cBaexBQl1zyqQl8U7/oNB2PjWV8ItjL0Da/r7uQphlO206zm8Fg7tC/drebSMGY+wzxJHy3BZNiheMYYeyTPcMLASV5KxQYev9G09f7Rck2/Yo6EF5XA1bneba4P/Sh2B0r1GHNxAFJF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702886; c=relaxed/simple;
	bh=vDvvgp+txOyPsIguFMIiO4KR+nmBRNihIrQLqrAgMy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqGztADbi6Pt4fdXEonwl4E+y7XYvqa73zzSTC8T/fIfIen1fdNaUo3Tx8t7WuponiYk9+x7otS3CcnJ7BWzkXx6WduOIq6XLKG41evNFnnDlY9qSLZQnEdXibLrJR9SPjSVUCF2YbEd4qGXMlhwjfjffGJJ2wX20lkTaOu0wOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gchhyvNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5724C8B7AA;
	Mon, 26 Aug 2024 20:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724702885;
	bh=vDvvgp+txOyPsIguFMIiO4KR+nmBRNihIrQLqrAgMy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gchhyvNc1VF/l6IS2hqcDNcCf0+3xp8ZzQMcQPPj8IPVVRiPBizxQ5aSDPLyrqRM8
	 TciptEcFqnfUB3O+zpSTNMcj+O1WkO5JBdamz2EBaVIH+a1TLHp1PHmSwovksXiet/
	 wMh+Mqk4RGl9vbdJ1pPCHdgm0df/DUHfbLXCCSRAsVwnzUqu1E6otKTRMSpAkWcsjZ
	 alOqyvr1jmjW0YuXRn+7xlX6Q/bfq8F5clXWXPDdp31rWCn7MjE91XccNDgxry8gun
	 hutcyvRdxWXUDyfpuRR/1Rm7B4fPftJlBo3/UxV3czPmOSqbT8StYXTBsvsdGwU2+i
	 ne0Mlcre+DZmg==
Date: Mon, 26 Aug 2024 13:08:05 -0700
From: Kees Cook <kees@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: dsterba@suse.com, gustavoars@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] affs: Remove unused struct members in affs_root_head
Message-ID: <202408261307.F7D2AD650@keescook>
References: <20240826142735.64490-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826142735.64490-2-thorsten.blum@toblux.com>

On Mon, Aug 26, 2024 at 04:27:36PM +0200, Thorsten Blum wrote:
> Only ptype is actually used. Remove the other struct members.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  fs/affs/amigaffs.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/fs/affs/amigaffs.h b/fs/affs/amigaffs.h
> index 1b973a669d23..9b40ae618852 100644
> --- a/fs/affs/amigaffs.h
> +++ b/fs/affs/amigaffs.h
> @@ -49,12 +49,6 @@ struct affs_short_date {
>  
>  struct affs_root_head {
>  	__be32 ptype;
> -	__be32 spare1;
> -	__be32 spare2;
> -	__be32 hash_size;
> -	__be32 spare3;
> -	__be32 checksum;
> -	__be32 hashtable[1];
>  };

This is removing documentation, in a way. Since I suspect you were
looking at this due to hashtable, maybe just change that to [] and note
that it (and the other fields) aren't used, but they're kept around to
help document the format.

-- 
Kees Cook

