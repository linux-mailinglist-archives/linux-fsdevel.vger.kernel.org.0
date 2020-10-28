Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900C429D630
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 23:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbgJ1WLt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730738AbgJ1WLs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:11:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FCCC0613CF;
        Wed, 28 Oct 2020 15:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6utoMtcBr/nbW9ldHrxB2+C4zosO2vmkmbKG+2j2lgc=; b=BPbuO5V35gDj4HZHn19t/XeO44
        q43w3IbOZixtiOeu/vQ5kX3iYRdumVtVD9+lJDn0+3+LexW4+ezEoNmlG4uerbCET9K0u3uHaVYcn
        JBhl3IPkjjGh+wIYUcTd+8kPtu/gXyiN7N4S9ntXL0bqfMe5vgF9V1U4x4qcUgN/Bss+0pHPjw3VL
        vPW/mfRocGO+N8AajYLPLxCCbrGtJ8xhE7FpTc/0w03tx9unuoqEMlwnMqzDZzgxDo393JhoOwW2j
        hhWY38QjUoQJxgNF1IyIKiI3YcW+Q0+LZqdZgSmj6PvjZBqY2iv44GS2cw9OGFcpJb6K0vfb083cr
        GbQLgYNw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXes3-0004kE-TB; Wed, 28 Oct 2020 06:23:44 +0000
Date:   Wed, 28 Oct 2020 06:23:43 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3] seq_file: fix clang warning for NULL pointer
 arithmetic
Message-ID: <20201028062343.GA18092@infradead.org>
References: <20201027221916.463235-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027221916.463235-1-arnd@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +#define SEQ_OPEN_SINGLE	(void *)1

I still think a comment explaining the magic value here would be useful.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
