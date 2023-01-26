Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE6567CC09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 14:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbjAZN1B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 08:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjAZN1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:27:00 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C586E414
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 05:26:40 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x10so1824616edd.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 05:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnYbzrB2oVOvcPj1GA9MZ8cG9IrI7N+mO6rE42ejGe8=;
        b=poRG6H5mXujnQCPfi6t0qKaHjmzYlsKD6nAnuGv75dzANiXZUKpsoMcgaRvXNy9qHW
         qF5axUmPre9ArcCPSc6NQ7zPmzLqw5HFwx9FApPokbIhbQCmYY1iRku5H36w2wXaALtj
         tKevhojZPi4i6K5rR4ZIBQX6UNAel3coMmS78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnYbzrB2oVOvcPj1GA9MZ8cG9IrI7N+mO6rE42ejGe8=;
        b=f3WEtpBJPhLxPg/3E2GeEw3RwAgBg45sF05G6BMU0ec9Cz7hOpUp5VhxJYAEuQ9JKz
         cS4Nrn1OwEearZ67Js/rE0Dj8vsMkuYvT26RC0ow9cdC6mePRP3QDqcsGFl8BrjbUC5i
         121PihiQnvnarQbrQl4vy2J89Jgc8zHnyQWGPVNecuoAGUQtxLUaituebX0RQbIpGNWC
         UcKMFOGSd/NkxePmwok0zbN21ZYk1RXBUDpRnLvidMG9DgPLEx1GxNb4jsvECi2rspPO
         0bLSUSyIClpw49Rn8K24p/gRnnK9N9uMkofp6zRthVZKgAUohmqyhiDhGnFBJq9ZsW5Q
         4QgA==
X-Gm-Message-State: AFqh2koBdrabZOjd4MZxQjjTE4CBDjPBRfYncY6WfylXLms29HjZ+rbG
        8LaYMvkWX68xJW/1Bv1wHP1xBO36kZxy2YfYL3d+vcqWdgNauA==
X-Google-Smtp-Source: AMrXdXuqt3vOLe0P9mpZBkr8pOK4cwkFuhA96gtRigN/4hZ1Rut2mH43rKwWAoC63/pr/odBwhGf3EPqhS1w13WeLK0=
X-Received: by 2002:a05:6402:358e:b0:49e:ea1e:ac9c with SMTP id
 y14-20020a056402358e00b0049eea1eac9cmr3886146edc.70.1674739598734; Thu, 26
 Jan 2023 05:26:38 -0800 (PST)
MIME-Version: 1.0
References: <4B9D76D5-C794-4A49-A76F-3D4C10385EE0@kohlschutter.com>
 <CAJfpegs1Kta-HcikDGFt4=fa_LDttCeRmffKhUjWLr=DxzXg-A@mail.gmail.com>
 <83A29F9C-1A91-4753-953A-0C98E8A9832C@kohlschutter.com> <CAJfpegv5W0CycWCc2-kcn4=UVqk1hP7KrvBpzXHwW-Nmkjx8zA@mail.gmail.com>
 <FFA26FD1-60EF-457E-B914-E1978CCC7B57@kohlschutter.com> <CAJfpeguDAJpLMABsomBFQ=w6Li0=sBW0bFyALv4EJrAmR2BkpQ@mail.gmail.com>
 <A31096BA-C128-4D0B-B27D-C34560844ED0@kohlschutter.com> <CAJfpegvBSCQwkCv=5LJDx1LRCN_ztTh9VMvrTbCyt0zf7W2trw@mail.gmail.com>
 <CAHk-=wjg+xyBwMpQwLx_QWPY7Qf8gUOVek8rXdQccukDyVmE+w@mail.gmail.com>
 <EE5E5841-3561-4530-8813-95C16A36D94A@kohlschutter.com> <CAHk-=wh5V8tQScw9Bgc8OiD0r5XmfVSCPp2OHPEf0p5T3obuZg@mail.gmail.com>
 <CAJfpeguXB9mAk=jwWQmk3rivYnaWoLrju_hq-LwtYyNXG4JOeg@mail.gmail.com>
 <CAHk-=wg+bpP5cvcaBhnmJKzTmAtgx12UhR4qzFXXb52atn9gDw@mail.gmail.com>
 <56E6CAAE-FF25-4898-8F9D-048164582E7B@kohlschutter.com> <490c5026-27bd-1126-65dd-2ec975aae94c@eitmlabs.org>
In-Reply-To: <490c5026-27bd-1126-65dd-2ec975aae94c@eitmlabs.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 26 Jan 2023 14:26:27 +0100
Message-ID: <CAJfpegt7CMMapxD0W41n2SdwiBn8+B08vsov-iOpD=eQEiPN1w@mail.gmail.com>
Subject: Re: [PATCH] [REGRESSION] ovl: Handle ENOSYS when fileattr support is
 missing in lower/upper fs
To:     jkatz@eitmlabs.org
Cc:     =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 18 Jan 2023 at 04:41, Jonathan Katz <jkatz@eitmlabs.org> wrote:

> I believe that I am still having issues occur within Ubuntu 22.10 with
> the 5.19 version of the kernel that might be associated with this
> discussion.  I apologize up front for any faux pas I make in writing
> this email.

No need to apologize.   The fix in question went into v6.0 of the
upstream kernel.  So apparently it's still missing from the distro you
are using.

> An example error from our syslog:
>
> kernel: [2702258.538549] overlayfs: failed to retrieve lower fileattr
> (8020 MeOHH2O
> RecoverySample2-20221219-A-JJL-WebinarHilic10C-TOF-TT54-Neg-1722.d/analysis.tsf,
> err=-38)

Yep, looks like the same bug.

Thanks,
Miklos
