Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396D2365938
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 14:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhDTMtw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 08:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhDTMtu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 08:49:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07E8C06174A;
        Tue, 20 Apr 2021 05:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UBs/3IU4qOqe26pmfSqrhN0agM0g3vHrn8n2VyPPRIA=; b=Cp8tD01wvbGNq/BTg28Lb+24q0
        24nfSk4rkJykvYI8OV7ePARwDW8y3pbJDxTKxcyZl7CXUUDJkBV2GQWQIxT4lYugJINfq9bIqLJH6
        pbP0y3i+ukb+uPu8rHGXLtGebC0wxoq7FP8da4zS53Jn/tWaCsSt1opwbRHjsrd81LycIBj9958YC
        11NWXr32TwC/JbcLS1xgRm/wUNg/SZt9y/JF2YWjSB/SEHVGfK6YwAKITc2MeDVdR8AqnMY4DYp65
        8Q/4sHztBrh7o5GMuQDP+xCHJorg7Jahxp61dMtl440AKp4j5SK57VhiZ9sIuCozrJpMBvLhpMi+M
        m/Cq4l1w==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYplq-00FATl-EQ; Tue, 20 Apr 2021 12:47:19 +0000
Date:   Tue, 20 Apr 2021 13:46:26 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        jeyu@kernel.org, ebiederm@xmission.com, mchehab@kernel.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        kernel@tuxforce.de, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 4/6] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <20210420124626.GB3604224@infradead.org>
References: <20210417001026.23858-1-mcgrof@kernel.org>
 <20210417001026.23858-5-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417001026.23858-5-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Wouldn't it be simpler to just add a new flag to signal a kernel
initiated freeze, or even better the exact reason (suspend) instead of
overloading the state machine?
