Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A911E75A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 07:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgE2Fvf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 01:51:35 -0400
Received: from verein.lst.de ([213.95.11.211]:59701 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgE2Fvf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 01:51:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A423568BFE; Fri, 29 May 2020 07:51:31 +0200 (CEST)
Date:   Fri, 29 May 2020 07:51:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 06/14] fs: remove the call_{read,write}_iter functions
Message-ID: <20200529055131.GA6788@lst.de>
References: <20200528054043.621510-1-hch@lst.de> <20200528054043.621510-7-hch@lst.de> <20200528185643.GL23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528185643.GL23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 07:56:43PM +0100, Al Viro wrote:
> On Thu, May 28, 2020 at 07:40:35AM +0200, Christoph Hellwig wrote:
> > Just open coding the methods calls is a lot easier to follow.
> 
> Not sure about this one, TBH - it's harder to grep that way, since
> you get all the initializers for read_iter/write_iter thrown into
> the mix.  Sure, you can do something like '\->[ 	]*read_iter\>',
> but it's a PITA.

Which you have to do anyway as not all calls go through these weird
helpers.
