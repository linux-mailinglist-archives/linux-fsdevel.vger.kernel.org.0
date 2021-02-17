Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1677E31D5EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 08:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhBQH6E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 02:58:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:48850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhBQH55 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 02:57:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613548631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cgmC7AaJ6yBPNg2oaCmQrFfiwgvCyyz07hRRATeOpLs=;
        b=To0WYKySQSp7O/XtbTiAzCmtGN5p62m1ojqofnnGbN7v8Fw7rVkBXzJl0T62ClkSmbVRov
        A6U4BBcabffv/szw+FagGMLxu/33iWy//1Frfu+EKHUWTHQ37MvnbQBbFdCnNqARGJx6JZ
        r7t4qd5VXzwTCqzFvzaRWe/8guyZ1Y4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 016E6AFF1;
        Wed, 17 Feb 2021 07:57:11 +0000 (UTC)
Date:   Wed, 17 Feb 2021 08:57:09 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>, corbet@lwn.net,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, felipe.franciosi@nutanix.com
Subject: Re: [RFC PATCH] mm, oom: introduce vm.sacrifice_hugepage_on_oom
Message-ID: <YCzMVa5QSyUtlmnI@dhcp22.suse.cz>
References: <20210216030713.79101-1-eiichi.tsukata@nutanix.com>
 <YCt+cVvWPbWvt2rG@dhcp22.suse.cz>
 <bb3508e7-48d1-fa1b-f1a0-7f42be55ed9c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb3508e7-48d1-fa1b-f1a0-7f42be55ed9c@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 16-02-21 14:30:15, Mike Kravetz wrote:
[...]
> However, this is an 'opt in' feature.  So, I would not expect anyone who
> carefully plans the size of their hugetlb pool to enable such a feature.
> If there is a use case where hugetlb pages are used in a non-essential
> application, this might be of use.

I would really like to hear about the specific usecase. Because it
smells more like a misconfiguration. What would be non-essential hugetlb
pages? This is not a resource to be pre-allocated just in case, right?

-- 
Michal Hocko
SUSE Labs
