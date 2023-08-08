Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A013774522
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 20:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjHHShr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 14:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjHHShT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:37:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5A4F3A28;
        Tue,  8 Aug 2023 09:37:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22BF8624E8;
        Tue,  8 Aug 2023 16:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F417C433C8;
        Tue,  8 Aug 2023 16:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691512600;
        bh=s2rPxOfy1Y0fjPSjnYAH7dGDP+SH3CfSccoZNpyTO+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y+qJvfVesc1nYGZoi+Lsb5+ELO7xkN0t4o6lfG5rhCYoXYVw1mXVn7lmCpIeG/2w4
         8yvsHlP5NZwsDZpf6kXdzggArbTh8fFgIplFSYwX2q3CZwKYR6QqfgQn79qhMN4S9O
         FncaicQUOicY7U210nvS+eRi/er10vurr5W9h7DI=
Date:   Tue, 8 Aug 2023 18:36:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manas Ghandat <ghandatmanas@gmail.com>
Cc:     Linux-kernel-mentees@lists.linuxfoundation.org, anton@tuxera.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] ntfs : fix shift-out-of-bounds in ntfs_iget
Message-ID: <2023080811-populace-raven-96d2@gregkh>
References: <2023080821-blandness-survival-44af@gregkh>
 <20230808102958.8161-1-ghandatmanas@gmail.com>
 <2023080833-pedicure-flavorful-921c@gregkh>
 <CAEt2hJ5icep5dF_OhuZwe0zig4VKCTKuQ0=iYfpOek7Ebp12Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEt2hJ5icep5dF_OhuZwe0zig4VKCTKuQ0=iYfpOek7Ebp12Lw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 08:45:02PM +0530, Manas Ghandat wrote:
> In the above patch I have mentioned what are the changes from the version
> 1. Also since most of the lines of the patch were a change due to some
> indentation error, the whole patch appears as the diff.

As my bot said:

> > - This looks like a new version of a previously submitted patch, but you
> >   did not list below the --- line any changes from the previous version.
> >   Please read the section entitled "The canonical patch format" in the
> >   kernel file, Documentation/process/submitting-patches.rst for what
> >   needs to be done here to properly describe this.

Please read that and submit a new patch based on the requirements there.

thanks,

greg k-h
