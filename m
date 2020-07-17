Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9DE223988
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 12:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgGQKnE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 06:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgGQKnD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 06:43:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB9BC061755
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 03:43:03 -0700 (PDT)
Date:   Fri, 17 Jul 2020 12:43:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594982582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q8Z2zYrY9VRmFH9yWoiYxtQsQ0RO40OkGXnl0oXdAyk=;
        b=0/FeOmxi2rW6c1GFnXP3sSDEQEdAWhSY92xcBtf6MgIM0iLgRv6SK187xjgOkdUVRa0rUx
        DSgfOHGnCpZ7QyiaQFMczOsdoYkyPWzwa4Uaqv5vtvnrGgnxD6RV97gLh3KXVJ4GY7MBUO
        4TBHzHMZvqTwcEfETjY9lMJSUGVqZt2ZMo0yU50ApqtcOSNjwy/aE07hn6QYA407Gkb0rf
        s1FwJeaJi93VP5g0CGxupX6zCOpIrXGd4iEE190sfzW54WXDIHa+1jF2zO0EaheqyKCuoC
        urLTLGNODgSVTrd7LD34Xf/vV/7aMSuRLauvu/BFq+56CsLcazYw7k/3NT3nCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594982582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q8Z2zYrY9VRmFH9yWoiYxtQsQ0RO40OkGXnl0oXdAyk=;
        b=JGpa/i/4boDHer2ycES2sw639SZ1CjIvD73wF4fPrs6QpKZaKOFAfYLR10LQGjEAmdPzZC
        IUBA5xSUhfQx0NBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Alberto Milone <alberto.milone@canonical.com>
Cc:     linux-fsdevel@vger.kernel.org, mingo@kernel.org
Subject: Re: [PATCH 1/1] radix-tree: do not export radix_tree_preloads as GPL
Message-ID: <20200717104300.h7k7ho25hmslvtgy@linutronix.de>
References: <20200717101848.1869465-1-alberto.milone@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200717101848.1869465-1-alberto.milone@canonical.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-07-17 12:18:48 [+0200], Alberto Milone wrote:
> Commit cfa6705d89b6 ("radix-tree: Use local_lock
> for protection") replaced a DEFINE_PER_CPU() with an
> EXPORT_PER_CPU_SYMBOL_GPL(), which made the
> radix_tree_preloads symbol GPL only. All the other
> symbols in the file are exported with EXPORT_SYMBOL().

Is this a problem if you disable CONFIG_DEBUG_LOCK_ALLOC ?

> The change breaks the NVIDIA 390 legacy driver.
> 
> This commit uses EXPORT_PER_CPU_SYMBOL() for
> radix_tree_preloads.
> 

Sebastian
