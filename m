Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCB572BAC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 10:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjFLIfN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 04:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjFLIfD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:35:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3073B9F;
        Mon, 12 Jun 2023 01:35:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6F2D62150;
        Mon, 12 Jun 2023 08:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A4EC433D2;
        Mon, 12 Jun 2023 08:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686558900;
        bh=9ef8ksnCp30UJR78S9cXv1oIl2+eRaHJj41PIcfhvR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XJVn0RVkAHSyGoevsqNZtsq78BCAnUy3P32db4efGj8LOLUaZxHiYCdY7SigiQg+A
         Am3b4A90Dv43KYZ+RlqfssK1gof9t7Ymwggv05mCTxuYi/CedweuzlD6AwpkD0RuaW
         EQjuxRxfY4KlKxOkyNmLmmlwSNkjlJxI/SaaJsO6XJnw+DTxXKxm6RLbEWQknUbG6R
         4/PrrpfDn1J7xZj0aiC1Rm+Bz2LFnj60Tjbs0zi96No7AM8/9xQZqvW7No99PEE9Tz
         ngo0zYVFX7AClE9j5MP++xCvou1SOjNjXl/Pcqy2D+qqaxqrp+aW3XiGyeGspyR+Xz
         +ezzAhzCnlNYw==
Date:   Mon, 12 Jun 2023 10:34:55 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Shaomin Deng <dengshaomin@cdjrlc.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mao Zhu <zhumao001@208suo.com>
Subject: Re: [PATCH] fs: Fix comment typo
Message-ID: <20230612-daran-erhitzen-b839f13a6134@brauner>
References: <20230611123314.5282-1-dengshaomin@cdjrlc.com>
 <ZIXEHHvkJVlmE_c4@debian.me>
 <87edmhok1h.fsf@meer.lwn.net>
 <20230612-kabarett-vinylplatte-6e3843cd76a3@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230612-kabarett-vinylplatte-6e3843cd76a3@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 08:34:53AM +0200, Christian Brauner wrote:
> On Sun, Jun 11, 2023 at 01:50:34PM -0600, Jonathan Corbet wrote:
> > Bagas Sanjaya <bagasdotme@gmail.com> writes:
> > 
> > > On Sun, Jun 11, 2023 at 08:33:14AM -0400, Shaomin Deng wrote:
> > >> From: Mao Zhu <zhumao001@208suo.com>
> > >> 
> > >> Delete duplicated word in comment.
> > >
> > > On what function?
> > 
> > Bagas, do I *really* have to ask you, yet again, to stop nitpicking our
> > contributors into the ground?  It appears I do.  So:
> > 
> > Bagas, *stop* this.  It's a typo patch removing an extraneous word.  The
> > changelog is fine.  We absolutely do not need you playing changelog cop
> > and harassing contributors over this kind of thing.
> 
> 100% agreed.
> 
> > 
> > >> Signed-off-by: Mao Zhu <zhumao001@208suo.com>
> > >
> > > You're carrying someone else's patch, so besides SoB from original
> > > author, you need to also have your own SoB.
> > 
> > This, instead, is a valid problem that needs to be fixed.
> 
> Patch picked up and missing sender SOB added.

I've been informed that I may not be allowed to do that.
So dropping the sender SOB for now following willy's argument.
