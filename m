Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9E46FB559
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 18:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbjEHQkF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 12:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbjEHQkA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 12:40:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170366EB1;
        Mon,  8 May 2023 09:39:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75E6C6252F;
        Mon,  8 May 2023 16:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABD4C433D2;
        Mon,  8 May 2023 16:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683563968;
        bh=k6cUHSsgK5Fn8DpZlfU29s/FNuK/SUl4o07CWRZz99s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mC0a7zrM1FiMolYByDwdo1vM7uJNnt5DJS/o1UEFnCWoz2+W/9BeveIDHs3SC0/EY
         EeXO1UF6/8p2MKgZTeFSJW9QsZ+Z3DR7eDXHZiO655BcmmIvskOVZdt0HbqBZpSCKT
         rmAelxzuu2KMxU2GpOuHFmEPFIC4GEkHaio29Pa5e14dPNoKxIsuTYAOn8VZzhp8px
         DtdPydAO+oXNc5FKPT73Aal0VABVde2qdq4a2QOcuTwj6lhBBsS/4X/Bnyc/y68f+B
         1U/Q+/7c/36jDDoWFdWeiJYHwpm8T026WiIfsgUrjPkH/8MTiNfeNK+YoN8o6pKkOY
         4cpeO04DZLjTA==
Date:   Mon, 8 May 2023 18:39:31 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Rob Landley <rob@landley.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Documentation/filesystems: ramfs-rootfs-initramfs: use
 :Author:
Message-ID: <20230508-absehbar-nickel-c94c8e3069e3@brauner>
References: <20230508055928.3548-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230508055928.3548-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 07, 2023 at 10:59:28PM -0700, Randy Dunlap wrote:
> Use the :Author: markup instead of making it a chapter heading.
> This cleans up the table of contents for this file.
> 
> Fixes: 7f46a240b0a1 ("[PATCH] ramfs, rootfs, and initramfs docs")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Rob Landley <rob@landley.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>
