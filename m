Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A9E72B8EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 09:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbjFLHn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 03:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbjFLHnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:43:23 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70B2E7A;
        Mon, 12 Jun 2023 00:42:50 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-543d32eed7cso1636193a12.2;
        Mon, 12 Jun 2023 00:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686555694; x=1689147694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euWXaE16F/ugXUu2AMUYqNLZJYAVWQN5GTNPdv6gWGc=;
        b=YAKp79x/Kq6zwHrCw55oosM5zQDMLpzHUX7vJhuFAdSHsJf3kf5jYPkJjBl5Pfw+oG
         ll5t3YPZuZ8foEsGiP/GgNI+sAXbjOZnFGAXdG9g2r5WQT79JL5bHQzPe/NnC3jG3bsZ
         n+tWmkwYMwNMc06k42lKhn53hEbFqs6W91Ss+oJ0AyjlQaJS4Mmh/E3i1hFqgrGV99Jx
         tqjdbdoL/YWD/Zw3zYeVSQrj8gIUUcUIlTihG0hQK/d/FgSVHK2MzFzNCX0InfqRS5zh
         FCZ1hma+xk/y+Z/kgWuA8Io/t/hJEeoSrBQUdua60Hc+usvHBzeAAL+mpFdQuLrKyngg
         GN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686555694; x=1689147694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euWXaE16F/ugXUu2AMUYqNLZJYAVWQN5GTNPdv6gWGc=;
        b=BybZvL1h8GmLX7Y9jH4CGk3rRdJdkLPH2rh5frkgvrbBXp88WAoM/i8CamQeaZ9Kl4
         ShigGsfqLyOn4THKMKnrNq/mhH+T+UDYFJz3eDUwKpdqBOfNzHZfMJxcX2oBndMIyGei
         ZRMTL+QT/kEnpzJQS81PgJZ5Ig8q76un13++Ynf+WUeikISnANakcOJXNZNWvDyCIpIW
         WMF/TygnXk57oGAfGWhgkUfrI/dCmOU5cFPRvhZNWulpfC0sjBaT6A4weT9ME8HK/xbg
         FsuhA02ji+X7kyJiPUDC4Gks5q47xH8QXL3YJ5UCPOWSwyRJx0m9VOknsf1PSP+xtnlI
         mUbA==
X-Gm-Message-State: AC+VfDzYl9jGMXcvue+QTIYTR7ON0KZl/a5aQFWSVvPrLx7yRzYL6GAx
        77QmmXa1U+brweDwZRG1Yiq7QwNEmAVvl6f7YB/HC4V+RmQ=
X-Google-Smtp-Source: ACHHUZ4pAAxHXnucW983HrU5rBUAk9CQd/Vt3QT3607XLv5TJ1gwDnE3t9W2M8iRjZJleCzVYQXttl78ah/rkL+ZYDY=
X-Received: by 2002:a67:fd75:0:b0:43b:240f:b92e with SMTP id
 h21-20020a67fd75000000b0043b240fb92emr2803174vsa.18.1686551331374; Sun, 11
 Jun 2023 23:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230611132732.1502040-1-amir73il@gmail.com> <20230611132732.1502040-3-amir73il@gmail.com>
 <ZIagx5ObeBDeXmni@infradead.org>
In-Reply-To: <ZIagx5ObeBDeXmni@infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 12 Jun 2023 09:28:40 +0300
Message-ID: <CAOQ4uxjm4nXc4cHFCnk69RC2yshBmFBxMTuVxH3QQRm_6LRcSw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fs: introduce f_real_path() helper
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 7:36=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Sun, Jun 11, 2023 at 04:27:31PM +0300, Amir Goldstein wrote:
> > Overlayfs knows the real path of underlying dentries.  Add an optional
> > struct vfsmount out argument to ->d_real(), so callers could compose th=
e
> > real path.
> >
> > Add a helper f_real_path() that uses this new interface to return the
> > real path of f_inode, for overlayfs internal files whose f_path if a
> > "fake" overlayfs path and f_inode is the underlying real inode.
>
> I really don't like this ->d_real nagic.  Most callers of it
> really can't ever be on overlayfs.

Which callers are you referring to?

> So I'd suggest we do an audit
> of the callers of file_dentry and drop all the pointless ones
> first, and improve the documentation on when to use it.

Well, v3 is trying to reduce ->d_real() magic and the step
after introducing the alternative path container is to convert
file_dentry() to use the stored real_path instead of ->d_real().

But I agree that the documentation about this black magic is
missing. Will try to improve that with the move to the "fake"
file container.

Thanks,
Amir.
