Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5656471793C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 09:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbjEaH5c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 03:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbjEaH5S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 03:57:18 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09070198E;
        Wed, 31 May 2023 00:56:06 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5ae86a.dynamic.kabel-deutschland.de [95.90.232.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id B64BB61E4052B;
        Wed, 31 May 2023 09:54:23 +0200 (CEST)
Message-ID: <e510055e-da93-e9c1-d60b-f6b357d6611b@molgen.mpg.de>
Date:   Wed, 31 May 2023 09:54:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 15/20] md: raid1: check if adding pages to resync bio
 fails
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Song Liu <song@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>, gouhao@uniontech.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <cover.1685461490.git.johannes.thumshirn@wdc.com>
 <c60c6f46b70c96b528b6c4746918ea87c2a01473.1685461490.git.johannes.thumshirn@wdc.com>
 <20230531042502.GM32705@lst.de>
 <CAPhsuW62vBccjUkCUmYr+OZSLgGozFzX4YyzP8OV+dvsLujCGg@mail.gmail.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAPhsuW62vBccjUkCUmYr+OZSLgGozFzX4YyzP8OV+dvsLujCGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Johannes,


Thank you for your patches.

Am 31.05.23 um 06:58 schrieb Song Liu:
> On Tue, May 30, 2023 at 9:25 PM Christoph Hellwig <hch@lst.de> wrote:
>>
>> To me these look like __bio_add_page candidates, but I guess Song
>> preferred it this way?  It'll add a bit pointless boilerplate code,
>> but I'm ok with that.
> 
> We had some discussion on this in v2, and decided to keep these
> assert-like WARN_ON().

it’d be great if you added a summary/note of the discussion to the 
commit message.


Kind regards,

Paul
