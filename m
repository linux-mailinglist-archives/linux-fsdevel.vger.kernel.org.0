Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D0E740A25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 09:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjF1H6b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 03:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjF1H4Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 03:56:25 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335AD30CB;
        Wed, 28 Jun 2023 00:55:40 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b80ba9326bso22837675ad.1;
        Wed, 28 Jun 2023 00:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687938939; x=1690530939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwV6VegEGgXHvYZO+FVF8YG499LVL6bepvXDlvF8+Rg=;
        b=DdN/W8i9yZGtVroesVqsYL9291qa6yWdufawJ695i78fLkmsgsak5TfYyWmXdTfYnF
         1FPtHGggMjJYlAvpYG4UJGDhQKW0nDaFKUzDHNBP+UEm4+XaxCfVb6Ds/fqhGIaK7k2S
         glFNTqtmoiZgWAC35C9oOnpZpjRvhs1sNT5HpEnMLa56LxbSW1btvvXyKDr9awgPk2vS
         xTTLLmGMRjacxZZpi2nBjvtvhYfNz6dL19rRENid70NexX/C6eS8pP8gU1meTDwrueXG
         8q/jc6q3jGHNMU5W3/AREXc0J2kUTGfTxIcUvKCyCkFjMXuKnq5rh6UyqPhSyR91iSev
         LsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687938939; x=1690530939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwV6VegEGgXHvYZO+FVF8YG499LVL6bepvXDlvF8+Rg=;
        b=cdr1eb/k3dGnTm44E+508q54OTTw95l5st1vyKxWMNMmfhEXP6n7rOg/b124VCyKcw
         MqYWd+k/vqvkWfRKrSHQALCVu4m8qR5VU+eTEhu7yFM4e9Vv4ww79DzyExr+Wdqqgban
         30Xn6ZTO5kg/5UuHHKDAUOzpN+KWej1Pz5dhILv4XG5MgRpjciA+VaZYXi+BF+pCeqfr
         17PTB8nPk5yaS/VAJp2d76iKL3G7UFJOESNY/ESDRFS7euH4grlfGNkxZVcu2gZEW8hA
         gr5f4xcYS8aUp+Vw1c1yOtYykyseoyBbqVhgKy3XMCOMTcfYfygxK5ywztSxYLpnIP9Q
         yl5w==
X-Gm-Message-State: AC+VfDzXpBRAeKww4MGH4VYZ5AVtKCFyeUWc+mP/M4PT7i4/B1fWnvBx
        POm2ypsgIiWIqvgOE+1aLFQdF1xV+jQ7dUrVb3SDoBAtwBk=
X-Google-Smtp-Source: ACHHUZ4soVvSPz//0N56n2zVg9/mvSMdsW+hABPbyzw+YBgPBTOqSHuV37+eeVnA7wmrf8sM0FpOVum4oowpUDUaULk=
X-Received: by 2002:a1f:e201:0:b0:471:4ceb:675f with SMTP id
 z1-20020a1fe201000000b004714ceb675fmr10540049vkg.9.1687932158755; Tue, 27 Jun
 2023 23:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <t5az5bvpfqd3rrwla43437r5vplmkujdytixcxgm7sc4hojspg@jcc63stk66hz> <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
In-Reply-To: <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 28 Jun 2023 09:02:27 +0300
Message-ID: <CAOQ4uxgLVJwzTZDvcs6aRLU+Q8zARTXv4tqsAGTX=r8pCLB7NQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] fanotify accounting for fs/splice.c
To:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 11:50=E2=80=AFPM Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> Always generate modify out, access in for splice;
> this gets automatically merged with no ugly special cases.

Ahelenia,

Obviously, you are new to sending patches to the kernel
and you appear to be a very enthusiastic and fast learner,
so I assume you won't mind getting some tips that you won't
find in any document.

a) CC LTP only on tests, not on the kernel patches

b) Please don't post these "diff" patches.
Developers (and bots) should be able to understand which
upstream commit a patch is based on (git format-patch provides that info).

I mean you can send those diff patches as part of a conversation to
explain yourself, that's fine, just don't post them as if they are patches
for review.

c) When there are prospect reviewers that have not reviewed v1
(especially inotify maintainer), it is better to wait at least one day post=
ing
v2 and v3 and v4 ;), because:
1. It is better to accumulate review comments from several reviewers
2. Different reviewers may disagree, so if you are just following my
    advice you may need to go back and forth until everyone is happy
3. It's racy - reviewers may be in the middle of review of v1 without
    realizing that v2,v3,v4 is already in their inbox, so that's creating
    extra work for them - not a good outcome

Going to review v4....

Thanks,
Amir.
