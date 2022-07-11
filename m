Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E02A570B41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 22:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiGKUTr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 16:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGKUTp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:19:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762362613F;
        Mon, 11 Jul 2022 13:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HYs1LyaRC73VT38dPjTKJTKkmS+W1iX1bYSWkOKlJWs=; b=tWts7IXr30sZVi/WrY56iafBXu
        YKGs3dRZ4TNQL5qhs+2GhmS2i7HFIcQn2DwHIKQoXDxKbBkbfakZAVxK4/hGZyRKnPKHMHrO9Dhly
        IkKkETZI1LWw7YtYZ6tO/y4I/SwVvTrKACIbCYvXSm7vCBxrx5wbWwjmbfCFYmV4itIEfGzoHCm9n
        d4NRobvHjDrTmgqoZi6Ouk5zrk34TzAWnxqERp0E620prEZUkak4Fi0y2WHcv/cEO8pAeBcoKIX+T
        yTr92nvcOXLz2KhA+5AlDnzQXfn86bQiNfP0qCUr3py25ITJzLm9Icr5TOwJZWM5ldpzp70wExdI9
        pIZbZR3A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAzsc-006FqC-Ei; Mon, 11 Jul 2022 20:19:42 +0000
Date:   Mon, 11 Jul 2022 21:19:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ikent@redhat.com, onestero@redhat.com
Subject: Re: [PATCH v2 0/4] proc: improve root readdir latency with many
 threads
Message-ID: <YsyF3rK1YV57HDM/@casper.infradead.org>
References: <20220711135237.173667-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711135237.173667-1-bfoster@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 11, 2022 at 09:52:33AM -0400, Brian Foster wrote:
> Hi all,
> 
> Here's v2 of the /proc readdir optimization patches. See v1 for the full
> introductary cover letter.

I really don't want to change the radix tree or IDR code.  That's why
I did the conversion of the pid code to use the XArray for you.

> The refactoring in v2 adds a bit more to the idr code, but it remains
> trivial with respect to eventual xarray (tag -> mark) conversion. On
> that topic, I'm still looking for some feedback in the v1 thread [1] on
> the prospective approach...

Oh, I missed the last few emails in that thread due to being on holiday.
I'll go back and read/reply to them now.
