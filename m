Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3346B345F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 03:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCJCnW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 21:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCJCnU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 21:43:20 -0500
X-Greylist: delayed 379 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Mar 2023 18:43:19 PST
Received: from out-55.mta1.migadu.com (out-55.mta1.migadu.com [95.215.58.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49790311EC
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Mar 2023 18:43:19 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678415817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lv1rTnPEj3HkjxVqfTPinxOZI/oYc4ynuPMw+iFH9c0=;
        b=RwP2o4VCTFLqQbe5nfkWw2CZgwJQyt29NuSbWXf2J4rvN2iLG5VcBOVwMTcwDaGL969s5z
        W4qGSxFqLmGhv/PlhZDQQHzpwK2vrYnS1c3pP5Fw0oTExRTJfDvfRpPFhHsuMhJTKqyVlr
        mJF/Q1SLcErUo3COJGfIT3lyVTOhWzE=
MIME-Version: 1.0
Subject: Re: [PATCH] mm: hugetlb: move hugeltb sysctls to its own file
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230309122011.61969-1-wangkefeng.wang@huawei.com>
Date:   Fri, 10 Mar 2023 10:36:16 +0800
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Content-Transfer-Encoding: 7bit
Message-Id: <EDCC301D-D19F-41F6-A282-6653EF454F21@linux.dev>
References: <20230309122011.61969-1-wangkefeng.wang@huawei.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 9, 2023, at 20:20, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> 
> This moves all hugetlb sysctls to its own file, also kill an
> useless hugetlb_treat_movable_handler() defination.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

