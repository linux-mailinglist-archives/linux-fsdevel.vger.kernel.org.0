Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C22C4D49A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 15:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243477AbiCJO0V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 09:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243594AbiCJOZc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:25:32 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC1FB82D7;
        Thu, 10 Mar 2022 06:22:04 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2E2F968AFE; Thu, 10 Mar 2022 15:21:48 +0100 (CET)
Date:   Thu, 10 Mar 2022 15:21:48 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     "Luca Porzio (lporzio)" <lporzio@micron.com>
Cc:     Manjong Lee <mj0123.lee@samsung.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "song@kernel.org" <song@kernel.org>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "nanich.lee@samsung.com" <nanich.lee@samsung.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>
Subject: Re: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Message-ID: <20220310142148.GA1069@lst.de>
References: <20220306231727.GP3927073@dread.disaster.area> <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com> <20220309133119.6915-1-mj0123.lee@samsung.com> <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 10, 2022 at 11:34:40AM +0000, Luca Porzio (lporzio) wrote:
> I work for Micron UFS team. I confirm and support Manjong message above.
> There are UFS customers using custom write_hint in Android and due to the 
> "upstream first" policy from Google, if you remove write_hints in block device,
> The Android ecosystem will suffer this lack.
> 
> Can we revert back this decision? Or think of an alternative solution which 
> may work?

Hell no.  Given that these custmomers never gave a singe fuck to actually
support whatever crap they came up with upstream we're not going to leave
dead code to encurage them to keep doing this.
