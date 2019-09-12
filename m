Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42D19B06E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 04:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfILCyq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 22:54:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:7906 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbfILCyq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 22:54:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2019 19:54:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="197089492"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga002.jf.intel.com with ESMTP; 11 Sep 2019 19:54:44 -0700
Date:   Thu, 12 Sep 2019 10:54:24 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/userfaultfd.c: simplify the calculation of new_flags
Message-ID: <20190912025424.GB25169@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190806053859.2374-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806053859.2374-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping~

On Tue, Aug 06, 2019 at 01:38:59PM +0800, Wei Yang wrote:
>Finally new_flags equals old vm_flags *OR* vm_flags.
>
>It is not necessary to mask them first.
>
>Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>---
> fs/userfaultfd.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
>index ccbdbd62f0d8..653d8f7c453c 100644
>--- a/fs/userfaultfd.c
>+++ b/fs/userfaultfd.c
>@@ -1457,7 +1457,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> 			start = vma->vm_start;
> 		vma_end = min(end, vma->vm_end);
> 
>-		new_flags = (vma->vm_flags & ~vm_flags) | vm_flags;
>+		new_flags = vma->vm_flags | vm_flags;
> 		prev = vma_merge(mm, prev, start, vma_end, new_flags,
> 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> 				 vma_policy(vma),
>-- 
>2.17.1

-- 
Wei Yang
Help you, Help me
