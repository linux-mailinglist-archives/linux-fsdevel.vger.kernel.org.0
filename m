Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D80BE19BCF7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 09:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbgDBHoV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 03:44:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgDBHoV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:44:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E81A2063A;
        Thu,  2 Apr 2020 07:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585813461;
        bh=d/t/ujtXfu28zEOz6+VRG1AW8IlGcvBVan5BajLdORM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XLku4gs1IZiQwF4QFe0O7SC6J3tvkwEMlX1UjDNr2ebi6Y+7CV5wi8pVr9/pMPWSH
         /XJFl/7mgZyPwYrBlaQmCMakSc2GiZlXr9OiiLdY6FCFMVVi9XCTh6eUhhj1Kd61CM
         wppysZScXU4zQ0fO6YtA6P3vhBtf6Ku/Qhtfk2yo=
Date:   Thu, 2 Apr 2020 09:44:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, jack@suse.cz, ming.lei@redhat.com,
        nstange@suse.de, mhocko@suse.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/3] block: address blktrace use-after-free
Message-ID: <20200402074419.GD2755501@kroah.com>
References: <20200402000002.7442-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402000002.7442-1-mcgrof@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 01, 2020 at 11:59:59PM +0000, Luis Chamberlain wrote:
> Upstream kernel.org korg#205713 contends that there is a UAF in
> the core debugfs debugfs_remove() function, and has gone through
> pushing for a CVE for this, CVE-2019-19770.

As you point out, that CVE is crazy and pointless, thanks for seeing
this through.

greg k-h
