Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F7F4D7D5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Mar 2022 09:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbiCNIKU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Mar 2022 04:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237593AbiCNIKS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:10:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D89140C1;
        Mon, 14 Mar 2022 01:09:08 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 47B1C68B05; Mon, 14 Mar 2022 09:00:03 +0100 (CET)
Date:   Mon, 14 Mar 2022 09:00:01 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Avi Shchislowski <Avi.Shchislowski@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        "Luca Porzio (lporzio)" <lporzio@micron.com>,
        Manjong Lee <mj0123.lee@samsung.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
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
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Message-ID: <20220314080001.GB4921@lst.de>
References: <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com> <e98948ae-1709-32ef-e1e4-063be38609b1@kernel.dk> <CO3PR08MB797562AAE72BC201EB951C6CDC0B9@CO3PR08MB7975.namprd08.prod.outlook.com> <d477c7bf-f3a7-ccca-5472-f9cbb05b83c1@kernel.dk> <c27a5ec3-f683-d2a7-d5e7-fd54d2baa278@acm.org> <PH0PR08MB7889642784B2E1FC1799A828DB0B9@PH0PR08MB7889.namprd08.prod.outlook.com> <ef77ef36-df95-8658-ff54-7d8046f5d0e7@kernel.dk> <bf221ef4-f4d0-4431-02f3-ef3bea0e8cb2@acm.org> <800fa121-5da2-e4c0-d756-991f007f0ad4@kernel.dk> <SN6PR04MB3872231050F8585FFC6824C59A0F9@SN6PR04MB3872.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB3872231050F8585FFC6824C59A0F9@SN6PR04MB3872.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Which part of "the Linux kernel does not keep unused code around" is still
not clear to you after explaining it three times in this thread?
