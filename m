Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B898067CD5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 15:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjAZOQI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 09:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjAZOQH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:16:07 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E5741094
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 06:16:06 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qx13so5304437ejb.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 06:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=flwiW/xi72yKzHSqPW2Y3gpNbThE+7pF0t3EWtl4bTY=;
        b=jN8TuaHh65R0CGmw8VIIjYWOzwSVI9M9W5qy9Kl+nJTMMq7V5lcwTBeRkLF0JehNSc
         4ooTEyvuCbUkFUFWVPGdLpv2/6u7uoLNm1HX5uh8Vym5AYKkA4DskH9cmazclvzN9PQb
         hrgSUqnwzejScwKA8O9eE4VTQivc3Fusx6FoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flwiW/xi72yKzHSqPW2Y3gpNbThE+7pF0t3EWtl4bTY=;
        b=FDfJ1Ec/za3BWZtr5Y8bIXBcSD2C5zgwQn7Z5t5l96IAaV0UMC4iaykYj4YdKfDyB2
         hPECAyllBY8zTMoqp9/hzm5wU5sxojGP4nLT7VzvWzDsMORvpst4W0cu/DsVmzL/c3Mi
         3u3dTo4xJet6EBA80G2jFfH9nEald15yFpU6Yt4iW4EHcGqwZ/+7T8AfoGBWaTf88xXc
         doVO7xiqCRSyTxPc1wL7aUBi63H+T47g3xHyIM3WUnI9uu8+w286wDVgo/jg8GEDMSdk
         ZUfawEMCkV3ZlKJTA9LRKcZn8Xtd0ykBqlEmnDeD/QeVNb2LINwItV8osbH/2B6HFO8T
         rU7g==
X-Gm-Message-State: AFqh2kpt6+NsrHRp9ukmT+qrn9PvakaMs/UTbHo5uPa4qm4gCXJ3op64
        atOhmzyOiGtVbtqpzvWuT4Ajr7SLQU3TUIgiBwJofA==
X-Google-Smtp-Source: AMrXdXtbG+I0/IvzKg+JicnlRUsGUccM/nFTfXRJLbvMyPyffLDZKCISRrrJp6Zit6/bxr3CYGgdIlH8oiqDwmVlqX0=
X-Received: by 2002:a17:906:6a8e:b0:86e:3764:4f80 with SMTP id
 p14-20020a1709066a8e00b0086e37644f80mr3653187ejr.239.1674742565043; Thu, 26
 Jan 2023 06:16:05 -0800 (PST)
MIME-Version: 1.0
References: <20230109010023.20719-1-rdunlap@infradead.org>
In-Reply-To: <20230109010023.20719-1-rdunlap@infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 26 Jan 2023 15:15:54 +0100
Message-ID: <CAJfpegv2DW8toDQ_aUUC_KeE8X=oTv37BjXw3u_8HL-Ky7ba0g@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix all W=1 kernel-doc warnings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 9 Jan 2023 at 02:00, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Use correct function name in kernel-doc notation. (1)
> Don't use "/**" to begin non-kernel-doc comments. (3)
>
> Fixes these warnings:
>
> fs/fuse/cuse.c:272: warning: expecting prototype for cuse_parse_dev_info(). Prototype was for cuse_parse_devinfo() instead
> fs/fuse/dev.c:212: warning: expecting prototype for A new request is available, wake fiq(). Prototype was for fuse_dev_wake_and_unlock() instead
> fs/fuse/dir.c:149: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Mark the attributes as stale due to an atime change.  Avoid the invalidate if
> fs/fuse/file.c:656: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * In case of short read, the caller sets 'pos' to the position of
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Miklos Szeredi <miklos@szeredi.hu>

Applied, thanks.

Miklos
