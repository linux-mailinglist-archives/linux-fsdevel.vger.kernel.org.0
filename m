Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805F652A6F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 17:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346491AbiEQPgh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 11:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350364AbiEQPfy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 11:35:54 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F67506D9;
        Tue, 17 May 2022 08:35:35 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24HFYsQ9026768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 11:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652801701; bh=vMDcL1Sj3ecZF/PHO33RMl8MajLs+NitzTG2owdTZQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=QWWYv+c38E0Js5EJ5O4LH7stm0/N/0G+zlZGaxwbAbrJcoBFiFX+I8aMjlxDXtdcH
         HpQFgO3vNojUXJc8f+tn6qApIq1oq89uILHK6aqbgkyPptilbkipvXh8b+UDCORwcJ
         NTcZRZaecteMkr4C9FEtPqcOV8/1Z/mJK25oUPZYeYBBp6sBYjgpZEf9xgcokZgDBW
         jWBIxHO+AVv5V5gBQlM1SENquz5Y+sM7mT5fnlB7PvD9DdOkb+WioPJCoeulEVoACn
         ngUKDte0snQOFU95pMNMLZkRMx8s9GtBCC6kwv6i26eYPhX3g2IKwzeEwICOgNvimy
         LqJbC9V4JwF5A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8636C15C3EC0; Tue, 17 May 2022 11:34:54 -0400 (EDT)
Date:   Tue, 17 May 2022 11:34:54 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        pankydev8@gmail.com, gost.dev@samsung.com,
        damien.lemoal@opensource.wdc.com, jiangbo.365@bytedance.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Message-ID: <YoPAnj9ufkt5nh1G@mit.edu>
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
 <20220517081048.GA13947@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517081048.GA13947@lst.de>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 17, 2022 at 10:10:48AM +0200, Christoph Hellwig wrote:
> I'm a little surprised about all this activity.
> 
> I though the conclusion at LSF/MM was that for Linux itself there
> is very little benefit in supporting this scheme.  It will massively
> fragment the supported based of devices and applications, while only
> having the benefit of supporting some Samsung legacy devices.

FWIW,

That wasn't my impression from that LSF/MM session, but once the
videos become available, folks can decide for themselves.

       	      		       	   	  - Ted
