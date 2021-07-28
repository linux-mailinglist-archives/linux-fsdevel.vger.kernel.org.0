Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772783D95B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 21:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhG1TB2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 15:01:28 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:49734 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhG1TB2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 15:01:28 -0400
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id A58DEE809E1;
        Wed, 28 Jul 2021 21:01:23 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 5E392160383; Wed, 28 Jul 2021 21:01:22 +0200 (CEST)
Date:   Wed, 28 Jul 2021 21:01:22 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Luca Boccassi <bluca@debian.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v5 0/5] block: add a sequence number to disks
Message-ID: <YQGpgvwLk7voeKZ3@gardel-login>
References: <20210712230530.29323-1-mcroce@linux.microsoft.com>
 <3ca56654449b53814a22e3f06179292bc959ae72.camel@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ca56654449b53814a22e3f06179292bc959ae72.camel@debian.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Di, 20.07.21 18:27, Luca Boccassi (bluca@debian.org) wrote:

> Here's the implementation, in draft state until the kernel side is
> merged:
>
> https://github.com/systemd/systemd/pull/20257

I reviewed this systemd PR now. Looks excellent. See my comments on the PR.

Jens, anything we can do to get your blessing on the kernel patch set
and get this landed?

Thank you,

Lennart
