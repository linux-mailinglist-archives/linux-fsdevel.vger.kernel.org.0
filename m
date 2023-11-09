Return-Path: <linux-fsdevel+bounces-2513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C53C07E6B81
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 14:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55BB9B20E60
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 13:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EB51DFF1;
	Thu,  9 Nov 2023 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTi9Ahg1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AE71DDFC
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 13:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D49C433C7;
	Thu,  9 Nov 2023 13:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699537793;
	bh=g2jkUw42qCWhFW5cZf4U5x713RPrIMKJnBTpERQiIj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HTi9Ahg17H27lu7U9bF3Z1jV5efyxcvnz+qBA0/d56dUxQvNYSH8QekZCphg3II4T
	 q23JgZY3sVBeI1QlQV9goLV6Hewi7Jt+nTHCwJee/4R77/mXySF7b4QHkrH3I7JvOD
	 Z8x6gWNEqUr3PZiNP8p4vPAVCLj/HJByEeeFa4+gI76zEshsq2vhCAmWm7/uFTk/VN
	 ywDxhVPkW2ystVh0PDdUVm7CKFJBzAWrk4mssLdcBlOJ85YIEfPQtmCp1iYAprRhCg
	 9/s/ksvFImCZ1nWjbvUsDF+85+KP0IlDBgh2nMBF6if3wQpAaULx5M4gucIa9NpKud
	 KOUE4HJGdO6MQ==
Date: Thu, 9 Nov 2023 14:49:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/22] centralize killing dentry from shrink list
Message-ID: <20231109-behindern-bauphase-69cd3b1f78a9@brauner>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-5-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109062056.3181775-5-viro@zeniv.linux.org.uk>

On Thu, Nov 09, 2023 at 06:20:39AM +0000, Al Viro wrote:
> new helper unifying identical bits of shrink_dentry_list() and
> shring_dcache_for_umount()
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

