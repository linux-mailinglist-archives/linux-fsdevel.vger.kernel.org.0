Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA50730784
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 20:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjFNSm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 14:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjFNSmy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:42:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016771BEC;
        Wed, 14 Jun 2023 11:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZUngY3vxE+GX6ne/HFPUJqC1QxnwMwVXn396TSG4h4g=; b=n641Yf+yYOzx/xteIYBSQzG3JR
        7M2b5gswMyPFDBIPw7KuY+87aP80ibYUvS3LfjxmnxPgtNMZaMedsgjtixeNG/QFp6z7n0+JIUXlB
        M/ktEtskrxeYfRLOQwEoFdsq8FO8WCgV4sbIV9BU7+lFXGevuvCLJ9SvkAywHqNDbrZWxhnE9gKeB
        ALG/PC3h60JgIupR3PSP7WMawRUY8kri+JoAFudVwGRwismO0DEUWcUyj7VA4Q6zwQWTZX9DhQW8C
        +jdcLeEzPi3nUdM+pbBY+2rJkzE2OnkOr2hwrcXaBCEvZQbu/Hb1E0rPzKiPQdr2axKvbJ50YBgpS
        Wn+KvdOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9VS6-006eeR-3g; Wed, 14 Jun 2023 18:42:42 +0000
Date:   Wed, 14 Jun 2023 19:42:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     wenyang.linux@foxmail.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Eric Biggers <ebiggers@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] eventfd: add a uapi header for eventfd userspace APIs
Message-ID: <ZIoKInPyYIOC8XPw@casper.infradead.org>
References: <tencent_2B6A999A23E86E522D5D9859D54FFCF9AA05@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_2B6A999A23E86E522D5D9859D54FFCF9AA05@qq.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 15, 2023 at 02:40:28AM +0800, wenyang.linux@foxmail.com wrote:
> From: Wen Yang <wenyang.linux@foxmail.com>
> 
> Create a uapi header include/uapi/linux/eventfd.h, move the associated
> flags to the uapi header, and include it from linux/eventfd.h.
> 
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
