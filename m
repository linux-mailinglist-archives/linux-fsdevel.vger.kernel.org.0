Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF1001CC54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 17:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfENP5o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 11:57:44 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35342 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfENP5o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 11:57:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id a39so18794815qtk.2;
        Tue, 14 May 2019 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=09KkEvxVufpT7/jHfQWIW8S/OLgTGQRQAFAad5Q891g=;
        b=evnybUqQSO3rMlm+kFqEQEIAfI3v4IqgwamNZvPOEyI9wfLiDbsuEeXduuT3enU+/D
         iPaHuAred/MDyZUVZgr18lqhCz/SufyYY000qM22MZZpH/JuvqIujY2M3yfpedzXDH1V
         CUXWUf5xY8etjU/g1epN4mmTh3W4L8h/GZxe9kMxCB+tU9kx3BuiIFMLWZKDu/wPTnz8
         9a8FfvgxAFTFjGiycvXhLWDMbsBwaoxZL30QEkdUA3OmNl0+6lT6Rw7OMCoCN1pOTlgF
         ssx2GCz1BmDg4+bJTTtQQmXXFK59NTym2BDk+1SRu1kUafbPyfP5tvlJWv1n1Itxr6C/
         JP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=09KkEvxVufpT7/jHfQWIW8S/OLgTGQRQAFAad5Q891g=;
        b=S2byZtGVafs/kmyA/gfG2qs2Gb7KxcpxbQDROWdY+zcthmmD+o7paCXK1eund8cDV9
         K9nUE619axorpLC7rZpYqTFXE/HGVMFnxvjnlORKjgra+pQSPUbzwWFAkyEyp2J4PtIZ
         M4pvfrTXiiPql0qxmJNtA8UjRSRIIZr/W82Bn2D92yjsaKVtYFPdmAN8EvIaXV6b04pu
         7L/oLp6PkIhDqWfw2TqtqnFIA43cearEXadL67LHgRuBtc4NfdXSmgX8ELiZXxj4Rpn5
         4iXyP5LHImWE4CXrXIhOphrbOnMGAeiKNXDRSRNnnHDQWxPmYevUt2U0i4Ox08Is2Y6i
         PYFQ==
X-Gm-Message-State: APjAAAWQWSTvqYivORFI3EPkUudlOGLhiwJC+jys8l6RSrIt1dv1eT6N
        M9bjxSn38zE/XwUO8310JsE=
X-Google-Smtp-Source: APXvYqxQkrvvSVGKdFqsv/NpzHHnJeXW91ioD42OqHauIMmMOKgcTJj6yswK2beRxWwGYRcDRcnhnw==
X-Received: by 2002:a0c:b92f:: with SMTP id u47mr19802185qvf.94.1557849462769;
        Tue, 14 May 2019 08:57:42 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p37sm14130553qtj.90.2019.05.14.08.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 08:57:42 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 14 May 2019 11:57:40 -0400
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Rob Landley <rob@landley.net>,
        Arvind Sankar <niveditas98@gmail.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        initramfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
Message-ID: <20190514155739.GA70223@rani.riverdale.lan>
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
 <20190512194322.GA71658@rani.riverdale.lan>
 <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
 <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
 <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
 <49965ffd-dd57-ffe5-4a2f-73cdfb387848@landley.net>
 <de91ef53-6bb3-b937-8773-5f6b34e1acb7@huawei.com>
 <20190514152704.GB37109@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190514152704.GB37109@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 14, 2019 at 11:27:04AM -0400, Arvind Sankar wrote:
> It's also much easier to change/customize it for the end
> system's requirements rather than setting the process in stone by
> putting it inside the kernel.

As an example, if you allow unverified external initramfs, it seems to
me that it can try to play games that wouldn't be prevented by the
in-kernel code: setup /dev in a weird way to try to trick /init, or more
easily, replace /init by /bin/sh so you get a shell prompt while only
the initramfs is loaded. It's easy to imagine that a system would want
to lock itself down to prevent abuses like this.
So you might already want an embedded initramfs that can be trusted and
that can't be overwritten by an external one even outside the
security.ima stuff.
