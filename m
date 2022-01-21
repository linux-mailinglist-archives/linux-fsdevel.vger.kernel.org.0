Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56ADA4957AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 02:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbiAUBXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 20:23:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35374 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbiAUBXR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 20:23:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 225A66199D
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jan 2022 01:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9E5C340E0;
        Fri, 21 Jan 2022 01:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642728196;
        bh=/OhORxmqBZsRxohJwe8c8gP1wkMoO9oCrj0ChAmvtx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tZyxKXiEZWXryuXwPmgu1t39cqezwzeoYJgCRmIvYMJZSmIXLZds2pXeoblSN9Gvd
         X9NY4rAMo/djHFKS2t/0Wo85650haCN3umeFq0BCxsUO5dq/hU3I8d58CWgF3R3lDa
         Ut2ohVJAcml1Q0yYU3ooxa4QH1KTh/TvSPVFSYz+hofDHuJm1agyy0U88Ev2oUJJen
         IRL+C9KA/g5AvWrhUh+w8xbC+Ibz4z/ZsUQTWM6OztyBqqLcvMdlzKwto/igT/yzpI
         9VoPpMsXCW7UDRblC+QNweO7bWwvV1cEcXJ1LvOLiPPswldH3BW829d7R7mnaw2MXl
         egKRyPkB3cvOw==
Date:   Thu, 20 Jan 2022 17:23:14 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-aio@kvack.org, Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [libaio PATCH] harness: add test for aio poll missed events
Message-ID: <YeoLAu++cORO5mRL@sol.localdomain>
References: <20220106044943.55242-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106044943.55242-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 05, 2022 at 08:49:43PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add a regression test for a recently-fixed kernel bug where aio polls
> sometimes didn't complete even if the file is ready.
> 
> This is a cleaned-up version of the test which I originally posted at
> https://lore.kernel.org/r/YbMKtAjSJdXNTzOk@sol.localdomain
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  harness/cases/23.t | 255 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 255 insertions(+)
>  create mode 100644 harness/cases/23.t

Jeff, any feedback on this?  It looks like you're maintaining libaio.

I feel that this should go in the libaio test suite given the other aio tests
there already (including the one for aio poll), but I'd also be glad to put this
in LTP instead if you would prefer that.  Just let me know...

- Eric
