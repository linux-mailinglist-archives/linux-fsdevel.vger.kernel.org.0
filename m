Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DA41C2388
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 May 2020 08:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgEBGXx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 May 2020 02:23:53 -0400
Received: from verein.lst.de ([213.95.11.211]:50177 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgEBGXx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 May 2020 02:23:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 52DDE68C4E; Sat,  2 May 2020 08:23:51 +0200 (CEST)
Date:   Sat, 2 May 2020 08:23:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] exec: open code copy_string_kernel
Message-ID: <20200502062351.GA2158@lst.de>
References: <20200501104105.2621149-1-hch@lst.de> <20200501104105.2621149-3-hch@lst.de> <20200501141903.5f7b1f81fdd38ae372d91f0e@linux-foundation.org> <20200501213048.GO23230@ZenIV.linux.org.uk> <20200501144013.be5bf036ab7f2d2303676bce@linux-foundation.org> <20200501220449.GQ23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501220449.GQ23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 01, 2020 at 11:04:49PM +0100, Al Viro wrote:
> Long story - basically, it's been a source of massive headache too many times.
> No formal project, but there are several people (me, Arnd, Christoph) who'd
> been reducing its use.  For more than a decade now, I think...
> 
> FWIW, I doubt that it will be entirely killable; Christoph appears to be
> more optimistic.  In any case, its use has been greatly reduced and having
> it narrowed down to even fewer places would be a good thing.
> 
> In the same direction: use_mm()/unuse_mm() regularization wrt set_fs(), getting
> rid of it in coredump code, some movements towards killing ioctl_by_bdev();
> not sure if I've spotted everything - Christoph?

That's the big current projects out in the wild.  I have a few more
growing.
