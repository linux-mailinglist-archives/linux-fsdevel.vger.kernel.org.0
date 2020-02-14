Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFDF15D8C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 14:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgBNNw2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 08:52:28 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37737 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbgBNNw2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:52:28 -0500
Received: by mail-lf1-f66.google.com with SMTP id b15so6814799lfc.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2020 05:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tdtqJsclM4uhuI49pOeI8DovFeuAeipuZdS8MF+ZWv4=;
        b=2TKMT+CYVGT6tGMCX3C6ArI+zF6FCg+KFoCVV+Dp1uBA+j0Bypp6RS3QcMMgk9JKK2
         +5FkZGsWlh+c73qUM1dgCbXrCaIDpNSxv5yZ4QZGVultrVfS0230WquGpTX7bWMQZwRL
         Itk86oLVC12ZSIKyd+5Sx5M0SqXlOC3Y1FMECprDAznUARuH7ImGLSbmH4a9xgwU8KDC
         H7AaI8p81Izim+CXybf3/U1g3yEyxDRIfmr7NBAeUS+PpoX/CPSvou/vpz3us8w80e0/
         CgqPwGd05MoNEx6XvJl4K5/6Pn2O/mUOFIQN+NUEkqVeV/p3NW0POTievY/0WitDLk0/
         XyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tdtqJsclM4uhuI49pOeI8DovFeuAeipuZdS8MF+ZWv4=;
        b=FcPM/QuL7MPp5Po789Hs3kN0Etd3N5m+N/lhLm7rdHiKT2t1mOGR0550ibGZ+C8/hY
         zv+OSOZA188S2ITArMFVOL/Fy0B53Fbzh87i+rPkvsU6YwcQENQvongbXqo+k+WGPAEf
         RbOyr4RUNMHlfGjant717lWD61utNz6StWrmic4lUhRiNAddHqP8/WwfgcDsVBK5Kb4/
         +0DYAeWMJvLluB68FDnDYkWCKV/zz+pWg5XHN4PO/bSWKgHzvLZQIP0FzxCAUvcyzEEo
         v6q8fVmo8iuUohQ4DBRP2ymt9TPhARuNnruEvIiEVLOidpxCdGnL5z0u3+ZawCmf/odx
         3VtQ==
X-Gm-Message-State: APjAAAXcVn1b1Igtj+megofbH1Wp/gZEZz6sbLKdfs5aM/p9tbim4t5N
        9MW+nyITbKcGlwchXaSwoOHn/g==
X-Google-Smtp-Source: APXvYqxKZSFPG4dqXvYMd4rmSifXuXeg3DODSZO8QZQljvwGRQPXEzK9MqFBoZOwwF5DbIqRkuXUEQ==
X-Received: by 2002:a05:6512:4c6:: with SMTP id w6mr1721466lfq.157.1581688346526;
        Fri, 14 Feb 2020 05:52:26 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 23sm3661546ljw.31.2020.02.14.05.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 05:52:25 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3DAEF100F7E; Fri, 14 Feb 2020 16:52:48 +0300 (+03)
Date:   Fri, 14 Feb 2020 16:52:48 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/25] fs: Add zero_user_large
Message-ID: <20200214135248.zqcqx3erb4pnlvmu@box>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-14-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:33PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> We can't kmap() a THP, so add a wrapper around zero_user() for large
> pages.

I would rather address it closer to the root: make zero_user_segments()
handle compound pages.

> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/highmem.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index ea5cdbd8c2c3..4465b8784353 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -245,6 +245,28 @@ static inline void zero_user(struct page *page,
>  	zero_user_segments(page, start, start + size, 0, 0);
>  }
>  
> +static inline void zero_user_large(struct page *page,
> +		unsigned start, unsigned size)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < thp_order(page); i++) {
> +		if (start > PAGE_SIZE) {

Off-by-one? >= ?

> +			start -= PAGE_SIZE;
> +		} else {
> +			unsigned this_size = size;
> +
> +			if (size > (PAGE_SIZE - start))
> +				this_size = PAGE_SIZE - start;
> +			zero_user(page + i, start, this_size);
> +			start = 0;
> +			size -= this_size;
> +			if (!size)
> +				break;
> +		}
> +	}
> +}
> +
>  #ifndef __HAVE_ARCH_COPY_USER_HIGHPAGE
>  
>  static inline void copy_user_highpage(struct page *to, struct page *from,
> -- 
> 2.25.0
> 
> 

-- 
 Kirill A. Shutemov
