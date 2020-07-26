Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B6622DD31
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 10:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGZIVW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 04:21:22 -0400
Received: from verein.lst.de ([213.95.11.211]:39929 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgGZIVW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 04:21:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DD91168B05; Sun, 26 Jul 2020 10:21:18 +0200 (CEST)
Date:   Sun, 26 Jul 2020 10:21:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 04/21] devtmpfs: refactor devtmpfsd()
Message-ID: <20200726082118.GA17726@lst.de>
References: <20200726071356.287160-1-hch@lst.de> <20200726071356.287160-5-hch@lst.de> <20200726074306.GA444745@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726074306.GA444745@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 26, 2020 at 09:43:06AM +0200, Greg Kroah-Hartman wrote:
> On Sun, Jul 26, 2020 at 09:13:39AM +0200, Christoph Hellwig wrote:
> > Split the main worker loop into a separate function.  This allows
> > devtmpfsd itself and devtmpfsd_setup to be marked __init, which will
> > allows us to call __init routines for the setup work.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/base/devtmpfs.c | 47 +++++++++++++++++++++++------------------
> >  1 file changed, 26 insertions(+), 21 deletions(-)
> 
> Nice cleanup, thanks for doing this:

This was actualy Als idea, I should have probably mentioned that.
