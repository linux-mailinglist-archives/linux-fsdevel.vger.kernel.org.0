Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEBAD481D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 21:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfJKTDN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 15:03:13 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37602 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbfJKTDM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 15:03:12 -0400
Received: by mail-qt1-f196.google.com with SMTP id l49so1376138qtc.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2019 12:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1zj65VAHkrvrqgSf6v62yhKJ+Twl/i9DMVLlx6+COss=;
        b=P/Lw5TH2CApDYV9WucqDHKN7ISqviYRM2FKKslNZUrtH+viSX+X33b853UrlmsPf8B
         rTJ0QBbOoQ6qSqkDKQ9vvtkMasXaAX4k4qWx28cZKhh6JHVcmlqubTTVg40B8ghKP+Nc
         B1iFGWCLL5qDVS3XYUJOsAR1X3kiBbo5kIWI4Y/9/37rwInGJrA0Z3GD6bsW/qi06M+q
         ecWHoT83DAAhdiW3p80n8DIuUKYxlIh+SPY8YGEJxXGYgqzkLyDehc6W2IVpBZ5A08Oc
         Bg7+axUJ13f1zDUS1qmQyoJPekISn+cA6hBQzZg3mXLw0MKChkOF7xcqvnMceGzOB3nN
         dpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1zj65VAHkrvrqgSf6v62yhKJ+Twl/i9DMVLlx6+COss=;
        b=lhfCCJ601JKaKCYWQPXGwavY2qZm3bj3TD/uWJFCNeYLi+6qatr8uPYLSZKAIL+3TM
         14dNLkr/qv0cHpfvopChMuoqvOJXmsTDf4SM+yDchok2QawVgJOIdQzK9r2Qtxd09QEk
         wKPyFLHJPrQ2ad0Sd/ZphTgqfTVKnq/6Fr4H26oHVdim3U5CsfZi96kCMxrn/MMBxE9D
         7rW4O+wDl5oDaGiL8zLL4K2Kv1DlSGTWJF/UEShqyewC7cAXl7zfBkQI91JjUH07l7CQ
         TrENvNsyRlEadpwuYDzKdDSA3vAsIiEvSbUgBq5ueiMrDXw4LQgZHlQLO5fynLQGWDyf
         9apQ==
X-Gm-Message-State: APjAAAUm5WCI727Rjwo9yw1/q6yobsKL3PN7xPnfAzprgpuV/tr2RKhY
        PQ8wdzTDzlUhG6+EDonnVi154g==
X-Google-Smtp-Source: APXvYqykqTMBbhaj+qITq53rUsWJEJASWi7o6MJhiBD5rJ4gtLZmBUVMzVLpnJofut+LtUqpLqOZqQ==
X-Received: by 2002:ac8:7447:: with SMTP id h7mr18646593qtr.11.1570820590320;
        Fri, 11 Oct 2019 12:03:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d36])
        by smtp.gmail.com with ESMTPSA id z5sm4602516qtb.49.2019.10.11.12.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 12:03:09 -0700 (PDT)
Date:   Fri, 11 Oct 2019 15:03:08 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V2 00/26] mm, xfs: non-blocking inode reclaim
Message-ID: <20191011190305.towurweq7gsah4vr@macbook-pro-91.dhcp.thefacebook.com>
References: <20191009032124.10541-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-1-david@fromorbit.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:20:58PM +1100, Dave Chinner wrote:
> Hi folks,
> 
> This is the second version of the RFC I originally posted here:
> 
> https://lore.kernel.org/linux-xfs/20190801021752.4986-1-david@fromorbit.com/
> 
> The original description of the patchset is below, the issues and
> approach to solving them has not changed. THere is some
> restructuring of the patch set - the first few patches are all the
> XFS fixes that can be merged regardless of the rest of the patchset,
> but the non-blocking reclaim is somewhat dependent of them for
> correct behaviour. The second set of patches are the shrinker
> infrastructure changes needed for the shrinkers to feed back
> reclaim progress to the main reclaim instructure and act on the
> feedback. The last set of patches are the XFS changes needed to
> convert inode reclaim over to a non-blocking, IO-less algorithm.
> 

I looked through the MM patches and other than the congestion thing they look
reasonable.  I think I can probably use this stuff to drop the use of the btree
inode.  However I'm wondering if it would be a good idea to add an explicit
backoff thing for heavy metadata dirty'ing operations.  Btrfs generates a lot
more dirty metadata than most, partly why my attempt to deal with this was tied
to using balance dirty pages since it already has all of the backoff logic.

Perhaps an explict balance_dirty_metadata() that we put after all metadata
operations so we have a good way to throttle dirtiers when we aren't able to
keep up?  Just a thought, based on my previous experiences trying to tackle this
issue for btrfs, what you've done already may be enough to address these
concerns.  Thanks,

Josef
