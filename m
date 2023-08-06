Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F683771656
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Aug 2023 19:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjHFRtf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Aug 2023 13:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjHFRte (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Aug 2023 13:49:34 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD851716
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Aug 2023 10:49:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe44955decso4593390e87.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Aug 2023 10:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691344171; x=1691948971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5c+qcNDwemDSSTXvTKcISpxIGdg6gcplF2JUpghI6yw=;
        b=Y7czYanOw1jkq3Ke+oPnYmgVSNNSvEHn0BW+Brrk87ZZffcwmvrJkbmXdkVgY6wVrG
         w1rpUT/evg+p+4IcnUQuHWPAh9T0wLm67GRIRI2hg7SJJB1uoSwUOEipy3+0VNoD9aha
         nqrFj4Vz98Nw5p7Z8hp/t38UB3bc21+NnTe3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691344171; x=1691948971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5c+qcNDwemDSSTXvTKcISpxIGdg6gcplF2JUpghI6yw=;
        b=Xlv49dl/Bn9mbiebU53gEkWambllP4SkJ1nWpm0n9ut0wielmo0sSNQdDZub+taJ1/
         F5fgrCZ3agNRbyVJYti/AWMJeeoP+V3iO3VBld8oCDM8sknB1VfBwBl97NCK0+zWZy9X
         z/+E1Ic/xJn8qVJHT5X0iZKv3VoRCDB4niKFDYjAEd9p8Cc9VYiVF3P3SO8ZF2YOMgeR
         /Q2zUuVWxIwc18B42k9IrDy/CgtoFqZdCMrNpP/Yz4pBqSg7rKDFQqkXWgqP2hF8qBDd
         DtXSDgwM7M+ZhnXICGJAGTtNeZvv6FNH0uaJ6IKvk6/DRzEpQTnEv9hzP1nwdCvjpEiH
         4CqQ==
X-Gm-Message-State: AOJu0YzVRI9Ex9t4VDwuzDrpp9B7OBNl5cknIBqMNHpEEIjG/mkjIrdR
        CqKGsb4uVXz7ZgMD8ol2A33wrL0PmxuIqXTsi/G1qfBo
X-Google-Smtp-Source: AGHT+IELN8Dwhp63ANQ37qMjUQYF1OUoqZUCW6aqUXj7/oII3ZiNznhfT+MrAEa2oaB9IHTqZCu6tA==
X-Received: by 2002:a19:e044:0:b0:4f8:6e1a:f3ac with SMTP id g4-20020a19e044000000b004f86e1af3acmr1459987lfj.28.1691344171015;
        Sun, 06 Aug 2023 10:49:31 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id p20-20020ac246d4000000b004fbf37b73ccsm1192416lfo.284.2023.08.06.10.49.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 10:49:30 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fe55d70973so3977103e87.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Aug 2023 10:49:30 -0700 (PDT)
X-Received: by 2002:a17:907:160e:b0:993:da5f:5a9b with SMTP id
 hb14-20020a170907160e00b00993da5f5a9bmr6239608ejc.8.1691344149938; Sun, 06
 Aug 2023 10:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230804-turnverein-helfer-ef07a4d7bbec@brauner>
 <20230805-furor-angekauft-82e334fc83a3@brauner> <CAHk-=witxS+hfdFc+xJVpb9y-cE6vYopkDaZvvk=aXHcv-P5=w@mail.gmail.com>
 <CAHk-=wiEzoh1gqfOp3DNTS9iPOxAWtS71qS0xv1XBziqGHGTwg@mail.gmail.com>
 <20230806-mundwinkel-wenig-d1c9dcb2c595@brauner> <20230806-appell-heulen-61fc63545739@brauner>
In-Reply-To: <20230806-appell-heulen-61fc63545739@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Aug 2023 10:48:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJtLkYwEFTS9LcRiMjSqq_xswDeXo7hYNWT0Em6nL4Sw@mail.gmail.com>
Message-ID: <CAHk-=whJtLkYwEFTS9LcRiMjSqq_xswDeXo7hYNWT0Em6nL4Sw@mail.gmail.com>
Subject: Re: [PATCH] file: always lock position
To:     Christian Brauner <brauner@kernel.org>
Cc:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 6 Aug 2023 at 06:26, Christian Brauner <brauner@kernel.org> wrote:
>
> We got sent a fix for a wrong check for O_TMPFILE during RESOLVE_CACHED
> lookup which I've put on vfs.fixes yesterday:
>
> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5-rc5.vfs.resolve_cached.fix
>
> But in case you planned on applying this directly instead of waiting for
> next cycle I've added your two appended patches on top of it and my
> earlier patch for massaging the file_needs_f_pos_lock() check that
> triggered this whole thing:
>
> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5-rc5.vfs.fixes

I had actually planned on just waiting for the 6.6 merge window, but
then you made this _so_ easy for me that I ended up taking these
things right now.

The timing may not be entirely right, but I'm very comfortable with
the "get rid of '->iterate' op" change since it (a) would clearly fail
the build on a missed conversion and (b) doesn't touch any core
filesystems anyway.

And now that file_needs_f_pos_lock() does look better, and as you say
in teh commit, makes it clearer why that locking rule exists.

             Linus

                     Linus
