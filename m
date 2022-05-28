Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBD6536949
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 02:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbiE1AG2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 20:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiE1AGY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 20:06:24 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B58932DC2;
        Fri, 27 May 2022 17:06:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 7E642538FEE;
        Sat, 28 May 2022 10:06:21 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nujyG-00HDH2-8o; Sat, 28 May 2022 10:06:20 +1000
Date:   Sat, 28 May 2022 10:06:20 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Almaz Alexandrovich <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs/ntfs3: Refactoring of indx_find function
Message-ID: <20220528000620.GH3923443@dread.disaster.area>
References: <75a1215a-eda2-d0dc-b962-0334356eef7c@paragon-software.com>
 <0f9648cc-66af-077c-88e6-8650fd78f44c@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f9648cc-66af-077c-88e6-8650fd78f44c@paragon-software.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=6291677e
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=GFCt93a2AAAA:8 a=7-415B0cAAAA:8
        a=0CrOsYfU3WwKmZ_veyUA:9 a=CjuIK1q_8ugA:10 a=CZlV3fpBRwkA:10
        a=0UNspqPZPZo5crgNHNjb:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 05:21:03PM +0300, Almaz Alexandrovich wrote:
> This commit makes function a bit more readable
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

This looks wrong. The email is from

 "From: Almaz Alexandrovich <almaz.alexandrovich@paragon-software.com>"

So it looks like the S-o-B has the wrong email address in it. All
the patches have this same problem.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
