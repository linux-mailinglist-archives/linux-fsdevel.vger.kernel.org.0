Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E941134BF67
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Mar 2021 23:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhC1Vke (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Mar 2021 17:40:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhC1VkO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Mar 2021 17:40:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FF4361936;
        Sun, 28 Mar 2021 21:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1616967613;
        bh=iiB5Pia61Yr8kkVXAAfLI0zQirvQWAf1FAnuzUpwE88=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j1FEbrKbBxBuCdUlhbf5W/4KAcwhHMwvUnJ6fo38hoUT44ilxCfi+Akzw7t57JJgT
         TiCluayBE4AllZgTTvkij6U9qkm1V6i2vL0J7Wnnf7MxBKs3iaBSdvI1F+ktIwYjGi
         4a7j+QftC58pREkbHouE2/xEgEpAX5Je6/ZfIbI4=
Date:   Sun, 28 Mar 2021 14:40:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jack Qiu <jack.qiu@huawei.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: direct-io: fix missing sdio->boundary
Message-Id: <20210328144012.6a6a934b38bf93feca5d6d7d@linux-foundation.org>
In-Reply-To: <20210322112847.GB31783@quack2.suse.cz>
References: <20210322042253.38312-1-jack.qiu@huawei.com>
        <20210322112847.GB31783@quack2.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 22 Mar 2021 12:28:47 +0100 Jan Kara <jack@suse.cz> wrote:

> On Mon 22-03-21 12:22:53, Jack Qiu wrote:
> > Function dio_send_cur_page may clear sdio->boundary,
> > so save it to avoid boundary missing.
> > 
> > Fixes: b1058b981272 ("direct-io: submit bio after boundary buffer is
> > added to it")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Jack Qiu <jack.qiu@huawei.com>
> 
> Indeed. The patch looks good to me. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

It's been 8 years and nobody has noticed.  I'm struggling to see the
cc:stable justification here.  Do we have any performance measurements
which would justify backporting?

