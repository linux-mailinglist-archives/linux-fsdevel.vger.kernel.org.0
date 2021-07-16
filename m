Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED68D3CB19E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 06:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhGPEal (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 00:30:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhGPEal (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 00:30:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E97C613E7;
        Fri, 16 Jul 2021 04:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626409665;
        bh=tFDxqE59akvzwWpsNI0XGlepos706KgR+S84geBuR5Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BIsdIYZBf/GIZ/OG58cLxRbzeAIkH1UYvYJAk8ynX6PqF4mPL1JeHGw7BzUD/QUcY
         IslPB0HK0ufUaCZSodRP4RN0CUaVQdYInv3kcB8PsCmSp3+lqd/tTAABNRJ4khiNzn
         u4Oe7KrmMPL4pXX2jRDYepqW7kOsxuQp0H86hJmE=
Date:   Thu, 15 Jul 2021 21:27:44 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Charan Teja Kalla <charante@codeaurora.org>
Cc:     vbabka@suse.cz, corbet@lwn.net, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        rientjes@google.com, mchehab+huawei@kernel.org,
        lokeshgidra@google.com, andrew.a.klychkov@gmail.com,
        xi.fengfei@h3c.com, nigupta@nvidia.com,
        dave.hansen@linux.intel.com, famzheng@amazon.com,
        mateusznosek0@gmail.com, oleksandr@redhat.com, sh_def@163.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        "vinmenon@codeaurora.org" <vinmenon@codeaurora.org>
Subject: Re: [PATCH V4,0/3] mm: compaction: proactive compaction trigger by
 user
Message-Id: <20210715212744.1a43012c21711bafd25e5b68@linux-foundation.org>
In-Reply-To: <c0150787-5f85-29ac-9666-05fabedabb1e@codeaurora.org>
References: <cover.1624028025.git.charante@codeaurora.org>
        <c0150787-5f85-29ac-9666-05fabedabb1e@codeaurora.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 3 Jul 2021 15:52:10 +0530 Charan Teja Kalla <charante@codeaurora.org> wrote:

> A gentle ping to have your valuable comments.

Can we please have a resend?

The series has two fixes against the current code.  Please separate
that work out from the new feature.  So a 2-patch series to fix the bugs
followed by a single patch to add your new feature.


