Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2384867FCDE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jan 2023 06:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjA2FfG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Jan 2023 00:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2FfE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Jan 2023 00:35:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B188212AC;
        Sat, 28 Jan 2023 21:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=VKxlaGMrI0cp0ye3H9Jmx6z3Rmpn9Z9p0OcUfzcS/oA=; b=nbpw9oZ9+eUaa2rK2vTNyKdREg
        ra/ZABuEmnzsfMygFg2JjR8HqA7CsdnqE6Rut5g7a86By3qnU8k288DbSkuignY6kiHSW6O1IbwYE
        8Om32g0UTek8t5gusVEU4fN+yY2pl21g78mWnvBf9NErom7t7zNF5iko8sZyvjxOLKJNcz/n89nQF
        f8GGStR9xGwZ2UpmCU7tBqDHC/13vJ7B42MefmwlsHOPtFj18nERLMlNIjQ0fbxriFqIr0fYE1DaH
        hKWFGHGOjkm5qoL+eiRiySd1iS7qBLSkQ6zAbd1CN3lB9BmEaLWlWcdG3d67/tjFSvxDhXUa9i2rf
        SWjUalYQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pM0LA-0014cV-3J; Sun, 29 Jan 2023 05:34:56 +0000
Date:   Sat, 28 Jan 2023 21:34:56 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     lsf-pc@lists.linux-foundation.org
Cc:     amir73il@gmail.com, a.manzanares@samsung.com,
        chandan.babu@oracle.com, jlayton@kernel.org, josef@toxicpanda.com,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: LSF/MM/BPF BoF: pains / goods with automation with kdevops
Message-ID: <Y9YFgDXnB9dTZIXA@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

More suitable towards a BoF as I don't *think* a larger audience would be
interested. At the last LSF during our talks about automation it was suggested
we could share a repo and go to town as we're all adults. That's been done:

https://github.com/linux-kdevops/kdevops

At ALPSS folks suggested maybe non-github, best we can do for now is
gitlab:

https://gitlab.com/linux-kdevops/kdevops

There's been quite a bit of development from folks on the To list. But
there's also bugs even on the upstream kernel now that can sometimes erk us.
One example is 9p is now used to be able to compile Linux on the host
instead of the guests. Well if you edit a file after boot on the host
for Linux, the guest won't see the update, so I guess 9p doesn't update
the guest's copy yet. Guests just have to reboot now. So we have to fix that
and I guess add 9p to fstests. Or now that we have NFS support thanks to
Jeff, maybe use that as an option? What's the overhead for automation Vs 9p?

We dicussed sharing more archive of results for fstests/blktests. Done.
What are the other developer's pain points? What would folks like? If
folks want demos for complex setups let me know and we can just do that
through zoom and record them / publish online to help as documentation
(please reply to this thread in private to me and I can set up a
session). Let's use the time at LSF more for figuring out what is needed
for the next year.

  Luis
