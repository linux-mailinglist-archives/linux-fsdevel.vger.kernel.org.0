Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9150248F34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 21:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgHRT7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 15:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgHRT7H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:59:07 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893E6C061342
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 12:59:07 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f10so9706884plj.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 12:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UtvEIM7NJb9DV7eM9Gem48qF3l7pVpCdEzxyrXC+k2g=;
        b=TEZ9FT5UQ0c4hTw4uTo0tXnl21MyitKB/Hm0BA/xD94N+19fOdggAxLE1SHPhZXHqD
         Rly/Wc9mUw8GyMUu9e4rUX+5GtFA6peIE4GDgziPYwtFtihtofk84dfTXvuz5Z+I5Lt0
         XAw8PgnIzVDU+KymMURjkfxZx0R0EvGunb2/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UtvEIM7NJb9DV7eM9Gem48qF3l7pVpCdEzxyrXC+k2g=;
        b=UZBR1Ymsm71pgsWS6Sxo2fc1f/kHJbFz7GOqCWjFRwqR3nrSS4yc+8RdToS12JWqxE
         nxgktIf5Yk9lVFA2VGoEcdIVe8pJWjcUOPBGZdnVnBm+yy7v4r7jkCS83eTkExyxemS+
         henzI77E3pvKqN4vPSsG9rLHTGe92yqcin+FjU7zWiW6pteW8uYKqUHXqP8eUlS5F40/
         /sm/hyn+8caPlmWnGknFC+i+SjP5GsBbWzR/CiDIAPR2zs/Umf3HN4iNNJ/4oP0BCUYV
         oow01+syGvDYnzYqxPze98ZOW0UC6xkzKIAXndGbkwDsVFcAk5ts/6feAITGnRSa5bGU
         teZw==
X-Gm-Message-State: AOAM530oTMo2AS1zxYczOxf/r2rSHyJKadRR7aCeCKUoGNC2IdDtM+Ns
        3EsCHgao5wLBJdQKVMWkE2q97Q==
X-Google-Smtp-Source: ABdhPJz5S+aFMIAllTf6EeyEL2d4ft+e+kahg8U05QAv6xwSUo7qPqGWeSmxI0LB5EZTcNSgAu3TAg==
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr16722140plr.58.1597780747129;
        Tue, 18 Aug 2020 12:59:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f17sm26147059pfq.67.2020.08.18.12.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:59:06 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:59:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 08/11] x86: make TASK_SIZE_MAX usable from assembly code
Message-ID: <202008181258.CEC4B8B3@keescook>
References: <20200817073212.830069-1-hch@lst.de>
 <20200817073212.830069-9-hch@lst.de>
 <202008181244.BBDA7DAB@keescook>
 <20200818195539.GB32691@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818195539.GB32691@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 09:55:39PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 18, 2020 at 12:44:49PM -0700, Kees Cook wrote:
> > On Mon, Aug 17, 2020 at 09:32:09AM +0200, Christoph Hellwig wrote:
> > > For 64-bit the only hing missing was a strategic _AC, and for 32-bit we
> > 
> > typo: thing
> > 
> > > need to use __PAGE_OFFSET instead of PAGE_OFFSET in the TASK_SIZE
> > > definition to escape the explicit unsigned long cast.  This just works
> > > because __PAGE_OFFSET is defined using _AC itself and thus never needs
> > > the cast anyway.
> > 
> > Shouldn't this be folded into the prior patch so there's no bisection
> > problem?
> 
> I didn't see a problem bisecting, do you have something particular in
> mind?

Oh, I misunderstood this patch to be a fix for compilation. Is this just
a correctness fix?

-- 
Kees Cook
