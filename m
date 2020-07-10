Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7995421BA12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 17:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgGJP5X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 11:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGJP5W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:57:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68571C08C5CE;
        Fri, 10 Jul 2020 08:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CpVYyGJEOwWcccxExHRfrgInA8VS1nTN5mktDOBuniU=; b=bdKTkj9taJdShdVNCith8H/Kg1
        Q/fC6e0QbdRcPXuFKAF6VJ0crPiM1kh9vmeq9Hr+YslkEXevEljYTesKqROY3b7BtDSMO9f2LDfN1
        wxPuLp47utsk5SgGH/k8+AXSRAhwNEUXSSSoE7uc4y/CXUTH/kZbGfKsdrXaoq4Dd56iDoSqVJdCj
        JQamlPMlxoPufI93ssCvVJpcUqrU57LRP9/SLDXj6XY6Trlppf3uD+f68biJzyWTM4BzS45YLtzUf
        AvEh3mRI/346yZ/mOpKtDKBIkpS/+0KwDiFRVk4CpbKsov2xlYxTLzHlYXFHntPmPRodskE3y5aa7
        y01OpCKA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtvOq-0002Q0-20; Fri, 10 Jul 2020 15:57:20 +0000
Date:   Fri, 10 Jul 2020 16:57:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kcmp: add separate Kconfig symbol for kcmp syscall
Message-ID: <20200710155719.GN12769@casper.infradead.org>
References: <20200710075632.14661-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710075632.14661-1-linux@rasmusvillemoes.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 10, 2020 at 09:56:31AM +0200, Rasmus Villemoes wrote:
> The ability to check open file descriptions for equality (without
> resorting to unreliable fstat() and fcntl(F_GETFL) comparisons) can be
> useful outside of the checkpoint/restore use case - for example,
> systemd uses kcmp() to deduplicate the per-service file descriptor
> store.
> 
> Make it possible to have the kcmp() syscall without the full
> CONFIG_CHECKPOINT_RESTORE.

If systemd is using it, is it even worth making it conditional any more?
Maybe for CONFIG_EXPERT builds, it could be de-selectable.
