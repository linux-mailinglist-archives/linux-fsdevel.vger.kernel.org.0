Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B60B50012E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 23:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiDMVaU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 17:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiDMVaR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:30:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC1C888FE;
        Wed, 13 Apr 2022 14:27:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1989BB82792;
        Wed, 13 Apr 2022 21:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E3CC385A6;
        Wed, 13 Apr 2022 21:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649885269;
        bh=FjG2+pX9sQXWdwJMeAX8PPPWjqJFcjuWd0aqHp4WLGg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sPnv/kKsjBuE1m9S0VgEQlrr7YDHXoHzcjdekSxcuS0Y+jPYJHw8m7oD590PzBAHg
         9YB7FAInDU1LFenE05jW8OU8l7TzPWqoje15Zr1f+fzFsU2dwgB0SxGxTtIz/g6uDs
         GA8emcpTSpdOxICqPFifzDZxGYOXKRtOyNhKAa9w=
Date:   Wed, 13 Apr 2022 14:27:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Daniel Colascione <dancol@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] mm/smaps_rollup: return empty file for kthreads instead
 of ESRCH
Message-Id: <20220413142748.a5796e31e567a6205c850ae7@linux-foundation.org>
In-Reply-To: <20220413211357.26938-1-alex_y_xu@yahoo.ca>
References: <20220413211357.26938-1-alex_y_xu.ref@yahoo.ca>
        <20220413211357.26938-1-alex_y_xu@yahoo.ca>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 13 Apr 2022 17:13:57 -0400 "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca> wrote:

> This restores the behavior prior to 258f669e7e88 ("mm:
> /proc/pid/smaps_rollup: convert to single value seq_file"), making it
> once again consistent with maps and smaps, and allowing patterns like
> awk '$1=="Anonymous:"{x+=$2}END{print x}' /proc/*/smaps_rollup to work.
> Searching all Debian packages for "smaps_rollup" did not find any
> programs which would be affected by this change.

Thanks.

258f669e7e88 was 4 years ago, so I guess a -stable backport isn't
really needed.

However, we need to be concerned about causing new regressions, and I
don't think you've presented enough information for this to be determined.

So please provide us with a full description of how the smaps_rollup
output will be altered by this patch.  Quoting example output would be
helpful.

