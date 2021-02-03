Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DF430D04C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 01:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhBCAcG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 19:32:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:56332 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232228AbhBCAcF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 19:32:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EB442AE14;
        Wed,  3 Feb 2021 00:31:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C1886DA6FC; Wed,  3 Feb 2021 01:29:33 +0100 (CET)
Date:   Wed, 3 Feb 2021 01:29:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [ANNOUNCE] xfs-linux: iomap-for-next updated to ed1128c2d0c8
Message-ID: <20210203002933.GA1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20210202164747.GK7193@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202164747.GK7193@magnolia>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 02, 2021 at 08:47:47AM -0800, Darrick J. Wong wrote:
> Note that Naohiro Aota's btrfs patchset to add zoned block support will
> perform some slight refactoring of fs/iomap/directio.c to add support
> for REQ_OP_ZONE_APPEND.  I don't know if they're planning to push that
> for 5.12, but AFAICT it should have minimal impact to everyone else.

Current plan is to push that patch to 5.12 among the other zoned updates
in btrfs pull request.
