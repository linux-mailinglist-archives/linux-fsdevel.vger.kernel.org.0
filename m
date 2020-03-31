Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC6EC198D4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 09:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgCaHq3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 03:46:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43066 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgCaHq3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 03:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AWf8xAFbvPHYaPOzqDNVG4lYxmJsy5ZnxA9Ca86A/Bw=; b=rjoDf/+59KDmOXbQ3mBNjvPtFJ
        dd02Xr38874GNJeNd9YSfB+2WQGw80ng/57gI7WjwDnrptO8yq6dKGm+85vMVlQEKSTeJgFJSGl4Y
        FOHGgBFe/Dfse05LixLsGC6waa6JRa+O+yrNVJBMv2aKd7Wm1+dPikbhWpy/SWdvws8efXD8QNqCh
        hltFrCExeU4hLYH9ip0CiMoCWH/rfzEAUtLJxM5lrKDOyEhIQFNorBWM938EYDL2Lsw5I82TKMZTN
        YyCzXRQ83seom0RrMeM4/w0CZUEdhg/eC7ccjjTdakDyZkwvoqi0irn3O27dp34eM+EOxd0VIv6JS
        LnAXhK7Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJBbQ-0004ts-LR; Tue, 31 Mar 2020 07:46:28 +0000
Date:   Tue, 31 Mar 2020 00:46:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC] iomap: Remove indirect function call
Message-ID: <20200331074628.GA9872@infradead.org>
References: <20200328155156.GS22483@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328155156.GS22483@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 28, 2020 at 08:51:56AM -0700, Matthew Wilcox wrote:
> By splitting iomap_apply into __iomap_apply and an inline iomap_apply,
> we convert the call to 'actor' into a direct function call.  I haven't
> done any performance measurements, but given the current costs of indirect
> function calls, this would seem worthwhile to me?

Hmm.  Given that emount of compiler stupidity we are dealing with did
you at least look at the assembly output to see if this actually removes
the indirect call?  I wouldn't be quite sure.
