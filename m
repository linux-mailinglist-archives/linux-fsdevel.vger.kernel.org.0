Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D9D1B6E82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 08:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgDXGw5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 02:52:57 -0400
Received: from verein.lst.de ([213.95.11.211]:33420 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbgDXGw5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 02:52:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D49B568CEC; Fri, 24 Apr 2020 08:52:53 +0200 (CEST)
Date:   Fri, 24 Apr 2020 08:52:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] isofs: stop using ioctl_by_bdev
Message-ID: <20200424065253.GB23754@lst.de>
References: <20200423071224.500849-1-hch@lst.de> <20200423071224.500849-7-hch@lst.de> <20200423110347.GE3737@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423110347.GE3737@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 23, 2020 at 01:03:47PM +0200, Jan Kara wrote:
> There's no error handling in the caller and this function actually returns
> unsigned int... So I believe you need to return 0 here to maintain previous
> behavior (however suspicious it may be)?

Indeed, and I don't think it is suspicious at all - if we have no CDROM
info we should assume session 0, which is the same as for non-CDROM
devices.  Fixed for the next version.
