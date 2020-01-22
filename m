Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15830145DDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 22:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgAVV2g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 16:28:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33234 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbgAVV2f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 16:28:35 -0500
Received: by mail-lj1-f193.google.com with SMTP id y6so760879lji.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 13:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PP/urhQquewzkG31d0Bv7dDFia5iR+GM30A5qGisAZo=;
        b=SajScBwd4/UgrKZ/eVeac0PAAa2fMsMBlaOt+S4HYTMSTOVX1fean3ODPcrMpj6p2j
         jHIQdCzp3GGZYgZu4+713u5JCIJvtBaGV8GyCv+TZtPHE9JwAYOE4vI2XNoQQ3vXnpY6
         WSDE6fmUWAO7J2BZRwVEFvWzel/QXOW1O5NvulCVV+pdmbStD3TY81ncvW1bpughUSE7
         2SIe/PWiNyn5zX0M/wObHzpX0R32aAyIk8Qzzh9YZ4xbukPkHxb9FX3006vvXGHBsvWj
         XgFf9H3u7iPfs4x4kJu4mOE5CEV2LIJZkk4/6a/VIKBehACNhWRJMwRhP0IZNpAJ4JcM
         bSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PP/urhQquewzkG31d0Bv7dDFia5iR+GM30A5qGisAZo=;
        b=gH2/9dR+Z7/W8RbXC5SWJk+QzSCFtAXyu0ctjfd4sezSmaorUpHQartMuWUKViGtr8
         9JbU1L8oA2tSek7gSwoRvpTM6vliI6eaJXIuy7bsjlCnm9copZI/ys83fVaMRAD2gtnd
         0kVI8SvofFNlPxj0PNyquV2V6FX+RAsrVwdHUovGZ1ZuXdIKTmee8MkVGDS1WjYBfs4s
         SmKbHCGAPHcn9PerFxr+QTIn0+QwYkydtrbgJ+fzARGP4Yf2GovzmL+GmNelz1GN+Nmw
         Nj4d6uFQ2ScSRTG11IX1m1RNQSXWW/cE0yfVWFYaJq2HX4eqvgutrze/FVvdzHwx1F2/
         fvyQ==
X-Gm-Message-State: APjAAAX4MXpS88Zjn3/iXVshgD5kIxTzlYyXtG7JZTXpWvTExQ82K2BB
        wH1te1v4fDx1cn9Cqyh97XUDtdGKrVkbgQ9U3IyY8Og=
X-Google-Smtp-Source: APXvYqzouLX05x7dEZusBBRcnAKMMWYsgy2d+H9MFjd13MPyiEyOVYhFhGf6qiCbTeoXa/XkPTez2v/ENY6/zc2Zo34=
X-Received: by 2002:a2e:6f19:: with SMTP id k25mr20795552ljc.84.1579728513965;
 Wed, 22 Jan 2020 13:28:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577736799.git.rgb@redhat.com> <b3725abab452beaba740ac58f76144e6c3bda2fa.1577736799.git.rgb@redhat.com>
In-Reply-To: <b3725abab452beaba740ac58f76144e6c3bda2fa.1577736799.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 22 Jan 2020 16:28:22 -0500
Message-ID: <CAHC9VhQ=+4P6Rr1S1-sNb2X-CbYYKMQMJDGP=bBr8GG3xLD8qQ@mail.gmail.com>
Subject: Re: [PATCH ghak90 V8 05/16] audit: log drop of contid on exit of last task
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 31, 2019 at 2:50 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Since we are tracking the life of each audit container indentifier, we
> can match the creation event with the destruction event.  Log the
> destruction of the audit container identifier when the last process in
> that container exits.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit.c   | 17 +++++++++++++++++
>  kernel/audit.h   |  2 ++
>  kernel/auditsc.c |  2 ++
>  3 files changed, 21 insertions(+)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 4bab20f5f781..fa8f1aa3a605 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2502,6 +2502,23 @@ int audit_set_contid(struct task_struct *task, u64 contid)
>         return rc;
>  }
>
> +void audit_log_container_drop(void)
> +{
> +       struct audit_buffer *ab;
> +
> +       if (!current->audit || !current->audit->cont ||
> +           refcount_read(&current->audit->cont->refcount) > 1)
> +               return;
> +       ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_CONTAINER_OP);
> +       if (!ab)
> +               return;
> +
> +       audit_log_format(ab, "op=drop opid=%d contid=%llu old-contid=%llu",
> +                        task_tgid_nr(current), audit_get_contid(current),
> +                        audit_get_contid(current));
> +       audit_log_end(ab);
> +}

Assumine we are careful about where we call it in audit_free(...), you
are confident we can't do this as part of _audit_contobj_put(...),
yes?


>  /**
>   * audit_log_end - end one audit record
>   * @ab: the audit_buffer
> diff --git a/kernel/audit.h b/kernel/audit.h
> index e4a31aa92dfe..162de8366b32 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -255,6 +255,8 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
>  extern struct tty_struct *audit_get_tty(void);
>  extern void audit_put_tty(struct tty_struct *tty);
>
> +extern void audit_log_container_drop(void);
> +
>  /* audit watch/mark/tree functions */
>  #ifdef CONFIG_AUDITSYSCALL
>  extern unsigned int audit_serial(void);
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 0e2d50533959..bd855794ad26 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1568,6 +1568,8 @@ static void audit_log_exit(void)
>
>         audit_log_proctitle();
>
> +       audit_log_container_drop();
> +
>         /* Send end of event record to help user space know we are finished */
>         ab = audit_log_start(context, GFP_KERNEL, AUDIT_EOE);
>         if (ab)
> --
> 1.8.3.1
>

--
paul moore
www.paul-moore.com
