Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA664DC731
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 14:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiCQNFa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 09:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbiCQNEc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:04:32 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F10ADD67
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 06:03:15 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w127so5476211oig.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 06:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U0EcSAAJ4HRcVVrEONWcv5y7g0com8oiKod16b9QT4s=;
        b=MmlQc+uS316bd8nDCmEj139QepHj/bgHCUEPSGj4ospzEulqEdnfnu2YITo4fJ/F7c
         7VMEh2cPpW1GuldeX0N353cXv+bm7wWeAbW5fxYxf73a67RtFUzfkfLCLhneB1sBb3My
         wPxPwQz1wG0LfHxlkHN8PVIJSsV9NZIw4n4GAHnENGAYf7r3uyF2K7Q1PyYyp3qzMoyF
         tBJbYStCBut5iVsHOwVPv1h8oJqdHRl5DLIbnAkK2Lhg00Am+lZElyIduj2VxbNhTP1W
         s5t7DTJ1WwlR88NNKLByc1So/TAeHak8VsI9jTHtWMBo8NbwO/XMji/8mjRgSe1h/sit
         BC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U0EcSAAJ4HRcVVrEONWcv5y7g0com8oiKod16b9QT4s=;
        b=pVKNp5Fb9xlDdTkZIoyHw37L9WTYjOC4pM+gEFHsmgc+knDUeVQ+tNOQ4eB9HGFDyI
         5ZHCX+7pjr88hryxf23C/FzYpy55hN1QcSVOLi/QkP6LrGE6Yz47lKr7D7PfP7piYqPm
         r2gYmchZIE9V27pyYCyZ2T2l1NeaM2uzs8iJJJjmVtv503eR0Fv+6Yn+HSdZTDO67LgP
         Y9QJWFwP3h2lsGlErIu1n1qIRmvS0bfR/z5tnI4jgv6VjtZhUIRhxAGBugzaMdX1bv6w
         5fRKz5aCXKS1L8+kDNYzseozd3CdwYtamFyvWQOQ+UhunGjUMgwSrsyawcuLx4vcqlcR
         KL4Q==
X-Gm-Message-State: AOAM530TQt1PUickxm79fi+pXQINvRIXbpcJPw4ptoifxtwrnCV6/44r
        uATwC7S1DKmtgsYNfjMK/nhBiS/Uia4iAQcxj6I=
X-Google-Smtp-Source: ABdhPJzqBfEFdnu6QbsI/ghZv08aaoPpH+p2OcuonDExxls22vANh784ikgounQQsqyPnvMAHsqx0H4PrDnZO1MyrEE=
X-Received: by 2002:a05:6808:23c1:b0:2da:30fd:34d9 with SMTP id
 bq1-20020a05680823c100b002da30fd34d9mr5570923oib.203.1647522194729; Thu, 17
 Mar 2022 06:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <1357949524.990839.1647084149724.ref@mail.yahoo.com>
 <1357949524.990839.1647084149724@mail.yahoo.com> <20220314084706.ncsk754gjywkcqxq@quack3.lan>
 <CAOQ4uxiDubhONM3w502anndtbqy73q_Kt5bOQ07zbATb8ndvVA@mail.gmail.com>
 <20220314113337.j7slrb5srxukztje@quack3.lan> <CAOQ4uxhwXgqbMKMSQJwNqQpKi-iAtS4dsFwkeDDMv=Y0ewp=og@mail.gmail.com>
 <20220315111536.jlnid26rv5pxjpas@quack3.lan> <CAOQ4uxhSKk=rPtF4vwiW0u1Yy4p8Rhdd+wKC2BLJxHR8Q9V9AA@mail.gmail.com>
 <20220316115058.a2ki6injgdp7xjf7@quack3.lan> <CAOQ4uxgG37z7h-OYtGsZ-1=oQNu-DVvQgbN5wNbLXf0ktY1htg@mail.gmail.com>
 <20220317115346.ztz2g7tdvudx7ujd@quack3.lan>
In-Reply-To: <20220317115346.ztz2g7tdvudx7ujd@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 17 Mar 2022 15:03:03 +0200
Message-ID: <CAOQ4uxgupVpDSwN0EKw8hWVdyzK06DYyV9wBhmySz42nb_oNMA@mail.gmail.com>
Subject: Re: Fanotify Directory exclusion not working when using FAN_MARK_MOUNT
To:     Jan Kara <jack@suse.cz>
Cc:     Srinivas <talkwithsrinivas@yahoo.co.in>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
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

> > If anything, I would rather introduce FAN_IGNORE_MARK.
> > The reasoning is that users may think of this "ignore mark"
> > as a separate mark from the "inode mark", so on this "mark" the
> > meaning of ON_CHILD flags would be pretty clear.
>
> Well, yes, you are speaking about effectively the same flag just under a
> different name :) I agree my name is poor so I'm happy if we pick another
> one. The only small reservation I have against the name FAN_IGNORE_MARK is
> that we would now have to explain in the manpage a new concept of ignore
> mark and tell this is just a new name for ignore mask which looks a bit
> silly and perhaps confusing to developers used to the old naming.

Right. here is a first go at that (along with a name change):

"FAN_MARK_IGNORE - This flag has a similar effect as setting the
 FAN_MARK_IGNORED_MASK flag - the events in mask shall be added
 to or removed from the ignore mask.
 Unlike the FAN_MARK_IGNORED_MASK flag, this flag also has the effect
 that the FAN_EVENT_ON_CHILD and FAN_ONDIR flags take effect on the
 ignored mask, because with FAN_MARK_IGNORED_MASK, those flags
 have no effect. Note that unlike the FAN_MARK_IGNORED_MASK flag,
 unless FAN_ONDIR flag is set with FAN_MARK_IGNORE, events on
 directories will not be ignored."

What I like about this name is that the command
fanotify_mark(FAN_MARK_ADD | FAN_MARK_IGNORE,
                       FAN_MARK_OPEN | FAN_EVENT_ON_CHILD, ...
sounds like spoken English ("add a rule to ignore open events (also)
on children").

Please let me know if you agree with that flag name.

Apropos man page, after I am done with that, I will try to shake the dust
from all the man page update patches sitting in my queue and re-submit them.

Thanks,
Amir.
