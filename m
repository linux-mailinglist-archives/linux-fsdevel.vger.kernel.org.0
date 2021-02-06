Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5728311F26
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Feb 2021 18:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhBFRjs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Feb 2021 12:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBFRjr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Feb 2021 12:39:47 -0500
X-Greylist: delayed 2473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 06 Feb 2021 09:39:07 PST
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DB1C06174A;
        Sat,  6 Feb 2021 09:39:07 -0800 (PST)
Received: from localhost (kaktus.kanapka.ml [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 151329778B0;
        Sat,  6 Feb 2021 18:39:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1612633144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gq6JJeg3Xo7Bi0Tayld7WrowagUnBEY6WRZxDsEhUiE=;
        b=avxO4YRrhO/d/aFQKGCqgkgTm30xqTFRPr5H7ej6mD1ip34fW7Seagep/cPto6vVhjvmzI
        gN7md5PHsELuCBwopAJD7LdLIrG1oR4Sc84onJ8SYV1RO81FI4xeikAX7FZvtyAtXCTGnA
        q4cFewhftronjCP3QJm7l8WagFnC5j8=
Date:   Sat, 6 Feb 2021 18:39:03 +0100
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
Message-ID: <20210206173903.i75ir5x7ksexyptu@spock.localdomain>
References: <CAOehnrO-qjA4-YbqjyQCc27SyE_T2_bPRfWNg=jb8_tTetRUkw@mail.gmail.com>
 <20210206165744.q6sjcujezxg3ho2z@spock.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210206165744.q6sjcujezxg3ho2z@spock.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 06, 2021 at 05:57:45PM +0100, Oleksandr Natalenko wrote:
> On Sat, Feb 06, 2021 at 01:43:10AM +0500, Hanabishi Recca wrote:
> > Can't even build v20 due to compilation errors.
> 
> Try this please: http://ix.io/2OwR

Slightly reworked version: http://ix.io/2Oxa

-- 
  Oleksandr Natalenko (post-factum)
