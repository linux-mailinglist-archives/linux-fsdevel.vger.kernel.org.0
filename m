Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAEB33D9ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 17:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbhCPQ5Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 12:57:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:2203 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236819AbhCPQ5A (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:57:00 -0400
IronPort-SDR: zDsb3nro9os8GuU01lAyz+/VxkpdUv7xJIODJgldO1NSaQZDPVC5Ojiux20QeA7xoqpHLKs3Ii
 yDOn2r9LqGPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="185935096"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="185935096"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 09:56:59 -0700
IronPort-SDR: 0GXpxfw1ccaDKmouGv4eh+4O8g7EB/sXp/7qBYXgcKa8b91JsjRXVhXJA7l/h/xuPtxyer7xw7
 nexYuPBMYkDg==
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="412288261"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 09:56:58 -0700
Date:   Tue, 16 Mar 2021 09:56:58 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: Convert more kmaps to kmap_local_page()
Message-ID: <20210316165658.GS3014244@iweiny-DESK2.sc.intel.com>
References: <20210217024826.3466046-1-ira.weiny@intel.com>
 <20210312194141.GT7604@suse.cz>
 <20210312200500.GG3014244@iweiny-DESK2.sc.intel.com>
 <20210316110724.GJ7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316110724.GJ7604@twin.jikos.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 16, 2021 at 12:07:24PM +0100, David Sterba wrote:
> On Fri, Mar 12, 2021 at 12:05:00PM -0800, Ira Weiny wrote:
> > On Fri, Mar 12, 2021 at 08:41:41PM +0100, David Sterba wrote:
> > > On Tue, Feb 16, 2021 at 06:48:22PM -0800, ira.weiny@intel.com wrote:
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > I am submitting these for 5.13.
> > > > 
> > > > Further work to remove more kmap() calls in favor of the kmap_local_page() this
> > > > series converts those calls which required more than a common pattern which
> > > > were covered in my previous series[1].  This is the second of what I hope to be
> > > > 3 series to fully convert btrfs.  However, the 3rd series is going to be an RFC
> > > > because I need to have more eyes on it before I'm sure about what to do.  For
> > > > now this series should be good to go for 5.13.
> > > > 
> > > > Also this series converts the kmaps in the raid5/6 code which required a fix to
> > > > the kmap'ings which was submitted in [2].
> > > 
> > > Branch added to for-next and will be moved to the devel queue next week.
> > > I've added some comments about the ordering requirement, that's
> > > something not obvious. There's a comment under 1st patch but that's
> > > trivial to fix if needed. Thanks.
> > 
> > I've replied to the first patch.  LMK if you want me to respin it.
> 
> No need to respin, patchset now in misc-next. Thanks.

Sweet!  Thanks!
Ira
