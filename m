Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB86F211266
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 20:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbgGASOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 14:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbgGASOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:14:40 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154CAC08C5C1;
        Wed,  1 Jul 2020 11:14:40 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id dg28so20900841edb.3;
        Wed, 01 Jul 2020 11:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mLcYZYfXrLLmrM/puOG+soPTfd30cxtKUrRS7WI6ng4=;
        b=BRPKmLM1MkbWv32OZHR9VQ2JPdU696KsT6AAzUBoxN65GdBlBQWWWOj5h/OxGc0ixC
         nAQ9z0LrAHKG9E/5qYX275f31V9EFtVDBoQDNyy2lEyk2Nb/QHAEaViIr+6N8/wAyE1M
         qejlTgUYWRLmM9ySsmMVi1lpQdi4+wiMZVH+HaUyJLq+Jz29Af3uILM/O1PJjib5sDww
         zTnvcg9kKu919WNcAOt7A2yLBjWqU5TyKsvzbaZpks3ADKzVpgYMkmJ/UlBjF+8mESMF
         t6KfQ/FXBes8PIYKmNuQOptnqMfVpVmJFsVzNC1F6pk+03jyUiTS3XOkqfZtmeVL2vqT
         yx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mLcYZYfXrLLmrM/puOG+soPTfd30cxtKUrRS7WI6ng4=;
        b=t76UTfw8Ar3aJaxPGtlPQ7oclPcIrjEG8CgMFHrC5bSpAMJk3H+Kk1c3rFcqSArHtW
         pbqXNYfp83QT6jh2wggXpn2ylMksaUaKVgfGz3ZTc6OBzD+YtI1DxeEn0SdMD5xIhkTA
         KvzvFPzJfphcZsv1xwhnrvgSgSsCaelEcMxib/FdJy+KxTfBXuG1+FiTCgS1JalvJzro
         3BwfeqjdslxWxmPsG6K0OGgBp7O0kRrwDEPBuTr2coigbDS+Gu88AoxhOf04OitBJIhg
         Q46ObdaC9IhNQq1gPRBc/2yu1uFg/qpZ6y5JWSNpVe64lVvyEaYJ6iRhJQki9denJBBR
         hrlw==
X-Gm-Message-State: AOAM531GVJ8CPtl/KbrZBZqTLcdX+aRZzRxXOaCzil0dOrQBkvzCf6bL
        DfnGX0e4FWhYTpTF29QM6w==
X-Google-Smtp-Source: ABdhPJy0IH2YHRQjW2SIiGuoagp0vZ3yw4YIe6AjkE4gK4IZ/YXvtsnjtuIaTg2CZkh6qG2sfu+5tg==
X-Received: by 2002:a05:6402:176e:: with SMTP id da14mr14951195edb.262.1593627278830;
        Wed, 01 Jul 2020 11:14:38 -0700 (PDT)
Received: from localhost.localdomain ([46.53.251.41])
        by smtp.gmail.com with ESMTPSA id ck6sm5910337edb.18.2020.07.01.11.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 11:14:38 -0700 (PDT)
Date:   Wed, 1 Jul 2020 21:14:36 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     tglx@linutronix.de, kzak@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/proc: add short desc for /proc/softirqs
Message-ID: <20200701181436.GA100441@localhost.localdomain>
References: <1593614103-23574-1-git-send-email-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1593614103-23574-1-git-send-email-pizhenwei@bytedance.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 01, 2020 at 10:35:03PM +0800, zhenwei pi wrote:
> Only softirq name is not friendly to end-users, typically 'HI' is
> difficult to understand. During developing irqtop/lsirq utilities
> for util-linux, Karel Zak considered that we should give more
> information to end-users. Discuss about this:
>     https://github.com/karelzak/util-linux/pull/1079
> 
> Add short desc for /proc/softirqs in this patch, then /proc/softirqs
> gets more human-readable.

> --- a/fs/proc/softirqs.c
> +++ b/fs/proc/softirqs.c
> @@ -20,7 +20,7 @@ static int show_softirqs(struct seq_file *p, void *v)
>  		seq_printf(p, "%12s:", softirq_to_name[i]);
>  		for_each_possible_cpu(j)
>  			seq_printf(p, " %10u", kstat_softirqs_cpu(i, j));
> -		seq_putc(p, '\n');
> +		seq_printf(p, "  %s\n", softirq_to_desc[i]);

This could break parsers. I'd rather leave it as is and update proc(5).

Of course this file doesn't need more characters in it. :-\
