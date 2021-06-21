Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20FF3AE7A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 12:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhFUKw1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 06:52:27 -0400
Received: from mx4.veeam.com ([104.41.138.86]:35378 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhFUKw0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 06:52:26 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jun 2021 06:52:26 EDT
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id A05A2339DD;
        Mon, 21 Jun 2021 13:42:52 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1624272172; bh=GljFfCWjRBIR4hzJFuKOmKnKEd6VWDoU5d8lRKHelyU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=Ro9i7SJ4j7/MTK265L8ZUfPMGUw5qbelzB/Cdx4Bf9QB30R+7f4/nRc599kq8rdpJ
         2kGJdwd+5h7dfRa2MXnD7+/6591+gTQDctHHmi05K3QP01blqdjMn6dsT+E+RQcmig
         DH6H/rN/jI3k0j8a1hK0dPwlKVI2RP3H6gz4CeRM=
Received: from veeam.com (172.24.14.5) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Mon, 21 Jun 2021
 12:42:50 +0200
Date:   Mon, 21 Jun 2021 13:41:31 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Pavel Tide <Pavel.TIde@veeam.com>
Subject: Re: [PATCH v9 0/4] block device interposer
Message-ID: <20210621104131.GA8841@veeam.com>
References: <1619023545-23431-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1619023545-23431-1-git-send-email-sergei.shtepa@veeam.com>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: spbmbx02.amust.local (172.17.17.172) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B596D7267
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mike,

This is a follow up message.
Did you have a chance to take a look at the latest patchset from April?
Thanks!

I can update the patch to be compatible with kernel 5.14.
I would like to know if you still have interest in blk_interposer.

-- 
Sergei Shtepa
Veeam Software developer.
