Return-Path: <linux-fsdevel+bounces-45430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C097A77906
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 12:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA953188BFCC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 10:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C551F09B7;
	Tue,  1 Apr 2025 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCYmKVAm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F4D1EDA35;
	Tue,  1 Apr 2025 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743504169; cv=none; b=YPn/k7GBZN83WIXZfvISq9S+lKkY99aDlfYs46BuQV09yXW55UTzwtdMb3O1Gk5/Va/fpyaXQlROthhSKCqZX3ukEU9lnuilgQUkDJoZDrhcQTYRke7tJXdm578Pf23xs0lxkSu2Awtz6Fspzyt/MZCVQ0ixjPw7C+1212MPL1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743504169; c=relaxed/simple;
	bh=BnQ9H+boerjCG/7J12pe8zhoKH2+SFG+Xq9QxpqT3YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2FwwPEHTT+JAPX9PhSAI+b0yjpJfHqwjhvV2higm4OOP2ioaJc0dqvRGuUhSWxMBgNGOc/1CClfATzXw+CV/u0dFtLdWCrVhvO/ngVnu3Ylm4AGfzn8ciGRPQ7JbLsAnnnSBUyIxr/3zxZd5xBntnRZUayboU9/l2nywY2m0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCYmKVAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D281DC4CEE4;
	Tue,  1 Apr 2025 10:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743504169;
	bh=BnQ9H+boerjCG/7J12pe8zhoKH2+SFG+Xq9QxpqT3YE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rCYmKVAmDrJJP3KmHZOIUNkSIjdIEzfKmqzEJ+DjAXmEhL7gjWAzO/E53F0Ind3ST
	 ge7LVCmfJLyKm2oHI7dh3Y4yuwUYG2iqMe/tqOsvd9YJdpff/qKEBbBKAKCl2ML5r3
	 s04hxLIrce/P0M4XEmTJOhIYCRUvJABWmF8OEWxyIjKaDYMX1DqnyqLv/TF4rBKcu0
	 o2boUn2eJPexmD91aQwveXGuqC8Cigp1pwzDORM6HUUqCZWMiGziyqQm7k7o1NGA1s
	 kb1MYJLkULB7DkztJa1HizRLv41BjuSPd0Yvki6ybABK2Eu33qpMzg01cmg62o9kML
	 badHTSg4nmy3Q==
Date: Tue, 1 Apr 2025 12:42:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alejandro Colomar <alx@kernel.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: Document mount namespace events
Message-ID: <20250401-jazzclub-inhuman-979be82cf3c7@brauner>
References: <20250331135101.1436770-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250331135101.1436770-1-amir73il@gmail.com>

On Mon, Mar 31, 2025 at 03:51:01PM +0200, Amir Goldstein wrote:
> Used to subscribe for notifications for when mounts
> are attached/detached from a mount namespace.
> 
> Cc: Jan Kara <jack@suse.cz>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

With the changes pointed out by Miklos and Jan:

Reviewed-by: Christian Brauner <brauner@kernel.org>

Thanks for doing this!

