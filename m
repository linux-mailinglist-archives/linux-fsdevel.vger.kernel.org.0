Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3EB525F76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 12:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379197AbiEMJhC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 05:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379190AbiEMJg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 05:36:58 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFFC289BEA;
        Fri, 13 May 2022 02:36:56 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id c1so6628104qkf.13;
        Fri, 13 May 2022 02:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5/QaHzIsDx+VUbkQpyJdrmhr5ZThzTeQgKRfTCqVyP0=;
        b=LoECVbfRBi4FDUjlO+TsWlNINlegPwvqwXrR2czl8byOnVKt85YnYW+sZhWjopmjyD
         cCBo/gmgUyl1Biu+wqDU2ZebY8KSUmnucMeRaz94Yxx9B2Qz8iwL8B6tIT3khC3iHhHH
         duozL9qSrIk2DZgTbNl9tXtu/aJhdNvROLmAVZ633A3MQ+mv9SoBoGjMUB1z8pgb+H6n
         g6NlEsKczLjIweg2IucLK3xCkZ6FivZse6yZ0kl2TWG6XO1oMwyKU/6W+lAEB8lhZib2
         jvi+Yi9Jncwfl+APhDRIi7emZekDCYv5Ivd76x37C6N1or6FIPK3ElJk2Uri1gtt+HXD
         yAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5/QaHzIsDx+VUbkQpyJdrmhr5ZThzTeQgKRfTCqVyP0=;
        b=0xQiaiAyLPFhNwWod9uS9GcVopo3bu/fNzILPMkMdmc2xB7ezEofeicQPBXGPsaeZp
         SdZE36ZVM7NAzoIKVF+4EgWVdzSj990pQGg4u3UJiaBo13WBjOsHCWh1RnGqKi4kQz9y
         cgTa45r/4elFT74DlzEe+RUSCYVNU9bSGScDi3Rsuc3LU4urKt+6l3RRojrwlX6M7rIK
         6lTFNF6FkQo8flVsbidkDir8lfWBJRx1fv1sQN1a1LTCD1J70esnYx0oQylPoKdGggSP
         QOLE1yGaiIU7sf7fAQhTBVoh+6gkJ3B4B5OL5DwW0gwNOPHTLHCy9pAI0AvYS4wrft48
         ZOdg==
X-Gm-Message-State: AOAM532M6LJaN8M/hzB3uYB4xcWypQmYgy8PYyADscfsnIPXeMC2MARL
        X+DWH0JMv7qKgEpTOYMbFnM6RG0USe7sLIQvtIs7h+fUdy4=
X-Google-Smtp-Source: ABdhPJwTAuDj69E8va6LLbGC/UtsCBaq2ghW54E2TbfuYUPG9cPdUfAUsJnmuH17yXT67cbhf9mGJImwDlL8l1MabHc=
X-Received: by 2002:a05:620a:1aa0:b0:6a0:a34:15e0 with SMTP id
 bl32-20020a05620a1aa000b006a00a3415e0mr2940089qkb.19.1652434615582; Fri, 13
 May 2022 02:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <lGo7a4qQABKb-u_xsz6p-QtLIy2bzciBLTUJ7-ksv7ppK3mRrJhXqFmCFU4AtQf6EyrZUrYuSLDMBHEUMe5st_iT9VcRuyYPMU_jVpSzoWg=@emersion.fr>
 <CAOQ4uxjOOe0aouDYNdkVyk7Mu1jQ-eY-6XoW=FrVRtKyBd2KFg@mail.gmail.com> <Uc-5mYLV3EgTlSFyEEzmpLvNdXKVJSL9pOSCiNylGIONHoljlV9kKizN2bz6lHsTDPDR_4ugSxLYNCO7xjdSeF3daahq8_kvxWhpIvXcuHA=@emersion.fr>
In-Reply-To: <Uc-5mYLV3EgTlSFyEEzmpLvNdXKVJSL9pOSCiNylGIONHoljlV9kKizN2bz6lHsTDPDR_4ugSxLYNCO7xjdSeF3daahq8_kvxWhpIvXcuHA=@emersion.fr>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 13 May 2022 12:36:44 +0300
Message-ID: <CAOQ4uxiw0gaa+=afk=Avnr+8+DiyP9CRgUNUDK6NYZbo+Z7dOQ@mail.gmail.com>
Subject: Re: procfs: open("/proc/self/fd/...") allows bypassing O_RDONLY
To:     Simon Ser <contact@emersion.fr>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On Thu, May 12, 2022 at 3:38 PM Simon Ser <contact@emersion.fr> wrote:
>
> On Thursday, May 12th, 2022 at 14:30, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > Clients can also readlink("/proc/self/fd/<fd>") to get the path of the file
> > and open it from its path (if path is accessible in their mount namespace).
>
> What the compositor does is:
>
> - shm_open with O_RDWR
> - Write the kyeboard keymap
> - shm_open again the same file with O_RDONLY
> - shm_unlink
> - Send the O_RDONLY FD to clients
>
> Thus, the file doesn't exist anymore when clients get the FD.

From system POV, a readonly bind mount of /dev/shm
could be created (e.g. at /dev/shm-ro) and then wayland could open
the shm rdonly file from that path.

If wayland cannot rely on system to create the bind mount for it,
it could also clone its own mount namespace and create the
bind mount in its own namespace for opening the rdonly file.

But that implementation would be Linux specific an Linux has many
other APIs that were suggested on the linked gitlab issue.
You did not mention them in your question and did not say why
those solutions are not a good enough for your needs.

Thanks,
Amir.
