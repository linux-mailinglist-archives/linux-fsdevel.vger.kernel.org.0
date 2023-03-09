Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B506B2908
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 16:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjCIPqb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 10:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCIPq3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:46:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63EBDCF7E
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Mar 2023 07:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678376744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=37/w03iyTP4+W8iPKFzYFgUbiQ52iRaqgtdVrDhT9xs=;
        b=PSwkJ2jfh/Q1wzU1FQELNbWABHXie3ElG6EUf/+Yq6PmHZZV4MfcKCONQ6HisW7P8+gOzM
        JZR6vkNX+apuXHF0kH35aLQGUsfeo6s3GQIJzTe0F1MTq9L80+WQ6uIymrkEcjsPjnuZMB
        pmyuOkN4Ye6aOxlfy+P5r5oBywKnPwU=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-q5BU8o_rMSm47LOmU3POiQ-1; Thu, 09 Mar 2023 10:45:43 -0500
X-MC-Unique: q5BU8o_rMSm47LOmU3POiQ-1
Received: by mail-io1-f70.google.com with SMTP id a21-20020a5d9595000000b0074c9dc19e16so1018148ioo.15
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Mar 2023 07:45:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678376743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37/w03iyTP4+W8iPKFzYFgUbiQ52iRaqgtdVrDhT9xs=;
        b=qFKL2eTLBpfNcRwg4qIA5eObaZeRwPauDh9EC8mswtuF+LpZuIvJtz+1T37hXl5M+E
         y0SZ0232Xf0XXIeTDuGZruv3sihRApMhnXA886RZNUPJZpK9tv4sK4PinLe5Q7jN0Rqj
         xn2omAOcMHkG3uz7fqHcEBEQlryTQWwqG3TIKeH2BHjc+Gg68MmVAw5tsyh5leiUsAfb
         gncSsRkI1k5KzcOlTzAGOe9f2wfXxA4/i5Vni89ehVUG52DdM8LP7Qui+L/nCenaFjvq
         L7y39yrDW3AVcihn4athYOub5cRxeD/y+jwoRTEUECiAaWPnnB6Vv3/ceTOQjyHe8C3t
         1ktg==
X-Gm-Message-State: AO0yUKUjJH7Dy1yq+Iz4lCqdgDnGDZIe0QXoBxhkQsVfAoKfPr2nrFcB
        6ftDFHd2u6eVmyWCWMYXnvJHOHlFtum2aybb1KfCwR73qkSSN23To8XU+uA0jk9dLbf5CIkOLmm
        iul6RqUArTIWaA1UzSX4DwreEKo4G/P7LDm5vnYzB3g==
X-Received: by 2002:a02:aa1c:0:b0:3b4:42bd:bec with SMTP id r28-20020a02aa1c000000b003b442bd0becmr11003175jam.4.1678376743051;
        Thu, 09 Mar 2023 07:45:43 -0800 (PST)
X-Google-Smtp-Source: AK7set8QBRuryYFdirBo6eHZdfY2571MUkP1FwqMyqR1gOwhXmwSuzQmRXV2DIONkq+83p0UnSvSoKwmFcBwJVN7bHM=
X-Received: by 2002:a02:aa1c:0:b0:3b4:42bd:bec with SMTP id
 r28-20020a02aa1c000000b003b442bd0becmr11003168jam.4.1678376742785; Thu, 09
 Mar 2023 07:45:42 -0800 (PST)
MIME-Version: 1.0
References: <CAL7ro1GQcs28kT+_2M5JQZoUN6KHYmA85ouiwjj6JU+1=C-q4g@mail.gmail.com>
 <CAJfpeguTqXKuBcR3ZBbpWTPTbhnLja0QkBz3ASa4mgaw+A4-rQ@mail.gmail.com>
In-Reply-To: <CAJfpeguTqXKuBcR3ZBbpWTPTbhnLja0QkBz3ASa4mgaw+A4-rQ@mail.gmail.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Thu, 9 Mar 2023 16:45:31 +0100
Message-ID: <CAL7ro1FZKNa1vMJ0CLsGr0Wcg=TSm_2Ehso=adQEVnn3G5i=xQ@mail.gmail.com>
Subject: Re: WIP: verity support for overlayfs
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 9, 2023 at 3:59=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Wed, 8 Mar 2023 at 16:29, Alexander Larsson <alexl@redhat.com> wrote:
> >
> > As was recently discussed in the various threads about composefs we
> > want the ability to specify a fs-verity digest for metacopy files,
> > such that the lower file used for the data is guaranteed to have the
> > specified digest.
> >
> > I wrote an initial version of this here:
> >
> >   https://github.com/alexlarsson/linux/tree/overlay-verity
> >
> > I would like some feedback on this approach. Does it make sense?
> >
> > For context, here is the main commit text:
> >
> > This adds support for a new overlay xattr "overlay.verity", which
> > contains a fs-verity digest. This is used for metacopy files, and
> > whenever the lowerdata file is accessed overlayfs can verify that
> > the data file fs-verity digest matches the expected one.
> >
> > By default this is ignored, but if the mount option "verity_policy" is
> > set to "validate" or "require", then all accesses validate any
> > specified digest. If you use "require" it additionally fails to access
> > metacopy file if the verity xattr is missing.
> >
> > The digest is validated during ovl_open() as well as when the lower fil=
e
> > is copied up. Additionally the overlay.verity xattr is copied to the
> > upper file during a metacopy operation, in order to later do the valida=
tion
> > of the digest when the copy-up happens.
>
> Hmm, so what exactly happens if the file is copied up and then
> modified?  The verification will fail, no?

When we do a meta-copy-up we need to look at the data file and
synthesize an overlay.verity xattr in the upper dir based on the
existing fs-verity diges. At least if the file has fs-verity enabled.
And indeed, in the verify_policy=3Drequired case, if there is no
fs-verity in the lower file we should fall back to a full copy-up
instead of a metacopy-up, or we will end up with a metacopy we can't
validate.

However, if you actually modify a file I don't really see the problem,
you will get a non-verified upper layer file with the changes. It will
not fail validation because it is at that point not validated. Really
we can only expect to validate the lower layers.


--
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

