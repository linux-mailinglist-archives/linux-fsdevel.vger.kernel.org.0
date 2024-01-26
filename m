Return-Path: <linux-fsdevel+bounces-9073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FFB83DDD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 16:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31DDE1F23EB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 15:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848B61D527;
	Fri, 26 Jan 2024 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WccHJS4W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27F21CF83;
	Fri, 26 Jan 2024 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283851; cv=none; b=OAw9a6eNGGFfMj7Rs/zoEbeaPTksahmgtPHzwmbsBN5X2fwZhnoh8bx+WKevMcXVIveQ3urEOUKyu0IwlEEvHMHRHTILZ617XNFrlmcy0dpPwJyDtrHeyFGJ0CKb+XzecvajlHSYG20Lu7lmsk4GSB+g73mgne5BBRQaLh0PNM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283851; c=relaxed/simple;
	bh=brNlmY8FBBoG1pRnDgmAVUL934+gYDoIoH9YKHrDslI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnSdfkVFMcyJlMaSRHCFkdd2LwzXH61WEshezLE6PT7YDmVYGmwsO39y80ODHrS5QSBMiHN3DaJl/rBtWZYeL3Qd0J+uGC0I0G8G5O/yg00VPyzhNsQiSAhVsT4+qBb9P/VYEHENODbLkjTLeN6m4KkL12pdlErB/s9xFUoeZRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WccHJS4W; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5sAJdn4jk6uOExNJkIgQ6yblhOQNUqCx9dZeB9veMk8=; b=WccHJS4WCZJNyhyM3avRTIy384
	o1th7NWeVW63DpvSyN1LVzSSjUAL7JustXskBwors5aQI6ntBjwrhXYCUPrn1GriNPJCsAnckCRJ7
	ayHTqWp03PXHUUO4y3sEPk7p/UOgjQJYNhctjMgJyjCi5uGcHd9EdFWBrYtDyPZBGbjIg09cCF2B5
	r8HIkXfOYus80VbR9vlshNjDxe3EDNQPLIMywKDA/xlOhYllT+71+gNUWWGr2cMPdmfdlobqpuG+g
	/8fzHf5gj5ctRpI17ploATz3hIJEY5RUageOfskPeHzDUxD9Hg9zkAe9JxACiE/s43QKTk9/mhkJt
	zLx76i9Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTOND-00000004ZNq-1uHp;
	Fri, 26 Jan 2024 15:44:07 +0000
Date: Fri, 26 Jan 2024 07:44:07 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: j.granados@samsung.com
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] MAINTAINERS: Update sysctl tree location
Message-ID: <ZbPTRwTou8B3ZL9I@bombadil.infradead.org>
References: <20240126-for-6-8-v1-1-9695cdd9f8ef@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126-for-6-8-v1-1-9695cdd9f8ef@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Jan 26, 2024 at 12:53:10PM +0100, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
> 
> To more efficiently co-maintain the sysctl subsystem a shared repository
> has been created at https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git
> and the sysctl-next branch that Luis Chamberlain (mcgrof@kernel.org) maintained at
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-next
> has moved to the shared sysctl-next branch located at
> https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/log/?h=sysctl-next.
> This commit changes the sysctl tree in MAINTAINERS to reflect this change.
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..adf69ab891e0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17616,7 +17616,7 @@ M:	Joel Granados <j.granados@samsung.com>
>  L:	linux-kernel@vger.kernel.org
>  L:	linux-fsdevel@vger.kernel.org
>  S:	Maintained
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git sysctl-next
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git sysctl-next

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

