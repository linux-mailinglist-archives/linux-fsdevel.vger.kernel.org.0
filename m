Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C7D6009C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 07:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfGEF3J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 01:29:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfGEF3I (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 01:29:08 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 111B621850;
        Fri,  5 Jul 2019 05:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562304547;
        bh=ku9aEp+wapV1jAtHr82zZH6REpuJWRVS+GCf+tHXR7Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gpwsyMS6DRC1CwjjTw4nWYbfs5wE2bJ85FBSXW84XxfeYBs6quUOEtr8MLEJ6QcMZ
         03jv6nY0lDeUSDRQOggVvU24ZcWC8z5wMyc53vkGgU4qbFnuhBeU8cBq+krJtoDFTV
         5BAl2jqKEoiqIRjP7Qf7cwvYh0pBZRG2A96dQtGc=
Date:   Thu, 4 Jul 2019 22:29:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        mhocko@suse.cz, mm-commits@vger.kernel.org,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: mmotm 2019-07-04-15-01 uploaded (gpu/drm/i915/oa/)
Message-Id: <20190704222906.f817d02cb248561edd84a669@linux-foundation.org>
In-Reply-To: <5f4680cce78573ecfbbdc0dfca489710581b966f.camel@perches.com>
References: <20190704220152.1bF4q6uyw%akpm@linux-foundation.org>
        <80bf2204-558a-6d3f-c493-bf17b891fc8a@infradead.org>
        <CAK7LNAQc1xYoet1o8HJVGKuonUV40MZGpK7eHLyUmqet50djLw@mail.gmail.com>
        <20190705131435.58c2be19@canb.auug.org.au>
        <20190704220931.f1bd2462907901f9e7aca686@linux-foundation.org>
        <5f4680cce78573ecfbbdc0dfca489710581b966f.camel@perches.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 04 Jul 2019 22:22:41 -0700 Joe Perches <joe@perches.com> wrote:

> > So when comparing a zero-length file with a non-existent file, diff
> > produces no output.
> 
> Why use the -N option ?
> 
> $ diff --help
> [...]
>   -N, --new-file                  treat absent files as empty
> 
> otherwise
> 
> $ cd $(mktemp -d -p .)
> $ touch x
> $ diff -u x y
> diff: y: No such file or directory

Without -N diff fails and exits with an error.  -N does what's desired
as long as the non-missing file isn't empty.


