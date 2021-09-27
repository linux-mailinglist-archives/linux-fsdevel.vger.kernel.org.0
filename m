Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244A04193A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 13:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhI0Lw4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 07:52:56 -0400
Received: from verein.lst.de ([213.95.11.211]:46388 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234053AbhI0Lw4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:52:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 566C667373; Mon, 27 Sep 2021 13:51:16 +0200 (CEST)
Date:   Mon, 27 Sep 2021 13:51:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     nvdimm@lists.linux.dev, hch@lst.de, linux-fsdevel@vger.kernel.org
Subject: Re: [regression] fs dax xfstests panic
Message-ID: <20210927115116.GB23909@lst.de>
References: <20210927061747.rijhtovxafsot32z@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927061747.rijhtovxafsot32z@xzhoux.usersys.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 02:17:47PM +0800, Murphy Zhou wrote:
> Hi folks,
> 
> Since this commit:
> 
> commit edb0872f44ec9976ea6d052cb4b93cd2d23ac2ba
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Mon Aug 9 16:17:43 2021 +0200
> 
>     block: move the bdi from the request_queue to the gendisk
> 
> 
> Looping xfstests generic/108 or xfs/279 on mountpoints with fsdax
> enabled can lead to panic like this:

Does this still happen with this series:

https://lore.kernel.org/linux-block/20210922172222.2453343-1-hch@lst.de/T/#m8dc646a4dfc40f443227da6bb1c77d9daec524db

?
