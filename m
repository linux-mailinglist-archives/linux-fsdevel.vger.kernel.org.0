Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3CE1A7163
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 05:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404352AbgDNDAb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 23:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404224AbgDNDAa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:00:30 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EA0C0A3BDC;
        Mon, 13 Apr 2020 20:00:29 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id f82so7217850ilh.8;
        Mon, 13 Apr 2020 20:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NeqKXLYrWUpD8jNTcGC4+w/0QPeCB7it9q+iuJn3+6A=;
        b=PFv2e/MWAiprnN1BhiBDycrqJD137NITfKgcM7yyJdOWGGyV+BAY02xot6sVwbHfU+
         uEptpiXO+doA8o30kbNcrmXTY7DmbhUtqjkyGQvFPMGlRMzVxd7tnHfoBetxg4uq/0Vw
         BmRav/H54feN1KZotQw7H6sgqxeWFmzHa/5DgwsiS05E6rcS52FCF8fGHL290i5nf5M3
         U8imVjIi/3FUdqzyBELP7Dlg06lKzJtiiWkcFt09N+wzhCSOwLoGA5sAdqMXJAxAZ9NL
         rOri6Y6EQ0ZBpdrucsic1PNOat0LDsc7bgp/tkYl7E9aEXu6GbyM0Im6zpwd6DJKH+dD
         PT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NeqKXLYrWUpD8jNTcGC4+w/0QPeCB7it9q+iuJn3+6A=;
        b=eDNIZUAPHiYKE0RMfKO3Ud7dY6cgfNcquZSRJKuw843xXgRh2+cVOX4u9HXq0YvIt4
         /5aDZpXPCoG+TG3BIAUaOqS10oXStqbWSF3UIxN6SsDXHPKtktD70+6X9AhjqqLvI0TH
         6Nj4eKP95nsFtp5RiMkcyCd116eHf+71DWK7oIt9J4A2HRjBckZK/ZEOzFalxwpeNmBr
         lPqG+4up+fP/613XtpAvrzyojB2fsr7QTiJ6MtDgmj+ybXcXa5vqRqtS3QDgby+y4rdP
         dxXafcRosJRaAH/rXYtOGTnDV3Po+ULzKAz03tpNbjFda0zwQJ+xMn7EtwksGlpO/s6K
         dRhw==
X-Gm-Message-State: AGi0PuYJ1QG01blnApoVL1QNvC4YZalSEEvnyPrJFPH8QxZXvR+qnc3l
        VTw6In2TKWgT5Woq5w5U/TMXG2WOm+UJiF5jhkXR45Cd
X-Google-Smtp-Source: APiQypIcccZX6FgExHTpUgHvvHh5LMPDLG+hilm7yJjaE8lpm5gSqgSU+a+4KO0VwFPvF16dB7XLOKXGMlciYxuN/C0=
X-Received: by 2002:a92:394d:: with SMTP id g74mr19906784ila.250.1586833229197;
 Mon, 13 Apr 2020 20:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <CABV8kRw_jGxPqWc68Bj-uP_hSrKO0MmShOmtuzGQA2W3WHyCrg@mail.gmail.com>
 <CAOQ4uxhPKR34cXvWfF49z8mTGJm+oP2ibfohsXNdY7tXaOi4RA@mail.gmail.com>
 <CABV8kRxVA0j2qLkyWx+vULh2DxK2Ef4nPk-zXCikN8XmdBOFgQ@mail.gmail.com>
 <CAOQ4uxh2KKwORLC+gWEF=mWzBa3Kh4A4HgRoiad5N5qu06xjcg@mail.gmail.com> <CABV8kRxsGm2-RLsuWPQGc82=6+x8v8FtV0=a6MQS=Nt-Pv3V9A@mail.gmail.com>
In-Reply-To: <CABV8kRxsGm2-RLsuWPQGc82=6+x8v8FtV0=a6MQS=Nt-Pv3V9A@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 14 Apr 2020 06:00:17 +0300
Message-ID: <CAOQ4uxj1csY-Vn2suFZMseEZgvAZzhQ82TR+XtDRQ=cOzwvzzw@mail.gmail.com>
Subject: Re: Same mountpoint restriction in FICLONE ioctls
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 13, 2020 at 10:40 PM Keno Fischer <keno@juliacomputing.com> wrote:
>
> > You make it sound like the heuristic decision must be made
> > *after* trying to clone, but it can be made before and pass
> > flags to the kernel whether or to fallback to copy.
>
> True, though I simplified slightly. There's other things we try
> first if the clone fails, like creating a hardlink. If cloning fails,
> we also often only want to copy a part of the file (again
> heuristically, whether more than what the program asked
> for will be useful for debugging)

Fair enough.

>
> > copy_file_range(2) has an unused flags argument.
> > Adding support for flags like:
> > COPY_FILE_RANGE_BY_FS
> > COPY_FILE_RANGE_BY_KERNEL
>
> That would solve it of course, and I'd be happy with that
> solution, but it seems like we'd end up with just another
> spelling for the cloning ioctls then that have subtly different
> semantics.
>

Yeh. Another spelling is a common way to change behavior.
In fact, it is the only way if you want to avoid changing behavior
of existing application.

Generally speaking, syscall interface is an improvement over ioctl
interface. Flags like:
COPY_FILE_RANGE_REFLINK
COPY_FILE_RANGE_NO_XDEV
along with proper documentation, can help make the change of behavior
explicit. The flags mentioned above would describe the existing
FICLONERANGE semantics.

But the thing is that the above is not just a fancy maneuver for relaxing the
same mnt restriction of FICLONERANGE.
I believe that enhancing the semantics of copy_file_range(2) has benefits
beyond your use case.
copy tools could make use of nfs/cifs server side copy without falling back
to kernel copy.

Thanks,
Amir.
