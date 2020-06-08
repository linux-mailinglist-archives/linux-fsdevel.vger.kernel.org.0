Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7DD1F12B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 08:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgFHGPF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 02:15:05 -0400
Received: from verein.lst.de ([213.95.11.211]:35990 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726929AbgFHGPF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 02:15:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2491468AFE; Mon,  8 Jun 2020 08:15:03 +0200 (CEST)
Date:   Mon, 8 Jun 2020 08:15:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     viro@zeniv.linux.org.uk, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Jan Kara <jack@suse.cz>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH v4] block: Fix use-after-free in blkdev_get()
Message-ID: <20200608061502.GB17366@lst.de>
References: <20200608020557.31668-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608020557.31668-1-yanaijie@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Can you dig into the history for a proper fixes tag?
