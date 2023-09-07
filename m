Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63887796F42
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 05:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjIGD0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 23:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjIGD0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 23:26:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A259F132
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 20:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=beztTAELL/ljqjPMu+PY2abJDnM0F7oBhZ4gTPpwmck=; b=qI/nl4JrJBHZcsrO8WTOQI8uas
        PprWSqS+YNPmWs2I1Wsag0kZGx2BExpPA2k9SHXQvGwsi1CGn46HuHs98a4jiFMCXxrOmbbnZNxio
        MjqbxzYb2SbUIY8ZWJZ3BToWIsVLPR6b13FERlR0G3qUTalDP+zgYsHcaWzPxbbh/uU8+UpsF/8wG
        CcmD5LvB9YfG9p9cLXwJhkv5rdtn5Dz8kW5KljCq/adCrkXxcsOd5y2D3FzgfL5upUge9/JhPXOGj
        ZSFFxRwRbVuyDVAKP5PZwlmYp4ljROuXRyF4znWwSfV3cB0hqwF0pbcKPeOcqiowiizMaFVMxXNp6
        HVyVRpJA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qe5ek-007pei-Uj; Thu, 07 Sep 2023 03:26:11 +0000
Date:   Thu, 7 Sep 2023 04:26:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZPlC0pf2XA1ZGr6j@casper.infradead.org>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
 <ZPkDLp0jyteubQhh@dread.disaster.area>
 <20230906215327.18a45c89@gandalf.local.home>
 <ZPkz86RRLaYOkmx+@dread.disaster.area>
 <20230906225139.6ffe953c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906225139.6ffe953c@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 10:51:39PM -0400, Steven Rostedt wrote:
> I guess the point I'm making is, what's the burden in keeping it around in
> the read-only state? It shouldn't require any updates for new features,
> which is the complaint I believe Willy was having.

Old filesystems depend on old core functionality like bufferheads.

We want to remove bufferheads.

Who has the responsibility for updating those old filesystmes to use
iomap instead of bufferheads?

Who has the responsibility for testing those filesystems still work
after the update?

Who has the responsibility for looking at a syzbot bug report that comes
in twelve months after the conversion is done and deciding whether the
conversion was the problem, or whether it's some other patch that
happened before or after?

