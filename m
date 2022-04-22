Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2056750B04A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 08:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444228AbiDVGOx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 02:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444265AbiDVGOt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:14:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B3E506C0;
        Thu, 21 Apr 2022 23:11:56 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A04EF68B05; Fri, 22 Apr 2022 08:11:52 +0200 (CEST)
Date:   Fri, 22 Apr 2022 08:11:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev,
        rostedt@goodmis.org
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
Message-ID: <20220422061152.GA11704@lst.de>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com> <20220421234837.3629927-7-kent.overstreet@gmail.com> <20220422042017.GA9946@lst.de> <YmI5yA1LrYrTg8pB@moria.home.lan> <20220422052208.GA10745@lst.de> <YmI/v35IvxhOZpXJ@moria.home.lan> <20220422055214.GA11281@lst.de> <YmJF9J5cCsELY++y@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmJF9J5cCsELY++y@moria.home.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 02:06:44AM -0400, Kent Overstreet wrote:
> > Well, most of what we have is really from Ming.  Because your original
> > idea was awesome, but the code didn't really fit.  Then again I'm not
> > sure why this even matters.
> 
> Didn't fit how? And Ming extended it to multipage bvecs based on my proposal.

He did all the actual hard work to get it ready to merge and to work
everywhere.  As in he stuck around and actually finished the project
based on your design.

> 
> > I'm also relly not sure why you are getting so personal.  
> 
> Put yourself my shoes, I've honestly found you to be hardheaded and exceedingly
> difficult to work with for a very long time.

Thanks, but I've been walking these shoes for a while..
