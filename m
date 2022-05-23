Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D9D5318F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 22:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiEWUTh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 16:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiEWUTg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 16:19:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE7CBC6C1;
        Mon, 23 May 2022 13:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N2rdI1I+QIUtRZp/TJFYWC+M+9hFHdCTsdcwwNaN+is=; b=vIXeVVwGbphsWuV8rScnUaZbYt
        kyf2gU0WU1/mPAbgSVUYKsexBErSSvoZdKlgokGxbpiuvFd0DNOdgQC+A+Tessq0wgilc07kAYltB
        sqVqxpKCFYtbxLhbZow8UVOwRTsZ8DjjF5CvM9meRlsIsaT6TM9SbBsTbD7FZ7rCwV7o/hVAQatM8
        62JXw35Nnxo1JIlfnYbpH5jzoiDRlFRVxbY7qbluMqelxnWO92SZfrwFBTyoUv1z59RgyiVHYm4oH
        gNLYFXsvtJyv+NDNkdeIwnXaz9uDiogM5FHKG52QpACs5sjEVHWOHlBVCTSbR7nazOqzZ1o22C0O3
        3FC86RUQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntBqC-005NuX-Ju; Mon, 23 May 2022 17:27:36 +0000
Date:   Mon, 23 May 2022 10:27:36 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        willy@infradead.org, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: Re: [PATCH v2] sysctl: handle table->maxlen properly for proc_dobool
Message-ID: <YovECEBVeCZl79fi@bombadil.infradead.org>
References: <20220522052624.21493-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220522052624.21493-1-songmuchun@bytedance.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 22, 2022 at 01:26:24PM +0800, Muchun Song wrote:
> Setting ->proc_handler to proc_dobool at the same time setting ->maxlen
> to sizeof(int) is counter-intuitive, it is easy to make mistakes.  For
> robustness, fix it by reimplementing proc_dobool() properly.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Iurii Zaikin <yzaikin@google.com>
> ---

Thanks for your patch Muchun!

Does this fix an actualy issue? Because the comit log suggest so.
If so is there a bug which is known or a reproducer which can be
implemented to showcase that bug?

The reason I ask is that we have automatic scrapers for bug fixes,
and I tend to prefer to avoid giving those automatic scrapers
the idea that a patch is a fix for a kernel bug when it it is not.
If what you are change is an optimization then your commit log should
clarify that.

If you are fixing something then you must be clear about about the
details I mentioned. And then, if it does fix an issue, how long
has the issue been know, what are the consequences of it? And up
to what kernel is this issue present for?

  Luis
