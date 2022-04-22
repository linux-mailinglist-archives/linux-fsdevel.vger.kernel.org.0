Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983E250B05C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 08:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444308AbiDVGVU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 02:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444286AbiDVGVS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:21:18 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0EA506C3;
        Thu, 21 Apr 2022 23:18:20 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id j6so5180114qkp.9;
        Thu, 21 Apr 2022 23:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jBtDCs/jMS2n+brFuT1uuyxiqgedIf4qZJTyHxgLAVI=;
        b=Fbb1PEPUmevCzHAR2ytCKF9FcEAdtjuBYUrT/qm619DjBDkuibJYyOLh2oCW6RLKUx
         84o4X782f3tda8VZ8qS0m5L6QtZ2hWLfDhI7Cn0VaVBjOpFTGofJ4M+GugQ6/wWpkpME
         QkK3riIJ2GViGZF33XONGLYEUU503YV9oOBd+gYmwicep9Hp8YC/TmZXqNyvuje8Mshu
         jZw0W/xBHIyHr/SNkbqgvR9nHS83333YF7DVsGw5l0zdCLNWcUhcrphmUsHbNB4+xjMb
         buTCdu6TWZoULdFZzKprfVrjWZ6IW6xrVAi96VB8fwLyPXWEz5HT5CgEDzAfSWB89MDO
         aOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jBtDCs/jMS2n+brFuT1uuyxiqgedIf4qZJTyHxgLAVI=;
        b=R5g93tW+do4J4q6qMATSwSZUu7TmeaA5EvjjzMilgsxA0q1auS9+ceFPElxz2dtJo1
         u+vzrmniT/PftpjTgTSdo4PI7xWTgHzblmNMmRr12wqqkB3BCBDMvWWnM2T+9nVh9ZCM
         Il/6BPzUW2g0exD/C2yoakJRlQmedsEjJb+yEOy6Nn0XCq6bNUYxSNdINaWjGYTfnAPm
         UlI//vxzmUYS+lxYfYjhr9AqvL7RJihrgyz02R4LVntqgtXYntnyO5kCQBqjXSyRrZy5
         hRkn7SJjyW6SDriv1EB3RMwUi8Bc32QaBs+n7ti4ZEC0b2e4wTikwdLhJhnVkssM7Kyc
         akzg==
X-Gm-Message-State: AOAM531c52lIMn0Gh6ENYchxYuXpE7h1L7tN0kuuqZxh7Wq05TMGZjgX
        UWAoNn4qTaTRmZAQufwXCw==
X-Google-Smtp-Source: ABdhPJxyewgacs4uuXBgLPLZHF1Tg5S17HFywfzWbBISs2q2bZOLsGVrseRzk1tANYrmvAzf8HVCrQ==
X-Received: by 2002:a05:620a:410b:b0:69e:ce2f:1428 with SMTP id j11-20020a05620a410b00b0069ece2f1428mr1714010qko.457.1650608299630;
        Thu, 21 Apr 2022 23:18:19 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id n11-20020a05622a11cb00b002f344f11849sm729680qtk.71.2022.04.21.23.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 23:18:19 -0700 (PDT)
Date:   Fri, 22 Apr 2022 02:18:17 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-input@vger.kernel.org,
        roman.gushchin@linux.dev, rostedt@goodmis.org
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
Message-ID: <YmJIqQStCvSAXKPF@moria.home.lan>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-7-kent.overstreet@gmail.com>
 <20220422042017.GA9946@lst.de>
 <YmI5yA1LrYrTg8pB@moria.home.lan>
 <20220422052208.GA10745@lst.de>
 <YmI/v35IvxhOZpXJ@moria.home.lan>
 <20220422055214.GA11281@lst.de>
 <YmJF9J5cCsELY++y@moria.home.lan>
 <20220422061152.GA11704@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422061152.GA11704@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 08:11:52AM +0200, Christoph Hellwig wrote:
> On Fri, Apr 22, 2022 at 02:06:44AM -0400, Kent Overstreet wrote:
> > > Well, most of what we have is really from Ming.  Because your original
> > > idea was awesome, but the code didn't really fit.  Then again I'm not
> > > sure why this even matters.
> > 
> > Didn't fit how? And Ming extended it to multipage bvecs based on my proposal.
> 
> He did all the actual hard work to get it ready to merge and to work
> everywhere.  As in he stuck around and actually finished the project
> based on your design.

Not sure why you need to keep throwing shade, but..

> > > I'm also relly not sure why you are getting so personal.  
> > 
> > Put yourself my shoes, I've honestly found you to be hardheaded and exceedingly
> > difficult to work with for a very long time.
> 
> Thanks, but I've been walking these shoes for a while..

*snort* Yeah, I know I am too :)
