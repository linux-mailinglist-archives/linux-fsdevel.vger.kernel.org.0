Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DB62D90C6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Dec 2020 22:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbgLMVb1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 16:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbgLMVb1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 16:31:27 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214A1C0613CF
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 13:30:47 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id 7so10648395qtp.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 13:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9UI1D/aF4Xct+Qc2O6ZRr7LpItVCG0Rdw7WtYPD5nIc=;
        b=D+zHYJ11jJFmKJNOZQh50YQxgonWn047Fi+xrLUOksBg/8G5tq+ouOzszxrKyuqH25
         KWytkXj7oC7SOHK6INZ9dlgvcOg/iZPaK8/Cjo1PyJnldFVpyLCd9rjdt3fX7CUqETji
         G+0N3kD0HSrw8/NTKCEKNEXTaWhobG7pHOje7+mZetSnbIVn3YyHTMdzj2kPD7Dl5R++
         FyKEFhwB6Wh204b+sI2IPo9yMCrrDIHYQ4hYXqkqrvB087uTthGvvHnR4W3VZsbN93gz
         zfc9zLoQlgj9PMzO0ZhiuZVYbu3ffRb+kGsgrQDXYCpg9XdrhaZcKhWgqIYsf21x9vMQ
         GN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9UI1D/aF4Xct+Qc2O6ZRr7LpItVCG0Rdw7WtYPD5nIc=;
        b=AK8tEukWRNj7E8REulnaHSuXf62P8jmhJmjQn/ei5tpojwxpMKY8p2ADmuxnt7V47I
         6zPcIwWl20UIpwOWyUU1HJ1cbf5maRxxl1RfpHqjyUcq9d4RtwZ/kEFBq63o3uWpWY4Q
         OB3SXp0GJRqqtCoAGhmemc2/QtzSjZGmEURNZs6S4zXfCTc/e3gbFP8pH/oV0xNesnwN
         K9hwzKTSCBcRYdMRbuLdb87/4+gcSX+2TwKs4SBM+smh9Pf5KbMM8YdhKnEM5tjNQn4a
         E0ywqC7ax2vLTjJmkngpj1t0xCDJKIsTpVOX74byhoABEkaJqp3MBeJh3wkz15SDAak5
         untw==
X-Gm-Message-State: AOAM532mrRlfeaG6PcQ0Opg3ooQ/0E7YmPeNgmqT3CkdRSIpRbCzyyKl
        1Qn78cofbvfiHJunVsOwd1kzsQ==
X-Google-Smtp-Source: ABdhPJwB/dKHHba8Lnk19XE7UcSIIVlesGOfrFFWBaLXP2iBhIkRUIivS2Qh72bOt422eOEoS/qzmQ==
X-Received: by 2002:ac8:1417:: with SMTP id k23mr29279216qtj.191.1607895046372;
        Sun, 13 Dec 2020 13:30:46 -0800 (PST)
Received: from elrond.bobcopeland.com ([2607:fea8:5ac0:7d5:501:72b8:3a26:b101])
        by smtp.gmail.com with ESMTPSA id f22sm12774645qkl.65.2020.12.13.13.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 13:30:45 -0800 (PST)
Received: by elrond.bobcopeland.com (Postfix, from userid 1000)
        id 4249FFC007E; Sun, 13 Dec 2020 16:30:44 -0500 (EST)
Date:   Sun, 13 Dec 2020 16:30:44 -0500
From:   Bob Copeland <me@bobcopeland.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH -next] fs/omfs: convert comma to semicolon
Message-ID: <20201213213044.GA9300@bobcopeland.com>
References: <20201211083930.1825-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211083930.1825-1-zhengyongjun3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 11, 2020 at 04:39:30PM +0800, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Acked-by: Bob Copeland <me@bobcopeland.com>

As I do not run a git tree specifically for OMFS, this should
probably go through vfs tree.

> ---
>  fs/omfs/file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/omfs/file.c b/fs/omfs/file.c
> index 2c7b70ee1388..fc6828f30f60 100644
> --- a/fs/omfs/file.c
> +++ b/fs/omfs/file.c
> @@ -22,8 +22,8 @@ void omfs_make_empty_table(struct buffer_head *bh, int offset)
>  	struct omfs_extent *oe = (struct omfs_extent *) &bh->b_data[offset];
>  
>  	oe->e_next = ~cpu_to_be64(0ULL);
> -	oe->e_extent_count = cpu_to_be32(1),
> -	oe->e_fill = cpu_to_be32(0x22),
> +	oe->e_extent_count = cpu_to_be32(1);
> +	oe->e_fill = cpu_to_be32(0x22);
>  	oe->e_entry.e_cluster = ~cpu_to_be64(0ULL);
>  	oe->e_entry.e_blocks = ~cpu_to_be64(0ULL);
>  }
> -- 
> 2.22.0

-- 
Bob Copeland %% https://bobcopeland.com/
