Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FE54D0313
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 16:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiCGPlf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 10:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbiCGPle (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:41:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15FE22BE8
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Mar 2022 07:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=H+gqgJ7AVoosNx9UBcH/XTwpPIQy/yuf8luNz2y5WV0=; b=m8+x4H0jEqBUj2IutOx9+Jmod0
        kugEosNbnZvvqVFESxpA0Gzvjf4yvRTGx95LnUq2WuAC2JCHPenrG5qy3FpANImy3Wx/ivoEpYPBB
        HSURLYnL9zKTIt2BlUFpPyGJ1HqfEiPZxmrgfpyKa88wAvFQbd9mDCg2VtBFd//EZtnPUACfYK5wU
        Ze86lGM89qvuIJ/FEHmSR4ECO5CUbbhYRw3YM8mRn2FppRAz5F1K6a7rA7/JHeRmHzh11oDz6Iupy
        77wtCK+Yu4vU/2w8+WrzUyVK+QiXhEMxRknWSwtYdOey9cp/VZeSyDEY4CEYUhNw0PEX9JHIhDi2T
        M9hnGlmg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRFTN-00FLQW-6l; Mon, 07 Mar 2022 15:40:33 +0000
Date:   Mon, 7 Mar 2022 15:40:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     =?utf-8?B?6ZmI56uL5paw?= <clx428@163.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Subject: Re: Re: Report a fuse deadlock scenario issue
Message-ID: <YiYncQJi0NIWstpj@casper.infradead.org>
References: <6da4c709.5385.17ee910a7fd.Coremail.clx428@163.com>
 <CAJfpeguvqro7SUmve_dyMiPHn4_dzQR4MMJRwZyfq61k17N-jg@mail.gmail.com>
 <20645a14.5220.17f1ca46398.Coremail.clx428@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20645a14.5220.17f1ca46398.Coremail.clx428@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:16:49PM +0800, 陈立新 wrote:
> I use the kernel version is 4.19.36, which it has no 64081362e8ff4587b4554087f3cfc73d3e0a4cd7 mm/page-writeback.c: fix range_cyclic writeback vs writepages deadlock patch.
> I think this patch can fix this deadlock.

This patch was added to v4.19.87 which was released in December 2019.
You really should update to the latest v4.19 kernel; you're missing
hundreds, if not thousands of bug-fixes, many of them with CVEs
attached.
