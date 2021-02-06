Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89047311EB6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Feb 2021 17:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhBFQoy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Feb 2021 11:44:54 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:48338 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhBFQoy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Feb 2021 11:44:54 -0500
Received: from localhost (kaktus.kanapka.ml [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 2F4A5977746;
        Sat,  6 Feb 2021 17:44:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1612629851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nL54iWMpoSnIbP1+Qd7tBjjYvN2BWAFko+iYvkNs/Co=;
        b=YXIwO6Kc7XcvyxxobFRIPkmPFm7JgKr1G4QvPWGK+MToyiBy2oyf38tXV0ZdGyyMOyRRAQ
        l5V2Hi99szEJqedUDHfZFFQY2IzbByE40SErTY6LoM/z56WKxD+Wa6E54p4h0RG7HhsLYn
        ys6TZNaDuNXoGKLhZCg7O/5Osv/mPVs=
Date:   Sat, 6 Feb 2021 17:44:10 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Hanabishi Recca <irecca.kun@gmail.com>
Cc:     almaz.alexandrovich@paragon-software.com, aaptel@suse.com,
        andy.lavr@gmail.com, anton@tuxera.com, dan.carpenter@oracle.com,
        dsterba@suse.cz, ebiggers@kernel.org, hch@lst.de, joe@perches.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, mark@harmstone.com,
        nborisov@suse.com, pali@kernel.org, rdunlap@infradead.org,
        viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH v20 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
Message-ID: <20210206164410.eebttjuswbcvbxxz@spock.localdomain>
References: <CAOehnrO-qjA4-YbqjyQCc27SyE_T2_bPRfWNg=jb8_tTetRUkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOehnrO-qjA4-YbqjyQCc27SyE_T2_bPRfWNg=jb8_tTetRUkw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 06, 2021 at 01:43:10AM +0500, Hanabishi Recca wrote:
> Can't even build v20 due to compilation errors.

I think this submission is based against linux-next branch where
idmapped mounts are introduced, hence it is not applicable to v5.10 and
v5.11 any more.

-- 
  Oleksandr Natalenko (post-factum)
