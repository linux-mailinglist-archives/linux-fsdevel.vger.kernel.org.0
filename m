Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D97254D639
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 02:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243193AbiFPAq2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 20:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiFPAq1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:46:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5511FA67;
        Wed, 15 Jun 2022 17:46:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F7B861B44;
        Thu, 16 Jun 2022 00:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60D4C3411C;
        Thu, 16 Jun 2022 00:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655340385;
        bh=Ka9NDcozxCqNwltwXXzj3Lfwvi1TlTiVEFw4V4KHWD8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=r/puVxYETDOZCxUQCfuaj3xXycJAnIOLqJqr4OOZTzcpAusNRdD+sCDBhqnXBpd+L
         VEAGcTDgHRjE5+O25FTl58K22H6Yw7+197rqfH+5H+CmNQeobZYub+ENenC77gC904
         k8E1xcE3wRKqn04oGvPXf/O4TA64eAIR3HZwkvrfvRkGQfg+Fl4piPH10FsW19Pcoe
         G6h+Oauivdpdzp8Ib1Y9Y7+Epav727KmZOpLUN9LGTgF3iQZIslfzbULvlewkXu4zJ
         Ced5EICzRsQZ8dZkIgGGxDcPklA/wfKqbe6ZIuNJJKgtUKSyYiWuJqWcwNu4BTAnJ6
         35XJb/LMqK6VQ==
Received: by mail-wr1-f49.google.com with SMTP id q9so153484wrd.8;
        Wed, 15 Jun 2022 17:46:25 -0700 (PDT)
X-Gm-Message-State: AJIora+bLlqVQ6ADlOtS9MtbzTZ8687WorUO6HamDcTPTAVkxPE6CtBo
        xjQfSnqmT0MXEpvk0Jncod8kJclHO+mjZDoBOpg=
X-Google-Smtp-Source: AGRyM1tljmyc4LcN3jmT6djVfMgx8ZZLu1PyXYU1jz9TRziGsSv7ycvdKNWpR1ICxQlVLqmfXWmIhAwh+tZ7Go7CFCg=
X-Received: by 2002:adf:ed45:0:b0:210:2f9c:f269 with SMTP id
 u5-20020adfed45000000b002102f9cf269mr2254360wro.470.1655340384125; Wed, 15
 Jun 2022 17:46:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:18ad:0:0:0:0 with HTTP; Wed, 15 Jun 2022 17:46:23
 -0700 (PDT)
In-Reply-To: <SEZPR06MB526945BC172186A13FA60B11E8A69@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20220607024942.811-1-frank.li@vivo.com> <CAKYAXd99NAbQP6m93P3bcjvWTN-T8Qy59DHJyfyTHqdH-7aWBQ@mail.gmail.com>
 <SEZPR06MB526945BC172186A13FA60B11E8A69@SEZPR06MB5269.apcprd06.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 16 Jun 2022 09:46:23 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_j-MAYP_8a3xEi2MmxZ9Po8t2di5_yi+7V1xXJuD006A@mail.gmail.com>
Message-ID: <CAKYAXd_j-MAYP_8a3xEi2MmxZ9Po8t2di5_yi+7V1xXJuD006A@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIXSBleGZhdDogaW50b3JkdWNlIHNraXBfc3RyZWFtX2NoZQ==?=
        =?UTF-8?B?Y2sgbW91bnQgb3B0?=
To:     =?UTF-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
Cc:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-06-10 22:07 GMT+09:00, =E6=9D=8E=E6=89=AC=E9=9F=AC <frank.li@vivo.com>=
:
> HI Namjae,
>
>> Still having problem on linux-exfat after recovering it using windows
>> chkdsk?
>
> After repairing with the chkdsk tool on the windows platform, the current
> file can be accessed normally on linux.
> However, it can be accessed normally on the Windows platform itself, and =
no
> tools are required to repair it.
> Imagine that if some users do not have a Windows environment and do not
> understand repair tools, they
> cannot access these files on Linux.
>
> Why not just skip the stream entry like Windows does and allow access
> without fixing it?
If the name hash is not checked, file lookup performance will degrade.
Probably you don't want the overall performance degrade for a few
corrupted files. I suggest fixing it by fsck in exfatprogs before
mounting. We are preparing repair function release in fsck to do that
in next month.

Thanks!
>
> Thx,
> Yangtao
>
