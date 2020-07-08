Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18888218A08
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 16:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbgGHOWQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 10:22:16 -0400
Received: from verein.lst.de ([213.95.11.211]:35608 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729468AbgGHOWQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 10:22:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4C7A868AFE; Wed,  8 Jul 2020 16:22:13 +0200 (CEST)
Date:   Wed, 8 Jul 2020 16:22:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-raid@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/6] mmc: remove the call to check_disk_change
Message-ID: <20200708142212.GA22601@lst.de>
References: <20200708122546.214579-1-hch@lst.de> <20200708122546.214579-7-hch@lst.de> <CAPDyKFr5+LRRGMYhWM2At=O9LQSPmFAp0YuQiwmRiV1a6Tx6=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr5+LRRGMYhWM2At=O9LQSPmFAp0YuQiwmRiV1a6Tx6=g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 08, 2020 at 04:17:26PM +0200, Ulf Hansson wrote:
> On Wed, 8 Jul 2020 at 14:41, Christoph Hellwig <hch@lst.de> wrote:
> >
> > The mmc driver doesn't support event notifications, which means
> > that check_disk_change is a no-op.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> I can queue this via my mmc tree, but perhaps you have plans for some
> additional cleanups on top? In such a case, it may be better that this
> goes through Jens' tree?

I have some vague plans.  They might or might not hit this merge window,
so if you are fine with Jens picking up the whole thing that would
avoid any potential problems.
