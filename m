Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97FF688152
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 16:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjBBPLY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 10:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjBBPLX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:11:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0811292EC7;
        Thu,  2 Feb 2023 07:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bBVtD8HDRvQYs8mba3bwj+awzZrl0jktJ7xWlq9eHKw=; b=ZjWQ5uFB92+yVSjRdTOT6H7l6b
        jftNrvi3rA1m8Y33ff3YzMoRWx31ph14b6kOkPVktcWTyZnLjMkay/mEN5l14GCc3Ruzv2mFObLX0
        o2x85g49AFWEsmc5zeJTes3prIUyo8Zt4RqEuEccFFU++B3BMJnWQyyUDhPWnb/22CWqZdbt718+8
        pkHZ3S2XjxGWRL1mRXuLmcv607SBEuMzTeVxuc7gBZVZAIz1OdVBDjnYU5VyVuhJ9xWrOg4ZtJV7n
        VTrxyavmP19HgvpXwDavZ3DhbyoV80YtP9D3pOI2s0PYR2p0JG3qjIWRdiPW28OROlc4Q3RsJgZRA
        UUbM/Izw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNbEM-00DUHm-QH; Thu, 02 Feb 2023 15:10:30 +0000
Date:   Thu, 2 Feb 2023 15:10:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RFC 0/5] mm/bpf/perf: Store build id in file object
Message-ID: <Y9vSZhBBCbshI3eM@casper.infradead.org>
References: <20230201135737.800527-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201135737.800527-1-jolsa@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 01, 2023 at 02:57:32PM +0100, Jiri Olsa wrote:
> hi,
> we have a use cases for bpf programs to use binary file's build id.

What is your use case?  Is it some hobbyist thing or is it something
that distro kernels are all going to enable?

