Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F0B6ED84B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 01:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjDXXFq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 19:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjDXXFp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 19:05:45 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE24393E6;
        Mon, 24 Apr 2023 16:05:44 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2478485fd76so3539788a91.2;
        Mon, 24 Apr 2023 16:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682377544; x=1684969544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQ8sFzZ9vlAXommM0w2/PXvGSOKBNi6JzIA9K33bVAU=;
        b=WD+ceziX6bq4nghbfbXLNklOmtmN9i6mL4/A14bPp9VINUyoFGGw8A0p3dQ34YR+WV
         V9UR0Cc1hxLra/AnBrIM2gSUcmRFtrM5vgBmxBXyH5v7k/iTTDcarBsO+NVHuUmNRLqk
         dSPFhIKxc3ozN6inFnMIifOSp0RHJ/2bfCVGkAJqyAaWeKXijbsqYI4AwyageV940smm
         vD8mw7+iTiazzzJQjSbKJtwtb48sO7QbkT+1hYFzC/8SxrZf/CzoX0kZPwM3nS41A+6/
         q+e/CJ8lPeZJCI19Jmmuvmazx2ljqsBXJIf6qkom4c4wGxwyamVIDb5oE81/KJI0NGbi
         vljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682377544; x=1684969544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQ8sFzZ9vlAXommM0w2/PXvGSOKBNi6JzIA9K33bVAU=;
        b=L/9LOQi4DBAyEho/2CVm3H+08wddazlRfGzRcaqU84uswt9BXSdtKk1i4wHcrSmGbD
         w1j5pS+z3mQxflev2ipqPE+jCDq/AQ+wR/tJiK4nyuxveiHCsHcgGImSoP9r/KfPDiw3
         U3Mtdb9d0OwgqUUEZ0tq7B+AhmHS4uN1JwLvmyM3rve1eyCBnslZiKCRfEUDqXFxQOGi
         3whQDwq2u0oSkjQplvxNGIAnSNi7MJdTAhdlCqtmAEjkG02wxwbuS22Vujj8hBHSFZRt
         su7mgX7jEWPnK6d3I0SRdW4P1dpsHRLGcTJjfFcZCwTHW7TT7T38kMJwWURBaByrlySP
         Wuyg==
X-Gm-Message-State: AAQBX9c47wHNYsVAaTSSqnLLcAEMDjQlRq5dfsw6Yt6vQrmgPvcnIRxQ
        oyRxyYnXmBfVzU6rCLhuHAxL2yYiIliF/ZaCIKs=
X-Google-Smtp-Source: AKy350YiJuL4duFP78n+ItNB+lUpN4w+zRdMWcrBiJgXD2Qk753AS4CLImpFJFw1UHLIr+HVloJCI3jyLWK4zIDEzVY=
X-Received: by 2002:a17:90a:fd17:b0:247:1de8:8263 with SMTP id
 cv23-20020a17090afd1700b002471de88263mr16233416pjb.4.1682377544182; Mon, 24
 Apr 2023 16:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230421214400.2836131-1-mcgrof@kernel.org> <20230421214400.2836131-3-mcgrof@kernel.org>
 <ZEMRbcHSQqyek8Ov@casper.infradead.org> <ZENO4vZzmN8lJocK@bombadil.infradead.org>
 <CAHbLzkoEAJhz8GG91MSM9+wCYVqseSFzBQdVAP78W5WPq26GHQ@mail.gmail.com> <ZEb2eYX5btfLrUtQ@casper.infradead.org>
In-Reply-To: <ZEb2eYX5btfLrUtQ@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 24 Apr 2023 16:05:32 -0700
Message-ID: <CAHbLzkqk2+woBTHEdkYcae6No40S6QXFPQk6hE+_C=7UHbe+Zg@mail.gmail.com>
Subject: Re: [RFC 2/8] shmem: convert to use folio_test_hwpoison()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, hughd@google.com,
        akpm@linux-foundation.org, brauner@kernel.org, djwong@kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, hare@suse.de, kbusch@kernel.org,
        patches@lists.linux.dev, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 24, 2023 at 2:37=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Apr 24, 2023 at 02:17:12PM -0700, Yang Shi wrote:
> > On Fri, Apr 21, 2023 at 8:05=E2=80=AFPM Luis Chamberlain <mcgrof@kernel=
.org> wrote:
> > >
> > > On Fri, Apr 21, 2023 at 11:42:53PM +0100, Matthew Wilcox wrote:
> > > > On Fri, Apr 21, 2023 at 02:43:54PM -0700, Luis Chamberlain wrote:
> > > > > The PageHWPoison() call can be converted over to the respective f=
olio call
> > > > > folio_test_hwpoison(). This introduces no functional changes.
> > > >
> > > > Um, no.  Nobody should use folio_test_hwpoison(), it's a nonsense.
> > > >
> > > > Individual pages are hwpoisoned.  You're only testing the head page
> > > > if you use folio_test_hwpoison().  There's folio_has_hwpoisoned() t=
o
> > > > test if _any_ page in the folio is poisoned.  But blindly convertin=
g
> > > > PageHWPoison to folio_test_hwpoison() is wrong.
> > >
> > > Thanks! I don't see folio_has_hwpoisoned() though.
> >
> > We do have PageHasHWPoisoned(), which indicates at least one subpage
> > is hwpoisoned in the huge page.
> >
> > You may need to add a folio variant.
>
> PAGEFLAG(HasHWPoisoned, has_hwpoisoned, PF_SECOND)
>         TESTSCFLAG(HasHWPoisoned, has_hwpoisoned, PF_SECOND)
>
> That generates folio_has_hwpoisoned() along with
> folio_set_has_hwpoisoned(), folio_clear_has_hwpoisoned(),
> folio_test_set_has_hwpoisoned() and folio_test_clear_has_hwpoisoned().

Oh, yeah, I missed that part. Thanks.
