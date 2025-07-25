Return-Path: <linux-fsdevel+bounces-55993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD75B1154D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 02:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2273A803C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 00:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7341428E7;
	Fri, 25 Jul 2025 00:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFBLCflq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2B711CA9;
	Fri, 25 Jul 2025 00:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753403803; cv=none; b=hkTiGh7gDM5KcgRj5lgKH54uuWkUiPzGrNx94y/2ESHdYh1MumH9Owj5F0AmzLTuhSczaehbyLqJLoAOiqUmWdMW/9Jlga5xD0Os+NsSEQmiFHN2zVnKM5ko6s6ybf3xn+S4iHcWl6Ai6e72XJxz5vldAidimD7ZgcVFokbW4pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753403803; c=relaxed/simple;
	bh=peJ0XPsEFesPW/2iLP0+WBwlYtLELz4vfXsGmre17Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vqf0RkrWAoi6roSXQFMyGvj89YA2bDiW/HqeIQ9RJiTLtvUISVj9jYF/Eofbnif9vG7BLDHX9U962dRcxXqH7b4kekUNOqXIHQZu4OOUGIoEZ0BZvHwKIkdT+IAlWvz67vkL8qCe6EJ/RtesaD/u1cjPhCYNBufYkrMmdA8LarY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFBLCflq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F349C4CEED;
	Fri, 25 Jul 2025 00:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753403803;
	bh=peJ0XPsEFesPW/2iLP0+WBwlYtLELz4vfXsGmre17Mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EFBLCflqINWYcYRhF7PsFSkzpDVmNGiDneydbPU6Zrxcu+pbNMOP2QaJCEjj8jD/2
	 sfdt7i1EiDf2SDQcPbaKvtCRqSA1btEWaebjW9hjCoRiVhKHPJ70VUSVi4uX4awqut
	 UpUznd9HNNDfIJJPAS9s67hjcvG6Olu0/Z9k7qB9fTXNkzRVNhgaq0415V5HfT3T/l
	 SWZ//ZN5jXMxUt+bgPqwnn5z8fjflYil21qRYvSdxLQAfOzU5U052CK7miAldq6Jhp
	 uD8F5O66aBvGJHo+hFBo5VK4P3biJVkYWhcwoqFZvLX7es/dceptV62FP67MQ+Ez4G
	 de2psmBLODlOA==
Date: Thu, 24 Jul 2025 17:35:53 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	"Theodore Y. Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH v4 08/15] fscrypt: rephrase documentation and comments
Message-ID: <20250725003553.GD25163@sol>
References: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
 <20250723-work-inode-fscrypt-v4-8-c8e11488a0e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723-work-inode-fscrypt-v4-8-c8e11488a0e6@kernel.org>

On Wed, Jul 23, 2025 at 12:57:46PM +0200, Christian Brauner wrote:
>  	/*
>  	 * Pairs with the cmpxchg_release() in fscrypt_setup_encryption_info().
> -	 * I.e., another task may publish ->i_crypt_info concurrently, executing
> -	 * a RELEASE barrier.  We need to use smp_load_acquire() here to safely
> -	 * ACQUIRE the memory the other task published.
> +	 * I.e., another task may publish the inode's fscrypt info
> +	 * concurrently, executing a RELEASE barrier.  We need to use
> +	 * smp_load_acquire() here to safely ACQUIRE the memory the other task
> +	 * published.
>  	 */

Please make sure to wrap at 80 columns, not 79.

- Eric

