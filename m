Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC28A5233B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 15:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbiEKNFv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 09:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiEKNFu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 09:05:50 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7C1DEA5
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 06:05:48 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id y76so3920730ybe.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 06:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=alN9NUxZowEkDstVYOnVw32DS4I4mSVC05IaVQ1sfiU=;
        b=NHbVLSb/IvYbshil6PcaDeTB9meK9lgGB+X9ifCZP+TCL1N3KBAZhlTd0GhktiOhkO
         cJtPG3u7bW8cUQ7YGT1ptX9+VyXecVcV5Y6ZXRdjJSSfH8HRFEOz02hDo4Hfqu0dQbAN
         Si4jvVk1JSJDxKvCLpBLZHl8Pa5bCknaZOJF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=alN9NUxZowEkDstVYOnVw32DS4I4mSVC05IaVQ1sfiU=;
        b=2PR3qzj/leMe/Ax+rDq4tbO4Bn5qnYFl/W/5MppY/kH/ehA4v5uNhggrEWfm6EmfYx
         QfJsEGuu7PbjXNmdf7v9VHMQKy3uQrSmy3EO86rfaJuHilxa6+vTTq8Ml4jQeMchoeYx
         rDnQnceaWj+ChAXnCEEIsG8f2OsbGvPDxCZPxuZOGBboKRLF1W5nFSRF8oMWddvpTTWl
         jDVV9OwOqA/SgkLLMkmSVMNjhPWsB8ifvq5NVAX6CrnUb2yW41TD2QwBa7HCXuR9hDnG
         ifUkiVsTBDvwUEvm4UXKHvbwR4sRX6XVOPYehMKghXrbFjdS0lPD78tfZHWgcQLJP4p8
         mE7A==
X-Gm-Message-State: AOAM530yhXS9/2Vhwdon0um/Lo26OcP6eninhBJrUEPhth8gOth9kZhX
        bRAEiaNFV034GrYlt1qeGvIvVxWwtom9aUAxfcdE2A==
X-Google-Smtp-Source: ABdhPJzkrcZMJilZKt8K7MTZ9r8G8qNFSk+3YyiZ6njw2XzhbTqbGkSKb6Y7yUx68sby8oqrklEVUwTAuqBK+A3Br4A=
X-Received: by 2002:a5b:44e:0:b0:64a:c0be:c59c with SMTP id
 s14-20020a5b044e000000b0064ac0bec59cmr16451795ybp.573.1652274347928; Wed, 11
 May 2022 06:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220511013057.245827-1-dlunev@chromium.org> <CAJfpegsmyY+D4kK3ov51FLGA=RkyGDKMcYiMo2zBqYuFNs78JQ@mail.gmail.com>
 <CAONX=-dqY64VkqF6cNYvm8t-ad8XRqDhELP9icfPTPD2iLobLA@mail.gmail.com>
 <CAJfpegvUZheWb3eJwVrpBDYzwQH=zQsuq9R8mpcXb3fqzzEdiQ@mail.gmail.com>
 <CAONX=-cxA-tZOSo33WK9iJU61yeDX8Ct_PwOMD=5WXLYTJ-Mjg@mail.gmail.com>
 <CAJfpegsNwsWJC+x8jL6kDzYhENQQ+aUYAV9wkdpQNT-FNMXyAg@mail.gmail.com>
 <CAONX=-d9nfYpPkbiVcaEsCQT1ZpwAN5ry8BYKBA6YoBvm7tPfg@mail.gmail.com> <CAJfpegtTP==oMm+LhvOkrxkPB973-Y80chbwYpXSiOAXBDhHJw@mail.gmail.com>
In-Reply-To: <CAJfpegtTP==oMm+LhvOkrxkPB973-Y80chbwYpXSiOAXBDhHJw@mail.gmail.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Wed, 11 May 2022 23:05:37 +1000
Message-ID: <CAONX=-fQvBczRk2HV1GXBoypq7_QbUX9JXc2AuDMQ+-qfYW32A@mail.gmail.com>
Subject: Re: [PATCH 0/2] Prevent re-use of FUSE superblock after force unmount
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I think it would be easiest to remove the super block from the
> type->fs_supers list.
I will try tomorrow and upload an updated patchset.
Thanks,
Daniil.
