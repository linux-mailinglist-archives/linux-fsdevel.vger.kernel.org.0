Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C772B9FA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 02:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgKTBWI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 20:22:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgKTBWH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 20:22:07 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E467922254;
        Fri, 20 Nov 2020 01:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1605835326;
        bh=oyL8tyDHbJ3qIIoumYURc5U/JKtxezYzrlsKEz9We3g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=06OIwS6dO1uCJbzpKkAfU0LgV6NR0sEh63PDccOurGJc8jcYZca+MbtftmA4ozfT1
         +XWNisle68uETojyIOjBOHcLdc5F81GbfN4/OJEnDpwW/QdD7GwGISM0/GjwiJ3A9K
         lKnSoOzPVM7CBZkxQMlPAerewzNfZHktmX2nl7Go=
Date:   Thu, 19 Nov 2020 17:22:04 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Daniel Colascione <dancol@dancol.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nitin Gupta <nigupta@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v6 0/2] Control over userfaultfd kernel-fault handling
Message-Id: <20201119172204.6787046c9036d0bbdcbc2dfc@linux-foundation.org>
In-Reply-To: <CA+EESO7N7gFkG_Vqy5j1oCZif8RaiCJ146GrQAKq3P1SCUi+ng@mail.gmail.com>
References: <20201026210052.3775167-1-lokeshgidra@google.com>
        <CA+EESO7N7gFkG_Vqy5j1oCZif8RaiCJ146GrQAKq3P1SCUi+ng@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 19 Nov 2020 12:39:15 -0800 Lokesh Gidra <lokeshgidra@google.com> wrote:

> It's been quite some time since this patch-series has received
> 'Reviewed-by' by Andrea. Please let me know if anything is blocking it
> from taking forward.

This series has not been shared with linux-mm@kvack.kernel.org, so many
of the people who are familiar with userfaultfd will never have seen
it.

Please fix that and resend, and we'll see how it goes?
