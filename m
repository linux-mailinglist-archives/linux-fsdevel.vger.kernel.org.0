Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A84B2515DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 12:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbgHYKAL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 06:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgHYKAK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:00:10 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C73C061574;
        Tue, 25 Aug 2020 03:00:10 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m34so6459486pgl.11;
        Tue, 25 Aug 2020 03:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VM+RLzAWrkuL9HVQ42Csb2lSsT42rRve4CGTNXwHLig=;
        b=OeTt0X6JS3ohzMd/hSDssWd+4zy8My22Yg4hcnugnCiDCl2h1J0/oRqN5/WVacbd4s
         i8obfnthPWOE8CY/t/JIXyX0bITkaiWvuvqObBnm/zEQbOl/isDMg33zSQpOkL7pVrgw
         W17sEKKFFPfhueAd4Wgn6upRkBqXVMoH3JYVjFfTQz2WM1n2uZp6SvG0Ewqww+t4l6mS
         ywPoKSis2MDxWAmBUQ/RYIFHGBmGPg6F2EhxOGR4589tNWRecgkNeOj0jqmelNNLq2se
         aV2F/eh4/pTojvdZ0ShfazuAc7Lko3Y40yzJvdRJS/OBY4scMCBr3A1AlNY5/MRolaq6
         x3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VM+RLzAWrkuL9HVQ42Csb2lSsT42rRve4CGTNXwHLig=;
        b=ZUF2oUL3GSfHvzXewAMyOSaFWHXvth2Dv8LGcIcPLNUmj7lJHF+bTcTekGRcMeUDId
         EMz18GmRNXPIiNNrbyHf2ApIsLvR6pyuBmW/G2v1U6op05iIRfS9esEUcoqzHA1nqyOb
         7PBHjyOc8sdCQWKCvG4SRVI/SPU15CXGIduYJk4Ki90oynK85Mes/bkEI9/Wa5E7ILX3
         6a4Y6pZxFnpJbPLaYDZ/TytHJsbHkn5WmayeWqn7ZCpQz+9tNH+3SoBSaQ70Lo9jyCix
         xEstjC/MOknqXEuBA9enviseIQr/MkCVHI7uE5vI6FSjBQ4Gh7QM5HGG3zFWjLSgrQrh
         wYXg==
X-Gm-Message-State: AOAM532biD0A0NrWmT4ohO37Q5Y8/qN0G+S0Aar0YFzpHwmKqllNVDDf
        70k/lmVNOWEZgA8H4ZMij0k=
X-Google-Smtp-Source: ABdhPJzjseP65pqiWG+REWzajbnNnvZ739SyIomxreoKWdiNCub/QbNMoHvZDjzFOPfVoAx7KF5wWg==
X-Received: by 2002:a17:902:6bc3:: with SMTP id m3mr3432524plt.137.1598349608895;
        Tue, 25 Aug 2020 03:00:08 -0700 (PDT)
Received: from eug-lubuntu (27-32-121-201.static.tpgi.com.au. [27.32.121.201])
        by smtp.gmail.com with ESMTPSA id q207sm12699869pgq.71.2020.08.25.03.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 03:00:08 -0700 (PDT)
Date:   Tue, 25 Aug 2020 20:00:01 +1000
From:   Eugene Lubarsky <elubarsky.linux@gmail.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        dsahern@gmail.com, Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH 0/5] Introduce /proc/all/ to gather stats from all
 processes
Message-ID: <20200825200001.548b64d8@eug-lubuntu>
In-Reply-To: <20200820174139.GA919358@gmail.com>
References: <20200810145852.9330-1-elubarsky.linux@gmail.com>
        <20200812075135.GA191218@gmail.com>
        <20200814010100.3e9b6423@eug-lubuntu>
        <20200820174139.GA919358@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 20 Aug 2020 10:41:39 -0700
Andrei Vagin <avagin@gmail.com> wrote:
> Unfotunatly, I don't have enough time to lead a process of pushing
> task_diag into the upstream. So if it is interesting for you, you can
> restart this process and I am ready to help as much as time will
> permit.
>
> I think the main blocking issue was a lack of interest from the wide
> audience to this. The slow proc is the problem just for a few users,
> but task_diag is a big subsystem that repeats functionality of another
> subsystem with all derived problems like code duplication.

Unfortunately I don't have much time either and yes it sounds like
upstreaming a new interface like this will require input & enthusiasm
from more of those who are monitoring large numbers of processes,
which is not really me..

A related issue is that task_diag doesn't currently support the cgroup
filesystem which has the same issues as /proc and is accessed very
heavily by e.g. the Kubernetes kubelet cadvisor. Perhaps more interest
in tackling this could come from the Kubernetes community.

> 
> Another blocking issue is a new interface. There was no consensus on
> this. Initially, I suggested to use netlink sockets, but developers
> from non-network subsystem objected on this, so the transaction file
> interface was introduced. The main idea similar to netlink sockets is
> that we write a request and read a response.
> 
> There were some security concerns but I think I fixed them.

There's currently a lot of momentum behind io_uring which could not only
enable efficient enumeration and retrieval of small files but maybe it
would also be a more natural place for an API like task_diag..



Best Wishes,
Eugene
