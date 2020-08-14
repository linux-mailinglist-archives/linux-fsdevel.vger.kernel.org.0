Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36E3244485
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Aug 2020 07:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgHNF2D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Aug 2020 01:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgHNF2D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Aug 2020 01:28:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762E8C061757;
        Thu, 13 Aug 2020 22:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zum0YIlqmhHS3QFdM5uxhyHhjwPh766nrYcKVM2Z7Xc=; b=eDP3xueFlAEEI++oq+SQUo+kvC
        g+4Rzw6l7n7Yk13S85jeXb4cauZEa3kNZZ+k662zmmqNcyz7lrH6khtiPZYp/nYf/eBTGVd4WHCaV
        lMu4i6Nuqg8V7iDIiGs1pQt6YTBth1JIiVJa8aY8+maFUIlkarAIjG4mkcjg8JscYmN8rKthRh0tD
        ecLlTxqfTpAITC3vBUihZ5OZ42RspfmDAt1FwGSiNcK0mVftQq/bBvlp2bw4K4huV35wwLcMBNPmw
        xiQi0qTvKU6bOcMpGTZYzaGM8ISzmJFYXt58vCcmas/5jG0+wFQwqTtCB4zdLL+QtixwiusvO3S/F
        gySFhDOQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6SG1-0002t7-4W; Fri, 14 Aug 2020 05:28:01 +0000
Date:   Fri, 14 Aug 2020 06:28:01 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Pascal Bouchareine <kalou@tfz.net>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH v4 2/2] fcntl: introduce F_SET_DESCRIPTION
Message-ID: <20200814052801.GA10141@infradead.org>
References: <20200814035453.210716-1-kalou@tfz.net>
 <20200814035453.210716-3-kalou@tfz.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814035453.210716-3-kalou@tfz.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 13, 2020 at 08:54:53PM -0700, Pascal Bouchareine wrote:
> This command attaches a description to a file descriptor for
> troubleshooting purposes. The free string is displayed in the
> process fdinfo file for that fd /proc/pid/fdinfo/fd.
> 
> One intended usage is to allow processes to self-document sockets
> for netstat and friends to report

NAK.  There is no way we're going to bloat a criticial structure like
struct file for some vanity information like this.
