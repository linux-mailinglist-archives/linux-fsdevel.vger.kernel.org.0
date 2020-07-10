Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A45B21B264
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 11:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgGJJhk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 05:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgGJJhj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:37:39 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D8FC08C5CE;
        Fri, 10 Jul 2020 02:37:39 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id r19so5673070ljn.12;
        Fri, 10 Jul 2020 02:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/dUk3o7WmxeQ+s81BEUdkgQmyRruCHvFWBCU6KJpmRE=;
        b=AygFhQyh7GIEUNYRy1O7/Ymb+5SKSUz6bVA1Js7C/JQDnOZd/ufSlMgXrJPJsM4sLb
         pCqLzyJqMCDE1R8lFz3p+dHtw1TwR0JFhBkbUflOVI7vsbKVPvudTqKpR/6afvz3EtvW
         0MWUOC8hXf0JRHoGzU5mYK2AmwuSGqVQVuBv2/+HBXfW8x02g5akvkg//mlumE/qgAu+
         ZZeLWpyNDYyW/qkQ8RTg4aSFsADbk9U0ZlOc+t3rxVU2/8znP1QgK3tHdV6TlqYO7e9f
         iifAuyzBIADOld7NFMvbG5aqVy7VL/tohaX2hGKtvEX+QxuJmhhR85T23Q7MZEnnzgD+
         Mn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/dUk3o7WmxeQ+s81BEUdkgQmyRruCHvFWBCU6KJpmRE=;
        b=kFaBf8+5laDdCNz3xO9lUl6VEEPUXMei1SmpyIZMdA1jAE1YMEziC4ASEB8hck/9XU
         4h0dnWt4pV6xjZRS6Zp6SEKat97S6JcTkFO7savkMkg4giM7HcpPWLAEDTrZxPQ0N2VG
         gIpBmByqih99lcpfQLZcp3nHQirjDpke6kzg1yK34ggCOKEikW0yv4uVwld6HAZavcc7
         0Vmgrm+mO+MX4NAV3s09PkU0hZ3QJ5UUpvrFYCYPWbfZKo8R8fm7uutxU4LZjKr6RbLA
         +m4MkglKo2x9FLPHHtCpddxRtyWbPY0acj1JY+EHLyEHcKijPM1wqJxy2jTpXWS7om4t
         5ifw==
X-Gm-Message-State: AOAM531OQtyt3tECLC9staGmdElyzdOVwpe+TbUQ4Z2AmGsGVWKBLNLz
        UkxYYaScOV4ZebzIVzaS0Cw=
X-Google-Smtp-Source: ABdhPJybV+JbVVnw8nmfjWW8qMld2U8+yROVI1SkLaVx3cdnNUtMWCE+sD3lXdtVt6xOaBiIQ0E6cA==
X-Received: by 2002:a2e:1502:: with SMTP id s2mr25083480ljd.236.1594373857641;
        Fri, 10 Jul 2020 02:37:37 -0700 (PDT)
Received: from grain.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id 24sm1965112lfy.59.2020.07.10.02.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:37:25 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id E6A561A007B; Fri, 10 Jul 2020 12:37:21 +0300 (MSK)
Date:   Fri, 10 Jul 2020 12:37:21 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kcmp: add separate Kconfig symbol for kcmp syscall
Message-ID: <20200710093721.GE1999@grain>
References: <20200710075632.14661-1-linux@rasmusvillemoes.dk>
 <20200710083025.GD1999@grain>
 <14b4a1f0-3caf-75e4-600a-3de877a92950@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14b4a1f0-3caf-75e4-600a-3de877a92950@rasmusvillemoes.dk>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 10, 2020 at 11:05:11AM +0200, Rasmus Villemoes wrote:
> >> I deliberately drop the ifdef in the eventpoll.h header rather than
> >> replace with KCMP_SYSCALL; it's harmless to declare a function that
> >> isn't defined anywhere.
> > 
> > Could you please point why setting #fidef KCMP_SYSCALL in eventpoll.h
> > is not suitable?
> 
> It's just from a general "avoid ifdef clutter if possible" POV. The
> conditional declaration of the function doesn't really serve any
> purpose.

OK, thanks for explanation.
