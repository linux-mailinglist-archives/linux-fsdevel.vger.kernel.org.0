Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA29D15C033
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 15:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgBMOTg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 09:19:36 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45415 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbgBMOTg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:19:36 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so4365567lfa.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 06:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ChUl3tHz/fw+J1QXa3SpVpFJqSXrNSqyDcmt7Jvy8A0=;
        b=Qe5MOTcV3y5UxK9Ii9p0xEZvCMj9OLw0YjFE0xBCoz1gWi9ibYASz014rUL04gpb7q
         Jh0z4VuqzLtk3mvX37TJRUZy9SweYkQMK1BNiZXULFtmiSf7XqC0kDKiTeTV2BnEn950
         QAcRxDT2FRhbApnil+gab9l+DhowDzeOFeOiHpa2fVhub7mVhBIr/LjjVhe8WBe9YEsz
         4k7GUhjbSju+l2w7Q1fbj+Ibb9rgONMoY22O91dYYGvKakYmmmCXCywGHQTkxos6LKE/
         RW2rlByGRW2QIHo+HAfVA4hPa0BnLl3f8/ihSYYBYF5CI00ccfZfMQw6yeKJCLqiol83
         NvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ChUl3tHz/fw+J1QXa3SpVpFJqSXrNSqyDcmt7Jvy8A0=;
        b=h0oW//TrL6fkgtJqt9IzkQY3Y5Jm20xUQHyFomrnk8+vc/D5Jir5lM9GOOj6PiYIj5
         Rq9OOnjltJFv1ui8SsaIE51rZq0HTnJ5ZtTPAXBfUSHYvoWD39C3ZD/wqrcPqH4Fnuw0
         c1ZnpZUNGdTOb1x1wNtutBWUuspWp3hDNU7bi120zPZzcsUbn8VqYbJknwbUUKEZWxGu
         efT+7kQv6/Wen9KyAuYEGntVHkEagoRAhIsMF4ccXO4SQ6m2OmNZiDts1BaD9Cia6/WL
         blL6YUlJKB5bKNNmvOPdPY2p+HffEuxNOJ+nZ3oKCKKNKTMd0aQJ+De+JRtV18xhMlB9
         OLSw==
X-Gm-Message-State: APjAAAWpPl3W5TyJ9FDHitniczWuIwOsvWsfZsgkIVWYmsnmxnZqB3In
        +eMdrj7ZfWnMysal0sRhURsCSQ==
X-Google-Smtp-Source: APXvYqzq/FNTpsd3Tvp2BMWqJNwdIvCHj9yXlOkhD98MAYW0DHLX50XOLa+DZ0Flj/x/O/8HCz4OZQ==
X-Received: by 2002:a19:cb95:: with SMTP id b143mr9527955lfg.158.1581603572940;
        Thu, 13 Feb 2020 06:19:32 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i5sm1591340ljj.29.2020.02.13.06.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 06:19:31 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id DF899100F25; Thu, 13 Feb 2020 17:19:53 +0300 (+03)
Date:   Thu, 13 Feb 2020 17:19:53 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/25] mm: Introduce thp_size
Message-ID: <20200213141953.ijmts6cs5eh5pgfx@box>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-8-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:27PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This is like page_size(), but compiles down to just PAGE_SIZE if THP
> are disabled.  Convert the users of hpage_nr_pages() which would prefer
> this interface.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I would prefer the new helper to be inline function rather than macro.
Otherwise looks good.

-- 
 Kirill A. Shutemov
