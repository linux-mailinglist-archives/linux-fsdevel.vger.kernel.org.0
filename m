Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A5D5861E7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 00:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238634AbiGaWtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jul 2022 18:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238044AbiGaWtA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jul 2022 18:49:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734516361;
        Sun, 31 Jul 2022 15:48:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27D91B80D8E;
        Sun, 31 Jul 2022 22:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4571C43143;
        Sun, 31 Jul 2022 22:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659307736;
        bh=YCJg1T5L2gtsSKvb29nkDzYmguDljGhTKqZBnXztbUw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Am8P842Jli/qcbYJs89BeLmGM+0KEazI51lMmVeQTymQyQ/qsNR8l7uHogirFLRSN
         AqOg1FODlAnbQVYyQKyRdPTaOeAheqAG8OpbqVMuTSH1yYOuUZ8UCo7Ip6Wke5eudw
         uqQ43uITBqRCnLuLeJQNV6UQdmgGjXmdXKrIYihIpvWR0LtNq3urzJNLx7jLIKKZko
         Kx9EG1R1MBYRZ8CjaFxPYQocuR+9sMvFHlWO2p3rUlgUfQlHx6Jl9fy3+Ic65VqJ3q
         ubmpEXC/a2czhHpCutQF18oc44H4UuDzvKeW8j+bHuWwaPfjf3c2ONdbj+ccmuQ9BJ
         B7peZhLRedv7Q==
Received: by mail-oi1-f169.google.com with SMTP id s204so11355058oif.5;
        Sun, 31 Jul 2022 15:48:56 -0700 (PDT)
X-Gm-Message-State: AJIora8lS6W/Og/Reg4hOVdmaBRf1Wh4NGaa/wnHdFx8uzEvgITHjK4r
        ahTmA0qsoxfH/zibfNghhAfbXdlrUR048+DOBbM=
X-Google-Smtp-Source: AGRyM1sZACQ9aAC+MFmBHszV8d/QH2iryi5ATw3k8c4+g+PJM4MKvLsh6n9mjA++xiKh+QoBgJFSHv8Yyl3KOd0htMY=
X-Received: by 2002:a05:6808:1489:b0:33a:861c:838e with SMTP id
 e9-20020a056808148900b0033a861c838emr5348286oiw.228.1659307735903; Sun, 31
 Jul 2022 15:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
 <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
 <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311641060.21350@file01.intranet.prod.int.rdu2.redhat.com>
 <Yub+vPb53zt6dDpn@casper.infradead.org> <CAMj1kXE-TpUGgFxBOaZbsF7k3rdHdjBoqoxZ1bvDz5AoTGADxQ@mail.gmail.com>
In-Reply-To: <CAMj1kXE-TpUGgFxBOaZbsF7k3rdHdjBoqoxZ1bvDz5AoTGADxQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 1 Aug 2022 00:48:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE2kYCn906qpvc7guK8BTNeEXsbCyTwiomaBqtbWfe_qg@mail.gmail.com>
Message-ID: <CAMj1kXE2kYCn906qpvc7guK8BTNeEXsbCyTwiomaBqtbWfe_qg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] make buffer_locked provide an acquire semantics
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 1 Aug 2022 at 00:31, Ard Biesheuvel <ardb@kernel.org> wrote:
>
...
>
> I was cc'ed only on patch #1 of your v3, so I'm not sure where this is
...

Apologies for causing confusion here by replying to [PATCH v3 2/2]
that I was not cc'ed on [PATCH v3 2/2], which is of course nonsense.
Gmail's threading gets a bit wonky sometimes, and the patch was
threaded under v2 as their subject lines are sufficiently similar, and
I assumed I was replying to v2.
