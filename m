Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F71E78FC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2019 17:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388216AbfG2Pr1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 11:47:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59108 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387495AbfG2Pr1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:47:27 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hs7rs-000847-6K; Mon, 29 Jul 2019 15:47:20 +0000
Date:   Mon, 29 Jul 2019 16:47:20 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     "zhangyi (F)" <yi.zhang@huawei.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcrl@kvack.org, wangkefeng.wang@huawei.com
Subject: Re: [PATCH] aio: add timeout validity check for io_[p]getevents
Message-ID: <20190729154720.GS1131@ZenIV.linux.org.uk>
References: <1564039289-7672-1-git-send-email-yi.zhang@huawei.com>
 <x49imrqb2e5.fsf@segfault.boston.devel.redhat.com>
 <x49y30gnb16.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49y30gnb16.fsf@segfault.boston.devel.redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 29, 2019 at 10:57:41AM -0400, Jeff Moyer wrote:
> Al, can you take this through your tree?

Umm...  Can do, but I had an impression that Arnd and Deepa
had a tree for timespec-related work.  OTOH, it had been
relatively quiet last cycle, so...  If they have nothing
in the area, I can take it through vfs.git.
