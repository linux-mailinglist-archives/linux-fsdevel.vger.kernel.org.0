Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F3C40991B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 18:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbhIMQa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 12:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237339AbhIMQa4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:30:56 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4F6C061574;
        Mon, 13 Sep 2021 09:29:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id bg1so6172962plb.13;
        Mon, 13 Sep 2021 09:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HzDTLjGw74e8CjqrCfWVLgo6C2sbYI/lSxwRQLVntl4=;
        b=nDgSvSlJ4smKAm8c1xcHqnbe6jg/8lXJ0MYn2ZpG+aMxi9y1r8WvSFTRELTJcEVYP9
         teR8yxsTUv3v497W7/jy7xBFTWZn/vbhsqfaKYuiY52cCtDmGxXhvNrAuDAsyaWcGekn
         BAcesXdYk3jOnj/a/asM+E3cmrQD0z1vUCpNHUDj634dfPJm2QnUrO3r4VtdJLFs732t
         zbjlJo7uSRcsNjZUEjkxeh520qmWHi6KGYQ/ZR8v3AK3GlIM9c9eEPuNUskzW5WSqWIj
         t7HnXSOMyR4pLiDM4IJobWFFvMBjHvzRZ4GA/fkBFXYOUqFrwPJRfgE7aAf+ouixCfwo
         yPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HzDTLjGw74e8CjqrCfWVLgo6C2sbYI/lSxwRQLVntl4=;
        b=S6cgOOj57pcjsnKBR8AKmx+/x3ZAlmy5cAM9oDCTzGFUSyTAPt7qQLp1IxlcoAlL/c
         jW0r37lvnp/nFEpFsTpoiM62BuRTKdioly0O1fR85EDrAUV6f/Rt/nKFAlysd0LOYPL+
         f8xFAVv9ZzjMTtIbq2Kns+yAPC1Nv/1UhxbA3jBxjGOCisO7OrMQxGOkCXGjwKttaKN4
         O+qmziYrGzfkLibxqZKXfMhFWVfjgDnSmztzWux5Gvby+4NVKPWEx1EOJngt7TcDI063
         TRJDeO4nhrrS0DYWa4azu3N318bVNTP9JihYF2rMlmxfKAkl4X8b3X3uGfeXET6aM2Ku
         tynA==
X-Gm-Message-State: AOAM530A8u1cxUvMnvm9BdSa/ugfFF36e4VMZ/fOIJYEz6W21C5dau2Z
        BK7jrrHA7hbOYcVaE5qWNJY=
X-Google-Smtp-Source: ABdhPJwiPkgndzXzHNckVZlJdBGxTG76sHmV3+lRqtoX6mC6gzOmWzSgOi4PJn+GN6iv57bj/1sLIA==
X-Received: by 2002:a17:90b:3a82:: with SMTP id om2mr328347pjb.67.1631550579542;
        Mon, 13 Sep 2021 09:29:39 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id p9sm9431053pgn.36.2021.09.13.09.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 09:29:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Sep 2021 06:29:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] seq_file: mark seq_get_buf as deprecated
Message-ID: <YT98ccRMNBmoYPdl@slm.duckdns.org>
References: <20210913054121.616001-1-hch@lst.de>
 <20210913054121.616001-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913054121.616001-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 13, 2021 at 07:41:09AM +0200, Christoph Hellwig wrote:
> This function pokes a big hole into the seq_file abstraction.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/seq_file.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
> index dd99569595fd3..db16b11477875 100644
> --- a/include/linux/seq_file.h
> +++ b/include/linux/seq_file.h
> @@ -59,6 +59,10 @@ static inline bool seq_has_overflowed(struct seq_file *m)
>   *
>   * Return the number of bytes available in the buffer, or zero if
>   * there's no space.
> + *
> + * DOT NOT USE IN NEW CODE! This function pokes a hole into the whole seq_file
        ^
       typo

Thanks.

-- 
tejun
