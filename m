Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCB373FF8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 17:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjF0PWT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 11:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjF0PWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:22:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617E5185;
        Tue, 27 Jun 2023 08:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5OQ81fP5MT/p2WsB3Y4qNkUUEhdkT8Ufx9BbHjrAEbA=; b=FWVHHoNlfAUSWj7ka/pCDSK0++
        SWDM/XEPrDvTwyoUL2l8ZbKiwIjlzLtT+XeR/zCp/mxEJsSuW1gbUXCKdSGk1bAnDmX8YEW63MPLe
        51ySaTyvfy7uQf72BWCkBY70FwJzRfi8Vikc8OcuMD27S3jUWxIDKYvZga77pTyT/qx8wzm3nn2p1
        v2X5IQDuY4fE5mqCWq2yQ/3n2lZacpfxypxdliaJdlFl3+N4a3kv8EYqAd2zvEbH6lq3VV3RuaWnn
        sJYMegxILw3EWuWCOH/UA8z5UEAEAQr6u1Ob6LzjW/ajVTxpxRQtlVtsmiHpXfPGJhXyhUqSGpq3u
        HtEegAJA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qEAW6-002q7Q-Q9; Tue, 27 Jun 2023 15:22:07 +0000
Date:   Tue, 27 Jun 2023 16:22:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Jane Chu <jane.chu@oracle.com>, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [v5 0/1] dax: enable dax fault handler to report
 VM_FAULT_HWPOISON
Message-ID: <ZJr+ngIH877t9seI@casper.infradead.org>
References: <20230615181325.1327259-1-jane.chu@oracle.com>
 <b57afc45-6bf8-3849-856f-2873e60fcf97@web.de>
 <18ca0017-821b-595c-0d5a-25adb04196c1@oracle.com>
 <be3db57c-29d0-cfc9-f0cc-1765b672c57e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be3db57c-29d0-cfc9-f0cc-1765b672c57e@web.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 08:08:19AM +0200, Markus Elfring wrote:
> > The thought was to put descriptions unsuitable for commit header in the cover letter.
> 
> How do you think about to put additional information below triple dashes
> (or even into improved change descriptions)?
> 
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.4#n686

Markus,

Please go away.  Your feedback is not helpful.  Thank you.
