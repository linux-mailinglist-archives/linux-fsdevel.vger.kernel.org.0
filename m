Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143D71D55A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 18:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgEOQMR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 12:12:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36675 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgEOQMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 12:12:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id c75so152558pga.3;
        Fri, 15 May 2020 09:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RG70TiJYGoEhXnutlb3L5GkzC6tQ3GVdkLhBrlshdRc=;
        b=le6gK+2szxzUe3okL707hN83kAI6L1BHiXdaYvkCIZsgJPmQtXSkTVDVt+0QbB4+Li
         2guwDpwFyAlUUI9o1wD/vly9Lly606zw/dxbV3SMTB5zVJ+zJtWpIXBXwq/uLS13FIkT
         B0JNF+ePEIO13alU9q5soFRDXiP3e8hOcB6q9Jkf9elPWA44+wpjip9H2kp4GApdwPm5
         nt6vZsMPN1zsJSOti3QRBE6zmz1na5UkCKHCgSo552AHi9aPf2OESmltnbCAb+C0icAw
         Vic1d7FvTvUoeI98UHFKRqdVlyb6R9uP+AGOWNk+IWcOE+2Z0CR44evvIYMVwZMl8Dwj
         qQWw==
X-Gm-Message-State: AOAM532AdlWkyMV+bQkOtHQViF+ivZYkKIqGZ99rbTnm3MmPNfibJfjg
        ghygAdhWOTFCcSfYp6iJAK8=
X-Google-Smtp-Source: ABdhPJx8zcxmnT0TMR2UidZqY315uPbUbguSKVo3CU18gfFFYDZgANXm3krJvhNTyWsshEDNnemDDA==
X-Received: by 2002:a63:b402:: with SMTP id s2mr3999993pgf.322.1589559135312;
        Fri, 15 May 2020 09:12:15 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id gb6sm1867054pjb.56.2020.05.15.09.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 09:12:14 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 5B37940246; Fri, 15 May 2020 16:12:13 +0000 (UTC)
Date:   Fri, 15 May 2020 16:12:13 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     viro@zeniv.linux.org.uk, axboe@kernel.dk, zohar@linux.vnet.ibm.com,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] fs: avoid fdput() after failed fdget() in
 ksys_sync_file_range()
Message-ID: <20200515161213.GV11244@42.do-not-panic.com>
References: <cover.1589411496.git.skhan@linuxfoundation.org>
 <5945f42e08ee037c4d1d0492622defb5904f4850.1589411496.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5945f42e08ee037c4d1d0492622defb5904f4850.1589411496.git.skhan@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 05:33:20PM -0600, Shuah Khan wrote:
> Fix ksys_sync_file_range() to avoid fdput() after a failed fdget().
> fdput() doesn't do fput() on this file since FDPUT_FPUT isn't set
> in fd.flags.
> 
> Change it anyway since failed fdget() doesn't require a fdput(). Refine
> the code path a bit for it to read more clearly.
> Reference: 22f96b3808c1 ("fs: add sync_file_range() helper")
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
