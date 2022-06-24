Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551CA55A3FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 23:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiFXVxW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 17:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiFXVxV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:53:21 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3773251E54;
        Fri, 24 Jun 2022 14:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KbVP1NeGvGHemZZU+ExARnHCCDiWivWCfuEpseNKJZA=; b=rSeGFK9KBSvuZfpwAHzDSN0kxD
        59AstGo5OikSH/pKojeAZJpljo/CQ40RxXBHxT2Z8ZcmTAONSLadc2OekOiGS3xSfOzvaqViOIian
        aEez2q9/dsR1UQ+1t7X895QdWEIRf+Vph7f2IqVJC+xDYXyfNSO0EzbCYLgFGily6c5Y6CB0B6Kw3
        Ya58RQkQZDd2c3r96xpcPMTGm2y7DkxWpOLBQbt76p2yF65GhylkCxFWeIIbM5rZzcNc1K3Lc+XQH
        KuS9SMyO7FTXW4FurCpJMtGz/A0L5AwDo8Ue3hnFFmyuTBKLVYbsfWLomZmoOargClcXIn5haMrPO
        DIgm0YHw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o4rEt-00450z-7h;
        Fri, 24 Jun 2022 21:53:19 +0000
Date:   Fri, 24 Jun 2022 22:53:19 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 6/6] vfio: do not set FMODE_LSEEK flag
Message-ID: <YrYyT0msDtQWSdSs@ZenIV>
References: <20220624165631.2124632-1-Jason@zx2c4.com>
 <20220624165631.2124632-7-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624165631.2124632-7-Jason@zx2c4.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 24, 2022 at 06:56:31PM +0200, Jason A. Donenfeld wrote:
> This file does not support llseek, so don't set the flag advertising it.

... or it could grow a working llseek - doesn't look like it would be
hard to do...
