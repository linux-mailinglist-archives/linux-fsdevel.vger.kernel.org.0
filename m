Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9573078766F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 19:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241519AbjHXRQW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 13:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241772AbjHXRQJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 13:16:09 -0400
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F422219A3;
        Thu, 24 Aug 2023 10:16:04 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 9A43A406E5; Thu, 24 Aug 2023 18:16:03 +0100 (BST)
Date:   Thu, 24 Aug 2023 18:16:03 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Jiao Zhou <jiaozhou@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Peter Jones <pjones@redhat.com>,
        linux-fsdevel@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: Add Mount Option For Efivarfs
Message-ID: <ZOeQU9ACbj41g2Ni@srcf.ucam.org>
References: <20230822162350.1.I96423a31e88428004c2f4a28ccad13828adf433e@changeid>
 <CAMj1kXHkrRvUbzdNg7WGmBPFW8MtnhEsSy1FOk4GZzVZ1H4fTw@mail.gmail.com>
 <ZOaIabhk9a+hyBaI@srcf.ucam.org>
 <CAFyYRf2DschMpD35rkn4-0quKkga=kf0ztQQ3J9ZBvKmKTpAkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFyYRf2DschMpD35rkn4-0quKkga=kf0ztQQ3J9ZBvKmKTpAkw@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 24, 2023 at 12:51:07PM +0100, Jiao Zhou wrote:
> We want to support fwupd for updating system firmware on Reven. Capsule updates
> need to create UEFI variables. Our current approach to UEFI variables of
> just allowing access to a static list of them at boot time won't work here.
> 
> I think we could add mount options to efivarfs to set the uid/gid. We'd
> then mount the file system with fwupd's uid/gid. This approach is used by a
> number of other filesystems that don't have native support for ownership,
> so I think it should be upstreamable.

Makes sense.

Acked-by: Matthew Garrett <mgarrett@aurora.tech>
