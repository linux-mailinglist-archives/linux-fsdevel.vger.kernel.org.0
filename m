Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611B54E5AB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 22:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243371AbiCWVdt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 17:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240867AbiCWVds (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:33:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFB33EF0C;
        Wed, 23 Mar 2022 14:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mYNJfGGSVaocDlmcw7Y6SzRfFy2YudcedELxKPfKos4=; b=AALIGi39gaeafdIUdimblw8VAP
        GcF2M2hi3z/FkOGSIrNoAIvW4v4ViL+ZEGcUkHD7Sw5lTir86cvGWJOBSouooJ7I/ABC2xgHVZqAh
        PYKRde2/ygfGxXHxCa1SJTX8On5h7jhfp5BPDbu3fSE0Aczm1ro+lWQZxn2gS6N1ufFTG6+31ZDir
        iwDqMGs5JBl+ZgMEV14T7SfD4XE9g2O7cn68Rb/r2nScpALp5TloWG5sbOm2xm8o3LjFPeJurqgvO
        fQU35onhWq+GAp0Xxz1V8aeurBAsJbffkof+iCNluYLS0klgtGkojzu0aLcYido3SBV8HD5ieMr26
        5G3hdpMg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nX8aU-00CrO3-AE; Wed, 23 Mar 2022 21:32:14 +0000
Date:   Wed, 23 Mar 2022 21:32:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Thiago Becker <tbecker@redhat.com>
Cc:     linux-nfs@vger.kernel.org, steved@redhat.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        kolga@netapp.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC v3 0/6] Intruduce nfsrahead
Message-ID: <YjuR3h6yDYLoEeum@casper.infradead.org>
References: <20220323201841.4166549-1-tbecker@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323201841.4166549-1-tbecker@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 05:18:35PM -0300, Thiago Becker wrote:
> Recent changes in the linux kernel caused NFS readahead to default to
> 128 from the previous default of 15 * rsize. This causes performance
> penalties to some read-heavy workloads, which can be fixed by
> tuning the readahead for that given mount.

Which recent changes?  Something in NFS or something in the VFS/MM?
Did you even think about asking a wider audience than the NFS mailing
list?  I only happened to notice this while I was looking for something
else, otherwise I would never have seen it.  The responses from other
people to your patches were right; you're trying to do this all wrong.

Let's start out with a bug report instead of a solution.  What changed
and when?
