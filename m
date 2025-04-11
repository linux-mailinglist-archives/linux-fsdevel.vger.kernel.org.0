Return-Path: <linux-fsdevel+bounces-46266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 548F5A86014
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F5777B340F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 14:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8711F463B;
	Fri, 11 Apr 2025 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asukNt1y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C431F419A;
	Fri, 11 Apr 2025 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380640; cv=none; b=N94t5pWJlJpr4NfW4TM7C/YTGNU2HYQn+ptUmTiIUGtkgeMQeYovlRT2FlWAa22Swn5eTD32xVjEGJ8tYhXTWAjVOEGOBjRRmL2vJgGRy44g3tpy/EjUurGFw02kFZ/++teppH5QiQddae1unziTp5qSQ+z4jbjLjyzOLWgwQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380640; c=relaxed/simple;
	bh=KzXEO5UCRWyWpNuoUxoOb69fLAzMJ9uiD0OLQ/xcNZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtu22zYfhVOzWNxbQp4PqxoxZ9M9639HH1AY9LQLxOzTCut+LlyePVUMutu5i3V4QdH1mpdo1j1mTBHlsrssDgfhUMUL5ohSCSKzcBlZbJ18atd1AVN5W4hoMSZ+ENV6/S/DDnBrP/JJpiERJbOTb053cmPg5w5JeNRiKevtlBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asukNt1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9C0C4CEE2;
	Fri, 11 Apr 2025 14:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744380640;
	bh=KzXEO5UCRWyWpNuoUxoOb69fLAzMJ9uiD0OLQ/xcNZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=asukNt1yLWbClDpq3Zhy93G98botagBwqsj7zpUuvHTyLDAIxc/L1mrLr4ViPK9Dl
	 YbslBdOH3olvZc5jul5ZqFO4wNyXkVO+g3iZrFrwAtSRGEv7d5iiCApiHpZbSqr9kE
	 5eN2hMOm20+WWXAiMO6m3gqVna+NNb9CD9Nn2hrx/22iqmKvChkk5hq6naZU1HqtLA
	 p9+o4FONnff6gocacy8AHi5gioVImwePn6Admzg6NErBaiL46fFuFZD6TsGO+xqhgy
	 R9bTvLg6VRrEpYzCrrFerzFdeVnNVFXtNJZiSEL6UOTGRRS3xG88YKAbTgRWDxZf/V
	 Ghnvt2NqGXO5Q==
Date: Fri, 11 Apr 2025 16:10:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH RFC] fs/fs_context: Use KERN_INFO for
 infof()|info_plog()|infofc()
Message-ID: <20250411-fahrbahn-vortrag-ea3a07c30754@brauner>
References: <20250410-rfc_fix_fs-v1-1-406e13b3608e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250410-rfc_fix_fs-v1-1-406e13b3608e@quicinc.com>

On Thu, Apr 10, 2025 at 07:53:03PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Use KERN_INFO instead of default KERN_NOTICE for
> infof()|info_plog()|infofc() to printk informational messages.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  fs/fs_context.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index 582d33e8111739402d38dc9fc268e7d14ced3c49..2877d9dec0753a5f03e0a54fa7b8d25072ea7b4d 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -449,6 +449,10 @@ void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt,
>  			printk(KERN_ERR "%s%s%pV\n", prefix ? prefix : "",
>  						prefix ? ": " : "", &vaf);
>  			break;
> +		case 'i':
> +			printk(KERN_INFO "%s%s%pV\n", prefix ? prefix : "",
> +						prefix ? ": " : "", &vaf);

We can try but it's not out of the question that this might cause users
to complain or cause regressions.

> +			break;
>  		default:
>  			printk(KERN_NOTICE "%s%s%pV\n", prefix ? prefix : "",
>  						prefix ? ": " : "", &vaf);
> 
> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> change-id: 20250410-rfc_fix_fs-cfa369930abe
> 
> Best regards,
> -- 
> Zijun Hu <quic_zijuhu@quicinc.com>
> 

