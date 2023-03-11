Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1AC6B60C2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 21:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCKU5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Mar 2023 15:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjCKU5g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Mar 2023 15:57:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D320A6C692;
        Sat, 11 Mar 2023 12:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cegzVSijTaPtGwhrMmWuRhxPn9RiDuutUK0M4Pgdujc=; b=JNwtYHYVmRm2Unbf8sqUaXvw0l
        Qa8uLfVrRLs8I+YMLniZRz437crZHsl7ISkg7MyncHcyim+yC2G3dIB2atncOvPyxsagfeykJyo4E
        R3yO+e9PeGhzNNA1cSMeFcEE5SkfnnlGLizbrBHwS+Dld6YmS38IXs+Z/l/+82zdJaWy1lrRVBHL5
        nndsXNYNx6SGMReKiI7rfTJdCZpBx+i03drVZY5xQsgGJfgDflS9IScdowJYrP69Rul1OsCpEWHX6
        NYqjlRVolF7Fp0TiyZcqPAsqO3bDiDL1dL1HHnwFAQBUFhkpNIno+LT3kns9nVdr0YrVbWll2Flwo
        1SZuNJbg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pb6HI-001Eh3-HU; Sat, 11 Mar 2023 20:57:20 +0000
Date:   Sat, 11 Mar 2023 12:57:20 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2] mm: hugetlb: move hugeltb sysctls to its own file
Message-ID: <ZAzrMLDG1jyaVU5d@bombadil.infradead.org>
References: <20230311074734.123269-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311074734.123269-1-wangkefeng.wang@huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 11, 2023 at 03:47:34PM +0800, Kefeng Wang wrote:
> This moves all hugetlb sysctls to its own file, also kill an
> useless hugetlb_treat_movable_handler() since commit d6cb41cc44c6
> ("mm, hugetlb: remove hugepages_treat_as_movable sysctl").
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks queued up onto sysctl-testing [0]. Eventually I'll move this to
sysctl-next.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-testing

  Luis
