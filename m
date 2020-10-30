Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313E929F969
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 01:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgJ3AEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 20:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ3AEo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 20:04:44 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE444C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 17:04:44 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id p10so4971607ile.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 17:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9gRYezkbnMXFdqY4A90rm34YJ2lybUPYTL7SBNEMZ84=;
        b=d/d1CRY7661eKRjem/vI1XNo9H2M5TvyRItjdcOZwRWpij48kIRCkBXeTi0TesOG4s
         +JfOwnsqwOdhKTk2YIc1TqAW0HCchHYc83fKV9vRbNSeVMYs5OlIKFComk7iQv0GfT5b
         S4SE9arI5fg3RqIP9t0jcfkqXKoUfbcRVwrbrdfd/eFcGn4h2B6UMUfOw8k84jyacfTD
         Toswv2ay79kFj8aBtryd3GkqLyvKq3JgivzfZ/XNjKyCX+zyvmA5NOW2kVc3EiH//scm
         +VlqlLyeBGDl9YTZH026+/icwiUh7j6VJxxpiilwghenbEgpaWdrUqUHxkvy5nUY+XJh
         HtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9gRYezkbnMXFdqY4A90rm34YJ2lybUPYTL7SBNEMZ84=;
        b=Igkrerkxj8U+gh1vY0GQOWBOZ0uj5RtcTOkd7Xq9YPPv74HUzQaUwLDC5k0hKg5kZY
         n07y/62n3/AhufbusDFndYNLUPOyunAblDU1k36lPKGFyskbwj6L99MYPOskPixXHWC0
         oujY0mke131zXE1BqBtXm/XacRyUP5p7w8u7uh4S0kSPUykAu+W/l6smLirnD1dWar9R
         XuGzUAyGIhyB3bzXGgrPOsdbvsg+84Lj48dGdn6cReHok+60VLAUDF0KtH3g1YZ4mtfg
         eZRGgaY79oWMV2KfHm6DISDuhqFY/mVCSEqpo+CQlpW911v6pcqnB4lTcCzGsTr4ggBT
         5oCQ==
X-Gm-Message-State: AOAM532b5/9z0kdJ1Z2Ep1OLCND8u/o1kAki4ihQsVYCITnbbyR+JXU2
        XAFay4323VXQTmGSdk9rIW7qTlilCDbD
X-Google-Smtp-Source: ABdhPJy99muaofx0ikA0ilNe6zU834F1hUXtY4GBrlHs+u/D0NYom356JcTmb59mOATTxstXKD5qAg==
X-Received: by 2002:a92:db05:: with SMTP id b5mr5130778iln.279.1604016283633;
        Thu, 29 Oct 2020 17:04:43 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id 192sm4339067ilc.31.2020.10.29.17.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 17:04:43 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:04:38 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/19] mm/filemap: Rename generic_file_buffered_read
 subfunctions
Message-ID: <20201030000438.GA2123636@moria.home.lan>
References: <20201029193405.29125-1-willy@infradead.org>
 <20201029193405.29125-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029193405.29125-6-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 07:33:51PM +0000, Matthew Wilcox (Oracle) wrote:
> The recent split of generic_file_buffered_read() created some very
> long function names which are hard to distinguish from each other.
> Rename as follows:
> 
> generic_file_buffered_read_readpage -> gfbr_read_page
> generic_file_buffered_read_pagenotuptodate -> gfbr_update_page
> generic_file_buffered_read_no_cached_page -> gfbr_create_page
> generic_file_buffered_read_get_pages -> gfbr_get_pages
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
