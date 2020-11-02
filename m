Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEA02A3360
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 19:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgKBSxS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 13:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgKBSxS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:53:18 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6ACC0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 10:53:17 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id z6so12461609qkz.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 10:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GqwiFjVGQt3CX2to8WXw7r6v8bqt9Yg6qe2TM6wY868=;
        b=FhY/VzWZOXxjuAhf+CVxMj+WY32fC5l8SCraEdaf+khpOkKA0xDAD0p/PanFTQg0Wv
         a0mjkA8rADCbt4vVM5i00qEDbaVPc5sRlYQ9NnZN63gfpztT+UxQSfuKAZSvttc55J5h
         nBR5oKwRv6yztzehVyUESKvJUpEWbPLTmvVNkCrsmC6uGejfX6NOpgi2mNpi+QoWItGw
         Gm2dxSckw11vXh4sbm65zVj7l+SqixC6LDdapn8aTBDvv52KJCnE8DM3stNPsLHOjGsM
         SdKMxYIIHDftRjA83y1RporowcSIx2tqPmuQC9K9wozeFawOsxvZ2tTpyVwscOOpXiA6
         wZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GqwiFjVGQt3CX2to8WXw7r6v8bqt9Yg6qe2TM6wY868=;
        b=loLX2pk2h8Oc7tfN47+29KnXBEkutX7cC8FdS0YgKKBtyStNbHUBorZPDHWLsJHekp
         N2yqHIPqxNf01PbbrmWUpTYoiQtJT3p/65HetaMkTRhqg5xjFeE+nFhBucrilJ+iTx7P
         Yz6Ic4jGje3WI62qTfIo1r5WBr5yemuzRT2J9RDGT6tcTrWvzyx23EQlAht2c9PZFGpk
         oanyQNXMR4oJbOvnyaAQ2Or9Jz6T0hTc7zShsysSkst9eGHEWRtJzxAq9/QHLlz+SOPT
         Gw+Ci7hk/n+TYcWaqy4PbIhswjnvb+r27Vl0is/eEXg+TZFtdvX63o97XBv9I77hH268
         +ySA==
X-Gm-Message-State: AOAM5339q4aI85GbYIvnr/oLJDhQtViZ5sAxLB/rIV5iKJEroMkjd6fY
        fSkN+yN8qSVCE+Uoy3kCCD4tXkauWpC3
X-Google-Smtp-Source: ABdhPJyi1ikDoeM1Ly1H3DyJYDYPmHKxD1ErVyCvw2BratBsiaKSjA9WlokMi+rwOsw4LmYMcBOOsw==
X-Received: by 2002:ae9:e414:: with SMTP id q20mr15461973qkc.291.1604343196718;
        Mon, 02 Nov 2020 10:53:16 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id p24sm8434811qtq.79.2020.11.02.10.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:53:16 -0800 (PST)
Date:   Mon, 2 Nov 2020 13:53:14 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 01/17] mm/filemap: Rename generic_file_buffered_read
 subfunctions
Message-ID: <20201102185314.GD2123636@moria.home.lan>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-2-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:42:56PM +0000, Matthew Wilcox (Oracle) wrote:
> The recent split of generic_file_buffered_read() created some very
> long function names which are hard to distinguish from each other.
> Rename as follows:
> 
> generic_file_buffered_read_readpage -> filemap_read_page
> generic_file_buffered_read_pagenotuptodate -> filemap_update_page
> generic_file_buffered_read_no_cached_page -> filemap_create_page
> generic_file_buffered_read_get_pages -> filemap_get_pages
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
