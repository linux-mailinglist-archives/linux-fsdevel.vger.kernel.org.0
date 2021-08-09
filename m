Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037B13E4E79
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 23:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbhHIV1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 17:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbhHIV1e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 17:27:34 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C421DC061798
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Aug 2021 14:27:13 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id h17so14374672ljh.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Aug 2021 14:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jggCUuylUTp8Qazkw4vyHQk7Sx27WnHOaFstAIevKbw=;
        b=ahusbhrQOwPDpp9d7umFODX39riwpah9xsJFNwdPYjW/4+UDVTFy/QrRYOBOclHXAu
         UHM/hA3SaIXz8Vcb8Cfiy84Yqm/VgSkEy88uT4fFKLuWgcfwrFLk5f0x7mzSBcZgc1uu
         Xb+wv2gYe2MI+DuWdQnYwvY8TTDG7CPECRQHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jggCUuylUTp8Qazkw4vyHQk7Sx27WnHOaFstAIevKbw=;
        b=U+3ISxuMt2DvOZ/9pHhLp2zsvbFKreSbn+apids0g4CSLfewSXl7WY1rJuqv+z1+m4
         W5KT5X+YS/O52MBSf7yVMFGETxotFMY1fsvqN1O2GInpbns+hR8mIftchUYhJzlNJ00M
         k9VrZJOyjmkkmKoYn5HiwTKOaxB4RbOavNbLBOwMEs7iwPtQEmZurwiSl7cfgJJGvqYZ
         TIlYfQlB6fIjbXh9Tdgwztd+zYwIpgcVnw1ve9xKdjwyfeudF0wPGXfZHckCyxNUGu/I
         aUiwx7+bQAQRjCetyJSniOmckFIGuRxunQ9PFjjGKB9EZ1nO2rZk3UaeKj1KIA9yrmJu
         guuA==
X-Gm-Message-State: AOAM530Ue7fCUrUhSijCMjh796ouR4MHZKhFnaIZ9sJqikXFqlYxHD3M
        Izos1SaBC3MwtG0qdo8eI1qPEDp1e1eXWP/X
X-Google-Smtp-Source: ABdhPJxvuxf8I7kW/t6xkWbvPG7AqKzQuA4914r1EPSpoB87zQBrLKYUCmcgj9+Q0xYoOnRGSGmJPg==
X-Received: by 2002:a2e:8155:: with SMTP id t21mr3557836ljg.168.1628544432095;
        Mon, 09 Aug 2021 14:27:12 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id h7sm580470lji.23.2021.08.09.14.27.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 14:27:11 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id u13so25683874lje.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Aug 2021 14:27:11 -0700 (PDT)
X-Received: by 2002:a2e:80cb:: with SMTP id r11mr3942175ljg.48.1628544431464;
 Mon, 09 Aug 2021 14:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <YRFfGk5lHL0W27oU@miu.piliscsaba.redhat.com> <CAHk-=wigKQqEqt9ev_1k5b_DwFGp7JmCdCR1xFSJjOyisEJ61A@mail.gmail.com>
In-Reply-To: <CAHk-=wigKQqEqt9ev_1k5b_DwFGp7JmCdCR1xFSJjOyisEJ61A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Aug 2021 14:26:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhm9CV+sLiA9wWUJS2mQ1ZUcbr1B_jm7Wv8fJdGJbVYA@mail.gmail.com>
Message-ID: <CAHk-=wjhm9CV+sLiA9wWUJS2mQ1ZUcbr1B_jm7Wv8fJdGJbVYA@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs fixes for 5.14-rc6
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 9, 2021 at 2:25 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I've pulled this,

Actually, I take that back.

None of those things have been in linux-next either, and considering
my worries about it, I want to see more actual testing of this.

                Linus
