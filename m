Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5423519C6C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 18:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389752AbgDBQLu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 12:11:50 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39980 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389451AbgDBQLu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:11:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id j17so3199205lfe.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2020 09:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yt6zWERiKTCjDwTG56J7PYbCEtxdXxHidONUlaX/0Js=;
        b=cRMdri6VXL1PrIKwuy81gkl35L7PPDq29lpPSc9oxeCIc5SGIiqZg8pZqrkDDLnVb9
         ATIfA6ph4AX+mgQJ2g4xFtlTed8dXG9kFXpWDDmRmc9iZRJ/VvaCXIYwKdNcvGxYya9T
         JrvodRpKIVTZYh5OZgKCQvDiX1x+OBqYoVfSEje9Sjp+wrWHzZu7VuCxoB8n27O7DS7K
         m2VuRbXpPfA/c2K3BAp3HojSyhNMlssuF//ntu3Mv5fMltgcizzbIz2Hwvm4Rl5RrTh7
         db1ESdeqzHZCuVNlj451tRQJnKHTM+fat+l1dFjPYun9ATeoy3nvp7eWR1J38Wv435Ab
         BUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yt6zWERiKTCjDwTG56J7PYbCEtxdXxHidONUlaX/0Js=;
        b=jthWOozqPOApjFKNUZtZ6YcqkmzizP8cDQwPyQe/KWpLmsvVa10WZr/oDi64ONKJg5
         eKDDmJTzDVb6w+0GQDebsiCKhjGVgZkbVqRjDXMtVUZBBU1fVA0zLhEzWjS0E+ruNqtW
         +AuVmrI9kMZeo4uQnlVi8fDpTQ5xuT7dQeg4ehVKroOOzC1gf+NUTlkxbqmPszSxpvgQ
         kM3H0sfS6iKBGGbM060ep5jdYq/JjN/hgy/ywINe4QC3xy6l3YpKcYZeXOUwTLITtGIS
         pXgxlpYGrIMKvxBq4Ag4wxz5JZUNfG9JxE7fLTopHeVGrqYpad1S7a4uMB1HG5KqQWoe
         vDQw==
X-Gm-Message-State: AGi0PuYmm1iyXCrwUNHF5snrSfFp9ki+S7uEzYW8DTVbgnUYOP23MgSK
        wdOpEBQCWAoe8Zt84floLSvB17arGzUvDOlscMA3ZA==
X-Google-Smtp-Source: APiQypIY+3gHVfOON959mT3BWUZJaXvVOSvN8K0EQOmiQuny69JdN42ugLz+DORki8l/0FvOcEvx2X4tgIn4sOhB9vA=
X-Received: by 2002:a19:700a:: with SMTP id h10mr2752575lfc.184.1585843907063;
 Thu, 02 Apr 2020 09:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200327172331.418878-9-gladkov.alexey@gmail.com> <20200330111235.154182-1-gladkov.alexey@gmail.com>
In-Reply-To: <20200330111235.154182-1-gladkov.alexey@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 2 Apr 2020 18:11:20 +0200
Message-ID: <CAG48ez2L__TODzwQW0MjYim6rh=WjkU__xvAoi2CtBCkNP2=Fg@mail.gmail.com>
Subject: Re: [PATCH v11 8/9] proc: use human-readable values for hidehid
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 30, 2020 at 1:13 PM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
> The hidepid parameter values are becoming more and more and it becomes
> difficult to remember what each new magic number means.

nit: subject line says "hidehid"
