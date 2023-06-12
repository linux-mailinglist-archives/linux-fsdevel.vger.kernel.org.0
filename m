Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B1472B82B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 08:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbjFLGjj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 02:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFLGjg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 02:39:36 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465531708;
        Sun, 11 Jun 2023 23:34:36 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-43b1c483c39so1444514137.2;
        Sun, 11 Jun 2023 23:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686551536; x=1689143536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KP3Pjx93vXIFN83dx/ceEF3t7U3VTCBctTN3DgUC6Os=;
        b=DnMaOUcqFzalQvVamUt5hdY4LTKzNOvEYTKLk1MIQ+v/2qKxYlLeCOuJt4POhznmfL
         kAxAnDMOkcH/hk+58I6v4b7olUD1cfivqinWH1dOTrU1W9bS9MddwU1FGjB7CE/ec1Gb
         1ITO1eM4SfOwDNiOaj99RId+VKnBz8iR6N8kXjx3aMHAD4N4zWuz7O9Wi5cjwRpxHuJK
         Mm6ZGZ+oxy0ScJiQ1klD68bC9VTGyRcupLMcttsuHgZPm0B5FLDRQh92EdpZtHDMyPAk
         DTv02GxlsoWZLzF4KDqyt7gYpiAYvZOdDuuOz9gC8lyhoO8o4ktRBMDF5W0tJtFSmAJE
         MMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686551536; x=1689143536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KP3Pjx93vXIFN83dx/ceEF3t7U3VTCBctTN3DgUC6Os=;
        b=jXG9ZJSI5SEYniX+JdjAIiNBXxrFsB9VbyOmZT7TiRl+/L14pOlU26X2Xr/PxKUtut
         BupCATCL+DedUqpCNP4YSK/kBm5T0PlqTSXbxJwwgeEse7lPxy2I49UqT6yCskvlRDru
         8soxGIlVxyXApO9L8lJmrYLl1PjCdJuc0opT873q0pCCSMSgCG8by3yKIDYXfbmU3DPR
         O/occ8giEDjczygQKgGTl2Z3gnB2R2QpFM3BUZfHg16aYRdAnPkXAVkiJEbD8ewpPBNG
         2vAapDfJXM5XF7ztNfE4p7HjIk8YXoy5jvi/6MMuz4hMt0+noAeYwHbKHdh1B2ZCFUcc
         NeyA==
X-Gm-Message-State: AC+VfDw4B1BT4UPDWedfrgPBrXOUMoV2F0BgsNU0CUOfF7pdBExEzoMH
        UcuwZPRxTU5vDYm7crnEd4Rg1A90VGz8vWpI3+4=
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
