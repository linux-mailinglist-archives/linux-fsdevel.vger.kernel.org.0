Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD9D22611E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 15:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgGTNiv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 09:38:51 -0400
Received: from verein.lst.de ([213.95.11.211]:47004 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgGTNiu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:38:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2B2BF68BFE; Mon, 20 Jul 2020 15:38:49 +0200 (CEST)
Date:   Mon, 20 Jul 2020 15:38:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] fs: fix kiocb ki_complete interface
Message-ID: <20200720133849.GA3342@lst.de>
References: <20200720132118.10934-1-johannes.thumshirn@wdc.com> <20200720132118.10934-2-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720132118.10934-2-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 10:21:17PM +0900, Johannes Thumshirn wrote:
> From: Damien Le Moal <damien.lemoal@wdc.com>
> 
> The res and res2 fields of struct io_event are signed 64 bits values
> (__s64 type). Allow the ki_complete method of struct kiocb to set 64
> bits values in these fields by changin its interface from the long type
> to long long.

Which doesn't help if the consumers can't deal with these values.
But that shouldn't even be required for using zone append anyway..
