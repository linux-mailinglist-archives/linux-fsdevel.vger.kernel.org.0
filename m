Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1913212FFF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 01:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgGBXZz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 19:25:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgGBXZy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 19:25:54 -0400
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D79E206DD;
        Thu,  2 Jul 2020 23:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593732354;
        bh=yjixGqCbQqizOhwkX+oBxN8uiaT9Rl72gyAx9twRioU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TzHl0SuNXddjIn7adaK/gB2eDWn2zSB1svslIh52TIx1Ibfnd7M5MrI77WlnfU9th
         Ne0vXYXjowLbyx3kXGEut3jWpcPkWUj1XawanyllOmEVfF92lVvciim4YS/kisjhUN
         TG4jvND9hRewl2jIGaukLyqap0tMNzYqZRIrABns=
Received: by mail-lj1-f170.google.com with SMTP id e8so142959ljb.0;
        Thu, 02 Jul 2020 16:25:54 -0700 (PDT)
X-Gm-Message-State: AOAM531dxgNe0L8sLFKHBH+Au2Ltl/WhRUFBRppSxB0erOgNv9Cg++Xo
        DLaAopSI0/kjQ2XPzUWfsi+golPAPYV9k9ddqTo=
X-Google-Smtp-Source: ABdhPJxMtBWljIidCscK5kHHrsz8s6hweN4HmlrGmEOtX0q4UYxV0MJIWWoEijgckwbyRHUHgDPdm2LMy43I4CXy/Y4=
X-Received: by 2002:a2e:b175:: with SMTP id a21mr15299515ljm.10.1593732352498;
 Thu, 02 Jul 2020 16:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200615125323.930983-1-hch@lst.de> <20200615125323.930983-2-hch@lst.de>
In-Reply-To: <20200615125323.930983-2-hch@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Thu, 2 Jul 2020 16:25:41 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6chy6uMpow3L1WvBW8xCsUYw4SbLHQQXcANqBVcqoULg@mail.gmail.com>
Message-ID: <CAPhsuW6chy6uMpow3L1WvBW8xCsUYw4SbLHQQXcANqBVcqoULg@mail.gmail.com>
Subject: Re: [PATCH 01/16] init: remove the bstat helper
To:     Christoph Hellwig <hch@lst.de>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Mon, Jun 15, 2020 at 5:53 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The only caller of the bstat function becomes cleaner and simpler when
> open coding the function.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for the set. md parts of the set look good to me.

How should we route this set, as it touches multiple subsystems?

Thanks,
Song
