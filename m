Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE23221320
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 19:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgGORD6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 13:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgGORD5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 13:03:57 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8231BC061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 10:03:57 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id h19so3351636ljg.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 10:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QWB0gQ10qeh+4PXw8FO13aNzf1PjQxfW3LedQu7gVUo=;
        b=ZAb6IkRHFqgS/ixB8RckGd2JLlLYEJx3XnPMK9Y9grilxTxWO62DxTZMe0mCUXDUit
         9Y51UGiVmOD4JlmAX8u1QOk+AUmgxA8gdS1gBW/T7osgLwpOYEzH3Hcpg42A7IeHh9yq
         XOQC7E3W9W6dg+itOn4eEb93JFZ5snDxmDGFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QWB0gQ10qeh+4PXw8FO13aNzf1PjQxfW3LedQu7gVUo=;
        b=EJH64qAtCndylVMP2pzBJl49+pMPKxs4uAhZOE/e9obn3VL+W5Vgu/gbnppZaGHDmu
         Pk0xtysDCUd8aigW6HqtbeIo51CykhIhG5SAtOcmoDV9aYcYETD25yKuWHdesKzxXS85
         eWBkx8Vn/etvTF6bXCRi8Ba2swJqJIJ2C5awURWy2isrDbRd7mm1zS+o68md7qHw4pCF
         eNIKRstvJbM6OS4k2xWaGz1ofbMzoyZ+CtE4nTXJs7h8jxQ+92vUSYGNHBaiuqtDHVHy
         3Ae70R5rtIZyxh2B3Ut6BE3vZlCEvvM4CZx3YeJzOeyA4MgP5EwddQomxtbrjXif3HN0
         kuJg==
X-Gm-Message-State: AOAM531/IMf/3geju0KuM4iuNeHBNixW54gJ9oQSs0Rcgedc1w54ag30
        b9s+xCaZ66g0vaWVoIqDAEW/KDHDrfs=
X-Google-Smtp-Source: ABdhPJzO1rDhSa0OakuKnpP3q14k2aEfZCMZrwFIqJdTtu0PXnEXBHuYHwQMsisPIfsfgCogxlT75w==
X-Received: by 2002:a05:651c:21c:: with SMTP id y28mr49861ljn.139.1594832635627;
        Wed, 15 Jul 2020 10:03:55 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id p8sm664655ljn.117.2020.07.15.10.03.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 10:03:54 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id h22so3380880lji.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 10:03:54 -0700 (PDT)
X-Received: by 2002:a2e:760b:: with SMTP id r11mr51043ljc.285.1594832634009;
 Wed, 15 Jul 2020 10:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200715065434.2550-1-hch@lst.de>
In-Reply-To: <20200715065434.2550-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Jul 2020 10:03:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wic28QHU6BmPt8WPr_MegXfyxcZxs3Upauw7SiC=X4zQA@mail.gmail.com>
Message-ID: <CAHk-=wic28QHU6BmPt8WPr_MegXfyxcZxs3Upauw7SiC=X4zQA@mail.gmail.com>
Subject: Re: clean up utimes and use path based utimes in initrams
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 11:54 PM Christoph Hellwig <hch@lst.de> wrote:
>
> here is the requested series to add a vfs_utimes and use that in
> initramfs, plus assorted cleanups that makes this easier.

Looks good to me, you can add my ack for all of them.

           Linus
