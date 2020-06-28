Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E412A20C6BC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jun 2020 09:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgF1HUQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Jun 2020 03:20:16 -0400
Received: from verein.lst.de ([213.95.11.211]:55600 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgF1HUQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Jun 2020 03:20:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BAD6F68AFE; Sun, 28 Jun 2020 09:20:12 +0200 (CEST)
Date:   Sun, 28 Jun 2020 09:20:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] stop using ->read and ->write for kernel access v2
Message-ID: <20200628072012.GA16344@lst.de>
References: <20200626075836.1998185-1-hch@lst.de> <CAHk-=wiFVdi_AGKvUH5FWfD4Pe-dFa+iYPzS174AHKx_ZsjW5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiFVdi_AGKvUH5FWfD4Pe-dFa+iYPzS174AHKx_ZsjW5w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 27, 2020 at 03:15:00PM -0700, Linus Torvalds wrote:
> > as part of removing set_fs entirely (for which I have a working
> > prototype), we need to stop calling ->read and ->write with kernel
> > pointers under set_fs.
> >
> > My previous "clean up kernel_{read,write} & friends v5" series, on which
> > this one builds, consolidate those calls into the __ḵernel_{read,write}
> > helpers.  This series goes further and removes the option to call
> > ->read and ->write with kernel pointers entirely.
> 
> Ack. I scanned through these and didn't find anything odd.
> 
> Which either means that it's all good, or that my scanning was too
> limited. But this does feel like the right way to go about things.

Thanks.  If we move forward with this I'd like to get it merge soon
so that we get an as long as possible exposure in linux-next to find
the occasional candidate that needs to be converted to the iter ops.
