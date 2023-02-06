Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9636568C742
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 21:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjBFUGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 15:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjBFUGt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:06:49 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4361F5DD;
        Mon,  6 Feb 2023 12:06:49 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id b11so2375875uae.4;
        Mon, 06 Feb 2023 12:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+xkGpV2J5Cx97bCAdhXVZN95dnWTCs3vHPBvG3vZkgI=;
        b=GLdhYnDq+SeaOsNFfDPrvckcxwWAkoLiZUGMofqjsmbWPtG4my6gVt93c6khDuyndp
         h0CvwGAI2hzg3MS+6jRplijyFRghMmphT45tNmdOonin3WpdG0QvNOW/9H8FFmma3iNU
         FEAVpZeMyL3lkdBAbM1cf8HhwJ+d4/6sIzwMumACkmWXVCGGrPqpFbrcH31Ckan7cANJ
         WgQYGBJtaO365s9y6gkh0S4AiSMxX08GnqOi8fEkQkkVdegMdlpe1vhdQ9JrcsIq4IwE
         xpjiFSd7XyKttFONU66daIX82VmELgJ4QZKsgvFarKNxMDXvQp12vfW7BVc5ZB196Dwb
         AL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xkGpV2J5Cx97bCAdhXVZN95dnWTCs3vHPBvG3vZkgI=;
        b=fvWYAcHGiCyLkgpwtkHYK3rl8W4cQi9JcUNjBCtUo9cQXVmbjwYNM9NFf8fWh4wuJL
         JSmiW7OuNKTrR0f0o2UHmlMB/Jq7c6PTKWx5QC5j7pCjYBEAHMuSjBw7f7pSadwDqZft
         iiRzaGhhZIv8qInNvCMp11xJU8Yow4IhZDjflypYWfw+kFaAOeDdO26oDB2RgigtQlo3
         drVZptf/5RiarcsD5NAbjnJdJWTfGb6Ro4jYtnqQGEn1ZMytdu4JY0OaDzsxO0yscfv3
         Hi1yudyKKw948BzrAMTWKBx/mjaoAnIX2dz2bCsMr9xdnG/4I+oJrue4xqzw/k3UfFJq
         RhtA==
X-Gm-Message-State: AO0yUKW7NnAGmdnomATL01nihpFq5xE/8P5oFw6ttqyGEFePiON3xwXt
        kDRELCXvy1ap7LZ6E7Ht7FBkRFdFKw1PqpdK8Tk=
X-Google-Smtp-Source: AK7set8WyoBT5Inpy/MKmFd1oJQhy1sDtq2NeLfQ/J0rms1tT9l3kaPutniAOte6912JclDaYY6wcr0JYv53Ch7ypFU=
X-Received: by 2002:ab0:7598:0:b0:683:9503:fd65 with SMTP id
 q24-20020ab07598000000b006839503fd65mr121853uap.13.1675714008063; Mon, 06 Feb
 2023 12:06:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674227308.git.alexl@redhat.com> <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
 <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
 <b8601c976d6e5d3eccf6ef489da9768ad72f9571.camel@redhat.com>
 <e840d413-c1a7-d047-1a63-468b42571846@linux.alibaba.com> <2ef122849d6f35712b56ffbcc95805672980e185.camel@redhat.com>
 <8ffa28f5-77f6-6bde-5645-5fb799019bca@linux.alibaba.com> <51d9d1b3-2b2a-9b58-2f7f-f3a56c9e04ac@linux.alibaba.com>
 <071074ad149b189661681aada453995741f75039.camel@redhat.com>
 <0d2ef9d6-3b0e-364d-ec2f-c61b19d638e2@linux.alibaba.com> <de57aefc-30e8-470d-bf61-a1cca6514988@linux.alibaba.com>
 <CAOQ4uxgS+-MxydqgO8+NQfOs9N881bHNbov28uJYX9XpthPPiw@mail.gmail.com>
 <9c8e76a3-a60a-90a2-f726-46db39bc6558@linux.alibaba.com> <02edb5d6-a232-eed6-0338-26f9a63cfdb6@linux.alibaba.com>
 <3d4b17795413a696b373553147935bf1560bb8c0.camel@redhat.com>
 <CAOQ4uxjNmM81mgKOBJeScnmeR9+jG_aWvDWxAx7w_dGh0XHg3Q@mail.gmail.com>
 <5fbca304-369d-aeb8-bc60-fdb333ca7a44@linux.alibaba.com> <CAOQ4uximQZ_DL1atbrCg0bQ8GN8JfrEartxDSP+GB_hFvYQOhg@mail.gmail.com>
 <CAJfpegtRacAoWdhVxCE8gpLVmQege4yz8u11mvXCs2weBBQ4jg@mail.gmail.com>
 <CAOQ4uxiW0=DJpRAu90pJic0qu=pS6f2Eo7v-Uw3pmd0zsvFuuw@mail.gmail.com>
 <CAJfpeguczp-qOWJgsnKqx6CjCJLV49j1BOWs0Yxv93VUsTZ9AQ@mail.gmail.com>
 <CAOQ4uxg=1zSyTBZ-0_q=5PVuqs=4yQiMQJr1tNk7Kytxv=vuvA@mail.gmail.com> <CAJfpeguq2BH_4WQDb=eGkoVGOUVhNhMRicT4b_PN-t6FTBFUoQ@mail.gmail.com>
In-Reply-To: <CAJfpeguq2BH_4WQDb=eGkoVGOUVhNhMRicT4b_PN-t6FTBFUoQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 6 Feb 2023 22:06:34 +0200
Message-ID: <CAOQ4uxhHnvznz_wN7OdaYeF0WSMV-S87Az4uLRoREPe8oTM8eQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Alexander Larsson <alexl@redhat.com>, gscrivan@redhat.com,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>
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

On Mon, Feb 6, 2023 at 9:32 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, 6 Feb 2023 at 18:16, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > it's not overlay{erofs+erofs}
> > it's overlay{erofs+ext4} (or another fs-verity [1] supporting fs)
> > the lower layer is a mutable fs with /objects/ dir containing
> > the blobs.
> >
> > The way to ensure the integrity of erofs is to setup dm-verity at
> > erofs mount time.
> >
> > The way to ensure the integrity of the blobs is to store an fs-verity
> > signature of each blob file in trusted.overlay.verify xattr on the
> > metacopy and for overlayfs to enable fsverity on the blob file before
> > allowing access to the lowerdata.
> >
> > At least this is my understanding of the security model.
>
> So this should work out of the box, right?
>

Mostly. IIUC, overlayfs just needs to verify the signature on
open to fulfill the chain of trust, see cfs_open_file():
https://lore.kernel.org/linux-fsdevel/9b799ec7e403ba814e7bc097b1e8bd5f7662d596.1674227308.git.alexl@redhat.com/

Thanks,
Amir.
