Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F06C73E00D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 15:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjFZNCu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 09:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjFZNCl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:02:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B40019F;
        Mon, 26 Jun 2023 06:02:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2FE960E86;
        Mon, 26 Jun 2023 13:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9A6C433C0;
        Mon, 26 Jun 2023 13:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687784546;
        bh=qHCByCNDys2ECT6mI9nx7oOPVqRAJqAf0TdsDuDj2PI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o53DZaDNvEAwptnEewGQrTiUVPR6v8FwlmTYX7yfgHWj/oUbJGR0mhRH1GL39WX5g
         fp4oalcmiYuaNf5x8s65Ydy5ihYFrRckIWBUSM6GaHDjLwal1iUXFES1D/rhkOxDnz
         cdPK4n96JJlMF7nWtd+JoN35UgJzBHocXT3XWUCw=
Date:   Mon, 26 Jun 2023 15:02:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Byungchul Park <byungchul@sk.com>
Cc:     linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
        torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, kernel-team@lge.com, linux-mm@kvack.org,
        akpm@linux-foundation.org, mhocko@kernel.org, minchan@kernel.org,
        hannes@cmpxchg.org, vdavydov.dev@gmail.com, sj@kernel.org,
        jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: Re: [PATCH v10 00/25] DEPT(Dependency Tracker)
Message-ID: <2023062627-chooser-douche-6613@gregkh>
References: <20230626115700.13873-1-byungchul@sk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626115700.13873-1-byungchul@sk.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 08:56:35PM +0900, Byungchul Park wrote:
> >From now on, I can work on LKML again! I'm wondering if DEPT has been
> helping kernel debugging well even though it's a form of patches yet.
> 
> I'm happy to see that DEPT reports a real problem in practice. See:
> 
>    https://lore.kernel.org/lkml/6383cde5-cf4b-facf-6e07-1378a485657d@I-love.SAKURA.ne.jp/#t
>    https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byungchul.park@lge.com/
> 
> Nevertheless, I apologize for the lack of document. I promise to add it
> before it gets needed to use DEPT's APIs by users. For now, you can use
> DEPT just with CONFIG_DEPT on.
> 
> ---
> 
> Hi Linus and folks,
> 
> I've been developing a tool for detecting deadlock possibilities by
> tracking wait/event rather than lock(?) acquisition order to try to
> cover all synchonization machanisms. It's done on v6.2-rc2.
> 
> Benifit:
> 
> 	0. Works with all lock primitives.
> 	1. Works with wait_for_completion()/complete().
> 	2. Works with 'wait' on PG_locked.
> 	3. Works with 'wait' on PG_writeback.
> 	4. Works with swait/wakeup.
> 	5. Works with waitqueue.
> 	6. Works with wait_bit.
> 	7. Multiple reports are allowed.
> 	8. Deduplication control on multiple reports.
> 	9. Withstand false positives thanks to 6.
> 	10. Easy to tag any wait/event.
> 
> Future work:
> 
> 	0. To make it more stable.
> 	1. To separates Dept from Lockdep.
> 	2. To improves performance in terms of time and space.
> 	3. To use Dept as a dependency engine for Lockdep.
> 	4. To add any missing tags of wait/event in the kernel.
> 	5. To deduplicate stack trace.

If you run this today, does it find any issues with any subsystems /
drivers that the current lockdep code does not find?  Have you run your
tool on patches sent to the different mailing lists for new drivers and
code added to the tree to verify that it can find issues easily?

In other words, why do we need this at all?  What makes it 'better' than
what we already have that works for us today?  What benifit is it?

thanks,

greg k-h
