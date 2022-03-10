Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC8A4D5197
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 20:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245756AbiCJTPy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 14:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbiCJTPw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:15:52 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900B615AF02;
        Thu, 10 Mar 2022 11:14:49 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B24FF68AFE; Thu, 10 Mar 2022 20:14:45 +0100 (CET)
Date:   Thu, 10 Mar 2022 20:14:45 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     "Luca Porzio (lporzio)" <lporzio@micron.com>
Cc:     "hch@lst.de" <hch@lst.de>, Manjong Lee <mj0123.lee@samsung.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
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
Message-ID: <20220310191445.GA7338@lst.de>
References: <20220306231727.GP3927073@dread.disaster.area> <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com> <20220309133119.6915-1-mj0123.lee@samsung.com> <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com> <20220310142148.GA1069@lst.de> <CO3PR08MB7975AB3E282C7DA35A5B1CF0DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CO3PR08MB7975AB3E282C7DA35A5B1CF0DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 10, 2022 at 06:51:39PM +0000, Luca Porzio (lporzio) wrote:
> You are starting from the wrong assumption: I'm just saying this is not dead code
> but it is used across the (Android) ecosystem.

No one gives cares about random forks, so no I'm not starting from the
wrong assumptіon.  You on the other hand seem to have a lot of learning
to do if you thing some random kernel fork matters the slightest about
what is considered dead code.
