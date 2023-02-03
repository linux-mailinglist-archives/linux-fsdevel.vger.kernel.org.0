Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A116897F8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 12:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjBCLn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 06:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjBCLn0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:43:26 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763269D5AA;
        Fri,  3 Feb 2023 03:43:25 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id y8so5113448vsq.0;
        Fri, 03 Feb 2023 03:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/O0wfDmh+hVYy+ZkNR4liogCM4hpIictaPGLw3sHiAs=;
        b=cYd/WRYuLftKmgz18SrIZkr1UV0cfkm9D7jKlFiBkn6zFMSvruJ1rgl/8/bmn8hqMK
         p7qf+/0iEMyjTgnU1fEQYDdMC6qf5QVxpPI33MqGuKx5ZW+t/3Fnd0UgtvW5DMhYU76q
         qDRG53Ftek7aMHmOuA/bYxBZFyzlE9skG7VJ4lIkpvfBX0NUZC8CvVEael34U1JrMATm
         r6awIZZO5uRRM9rSDnEhsM614j3VMzV6cuIVp60cUQX/KqH/tJjJR6qZ9+ItHMsfYVej
         /dxKdV4UX8khN56fo/TAu5Nek4tB0rZwDIJk8t2jDFWIUHA/LuQjoN4uuKehWZfk+/an
         y6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/O0wfDmh+hVYy+ZkNR4liogCM4hpIictaPGLw3sHiAs=;
        b=BCDWJOhSdle/MSDnyDX1dxWjB0jAqTBXO3YxbBe93HpZsNp0rSdI7IdgfA61McQ5xz
         pCCk6x/RcsGk/yS4TAxFPnqAK647Tmo7GOezi94heYm8kvmQTKJCzDtZlBY5yzU5adpa
         bzwp1II3i2NtaiaSUkJsjosEuUQWCEtGuLPN0Uy1KaSpsgwjSqIbLHg3BBMqtL+U7H0V
         K6ehnyVOZTxTqDb7TnODgg2wtcoFtG4I9K41uxVc/Ydd7soPPgFetdr8jEaspRddRu4U
         V3NNYQknWCOJt81LIIoD0Ktt4u2vOzfElI5CO+4MDR29+aZD9XLL+cSsh4a1q0N5oI3+
         SktA==
X-Gm-Message-State: AO0yUKVE/VkiVwsySUbSe19pzVQf7y/Hkwl1zecy0MQNLvLY5z7L1D4u
        aqrJSCMSOFrujwJ7WC3ojmXZPqMDdVCqLYhjs1Y=
X-Google-Smtp-Source: AK7set8HoY4/ZCAC8QSuult6Rp/Z114p0/1kQL9PigZw3gsjVIDleaMgZ+uaU0cuQkKZ+v8ELYvEVonF51NSkNTnp2c=
X-Received: by 2002:a67:e102:0:b0:3f0:89e1:7c80 with SMTP id
 d2-20020a67e102000000b003f089e17c80mr1314417vsl.72.1675424604543; Fri, 03 Feb
 2023 03:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com> <CAOQ4uxiyRxsZjkku_V2dBMvh1AGiKQx-iPjsD5tmGPv1PgJHvQ@mail.gmail.com>
 <CA+PiJmRLTXfjJmgJm9VRBQeLVkWgaqSq0RMrRY1Vj7q6pV+omw@mail.gmail.com>
 <2dc5e840-0ce8-dae9-99b9-e33d6ccbb016@fastmail.fm> <CAOQ4uxiBD5NXLMXFev7vsCLU5-_o8-_H-XcoMY1aqhOwnADo9w@mail.gmail.com>
 <283b5344-3ef5-7799-e243-13c707388cd8@fastmail.fm>
In-Reply-To: <283b5344-3ef5-7799-e243-13c707388cd8@fastmail.fm>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 3 Feb 2023 13:43:13 +0200
Message-ID: <CAOQ4uxjvUukDSBk977csO5cX=-1HiMHmyQxycbYQgrpLaanddw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/21] FUSE BPF: A Stacked Filesystem Extension for FUSE
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@android.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Nikolaus Rath <Nikolaus@rath.org>,
        Josef Bacik <josef@toxicpanda.com>
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

> > Bernd, Daniel, Vivek,
> >
> > Did you see LSFMMBPF 2023 CFP [1]?
> >
> > Did you consider requesting an invitation?
> > I think it could be a good opportunity to sit in a room and discuss the
> > roadmap of "FUSE2" with all the developers involved.
> >
> > I am on the program committee for the Filesystem track, and I encourage
> > you to request an invite if you are interested to attend and/or nominate
> > other developers that you think will be valuable for this discussion.
> >
> > Thanks,
> > Amir.
> >
> > [1] https://lore.kernel.org/linux-fsdevel/Y9qBs82f94aV4%2F78@localhost.localdomain/
>
>
> Thanks a lot Amir, I'm going to send out an invitation tomorrow. Maybe
> Nikolaus as libfuse maintainer could also attend?
>

Since this summit is about kernel filesystem development, I am not sure
on-prem attendance will be the best option for Nikolaus as we do have
a quota for
on-prem attendees, but we should have an option for connecting specific
attendees remotely for specific sessions, so that could be great.

Two more notes:
1. We realize that companies are going through economic changes and that
    this may not be the best time to request travel approval or to be able to
    get it. This should not stop you from requesting to attend!
    Worse case, you can attend remotely. It is not the same experience, but
    it is better than not attending at all if you have something to
contribute to
    the discussion.
2. Bernd, I think you have some interesting WIP on "FUSE2" that the majority
    of fs developers are not aware of.
    It would be great if you can follow the instructions in CFP and also post
    a TOPIC suggestion to fsdevel, to get the discussion started ahead of
    the summit.
    Daniel, same request for FUSE BFP. The TOPIC suggestion should
    highlight the remaining open questions about design and API, which
    may be good to discuss in this forum.
    Please do not be intimidated by suggesting a TOPIC, you don't need
    to prepare any slides if you do not want to, nor to submit an abstract
    or anything of that sort.

Thanks,
Amir.
