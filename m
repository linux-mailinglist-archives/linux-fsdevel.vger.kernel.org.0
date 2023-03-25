Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4386C8E8C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Mar 2023 14:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjCYNdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Mar 2023 09:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjCYNdq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Mar 2023 09:33:46 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C435812859
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Mar 2023 06:33:45 -0700 (PDT)
Received: from letrec.thunk.org (216.200.140.133.t01566-01.above.net [216.200.140.133] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32PDX9Gw028167
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 09:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679751191; bh=ney3ZTNZKvrvV6ifyhERjCVEYlvSiageA+nB9FsX8A0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=LcGkc2zou0310eThCZ1AEOKTbp4Vpq6qZ+O9C2HggIbD9jfV33spAdulbrcpxujnU
         CAKPm/qHNqjNTN+Vye0dk4M5I+2wyHQSvCH4jPBxR0wnu9mjzywP0L2921KiONR8SR
         18zfsE3AgUZh3tzbXA2Zw0cv/m3Qoi0ekUDE0glbYh9DUN/xzUsoj6LgcCeZHPMfva
         qnQ+/v63r8iqIeh5RykwVk/uAwKR81vXaIGM8Z4wge+3wekQhVjIZVfZRxPYsD+Qb5
         IbnxrYXhwqWvBxFG+tdnkeltDbQW0ZwZYBzIfhrFezgdteBix+vtAqv9JvKOlfyUuj
         Z3mvyJ6VNjhJQ==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 37C698C0521; Sat, 25 Mar 2023 09:33:10 -0400 (EDT)
Date:   Sat, 25 Mar 2023 09:33:10 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     viro@zeniv.linux.org.uk, jaegeuk@kernel.org, ebiggers@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel@collabora.com
Subject: Re: [PATCH 1/7] fs: Expose name under lookup to d_revalidate hook
Message-ID: <ZB74FsfDDUegrqqx@mit.edu>
References: <20220622194603.102655-1-krisman@collabora.com>
 <20220622194603.102655-2-krisman@collabora.com>
 <20230323143320.GC136146@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323143320.GC136146@mit.edu>
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        MAY_BE_FORGED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 23, 2023 at 10:33:20AM -0400, Theodore Ts'o wrote:
> On Wed, Jun 22, 2022 at 03:45:57PM -0400, Gabriel Krisman Bertazi wrote:
> > Negative dentries support on case-insensitive ext4/f2fs will require
> > access to the name under lookup to ensure it matches the dentry.  This
> > adds an optional new flavor of cached dentry revalidation hook to expose
> > this extra parameter.
> > 
> > I'm fine with extending d_revalidate instead of adding a new hook, if
> > it is considered cleaner and the approach is accepted.  I wrote a new
> > hook to simplify reviewing.
> > 
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> 
> Al, could you take a look and see if you have any objections?

Ping, Al, any objsections if I take Gabriel's patch series via the
ext4 tree?

					- Ted
