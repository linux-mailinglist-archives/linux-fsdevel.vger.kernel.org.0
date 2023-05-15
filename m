Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D318D703E96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 22:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245192AbjEOUYU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 16:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245150AbjEOUYT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 16:24:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8FB10CE;
        Mon, 15 May 2023 13:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y8GfYxEehE3KNcEtHln0pLTgiDjTpLWN9Yvcq3hlIwc=; b=35620JKfdubiAZiQIWGRjKhamW
        yU7sN2mTXJJVzsqBgieI9wOkm3kBUrb03E6xEThFvXfIy0+1Ypk+oAY8fnlJ+cVP3Ae7S0A8bOshK
        MHZ/akWZL0F+/82Ova+HVLa2At7FhTihItrQIlJDGaCwHv68CB1fr+i4BOHWTddCtLceEJIg5Ydgm
        w+pAwaLkOWBijEaAoFMm6ZIt4Zto1EOAcTeP7b1UMAxX4GQe2ZnrnvtGS+WS8dPZ7VSmxV0TQvgSJ
        tZUBN73YQ+ILsWpkFmlOr0Gpc0h8L6kLN6PiBqOvQ7H3h6EClSSC57Q+cyipit0StJ0vxKuI0hB/c
        BFO4CBqg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pyejm-003QNT-0Z;
        Mon, 15 May 2023 20:24:06 +0000
Date:   Mon, 15 May 2023 13:24:06 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joel Granados <j.granados@samsung.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/6] sysctl: Remove register_sysctl_table from parport
Message-ID: <ZGKU5vP8Anmfeen0@bombadil.infradead.org>
References: <CGME20230515071448eucas1p111c55b7078f1541f487c9dfb1a9f9c15@eucas1p1.samsung.com>
 <20230515071446.2277292-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515071446.2277292-1-j.granados@samsung.com>
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

On Mon, May 15, 2023 at 09:14:40AM +0200, Joel Granados wrote:
> This is part of the general push to deprecate register_sysctl_paths and
> register_sysctl_table. Parport driver uses the "CHILD" pointer
> in the ctl_table structure to create its directory structure. We move to
> the newer register_sysctl call and remove the pointer madness.

Nice! Thanks for doing this and unwinding the sysctl use case which
takes the cake for the obfuscation use case of sysctls.

> I have separated the parport into 5 patches to clarify the different
> changes needed for the 3 calls to register_sysctl_paths. I can squash
> them together if need be.

I think it makes sense to keep them that way.

> We no longer export the register_sysctl_table call as parport was the
> last user from outside proc_sysctl.c. Also modified documentation slightly
> so register_sysctl_table is no longer mentioned.

We can go further, but I'll explain in patch review on the patches.

> I'm waiting on the 0-day tests results.

Nice!

  Luis
