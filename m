Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A565067B8FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 19:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbjAYSHm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 13:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjAYSHl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:07:41 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC59C1716F;
        Wed, 25 Jan 2023 10:07:39 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id c21so9605476vkn.10;
        Wed, 25 Jan 2023 10:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qM7kiuRwQe1g9m3XMwcQMXA/t3ho0zA60PXcbSeaBhI=;
        b=fT+aa6N02Pkl/fbQ/kW3yJcYpRJFk2o7pcuA7glQwdC83q+73YcoRU7WywZM7azBXr
         6qwz3qsDBYqiZlcz0rrVkWCDOBmWGy8fG01RimEZ0xKpGcB/Hh8Wn/SzM0ATs74MnTrb
         y8SjcWelNYvZppo6pCt88JAA13oWMazKLPe9lCuSZTCTUMqPFufslhR813qh+Aitq7g3
         k7kOny/y5aj9Q9VF4CbZybjdvXtLKgjzqTo/miuu1GnBG5xHeXGIBIcWZyJiKY7te2c8
         RuMXfHzixCyTfxypRrX3IOr8NQjVWtd90m2YSigaAFPEfGV+HwLfklcPSclxc32HfCeB
         BtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qM7kiuRwQe1g9m3XMwcQMXA/t3ho0zA60PXcbSeaBhI=;
        b=ovSbZkn1wyMkmo25plTOsEw7Elk+hyjOurKUdj9x8MRMJbtw7wXJU/IWdmgF5nSXTs
         0e7b1/Vj629DsGthxjvd0lzVtu60FR0dYxHyC+4lyS7FqtJLSI9jWKVDokz1QWvdHlJE
         tPrvVuul6RGth7oshiauhSO3qt8x2OptSd4AkuvvyFUJeEbETVBwrEnIPksVeUwUUxq5
         R3pAl+XhSPxzR2BfEfPEykW9mVBN5aWMKtW57+zPCsYW3dPFzeaQWWMu1RydUdAh4ZUq
         Qq6Ei/leqxJOdQ/tiWPvShazPHjGFn1Phng6LzpW74m0tVlkoB4oXxt7QZREDCUlAPCn
         goiw==
X-Gm-Message-State: AFqh2koJtwfpzLRxi3vSc/QaGnoQuEc0r3G+9F9rNEb+fyxopZw/cBK8
        pOwZ8MUxsRJuiJ3fcwoQ0t/YIdMkd1rX1m5yQmCnchMD
X-Google-Smtp-Source: AMrXdXuj19/f+u/5mrylRroHZVaYwXjn0LMc76xVKN+dasjd/frlcGHq3a9QMQ+t6VhPxryqzicp6TXHf/dB5Lh73ek=
X-Received: by 2002:a1f:91d4:0:b0:3db:104:6d13 with SMTP id
 t203-20020a1f91d4000000b003db01046d13mr4343547vkd.25.1674670058841; Wed, 25
 Jan 2023 10:07:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674227308.git.alexl@redhat.com> <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
 <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
 <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
 <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
 <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
 <20230125041835.GD937597@dread.disaster.area> <CAOQ4uxhqdjRbNFs_LohwXdTpE=MaFv-e8J3D2R57FyJxp_f3nA@mail.gmail.com>
 <87wn5ac2z6.fsf@redhat.com> <CAOQ4uxiPLHHnr2=XH4gN4bAjizH-=4mbZMe_sx99FKuPo-fDMQ@mail.gmail.com>
 <87o7qmbxv4.fsf@redhat.com> <CAOQ4uximBLqXDtq9vDhqR__1ctiiOMhMd03HCFUR_Bh_JFE-UQ@mail.gmail.com>
 <87fsbybvzq.fsf@redhat.com>
In-Reply-To: <87fsbybvzq.fsf@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Jan 2023 20:07:26 +0200
Message-ID: <CAOQ4uxgos8m72icX+u2_6Gh7eMmctTTt6XZ=BRt3VzeOZH+UuQ@mail.gmail.com>
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

> >> I previously mentioned my wish of using it from a user namespace, the
> >> goal seems more challenging with EROFS or any other block devices.  I
> >> don't know about the difficulty of getting overlay metacopy working in a
> >> user namespace, even though it would be helpful for other use cases as
> >> well.
> >>
> >
> > There is no restriction of metacopy in user namespace.
> > overlayfs needs to be mounted with -o userxattr and the overlay
> > xattrs needs to use user.overlay. prefix.
>
> if I specify both userxattr and metacopy=on then the mount ends up in
> the following check:
>
> if (config->userxattr) {
>         [...]
>         if (config->metacopy && metacopy_opt) {
>                 pr_err("conflicting options: userxattr,metacopy=on\n");
>                 return -EINVAL;
>         }
> }
>

Right, my bad.

> to me it looks like it was done on purpose to prevent metacopy from a
> user namespace, but I don't know the reason for sure.
>

With hand crafted metacopy, an unpriv user can chmod
any files to anything by layering another file with different
mode on top of it....

Not sure how the composefs security model intends to handle
this scenario with userns mount, but it sounds like a similar
problem.

Thanks,
Amir.
