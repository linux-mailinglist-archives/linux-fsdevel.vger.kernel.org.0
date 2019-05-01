Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0CE1037B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 02:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfEAAZU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 20:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfEAAZU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 20:25:20 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7993F20835;
        Wed,  1 May 2019 00:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556670319;
        bh=cH91W4qRWYYFnp1kPrzAJ35LPXMAIxI0pKVfaW/RMmI=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=wvNpMlZE9zdS3ts/NOcENwKIbYSr1hjqoI0vbcoS55AZmvyeENj3cZBkX4Q5XaPcg
         2RAW5sEF6a/UYUJqBHltdsfmKLMCvYdCONLUpmZGGKEcxhVRvrusa2w6puceH3IW1h
         9HWwZAJfhm9Xs6vOIMYvdiGnLoPjAYy0LPxpD6a8=
Date:   Tue, 30 Apr 2019 17:25:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/4] vfs: update ->get_link() related documentation
Message-ID: <20190501002517.GF48973@gmail.com>
References: <20190411231630.50177-1-ebiggers@kernel.org>
 <20190422180346.GA22674@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422180346.GA22674@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 22, 2019 at 11:03:47AM -0700, Eric Biggers wrote:
> On Thu, Apr 11, 2019 at 04:16:26PM -0700, Eric Biggers wrote:
> > Update the documentation as per the discussion at
> > https://marc.info/?t=155485312800001&r=1.
> > 
> > Eric Biggers (4):
> >   Documentation/filesystems/vfs.txt: remove bogus "Last updated" date
> >   Documentation/filesystems/vfs.txt: document how ->i_link works
> >   Documentation/filesystems/Locking: fix ->get_link() prototype
> >   libfs: document simple_get_link()
> > 
> >  Documentation/filesystems/Locking |  2 +-
> >  Documentation/filesystems/vfs.txt |  8 ++++++--
> >  fs/libfs.c                        | 14 ++++++++++++++
> >  3 files changed, 21 insertions(+), 3 deletions(-)
> > 
> > -- 
> > 2.21.0.392.gf8f6787159e-goog
> > 
> 
> Al, any comment on this?  Will you be taking these?
> 
> - Eric

Ping?
