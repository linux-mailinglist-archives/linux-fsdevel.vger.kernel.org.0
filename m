Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799356CF7DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 01:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjC2X6n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 19:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjC2X6m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:58:42 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC9559DA
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680134321; x=1711670321;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l3K4Kt/FO4iBIKq8VgAcGfFNIvXYccX/xQem9blms08=;
  b=rEKltx4jSPEwIxlf3wYtRdes4rk5Fr7t+GcYVP6+gxVo9XQAEp1SM8Ap
   x7+EPHChGrnBhuE3BJm9/OKbBPbZzuOJFbHsuBxr5d+Yu+Iwe3XnR4R4z
   +B4iPy8YFKkjsOA35AAao6Lc7I9HIsn0Ccbb+GYAwF9dPC6z7ZNHJVftP
   i4vfdwjq9azjMKxdW+d3MhIae4827UsvN3Oygka/hI9WWx43wgjW2Sd/1
   ZVs6TeS0WsXxNFd+cqsWfq/kmTZu8fsVO6/nhCKizHY57wXtU35zGO1d9
   pjLfo0p5inKFm302Elpz8a34X0MO+HsoqXkdzfYVPjnDctFpFaJph3nsW
   w==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="338905086"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:58:40 +0800
IronPort-SDR: vQOHSEMmiODGl+Xc4eu1K+TWxtoLBr1852Lut+mgeavonEX1fURlQs0lvTiv1R3VfdYgGoa9SG
 chzzBuhdgf2YEhvMIstzRAte7QrguJQU0fwQdEvYAZdT5iPXAm+gXyap9XRaHFHgD2iNd+ZnqF
 pKKeEuu3F+KX3iUUl8WUddbdVuMftQYQ0uAeyRorngsGjM7rS7O5e3H88/Gbn2DriGIfrI4qPC
 3UnchSSwQefo1kelOCFKnDehJ/eN8DRmUjkeZcYD+C0BmO0b/ri16s4jrrasWFflRa/jhMyQwk
 tU4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:14:49 -0700
IronPort-SDR: Ubcj4P9tuE96wkhGv6XHG8DSlYyQBq5S+apFjWsgpS2ch+9vj2ucTRf7C68An5H6LImwgdMWcz
 PjWaPW63lbu+FW0R251P3jdJzBOxSBJCmnFhdwythudIK4BOQTDaYj+IGTJ/e8bnFVwQVmfWWl
 lsmKlI9TWFpze3AlCy/mL41klZCTURlEFyiDu7gNVNe4hN6v5O/yy7Z7UVtU/Ey+xo7B0cObh2
 qpyOLlmEUPo1Q8RpHtiRBoA7vuVPeJeq0trlKbULJ+OCn59N/4u74fIo3xF/9RKrGt2PJFZIfg
 M4I=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:58:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn3RN10zDz1RtW4
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:58:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680134319; x=1682726320; bh=l3K4Kt/FO4iBIKq8VgAcGfFNIvXYccX/xQe
        m9blms08=; b=Z/xEynILGjmaBwHeY3zVoiULWBo3e30fvx6iPr3Zx6Wj7JD/AeL
        AlMf5sdtT16U+2fy8eU1VAKFPpBudi6kurLPAGIzKE9drC6EeQeqgjCFT9E4ojVy
        TQQB5cTsm8u17203jJLawINrINsD7UcNkKFsfaNP554pst6fe7CQNFLH/4gnZpHW
        cIc0ZPn8qBqY/PUa8EZzINk2DyDa38pZrA2IHJhRPZg8wTakQ8CRn+WKb8IUyz/t
        SBylBZXjhtrWwGcmAPksFGN22jMLMsZOAJeZ+IGqQ1Xj5XyaZ0SgGrhmF2I15zcu
        VVtWA4JMjP+QyIuov+vQWELqF/Tx0+aFYxg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Jb2pstF2RlQR for <linux-fsdevel@vger.kernel.org>;
        Wed, 29 Mar 2023 16:58:39 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn3RJ0pDLz1RtVm;
        Wed, 29 Mar 2023 16:58:35 -0700 (PDT)
Message-ID: <e088f7f1-827e-f0e5-4fc0-df0dcefbb873@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:58:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 19/19] block: mark bio_add_page as __must_check
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
 <350bd9c62ce575267a2b38625ab767c332429bc1.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <350bd9c62ce575267a2b38625ab767c332429bc1.1680108414.git.johannes.thumshirn@wdc.com>
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

On 3/30/23 02:06, Johannes Thumshirn wrote:
> Now that all users of bio_add_page check for the return value, mark
> bio_add_page as __must_check.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

