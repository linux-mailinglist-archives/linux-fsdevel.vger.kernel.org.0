Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0034553F522
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 06:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbiFGEaz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 00:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbiFGEaw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 00:30:52 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D605D674;
        Mon,  6 Jun 2022 21:30:51 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id p83so350986vkf.6;
        Mon, 06 Jun 2022 21:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7BF9WyjOUstLU5sdiPd4MgM1fQOqAYwFJgrDPasxIrI=;
        b=cOLgKQAUY5z5y0ifx1jE/IHkRIIl8B5szLm0fdHeWMDyyf/ZWDFBiFFQywNUmtYkMp
         UFfn9dOAn9At5LwvAlaQRsERJ9PSmyszxf3ViS2Otshvn4woEWuUXvBOEhBv8iu6g12z
         eHARpHPnKmoUL/zXQAg5JouTR3worF05zns+QdU1jZL4KEwaHoP6OXWrILsLxmKzw30X
         zk90/tHjJ2tKX6En7BDwVRF5dQaR4vE6smDWxdL953+eYVP0LFwtKKAkvxksCbv7BpWV
         ySHOetK2nqnVd9MAwJsvCs/fw6qwLRAdHPM/l3M3B57r2QsT3l5zl294uHIz7HNwXa5k
         Xi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7BF9WyjOUstLU5sdiPd4MgM1fQOqAYwFJgrDPasxIrI=;
        b=VtBZF+jUURySUTwcljK5+cfU0AqqlNypbo3rLojf2eGXnxhPVmqHXyTNM0DUlaDeKT
         aPbTZJBXi0KbDuaNH1b8sonw1rMF4T8vNeDch/Hf64JU7Fjhph5pSXUrQGrhixnnhr6H
         5ZiHiUR4r8Xvk9zAvITwZ7D40HdDQvj/gD6s8aPOs7P7GQHZIjdFgbI7FYkXYgwu3E44
         /YGCBjzEnEW51cTBN/+2gixiNdipOSYyhsihPCVU3v0IpAdpsPK/1NxGLQlpnULUcMrJ
         x60VQOxFKsTVRDVoqz2s9mf93Aes2FZE53apRmQYGBNMs/9yBqBu01TDy1tZscg9BuKz
         WygQ==
X-Gm-Message-State: AOAM533XIgDbs/XRoGhvBig5BIBWceu1F3BuNn1ljtu1jWEtOA0oURCR
        yh3wj0GgN5EAUb3Yo6b9z442Yzo2FC4R+PtIV/A=
X-Google-Smtp-Source: ABdhPJzvBpDBGudyCiIc9ttpYLYI3ZZ5JzmlmAVbO6+QHjRdMM26bbgJJv1EiZWe4nxuDQfsXnWL5NG5KHyWM02U56s=
X-Received: by 2002:a05:6122:2205:b0:321:230a:53e1 with SMTP id
 bb5-20020a056122220500b00321230a53e1mr15105573vkb.25.1654576250472; Mon, 06
 Jun 2022 21:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220606224241.25254-1-ojford@gmail.com>
In-Reply-To: <20220606224241.25254-1-ojford@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 7 Jun 2022 07:30:39 +0300
Message-ID: <CAOQ4uxhuMTw7fHY-2NGCs4s2vqnCQF3EKHtozjn-1UP4Jm9=1Q@mail.gmail.com>
Subject: Re: [PATCH 0/1] fs: inotify: Add full paths option to inotify
To:     Oliver Ford <ojford@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Tue, Jun 7, 2022 at 1:43 AM Oliver Ford <ojford@gmail.com> wrote:
>
> Adds an option to return the full path in inotify events. Currently, user=
 space has to keep track of watch descriptors and paths, mapping the descri=
ptor returned when reading inotify events to the path. Adding an option to =
return the full path simplifies user space code.

That is exactly what FAN_REPORT_DFID_NAME fanofiy mode is for.
Please try to use it and see if it fits your needs.

Thanks,
Amir.
