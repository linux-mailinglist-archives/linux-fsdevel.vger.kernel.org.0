Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB8F708702
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 19:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjERReK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 13:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjERReJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 13:34:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0948F10F0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 10:33:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96f53c06babso46093266b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 10:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684431228; x=1687023228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5k9EtuLI3tDPxkuM6Z7FYpLe7g8cI0Dfathe8uxGMFM=;
        b=YG3B7R+TIVc9Pe4YejC48O3tk83Vr02YXah6CemPod4zJJDfq8lSd8fulPt+1V2AUB
         ELmGsKz7TrFlZ7AuP669UtV4F6Gqc0f5axPu/EMofiQOslneYDaL2yL2AAHcepOC/AbK
         yoEAe/ZZdtP1GaSRY4AKpT5E4Odx+AZJNZOSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684431228; x=1687023228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5k9EtuLI3tDPxkuM6Z7FYpLe7g8cI0Dfathe8uxGMFM=;
        b=mA7ddJvRVmWuiW88giPsDLOuz3Cvh/ApSXdEaFSq2C/SCkPTEJMPQ80xHoJSZaCKhT
         ZhVe0QYldiTVae47foqg6jwnfYYReRduCb6NpZVsHu8FV4Hp5v0dTAsTaIMcbfE3+4Bx
         OU8AB1hxTV9nQb7pqrBq08vaffbV+z0e8DtxJfiq0EY/43QBGkGW1zvP8zMQzuxhNIBb
         7HO4hmr26kTP3RKcLlhGAYamI1O++UYI2KbYRGN6McJyQrvzE3bAwI/JpucGODbJncQg
         KvUeN/HZNXG38Xwo7HBn+YB9vPnZf9FMy2Z6mPjqNILBRJ5oVxEAB2SCPKgnVxG7RehO
         ehIw==
X-Gm-Message-State: AC+VfDzFdFeS9Ux1el21lQSDzcdBh/NsKUTlIiG/KMmuMz2naWOfYRsw
        HFbrOHQSvzoY2r+i5IjlR0wdFDUXbqztrdS9b1w0oLEW
X-Google-Smtp-Source: ACHHUZ6+ZpphzVkRJbx1rU+zD+b5dlFaiogiOYAjLBQOxD4rUJJwxROPNMMglc2GfMSnSKJuOFNHwQ==
X-Received: by 2002:a17:907:6e03:b0:96a:440b:d5dc with SMTP id sd3-20020a1709076e0300b0096a440bd5dcmr28920484ejc.54.1684431228162;
        Thu, 18 May 2023 10:33:48 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id m15-20020a170906234f00b00959c07bdbc8sm1238684eja.100.2023.05.18.10.33.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 10:33:47 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-9659e9bbff5so418581666b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 10:33:47 -0700 (PDT)
X-Received: by 2002:a17:906:da86:b0:960:ddba:e5c3 with SMTP id
 xh6-20020a170906da8600b00960ddbae5c3mr36488408ejb.32.1684431227176; Thu, 18
 May 2023 10:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230516001348.286414-1-andrii@kernel.org> <20230516001348.286414-2-andrii@kernel.org>
 <20230516-briefe-blutzellen-0432957bdd15@brauner> <CAEf4BzafCCeRm9M8pPzpwexadKy5OAEmrYcnVpKmqNJ2tnSVuw@mail.gmail.com>
 <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner> <20230517120528.GA17087@lst.de>
 <CAADnVQLitLUc1SozzKjBgq6HGTchE1cO+e4j8eDgtE0zFn5VEw@mail.gmail.com>
 <20230518-erdkugel-komprimieren-16548ca2a39c@brauner> <20230518162508.odupqkndqmpdfqnr@MacBook-Pro-8.local>
 <20230518-tierzucht-modewelt-eb6aaf60037e@brauner>
In-Reply-To: <20230518-tierzucht-modewelt-eb6aaf60037e@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 18 May 2023 10:33:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmRTogGmR8E_SYOiHFpz8cY+0xj7nBpv9UwGU6k-UPAA@mail.gmail.com>
Message-ID: <CAHk-=wgmRTogGmR8E_SYOiHFpz8cY+0xj7nBpv9UwGU6k-UPAA@mail.gmail.com>
Subject: Re: fd == 0 means AT_FDCWD BPF_OBJ_GET commands
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 10:20=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> That's just completely weird. We can see what Linus thinks but I think
> that's a somewhat outlandish proposal that I wouldn't support.

I have no idea of the background here.

But fd 0 is in absolutely no way special. Anything that thinks that a
zero fd is invalid or in any way different from (say) fd 5 is
completely and utterly buggy by definition.

Now, fd 0 can obviously be invalid in the sense that it may not be
open, exactly the same way fd 100 may not be open. So in *that* sense
we can have an invalid fd 0, and system calls might return EBADF for
trying to access it if somebody has closed it.

If bpf thinks that 0 is not a file descriptor, then bpf is simply
wrong. No ifs, buts or maybes about it. It's like saying "1 is not a
number". It's nonsensical garbage.

But maybe I misunderstand the issue.

              Linus
