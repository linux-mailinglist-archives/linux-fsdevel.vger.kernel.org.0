Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5073622E0EF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 17:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgGZPwI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 11:52:08 -0400
Received: from verein.lst.de ([213.95.11.211]:40760 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgGZPwI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 11:52:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 16E2B68B05; Sun, 26 Jul 2020 17:52:04 +0200 (CEST)
Date:   Sun, 26 Jul 2020 17:52:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: add file system helpers that take kernel pointers for the init
 code v3
Message-ID: <20200726155204.GA24103@lst.de>
References: <20200726071356.287160-1-hch@lst.de> <CAHk-=wgq8evViJD9Hnjugq=V0eUAn7K6ZjOP7P7qki-nOTx_jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgq8evViJD9Hnjugq=V0eUAn7K6ZjOP7P7qki-nOTx_jg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 26, 2020 at 08:49:28AM -0700, Linus Torvalds wrote:
> On Sun, Jul 26, 2020 at 12:14 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Hi Al and Linus,
> >
> > currently a lot of the file system calls in the early in code (and the
> > devtmpfs kthread) rely on the implicit set_fs(KERNEL_DS) during boot.
> > This is one of the few last remaining places we need to deal with to kill
> > off set_fs entirely, so this series adds new helpers that take kernel
> > pointers.  These helpers are in init/ and marked __init and thus will
> > be discarded after bootup.  A few also need to be duplicated in devtmpfs,
> > though unfortunately.
> 
> I see nothing objectionable here.
> 
> The only bikeshed comment I have is that I think the "for_init.c" name
> is ugly and pointless - I think you could just call it "fs/init.c" and
> it's both simpler and more straightforward. It _is_ init code, it's
> not "for" init.

That was Al's suggestion.  I personally don't care, so if between the
two of you, you can come up with a preferred choice I'll switch to it.
