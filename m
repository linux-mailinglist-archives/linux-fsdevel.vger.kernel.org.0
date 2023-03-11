Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527806B595D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 08:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjCKH5X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Mar 2023 02:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCKH5V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Mar 2023 02:57:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFC5BBA9;
        Fri, 10 Mar 2023 23:57:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C3DDB80880;
        Sat, 11 Mar 2023 07:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95641C433EF;
        Sat, 11 Mar 2023 07:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678521437;
        bh=Gg16DCykJnE2Bhw2ejexmfCb52yIzdYHCxDa3JlpAbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gzGhctNUhn4NXUQyyAwllTMN+IEjkkXebZzYti5laFRdavjcYflS/A7tZnaiI8yU1
         I885XBkAlyECh1czT2rDSTVhF8HLOXbrFeBeeHVPUAXHkJzEwFiZtJYWLKSpJSR1Ac
         JOptKAO5qt/aguAxHHQ21+PinmZFwIvJ5kjKvkd8=
Date:   Sat, 11 Mar 2023 08:57:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     pvorel@suse.cz, akpm@linux-foundation.org, keescook@chromium.org,
        Jason@zx2c4.com, ebiederm@xmission.com, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] utsname: simplify one-level sysctl registration for
 uts_kern_table
Message-ID: <ZAw0WoMnaBdMEDwa@kroah.com>
References: <20230310231656.3955051-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310231656.3955051-1-mcgrof@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 10, 2023 at 03:16:56PM -0800, Luis Chamberlain wrote:
> There is no need to declare an extra tables to just create directory,
> this can be easily be done with a prefix path with register_sysctl().
> 
> Simplify this registration.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

> ---
> 
> This is part of the effort to phase out calls that can recurse from
> sysctl registration [0]. If you have a tree to take this in feel free
> to take it, or I can take it too through sysclt-next. Let me know!
> 
> This file has no explicit maintainer, so I assume there is no tree.
> 
> If I so no one taking it I can take in as part of sysctl-next later.

I recommend taking it in your tree like this, thanks.

greg k-h
