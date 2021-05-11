Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF08D379DC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 05:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhEKD33 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 23:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhEKD30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 23:29:26 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F40C061574;
        Mon, 10 May 2021 20:28:19 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id h4so26566828lfv.0;
        Mon, 10 May 2021 20:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UEa9Ive7nK1WuR8Ajvbk/luLV33U4rirGsLpL69Zeyw=;
        b=aDDshwxPC27O0V8R1torjwTEvHguvC0D8/F55yOqvAi8WhtAq9Gtsor5qrzQ70bqpU
         3TCxQKuoy9Vic+Gdmwff1sFie7LxkcNWfTsReX3vjam4O9OlflunLCexDNTWuVajbCT7
         ovaEg6pJaIqzDFKqT1b/pg+Bdhu9sbEQIwUEDZIUi8GwyJypOQrCkK1ihNY+2qqLue3b
         FmmstR3/GDr0Qa0B787MwswaLKZAfYwkuHXC0XrHZgs1Y7yiyvrcxwAF895aT8ku268I
         j4jgCTfRnGLg+sdrcdY4CeGCJIWG46oFSCAdfVFiTnsIWlWC18OWIbLHkUoYsqeOnIuI
         YLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UEa9Ive7nK1WuR8Ajvbk/luLV33U4rirGsLpL69Zeyw=;
        b=D1508b/2W/+cy1UVEmRcp9fm80Bk8bQY+BcWNfBWlz2OmpA367850SrLtOTh7sk6mG
         ugcsnLfEl6xC0okVx86mEIrUtJ4q3CzOK7YnqZY7NCMgrTygxYIc+iaVPy0Iev86FK3c
         Oi6XUFi+ArVuC5WmqI5XGMgKxOWQ1LQuBasnGSUyO7jq2Ue/wbNGdoh2fCnZy78453md
         BkCuTsdlSpvnJmcLvKaHCHNpVbbw+J8EKis/GgE8lKIVOURRJgDf8Vpn0Y09ViKEuic/
         +mLE9C2B/WU40WfYmhjT2lrgSFzCEx7Trf5pb+asZW7AxNAuvI5HQY2HSiJbbaagx+wa
         Wwyw==
X-Gm-Message-State: AOAM530+sr5OSw10zoOt69ASR/aPXNoyEf2wHxrYgIvZjVPO9HW3/3bo
        je0LSeB5sJwMapKq5i+Cfabb+g5CpLnPtxx/99E=
X-Google-Smtp-Source: ABdhPJxgKgJ6ZpFG3V8WVcw27quc6yBx/0AL8EhqjFvrgBWyDOTDQHyh2hBqrxrfYOAgGVqRnLeH6TiQtNGQWdfMqHE=
X-Received: by 2002:a05:6512:21af:: with SMTP id c15mr19265348lft.184.1620703698218;
 Mon, 10 May 2021 20:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5ms+NL=J2Wa=wY2doV450qL8S97gnJW_4eSCp1aiz1SEZA@mail.gmail.com>
 <YJnm97asL8gtmL32@casper.infradead.org>
In-Reply-To: <YJnm97asL8gtmL32@casper.infradead.org>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 10 May 2021 22:28:07 -0500
Message-ID: <CAH2r5mt05gD-MR1w_GOyZkGxJr2C=FfHg7FNYZC3HagHNf3+Zg@mail.gmail.com>
Subject: Re: Compile warning with current kernel and netfs
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

$ gcc --version
gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0

$ sparse --version
v0.6.1-393-ge140005c

On Mon, May 10, 2021 at 9:09 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, May 10, 2021 at 09:01:06PM -0500, Steve French wrote:
> > Noticed the following netfs related new warning when compiling cifs.ko
> > with the current 5.13-rc1
>
> I don't see that ... what compiler & version are you using?
>
> >   CC [M]  /home/smfrench/cifs-2.6/fs/cifs/fscache.o
> >   CHECK   /home/smfrench/cifs-2.6/fs/cifs/fscache.c
> > /home/smfrench/cifs-2.6/fs/cifs/fscache.c: note: in included file
> > (through include/linux/fscache.h,
> > /home/smfrench/cifs-2.6/fs/cifs/fscache.h):
> > ./include/linux/netfs.h:93:15: error: don't know how to apply mode to
> > unsigned int enum netfs_read_source
> >   CC [M]  /home/smfrench/cifs-2.6/fs/cifs/cache.o
> >   CHECK   /home/smfrench/cifs-2.6/fs/cifs/cache.c
> > /home/smfrench/cifs-2.6/fs/cifs/cache.c: note: in included file
> > (through include/linux/fscache.h,
> > /home/smfrench/cifs-2.6/fs/cifs/fscache.h):
> > ./include/linux/netfs.h:93:15: error: don't know how to apply mode to
> > unsigned int enum netfs_read_source
> >
> > It doesn't like this enum in include/linux/netfs.h:
> >
> > enum netfs_read_source {
> >         NETFS_FILL_WITH_ZEROES,
> >         NETFS_DOWNLOAD_FROM_SERVER,
> >         NETFS_READ_FROM_CACHE,
> >         NETFS_INVALID_READ,
> > } __mode(byte);
> >
> > --
> > Thanks,
> >
> > Steve



-- 
Thanks,

Steve
