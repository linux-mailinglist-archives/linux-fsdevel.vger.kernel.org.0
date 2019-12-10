Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3B85119000
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 19:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfLJSsn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 13:48:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45230 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfLJSsl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:48:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so21253247wrj.12;
        Tue, 10 Dec 2019 10:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E7cKrmmGLYl3UX+9Kgs62VJkCGwrmZBzege8Q3gWjgc=;
        b=iuCO9jGJUS34zNLPGCFc6XiHt+/BbhH8alpboxYbDwc2J5Qn7V55ucykh1XWtaNqdH
         IHs3v5nm3c9pUO+ftEhtwR6MLU+9G7AHKKpaYK+Ezm3z6PQgywoJGODx0YhLfFHpKNjZ
         V5jP1SmMLWXRBYcgKB3gogxHsyRL7mcfnaB7rXqCwzfXq9Obu5DbRscpZJwiQoIetoHY
         ZcApdgVCODh5Mrw2yCYs2Tt2vM5Cvrvgjht/dtMuMz33dapaYevO67ZrnvcNUnzYf0Ek
         +a88yUs3G5hUerJybaXp2bLa6IlDzhwGGsE6Knkk8XbOzGgzpjfcgqrL/H7xXFN7G9x2
         lqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E7cKrmmGLYl3UX+9Kgs62VJkCGwrmZBzege8Q3gWjgc=;
        b=bIf22hKKbj3Pm3Yucrrj+IprVs5+GeHvOItc9Fo50ecbZf2wEdB34YdazYOdwKXnbI
         kPq4LZKfiQMdnFaX+qcDnwllOiM3YkNcTEEkabOidymIxxW2uKSuzjk2m3BIwH/0ynhH
         r1Sql9fgDo+3TB+mWQOEoARKJDd46vjgPW7DKIPbh7jhnxwbpu5L2FepisxHdbMaGGoi
         pP+/WjwrC/Z/crFkApJZOXjFImEyBJusWrMsu0hyZK8qMX7yR4Xo3VL3EcHX+fKSlBRN
         OsoRilNFJlmUQa/7MwnUJol+qhcZFx3GCLysig2VvUee3MWXgmbSfwR2A7NJOKz1U2TN
         xpCw==
X-Gm-Message-State: APjAAAUfroKbtKo2AinRO6VzIV8FFAgggqaRqFzg8fz0+zHlUQ7rTEz7
        TyFh7GKT1K08VXTWfpy9svbJjfdC
X-Google-Smtp-Source: APXvYqy34IYSTRjB7G1AWrulLNvwmK+vjlcMXdxa+zYaAYuhQIuKUiSxdsE5J57YtOGVnPe1/RHlAQ==
X-Received: by 2002:a5d:640d:: with SMTP id z13mr4929264wru.181.1576003718902;
        Tue, 10 Dec 2019 10:48:38 -0800 (PST)
Received: from gentoo-tp.home ([2a02:908:1086:7e00:51f1:c7d0:b0cb:4fa2])
        by smtp.gmail.com with ESMTPSA id 60sm4386114wrn.86.2019.12.10.10.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 10:48:37 -0800 (PST)
Date:   Tue, 10 Dec 2019 19:50:02 +0100
From:   Jeremi Piotrowski <jeremi.piotrowski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Phillip Lougher <phillip@squashfs.org.uk>
Subject: Re: Regression in squashfs mount option handling in v5.4
Message-ID: <20191210185002.GA20850@gentoo-tp.home>
References: <20191130181548.GA28459@gentoo-tp.home>
 <6af16095-eab0-9e99-6782-374705d545e4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6af16095-eab0-9e99-6782-374705d545e4@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 30, 2019 at 10:56:47AM -0800, Randy Dunlap wrote:
> [adding Cc-s]
> 
> On 11/30/19 10:15 AM, Jeremi Piotrowski wrote:
> > Hi,
> > 
> > I'm working on an embedded project which uses 'rauc' as an updater. rauc mounts
> > a squashfs image using
> > 
> >   mount -t squashfs -o ro,loop,sizelimit=xxx squashfs.img /mnt
> > 
> > On my system mount is busybox, and busybox does not know the sizelimit
> > parameter, so it simply passes it on to the mount syscall. The syscall
> > arguments end up being:
> > 
> >   mount("/dev/loop0", "dir", "squashfs", MS_RDONLY|MS_SILENT, "sizelimit=xxx")
> > 
> > Until kernel 5.4 this worked, since 5.4 this returns EINVAL and dmesg contains
> > the line "squashfs: Unknown parameter 'sizelimit'". I believe this has to do
> > with the conversion of squashfs to the new mount api. 
> > 
> > This is an unfortunate regression, and it does not seem like this can be simply
> > reverted. What is the suggested course of action?
> > 
> > Please cc me on replies, I'm not subscribed to the list.
> > 
> > Thanks,
> > Jeremi
> > 
> 
> 
> -- 
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

Ping. This is preventing me from updating the kernel on my systems.
