Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1575EFB0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 18:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbiI2Qjn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 12:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiI2Qjm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:39:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF3C2DDE;
        Thu, 29 Sep 2022 09:39:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CA81468BFE; Thu, 29 Sep 2022 18:39:31 +0200 (CEST)
Date:   Thu, 29 Sep 2022 18:39:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        qemu-devel@nongnu.org, kvm@vger.kernel.org,
        Kevin Wolf <kwolf@redhat.com>
Subject: Re: Commit 'iomap: add support for dma aligned direct-io' causes
 qemu/KVM boot failures
Message-ID: <20220929163931.GA10232@lst.de>
References: <fb869c88bd48ea9018e1cc349918aa7cdd524931.camel@redhat.com> <YzW+Mz12JT1BXoZA@kbusch-mbp.dhcp.thefacebook.com> <a2825beac032fd6a76838164d4e2753d30305897.camel@redhat.com> <YzXJwmP8pa3WABEG@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzXJwmP8pa3WABEG@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 10:37:22AM -0600, Keith Busch wrote:
> I don't think so. Memory alignment and length granularity are two completely
> different concepts. If anything, the kernel's ABI had been that the length
> requirement was also required for the memory alignment, not the other way
> around. That usage will continue working with this kernel patch.

Well, Linus does treat anything that breaks significant userspace
as a regression.  Qemu certainly is significant, but that might depend
on bit how common configurations hitting this issue are.
