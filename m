Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9900680D7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jul 2019 20:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfGNSul (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Jul 2019 14:50:41 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47098 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbfGNSul (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Jul 2019 14:50:41 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 08D2C804F1; Sun, 14 Jul 2019 20:50:26 +0200 (CEST)
Date:   Sun, 14 Jul 2019 12:49:40 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v2 00/24] erofs: promote erofs from staging
Message-ID: <20190714104940.GA1282@xo-6d-61-c0.localdomain>
References: <20190711145755.33908-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711145755.33908-1-gaoxiang25@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 2019-07-11 22:57:31, Gao Xiang wrote:
> Changelog from v1:
>  o resend the whole filesystem into a patchset suggested by Greg;
>  o code is more cleaner, especially for decompression frontend.
> 
> --8<----------
> 
> Hi,
> 
> EROFS file system has been in Linux-staging for about a year.
> It has been proved to be stable enough to move out of staging
> by 10+ millions of HUAWEI Android mobile phones on the market
> from EMUI 9.0.1, and it was promoted as one of the key features
> of EMUI 9.1 [1], including P30(pro).

Ok, maybe it is ready to be moved to kernel proper, but as git can
do moves, would it be better to do it as one commit?

Separate patches are still better for review, I guess.
							Pavel
