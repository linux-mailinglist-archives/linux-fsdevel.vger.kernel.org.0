Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC39510525
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 19:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiDZRWT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 13:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiDZRWS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:22:18 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4F224595;
        Tue, 26 Apr 2022 10:19:09 -0700 (PDT)
Received: from mail-yb1-f180.google.com ([209.85.219.180]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1My6xz-1o5LQB2b5b-00zTZO; Tue, 26 Apr 2022 19:14:04 +0200
Received: by mail-yb1-f180.google.com with SMTP id w187so24764165ybe.2;
        Tue, 26 Apr 2022 10:14:04 -0700 (PDT)
X-Gm-Message-State: AOAM532TsqAt7Q/IPazDwjCS6R/JEhIcoPDVTsdC9pmcMcvx7ZCU6ZpG
        htWPz1fVoKBklr2XU7h8bs7g1Vq+5LHFp+nNr+A=
X-Google-Smtp-Source: ABdhPJy4qrzId24VdonwrFL8xdmT+OefZW9RIA7s/JBFmqDtK6o+FbcHdop/B8RF2jVsl9Z7YvDRgbjOS6bpOD7eSC0=
X-Received: by 2002:a25:d3c2:0:b0:645:74df:f43d with SMTP id
 e185-20020a25d3c2000000b0064574dff43dmr21550935ybf.394.1650993243035; Tue, 26
 Apr 2022 10:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220422212945.2227722-1-axelrasmussen@google.com>
 <20220422212945.2227722-3-axelrasmussen@google.com> <20220425203249.GA5814@altlinux.org>
 <CAJHvVchLSpbKXn6u451pjaRpW=SwbOFSdpQpaC47WBFa0660xw@mail.gmail.com>
In-Reply-To: <CAJHvVchLSpbKXn6u451pjaRpW=SwbOFSdpQpaC47WBFa0660xw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Apr 2022 19:13:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0th99KbPO_Mt17uztHay6vBMngT-ii2dFW4++BaAQNpw@mail.gmail.com>
Message-ID: <CAK8P3a0th99KbPO_Mt17uztHay6vBMngT-ii2dFW4++BaAQNpw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] userfaultfd: add /dev/userfaultfd for fine grained
 access control
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>,
        Linux API <linux-api@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+s8HFHdANqZQ0PHV/EC05dFnp+y9+zq7ZoknP0XSfx+gbj1UKdy
 qpd/5nWyjvrS+vcbvdCPyfrueeReCzfxkFwdSw8JbIqIinpDALZigP9yF6FY8L0US6P4aG6
 JncGfCJpshBqIUY+6ShHNRwX1J1a4eECU2ibabTL/29b2T58eMWnbdprNr/ARASn82mFmEZ
 NpD5ZuwRg6RsaYYS4ofTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0naR4d11Hho=:T/uCdg0IR3rEfMqak9PYUn
 zOE2qQ6wxT3yC1Vzz/WV6+QpsRIL4kY2AjBUzlYySiZYfc7/3EzGuhXLItGo2Kb3+ZY0PQJ42
 VZzF4UW2lGC6kFYmJQ+WMTF92+ENA7/y164+o+meFagCa9Fn+3NfQaRk56Ff8s/aU5GO/pUUY
 XUhCq+yZ6NRbJOECBFonYVkG4as7im20bcmzTs2BKsr4kAEpJliKOi9epmsYRokD6L2CjiE8d
 yS61e1Vk1sCee5j4oT/u8ALpEKUs2RP3gZBTnmv5tCTMLSTBkMu9pBuVuGY0y6MHycjgWc/PN
 uHi1N3tMZf7YOfPMn2JYI1VXxco6XyNWdV9ib5innyN67evnHCI/O89YecEzqrxGzB9DaMIia
 XVTrqoYIEbaOhFIHql7O9b1mZfjF1lk3uG+dhZ5P1tWdJiUB5FxIs0VNKuV1ZSo398jMz3LXK
 6Z0wb45FHbYHdMQdgedxRQHVH3meS08WJuTRh83gRWWN9dZufJBRln0JUglmMzousuSUWtyxp
 qWZD5lZ5YOR5LaahRVE8zvePLQ0H04a+NH5iJwuZfpXy5JC5bShdZDiusWs8SMv3vCMw3UbaQ
 UTZ65k1AyB7TOB1ZRre0Yf6y/7Lkqv1SHVZGbmDB8jXf01s2X/M/IhNxSjwMxHD7yKK8WFRlE
 OcYJk/vBipN4vr6bpdOkQaU1Qw5AuZsQjPzmRREMuC2INh75h6OZXoHKQqHZuG2mcab7bZYcg
 J55deikpHYsUgLz3xZl/sInGUID9zNUwLB/JyATNj4wE7JFKIKZXMaGK9tDEfponNtBCNdNZz
 axy2FU0aEnACFatxVhJPEuowBbHpsX3FBDxdbvVefIH0W64R4s=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 26, 2022 at 6:00 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> You're right, [1] says _IO is appropriate for ioctls which only take
> an integer argument. I'll send a v3 with this fix, although I might
> wait a bit for any other review comments before doing so. Thanks for
> taking a look!

If there are no other command codes, you could also set .compat_ioctl
to the same function pointer as .unlocked_ioctl, the compat_ptr_ioctl
conversion is only needed when there are commands that take a pointer.

        Armd
