Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD9569B889
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 08:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjBRHtM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 02:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBRHtL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 02:49:11 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C496E43450;
        Fri, 17 Feb 2023 23:49:09 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 622ADC01F; Sat, 18 Feb 2023 08:49:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676706571; bh=SNQrITH6He6cyqDtohKqoAHimWnNUzPJH2XwvQbg/M0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JS5KXU4FKrbNhBKW5Blw6jUfAfcNRgKQujmRHI/Xv9y34Nk9A2ntsMHmoI8XdOEhk
         wGXgWn8ajn6nli/xt37l6PNmEBdf/6Ovgum7Pq8FEY9BiYqqTHllzXJqPtlFVJK9mz
         oFoELedp+tCLwxflPTVk6zUReBPXwJxjd2qM1cTs6+uofBE5EQS6V6WNHCJM2EZpzg
         pgDr5sh5/O1w8fjYosuDq4FFM7Khtcmex12fjQ1uzxmcPHW1rJiVxvo4gcsvS+01kY
         qGoqfCuSs3Q+YJFU3Lt2e6Id4nWu3Vinw8hQDd1hFvCVdO8g/v74XIYWd6yhH0ww8Z
         2lTzOWHs5DYDg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 8FD06C009;
        Sat, 18 Feb 2023 08:49:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676706570; bh=SNQrITH6He6cyqDtohKqoAHimWnNUzPJH2XwvQbg/M0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qiivNhLQc5gQ9M0Bn1CWrePFSoYcpOnRmkg4sGZOQzsgc1MGBKcsha28EyWcmPrl0
         h6KCVUk+DAl4dob68e3ivlq2VAoC6o4t8OFbb2KJXrNeigZz3gIBKXAcsakyIsRQY0
         UWIAbDAOikNYsXqHUNpqyeSjT+7VbeZ82TN8unh2bbv1lC1GS9EIRMiWA+PGOnNH5A
         MubQpCeIAd0CvHG9Z5UjyHYA+V5RtJEklUlAPYmPeGgPCAlSkStIC3+FtD/7vQ5Cot
         0MhY5Ur3Y3sQpwDr+kY1KFiEOXu7VgviRn1x8mzM7rMDP2BRwHf82LmLYeiexXT9Gt
         Yuq7W4nhL2HdQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id f49989bc;
        Sat, 18 Feb 2023 07:49:01 +0000 (UTC)
Date:   Sat, 18 Feb 2023 16:48:46 +0900
From:   asmadeus@codewreck.org
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux_oss@crudebyte.com
Subject: Re: [PATCH v4 00/11] Performance fixes for 9p filesystem
Message-ID: <Y/CC3qyBFSFVI/S0@codewreck.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-1-ericvh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230218003323.2322580-1-ericvh@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Van Hensbergen wrote on Sat, Feb 18, 2023 at 12:33:12AM +0000:
> I'm gonna definitely submit the first couple patches as they are
> fairly harmless - but would like to submit the whole series to the
> upcoming merge window.

Could you take the three patches I have in my 9p-next branch:
https://github.com/martinetd/linux/commits/9p-next

If you're going to submit some?
The async stuff still isn't good, but there three patches have had
reviews and should be good to go.

(I guess we can just send Linus two pull requests for 9p, but it doesn't
really make sense given the low number of patches)

> Would appreciate reviews.

Just one first review on the form: let's start a new thread for every
new revision of the patchset.

I also used to relink from the pervious cover letter and thought that
made more sense at the time, but I was told to split threads a while ago
and now I'm trying some new tools based on lkml.kernel.org's public
inbox thread view I can agree it's much simpler to grab a batch of patch
if older versions aren't mixed in the thread.
(For the curious, I'm just grabbing the thread to review on an e-ink
reader for my eyes, but there's also b4 that I've been meaning to try at
some point -- https://b4.docs.kernel.org/en/latest/ -- that will likely
work the same)

Anyway, off to look at patches a bit.

-- 
Dominiquee
