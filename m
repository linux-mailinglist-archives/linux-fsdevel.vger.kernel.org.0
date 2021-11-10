Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944C544C895
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 20:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhKJTLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 14:11:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232689AbhKJTLn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 14:11:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B84C961077;
        Wed, 10 Nov 2021 19:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636571335;
        bh=/nlf8a6pijn/h9Jdun7z44dTvfnUp17fW2yftSoPyRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KI2Dy0nHL566ZVbhotl37oq3zis86my26aRiwp23gDxMbYLh4CW2ATAArBqyACntA
         PdAmISJzZ4fxYBJ9UhMhAEIdM8N2kEWrA31LetW0jWXNY79LZvPU4M3B0w99rZnluf
         9+tMU62qpoEf9qc0LjufjQa8czLmCMzHeP5ldgmyE4fT75bI9bYA/B13nya1S6YmAQ
         LWXs+JOk0EB+kvsJRy3UXPk0XaVpnF0b9Ws+SPNaIUvmKiFKxIK2M5vCdEjeJ0XCzR
         1uqjWsFEHdqA4MXiiNocLTXraZWbQ83HppyRyu+HXnuptAydLfTcJIF7NTrQjPOKh9
         VqAvFrp8IrWnA==
Date:   Wed, 10 Nov 2021 11:08:54 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] f2fs: provide a way to attach HIPRI for Direct IO
Message-ID: <YYwYxv4s1ZzBZRtC@google.com>
References: <20211109021336.3796538-1-jaegeuk@kernel.org>
 <YYqkWWZZsMW49/xu@infradead.org>
 <042997ce-8382-40fe-4840-25f40a84c4bf@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <042997ce-8382-40fe-4840-25f40a84c4bf@kernel.dk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/09, Jens Axboe wrote:
> On 11/9/21 9:39 AM, Christoph Hellwig wrote:
> > On Mon, Nov 08, 2021 at 06:13:36PM -0800, Jaegeuk Kim wrote:
> >> This patch adds a way to attach HIPRI by expanding the existing sysfs's
> >> data_io_flag. User can measure IO performance by enabling it.
> > 
> > NAK.  This flag should only be used when explicitly specified by
> > the submitter of the I/O.
> 
> Yes, this cannot be set in the middle for a multitude of reasons. I wonder
> if we should add a comment to that effect near the definition of it.

Not surprising. I was wondering we can add this for testing purpose only.
Btw, is there a reasonable way that filesystem can use IO polling?

> 
> -- 
> Jens Axboe
