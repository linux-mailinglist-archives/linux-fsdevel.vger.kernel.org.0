Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC3D59ACF9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 11:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245437AbiHTJiR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 05:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiHTJiP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 05:38:15 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FC0626F;
        Sat, 20 Aug 2022 02:38:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c39so8224078edf.0;
        Sat, 20 Aug 2022 02:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=MUA2Aecgy09+c0hu2ehsJ65Aw6U6m/BGLf6lup2uQPA=;
        b=nfmG5vZl2xGSb5E8QdpY9QC+2r4ThjuXmQRHPagjx5q+d7uIaHhtndeVKj13pBRvFw
         gp2CFMm1blO79s5zPpG9kZEDXIDPpRzEDUvFOgxaLyoR1vBW+7OeilN2g5HPZAdBd5Al
         7ejT/eLAAjdlvFymXreU4LcsaojFE0dqVjgZeJfJXPXvCfEPMlyAnRC97RjmND1WrzVj
         HLp1kSp3CfmmVPkXoUA36k3dTEZjRGacA+DFJ8HsQ3KS8RLzv2Sn0f+FB91rrl4cAnVf
         rt5ag38ozxQ6GaHSE777HIaAebCEDo2lX8YtAGVvlXYLUOyFrWFf7blyv2hVWWqnvCh0
         KNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=MUA2Aecgy09+c0hu2ehsJ65Aw6U6m/BGLf6lup2uQPA=;
        b=I3sE33MwG4z2gpDWMORZA1ftLO3hAncpGkrPpLgj3TFRhsy7bhhrBC5vCSmsNq6zgG
         fw1DHHlVZklGYKWeB0JAt4j66g9OijLq45IWr6O6auPP/5YhF1+BiOefqZrlnhBvLgrL
         pG4Hf9QyJpcp9JdNBEEJeRSKMmPqUtRlt0kbmQIw0QGusJXoe94SFrUlltT4Z/eAubdS
         Z79zuQAGKyrgGhEQemxOSPreHbA/Nv8G+UzsXASgPmlisu+w3O2jOW0ywYu6WurVhAT5
         YXAliDjdw+BrnSc1ONmX+eOCUNen1Gkok6wLbidTj1yy1/lLHLmh2PRWSKLnGycrN692
         2xQg==
X-Gm-Message-State: ACgBeo3cNPV7MrfBFb7YLOUxIbldt3n22DHbHZnnAC3hBHsOyuZ5RAm1
        HqT7AK2ugIK4KtYc6zhnx0E=
X-Google-Smtp-Source: AA6agR4YG9DyBOI+iz3TLjyy9IL/Wu0H7NjKecjTrAWm0mn5T24UmzHqd1ID6Jgvh+iahJDl6okqIA==
X-Received: by 2002:a05:6402:440c:b0:43a:1124:e56a with SMTP id y12-20020a056402440c00b0043a1124e56amr9225291eda.134.1660988293030;
        Sat, 20 Aug 2022 02:38:13 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id pj27-20020a170906d79b00b007304924d07asm3480317ejb.172.2022.08.20.02.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 02:38:12 -0700 (PDT)
Date:   Sat, 20 Aug 2022 11:38:10 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v5 2/4] selftests/landlock: Selftests for file truncation
 support
Message-ID: <YwCrgigS9gZKLW0Z@nuc>
References: <20220817203006.21769-1-gnoack3000@gmail.com>
 <20220817203006.21769-3-gnoack3000@gmail.com>
 <e90aaa5d-d6c8-838a-db29-868a30fd8e37@digikod.net>
 <Yv8elmJ4qfk8/Mw7@nuc>
 <86b013ed-b809-f533-5764-60b22272dce9@digikod.net>
 <2e7afd64-d36f-f81d-2ae4-1a99769e173c@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e7afd64-d36f-f81d-2ae4-1a99769e173c@digikod.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 19, 2022 at 10:36:15AM +0200, Mickaël Salaün wrote:
> FYI, my -next branch is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next
>
> Günther, let me know if everything is OK.

Thanks, looks good.

Good idea to also fix the date in the documentation, I had overlooked that.


> Konstantin, please rebase your work on it. It should mainly conflict with
> changes related to the Landlock ABI version.

+1, I believe we have both increased the ABI version to 3 in the two patch sets.

--
