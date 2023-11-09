Return-Path: <linux-fsdevel+bounces-2510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C447E6B50
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 14:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B2E2810B9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 13:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272361DFF7;
	Thu,  9 Nov 2023 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1QpfeF8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4C91DFEE
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 13:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B27C433C7;
	Thu,  9 Nov 2023 13:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699537331;
	bh=epzjuhA/uPI4wBldMqPFqZDTONmVMlFKCxFGYbZMboU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u1QpfeF8l/Cy/6eUzIopy9WbpfyZ8PigaZNIN8hox7NjVnWuo2BHFeg8ltYpp88Sr
	 jzQRH6Zd74LdT8O9OOuSXpcQ+FADa+3FpYzo7ZhGohHs6JDUkpX/FfgpQ847U+l3B7
	 hAeqK8FJ6c2ttAcGBdvPgxvygNgCqw26N8e/HiTRwGQxx0rx3YW6Jn2jn40JN4Cf49
	 yQNlmUmUoYEbG45RcmN8DY9ckwhM5UIS5M4Q6UUo5qzuyHIjErzxy1Vj+xZIJLR6YH
	 Ge2mD7k+dZYcLFI822YO5RmxhCKCN93N0gU/C+CJDg+LAC/vnJs3qcuzoSwGmEQtGs
	 fVMUv8ZXRgVOQ==
Date: Thu, 9 Nov 2023 14:42:03 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/22] switch nfsd_client_rmdir() to use of
 simple_recursive_removal()
Message-ID: <20231109-anstieg-fanatiker-181307fc45dc@brauner>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-2-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109062056.3181775-2-viro@zeniv.linux.org.uk>

On Thu, Nov 09, 2023 at 06:20:36AM +0000, Al Viro wrote:
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Tested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>

