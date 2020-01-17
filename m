Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51CB9140FDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 18:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgAQR27 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 12:28:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40000 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgAQR27 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 12:28:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id q8so12242752pfh.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2020 09:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kt1gWL0UEPxIvV5tCvE0dGgLcEGjJdM/cw//i+qWJdM=;
        b=deSQglNnmwR/kqm84NVsTOGXD0lFJotmG7fGH2vDKrWy7u3LZFBWF7v6HIvUVWImil
         BUDZ5WMUId6IRkUxiHJvuBRVN7TaQS5AACWCJS9P1xrmeph5MC5IhNArYWh8SuYlPPCE
         n88Iu1nP3ZzG8g/vNR/NZZE5wNz3lHzWr1kHEalC9nXUkgVPwhpJlJCU1YWKKzp3sCfK
         KOKaz5FrldsCqXzeBkfGpxsIWCerpKYo7s1k76Cf5SWhC7MMdnjKAtbRNfioNEg1D/ho
         iJ+Oncl47ZmxFQVf9r2GT4Akaofy7M+7RRlI/EowN8TkadsVyXc8UtisObmorUbc4Ei0
         3pPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kt1gWL0UEPxIvV5tCvE0dGgLcEGjJdM/cw//i+qWJdM=;
        b=GJ/re3ietsP0K6hlVMPwSGQH+utONz7q0P+Dt0K8LcjXgCgAshlNItN2OI86KgT7jn
         KDHecpLhlnQtCFja5bS4MdsPbWZW0fLMEjWvf8EYMVh+xAxE6QSbn4PwVY1jzxqdhPJU
         DNXr4p1JPSe7v1ndkvASn8b6gt/6FCQDye56d7RxhoDD5fACBZXmpzlL3P+DoLUrffA8
         NmNhxVGaNAl3ZaKCIXpbx+rKVjroXYbjk6Nv3IPlSE98wS34xB816cW3kYUXRwL6j4EV
         SMyAK2PwEbfDtlXIAXGF1Ft9z752hr+d4GGi1wps0VpSw7ZKj2l4/d7GD89nP4v6VdUf
         6TUQ==
X-Gm-Message-State: APjAAAX2I3I7eruJK8mqR/6O+tfSGscomkuKXuEW4JF+d9Uz0AHgbx8p
        nF1TPszy8Y9Emlll391uQ8qqyg==
X-Google-Smtp-Source: APXvYqyHAEfI9WxMB64blxmkFDsz+jrDdpVUUrNbdF7M9CXogcVg8bj1vL9A4hJucMzYlmR3YACxlw==
X-Received: by 2002:a63:1110:: with SMTP id g16mr45352017pgl.84.1579282138239;
        Fri, 17 Jan 2020 09:28:58 -0800 (PST)
Received: from vader ([2607:fb90:837f:92ce:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id h3sm29907745pfo.132.2020.01.17.09.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 09:28:57 -0800 (PST)
Date:   Fri, 17 Jan 2020 09:28:55 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Message-ID: <20200117172855.GA295250@vader>
References: <364531.1579265357@warthog.procyon.org.uk>
 <d2730b78cf0eac685c3719909df34d8d1b0bc347.camel@hammerspace.com>
 <20200117154657.GK8904@ZenIV.linux.org.uk>
 <20200117163616.GA282555@vader>
 <20200117165904.GN8904@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117165904.GN8904@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 17, 2020 at 04:59:04PM +0000, Al Viro wrote:
> On Fri, Jan 17, 2020 at 08:36:16AM -0800, Omar Sandoval wrote:
> 
> > The semantics I implemented in my series were basically "linkat with
> > AT_REPLACE replaces the target iff rename would replace the target".
> > Therefore, symlinks are replaced, not followed, and mountpoints get
> > EXDEV. In my opinion that's both sane and unsurprising.
> 
> Umm...  EXDEV in rename() comes when _parents_ are on different mounts.
> rename() over a mountpoint is EBUSY if it has mounts in caller's
> namespace, but it succeeds (and detaches all mounts on the victim
> in any namespaces) otherwise.
> 
> When are you returning EXDEV?

EXDEV was a thinko, the patch does what rename does:


+	if (is_local_mountpoint(new_dentry)) {
+		error = -EBUSY;
+		goto out;
+	}

...

+	if (target) {
+		dont_mount(new_dentry);
+		detach_mounts(new_dentry);
+	}

Anyways, my point is that the rename semantics cover 90% of AT_REPLACE.
Before I resend the patches, I'll write up the documentation and we can
see what other corner cases I missed.

> Incidentally, mounts _are_ traversed on
> the link source, so what should that variant do when /tmp/foo is
> a mountpoint and you feed it "/tmp/foo" both for source and target?

EBUSY and noop both seem reasonable in this case, so we pick one and
document it.
