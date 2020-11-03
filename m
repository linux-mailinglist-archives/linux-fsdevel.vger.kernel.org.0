Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B322A4F98
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 20:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgKCTC5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 14:02:57 -0500
Received: from verein.lst.de ([213.95.11.211]:38744 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbgKCTC5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:02:57 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1CB3C6736F; Tue,  3 Nov 2020 20:02:54 +0100 (CET)
Date:   Tue, 3 Nov 2020 20:02:53 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support splice reads on seq_file based procfs files
Message-ID: <20201103190253.GA24382@lst.de>
References: <20201029100950.46668-1-hch@lst.de> <20201103184815.GA24136@lst.de> <CAHk-=wha+F9-my8=3KO7TNJ7r-fVobMrXRdUuSs5c2bbqk1edA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wha+F9-my8=3KO7TNJ7r-fVobMrXRdUuSs5c2bbqk1edA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 10:57:10AM -0800, Linus Torvalds wrote:
> On Tue, Nov 3, 2020 at 10:48 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > ping?
> 
> It looked fine by me, although honestly, I'd prefer that last patch to
> be the minimum possible if we want this for 5.10.
> 
> Yeah, that might technically be just cpuinfo, but I'd be ok with the
> other read-only core proc files (ie I would *not* add it to anything
> that has a .proc_write operation like the ones in proc_net.c).
> 
> IOW, I'd start with just cpuinfo_proc_ops, proc_seq_ops,
> proc_single_ops, and stat_proc_ops.

I think Greg reported another test case hitting /proc/version

> 
> Because honestly, I'd rather restrict splice() as much as possible
> than try to say "everything should be able to do splice".

sure.
