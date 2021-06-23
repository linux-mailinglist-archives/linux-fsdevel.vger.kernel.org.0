Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5523E3B1ADD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 15:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFWNPz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 09:15:55 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:43682 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhFWNPw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:15:52 -0400
Received: by mail-wr1-f43.google.com with SMTP id a13so2589196wrf.10;
        Wed, 23 Jun 2021 06:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=6aAYleE/LhnzZ0Wq/X+zwnDBTwA+HUGZwD3I6d4qoTk=;
        b=fhpAjaaGfa72r4otxDFn79NVgaAPX+79cdVPqgEQ9XXEheEy7Onv5qV6R7EHcH6Pbi
         n4Psu32cJ/PuZkuTrDBMIWQ2aQHB8lQSoJr6FlAKze+3v8INQ9ZKAMI/zn4g7h1A2QIT
         mEpf9vHSCkE3sM+Lemm2xE2oDbnBtfUUmePeHjezgOqyNCgKTpTIASnR0wKiRh7vwpCP
         yDU/7oBNX3ayNV3ozc3Jvl3nrK10J3FhrdazPaxZ84y15uDcVN8QPPnRt9Bkp6ykilcF
         +OosMJTwOuGCKw/vJQevkL189y+wgNY4sUds4qq+iJsfFBODBEjRcALGT7xJiWc8WvC1
         YlKQ==
X-Gm-Message-State: AOAM530aHqzKpdPGzOkT4IXnAfpNPY5qjksCJ9Azq3cHAdlFE+JuF4Q5
        DIuod4y2d4CIaVYVHaTf3a4=
X-Google-Smtp-Source: ABdhPJzy9a+URsFwwYb7Q3/kcbKTsWPhlFX7NG1Po9O5JEWl97JZ+AcsMcr6N0j7pUdmG6sWxAH26A==
X-Received: by 2002:adf:db42:: with SMTP id f2mr11413828wrj.410.1624454008140;
        Wed, 23 Jun 2021 06:13:28 -0700 (PDT)
Received: from localhost ([137.220.125.106])
        by smtp.gmail.com with ESMTPSA id o2sm2887007wrp.53.2021.06.23.06.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 06:13:27 -0700 (PDT)
Message-ID: <bbd3d100ee997431b2905838575eb4bdec820ad3.camel@debian.org>
Subject: Re: [PATCH v3 6/6] loop: increment sequence number
From:   Luca Boccassi <bluca@debian.org>
To:     Christoph Hellwig <hch@infradead.org>,
        Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier Gonz??lez <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Date:   Wed, 23 Jun 2021 14:13:25 +0100
In-Reply-To: <YNMhwLMr7DiNdqC/@infradead.org>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
         <20210623105858.6978-7-mcroce@linux.microsoft.com>
         <YNMhwLMr7DiNdqC/@infradead.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-mxAzQuzzUw5nnkmWVfyT"
User-Agent: Evolution 3.30.5-1.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-mxAzQuzzUw5nnkmWVfyT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-06-23 at 12:57 +0100, Christoph Hellwig wrote:
> On Wed, Jun 23, 2021 at 12:58:58PM +0200, Matteo Croce wrote:
> > From: Matteo Croce <mcroce@microsoft.com>
> >=20
> > On a very loaded system, if there are many events queued up from multip=
le
> > attach/detach cycles, it's impossible to match them up with the
> > LOOP_CONFIGURE or LOOP_SET_FD call, since we don't know where the posit=
ion
> > of our own association in the queue is[1].
> > Not even an empty uevent queue is a reliable indication that we already
> > received the uevent we were waiting for, since with multi-partition blo=
ck
> > devices each partition's event is queued asynchronously and might be
> > delivered later.
> >=20
> > Increment the disk sequence number when setting or changing the backing
> > file, so the userspace knows which backing file generated the event:
>=20
> Instead of manually incrementing the sequence here, can we make loop
> generate the DISK_EVENT_MEDIA_CHANGE event on a backing device (aka
> media) change?

Hi,

This was answered in the v1 thread:

https://lore.kernel.org/linux-fsdevel/20210315201331.GA2577561@casper.infra=
dead.org/t/#m8a677028572e826352cbb1e19d1b9c1f3b6bff4b

The fundamental issue is that we'd be back at trying to correlate
events to loopdev instances, which does not work reliably - hence this
patch series. With the new ioctl, we can get the id immediately and
without delay when we create the device, with no possible races. Then
we can handle events reliably, as we can correlate correctly in all
cases.

--=20
Kind regards,
Luca Boccassi

--=-mxAzQuzzUw5nnkmWVfyT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmDTM3UACgkQKGv37813
JB4iiBAAh8dDexmraGaO7SQsP46DlEyznJWYgdFAe5nHENVy+whET347gGEt3VeB
GDJOIHZuZ9q/dNdnqBaXA3Hek8tSdOcyFUVuZ//WDs2w7SDe5DxACdAiHuTcflvG
pyXvH1MDuxMa0wGCLXZ8qepsqq8mcZzL++jCszmGSCC/wSfHL9t4ALN0ggotUzdW
EnCdQX7hbpnA+g1CQpdiEffoZzeqBWAijchJ81X8T2HyQzFGh3VTfU3JiszZzprt
0C1QuMkcfGM+yjItwZlwfg9GTZ3DZXIHdmuFsjngoOn1cdK/VEra1nUk7fdre/PP
J8fWQ8vgwnxkm/RUq0F6HYreyyVzm/+VIBflZhhQiIafLClnEPgLfcffwlkQ02aW
fulLRbvLHQeP0WUWi7ciRNIB4ZaX8eCKx+nG9GEWUZzwNDrP0R925NkVe+sD5vId
e427CftslZIVIy4GNGcwF/M4VbWdXr3kUrqOH+SWGxc2lMaje9U0JJQt12BobfKG
3Theu+uDi0NqzvUSv6jqZBhyFij1GtJu4VAv4oTpo35N+O84HI5ml2PU7iLKvY0m
3m3ahx45g/kAZ/ufC4c63QT1lFSpeCma2TagabQXynHnxGwOyERGdaDtb9fXlXNi
QZR/guYk/TMKfX1N3KrHEAWRyWwWH4IbAnCBZxhr74fEEY02wJs=
=sy9m
-----END PGP SIGNATURE-----

--=-mxAzQuzzUw5nnkmWVfyT--
