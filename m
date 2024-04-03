Return-Path: <linux-fsdevel+bounces-16088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCDF897CBC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 01:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D2928A1A9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 23:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2708F156C50;
	Wed,  3 Apr 2024 23:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSX60lOJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CE5139D;
	Wed,  3 Apr 2024 23:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712188527; cv=none; b=Pjep+Y285hmdQrpRGvzNbVIlX4UP7FyUuPNIL+tVpnNEux1rQ3p/9xDOIdFhQjouieI651+CDmackOAaIqEJ6KMvnw/+YLopiL0wc2tVAjWiFXHOnJrxsItC7fBHzwahqVE8eldmsFZ66dgeR06Eu9LxzwBOS/VA1DRK/v5EeX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712188527; c=relaxed/simple;
	bh=HWHBdM5a47wfjfWmcaNM3oH6e3DQ6PEyk5hcv30TTn4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Z3yjUGBxLT+6xIM3Pad87pn8Gkkm3z13t+ogbdasqtHK3oxFvfcPObUQbmT+CtNidQfDRLOWXbfADgXG9Dg/uaOW/fGDT4DCU73eYKx+zKR4gZ1YsQxyONRe6D3pOyiv8OoS/SjhX2W7WQx6H0JqSXA1zmdc7ADMGZab3HJu/7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSX60lOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA36C433F1;
	Wed,  3 Apr 2024 23:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712188527;
	bh=HWHBdM5a47wfjfWmcaNM3oH6e3DQ6PEyk5hcv30TTn4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CSX60lOJpUVt/g+VfUjC5n6QM20vfeqZCF2mvJKXLloZhBG936KkYNAcXK+zfkdAv
	 PaRjfysfe4887jJeoKZEMTi98/a4k+GGVYzo8mK9/HfgLq61PQAqL9ZAdjHAlE/y49
	 yMlb4uhUFsgTjDtx4zVhaBmDLUYDBHAOnPp26e9zA4aNGBwUsp/sTV1I/3/UpKY1T7
	 ep3zamJcF8CQb87lD/8pnVVBw3zQWM96tQpf5YV6uTbPSrzTvJcwM7sr9g13PJa4KH
	 N2PPaaJy9liGDBBq2eB7ptHxYHi58CgxGo0m5r606yKUkq19M8P3LhmSqCvDaNU9K9
	 8AT4CSreSSMGg==
Date: Thu, 4 Apr 2024 08:55:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Zhenhua Huang <quic_zhenhuah@quicinc.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH fs/proc/bootconfig] remove redundant comments from
 /proc/bootconfig
Message-Id: <20240404085522.63bf8cce6f961c07c8ce3f17@kernel.org>
In-Reply-To: <f036c5b0-20cc-40c1-85f9-69fa9edd0c95@paulmck-laptop>
References: <f036c5b0-20cc-40c1-85f9-69fa9edd0c95@paulmck-laptop>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Apr 2024 12:16:28 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> commit 717c7c894d4b ("fs/proc: Add boot loader arguments as comment to
> /proc/bootconfig") adds bootloader argument comments into /proc/bootconfig.
> 
> /proc/bootconfig shows boot_command_line[] multiple times following
> every xbc key value pair, that's duplicated and not necessary.
> Remove redundant ones.
> 
> Output before and after the fix is like:
> key1 = value1
> *bootloader argument comments*
> key2 = value2
> *bootloader argument comments*
> key3 = value3
> *bootloader argument comments*
> ...
> 
> key1 = value1
> key2 = value2
> key3 = value3
> *bootloader argument comments*
> ...
> 
> Fixes: 717c7c894d4b ("fs/proc: Add boot loader arguments as comment to /proc/bootconfig")
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: <linux-trace-kernel@vger.kernel.org>
> Cc: <linux-fsdevel@vger.kernel.org>

OOps, good catch! Let me pick it.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> 
> diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
> index 902b326e1e560..e5635a6b127b0 100644
> --- a/fs/proc/bootconfig.c
> +++ b/fs/proc/bootconfig.c
> @@ -62,12 +62,12 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
>  				break;
>  			dst += ret;
>  		}
> -		if (ret >= 0 && boot_command_line[0]) {
> -			ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
> -				       boot_command_line);
> -			if (ret > 0)
> -				dst += ret;
> -		}
> +	}
> +	if (ret >= 0 && boot_command_line[0]) {
> +		ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
> +			       boot_command_line);
> +		if (ret > 0)
> +			dst += ret;
>  	}
>  out:
>  	kfree(key);


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

