Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374714C0645
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 01:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbiBWAkA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 19:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiBWAj7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:39:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24455F8DE;
        Tue, 22 Feb 2022 16:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mnwTyMbUz81PkB25DhATLqknf9GX0qBtMJyqNEVfajI=; b=sxwmKsmhM6USGd256+56DlZH+0
        xC8pp6lboBFRP88VnMkxrclwWkXe3f2XdwnKpvH+z8J4H/tQ5x09ss4WJqJVkAM/8uRMxpiUAzY8k
        AyeS04RXX0DgxaYuiz9AMQfFekUAfGn/iTMQFKj6mny1N2cySd/sYp/Ki4dS7xSO3WZksKlieMjvx
        DNPaYNbEj+CcHY464j7QkeJ9ifx4c671M2xsWMsvgHx7sB9b423IBlZMCQOxcQEwU0tGEZ0dGx3P3
        2kjSKJ5KuCAEaG/rKPAQyKhlJjEtajugqivMXbR8raOSTL32LBDvaM+SIc4F07HFxDxmg8TLp4gEI
        aIA/+iPg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMfge-00C1fi-Tq; Wed, 23 Feb 2022 00:39:20 +0000
Date:   Tue, 22 Feb 2022 16:39:20 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tangmeng <tangmeng@uniontech.com>
Cc:     Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nizhen@uniontech.com, zhanglianjie@uniontech.com,
        nixiaoming@huawei.com, sujiaxun@uniontech.com
Subject: Re: [PATCH 10/11] fs/drop_caches: move drop_caches sysctls to its
 own file
Message-ID: <YhWCOBqKc8xIylmT@bombadil.infradead.org>
References: <20220220060626.15885-1-tangmeng@uniontech.com>
 <YhIokWPShGOYh9LK@casper.infradead.org>
 <cbc60b32-d69c-d848-ca4c-650016da65d3@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbc60b32-d69c-d848-ca4c-650016da65d3@uniontech.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 21, 2022 at 09:55:18AM +0800, tangmeng wrote:
> I think it is obviously the right thing that we need to do.

Since you are following up on more changes, can you work on this?
Brownie points if you show size results to refelct no size difference
based on a new build with an example new user.

> However, many submissions have been commited which registers an array
> before, I think that having a register_sysctl_one() which registers exactly
> one ctl_table should submit in a separate submission, rather than modify it
> this time.

We can optimize this later and fix those.

  Luis
