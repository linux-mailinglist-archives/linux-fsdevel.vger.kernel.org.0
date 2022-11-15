Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B4862A1CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 20:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiKOTZw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 14:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiKOTZu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:25:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B683D2F3AF
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Nov 2022 11:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=78L0Yu0x+glskr1IHe+5Sn7Q+4VXPaI5cpnwppCdEEU=; b=n6JDMrgjtGSDQn9BnuGUjhCtGg
        Fqrr0I43wsiwX4+k6q0uzp0a2OKDGni29essZzZHJJVnWhgpVvJsfJHV9LA7Bs7YmtEJegr8oO1T6
        l4w/9PpnRRWZU71hXVDIhptNnx/zFs47kJqmPzXlfh1cLOJMrGcPtRShGqYgt/Y4qSa1BJSpRb5Dc
        mcHNmy+AAdTDUgQUmvvsyvwBD9baFPdUnMrKeQ6JbCXWL2vlsziCAnqchDT7T50MC6WiBrjZxTluW
        JlYp2eMKGyhU5u0ZR3YHSpeNY0kjezyHzSimGxzQ+70BtZr18Coy35TVeWgBh6ui8/AbtocHGYShy
        9ESF4pYw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ov1Yz-00EHVM-Kh; Tue, 15 Nov 2022 19:25:41 +0000
Date:   Tue, 15 Nov 2022 11:25:41 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     yzaikin@google.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, liwei391@huawei.com
Subject: Re: [PATCH] proc: sysctl: remove unnecessary jump label in
 __register_sysctl_table()
Message-ID: <Y3PntfKfwSakLuTf@bombadil.infradead.org>
References: <20221115024734.3734391-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115024734.3734391-1-zengheng4@huawei.com>
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

On Tue, Nov 15, 2022 at 10:47:34AM +0800, Zeng Heng wrote:
> The processing path that handles error return value of insert_header(),
> can reuse part of normal processing path. So remove the unnecessary
> jump label named fail_put_dir_locked.
> 
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>

I see no point to do this change, it doesn't make the code clearer. So
I'd rather just leave it as-is.

  Luis
