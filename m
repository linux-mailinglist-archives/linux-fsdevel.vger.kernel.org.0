Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0AF32382E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 08:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhBXH6a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 02:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbhBXH6G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:58:06 -0500
X-Greylist: delayed 258 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 Feb 2021 23:57:26 PST
Received: from mail.as201155.net (mail.as201155.net [IPv6:2a05:a1c0:f001::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD381C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 23:57:26 -0800 (PST)
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:54948 helo=webmail.newmedia-net.de)
        by mail.as201155.net with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1lEoy5-0008Mc-1V; Wed, 24 Feb 2021 08:52:21 +0100
X-CTCH-RefID: str=0001.0A782F19.603605B5.0077,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID; bh=+h4wN+gEmCE4egeucsEqyx1BKFItgtfkkCG2z9NxOAs=;
        b=R4VFlbzLjYccPkcZXkyIKEf9f88UQyZ0tY3zJRIyKEAmsfegFsJyAUp3Wl7WFQhICwRYz+Hr847ldUn7kZz3UaQp9Y3fMRT5oAoLethXyetf8mu+HHIt5iBUwr8w9vndy96d9dz0FhMLkyF/XPmTp4V1c9cp6BaF1uTmAO0RWM4=;
Message-ID: <f2b72217-3da5-7e71-e108-56e657e8a85d@dd-wrt.com>
Date:   Wed, 24 Feb 2021 08:52:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v21 10/10] fs/ntfs3: Add MAINTAINERS
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        pali@kernel.org, dsterba@suse.cz, aaptel@suse.com,
        willy@infradead.org, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com
References: <20210212162416.2756937-1-almaz.alexandrovich@paragon-software.com>
 <20210212162416.2756937-11-almaz.alexandrovich@paragon-software.com>
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
In-Reply-To: <20210212162416.2756937-11-almaz.alexandrovich@paragon-software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [2003:c9:3f4c:a900:81f8:af90:a12c:2d22]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1lEoy4-000OVA-EG; Wed, 24 Feb 2021 08:52:20 +0100
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Am 12.02.2021 um 17:24 schrieb Konstantin Komarov:
> This adds MAINTAINERS
>
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

just for your info with latest ntfs3 driver

kern.err kernel: ntfs3: sda1: ntfs_evict_inode r=fe1 failed, -22.


