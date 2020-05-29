Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967701E7D49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 14:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgE2Mcn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 08:32:43 -0400
Received: from verein.lst.de ([213.95.11.211]:32812 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbgE2Mcn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 08:32:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8B0A968B02; Fri, 29 May 2020 14:32:39 +0200 (CEST)
Date:   Fri, 29 May 2020 14:32:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH 09/14] fs: don't change the address limit for
 ->write_iter in __kernel_write
Message-ID: <20200529123239.GA28608@lst.de>
References: <20200528054043.621510-1-hch@lst.de> <20200528054043.621510-10-hch@lst.de> <CAHk-=wgpnR9sBeie_z0xA3mYzG50Oiw1jZjyHt0eLX6p45ARvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgpnR9sBeie_z0xA3mYzG50Oiw1jZjyHt0eLX6p45ARvQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 11:43:13AM -0700, Linus Torvalds wrote:
> On Wed, May 27, 2020 at 10:41 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > -ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
> > +ssize_t __kernel_write(struct file *file, const void *buf, size_t count,
> > +               loff_t *pos)
> 
> Please don't do these kinds of pointless whitespace changes.
> 
> If you have an actual 80x25 vt100 sitting in a corner, it's not really
> conducive to kernel development any more.

I have real 80x25 xterms, as that allows me to comfortably fit 4 of
them onto my latop screen.
