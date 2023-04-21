Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384DF6EB4FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Apr 2023 00:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjDUWgM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 18:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjDUWgD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:36:03 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF6D3C05
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 15:35:43 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a6f0d8cdfeso23495135ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 15:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1682116463; x=1684708463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WOBbV//TmE5/Vt+YNa7VvWoHjH617/cqrLHE/FuEqvo=;
        b=28YtcKiMKTyuPMVw5fu/SoweCi0BqDGeWt7RdFQrVk7PAU917keO+0FEYqTQ9/TsLB
         T1pzM9DhgsBLcc91My2Vu/2jTc0NKv/M54REjAUYDHXH1HKV9Z5I1WFYwId6vQM+JZTT
         E6n5vpXvzeV5sJVZPomczRMqHlEzbnPY63QdhqjDa6gftGLx/sPZUwv2JfprlGFlZtYf
         fkSebmqIvZEolZKw757enRENf4URiSoQqdGQEZOuckafZkYiGfcqGHFj/veTqOAh424T
         Sue6bk+H9d6MxTxRu5J8fCc9HsE6NtJ7Q9mZmdahhGSisRdkO3MgSWcLNMeFOEusAg5H
         JN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682116463; x=1684708463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOBbV//TmE5/Vt+YNa7VvWoHjH617/cqrLHE/FuEqvo=;
        b=OI7fbo9iIufTO2tVcztEZ9HkPRNU5kDazmYDQwhRJv9qjbOvxUR3wZ6Gbz9BBA6yTa
         9aWuEDH2sD5sf/ZEyVBUyfzE2Rg2r23aguc91mfNxB4Ue2pxWLgZ5c/3VdYpSpoWmzzX
         Whu1dR3W2UKCGaMCJLxoToIP2SSTRHuNEU7ND/+nO4iSWN08U5QPBkmsQOZc5PFG+a5m
         M0zDgI8qgxC87OtNACk9xdcpIY350upn7IZfj1Sc0O0cPuX//REnrv3I7RJ2Yh9glx0B
         yizkOC44rGjQ9HJMMtJstNpFxO/GKvom0Eq1XznoZN9C2TdIlfqxd3+GNme/fPP85ztF
         qztQ==
X-Gm-Message-State: AAQBX9fdjw7tr9smndKRic6+Pr2OaFVGyiGGnxGuy1IfpKlhBh5jSLed
        Tbcm/XXoy1IwQumFdGVAl2kLqg==
X-Google-Smtp-Source: AKy350Yx4GjX3RRHXL1Mum+601m5ZkYo7MaItZI/8CPJsIZY6IZjMOJMo9Hbi+Mo8ymVreNZtCsXeA==
X-Received: by 2002:a17:902:d4c4:b0:1a6:6fe3:df91 with SMTP id o4-20020a170902d4c400b001a66fe3df91mr7801960plg.50.1682116463609;
        Fri, 21 Apr 2023 15:34:23 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-41-174.pa.nsw.optusnet.com.au. [49.180.41.174])
        by smtp.gmail.com with ESMTPSA id v7-20020a1709028d8700b001a6401189a6sm3138777plo.147.2023.04.21.15.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 15:34:23 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ppzKe-006Dta-Ha; Sat, 22 Apr 2023 08:34:20 +1000
Date:   Sat, 22 Apr 2023 08:34:20 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, axboe@kernel.dk,
        agk@redhat.com, snitzer@kernel.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
        hch@infradead.org, djwong@kernel.org, minchan@kernel.org,
        senozhatsky@chromium.org, patches@lists.linux.dev,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
        da.gomez@samsung.com, kbusch@kernel.org
Subject: Re: [PATCH 3/5] iomap: simplify iomap_init() with PAGE_SECTORS
Message-ID: <20230421223420.GH3223426@dread.disaster.area>
References: <20230421195807.2804512-1-mcgrof@kernel.org>
 <20230421195807.2804512-4-mcgrof@kernel.org>
 <ZELuiBNNHTk4EdxH@casper.infradead.org>
 <ZEMH9h/cd9Cp1t+X@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEMH9h/cd9Cp1t+X@bombadil.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 03:02:30PM -0700, Luis Chamberlain wrote:
> On Fri, Apr 21, 2023 at 09:14:00PM +0100, Matthew Wilcox wrote:
> > On Fri, Apr 21, 2023 at 12:58:05PM -0700, Luis Chamberlain wrote:
> > > Just use the PAGE_SECTORS generic define. This produces no functional
> > > changes. While at it use left shift to simplify this even further.
> > 
> > How is FOO << 2 simpler than FOO * 4?
> > 
> > > -	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
> > > +	return bioset_init(&iomap_ioend_bioset, PAGE_SECTORS << 2,
> 
> We could just do:
> 
> 
> -	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
> +	return bioset_init(&iomap_ioend_bioset, 4 * PAGE_SECTORS,

Yes, please.

> The shift just seemed optimal if we're just going to change it.

Nope, it's just premature optimisation at the expense of
maintainability. The compiler will optimise the multiplication into
shifts if that is the fastest way to do it for the given
architecture the code is being compiled to.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
