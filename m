Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF745A1F76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 05:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244023AbiHZDeJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 23:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiHZDeH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 23:34:07 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE638CE461;
        Thu, 25 Aug 2022 20:34:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VNHIe3G_1661484839;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VNHIe3G_1661484839)
          by smtp.aliyun-inc.com;
          Fri, 26 Aug 2022 11:34:01 +0800
Date:   Fri, 26 Aug 2022 11:33:59 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Sun Ke <sunke32@huawei.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
        dan.carpenter@oracle.com
Subject: Re: [PATCH v4] cachefiles: fix error return code in
 cachefiles_ondemand_copen()
Message-ID: <Ywg/J6Pk/2mJfR0c@B-P7TQMD6M-0146.local>
Mail-Followup-To: Sun Ke <sunke32@huawei.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jefflexu@linux.alibaba.com, dan.carpenter@oracle.com
References: <20220826023515.3437469-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220826023515.3437469-1-sunke32@huawei.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 26, 2022 at 10:35:15AM +0800, Sun Ke wrote:
> The cache_size field of copen is specified by the user daemon.
> If cache_size < 0, then the OPEN request is expected to fail,
> while copen itself shall succeed. However, returning 0 is indeed
> unexpected when cache_size is an invalid error code.
> 
> Fix this by returning error when cache_size is an invalid error code.
> 
> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> Suggested-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
