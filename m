Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A4265A2B1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 05:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiLaEfb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 23:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiLaEfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 23:35:30 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022F211154
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Dec 2022 20:35:27 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id e141so25351195ybh.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Dec 2022 20:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F0C5oAJEuXsiIdydExpKDt9KM/1B9On6xnvG2gCvXqU=;
        b=TVtZML/TmIpXR1M2v4Ws2lM/ztIlNF4jVwo2b2sdRZLcG71rhsF5ap9y0dd0nP/uLT
         iglrLUmYE4QX55S0XHIPcvp5wm/qAeAaPqP6cuxrYjKKvflpGePgauOiCWzLn6ltOSWV
         hfgMyJ2+c/DMWI+rcSuUhCAot+3SY3P/Lo70xa5C+WDkzc6F5n/ERO4Vli6rSEJrLWcK
         1yudGBPf79fNs0N2BzscOwxFlRNWrcBMzrbAyKVXEpHe5oQr76cRYivmXgsvp1BOO08m
         TjPlN2EG/9HpQzf1x/rhta3hOyJp734T0gwIKD5p7l8MgC2AWGt7ZI5lnDSDkmlwlPAf
         Srbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0C5oAJEuXsiIdydExpKDt9KM/1B9On6xnvG2gCvXqU=;
        b=g+BXp8ItWgsxrt7OKzzR1F1KAoXNEH9uDCtS1Cf08BWLMuRvnDvtk2VnaciU/gyRrO
         OnbpYiQqTfN213ihOClBKrNb7vCw4d8eKzktFHU5XwzAztNdjpFJ7KeGqFlFjwOBEPqz
         c72IjqMA5HtUGjl16zAYkDwbePF2nxgmX6uuQlfm+90NlC8YIwIqLQTlgtT8s1XSDuEQ
         4cgusYBje80XACX7Qj450dC24PCgLWw++pOjE1xCCDSVS7M6nAqxmdu0Q4I6MrOdokUj
         hwGE1u9Dc7aJepIXUL6qgYGSYUzKwYLnSYhDXjlG9ectBHgK3qHIkZg2EW4phoq9MGuD
         DeYg==
X-Gm-Message-State: AFqh2krDkbHbL5BXMoKMZ9DidhA/20nygguEQm78ESCFDQwigvXFqZsp
        b0siP8n+d387otkK0yHuX8aZkAryPJOSxYh+p6quAhs9
X-Google-Smtp-Source: AMrXdXsJXRx7RxYksKSOyn2rav8zCyzCtqbGMxBt1vVTyTxEAP2XPz14ZTahNYPKnvkfaCi1fP9b7YJDaRkG9wAEn4A=
X-Received: by 2002:a5b:489:0:b0:755:e465:7651 with SMTP id
 n9-20020a5b0489000000b00755e4657651mr3595054ybp.596.1672461327045; Fri, 30
 Dec 2022 20:35:27 -0800 (PST)
MIME-Version: 1.0
References: <CAM7-yPQOZx85f3KxKO1feSPcwYTZGRNNVEgqn4D_+nhhXvqQzQ@mail.gmail.com>
 <Y67EPM+fIu41hlCO@casper.infradead.org> <CAM7-yPROANYjeGn3ECfqmn0sLzEQPUpzCyU5zSN3-mJv3UA4CA@mail.gmail.com>
 <CAM7-yPSDZG6Sd9pcm+5zXteMfKYujZ8bjpywwJV4whrmRr+ELQ@mail.gmail.com>
 <Y69dRHaTLqgY+vLG@sol.localdomain> <CAM7-yPSdnPg56fQ=j11neee5UN3jLE6e3D5tmtMxHufR_nVD+g@mail.gmail.com>
 <Y69u1zxkcVn1RHY0@sol.localdomain>
In-Reply-To: <Y69u1zxkcVn1RHY0@sol.localdomain>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Sat, 31 Dec 2022 13:35:15 +0900
Message-ID: <CAM7-yPRC5bkC=9um_DnH1Lbf9QyHoXyjcrbHtA54m4Yv-wjLJA@mail.gmail.com>
Subject: Re: [Question] Unlinking original file of bind mounted file.
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> ext4 doesn't free the inode number while the inode is still on the orphan list.
> So your claim "inode->i_no which managed by ext4 is freed and become reusable"
> is wrong.

Thanks :) I didn't know that! and Sorry to make noise.
