Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1BB3C9604
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 04:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbhGOCjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 22:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbhGOCj0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 22:39:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ACCC06175F
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 19:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8ajqsZ5gg0J0/2Vvmn7KSFKmWiDI+nEHnSs0tpVpdGQ=; b=oeLv2OYnZlt9+NSA32Dj6pdUR9
        XMIcw3xlBfv9ptMlEpuudg5nUVXlZiG1kjmJe93hYVbxsnt4nkL4Z/V28jfmOybYlUP4S3/u5Gs8z
        7YUZxxLrqMMDE6jAkAk3zFhyk0AzZLux/cWfkXFs3gzZVUwHn1ricjbRXBEXtEdKk1TzGYF0uWWmT
        +yuJv2IJkxQb4MOK5V3l3xP2JcgWfofR1bfeNb1xXq5u5np/3VkzFW82D6rIRQCVMf+mUb+HIKosh
        MuhS0Sc/vJaqYQV6srETG6DRwTp9nNQYqdg+MAHQMwrjb7sBzVsH49I6VGAPqNcB3XLmNBUyF1rba
        XuxB072g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3rDl-002rze-7B; Thu, 15 Jul 2021 02:35:54 +0000
Date:   Thu, 15 Jul 2021 03:35:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Boyang Xue <bxue@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Patch 'writeback, cgroup: release dying cgwbs by switching
 attached inodes' leads to kernel crash
Message-ID: <YO+e8UrCbzp2pfvj@casper.infradead.org>
References: <CAHLe9YZ1_0p_rn+fbXFxU3ySJ_XU=QdSKJAu2j3WD8qmDuNTaQ@mail.gmail.com>
 <YO5kCzI133B/fHiS@carbon.dhcp.thefacebook.com>
 <CAHLe9YYiNnbyYGHoArJxvCEsqaqt2rwp5OHCSy+gWH+D8OFLQA@mail.gmail.com>
 <20210714092639.GB9457@quack2.suse.cz>
 <CAHLe9YbKXcF1mkSeK0Fo7wAUN02-_LfLD+2hdmVMJY_-gNq=-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLe9YbKXcF1mkSeK0Fo7wAUN02-_LfLD+2hdmVMJY_-gNq=-A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 12:22:28AM +0800, Boyang Xue wrote:
> It's unclear to me that where to find the required address in the
> addr2line command line, i.e.
> 
> addr2line -e /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
> <what address here?>

./scripts/faddr2line /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux cleanup_offline_cgwbs_workfn+0x320/0x394

