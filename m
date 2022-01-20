Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB952494DD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 13:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239731AbiATMXM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 07:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiATMXJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:23:09 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA029C061574;
        Thu, 20 Jan 2022 04:23:08 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id n10so12274213edv.2;
        Thu, 20 Jan 2022 04:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XHbVxPVvQxKFGbV2gO92+uYdrWX0wSKGNZ+qAac9RH8=;
        b=mJstJer94oSZPY77xchw20ydWv6462Svb1zFv5diZWooveJU9tqXs2kOSY7V5mHXpj
         emKeJAo8rItxJ13PcQy57kE4GSvx4FXZYbdzUYOx01x8Qzp6ezt+fDgj75/+pjPIvgth
         DfaudXa7VyjI5qdB9LRszLnIOkoYHbTKv/y76XCeoJUxeOi06FS4c6svi2w7k8j1at57
         +8uaAaVjqTcxJxdNz2pEJz90g3SzBtoGCsz4UoLexzMufzAlgL9sGGR1O/m8S2+z4m7h
         m+2tmcQXZvli87AW++6tgNSVpsTQ6UMp1Pe2wERnjXdXy3E1c9Vt3rqvXed+n1VxhaE7
         1x+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XHbVxPVvQxKFGbV2gO92+uYdrWX0wSKGNZ+qAac9RH8=;
        b=AbSHh4dLqdGslEfOBEZlxN1e9bWnUjhJcqoEcIxLnwWRKXXPWNAswbJJu6Nx5Y1qUc
         +b+l4hmwSq7XIoxlrwp1vAhsi44NICC6aa958/zmVgaU3b3jZAuEB8e15jbDu/jaSnHF
         Ap423qpulrTqWbu/r8m8WtZSZJ9kcXaYFHNxxjr43PwSNRKMdwIhNWHE3FmIlaLSUP/f
         GI16tEe9NsRFZWJVeKmZc8slOm7foRddAvFtpNiUqgr11EiXLikPfaVg3rKAiIFBlFKW
         SCVsW3KqnHdqqe6TBj1G+Pq0Mu5CZ80u4rGRjeiMgs3YdGhw5CI2xbLeRSqq+C1E5rZ0
         YC2g==
X-Gm-Message-State: AOAM531SEZ+e1pd64w5sYG+3xZD3KysJFWN0iBRD5vpTXNIIWAgGJg33
        v3CHeDC/WwX3AsOLm7frcA==
X-Google-Smtp-Source: ABdhPJxlCJUR7xftN7+m7al79PN2IVfj6sbEGegLH6cIpmE+tKGZPk+TlxL89oTc2bBU0YwbUXtPzg==
X-Received: by 2002:a17:906:a103:: with SMTP id t3mr27826817ejy.567.1642681387287;
        Thu, 20 Jan 2022 04:23:07 -0800 (PST)
Received: from localhost.localdomain ([46.53.254.155])
        by smtp.gmail.com with ESMTPSA id gz19sm949362ejc.10.2022.01.20.04.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 04:23:06 -0800 (PST)
Date:   Thu, 20 Jan 2022 15:23:04 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, stephen.s.brennan@oracle.com,
        legion@kernel.org, cyphar@cyphar.com
Subject: Re: [PATCH v2] proc: "mount -o lookup=" support
Message-ID: <YelUKIOjLd7A9XQN@localhost.localdomain>
References: <YegysyqL3LvljK66@localhost.localdomain>
 <20220119162423.eqbyefywhtzm22tr@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220119162423.eqbyefywhtzm22tr@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 19, 2022 at 05:24:23PM +0100, Christian Brauner wrote:
> On Wed, Jan 19, 2022 at 06:48:03PM +0300, Alexey Dobriyan wrote:
> > From 61376c85daab50afb343ce50b5a97e562bc1c8d3 Mon Sep 17 00:00:00 2001
> > From: Alexey Dobriyan <adobriyan@gmail.com>
> > Date: Mon, 22 Nov 2021 20:41:06 +0300
> > Subject: [PATCH 1/1] proc: "mount -o lookup=..." support
> > 
> > Docker implements MaskedPaths configuration option
> > 
> > 	https://github.com/estesp/docker/blob/9c15e82f19b0ad3c5fe8617a8ec2dddc6639f40a/oci/defaults.go#L97
> > 
> > to disable certain /proc files. It overmounts them with /dev/null.
> > 
> > Implement proper mount option which selectively disables lookup/readdir
> > in the top level /proc directory so that MaskedPaths doesn't need
> > to be updated as time goes on.
> 
> I might've missed this when this was sent the last time so maybe it was
> clearly explained in an earlier thread: What's the reason this needs to
> live in the kernel?
> 
> The MaskedPaths entry is optional so runtimes aren't required to block
> anything by default and this mostly makes sense for workloads that run
> privileged.
> 
> In addition MaskedPaths is a generic option which allows to hide any
> existing path, not just proc. Even in the very docker-specific defaults
> /sys/firmware is covered.

MaskedPaths is not future proof, new entries might pop up and nobody
will update the MaskedPaths list.

> I do see clear value in the subset= and hidepid= options. They are
> generally useful independent of opinionated container workloads. I don't
> see the same for lookup=.

The value is if you get /proc/cpuinfo you get everything else
but you might not want everything else given that "everything else"
changes over time.

> An alternative I find more sensible is to add a new value for subset=
> that hides anything(?) that only global root should have read/write
> access too.
