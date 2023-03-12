Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509AB6B6B19
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Mar 2023 21:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjCLUac (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Mar 2023 16:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjCLUaa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:30:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0EB36442;
        Sun, 12 Mar 2023 13:30:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A324B80D67;
        Sun, 12 Mar 2023 20:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99035C433EF;
        Sun, 12 Mar 2023 20:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1678653027;
        bh=7ZdJjtvONGlnyQxl/MSqAHbeDZqT//t50NNJbtDtWQ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HLTab+6F6U4xfpJVlZUHebm21jC9SBllnhfYVVHFe8Ty93ZRAMcTIV3Yu5eX7ThIL
         AO3ATueDhj93AQKf4xvz7s1uO+rl7GkYfUEHuaog2cIw4ArO06VEYXU6yywNbnbjpv
         kmfAI/FU+EiZWma9+AmaQj8v/blTNProugC1Xlyg=
Date:   Sun, 12 Mar 2023 13:30:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     pvorel@suse.cz, gregkh@linuxfoundation.org, keescook@chromium.org,
        Jason@zx2c4.com, ebiederm@xmission.com, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] utsname: simplify one-level sysctl registration for
 uts_kern_table
Message-Id: <20230312133025.deb572fd12d56ffe42ab8955@linux-foundation.org>
In-Reply-To: <20230310231656.3955051-1-mcgrof@kernel.org>
References: <20230310231656.3955051-1-mcgrof@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 10 Mar 2023 15:16:56 -0800 Luis Chamberlain <mcgrof@kernel.org> wrote:

> This is part of the effort to phase out calls that can recurse from
> sysctl registration [0]. If you have a tree to take this in feel free
> to take it, or I can take it too through sysclt-next. Let me know!
> 
> This file has no explicit maintainer, so I assume there is no tree.

I act as a backstop for such changes, if people cc me.

> If I so no one taking it I can take in as part of sysctl-next later.

Please do that.
