Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F9B40B31A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 17:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbhINPbd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 11:31:33 -0400
Received: from verein.lst.de ([213.95.11.211]:60835 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233202AbhINPbd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:31:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 56AEB68AFE; Tue, 14 Sep 2021 17:30:12 +0200 (CEST)
Date:   Tue, 14 Sep 2021 17:30:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] xfs: convert xfs_sysfs attrs to use ->seq_show
Message-ID: <20210914153011.GA815@lst.de>
References: <20210913054121.616001-1-hch@lst.de> <20210913054121.616001-14-hch@lst.de> <YT7vZthsMCM1uKxm@kroah.com> <20210914073003.GA31077@lst.de> <YUC/iH9yLlxblM09@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUC/iH9yLlxblM09@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 05:28:08PM +0200, Greg Kroah-Hartman wrote:
> We can "force" it by not allowing buffers to be bigger than that, which
> is what the code has always done.  I think we want to keep that for now
> and not add the new seq_show api.

The buffer already is not larger than that.  The problem is that
sysfs_emit does not actually work for the non-trivial attributes,
which generally are the source of bugs.
