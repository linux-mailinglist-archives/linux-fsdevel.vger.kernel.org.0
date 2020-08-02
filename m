Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D08D235753
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Aug 2020 16:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgHBODC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Aug 2020 10:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgHBODC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Aug 2020 10:03:02 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C47E206DA;
        Sun,  2 Aug 2020 14:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596376981;
        bh=MfDHqqMit+hSKntxVK7N8UOl+i+Xf4TOcn3dkPfEHKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KCCoZzei4YlvGLCmLc3F1NM+BrofKE3kQF8HLCrDkY2lDxQxTw63qkeOGAHmCRD76
         GVUrM5QtLJnVKiPvc7hYGcIT3AdB0B0ALUf7lporEw3MmHSSbo4UmpFVUge1Ch2cLu
         O6MjbhBEky6VmkG385W9qB/PYFp2LofpLD5oHFF0=
Date:   Sun, 2 Aug 2020 10:03:00 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Deven Bowers <deven.desai@linux.microsoft.com>, agk@redhat.com,
        axboe@kernel.dk, snitzer@redhat.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, viro@zeniv.linux.org.uk,
        paul@paul-moore.com, eparis@redhat.com, jannh@google.com,
        dm-devel@redhat.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-audit@redhat.com, tyhicks@linux.microsoft.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        jaskarankhurana@linux.microsoft.com, mdsakib@microsoft.com,
        nramas@linux.microsoft.com, pasha.tatashin@soleen.com
Subject: Re: [RFC PATCH v5 00/11] Integrity Policy Enforcement LSM (IPE)
Message-ID: <20200802140300.GA2975990@sasha-vm>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
 <20200802115545.GA1162@bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200802115545.GA1162@bug>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 02, 2020 at 01:55:45PM +0200, Pavel Machek wrote:
>Hi!
>
>> IPE is a Linux Security Module which allows for a configurable
>> policy to enforce integrity requirements on the whole system. It
>> attempts to solve the issue of Code Integrity: that any code being
>> executed (or files being read), are identical to the version that
>> was built by a trusted source.
>
>How is that different from security/integrity/ima?

Maybe if you would have read the cover letter all the way down to the
5th paragraph which explains how IPE is different from IMA we could
avoided this mail exchange...

-- 
Thanks,
Sasha
