Return-Path: <linux-fsdevel+bounces-45313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC19A75E81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 07:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A816168140
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 05:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D50617A2E2;
	Mon, 31 Mar 2025 05:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="re+IotCx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D734610C;
	Mon, 31 Mar 2025 05:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743398012; cv=none; b=q6v2+SIKmHSzPkzi7cCFNYuPLM2Cw1QXRODp9jkOxCrAfX26T27zhzYALZ8KaQnwqaxtGw3Q3SRMp0VigGopStEzS9tjm6U2YN4Xhlm0Q/uD4Kf/04tOfYq2EUC2gratF1ZV3NJkiG/wpNwG2NNuLhPFOzHTW421BJxBq5Sgh38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743398012; c=relaxed/simple;
	bh=1FQ99V5zH90kSxmzk+IRdRPHzOGIhIJEGYr080dF3gE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjKfP4aYdlsMs7P99Z0Lb4rJ3mypE0sMEaL3ujZFTyp/Y2SG0qkc4WjTbp8Qg92EFMzp1tVATozGM6wRgLlS5QtW5GPY6vUF2aNXFEnR858+li7MgCMwcvetid4iOyQyRkzzp+jt9vMkFggwM9w5sO1lI0bFoJW9JKQGE3q2/Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=re+IotCx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=xljV96mkmZwxXbRoTPyRfln7pvEQHpoXqeSptdtUeEE=; b=re+IotCxIVIRQiKQUhAu0xFNwn
	3eiNvjf1/DLAp5y/WUp5t7CGFgbdV8bDjFLtyENlUstJKAZmdQxRqSOkO6uatpMgA/h9oFwUb+RQN
	ttaTp4HLO8MWZbAwRgB0JhpsCZwguyjOJyIt7NNnAT8Rq+BFWuXzVIgJZ6howAq0XDLF5nI4x/ubb
	mhWjwF8zK7ZujrWxzvOGEv6WYYWaubwxxcooPlGkugkF78OwXKPrjZ8sjUHohQovxBW+RyNX0WlUO
	pYNUPwyTfy9+UaA7ALdequ9fdsmqL85UxN+fAyDHxdxxzO6+5/wrlKCb/DtQwV2EuQpgm1pGkeQdt
	uTN4tN7Q==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tz7Sc-00000006b5r-3Dr0;
	Mon, 31 Mar 2025 05:13:24 +0000
Message-ID: <39c91e20-94b2-4103-8654-5a7bbb8e1971@infradead.org>
Date: Sun, 30 Mar 2025 22:13:19 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: initramfs: update compression and mtime
 descriptions
To: David Disseldorp <ddiss@suse.de>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250331050330.17161-1-ddiss@suse.de>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250331050330.17161-1-ddiss@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/30/25 10:03 PM, David Disseldorp wrote:
> Update the document to reflect that initramfs didn't replace initrd
> following kernel 2.5.x.
> The initramfs buffer format now supports many compression types in
> addition to gzip, so include them in the grammar section.
> c_mtime use is dependent on CONFIG_INITRAMFS_PRESERVE_MTIME.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  .../early-userspace/buffer-format.rst         | 30 ++++++++++++-------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/driver-api/early-userspace/buffer-format.rst b/Documentation/driver-api/early-userspace/buffer-format.rst
> index 7f74e301fdf35..cb31d617729c5 100644
> --- a/Documentation/driver-api/early-userspace/buffer-format.rst
> +++ b/Documentation/driver-api/early-userspace/buffer-format.rst
> @@ -4,20 +4,18 @@ initramfs buffer format
>  
>  Al Viro, H. Peter Anvin
>  
> -Last revision: 2002-01-13
> -
> -Starting with kernel 2.5.x, the old "initial ramdisk" protocol is
> -getting {replaced/complemented} with the new "initial ramfs"
> -(initramfs) protocol.  The initramfs contents is passed using the same
> -memory buffer protocol used by the initrd protocol, but the contents
> +With kernel 2.5.x, the old "initial ramdisk" protocol was complemented
> +with an "initial ramfs" protocol.  The initramfs contents is passed

                                                             are passed

> +using the same memory buffer protocol used by initrd, but the contents
>  is different.  The initramfs buffer contains an archive which is

  are different.

>  expanded into a ramfs filesystem; this document details the format of
>  the initramfs buffer format.

Don't use "format" 2 times above.


-- 
~Randy


