Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F68722E147
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 18:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgGZQ0b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 12:26:31 -0400
Received: from verein.lst.de ([213.95.11.211]:40849 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgGZQ0b (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 12:26:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 61F4A68B05; Sun, 26 Jul 2020 18:26:27 +0200 (CEST)
Date:   Sun, 26 Jul 2020 18:26:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: add file system helpers that take kernel pointers for the init
 code v3
Message-ID: <20200726162627.GA24522@lst.de>
References: <20200726071356.287160-1-hch@lst.de> <CAHk-=wgq8evViJD9Hnjugq=V0eUAn7K6ZjOP7P7qki-nOTx_jg@mail.gmail.com> <20200726155204.GA24103@lst.de> <20200726162113.GR2786714@ZenIV.linux.org.uk> <20200726162426.GA24479@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726162426.GA24479@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 26, 2020 at 06:24:26PM +0200, Christoph Hellwig wrote:
> Btw, care to take a look at 
> 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/kernel_readwrite
> 
> it has been in linux-next for 2 1/2 weeks, and the only interesting
> thing found was that btrfs didn't wire up iter_splice_write, which has
> already been fixed in mainline.

Actually, the above is a stale old branch sorry.  The real one that has
been in linux-next is:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/set_fs-rw
