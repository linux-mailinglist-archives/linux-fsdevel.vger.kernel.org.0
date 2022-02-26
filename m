Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74654C583C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Feb 2022 22:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiBZVDD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Feb 2022 16:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiBZVDD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Feb 2022 16:03:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C813DFC7;
        Sat, 26 Feb 2022 13:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t5PvKUiCfOMquPumfQ4cEUgcoR3Wsv7oMQVd0HhO0Zo=; b=gtNP4G6fJqE4QOtsMvUMIVFpQ4
        usPnT7I8lr5qMEgoySSAWt79IYauedv87xchUhNtpl7pnUuuRmvckbPV6Jrh5QQRePDS6sPnrEQDd
        mLQ0Ey83QSIJDK7LZAYz8RaD9Ty3Uk4YPD8g08lRJITopv9NFbKS0T6ivFF2JXpzjxWqLKHWfLMs7
        /1pUHclLHba1zIqBZlA3gQ5Fdj504mt++KNl0uh9fqrQ9NvJbk0RXdsU+cxFtTCjnPBSHCngUnrxJ
        dos+hBJALOqBjdOz1d/nnI/Uul/HHo8YsphtGDRkybBB1eyTqR3HR5r/4/hbB0g5TVXmt2v3P+8gM
        8tVWXt+A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nO4Cp-008XqG-Id; Sat, 26 Feb 2022 21:02:19 +0000
Date:   Sat, 26 Feb 2022 13:02:19 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tangmeng <tangmeng@uniontech.com>
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        keescook@chromium.org, yzaikin@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nizhen@uniontech.com, zhanglianjie@uniontech.com,
        nixiaoming@huawei.com
Subject: Re: [PATCH v2 10/11] fs/drop_caches: move drop_caches sysctls to its
 own file
Message-ID: <YhqVW972rnF5L22U@bombadil.infradead.org>
References: <20220221061018.10472-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221061018.10472-1-tangmeng@uniontech.com>
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

On Mon, Feb 21, 2022 at 02:10:18PM +0800, tangmeng wrote:
> kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
> dishes, this makes it very difficult to maintain.
> 
> To help with this maintenance let's start by moving sysctls to places
> where they actually belong.  The proc sysctl maintainers do not want to
> know what sysctl knobs you wish to add for your own piece of code, we
> just care about the core logic.
> 
> All filesystem syctls now get reviewed by fs folks. This commit
> follows the commit of fs, move the drop_caches sysctls to its own file,
> fs/drop_caches.c.
> 
> Signed-off-by: tangmeng <tangmeng@uniontech.com>

Thanks but please send a v3 including all the other patches as well
and collecting the Reviewed/Acked-bys, etc. This can be sent *after*
your v3 of the optimization work.

  Luis
