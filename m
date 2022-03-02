Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696784CA6AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 14:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242454AbiCBNzK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 08:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242553AbiCBNyu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:54:50 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A628C7934;
        Wed,  2 Mar 2022 05:51:50 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id g20so1904130vsb.9;
        Wed, 02 Mar 2022 05:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EKpPgbkkKlzEsFTDu9xIc0ZsMrY5wembgqXpNtT/fXQ=;
        b=XIxALNsB/mkfRZOMUJugGvKp0QzbewxSQ+U+fR9JCHvUYLTIS2TuM5svmX1n/hrcSv
         joHNXB7MrSvTbVr3YYp58fBIj9y8aZMZmDErag8rInwrXcUOmuHNwwVrAqGE7o7Qire6
         46JCb8u5jSyRM+peMatOcJF4VpKm2MtjyAM4q9azZKnqLX0DQVlaKTUyaFT5d/zqgn1C
         QnKsxd7dI94er+nY+0MNFjbt7RGNPgQrQyYbCV3IgCooxJccGBfMlEl0pwq0+m4G81ua
         CGzvm6o3WTIOxZmvMpLr9KrFGvmV8JX2iq9v42khjgDC8Ao1IkGGp0MRy0LbIpXY7rHF
         v9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EKpPgbkkKlzEsFTDu9xIc0ZsMrY5wembgqXpNtT/fXQ=;
        b=iiuw084k7b2+dHo36W7oYJOaDRjWDz9zARZgkIH6+ZhYZP1WkrlCQ37K313H/opWug
         NjP+ugs/XuEZ5oUYLcD6Hyevld4QDjiWI3NQNfCWvO20/W7byV3MdhpxsN/cqbUXZxUp
         mZHcBWTcVy1EopiIUy+lcfxidtPvjt9GXR30pAqZaOeTtH69K8aw3DrGhO3UN7AIk/Bo
         Ga03Mxh/W1RXLQH2fu4Ymv4gXFwUoWP0EW2khiKp+ZQuI3fZGRW66KyOG0PToWql3Fhi
         LouCC+QKTDruZAI3hx7542X4xRiqpk2DVZxX7gDwLeIjv8xl2I/zFRrl6jqDVu/CvEly
         r94A==
X-Gm-Message-State: AOAM532NrLbTRJ6WlapdcrfkktRoTbT9iYMXq+1YTPXCIYZAFU6Hzvwy
        r8k43ChPC5E63S2OwVUblE/rFv7N8H5N2Mmrx+I=
X-Google-Smtp-Source: ABdhPJwOVr3O03Y7i9OQq6aznHLPtjaPn4ggsCkcfGzfdPfaBRjUJdCOJkwfhrSYRTC46LGZnY9f9tXmquk8MhjSmOY=
X-Received: by 2002:a05:6102:418a:b0:31a:1d33:6803 with SMTP id
 cd10-20020a056102418a00b0031a1d336803mr12887269vsb.40.1646229108160; Wed, 02
 Mar 2022 05:51:48 -0800 (PST)
MIME-Version: 1.0
References: <164311902471.2806745.10187041199819525677.stgit@warthog.procyon.org.uk>
 <164311919732.2806745.2743328800847071763.stgit@warthog.procyon.org.uk>
 <CACdtm0YtxAUMet_PSxpg69OR9_TQbMQOzU5Kbm_5YDe_C7Nb-w@mail.gmail.com>
 <3013921.1644856403@warthog.procyon.org.uk> <CACdtm0Z4zXpbPBLJx-=AgBRd63hp_n+U-5qc0gQDQW0c2PY7gg@mail.gmail.com>
 <2498968.1646058507@warthog.procyon.org.uk> <CACdtm0aZnQLyduKxr9dhcpYB_r00UFnR=WQvAnqL0DebxgbrOw@mail.gmail.com>
 <2568725.1646127551@warthog.procyon.org.uk>
In-Reply-To: <2568725.1646127551@warthog.procyon.org.uk>
From:   Rohith Surabattula <rohiths.msft@gmail.com>
Date:   Wed, 2 Mar 2022 19:21:37 +0530
Message-ID: <CACdtm0Yf3ifEeMeAeyDRvofk40GZjZRqF7FCP2Uu6bm+i5RM3g@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] cifs: Use netfslib to handle reads
To:     David Howells <dhowells@redhat.com>
Cc:     smfrench@gmail.com, nspmangalore@gmail.com, jlayton@kernel.org,
        linux-cifs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
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

No, I don't have any private changes on top of your cifs-experimental branch.

Below is last commit:
commit cf302ba2d441582a060a0ea1aa4af47f09b24f57 (HEAD ->
cifs-experimental, origin/cifs-experimental)
Author: David Howells <dhowells@redhat.com>
Date:   Tue Nov 17 15:56:59 2020 +0000

    cifs: Use netfslib to handle reads

yes, I have used "Vi". I have tried with md5sum as well.

Regards,
Rohith

On Tue, Mar 1, 2022 at 3:09 PM David Howells <dhowells@redhat.com> wrote:
>
> Btw, do you have any changes on top of my cifs-experimental branch?
>
> Also, what commands are you running to test it?  I see you're using 'vi' - is
> it possible that vi is opening the file O_RDWR?
>
> David
>
