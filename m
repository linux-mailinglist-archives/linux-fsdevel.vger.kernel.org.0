Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A227E53940E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 17:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345761AbiEaPcJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 11:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345776AbiEaPcH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 11:32:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D685548898
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iz3M3No8iAq/ARHTW/FoyqRzLDG6u02rBVIzMFROFuc=; b=cdb2gpQP57M0WbFmhuDFQUL3cF
        WKZnsDnkDrM4yT6w8OgdUo1mYLxSdRGPqT+i2KJXh5KEVFE7dSba1pp1me+e0rpTW4D5YfqKVs5KW
        jTfZEOazD/uNpKU65zKMGUnAaJpZIVwoMxNTIoN+fh9U8R0xBj81qDwiGyvvmCvzyiwtxrgiksEj1
        kcTwFrGvr3zkJpEXHnjCodMR8IWFxy0/8V3GFps7GNr7O8kb7xR4VWEOtdmDZ9fTLYIEKDh+t33+0
        I8qV+ocfYAR/eZ679nMnK3sYJlESevFH7ZP6+OTwUq3HS1Af6Px0D2I/vlOZvMoFLM27Z7T6SUrFD
        otus5BRw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nw3qX-005Txh-G8; Tue, 31 May 2022 15:31:49 +0000
Date:   Tue, 31 May 2022 16:31:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        jfs-discussion@lists.sourceforge.net,
        "linux-ext4@vger.kernel.org Darrick J . Wong" <djwong@kernel.org>,
        mythtv-dev@mythtv.org
Subject: Re: [Jfs-discussion] [RFC PATCH 0/9] Convert JFS to use iomap
Message-ID: <YpY05ROgPowLbC77@casper.infradead.org>
References: <20220526192910.357055-1-willy@infradead.org>
 <20220528000216.GG3923443@dread.disaster.area>
 <YpGF3ceSLt7J/UKn@casper.infradead.org>
 <20220528053639.GI3923443@dread.disaster.area>
 <YpJxEwl+t93pSKLk@mit.edu>
 <20220529235122.GJ3923443@dread.disaster.area>
 <b3b1a6a0-f6fe-b054-c3ad-b6ab0f62314c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3b1a6a0-f6fe-b054-c3ad-b6ab0f62314c@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 31, 2022 at 08:51:40AM -0500, Dave Kleikamp wrote:
> On 5/29/22 6:51PM, Dave Chinner wrote:
> > "Just because we can" isn't a good answer. The best code is code we
> > don't have to write and maintain. If it's a burden to maintain and a
> > barrier to progress, then we should seriously be considering
> > removing it, not trying to maintain the fiction that it's a viable
> > supported production quality filesystem that people can rely on....
> 
> I'm onboard to sunsetting jfs. I don't know of anyone that is currently
> using it in any serious way. (jfs-discussion group, this is a good time to
> chime in if you feel differently.)

We should probably get the mythtv people to stop recommending JFS.

https://www.mythtv.org/wiki/User_Manual:Setting_Up#Filesystems

