Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB912444A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Aug 2020 07:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgHNFtK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Aug 2020 01:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgHNFtJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Aug 2020 01:49:09 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68090C061757
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 22:49:09 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k20so6912309wmi.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 22:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tfz-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fBBZ1VE6Pl61w02scuLSTrYPkXkkmltKzTwwdi9Dq0s=;
        b=cvBvSNsGQMXqH9DBta9cyj9+60K2gEDrczZHyxiE8AJxJRKljzClHw97cLtJ2F07aW
         jswI2vSz37+TmOVWQFyqYFrCFMNaRh3Vc9wE0fxjHcNjto+yZaFcbEpQy+MKkzLBufLu
         AkOHko/GEmRONQjkTQ4mZ3G3AEI8SX6yV3rPr0ZVIm9J7fGisb+kbHJWf1x86bnHsKr3
         3/MtNrjD7waRFt6sUM0f/2BIoXNbufacioD1ZVbHY+ZusXgJM9PNp7iQ+he+amu3U9Xc
         qNVrG52Qft+BPLUAmqlG1i4TeCsna6iyk2EtqF8zJzrr3VwjEOPtrt3fRwCXRly++M7Y
         TgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBBZ1VE6Pl61w02scuLSTrYPkXkkmltKzTwwdi9Dq0s=;
        b=Lvp9hI9lLqoNAjpau1uQZLb2Ft7Rm/UL5+dSh9LDgI14if4cfhYrCnnIPMTtTUG2ym
         63NYHK0nzTnOgKTcb0FBKi0D8Ue5ehq1Beg8FOB7/sTQR8hm16yNyJGOdOSAjmoIeQir
         I3CI/rXqnX9BnDmdUd2z7GBZlI3O3KJbkubFx1iVhCpzDxtp1dzJ6/CjeVU1BX9tNCcb
         dyVZQw0//tA66IgnEUPGHNRWT82opD91Jrxm34HspXlRpEALt3UGIAQgbhkgmu+bvErt
         Cveus9nOjPgnMMKJk8/zGaviqFEgaX9qCJIE+4KnSNpQS0JlzY0WvqN5/htiyoH7lAxu
         Aekw==
X-Gm-Message-State: AOAM533lY5/UNxXnMDbSsFxQ390a6pH/8ksZEaSQI+QoJPPKoGvbcORN
        lc/jhm+I5F6ki+mAPpgZKDRuq6TlNjDIvOGbFncJqg==
X-Google-Smtp-Source: ABdhPJzmBEbq57a5AKVMkRh0f1Dj6D+omdtilofEgPXHIXGj3ylfJN8FqdFPh71kSsTOYaOAgWrNM0Gf9GAGwnRCIOI=
X-Received: by 2002:a1c:bd56:: with SMTP id n83mr916007wmf.64.1597384145882;
 Thu, 13 Aug 2020 22:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200814035453.210716-1-kalou@tfz.net> <20200814035453.210716-3-kalou@tfz.net>
 <20200814052801.GA10141@infradead.org>
In-Reply-To: <20200814052801.GA10141@infradead.org>
From:   Pascal Bouchareine <kalou@tfz.net>
Date:   Thu, 13 Aug 2020 22:48:55 -0700
Message-ID: <CAGbU3_kOhXEx2s19P==F2-CyHFGbX_qKVWhPi+kPe3tmsY=HfA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] fcntl: introduce F_SET_DESCRIPTION
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 13, 2020 at 10:28 PM Christoph Hellwig <hch@infradead.org> wrote:
> > One intended usage is to allow processes to self-document sockets
> > for netstat and friends to report
>
> NAK.  There is no way we're going to bloat a criticial structure like
> struct file for some vanity information like this.

The useful case is for sockets - Is there a more suited place to do that?
Do you think adding a setsockopt and sk_description to struct sock
would work, or would be considered the same?
