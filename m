Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CE8211B6F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 07:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgGBFPS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 01:15:18 -0400
Received: from verein.lst.de ([213.95.11.211]:42629 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgGBFPS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 01:15:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 63EDC68B02; Thu,  2 Jul 2020 07:15:13 +0200 (CEST)
Date:   Thu, 2 Jul 2020 07:15:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 19/23] sysctl: Call sysctl_head_finish on error
Message-ID: <20200702051512.GA30361@lst.de>
References: <20200701200951.3603160-1-hch@lst.de> <20200701200951.3603160-20-hch@lst.de> <20200702003240.GW25523@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702003240.GW25523@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 02, 2020 at 01:32:40AM +0100, Matthew Wilcox wrote:
> On Wed, Jul 01, 2020 at 10:09:47PM +0200, Christoph Hellwig wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > This error path returned directly instead of calling sysctl_head_finish().
> > 
> > Fixes: ef9d965bc8b6 ("sysctl: reject gigantic reads/write to sysctl files")
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> I think this one needs to go to Linus before 5.8, not get stuck in the
> middle of a large patch series.

I've only kept it here because it didn't show up in Linus tree yet.
If you send it and it gets picked up I can trivially drop it.
