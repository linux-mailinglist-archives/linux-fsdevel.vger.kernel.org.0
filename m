Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A007F1C9EEF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 01:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgEGXH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 19:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727821AbgEGXHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 19:07:22 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7670C05BD43
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 16:07:22 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 4so1686234qtb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 16:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=cDgv5RBBNmmZoeVkSdRHbb+p5n1j6gbGkVNuskYknK8=;
        b=irn2+fcrxp6NonlZzAmEkP+IcmaZPlVzbzxmfCG6lVabw4/G0dFt3sq6PNTCVMGxGG
         mHrxFYOqL919h6uaxEl0JW7dIaw8NB10ABm7DPmqf/EhfuWGsilf0Zdh4cihFDxim+Mo
         2oiV63mSEiHMYHoenvD/gjwZA2LAweN8EWw+tYVdcFwe7a8XKwwE9AkeASQmt+OrM6Ud
         66rqMK51DOb0gUzTcrOl8r0cDm0oT8FMB5ERjpMlkKlVh00sAuv1oGi7o++rQCXNEyy3
         NK/+1D+NyYl6NPUHDAAe/3i2dWdBxPkf5biMBOG9YHzAaT3acw0lJR7KTsOkpXlpkwHt
         Jr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=cDgv5RBBNmmZoeVkSdRHbb+p5n1j6gbGkVNuskYknK8=;
        b=Jt4tgttJcAIjnY6+8DyiAQnzJz93ljBRabpPplgRx1Pm5URlfVMOf0lAzYj2Fm2afA
         uKAn5h9TuNAaqg6AUb0Q/ExUA35ef061bd4ClA0MFdc2+P8y18mqJgGJgZIU5T572EZV
         Ei2R71uknv7St0BlPTydXV1oN38TJHMKyK84iS9HxNT5c5cWMRKFHaX7J3Hlzz4lIRBo
         AbmtCib6k61amqU1H9gB6ekwOez9zn0KPFG9feJ33mOArech8zzj6UBQlAvEMVwc04P7
         opRqVJdHu7H0AV95eZZiKdblsmr3FZtT0CXxrC+2e8gga4ckYpGac7Nsa4fGNS2KMbuJ
         5ZMg==
X-Gm-Message-State: AGi0PuZU7X9QaVlG9k0S2FYLJzy2oJLEfcUD05chP3g8vuzoOWFHknun
        /1PVkZ4MYFMy4vfaYDhqVhvasA==
X-Google-Smtp-Source: APiQypJ8nv0rS/6ipD0+tlnjwjtkoEW9gBSgFlE4m3C077d6wO4jOE6P+FabQVeufE8QHwU+D1XMog==
X-Received: by 2002:ac8:46c9:: with SMTP id h9mr16757891qto.128.1588892841789;
        Thu, 07 May 2020 16:07:21 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b126sm5170080qkc.119.2020.05.07.16.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 16:07:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] kernel: add panic_on_taint
Date:   Thu, 7 May 2020 19:07:20 -0400
Message-Id: <6B423101-ACF4-49A3-AD53-ACBF87F1ABE0@lca.pw>
References: <20200507221503.GL205881@optiplex-lnx>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dyoung@redhat.com, Baoquan He <bhe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
In-Reply-To: <20200507221503.GL205881@optiplex-lnx>
To:     Rafael Aquini <aquini@redhat.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 7, 2020, at 6:15 PM, Rafael Aquini <aquini@redhat.com> wrote:
>=20
> It's a reasonable and self-contained feature that we have a valid use for.=
=20
> I honestly fail to see it causing that amount of annoyance as you are=20
> suggesting here.

It is not a big trouble yet, but keeping an obsolete patch that not very str=
aightforward to figure out that it will be superseded by the panic_on_taint p=
atch will only cause more confusion the longer it has stayed in linux-next.

The thing is that even if you can=E2=80=99t get this panic_on_taint (the sup=
erior solution) patch accepted for some reasons, someone else could still wo=
rk on it until it get merged.

Thus, I failed to see any possibility we will go back to the inferior soluti=
on (mm-slub-add-panic_on_error-to-the-debug-facilities.patch) by all means.=
