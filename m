Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 676BA5A029
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 18:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfF1QCc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 12:02:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfF1QCc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GyhiC5rh5R/SA3JdFPBdp/fqKIvCDnAaiwOHr5+37xI=; b=sJFGMpBOwecab1Pbl4HEXHNu2
        /wBUXjIy6p22D3vgPvvlNhozFXM+KVKACnPL2NbJPVrAZFuKp+3HDfOYnL1Mc7LHP8DLAzdTCKL/M
        jtQ4Y3JO+eMQlOMEbamh/I0lbFBEmJ/iyZ9EL953YZEt+lcnut1AuQAOJt6eyq3Y4XJvw/K/hS0f2
        6B7ffZYBcXBu2DeKaHMcFjnO0S5AVIUHx5MiNwuUgl2xWqOhrvhifabag26uh6oHjTBDee+1w7g9a
        70GpxMVxu0L9Q8NCfgXV5BtLdzrFawxxAHWGZdac3NONSLG0sPJ4Y1oZWTuR2A96BAs07erkqYY/P
        oibYd4g9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hgtKY-0006oo-Om; Fri, 28 Jun 2019 16:02:30 +0000
Date:   Fri, 28 Jun 2019 09:02:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fat: Add nobarrier to workaround the strange behavior of
 device
Message-ID: <20190628160230.GA24232@infradead.org>
References: <871rzdrdxw.fsf@mail.parknet.co.jp>
 <20190628143216.GA538@infradead.org>
 <87pnmxpx9p.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnmxpx9p.fsf@mail.parknet.co.jp>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 29, 2019 at 12:03:46AM +0900, OGAWA Hirofumi wrote:
> I see, sounds like good though. Does it work for all stable versions?
> Can it disable only flush command without other effect? And it would be
> better to be normal user controllable easily.

The option was added in 2.6.17, so it's been around forever.  But
no, it obviously is not user exposed as using it on a normal drive
can lead to data loss.
