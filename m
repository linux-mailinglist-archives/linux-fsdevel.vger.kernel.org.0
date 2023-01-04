Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5F965D103
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 11:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239114AbjADKzy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 05:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbjADKyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:54:33 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F0312AE1
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jan 2023 02:54:09 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id jo4so81643452ejb.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jan 2023 02:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1pxje+5aTPq7eSsg/ruQa9jMt63AcUe76/mSIdF4YJI=;
        b=YM3xFzYuhdejV1kQQWYoy9azE8HGcWtLEDyFAmyaAyq7yNt7SaXnu1fEU6JLN+rsHz
         Yp821Cc29nKyLdyuS4DKbnlYMjv12T9tO78CAn5QdARPvTPb+ulGuCUQzMz9rx+s62Ny
         CV7qt96ZBVyvSEXAvuhOYan5caogNaK9pKDsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1pxje+5aTPq7eSsg/ruQa9jMt63AcUe76/mSIdF4YJI=;
        b=KxZEOwKMCv87WpUdoJ+xH+z5qWouSGc6TeQxphIEc4r/lMUXRgfwK6q/aFT8F4vhPb
         u/iIJtpLYmyjCZUMhJ8Mvmm80vo1wltjLaUkMEEUZg9xgKetzV7pa13MTUjxB/33wWkr
         CVVqtGK1g2STUyBswOQRc3J8WjfbCAG6CrBxODkU4aK7XpsgherJmG/WMKNHjdKMOvZ1
         Qdap5Rht7eYc3YOBya5D2qRRFAWLbiK7nvUAjZvM/+btN8p0hYO3xTjXHEinarMEbVDL
         Kr409wvNXLGrKBf6dplanMpXqmIJ1JoEyyKp8b0pJsH//BDzTrfTUWqFrxjdACdlLRZc
         t+oA==
X-Gm-Message-State: AFqh2kpHJamW5caRf6bMuuMR2MZTH8Wa+nTPkR/izDS39jYKx1u9TW6i
        9MqQVsoFaxzb7gQY7gwqmvFo1Y3R3+KvRb0+4BsUCQ==
X-Google-Smtp-Source: AMrXdXv69ff6h3PEw35cc1vBZQg9QGdnwzJEqcRjoNu4u+N5EhYERF3DXAba0jyHjKVddch33Uqhv3xAFRCA7rFJX04=
X-Received: by 2002:a17:906:d790:b0:83e:cc7:27f with SMTP id
 pj16-20020a170906d79000b0083e0cc7027fmr2767211ejb.751.1672829647718; Wed, 04
 Jan 2023 02:54:07 -0800 (PST)
MIME-Version: 1.0
References: <20230103-fstests-setgid-v6-2-v2-1-9c70ee2a4113@kernel.org>
In-Reply-To: <20230103-fstests-setgid-v6-2-v2-1-9c70ee2a4113@kernel.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 4 Jan 2023 11:53:56 +0100
Message-ID: <CAJfpegvbcQ6QTJuAW8CRGd7Zm_K4nvQCixJgD-VkcNU3d7b4Qw@mail.gmail.com>
Subject: Re: [PATCH v2] generic: update setgid tests
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Zorro Lang <zlang@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 4 Jan 2023 at 11:09, Christian Brauner <brauner@kernel.org> wrote:
>
> Over mutiple kernel releases we have reworked setgid inheritance
> significantly due to long-standing security issues, security issues that
> were reintroduced after they were fixed, and the subtle and difficult
> inheritance rules that plagued individual filesystems. We have lifted
> setgid inheritance into the VFS proper in earlier patches. Starting with
> kernel v6.2 we have made setgid inheritance consistent between the write
> and setattr (ch{mod,own}) paths.
>
> The gist of the requirement is that in order to inherit the setgid bit
> the user needs to be in the group of the file or have CAP_FSETID in
> their user namespace. Otherwise the setgid bit will be dropped
> irregardless of the file's executability. Change the tests accordingly
> and annotate them with the commits that changed the behavior.
>
> Note, that only with v6.2 setgid inheritance works correctly for
> overlayfs in the write path. Before this the setgid bit was always
> retained.

Shouldn't the test ignore sgid without group execute instead?   It's
not a security issue and expecting a certain value is not going to
help find real issues (e.g. in old distro kernels, where this test
will now start failing).

Yeah, doing that is more involved, but I do believe that it would be
the right way to go.

Thanks,
Miklos
