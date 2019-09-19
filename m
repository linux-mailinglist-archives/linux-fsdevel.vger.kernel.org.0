Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B851EB7488
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 09:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388109AbfISH7x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 03:59:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36458 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfISH7w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:59:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id y22so1745908pfr.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2019 00:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xYzaBzbX2wcXB1TeWPAv6aYBrsqEHonGHaTGJrjyg4c=;
        b=Ul06lNEn8+13Ctnds6ZvyhqjciDnEpVUAN4abDOAC21P8D2U1xPhfqZzi1+ppdVGFD
         n3ZmYBzvyH8YDotqAf5AJWJV8i+bQuXTp4EOeXlKLjbuxFkzYqpBandMFYDVlyGXN78B
         d6mbwFJoJh8WqughJIqLFiFp6yvEIsWmqUq7ewTFIoOBIw+ZIQpfCPlqlTRDNa5UCNkF
         7zgKwWfEuh+Hxi7vB/8f2IKPsipSf/x/4Yy7ORTWwIRPZIvgQDkjVxAfz3KcuiMp/R6Z
         LzGr6L6Hb2eupJDSipHFCy+hXKiixS0YtXhC/YHXJtPieOt7BNupWEoPkX6sVSnFI9fg
         fwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xYzaBzbX2wcXB1TeWPAv6aYBrsqEHonGHaTGJrjyg4c=;
        b=Q0O9pHNf1o/ps0wmM/qZwQYdFktKi7YLccGJ8TB7KEAsdjBD254aklgbSUgytoRSDy
         CxRyAi8rJ4LrCfhNjB66TNT3w3Z5NoTpLfm9vDzp83QjGXlMaKdX5dvJBj2cymCu4Qhj
         hKz+ARvdWWvVAful4AXV+y8nqWOxo0H1la1zRIWmSKM1sVasH+EbyPywm91/kHSAteT0
         xwIMpl7Sz4okqMcmuyMQiCIasopNa1xEqBO7AmVbIDB6XvCkEz/e6g2BE1n8P4oL9biK
         IuO5Wr3ySNCffw+ZKZHYviUpO8m0K01dbRL1hEq1vvBbT/qlJdSrkiVztdOvMEynQSwv
         4vIw==
X-Gm-Message-State: APjAAAUaDakGo5F2tNQjaAuS9BZ8LlPnNR+smCIUcdHjA4S0+m/y0Muu
        X3Kekn56G1KfQ5Hac2ORii3rLQ==
X-Google-Smtp-Source: APXvYqwajJTOyNbm2XXB5KgYMEBD8ntikp49d9Rkb1z8pzFTSIMBNUBQF7HzSnikaP5Sy9uFns2yqQ==
X-Received: by 2002:a63:741a:: with SMTP id p26mr7805828pgc.177.1568879991805;
        Thu, 19 Sep 2019 00:59:51 -0700 (PDT)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id z20sm5575332pjn.12.2019.09.19.00.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 00:59:51 -0700 (PDT)
Date:   Thu, 19 Sep 2019 00:59:52 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: add ioctl for directly writing compressed data
Message-ID: <20190919075952.GA121676@vader>
References: <cover.1567623877.git.osandov@fb.com>
 <8eae56abb90c0fe87c350322485ce8674e135074.1567623877.git.osandov@fb.com>
 <652f5971-2c82-e766-fde4-2076e65cf948@suse.com>
 <20190919061404.GA105652@vader>
 <625001e7-dd04-0550-cbb0-7437fe901944@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <625001e7-dd04-0550-cbb0-7437fe901944@suse.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 19, 2019 at 09:46:31AM +0200, Nikolay Borisov wrote:
> 
> 
> On 19.09.19 г. 9:14 ч., Omar Sandoval wrote:
> > On Thu, Sep 05, 2019 at 01:33:56PM +0300, Nikolay Borisov wrote:
> 
> <snip>
> 
> >>
> >> Won't btrfs_lock_and_flush_ordered_range suffice here? Perhaps call that
> >> function + invalidate_inode_pages2_range ?
> > 
> > No, btrfs_lock_and_flush_ordered_range() doesn't write out dirty pages,
> > so it's not sufficient here.
> 
> But it does - it calls btrfs_start_ordered_extent which calls
> filemap_fdatawrite_range.

It only calls that for ranges which already have an ordered extent,
which we don't create until we're writing the dirty pages out (take a
look at where we call btrfs_add_ordered_extent()).
