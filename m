Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99209720AD3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 23:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbjFBVHG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 17:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236393AbjFBVHF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 17:07:05 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E431FE45
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 14:07:04 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-119-27.bstnma.fios.verizon.net [173.48.119.27])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 352L6drj012273
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 17:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1685740002; bh=+fhvnsMpXlpfmJs76T6Sk6ClEO2oC4AjjwblRuM2ubw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=hXyU7+uCe2xPabyzcF+mpcUQu4SzMXoqFnOoZV65St34QqPU0XI8cfgFVkxQYPcNf
         6tqrzhTOQCx1vxTP3rzlG8ZAYWaErnxoDSwpysdnfoSbudpiTMMEgwrcK4leAZ+AhV
         bULOxm1BdvnonaM29A/oEhW7W4PlJy2dFQbM5OOKl3qvE/SgRXhYFqTC8uz/DGqQU9
         WqUe5owGg+q4ZQtRqnGW4I91foz77Y2zLi8uOzm6U4g6jKaidQqsPuFpq/uzQUjQOp
         619QpEo0fbM3LrlZQwzxCqT6r5LAvBpMH4lPaYi9+3lbmlcJ2Oc2Q+6EPHrIInBIRB
         Lp+j+WVX8en9w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5ED1A15C02EE; Fri,  2 Jun 2023 17:06:39 -0400 (EDT)
Date:   Fri, 2 Jun 2023 17:06:39 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     syzbot <syzbot+list5ea887c46d22b2acf805@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yangerkun <yangerkun@huawei.com>
Subject: Re: [syzbot] Monthly ext4 report (May 2023)
Message-ID: <20230602210639.GA1154817@mit.edu>
References: <000000000000834af205fce87c00@google.com>
 <df5e7e7d-875c-8e5d-1423-82ec58299b1b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df5e7e7d-875c-8e5d-1423-82ec58299b1b@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 01, 2023 at 10:08:53AM +0800, Baokun Li wrote:
> 
> Patch "[PATCH v2] ext4: fix race condition between buffer write and
> page_mkwrite​"
> in maillist fixes issues <1>,<4>,<5>.
> 
> Patch set "[PATCH v4 00/12] ext4: fix WARNING in
> ext4_da_update_reserve_space"
> in maillist fixes issues <3>.

Thanks for noting that the fixes are applicable to the above reports.
I've adjusted the commit descrptions to include the necessary
Reported-by: lines, and they are in the ext4 dev tree.

Cheers,

						- Ted
