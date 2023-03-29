Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814F16CF71F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 01:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjC2Xai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 19:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjC2Xah (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:30:37 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F3E1FFF
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132636; x=1711668636;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gcC/1POcjLEFAIcEMXu/G07oqNzLEW5v95BGotn97v8=;
  b=KRyXXUdFlkyqjaSqo7dov2ecp9eqL3p2H0iB3QYEHt1OWNnTgjdLjgpc
   0izLapqWOIWi/1/t4z1+nMgEXdyHN13nm1UbyAJ8ptJWMDQfI61QojFFw
   WybKUpNdwP6peHKAU5/muTTrsm3hprGlkVQOeh9CmaYeK76gN1f6HAq00
   mkm2hgVSOWoKbUvbRswKauLXkiZ+3hVNcLoUEZLqVJFV+YfNuxl4zTZYF
   Gd2Jt+dSccpfcxnVS++H0OstS6Y1L6sBRuWSyNMVhM4oEQFlDB0GJQgDu
   tX/FK8YiwS4yy5QDPyO0IllEA0AcHPFvS0W2aOBS0MKh0eJWMeogBhyZ0
   w==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226648028"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:30:34 +0800
IronPort-SDR: iaK7s0wZv3JAToWIWmtrblipmMQOAzG9jnwiPJ+XPV/2zCFFgMAHW5CIihRIP4TgqlExn8Bo1x
 Dw6zRZhN2Aj4MBt839v6ITxcQYbIr1PTOXxXfs31c3EhOwOAYX89k4baN2YkpCcG8Jj0F73AS3
 ZmIZb9RpeIyY1yU7NgOgC+UdUGEUqdDe0EOrpgZj2PABpQz0zqiS5ENDo6UB5f39MDnalHL9DP
 SIaHbQ2rPsI13odXErCe27a9B2nOHfo+JCZDf5c+Oac+p1pMzW9D7E1PJxUon9jX5YxVyxYm2J
 VXc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:46:42 -0700
IronPort-SDR: eW/O7nTyezqBQV7t40KPJP/zlqwpVaUuNC7nZEwaw+RHuf614OAVgMPlBoLsKkqQ5veFerwIfl
 HT6ian3gM5qnivdR8q1DMC7bFMlDz/KwAvueHmBQBlMlv/eVOhFakpB6g7LpXpxqxuGHEgXtAr
 PBEF1ES15FEJJvAwJPbTIzjZV+341JZWDfHV57dq7uoqyUfCaaMgKZMVk0js8mwtzZi8kFk45V
 5FrOwZJ7gr+aI2UesGMiu05qJk4w3piRa+KH2fe2rMnbP7th/Gj8DTjXtQk9g/ZSKBerSAcNvz
 n+4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:30:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2px4fj6z1RtVy
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:30:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132632; x=1682724633; bh=gcC/1POcjLEFAIcEMXu/G07oqNzLEW5v95B
        Gotn97v8=; b=PoG50HzSd9Sqa3seuCovhxqh1ZZj1r8rRM7hqMVC1Pzrs/Mo8xn
        s2FvS3V47vL7XwXAfrvFNgGFN1/MXXWe6cQDyUrs+uLkmyMiu1ovYiEFYowQ7TUT
        wfa4tqt19MVPZuqNtDeGKyc7ne+kGMaZwH8cyCYGntsekO4jGotJoRJD6DLiPGwu
        os4aw6OxIJRE6l+V9kLg+RXaflepH+nb+xTPHi+u7Tkml5O8gOxvKnBM17WRQIbv
        mQdVhvyFEVMsEnqG8QNoHfx3vNLFW7ITiVKbEkKnZMEik4uxC9t7Y7t1oltQZe94
        VoGnC9Q9Nzo4gA9ee6x9ZTsaAiXIUcMppRw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LcfBMtmjWbIV for <linux-fsdevel@vger.kernel.org>;
        Wed, 29 Mar 2023 16:30:32 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2pt0C0hz1RtVm;
        Wed, 29 Mar 2023 16:30:29 -0700 (PDT)
Message-ID: <4e4aa0e7-f222-f269-1b5c-1abb3a7179e7@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:30:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 03/19] dm: dm-zoned: use __bio_add_page for adding single
 metadata page
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1680108414.git.johannes.thumshirn@wdc.com>
 <4a2c46dc0e217a9fb6b9f32d460498a5feb8b67b.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <4a2c46dc0e217a9fb6b9f32d460498a5feb8b67b.1680108414.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/30/23 02:05, Johannes Thumshirn wrote:
> dm-zoned uses bio_add_page() for adding a single page to a freshly created
> metadata bio.
> 
> Use __bio_add_page() instead as adding a single page to a new bio is
> always guaranteed to succeed.
> 
> This brings us a step closer to marking bio_add_page() __must_check
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

