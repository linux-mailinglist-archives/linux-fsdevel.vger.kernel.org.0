Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531F052669E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 17:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382287AbiEMPya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 11:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382144AbiEMPy3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 11:54:29 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E961F22A2D1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 08:54:26 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id a22so7358593qkl.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fwOF3PwlB7dwW7peo3UFsTujUz1I6SutUHLnuHfPYC0=;
        b=ikJxCqri3bm4MrizUHSM5Pcm8YJwPPyMc6UKhClomCn/t1hweU/soDMMlsiMmqAsg2
         YREgrKuFNJopYQnijCga/9xeAgMWLceI5PCzxsrU8Nqx8FXGDuEdzZsD62N9cqI+YtPJ
         ymk3o1wJZB3XyhZBF0Py/LfuuQ3wZtqfqvDmMeLzBhmVoF6Hnqlu9GO/+DjVwxAEJQ1i
         Bw3se2E8EofeamEwwFlynVua+4hZpYsGiz+iWJfBHx6N0wslU2aYIN32ebbQPzrKkZnW
         xIE8bZpkrKA7oV33GIfrspTu6qG1EMm6vB12xfoRIZjrHeKH++w9EuR+guWwTzVEPnW4
         UMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fwOF3PwlB7dwW7peo3UFsTujUz1I6SutUHLnuHfPYC0=;
        b=Uy6jPPqccDIJP3dwZRHLo4F+FkVMwyFNPMWko8Lwd9tPGl0mscgmRdEV47FsGkXoJ8
         ruMuCHw0IGD46BCGgTSl1/vUKWVMSSMCStl6UekrfgXw3nzfkjqso0OezH/vCIA4ctNl
         XgyojRuToxA0T8B0LIp+5n/Vd3cqIQN27F9zefa3G4UADTnkeDisVSXEpHO6IA1ed7ky
         uaUDzGx3V/FdTt7CHMlupYu5uSRIVAxXAhrnDsUJiZl1KRihPI6H8CXEauH627xkkgeU
         +iO/8b+h6UdMq2pH2QuuQ1qImEEhnhZ+sU1tuE0eXO+sWO8eX7jiy7uJHmTT3vkOZiST
         qqMw==
X-Gm-Message-State: AOAM530wyxRBr1IhgREJEfhwaIyPgKmgtnioLf+1us96eht9RbK8Aknp
        9edcq/Hvf78lxWTuTMxlh6n1ew==
X-Google-Smtp-Source: ABdhPJxNOXA6QU45KxFZjppgu+V2Ik1wqk32GFYYSDxebpTUTMaJC64IUfmhiQrS2sPgTZPgd6Yf/w==
X-Received: by 2002:a37:e102:0:b0:69f:8463:cbdd with SMTP id c2-20020a37e102000000b0069f8463cbddmr4053955qkm.766.1652457265907;
        Fri, 13 May 2022 08:54:25 -0700 (PDT)
Received: from google.com (122.213.145.34.bc.googleusercontent.com. [34.145.213.122])
        by smtp.gmail.com with ESMTPSA id 16-20020a370710000000b0069fc13ce1d7sm1554586qkh.8.2022.05.13.08.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 08:54:25 -0700 (PDT)
