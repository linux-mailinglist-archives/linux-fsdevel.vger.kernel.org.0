Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93097223E18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 16:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgGQOep (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 10:34:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37417 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgGQOeo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:34:44 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1jwRRi-0004Ba-EP
        for linux-fsdevel@vger.kernel.org; Fri, 17 Jul 2020 14:34:42 +0000
Received: by mail-il1-f198.google.com with SMTP id t19so5511142ili.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 07:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nq0NDHwUFXxzJZTp4F6HC8c4DV6/X2/lcdBOQjQySNA=;
        b=o9QTxfjYWvGwv9QJX+czxg8r3Hv6J9jx5+a/tAdW2hqBqoDQ5FV3+29h7pUVgnhp4p
         LNhspzv3jrj1A3PkSvqWTglh1jKdfYkGMiep0st4rbfkmQTrnIh15MGQO6m/ZsmySvsa
         mdVa8eJ7PvRIn5qHo5Q/36BR0IBg5lZjOSCglUXcBXgX7w6jf27aSNBDAsFWzas8hdYI
         UujzGhbZjZ6nvSaDuBRrQlgafia/5fh95P8sbFBK8iLoqh7U+8yHRrK6c73Ryb7Fibne
         emNYZtaO27bavaDV2lMAhFkPbcrRf08ck8drRMfW6/knp6RQzake+/1yO4Ylj+QP40ld
         VX2g==
X-Gm-Message-State: AOAM531+faAGGKDkGRre9XIT0IVITC6UtCEzTLe9BNnFrZcVkHe0jOZf
        Ln6rHCpcHt2m2KWZmUV1TDo9xM2mfgIlZsEEQL29WL1r8m4PFZr0Ydj8aSPxYnQamEO/vjGwAlL
        Ab3eFK1lhq2Kju9ny4w3Ki2m65rzMV3jv6Q76JXrC7XE=
X-Received: by 2002:a5d:8c8f:: with SMTP id g15mr1415506ion.206.1594996481459;
        Fri, 17 Jul 2020 07:34:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrYQJzp7H1HXSHovLc11uYDCjo/zLwwDmKJfTvF4t+CMcItTE8EABNuqUk3kn0jPw0VlfnUg==
X-Received: by 2002:a5d:8c8f:: with SMTP id g15mr1415484ion.206.1594996481133;
        Fri, 17 Jul 2020 07:34:41 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:90fa:132a:bf3e:99a1])
        by smtp.gmail.com with ESMTPSA id m6sm4520602ilb.39.2020.07.17.07.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 07:34:40 -0700 (PDT)
Date:   Fri, 17 Jul 2020 09:34:39 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Alberto Milone <alberto.milone@canonical.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-fsdevel@vger.kernel.org, mingo@kernel.org
Subject: Re: [PATCH 1/1] radix-tree: do not export radix_tree_preloads as GPL
Message-ID: <20200717143439.GL3644@ubuntu-x1>
References: <20200717101848.1869465-1-alberto.milone@canonical.com>
 <20200717104300.h7k7ho25hmslvtgy@linutronix.de>
 <ba5d59f6-2e40-d13a-ecc8-d8430a1b6a14@canonical.com>
 <20200717132147.nizfehgvzsdi2tfv@linutronix.de>
 <ea8b14c7-cda9-d0c1-b36a-8f2deea3ca18@canonical.com>
 <20200717142848.GK3644@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717142848.GK3644@ubuntu-x1>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 09:28:48AM -0500, Seth Forshee wrote:
> On Fri, Jul 17, 2020 at 03:45:10PM +0200, Alberto Milone wrote:
> > On 17/07/2020 15:21, Sebastian Andrzej Siewior wrote:
> > > On 2020-07-17 14:33:31 [+0200], Alberto Milone wrote:
> > >> I checked and CONFIG_DEBUG_LOCK_ALLOC is not enabled in our kernels.
> > > The access to that variable is optimized away if not for debug. I made
> > > this:
> > > | #include <linux/module.h>
> > > | #include <linux/idr.h>
> > > | 
> > > | static int le_init(void)
> > > | {
> > > |         idr_preload_end();
> > > |         return 0;
> > > | }
> > > | module_init(le_init);
> > > | 
> > > | static void le_exit(void)
> > > | {
> > > | }
> > > | module_exit(le_exit);
> > > |    
> > > | MODULE_DESCRIPTION("driver");
> > > | MODULE_LICENSE("prop");
> > >
> > > and it produced a .ko. Here the "idr_preload_end()" was reduced to
> > > "preempt_enable()" as intended. No access to
> > > "&radix_tree_preloads.lock".
> > >
> > > Sebastian
> > * Subscribing Seth
> 
> Looks like the driver is not using idr_preload_end() though, it is
> calling radix_tree_preload_end() which uses radix_tree_preloads whether
> or not CONFIG_DEBUG_LOCK_ALLOC is enabled.

Sorry, I didn't dig deep enough. I see that radix_tree_preload_end() is
expected to opimize away that access too. I wonder if different
toolchains could be ending up with different reults.

Seth
