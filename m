Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAE0105BE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 22:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKUV0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 16:26:10 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:34501 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726574AbfKUV0K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 16:26:10 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id B159E7617;
        Thu, 21 Nov 2019 16:26:09 -0500 (EST)
Received: from imap35 ([10.202.2.85])
  by compute4.internal (MEProxy); Thu, 21 Nov 2019 16:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=6/69v5kzwwhDyJSHFmNIaawk46DHGEA
        8mUJzy7pevwA=; b=QktELoY7y29yHYgufYfRRJ0evbuulBc4+Ztfhe5sFtlrtaN
        fiUcWzuljK0s/yn4BZW6ZRCTY0fh1MYZZ8SWbtEMAx7u68m3UJvAvgkWxcrpQQgw
        IWtkapFjpEBAL2kmXVHumh+B908uMwuDgWg31UrwgaKhRL6K1d3H9C1hu34DPhVs
        X02rR7dpJSAdhiRJ4WmzKb1qJpfu0QdU2EuVzpSZN50RYfBtsSSoeMkZjgdj5MGf
        qjdpBn27DcThQQxj3sl4ZPRNzmfAr7ulI/GkVNyf4iVqzFtZ55q+X06Zbe8RwLGy
        LFkeAd8tc8LpXcokmI1qmNAB0zw5A7KnN+gqMGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=6/69v5
        kzwwhDyJSHFmNIaawk46DHGEA8mUJzy7pevwA=; b=CaOyb4NPQPw/wd+ZUHi79G
        k/bwSqR8fQb1HVRanhjW7HkrhV1UCqw9wozQSfcCaohlb6D2hcLun1qEvN77Z6ae
        4xe54YV+Pm7gM6OVHEtQQgDLKg0Me4cuQ5/cC4W34vuT8PCh5YnFGnfVy3QQusZp
        ApoEK7JQnl1YqzOIp0Abp/00sijiPqJDkbxaSqKh3wmuOqUB3mDAlLknwbdot0dT
        Nx7IaJNqgSb60GOBAE5M8WDdE7m8BflnWEOebbBpKDTzGNGz800EOx2aYYTQGqNu
        ngXiTU8PzlAJGrIc80MmMEmaKm/Y+0ncxvNiJc34yjO+mJVNxqiMFCfGrppfSYQg
        ==
X-ME-Sender: <xms:7wDXXVT5BtzkYJ9B1uyt0yrE_G3VjfJDdVdskd99VkB54iIOOKkHvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudehvddgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepofgfggfkjghffffhvffutgesthdtredt
    reertdenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighi
    iiqeenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiienucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:7wDXXaQrMedGbyHoCXoxVwXBcD72Hwq_9ZyAWy6TD5d5QiDscSak8g>
    <xmx:7wDXXf47d3MvI_zHuuxDP0V15qWzawZmr1qf8QEqzsDzwqsCn9J3pg>
    <xmx:7wDXXb-LZF3BVMZblKj2YgzGdERGcVq8xSXISm84bsQ_QkpxQ2gaIQ>
    <xmx:8QDXXYdQFc8cyYYCqzaVDSU34WUScG-c_ZscYNbpvY8dytUJEF60cw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A19EF14C0073; Thu, 21 Nov 2019 16:26:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-578-g826f590-fmstable-20191119v1
Mime-Version: 1.0
Message-Id: <0e878d0f-0e2b-495d-bc9a-f9663f18d3fa@www.fastmail.com>
In-Reply-To: <20191121210909.15086-1-dxu@dxuuu.xyz>
References: <20191121210909.15086-1-dxu@dxuuu.xyz>
Date:   Thu, 21 Nov 2019 13:25:47 -0800
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     adobriyan@gmail.com, christian@brauner.io,
        akpm@linux-foundation.org, tglx@linutronix.de, mhocko@suse.com,
        keescook@chromium.org, shakeelb@google.com, casey@schaufler-ca.com,
        khlebnikov@yandex-team.ru, kent.overstreet@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     dschatzberg@fb.com, htejun@fb.com, dennis@kernel.org,
        "Kernel Team" <kernel-team@fb.com>
Subject: Re: [PATCH] proc: Make /proc/<pid>/io world readable
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 21, 2019, at 1:09 PM, Daniel Xu wrote:
> /proc/<pid>/io is currently only owner readable. This forces monitoring
> programs (such as atop) to run with elevated permissions to collect disk
> stats. Changing this file to world readable can add a measure of safety to
> userspace.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  fs/proc/base.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index ebea9501afb8..1d1c1d680e16 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3076,7 +3076,7 @@ static const struct pid_entry tgid_base_stuff[] = {
>  	REG("coredump_filter", S_IRUGO|S_IWUSR, proc_coredump_filter_operations),
>  #endif
>  #ifdef CONFIG_TASK_IO_ACCOUNTING
> -	ONE("io",	S_IRUSR, proc_tgid_io_accounting),
> +	ONE("io",	S_IRUGO, proc_tgid_io_accounting),
>  #endif
>  #ifdef CONFIG_USER_NS
>  	REG("uid_map",    S_IRUGO|S_IWUSR, proc_uid_map_operations),
> @@ -3473,7 +3473,7 @@ static const struct pid_entry tid_base_stuff[] = {
>  	REG("fail-nth", 0644, proc_fail_nth_operations),
>  #endif
>  #ifdef CONFIG_TASK_IO_ACCOUNTING
> -	ONE("io",	S_IRUSR, proc_tid_io_accounting),
> +	ONE("io",	S_IRUGO, proc_tid_io_accounting),
>  #endif
>  #ifdef CONFIG_USER_NS
>  	REG("uid_map",    S_IRUGO|S_IWUSR, proc_uid_map_operations),
> -- 
> 2.21.0
> 
>

Nevermind, abandoning. Just found 1d1221f375c94ef961b ("proc: restrict access to /proc/PID/io").
