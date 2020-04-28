Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4F51BC5D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 18:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgD1Qxn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 12:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgD1Qxn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:53:43 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7BBC03C1AC
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 09:53:43 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id l11so17505308lfc.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 09:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q5Z4HlhTNB53SfOmbfxYbxhFeMg9kSBe7UiylTe1sK4=;
        b=U0vubYq04Lq1/qZe+lISORyl0P83N1X2JC1zPH/anIzO/2qgQ9RdChTPhMz9JkQYQN
         MMuZWyY2quEr7OcLglD7hQLA6m85JwzjLomr38fhVcQFFEJcRWEnwXzAfHtni2RnkvwQ
         x6lDYp88Dq7d9rzV+kA7s7TFN7/nBiIe2xQ8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q5Z4HlhTNB53SfOmbfxYbxhFeMg9kSBe7UiylTe1sK4=;
        b=Q3Gdi+KJP6y3bOPUNK/YogD4hgiDhK0xP28cg9BuZD7K6G8eTtIbv3M+YWhYNvmY9d
         yB14o6HaMSg63VH+iXqglZHan14PZPCAbTKD71Ggk8Q97NgSVp7sfaZP5nA3818CSI2v
         akaz30sp1R6zyPtKGJfrlIu9IysoSstkwH/1jWsmCg9oVQ60msUDT1NrYR9qs+jXttOJ
         isthkOI32fJtLPxi35G7rapS9VVURBcVKID3nlgyz4k/ygW9cwN5s0lI5CwgovW4WGeS
         mcBexbZEe0uSp/505wfGpTdd+SItiRZdGHrQ+iGtsppR5i2Ku+pDPnHKVgX98401SRqs
         SuUQ==
X-Gm-Message-State: AGi0PubFKiS0clEj7AE1Z+n4rFzEaBXV3oGW5Z4lxbq/hCyEPjZ4fiNR
        naJnfYWvWvCB6qgeZB3XWlEACSL3XeY=
X-Google-Smtp-Source: APiQypJOIheJwi+x09R02eKVDWEPGU3jUPB3v2rZvWUrXUArjQPYzHjKW01pMc0BM9dL2x58f4E5Qg==
X-Received: by 2002:a05:6512:cc:: with SMTP id c12mr1197720lfp.188.1588092820559;
        Tue, 28 Apr 2020 09:53:40 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id u12sm12862420ljo.102.2020.04.28.09.53.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 09:53:39 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id h6so17538428lfc.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 09:53:39 -0700 (PDT)
X-Received: by 2002:ac2:4892:: with SMTP id x18mr1932440lfc.142.1588092818583;
 Tue, 28 Apr 2020 09:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
 <87ftcv1nqe.fsf@x220.int.ebiederm.org> <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
 <20200424173927.GB26802@redhat.com> <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
 <875zdmmj4y.fsf_-_@x220.int.ebiederm.org> <CAHk-=whvktUC9VbzWLDw71BHbV4ofkkuAYsrB5Rmxnhc-=kSeQ@mail.gmail.com>
 <878sihgfzh.fsf@x220.int.ebiederm.org> <CAHk-=wjSM9mgsDuX=ZTy2L+S7wGrxZMcBn054As_Jyv8FQvcvQ@mail.gmail.com>
 <87sggnajpv.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87sggnajpv.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Apr 2020 09:53:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiBYMoimvtc_DrwKN5EaQ98AmPryqYX6a-UE_VGP6LMrw@mail.gmail.com>
Message-ID: <CAHk-=wiBYMoimvtc_DrwKN5EaQ98AmPryqYX6a-UE_VGP6LMrw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] proc: Ensure we see the exit of each process tid exactly
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 5:20 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> In short I don't think this change will introduce any regressions.

I think the series looks fine, but I also think the long explanation
(that I snipped in this reply) in the cover letter should be there in
the kernel tree.

So if you send me this as a single pull request, with that explanation
(either in the email or in the signed tag - although you don't seem to
use tags normally - so that we have that extra commentary for
posterity, that sounds good.

That said, this fix seems to not matter for normal operation, so
unless it's holding up something important, maybe it's 5.8 material?

                Linus
