Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2662972B888
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 09:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjFLHWN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 03:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjFLHWM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:22:12 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D37DBD;
        Mon, 12 Jun 2023 00:17:12 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-bcde2b13fe2so153018276.3;
        Mon, 12 Jun 2023 00:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686553988; x=1689145988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KP3Pjx93vXIFN83dx/ceEF3t7U3VTCBctTN3DgUC6Os=;
        b=QPkmu44uhcFrq7PjbGVnTWTcJ02ukrNApuO+HJ8L40NXSpKl67GWTPSRRpcOflFzQ9
         B6kWiRGoG7a4NwRJmjB6qEllnsHsClwmfn3JDao2gwrClX4JopNxQqNOX7PKXgGUhmsg
         8IArxNaZUk74oSRY7Ub15k6NI8pj+3YVL06w51FdaO3bjAtT6rcxyYoRaR1WcnEfnr4l
         q0n5kLeaj7Xa6q2ZyH0fhrXtLwbnmELjf0eYnhQrnkid4YuxpXcRwFcADxzihhmiwLw0
         3JESJTByiqxTYSOBH2kcBfnhEJ5kCFPhYgb4z/1AZjAn/uJZVsOeXMMi2ZnETtRKhnMl
         kwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686553988; x=1689145988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KP3Pjx93vXIFN83dx/ceEF3t7U3VTCBctTN3DgUC6Os=;
        b=FqD3PXkEYfMyaJzfWkzAvDCKRSI+iVYDez0vQZy2REPn3pTwVtH3O27LAtKHgGL/Tc
         HvRFW+sFGDZOvNEhqgwyzXNpE74qmgZNzB/Yhjx7pq9kbdEN4HpuqAb/y1scqwS+D0JN
         ZzEyim0v+J1exJeixgiQ9bLbAOS8KYsJTE9b6vQsiHW9DDaAv/wXiMEO5wmhuMV32etJ
         kurnbzsFHM6rQrXouiNjCF6QiheQ/YF+g7QIsonMNKUFu5ImBoV6KGKkx7PBlP6qtV8T
         E5raL62Jf2h93xBj00RDJp3EInDeV6eFWxmLOiz+yuzxlYrapaRQhz4VrlTUWzKCucMY
         cAdQ==
X-Gm-Message-State: AC+VfDxF9ztHrlLYOvR58axC3aUkWrNroXsbuCkxzc+e/Gj+8ImZidmO
        UNNFMZ6OaLGRV9bx8Kvge5j1RRVc0x54Z4sNB4cwBv7pb2g=
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
