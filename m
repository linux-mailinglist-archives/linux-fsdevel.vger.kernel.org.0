Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D161A6ADF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 16:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbfICOMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 10:12:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbfICOMW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:12:22 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A8452A09BA
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2019 14:12:22 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id x77so1620847qka.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 07:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B2BfNzrm+hR7i1mNls3IhAz7GlKTxZk9pYPgMdNVli0=;
        b=k+/Ezy8v3/hgMr934hp6+Q+aqHANz7YQeOWr3xTQ1dZo6i7A1eK4e91osbfvn/C6on
         DjnH3taNkRn3QF7dA5OmRn1zD9cIOinSKTMHbz6H3d53N5cn6YgC3ENSNF78TLevyjBC
         jPW/m7p6i71Wfs2uMnklbqR+85w0hfnH5FpSYKX+213oZf6lv57NHgTHjjsAS1AqoAkk
         suHSdzctkyAtjToJtdvqCHP/mw5QHegSxY5yrapweq61sa/2q285+yAf7r1/fn5CtJk9
         2v6z3nfGdsgRmeAAeAMP85Qp6jSMnl2REft99pndnvNqgGy76vr7qXBPGXHzRlRVvIO2
         e4jQ==
X-Gm-Message-State: APjAAAW3NsmhbiNTWl3Xh1P5PzHnTNlTajIQIt1MA8KRTIAOpsGSBguA
        /sjRhjdAsV1pPLk2rwf34KBw7fDkQTOG/mVGMWBE0TjZU0+NEXdsMUplISBjfLpqw3rhtv0R7O3
        28ZwfAkr7ewOBgSlgR+VtM6h+Zg==
X-Received: by 2002:ac8:19c7:: with SMTP id s7mr23669450qtk.392.1567519941737;
        Tue, 03 Sep 2019 07:12:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwZD7QC/GbljRGHZ9kQkhQ8TANJQbERaI507U8NcnTvw54YKl5HRSRH5iHvxe2JtdirsGcbnA==
X-Received: by 2002:ac8:19c7:: with SMTP id s7mr23669437qtk.392.1567519941605;
        Tue, 03 Sep 2019 07:12:21 -0700 (PDT)
Received: from redhat.com (bzq-79-180-62-110.red.bezeqint.net. [79.180.62.110])
        by smtp.gmail.com with ESMTPSA id b123sm8764984qkf.85.2019.09.03.07.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:12:20 -0700 (PDT)
Date:   Tue, 3 Sep 2019 10:12:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 00/13] virtio-fs: shared file system for virtual
 machines
Message-ID: <20190903101001-mutt-send-email-mst@kernel.org>
References: <20190821173742.24574-1-vgoyal@redhat.com>
 <CAJfpegvPTxkaNhXWhiQSprSJqyW1cLXeZEz6x_f0PxCd-yzHQg@mail.gmail.com>
 <20190903041507-mutt-send-email-mst@kernel.org>
 <20190903140752.GA10983@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903140752.GA10983@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 10:07:52AM -0400, Vivek Goyal wrote:
> On Tue, Sep 03, 2019 at 04:31:38AM -0400, Michael S. Tsirkin wrote:
> 
> [..]
> > +	/* TODO lock */
> > give me pause.
> > 
> > Cleanup generally seems broken to me - what pauses the FS
> 
> I am looking into device removal aspect of it now. Thinking of adding
> a reference count to virtiofs device and possibly also a bit flag to
> indicate if device is still alive. That way, we should be able to cleanup
> device more gracefully.

Generally, the way to cleanup things is to first disconnect device from
linux so linux won't send new requests, wait for old ones to finish.




> > 
> > What about the rest of TODOs in that file?
> 
> I will also take a closer look at TODOs now. Better device cleanup path
> might get rid of some of them. Some of them might not be valid anymore.
> 
> > 
> > use of usleep is hacky - can't we do better e.g. with a
> > completion?
> 
> Agreed.
> 
> Thanks
> Vivek
