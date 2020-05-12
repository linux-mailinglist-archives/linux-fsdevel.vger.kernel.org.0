Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4BB1D025B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 00:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbgELWbO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 18:31:14 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36779 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELWbN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 18:31:13 -0400
Received: by mail-pj1-f66.google.com with SMTP id q24so10096198pjd.1;
        Tue, 12 May 2020 15:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WkWxKR9pBfc58a1dbN8nbKjJim/7aXCa3UgG7dxJjk4=;
        b=HYnpmAhDpqHBUiL8RIJFL7CVr4rIBaW4yZRR+kAeWsewegDdK3mZSMscCV9pIKKSeW
         XoYHp7B0jEHTmAg818tD8mUN/+3HORk6pVrnTRBJspXfpQCcsffFgMsQOjF/fNN76/x1
         NDZpJ5JxqsQrNzlHgGzffjsEUpsUowhB+BZlxMHI4dE+sZLPJcVf/DrKU1CjFW8CcRdD
         E8Q4O8CuCdPa++Ky4vjy+kBpV87DrEVerK/nEvKJdoGSAtf1ikfpWrXazVqJWiYw/+8s
         Z7sNj4/fqU78aQA0+HMZnpn4Ssj3/hGRhVm3o+upNljAhl3ocLpvp/8tUQvgQsYH4guQ
         dQvQ==
X-Gm-Message-State: AGi0PuY1wBCVSTohLp1a78E0t4Zl9nnCkLi0KYRim54budfEi4Spoyeu
        Y3G+ivlWB3OgHusDQT3jVFc=
X-Google-Smtp-Source: APiQypLrjBA7She0nP+YDikODlUlHGiHQIsgAZbqmYPQb0MLNtvitmQSyo6GKRENaqYo68EVMqNzew==
X-Received: by 2002:a17:90a:fd8c:: with SMTP id cx12mr30597764pjb.211.1589322672838;
        Tue, 12 May 2020 15:31:12 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id d2sm13247052pfc.7.2020.05.12.15.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:31:11 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id F17A04063E; Tue, 12 May 2020 22:31:10 +0000 (UTC)
Date:   Tue, 12 May 2020 22:31:10 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        keescook@chromium.org, akpm@linux-foundation.org,
        yzaikin@google.com, tytso@mit.edu
Subject: Re: [PATCH] kernel: sysctl: ignore out-of-range taint bits
 introduced via kernel.tainted
Message-ID: <20200512223110.GF11244@42.do-not-panic.com>
References: <20200512174653.770506-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512174653.770506-1-aquini@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 01:46:53PM -0400, Rafael Aquini wrote:
> The sysctl knob allows users with SYS_ADMIN capability to
> taint the kernel with any arbitrary value, but this might
> produce an invalid flags bitset being committed to tainted_mask.
> 
> This patch introduces a simple way for proc_taint() to ignore
> any eventual invalid bit coming from the user input before
> committing those bits to the kernel tainted_mask.
> 
> Signed-off-by: Rafael Aquini <aquini@redhat.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
