Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DACE65DCF4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 20:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbjADTjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 14:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240169AbjADTjA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:39:00 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B053FCA7
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jan 2023 11:38:41 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r26so44837499edc.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jan 2023 11:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DJsUcUEbvQoaJWGljNIOUTh0wsOJmkDnnEUSKMNbbrk=;
        b=EmMHVLyQ8/JNAwCMkNodPDHq7o355xLQjGuZ8td1NJMBgbiRkeFAeaXkyL9rNb27jp
         I6XjcCMNvllnb2X0HpnPuKcnn9LJSG0cLMst3ow47wnNnYWgqw7+axz60zTCeGYjDsdX
         7sDAW3b+brpD0ziFYW7iqc31uQGu4lcAr/9RQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJsUcUEbvQoaJWGljNIOUTh0wsOJmkDnnEUSKMNbbrk=;
        b=fLzmxuNjNQ/zYh4AcWI2X1pJmdjiBctgavN6WBl3Gzj1HiEp6AEGu9CnfypBbM8Ii9
         D45dsxp7EF6FoL598XHKD8PYvtUQiQN6qc6nNdwnxBgPtbUK0fVRPsw1cRSNuJOvslNg
         MQCahacmrhFZDpoMTLZeu+U5cRB+cvOfab6Z1wffWtjYFmE6NES5rkiaE5dLc1SqoQGJ
         UTKDJWqC8ClxnpJfJvKV1JATkeInytJhZA5BF9hIBsRWaGoc1YjgaOK+atZ85Eoa8EWK
         mNO4skfMe8B3vt8onPR3U8bBXxDW3YF5/qUHk9kZpbpsnfKR8ugwYTN/NKKz51FrmVaA
         9Dog==
X-Gm-Message-State: AFqh2kqG+KYyISqX2+BUR424Y2UpkSO3VPkJ82uzbOyqWHWyrIczCY18
        nVHKGYrDEt+NDfCxIuFHSQsmUIbYRPSHSbLF6o9hhg==
X-Google-Smtp-Source: AMrXdXsbu6cEsmIhUMLkEPwUVvysp9pQo74U4SaRNWvUl+KExJD8JsY1ooAOjcXB+TN5RLbT5BPCto29t12C4zE81b4=
X-Received: by 2002:a05:6402:2292:b0:488:907c:68d4 with SMTP id
 cw18-20020a056402229200b00488907c68d4mr2923186edb.185.1672861119934; Wed, 04
 Jan 2023 11:38:39 -0800 (PST)
MIME-Version: 1.0
References: <20230103-fstests-setgid-v6-2-v2-1-9c70ee2a4113@kernel.org>
 <CAJfpegvbcQ6QTJuAW8CRGd7Zm_K4nvQCixJgD-VkcNU3d7b4Qw@mail.gmail.com> <20230104125913.ziqie73mc7paiz32@wittgenstein>
In-Reply-To: <20230104125913.ziqie73mc7paiz32@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 4 Jan 2023 20:38:29 +0100
Message-ID: <CAJfpegtJaLzQ_-wUBaCLmctJ8wGQvv0Gq=8OUV6Kfkh6EjFoDg@mail.gmail.com>
Subject: Re: [PATCH v2] generic: update setgid tests
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Zorro Lang <zlang@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 4 Jan 2023 at 13:59, Christian Brauner <brauner@kernel.org> wrote:
>
> On Wed, Jan 04, 2023 at 11:53:56AM +0100, Miklos Szeredi wrote:

> > Shouldn't the test ignore sgid without group execute instead?   It's
> > not a security issue and expecting a certain value is not going to
> > help find real issues (e.g. in old distro kernels, where this test
> > will now start failing).
>
> Yeah, I would be fine with just leaving the group-exec and all-exec
> tests 10 and 12 and dropping tests 9 and 11.
>
> >
> > Yeah, doing that is more involved, but I do believe that it would be
> > the right way to go.
>
> Just asking so I'm not missing a subtlety you're thinking of: why would
> this be more involved? Seems easier to me even.

Leaving out 9 and 11 would be a good start.  To be entirely consistent
tests 1 and 3 would need to be modified to ignore the sgid bit in the
result.  That would be the involved part.

Thanks,
Miklos
