Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E35A8B6D37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 22:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389946AbfIRUEl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 16:04:41 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36937 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389939AbfIRUEl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:04:41 -0400
Received: by mail-lj1-f193.google.com with SMTP id l21so1210986lje.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 13:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=01Y6x1zvemzBJQWLxE4DBoZbhxORfd/lyc86dODNTds=;
        b=TgS0uVH24w0R1Fkx0c26UZGHv0NIDmFwVNEVRMK1sKN+11sFoguy/eWP2GRt5ktatK
         UA1N2CCdZVRk0AzXAIkyAiGcU+CQMl7qwnLRwXX/dvh+2CuQv3QJ6XM8shRLCQNTFIMt
         V4BgdJc75+s4V8iriJV0BM7ZT7q18LRacAIfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01Y6x1zvemzBJQWLxE4DBoZbhxORfd/lyc86dODNTds=;
        b=CZpa6osI2DrYFOyMyAX+DIBoRjRnR/zK3ZqPq8M3X2VeCSEN3wA34InVxY/lYO6UbD
         aFMZUKdAdP8YWRdIIcKTBjveuIOpRF/M8XuEWnGRrz963lzKbt3Tl0UUHxLjDZOaQfRO
         WezLEyeBPwFta5WQZF/9zQiX0DB/LOiR/edL1NKrhKCH+OnDTKbKlIN+A2vvpguVNz69
         9gKOunaPAdRxgd20CYtaF+0kLvMRGy3LggokgB75eaxUF8jXXTiVzt2elpobB0Or1Gdc
         dqpoByKj4tf2oUwJ153Q6t9duegYMoaAfgHVLzYytlCWuEPvkLEyjXy+XRsEiKl0FtGw
         S2Og==
X-Gm-Message-State: APjAAAVuK10MSPCJ2+obeCpa3gGElWO47w4RmN1KF0ZFBv45XNi8aYqF
        Sa9b+xCc22Mt585NvGbSsLxGqxvn06w=
X-Google-Smtp-Source: APXvYqxnibegphiA7vnkf+ARBkHzjHxkOdEhJBx4sbY3Z3ETgxlVyZEL/DKTBVKLibVTw5V01s32bQ==
X-Received: by 2002:a2e:90c6:: with SMTP id o6mr3284902ljg.144.1568837079016;
        Wed, 18 Sep 2019 13:04:39 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id k16sm1218060lje.56.2019.09.18.13.04.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 13:04:37 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id m13so1150499ljj.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 13:04:37 -0700 (PDT)
X-Received: by 2002:a2e:8943:: with SMTP id b3mr3228332ljk.165.1568837077303;
 Wed, 18 Sep 2019 13:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190917013548.GD1131@ZenIV.linux.org.uk>
In-Reply-To: <20190917013548.GD1131@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Sep 2019 13:04:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgKEdDnCBE40D-S=ZdekJjhU_WJAjnXq3LCGZLgE5SU_w@mail.gmail.com>
Message-ID: <CAHk-=wgKEdDnCBE40D-S=ZdekJjhU_WJAjnXq3LCGZLgE5SU_w@mail.gmail.com>
Subject: Re: [git pull] vfs.git #work.namei
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 16, 2019 at 6:35 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         pathwalk-related stuff

That could have done with a few more words of explanation.

I added "Audit-related cleanups, misc simplifications, and easier to
follow nd->root refcounts"

            Linus
