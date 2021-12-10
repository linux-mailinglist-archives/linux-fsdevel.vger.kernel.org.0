Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53A5470A71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 20:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343656AbhLJThX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 14:37:23 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:35140 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343643AbhLJThU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:37:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 82EB7CE2D3F;
        Fri, 10 Dec 2021 19:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90306C341C7;
        Fri, 10 Dec 2021 19:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639164821;
        bh=ERS0opz4r15Gqwn0qYudxh8L5RAZZ1xOPTq5JltvMak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dtNDiupPNxhu0vKGphoTur4wqkW+ckHD4eJ+fffgH7Oq/3HtWBHGNeKcL2VcQZ7iZ
         IFNMZqp3di9tPi98IC41a+6kY/Omu+UsMPB/GvJcMKGpxqXgOL4Exms3uWGYhFntd7
         sJfZ9R0R7JW/ZSJHIntN4GG5Bp6rncMHRCPHc+o5dmG/1nNMM3Hu2Fcf76LvNw9WDx
         iJrLE2bX74EVWF65HNIi0+kB0ti2N6/TMAdV9FhdoPZQsMoM2toQKhBPa2Sfg/FsGz
         LPYWHpoWawEueza4Y8TUvlKRrqg0ZnlGCowDhnSVA8FfYPPo77TC3vA5CIKS1jZnhM
         A9/a2I/8mctrQ==
Date:   Fri, 10 Dec 2021 11:33:40 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/36] ceph+fscrypt: context, filename, symlink and size
 handling support
Message-ID: <YbOrlC8KooqvaAuz@sol.localdomain>
References: <20211209153647.58953-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209153647.58953-1-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 09, 2021 at 10:36:11AM -0500, Jeff Layton wrote:
> I've not posted this in a while, so I figured it was a good time to do
> so. This patchset is a pile of the mostly settled parts of the fscrypt
> integration series. With this, pretty much everything but the actual
> content encryption in files now works.

There have been a lot of versions of this sent out without contents encryption
support, which is the most important part.  Is there a path forward for that?

- Eric
