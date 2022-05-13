Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657425259C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 04:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376572AbiEMClr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 22:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356227AbiEMClq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 22:41:46 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4216472A
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 19:41:44 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id js14so5766264qvb.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 19:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2+U+SYaW6vkJ0XEvl7xtVWT76tib5ZDaUxF5KKEMX1A=;
        b=b38pAQO7q4b/T+t0KX9gi5GYnGqPjgdZk/ByhWrR7n3NEYyGcnK/RKSsH630bgczkf
         T4Nv7371iKGW503YdYPgL0cQoLvmDh2dQsr5fd5JoZIu67kqUCK4hsJxtVbX5+ZJ8UZv
         uPY2z9ypI1INzyL/ao5ylq4bWpUKGm+kh+oO7pEl5ux878mpAIe6yTJF8fQPH9ZYZ4TK
         owOxZZQin180JGImwtuSkApIvAfKyUlp/XkYrU5BIlYz9vDg0nWqHzesTKQmgyHDf5iP
         25twzdMZXkRQI1ZcEZw/QTK4Pl4wdlXgPKAnYaSGOFWpa0b+XUPdtdUYV/xs5BkBacYj
         27ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2+U+SYaW6vkJ0XEvl7xtVWT76tib5ZDaUxF5KKEMX1A=;
        b=aWGoasFV2Q4LwgJkmmAkHfckLFk7qTjG6eCSx+6iaLTa5xoUBe85iDpCrjuFqe63N8
         YQuPXYsLsTi3uXCsYAzhtygOlFqvFCoc5rFrPJ40w6Qj5NQpUflz6zQ1ORZrwFDi2EyC
         k5WP1gwQWmeHBZ5EfRFncGJ2R9z80SgbfI41byT6WIuYVOUzFvO3qstTacUc7TIrLwMh
         4zCJNhfQuu2Q4ob/HAWkzkavUBy9+PMI78s76DSvX/vrTgzqybIUuJ3r9t2H8/0+kPH4
         OJZrxSwiMPenS0oLaRKwS+jK/85FPsakQLFxPPyKMk+I2+OS9SFqEYHlWdsjtUGR3okh
         6mGA==
X-Gm-Message-State: AOAM531wEXLGfYOinW91dd/8hOLmIg19L5qmn6ll7NWC7pPRYWA3w27s
        W7zcerGPhEDTuhD4QQ4UwFkoyhEoIY8Tvw==
X-Google-Smtp-Source: ABdhPJz4DpL0sp0F5yRBm7R8pnTfP+6nn+BoqxYeAPswwQn2OnIGOsyJHGsjHSNt3NpEb5378qzhkQ==
X-Received: by 2002:a05:6214:2503:b0:45a:a294:510e with SMTP id gf3-20020a056214250300b0045aa294510emr2764179qvb.49.1652409703962;
        Thu, 12 May 2022 19:41:43 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 2-20020ac82082000000b002f39b99f672sm834488qtd.12.2022.05.12.19.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 19:41:43 -0700 (PDT)
Date:   Thu, 12 May 2022 22:41:41 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Freeing page flags
Message-ID: <Yn3FZSZbEDssbRnk@localhost.localdomain>
References: <Yn10Iz1mJX1Mu1rv@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn10Iz1mJX1Mu1rv@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 12, 2022 at 09:54:59PM +0100, Matthew Wilcox wrote:
> The LWN writeup [1] on merging the MGLRU reminded me that I need to send
> out a plan for removing page flags that we can do without.
> 
> 1. PG_error.  It's basically useless.  If the page was read successfully,
> PG_uptodate is set.  If not, PG_uptodate is clear.  The page cache
> doesn't use PG_error.  Some filesystems do, and we need to transition
> them away from using it.
>

What about writes?  A cursory look shows we don't clear Uptodate if we fail to
write, which is correct I think.  The only way to indicate we had a write error
to check later is the page error.

> 2. PG_private.  This tells us whether we have anything stored at
> page->private.  We can just check if page->private is NULL or not.
> No need to have this extra bit.  Again, there may be some filesystems
> that are a bit wonky here, but I'm sure they're fixable.
> 

At least for Btrfs we serialize the page->private with the private_lock, so we
could probably just drop PG_private, but it's kind of nice to check first before
we have to take the spin lock.  I suppose we can just do

if (page->private)
	// do lock and check thingy

Thanks,

Josef
