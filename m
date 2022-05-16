Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43D7527F23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 10:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241475AbiEPIFA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 04:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbiEPIE7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 04:04:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF073121B
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 01:04:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E763FB80EB2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 08:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107C6C385AA;
        Mon, 16 May 2022 08:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652688294;
        bh=HYbV/vQ1taTvFscvBnZOB9fYgXR0kI+r50WuLyx0xFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MeQStI8FOf13WUQcFV5yr/r0Drz9cUBnaDRIW8fR2LXizKhafbT1QaJD42mdmv5lL
         kM6tH4GZXDEa61GZu7BN8kmRStjC2nDD+hj76J8xzpIJ4+RIjPrLJuhK+SpLLT5FC5
         nYaBlyPQHgUNCS4gcY4G9oEtIYhKFCReY0+81o8dkS473X9w/sKjDHLYaZtknk6/xt
         RQOPklL2kEtnFW3/ybQ7hEYGquSrLnVO7R3kxjuwD6wKPt3mkECTLBod2vVUS5uGv2
         pTRaG9RevS9+ER+PIX56VA4as3OLiBueWvDPQntWMyuC2j6WiXqD4ZzdBwaeh2Zdrl
         w3L80ER3tl3ug==
Date:   Mon, 16 May 2022 10:04:49 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Jens Axboe <axboe@kernel.dk>, Todd Kjos <tkjos@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [RFC] unify the file-closing stuff in fs/file.c
Message-ID: <20220516080449.og7gbnsjoa3weii4@wittgenstein>
References: <Yn16M/fayt6tK/Gp@zeniv-ca.linux.org.uk>
 <20220513105218.6feck5rqd7igipj2@wittgenstein>
 <YoA8LSXfYTITfnKm@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YoA8LSXfYTITfnKm@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 14, 2022 at 11:33:01PM +0000, Al Viro wrote:
> On Fri, May 13, 2022 at 12:52:18PM +0200, Christian Brauner wrote:
> 
> > 	Context: Caller must hold files_lock.
> 
> Done and force-pushed to #work.fd
>  
> > Also, there's a bunch of regression tests I added in:
> > 
> > tools/testing/selftests/core/close_range_test.c
> > 
> > including various tests for issues reported by syzbot. Might be worth
> > running to verify we didn't regress anything.
> 
> # PASSED: 7 / 7 tests passed.
> # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0

Thank you, appreciate it!

Christian
