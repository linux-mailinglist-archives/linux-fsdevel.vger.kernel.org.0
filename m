Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C32745B0B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 01:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239347AbhKXAav (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 19:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbhKXAau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 19:30:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3C1C061574;
        Tue, 23 Nov 2021 16:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BL2H+aUUS8RxUiQn3zfoq6gcz+j4S7JpSNQA/R9cK/8=; b=DRbgOEnYteVx/RS/fGniKkeUox
        yjtxot659ldaGF8XX1UlGu0skZjjkvIZlsKVCiSFFhmLIlb6n7aaUZyDK7AnukSl0y/OAwB3eQZbQ
        WyFYZLEZmdZicsOVE363Tgh7RZCsMF40Q4H++Q03dHyXzMJjitPK8QuGf43lBhsGobtPffiS4sB2K
        UAh8EGEu0pgOITRZLtrnPYS38oecnIwpK/fQ+Ji47kdLjTAOacvOaasWL2egMUZBBmFRxWy0QPvqC
        G8WSTbrL4iOgkUsdtt4AAykUrRWjA+sueo5iSS76uJQX+pFkOyprx8SwT8kqN1Bzr8yJ6K39ngC4E
        IW86Pjvw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpg7z-003k9N-7b; Wed, 24 Nov 2021 00:27:11 +0000
Date:   Tue, 23 Nov 2021 16:27:11 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, peterz@infradead.org,
        gregkh@linuxfoundation.org, pjt@google.com,
        liu.hailong6@zte.com.cn, andriy.shevchenko@linux.intel.com,
        sre@kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        pmladek@suse.com, senozhatsky@chromium.org, wangqing@vivo.com,
        bcrl@kvack.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] sysctl: first set of kernel/sysctl cleanups
Message-ID: <YZ2G31E7dSI/CMNW@bombadil.infradead.org>
References: <20211123202347.818157-1-mcgrof@kernel.org>
 <20211123161426.48844f7500be5ca6363b3818@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123161426.48844f7500be5ca6363b3818@linux-foundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 04:14:26PM -0800, Andrew Morton wrote:
> On Tue, 23 Nov 2021 12:23:38 -0800 Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> > Since the sysctls are all over the place I can either put up a tree
> > to keep track of these changes and later send a pull request to Linus
> > or we can have them trickle into Andrew's tree. Let me know what folks
> > prefer.
> 
> I grabbed.  I staged them behind all-of-linux-next, to get visibility
> into changes in the various trees which might conflict.

Groovy thanks, if nothing barks back next week I can send out a third
set of changes. I'll note that I've been testing these with 0-day prior
to posting sets.

  Luis
