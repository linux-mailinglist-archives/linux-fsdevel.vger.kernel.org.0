Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB17740398
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 20:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjF0Swp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 14:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjF0Swo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:52:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359E919A8
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 11:52:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51db8a4dc60so1314a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 11:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687891961; x=1690483961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrMUD+bzjYq5U/OlRQ46C95vvZ+AhNRjqJFLfHa8n58=;
        b=Lwjol0KzgSFyHrtVjCTTjkFPYma+RQF77JRbL0wBs9NJOySx0p1L2f3KoQOq2wtYew
         bTbS4LUyDDLndkY34CBSLWvRzEdphSFvMUqTZGeF54WZZxThj2qDyI+xzBCFM4pogR7W
         6bazPitMsZvcEA2YauBwiyijlOt2eO2AU6tgt0np1VbzJ0e1mNjUm9eEqWYW+z1kIExA
         Z01Z8niT6EkjqiZzq1atZgnkgvSbxGXUcTwbQbaWqN4xOUMT4xyf3shnyJrljigB3h2A
         KL/F/itIeavYuh/huelf/SLkHAf8a+Z3lf6f75s5Rw9smZoquAjZxv8gONeapQ66QuF+
         fv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687891961; x=1690483961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrMUD+bzjYq5U/OlRQ46C95vvZ+AhNRjqJFLfHa8n58=;
        b=PKTG3gU/MPIXYZBAlqgTJ9Ukfs6uaAg3UbS0OLkez1BWU1mNG74BfIzbYp+b092JJj
         ZWAR9CfYvCBuY1YsNSiPKh3kKioq5rLmJD7PMVCd3ZOlC0FsrEGpSEj0vfuckiTRnPys
         H4ZoIBadSj752jVgMz5Ys/bnCtKOSqbjdvaEy/0zEAz3yrtgM/Pyrn+SGm47PEI4CcKN
         huHvoUPbtvqAQTHgAY2AazusB2d4p1bV9GCEJKvqDKfX6lOTZpD0YHID4cVVhTDMdhYz
         chFM50vGKs1qswfolpzfE1ksWt5atchbfaDOkrGGSoX3PRTMzmO8Dq7qai/PMyU9IFE8
         q4zw==
X-Gm-Message-State: AC+VfDwaMoQ9vfTBu9g1WFcHmqmvQLyT8znlpT3FKUYkjyUupK2gdaZz
        tDzgDL8996sCycdlaF44Q3LTNlipatjmm48ZPY7KcA==
X-Google-Smtp-Source: ACHHUZ4NqtygUkoF7LzNQuMwk4m82VidiZ4IS+yy+S4o+fhpUQ0AL4Z3k4FCruDAhBmmEv8MVBz6pucYVp9kK7qXtpc=
X-Received: by 2002:a50:a6c3:0:b0:506:90c4:b63b with SMTP id
 f3-20020a50a6c3000000b0050690c4b63bmr12556edc.4.1687891961572; Tue, 27 Jun
 2023 11:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230626113156.1274521-1-usama.anjum@collabora.com>
 <20230626113156.1274521-3-usama.anjum@collabora.com> <ZJo/gOnTmwEQPLF8@gmail.com>
 <13ea54c0-25a3-285c-f47e-d6da11c91795@collabora.com>
In-Reply-To: <13ea54c0-25a3-285c-f47e-d6da11c91795@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Tue, 27 Jun 2023 20:52:30 +0200
Message-ID: <CABb0KFGn=3oAYa+wsf=iWr1Ss=en9+m11JOijEibXJLFDAkvjQ@mail.gmail.com>
Subject: Re: [PATCH v21 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Andrei Vagin <avagin@gmail.com>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
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

On Tue, 27 Jun 2023 at 11:00, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Hi Andrei and Michal,
>
> Lets resolve last two points. Please reply below.
>
> On 6/27/23 6:46=E2=80=AFAM, Andrei Vagin wrote:
[...]
> > And we need to report an address where it stopped scanning.
> > We can do that by adding zero length vector.
> I don't want to do multiplexing the ending address in vec. Can we add
> end_addr variable in struct pm_scan_arg to always return the ending addre=
ss?
>
> struct pm_scan_arg {
>         ...
>         _u64 end_addr;
> };

The idea to emit a zero-length entry for the end looks nice. This has
the disadvantage that we'd need to either reserve one entry for the
ending marker or stop the walk after the last entry is no longer
matching.

Another solution would be to rewrite 'start' and 'len'. The caller
would be forced to use non-const `pm_scan_arg`, but I expect the `vec`
pointer would normally be written anyway (unless using only a
statically-allocated buffer).
Also, if the 'len' is replaced with 'end' that would make the ioctl
easily restartable (just call again if start !=3D end).

Best Regards
Micha=C5=82 Miros=C5=82aw
