Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCA8264998
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 18:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgIJQWI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 12:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgIJQVF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:21:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B2BC061757;
        Thu, 10 Sep 2020 09:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y9qfXyLFuBmPMsAM81BTuaovsSrAemSXS1djruQmIgM=; b=P26BvPCQWoDrSnm2S2ktrnzed2
        /aTjVZiWCO8WPdNxU/TC1je82rkKizrMWuFlHF6W18GU/GlN1pvGv5S2zvxff+yfe7wxCBuMShPtu
        UL3sUu5B7HEE7n9SyFucf71P4mhc7o1GfGcs05HFy1qcZGWzOA9PrQ63xOr0gOFhc5imy2pEWOEoT
        jRAg5fvYHC/mIx6unVgGy9VVUvn8lz/f1J/zj0AtRU7ZEhZsiZOjB2ukyF1C58GpDzIEIruATUDxi
        oM4sf7QNwSZe93ekpFGjxUNQ5FlsJkarZx99CihOJc6qpzVU4dJdts2ZBysu4eExyzFAcsBORY9PX
        jH1gq3vA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGPJj-0004t4-8I; Thu, 10 Sep 2020 16:20:59 +0000
Date:   Thu, 10 Sep 2020 17:20:59 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Rich Felker <dalias@libc.org>
Cc:     linux-api@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: add fchmodat2 syscall
Message-ID: <20200910162059.GA18228@infradead.org>
References: <20200910142335.GG3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910142335.GG3265@brightrain.aerifal.cx>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 10:23:37AM -0400, Rich Felker wrote:
> userspace emulation done in libc implementations. No change is made to
> the underlying chmod_common(), so it's still possible to attempt
> changes via procfs, if desired.

And that is the goddamn problem.  We need to fix that _first_.  After
that we can add sugarcoating using new syscalls if needed.
