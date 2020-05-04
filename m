Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BAC1C3FA5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 18:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbgEDQSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 12:18:42 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54753 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbgEDQSm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 12:18:42 -0400
Received: by mail-pj1-f68.google.com with SMTP id y6so15871pjc.4;
        Mon, 04 May 2020 09:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UcAes9dKbhDmITA6s1NANGpIuREAaX05wcOATAsEP80=;
        b=pJS/yV71GHbU8tcmcKHP5GO5gebehXT+ADQYy1OjCKpfghPJUtgNHF/Yv5JZ8dkliO
         K5XhoNinpRKpaaBE4CG1OUOzdP5XkAAhhP3v6Tb9uAMXkXBOTEICurR/cV1v8UJ3GJ04
         i2PAAUe6RiM9W4mR34/Ffxqrh4Qwb2AIbOUJc4K0qgkLmBmbRo+D79mJhHRbPRfAoqOi
         q+gtdIZPISxunU2CrvY5FJOXH2HInMerJbQjAHJqwsDfTFGfEHsCvtqCNAwRGDlUSjzP
         4/m00CMW4MrtJ56JVZT1LzLYoiqjj1tp4xVZUR6wSf//xMY4ILRPEXHzhptCt6LiDjBm
         9nvQ==
X-Gm-Message-State: AGi0PuY+gUopi4/77musSdHH1Y+FRI5XcuWHerWP7N5FLj8BuZYKck4w
        cEr2UYGrFh2g6sqlmIcXmks=
X-Google-Smtp-Source: APiQypIv/J90mnsPJN65xf0xV0HC1YW0vCs74bDiiHPXvyMF1oLWZjZWNKSxRycaJe/7fs7j1AMBbg==
X-Received: by 2002:a17:902:b78b:: with SMTP id e11mr18437920pls.311.1588609120522;
        Mon, 04 May 2020 09:18:40 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 1sm9345233pff.180.2020.05.04.09.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 09:18:39 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id AAE17403EA; Mon,  4 May 2020 16:18:38 +0000 (UTC)
Date:   Mon, 4 May 2020 16:18:38 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v3 1/6] block: revert back to synchronous request_queue
 removal
Message-ID: <20200504161838.GR11244@42.do-not-panic.com>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-2-mcgrof@kernel.org>
 <a2c64413-d0a4-e5c8-e0fa-904285a1189e@acm.org>
 <20200503103245.GG29705@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200503103245.GG29705@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 03, 2020 at 03:32:45AM -0700, Matthew Wilcox wrote:
> On Fri, May 01, 2020 at 05:22:12PM -0700, Bart Van Assche wrote:
> > > expected behaviour before and it now fails as the device is still present
> >            ^^^^^^^^^
> >            behavior?
> 
> That's UK/US spelling.  We do not "correct" one to the other.
> 
> Documentation/doc-guide/contributing.rst: - Both American and British English spellings are allowed within the
> Documentation/doc-guide/contributing.rst-   kernel documentation.  There is no need to fix one by replacing it with
> Documentation/doc-guide/contributing.rst-   the other.

I already changed it at Bart's request. I'll leave at like that to honor
US as being the leader in COVID19 cases.

  Luis
