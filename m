Return-Path: <linux-fsdevel+bounces-186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7AE7C714A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 17:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647E6282A9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 15:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19032273D5;
	Thu, 12 Oct 2023 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pC6SWNXc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573C8BA3C
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF68C433C7;
	Thu, 12 Oct 2023 15:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697123974;
	bh=U4AKeNaF72XkPR09CAo/CmamDqWb5tGZteAAH165Ed4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pC6SWNXcIyGXxi6ZJ65IXuqq3wuDy1vJy4qGCh+U3SW7ug9rG4/uC/0AZP1Jrgu3B
	 3cG5AzKKlsWK82pW2IbiD+iQ1CrbYXyX4MwYptTHrSoh31wjPWljy2AHCIpN9FA8f3
	 8aOcNpku4J3h/WXwBMLXozQfoa7QIy37n5HM18X0mLO4xaryo4fXlE4+S3Jgb4az8X
	 KMAnVlzX6Y3QUk/TD1ZX4e+iZncSHp/m/dGLg4hD1ZuvujM/OyrPW9WlmhctdjlARr
	 T3stQwfCmANYAc9SPVQ02Hn6BpN09q9/wREdcmBoLRWM0NXcdZFRPpa+F/fOpqGX4L
	 XCL+jMh1SXQ7A==
Date: Thu, 12 Oct 2023 17:19:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: factor out vfs_parse_monolithic_sep() helper
Message-ID: <20231012-anweisen-aufpeppen-8f750ad5a4bd@brauner>
References: <20231012134428.1874373-1-amir73il@gmail.com>
 <20231012134428.1874373-2-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231012134428.1874373-2-amir73il@gmail.com>

On Thu, Oct 12, 2023 at 04:44:27PM +0300, Amir Goldstein wrote:
> Factor out vfs_parse_monolithic_sep() from generic_parse_monolithic(),
> so filesystems could use it with a custom option separator callback.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Christian,
> 
> If you can ack this patch, I'd rather send it to Linus for 6.6-rc6,
> along with the two ovl option parsing fixes.

Sounds good to me.
Acked-by: Christian Brauner <brauner@kernel.org>

