Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE4EB33C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 05:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfIPDoZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Sep 2019 23:44:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37620 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbfIPDoY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Sep 2019 23:44:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id c22so4486670ljj.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2019 20:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o4E/pjEYijXV4v5pS1lBuyelXJCHxLkdn1Gz2TV1Rdc=;
        b=iNZ/esadxmEYS94m0Tu6FNcPScuPYLKZ1pWIvJ49p+SWjb/9sJN7grvNPj8Y9vT4k9
         /smY8+lzG16BbcRlyWoPSeH6CI2MWxnyQFbr3l8yEhz4exTF8pm3c4ay2wsvRwEP6Orf
         YR/+aOwfg8mkPFitzlB1kH4kBMbwLZjrK+3/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o4E/pjEYijXV4v5pS1lBuyelXJCHxLkdn1Gz2TV1Rdc=;
        b=cNE4ms5RzuFqxpH9xcJL4ExwrebPZPOahCUokMacOaIed6PYtd8odAR77r5mRTcEcX
         pIAuschQ0FkcjOE0+axPsxMNFUFQ5jrOVEd09sc5jH0Vp1roeMeaxyQY+JjYb16Y/jJW
         91rlkBTn35ohtvdpT6qUapPM8IZG5s0rSOFctSwxx+6L+PEygUOhfwqxX7fdsOiQuBBE
         xbRyZQfozdF6FmpbHpsONH+lbYQ+Vpcq+wpg60a8Yrk4ZaT/HQMemKxnQjE+0d69cKhy
         2ONBXyCUHNoX5KKmCwBES9ShojTgLXAyG+AmhE9knHCbiemScDjuBYNVRy5W3MtwXwKy
         FucA==
X-Gm-Message-State: APjAAAU/Sf8JeIdytfkQCzOl5luBjhGnlwWVDn/olCKEGrav8cLA3sxE
        PNv0dRSb4SGxh+UfQIOk4zxLMIi1dFo=
X-Google-Smtp-Source: APXvYqzVDMqKhZQ8ICGkWAwGNQllYMfhUY5a9gHHKryNHUENp/e2dACbbcOva1tiSXx24rc4s8HbEQ==
X-Received: by 2002:a2e:3a0e:: with SMTP id h14mr15266892lja.161.1568605462686;
        Sun, 15 Sep 2019 20:44:22 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id d6sm2964953lfa.50.2019.09.15.20.44.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 20:44:22 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id v24so4679049ljj.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2019 20:44:21 -0700 (PDT)
X-Received: by 2002:a2e:814d:: with SMTP id t13mr36982448ljg.72.1568605461531;
 Sun, 15 Sep 2019 20:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190914161622.GS1131@ZenIV.linux.org.uk> <20190916020434.tutzwipgs4f6o3di@inn2.lkp.intel.com>
 <20190916025827.GY1131@ZenIV.linux.org.uk> <20190916030355.GZ1131@ZenIV.linux.org.uk>
In-Reply-To: <20190916030355.GZ1131@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Sep 2019 20:44:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wii2apAb9WHCaOt8vnQjk8yXAHnMEC6im0f0YiEF4PwOA@mail.gmail.com>
Message-ID: <CAHk-=wii2apAb9WHCaOt8vnQjk8yXAHnMEC6im0f0YiEF4PwOA@mail.gmail.com>
Subject: Re: 266a9a8b41: WARNING:possible_recursive_locking_detected
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kernel test robot <lkp@intel.com>,
        "zhengbin (A)" <zhengbin13@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 15, 2019 at 8:04 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Perhaps lockref_get_nested(struct lockref *lockref, unsigned int subclass)?
> With s/spin_lock/spin_lock_nested/ in the body...

Sure. Under the usual CONFIG_DEBUG_LOCK_ALLOC, with the non-debug case
just turning into a regular lockref_get().

Sounds fine to me.

             Linus
