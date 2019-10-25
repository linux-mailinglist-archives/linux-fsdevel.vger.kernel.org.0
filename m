Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0F6CE41D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 04:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390955AbfJYCs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 22:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbfJYCs6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 22:48:58 -0400
Received: from localhost (unknown [38.98.37.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C31121929;
        Fri, 25 Oct 2019 02:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571971737;
        bh=nLvmHTl9M+EjHvOkgVDNxdCekjne3edjHpCDMdQ+qIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h2PYV4sArSzNuN8BzLdUsbts1x+CX7QREnpZ+96d2SyA//xSW4bRwlAxwkdpOCKqL
         BPd3aq7n2WonoV18ng/fMH9bhaLTArifhGlDo5auD7ohhsNWHel+F/1tJrnxMruYdd
         147pI4UgtStqwsesdtxbBOVhaL7wxRQC2/o3e8ig=
Date:   Thu, 24 Oct 2019 22:45:08 -0400
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] staging: exfat: Clean up namespace pollution, part 1
Message-ID: <20191025024508.GA344075@kroah.com>
References: <20191023052752.693689-1-Valdis.Kletnieks@vt.edu>
 <20191023052752.693689-2-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023052752.693689-2-Valdis.Kletnieks@vt.edu>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 01:27:44AM -0400, Valdis Kletnieks wrote:
> Make as much as possible static.  We're over-exuberant here for the benefit
> of a following patch, as the compiler will flag now-unused static code

This adds a bunch of compiler warnings, which isn't ok.  Please fix this
up to be correct and not add build warnings, as it just hides real
issues.

I'll drop this series and wait for a new version with this fixed up.

thanks,

greg k-h
