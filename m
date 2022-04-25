Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB91550E0ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 14:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbiDYNCi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 09:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240557AbiDYNCd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:02:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A137913F11
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 05:59:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 59C36210F1;
        Mon, 25 Apr 2022 12:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650891568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SxgnGiDK3Xnvt1bQBau/QuBOyIAUouoDlhHFRreFOZ4=;
        b=w7lITHFrFNR/7k+U3xfgQbXr2R4OyZEwHVW7rcq8TECVOjYBueH9iz2tAw/PzY8BYxgm0u
        yS83zTwjTQuXHn07zsZzcBupjAybtfqpPDLrfwp1Q9IcVfiALyo9n7YExSQvB9feqfV7mu
        /Al3IOCKYBNGC/f7EfXJ2mhVsIYsvsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650891568;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SxgnGiDK3Xnvt1bQBau/QuBOyIAUouoDlhHFRreFOZ4=;
        b=ld1vDs2vS0iB3dW+7tRZbBKYgzn44bl9Zc0cTNYW66WSLoB1jato2FQM1EjnbuZ4YCFG4k
        FjyOFKeIo66Wo2Bg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 471162C141;
        Mon, 25 Apr 2022 12:59:28 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F1A90A0620; Mon, 25 Apr 2022 14:59:24 +0200 (CEST)
Date:   Mon, 25 Apr 2022 14:59:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/16] Evictable fanotify marks
Message-ID: <20220425125924.qd7qfgjsvgbj7qyg@quack3.lan>
References: <20220422120327.3459282-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422120327.3459282-1-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir!

On Fri 22-04-22 15:03:11, Amir Goldstein wrote:
> Following v4 patch set addresses your review comments on v3 [3].
> 
> I allowed myself to take the clean you requested for
> fanotify_mark_update_flags() and recalc argument a bit further.
> I hope you will like the result.

The result looks good. I've merged the patches to my tree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
