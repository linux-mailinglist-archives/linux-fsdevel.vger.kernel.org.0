Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899E646F465
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 20:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhLIT7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 14:59:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhLIT7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639079727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q3YASXdZwndzziGTgTXQOmP45doZqOgxG+zXhNgdPVU=;
        b=ItYdvMalPoEh7uED4hZChkwun1MKWbH1bPv+WKHqfUMOmcs/reKJbVoibroJUa6XkbWY2n
        3nImvSLQwbTrFC+YkCSC2zWNTZZfyYdRWbKwnhkiJAMkVLo5C0TUAgEedHLstPg3tE51Sr
        1yqdBeHi4nvO4DXWzxT9Xmg5tvPoTLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-dAQQSV2oOIeyx3QJBbGIHQ-1; Thu, 09 Dec 2021 14:55:26 -0500
X-MC-Unique: dAQQSV2oOIeyx3QJBbGIHQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1463D801962;
        Thu,  9 Dec 2021 19:55:25 +0000 (UTC)
Received: from work (unknown [10.40.195.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E53A460BD8;
        Thu,  9 Dec 2021 19:55:23 +0000 (UTC)
Date:   Thu, 9 Dec 2021 20:55:20 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v4 00/13] ext4: new mount API conversion
Message-ID: <20211209195520.z7vv4jtvgpu4omxx@work>
References: <20211027141857.33657-1-lczerner@redhat.com>
 <YbJWN+6nmhpQOZR1@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbJWN+6nmhpQOZR1@mit.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 09, 2021 at 02:17:11PM -0500, Theodore Y. Ts'o wrote:
> Hi Lukas,
> 
> I'm starting to process ext4 patches for the next merge window, and I
> want to pull in the merge mount API conversions as one of the first
> patches into the dev tree.

Hi Ted,

that's great, thanks.

> 
> Should I use the v4 patch set or do you have a newer set of changes
> that you'd like me to use?  There was a minor patch conflict in patch
> #2, but that was pretty simple to fix up.

I don't have anything newer than this. I could rebase it if you'd like
me to, but it sounds like you've already done that pretty easily?

Thanks!
-Lukas

> 
> Thanks!
> 
> 						- Ted
> 

