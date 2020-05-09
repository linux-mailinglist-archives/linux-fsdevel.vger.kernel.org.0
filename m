Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6911F1CC483
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 22:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgEIUUB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 16:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgEIUT7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 16:19:59 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF284C061A0C
        for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2020 13:19:58 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u4so4172634lfm.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 May 2020 13:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DL22TlRhfdhfFFfvaipbz/lSHTNFSjOxjeAvslhNQxU=;
        b=J2julx2hs6owd62n+pd2JYhe6q2QsRo1OXAtwsVsruYMJBpnQ8uiFOlguFDfLik7YZ
         rMAAv0+dFxD8QskYZi9nLX3zKberv3nFnMQyidnzE4Vpn2PvYCSA06ICHQfTj4koWuUf
         oYf9h4WDijg//VNKhtCcE35X/HOZG3u0J2S3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DL22TlRhfdhfFFfvaipbz/lSHTNFSjOxjeAvslhNQxU=;
        b=He+li6lqXWAjC8TQQe/xwAPu9LONCbC1Sw0MtAS+Eg0Px9btYcDEprmi4IxL/OBoOP
         XNK0T2DTa6wngCX7pJKPJUXNuArn3mSNn86BnbexWK6QvyCAoyQAUGZlLWuNe4GU0z5+
         Uc/MPUX9D0aLlB19UwbD/u9TeIhv/6cFUpqcXKpiJIVpWJkeyEWmtQeffk45Mf1n1tKo
         911WQuc0LyHHW8FoKl0NHNaFpoMcdFDk+nFZpBidEsE2yvxvISSh36mzGoO9y+LLfjBf
         9MeZQ9gCn6XJmG3psaYim7CVlatoQnVEpMnrDrt9/js0GnneNJeJtarp2lkrtg98PoMY
         z56A==
X-Gm-Message-State: AOAM532d2sCWVBmfHHi9GRNWqj9H7pjheIHz6fJyhshdt09APZZNvfAl
        Z6iXVVBC2sE6dZ+BppZqpR8DH3KG+5I=
X-Google-Smtp-Source: ABdhPJwQF9C5azX32Wv4pTGZKl16xHsM4DTyXfeU37hB8cjQbj+v5SmZMI0fhjlglShTrSwhMvmdDQ==
X-Received: by 2002:a19:4f02:: with SMTP id d2mr5863427lfb.180.1589055596288;
        Sat, 09 May 2020 13:19:56 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id t16sm4659922ljo.6.2020.05.09.13.19.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 13:19:55 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id w20so5305700ljj.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 May 2020 13:19:54 -0700 (PDT)
X-Received: by 2002:a2e:8512:: with SMTP id j18mr5609189lji.201.1589055594669;
 Sat, 09 May 2020 13:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <87k11kzyjm.fsf_-_@x220.int.ebiederm.org>
 <CAHk-=wj-Znzqp3xktZ+kERM5cKF-Yh_6XjyGYof6bqPq2T3F5A@mail.gmail.com> <878si0yijd.fsf@x220.int.ebiederm.org>
In-Reply-To: <878si0yijd.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 May 2020 13:19:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZ-dXeYEk-meQT4pQmqJxATxDHSYbTSjL4dj56Ne9TFw@mail.gmail.com>
Message-ID: <CAHk-=whZ-dXeYEk-meQT4pQmqJxATxDHSYbTSjL4dj56Ne9TFw@mail.gmail.com>
Subject: Re: [PATCH 2/5] exec: Directly call security_bprm_set_creds from __do_execve_file
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 9, 2020 at 1:15 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I agree something needs to be renamed, to remove confusion.

Yeah, the alternative is to rename the capability version. I don't
care much which way it goes, although I do think it's best to call out
explicitly that the security hook functions get only the "primary"
executable brpm info.

Which is why I'd prefer to just rename all those low-level security
cases. It makes for a slightly bigger patch, but I think it makes for
better readability, and makes it explicit that that hook is literally
just for the primary executable, not for the interpreter or whatever.

               Linus
