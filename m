Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBF36ED6A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 23:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjDXVR0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 17:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDXVRZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:17:25 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF8840FB;
        Mon, 24 Apr 2023 14:17:24 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b73203e0aso31025535b3a.1;
        Mon, 24 Apr 2023 14:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682371043; x=1684963043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IQmgFRWemEvXJC88T/rDku0y6B5K+c+6E1l1xk0hYI=;
        b=h8yqfVmnsIsaOgvfBMfP0TfIF8rf0Dt0iGWSoJ5hqw0IM/Nes78I2QLmPVreVrQ00b
         iXv+uSHM4guXlcbktd8ejSXbIVhL27z1tOKY2+jiI5kLCvr/LzFEASO+VDDR9oM8lvjm
         3pO3gfXvWCUMYtyOIG0SCXiNIv8mfz22kBS9z3bcOUZetecWnhB/UaCtYzVU5izrOOLf
         RTGTpDLEvq7OdOMY+HkCejVxtRZF3XnVnMadlmZ0YgpcykE4a/negmZAHhTWyDcrfYdv
         9vEykl+NyaYGSpXYpuFV0FH5y5U628FesWSTx3IFrbKl4FfE2z5TNwU6SYMoRl5kqGIx
         /2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682371043; x=1684963043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IQmgFRWemEvXJC88T/rDku0y6B5K+c+6E1l1xk0hYI=;
        b=lUqxiEuIaIl0lrOgVaqMya0QMGS+Z+zgxFbmFCWEKpE9yWJDscP9Ayx3FFmI+nM+4M
         z+IgESSNRJtAWqkZSAlfIHHntR3KtNTE0xx+uE+J6jd0e0HlrDC5G42ugbGW6XR70yAY
         CVJfNj+cvuVd5lq4Ne9NjSoJ9luAbB93F9ibYqCgcXwOdGYb7Dy2tylIItYpJMcVvt/W
         yTb/BEe2jZxb9eNBxxi/IQpsSPE8DM2eXHjHUYP1TGOFKN2N5OnI9TfIKQVGS0zeUkHd
         eH1iwq2qb5b3wk1HNBPjgGNRdTmy5FdyMNqjcLSkJn0SeIjMDPQ3Ytszw2/eRbchRuqi
         6T/w==
X-Gm-Message-State: AAQBX9cJj5pke9Mpp3tA231Z+xcNjTv/Q8lLY0JkFEa0Bp3P5r0TvD8U
        UIG3InAAeJl1sXogdSdr9K89xGg0lES2oisSFU4=
X-Google-Smtp-Source: AKy350YdosoMK29+Sw0J+vSpOOdKm+Y6k32RQnY43Hcu+sK/jdkLswUFO7t02Rwt6i53F7WTakMbOvGEF6qngQP/Gdc=
X-Received: by 2002:a17:90b:1106:b0:247:5c00:10 with SMTP id
 gi6-20020a17090b110600b002475c000010mr21067746pjb.2.1682371043441; Mon, 24
 Apr 2023 14:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230421214400.2836131-1-mcgrof@kernel.org> <20230421214400.2836131-3-mcgrof@kernel.org>
 <ZEMRbcHSQqyek8Ov@casper.infradead.org> <ZENO4vZzmN8lJocK@bombadil.infradead.org>
In-Reply-To: <ZENO4vZzmN8lJocK@bombadil.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 24 Apr 2023 14:17:12 -0700
Message-ID: <CAHbLzkoEAJhz8GG91MSM9+wCYVqseSFzBQdVAP78W5WPq26GHQ@mail.gmail.com>
Subject: Re: [RFC 2/8] shmem: convert to use folio_test_hwpoison()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, hughd@google.com,
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

On Fri, Apr 21, 2023 at 8:05=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> On Fri, Apr 21, 2023 at 11:42:53PM +0100, Matthew Wilcox wrote:
> > On Fri, Apr 21, 2023 at 02:43:54PM -0700, Luis Chamberlain wrote:
> > > The PageHWPoison() call can be converted over to the respective folio=
 call
> > > folio_test_hwpoison(). This introduces no functional changes.
> >
> > Um, no.  Nobody should use folio_test_hwpoison(), it's a nonsense.
> >
> > Individual pages are hwpoisoned.  You're only testing the head page
> > if you use folio_test_hwpoison().  There's folio_has_hwpoisoned() to
> > test if _any_ page in the folio is poisoned.  But blindly converting
> > PageHWPoison to folio_test_hwpoison() is wrong.
>
> Thanks! I don't see folio_has_hwpoisoned() though.

We do have PageHasHWPoisoned(), which indicates at least one subpage
is hwpoisoned in the huge page.

You may need to add a folio variant.

>
>   Luis
>
