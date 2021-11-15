Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A673944FF52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 08:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhKOHok (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 02:44:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42828 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhKOHoV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 02:44:21 -0500
Date:   Mon, 15 Nov 2021 08:41:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636962083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+5IisUIbI70vrGkOqovnvkjwy7IXKjN/5Ztlq4EDlSA=;
        b=3lPRKCIXYJmMyjWybaLV0hgp0HPURkFdbrRsyLjTv5OWzTCtqgcBCC7tz5wPHH2splwxsU
        BHe0rNCfslXLfOAesgDmxWQb1TO4U9BGinTHn3dqKdCmsOvAi1lAE2NXPCIay2La0hmoGg
        3P8ccBbea2KU6Mqd09dsXemHC1qT31vdV2xuVvSjs6RTbb0jQVJgqiTI9OOawvo0n3LyrM
        rwBwy7QP39UkWef9h8+bHtPs4DvCo4pw1zuBM9hhftE8S3M041Bllnt+lwRGX/pnUPI3O0
        UwfnctvZePUe8d9kLcHES4dCnW0e8/bH6Ub95y0Bu5qit9hZKzOX1/29gVGzmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636962083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+5IisUIbI70vrGkOqovnvkjwy7IXKjN/5Ztlq4EDlSA=;
        b=AP+G+48D2yfV9xgFTKNTJC7sB6GpX88NvApYrGtdWRu1O12WE2yJgl5vu9wuOtQ5k4WPbB
        /va4+Z1h0dbHohBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: xas_retry() based loops on PREEMPT_RT.
Message-ID: <20211115074122.3o4mjq4ddow7f2gp@linutronix.de>
References: <20211112173305.h36kodnm3awe3fn3@linutronix.de>
 <YY7kD/JWy9zuUGub@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YY7kD/JWy9zuUGub@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-11-12 22:00:47 [+0000], Matthew Wilcox wrote:
> Readers should all be skipping over ZERO entries (as they do NULL
> entries), not restarting the iteration if they see one.  So it shouldn't
> factor into your "does it make progress" analysis, because an iteration
> should continue, not retry.
> 
> Also, I am not aware of any user of ZERO entries in the page cache.
> It's possible that somebody has added one without me noticing, but there
> wasn't one earlier.

Thank you for confirming.

Sebastian
