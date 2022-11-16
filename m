Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4AA62C767
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 19:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbiKPSQ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 13:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238854AbiKPSQp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:16:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F4E6314F;
        Wed, 16 Nov 2022 10:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3QlE2bOOn3d9ibwxdimqr4/FiU3pKkYhXqcHPHT4Nog=; b=MqnUG3fItIqA4aopRIW4CFI+M4
        PtCt++JZtk2E0rSA5HFsBG+tI3p2640KnmIq1d/97x+eXOFnmQVchRlszcZvqlvQvkneE/Q1RtIHn
        ZmnZJa/nhOkhFllZ6XZXGHm3ecE7oFdK3wvkT0A6g6Ek0vX0y1MWFUIG3rvr2fnkRWdwWJhhyyhJL
        4RZ9FBu3cmyy/gDSw10IrmdtDwt2GnL6IQ0pdVWR21ciu2zyk/1m+12KzbdwY3GRFZfrfl6JsA6Y6
        eU+SMY9P581WLA7Se3c4kUA7Xy/PzAZNM9dRP3z74ZTeYZ+ZTNskyzAEAPhSch0tLef/4O9OH70MK
        gOBngGMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovMxn-0004rs-Jg; Wed, 16 Nov 2022 18:16:43 +0000
Date:   Wed, 16 Nov 2022 18:16:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Denis Arefev <arefev@swemel.ru>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        trufanov@swemel.ru, vfh@swemel.ru
Subject: Re: [PATCH] namespace: Added pointer check in copy_mnt_ns()
Message-ID: <Y3UpC8AT8gTeupib@casper.infradead.org>
References: <20221116091255.84576-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116091255.84576-1-arefev@swemel.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 16, 2022 at 12:12:55PM +0300, Denis Arefev wrote:
> Return value of a function 'next_mnt' is dereferenced at
> namespace.c:3377 without checking for null,
>  but it is usually checked for this function
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

You need to do human analysis, not just send the results from a bot.
What conditions can lead to this function returning NULL?  Do we
already know those conditions can or cannot hold?

