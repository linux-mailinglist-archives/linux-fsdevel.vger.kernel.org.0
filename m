Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C799D1983A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 20:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgC3SsP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 14:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgC3SsP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:48:15 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5C3A20714;
        Mon, 30 Mar 2020 18:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585594094;
        bh=oOKIHcQGhYX4hu6jVwRcFykzK3Feu2LcY+JfHQDw3M8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gHnUmVF4MWYXmgkw6buRa6NCGTbUaSjZwehsBCH43kC104WAtMHf1hMxP9NZ3c3jZ
         nD7LEZx2NfyORHJR7V9N9x051RWuPlJkTqP7wO4wNhbZXrLzTTTChy/U5bDAlz920X
         dWsF2HcNWV7j8bi7gjbloNHAfELFS48DCnXCb5eg=
Date:   Mon, 30 Mar 2020 11:48:12 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        NeilBrown <neilb@suse.com>, Stephen Kitt <steve@sk2.org>
Subject: Re: [PATCH v4 3/5] docs: admin-guide: document the kernel.modprobe
 sysctl
Message-ID: <20200330184812.GA108564@gmail.com>
References: <20200318230515.171692-1-ebiggers@kernel.org>
 <20200318230515.171692-4-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318230515.171692-4-ebiggers@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andrew,

On Wed, Mar 18, 2020 at 04:05:13PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Document the kernel.modprobe sysctl in the same place that all the other
> kernel.* sysctls are documented.  Make sure to mention how to use this
> sysctl to completely disable module autoloading, and how this sysctl
> relates to CONFIG_STATIC_USERMODEHELPER.
> 
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jeff Vander Stoep <jeffv@google.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: NeilBrown <neilb@suse.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 25 ++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 

I just noticed there's already a patch going into 5.7 through the docs tree
(https://lkml.kernel.org/lkml/20200329172713.206afe79@lwn.net/) that creates the
documentation for this sysctl:

        commit 0317c5371e6a9b71a2e25b47013dd5c62d55d1a6
        Author: Stephen Kitt <steve@sk2.org>
        Date:   Tue Feb 18 13:59:17 2020 +0100

            docs: merge debugging-modules.txt into sysctl/kernel.rst

It looks for -mm, you resolved the conflict by changing my patch to add the
documentation to a different location in the file.  But that's not correct as it
results in this sysctl being documented twice.

Perhaps just drop this patch for now, but keep patches 1-2 and 4-5?  I can
rebase and resend this documentation patch later.

- Eric
