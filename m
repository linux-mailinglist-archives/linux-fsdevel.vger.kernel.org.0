Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC820118C9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 16:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfLJPf5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 10:35:57 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44299 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfLJPf5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:35:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id d199so16767pfd.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 07:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2fl7MawNYz3ZkzAynbewcYICAZpqfTz/726fJLPlUqY=;
        b=dLr9mxK51zZV+Yu2FI7AUlxZvrxRgKsin4pzn22uIL01caSkZBm0F9Ej0HqRbj5Ntw
         iDS6aVTPjxYGrCnHxfnEPz5AupmhMGnJaNwJTqAZscAogtCDNRi3ntrAWDd6j+BA31d/
         7NN8HG2uotdH5Nd3+DKTuPRACNDQeoB6p/OWfLJbHnG3ssvxaZUBQ7a3hPexwP8R5Mtc
         EBKv51edPLT/5zNFy9pcCQCOTKJJ4Y6ab0sKXDFvOsWZGqCbOCSV4gXmTF5IdvqzZqdX
         0e+owlJwnLoGMrXgLvZSoQrSiJBGrWSDpWokCd0zk2HZpmOoGYw2jidyJr5yhDTicMB+
         Gf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2fl7MawNYz3ZkzAynbewcYICAZpqfTz/726fJLPlUqY=;
        b=FozBQ8VP0AAduxY07gVGUTuUvh6hAN3BKDp4+3Hzxbk1VDH7qPjJwOfHnIp7t1d/1A
         kb8nOTcELvb1fcv+RyMPUhSyCN50+9kLoTyaLnDrXJefNZ6TIdhulBYlp1paVJ00uL6g
         ldydrGYJCWaHzdJk4weHfn9m4C0FMoRnj39wUe4rU/m+Hyv06KVpfunj1tqhKWBtb3b5
         QlhxPIahJ81q+KZyIy0odLcEpLXHmUcN+2grQvDVn7SC9VHkYwdqVuIR4Idix3Hzy3/m
         zic13RHXN1aziA46OHVXq7QaOeY8Q0b362FgJ5g2DIh1LAdHOklE0WDxB6ux8m/zhzPo
         JjXg==
X-Gm-Message-State: APjAAAWrdFVi2rhOfsfDK78xGSn2y5tBT5NQ7ctJmIzj9as1w1vl12uN
        Msw/gNeTv5ibHx71tEmwqkGTfw==
X-Google-Smtp-Source: APXvYqw+0QHiTBM7Qw/N1xP/7gvnoWtJZQTrHTkAPTM1Ce7db9yrq1cTc2dYcF2z10B/9s1kz9bM6g==
X-Received: by 2002:aa7:9f9b:: with SMTP id z27mr36066045pfr.102.1575992156359;
        Tue, 10 Dec 2019 07:35:56 -0800 (PST)
Received: from cisco ([2601:282:902:b340:b1ae:d960:d4d7:eda9])
        by smtp.gmail.com with ESMTPSA id e12sm1501838pjs.3.2019.12.10.07.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:35:55 -0800 (PST)
Date:   Tue, 10 Dec 2019 08:35:55 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Sargun Dhillon <sargun@sargun.me>,
        linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, jannh@google.com, cyphar@cyphar.com,
        luto@amacapital.net, viro@zeniv.linux.org.uk,
        Jed Davis <jld@mozilla.com>,
        Gian-Carlo Pascutto <gpascutto@mozilla.com>,
        Emilio Cobos =?iso-8859-1?Q?=C1lvarez?= <ealvarez@mozilla.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v2 4/4] samples: Add example of using PTRACE_GETFD in
 conjunction with user trap
Message-ID: <20191210153555.GD22803@cisco>
References: <20191209070646.GA32477@ircssh-2.c.rugged-nimbus-611.internal>
 <20191209192959.GB10721@redhat.com>
 <BE3E056F-0147-4A00-8FF7-6CC9DE02A30C@ubuntu.com>
 <20191209204635.GC10721@redhat.com>
 <20191210111051.j5opodgjalqigx6q@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210111051.j5opodgjalqigx6q@wittgenstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 10, 2019 at 12:10:52PM +0100, Christian Brauner wrote:
>
> #define SECCOMP_IOCTL_NOTIF_SET_FD	SECCOMP_IOWR(4, <sensible struct>)

There's even some code already for this one:
https://lore.kernel.org/linux-fsdevel/20180927151119.9989-6-tycho@tycho.ws/

Tycho
