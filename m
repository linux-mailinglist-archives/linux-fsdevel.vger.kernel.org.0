Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA124AAD81
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Feb 2022 03:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381602AbiBFCXo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 21:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244398AbiBFCXn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 21:23:43 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE3BC043186;
        Sat,  5 Feb 2022 18:23:42 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id z20so14457492ljo.6;
        Sat, 05 Feb 2022 18:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1E6bVK8AHUmw4iabxx8MHLpQ1jAgmwOt/Bl6uj/XOE=;
        b=Hva+uqwHSlQvGLAnTK95lIoVWsYCCaIXmeP9M9F/K6qkI/GjxxCiFYiZoDxmvbhjSt
         wFrNcyfBjJyNKSanRTr6V4v0jxDKjHMJe/+wcwcqQRxaHmi4lHtHEG34Na/k//Wucb5S
         Y2/H/xUGghO5Wa7c9sj1i26ApDYQU+wPv1HtS76dLsi3Da4nNQfL9hkt7O0dB21C5QEx
         nH62yeCYLHEVzy0twChXimUzTI+kobVTUABoiBRXvSQViIg1cUDVGZcdGqXUSaeDFQyU
         IdnnWA406aBuORLi3DimswmAeIlt6HRqDlMsZl3/uc3xZJkags2uXB7M5jUlcF2L3Igz
         Ku2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1E6bVK8AHUmw4iabxx8MHLpQ1jAgmwOt/Bl6uj/XOE=;
        b=F8T2X2K+TpCRUxR+cdnun08lTkoau7ksawCqaIiTJVYLP6j8cw3SbTFoknFEQ6H4B7
         1VISGT0Q9cWGZCAHr1xexHvreZbQQGNo7EUnlGKG/qWUVzzB/YY8otnxj63N0gJMm1hR
         4TojK2TPjXiKLWtFYf9ERw61T+2eXUIzbFwuunfAhFQA2CZZXfDPLCZoWjv2tQlJxmNK
         39R6JiIM5YRG70nCIw5lFTiETCXFMF1bYCY1/k18yU1m0/Zfq5X+TDWbbrwkKc1cOU17
         g+yqBPRVQKtt3QxJrmCk9Cx3XyH5ey0m3j1QH9s/SAfo+7QPbgRiTHCIX6jjHPmGpgq/
         pmAw==
X-Gm-Message-State: AOAM530j4I3X0XoLItIjGBpZ4dwIJ4GIz/6HOSnY8BSLgFHY1F8E65mH
        CurXRyAATTvnLsnzVaynm4mdrg3+mh1WwhvVHKAUn494
X-Google-Smtp-Source: ABdhPJzUVRwpCGA1/qPUbSEMKThqgsdM9cosL6EJ5qtQdJ84l8myWVlTLU3OlpeWT/nkXdqqIAZEphddm+AlO6EprwI=
X-Received: by 2002:a2e:9c04:: with SMTP id s4mr4399755lji.229.1644114220293;
 Sat, 05 Feb 2022 18:23:40 -0800 (PST)
MIME-Version: 1.0
References: <2ee1eb2b46a3bbdbde4244634586655247f5c676.camel@HansenPartnership.com>
In-Reply-To: <2ee1eb2b46a3bbdbde4244634586655247f5c676.camel@HansenPartnership.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 5 Feb 2022 20:23:29 -0600
Message-ID: <CAH2r5mvgm30Dr8P=Ah8Hq0dZ6w=++amLg98TJgtfdOL+Tdjdzg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] configfd as a replacement for both ioctls and fsconfig
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a good discussion to have

On Sat, Feb 5, 2022 at 6:02 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> A shortened version of this topic was originally sent for LSF/MM 2020
> which didn't happen due to the pandemic:
>
> https://lore.kernel.org/all/1581781497.3847.5.camel@HansenPartnership.com/
>
> However, now replacing ioctls is on the table:
>
> https://lore.kernel.org/all/20220201013329.ofxhm4qingvddqhu@garbanzo/
>
> as I've already stated in that thread, I think, used sparingly, ioctls
> are fit for purpose and shouldn't be replaced and I'd definitely like
> to argue for that position.
>
> However, assuming that people would like to consider alternatives, I'd
> like to propose configfd.  It was originally proposed as a
> configuration mechanism for bind mounts that was a more general
> replacement for fsconfig (which can only configure filesystems with
> superblocks) and was going to be used by shiftfs.  However, since
> shiftfs functionality was done a different way, configfd has
> languished, although the patches are here:
>
> https://lore.kernel.org/all/20200215153609.23797-1-James.Bottomley@HansenPartnership.com/
>
> The point, though, is that configfd can configure pretty much anything;
> it wouldn't just be limited to filesystem objects.  It takes the
> fsconfig idea of using a file descriptor to carry configuration
> information, which could be built up over many config calls and makes
> it general enough to apply to anything.  One of the ideas of configfd
> is that the data could be made fully introspectable ... as in not just
> per item description, but the ability to get from the receiver what it
> is expecting in terms of configuration options (this part was an idea
> not present in the above patch series).
>
> If the ioctl debate goes against ioctls, I think configfd would present
> a more palatable alternative to netlink everywhere.
>
> James
>
>


-- 
Thanks,

Steve
