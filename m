Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DFF34075B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 15:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhCROAs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 10:00:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39049 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhCROAd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 10:00:33 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lMtCQ-0004ds-V0; Thu, 18 Mar 2021 14:00:31 +0000
Date:   Thu, 18 Mar 2021 15:00:29 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@google.com>,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: fix incorrect pde_is_permanent check
Message-ID: <20210318140029.munk3tf2iiipxw6y@wittgenstein>
References: <20210318122633.14222-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210318122633.14222-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 18, 2021 at 12:26:33PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the pde_is_permanent check is being run on root multiple times
> rather than on the next proc directory entry. This looks like a copy-paste
> error.  Fix this by replacing root with next.
> 
> Addresses-Coverity: ("Copy-paste error")
> Fixes: d919b33dafb3 ("proc: faster open/read/close with "permanent" files")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Thanks! Seems very much like it.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
