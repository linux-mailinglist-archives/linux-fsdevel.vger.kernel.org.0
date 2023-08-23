Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B580786381
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 00:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbjHWWjv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 18:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238793AbjHWWjn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:39:43 -0400
X-Greylist: delayed 576 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Aug 2023 15:39:41 PDT
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E7610D9;
        Wed, 23 Aug 2023 15:39:41 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id B12C840716; Wed, 23 Aug 2023 23:30:01 +0100 (BST)
Date:   Wed, 23 Aug 2023 23:30:01 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jiao Zhou <jiaozhou@google.com>, Peter Jones <pjones@redhat.com>,
        linux-fsdevel@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: Add Mount Option For Efivarfs
Message-ID: <ZOaIabhk9a+hyBaI@srcf.ucam.org>
References: <20230822162350.1.I96423a31e88428004c2f4a28ccad13828adf433e@changeid>
 <CAMj1kXHkrRvUbzdNg7WGmBPFW8MtnhEsSy1FOk4GZzVZ1H4fTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHkrRvUbzdNg7WGmBPFW8MtnhEsSy1FOk4GZzVZ1H4fTw@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 06:30:12PM +0200, Ard Biesheuvel wrote:
> (cc Peter and Matthew)
> 
> On Tue, 22 Aug 2023 at 18:24, Jiao Zhou <jiaozhou@google.com> wrote:
> >
> > Add uid and gid in efivarfs's mount option, so that
> > we can mount the file system with ownership. This approach
> > is used by a number of other filesystems that don't have
> > native support for ownership
> >
> > Signed-off-by: Jiao Zhou <jiaozhou@google.com>

No inherent objection, but what's the use case?
