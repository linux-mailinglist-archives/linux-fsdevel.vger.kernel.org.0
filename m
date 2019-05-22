Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB04626A54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 20:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbfEVS5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 14:57:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33196 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729670AbfEVS5m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 14:57:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id g21so1518666plq.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2019 11:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=szkcRyxZ0C39yo4N6145DEUe6XyFUz0KBpbtt9TBfP0=;
        b=Ydf4kIIzFGsRPeyDv/LD9jkV59ovbQan+Wd8fqIxMwCRJp/RVX+yZf4o+u6NibmZNb
         RBaURj3qgOsxfsuBtJG6yAimX+7Bpo1Z58qe4I1GSlhbt4rdQlesJgqiVtNxukJHL9Ay
         SCkEf9p4pFm6hpxZvAD0nuufFt6Z3LLCeyS7sMt3FF/ytzXY9FBgqYOrvXNeh66AeKL5
         ffqluOQsspdvY8fIbgNl94Tft8wYYZvabj0kGgOv0BKMgwsPZ7rdvy4BVl3CESx+XYnK
         dh+QwhYiKneyxjbioXF2+ggV65ZAle6Tnd2nqQo9lbgH534qL/JrOAw3laOTxvE8X7Hp
         kLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=szkcRyxZ0C39yo4N6145DEUe6XyFUz0KBpbtt9TBfP0=;
        b=g5WjFCOK+OMMdKnUAB6Wc4N6JfOnWQmaKwXDqFInckI7XlMyt3zllazNr+jXQyT6fX
         WCGQYkneLzN/f01e2yLKYLA7N6jfRGpiSSwa8QQXgpVvIvXKc23b0WmeZqJsVwru9ivk
         F3QpD0byZQHa6Qxl1ENlIy5tIq/oVYqNRQlfhwcKUsHBHgNrDhcimEv7FVZHr//GXIhl
         tQNUyT/HbKOFuUlaJp/aCMuiwqPi0nZ2ht7aQ7PIsAcsZAKE6GssEv9wrPHgKo/QBtvZ
         rCikkL6+IORlP1d5A3IlcTJ9VHoCdTl5Cf/67R2cDiWGZB0u17XhEY3o+bWbp6uKNaqc
         kuyg==
X-Gm-Message-State: APjAAAXYZ3YS+tMKUjBoQtgUX2CRJDKIPR9pHZwg4lYzC6tQTKPY0hNQ
        WU3DU/ZRbVRYqm8xvwdWCwVB9w==
X-Google-Smtp-Source: APXvYqyLoaZ7hqmXEwmUSc+mzFW9yrK692JNNFYKEoLiWemGI3SiDKNDvfmLElxz4983TVkj1cGfnQ==
X-Received: by 2002:a17:902:56a:: with SMTP id 97mr53597607plf.20.1558551461185;
        Wed, 22 May 2019 11:57:41 -0700 (PDT)
Received: from [25.171.36.155] ([172.56.31.154])
        by smtp.gmail.com with ESMTPSA id t78sm53489942pfa.154.2019.05.22.11.57.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 11:57:40 -0700 (PDT)
Date:   Wed, 22 May 2019 20:57:32 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAOQ4uxjV=7=FXuyccBK9Pu1B7o-w-pbc1FQXJxY4q6z8E93KOg@mail.gmail.com>
References: <20190522163150.16849-1-christian@brauner.io> <CAOQ4uxjV=7=FXuyccBK9Pu1B7o-w-pbc1FQXJxY4q6z8E93KOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] fanotify: remove redundant capable(CAP_SYS_ADMIN)s
To:     Amir Goldstein <amir73il@gmail.com>
CC:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <EB97EF04-D44F-4320-ACDC-C536EED03BA4@brauner.io>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On May 22, 2019 8:29:37 PM GMT+02:00, Amir Goldstein <amir73il@gmail=2Ecom>=
 wrote:
>On Wed, May 22, 2019 at 7:32 PM Christian Brauner
><christian@brauner=2Eio> wrote:
>>
>> This removes two redundant capable(CAP_SYS_ADMIN) checks from
>> fanotify_init()=2E
>> fanotify_init() guards the whole syscall with capable(CAP_SYS_ADMIN)
>at the
>> beginning=2E So the other two capable(CAP_SYS_ADMIN) checks are not
>needed=2E
>
>It's intentional:
>
>commit e7099d8a5a34d2876908a9fab4952dabdcfc5909
>Author: Eric Paris <eparis@redhat=2Ecom>
>Date:   Thu Oct 28 17:21:57 2010 -0400
>
>    fanotify: limit the number of marks in a single fanotify group
>
>There is currently no limit on the number of marks a given fanotify
>group
>can have=2E  Since fanotify is gated on CAP_SYS_ADMIN this was not seen
>as
>a serious DoS threat=2E  This patch implements a default of 8192, the
>same as
>inotify to work towards removing the CAP_SYS_ADMIN gating and
>eliminating
>    the default DoS'able status=2E
>
>    Signed-off-by: Eric Paris <eparis@redhat=2Ecom>
>
>There idea is to eventually remove the gated CAP_SYS_ADMIN=2E
>There is no reason that fanotify could not be used by unprivileged
>users
>to setup inotify style watch on an inode or directories children, see:
>https://patchwork=2Ekernel=2Eorg/patch/10668299/
>
>>
>> Fixes: 5dd03f55fd2 ("fanotify: allow userspace to override max queue
>depth")
>> Fixes: ac7e22dcfaf ("fanotify: allow userspace to override max
>marks")
>
>Fixes is used to tag bug fixes for stable=2E
>There is no bug=2E
>
>Thanks,
>Amir=2E

Interesting=2E When do you think the gate can be removed?
I was looking into switching from inotify to fanotify but since it's not u=
seable from
non-initial userns it's a no-no
since we support nested workloads=2E
