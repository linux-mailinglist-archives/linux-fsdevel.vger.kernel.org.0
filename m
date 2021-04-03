Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D783531C8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Apr 2021 02:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbhDCAcB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 20:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbhDCAcA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 20:32:00 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEB6C0613E6;
        Fri,  2 Apr 2021 17:31:57 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id g20so6654864qkk.1;
        Fri, 02 Apr 2021 17:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CvEaf7XI2+OL6Uz4F6ps4uPZx9GzX6Ggnfr2XHs6ui0=;
        b=cQ76UQt6bfc3lHFMLCwEL6xlobK5LfSRA4GhciPgpgBNw7G2airbGbiO9wIGfKBJk0
         lOUVkaBFfNxtWN2mGS5z4vIBSrsW8B2Qi+H3gTiRbUzbUAO/72Bj5oyEsn18Cv/emy/U
         ixo5uFdMm8xFzNsjnfTea14UoFrBMWdwOmNaMkYr53u9g3lXezkyzJFrzbC9OgddjiY5
         TV1ECNEQI17wsQ3TWxaf/at1ESD8mqE/28VrfwGvVChsgLD9YcokfbusaYmcCZ5DE0li
         e2obDS9vsO7SqYYRPRMih1IJYa03zUbjzIdu1yd99iUUkQQHIY8fq1TV7n1hcX6gtN6L
         aPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CvEaf7XI2+OL6Uz4F6ps4uPZx9GzX6Ggnfr2XHs6ui0=;
        b=t40A6HwIgB31MRNUlhpwpTT2vbPkraz9BxKjTXcp5YERxg903GtUy270ZyczfBfNld
         hfwVbd4MEQib6+REWJv3IdL4PJ2/yifXkDHeVvWuCdEO117GRe9/A1FjOFhSt3no2PLt
         n84U4X34FqRRVcAe7zqa2xsWzMfkBS9EojaDaGsbDg+BFLKVa4iUmE/HJa3BeRhYqjoF
         wig1XrwkGqs9gvz0zihxsKnWjpAfjUVCtOk8OUR2PPjUB56I4cdAhzmezKraZ7RE/MTr
         Z/RLC7/FyOhVfuGfK37E1dP091ddV112a4nNb4rFdQdRFet9rakMQJEPSd9WvsRXlpmf
         tjVA==
X-Gm-Message-State: AOAM532BOCXLWWFs1p2YhkSYmzqpmCVjvlEUVKZZ9UWJ+mG4BOGRjJ4v
        ZWfxygE0vv4rt1QvklXTYg==
X-Google-Smtp-Source: ABdhPJwHpcNhSbKtS1P/Tix+YFdtCPahhDLMiuyLXSp2OhNYqLKX4Kws1fIiT8qFDJe8lAAe2iLnww==
X-Received: by 2002:a05:620a:134a:: with SMTP id c10mr15166572qkl.481.1617409916852;
        Fri, 02 Apr 2021 17:31:56 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id i25sm8253285qka.38.2021.04.02.17.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 17:31:56 -0700 (PDT)
Date:   Fri, 2 Apr 2021 20:31:51 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 00/27] Memory Folios
Message-ID: <YGe3dy5OmT12NVYK@moria.home.lan>
References: <20210331184728.1188084-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:47:01PM +0100, Matthew Wilcox (Oracle) wrote:
> The medium-term goal is to convert all filesystems and some device
> drivers to work in terms of folios.  This series contains a lot of
> explicit conversions, but it's important to realise it's removing a lot
> of implicit conversions in some relatively hot paths.  There will be very
> few conversions from folios when this work is completed; filesystems,
> the page cache, the LRU and so on will generally only deal with folios.

I'm pretty excited for this to land - 4k page overhead has been a pain point for
me for quite some time. I know this is going to be a lot of churn but I think
leveraging the type system is exactly the right way to go about this, and I
can't wait to start converting bcachefs.
