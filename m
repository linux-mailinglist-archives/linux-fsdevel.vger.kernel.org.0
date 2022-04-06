Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F274F6DD1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 00:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiDFWae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 18:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiDFWaa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 18:30:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A474C21D070;
        Wed,  6 Apr 2022 15:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zRRr9o88MDfRNGGOv6NfO7sRgkAybsODKK4BSnVRap4=; b=VaxVKW54QNABawNWlza69u7VPP
        5stOVViYh4fjXc3yLa/Va+sA/1sUYHu2JJYZg/g+k89WKzGcp7HS/uBK+0hYO5+krQ7bzC8ZE6txY
        mP/9lxoDtY1KRgKM3gwbI60KdzBDGY+862MyKBTnZbdU9Dq5/mOPlNFF3S6xXlhruUNL8b/g/Rdgy
        kaAD5aDH34BdrqPFZVtJCcObp7Fvx9sJLGUaxZJ+eQ3PrkRceOk0g4zKjxh0+K5IRVTQbn7pK+Lwf
        1vbr5WO8RwQxLDeAppiIJVxXvRVHDu5+cNv0XxpEA7kx00iEqzRxamNf2fJOlaHZPANxZHtDwnQYv
        Uh7rFPLQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncE8c-0088W1-0d; Wed, 06 Apr 2022 22:28:30 +0000
Date:   Wed, 6 Apr 2022 15:28:29 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Meng Tang <tangmeng@uniontech.com>
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dave@stgolabs.net,
        nixiaoming@huawei.com
Subject: Re: [PATCH] fs/proc: Introduce list_for_each_table_entry for proc
 sysctl
Message-ID: <Yk4UDYxqpLFMi+yQ@bombadil.infradead.org>
References: <20220315060616.31850-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315060616.31850-1-tangmeng@uniontech.com>
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

On Tue, Mar 15, 2022 at 02:06:16PM +0800, Meng Tang wrote:
> Use the list_for_each_table_entry macro to optimize the scenario
> of traverse ctl_table. This make the code neater and easier to
> understand.
> 
> Suggested-by: Davidlohr Bueso<dave@stgolabs.net>
> Signed-off-by: Meng Tang <tangmeng@uniontech.com>

Can you re-send based on sysctl-next [0]?

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-next

  Luis
