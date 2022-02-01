Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC2F4A6420
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 19:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbiBASlL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 13:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbiBASlK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:41:10 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852C6C06173B
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Feb 2022 10:41:09 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id u6so35699711lfm.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Feb 2022 10:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9KMB5E3V1bz4skn5GoAxZyIA1phJ+tSxcRJR8WInLy0=;
        b=K6RfLu0tss7sWY+3Cb5jC7Cb3noc2STewpCcv7FQBgZBWz1Uf4DsDtQ/sE39JrgFWB
         wuXuiEKHuT1xTy97aiqjEqsOntTXvtpq9EiGZeh1r3Fai4F92dl+yWEN97l1UgndGliB
         m+TpO7+4JaH48lcla/mrWON4/cuz8eUuC1OI5aG0NAud4PwF8cGsl/PrY+nRidqkw/df
         dQUL1f3yw1TFvj3IJ5Z0ODCtVX2uqas+5mUNjma6M8JgWUhUHHRwl3CpGiCajPVARJfJ
         I7lDH6AVVnKkmRtYOaEWSvM5f+xWS1+J5q6pZaEo0C68uReznkP33Lubme34OvNjhchc
         stgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9KMB5E3V1bz4skn5GoAxZyIA1phJ+tSxcRJR8WInLy0=;
        b=u1VFEiFO9wPfcHi4IC26QsRadij2UuPXdb08d/9MQnjgp1WT8nMIkihhbw8hWEzS5C
         jLWsmztxC1StWAR5mMjyLpRkyTsjYYp0P1iK+/u4luG4ziVjAVd2XZAgfuHKUrmAdQvc
         m8WYXgBXqxTsORSvMskOTcXb2f1TzhRLYuS7qGpavH6b1NJnvXQvAS0K8Qi1lWwCSSvi
         1uyH9bcatUYxFBrmIt61SK4NyncDkb6FU64xRA+3wwuBmCwKjXUUTiQigE0bf9kXbYI3
         g4dntnfn94WAA5eaTNInohnqBrFIESRvBIY0GDhzpAAfobsl98OsseaPrbEUQTaiAgUL
         PtJw==
X-Gm-Message-State: AOAM532TL+72ZqqasFPu1dpEHD6BdY4zOaFMoBe//sXzc6BCRC2sF4ay
        oNFvJhEifnAg+LD2y5l4AtHDj/Bf2nDLetrdx84Log==
X-Google-Smtp-Source: ABdhPJw5kEWBR7jvbAbi8qdyZ/EThlOC/31Qwy3Sx6BUvs5huAKz/oJ7l3Jgbjhn7WjJhbUZyVm9w708H5d9G9futQ0=
X-Received: by 2002:a05:6512:3ca8:: with SMTP id h40mr19976020lfv.213.1643740867743;
 Tue, 01 Feb 2022 10:41:07 -0800 (PST)
MIME-Version: 1.0
References: <20220131153740.2396974-1-willy@infradead.org> <871r0nriy4.fsf@email.froward.int.ebiederm.org>
 <YfgKw5z2uswzMVRQ@casper.infradead.org> <877dafq3bw.fsf@email.froward.int.ebiederm.org>
 <YfgPwPvopO1aqcVC@casper.infradead.org> <CAG48ez3MCs8d8hjBfRSQxwUTW3o64iaSwxF=UEVtk+SEme0chQ@mail.gmail.com>
 <87bkzroica.fsf_-_@email.froward.int.ebiederm.org> <87o83rn3ny.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87o83rn3ny.fsf_-_@email.froward.int.ebiederm.org>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 1 Feb 2022 19:40:41 +0100
Message-ID: <CAG48ez1uo41dshk0VoCXyY6B9BUCCAzq3O+_42BX+yV2_iDhgw@mail.gmail.com>
Subject: Re: [PATCH 4/5] coredump/elf: Pass coredump_params into fill_note_info
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <liam.howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 7:47 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Instead of individually passing cprm->siginfo and cprm->regs
> into fill_note_info pass all of struct coredump_params.
>
> This is preparation to allow fill_files_note to use the existing
> vma snapshot.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Jann Horn <jannh@google.com>
