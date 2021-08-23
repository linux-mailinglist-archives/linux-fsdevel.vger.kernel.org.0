Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FE73F4CB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 16:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhHWOyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 10:54:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47268 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhHWOyt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:54:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id C64241F42633
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 04/11] unicode: mark the version field in struct
 unicode_map unsigned
Organization: Collabora
References: <20210818140651.17181-1-hch@lst.de>
        <20210818140651.17181-5-hch@lst.de>
Date:   Mon, 23 Aug 2021 10:54:02 -0400
In-Reply-To: <20210818140651.17181-5-hch@lst.de> (Christoph Hellwig's message
        of "Wed, 18 Aug 2021 16:06:44 +0200")
Message-ID: <87y28s1ab9.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> unicode version tripplets are always unsigned.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Thanks,

> ---
>  include/linux/unicode.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/unicode.h b/include/linux/unicode.h
> index 6a392cd9f076..0744f81c4b5f 100644
> --- a/include/linux/unicode.h
> +++ b/include/linux/unicode.h
> @@ -6,7 +6,7 @@
>  #include <linux/dcache.h>
>  
>  struct unicode_map {
> -	int version;
> +	unsigned int version;
>  };
>  
>  int utf8_validate(const struct unicode_map *um, const struct qstr *str);

-- 
Gabriel Krisman Bertazi
