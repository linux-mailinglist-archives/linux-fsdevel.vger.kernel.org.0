Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9EF524EF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 15:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354781AbiELN5B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 09:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354768AbiELN4y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 09:56:54 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A0A3982D;
        Thu, 12 May 2022 06:56:52 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24CDuk1S025723
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 09:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652363808; bh=fK1JutfKwB9RZi7LGZBoNzqwgl48auY9kCDUP4LKjGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=UdsqUMuxNr9fe51BYBreYmwrfOY1B++I+ve8viaz0nmXc6KyQP5QUzEjOXAOAk4ra
         g8Tr5jAwwqGdfLEZT3d8iGx07G6013fFup2jsp6fjMByQkPvPM7yC06ELxnpD8rVsB
         1sxDQ9aqUvLS5dS7Sa3ta0hvdwNATlFnfdv/y9/oYwrKDrZxkYGSYvQXdmyBnWws2S
         PHEQ9SuJKLtMvK42rHTFd0TlOuBN4zDHFnoLMwcvI8XW5rrTW4gTOi0+I5Kb4gWPQ8
         UA8k4Zb1JGSopLJy9riWjPVB0MCf9k1zX5RrjRWwXGG1E7eacsHmf+ZiylDmJ6kJ9O
         N+RhD+0vEgzeQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B5CC215C3F2A; Thu, 12 May 2022 09:56:46 -0400 (EDT)
Date:   Thu, 12 May 2022 09:56:46 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     tj@kernel.org, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
        daniel.vetter@ffwll.ch, chris@chris-wilson.co.uk,
        duyuyang@gmail.com, johannes.berg@intel.com, willy@infradead.org,
        david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, mcgrof@kernel.org, holt@sgi.com
Subject: Re: [REPORT] syscall reboot + umh + firmware fallback
Message-ID: <Yn0SHhnhB8fyd0jq@mit.edu>
References: <YnzQHWASAxsGL9HW@slm.duckdns.org>
 <1652354304-17492-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652354304-17492-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 12, 2022 at 08:18:24PM +0900, Byungchul Park wrote:
> I have a question about this one. Yes, it would never been stuck thanks
> to timeout. However, IIUC, timeouts are not supposed to expire in normal
> cases. So I thought a timeout expiration means not a normal case so need
> to inform it in terms of dependency so as to prevent further expiraton.
> That's why I have been trying to track even timeout'ed APIs.

As I beleive I've already pointed out to you previously in ext4 and
ocfs2, the jbd2 timeout every five seconds happens **all** the time
while the file system is mounted.  Commits more frequently than five
seconds is the exception case, at least for desktops/laptop workloads.

We *don't* get to the timeout only when a userspace process calls
fsync(2), or if the journal was incorrectly sized by the system
administrator so that it's too small, and the workload has so many
file system mutations that we have to prematurely close the
transaction ahead of the 5 second timeout.

> Do you think DEPT shouldn't track timeout APIs? If I was wrong, I
> shouldn't track the timeout APIs any more.

DEPT tracking timeouts will cause false positives in at least some
cases.  At the very least, there needs to be an easy way to suppress
these false positives on a per wait/mutex/spinlock basis.

      	       	    	     	      	   	 - Ted
