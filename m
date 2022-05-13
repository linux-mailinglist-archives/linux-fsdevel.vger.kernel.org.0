Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB515262E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 15:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380662AbiEMNRu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 09:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380646AbiEMNR2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 09:17:28 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EF81C112
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 06:17:17 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id v14so5601298qtc.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 06:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0v+FfOsKq5VWpBjWpQKF+Samyecdm66+rnpTGWhFy5Q=;
        b=GujRUI3WLq3U7M0kMpyk3Rtgb6bm1R2ZA+3/qJiD5xxo+qI5bWYtSqI9ORhx0A4CVO
         AJo8ghYwuEUd0w4lqtS40h9p0HhrOD4gZqBJ18Bs29k3MVtWiuOxjUZg10flnhVJ41/D
         vCQtzX6cu5hN6zJxZdpDfruOz25z8AupG4bP63sASGnaAAtjWXaCdWEwnraN13T+ZCsp
         45pWzN5j4ZRLjCeBf4uGAcpnNft2J8rjDk3Vk1+RbNzAojaX917SBAlLRBPJXYuBm9t/
         Yh6e7oFLoc5iYd6k3vMlPBZ7dky9I9xOwJEF/H6yWDXrHQ8/og0RKUVHBehuh6e0R7v6
         k3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0v+FfOsKq5VWpBjWpQKF+Samyecdm66+rnpTGWhFy5Q=;
        b=iN6zepiuliHKTf7uiGaHiHdLhhxmqrWpooz73UOA7r9hQRn3qT4LTp+XD0DSU9QXr2
         g9PVmttpKudgFqIuM42FohnNlNkrzVTPt9Bm9wprgVyRLDsvG2FDHdV1Zh8jn1JjFcyx
         BYF3SoUZ/dp7Dtl3TNSZR+grBkH/drrv2oUNzLsg3fjStedzkkodkmd0LIGYL6a9fLtW
         hOYrSuRTUMeg5rPYPjOdxH5MTzfJRLsBURqn7NrvstPg00avuACY3vDpb4tOimCFqSSv
         cwgml4xqEV7izt8ELWP0+7eJb10HEgIVtx8bYoiV9E+jWbMfJMSwsqeAHJBJxYIwxt1I
         iCwQ==
X-Gm-Message-State: AOAM530c8AreKTcjiQujKFEsIKBQPMG0BPpMO0CtBIj+lVNPtPwpvirf
        WpCt6mnaHVCRXjklwEcCzBTUVnlQL2eO2g==
X-Google-Smtp-Source: ABdhPJyNw5Wg+jqj7dr9lMG9SfNu1+W1unb/0JVNGsyXFciINrRjjGcYTqlcvGLHprg+QUvdFpA96A==
X-Received: by 2002:a05:622a:6115:b0:2f1:d8fa:84aa with SMTP id hg21-20020a05622a611500b002f1d8fa84aamr4501160qtb.689.1652447836416;
        Fri, 13 May 2022 06:17:16 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r18-20020ac85212000000b002f39b99f67csm1348296qtn.22.2022.05.13.06.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 06:17:15 -0700 (PDT)
Date:   Fri, 13 May 2022 09:17:14 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Freeing page flags
Message-ID: <Yn5aWj2dJDyr/WRl@localhost.localdomain>
References: <Yn10Iz1mJX1Mu1rv@casper.infradead.org>
 <Yn3FZSZbEDssbRnk@localhost.localdomain>
 <Yn3S8A9I/G5F4u80@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn3S8A9I/G5F4u80@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 13, 2022 at 04:39:28AM +0100, Matthew Wilcox wrote:
> On Thu, May 12, 2022 at 10:41:41PM -0400, Josef Bacik wrote:
> > On Thu, May 12, 2022 at 09:54:59PM +0100, Matthew Wilcox wrote:
> > > The LWN writeup [1] on merging the MGLRU reminded me that I need to send
> > > out a plan for removing page flags that we can do without.
> > > 
> > > 1. PG_error.  It's basically useless.  If the page was read successfully,
> > > PG_uptodate is set.  If not, PG_uptodate is clear.  The page cache
> > > doesn't use PG_error.  Some filesystems do, and we need to transition
> > > them away from using it.
> > >
> > 
> > What about writes?  A cursory look shows we don't clear Uptodate if we fail to
> > write, which is correct I think.  The only way to indicate we had a write error
> > to check later is the page error.
> 
> On encountering a write error, we're supposed to call mapping_set_error(),
> not SetPageError().
> 

Yup I can't read, the places I was looking did mapping_set_error() in a
different area from SetPageError() so I got confused, so this can be ripped out
of btrfs with no problems.  Thanks,

Josef
