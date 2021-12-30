Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5A3481ACB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Dec 2021 09:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbhL3Ims (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Dec 2021 03:42:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58450 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhL3Ims (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Dec 2021 03:42:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A80BF615F1;
        Thu, 30 Dec 2021 08:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63049C36AEA;
        Thu, 30 Dec 2021 08:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640853767;
        bh=vyvelD0Nu1PcVFnAHB/GirQcZKWNcV9A02QtrZmIqf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=D60tRmX0q5Z1EAnZvAOQRAhiEpoh0/PYYALEuofTZWMEJ6clBXaUOM4cNUVxsHfG5
         qMCUovUacUCbDjuecHIBRyB3XHEkpZXxLVzxWZxblqALOsg26JYmj5jUH/trB9jsa2
         m56hza0kcSi10HhzXsd+rZtnV3pwTENLjKJRppGpyRdzQCWtI48m6v4m41rvTiIXsm
         J/4vNJ/EX89uY1AeHKWGMZNZNjdOLBQsQ2KyAtpPG0qmPeiC+XqIUYPDhqpEQGtMn9
         zpBGEsdDZu/grBalKvYWYM2J1Pf0VmC8v07tKgdbD6LEjehTDvv3hTUlqC0u4s6FCm
         ok3tqh/O5dEMA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: mmotm 2021-12-29-20-07 uploaded
Date:   Thu, 30 Dec 2021 08:42:43 +0000
Message-Id: <20211230084243.10673-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211230040740.SbquJAFf5%akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Andrew,

On Wed, 29 Dec 2021 20:07:40 -0800 akpm@linux-foundation.org wrote:

> The mm-of-the-moment snapshot 2021-12-29-20-07 has been uploaded to
> 
>    https://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> https://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> https://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.
> 
> This tree is partially included in linux-next.  To see which patches are
> included in linux-next, consult the `series' file.  Only the patches
> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
> linux-next.
> 
> 
> A full copy of the full kernel tree with the linux-next and mmotm patches
> already applied is available through git within an hour of the mmotm
> release.  Individual mmotm releases are tagged.  The master branch always
> points to the latest release, so it's constantly rebasing.
> 
> 	https://github.com/hnaz/linux-mm

I realized the git repository is not updated since 2021-10-27.  That's
obviously not a problem, but if that's not temporal but intentional, I guess
above text might be better to be updated?

> 
> The directory https://www.ozlabs.org/~akpm/mmots/ (mm-of-the-second)
> contains daily snapshots of the -mm tree.  It is updated more frequently
> than mmotm, and is untested.
> 
> A git copy of this tree is also available at
> 
> 	https://github.com/hnaz/linux-mm

ditto.


Thanks,
SJ

[...]
