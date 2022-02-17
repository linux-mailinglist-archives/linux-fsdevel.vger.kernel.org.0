Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA8F4B9A20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 08:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbiBQHvc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 02:51:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiBQHvb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:51:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7772A39DC;
        Wed, 16 Feb 2022 23:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u1UboIw5kGkVdPuUhtG8b4T+LJ8PQWL40XhaSlt14m4=; b=pNOfS7XsMhXEaBeAwnafjh5qsU
        JlN5Qe8tsXihYVnxPMYIAr3y6MKoCWQ4EWPGuJSxmVxc0zPwTiQLD9m9pAZogLBXbcs8HsFZ/r6Gv
        wxdYHrQ3QWM/VTK7CF0FFu9uFc+gX5SF0kto5pJllOistfG7YwrEluKs/SFz5TUWMK5Wv6vMEQDNO
        sTOkjFz4B02Ib2PfAr9V9c5GSswKJxWUcDKVgdr65lh1Kn+g8QvOZ6AcYOcq1D1/l4QTW/hPUZ8zv
        NCFmpvdMHO86sYCflSeFHa9R56ZF/CI/G1Ntp7UKjJ/RBVfjsVo9GMeaDSJTYudElSjbY+G8Uohd1
        AQiqKc5A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKbZE-009GtV-Ss; Thu, 17 Feb 2022 07:51:08 +0000
Date:   Wed, 16 Feb 2022 23:51:08 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Zhen Ni <nizhen@uniontech.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>
Subject: Re: [PATCH v3 0/8] sched: Move a series of sysctls starting with
 sys/kernel/sched_*
Message-ID: <Yg3+bAQKVX+Dj317@bombadil.infradead.org>
References: <20220215114604.25772-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215114604.25772-1-nizhen@uniontech.com>
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

On Tue, Feb 15, 2022 at 07:45:56PM +0800, Zhen Ni wrote:
> move a series of sysctls starting with sys/kernel/sched_* and use the
> new register_sysctl_init() to register the sysctl interface.

Peter, Andrew,

I'm starting to get more sysctl patches under kernel/ other than the
scheduler. To avoid low quality patches, try to see proactively what
conflicts may lie ahead, ensure everything is applies on linux-next,
and to ensure all this gets baked through 0-day for a while, I'm
going to shove all pending patches into a sysctl-next branch based on
Linus' tree.

I think it doesn't make sense now to just say, do this for sched for one
release. I think we need to get these more widely tested in a faster
way, and to get conflicts ironed out faster too.

Are you folks OK if say Stephen adds a sysctl-next for linux-next so
we can beat on these there too?

FWIW queued on sysctl-next [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-next

  Luis
