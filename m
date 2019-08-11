Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB73889285
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2019 18:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfHKQPk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Aug 2019 12:15:40 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49113 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726458AbfHKQPk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Aug 2019 12:15:40 -0400
Received: from callcc.thunk.org (75-104-84-221.mobility.exede.net [75.104.84.221] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7BGFE9T007584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Aug 2019 12:15:25 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9B2644218EF; Sun, 11 Aug 2019 12:15:08 -0400 (EDT)
Date:   Sun, 11 Aug 2019 12:15:08 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 1/3] ext4: return the extent cache information via fiemap
Message-ID: <20190811161508.GA5878@mit.edu>
References: <20190809181831.10618-1-tytso@mit.edu>
 <20190810073343.GA12777@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810073343.GA12777@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 10, 2019 at 12:33:43AM -0700, Christoph Hellwig wrote:
> 
> On Fri, Aug 09, 2019 at 02:18:29PM -0400, Theodore Ts'o wrote:
> > For debugging reasons, it's useful to know the contents of the extent
> > cache.  Since the extent cache contains much of what is in the fiemap
> > ioctl, extend the fiemap interface to return this information via some
> > ext4-specific flags.
> 
> Nak.  No weird fs specific fiemap flags that aren't even in the uapi
> header.  Please provide your own debug only interface.

I can understand why you don't like this from the principle of the
thing.

I'll create my own ioctl, and make a copy of ioctl_fiemap() into ext4
and modify it for my needs.  I was trying to avoid needing to do that,
since there is plenty of space in the fiemap flags to carve out space
for file-specific specific flags, and avoiding making extra copies of
code for the purposes of reuse weighed more heavily than "no
fs-specific fiemap flags".

						- Ted
