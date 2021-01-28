Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD0F30807D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 22:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhA1VZL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 16:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhA1VZB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:25:01 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E465C061573;
        Thu, 28 Jan 2021 13:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=fgxRB7yFY7ivAGOXupxroeHkNQGIObd0cjQLTaZyhYw=; b=0xac9ZqpnG1TWzljEEoZ/wy5f0
        s3no8nu9lr1YAChnBgqDqZldibegK2qvbyuLNKk+3P4aBm+jdOdLvzpPozBLMgnTNMOi1Q5SbKvuu
        3FhhakkPMyyPg13ELgjujFS/WeO59RFDxbsib2Qt4kmov1/FDnrfFpFPyUG1hGtb9dgdg1yMjGnbz
        d2ilfP6+LHj8tZeg25mI1+Mpk/yZchNKMlotQfdlJhk6/YTeBfv6i7YdjImsiumrDcL+IU7gBYCWB
        aA1BK+9koYJ19dRSgXK9PbjzUNHKoRAEMQ+rZtn7GS4c6sImuK2eyrIMUqReU0Sfw/hgDf2HZXIC0
        ZxGGVHlA==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l5Elz-0000qH-SA; Thu, 28 Jan 2021 21:24:16 +0000
Subject: Re: [PATCH v2 1/3] parser: add unsigned int parser
To:     bingjingc <bingjingc@synology.com>, viro@zeniv.linux.org.uk,
        jack@suse.com, jack@suse.cz, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, cccheng@synology.com,
        robbieko@synology.com, willy@infradead.org
References: <1611817983-2892-1-git-send-email-bingjingc@synology.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9e867a74-89c0-e0da-b166-e9824372e181@infradead.org>
Date:   Thu, 28 Jan 2021 13:24:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1611817983-2892-1-git-send-email-bingjingc@synology.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/27/21 11:13 PM, bingjingc wrote:
> From: BingJing Chang <bingjingc@synology.com>
> 
> Will be used by fs parsing options & fix kernel-doc typos
> 
> Reviewed-by: Robbie Ko<robbieko@synology.com>
> Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
> Reviewed-by: Matthew Wilcox <willy@infradead.org>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

You should drop my Reviewed-by: also, until I explicitly
reply with that.

> Signed-off-by: BingJing Chang <bingjingc@synology.com>
> ---
>  include/linux/parser.h |  1 +
>  lib/parser.c           | 44 +++++++++++++++++++++++++++++++++-----------
>  2 files changed, 34 insertions(+), 11 deletions(-)

The kernel-doc changes do look good. :)

thanks.
-- 
~Randy

