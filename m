Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4AD61708F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 23:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiKBWTb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 18:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiKBWT3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 18:19:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4D1BCB6;
        Wed,  2 Nov 2022 15:19:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0084B8244D;
        Wed,  2 Nov 2022 22:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F178AC433D6;
        Wed,  2 Nov 2022 22:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667427564;
        bh=wl6G+UPlJpNzy31t7lvwfXGqECkGZLAEZq/RLczszg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OMrfYWvkiLREA4eLHeW8enn1L+6oAQhmpfQKCHlYHpd/2E8M0l+JpoDsRB8PzUy+M
         Jyxkw8zZjO+BFoVJluKts6IGjZ6a2LvvKR/9yI7rEui4MAZvFGggmWZUtR7/JmxilX
         vL1F97n4frjEhejis2q79DU+5/dv65iPF8IupfzC8xs2Ti3fH37ZHm6TakOAClujhx
         6JwRml7yt2rFgW43rOkCt+XDvZLRJby1f9YfN6olXA3egDIXbKSZUiZCblrsAYyCJH
         CnAweYiSYjoE0SOvd8IK1IxDWRQ8fq3CgDxMjzPcTH2gu1RQVJbaLePnZYCp2w9OHh
         5Dgw7vuFFIljQ==
Date:   Wed, 2 Nov 2022 15:19:22 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: Re: fs: layered device driver to write to evdev
Message-ID: <Y2Ls6tPhgOcfyxZ2@sol.localdomain>
References: <CABDcava8ADBNrVNh+7A2jG-LgEipcapU8dVh8p+jX-D4kgfzRg@mail.gmail.com>
 <CABDcava_0n2-WdyW6xO-18hTPNLpdnGVGoMY4QtPhnEVYT90-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABDcava_0n2-WdyW6xO-18hTPNLpdnGVGoMY4QtPhnEVYT90-w@mail.gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 02, 2022 at 02:14:24PM +0100, Guillermo Rodriguez Garcia wrote:
> What is the recommended way to have a layered device driver that can
> talk to evdev ?

Don't do that.  evdev is a userspace interface, not something for internal
kernel use.  Just write userspace code that uses evdev to do what you want.
Or if it's really necessary, add features to the real device driver.

- Eric
