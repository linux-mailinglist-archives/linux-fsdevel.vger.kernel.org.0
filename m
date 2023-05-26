Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC9A7121D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 10:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242443AbjEZIG7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 04:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjEZIG5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 04:06:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4962D3;
        Fri, 26 May 2023 01:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ji88nppxg0Yr6rTy2oo71cGSBHNzbZinz0tBY64Q5co=; b=wgA2+lE9Qdy04dO9PIx26l4kFK
        qd9OlyNBVEu9rnvWXmHQocHWn9kpyixJbCFl1sJYUjM+epXC7Rfqx8cnimKoqt2sZwPqyh6SzRtRL
        LeMPddZm6FrCStPNtL1GWHHlW+2+1lO5rxBx7b/Nj5IELb4taG8TuZtKarI6eXWFqO0suqd8OlxsI
        RshvQSO1reLoup/KZv6rDLuGkTy6lVVm2Zl2QuRf6QiHM3SRkxonNddEOsXPNLw1XxYNwJOFvGOyb
        9c/3x7GZGd8WUnJj84uXa2df622cCgk2nkLlecH5NLVqtMqJdjEvfZ9GxmO6OcPyMaGFS9mfcK9RG
        /W2PwGnQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2STG-001YPx-2C;
        Fri, 26 May 2023 08:06:46 +0000
Date:   Fri, 26 May 2023 01:06:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        cluster-devel@redhat.com, "Darrick J . Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [Cluster-devel] [PATCH 06/32] sched: Add
 task_struct->faults_disabled_mapping
Message-ID: <ZHBolpHP5JAmt65V@infradead.org>
References: <20230509165657.1735798-7-kent.overstreet@linux.dev>
 <20230510010737.heniyuxazlprrbd6@quack3>
 <ZFs3RYgdCeKjxYCw@moria.home.lan>
 <20230523133431.wwrkjtptu6vqqh5e@quack3>
 <ZGzoJLCRLk+pCKAk@infradead.org>
 <ZGzrV5j7OUU6rYij@moria.home.lan>
 <ZG2yFFcpE7w/Glge@infradead.org>
 <ZG3GHoNnJJW4xX2H@moria.home.lan>
 <ZG8jJRcwtx3JQf6Q@infradead.org>
 <ZG/KH9cQluA5e30N@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG/KH9cQluA5e30N@moria.home.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 04:50:39PM -0400, Kent Overstreet wrote:
> A cache that isn't actually consistent is a _bug_. You're being
> Obsequious. And any time this has come up in previous discussions
> (including at LSF), that was never up for debate, the only question has
> been whether it was even possible to practically fix it.

That is not my impression.  But again, if you think it is useful,
go ahead and seel people on the idea.  But please prepare a series
that includes the rationale, performance tradeoffs and real live
implications for it.  And do it on the existing code that people use
and not just your shiny new thing.

