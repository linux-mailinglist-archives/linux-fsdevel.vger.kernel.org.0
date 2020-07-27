Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9651722E60F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 08:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgG0GuA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 02:50:00 -0400
Received: from verein.lst.de ([213.95.11.211]:42221 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgG0GuA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:50:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2774168B05; Mon, 27 Jul 2020 08:49:58 +0200 (CEST)
Date:   Mon, 27 Jul 2020 08:49:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     hpa@zytor.com
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/23] init: open code setting up stdin/stdout/stderr
Message-ID: <20200727064957.GB2317@lst.de>
References: <20200714190427.4332-1-hch@lst.de> <20200714190427.4332-19-hch@lst.de> <20200727030534.GD795125@ZenIV.linux.org.uk> <F3DAF5DA-82C2-4833-805D-4F54F7C4326E@zytor.com> <20200727062425.GA2005@lst.de> <366377E2-6F19-45E1-9285-CFA5E660C6B5@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <366377E2-6F19-45E1-9285-CFA5E660C6B5@zytor.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 26, 2020 at 11:36:15PM -0700, hpa@zytor.com wrote:
> >Err, why?  The changes have been pretty simple, and I'd rather not come
> >up with new crazy ways just to make things complicated.
> 
> Why? To avoid this neverending avalanche of special interfaces and layering violations. Neatly deals with non-contiguous contents and initramfs in device memory, etc. etc. etc.

I don't think it will be all that simple.  But given that linux-next
is just missing one series Al was already ok with to kill off set_fs
entirely for about half of our architectures I'd rather go ahead with
this series.  If you can send a series mapping user memory that actually
cleans things up on top of it I'm not going to complain, but I'm not
sure it really is going to be all that much cleaner.
