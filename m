Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880E91C3F8F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 18:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgEDQQD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 12:16:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42511 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbgEDQQD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 12:16:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id v2so6937241plp.9;
        Mon, 04 May 2020 09:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2qr/Rk79g2nyCpDovhCY1s+LWpouRn7/uoh4iQYGd3A=;
        b=bbZ4Z5WpjtQ/DIbg3J0QTujULI9KDWOJo6Z+xzSyFMeQU72ezGxp6NcY9YiO4gPvCk
         nO2JIi8nlfhW4iu78U6pLD5k7Bq+Mt5wv6t+2syb+shj+9EGpH+hu5z1Jj6zA8f8hKFI
         TNYQlYBSUJWdYWVoeIGPDdLUMwnH0ZjwkSXcfQzVqhNnsdL84GgwuncyxrnCkQpC1BJl
         53xPX2G3QVAx3qVvLHuo3YC5gr/IzP/6bTHtl676+QUqVFHOa3+8bgav3pNTzwk6EYXr
         mg36GidhX73kb2hYzldMleIwBFF347olBGPbQqwOyv40JO1xU5MoSeYYDuNqwtuj/tug
         HipQ==
X-Gm-Message-State: AGi0PuZB7L/p0fFPaXActO6Slp6Nimf+b+hUyOgtsvMCXAUuuLOX0uZU
        eXXR2z01ffzbBPmga1+3PY8=
X-Google-Smtp-Source: APiQypI11dj1BVZm0pIlZtfQDOMV2Dgjh1v2g/gqiPgsYO6t7Us71OisiFDj5bDWYh1D4JNJCy0RzQ==
X-Received: by 2002:a17:902:8608:: with SMTP id f8mr9045plo.110.1588608962714;
        Mon, 04 May 2020 09:16:02 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id h13sm9193057pfk.86.2020.05.04.09.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 09:16:01 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 8F58F403EA; Mon,  4 May 2020 16:16:00 +0000 (UTC)
Date:   Mon, 4 May 2020 16:16:00 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v3 1/6] block: revert back to synchronous request_queue
 removal
Message-ID: <20200504161600.GQ11244@42.do-not-panic.com>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-2-mcgrof@kernel.org>
 <a2c64413-d0a4-e5c8-e0fa-904285a1189e@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2c64413-d0a4-e5c8-e0fa-904285a1189e@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 01, 2020 at 05:22:12PM -0700, Bart Van Assche wrote:
> Please fix the spelling errors. Otherwise this patch looks good to me.

Fixed, thanks for the review.

  Luis
