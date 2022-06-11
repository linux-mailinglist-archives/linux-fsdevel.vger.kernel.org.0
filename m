Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517BB5473FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jun 2022 12:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiFKK4O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jun 2022 06:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiFKK4M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jun 2022 06:56:12 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110AC72E3E;
        Sat, 11 Jun 2022 03:56:12 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-30ce6492a60so12665817b3.8;
        Sat, 11 Jun 2022 03:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eqA6H/Kd3v8qLCIvaYprcutQG+OhOEiZYNUR3mtKR8g=;
        b=InFhqVRk/HMI49qxhWCdNY0P1XE0wEpBRC5azFWGcNn7x4HbOqxHc6oFfgHf6xc7ja
         ANUONPNb6l35CdrdMuoFZUtnLBuqDAGpQT+yrn0L+ezkWBq20mM6CxFRdxvZtKpWqlxm
         +JYolldNIWCvjuh+pqbUdoF/r7eMtqzYIATebPuntniMgYiwEgY68cssFw1CO/4kX0G2
         t+JZp25P706XCw63jlQzvshJt6/5Hvyo95tqAvRjnluQP34WC+v4AZlUvg6DjA04SzPH
         N1MoptCK0shoroPvLCx0hKetpvhfX1//r8LuC3fcLYPE/2wrXCtTt/G+j6mhH4DQt/+f
         wNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eqA6H/Kd3v8qLCIvaYprcutQG+OhOEiZYNUR3mtKR8g=;
        b=3vfpVCbHHiSX+J88XPDxrrhX7ta0MS/+tJB8vREeqJrBCtn+wJ1bJ17fhfVTc3JlRe
         zrQIs1xRrg/AcHFpQtc+jJRJYIXbxcE7ga+tLxn7pUsbKI/mwRxD8VJa34zZDsuTSrob
         UlBcV2AOahmoxOKEz8H+ZUPscbJUh9vy3ZIyuRUuICfhbEgZAKkM90QAFtiUNH9bwGBE
         5wEo4HZw+nBCMtV21gRepkdnpMlkWBWkJvPoxczB5oqJgQb7gJYCp6hkk+uWLr1pLbCA
         d0E/W7eWmKppZEmhnrQbozLdypznZdsUeET1hkPCf3A6XjJf3kZXak4EJVlNu7tlnZO8
         FL1A==
X-Gm-Message-State: AOAM5320UxPMz5UAAqW8A92xH06UYghfN2UCRbD7vkyrE4NF7jx/pNOq
        N0CkA+3emqGngwBX5bS097sPI/BZkAlFC3nLpY4=
X-Google-Smtp-Source: ABdhPJzMPaMP2VjmabTBvuNSAp2tyI0KZoHPUC4tMzTy1Au1VZoxjK59G/T3tyeKHoUGM5JYj+tYJXEMmKiGGgUt7c8=
X-Received: by 2002:a81:25cc:0:b0:30f:ea57:af01 with SMTP id
 l195-20020a8125cc000000b0030fea57af01mr51233219ywl.488.1654944971327; Sat, 11
 Jun 2022 03:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <YqRyL2sIqQNDfky2@debian>
In-Reply-To: <YqRyL2sIqQNDfky2@debian>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sat, 11 Jun 2022 11:55:35 +0100
Message-ID: <CADVatmOKtwSbdGcis4+44-G=UEdHWfOE3M4SBu=25vvp0TWxEA@mail.gmail.com>
Subject: Re: mainline build failure due to 6c77676645ad ("iov_iter: Fix iter_xarray_get_pages{,_alloc}()")
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Gao Xiang <xiang@kernel.org>, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 11, 2022 at 11:45 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi All,
>
> The latest mainline kernel branch fails to build for "arm allmodconfig",
> "xtensa allmodconfig" and "csky allmodconfig" with the error:

missed adding "mips allmodconfig".



-- 
Regards
Sudip
