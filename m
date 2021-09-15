Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F3140C00C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 09:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbhIOHGH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 03:06:07 -0400
Received: from verein.lst.de ([213.95.11.211]:35119 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231301AbhIOHGG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:06:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 847D767373; Wed, 15 Sep 2021 09:04:45 +0200 (CEST)
Date:   Wed, 15 Sep 2021 09:04:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] xfs: convert xfs_sysfs attrs to use ->seq_show
Message-ID: <20210915070445.GA17384@lst.de>
References: <20210913054121.616001-1-hch@lst.de> <20210913054121.616001-14-hch@lst.de> <YT7vZthsMCM1uKxm@kroah.com> <20210914073003.GA31077@lst.de> <YUC/iH9yLlxblM09@kroah.com> <20210914153011.GA815@lst.de> <YUDCsXXNFfUyiMCk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUDCsXXNFfUyiMCk@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 05:41:37PM +0200, Greg Kroah-Hartman wrote:
> They huge majority of sysfs attributes are "trivial".  So for maybe at
> least 95% of the users, if not more, using sysfs_emit() is just fine as
> all you "should" be doing is emitting a single value.

It is just fine if no one does the obvious mistakes that an interface
with a char * pointer leads to.  And 5% of all attributes is still a huge
attack surface.
