Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033895B0E13
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 22:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiIGUYD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 16:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIGUYC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:24:02 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B456C12E1
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Sep 2022 13:24:00 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id h20-20020a056830165400b00638ac7ddba5so11031240otr.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Sep 2022 13:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=KcEWNmQCFEGlwSCr9ZMLZUL2o8HZZDxeYrIRyVxUuzQ=;
        b=zK84tTcQN8WWOYXDo4qDxzUBX21SjObgSyQnROD7QfT0srJbajghxH/nwF4yGOfc3P
         vYxgMj1xWzMnI+OpdUZkyOX5bklNhiaHgV4UuZGxKxj7yN8jrvmDplhg3HfNE4CvFqro
         z1hpPvVQb4tmJIl0uJSbAokY82CgR6WOH1dwEaqQj6SSlTEYVWkvfh//xWMcNvwZhvyK
         bAAdbDAUCqk5xdrnlNAFZhy3YCdaKzaWAQyaR7dP3e1GTyRFkPQauVONNwIqIn7XtpCE
         eyqloBOaxfRxwm8Q4jwnclnJVHt6zU7TVwikWWwW1CQmHtn4cO/5UBzIel1Ny58hUm1F
         sBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KcEWNmQCFEGlwSCr9ZMLZUL2o8HZZDxeYrIRyVxUuzQ=;
        b=Mqwu5FX0c9Q54lRsRMuHajZk9yBuGkG9VqSBcjNWH2tFtADYY/1mJLPiZzKxA8QQk1
         /Xv9I8xJ4OKWrjl/+E6mLXjdHWBb/eKj02HkWvaRQyYCFP2g1KG/u4VpwpFUK9aboUc/
         Mond8l8xQ8CD5oDjA3EPmT5U1Qh6dKFXnssJY3XzMCj38dJIEnZ9zFDA9mpq+V+ZNG2l
         L1qVbJSXQ5MobqsgvAbBRIrsTyQCHigKEVmvcAhPPpWSri2h7LvFhs8YNvp8fiZfGjzu
         oYfqEpBDbX2fwnHyJBIv5rNiGAHf06nlK9O4Al/iFMahDtazllT1A2ouh/LKOO8bnJWj
         GI0w==
X-Gm-Message-State: ACgBeo3VhC0fJ5faPcpn+9e3pRaTzU28pMCcTwoLh+v3yoUvUs8f5xgH
        WT4REmEDdRQUbZrDWxxcf5b/G44uZLNLFoYm6Hk+
X-Google-Smtp-Source: AA6agR4yexcKfIXZS/oxREnCr1eFoJO3G4+Ln93K//hG1nNpAn3yIfowLc5cx8IB19fzyXjgUtARVzvGaAmsdiGiKrA=
X-Received: by 2002:a9d:2de3:0:b0:638:e210:c9da with SMTP id
 g90-20020a9d2de3000000b00638e210c9damr2143948otb.69.1662582239884; Wed, 07
 Sep 2022 13:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659996830.git.rgb@redhat.com> <CAHC9VhStnE9vGu9h5tHnS58eyb8vm8rMN4miXpLAG6fFnidD=w@mail.gmail.com>
 <YxjmassY2yXOYtgo@madcap2.tricolour.ca> <4753948.GXAFRqVoOG@x2>
In-Reply-To: <4753948.GXAFRqVoOG@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 7 Sep 2022 16:23:49 -0400
Message-ID: <CAHC9VhRLwL6cBSXsZF09HWspeREf_tKxh0QdX1Hki=DPvHv7Vg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] fanotify,audit: Allow audit to use the full
 permission event response
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 7, 2022 at 4:11 PM Steve Grubb <sgrubb@redhat.com> wrote:
> On Wednesday, September 7, 2022 2:43:54 PM EDT Richard Guy Briggs wrote:
> > > > Ultimately I guess I'll leave it upto audit subsystem what it wants to
> > > > have in its struct fanotify_response_info_audit_rule because for
> > > > fanotify subsystem, it is just an opaque blob it is passing.
> > >
> > > In that case, let's stick with leveraging the type/len fields in the
> > > fanotify_response_info_header struct, that should give us all the
> > > flexibility we need.
> > >
> > > Richard and Steve, it sounds like Steve is already aware of additional
> > > information that he wants to send via the
> > > fanotify_response_info_audit_rule struct, please include that in the
> > > next revision of this patchset.  I don't want to get this merged and
> > > then soon after have to hack in additional info.
> >
> > Steve, please define the type and name of this additional field.
>
> Maybe extra_data, app_data, or extra_info. Something generic that can be
> reused by any application. Default to 0 if not present.

I think the point is being missed ... The idea is to not speculate on
additional fields, as discussed we have ways to handle that, the issue
was that Steve implied that he already had ideas for "things" he
wanted to add.  If there are "things" that need to be added, let's do
that now, however if there is just speculation that maybe someday we
might need to add something else we can leave that until later.

-- 
paul-moore.com
