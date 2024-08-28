Return-Path: <linux-fsdevel+bounces-27619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BC9962DA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 18:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB451F22FA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 16:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0EB1A3BC3;
	Wed, 28 Aug 2024 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iO/rozde"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EEE44C68;
	Wed, 28 Aug 2024 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862474; cv=none; b=NDVoJAwziHuu86D9GgFn7IeTV8kxiAvXo+lbwgeCOxzeHKP053SE/lc4SCg45EZHDX80nhvmA3AtqK6VKTZZUZ198aOz0w/6rQM+HLRWM7raMVlu+rPk0J2dm3iAmyQb0dD3VoIySctzVmvzBmdavVgQSqUdvOTYoriVqepQqfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862474; c=relaxed/simple;
	bh=yiHtmwtZpevDfS/QkcYT/xZiCrDHFrmlQuTjJLiii0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2fv4fYwZ8jGkTTnOn6GFvMQM3dI2C0zybJfxf3KwhrAEUk7Krd1SMfN07fspEe80A4Nlsgkr9kD9gzZWDgJFFYIlQgsW6zhCS31ZdKcYNxvF6mYBNyyJvEEdeVsCpn08jXuWxuwin3Tu3rqluK6dCD93sx0rSLwKJeB0AYkuvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO/rozde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F59C4FE01;
	Wed, 28 Aug 2024 16:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724862473;
	bh=yiHtmwtZpevDfS/QkcYT/xZiCrDHFrmlQuTjJLiii0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iO/rozdep5jfgDNCIskmXHmvBLHhqBXai6uXXkp2Qopjp3ZHxbcNKd8fErDy4lSfj
	 AuhFE1oGtaP/1OOXRlZHwgyFiFwXqg8KwOCoY0Gm0lGZNmdJTDgdsDMVVl2k1k2Y21
	 4ptEYVKfJBolMAgM0oMN8K6YmwBCTFxWAvtgX2UJxulruKud8WTPspV1EnqMD+tySk
	 ZqsKgZqGkzJ97I7Rm+qyBQG0S606lomjJ0wKM1WCymEssrjUAmWZhrE/+qIk/EtluO
	 QOIFZHQYFioRLmr7j6Y3AY9AjjFJbu6WQERwDCpwnSufnI0Y9KhoI1ZyYVcs26ACSn
	 +UUSIcK4ton4Q==
Date: Wed, 28 Aug 2024 09:27:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-doc@vger.kernel.org, corbet@lwn.net,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	kernel-dev@igalia.com, kernel@gpiccoli.net,
	Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH V5] Documentation: Document the kernel flag
 bdev_allow_write_mounted
Message-ID: <20240828162753.GO6043@frogsfrogsfrogs>
References: <20240828145045.309835-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828145045.309835-1-gpiccoli@igalia.com>

On Wed, Aug 28, 2024 at 11:48:58AM -0300, Guilherme G. Piccoli wrote:
> Commit ed5cc702d311 ("block: Add config option to not allow writing to mounted
> devices") added a Kconfig option along with a kernel command-line tuning to
> control writes to mounted block devices, as a means to deal with fuzzers like
> Syzkaller, that provokes kernel crashes by directly writing on block devices
> bypassing the filesystem (so the FS has no awareness and cannot cope with that).
> 
> The patch just missed adding such kernel command-line option to the kernel
> documentation, so let's fix that.
> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Looks good to me now,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Fun unrelated question: do we want to turn on bdev_allow_write_mounted
if lockdown is enabled?  In that kind of environment, we don't want to
allow random people to scribble, given how many weird ext4 bugs we've
had to fix due to syzbot.

--D

> ---
> 
> V5:
> - s/open a block device/open a mounted block device (thanks Jan!).
> - Added the Review tag from Jan.
> 
> V4 link: https://lore.kernel.org/r/20240826001624.188581-1-gpiccoli@igalia.com
> 
> 
>  Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 09126bb8cc9f..efc52ddc6864 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -517,6 +517,18 @@
>  			Format: <io>,<irq>,<mode>
>  			See header of drivers/net/hamradio/baycom_ser_hdx.c.
>  
> +	bdev_allow_write_mounted=
> +			Format: <bool>
> +			Control the ability to open a mounted block device
> +			for writing, i.e., allow / disallow writes that bypass
> +			the FS. This was implemented as a means to prevent
> +			fuzzers from crashing the kernel by overwriting the
> +			metadata underneath a mounted FS without its awareness.
> +			This also prevents destructive formatting of mounted
> +			filesystems by naive storage tooling that don't use
> +			O_EXCL. Default is Y and can be changed through the
> +			Kconfig option CONFIG_BLK_DEV_WRITE_MOUNTED.
> +
>  	bert_disable	[ACPI]
>  			Disable BERT OS support on buggy BIOSes.
>  
> -- 
> 2.46.0
> 
> 

