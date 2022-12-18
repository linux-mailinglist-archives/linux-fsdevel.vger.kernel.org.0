Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F7E650488
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Dec 2022 20:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiLRTuA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Dec 2022 14:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLRTt7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Dec 2022 14:49:59 -0500
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B843ADE4;
        Sun, 18 Dec 2022 11:49:58 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 50806C009; Sun, 18 Dec 2022 20:50:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1671393009; bh=gzRa6huFbcrZLvLkrDSmTVFdbVyeUMFAbkgdKnjl9l8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RjKTnYDIn6wfQ6ukiJlCOlwQMqU3pn5/PIIlgakfNq3I18A97uyWLzp0xldAL6GN3
         b49cUGCwTdVVfrHcjzOBdaFUuv1pwRDgVvamcLo2qe38RoHkn0/pwbup+NmQd+O9UU
         5sjN3ev/lVSw2BWE8Wlx+tt8qtUPR3PjCLHFFDE3QA1PxoQ10R6UN1jlwf2ifH0Bky
         1haiV3mkUh65thUKuXrnDAibByRzmoeYDEBSpx53JvwM/7knT/5Qsjwqoi/aVyN5cR
         I4jO+lG5cQEciDPvn/z1lDKJwsMjW/1LXo0Le37Dqd1NrrH22dNVqn1p8rmM5PzsNA
         U3ccmPw+qP1xw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id B178FC009;
        Sun, 18 Dec 2022 20:50:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1671393007; bh=gzRa6huFbcrZLvLkrDSmTVFdbVyeUMFAbkgdKnjl9l8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bi8DfmRN3Mp/E6qkHghZ3GJNqzVQdQOuOomDkxM7FdMjVdwEEfWUl294aM/NTmT5H
         hr/uy2hs17Rc5QmJClzTuEpqOC/TPulGPVAAnO0SM0wopfe1Pu3nfA6LTontmWuFdv
         SWgnCfsnVlES5kqhs/En+Uc8GAg+p3y0Skzo1Fs5SOIH7YKEjrjr1n1VDHC9e6Y0l8
         e78VYajPTeBisKs7zzka5DtUukXsI+GXiHvPBEvq1ydBlj0CLtlQBsmkVrAB0xAy//
         EcGsEtaJZFmvZgnuP+2onvZTTzU6E3eunwDOPALox7AasNMhqGQUdES5YO3RGY3Fun
         3IXMPK5y9pMvw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 0e0d0f0b;
        Sun, 18 Dec 2022 19:49:50 +0000 (UTC)
Date:   Mon, 19 Dec 2022 04:49:35 +0900
From:   asmadeus@codewreck.org
To:     evanhensbergen@icloud.com
Cc:     Latchesar Ionkov <lucho@ionkov.net>, linux_oss@crudebyte.com,
        linux-kernel@vger.kernel.org, Ron Minnich <rminnich@gmail.com>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [PATCH 2/6] Don't assume UID 0 attach
Message-ID: <Y59uz0aeuoLMU9W8@codewreck.org>
References: <20221217185210.1431478-1-evanhensbergen@icloud.com>
 <20221217185210.1431478-3-evanhensbergen@icloud.com>
 <Y55Z2DwZgRG+9zW3@codewreck.org>
 <3343B7A9-2D1D-4A41-859E-B04AF90152FA@icloud.com>
 <864E1007-CBCF-40C7-B438-A76C3065AFC9@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <864E1007-CBCF-40C7-B438-A76C3065AFC9@icloud.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

evanhensbergen@icloud.com wrote on Sun, Dec 18, 2022 at 10:32:57AM -0600:
> Okay, reproduced the error you suspected on the patch.  It’s kind of a
> pain because the code as is won’t work unless I’m running the file
> server as root and changing all the servers to ignore requests seems
> off.  It also occurred to me that having a root R/W write back could
> be a security vulnerability.  I tried patching it with
> dfltuid/dfltgid, but only root can override the modes so that doesn’t
> work.
> 
> Since I have the better write back fix testing okay, we could drop
> this patch from the series and I could just focus on getting that
> patch ready (which I should be able to do today).  It does seem to
> work with the python test case you gave, so it doesn’t have the same
> issues.
> 
> Thoughts?

That sounds good to me, thanks!

I haven't had time to look at the other patches in detail but they look
good to me in principle.
I'll try to find time to run some xfstests this week to check for
regressions with the other patches (I don't have any list, so run some
before/after with qemu in cache=mmap/loose modes perhaps?) and we can
submit them next merge window unless you're in a hurry.
Some are obvious fixes (not calling in fscache code in loose mode) and
could get in faster but I don't think we should rush e.g. option
parsing... Well that probably won't get much tests in -next, I'll leave
that up to you.

Do you (still?) have a branch that gets merged in linux-next, or shall I
take the patches in for that, or do you want to ask Stefen?
(I should probably just check myself, but it's 5am and I'll be lazy)

-- 
Dominique
