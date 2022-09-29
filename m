Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A975EFDBD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 21:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiI2TPk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 15:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiI2TPh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:15:37 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8332AE34
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Sep 2022 12:15:35 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id m11-20020a4aab8b000000b00476743c0743so765997oon.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Sep 2022 12:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=8IbasIFnxsejYaRakKMDBw+Uxz+TadwpxPchTJjqrxs=;
        b=6UI3OArnfid8IKiXqa9PxPke7bVg+BIu9iBaLi/CVKSn6KxGVyKWnHlbuztUik/xqa
         rRJ7OVKR3Zry6HIPDN7tCqKVf4NO9MIQFxZQM75WbOYglFmJspaPt+Lh9YnlDXNuASTm
         QzE4TwdVDmvd7InI96FLlAzNzpWcxA4t6yeyxZ6xP11Soor1eVc0Iqzlh2S6lehvj/LW
         3Usk39z6dUJMcdKyWnbN+Xb+vjdU/a+JfW/bKUcGYTQCDNkvGNtatJNeLh2VzY4ZB4Xt
         /7faKzCb7e9g/VeZ30AF93fdL44NW2cma3I7Lt2RH54o3zTspRfxXDBTvatenLC6otID
         w7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8IbasIFnxsejYaRakKMDBw+Uxz+TadwpxPchTJjqrxs=;
        b=okLbx0OdJsWS42GfWCWfYOSxe33C6v9CIsjmYHkEHDJNDMZ5otunh9E9oT/V9htXq1
         9thGpDL2y0beaiZskRtqIWL1HK6W2rEPzugdXk9h2kWVB6GmERfrY2kISqHbYQq2SXSd
         6rTW1pTcq83J652aF1nEUKKJhFtrKFg02iF024EFZwBeUq3ZwaKB6JsCjHvA7B/gucN4
         q4jfL3FGZsN7hR3WeokYb7qUQPYd6FotG2ohXqY8yWnPMGjaVOPncjvcJWlWXyUcuzdf
         YySOw14znY0g0qGs6rG34A+qABNd9ZyMppKu2+ejcG1uSM70HJMD4NLsYAFZ8Lw4OFkk
         h4uA==
X-Gm-Message-State: ACrzQf2qfyEK/1EChc50H5TUdNDixZebSJJIZewSL4FLBb8j1+vXFldy
        yHEfSuwPzV7LQUjhR6JTB3EDaYNP9B/+zDZ53t3E
X-Google-Smtp-Source: AMsMyM7RMLrJCM78VDgsZEoSRlahTnnSzhtFRKGCXtD3ylFH7T9Vjjc9QK6mk9h6rCOVzsjleunPvCxt23iK41VHsOc=
X-Received: by 2002:a05:6830:114f:b0:655:bd97:7a9b with SMTP id
 x15-20020a056830114f00b00655bd977a9bmr2029445otq.287.1664478934964; Thu, 29
 Sep 2022 12:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220929153041.500115-1-brauner@kernel.org> <20220929153041.500115-10-brauner@kernel.org>
In-Reply-To: <20220929153041.500115-10-brauner@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 29 Sep 2022 15:15:24 -0400
Message-ID: <CAHC9VhTiGru2XAbjf=hqh+S+Hz8XH1aSP0mks0pjTxT55YfA2w@mail.gmail.com>
Subject: Re: [PATCH v4 09/30] security: add get, remove and set acl hook
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 11:31 AM Christian Brauner <brauner@kernel.org> wrote:
>
> The current way of setting and getting posix acls through the generic
> xattr interface is error prone and type unsafe. The vfs needs to
> interpret and fixup posix acls before storing or reporting it to
> userspace. Various hacks exist to make this work. The code is hard to
> understand and difficult to maintain in it's current form. Instead of
> making this work by hacking posix acls through xattr handlers we are
> building a dedicated posix acl api around the get and set inode
> operations. This removes a lot of hackiness and makes the codepaths
> easier to maintain. A lot of background can be found in [1].
>
> So far posix acls were passed as a void blob to the security and
> integrity modules. Some of them like evm then proceed to interpret the
> void pointer and convert it into the kernel internal struct posix acl
> representation to perform their integrity checking magic. This is
> obviously pretty problematic as that requires knowledge that only the
> vfs is guaranteed to have and has lead to various bugs. Add a proper
> security hook for setting posix acls and pass down the posix acls in
> their appropriate vfs format instead of hacking it through a void
> pointer stored in the uapi format.
>
> In the next patches we implement the hooks for the few security modules
> that do actually have restrictions on posix acls.
>
> Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>
> Notes:
>     /* v2 */
>     unchanged
>
>     /* v3 */
>     Paul Moore <paul@paul-moore.com>:
>     - Add get, and remove acl hook
>
>     /* v4 */
>     unchanged
>
>  include/linux/lsm_hook_defs.h |  6 ++++++
>  include/linux/lsm_hooks.h     | 12 ++++++++++++
>  include/linux/security.h      | 29 +++++++++++++++++++++++++++++
>  security/security.c           | 25 +++++++++++++++++++++++++
>  4 files changed, 72 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>


--
paul-moore.com
