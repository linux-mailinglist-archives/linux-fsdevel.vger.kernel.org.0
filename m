Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D061F780C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 14:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgFLMm3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 08:42:29 -0400
Received: from outbound-smtp17.blacknight.com ([46.22.139.234]:43939 "EHLO
        outbound-smtp17.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbgFLMm2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 08:42:28 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id 369D31C3C9B
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 13:42:27 +0100 (IST)
Received: (qmail 3855 invoked from network); 12 Jun 2020 12:42:27 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.5])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Jun 2020 12:42:27 -0000
Date:   Fri, 12 Jun 2020 13:42:25 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fsnotify: Rearrange fast path to minimise overhead when
 there is no watcher
Message-ID: <20200612124225.GC3183@techsingularity.net>
References: <20200608140557.GG3127@techsingularity.net>
 <CAOQ4uxhb1p5_rO9VjNb6assCczwQRx3xdAOXZ9S=mOA1g-0JVg@mail.gmail.com>
 <20200608160614.GH3127@techsingularity.net>
 <CAOQ4uxh=Z92ppBQbRJyQqC61k944_7qG1mYqZgGC2tU7YAH7Kw@mail.gmail.com>
 <20200608180130.GJ3127@techsingularity.net>
 <CAOQ4uxgcUHuqiXFPO5mX=rvDwP-DOoTZrXvpVNphwEMFYHtyCw@mail.gmail.com>
 <CAOQ4uxhbE46S65-icLhaJqT+jKqz-ZdX=Ypm9hAt9Paeb+huhQ@mail.gmail.com>
 <20200610125920.GM3127@techsingularity.net>
 <CAOQ4uxhcFO4=e-s7uStbEkZU==8kraD1=owZGu4SWx_iR72gTA@mail.gmail.com>
 <CAOQ4uxjTFCJa1y2Uq8NztXxkPRmvDvtUUt22QMwPkdd=eJdkyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjTFCJa1y2Uq8NztXxkPRmvDvtUUt22QMwPkdd=eJdkyw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 12, 2020 at 12:38:15PM +0300, Amir Goldstein wrote:
> > No worries. I wasn't planning on submitted the altered patch.
> > I just wanted to let you test the final result.
> > I will apply your change before my series and make sure to keep
> > optimizations while my changes are applied on top of that.
> >
> 
> FYI, just posted your patch with a minor style change at the bottom
> of my prep patch series.
> 

Thanks!

-- 
Mel Gorman
SUSE Labs
