Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A173D673A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 21:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhGZSX6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 14:23:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232202AbhGZSX6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 14:23:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C2EE60F5D;
        Mon, 26 Jul 2021 19:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627326266;
        bh=kzsXWrwCi9RWE6Q9bwL1m2kT7wU3EGNRLs3PcijJLeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p+2KgCyWvbGQIoSDUecB02vvD07XptxRslfwV63L3kKSv0UrbN5oB2xrHAZKdwje7
         WrfowmN1LQaJT+GLZbz4myvuFjQmlNiqvR6SLHKMilU+z2X3fXBJceOqDY55xnjyVx
         6JSCHDc/r9fPie1T6IBnvZcrT3rxzo2rEI7/8kbSky6joTs5gdI3wkMvAc576R/gv2
         47FdGxFnsLzaYoMWpKH/2aFWXJeMxexBkmlW+qn0W7EOI5scsJVneQN2V/CALfbBYj
         H+bawPsyfh+2vyp9Vdweh+ACtV6CAs+TsTg8ou6MqH7gl9LK+YGcGovesWN9Cip0Mi
         Mfg2FcfH2CnfQ==
Date:   Mon, 26 Jul 2021 12:04:24 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 3/9] f2fs: rework write preallocations
Message-ID: <YP8HOOkA0wlyMYMf@google.com>
References: <20210716143919.44373-1-ebiggers@kernel.org>
 <20210716143919.44373-4-ebiggers@kernel.org>
 <YP2Ew57ptGgYsD1Y@google.com>
 <YP2Hp5RcZfhKipfG@google.com>
 <YP2m7lSqvenvxYIY@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP2m7lSqvenvxYIY@sol.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/25, Eric Biggers wrote:
> On Sun, Jul 25, 2021 at 08:47:51AM -0700, Jaegeuk Kim wrote:
> > On 07/25, Jaegeuk Kim wrote:
> > > Note that, this patch is failing generic/250.
> > 
> > correction: it's failing in 4.14 and 4.19 after simple cherry-pick, but
> > giving no failure on 5.4, 5.10, and mainline.
> > 
> 
> For me, generic/250 fails on both mainline and f2fs/dev without my changes.
> So it isn't a regression.

fyi; I had to change 250 to pass like this. I'm digging the patch.
https://github.com/jaegeuk/xfstests-f2fs/commit/99c11b6550a2a24f831018d2e019eed86e517d44.

> 
> - Eric
