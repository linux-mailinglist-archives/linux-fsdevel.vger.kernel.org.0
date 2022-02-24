Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF8E4C3758
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 22:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbiBXVG7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 16:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiBXVG6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 16:06:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6903D24FA27;
        Thu, 24 Feb 2022 13:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gqwsfxNL/6u6rNbdgXApLMLgt2yxqOUUOtWYMHIjK/s=; b=TIctb2fI/Th0lTWb0MsVMD/mze
        ygDbG+qwvvYChpgzeugUgvWAh1UnWeb+BBL4nWUOLBYTLF1WDKe4XaRG+RZGIH0gFFGxo6L/JClJa
        W9mwKicf+pRvoyYIJRjMJ9WwEvCr8yxmoKVlb6mtFvGHqlF4Qof/J+JJuna1JWC1wUHIQAXacYgRe
        Z+3OjnWf/3pC1oAJXDqzTpfvRMF9n1o/LqiyljVjemJYY5d5stQe9rJFFHkjWHAl2Bfwp4i+rUpfE
        PM5zdL1+Gs7HXhVFVDvA6MFrXjw0o7szFHgmJxI52cUFFdKBtjzigj2IEaEY8SfBHUBGOJ/2ImjHw
        viPH3q1w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNLJh-0058qy-3b; Thu, 24 Feb 2022 21:06:25 +0000
Date:   Thu, 24 Feb 2022 21:06:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Byron Stanoszek <gandalf@winds.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: Re: Is it time to remove reiserfs?
Message-ID: <YhfzUc8afuoQkx/U@casper.infradead.org>
References: <YhIwUEpymVzmytdp@casper.infradead.org>
 <20220222100408.cyrdjsv5eun5pzij@quack3.lan>
 <20220222221614.GC3061737@dread.disaster.area>
 <3ce45c23-2721-af6e-6cd7-648dc399597@winds.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ce45c23-2721-af6e-6cd7-648dc399597@winds.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 23, 2022 at 09:48:26AM -0500, Byron Stanoszek wrote:
> For what it's worth, I have a number of production servers still using
> Reiserfs, which I regularly maintain by upgrading to the latest Linux kernel
> annually (mostly to apply security patches). I figured this filesystem would
> still be available for several more years, since it's not quite y2038k yet.

Hey Byron, thanks for sharing your usage.

It's not entirely clear to me from your message whether you're aware
that our annual LTS release actually puts out new kernels every week (or
sometimes twice a week), and upgrades to the latest version are always
recommended.  Those LTS kernels typically get five years of support in
total; indeed we just retired the v4.4 series earlier this month which
was originally released in January 2016, so it got six years of support.

If we dropped reiserfs from the kernel today (and thanks to Edward, we
don't have to), you'd still be able to use a v5.15 based kernel with
regular updates until 2028.  If we drop it in two years, that should
take you through to 2030.  Is that enough for your usage?
