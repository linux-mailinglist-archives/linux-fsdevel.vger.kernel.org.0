Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6F335843B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 15:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhDHNKm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 09:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhDHNKl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:10:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D726C061760
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Apr 2021 06:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GyOWOoyPXcNXC/fx2ulYrcPr43XWPruw+BRPnWGm3Z8=; b=EihRiLIYF+p9dAMS9DhZCI0cOE
        SN9hEagl56MM7nH0+X1OIRX+I7C5rJAYDn+T6yRAYFEjNlHxY5uxh+Un38n3PsUZdaJwVQNuGZp5q
        iu2lyPYLLRKIT0syH5dMzaYYmgNDYG4pB6g1Gj3BjveNC6aQ69DcSr62HSFXflHBVFAIsCovuXt2Q
        hLc3FJW97F9jTW4fngdBq8MHLnnMdQmDmYhQRDatjL1zxaAszkdVURlVRhUhYF47ym0pOikk9moye
        KYMgvcq7j5zbQJBF0wLqyf7M0MQuxX6pG2nSxbSkgvjQuoi+7JymbyaaPV/hRH8/6YfNPlYlUF069
        eAjqy8lg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUUPb-00GDW8-6s; Thu, 08 Apr 2021 13:09:47 +0000
Date:   Thu, 8 Apr 2021 14:09:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     jlayton@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm, netfs: Fix readahead bits
Message-ID: <20210408130931.GM2531743@casper.infradead.org>
References: <20210407201857.3582797-4-willy@infradead.org>
 <20210407201857.3582797-1-willy@infradead.org>
 <1234933.1617886271@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1234933.1617886271@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 08, 2021 at 01:51:11PM +0100, David Howells wrote:
> Hi Willy, Jeff,
> 
> I think we need the attached change to readahead_expand() to fix the oops seen
> when it tries to dereference ractl->ra when called indirectly from
> netfs_write_begin().
> 
> netfs_write_begin() should also be using DEFINE_READAHEAD() rather than
> manually initialising the ractl variable so that Willy can find it;-).

ACK.  Please fold into the appropriate patches.
