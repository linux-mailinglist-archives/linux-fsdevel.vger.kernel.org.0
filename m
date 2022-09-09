Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3ED5B2CE2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 05:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiIIDZ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 23:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiIIDZZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 23:25:25 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D029CCDD
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Sep 2022 20:25:23 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-127d10b4f19so767040fac.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Sep 2022 20:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=T16/dfwfRIl4ApXFV41w4Yn6wng2SG3Z7kxlsWGe3Gw=;
        b=M+3TlaVPIIgCZLSd+PEt1te9k0Yj+AOuPvLV+7gR11E5F9sVH4l3nDOtP45fk5np/7
         PoCpYjn9RzHaRFESpn48qNYtmCoYnJjsW4aZ7qjuzbhK+8QnYAuRPtC6gD5nwggRnnyb
         2LvKeEjwSQssti3IlLK2VdgkHrZDUe0JUVWhMRMgYPqWXhnlKYYxQSMk9M93tN9SP6Ts
         tqTUrYjBkhTtFMi3z62InTLekR+gwhOr+WyFLuJfteFj7B/xyV7l5nfNz75yapF7L4tA
         JU3v0ctdY8cDMHvWHl7rvwHC2AX9rOXqRiS4+vLcRiizKX6JI1/LxKJzBsOw6oKTNmBx
         ILIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=T16/dfwfRIl4ApXFV41w4Yn6wng2SG3Z7kxlsWGe3Gw=;
        b=2GHm/YOkcs8EtxW1MBu9mMrX49c3jjq1U6b/8+12ixfUSDrwyfHKpLP1Z4x+um7PTM
         niR3iqJGN73IA0ljjCE0hmqGRQ/gkaiTP7oTtcnF/ejerBzfwOGR6q3z2l7YMBCvvWXW
         Uy+5GEC7fULPYzjyZGPvSexReq1NRLb/fa+gj2xn2dAtjA90V0SGdLjqvfy8Mc4o7mQl
         3OtOenU81iMAyY9dAZ049tY5AMVNjv9VzvHVq/qGvHi/DRxlTmUrssQnLddOANqeKj7m
         /PI7EUmNPnIxFEZv46juYAJwE3p/vPw44UNdC6beeztHPM9S8eFevFeREEzD2Nsd+voZ
         /v5A==
X-Gm-Message-State: ACgBeo15UBeSRC8CV2Wvo1oVJaRPlzeedK6CvExwbPpdBP/+xqrjaEUw
        bv0sZWTVYJFYqoLDrNnh4izHZdHjTR/leb3YhUeE
X-Google-Smtp-Source: AA6agR4137lCVIvGABKObiKdLgmOgoLrrKUiCIs6S+cpznVUEiPGpcQhLf3f1VBNTvhCgCXTLDIXdIs9FF+zeugCMig=
X-Received: by 2002:a05:6808:bd1:b0:345:da59:d3ae with SMTP id
 o17-20020a0568080bd100b00345da59d3aemr2886098oik.136.1662693922716; Thu, 08
 Sep 2022 20:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659996830.git.rgb@redhat.com> <2603742.X9hSmTKtgW@x2>
 <CAHC9VhRKHXzEwNRwPU_+BtrYb+7sYL+r8GBk60zurzi9wz4HTg@mail.gmail.com>
 <2254258.ElGaqSPkdT@x2> <Yxqn6NVQr0jTQHiu@madcap2.tricolour.ca>
