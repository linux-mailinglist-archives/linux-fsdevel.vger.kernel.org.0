Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B165F62C3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 10:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiJFIdz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 04:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiJFIdm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:33:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BDC9411C;
        Thu,  6 Oct 2022 01:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ogIdAYV0BU8EWus85GBp3cFwq4ZzocrCrMeVOE5lBWM=; b=TUGg3whQm37FJ05L4DSFnjJAns
        RR+fr29Vr9AwrH0dgUR98gNB3JT5YNboOpXzx0ek1KcxGD6LTmXsTFuo0Xlo+6o36R//hJ49vHn0j
        gJKuI+DnJ3x2UpdVYmEb7vn6ypxMIdev+8RHD44C3zHxi7yIo4/qyVIkC9RIoE5yjScIQ8PWOP1xr
        jJ4BAsUxrtNo6AvbCwUQX39G0hMERbYad84Gf7/HH4MYDKO11TONDhpBHwnIitdhgHvY7+fDXxqIt
        wyR05XPCMWM0rjL3UhvJbw8t9RtDgAT2ks69dLeDNPYLLCFQty4U6YYZrsMcW6Lg194NG4FDdqEqB
        ggEMOmJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogMJy-000ips-6T; Thu, 06 Oct 2022 08:33:34 +0000
Date:   Thu, 6 Oct 2022 01:33:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Daeho Jeong <daeho43@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] f2fs: introduce F2FS_IOC_START_ATOMIC_REPLACE
Message-ID: <Yz6S3kP4rjm5/30N@infradead.org>
References: <20221004171351.3678194-1-daeho43@gmail.com>
 <20221004171351.3678194-2-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004171351.3678194-2-daeho43@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 04, 2022 at 10:13:51AM -0700, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> introduce a new ioctl to replace the whole content of a file atomically,
> which means it induces truncate and content update at the same time.
> We can start it with F2FS_IOC_START_ATOMIC_REPLACE and complete it with
> F2FS_IOC_COMMIT_ATOMIC_WRITE. Or abort it with
> F2FS_IOC_ABORT_ATOMIC_WRITE.

It would be great to Cc Darrick and linux-fsdevel as there have been
attempts to do this properly at the VFS level instead of a completely
undocumented ioctl.

