Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B692DB67D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 23:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbgLOW0O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 17:26:14 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:42901 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731552AbgLOW0K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 17:26:10 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D24B63C272E;
        Wed, 16 Dec 2020 09:25:23 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kpIl0-004MQy-R4; Wed, 16 Dec 2020 09:25:22 +1100
Date:   Wed, 16 Dec 2020 09:25:22 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH 3/4] fs: expose LOOKUP_NONBLOCK through openat2()
 RESOLVE_NONBLOCK
Message-ID: <20201215222522.GS3913616@dread.disaster.area>
References: <20201214191323.173773-1-axboe@kernel.dk>
 <20201214191323.173773-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214191323.173773-4-axboe@kernel.dk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=drOt6m5kAAAA:8 a=7-415B0cAAAA:8
        a=nxstkhmkV2fPwvo5-F4A:9 a=CjuIK1q_8ugA:10 a=RMMjzBEyIzXRtoq5n5K6:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 14, 2020 at 12:13:23PM -0700, Jens Axboe wrote:
> Now that we support non-blocking path resolution internally, expose it
> via openat2() in the struct open_how ->resolve flags. This allows
> applications using openat2() to limit path resolution to the extent that
> it is already cached.
> 
> If the lookup cannot be satisfied in a non-blocking manner, openat2(2)
> will return -1/-EAGAIN.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/open.c                    | 6 ++++++
>  include/linux/fcntl.h        | 2 +-
>  include/uapi/linux/openat2.h | 4 ++++

What text are you going to add to the man page to describe how this
flag behaves to developers?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