In-Reply-To: <Yxqn6NVQr0jTQHiu@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 8 Sep 2022 23:25:11 -0400
Message-ID: <CAHC9VhR0REQNK4e_Onb48C_DLugVD0bgMe3mqcJq-01v8S_nBA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] fanotify,audit: Allow audit to use the full
 permission event response
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 8, 2022 at 10:41 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2022-09-08 22:20, Steve Grubb wrote:
> > On Thursday, September 8, 2022 5:22:15 PM EDT Paul Moore wrote:
> > > On Thu, Sep 8, 2022 at 5:14 PM Steve Grubb <sgrubb@redhat.com> wrote:
> > > > On Wednesday, September 7, 2022 4:23:49 PM EDT Paul Moore wrote:
> > > > > On Wed, Sep 7, 2022 at 4:11 PM Steve Grubb <sgrubb@redhat.com> wrote:
> > > > > > On Wednesday, September 7, 2022 2:43:54 PM EDT Richard Guy Briggs
> > wrote:
> > > > > > > > > Ultimately I guess I'll leave it upto audit subsystem what it
> > > > > > > > > wants
> > > > > > > > > to
> > > > > > > > > have in its struct fanotify_response_info_audit_rule because
> > > > > > > > > for
> > > > > > > > > fanotify subsystem, it is just an opaque blob it is passing.
> > > > > > > >
> > > > > > > > In that case, let's stick with leveraging the type/len fields in
> > > > > > > > the
> > > > > > > > fanotify_response_info_header struct, that should give us all the
> > > > > > > > flexibility we need.
> > > > > > > >
> > > > > > > > Richard and Steve, it sounds like Steve is already aware of
> > > > > > > > additional
> > > > > > > > information that he wants to send via the
> > > > > > > > fanotify_response_info_audit_rule struct, please include that in
> > > > > > > > the
> > > > > > > > next revision of this patchset.  I don't want to get this merged
> > > > > > > > and
> > > > > > > > then soon after have to hack in additional info.
> > > > > > >
> > > > > > > Steve, please define the type and name of this additional field.
> > > > > >
> > > > > > Maybe extra_data, app_data, or extra_info. Something generic that can
> > > > > > be
> > > > > > reused by any application. Default to 0 if not present.
> > > > >
> > > > > I think the point is being missed ... The idea is to not speculate on
> > > > > additional fields, as discussed we have ways to handle that, the issue
> > > > > was that Steve implied that he already had ideas for "things" he
> > > > > wanted to add.  If there are "things" that need to be added, let's do
> > > > > that now, however if there is just speculation that maybe someday we
> > > > > might need to add something else we can leave that until later.
> > > >
> > > > This is not speculation. I know what I want to put there. I know you want
> > > > to pin it down to exactly what it is. However, when this started a
> > > > couple years back, one of the concerns was that we're building something
> > > > specific to 1 user of fanotify. And that it would be better for all
> > > > future users to have a generic facility that everyone could use if they
> > > > wanted to. That's why I'm suggesting something generic, its so this is
> > > > not special purpose that doesn't fit any other use case.
> > >
> > > Well, we are talking specifically about fanotify in this thread and
> > > dealing with data structures that are specific to fanotify.  I can
> > > understand wanting to future proof things, but based on what we've
> > > seen in this thread I think we are all set in this regard.
> >
> > I'm trying to abide by what was suggested by the fs-devel folks. I can live
> > with it. But if you want to make something non-generic for all users of
> > fanotify, call the new field "trusted". This would decern when a decision was
> > made because the file was untrusted or access denied for another reason.
>
> So, "u32 trusted;" ?  How would you like that formatted?
> "fan_trust={0|1}"
>
> > > You mention that you know what you want to put in the struct, why not
> > > share the details with all of us so we are all on the same page and
> > > can have a proper discussion.
> >
> > Because I want to abide by the original agreement and not impose opinionated
> > requirements that serve no one else. I'd rather have something anyone can
> > use. I want to play nice.
>
> If someone else wants to use something, why not give them a type of
> their own other than FAN_RESPONSE_INFO_AUDIT_RULE that they can shape
> however they like?

Yes, exactly.  The struct is very clearly specific to both fanotify
and audit, I see no reason why it needs to be made generic for use by
other subsystems when other mechanisms exist to support them.

-- 
paul-moore.com
