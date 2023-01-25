Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB0867B2BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 13:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbjAYMrO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 07:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjAYMrN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:47:13 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5942F12064;
        Wed, 25 Jan 2023 04:47:12 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id t190so592070vkb.13;
        Wed, 25 Jan 2023 04:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xuJCVae0wZPBFJJ+xEvuYUsjpElblgfBQtf0Snj7uaE=;
        b=binLEBOFl/V0Lcs8L7SXg8nwuDKoSft3qF6hubrKaF2U3q9aHF97CcKsi76cr3ZaNt
         fqy+FJyGby1vKbJXwOTurCQB+orGo4V05vyA8ZBKoRXdYT1BNDarboTaCUnREfSVPh3f
         yD9pA9SrRkET9h2kHWIAknGEBQ05caGZ3eWjBfqr4K86Oh9fKPJss4WH3b1NiPensfCQ
         21WzxEc3fWKqF+RDDRuwRIdQbpM3F4xmK5syXjD7hCxci1bCUuUR2DvH2I4hF4EOhdv8
         Cd+391GuzGPJ7ISzyQCOrFDIehj9WUc5GvWLbI4sK/IXKVBlNKObxdec9NBKaruPOZLf
         rEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xuJCVae0wZPBFJJ+xEvuYUsjpElblgfBQtf0Snj7uaE=;
        b=q/4I4Q3knuzxi6Yy6npuNc7oi9x0mATkK+9p+yFmQbJ6dCDEBZeKgtuccQ63ML1K1A
         WJ/LkV01vFwDbCXAXlyX88qQK8pfebmus4r9y7QVUtAYmhL4yre5zoRyGuYw/YRZb3pr
         Zqk5NUizoChQwS78uRXn8zhzoLAGOuZYeHuuvZaZ75u/T1Q5lgv/ETkum++zS87ouUhB
         zvB7Vue2+V2YzMHqu3R4/tM2KlAcauXvxHvLqB2cATY3XcmxXg4GEGPm8BQIqlU2o3Qk
         FrXZH0ibe5RCcldiRMDlPylX53ekh9ZAplKX4TK7b1e/vFEpGIe6jM6FhMjY9J5bTE8v
         mPKA==
X-Gm-Message-State: AFqh2kqpnES/KYBLwfajR+SuJ3wjsRZa5mGVAjIkLvl1rmlUd4CTjFZB
        rwoc8Iber3pw3jXaUknREKZPAsPVEtztAEDXz4A=
X-Google-Smtp-Source: AMrXdXsFaVttlgfRFchi5Y3frmCvCwL6XlPwVQchnyoJaO81QVDTKxmXEvd+eicOYg0qjn0o5e39s5cNYRtxhi12CbU=
X-Received: by 2002:a1f:ad56:0:b0:3bc:8497:27fd with SMTP id
 w83-20020a1fad56000000b003bc849727fdmr3972889vke.15.1674650831457; Wed, 25
 Jan 2023 04:47:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674227308.git.alexl@redhat.com> <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
 <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
 <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
 <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
 <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
 <20230125041835.GD937597@dread.disaster.area> <CAOQ4uxhqdjRbNFs_LohwXdTpE=MaFv-e8J3D2R57FyJxp_f3nA@mail.gmail.com>
 <87wn5ac2z6.fsf@redhat.com> <CAOQ4uxiPLHHnr2=XH4gN4bAjizH-=4mbZMe_sx99FKuPo-fDMQ@mail.gmail.com>
 <87o7qmbxv4.fsf@redhat.com>
In-Reply-To: <87o7qmbxv4.fsf@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Jan 2023 14:46:59 +0200
Message-ID: <CAOQ4uximBLqXDtq9vDhqR__1ctiiOMhMd03HCFUR_Bh_JFE-UQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> >
> > Based on Alexander's explanation about the differences between overlayfs
> > lookup vs. composefs lookup of a regular "metacopy" file, I just need to
> > point out that the same optimization (lazy lookup of the lower data
> > file on open)
> > can be done in overlayfs as well.
> > (*) currently, overlayfs needs to lookup the lower file also for st_blocks.
> >
> > I am not saying that it should be done or that Miklos will agree to make
> > this change in overlayfs, but that seems to be the major difference.
> > getxattr may have some extra cost depending on in-inode xattr format
> > of erofs, but specifically, the metacopy getxattr can be avoided if this
> > is a special overlayfs RO mount that is marked as EVERYTHING IS
> > METACOPY.
> >
> > I don't expect you guys to now try to hack overlayfs and explore
> > this path to completion.
> > My expectation is that this information will be clearly visible to anyone
> > reviewing future submission, e.g.:
> >
> > - This is the comparison we ran...
> > - This is the reason that composefs gives better results...
> > - It MAY be possible to optimize erofs/overlayfs to get to similar results,
> >   but we did not try to do that
> >
> > It is especially important IMO to get the ACK of both Gao and Miklos
> > on your analysis, because remember than when this thread started,
> > you did not know about the metacopy option and your main argument
> > was saving the time it takes to create the overlayfs layer files in the
> > filesystem, because you were missing some technical background on overlayfs.
>
> we knew about metacopy, which we already use in our tools to create
> mapped image copies when idmapped mounts are not available, and also
> knew about the other new features in overlayfs.  For example, the
> "volatile" feature which was mentioned in your
> Overlayfs-containers-lpc-2020 talk, was only submitted upstream after
> begging Miklos and Vivek for months.  I had a PoC that I used and tested
> locally and asked for their help to get it integrated at the file
> system layer, using seccomp for the same purpose would have been more
> complex and prone to errors when dealing with external bind mounts
> containing persistent data.
>
> The only missing bit, at least from my side, was to consider an image
> that contains only overlay metadata as something we could distribute.
>

I'm glad that I was able to point this out to you, because now the comparison
between the overlayfs and composefs options is more fair.

> I previously mentioned my wish of using it from a user namespace, the
> goal seems more challenging with EROFS or any other block devices.  I
> don't know about the difficulty of getting overlay metacopy working in a
> user namespace, even though it would be helpful for other use cases as
> well.
>

There is no restriction of metacopy in user namespace.
overlayfs needs to be mounted with -o userxattr and the overlay
xattrs needs to use user.overlay. prefix.

w.r.t. the implied claim that composefs on-disk format is simple enough
so it could be made robust enough to avoid exploits, I will remain
silent and let others speak up, but I advise you to take cover,
because this is an explosive topic ;)

Thanks,
Amir.
