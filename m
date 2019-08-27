Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAB69EC79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 17:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfH0PZ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 11:25:58 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45877 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbfH0PZ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:25:58 -0400
Received: by mail-qt1-f196.google.com with SMTP id k13so21626188qtm.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2019 08:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=UYsPsgGfUckufMeEUec2JwS26x9RnxC68LqfuMsCJb4=;
        b=Q1NhQkKVxAJlcKICo7k5uO5wNqrqJBvNZeECLILQCFrPYYBxQy90++0mMzPVwDn4S8
         TpWXTq7/bbzvvgU9XibqgTuSn9KYLWVYUi1wr9wQPm0n9tinq18kYuBsi9mSXbnjVrPJ
         LI569nCbjvqAHQkLM+ORs/6pREwitnixakqmoxua+Bv9X29ughQwtfmxM2n/Ma4L3FlZ
         2gjAgAiF2FJcNrKH4g6grpJB8XVrqdboghb2Lp7XhhnM/FOMqhACKeZyzu+PJMkQwCOg
         dU4mOurRaiSuhta9WPdCrG3SSlUO0bBwb96IjQIJajtvjgjxfd4voZ23uY9kZi8KwooA
         lKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=UYsPsgGfUckufMeEUec2JwS26x9RnxC68LqfuMsCJb4=;
        b=eWcWrrz3G/WKOn3tYfYGmt4wjRAkEkhGXOiqZJnx0ww7/GKDvojJX5Wu8RBv0FV2Qs
         cMC9wJQNbp1CeLKOE+8VmItfUHQCzRuXzo6Z4pDDoath2jvK9oMiU0C19OTutMGSJbkx
         Q9zKLPpKXyMKJimjn1DE9w2Vs6D9I95PCB6aMVIk9cUQKso7pOcU6HPj3FKWZPTv+Re/
         5pWcOLI/M5k4BkwJWkYdOKPr2B4BEIyoHpsSBzPjbpepYgB/F87FDNOka/zwm23RF/UV
         JpbnRV+UWqHKD6MchKwu2keo+9D6HjVwtVd9h0f9HCh8Qyd6DMe5vIAZO3hTuvyfga3I
         EaKA==
X-Gm-Message-State: APjAAAVErppxvsedFQzBf1o9u8DC2ViyzTP7rQz670ex0hoandOyl/jp
        lk0b72iJZVEMLmqMyTmFZhBeFw==
X-Google-Smtp-Source: APXvYqyz2z2LwgJPPM/lvqPrfZk6dZuilv+UvVvnsCTjgYLjcKlMdJnfhv4XQUcExaXeKHLvVSiVZw==
X-Received: by 2002:ac8:7b2a:: with SMTP id l10mr624196qtu.115.1566919557007;
        Tue, 27 Aug 2019 08:25:57 -0700 (PDT)
Received: from tpx230-nicolas (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id p201sm7988339qke.6.2019.08.27.08.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 08:25:55 -0700 (PDT)
Message-ID: <ed170df34f3dadc941f509a84730fe94d7c6a3a4.camel@ndufresne.ca>
Subject: Re: [PATCH 6/7] misc: bcm-vk: add Broadcom Valkyrie driver
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Arnd Bergmann <arnd@arndb.de>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Date:   Tue, 27 Aug 2019 11:25:53 -0400
In-Reply-To: <CAK8P3a1WBkmXbJx=rZMumxn7EN4bmA1AdZEgrWBVyQ3XNngU6Q@mail.gmail.com>
References: <20190822192451.5983-1-scott.branden@broadcom.com>
         <20190822192451.5983-7-scott.branden@broadcom.com>
         <CAK8P3a1WBkmXbJx=rZMumxn7EN4bmA1AdZEgrWBVyQ3XNngU6Q@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-Q6lkT7+PAzBRKQ8Zlvb3"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-Q6lkT7+PAzBRKQ8Zlvb3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mardi 27 ao=C3=BBt 2019 =C3=A0 16:14 +0200, Arnd Bergmann a =C3=A9crit :
> On Thu, Aug 22, 2019 at 9:25 PM Scott Branden
> <scott.branden@broadcom.com> wrote:
> > Add Broadcom Valkyrie driver offload engine.
> > This driver interfaces to the Valkyrie PCIe offload engine to perform
> > should offload functions as video transcoding on multiple streams
> > in parallel.  Valkyrie device is booted from files loaded using
> > request_firmware_into_buf mechanism.  After booted card status is updat=
ed
> > and messages can then be sent to the card.
> > Such messages contain scatter gather list of addresses
> > to pull data from the host to perform operations on.
> >=20
> > Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> > Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
> > Signed-off-by: James Hu <james.hu@broadcom.com>
>=20
> Can you explain the decision to make this is a standalone misc driver
> rather than hooking into the existing framework in drivers/media?
>=20
> There is an existing interface that looks like it could fit the hardware
> in include/media/v4l2-mem2mem.h. Have you considered using that?
>=20
> There is also support for video transcoding using GPUs in
> driver/gpu/drm/, that could also be used in theory, though it sounds
> like a less optimal fit.

I believe that a major obstacle with this driver is usability. Even
though I have read through, I believe it's just impossible for anyone
to actually write Open Source userspace for it. The commit message does
not even try to help in this regard.

Note that depending on the feature your transcoder has, there is also
the option to model it around the media controller. That is notably
useful for certain transcoders that will also do scaling and produce
multiple streams (for adaptive streaming usecases were you want to
share a single decoder).

An 1 to 1 transcoder modeled around m2m would eventually required
documentation so that other transcoder can be implemented in a way that
they would share the same userspace. This is currently being worked on
for m2m encoder and decoders (including state-less variants).

regards,
Nicolas



--=-Q6lkT7+PAzBRKQ8Zlvb3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXWVLgQAKCRBxUwItrAao
HOWtAJ9PEGIeS4lUvTlk5tzICIY0ocFUrgCfZ7hh+138dIIu9Aq/IBhBjjcgRwg=
=7DWJ
-----END PGP SIGNATURE-----

--=-Q6lkT7+PAzBRKQ8Zlvb3--

