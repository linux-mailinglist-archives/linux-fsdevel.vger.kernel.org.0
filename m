Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AADB306B8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 04:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhA1DXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 22:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhA1DXA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 22:23:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E7DC061573;
        Wed, 27 Jan 2021 19:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yXwAf4SjrS2AfONW4GD6Gl+1dXhVs6G1QXceWMC0B3U=; b=BggS2jWk8dTVxp2paur15i7JfA
        R8lVnUKUj010vopE+hV2ucNtXxAI+OMXRBnTq+297HNfUfRtoIZs1WUnooeM4Niu0xVw4FgBX/aad
        /PKvbfZrNAq0MGuu59jF9/VhX7fEZpC4YCWxtSOSLFm6ytiRPRTY2jspVIsmAHJlxmwvjUC119p7D
        4GZvRVuIzPqkyokEeAvRSdmjLsFviHUaAWAbpx9GHaHPb+fb0y8w5XEXU/nLSdw31w1IdWBiJ6+/B
        aFH7FGjI5ADyvhnh6J9/zHmY00jf5CGgZebLWlUjz9FimBBcju92re9dDL2zE/TwG4GWdRu/nf6AJ
        sxj/McKg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4xsj-007scR-5o; Thu, 28 Jan 2021 03:22:06 +0000
Date:   Thu, 28 Jan 2021 03:22:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     bingjingc <bingjingc@synology.com>
Cc:     viro@zeniv.linux.org.uk, jack@suse.com, jack@suse.cz,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, cccheng@synology.com,
        robbieko@synology.com
Subject: Re: [PATCH 0/3] handle large user and group ID for isofs and udf
Message-ID: <20210128032205.GV308988@casper.infradead.org>
References: <1611800220-9481-1-git-send-email-bingjingc@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611800220-9481-1-git-send-email-bingjingc@synology.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 28, 2021 at 10:17:00AM +0800, bingjingc wrote:
> From: BingJing Chang <bingjingc@synology.com>
> 
> The uid/gid (unsigned int) of a domain user may be larger than INT_MAX.
> The parse_options of isofs and udf will return 0, and mount will fail
> with -EINVAL. These patches try to handle large user and group ID.
> 
> BingJing Chang (3):
>   isofs: handle large user and group ID
>   udf: handle large user and group ID
>   parser: add unsigned int parser

This is the wrong way to submit this patch series.

Patch 1: add unsigned int parser
Patch 2: Use it in isofs
Patch 3: Use it in udf

