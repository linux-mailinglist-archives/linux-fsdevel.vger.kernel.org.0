Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA0420B1B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 14:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgFZMse (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 08:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFZMsd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:48:33 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B820CC08C5DB;
        Fri, 26 Jun 2020 05:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+40x5yR6xPYbcwqoWM0biH3squaIsHabGxmwaNuoCGw=; b=nrkb5+mece4M7+1eYiN4csS8eg
        iKRDSAkUbEoffe6SeE5BRFmaE1V7S+kUEPSXpBsIqhk9U8Jq2whlDUEzaVdPiXXafbLBUvOb3W+gP
        VGcgWSz4jLlN/XpZSEIfkW18V7LjhMpJLkFarDhCIPeXy0/xIjznpt+rjvKrXLr5tYZyfqEk51I+8
        dP7LOfBhra11C1sgRvTMv+jzhaTsmEoelHDEOV0f9daau9WNruU88Ujy6hpubnStsxuWLU3z791lM
        Fe373xh9eMxnsyZC7PCcoUgQbzrMW9LJRJSKSWlTx96umV8b94hFWzU2OGthjYWxabxw59oekeCsU
        6eTj2+cA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jonRq-0003Uu-FZ; Fri, 26 Jun 2020 12:27:15 +0000
Date:   Fri, 26 Jun 2020 13:27:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/9] sysctl: Call sysctl_head_finish on error
Message-ID: <20200626122713.GA25039@casper.infradead.org>
References: <20200626075836.1998185-1-hch@lst.de>
 <20200626075836.1998185-7-hch@lst.de>
 <20200626121701.GM4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626121701.GM4332@42.do-not-panic.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 26, 2020 at 12:17:01PM +0000, Luis Chamberlain wrote:
> On Fri, Jun 26, 2020 at 09:58:33AM +0200, Christoph Hellwig wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > This error path returned directly instead of calling sysctl_head_finish().
> 
> And if the commit log can say why this was bad. Found through code
> inspection from what I recall right?

I don't know why it's bad, it's just different from every other exit
path from this function, and it's user-triggerable, so it just needs to
get fixed.
