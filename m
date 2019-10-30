Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2B82EA185
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 17:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfJ3QND (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 12:13:03 -0400
Received: from sonic313-19.consmr.mail.gq1.yahoo.com ([98.137.65.82]:38144
        "EHLO sonic313-19.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726708AbfJ3QNC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1572451981; bh=S/ZDvmEPfSmBt4lxF3DnDhcZlHbW70loQ/lD49ODK0I=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=QMBsrUOAQVdL2w29pwAQaHcD6kp2e/RxIp85wI+KnwsKuWxiqcJd8pATRVM9juGX5aZ/M7BuyUfS5wt7Y0p7vu709QHNPrLp1Z4E9h7z68tMh618U7f6ta2GmPLy7yQCZRox404VNutWwYT8qNk/aAZEK3WRXE0N4mH403ldgsBC/Tx9M9nzP1ZDHq8F/LlUB9fkdt258m47X/57Ox1024R3FIkEwNiQAL0XywHbe9psFuOezVpV3A2f7pZyQb3XI/aSvm+06Oh24z+xWW8r97t43nzeGYvIXZJ9ZW1Rge1RRzUwoHSyq7JHN5f5juBRxYTrFXNP84iAVH7ZY7+o3Q==
X-YMail-OSG: VUDslHoVM1nmGfsRLE0u6zk7Oh8KL_GwpUfSYXRJd11NEDgJqdxoDyFqJsBHhwD
 J5Di1M9rrfPbZjoCYs9uFuiAHMizladxdFQNJmkGHayhDOIZsSFgNjLOmkN7zj_78F4XnsXXKNoH
 aUtTv9GZR9.VRdzMCwVd81Pts54VKsRZ.JD20NZe2pzYH6D7cZFxA3dN.jIIVb7C8JD6j3G5pfOA
 7Wue0S3h8TiGNDOonY_o7fnuA7ga79sdfZBHRlvZKhgCJYlI_WUrZ76lG.8PHeUThs14_K0Mg9fK
 ia5Ow1aNkdZC3urIl0TUBB1e6oWR3s_cY_P9t6aXScNzQyyCMTIrU.qrp2tN68btDzsHIX8C19Sp
 PVZjDBlwW1cN6wgT5VhVXjoslEjOoBjVQGTkpsgtic5BWw2CwYb_paKFYyMh..sN4kfVoGcU5NCX
 Qc5n4ZRt02IsYfuF9uEEV7_Ztjx5Iy_he2eohLQL4FRd0mRBCXMTeBAgOe6iz0AOgVVKkaQwl8Vj
 oN96L9ZBf93ukvBDAcruF9nm.kL2Yfhaz8PpuaqOkfigoMuNNcQ1It94nLXHK8lHSJyJlK0uD675
 AjPw_Vud6NlafOCsZJY4N8iizqSpuE5QXkL8xbGOH.0B0iofYy0yezUFrY0kPdvhHwLMzfkgOsfL
 N0Tou4sPDQ4dSjwBbGbRhsfQpdGx3VcqEG0oWAY3ifxhnG9WVRbb_b_4p0qo1G2zeXPQ5jfxfbZs
 6lVHyj.PZdOxnpLrLMJsyc_FdXTpkBxPadHWs11RBUNpiMuhAXEHFwyQQNxEq9sC0JyIZqejGhOv
 mi8r2eK3P8dEhDy5eX4EeWXinlzC1RG.KX4oqqBt1U85ALfe877Kq1qzxyzOFE9Atv22PxWqNbKM
 iLkBUqEizY8iFKZ8vZaBmdClhopDxeCmZrdSimesgEWCQjTKvrRhuSu0aLGjx42_jXxUTcOEbauc
 6LZblcrM_54LoUOnQE8gCBcALNL2j5VUklssHHu8tbSNAmY2_LbkMQxB4ni2rbCd2z89la..ojMB
 JQCUkH3Dyfudae9CqZNIGztmvD4fwf.wn4p_krKtkiFusiiskMiaLsXNvXujMv6yXR5bk1SR4B6a
 zJfQ4V60duEOpO0XFgCd5Bzq0doRP6R6zJVzpSJZH4BDNb_qq4KqOKPtJvTyQLer9b7YIcYdLtBi
 Nt4Z2xs.KOYNhiQxc0Vrpjo0aWUwDzmjReN0SkgkmOt3FhPovo0oA3KcgN_cRDyV4CjGSvoKTqUA
 JhAVJ_wtD0hLl6umTyuUGUUJHnRkx9a1PK2v_LtCx8uvFRRMmBHs2F__keJdEBI0gc.6dzatprPn
 NYs.w_VYphckCWYGa1zNGZ_d1E2n3DqcQfYweifeee2FaOf8Z2j_nlc3sZihMdvquuwbJCzslQON
 RPKNRTQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Wed, 30 Oct 2019 16:13:01 +0000
Received: by smtp431.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5bc5368066fdcbc1af6a611a83615b01;
          Wed, 30 Oct 2019 16:12:59 +0000 (UTC)
Date:   Thu, 31 Oct 2019 00:12:52 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: bio_alloc never fails
Message-ID: <20191030161244.GB3953@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191030042618.124220-1-gaoxiang25@huawei.com>
 <20191030101311.2175EA4055@d06av23.portsmouth.uk.ibm.com>
 <20191030150437.GB16197@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030150437.GB16197@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailer: WebService/1.1.14593 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ted,

On Wed, Oct 30, 2019 at 11:04:37AM -0400, Theodore Y. Ts'o wrote:
> On Wed, Oct 30, 2019 at 03:43:10PM +0530, Ritesh Harjani wrote:
> > 
> > 
> > On 10/30/19 9:56 AM, Gao Xiang wrote:
> > > Similar to [1] [2], it seems a trivial cleanup since
> > > bio_alloc can handle memory allocation as mentioned in
> > > fs/direct-io.c (also see fs/block_dev.c, fs/buffer.c, ..)
> > > 
> > 
> > AFAIU, the reason is that, bio_alloc with __GFP_DIRECT_RECLAIM
> > flags guarantees bio allocation under some given restrictions,
> > as stated in fs/direct-io.c
> > So here it is ok to not check for NULL value from bio_alloc.
> > 
> > I think we can update above info too in your commit msg.
> 
> Please also add a short comment in the code itself, so it's clear why
> it's OK to skip the error check, and reference the comments for
> bio_alloc_bioset().  This is the fairly subtle bit which makes this
> change not obvious:

OK, I will add short comments in code then, and tidy up later since
it's not urgent (but I'm surprised that so many in-kernel code handles
that, those also makes me misleaded before, but I think mempool back
maybe better since the total efficient path is shorter compared with
error handling path)... and I'd like to know the f2fs side as well :-)

> 
>  *   When @bs is not NULL, if %__GFP_DIRECT_RECLAIM is set then bio_alloc will
>  *   always be able to allocate a bio. This is due to the mempool guarantees.
>  *   To make this work, callers must never allocate more than 1 bio at a time
>  *   from this pool. Callers that need to allocate more than 1 bio must always
>  *   submit the previously allocated bio for IO before attempting to allocate
>  *   a new one. Failure to do so can cause deadlocks under memory pressure.
>  *
>  *   Note that when running under generic_make_request() (i.e. any block
>  *   driver), bios are not submitted until after you return - see the code in
>  *   generic_make_request() that converts recursion into iteration, to prevent
>  *   stack overflows.
>  *
>  *   This would normally mean allocating multiple bios under
>  *   generic_make_request() would be susceptible to deadlocks, but we have
>  *   deadlock avoidance code that resubmits any blocked bios from a rescuer
>  *   thread.
> 
> Otherwise, someone else may not understand why it's safe to not check
> the error return then submit cleanup patch to add the error checking
> back.  :-)

Got it.

Thanks,
Gao Xiang

> 
> 					- Ted
> 					
