Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5114ACF804
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 13:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfJHLWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 07:22:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52743 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbfJHLWg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:22:36 -0400
Received: from p2e585ebf.dip0.t-ipconnect.de ([46.88.94.191] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iHnZM-00036G-Ti; Tue, 08 Oct 2019 11:22:21 +0000
Date:   Tue, 8 Oct 2019 13:22:19 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "cyphar@cyphar.com" <cyphar@cyphar.com>,
        "christian@brauner.io" <christian@brauner.io>,
        "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>,
        Mingfangsen <mingfangsen@huawei.com>,
        "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] proc:fix confusing macro arg name
Message-ID: <20191008112218.voltywyzbdulx6iz@wittgenstein>
References: <165631b964b644dfa933653def533e41@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <165631b964b644dfa933653def533e41@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 06:44:18AM +0000, linmiaohe wrote:
> Add suitable additional cc's as Andrew Morton suggested.
> Get cc list from get_maintainer script:
> [root@localhost mm]# ./scripts/get_maintainer.pl 0001-proc-fix-confusing-macro-arg-name.patch 
> Alexey Dobriyan <adobriyan@gmail.com> (reviewer:PROC FILESYSTEM)
> linux-kernel@vger.kernel.org (open list:PROC FILESYSTEM)
> linux-fsdevel@vger.kernel.org (open list:PROC FILESYSTEM)
> 
> ------------------------------------------------------
> From: Miaohe Lin <linmiaohe@huawei.com>
> Subject: fix confusing macro arg name
> 
> state_size and ops are in the wrong position, fix it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

I thought I already reviewed this weeks ago...
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
