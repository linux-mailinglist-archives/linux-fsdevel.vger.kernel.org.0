Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8438072B9B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 10:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjFLIFZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 04:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjFLIEm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:04:42 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FBA136;
        Mon, 12 Jun 2023 01:03:36 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-653436fcc1bso3285879b3a.2;
        Mon, 12 Jun 2023 01:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686556970; x=1689148970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KP3Pjx93vXIFN83dx/ceEF3t7U3VTCBctTN3DgUC6Os=;
        b=n1oC4CNtzIPKDUjh7tBeVDeehLK/Uy1MS9S181kz8kJqtJzD8myUQOHKMGtE7GUu3m
         UJMpSGQ6VkY7BPMqvDBG6z6LFv1o659COaxhns3LES/+Y+1zO42rURqW3IAS7Ed8tQIQ
         b01rInARivZtNFbuGw/ek++xcN+P7isUhKeZo+bzY1PGkObZSTOzx3LVwjzXvRaZw5Aq
         mBMCSKuFSiMvLSkbtm7bQKQV2r7mdQJcmuSECvX2dso1AfyA+GIgvUMh52YCVTUJqZ6W
         w9fKrHWTi3oX1LxUcLlwRLY50YiFXszqMbu2EjCTFr4LZ0j/a68XthzOhHQcyYlxVfbL
         4Hbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686556970; x=1689148970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KP3Pjx93vXIFN83dx/ceEF3t7U3VTCBctTN3DgUC6Os=;
        b=JqKbX6miX+k2+Cmv3/6vu2k0WEiBnqKGwVtz3PMXYPKLm5TmRLeEby5CZNdBLoSIfx
         KhZvb6COdLSGdDn9wN+GCNxaqZLcWSKHQ1zWo/nMMr4egcYMmkrPeaIdU6/jWSMA2Ehr
         Z0yLGot7YAz+isfgpqhE4TKj+Ou8uU2dVvPQs5OLlEHtjR3Ctjwn5bPNbNZEdc2Jkbtp
         c0dMeBBcVJDkXo6HoQFuZxC4IjOLQiUVB5mIBnW4vC1aft7HmLQtzMonxY/LtnUbIv1R
         TwRN9drbwvhMxfH97akXcWsmnoJLv49aQz8TVZe7At1oAo+/+JG97bZmZ71nl3UZCgJ8
         DF3Q==
X-Gm-Message-State: AC+VfDzEqMjdvj9MpgWOy7us2bhG0yejfKGgyFSEe6oRqMAZRXVpIuNb
        ac2rNjUxY0TjjkwyhzbytmCTYTRtCleT7rw61vrd+VKC8hw=
X-Google-Smtp-Source: ACHHUZ5vqYcmwNKLSkCtKR8AtyZXy7vcX3GpuEsItccHgwEuoJlqH333DdyFDblRuEy+G91/HsGmq+h6Z2m6L/oM0BE=
X-Received: by 2002:a67:f646:0:b0:43b:554e:fce8 with SMTP id
 u6-20020a67f646000000b0043b554efce8mr3736335vso.19.1686551536461; Sun, 11 Jun
 2023 23:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230611132732.1502040-1-amir73il@gmail.com> <20230611132732.1502040-2-amir73il@gmail.com>
 <ZIaelQAs0EjPw4TR@infradead.org> <CAOQ4uxhNtnzpxUzfxjCJ3_7afCG1ye-pHViHjGi8asXTR_Cm3w@mail.gmail.com>
 <ZIa3DfH9D0BIBf8G@infradead.org>
In-Reply-To: <ZIa3DfH9D0BIBf8G@infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 12 Jun 2023 09:32:05 +0300
Message-ID: <CAOQ4uxgQc3DivjAQNYhpDRZ5PA-wH1wSenoLkzYmFatueGJwUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fs: rename FMODE_NOACCOUNT to FMODE_INTERNAL
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        David Howells <dhowells@redhat.com>
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

On Mon, Jun 12, 2023 at 9:11=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Jun 12, 2023 at 09:08:37AM +0300, Amir Goldstein wrote:
> > Well, I am not sure if FMODE_FAKE_PATH in v3 is a better name,
> > because you did rightfully say that "fake path" is not that descriptive=
,
> > but I will think of a better way to describe "fake path" and match the
> > flag to the file container name.
>
> I suspect the just claling it out what it is and naming it
> FMODE_OVERLAYFS might be a good idea.  We'd just need to make sure not
> to set it for the cachefiles use case, which is probably a good idea
> anyway.

Agree to both.
As I told Christian, I was reluctant to use the last available flag bit
(although you did free up a couple of flags:)), but making
FMODE_OVERLAYFS overlayfs only and keeping cachefiles with
FMODE_NOACCOUNT would be the cleaner thing to do.

Thanks,
Amir.
