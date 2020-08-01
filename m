Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0DF2353DD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Aug 2020 19:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHARlN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Aug 2020 13:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgHARlN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Aug 2020 13:41:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAE8C06174A;
        Sat,  1 Aug 2020 10:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vQRgZyGmY0l7f7VijR9AHb4oo8ffbUo17g7lo4AYv3Y=; b=rFd3L+k4Ff6rWRgQvfZIW/q1+C
        m5g+o79qyvMlTLBnP+pl4dkdPD2ZWLu9oDQaElnthDpB1oIb5V93SuFwPEQ3xIa4r/WO/ifblCXqH
        HRklMKWEy2R9l8N7O2r+mXAGpEKdWvysuaC0RzdjHHbAuisZQr+cKyH4VMsDyh5b2rSnJt4GYVks2
        ZlvZ8OTh1zTaPNgOiSXP9DI54OPn8YPYHzNA3YuUmhebMNakIEenxxD1ZONYj4GOFIELR0z5ts9+j
        lwxeevCW09tzHCj83HprBoOW5JCzQ6pqbQ+FvHJWkH7vDn4g2kqmumzy/d4i9zGMqAUbxd4l/ZeyT
        2P99VHFg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1vVO-0002QZ-DX; Sat, 01 Aug 2020 17:41:10 +0000
Date:   Sat, 1 Aug 2020 18:41:10 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] splice: direct call for default_file_splice*()
Message-ID: <20200801174110.GA8535@infradead.org>
References: <12375b7baa741f0596d54eafc6b1cfd2489dd65a.1579553271.git.asml.silence@gmail.com>
 <20200130165425.GA8872@infradead.org>
 <0618f315-7061-c3fd-15d3-c19cea48cc4c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0618f315-7061-c3fd-15d3-c19cea48cc4c@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 01, 2020 at 01:12:22PM +0300, Pavel Begunkov wrote:
> On 30/01/2020 19:54, Christoph Hellwig wrote:
> > On Mon, Jan 20, 2020 at 11:49:46PM +0300, Pavel Begunkov wrote:
> >> Indirect calls could be very expensive nowadays, so try to use direct calls
> >> whenever possible.
> 
> Hah, I'm surprised to find it as
> 00c285d0d0fe4 ("fs: simplify do_splice_from").
> 
> Christoph, even though this one is not a big deal, I'm finding the
> practice of taking others patches and silently sending them as yours
> own in general disgusting. Just for you to know.

Err, what makes you think I took your patch vs just not remembering
and pointlessly doing the same cleanup again?  If I had rembered your
patch I would have just added to the series with your credit as I've
done for plenty other patches..
