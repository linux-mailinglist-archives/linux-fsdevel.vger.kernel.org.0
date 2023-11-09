Return-Path: <linux-fsdevel+bounces-2532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A611E7E6D3D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F1F281098
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C38200D7;
	Thu,  9 Nov 2023 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pl3g6p4a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFBB1CA9D
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D528C433C8;
	Thu,  9 Nov 2023 15:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699543303;
	bh=Ic4i/j3TKxwxvY34WskpkHyqWy6I+mO/MPiO9MRoREE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pl3g6p4acumCCP3tS4h/k1DtBDgdIUS2Mtxqp2M2N/4HOW/GTsWKI2KQvO3uEscBC
	 3SsAflWB5rz53vhhifCFWYE6MFGbap3AndHf/jB2aGgPA5OfMyT4VSQcAINxXhvHZw
	 GU3BTFcvcnKcz6QOGCO85w5X599u9DTpJDSQS71IfcHmwF8uuIBVWyJuFEIoF2DQFH
	 c7Kvov1oeP/WsR1OLweIA9mamhp3gvq5Y0J228SuN5c0LYivl3i29lM25iWlbl4qY6
	 s9AV5W6dbMkr/KgQt3W3qz51J8nypS4K1s5xcYIkVymUa8jeMgxkMpgqjFBUtrQ6np
	 UwGxhpEDBjGCw==
Date: Thu, 9 Nov 2023 16:21:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/22] __dput_to_list(): do decrement of refcount in the
 callers
Message-ID: <20231109-betrug-neugierig-4d5d20ce9156@brauner>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-11-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109062056.3181775-11-viro@zeniv.linux.org.uk>

On Thu, Nov 09, 2023 at 06:20:45AM +0000, Al Viro wrote:
> ... and rename it to to_shrink_list(), seeing that it no longer
> does dropping any references
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

