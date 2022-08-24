Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A160359FA9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 14:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbiHXM4l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 08:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237462AbiHXM4k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:56:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AD285FFF;
        Wed, 24 Aug 2022 05:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b+0F9DCJbnU3v3nidoaFdK+b0pOLa/x+voQls167Hl8=; b=qA0tjd5g+zRMQTUFYVnofvPopV
        SV0X6fM7wTAvR3Ht9b5FFRmDeZt2IrA6t0pJTK3G6lh/o+UvVHcZei0Tf7nxW9pZJKxU2nlAje5Il
        FZBjHNXuh41X8bEiz7Ov5lSAAuqUyOPqnJrbWTXN94x3wJbbYu8HKOY/i7XTge12V+tZxQlfAcKXv
        4y99INrFHtYUbkbzjfuyHwPKRVdLVGgSarkI0rycGqYdFBcBgQAjHqAVgwdVPlEllAfDqq3+P9oIv
        cFKrt3ucd2dtziSO70QTCsz75q1fh1BqFhVFMkf6c+g9qT/SKm44eTPadz8kp01BlHUY0D02d+dTK
        Z/BtJCHg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQpvu-00GLBF-I4; Wed, 24 Aug 2022 12:56:34 +0000
Date:   Wed, 24 Aug 2022 13:56:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     xu xin <cgel.zte@gmail.com>
Cc:     akpm@linux-foundation.org, bagasdotme@gmail.com,
        adobriyan@gmail.com, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, xu xin <xu.xin16@zte.com.cn>
Subject: Re: [PATCH v4 0/2] ksm: count allocated rmap_items and update
 documentation
Message-ID: <YwYgAnrQguI5LpN1@casper.infradead.org>
References: <20220824124512.223103-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824124512.223103-1-xu.xin16@zte.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 24, 2022 at 12:45:12PM +0000, xu xin wrote:
> v3->v4:
> Fix the wrong writing format and some misspellings of the related documentaion.
> 
> v2->v3:
> remake the patches based on the latest linux-next branch.
> 
> v1->v2:
> Add documentation for the new item.

Don't send multiple versions of a patch series per day.  This fragments
review and makes it harder to know what's going on with the patch series.
Leave it at least a day between versions, preferably a week.
