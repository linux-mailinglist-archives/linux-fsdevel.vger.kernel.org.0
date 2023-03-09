Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE1B6B3070
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 23:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjCIWVd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 17:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjCIWV3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:21:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CE7EE76D;
        Thu,  9 Mar 2023 14:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q7P0DIcn2wEwsN0rZMxuiJBJim+mET3ynWD/oegeTWs=; b=zCdHnCcw+c+dCsgjEj4Dmf6UoL
        RRO2b/2fCjs2NHZdzDb+A6c/BXBhKykRrTmxv8J3wZegIpFxSqXXRQk8K7lJdqyVTVX+cwlZ89dHW
        6FO4GgHaIdj4uJcnrYEtzlIQo8p0RfXoBDfZDJBeBe1I2nXRgklR+R1rBg0W1e/GSd3X+R92cKM9J
        yUQf2iIVpqPBZ8xe2XID5wG1zZ+dVqD4Qzz8BTZtQFxi5CHy41vrSpWopCiIbRztEpNtH+e8Gb7FC
        rH8071n9wrAsFF/9P687c8RqU25i0+qyH0HKHFptJRM56NDeXPBmmFijOWchnd4JcwuDjbSRutMnu
        zYkPyOMA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paOcz-00C9Ox-T9; Thu, 09 Mar 2023 22:20:49 +0000
Date:   Thu, 9 Mar 2023 14:20:49 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: Re: [PATCH] mm: hugetlb: move hugeltb sysctls to its own file
Message-ID: <ZApbwXB7BdVkjgyU@bombadil.infradead.org>
References: <20230309122011.61969-1-wangkefeng.wang@huawei.com>
 <ZApC8PWLwAwVxfsY@bombadil.infradead.org>
 <20230309130840.4ff9bbbf7b570d35cdf48c58@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309130840.4ff9bbbf7b570d35cdf48c58@linux-foundation.org>
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

On Thu, Mar 09, 2023 at 01:08:40PM -0800, Andrew Morton wrote:
> On Thu, 9 Mar 2023 12:34:56 -0800 Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> > Mike and hugetlb gang, are you OK with me taking this patch through
> > sysctl-next to avoid conflicts as we trim down kernel/sysctl.c ?
> 
> Sure, go ahead.  Stephen will tell us if there's a collision with mm-git material.

OK thanks, merged onto sysct-next ! Who knows maybe this release we'll
trim down completely that large kernel/sysctl.c file finally.

  Luis
