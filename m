Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE52F31623F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 10:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhBJJaw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 04:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhBJJ2n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:28:43 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80599C061574;
        Wed, 10 Feb 2021 01:28:03 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id n2so1173845iom.7;
        Wed, 10 Feb 2021 01:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=NTwYbPlnwjr/4U1k4zJKPsXSZtSc51AAjh+Aot+HfzA=;
        b=hHvBZmTVaXKcA8YQ1iaTAUfBzV8BeigfL5B/DmnCInK3LcLA1FW+8RTTiJrZ7CNVCV
         SOSd4RR9+A9e12oPkMPvywW+GPPH+oFG29Pc91S/KvekXEq9ULye7N0CPGsgqJpTjvwc
         WemZLc+rdjqwTsQ6yCAEXfMpEEyg36aS6zXvbjExy56UU8fQBV6pXQkRHSRJu/TrfffG
         WoM6Y6x+K+Mw8y1dtvFjOOTETVV4URXS/Lrx7JZJu0YOCwJgXAEmp3dexlvAf6o1ITZJ
         TcJXvZgFO/kESrTe0UoW+ki2vFBRf53SRBT0ooecG181tHyngoNNEKRNiGBWZlm44QG9
         II5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=NTwYbPlnwjr/4U1k4zJKPsXSZtSc51AAjh+Aot+HfzA=;
        b=gU9AGRfhcvrtQZrDeN+VWjMAykoVaS2sTys0kqrVBTcZIXURKxqLgqdqWsK+Eqknyq
         hzbLS7R9DR6ysPTq7NJmAspLjclUaPEPgOLMLIoxUGDpJNcdEcDl6prNkImCBo540t1d
         O/3djCLbIQHEB3ezKjpPrD4bV4MVcvseW0xNpFMp4sFveHYFZMostBETTReZJBDUHdQJ
         fXaS5unPGRKdolbDIZZ7UHInBRzgJJ5dJfUG1BPeyi5YFARBt2fp3V+vt6z/fvnPOwG+
         HulE0cV9q6Fat4PGXjZkZeuFk6Ix5j02VXd1I6FMtLSFsGLT3wXyltwZvtg4hrUoVYk9
         5/fw==
X-Gm-Message-State: AOAM533FGrAOv1O5hZQGIPmyuSK0W9fzKaqCRPsSNFr/0/BIjxdDZ5yl
        YESqQFhFrzqUdthvOj1Ug9K0xkUYvst8Xof5Szc=
X-Google-Smtp-Source: ABdhPJzg6YCVbjut6i3poATewgVGLxIendfOaoudHkYCnRbJ8uqsdz0eBgzzmTDYHA9u5aW+NyXKj1SAWs4QKjemVcU=
X-Received: by 2002:a02:74a:: with SMTP id f71mr2299910jaf.30.1612949282924;
 Wed, 10 Feb 2021 01:28:02 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210209235046epcas1p1416b5b121c0d78bfcb854aab46ea35c2@epcas1p1.samsung.com>
 <000001d6ff3e$62f336d0$28d9a470$@samsung.com> <CA+icZUUFFrEJccHDZPV9nzj7zav-RA53eWqgKkDyvwOxCaKKnQ@mail.gmail.com>
 <001401d6ff68$5acaf360$1060da20$@samsung.com> <CA+icZUW0gS21ns1mVeJ7z-0W8XmfyuhggkwYHRXQjYy0jDZyNw@mail.gmail.com>
In-Reply-To: <CA+icZUW0gS21ns1mVeJ7z-0W8XmfyuhggkwYHRXQjYy0jDZyNw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 10 Feb 2021 10:27:57 +0100
Message-ID: <CA+icZUVmw0FpTTJB8Bv67EAOfuVJ+avNPw8_Vg3m0z_HHHehCQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] exfatprogs-1.1.0 version released
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Sandeen <sandeen@sandeen.net>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicolas Boos <nicolas.boos@wanadoo.fr>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Luca Stefani <luca.stefani.ge1@gmail.com>,
        Matthieu CASTET <castet.matthieu@free.fr>,
        Sven Hoexter <sven@stormbind.net>,
        Ethan Sommer <e5ten.arch@gmail.com>,
        Hyeongseok Kim <hyeongseok@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 10, 2021 at 8:24 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Wed, Feb 10, 2021 at 5:51 AM Namjae Jeon <namjae.jeon@samsung.com> wrote:
>
> > > Hope Sven will do a new release for Debian.
> > > ( Note that Debian/bullseye release  plans "Milestone 2" this Friday, February 12th (see [1] > "Key
> > > release dates" > "[2021-Feb-12] Soft Freeze"). Dunno which impact this might have on this. )
> > I hope he will do it, too!
> >
> > Thanks Sedat:)
>
> I filed Debian Bug #982431 "exfatprogs: Update to version 1.1.0"
>
> - Sedat -
>
> [1] https://bugs.debian.org/982431

Who said Debian GNU/linux has outdated packages :-)?

root# RELEASE="buildd-unstable" ; LC_ALL=C apt-get dist-upgrade -V -t $RELEASE
...
The following packages will be upgraded:
  exfatprogs (1.0.4-1 => 1.1.0-1)
1 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
Need to get 37.2 kB of archives.
After this operation, 61.4 kB of additional disk space will be used.
Do you want to continue? [Y/n]

- Sedat -
