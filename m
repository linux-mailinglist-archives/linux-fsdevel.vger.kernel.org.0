Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268946BD72D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 18:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCPRe6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 13:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjCPRev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:34:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE785ADEE;
        Thu, 16 Mar 2023 10:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZWCsXuEnx5NPHpKnprrXUTjLpix1zKrrJlc3ZEj5QZQ=; b=eZshu5PoYOFmhYfVeDH1ySCMbb
        VkI0LmoRQng2JMFCroNhLnri1gdzRcxOo6i2qEYjto0yFHVM1YpN5mMvVD9uAEOQJfBop4fVucM32
        aiPq9DFkUZqO+BMNj+4VTIzfwwTEm+XCuAyD/oBvOKctWlJl5cGIpsxBdOc7uqqsJTeMbD8dqabq9
        jZbbuEWtB53VuQxyjrTbx/PABYlHTB8NlpD7iKdVB1zF+59VChK7ESu6Za0uCbDBUo9stnFJYSnZ7
        QLuimxG/wuwQKmgDs5Llr7qXlNMi4KVPNT4KDyFnYWObHIG9pl0q8etPwfLbfDfNh4xWVC3sAD5jl
        QWKFxWWg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcrUv-00F2M2-Of; Thu, 16 Mar 2023 17:34:41 +0000
Date:   Thu, 16 Mar 2023 17:34:41 +0000
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
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCHv3 bpf-next 0/9] mm/bpf/perf: Store build id in file object
Message-ID: <ZBNTMZjEoETU9d8N@casper.infradead.org>
References: <20230316170149.4106586-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316170149.4106586-1-jolsa@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 16, 2023 at 06:01:40PM +0100, Jiri Olsa wrote:
> hi,
> this patchset adds build id object pointer to struct file object.
> 
> We have several use cases for build id to be used in BPF programs
> [2][3].

Yes, you have use cases, but you never answered the question I asked:

Is this going to be enabled by every distro kernel, or is it for special
use-cases where only people doing a very specialised thing who are
willing to build their own kernels will use it?

Saying "hubble/tetragon" doesn't answer that question.  Maybe it does
to you, but I have no idea what that software is.

Put it another way: how does this make *MY* life better?  Literally me.
How will it affect my life?
