Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B1B37B6EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 09:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhELHbB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 03:31:01 -0400
Received: from verein.lst.de ([213.95.11.211]:40140 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230211AbhELHaf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 03:30:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D576A68AFE; Wed, 12 May 2021 09:29:23 +0200 (CEST)
Date:   Wed, 12 May 2021 09:29:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Gulam Mohamed <gulam.mohamed@oracle.com>,
        viro@zeniv.linux.org.uk, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        junxiao.bi@oracle.com
Subject: Re: [PATCH V1 1/1] Fix race between iscsi logout and systemd-udevd
Message-ID: <20210512072923.GA22690@lst.de>
References: <20210511181558.380764-1-gulam.mohamed@oracle.com> <YJtKT7rLi2CFqDsV@T590> <20210512063505.GA18367@lst.de> <YJuCXh2ykAuDcuTb@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJuCXh2ykAuDcuTb@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 12, 2021 at 03:23:10PM +0800, Ming Lei wrote:
> This patch looks fine, and new openers can be prevented really with help
> of ->open_mutex.

Yes.  I have a patch directly on top of block-5.13 without my open_mutex
series undergoing testing right now.  I'll post it later today.
