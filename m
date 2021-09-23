Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1002A415F16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 15:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbhIWNCb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 09:02:31 -0400
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:55519 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241167AbhIWNCY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:02:24 -0400
Received: from MTA-15-3.privateemail.com (MTA-15-1.privateemail.com [198.54.118.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id D567B8064F;
        Thu, 23 Sep 2021 09:00:51 -0400 (EDT)
Received: from mta-15.privateemail.com (localhost [127.0.0.1])
        by mta-15.privateemail.com (Postfix) with ESMTP id 8254A18000AD;
        Thu, 23 Sep 2021 09:00:50 -0400 (EDT)
Received: from [192.168.0.46] (unknown [10.20.151.205])
        by mta-15.privateemail.com (Postfix) with ESMTPA id 5791818000A3;
        Thu, 23 Sep 2021 09:00:49 -0400 (EDT)
Date:   Thu, 23 Sep 2021 09:00:43 -0400
From:   Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH v2] aio: convert active_reqs into a hashtable
To:     Benjamin LaHaise <bcrl@kvack.org>
Cc:     linux-kernel@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Message-Id: <7H1WZQ.H8D3XK8HUSNQ3@effective-light.com>
In-Reply-To: <20210919145645.GE16005@kvack.org>
References: <20210919144146.19531-1-someguy@effective-light.com>
        <20210919145645.GE16005@kvack.org>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Sun, Sep 19 2021 at 10:56:45 AM -0400, Benjamin LaHaise 
<bcrl@kvack.org> wrote:
> You're doing this wrong.  If you want faster cancellations, stash an 
> index
> into iocb->aio_key to index into an array with all requests rather 
> than
> using a hash table.

Would that not mean that, we would have to keep track of the indices of 
the
array that are not being held by an `aio_kiocb`?


