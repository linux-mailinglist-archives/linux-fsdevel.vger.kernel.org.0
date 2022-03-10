Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7554D544D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 23:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344295AbiCJWMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 17:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238810AbiCJWMV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:12:21 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD4218A7A4
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 14:11:18 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id bg10so15200476ejb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 14:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9km0i8SFuccdCOVZYquGLNsFmsoS5afCtujPM89debo=;
        b=DkO/8stlw+jpHvI8npwNphLXTcJGdwo5HGKNzsLEQgRJKoqLNqUtQ14rO8YztWtv6H
         bAxp1qhPNeH3fynL0mw7GJsoth6uZUwOJRQT3vdvrEI2RpF54ufTb0yXO3++rTXBespQ
         x5lpjmtoM0L6NN0u9NAmn1YkWynYbmAVkFmqK9RxmA3NcICSIgE9yAEScpXJQ4VdYV+H
         qGhCj6APjWltlRC5qBmw4vuoMHC3nKYsIbGWFHWJaXvc4I/QXkVgLDu0Y46f5aCQWnEh
         nBP1d+G1PMaC87QCOjKfloK3Lw9CLGuuIdMcOaJnRc9h+7uDqcwjICH2qyHuewLribm8
         lAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9km0i8SFuccdCOVZYquGLNsFmsoS5afCtujPM89debo=;
        b=jVmj2dD8FI/4oFtXTEZsdh8Sg0lxhdN5BB52q2pQiqYJEt1P9MF+OGmjbCHq5wmg2v
         EJMtz23BIrGia4GEVg9VOxH6Ji3sl9xSTVkTW9JsdlfdL62waz7K2rgSQelpyWKs7NZx
         eOEK8mtlVN69glGaO/uxOiKnk9mtv7Es9kWSYn3fa/uHOK5FCrTZvF5jM/HGShVaErp7
         WzBoGEB4KIjF9tdy71X9sIGoP1/SGhaf/GIwBkfvkTKM7opmpz79WYvTTipGpqQoMfkm
         lYCO80jJrn9OhDOCSrm6My6CvTncTXoZ/A5tqN2P5MhDOTbUzRgI/pq6GBICADmMosRv
         la9A==
X-Gm-Message-State: AOAM533MwErEaiEqtlM56rH+ZnNDP/Q7mJsxVZRyOlfS0TgJMbjgCn0T
        uGcN0/6nIUM0bE5drETvvDT8X1xROk7n6Bnmxjez
X-Google-Smtp-Source: ABdhPJzuqe7pKCSsXOm2hSO3J0hQynYE7R+uH9xz7Xj/FjdVN2m1z54F4ZugUJ/pEbmhBHGUILXKrslgjHDns1/T+QA=
X-Received: by 2002:a17:907:216f:b0:6ce:d85f:35cf with SMTP id
 rl15-20020a170907216f00b006ced85f35cfmr6109610ejb.517.1646950277373; Thu, 10
 Mar 2022 14:11:17 -0800 (PST)
MIME-Version: 1.0
References: <20211117015806.2192263-1-dvander@google.com> <CAOQ4uxjjapFeOAFGLmsXObdgFVYLfNer-rnnee1RR+joxK3xYg@mail.gmail.com>
 <Yao51m9EXszPsxNN@redhat.com> <CAOQ4uxjk4piLyx67Ena-FfypDVWzRqVN0xmFUXXPYa+SC4Q-vQ@mail.gmail.com>
 <YapjNRrjpDu2a5qQ@redhat.com> <CAHC9VhQTUgBRBEz_wFX8daSA70nGJCJLXj8Yvcqr5+DHcfDmwA@mail.gmail.com>
 <CA+FmFJA-r+JgMqObNCvE_X+L6jxWtDrczM9Jh0L38Fq-6mnbbA@mail.gmail.com> <CAHC9VhRer7UWdZyizWO4VuxrgQDnLCOyj8LO7P6T5BGjd=s9zQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRer7UWdZyizWO4VuxrgQDnLCOyj8LO7P6T5BGjd=s9zQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Mar 2022 17:11:05 -0500
Message-ID: <CAHC9VhQkLSBGQ-F5Oi9p3G6L7Bf_jQMWAxug_G4bSOJ0_cYXxQ@mail.gmail.com>
Subject: Re: [PATCH v19 0/4] overlayfs override_creds=off & nested get xattr fix
To:     Vivek Goyal <vgoyal@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Anderson <dvander@google.com>
Cc:     Mark Salyzyn <salyzyn@android.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Stultz <john.stultz@linaro.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        kernel-team <kernel-team@android.com>, selinux@vger.kernel.org,
        paulmoore@microsoft.com, luca.boccassi@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 9, 2022 at 4:13 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Mar 1, 2022 at 12:05 AM David Anderson <dvander@google.com> wrote=
:
> > On Mon, Feb 28, 2022 at 5:09 PM Paul Moore <paul@paul-moore.com> wrote:

...

> >> This patchset may not have been The Answer, but surely there is
> >> something we can do to support this use-case.
> >
> > Yup exactly, and we still need patches 3 & 4 to deal with this. My curr=
ent plan is to try and rework our sepolicy (we have some ideas on how it co=
uld be made compatible with how overlayfs works). If that doesn't pan out w=
e'll revisit these patches and think harder about how to deal with the cohe=
rency issues.
>
> Can you elaborate a bit more on the coherency issues?  Is this the dir
> cache issue that is alluded to in the patchset?  Anything else that
> has come up on review?
>
> Before I start looking at the dir cache in any detail, did you have
> any thoughts on how to resolve the problems that have arisen?

David, Vivek, Amir, Miklos, or anyone for that matter, can you please
go into more detail on the cache issues?  I *think* I may have found a
potential solution for an issue that could arise when the credential
override is not in place, but I'm not certain it's the only issue :)

There is motivation on our part to try and get the
"override_creds=3Doff" portion of the patchset working and suitable for
upstreaming, but I need some help in making sure I understand all the
objections/problems.

--=20
paul-moore.com
