Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA1475FA2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 16:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjGXOt5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 10:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjGXOt4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:49:56 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6396210DE
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 07:49:54 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fc075d9994so112425e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 07:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690210193; x=1690814993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ki+X2Ujoc38+QWppbACpmptGeQ/z2af0rECZEbVAVFI=;
        b=CeE/SNaU1vmPj5FnneXPHb3jJH79djSajq+EiQCueGmehbzLPuqRKsrG8hiPBG6CxE
         G2ctKccmmtp7ajI2h6irptpIz3AmPV3ZFguG3NAHBWxF3/LEfOQW5X/IfAD69m6jqfJg
         JfwzuA6Ew1d2vToJEtoJqCdZ92mi3u8Y2q0B/sWnf0BmPBIyhK8A3gQ467OLfb/8I0Gq
         VUqB8BHwkz1iZ5ZIJq9IA0su5Y0AzBKgY6GU0fafP6X/OKdEj14uduMZnSOmSzWc34ed
         wfAMQX6RSc3TlLD61vSGtqZ4s/TrCqBhTn9zcNX8xgOOrgd1pZw24byr8us1nJJWltPF
         MkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690210193; x=1690814993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ki+X2Ujoc38+QWppbACpmptGeQ/z2af0rECZEbVAVFI=;
        b=CBlG9HEf3RLU0pinLpYsMKuhWs7JIrtgynoT8rCxh1+ZV77L031Z7RdobAyrbcC45F
         9qdZTEhwsB7A/X65I58pr6eReL6bW1TF7RhcJnav2adEHx2WN8ODJJA92/o2z+dmN4Wp
         0uF/vyslALmFOKdbP8vYPzJljdOTRW1b8Gcehm6iuQcdgqBrvDXtL/zLtanWRYgvXB7G
         FzDZstE7HOArvrJOhsPKkxOy3kJwR8n5ONJzcFmEd7Q6/Ty2+n+/fxffmdTSlQF92NtF
         Y4G9aZDhF1VacSHYmX6DylxSdwAZ/62/VFSyCG0NkgMPkgWWG1yCmOq5Nvg4i/kfcN61
         MZHw==
X-Gm-Message-State: ABy/qLYsarG38AmOXzsQ9Zf+v8toDSnVqyluocC3z3QeX6/VRl6dAozy
        Zk4bPNDL3tnCswUkGWIIfh4OfMdCeZoeGH7TsjlQLw==
X-Google-Smtp-Source: APBJJlF9uk3eSs5x3t+6WtqH14pUEUPIKuiZ2qGbirueqO/SURxmmVHB9Rog6hFQVOJAJnpxVQMqTOvWAXbIpUrca/w=
X-Received: by 2002:a05:600c:3ba7:b0:3f7:e4d8:2569 with SMTP id
 n39-20020a05600c3ba700b003f7e4d82569mr154278wms.5.1690210192726; Mon, 24 Jul
 2023 07:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230711202047.3818697-1-willy@infradead.org> <20230711202047.3818697-2-willy@infradead.org>
 <CAJuCfpGTRZO121fD0_nXi534D45+eOSUkCO7dcZe13jhkdfnSQ@mail.gmail.com> <ZLDCQHO4W1G7qKqv@casper.infradead.org>
In-Reply-To: <ZLDCQHO4W1G7qKqv@casper.infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 24 Jul 2023 16:49:16 +0200
Message-ID: <CAG48ez3bv2nWaVx7kGKcj2eQXRfq8LNOUXm8s1gNVDJJoLsprw@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] Revert "tcp: Use per-vma locking for receive zerocopy"
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 14, 2023 at 5:34=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
> On Thu, Jul 13, 2023 at 08:02:12PM -0700, Suren Baghdasaryan wrote:
> > On Tue, Jul 11, 2023 at 1:21=E2=80=AFPM Matthew Wilcox (Oracle)
> > <willy@infradead.org> wrote:
> > >
> > > This reverts commit 7a7f094635349a7d0314364ad50bdeb770b6df4f.
> >
> > nit: some explanation and SOB would be nice.
>
> Well, it can't be actually applied.  What needs to happen is that the
> networking people need to drop the commit from their tree.  Some review
> from the networking people would be helpful to be sure that I didn't
> break anything in my reworking of this patch to apply after my patches.

Are you saying you want them to revert it before it reaches mainline?
That commit landed in v6.5-rc1.
