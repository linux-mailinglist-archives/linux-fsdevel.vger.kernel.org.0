Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67376B2F49
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 22:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjCIVIt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 16:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjCIVIr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:08:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA87B71AC;
        Thu,  9 Mar 2023 13:08:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B257161CEA;
        Thu,  9 Mar 2023 21:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC856C433EF;
        Thu,  9 Mar 2023 21:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1678396122;
        bh=jpTxm4KQh8WuA2NHKS2TM89HHthX+2hyrj7QPqcUv0w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fUo5BIu2MuBcwbPc8qzgdT0BECl+vZfTog67bATlYSgUQfYNr83toKZJJjhcFRt+v
         Gg2xh+EMBIQ1Yv5ypHHMUgPS4ZFOJXWZWgc0cLc4jcQaCo89VYBJ/DZi3vKPD2qcMO
         ZtkJ05zck33jxZDyCz2a/ZXgTAjSnPqIyaYL+Ka4=
Date:   Thu, 9 Mar 2023 13:08:40 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: Re: [PATCH] mm: hugetlb: move hugeltb sysctls to its own file
Message-Id: <20230309130840.4ff9bbbf7b570d35cdf48c58@linux-foundation.org>
In-Reply-To: <ZApC8PWLwAwVxfsY@bombadil.infradead.org>
References: <20230309122011.61969-1-wangkefeng.wang@huawei.com>
        <ZApC8PWLwAwVxfsY@bombadil.infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 9 Mar 2023 12:34:56 -0800 Luis Chamberlain <mcgrof@kernel.org> wrote:

> Mike and hugetlb gang, are you OK with me taking this patch through
> sysctl-next to avoid conflicts as we trim down kernel/sysctl.c ?

Sure, go ahead.  Stephen will tell us if there's a collision with mm-git material.
