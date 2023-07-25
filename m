Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14027620F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 20:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjGYSF5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 14:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjGYSFw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:05:52 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0172689
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 11:05:45 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so1665a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 11:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690308344; x=1690913144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gBnT3Q9DJqSuXcP4CzN0zSoMTfKvs3KyiDNWzlI9V4=;
        b=IR7MPLRNrwqnMA6Taco+EOZJ6KtwnxWYXAWsiIpvLEpZ8GqzUUtArAD7xEuCO+mZv3
         aOiO+lW2JAnLZdb/Ck6lRn0BxAyt4qUSG4lQz26wvv5CawhHADRbfR8JdTkmZuqKWid3
         tQ4sxPrTLguBe5mOxWPkRgp5C+jQLB/QhL1zPzTMaIbs+8YY+xGjT6uCSOiuP+ShH/yh
         bghhKsbg4+YtihSsav+R2zhvOZpDN1YaMGxBsWq+BgWfdppwO7aEJnEB/IB6oySvNTZv
         PZ+ebPFJ7IFs6PMAwkdsvH388TRo5wF31MrlTWn+ckwpC0JHlIN/H20Q8pM/lztUD7CY
         vZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690308344; x=1690913144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gBnT3Q9DJqSuXcP4CzN0zSoMTfKvs3KyiDNWzlI9V4=;
        b=gydUhi78DYuW0Z9JqJSGE64AmvV00TRJXph7Z9bnp7qT2Y6g3XFwMknlhu1E0LYcMr
         ZyLt6hwR2Rb+Z76OZ+tK1hiVU8RNL89E4sXLz2GMn0alOp0Rij/KFX2K6nWpJf17PKZI
         ZtjLFtSF7VxCdKU6J6qMviLkTxnsjGeWTeXY3a8XTMfGeC/XeuCw+BUIqKAqQMfgznsf
         PY+SrKprpIhuVbzScgzgqJt1g8/vXpH2zRY0fhmKg08/2/mxFSEST22t3iZMd0xa+Nog
         b4CJpW5+ywNwKkJT24b3YLdM7famdWCfoM6ITSgfk1wOUUEjVJIlTcPiAzKV9cs8cHCe
         d0cQ==
X-Gm-Message-State: ABy/qLZXWxWR5pXHgS2KtkIp5+Luy+K/sJ9igdCWNf83aHyOnwYrYJAG
        fhaFjkpyJWdQBG+FHNg70Mnq7D5XBxc7xM+RSGh7mw==
X-Google-Smtp-Source: APBJJlFx5VS5SCJzOTClBE3oorb3CkqCx6mrIr5bXycpxVlMeBOxmxwx7XhBiLPrxEo29Ul0BYE36xYQQxmuCt7+gdA=
X-Received: by 2002:a50:d6de:0:b0:522:4741:d992 with SMTP id
 l30-20020a50d6de000000b005224741d992mr146970edj.4.1690308343974; Tue, 25 Jul
 2023 11:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230713101415.108875-6-usama.anjum@collabora.com>
 <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
 <7eedf953-7cf6-c342-8fa8-b7626d69ab63@collabora.com> <ZLpqzcyo2ZMXwtm4@qmqm.qmqm.pl>
 <382f4435-2088-08ce-20e9-bc1a15050861@collabora.com> <ZLshsAj5PbsEAHhP@qmqm.qmqm.pl>
 <b1071d62-5c8e-1b03-d919-b3a9db520e51@collabora.com> <CABb0KFF6M2_94Ect72zMtaRLBpOoHjHYJA-Ube3oQAh4cXSg5w@mail.gmail.com>
 <44eddc7d-fd68-1595-7e4f-e196abe37311@collabora.com> <CABb0KFHJVeEkh4f6WWK6FThCbA+NE8iYUZE68nV1YAxaHwiwog@mail.gmail.com>
 <e1ead2e8-046a-31d9-8df9-27cdd7b7ff83@collabora.com> <1afedab8-5929-61e5-b0da-9c70dc01c254@collabora.com>
 <eac29a4d-aa3f-4df5-97e6-4aa3a358f2b1@collabora.com>
In-Reply-To: <eac29a4d-aa3f-4df5-97e6-4aa3a358f2b1@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Tue, 25 Jul 2023 20:05:32 +0200
Message-ID: <CABb0KFHuNpG+NJQ4sQdp1n_Kf4sO8aC5DBEppFc1zz=zAeDfQw@mail.gmail.com>
Subject: Re: [v3] fs/proc/task_mmu: Implement IOCTL for efficient page table scanning
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 25 Jul 2023 at 11:11, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> ----
> Michal please post your thoughts before I post this as v26.
> ----
[...]

Looks ok - minor things below.

1. I'd change the _WPASYNC things to something better, if this can
also work with "normal" UFFD WP.

2. For the address tagging part I'd prefer someone who knows how this
is used take a look. We're ignoring the tag (but clear it on return in
->start) - so it doesn't matter for the ioctl() itself.

3. BTW, One of the uses is the GetWriteWatch and I wonder how it
behaves on HugeTLB (MEM_LARGE_PAGES allocation)? Shouldn't it return a
list of huge pages and write *lpdwGranularity =3D HPAGE_SIZE?

4. The docs and commit messages need some rewording due to the changes
in the API.

Other than that:

Reviewed-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
