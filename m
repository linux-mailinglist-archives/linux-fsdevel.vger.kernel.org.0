Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5189D47C908
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 23:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhLUWCM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 17:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhLUWCL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 17:02:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC27C061574;
        Tue, 21 Dec 2021 14:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=brIMU6iiQGAORjPmUTKmTkgFa8Fz15PWCmSHuHY/tdI=; b=rQnqz4LGkITxsxD7KK/ZeN0xqO
        q3XxL3v1Jv76L/aOp/f7OsTbIiM1+xVQ+jUrokpyzd+5mnr+lLuHAobIJYFnh9pq5JRABa3J6VOrb
        nLLFZ4uT96H/jQCywHywYb0uxHG5xYZRQLNCWvAw70xB+3pHjA369gVM3hlEi7i9ACCTrFVTLDGo8
        jRtUaM0Pvhsldm027btl4vBc2R4stTiesp1vZ247lOsok2ywuWHlXagPXIUMYFmFsiWmUv68CK2oR
        hByNKKV7cgXcdUimIu2xvXYVoaC3p3ueuNX006L59V8He4giPaV5IZvVMnzlrquB+IyJbNVQ6s39/
        zTZrKi9Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mznCv-008aZS-RN; Tue, 21 Dec 2021 22:02:05 +0000
Date:   Tue, 21 Dec 2021 14:02:05 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "libaokun (A)" <libaokun1@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, keescook@chromium.org,
        yzaikin@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] sysctl: returns -EINVAL when a negative value is
 passed to proc_doulongvec_minmax
Message-ID: <YcJO3f8LWvSMWBKz@bombadil.infradead.org>
References: <20211209085635.1288737-1-libaokun1@huawei.com>
 <Yb+kHuIFnCKcfM5l@bombadil.infradead.org>
 <4b2cba44-b18a-dd93-b288-c6a487e4857a@huawei.com>
 <YcDZKxXJKglR6mcO@bombadil.infradead.org>
 <70910c5b-4681-db00-27ba-715dddd7831a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70910c5b-4681-db00-27ba-715dddd7831a@huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 21, 2021 at 09:15:28AM +0800, libaokun (A) wrote:
> 在 2021/12/21 3:27, Luis Chamberlain 写道:
> > On Mon, Dec 20, 2021 at 04:53:57PM +0800, libaokun (A) wrote:
> > > 在 2021/12/20 5:29, Luis Chamberlain 写道:
> > > > Curious do you have docs on Hulk Robot?
> > > Hulk Robot is Huawei's internal test framework. It contains many things.
> > Neat, is the code public?
> The code is not public.

Why not?

  Luis
