Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F5D6B2EC7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 21:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjCIUfI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 15:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjCIUfE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:35:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4141CE6FE2;
        Thu,  9 Mar 2023 12:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XlwwrHLIhnrG20yTtx4GphLclji2zK7xw5Lu65v2noo=; b=PQxaSZRm2hbAjXxkVkBykaT3PP
        oNLNsQsTBxUq4haYMCn5HJI/fkTCzGvu9M2UQKdLrl+9Wc75b371FNUCTrOSIqkcBpl/Pb4Q0aknF
        0r7ncjO3HZEwdEZnmm1wL+mnkXSghVQ/qMqjivekUXDJ148Dic/7aEB+JV3WJYF4RPLF/iBY0Op/R
        e7arpVDf3SY0bcKu5HPHhTbDH9PpHJXW00OTbFCX618/dnVQj4Q0Uo9zkf/eIhUwT3lzFKzD0+I70
        OJP1KWXI/5boHMen+cvi2elWkd/rBeNHZWW9vyebFd+HP8RZjVtWcNQBnup+ieDykyqbpk3FV8j4N
        09BXvoxQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paMyW-00BmzD-Gq; Thu, 09 Mar 2023 20:34:56 +0000
Date:   Thu, 9 Mar 2023 12:34:56 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: Re: [PATCH] mm: hugetlb: move hugeltb sysctls to its own file
Message-ID: <ZApC8PWLwAwVxfsY@bombadil.infradead.org>
References: <20230309122011.61969-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309122011.61969-1-wangkefeng.wang@huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 09, 2023 at 08:20:11PM +0800, Kefeng Wang wrote:
> This moves all hugetlb sysctls to its own file, also kill an
> useless hugetlb_treat_movable_handler() defination.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

LGTM

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Mike and hugetlb gang, are you OK with me taking this patch through
sysctl-next to avoid conflicts as we trim down kernel/sysctl.c ?

  Luis
