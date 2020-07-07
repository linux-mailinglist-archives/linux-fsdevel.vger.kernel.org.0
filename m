Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854F92168C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 11:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgGGJDy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 05:03:54 -0400
Received: from verein.lst.de ([213.95.11.211]:57868 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgGGJDy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:03:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3A0A168AFE; Tue,  7 Jul 2020 11:03:51 +0200 (CEST)
Date:   Tue, 7 Jul 2020 11:03:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/16] initrd: remove the BLKFLSBUF call in
 handle_initrd
Message-ID: <20200707090350.GA28510@lst.de>
References: <20200615125323.930983-1-hch@lst.de> <20200615125323.930983-10-hch@lst.de> <514b0176-d235-f640-b278-9a7d49af356f@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <514b0176-d235-f640-b278-9a7d49af356f@zytor.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 02, 2020 at 08:40:31PM -0700, H. Peter Anvin wrote:
> On 2020-06-15 05:53, Christoph Hellwig wrote:
> > BLKFLSBUF used to be overloaded for the ramdisk driver to free the whole
> > ramdisk, which was completely different behavior compared to all other
> > drivers.  But this magic overload got removed in commit ff26956875c2
> > ("brd: remove support for BLKFLSBUF"), so this call is entirely
> > pointless now.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Does *anyone* use initrd as opposed to initramfs anymore? It would seem
> like a good candidate for deprecation/removal.

I thought about that as well.  I think deprecating it at least is a good
idea and can add a patch doing that to the next version.
