Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83616A8878
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 19:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjCBSWU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 13:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCBSWT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:22:19 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F3D37543;
        Thu,  2 Mar 2023 10:22:18 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id e26-20020a9d6e1a000000b00694274b5d3aso103202otr.5;
        Thu, 02 Mar 2023 10:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677781337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWvyqrOTI+j49unEN6IGHmjpV8Qd1SBr3lw4/Tar8fA=;
        b=Mu/jdDIjRB8QCyAhPkM7RE3eGytAjZEaKQdbgUqqispsGITAuLH9Rdek7B+30ytmkA
         Am7bJqW7VwhR4q+N9wibx7QajJclIs3guD5so8IdUdclHK2IdAYDg1OVSQFAQy6dPKLY
         2lbl0ToxYW+9buXmMPspK9XwUptTSs9uBgh9P+AaLTbMAxEM4ZqOHj52PRkRZI5jQWvH
         R59poeLRaORV29x51mkT9s3NmFh9sdSPurr1d/ViSNliSRaLTAsqefLYZIVy9xrG/GCC
         YFzej/h9mUVeDVn2cX2f2gHmDPc3HzpVRN8paX/BkV/ZRaIG/Ua0+vEhNZepf/AMKsKm
         fpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677781337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWvyqrOTI+j49unEN6IGHmjpV8Qd1SBr3lw4/Tar8fA=;
        b=0dNrS4MIkMBOv2vAQRFpbQeyUEmXMg4N6ikp2o1QNtKfOS6EyTCps3zq+fnQOhbZsE
         bl2AAR95cixpmVp+2INFngE2JLK4iJUPGNAP3B5EwTPHHK0AFmeQKVrmGetWvlQeTEtM
         Up+ivfm+k5z/m9jS+jee1WPTa31IDpOhOcX7Pflr9C2lzjTvh4X5CjbJr2G8c2uX6KPu
         fQyzTJvzDsMy+qDoPH4d65jIzRdasA2LPhdCNxPNRU4CvwaGQ55ut3BDm3O4XpfbFsKS
         A1Olm/3iWfBX7Q7Jee/GCifax820saxT7w/6puDlXX6hj2Mt5gT4rRptGoBCvfsG29br
         5rqg==
X-Gm-Message-State: AO0yUKWGRbfkB5ATgPN7OkW/4l5BHlKwWfdsKExXM5l59NnEN1ijwWxC
        mqvSQ6+BDr4WQ5Ffv0Z1MsK2gb+lc7BlcVTazgVltYjR
X-Google-Smtp-Source: AK7set+fQcdUoUhlfrnGhdq2Uu3vkzukiW9MR7JW9sIMq3OECBXBBi0n7GR3lzmjnASkMK6QnYlwynSxaqOYqCDTpTU=
X-Received: by 2002:a05:6830:39e0:b0:693:c3bb:8d06 with SMTP id
 bt32-20020a05683039e000b00693c3bb8d06mr3749091otb.6.1677781337668; Thu, 02
 Mar 2023 10:22:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:4304:0:b0:4c1:4768:8c59 with HTTP; Thu, 2 Mar 2023
 10:22:17 -0800 (PST)
In-Reply-To: <ZADoeOiJs6BRLUSd@ZenIV>
References: <20230125155557.37816-1-mjguzik@gmail.com> <20230125155557.37816-2-mjguzik@gmail.com>
 <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein> <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com> <ZADoeOiJs6BRLUSd@ZenIV>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Thu, 2 Mar 2023 19:22:17 +0100
Message-ID: <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/2/23, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Thu, Mar 02, 2023 at 07:14:24PM +0100, Mateusz Guzik wrote:
>> On 3/2/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> > On Thu, Mar 2, 2023 at 12:30=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org>
>> > wrote:
>> >>
>> >> Fwiw, as long as you, Al, and others are fine with it and I'm aware o=
f
>> >> it I'm happy to pick up more stuff like this. I've done it before and
>> >> have worked in this area so I'm happy to help with some of the load.
>> >
>> > Yeah, that would work. We've actually had discussions of vfs
>> > maintenance in general.
>> >
>> > In this case it really wasn't an issue, with this being just two
>> > fairly straightforward patches for code that I was familiar with.
>> >
>>
>> Well on that note I intend to write a patch which would add a flag to
>> the dentry cache.
>>
>> There is this thing named CONFIG_INIT_ON_ALLOC_DEFAULT_ON which is
>> enabled at least on debian, ubuntu and arch. It results in mandatory
>> memset on the obj before it gets returned from kmalloc, for hardening
>> purposes.
>>
>> Now the problem is that dentry cache allocates bufs 4096 bytes in
>> size, so this is an equivalent of a clear_page call and it happens
>> *every time* there is a path lookup.
>
> Huh?  Quite a few path lookups don't end up allocating any dentries;
> what exactly are you talking about?
>

Ops, I meant "names_cache", here:
	names_cachep =3D kmem_cache_create_usercopy("names_cache", PATH_MAX, 0,
			SLAB_HWCACHE_ALIGN|SLAB_PANIC, 0, PATH_MAX, NULL);

it is fs/dcache.c and I brainfarted into the above.

>> Given how dentry cache is used, I'm confident there is 0 hardening
>> benefit for it.
>>
>> So the plan would be to add a flag on cache creation to exempt it from
>> the mandatory memset treatment and use it with dentry.
>>
>> I don't have numbers handy but as you can imagine it gave me a nice bump
>> :)
>>
>> Whatever you think about the idea aside, the q is: can something like
>> the above go in without Al approving it?
>
> That one I would really like to take a look at.
>

allright

--=20
Mateusz Guzik <mjguzik gmail.com>
