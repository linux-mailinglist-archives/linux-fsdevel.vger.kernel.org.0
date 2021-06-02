Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660E939960B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 00:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhFBWpn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 18:45:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhFBWpn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 18:45:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02A63613DE;
        Wed,  2 Jun 2021 22:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1622673827;
        bh=MqihBVQBgO1GWnwQfcS3BFEdFtGyICXXAb+G/s5Vit4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z9fUoHfd72mSiJIckvZvocT4DstanANcBJXLPn8c5mmlKCvUfZpmNPfSHHtpIQQWr
         ybw3ea4uANNI45tjrgdNVNvGUv3m/krotpd1vYsNv27bTzJkCW0fZaX18CKX60OaOq
         tIfA4zFywZQC9mCJsu+OtiEiPAwZI8gXmi3Jsd8o=
Date:   Wed, 2 Jun 2021 15:43:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     David Matlack <dmatlack@google.com>,
        linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: Re: [PATCH] proc: Add .gitignore for proc-subset-pid selftest
Message-Id: <20210602154346.bade2869de9eddb6db87509f@linux-foundation.org>
In-Reply-To: <20210602085710.kp26wquy6anwy5kd@wittgenstein>
References: <20210601164305.11776-1-dmatlack@google.com>
        <20210602085710.kp26wquy6anwy5kd@wittgenstein>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2 Jun 2021 10:57:10 +0200 Christian Brauner <christian.brauner@ubuntu.com> wrote:

> On Tue, Jun 01, 2021 at 04:43:05PM +0000, David Matlack wrote:
> > This new selftest needs an entry in the .gitignore file otherwise git
> > will try to track the binary.
> > 
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> 
> Could use a
> Cc: stable@kernel.org
> link but Shuah might be able to fix this when applying.

I added

Fixes: 268af17ada5855 ("selftests: proc: test subset=pid")

but no cc:stable - 268af17ada5855 was added during the 5.13 cycle.

> Otherwise looks good,
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks.
