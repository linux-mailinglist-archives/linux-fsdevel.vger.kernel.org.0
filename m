Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532CB72709D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 23:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjFGVkN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 17:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjFGVkM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 17:40:12 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D251BD6;
        Wed,  7 Jun 2023 14:40:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6dfc4e01fso78635595e9.0;
        Wed, 07 Jun 2023 14:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686174009; x=1688766009;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lmy4XW07oKHOzK9aUKxDjGz102EX0NciX9ngG/h5Op8=;
        b=sMjiF6MA5LBXfcs4yX28hE18P801iKcAwW0xcFksygw4rnvT+zL5KGzA3oLFviaKul
         SXLDKHuPAh1qrChJafS0iNwbqEs068eawutnLQI9B/sZFGEHB7CfiAzmx7UbtXm+EQQP
         l5JlHfR3Zugj5hGqVy5FH/hchB+NE/DoeKYNvYT/g1yR20BIIcF/mshlFGni7hiYnaCt
         dSalA2wX/xqm1OYrmsDZ73HEArh8+lGWNSn2xQ1IE+5Lt+R/hRhMJR8ZSkphENy/MHva
         jPC81a3SamB5Cb5qUMc0Rskal2S2GA7+lI1E6DQlweIk36WfS4hHnAJOyqoTPLrnmemC
         Yn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686174009; x=1688766009;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmy4XW07oKHOzK9aUKxDjGz102EX0NciX9ngG/h5Op8=;
        b=i7lpRewUnFuZ7fUAGHxTFkpHnYrVnrxmE9GUlKVjXHwxoYCW58l3BuPEzID8GksOVn
         DQabZdLCJKgbbaVEm9hw5oQXLIykNbyQxvYBtkSSS5lce57j/m6zR6GlNSfi5ZgJoxUQ
         dIPrTbjE9ktkNaQ/5JU+cySY7qeAqmNprhZsMNolCUNgnwpEEhuJOtNCj9R4nk8l9wHx
         CvLIC7JCWwwM1aNpxsyAwRduykFqC4Mtz7urBLt/XcIwnXTNSwVjOSbLvVUDfsXnJKYq
         gqQmxCQty1FqCQcvrqCVaCVa8G7VhX+MhkhAUEpf3fVZKLza/QlTwHfPmUsCWlRcPQMh
         GO5A==
X-Gm-Message-State: AC+VfDwSGgRzYjMVvpVRrBo6q/3x7QQAsUejxqt85AUTgdyJxU5F7BME
        KYTFQxgwP5bafkS1KUv+B+C+S5tykNM=
X-Google-Smtp-Source: ACHHUZ4PWSrnMRmLSHjyewoXrXzTcg5ud1vYOcwQKJA99JC8o6Ria7mVmbfERcv5Q9z5T0bzHgQATg==
X-Received: by 2002:a05:600c:28d0:b0:3f6:143:7c4b with SMTP id h16-20020a05600c28d000b003f601437c4bmr8370899wmd.6.1686174009205;
        Wed, 07 Jun 2023 14:40:09 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id p23-20020a1c7417000000b003f6f6a6e769sm3230521wmc.17.2023.06.07.14.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 14:40:08 -0700 (PDT)
Message-ID: <6480f938.1c0a0220.17a3a.0e1e@mx.google.com>
X-Google-Original-Message-ID: <ZIDNHjVEoSh8gtOh@Ansuel-xps.>
Date:   Wed, 7 Jun 2023 20:31:58 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Mark Brown <broonie@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf: dynamically allocate note.data in
 parse_elf_properties
References: <20230607144227.8956-1-ansuelsmth@gmail.com>
 <202306071417.79F70AC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202306071417.79F70AC@keescook>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 07, 2023 at 02:19:51PM -0700, Kees Cook wrote:
> On Wed, Jun 07, 2023 at 04:42:27PM +0200, Christian Marangi wrote:
> > Dynamically allocate note.data in parse_elf_properties to fix
> > compilation warning on some arch.
> 
> I'd rather avoid dynamic allocation as much as possible in the exec
> path, but we can balance it against how much it may happen.
>

I guess there isn't a good way to handle this other than static global
variables and kmalloc. But check the arch question for additional info
on the case.

> > On some arch note.data exceed the stack limit for a single function and
> > this cause the following compilation warning:
> > fs/binfmt_elf.c: In function 'parse_elf_properties.isra':
> > fs/binfmt_elf.c:821:1: error: the frame size of 1040 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> >   821 | }
> >       | ^
> > cc1: all warnings being treated as errors
> 
> Which architectures see this warning?
> 

This is funny. On OpenWRT we are enforcing WERROR and we had FRAME_WARN
hardcoded to 1024. (the option is set to 2048 on 64bit arch)

ARCH_USE_GNU_PROPERTY is set only on arm64 that have a FRAME_WARN set to
2048.

So this was triggered by building arm64 with FRAME_WARN set to 1024.

Now with the configuration of 2048 the stack warn is not triggered, but
I wonder if it may happen to have a 32bit system with
ARCH_USE_GNU_PROPERTY. That would effectively trigger the warning.

So this is effectively a patch that fix a currently not possible
configuration, since:

!IS_ENABLED(CONFIG_ARCH_USE_GNU_PROPERTY) will result in node.data
effectively never allocated by the compiler are the function will return
0 on everything that doesn't have CONFIG_ARCH_USE_GNU_PROPERTY.

> > Fix this by dynamically allocating the array.
> > Update the sizeof of the union to the biggest element allocated.
> 
> How common are these notes? I assume they're very common; I see them
> even in /bin/true:
> 
> $ readelf -lW /bin/true | grep PROP
>   GNU_PROPERTY   0x000338 0x0000000000000338 0x0000000000000338 0x000030 0x000030 R   0x8
> 
> -- 

Is there a way to check if this kmalloc actually cause perf regression?

-- 
	Ansuel
