Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8503AEAA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 16:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhFUOCP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 10:02:15 -0400
Received: from verein.lst.de ([213.95.11.211]:42088 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhFUOCP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:02:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E305068B05; Mon, 21 Jun 2021 15:59:58 +0200 (CEST)
Date:   Mon, 21 Jun 2021 15:59:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <20210621135958.GA1013@lst.de>
References: <YM/hZgxPM+2cP+I7@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YM/hZgxPM+2cP+I7@zeniv-ca.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

What about just setting O_DSYNC in f_flags at open time if a superblock
has SB_SYNCHRONOUS set?  That means the flag won't be picked up for open
files when SB_SYNCHRONOUS is set at remount time, but I'm not even sure
we need to support it for remount.
