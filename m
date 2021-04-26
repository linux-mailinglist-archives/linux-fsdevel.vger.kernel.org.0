Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754A936B786
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 19:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhDZRGL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 13:06:11 -0400
Received: from verein.lst.de ([213.95.11.211]:42164 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235548AbhDZRGB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:06:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1FF8868C4E; Mon, 26 Apr 2021 19:05:17 +0200 (CEST)
Date:   Mon, 26 Apr 2021 19:05:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: switch block layer polling to a bio based model
Message-ID: <20210426170516.GA1443@lst.de>
References: <20210426134821.2191160-1-hch@lst.de> <2d229167-f56d-583b-569c-166c97ce2e71@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d229167-f56d-583b-569c-166c97ce2e71@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Can you test the force pushed update?  This now avoids the RCU free
for each bio and just uses SLAB_TYPESAFE_BY_RCU instead.
