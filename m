Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3B323A993
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 17:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgHCPlj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 11:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgHCPlj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:41:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5934AC06174A;
        Mon,  3 Aug 2020 08:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SnvD0ufrD36AznQ4b9NY+YAqMLCruaCYki+qndIchpQ=; b=rtfARZGfVzm85Mw0LPAVdMHYcI
        8au74Pe9pnWPbe4ilvolD/X3pCAbm3FZNm/Ooq2L3E1dCUsDj3fWTY6kM9qBeIXzh/BpsoJ/KbqBu
        iOqW07bf8Eom8J/hr99iQ2fc8tA+ZNmMYYG9NoLz1Ks2nIWgjL7BMRVcEWN3VIAEM0KCuNMxQo20G
        yu8QmmQhhPJ2sd03rvaywP+ehPid/5brcexjUmluLab3IZ1jyVHjqGnBrhS9NQMk0yK/dMdlgEeCR
        kQR4ab7/IVu4ZZ8muUCcSyl1/0QaMPgP1JmvJvQmA6kdPzCrsRjFo25GiVsOE0KEQ3oKWQ0CKPXU/
        K+Ta2iRQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2cab-0007Dl-Uy; Mon, 03 Aug 2020 15:41:26 +0000
Date:   Mon, 3 Aug 2020 16:41:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-fsdevel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Ioannis Ilkos <ilkos@google.com>,
        John Stultz <john.stultz@linaro.org>, kernel-team@android.com
Subject: Re: [PATCH 2/2] dmabuf/tracing: Add dma-buf trace events
Message-ID: <20200803154125.GA23808@casper.infradead.org>
References: <20200803144719.3184138-1-kaleshsingh@google.com>
 <20200803144719.3184138-3-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803144719.3184138-3-kaleshsingh@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 03, 2020 at 02:47:19PM +0000, Kalesh Singh wrote:
> +static void dma_buf_fd_install(int fd, struct file *filp)
> +{
> +	trace_dma_buf_fd_ref_inc(current, filp);
> +}

You're adding a new file_operation in order to just add a new tracepoint?
NACK.
