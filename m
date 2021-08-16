Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A163ED43E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 14:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbhHPMqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 08:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhHPMqW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:46:22 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C47FC0613C1;
        Mon, 16 Aug 2021 05:45:51 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id h11so26928891ljo.12;
        Mon, 16 Aug 2021 05:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ZT4eONejq0MjVzRHhlnf+5cG+diYvwCMZBalMlG6Nw=;
        b=aVhswyK9fWMq6U11Fa1V8OSkRGrnAfzIy//WZiOVa+I6m87IS9aRUsX0+4M/1AEwY1
         gh6gck1itzP3nc0b+sSNlq4gwArUlhptw9HKYkyAd24nJhQfG0JcMZHY0k1MOPbC3y4a
         /IzUwz14O8Oi1Z6fKWsssLsxPZalqCswcA0MJrvhOI1CwIx+m34CSQUvp5mOdX5yyia0
         vRTr+9uhxvSUFdzETAovz2W9p1iPB7OkhX/7Kpb8uQ4nqktklWwbi7pBNCdSnlaKIodv
         fZhsSgyNSpp6z2BFRwZn7d0pfdRAydzJZoj4pOeSCx9BwB9UaJKBO+w8r+gWi6Mf4FHV
         180A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ZT4eONejq0MjVzRHhlnf+5cG+diYvwCMZBalMlG6Nw=;
        b=k6KlN60jOLvog6WeCeIwO7PIeEAXEosDwEcc8HXEXmQICItGfI1BC0N1LsUKnO+3w0
         JNREJ1N9DQqB2RketORjMUBfQhDGyJjbWeXR5Elx1KeEAZf1WEoaaGGf7zgb9DZxTIRv
         qANit1t7P7dkis6fuw8YiCcjsEMwMMHPLWywMEuwUlLg1++aNJNkLvawP0HOMBdUsNbD
         ojT+aWTPHUu/ftMv9RENv7MaPCh/KXkFqBpu3t5543119kUKfvkTdzg4K8T0A2pG8hvC
         BYdSoQW7AsvIA2F8HOwS8Brqjy6j+LyjqpG8hkNaUh0zJvLq4LP00OsEDfzyVsWPQkAQ
         90jg==
X-Gm-Message-State: AOAM532rnJy6rMRovJY+o825IOh6UN2hEF/o1HaUuXpkzsxwxHgVXCDn
        Xp3Smp5XHdM6bCygGSeDLjc=
X-Google-Smtp-Source: ABdhPJxf49QYFanm5+rXyj4LkdrME/Ar2+RAAnbwL5QG9988Vu+hXnb4FWHfVkyS+kyl+m4nUo0ycg==
X-Received: by 2002:a2e:89c5:: with SMTP id c5mr12313583ljk.329.1629117949450;
        Mon, 16 Aug 2021 05:45:49 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id w12sm294381lfq.277.2021.08.16.05.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 05:45:49 -0700 (PDT)
Date:   Mon, 16 Aug 2021 15:45:47 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 2/4] fs/ntfs3: Remove unnecesarry mount option noatime
Message-ID: <20210816124547.avgxl7rf7uhluafd@kari-VirtualBox>
References: <20210816024703.107251-1-kari.argillander@gmail.com>
 <20210816024703.107251-3-kari.argillander@gmail.com>
 <20210816121818.GB16815@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816121818.GB16815@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 16, 2021 at 02:18:18PM +0200, Christoph Hellwig wrote:
> On Mon, Aug 16, 2021 at 05:47:01AM +0300, Kari Argillander wrote:
> > Remove unnecesarry mount option noatime because this will be handled
> > by VFS. Our function ntfs_parse_param will never get opt like
> > this.
> 
> Looks good, but I'd move this to the front of your series.

I agree. I will do this.

