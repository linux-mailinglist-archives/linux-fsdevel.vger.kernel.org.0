Return-Path: <linux-fsdevel+bounces-46270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CB7A8605D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DF54C2214
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 14:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D721F4612;
	Fri, 11 Apr 2025 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tl+2BTGX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E8A2367D1;
	Fri, 11 Apr 2025 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381054; cv=none; b=h451UjEuRYB/KRXMR/DVxKtgx/Yz4IfUMNvhDp50/tRTmnz4Qebt3aPVX4BlFGbs6RWDQOyldf82fyqMDdCJggjclI4trtlYe6QXaSeMFbr7Upz74IJgfTfpMVKbCJToxSX1i1Ins/arX5qLRjSUGJ/YY3VD1NK+g7tFZuWmKiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381054; c=relaxed/simple;
	bh=Ngg553Xud16ioALvkyjTLB97U7YGnmT2MEQ1j9nB8BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSNr7toOrK0aPOkUB52KB3TwEmM6EAo6HKb7ytjjUOXrx1jLiSucIbNiil9d0Bsw4dZ3Bwx4lTFSnkASkAkUGzMYnPKYKN3yWe33U/V9QPADZCMCrqs80N1cGuPpLO6Mng+Aja4r9ioK6p+jHJMYYo/1ZA0FK7eWNvS6BFU0zS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tl+2BTGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991F1C4CEE2;
	Fri, 11 Apr 2025 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744381053;
	bh=Ngg553Xud16ioALvkyjTLB97U7YGnmT2MEQ1j9nB8BI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tl+2BTGX2qwcpvSldP95TPxWmCdTnLquFOwjoJWEXmDkBUlQYjpdenBx3jjG0qLpm
	 rKwwBgumA4SZUS73r9fcSFMY7y5KJrJwap2pT8XFdACJlIEd/b0zKunrvsqvVAoXxt
	 9IFswAw0PNNeUuVuZIhvUqB36407qoxzARWCyUR+20Cz7Iy5BvoC+ESOw+0hYWu0+Q
	 mb6Xkd5nfsdTxNu4q3Hk8rWofkT+L+S/wk1XUMCvXM9bLdpWLu3f7UITDhPFsTlEzP
	 fIjcRPmCCYfnvA0TMfO6Xgxj+jtQTL+aiNByDYkTLRefvE4hdOtHcWITcWl9k7sIH0
	 P20JAPvWgiqwA==
Date: Fri, 11 Apr 2025 16:17:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH 2/5] fs/fs_parse: Fix macro fsparam_u32hex() definition
Message-ID: <20250411-kinokarten-umweltschutz-6167b202db91@brauner>
References: <20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com>
 <20250410-fix_fs-v1-2-7c14ccc8ebaa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250410-fix_fs-v1-2-7c14ccc8ebaa@quicinc.com>

On Thu, Apr 10, 2025 at 07:45:28PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Macro fsparam_u32hex() uses as type @fs_param_is_u32_hex which is
> never defined.
> 
> Fix by using @fs_param_is_u32 instead as fsparam_u32oct() does.
> 
> Fixes: 328de5287b10 ("turn fs_param_is_... into functions")
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  include/linux/fs_parser.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
> index 53e566efd5fd133d19e313e494b975612a227b77..ca76601d0bbdbaded76515cb6b2c06fa30127a06 100644
> --- a/include/linux/fs_parser.h
> +++ b/include/linux/fs_parser.h
> @@ -126,7 +126,7 @@ static inline bool fs_validate_description(const char *name,
>  #define fsparam_u32oct(NAME, OPT) \
>  			__fsparam(fs_param_is_u32, NAME, OPT, 0, (void *)8)
>  #define fsparam_u32hex(NAME, OPT) \
> -			__fsparam(fs_param_is_u32_hex, NAME, OPT, 0, (void *)16)
> +			__fsparam(fs_param_is_u32, NAME, OPT, 0, (void *)16)

Remove that define completely as it's unused. There's no point keeping
dead code around.

