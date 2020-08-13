Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9E02435B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 10:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHMIDd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 04:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgHMIDb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:03:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD1DC061383;
        Thu, 13 Aug 2020 01:03:30 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u20so2424471pfn.0;
        Thu, 13 Aug 2020 01:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RqsifCiAhji+v9/0Nl+nveB8RvYggbiLA9HaPT9XDH8=;
        b=AsbARyz+knnSACtM8aRkLPjNd4S/nV+k0AShaCEGBLWY/jo72IAfjEnVDHd9ysj6r7
         RHPe9bfx/Xh1C3tgU+7GP1zKZlIf+kvqtG9EygSWxVM4wvzw43pyThM2feSG3hrBGsfg
         YBuY89woq8SiubLQtduQnGjmt/qa1D4FkQ0pX8c0oMqXkgKtGzjqJBDpz00ogwtea9aY
         /nVu2jmtfxscPkwYi22s50/eVPsiCJ+aOfw9W/EBXbtAhpY8RISVdNlpTX+oLwV6p1lW
         /dXpSADelHBEJZ33Wqt1rLMu6akKQoOIb2PZ+RAPUQAtMM5S+8i7FCwf4NfNoiJafPSE
         926Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RqsifCiAhji+v9/0Nl+nveB8RvYggbiLA9HaPT9XDH8=;
        b=EMJOIN9BWyzk9z4cIln3PbM0a4uTIrubI49vuduKz9/st8MPrras9Z7Qgd5Z77ify+
         qDHV4iT+pb5q3hg10LF1YBDNW09AUbX2fcBpYXwzmGO+H2emF/vGaFNkGIlLEndhFUuQ
         WLrPRzxN4gT1IKqbcU+VrrVLIz/i1qZWpPWij1sWr8wEWRcg6k9fGFGHRvDsEwME4+tF
         gi4HSRSnmA+VzEIUwaaq02Ec7wSKELSs0cFGyis6JUKlPqnYmmyDFbl/HWTfvJNysvty
         LPBnVdSicHq7Ez7xlKY2oeBb8+HO7HAgcgFGKzMHv+j0dqzjPjW8WH96Z/fG8XcllmgI
         Iz5Q==
X-Gm-Message-State: AOAM5302hw4PXeHKG5bS8f1nKnUICQBANvZM/lPnt6YBWEyhxtVOyOf1
        bk/TspQuPZCmh1yhMkuFJvM=
X-Google-Smtp-Source: ABdhPJzRvg3H9q4IYOWoBtnFcsengARDJyvb7kUC8e0uTFifBPP/wD09bBVmUMrs3lsSb5BfaezT5A==
X-Received: by 2002:a05:6a00:22cc:: with SMTP id f12mr3125096pfj.42.1597305809910;
        Thu, 13 Aug 2020 01:03:29 -0700 (PDT)
Received: from gmail.com ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id e125sm4868483pfh.69.2020.08.13.01.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 01:03:29 -0700 (PDT)
Date:   Thu, 13 Aug 2020 01:03:27 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     Eugene Lubarsky <elubarsky.linux@gmail.com>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adobriyan@gmail.com
Subject: Re: [RFC PATCH 0/5] Introduce /proc/all/ to gather stats from all
 processes
Message-ID: <20200813080327.GA604888@gmail.com>
References: <20200810145852.9330-1-elubarsky.linux@gmail.com>
 <20200812075135.GA191218@gmail.com>
 <ffc908a7-c94b-56e6-8bb6-c47c52747d77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <ffc908a7-c94b-56e6-8bb6-c47c52747d77@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 10:47:32PM -0600, David Ahern wrote:
> On 8/12/20 1:51 AM, Andrei Vagin wrote:
> > 
> > I rebased the task_diag patches on top of v5.8:
> > https://github.com/avagin/linux-task-diag/tree/v5.8-task-diag
> 
> Thanks for updating the patches.
> 
> > 
> > /proc/pid files have three major limitations:
> > * Requires at least three syscalls per process per file
> >   open(), read(), close()
> > * Variety of formats, mostly text based
> >   The kernel spent time to encode binary data into a text format and
> >   then tools like top and ps spent time to decode them back to a binary
> >   format.
> > * Sometimes slow due to extra attributes
> >   For example, /proc/PID/smaps contains a lot of useful informations
> >   about memory mappings and memory consumption for each of them. But
> >   even if we don't need memory consumption fields, the kernel will
> >   spend time to collect this information.
> 
> that's what I recall as well.
> 
> > 
> > More details and numbers are in this article:
> > https://avagin.github.io/how-fast-is-procfs
> > 
> > This new interface doesn't have only one of these limitations, but
> > task_diag doesn't have all of them.
> > 
> > And I compared how fast each of these interfaces:
> > 
> > The test environment:
> > CPU: Intel(R) Core(TM) i5-6300U CPU @ 2.40GHz
> > RAM: 16GB
> > kernel: v5.8 with task_diag and /proc/all patches.
> > 100K processes:
> > $ ps ax | wc -l
> > 10228
> 
> 100k processes but showing 10k here??

I'm sure that one zero has been escaped from here. task_proc_all shows
a number of tasks too and it shows 100230.

> 
> > 
> > $ time cat /proc/all/status > /dev/null
> > 
> > real	0m0.577s
> > user	0m0.017s
> > sys	0m0.559s
> > 
> > task_proc_all is used to read /proc/pid/status for all tasks:
> > https://github.com/avagin/linux-task-diag/blob/master/tools/testing/selftests/task_diag/task_proc_all.c
> > 
> > $ time ./task_proc_all status
> > tasks: 100230
> > 

Thanks,
Andrei
