Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B636942DBBD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 16:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhJNOev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 10:34:51 -0400
Received: from verein.lst.de ([213.95.11.211]:50310 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbhJNOev (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 10:34:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 703CC68B05; Thu, 14 Oct 2021 16:32:43 +0200 (CEST)
Date:   Thu, 14 Oct 2021 16:32:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [sparc64] kernel OOPS (was: [PATCH 4/5] block: move the bdi
 from the request_queue to the gendisk)
Message-ID: <20211014143243.GA25700@lst.de>
References: <20210809141744.1203023-1-hch@lst.de> <20210809141744.1203023-5-hch@lst.de> <20211014143123.GA22126@u164.east.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014143123.GA22126@u164.east.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Anatoly,

please try this patchset:

https://lore.kernel.org/linux-block/CAHj4cs8tYY-ShH=QdrVirwXqX4Uze6ewZAGew_oRKLL_CCLNJg@mail.gmail.com/T/#m6591be7882bf30f3538a8baafbac1712f0763ebb