Date:   Fri, 13 May 2022 15:54:22 +0000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Fanotify API - Tracking File Movement
Message-ID: <Yn5/LgUdNbZsHc/N@google.com>
References: <YnOmG2DvSpvvOEOQ@google.com>
 <20220505112217.zvzbzhjgmoz7lr6w@quack3.lan>
 <CAOQ4uxhJFEoV0X8uunNaYjdKpsFj6nUtcNFBx8d3oqodDO_iYA@mail.gmail.com>
 <20220505133057.zm5t6vumc4xdcnsg@quack3.lan>
 <YnRhVgu6JKNinarh@google.com>
 <CAOQ4uxi9Jps3BGiSYWWvQdNeb+QPA9kSo_BDRCC2jfPSGWdx_w@mail.gmail.com>
 <20220506100636.k2lm22ztxpyaw373@quack3.lan>
 <CAOQ4uxjEcbjRoObAUfSS3RHVJY7EiW8tJSo1geNtbgQbcTOM+A@mail.gmail.com>
 <Yn5al/rEQIcf6pjR@google.com>
 <CAOQ4uxiMBEz8bgNT6zhsJbVe6dKCXfd0WyZw3MdNb_WLFvk2Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiMBEz8bgNT6zhsJbVe6dKCXfd0WyZw3MdNb_WLFvk2Zg@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 13, 2022 at 05:14:57PM +0300, Amir Goldstein wrote:
> On Fri, May 13, 2022 at 4:18 PM Matthew Bobrowski <repnop@google.com> wrote:
> >
> > On Sat, May 07, 2022 at 07:03:13PM +0300, Amir Goldstein wrote:
> > > Sorry Matthew, I was looking at the code to give you pointers, but there were
> > > so many subtle details (as Jan has expected) that I could only communicate
> > > them with a patch.
> > > I tested that this patch does not break anything, but did not implement the
> > > UAPI changes, so the functionality that it adds is not tested - I leave that
> > > to you.
> >
> > No, that's totally fine. I had to familiarize myself with the
> > FS/FAN_RENAME implementation as I hadn't gone over that series. So
> > appreciate you whipping this together quickly as it would've taken a
> > fair bit of time.
> >
> > Before the UAPI related modifications, we need to first figure out how
> > we are to handle the CREATE/DELETE/MOVE cases.
> >
> > ...
> >
> > > My 0.02$ - while FAN_RENAME is a snowflake, this is not because
> > > of our design, this is because rename(2) is a snowflake vfs operation.
> > > The event information simply reflects the operation complexity and when
> > > looking at non-Linux filesystem event APIs, the event information for rename
> > > looks very similar to FAN_RENAME. In some cases (lustre IIRC) the protocol
> > > was enhanced at some point exactly as we did with FAN_RENAME to
> > > have all the info in one event vs. having to join two events.
> > >
> > > Hopefully, the attached patch simplifies the specialized implementation
> > > a little bit.
> > >
> > > But... (there is always a but when it comes to UAPI),
> > > When looking at my patch, one cannot help wondering -
> > > what about FAN_CREATE/FAN_DELETE/FAN_MOVE?
> > > If those can report child fid, why should they be treated differently
> > > than FAN_RENAME w.r.t marking the child inode?
> >
> > This is something that crossed my mind while looking over the patch
> > and is a very good thing to call-out indeed. I am of the opinion that
> > we shouldn't be placing FAN_RENAME in the special egg basket and also
> > consider how this is to operate for events
> > FAN_CREATE/FAN_DELETE/FAN_MOVE.
> >
> > > For example, when watching a non-dir for FAN_CREATE, it could
> > > be VERY helpful to get the dirfid+name of where the inode was
> > > hard linked.
> >
> > Oh right, here you're referring to this specific scenario:
> >
> > - FAN_CREATE mark exclusively placed on /dir1/old_file
> > - Create link(/dir1/old_file, /dir2/new_file)
> > - Expect to receive single event including two information records
> >   FID(/dir1/old_file) + DFID_NAME(/dir2/new_file)
> >
> > Is that correct?
> 
> Correct.
> Exactly the same event as you would get from watching dir2 with
> FAN_CREATE|FAN_EVENT_ON_CHILD in a group with flag
> FAN_REPORT_TARGET_FID.

Right, that makes sense. For FAN_CREATE and FAN_DELETE (not entirely
sure about FAN_MOVE right now), as you mentioned can we simply provide
the DFID_NAME of the non-directory indirect objects? From a UAPI
perspective, I think in terms of what's expected in such situation
would be clear.

/M
