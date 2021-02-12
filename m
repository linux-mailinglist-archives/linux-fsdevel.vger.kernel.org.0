Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD12B31A6DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 22:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhBLV2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 16:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhBLV22 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:28:28 -0500
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB150C061574;
        Fri, 12 Feb 2021 13:27:47 -0800 (PST)
Received: from localhost (kaktus.kanapka.ml [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 6903098C705;
        Fri, 12 Feb 2021 22:27:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1613165258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2mjYffK+zMGEpM0j9pXBNGRQO7ZCRVVsHBrv+6cjjGI=;
        b=X8fFhVhw4zK3PJT/b3dj7oUqtbVRYCp6q+Ph7yoyECn0ZHTFFewgKc2WdVpi/dd3Dco74a
        sEeOEWTdcfTCgGSLeDlawmiOHfY0HUFQ37gHIKp2HFsZ/mf4opfzWxv1ktxGdMwg80C6rm
        LxWfqVEV6XGuvpCizwal3yZdt5eOc8k=
Date:   Fri, 12 Feb 2021 22:27:37 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, kasep pisan <babam.yes@gmail.com>,
        Hanabishi Recca <irecca.kun@gmail.com>
Subject: Re: [PATCH v21 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
Message-ID: <20210212212737.d4fwocea3rbxbfle@spock.localdomain>
References: <20210212162416.2756937-1-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210212162416.2756937-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi.

On Fri, Feb 12, 2021 at 07:24:06PM +0300, Konstantin Komarov wrote:
> This patch adds NTFS Read-Write driver to fs/ntfs3.
> …
> v21:
> - fixes for clang CFI checks
> - fixed sb->s_maxbytes for 32bit clusters
> - user.DOSATTRIB is no more intercepted by ntfs3
> - corrected xattr limits;  is used
> - corrected CONFIG_NTFS3_64BIT_CLUSTER usage
> - info about current build is added into module info and printing
> on insmod (by Andy Lavr's request)
> note: v21 is applicable for 'linux-next' not older than 2021.01.28

For those who use this on v5.10/v5.11, there's an extra patch available
that applies on top of this submission: [1].

Hanabishi, babam (both in Cc), here [2] you've reported some issues with
accessing some files and with hidden attributes. You may reply to this
email of mine with detailed description of your issues, and maybe
developers will answer you.

Thanks.

[1] https://gitlab.com/post-factum/pf-kernel/-/commit/e487427ef07c735fdc711a56d1ceac6629c34dcf.patch
[2] https://aur.archlinux.org/packages/ntfs3-dkms/

-- 
  Oleksandr Natalenko (post-factum)
