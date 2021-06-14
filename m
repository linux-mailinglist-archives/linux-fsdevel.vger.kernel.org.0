Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447353A70AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 22:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbhFNUqn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 16:46:43 -0400
Received: from mail-qv1-f49.google.com ([209.85.219.49]:44787 "EHLO
        mail-qv1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbhFNUqn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:46:43 -0400
Received: by mail-qv1-f49.google.com with SMTP id w4so13748298qvr.11;
        Mon, 14 Jun 2021 13:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=212ymYp7XEu+lKWxduC+83kiaUY3pqkgv+9qi3641iU=;
        b=ixpntEdyk4n4XpQDDgnK92G2u3+1O1Oz3Fhqal4MiqoQVAoZmarGQIzc1x7iSob77H
         vNzXG5bd7M3JsZPRBHsXNtIVpqpYxAYq+61TxPuyQ2oIhCrqzlXqISfPCgYra4nCNfqe
         3ZOn/WS3+/CArQyHi0AV2aVcy9uk70efLQEPWgAhEPlRauDD66xs/Y6hQMIJHKL/WPub
         zDUT31VW3Eg+meHPP+2TiyzfeRmRBuu7np35feeIqu4XIlmy8etcfa3bgsE6fdmv2EjM
         i/k4a2r3HqU8po5AySg1+/Ss7DP0P4H6lFmsNslpuivserxT92ZaxeqvB0U+0s1x8iJv
         qtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=212ymYp7XEu+lKWxduC+83kiaUY3pqkgv+9qi3641iU=;
        b=LBOjIf6grfMI7R/vmi3ZqJZ4ZPMfmHVDPLX1PN+Wjt0xtN+ekHNRkV8rBY3SlsWiBu
         yww4d3DdBPoAEeyrpUqYGgvGYGj88yWvn8pyyzXv/FZs/6C2qKrK7P0DG+yEZ2Sh+Vv/
         SDJvy9LO1UiwE6+lUDkTozL9uzVdD68k8msFF5fdsQpy3Sv93dFZ1tklDboVeLeMDnYk
         G0ZYUWWdYgktn776IJJg3Z29+PvfPRaRcMOuz5BCcVW3HxyW5TV5/2X7m0JOZXsYdT4y
         F6v8VaT3k57A+Sp6mU+6llHn8usoozTyr15wB+3t/oz0uF1JqUOggYokWvxWvLJFTQIS
         Gjsg==
X-Gm-Message-State: AOAM533S+khh9UmAQiLB4f1JK0nIBEomqkykKO+otecCsTZItXBMASvs
        1dmjmg9r5yVyACKQL706ugk=
X-Google-Smtp-Source: ABdhPJyZiBT2UFA22fxY80PwV97uk8Cilfx14IlToy0lDB7LgmWsIjbP5LulDlyiivN3X3IgnTCUKA==
X-Received: by 2002:a05:6214:1909:: with SMTP id er9mr1028714qvb.13.1623703410350;
        Mon, 14 Jun 2021 13:43:30 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id d16sm10271682qtj.69.2021.06.14.13.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 13:43:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Jun 2021 16:43:28 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin <hpa@zytor.com>, Greg Kroah-Hartman
        <gregkh@linuxfoundation.org>, Rafael J. Wysocki " <rafael@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, x86@kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] cgroup/cpuset: Allow cpuset to bound displayed cpu
 info
Message-ID: <YMe/cGV4JPbzFRk0@slm.duckdns.org>
References: <20210614152306.25668-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614152306.25668-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Mon, Jun 14, 2021 at 11:23:02AM -0400, Waiman Long wrote:
> The current container management system is able to create the illusion
> that applications running within a container have limited resources and
> devices available for their use. However, one thing that is hard to hide
> is the number of CPUs available in the system. In fact, the container
> developers are asking for the kernel to provide such capability.
> 
> There are two places where cpu information are available for the
> applications to see - /proc/cpuinfo and /sys/devices/system/cpu sysfs
> directory.
> 
> This patchset introduces a new sysctl parameter cpuset_bound_cpuinfo
> which, when set, will limit the amount of information disclosed by
> /proc/cpuinfo and /sys/devices/system/cpu.

The goal of cgroup has never been masquerading system information so that
applications can pretend that they own the whole system and the proposed
solution requires application changes anyway. The information being provided
is useful but please do so within the usual cgroup interface - e.g.
cpuset.stat. The applications (or libraries) that want to determine its
confined CPU availability can locate the file through /proc/self/cgroup.

Thanks.

-- 
tejun
