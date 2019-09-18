Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66D1BB5BB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 08:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfIRGQK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 02:16:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbfIRGQK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:16:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 909B020665;
        Wed, 18 Sep 2019 06:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787368;
        bh=9+1j0c62Hdp93RT/nCYlXl4BZbarkBUvvEVoQsUdB98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e78QY50bO1zk1qhLTUZ4na4y+XJ5QC2JI4yWEgWDi95tgwJ7SnwgNwCAFJ3U5olf7
         CtLelPy8QitXliWD8n00wTIFEgLJi0V3uC/5sXg6vABNiTpYZ9z73dgKvPZyRt0WAS
         Vu1aW1z50LFLOPIXVfDUr05WdZPXCo4CheBLMPOY=
Date:   Wed, 18 Sep 2019 08:16:05 +0200
From:   'Greg KH' <gregkh@linuxfoundation.org>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     'Ju Hyung Park' <qkrwngud825@gmail.com>,
        'Valdis Kletnieks' <valdis.kletnieks@vt.edu>,
        devel@driverdev.osuosl.org, linkinjeon@gmail.com,
        linux-kernel@vger.kernel.org, alexander.levin@microsoft.com,
        sergey.senozhatsky@gmail.com, linux-fsdevel@vger.kernel.org,
        sj1557.seo@samsung.com
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to
Message-ID: <20190918061605.GA1832786@kroah.com>
References: <8998.1568693976@turing-police>
 <20190917053134.27926-1-qkrwngud825@gmail.com>
 <20190917054726.GA2058532@kroah.com>
 <CGME20190917060433epcas2p4b12d7581d0ac5477d8f26ec74e634f0a@epcas2p4.samsung.com>
 <CAD14+f1adJPRTvk8awgPJwCoHXSngqoKcAze1xbHVVvrhSMGrQ@mail.gmail.com>
 <004401d56dc9$b00fd7a0$102f86e0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004401d56dc9$b00fd7a0$102f86e0$@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Sep 18, 2019 at 11:35:08AM +0900, Namjae Jeon wrote:
> I've summarized some of the big differences between sdfat and exfat
> in linux-next.
> 
> 1. sdfat has been refactored to improve compatibility, readability and
> to be linux friendly.(included support mass storages larger than 2TB.)
> 
> 2. sdfat has been optimized for the performance of SD-cards.
>   - Support SD-card friendly block allocation and delayed allocation
>     for vfat-fs only.
>   - Support aligned_mpage_write for both vfat-fs and exfat-fs
> 
> 3. sdfat has been optimized for the performance of general operations
>     like create,lookup and readdir.
> 
> 4. Fix many critical and minor bugs
>  - Handle many kinds of error conditions gracefully to prevent panic.
>  - Fix critical bugs related to rmdir, truncate behavior and so on...
> 
> 5. Fix NLS functions

Those are all wonderful things, any chances you can point out the
individual commits that reflect these bugfixes?

> Note, that Samsung is still improving sdfat driver. For instance,
> what will be realeased soon is sdfat v2.3.0, which will include support
> for "UtcOffset" of "File Directory Entry", in order to satisfy
> exFAT specification 7.4.

If Samsung is going to continue to keep its internal tree for this
driver, there's no way we can take a code dump today and expect things
to keep in sync.

If Samsung agrees to do development of this codebase upstream in the
kernel tree, I will be glad to consider moving to this codebase instead
and working together on it.  Otherwise it makes no sense as things
instantly diverge with no way of keeping in sync (we only can commit to
one tree, while you can in both.)

If Samsung wishes to use their sdfat codebase as the "seed" to work from
for this, please submit a patch adding the latest version to the kernel
tree and we can compare and work from there.

thanks,

greg k-h
