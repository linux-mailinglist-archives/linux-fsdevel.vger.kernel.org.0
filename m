Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BED4BBF87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 19:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbiBRSdk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 13:33:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiBRSdj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:33:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8BD101F10;
        Fri, 18 Feb 2022 10:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PrWz5qtwHqdsRw/blxCb36c0OKYX0eyItRlrI1nvhYw=; b=fg/RX55EvbqAh4EIcEZKIZHAgd
        wZokEp23P5OtG3/qxuaVZuB1CKe9ivzibiisyFrMCsVvyXZHyofFgrLX+AJD9P+V7IqFl5XcrVDJW
        3VuyeQ+odtBJtSQ1zxt2C8yQr0yougjcyfQ2Nn/TWUtcQnIemLmbrzAUrouL7i3V25YJWSzE4JSTn
        W71rFO46xDp5fbkKSGv+Knq4mvYGoWBwLDLfZhVb4LowRK8cI90w2QN4ZrDPpOUnuwuNrAxasYfBq
        birY9cRmAmJXZOpQY0BSh83O1o5ZEDFfN7ghHpYFsey+iLI0L+vsKt75H5L1Zp6vGVE3R3dXPNwF5
        fxRTge8g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL841-00FVaa-Of; Fri, 18 Feb 2022 18:33:05 +0000
Date:   Fri, 18 Feb 2022 10:33:05 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tangmeng <tangmeng@uniontech.com>,
        zhanglianjie <zhanglianjie@uniontech.com>, nizhen@uniontech.com,
        Xiaoming Ni <nixiaoming@huawei.com>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] kernel/lockdep: move lockdep sysctls to its own file
Message-ID: <Yg/mYW8mnWBmrY9G@bombadil.infradead.org>
References: <20220218105857.12559-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218105857.12559-1-tangmeng@uniontech.com>
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

On Fri, Feb 18, 2022 at 06:58:57PM +0800, tangmeng wrote:
> kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
> dishes, this makes it very difficult to maintain.
> 
> To help with this maintenance let's start by moving sysctls to places
> where they actually belong.  The proc sysctl maintainers do not want to
> know what sysctl knobs you wish to add for your own piece of code, we
> just care about the core logic.
> 
> All filesystem syctls now get reviewed by fs folks. This commit
> follows the commit of fs, move the prove_locking and lock_stat sysctls
> to its own file, kernel/lockdep.c.
> 
> Signed-off-by: tangmeng <tangmeng@uniontech.com>

Thanks!

Queued on to the new sysctl-next [0] please use that tree for further sysctl
changes. And please Cc zhanglianjie and nizhen and Xiaoming Ni on future
changes as well.

[0] git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git sysctl-next

  Luis
