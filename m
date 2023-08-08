Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB637746DF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 21:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjHHTFV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 15:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbjHHTFB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:05:01 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CCBAFA0C
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 10:48:41 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe58faa5cfso7240005e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691516919; x=1692121719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A07tSATk4WyiLzh2AjGN9k9LM0i/q4SHz/ST015SGFQ=;
        b=PPY00NUkXMnlLi1TsqTk2nHeZwm5/SEj9NBv8ZZ7fViHFNYSZhLFqNJRgLiY5rC5KM
         wxMnVuBrR7c/mp8Wtjc2+nwRK6gpdnFZHuxak2Q7diMkwmIXiIJqMMlLjiQJZ3wi9c/A
         /h7Ntk1OM//bvAEthaS4mwOxhHkfnzHVIvYsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691516919; x=1692121719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A07tSATk4WyiLzh2AjGN9k9LM0i/q4SHz/ST015SGFQ=;
        b=U3gluyaG3Ac7/qyUAIWQd3JS4KDj5nZ0nbJ0N0UzHzm8lR+oTDF+8OumwhIf5ctOFp
         7wmdo1l98wgUv4pHDvRtZcPRDICGvwN/3hk2FG+0mEfg0vFuLxLKS6Pzg3Ue59CAHA50
         siLTPfvUzSocs9OFVxVfsYaICzOQaI5WVdzf3TYnP/T1KmCPR9mQB0FfNUkjuUfGO4ty
         vDAM5di20uQX+4XWk0kJwzN5OXTosex/Ltx9Gp5rGP3hA5EwhsefX7tzPqNelZnBs21u
         MhqEAX6hHkvszfykwZuTZ33KUihuMa00blEVTput1zL9QU4YTI79xCq9bKRZ3MawkBwk
         Ociw==
X-Gm-Message-State: AOJu0Yyc/Voy2nRUUdmGnHBNazk86IvSAAboZoZ0I6g6uEgx+QO3l47J
        PaJQLy6cPx3Mlk+5ZfQ8u1wU3hsXDPwsdd0/oRaBAS6V
X-Google-Smtp-Source: AGHT+IHoBUG+Be5ns1NP8j6xLDmNBfhpapzL3SswkGCYPobYcGulYvXNMMFQCqsJCrc0f+KoHYJBdg==
X-Received: by 2002:a05:6512:3a83:b0:4f8:680a:68f8 with SMTP id q3-20020a0565123a8300b004f8680a68f8mr131249lfu.41.1691516918981;
        Tue, 08 Aug 2023 10:48:38 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id v26-20020ac2559a000000b004fddb0eb961sm1959844lfg.18.2023.08.08.10.48.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 10:48:37 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4fe28e4671dso9684777e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 10:48:37 -0700 (PDT)
X-Received: by 2002:a05:6512:159c:b0:4fd:f77d:5051 with SMTP id
 bp28-20020a056512159c00b004fdf77d5051mr149456lfb.26.1691516917321; Tue, 08
 Aug 2023 10:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230806230627.1394689-1-mjguzik@gmail.com> <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whk-8Pv5YXH4jNfyAf2xiQCGCUVyBWw71qJEafn4mT6vw@mail.gmail.com>
 <CAGudoHE5UDj0Y7fY=gicOq8Je=e1MX+5VWo04qoDRpHRG03fFg@mail.gmail.com>
 <CAHk-=wj+Uu+=iUZLc+MfOBKgRoyM56c0z0ustZKru0We9os63A@mail.gmail.com>
 <CAGudoHE=jJ+MKduj9-95Nk8_F=fkv2P+akftvFw1fVr46jm8ng@mail.gmail.com> <20230808-divers-verehren-02abcc37fe60@brauner>
In-Reply-To: <20230808-divers-verehren-02abcc37fe60@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Aug 2023 10:48:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgKpvn_u_9R72JbBaTw8gQnzhoER3hnR4WQpY8j96Gxcg@mail.gmail.com>
Message-ID: <CAHk-=wgKpvn_u_9R72JbBaTw8gQnzhoER3hnR4WQpY8j96Gxcg@mail.gmail.com>
Subject: Re: [PATCH] fs: use __fput_sync in close(2)
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 8 Aug 2023 at 10:36, Christian Brauner <brauner@kernel.org> wrote:
>
> @Linus, you ok with the appended thing?

Yes.

I do think that the CHECK_DATA_CORRUPTION() case (used to be in
filp_close, now in filp_flush) is now very questionable since we'll
end up doing an "fput()" on it anyway.

But I think that's actually not a new thing - it was always in the
wrong place, and only caught the "filp_close()" cases. Which -
considering that it would only happen with people using 'fput()'
incorrectly - was always quite suspicious.

The actual "CHECK_DATA_CORRUPTION()" part of the check is new, but the
check itself predates not just the git tree, but the BK history too.
Google does find that we had it trigger back in 1998, apparently.

I think we should probably remove it entirely - and just depend on all
our modern use-after-free infrastructure.

Or we could move it into __fput() itself - the ordering wrt any
flushing is immaterial, because it's no different from using read or
write or whatever on a stale file descriptor - and at least get much
better coverage of the situation where it would happen.

But that is, I think, a completely separate issue - this is all just
made more obvious by the reorganization.

              Linus
