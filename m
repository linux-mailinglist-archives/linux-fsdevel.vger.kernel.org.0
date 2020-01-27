Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14A7914A4DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 14:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgA0NWn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 08:22:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgA0NWn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 08:22:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81C0C20702;
        Mon, 27 Jan 2020 13:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580131363;
        bh=Kb9x2s+UkwWqGC22SMv7hYVGLMzfbIYXm5FD1TymFlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QLRKMtQe3CWXw3qsNchZ+wH+soGWVSVV3TPOYlHmNcnGi0/sS7AZLEF2rAbzJ+wEy
         B6pI7BJ6BrwsW0JF/jvnFtcx3S/ebZE8rRadayMeXfZohnQD6qjUdcWDShsAfQYJLi
         ixEa8+AZ1GKWg9TG0Mbnz304ximeon0hE1rAbH14=
Date:   Mon, 27 Jan 2020 14:22:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pragat Pandya <pragat.pandya@gmail.com>
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 10/22] staging: exfat: Rename variable "SecSize" to
 "sec_size"
Message-ID: <20200127132240.GB415635@kroah.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
 <20200127101343.20415-11-pragat.pandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127101343.20415-11-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 27, 2020 at 03:43:31PM +0530, Pragat Pandya wrote:
> Change all the occurrences of "SecSize" to "sec_size" in exfat.
> 
> Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
> ---
>  drivers/staging/exfat/exfat.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
> index a228350acdb4..58292495bb57 100644
> --- a/drivers/staging/exfat/exfat.h
> +++ b/drivers/staging/exfat/exfat.h
> @@ -237,7 +237,7 @@ struct part_info_t {
>  };
>  
>  struct dev_info_t {
> -	u32      SecSize;    /* sector size in bytes */

"sector_size"?
