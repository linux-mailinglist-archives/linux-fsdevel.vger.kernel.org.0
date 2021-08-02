Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5143DE283
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 00:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhHBWeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 18:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbhHBWeE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 18:34:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484D8C061764;
        Mon,  2 Aug 2021 15:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=QsPq3v5uWYS+XG2UeEtq8B5ym8GWlpM3Kjo4AJTrmMk=; b=iOpMuIHgAdPpGRTl2fs6VgfDq7
        kJ23Gi0oPYFtGhKfALDPGiTOiovPHjiSdhBmCSiyC9J8w/pZUTqCJ+Lw1FvpiUepBrW+6SHnoVr2C
        IMsIIRd3kdaHOIITc2QGXZhCXVLOyOBUQFcAiLEfZDXmHrWnEcoqsE//TJg9PPpARU9botWW+vsXr
        4DWo+HmtotUlFyRQmzpbHk2X12Eo9uuhIrIqRdaLADH9XNE7PxjbFTNKnvyNsf0bE68/Z7tZpqV8X
        M6OL1VPY+RUzsxzFWrNiI6aWZTo5HFdDn9OVpjYGq3QALpdUC2/pzS3rbv9fkY/X7WOd9xTbVddw1
        hngZ/CGw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mAgVL-005EqR-TT; Mon, 02 Aug 2021 22:33:52 +0000
Subject: Re: [PATCH] iomap: Fix some typos and bad grammar
To:     Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20210801120058.839839-1-agruenba@redhat.com>
 <20210802221339.GH3601466@magnolia>
 <CAHc6FU66B9VJFu6tPvDMJZYPbgGoytf3zR1yxRfg92Zw1=vaCQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e29cdfb5-d203-adb0-b421-53f2339cb91e@infradead.org>
Date:   Mon, 2 Aug 2021 15:33:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHc6FU66B9VJFu6tPvDMJZYPbgGoytf3zR1yxRfg92Zw1=vaCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/2/21 3:16 PM, Andreas Gruenbacher wrote:
> On Tue, Aug 3, 2021 at 12:13 AM Darrick J. Wong <djwong@kernel.org> wrote:
>> On Sun, Aug 01, 2021 at 02:00:58PM +0200, Andreas Gruenbacher wrote:
>>> Fix some typos and bad grammar in buffered-io.c to make the comments
>>> easier to read.
>>>
>>> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
>>
>> Looks good to me, though I'm less enthused about the parts of the diff
>> that combine words into contractions.

fwiw, I don't much care for them either.

> Feel free to adjust as you see fit.
> 
>> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> Thanks,
> Andreas
> 


-- 
~Randy

