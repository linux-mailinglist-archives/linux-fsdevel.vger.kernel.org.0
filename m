Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5D1B6DBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 22:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbfIRUbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 16:31:34 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36429 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfIRUbd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:31:33 -0400
Received: by mail-vs1-f67.google.com with SMTP id v19so753388vsv.3;
        Wed, 18 Sep 2019 13:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k00cJxJVOrZHQZWIDnw9OPdlixcLBPMnLm2wjYYctZQ=;
        b=cvAyWueZzWSZSju5V7PXoSzoAOQ2+3Fdjnf3enoHLDk42j68+thtOVj7z2AEWxKfC7
         ++GH+cn+GG2nsZUmIgCdzBC+azyFg53Bh3O0I0VFVEd1fVpsZVm1otzzw86XCAUz4K1r
         rh8q6GjnZjAfKoLZLXV4Tup4A2JmM8gU0BBVxoWEATzoEC6JuFAHVJ2guHEk6+rfhNsu
         PqSbSYATke0WCSM4parfRcIGWQzb+UVD1xmE8nU9LPmzVo6IHpypSnW8FYZMOkc+Z1cZ
         L9uM9BrVzMhLC0Q/0W9tZtIzw+3i8mV7o2ZBnmM1fYY+tc91K2pZsxFEXqTU5ouYMWj9
         2IKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k00cJxJVOrZHQZWIDnw9OPdlixcLBPMnLm2wjYYctZQ=;
        b=Ekf7xOfdY7QhjZEexhi5brwBM/v5qFrNc8WJL8hiET+BlTGiFqp8vEIc6JbVh9WrEp
         uqKxmvkrCTmkewCxkaf8pEAg/5HfFsCI15IncGRzFZzFLQczxOHad8s9LH3XYKqqKPWi
         yrdNbi1reioxF8jhmySaEWjEF1e5lz6BkLMM4XNqCTWcGy47sdH7lVJcen0qbb/3IXbr
         BVg393qO6w79BfsPG1k7q+iN6PfL+LpJ0s46sajhwRqHsd3LNwkOYqMBi6n3sDTDd1/l
         umAtRcWX+82LGrpVgJL7iJTB1aji7gVkHZdUSyB8oMtqqEVZgSvmv/TJzuh3cAg32fiQ
         8BHw==
X-Gm-Message-State: APjAAAVLAfHha3blzOWLTNeBbxEnPMKO7f4IPU/YtdBPkR58nu0jLGTc
        bhEzhvztlyjJrkc6NI6A7Gfj1RRPCkLc9x/YS6o=
X-Google-Smtp-Source: APXvYqw0/NfTdkYtF/83p7/m4C+2xB93JAFy/AQRs14cASEOg3z6U9/VjIuYDTba7nMYHih72p7t5LuzG3fRVAKYro8=
X-Received: by 2002:a67:7087:: with SMTP id l129mr3517858vsc.83.1568838692756;
 Wed, 18 Sep 2019 13:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190918195920.25210-1-qkrwngud825@gmail.com> <20190918201318.GB2025570@kroah.com>
 <CAD14+f0YeAPxmLbxB5gpJbNyjE1YiDyicBXeodwKN4Wvm_qJwA@mail.gmail.com> <20190918202629.GA2026850@kroah.com>
In-Reply-To: <20190918202629.GA2026850@kroah.com>
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Thu, 19 Sep 2019 05:31:21 +0900
Message-ID: <CAD14+f1yP7qps9mpF1T9Xf7E5Osthzj7tH35VcWPr3TmxdkMTQ@mail.gmail.com>
Subject: Re: [PATCH] staging: exfat: rebase to sdFAT v2.2.0
To:     Greg KH <gregkh@linuxfoundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>, sj1557.seo@samsung.com,
        devel@driverdev.osuosl.org, linkinjeon@gmail.com,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, alexander.levin@microsoft.com,
        sergey.senozhatsky@gmail.com, linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 19, 2019 at 5:26 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> That differs from the original exfat code, so something is odd here.  I
> need some sort of clarification from Samsung as to when they changed the
> license in order to be able to relicense these files.

We should probably ask Valdis on what happened there.

Even the old exFAT v1.2.24 from Galaxy S7 is using "either version 2
of the License, or (at your option) any later version".
You can go check it yourself by searching "G930F" from
http://opensource.samsung.com.

I'm guessing he probably used "GPL-2.0" during his clean-up.
