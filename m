Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C017843CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 16:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbjHVOTS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 10:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236134AbjHVOTR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:19:17 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98235F3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 07:19:15 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bb8a12e819so70730991fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 07:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692713954; x=1693318754;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qn9dodwGHzqM4o6Xuadep2wsN/m7oy9fF26H77GOobY=;
        b=pwYKMUvwWlEL3KBQ+jbzSKfVS5ATEZsT9KOBWxv9bZ4LAUt0wZ1LCsFKU57M30D+vK
         w2HI1JYfO/PoaqtPzEXGPHOOONvHyyjSwwGQZq60uYDXerFgLz3GII4GjAZCyRA9LPAU
         UGByKO/SySyFY/lJuBz9dA6XdNSFgzaGi1DgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692713954; x=1693318754;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qn9dodwGHzqM4o6Xuadep2wsN/m7oy9fF26H77GOobY=;
        b=WL2cjLn1NXcOcz9LU0rNUT6rNPt2ESVg7qEGytVX17dhMHbjwbfOmcR9ymqCEW6cYF
         FYZYJVIXACQFH9iD1HUoaWYw8XW07NVtulYoEwUpGSaIbNETONUN46MtMW5A511vYo4I
         zKyX70YIap/BTuV98zLXrTleWd4OJ/QsM/eF1zT7cwSlf2CZoQq+y5n6VsgO+tpCZgID
         IRRIFgjn19pyhMTQbfhYPcDVwP5vHTwnoeq0egI1vygF9hqLCGJasfkNntYLA5xB9pNG
         hH+FHumAg57ev7av4jCrlstC+8yO9WhyY6RXh5jfxIRb+msOa846/ekhMamYWw0Mpnhl
         lsTA==
X-Gm-Message-State: AOJu0YyxbXvNOVWH75AuNeGJwS7zvWU0NzgCWCPwaTASdPAllMf62/x7
        j12odcpZGqjDgVWteSeuYI07q6/uoj1ARGbDG1XBFDJM1zp3LbI0ZGI=
X-Google-Smtp-Source: AGHT+IFasunuJqLhjT7VTKsJGv0OIcCfwYtA72UV5vP4/LAPLzeoCc+WYBLm57t26rnuo7lJD3fl+/M+FHk8xd1Iqio=
X-Received: by 2002:a17:906:7395:b0:9a1:c0e9:58ff with SMTP id
 f21-20020a170906739500b009a1c0e958ffmr990130ejl.11.1692713191104; Tue, 22 Aug
 2023 07:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <20230519125705.598234-6-amir73il@gmail.com>
 <CAJfpeguhmZbjP3JLqtUy0AdWaHOkAPWeP827BBWwRFEAUgnUcQ@mail.gmail.com>
 <CAOQ4uxhYZqe0-r9knvdW_BWNvfeKapiwReTv4FWr_Px+CB+ENw@mail.gmail.com>
 <CAOQ4uxhBeFSV7TFuWXBgJZuu-eJBjKcsshDdxCz-fie0MqwVcw@mail.gmail.com>
 <CAOQ4uxirdrsaHPyctxRgSMxb2mBHJCJqB12Eof02CnouExKgzQ@mail.gmail.com>
 <CAJfpegth3TASZKvc_HrhGLOAFSGiAriiqO6iCN2OzT2bu62aDA@mail.gmail.com> <CAOQ4uxjU5D=BmLe66NyG_qGWk8rhZGKx+BCZmJQmhQOdCSw+1g@mail.gmail.com>
In-Reply-To: <CAOQ4uxjU5D=BmLe66NyG_qGWk8rhZGKx+BCZmJQmhQOdCSw+1g@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 22 Aug 2023 16:06:19 +0200
Message-ID: <CAJfpegu8QQZJVYz6bku_x-ai4YhJ+RBXLJzdq9+FyTo6dGtkCA@mail.gmail.com>
Subject: Re: [PATCH v13 05/10] fuse: Handle asynchronous read and write in passthrough
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 22 Aug 2023 at 15:22, Amir Goldstein <amir73il@gmail.com> wrote:

> IDK, ovl_copyattr() looks like a textbook example of a race
> if not protected by something because it reads a bunch of stuff
> from realinode and then writes a bunch of stuff to inode.

Yeah, you are right.

> Anyway, I guess it wouldn't hurt to wrap it with inode_lock()
> in the ovl completion callback.

Okay.

Thanks,
Miklos
