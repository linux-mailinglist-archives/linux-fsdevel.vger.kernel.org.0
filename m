Return-Path: <linux-fsdevel+bounces-2605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561867E7014
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 18:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3B61C20BDF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 17:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AFC22335;
	Thu,  9 Nov 2023 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hs447+pC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54DF22327
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 17:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EC0C433C8;
	Thu,  9 Nov 2023 17:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699550537;
	bh=TxusjNzr1qnUBwQbc1H1S698ALn7JboDDOpl/9tB2mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hs447+pCLNebOla+JdpQlvjnquEZt4PV7ECN7juX+tpTVWK8qI/hnOn5XaWyuZWs7
	 tCbJRD1JQ8yQdx4GKwwg1rvU/OXBkX7QE8cdqzFi6iHWjrmYGmil5uiCFV/p7AAn0U
	 9I1uOZO9ISu6ZxKWeGBQD70uS6MecLfbjDtSMkgu9sJhbnFWTvXb2CmLZ9xzMTyFMr
	 sHhh1/LLsxogjfGVH/z/aTNYK+w3BV6bSfOxp+1tTJuGOXViDtKyXrB1Hwq23clRkN
	 Iyh8ccTCsz5lUU/Oa3PZ2ELDg37vc9XfzUIhTajOqfxCFflTyDTn7G0DMKLC7hFaPG
	 fyWn30z//Sz2Q==
Date: Thu, 9 Nov 2023 18:22:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/22] fold dentry_kill() into dput()
Message-ID: <20231109-helium-attribut-ddb02c7bd22c@brauner>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-18-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109062056.3181775-18-viro@zeniv.linux.org.uk>

On Thu, Nov 09, 2023 at 06:20:52AM +0000, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

