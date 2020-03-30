Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9D9197E5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 16:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgC3O2W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 10:28:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58498 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgC3O2V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pLHDX3j/vvd/aAE6wS/Omu7NEbcc1BJFJb8ATkuq0Ow=; b=H5ZxYxMYQ6KS/4YYOQAIGKqodc
        KnucrkmhDRKY0CryqwaygOiu7j0rG+sBCakLO0oSRrD2tt64lhyTAdbGT1OjwuxCtV/Vdmd4IkgQu
        wlNovX8Jtq/pnu0yt+b+r1GBuB9eQDg5CHnNvHRAggXXISVJggFUP2IcAlgLYhF438uw/v0tAbBVg
        RiiQE4BK/PUExpbt5CbEqaF0JbZbaG6K1ocO05EqLGXUICCw95rzewItKvwlrZX0e1padg1ihX3q4
        cC/WBaEfAZa99nRzv9BZkQkU/kD7rBnE+OG45rPsrFGI6RSIYSl2l+y7U2NPAqtPzfhbbKF87odBc
        ChjfCYlA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIvOn-0003vP-Ji; Mon, 30 Mar 2020 14:28:21 +0000
Date:   Mon, 30 Mar 2020 07:28:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] XArray: entry in last level is not expected to be a
 node
Message-ID: <20200330142821.GD22483@bombadil.infradead.org>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
 <20200330123643.17120-6-richard.weiyang@gmail.com>
 <20200330124842.GY22483@bombadil.infradead.org>
 <20200330141558.soeqhstone2liqud@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330141558.soeqhstone2liqud@master>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 30, 2020 at 02:15:58PM +0000, Wei Yang wrote:
> On Mon, Mar 30, 2020 at 05:48:42AM -0700, Matthew Wilcox wrote:
> >On Mon, Mar 30, 2020 at 12:36:39PM +0000, Wei Yang wrote:
> >> If an entry is at the last level, whose parent's shift is 0, it is not
> >> expected to be a node. We can just leverage the xa_is_node() check to
> >> break the loop instead of check shift additionally.
> >
> >I know you didn't run the test suite after making this change.
> 
> I did kernel build test, but not the test suite as you mentioned.
> 
> Would you mind sharing some steps on using the test suite? And which case you
> think would trigger the problem?

cd tools/testing/radix-tree/; make; ./main

The IDR tests are the ones which are going to trigger on this.
