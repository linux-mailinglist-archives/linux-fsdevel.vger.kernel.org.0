Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053BB415531
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 03:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbhIWBtF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 21:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbhIWBtF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 21:49:05 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6186EC061574;
        Wed, 22 Sep 2021 18:47:34 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8627D6CCF; Wed, 22 Sep 2021 21:47:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8627D6CCF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1632361653;
        bh=KoRcspGU/sFE5nwHK/TAQOmXc1o3qWFUtiuoew3ScrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nAmqYv9aV6lK1QO0o+Kg3sMbNI01MZdVdp/gk5f6zskNaegPLaVqL562c2Sim8LOV
         XCtteuRwm4/IxB78JRi/gr63Y6qaaYXPa73UEqpHrqqyB7khvsggfIVywJWTMfDCjd
         EqG4yKLo38P09quMRgMC2wqUHCaw1RRrO6HxuMs4=
Date:   Wed, 22 Sep 2021 21:47:33 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20210923014733.GF22937@fieldses.org>
References: <20210916182212.81608-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916182212.81608-1-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I haven't tried to figure out why, but I notice after these patches that
pynfs tests RENEW3, LKU10, CLOSE9, and CLOSE8 are failing with
unexpected share denied errors.

--b.
