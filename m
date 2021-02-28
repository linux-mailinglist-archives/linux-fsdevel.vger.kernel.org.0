Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801C4327015
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Feb 2021 03:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhB1CcE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 21:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhB1CcE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 21:32:04 -0500
X-Greylist: delayed 609 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 27 Feb 2021 18:31:23 PST
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E68C06174A;
        Sat, 27 Feb 2021 18:31:23 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1614478871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v3clyNPh5BV6Eh6aiQwV55s8xCFNzeDvlEXSJrEMBBo=;
        b=PU4xX7EuJdhVWP91woPNS5MXs2FlAwqGK6hd30qqAAg6CWcLRQq5MStzBMXeGXJyAHRlEV
        pq6Wa0Oz65zm37Rk7kN2f4gEA1rK3Debh9jK0jBWfYiuRd5wFKJEtzKir2DuO1MwCw14Ag
        +cAsKU7JJuAbqixYqU3gBybr6qUqsFYyvpzFOOWKNVWYa8JMMQbFA01W6XgP/ZxQJi1W7M
        +1ar4RIeHGvH23pF4JLDiaj1mt/lrNnjiITmu4ysDKCkq9hU2JdpE5m0IDC+hwygfExnJI
        Tbw2lHtm1cCdNVnc3xd+Q3WT/Wj/cGan4JyURuX6bRXcOk9bq7M1Yt1lEHI8nQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Feb 2021 21:21:09 -0500
Message-Id: <C9KSZTRJ2CL6.DWD539LYTVZX@taiga>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        "Aleksa Sarai" <cyphar@cyphar.com>
Subject: Re: [RFC PATCH] fs: introduce mkdirat2 syscall for atomic mkdir
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Al Viro" <viro@zeniv.linux.org.uk>
References: <20210228002500.11483-1-sir@cmpwn.com>
 <YDr8UihFQ3M469x8@zeniv-ca.linux.org.uk>
In-Reply-To: <YDr8UihFQ3M469x8@zeniv-ca.linux.org.uk>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat Feb 27, 2021 at 9:13 PM EST, Al Viro wrote:
> No to the ABI part; "on error it returns -E..., on success - 0 or a
> non-negative number representing a file descriptor (zero also
> possible, but unlikely)" is bloody awful as calling conventions go,
> especially since the case when 0 happens to be a descriptor is not
> going to get a lot of testing on the userland side.

Hm, I was just trying to mimic the behavior of open(2). Do you have a
better suggestion?
