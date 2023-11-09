Return-Path: <linux-fsdevel+bounces-2508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2747E6B45
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 14:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB83B20E80
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 13:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBE81DFF0;
	Thu,  9 Nov 2023 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJfqTWhE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9131DFC7
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 13:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3054DC433C7;
	Thu,  9 Nov 2023 13:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699536819;
	bh=6Vk3/DLOFNVgp/SoPscCIBkIHjdbH9903S9VxoPydvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fJfqTWhE0QGcz0EbFmsbcvMxtwsvqzUf4I3InY2fB0iTWeIvMXjxwPk3chi6F1nEa
	 oL6Q86Gg877YCKgwmNiS9knDk8cvEC3H7/mNjlg2BbUQ5BsIPqqU3OAcuey+e2eoaB
	 9cEAvE9mF7pk4jiwA4/SC1VFsvFI9bOFbLGFDEOZgR/n4db9fh8mzsHga+lvK58usX
	 jsDZdnSR0YtlsWPjfGytgi+hgjFPeW7b3qccgmNAccwpRM7IfnGBoY7fkQRVJGh00G
	 yetGYdUnQsqhnlzYlWqV6B/K4sXUu4lUo6Sxn6OBfnHOrHhL8WgP5S99rQFJKRdL5W
	 qrHZNZSMyEYiw==
Date: Thu, 9 Nov 2023 14:33:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/22] struct dentry: get rid of randomize_layout idiocy
Message-ID: <20231109-bissfest-proletarisch-d9d34117eb82@brauner>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109062056.3181775-1-viro@zeniv.linux.org.uk>

On Thu, Nov 09, 2023 at 06:20:35AM +0000, Al Viro wrote:
> This is beyond ridiculous.  There is a reason why that thing is
> cacheline-aligned...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Yeah, lenient annotation with this stuff makes a bunch of structures
with carefully chosen layouts pretty meaningless.

The thing is that it doesn't matter for most cases as every regular
distro afaict sets CONFIG_RANDSTRUCT_NONE=y which means layout
randomization isn't applied.

In any case,
Reviewed-by: Christian Brauner <brauner@kernel.org>

