Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6AD5323A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 09:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbiEXHHv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 03:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiEXHHt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 03:07:49 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6653B87227
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 00:07:47 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id jx22so19934287ejb.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 00:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TbmzqHnHKaEKiIDwuxbAGBPUkyBwUCwSvLomR0WvZ1A=;
        b=JcC6Jr6AXDFv1kQ9jVoFyyVX1bCtI3fFnt5nRAsuw+sIZmaz5Zrnd8dEFAptqDFPB3
         gycJ0eFpu2rdJgjLDZ+gMhvzReKcOP3JtaTuERD/jW84Fw6TPp1TaLratZOeRI1Hm19e
         NIET7L72/J7JQuRcRFmY9YhaN/Dj5MIrVdm4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TbmzqHnHKaEKiIDwuxbAGBPUkyBwUCwSvLomR0WvZ1A=;
        b=ns8zAQLa0tydFMXjeIfcLUDkQyBcTD1h29jUs43VPUosnsb4b/aQA8cDlzLVDrBr9F
         d2WquFcoSxdrC/A7NWnu4HX8yzlX3X2mjUll37fYxiEw/n1copBxgcpJ8yLWvsSZe8cq
         v5+mERtz7bn2hVS+v9cCVC8MbU3B//pu+LsDV36o7ZEG2JX6t/7jgndwVdRFN5sRwtg2
         T/lZyDbsTT2qHCfKcVI7Cr0/XNiloXhbfEFmlk6W9oWtWrqRnwPGz67PNNePz6ix+2TU
         LgdSTUCAhWvYnpuJ1bHbcNpknjWaMuAeA8uyGppy7Gb387GIrM++tKBzvi50L/hlmkMm
         R01Q==
X-Gm-Message-State: AOAM531V80V5HrUEd/1CqrfoMLLsWlg6VkVzCwpM1Fk+lF/666+X1O9/
        /VOocRWnkl11b5dEhKPvTuDuOMj72+RvEykpioc9YX75nE+KvSLP
X-Google-Smtp-Source: ABdhPJyuSKv66HMWwA8N9qnr58M68UlPUnI2v9pKk/izdXv/ESj4oWSXz93v9Qg/WorpEtCU4X2VCjVTi2O9Bnj7qWo=
X-Received: by 2002:a17:907:c1e:b0:6ff:8ae:3bc3 with SMTP id
 ga30-20020a1709070c1e00b006ff08ae3bc3mr307497ejc.748.1653376065977; Tue, 24
 May 2022 00:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211111221142.4096653-1-davemarchevsky@fb.com>
 <20211112101307.iqf3nhxgchf2u2i3@wittgenstein> <0515c3c8-c9e3-25dd-4b49-bb8e19c76f0d@fb.com>
 <CAJfpegtBuULgvqSkOP==HV3_cU2KuvnywLWvmMTGUihRnDcJmQ@mail.gmail.com>
 <d6f632bc-c321-488d-f50e-749d641786d6@fb.com> <20220518112229.s5nalbyd523nxxru@wittgenstein>
 <CAJfpegtNKbOzu0F=-k_ovxrAOYsOBk91e3v6GPgpfYYjsAM5xw@mail.gmail.com>
 <CAEf4BzaNjPMgBWuRH_me=+Gp6_nmuwyY7L-wiGFs6G=5A=fQ4g@mail.gmail.com>
 <20220519085919.yqj2hvlzg7gpzby3@wittgenstein> <CAEf4BzY5en_O9NtKUB=1uHkGdHLSo_FqddUkokh7pcEWAQ2omw@mail.gmail.com>
In-Reply-To: <CAEf4BzY5en_O9NtKUB=1uHkGdHLSo_FqddUkokh7pcEWAQ2omw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 24 May 2022 09:07:34 +0200
Message-ID: <CAJfpeguOHRtmWTuQfUT_Lb98ddiyzZcjk=D8WyyYA8i923-Lag@mail.gmail.com>
Subject: Re: [PATCH] fuse: allow CAP_SYS_ADMIN in root userns to access
 allow_other mount
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>,
        Rik van Riel <riel@surriel.com>,
        kernel-team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, Chris Mason <clm@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 24 May 2022 at 06:36, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> I still think that tools like perf being able to provide good tracing
> data is going to hurt due to this cautious rejection of access, but
> with Kconfig we at least give an option for users to opt out of it.
> WDYT?

I'd rather use a module option for this, always defaulting to off .
Then sysadmin then can choose to turn this protection off if
necessary. This would effectively be the same as "user_allow_other"
option in /etc/fuse.conf, which fusermount interprets but the kernel
doesn't.

Thanks,
Miklos
