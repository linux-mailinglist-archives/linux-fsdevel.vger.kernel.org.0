Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01C11D04AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 04:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgEMCMA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 22:12:00 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:59461 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727792AbgEMCMA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 22:12:00 -0400
X-Greylist: delayed 1135 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 May 2020 22:11:59 EDT
Received: from dread.disaster.area (pa49-195-157-175.pa.nsw.optusnet.com.au [49.195.157.175])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 79961D79337;
        Wed, 13 May 2020 11:52:59 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jYgZs-0001dG-SQ; Wed, 13 May 2020 11:52:56 +1000
Date:   Wed, 13 May 2020 11:52:56 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH RFC 2/8] selftests: add stress testing tool for dcache
Message-ID: <20200513015256.GN2005@dread.disaster.area>
References: <158893941613.200862.4094521350329937435.stgit@buzz>
 <158894059714.200862.11121403612367981747.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158894059714.200862.11121403612367981747.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=ONQRW0k9raierNYdzxQi9Q==:117 a=ONQRW0k9raierNYdzxQi9Q==:17
        a=kj9zAlcOel0A:10 a=sTwFKg_x9MkA:10 a=6R7veym_AAAA:8 a=7-415B0cAAAA:8
        a=nNFfUkKyeu1yzWEg-EsA:9 a=CjuIK1q_8ugA:10 a=ILCOIF4F_8SzUMnO7jNM:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 08, 2020 at 03:23:17PM +0300, Konstantin Khlebnikov wrote:
> This tool fills dcache with negative dentries. Between iterations it prints
> statistics and measures time of inotify operation which might degrade.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  tools/testing/selftests/filesystems/Makefile       |    1 
>  .../testing/selftests/filesystems/dcache_stress.c  |  210 ++++++++++++++++++++

This sort of thing should go into fstests along with test scripts
that use it to exercise the dentry cache. We already have tools like
this in fstests (dirstress, metaperf, etc) for exercising name-based
operations like this, so it would fit right in.

That way it would get run by just about every filesystem developer
and distro QE department automatically and extremely frequently...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
