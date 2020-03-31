Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02874199BEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 18:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbgCaQmM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 12:42:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57130 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730442AbgCaQmM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uZ5E0WO6BJBy6aOSh2zh6JJICxRfhShrGtTHHcnqcww=; b=jw0wCsv9arFbFqYn6LQmNxh5nZ
        Fvk4IXwcuxJMLknZKreDBvaRHUwmppnjtHDXfPGPMqDUXGgeocve9yL+0X0/rxU3HPYpYdMu907xU
        CI49fRgoAVy72/zMxZgZZv8EYhBp5qyS0SajB59j2Fb6MCSjT4KfgMEiakguBTfEg4Djzwo/AmWyI
        YcBe0DpNrhBtde499wg+RRl2yK0xJBapRbsmctQ+Gz9uLNndi6SqkEgEZ11i+H2t6fPOouNwnOGd6
        VwHwcCmjwn8qknIoA8b05BGMKdQLEgELI2gpWlGwiiSO6aCeMMVRtpPcbtfOxwFnpYR8t/uWM7gSD
        PO1ZnejQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJJxs-0006df-6z; Tue, 31 Mar 2020 16:42:12 +0000
Date:   Tue, 31 Mar 2020 09:42:12 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] XArray: entry in last level is not expected to be a
 node
Message-ID: <20200331164212.GC21484@bombadil.infradead.org>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
 <20200330123643.17120-6-richard.weiyang@gmail.com>
 <20200330124842.GY22483@bombadil.infradead.org>
 <20200330141558.soeqhstone2liqud@master>
 <20200330142821.GD22483@bombadil.infradead.org>
 <20200331134208.gfkyym6n3gpgk3x3@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331134208.gfkyym6n3gpgk3x3@master>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 31, 2020 at 01:42:08PM +0000, Wei Yang wrote:
> On Mon, Mar 30, 2020 at 07:28:21AM -0700, Matthew Wilcox wrote:
> >On Mon, Mar 30, 2020 at 02:15:58PM +0000, Wei Yang wrote:
> >> On Mon, Mar 30, 2020 at 05:48:42AM -0700, Matthew Wilcox wrote:
> >> >On Mon, Mar 30, 2020 at 12:36:39PM +0000, Wei Yang wrote:
> >> >> If an entry is at the last level, whose parent's shift is 0, it is not
> >> >> expected to be a node. We can just leverage the xa_is_node() check to
> >> >> break the loop instead of check shift additionally.
> >> >
> >> >I know you didn't run the test suite after making this change.
> >> 
> >> I did kernel build test, but not the test suite as you mentioned.
> >> 
> >> Would you mind sharing some steps on using the test suite? And which case you
> >> think would trigger the problem?
> >
> >cd tools/testing/radix-tree/; make; ./main
> >
> 
> Hmm... I did a make on top of 5.6-rc6, it failed. Would you mind taking a look
> into this?

It works for me.  I run it almost every day.  What error did you see?
