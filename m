Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7670E158544
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 22:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgBJVwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 16:52:25 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:35364 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727254AbgBJVwZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 16:52:25 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id A60EE7EB6F2;
        Tue, 11 Feb 2020 08:52:23 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j1Gyc-0003E9-Qv; Tue, 11 Feb 2020 08:52:22 +1100
Date:   Tue, 11 Feb 2020 08:52:22 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Muhammad Ahmad <muhammad.ahmad@seagate.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, Tim Walker <tim.t.walker@seagate.com>
Subject: Re: [LSF/MM/BPF TOPIC] Multi-actuator HDDs
Message-ID: <20200210215222.GB10776@dread.disaster.area>
References: <CAPNbX4RxaZLi9F=ShVb85GZo_nMFaMhMuqhK50d5CLaarVDCeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPNbX4RxaZLi9F=ShVb85GZo_nMFaMhMuqhK50d5CLaarVDCeg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=l697ptgUJYAA:10
        a=07d9gI8wAAAA:8 a=7-415B0cAAAA:8 a=q5T8XEN1vGXhI3tkvFYA:9
        a=QEXdDO2ut3YA:10 a=e2CUPOnPG4QKp8I52DXD:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 10, 2020 at 12:01:13PM -0600, Muhammad Ahmad wrote:
> Background:
> As the capacity of HDDs increases so is the need to increase
> performance to efficiently utilize this increase in capacity. The
> current school of thought is to use Multi-Actuators to increase
> spinning disk performance. Seagate has already announced it’s SAS
> Dual-Lun, Dual-Actuator device. [1]
> 
> Discussion Proposal:
> What impacts multi-actuator HDDs has on the linux storage stack?
> 
> A discussion on the pros & cons of accessing the actuators through a
> single combined LUN or multiple individual LUNs? In the single LUN
> scenario, how should the device communicate it’s LBA to actuator
> mapping? In the case of multi-lun, how should we manage commands that
> affect both actuators?

What ground does this cover that wasn't discussed a couple of years
ago at LSFMM?

https://lwn.net/Articles/753652/

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
