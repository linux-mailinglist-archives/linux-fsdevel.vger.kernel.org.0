Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26065301AD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 09:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiEVHpQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 03:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiEVHpN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 03:45:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203F43F8AE
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 00:45:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 83CF968AFE; Sun, 22 May 2022 09:45:09 +0200 (CEST)
Date:   Sun, 22 May 2022 09:45:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <20220522074508.GB15562@lst.de>
References: <20210621135958.GA1013@lst.de> <YNCcG97WwRlSZpoL@casper.infradead.org> <20210621140956.GA1887@lst.de> <YNCfUoaTNyi4xiF+@casper.infradead.org> <20210621142235.GA2391@lst.de> <YNCjDmqeomXagKIe@zeniv-ca.linux.org.uk> <20210621143501.GA3789@lst.de> <Yokl+uHTVWFxoQGn@zeniv-ca.linux.org.uk> <70b5e4a8-1daa-dc75-af58-9d82a732a6be@kernel.dk> <f2547f65-1a37-793d-07ba-f54d018e16d4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2547f65-1a37-793d-07ba-f54d018e16d4@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 21, 2022 at 04:14:07PM -0600, Jens Axboe wrote:
> Then we're almost on par, and it looks like we just need to special case
> iov_iter_advance() for the nr_segs == 1 as well to be on par. This is on
> top of your patch as well, fwiw.
> 
> It might make sense to special case the single segment cases, for both
> setup, iteration, and advancing. With that, I think we'll be where we
> want to be, and there will be no discernable difference between the iter
> paths and the old style paths.

A while ago willy posted patches to support a new ITER type for direct
userspace pointer without iov.  It might be worth looking through the
archives and test that.
