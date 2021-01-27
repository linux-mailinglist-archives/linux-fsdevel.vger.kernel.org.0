Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2556F3060B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 17:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343932AbhA0QNI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 11:13:08 -0500
Received: from verein.lst.de ([213.95.11.211]:53580 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235382AbhA0QMt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:12:49 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5197D68AFE; Wed, 27 Jan 2021 17:12:05 +0100 (CET)
Date:   Wed, 27 Jan 2021 17:12:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Maxim Mikityanskiy <maxtram95@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "block: simplify set_init_blocksize" to regain
 lost performance
Message-ID: <20210127161205.GA21325@lst.de>
References: <20210126195907.2273494-1-maxtram95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126195907.2273494-1-maxtram95@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While this code is gross, I think we need to add it back for now:

Acked-by: Christoph Hellwig <hch@lst.de>

I'll put converting the block device buffered I/O path to iomap or
an iomap lookalike on the backburner to fix this..
