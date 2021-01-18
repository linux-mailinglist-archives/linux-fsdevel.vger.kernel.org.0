Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EEA2FAB9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 21:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388955AbhARUfj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 15:35:39 -0500
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:33468 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394270AbhARUfc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 15:35:32 -0500
Received: from dread.disaster.area (pa49-181-54-82.pa.nsw.optusnet.com.au [49.181.54.82])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id DA4CC1106E07;
        Tue, 19 Jan 2021 07:34:47 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l1bEc-001M5K-2a; Tue, 19 Jan 2021 07:34:46 +1100
Date:   Tue, 19 Jan 2021 07:34:46 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com
Subject: Re: [PATCH 08/11] iomap: rename the flags variable in __iomap_dio_rw
Message-ID: <20210118203446.GD78941@dread.disaster.area>
References: <20210118193516.2915706-1-hch@lst.de>
 <20210118193516.2915706-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118193516.2915706-9-hch@lst.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=NAd5MxazP4FGoF8nXO8esw==:117 a=NAd5MxazP4FGoF8nXO8esw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=KRY6nOaMA5SMbWMDRiUA:9 a=CjuIK1q_8ugA:10 a=DBeEp3iAzaEA:10
        a=UxLD5KG5Eu0A:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 08:35:13PM +0100, Christoph Hellwig wrote:
> Rename flags to iomap_flags to make the usage a little more clear.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Makes sense.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
