Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9851D75CA8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 16:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjGUOuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 10:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjGUOuL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:50:11 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E758121;
        Fri, 21 Jul 2023 07:50:10 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-78362f57500so82639339f.3;
        Fri, 21 Jul 2023 07:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689951009; x=1690555809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/8OU9nD+IEREkyQ5osWmr6BhwzoAr61328Brf7SVP4=;
        b=epf/EKYEjv8/Tmn1kAa4qxASe+g+4XH5EcGPt6FatDi5YyhhHpxbn3uCNmAQo2fBnY
         gFsJIuy0cgUZIkjzkoNs/rgs4vpWEIEb7+QRG+BmCMuy8pBHshd7tTZ+njl56vR5bphm
         mvjiic2q8wIhpX+uQh4tE2GAEY+DQ+eUZkuugSabxdf75zXo5DfTuJ5y84H+Qpu38VSO
         vJoRrKY03RmY/Uk8WX8hKQI0LvxZYsyyR+wQz4wtryl98KH3nZmEXM/IXJRZZ4wb8ccc
         ctrUazfTlmkGS/dCgdabHOXJcoN22Q0xaMdxvkcflPJDzdwrXpxo0wJ7504HQdju9CY2
         h90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689951009; x=1690555809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/8OU9nD+IEREkyQ5osWmr6BhwzoAr61328Brf7SVP4=;
        b=gabHZHxORODrs7+psVDbBUlTm80BVhtQmAOD7owp/Q18zX+4TTrYT5KwAxOZPVK/ii
         zZwtzdIA9uF0i6v8Lcj/YYQlTmiqeF17/xBSHXO6xS6pFIV3vwEuCxQr8fPJqdMct3Vn
         mdwWkJM35H2JwIQrVAji8f4AldV6QZAkz5IQPll9ztMlIom5QNDSgkpLOA+rwU5jTmez
         FsahYFqALJWJN9O2rEtUkqFSnr5O281ZriKb51u0jAuPek4SPhpQTwO13IJiEtIZvAzB
         RLPBeNAFmHEnukbil8xrqBCCWMslzy7c3DWW0uPSqVKkRh6O9s3hlXTthM9uGDhWJgFy
         etEg==
X-Gm-Message-State: ABy/qLYp5JBrT7vg+8cPJ0X7Pk80petQctMbduFwtayqVlqfeU6qMCff
        Z0J7LY/WGhicyMxnEjcGHRtGXBQd0M+i1XWIIYc=
X-Google-Smtp-Source: APBJJlEQMmH+GgzPxmVvqjhwqKJ85g0HrjwwfdmBSLQlmfbSR4x9YrjoNu3u0B2YULqVgNXIWHDdcAUbxc6M0pVA1cQ=
X-Received: by 2002:a6b:f00a:0:b0:786:463b:2ceb with SMTP id
 w10-20020a6bf00a000000b00786463b2cebmr228899ioc.11.1689951009297; Fri, 21 Jul
 2023 07:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230713101415.108875-6-usama.anjum@collabora.com>
 <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
 <e430ea5c-fbf2-9e23-626d-2e6ea63eba18@collabora.com>
In-Reply-To: <e430ea5c-fbf2-9e23-626d-2e6ea63eba18@collabora.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Fri, 21 Jul 2023 07:49:58 -0700
Message-ID: <CANaxB-y6KhdKLHFCw-Vrz+fVkgdboCv7ZKyYGAs7VXA0aFuu8A@mail.gmail.com>
Subject: Re: fs/proc/task_mmu: Implement IOCTL for efficient page table scanning
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
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
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 20, 2023 at 9:27=E2=80=AFPM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Thank you Micha=C5=82.
>
> On 7/21/23 12:28=E2=80=AFAM, Micha=C5=82 Miros=C5=82aw wrote:
> >   b. rename match "flags" to 'page categories' everywhere - this makes
> >       it easier to differentiate the ioctl()s categorisation of pages
> >       from struct page flags;
> >   c. change {required + excluded} to {inverted + required}. This was
> >       rejected before, but I'd like to illustrate the difference.
> >       Old interface can be translated to the new by:
> >               categories_inverted =3D excluded_mask
> >               categories_mask =3D required_mask | excluded_mask
> >               categories_anyof_mask =3D anyof_mask
> >       The new way allows filtering by: A & (B | !C)
> >               categories_inverted =3D C
> >               categories_mask =3D A
> >               categories_anyof_mask =3D B | C
> Andrei and Danylo,
>
> Are you okay with these masks? It were you two who had proposed these.

I am okay.

>
>
> --
> BR,
> Muhammad Usama Anjum
