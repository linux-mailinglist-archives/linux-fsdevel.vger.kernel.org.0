Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5FA3DE0E0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 22:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhHBUlx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 16:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231165AbhHBUlw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 16:41:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9936260F35;
        Mon,  2 Aug 2021 20:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1627936902;
        bh=mD2GlJ7qH0mW1hEmSzx38bjvmcCI51oF/MKdQrW9HmU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1JTdIkjiyweXRbNQAEN28NLpa5d8t+1ZUkAsnz3nmXFhOSTwSra+EzKTAU/8H0jqg
         L8vmi7MQk4/BZlCyXJkei2xPkwoMybAKXl1T4b/e9SroNjP/dc4bb/hiIUMlXO/UBm
         W0qE/aeML0YzE8KUtr+Ov3bF70Ndb/62dDcFyN3Y=
Date:   Mon, 2 Aug 2021 13:41:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Charan Teja Kalla <charante@codeaurora.org>
Cc:     Mike Rapoport <rppt@kernel.org>, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        dave.hansen@linux.intel.com, vbabka@suse.cz,
        mgorman@techsingularity.net, nigupta@nvidia.com, corbet@lwn.net,
        khalid.aziz@oracle.com, rientjes@google.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        vinmenon@codeaurora.org
Subject: Re: [PATCH V5] mm: compaction: support triggering of proactive
 compaction by user
Message-Id: <20210802134141.dbff2d5f850bbe84f3bef4d5@linux-foundation.org>
In-Reply-To: <1089d373-221e-7094-b778-ac260ca139a5@codeaurora.org>
References: <1627653207-12317-1-git-send-email-charante@codeaurora.org>
        <YQRTqNF3xn+tB+qN@kernel.org>
        <1089d373-221e-7094-b778-ac260ca139a5@codeaurora.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2 Aug 2021 17:30:16 +0530 Charan Teja Kalla <charante@codeaurora.org> wrote:

> Thanks Mike for the review!!
> 
> On 7/31/2021 1:01 AM, Mike Rapoport wrote:
> >> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> >> index 003d5cc..b526cf6 100644
> >> --- a/Documentation/admin-guide/sysctl/vm.rst
> >> +++ b/Documentation/admin-guide/sysctl/vm.rst
> >> @@ -118,7 +118,8 @@ compaction_proactiveness
> >>  
> >>  This tunable takes a value in the range [0, 100] with a default value of
> >>  20. This tunable determines how aggressively compaction is done in the
> >> -background. Setting it to 0 disables proactive compaction.
> >> +background. On write of non zero value to this tunable will immediately
> > Nit: I think "Write of non zero ..."
> 
> Can Andrew change it while applying the patch ?

I have done so, thanks.
