Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B622816540E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 02:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgBTBPt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 20:15:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38018 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgBTBPt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 20:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=dZtuknyoRtx3zb5xuPMfjefBRKNpd+FEygxzTdEPEZg=; b=Hp2eGaSvfeHFfDoYUhD0EfYRjb
        9TlBqHho2xGQiGFS0Ifi9l5JDoLZFS5y2bdmKHv3WlNzRHDNKYn1zbKPFqnHGKcYmZ43GtWLBuKga
        1sdYUOSV+gFDedLOwnkNqYZjyS4abn6ceekXlY/xBrIiMzNFBza36vdM/r+k2a/vNpNNj6N2nB8BW
        MEk5a/E8CXZklfl8BS8Ws2Ej/6rXl/SMAwL8NCCL+AQHGlHLmpqwzitqtlU6wBQdp0UMuHjVSGXPB
        NULyiWrI/Qa2c15xFjZNocPbFN0n9R2ozzSxsg/4RHe8vx147AdBtrYi5smLhY2MT9pJJx89QIoeg
        OJpnd4GA==;
Received: from [2603:3004:32:9a00::4074]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4aRN-0007MU-BO; Thu, 20 Feb 2020 01:15:45 +0000
Subject: Re: [PATCH v13 2/2] zonefs: Add documentation
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Dave Chinner <david@fromorbit.com>
References: <20200207031606.641231-1-damien.lemoal@wdc.com>
 <20200207031606.641231-3-damien.lemoal@wdc.com>
 <a6f0eaf4-933f-8c15-6f0c-18400204791f@infradead.org>
 <BYAPR04MB58167DDA2AE7B1BC1500D9C4E7130@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6f370a74-877a-a709-e7ff-ba7dc1963ece@infradead.org>
Date:   Wed, 19 Feb 2020 17:15:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB58167DDA2AE7B1BC1500D9C4E7130@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/19/20 4:59 PM, Damien Le Moal wrote:
> On 2020/02/20 9:55, Randy Dunlap wrote:
>> Hi Damien,
>>
>> Typo etc. corrections below:
> 
> Thanks. Will correct these. Since this is now in the kernel, you can send a
> patch too :)

oops, sorry, I didn't notice that.
I'll be glad to send a patch.

> 
>>
>> On 2/6/20 7:16 PM, Damien Le Moal wrote:
>>> Add the new file Documentation/filesystems/zonefs.txt to document
>>> zonefs principles and user-space tool usage.
>>>
>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>>> Reviewed-by: Dave Chinner <dchinner@redhat.com>
>>> ---
>>>  Documentation/filesystems/zonefs.txt | 404 +++++++++++++++++++++++++++
>>>  MAINTAINERS                          |   1 +
>>>  2 files changed, 405 insertions(+)
>>>  create mode 100644 Documentation/filesystems/zonefs.txt


-- 
~Randy
