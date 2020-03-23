Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0AB518F52F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 14:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgCWNEc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 09:04:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39606 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgCWNEc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:04:32 -0400
Received: by mail-io1-f68.google.com with SMTP id c19so13987632ioo.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2020 06:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WdGLQzezyq9OphpE6WZDm57hDQTuC3YtFB8XLougBfs=;
        b=d8YsvRxg1TOfyHTOC1SbJK8pjUMj0u2Lgbza3wNkfkJwpk88xiue8D5VZdVYELpSsQ
         A7MheIJ86rL01GOMOzU1VQpIppung0aJKqRQV2+I6vo5b3JYP6X1j3QsCcm5uIBBSBYa
         dXQp+GX0Nr2NG9iCbUNQ/hx9A50PYWpCbf6ICNZWAugZAl/nyEaP26VPEglUmDnIfMSy
         xrdCduuCCKnZAtsUU+CQubRCd5Lp4f8JhH8k55CGdMH/qJ6sbHF9lNnwY+/d+flXj65X
         4F61aDV4dH7muQxXX+jJijbpJK3h0rRJXVUILSjDVXfEPJMWYW0Z77oOJVJSyi9bTGGX
         Is8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WdGLQzezyq9OphpE6WZDm57hDQTuC3YtFB8XLougBfs=;
        b=hQ8hd6ZP5NeFKxGwG5nag3XxFou6dXYAJYsxoZBzyfoh5URcICnKP2P747+c8ExjfR
         ToFeMnNuDBONSgSr6g8wUJpkQ0qRVM3BC6iTe7m/gsNZ1wylDmdVw6fLfjvuD7eYo1/5
         XNarbBMwfiYPYCaCNUvMYRKi6iVVuUE8KVmJGVM+SEWYySXI2zS5mQcd8iixPavXZAbY
         y/DjsAWFZVaLdz5MpbtienVaEQpUmk9FxQzTXT7Szy3NKCIzzUxngnowRQh4wU9FSm4r
         YvAR6rYbVy7htKVMW8M03XraAVBwCez/FAOKurNUsRprGnoPDSt04GgK4Ny9AMxi7Prd
         KvAA==
X-Gm-Message-State: ANhLgQ1YS4vnX1MAbRW9xJ3ZqzuX/zwjb6zhHJG5QJwHRpY03qc1l8fo
        g4j9jCtjDu2DJPDWshYcVeyS64da+DpLKNpixu1meA==
X-Google-Smtp-Source: ADFU+vsQ5ye327FDx/CgkWjL6jrnxPxYcwRuE092BzKYayWoxsHEfucoyHZIhZZKEGqYsBhFs6dcDgjbTGJ/ElnDSLo=
X-Received: by 2002:a02:304a:: with SMTP id q71mr19759977jaq.123.1584968671493;
 Mon, 23 Mar 2020 06:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <TY2P153MB0224EE022C428AA2506AD1879CF30@TY2P153MB0224.APCP153.PROD.OUTLOOK.COM>
 <20200323115756.GA28951@quack2.suse.cz>
In-Reply-To: <20200323115756.GA28951@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 23 Mar 2020 15:04:20 +0200
Message-ID: <CAOQ4uxixHS6p44DObK=raGjmRUjLVoCozhpv_H85gUcdftOeRg@mail.gmail.com>
Subject: Re: Fanotify Ignore mask
To:     Jan Kara <jack@suse.cz>
Cc:     Nilesh Awate <Nilesh.Awate@microsoft.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 23, 2020 at 1:57 PM Jan Kara <jack@suse.cz> wrote:
>
>
> Hello Nilesh!
>
> On Sun 22-03-20 17:50:50, Nilesh Awate wrote:
> > I'm new to Fanotify. I'm approaching you because I see that you have done great work in Fanotify subsystem.
> >
> > I've a trivial query. How can we ignore events from a directory, If we have mark "/" as mount.
> >
> > fd = fanotify_init(FAN_CLOEXEC | FAN_CLASS_CONTENT | FAN_NONBLOCK,
> >                        O_RDONLY | O_LARGEFILE);
> >
> > ret = fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,  FAN_OPEN_PERM | FAN_CLOSE_WRITE,
> >                                    AT_FDCWD, "/") ;
> >
> > Now I don't want events from "/opt" directory is it possible to ignore all events from /opt directory.
> >
> > I see examples from https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/fanotify/fanotify01.c
> > But they all taking about a file. Could you pls help me here.
>
> There's no way how you could 'ignore' events in the whole directory, let
> alone even the whole subtree under a directory which you seem to imply.
> Ignore mask really only work for avoiding generating events from individual
> files. Any more sophisticated filtering needs to happen in userspace after
> getting the events from the kernel.

There is no way so set an 'ignore' mask, but it is possible to use the fact that
the mark is a 'mount' mark.
By mounting a bind mount over /opt (mount -o bind /opt /opt) operations within
the /opt subtree (if performed from this mount ns and with path lookup
done after
mounting the bind mount), will not generate events to the mount mark on /.

Thanks,
Amir.
