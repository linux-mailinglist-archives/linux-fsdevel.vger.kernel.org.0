Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE3F50C6D1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 05:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbiDWDIi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 23:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiDWDIg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 23:08:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46F8E4B;
        Fri, 22 Apr 2022 20:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SxQi15J/S+m7GUVDTi1JQZIeFqsLLWQuUAEkCr4fpr0=; b=JfuO39DnJIvtdTBrO8b1kB7hWJ
        UyHWEcNq2XEKydIC8o31W4QfkrZmYTLJoM/PeeMXAHmbr4FI39u87nAEHE91J5KuyvjH5r1jssYyn
        bKI0X3DDf7nvRoeWmRbbdaHfIzm1kClBBVuio8U3hfhQWnNbuc+X4IYIwiCF6W/qVwVQhtCRPGyqE
        yj2TH/MPjJLDNt5u/7ZKqG/TMzFofvxXMPBty+ChmVxDu5IXB39cYAgKj47aq/K3KHnYQtyIfacPW
        9diNSl5ba6pjjbCSPx1ohzPlmXtiq79SE28x0iCfDSfBjLAfsfddyOLOLDLvjNjIwsx1AeGUXqTXI
        UsqJoqbw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ni65S-006f4j-Hf; Sat, 23 Apr 2022 03:05:30 +0000
Date:   Sat, 23 Apr 2022 04:05:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Junwen Wu <wudaemon@163.com>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        adobriyan@gmail.com, fweimer@redhat.com, ddiss@suse.de,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] proc: limit schedstate node write operation
Message-ID: <YmNs+i/unWKvj4Kx@casper.infradead.org>
References: <20220423023104.153004-1-wudaemon@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423023104.153004-1-wudaemon@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 23, 2022 at 02:31:04AM +0000, Junwen Wu wrote:
> Whatever value is written to /proc/$pid/sched, a task's schedstate data
> will reset.In some cases, schedstate will drop by accident. We restrict
> writing a certain value to this node before the data is reset.

... and break the existing scripts which expect the current behaviour.
