Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 556F018C6FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 06:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgCTF2W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 01:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCTF2W (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 01:28:22 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53DEC20722;
        Fri, 20 Mar 2020 05:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584682101;
        bh=FO5gNo9ZRts77UVIBxkgq5rmiyJY3FXlj5T8dqql1WQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H/b4YGiVzb7bQp0TUbbBp0010RaSpXSa0f4jToSs924V8kn//Kf5H5RD/40y+A+X3
         dIu9nuUjUU4T3mBAvB7O+OMdRhHhZip0YrGigwJEiSJzw2j9BWKw6QNOnMwWuoDyyh
         elefiarDP+nrvRZ7MRxDafmpflzRy3X7vgsm2mPE=
Date:   Thu, 19 Mar 2020 22:28:19 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v4 0/5] module autoloading fixes and cleanups
Message-ID: <20200320052819.GB1315@sol.localdomain>
References: <20200318230515.171692-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318230515.171692-1-ebiggers@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 18, 2020 at 04:05:10PM -0700, Eric Biggers wrote:
> This series fixes a bug where request_module() was reporting success to
> kernel code when module autoloading had been completely disabled via
> 'echo > /proc/sys/kernel/modprobe'.
> 
> It also addresses the issues raised on the original thread
> (https://lkml.kernel.org/lkml/20200310223731.126894-1-ebiggers@kernel.org/T/#u)
> by documenting the modprobe sysctl, adding a self-test for the empty
> path case, and downgrading a user-reachable WARN_ONCE().
> 
> Changed since v3:
>   - Added Fixes tag to the fs/filesystems.c patch, and mentioned why the
>     warning is continued to be printed once only.
> 
> Changed since v2:
>   - Adjusted the new documentation to avoid implicitly bringing up
>     module aliases, which are a more complex topic.
>   - Split the selftest patch into two patches, one to fix the test
>     numbering bug and one to add the new tests.
> 
> Changed since v1:
>   - Added patches to address the other issues raised on the thread.

It seems that people are relatively happy with this patch series now.
Andrew, will you be taking it through -mm?  I don't see any better place.

Thanks,

- Eric
