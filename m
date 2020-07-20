Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A84225EAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 14:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgGTMhQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 08:37:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:59628 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbgGTMhP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:37:15 -0400
IronPort-SDR: QrMZgFR6ujJQ9Z3ou8dIP9/BHj3iFPpSFBE4my6AWJWoZYM5zrmYo1kHn/9r6xXIhXQi0mcEv7
 GjBdzmzLYtpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="234750664"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="234750664"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 05:37:15 -0700
IronPort-SDR: 7deXD1XW+A1Hva+QiCJdaK4EIpnjzCtylsXLbkZMEWcV3EA4SSFqyWHsLulKcoOBu1VF1DCfC/
 jsIW9xbLx4ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="487228228"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jul 2020 05:37:15 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.72.186])
        by linux.intel.com (Postfix) with ESMTP id A1092580299;
        Mon, 20 Jul 2020 05:37:11 -0700 (PDT)
Message-ID: <2827a5dbd94bc5c2c1706a6074d9a9a32a590feb.camel@gmail.com>
Subject: Re: [PATCH 04/14] bdi: initialize ->ra_pages in bdi_init
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Christoph Hellwig <hch@lst.de>,
        Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        Song Liu <song@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        linux-mtd@lists.infradead.org, linux-mm@kvack.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        drbd-dev@lists.linbit.com
Date:   Mon, 20 Jul 2020 15:37:10 +0300
In-Reply-To: <20200720120734.GA29061@lst.de>
References: <20200720075148.172156-1-hch@lst.de>
         <20200720075148.172156-5-hch@lst.de>
         <CAFLxGvxNHGEOrj6nKTtDeiU+Rx4xv_6asjSQYcFWXhk5m=1cBA@mail.gmail.com>
         <20200720120734.GA29061@lst.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-07-20 at 14:07 +0200, Christoph Hellwig wrote:
> What about jffs2 and blk2mtd raw block devices?

If my memory serves me correctly JFFS2 did not mind readahead.

