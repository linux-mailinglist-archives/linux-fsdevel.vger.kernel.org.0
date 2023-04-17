Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925D26E3FC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 08:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjDQG1I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 02:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjDQG1H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:27:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325D7359C;
        Sun, 16 Apr 2023 23:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MdcEqIopRGNeL8ynxUzh+Lk0gzYXw7VEdoDGuF/nCC4=; b=WJCZu+82Ms9YNKKRexfvrIz0CQ
        5rd8KyfwBqTZIK8vlQEdi2tfQutHIcUeBeFnpFyde1kheiETzyWGdyodCxdK0LR2NGt//zf1MDoPo
        Dt6ikWhcz8fZ+uudi04lRvwud7EdV2kBCqqX6OGl5U7M5/INOXVeEbrqsRwlQdV5Cq5doaBQOBTCI
        U20l+C4YHkx6o0alQFNw9/jVnVwnAPV1YjhTI4GBACpg/zCTkzkzpoSPN9OPY+VFKGk1ik6fGBV2q
        vawsnlDV1Z32PMn36gCL0a+DYfg0jdLTfqbLo8mF1WIowd5EIM6XTr//qQ7dSF70eeuGlimIVBPLv
        IUvIi0Vw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1poIKK-00F3GR-2y;
        Mon, 17 Apr 2023 06:27:00 +0000
Date:   Sun, 16 Apr 2023 23:27:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org
Subject: Re: [PATCH] mm/filemap: allocate folios according to the blocksize
Message-ID: <ZDzmtK64elHn6yPg@infradead.org>
References: <20230414134908.103932-1-hare@suse.de>
 <ZDzM6A0w4seEumVo@infradead.org>
 <df36a72c-5b20-f071-ec1c-312f43939ebc@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df36a72c-5b20-f071-ec1c-312f43939ebc@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 17, 2023 at 08:08:04AM +0200, Hannes Reinecke wrote:
> On 4/17/23 06:36, Christoph Hellwig wrote:
> > On Fri, Apr 14, 2023 at 03:49:08PM +0200, Hannes Reinecke wrote:
> > > If the blocksize is larger than the pagesize allocate folios
> > > with the correct order.
> > 
> > And how is that supposed to actually happen?
> 
> By using my patcheset to brd and set the logical blocksize to eg 16k.

Then add it to your patchset instead of trying to add dead code to the
kernel while also losing context.
