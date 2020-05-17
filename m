Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127AC1D6796
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 May 2020 13:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgEQLMg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 May 2020 07:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgEQLMg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 May 2020 07:12:36 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57461C05BD09
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2020 04:12:36 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id i68so5820504qtb.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2020 04:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Zyl3SarFIasLxbZ+RIzpA3l1T3ELrj/FBTllereD9vE=;
        b=gVfUAYDorbrrcavuF+7jzMivSWiuHH+HWijoJzN3x7+36DiWCaaXZeshs+HeYjbaVn
         sGCIdzXE40/UKgJpzhp6xtYBzBttOR1dp0VfiBDyCwjXB0YfyAe6xiHM89fH0ZP3ahLL
         UhcWS/esXKCSeQcqrLW+7fpfza1HvO8lSghtmjsxG8/YGZCa3aOtGDgCrymKSfNZOQBf
         nA7McKvnwl3+7T8j+oBVAMFpmLWFAUusLSQ1cNwHflYRsvbUIfre1u0PiJc1Olkvk+NY
         wxqDt8f4P1AJMRy/r8DBlmxXn+MNt/9s24JKgmQAGONF0XNS4AUhbTlErFPS7ie6dOyR
         zkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Zyl3SarFIasLxbZ+RIzpA3l1T3ELrj/FBTllereD9vE=;
        b=X2PFWMm/qjBB6QNgnL1+xzX2ywpePOB88XDCtmjRpVCgPQNp3ru308n3zGPAniSNgA
         03GKiQAh2knnh6IO7Y0QPzogVKlKTJre0/zP05o3yQF9rRgVa4rsaEueUt5tJLBtjf4d
         2hB/VId2DJg9kjYHg1YxSFKaUgK7ekWYW608578tle/M18pZg1FBieYvTjuzxHgwxYi9
         bBfP7H4bnGnTJqM+sf32zB4itMn/beZHZhx7tM+2sELIHBwahp5wNRSMi+tGBPLdy08L
         TYlF6qrocsyRgkHjJhYP6w7NTKyJI8GOVpSgHm2XyMDxxryY5mBohTuqvJu13can++p/
         OZfw==
X-Gm-Message-State: AOAM532HOxIfWsk5E1JMINK62vWIJTirQpTAfvEeE72M7iXOFE9PjrQF
        tauXNcdj8g2e9xJx3sC2iFdlKA==
X-Google-Smtp-Source: ABdhPJxm+Z6psJVh1daO567GdnW4roVUxYUbV5oTdCairc5qpsrr0Ja8dmh8CYKiFCVFihyKb1Eg+w==
X-Received: by 2002:ac8:4650:: with SMTP id f16mr11496052qto.168.1589713954634;
        Sun, 17 May 2020 04:12:34 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h22sm6512975qtn.23.2020.05.17.04.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2020 04:12:33 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: "BUG: MAX_LOCKDEP_ENTRIES too low" with 6979 "&type->s_umount_key"
Date:   Sun, 17 May 2020 07:12:33 -0400
Message-Id: <06E43DA0-9976-4D44-AC72-5ED8A7022FA3@lca.pw>
References: <e8c6d3af-3045-0a37-5e9e-bfd60c09f97d@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <e8c6d3af-3045-0a37-5e9e-bfd60c09f97d@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 16, 2020, at 9:16 PM, Waiman Long <longman@redhat.com> wrote:
>=20
> The lock_list table entries are for tracking a lock's forward and backward=
 dependencies. The lockdep_chains isn't the right lockdep file to look at. I=
nstead, check the lockdep files for entries with the maximum BD (backward de=
pendency) + FD (forward dependency). That will give you a better view of whi=
ch locks are consuming most of the lock_list entries. Also take a look at lo=
ckdep_stats for an overall view of how much various table entries are being c=
onsumed.

Thanks for the hint. It seems something in vfs is the culprit because every s=
ingle one of those triggering from path_openat() (vfs_open()) or vfs_get_tre=
e()

When the system after boot, lock_list entries is around 10000. After running=
 LTP syscalls and mm tests, the number is around 20000. Then, it will go all=
 the way over the max (32700) while running LTP fs tests. Most of the time f=
rom a test that would read every single file in sysfs.

I=E2=80=99ll decode the lockdep file to see if there is any more clues.=
