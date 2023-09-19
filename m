Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0217A5C7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 10:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjISI2U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 04:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjISI2S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:28:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AEA119;
        Tue, 19 Sep 2023 01:28:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0FBC433CA;
        Tue, 19 Sep 2023 08:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695112091;
        bh=fbb6AV/oXqZ1hMjMw2L1lQ2VSWjkN/YALz0Lp+Y4L2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c/UZOdb3jnEp6uQvK4E3WPE4X/To0zzr5xfTmlTkgZr2+gMrRB4EeMNlH6Vj1hXFb
         7ZdBEzEJMy4rEWY7DLFjtJDMh+lQFwDwIv8vqO9mSrdXxAdSUG7jgji4Yks87qpkfp
         R9ZOi4+BeKXQTYuBzWLDNRmK3c/rXKQAJY96YJtjwDVv4GIJkMzL/YCBQDdIhqAfvD
         uuS6A6buOp+0mnxNcUO/Eer+JWyFQIA6TxAW5SWqsHueWnhYKsMScA/NPOhFUSp0sM
         OI2BYu0Z9KYfT6avkS+uyj/ZwQW5yNM01qHXVBCkA3JHzwXqYqkMtNU38sQmdQ18Ed
         atHW4wbH1igpg==
Date:   Tue, 19 Sep 2023 10:28:07 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] timestamp fixes
Message-ID: <20230919-kranz-entsagen-064754671396@brauner>
References: <20230918-hirte-neuzugang-4c2324e7bae3@brauner>
 <CAHk-=wiTNktN1k+D-3uJ-jGOMw8nxf45xSHHf8TzpjKj6HaYqQ@mail.gmail.com>
 <e321d3cfaa5facdc8f167d42d9f3cec9246f40e4.camel@kernel.org>
 <CAHk-=wgxpneOTcf_05rXMMc-djV44HD-Sx6RdM9dnfvL3m10EA@mail.gmail.com>
 <2020b8dfd062afb41cd8b74f1a41e61de0684d3f.camel@kernel.org>
 <CAHk-=whACfXMFPP+dPdsJmuF0F6g+YHfUtOxiESM+wxvZ22-GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whACfXMFPP+dPdsJmuF0F6g+YHfUtOxiESM+wxvZ22-GA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Christian - I'm just going to assume that you'll sort this out and
> I'll get a new pull request at some point. Holler if you think
> something else is needed, ok?

I'll take care of it and will send you a new pull request once
everything's sorted. Thanks for looking!

Christian
